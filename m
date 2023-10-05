Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E497BA772
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjJERPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjJEROy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:14:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 523B5359D
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 10:06:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB946C15;
        Thu,  5 Oct 2023 10:07:07 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 467903F5A1;
        Thu,  5 Oct 2023 10:06:26 -0700 (PDT)
Message-ID: <c4157536-7e57-0250-dc44-8914f5965ce6@arm.com>
Date:   Thu, 5 Oct 2023 18:06:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 02/24] x86/resctrl: kfree() rmid_ptrs from
 rdtgroup_exit()
Content-Language: en-GB
To:     babu.moger@amd.com, x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-3-james.morse@arm.com>
 <7f95e9c8-73a6-4ccd-97e4-0d3723fbeafb@amd.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <7f95e9c8-73a6-4ccd-97e4-0d3723fbeafb@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 04/10/2023 19:00, Moger, Babu wrote:
> On 9/14/23 12:21, James Morse wrote:
>> rmid_ptrs[] is allocated from dom_data_init() but never free()d.
>>
>> While the exit text ends up in the linker script's DISCARD section,
>> the direction of travel is for resctrl to be/have loadable modules.
>>
>> Add resctrl_exit_mon_l3_config() to cleanup any memory allocated
>> by rdt_get_mon_l3_config().
>>
>> There is no reason to backport this to a stable kernel.

>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 85ceaf9a31ac..57cf1e6a57bd 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -537,6 +537,7 @@ void closid_free(int closid);
>>  int alloc_rmid(void);
>>  void free_rmid(u32 rmid);
>>  int rdt_get_mon_l3_config(struct rdt_resource *r);
>> +void resctrl_exit_mon_l3_config(struct rdt_resource *r);
>>  bool __init rdt_cpu_has(int flag);
>>  void mon_event_count(void *info);
>>  int rdtgroup_mondata_show(struct seq_file *m, void *arg);
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index ded1fc7cb7cb..cfb3f632a4b2 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -741,6 +741,16 @@ static int dom_data_init(struct rdt_resource *r)
>>  	return 0;
>>  }
>>  
>> +void resctrl_exit_mon_l3_config(struct rdt_resource *r)
>> +{
>> +	mutex_lock(&rdtgroup_mutex);
>> +
>> +	kfree(rmid_ptrs);
>> +	rmid_ptrs = NULL;
>> +
>> +	mutex_unlock(&rdtgroup_mutex);
>> +}

> What is the need for passing "rdt_resource *r" here?

My vain belief that monitors should be supported on something other than L3, but I agree
that isn't what resctrl does today. I'll remove it.


> Is mutex_lock required?

Reads and writes to rmid_ptrs[] are protected by that lock. This ensures no-one reads the
value while its being free()d, and after this function releases the lock, anyone trying
sees NULL.

(This is all moot as its only caller is marked __exit, so gets discarded by the linker)



Thanks,

James
