Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5AC811BD2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbjLMSDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbjLMSDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:03:07 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AACF593
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:03:13 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3174BC15;
        Wed, 13 Dec 2023 10:03:59 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 990913F762;
        Wed, 13 Dec 2023 10:03:10 -0800 (PST)
Message-ID: <bd3afbfd-3372-cac9-600e-ace19ddd3199@arm.com>
Date:   Wed, 13 Dec 2023 18:03:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 02/24] x86/resctrl: kfree() rmid_ptrs from
 rdtgroup_exit()
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
 <20231025180345.28061-3-james.morse@arm.com>
 <208c3ade-a8c3-41cc-b136-4ab9b7e938e5@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <208c3ade-a8c3-41cc-b136-4ab9b7e938e5@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette

On 09/11/2023 17:39, Reinette Chatre wrote:
> Hi James,
> 
> Subject refers to rdtgroup_exit() but the patch is actually changing
> resctrl_exit().

I'll fix that,


> On 10/25/2023 11:03 AM, James Morse wrote:
>> rmid_ptrs[] is allocated from dom_data_init() but never free()d.
>>
>> While the exit text ends up in the linker script's DISCARD section,
>> the direction of travel is for resctrl to be/have loadable modules.
>>
>> Add resctrl_exit_mon_l3_config() to cleanup any memory allocated
>> by rdt_get_mon_l3_config().
> 
> To match what patch actually does it looks like this should rather be:
> "Add resctrl_exit_mon_l3_config()" -> "Add resctrl_put_mon_l3_config()" 
> 
>>
>> There is no reason to backport this to a stable kernel.

[...]

>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index 19e0681f0435..0056c9962a44 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -992,7 +992,13 @@ late_initcall(resctrl_late_init);
>>  
>>  static void __exit resctrl_exit(void)
>>  {
>> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +
>>  	cpuhp_remove_state(rdt_online);
>> +
>> +	if (r->mon_capable)
>> +		rdt_put_mon_l3_config(r);
>> +
>>  	rdtgroup_exit();
>>  }
> 
> I expect cleanup to do the inverse of init. I do not know what was the
> motivation for the rdtgroup_exit() to follow cpuhp_remove_state()

This will invoke the hotplug callbacks, making it look to resctrl like all CPUs are
offline. This means it is then impossible for rdtgroup_exit() to race with the hotplug
notifiers. (if you could run this code...)


> but I
> was expecting this new cleanup to be done after rdtgroup_exit() to be inverse
> of init. This cleanup is inserted in middle of two existing cleanup - could
> you please elaborate how this location was chosen?

rdtgroup_exit() does nothing with the resctrl structures, it removes sysfs and debugfs
entries, and unregisters the filesystem.

Hypothetically, you can't observe any effect of the rmid_ptrs array being freed as
all the CPUs are offline and the overflow/limbo threads should have been cancelled.
Once cpuhp_remove_state() has been called, this really doesn't matter.


Thanks,

James
