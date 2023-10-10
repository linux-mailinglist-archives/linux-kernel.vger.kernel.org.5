Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA397BFCFD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjJJNK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjJJNKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:10:54 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B89FC6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:10:51 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S4blr5hDYzVlFk;
        Tue, 10 Oct 2023 21:07:20 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 10 Oct 2023 21:10:48 +0800
CC:     <yangyicong@hisilicon.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <sudeep.holla@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <dietmar.eggemann@arm.com>,
        <rafael@kernel.org>, <jonathan.cameron@huawei.com>,
        <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arch_topology: Support SMT control on arm64
To:     Greg KH <gregkh@linuxfoundation.org>
References: <20231010115335.13862-1-yangyicong@huawei.com>
 <2023101025-thieving-eagle-406f@gregkh>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <713d3125-e21e-005e-7713-53c717aa15da@huawei.com>
Date:   Tue, 10 Oct 2023 21:10:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <2023101025-thieving-eagle-406f@gregkh>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.177]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/10 20:33, Greg KH wrote:
> On Tue, Oct 10, 2023 at 07:53:35PM +0800, Yicong Yang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> The core CPU control framework supports runtime SMT control which
>> is not yet supported on arm64. Besides the general vulnerabilities
>> concerns we want this runtime control on our arm64 server for:
> 
> But shouldn't this be part of UEFI?  Why manually try to determine this
> at powerup in Linux?

We can disable/enable SMT by UEFI, but it lacks of flexibility. With runtime
support we can disable/enable on demand, rather than disable/enable all the time.
In our case, mainly for the below 2 reasons in the commit.

> 
>> - better single CPU performance in some cases
>> - saving overall power consumption
>>
>> This patch implements it in the following aspects:
>>
>> - implement the callbacks of the core
>> - update the SMT status after the topology enumerated on arm64
>> - select HOTPLUG_SMT for arm64
>>
>> For disabling SMT we'll offline all the secondary threads and
>> only leave the primary thread. Since we don't have restriction
>> for primary thread selection, the first thread is chosen as the
>> primary thread in this implementation.
>>
>> Tests has been done on our real ACPI based arm64 server and on
>> ACPI/OF based QEMU VMs.
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>> Change since v1:
>> - Avoid the complexity on SMT detecting by visiting each CPU once, concerned by Sudeep
>> Link: https://lore.kernel.org/all/20230919123319.23785-1-yangyicong@huawei.com/
>>
>>  arch/arm64/Kconfig            |  1 +
>>  drivers/base/arch_topology.c  | 75 +++++++++++++++++++++++++++++++++++
>>  include/linux/arch_topology.h | 11 +++++
>>  3 files changed, 87 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 78f20e632712..339661ceabc8 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -233,6 +233,7 @@ config ARM64
>>  	select HAVE_KRETPROBES
>>  	select HAVE_GENERIC_VDSO
>>  	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
>> +	select HOTPLUG_SMT if SMP
>>  	select IRQ_DOMAIN
>>  	select IRQ_FORCED_THREADING
>>  	select KASAN_VMALLOC if KASAN
>> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
>> index b741b5ba82bd..c5b453c2cd61 100644
>> --- a/drivers/base/arch_topology.c
>> +++ b/drivers/base/arch_topology.c
>> @@ -729,6 +729,75 @@ const struct cpumask *cpu_clustergroup_mask(int cpu)
>>  	return &cpu_topology[cpu].cluster_sibling;
>>  }
>>  
>> +#ifdef CONFIG_HOTPLUG_SMT
>> +static int topology_smt_num_threads = 1;
>> +
>> +void __init topology_smt_set_num_threads(void)
>> +{
>> +	int cpu, sibling, threads;
>> +	cpumask_var_t to_visit;
>> +
>> +	if (!alloc_cpumask_var(&to_visit, GFP_KERNEL)) {
>> +		pr_err("Failed to update the SMT info\n");
>> +		return;
>> +	}
>> +
>> +	cpumask_or(to_visit, to_visit, cpu_possible_mask);
>> +
>> +	/*
>> +	 * Walk all the CPUs to find the largest thread number, in case we're
>> +	 * on a heterogeneous platform with only part of the CPU cores support
>> +	 * SMT.
>> +	 *
>> +	 * Get the thread number by checking the CPUs with same core id
>> +	 * rather than checking the topology_sibling_cpumask(), since the
>> +	 * sibling mask will not cover all the CPUs if there's CPU offline.
>> +	 */
>> +	for_each_cpu(cpu, to_visit) {
>> +		threads = 1;
>> +
>> +		cpumask_clear_cpu(cpu, to_visit);
>> +
>> +		/* Invalid thread id, this CPU is not in a SMT core */
>> +		if (cpu_topology[cpu].thread_id == -1)
>> +			continue;
>> +
>> +		for_each_cpu(sibling, to_visit) {
>> +			if (cpu_topology[sibling].thread_id != -1 &&
>> +			    cpu_topology[cpu].core_id == cpu_topology[sibling].core_id)
>> +				threads++;
>> +
>> +			cpumask_clear_cpu(sibling, to_visit);
>> +		}
>> +
>> +		if (threads > topology_smt_num_threads)
>> +			topology_smt_num_threads = threads;
>> +	}
>> +
>> +	free_cpumask_var(to_visit);
>> +
>> +	/*
>> +	 * We don't support CONFIG_SMT_NUM_THREADS_DYNAMIC so make the
>> +	 * max_threads == num_threads.
>> +	 */
>> +	cpu_smt_set_num_threads(topology_smt_num_threads, topology_smt_num_threads);
>> +}
> 
> How is this going to affect non-arm64 systems?  Will we now be doing
> this double loop for all cpus in the systems (i.e. for 10's of thousands
> on x86)?

x86 build the topology in their arch codes. Currently the user of this driver
are arm64, arm, risv and parisc who select GENERIC_ARCH_TOPOLOGY.
arch needs to select CONFIG_HOTPLUG_SMT for this feature and this patch only
adds arm64 support. So others won't be affected.

> And again, why is this not an issue on the current platforms that
> already support CONFIG_HOTPLUG_SMT?  What makes ARM64 so broken it
> requires this manual intervention?
> 

Currently I see x86 and powerpc supports CONFIG_HOTPLUG_SMT on the mainline.
For x86 they build the topology and detects the SMT suppport in the arch
code, seems they can directly get the SMT number by reading the system
register, refers to arch/x86/kernel/cpu/common.c:detect_ht_early(). For
powerpc I see they are reading the threads number from the firmware(OF)
and assuming all the SMT have the same thread number, refer to
arch/powerpc/kernel/setup-common.c:smp_setup_cpu_maps(). Please corrects
me if there's mistakes.

Back to arm64, there's no system registers to directly indicate the thread
numbers of each SMT in the system like x86, nor do we have the information
from the firmware (OF/ACPI). I cannot assume all the physical cores have
the same thread number, since we may have SMT cores and non-SMT cores on
heterogeneous platform. We can only know the SMT information after
parsing the firmware information.

So in this implementation I scan the cpus to find the biggest SMT number
rather than use the SMT number of the first CPU in case on a
heterogeneous platform. And it can handle the case of both ACPI and OF
based platform. Sudeep also suggests to detect SMT numbers during
parsing the PPTT or device tree, that means we need to handle it
separately. Do the detecting in the OF scanning code in arch_topology
and also the dectecting in the PPTT scanning code in arch codes.
But if we agree it's better, I can switch to that. Or any other
suggestions are appreciated.

Thanks.
