Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137107B0358
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjI0Lxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjI0Lxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:53:49 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88A0BE
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:53:45 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RwZhG1xXBzrT2y;
        Wed, 27 Sep 2023 19:51:26 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 27 Sep 2023 19:53:41 +0800
CC:     <yangyicong@hisilicon.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
        <linux-kernel@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH] arch_topology: Support SMT control on arm64
To:     Sudeep Holla <sudeep.holla@arm.com>
References: <20230919123319.23785-1-yangyicong@huawei.com>
 <20230921150333.c2zqigs3xxwcg4ln@bogus>
 <0ea971ba-549f-62ed-a181-41b5572cd190@huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <ea76baf8-2215-d666-6270-a9bb20bba499@huawei.com>
Date:   Wed, 27 Sep 2023 19:53:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <0ea971ba-549f-62ed-a181-41b5572cd190@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.177]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

Any further comments? Did my replies answer your concerns?
Willing for more suggestions if there's any to make progress on this.

Thanks.

On 2023/9/22 17:46, Yicong Yang wrote:
> On 2023/9/21 23:03, Sudeep Holla wrote:
>> On Tue, Sep 19, 2023 at 08:33:19PM +0800, Yicong Yang wrote:
>>> From: Yicong Yang <yangyicong@hisilicon.com>
>>>
>>> The core CPU control framework supports runtime SMT control which
>>> is not yet supported on arm64. Besides the general vulnerabilities
>>> concerns we want this runtime control on our arm64 server for:
>>>
>>> - better single CPU performance in some cases
>>> - saving overall power consumption
>>>
>>> This patch implements it in the following aspects:
>>>
>>> - implement the callbacks of the core
>>> - update the SMT status after the topology enumerated on arm64
>>> - select HOTPLUG_SMT for arm64
>>>
>>> For disabling SMT we'll offline all the secondary threads and
>>> only leave the primary thread. Since we don't have restriction
>>> for primary thread selection, the first thread is chosen as the
>>> primary thread in this implementation.
>>>
>>> Tests has been done on our ACPI based arm64 server and on
>>> ACPI/OF based QEMU VMs.
>>>
>>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>>> ---
>>>  arch/arm64/Kconfig            |  1 +
>>>  drivers/base/arch_topology.c  | 63 +++++++++++++++++++++++++++++++++++
>>>  include/linux/arch_topology.h | 11 ++++++
>>>  3 files changed, 75 insertions(+)
>>>
>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>> index b10515c0200b..531a71c7f499 100644
>>> --- a/arch/arm64/Kconfig
>>> +++ b/arch/arm64/Kconfig
>>> @@ -233,6 +233,7 @@ config ARM64
>>>  	select HAVE_KRETPROBES
>>>  	select HAVE_GENERIC_VDSO
>>>  	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
>>> +	select HOTPLUG_SMT if SMP
>>>  	select IRQ_DOMAIN
>>>  	select IRQ_FORCED_THREADING
>>>  	select KASAN_VMALLOC if KASAN
>>> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
>>> index b741b5ba82bd..75a693834fff 100644
>>> --- a/drivers/base/arch_topology.c
>>> +++ b/drivers/base/arch_topology.c
>>> @@ -729,6 +729,63 @@ const struct cpumask *cpu_clustergroup_mask(int cpu)
>>>  	return &cpu_topology[cpu].cluster_sibling;
>>>  }
>>>  
>>> +#ifdef CONFIG_HOTPLUG_SMT
>>> +static int topology_smt_num_threads = 1;
>>> +
>>> +void __init topology_smt_set_num_threads(void)
>>> +{
>>> +	int cpu, sibling, threads;
>>> +
>>> +	/*
>>> +	 * Walk all the CPUs to find the largest thread number, in case we're
>>> +	 * on a heterogeneous platform with only part of the CPU cores support
>>> +	 * SMT.
>>> +	 *
>>> +	 * Get the thread number by checking the CPUs with same core id
>>> +	 * rather than checking the topology_sibling_cpumask(), since the
>>> +	 * sibling mask will not cover all the CPUs if there's CPU offline.
>>> +	 */
>>> +	for_each_possible_cpu(cpu) {
>>> +		threads = 1;
>>> +
>>> +		/* Invalid thread id, this CPU is not in a SMT core */
>>> +		if (cpu_topology[cpu].thread_id == -1)
>>> +			continue;
>>> +
>>> +		for_each_possible_cpu(sibling) {
>>
>> I would really like to avoid parsing all the cpus here(O(cpu^2))
>>
> 
> What if we use a temp cpumask to record each visited CPU and make it O(cpu)?
> I didn't use it because I don't want to see a memory allocation failure for
> the cpumask. In current implementation there's no way to fail.
> 
>> Another random thought(just looking at DT parsing) is we can count threads
>> while parsing itself if we need the info early before the topology cpumasks
>> are setup. Need to look at ACPI parsing and how to make that generic but
>> thought of checking the idea here first.
>>
> 
> The ACPI parsing is in each arch's codes (currently for arm64 and loongarch).
> The code will be isolated to DT, arm64 ACPI parsing, loogarch ACPI parsing
> and future ACPI based archs, it'll be redundant and hard to maintian, I think.
> So I perfer to unify the processing since the logic is common, just check
> the finally built cpu_topology array regardless whether we're on an ACPI/OF
> based system.
> 
>> [...]
>>
>>> @@ -841,6 +898,12 @@ void __init init_cpu_topology(void)
>>>  		reset_cpu_topology();
>>>  	}
>>>  
>>> +	/*
>>> +	 * By this stage we get to know whether we support SMT or not, update
>>> +	 * the information for the core.
>>> +	 */
>>> +	topology_smt_set_num_threads();
>>> +
>>
>> Does this have to be done this early ? I was wondering if we can defer until
>> all the cpumasks are set and you can rely on the thread_sibling mask ?
>> You can just get the weight of that mask on all cpus and choose the max value.
>>
> 
> We do this at this stage because we've already gotten the necessary informations.
> As commented in topology_smt_set_num_threads(), I didn't use sibling masks
> because the sibling masks will not contain all the informations, it'll only be updated
> when CPUs going online in secondary_start_kernel()->store_cpu_topology(). Think of
> the case if we boot with maxcpus=1, the SMT status won't be collected completely if
> we're using the sibling mask. For example, the sibling mask of the boot CPU will
> be correct, but not for its sibling cores.
> 
> Thanks.
> .
> 
