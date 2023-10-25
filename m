Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBF47D72B4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjJYR5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbjJYR5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:57:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFA96187
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:57:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D88FE1477;
        Wed, 25 Oct 2023 10:57:47 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95BC03F738;
        Wed, 25 Oct 2023 10:57:03 -0700 (PDT)
Message-ID: <59133e87-33f1-8038-72be-ffbb441545b4@arm.com>
Date:   Wed, 25 Oct 2023 18:56:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 02/24] x86/resctrl: kfree() rmid_ptrs from
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
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-3-james.morse@arm.com>
 <9606020e-c322-fb6a-a6ca-96ade7aecf17@intel.com>
 <550fe399-8904-c515-f556-3536ebe2e9a3@arm.com>
 <7b793937-ab79-48be-8f82-4bfcfc464045@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <7b793937-ab79-48be-8f82-4bfcfc464045@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 05/10/2023 19:04, Reinette Chatre wrote:
> On 10/5/2023 10:05 AM, James Morse wrote:
>> On 02/10/2023 18:00, Reinette Chatre wrote:
>>> On 9/14/2023 10:21 AM, James Morse wrote:
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> index 725344048f85..a2158c266e41 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> @@ -3867,6 +3867,11 @@ int __init rdtgroup_init(void)
>>>>  
>>>>  void __exit rdtgroup_exit(void)
>>>>  {
>>>> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>>>> +
>>>> +	if (r->mon_capable)
>>>> +		resctrl_exit_mon_l3_config(r);
>>>> +
>>>>  	debugfs_remove_recursive(debugfs_resctrl);
>>>>  	unregister_filesystem(&rdt_fs_type);
>>>>  	sysfs_remove_mount_point(fs_kobj, "resctrl");
>>>
>>> You did not respond to me when I requested that this be done differently [1].
>>> Without a response letting me know the faults of my proposal or following the
>>> recommendation I conclude that my feedback was ignored. 
>>
>> Not so - I just trimmed the bits that didn't need a response. I can respond 'Yes' to each
>> one if you prefer, but I find that adds more noise than signal.
> 
> I do not expect a response to every review feedback but no response
> is assumed to mean that you agree with the feedback.
> 
>>
>> This is my attempt at 'doing the cleanup properly', which is what you said your preference
>> was. (no machine on the planet can ever run this code, the __exit section is always
>> discarded by the linker).
>>
>> Reading through again, I missed that you wanted this called from resctrl_exit(). (The
> 
> Right. And not responding to that created expectation that you agreed with the
> request.
> 
>> naming suggests I did this originally, but it didn't work out).
>> I don't think this works as the code in resctrl_exit() remains part of the arch code after
>> the move, but allocating rmid_ptrs[] stays part of the fs code.
>>
>> resctrl_exit() in core.c gets renamed as resctrl_arch_exit(), and rdtgroup_exit() takes on
>> the name resctrl_exit() as its part of the exposed interface.
> 
> I expect memory allocation/free to be symmetrical. Doing otherwise
> complicates the code. Having this memory freed in rdtgroup_exit() only
> seems appropriate if it is allocated from rdtgroup_init().
> Neither rmid_ptrs[] nor closid_num_dirty_rmid are allocated in
> rdtgroup_init() so freeing it in rdtgroup_exit() is not appropriate.

It probably makes more sense when you see how things get split up. I was trying to reduce
the churn of adding something in one place, then moving it later.

For now I've added all the functions to make this thing symmetric.



James


> If you are planning to move resctrl_exit() to be arch code then I expect
> resctrl_late_init() to be split with the rmid_ptrs[]/closid_num_dirty_rmid
> allocation moving to fs code. Freeing that memory can follow at that time.

