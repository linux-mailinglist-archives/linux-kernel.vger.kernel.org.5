Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FC07569D5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjGQRHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjGQRHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:07:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED68C131
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 10:07:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D8F1D75;
        Mon, 17 Jul 2023 10:08:16 -0700 (PDT)
Received: from [10.57.79.8] (unknown [10.57.79.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F3413F738;
        Mon, 17 Jul 2023 10:07:27 -0700 (PDT)
Message-ID: <d1d02383-19fd-20c6-b6b7-0f769bc40582@arm.com>
Date:   Mon, 17 Jul 2023 18:07:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 12/24] x86/resctrl: Make resctrl_arch_rmid_read() retry
 when it is interrupted
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, dfustini@baylibre.com
References: <20230525180209.19497-1-james.morse@arm.com>
 <20230525180209.19497-13-james.morse@arm.com>
 <CALPaoCjLjngabG32m4X8sSwK-bbZ28oL6BVKSn_dFnDwPzkDkg@mail.gmail.com>
 <7ff7fcf9-725b-fb3d-43f3-b80a1df3a001@arm.com>
 <CALPaoChW=3T2EmrcW+eLEnDUY00rsRSQarTN3c0hSDX-FDRqvw@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <CALPaoChW=3T2EmrcW+eLEnDUY00rsRSQarTN3c0hSDX-FDRqvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 6/7/23 13:51, Peter Newman wrote:
> On Tue, Jun 6, 2023 at 7:03 PM James Morse <james.morse@arm.com> wrote:
>> On 06/06/2023 09:49, Peter Newman wrote:
>>> It looks like if __rmid_read() is interrupted by an occupancy counter
>>> read between writing QM_EVTSEL and reading QM_CTR, it will not perform
>>> any update to am->prev_msr, and the interrupted read will return the
>>> same counter value as in the interrupting read.
>>
>> Yup, that's a problem. I was only looking at the mbm state in memory, not the CPU register.
>> I think the fix is to read back QM_EVTSEL after reading QM_CTR. I'll do this in
>> __rmid_read() to avoid returning -EINTR. It creates two retry loops which is annoying, but
>> making the window larger means you're more likely to see false positives.
>>
>> ----------------------------%<----------------------------
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl
>> /monitor.c
>> index e24390d2e661..aeba035bb680 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -101,6 +101,7 @@ static inline u64 get_corrected_mbm_count(u32 rmid, unsigned
>>   long val)
>>
>>   static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
>>   {
>> +       u32 _rmid, _eventid;
>>          u64 msr_val;
>>
>>          /*
>> @@ -110,9 +111,15 @@ static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
>>           * IA32_QM_CTR.data (bits 61:0) reports the monitored data.
>>           * IA32_QM_CTR.Error (bit 63) and IA32_QM_CTR.Unavailable (bit 62)
>>           * are error bits.
>> +        * QM_EVTSEL is re-read to detect if this function was interrupted by
>> +        * another call, meaning the QM_CTR value may belong to a different
>> +        * event.
>>           */
>> -       wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
>> -       rdmsrl(MSR_IA32_QM_CTR, msr_val);
>> +       do {
>> +               wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
>> +               rdmsrl(MSR_IA32_QM_CTR, msr_val);
>> +               rdmsr(MSR_IA32_QM_EVTSEL, _eventid, _rmid);
>> +       } while (eventid != _eventid || rmid != _rmid);
>>
>>          if (msr_val & RMID_VAL_ERROR)
>>                  return -EIO;

> I happen to be tracking the cost of resctrl_arch_rmid_read() calls, so
> I measured the impact of your fix on my AMD EPYC 7B12:
> 
> with both this and the soft RMID series[1] applied:

> The Soft RMID switches contain two __rmid_read() calls, so this
> implies each QM_EVTSEL read-back is around 420 cycles on this AMD
> implementation.

Oooer. I assumed writes might have tedious side-effects but reads would cheap.
I suppose its because another CPU may have modified this value in the meantime.


> Even if you don't agree with my plan to add resctrl_arch_rmid_read()
> calls to context switches, there should be cheaper ways to handle
> this.

Yup, I've swapped this for a sequence counter[0], which should push that cost into the noise.
Anything left will be the cost of the atomics.


Thanks,

James

[0] barely tested:
------------------%<------------------
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 238831d53479..86d3a1b99be6 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -16,6 +16,7 @@
   */
  
  #include <linux/module.h>
+#include <linux/percpu.h>
  #include <linux/sizes.h>
  #include <linux/slab.h>
  
@@ -24,6 +25,9 @@
  
  #include "internal.h"
  
+/* Sequence number for writes to IA32 QM_EVTSEL */
+static DEFINE_PER_CPU(u64, qm_evtsel_seq);
+
  struct rmid_entry {
         /*
          * Some architectures's resctrl_arch_rmid_read() needs the CLOSID value
@@ -178,8 +182,7 @@ static inline struct rmid_entry *__rmid_entry(u32 idx)
  
  static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
  {
-       u32 _rmid, _eventid;
-       u64 msr_val;
+       u64 msr_val, seq;
  
         /*
          * As per the SDM, when IA32_QM_EVTSEL.EvtID (bits 7:0) is configured
@@ -188,15 +191,16 @@ static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
          * IA32_QM_CTR.data (bits 61:0) reports the monitored data.
          * IA32_QM_CTR.Error (bit 63) and IA32_QM_CTR.Unavailable (bit 62)
          * are error bits.
-        * QM_EVTSEL is re-read to detect if this function was interrupted by
-        * another call, meaning the QM_CTR value may belong to a different
-        * event.
+        * A per-cpu sequence counter is incremented each time QM_EVTSEL is
+        * written. This is used to detect if this function was interrupted by
+        * another call without re-reading the MSRs. Retry the MSR read when
+        * this happens as the QM_CTR value may belong to a different event.
          */
         do {
+               seq = this_cpu_inc_return(qm_evtsel_seq);
                 wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
                 rdmsrl(MSR_IA32_QM_CTR, msr_val);
-               rdmsr(MSR_IA32_QM_EVTSEL, _eventid, _rmid);
-       } while (eventid != _eventid || rmid != _rmid);
+       } while (seq != this_cpu_read(qm_evtsel_seq));
  
         if (msr_val & RMID_VAL_ERROR)
                 return -EIO;

------------------%<------------------
