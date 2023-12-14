Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D26812EC2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444078AbjLNLho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444087AbjLNLhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:37:32 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC91012D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:37:38 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22F54C15;
        Thu, 14 Dec 2023 03:38:24 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 240C63F738;
        Thu, 14 Dec 2023 03:37:35 -0800 (PST)
Message-ID: <b49f55df-e566-9a6c-b7d0-b0b675e787fc@arm.com>
Date:   Thu, 14 Dec 2023 11:37:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 14/24] x86/resctrl: Allow resctrl_arch_rmid_read() to
 sleep
Content-Language: en-GB
To:     Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
References: <20231025180345.28061-1-james.morse@arm.com>
 <20231025180345.28061-15-james.morse@arm.com>
 <73bcd9f2-7c2d-4e9e-bcd8-ce3de2f9a5a4@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <73bcd9f2-7c2d-4e9e-bcd8-ce3de2f9a5a4@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 09/11/2023 17:47, Reinette Chatre wrote:
> On 10/25/2023 11:03 AM, James Morse wrote:
>> MPAM's cache occupancy counters can take a little while to settle once
>> the monitor has been configured. The maximum settling time is described
>> to the driver via a firmware table. The value could be large enough
>> that it makes sense to sleep. To avoid exposing this to resctrl, it
>> should be hidden behind MPAM's resctrl_arch_rmid_read().
>>
>> resctrl_arch_rmid_read() may be called via IPI meaning it is unable
>> to sleep. In this case resctrl_arch_rmid_read() should return an error
>> if it needs to sleep. This will only affect MPAM platforms where
>> the cache occupancy counter isn't available immediately, nohz_full is
>> in use, and there are no housekeeping CPUs in the necessary domain.
>>
>> There are three callers of resctrl_arch_rmid_read():
>> __mon_event_count() and __check_limbo() are both called from a
>> non-migrateable context. mon_event_read() invokes __mon_event_count()
>> using smp_call_on_cpu(), which adds work to the target CPUs workqueue.
>> rdtgroup_mutex() is held, meaning this cannot race with the resctrl
>> cpuhp callback. __check_limbo() is invoked via schedule_delayed_work_on()
>> also adds work to a per-cpu workqueue.
>>
>> The remaining call is add_rmid_to_limbo() which is called in response
>> to a user-space syscall that frees an RMID. This opportunistically
>> reads the LLC occupancy counter on the current domain to see if the
>> RMID is over the dirty threshold. This has to disable preemption to
>> avoid reading the wrong domain's value. Disabling pre-emption here
>> prevents resctrl_arch_rmid_read() from sleeping.
>>
>> add_rmid_to_limbo() walks each domain, but only reads the counter
>> on one domain. If the system has more than one domain, the RMID will
>> always be added to the limbo list. If the RMIDs usage was not over the
>> threshold, it will be removed from the list when __check_limbo() runs.
>> Make this the default behaviour. Free RMIDs are always added to the
>> limbo list for each domain.
>>
>> The user visible effect of this is that a clean RMID is not available
>> for re-allocation immediately after 'rmdir()' completes, this behaviour
>> was never portable as it never happened on a machine with multiple
>> domains.
>>
>> Removing this path allows resctrl_arch_rmid_read() to sleep if its called
>> with interrupts unmasked. Document this is the expected behaviour, and
>> add a might_sleep() annotation to catch changes that won't work on arm64.

[...]

>> Changes since v3:
>>  * Removed error handling for smp_call_function_any(), this can't race
>>    with the cpuhp callbacks as both hold rdtgroup_mutex.
>>  * Switched to the alternative of removing the counter read, this simplifies
>>    things dramatically.
>>
>> Changes since v4:
>>  * Messed with capitalisation.
>>  * Removed some dead code now that entry->busy will never be zero in
>>    add_rmid_to_limbo().
>>  * Rephrased the comment above resctrl_arch_rmid_read_context_check().
>>
>> Changes since v5:
>>  * Really rephrased the comment above resctrl_arch_rmid_read_context_check().
>>
>> No changes since v6
> 
> If I trusted this I would not have taken the time to review this patch.

I'm not sure what you want me to do from this comment ... but this 'no changes' annotation
doesn't work for either of us, so I'll remove them.


> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>


Thanks,

James
