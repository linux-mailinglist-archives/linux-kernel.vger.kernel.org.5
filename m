Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EE58139F2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235729AbjLNS2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjLNS2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:28:01 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9240A112
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:28:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C133EC15;
        Thu, 14 Dec 2023 10:28:52 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E9B43F738;
        Thu, 14 Dec 2023 10:28:02 -0800 (PST)
Message-ID: <a5ef6b40-a9b3-5338-a12a-6a4540cda861@arm.com>
Date:   Thu, 14 Dec 2023 18:28:01 +0000
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
 <bd3afbfd-3372-cac9-600e-ace19ddd3199@arm.com>
 <cddbbbae-599b-42c0-abe1-4ca74d5ce36c@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <cddbbbae-599b-42c0-abe1-4ca74d5ce36c@intel.com>
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

On 13/12/2023 23:27, Reinette Chatre wrote:
> Hi James,
> 
> On 12/13/2023 10:03 AM, James Morse wrote:
>> On 09/11/2023 17:39, Reinette Chatre wrote:
>>> On 10/25/2023 11:03 AM, James Morse wrote:
> 
> ...
> 
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>>>> index 19e0681f0435..0056c9962a44 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>>>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>>>> @@ -992,7 +992,13 @@ late_initcall(resctrl_late_init);
>>>>  
>>>>  static void __exit resctrl_exit(void)
>>>>  {
>>>> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>>>> +
>>>>  	cpuhp_remove_state(rdt_online);
>>>> +
>>>> +	if (r->mon_capable)
>>>> +		rdt_put_mon_l3_config(r);
>>>> +
>>>>  	rdtgroup_exit();
>>>>  }
>>>
>>> I expect cleanup to do the inverse of init. I do not know what was the
>>> motivation for the rdtgroup_exit() to follow cpuhp_remove_state()
>>
>> This will invoke the hotplug callbacks, making it look to resctrl like all CPUs are
>> offline. This means it is then impossible for rdtgroup_exit() to race with the hotplug
>> notifiers. (if you could run this code...)

> hmmm ... if there is a risk of such a race would the init code not also be
> vulnerable to that with the notifiers up before rdtgroup_init()?

Nope, because this array is allocated behind rdt_get_mon_l3_config(), which ultimately
comes from get_rdt_resources() in resctrl_late_init() - which calls cpuhp_setup_state()
after all this init work has been done.

(cpu hp always gives me a headache1)


> The races you mention
> are not obvious to me. I see the filesystem and hotplug code protected against races via
> the mutex and static keys. Could you please elaborate on the flows of concern?

Functions like __check_limbo() (calling __rmid_entry()) are called under the
rdtgroup_mutex, but they don't consider that rmid_ptrs[] may be NULL.

But this could only happen if the limbo work ran after cpuhp_remove_state() - this can't
happen because the hotplug callbacks cancel the limbo work, and won't reschedule it if the
domain is going offline.


The only other path is via free_rmid(), I've not thought too much about this as
resctrl_exit() can't actually be invoked - this code is discarded by the linker.

It could be run on MPAM, but only in response to an 'error interrupt' (which is optional)
- and all the MPAM error interrupts indicate a software bug.

I've only invoked this path once, and rdtgroup_exit()s unregister_filesystem() didn't
remove all the files. I anticipate digging into this teardown code more once the bulk of
the MPAM driver is upstream.


> I am not advocating for cpuhp_remove_state() to be called later. I understand that
> it simplifies the flows to consider.
> 
>>> but I
>>> was expecting this new cleanup to be done after rdtgroup_exit() to be inverse
>>> of init. This cleanup is inserted in middle of two existing cleanup - could
>>> you please elaborate how this location was chosen?
>>
>> rdtgroup_exit() does nothing with the resctrl structures, it removes sysfs and debugfs
>> entries, and unregisters the filesystem.
>>
>> Hypothetically, you can't observe any effect of the rmid_ptrs array being freed as
>> all the CPUs are offline and the overflow/limbo threads should have been cancelled.
>> Once cpuhp_remove_state() has been called, this really doesn't matter.

> Sounds like nothing prevents this code from following the custom of cleanup to be
> inverse of init (yet keep cpuhp_remove_state() first).

I'll put the the rdt_put_mon_l3_config() call after rdtgroup_exit()...


Thanks,

James
