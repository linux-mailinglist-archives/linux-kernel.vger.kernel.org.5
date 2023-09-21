Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730637A9AA3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjIUSqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjIUSqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:46:42 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930D9EE802
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:46:31 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rrq0c6N6PzNnm7;
        Thu, 21 Sep 2023 16:52:32 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 21 Sep 2023 16:56:19 +0800
CC:     <yangyicong@hisilicon.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <jonathan.cameron@huawei.com>,
        <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arch_topology: Support SMT control on arm64
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <sudeep.holla@arm.com>, <linux-arm-kernel@lists.infradead.org>
References: <20230919123319.23785-1-yangyicong@huawei.com>
 <130ce530-a3c1-0918-e04f-cb7d94aef57b@arm.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <80b2556c-b56c-ca23-22c7-70a0a3995701@huawei.com>
Date:   Thu, 21 Sep 2023 16:56:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <130ce530-a3c1-0918-e04f-cb7d94aef57b@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.177]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

On 2023/9/21 1:08, Dietmar Eggemann wrote:
> On 19/09/2023 14:33, Yicong Yang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> The core CPU control framework supports runtime SMT control which
>> is not yet supported on arm64. Besides the general vulnerabilities
>> concerns we want this runtime control on our arm64 server for:
>>
>> - better single CPU performance in some cases
>> - saving overall power consumption
>>
>> This patch implements it in the following aspects:
>>
>> - implement the callbacks of the core
> 
> I see only 1 function here: topology_is_primary_thread() ?

Yes. Before 6.6-rc1 there's also one function topology_smt_supported() required,
I forgot to update the comment after rebase on 6.6-rc1.

> 
>> - update the SMT status after the topology enumerated on arm64
> 
> That's the call init_cpu_topology()
>                  topology_smt_set_num_threads()
>                   cpu_smt_set_num_threads()
> 

Yes.

>> - select HOTPLUG_SMT for arm64
>>
>> For disabling SMT we'll offline all the secondary threads and
> 
> `disabling SMT` means here setting cpu_smt_control=CPU_SMT_DISABLED ?
> 

Yes. The SMT control provides user interface like
`/sys/devices/system/cpu/smt/control` or cmdline option `nosmt=[force]`,
which will update cpu_smt_control = CPU_SMT_DISABLED.

>> only leave the primary thread. Since we don't have restriction
>> for primary thread selection, the first thread is chosen as the
>> primary thread in this implementation.
>>
>> Tests has been done on our ACPI based arm64 server and on
>> ACPI/OF based QEMU VMs.
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>  arch/arm64/Kconfig            |  1 +
>>  drivers/base/arch_topology.c  | 63 +++++++++++++++++++++++++++++++++++
>>  include/linux/arch_topology.h | 11 ++++++
>>  3 files changed, 75 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index b10515c0200b..531a71c7f499 100644
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
>> index b741b5ba82bd..75a693834fff 100644
>> --- a/drivers/base/arch_topology.c
>> +++ b/drivers/base/arch_topology.c
>> @@ -729,6 +729,63 @@ const struct cpumask *cpu_clustergroup_mask(int cpu)
>>  	return &cpu_topology[cpu].cluster_sibling;
>>  }
>>  
>> +#ifdef CONFIG_HOTPLUG_SMT
>> +static int topology_smt_num_threads = 1;
>> +
>> +void __init topology_smt_set_num_threads(void)
>> +{
>> +	int cpu, sibling, threads;
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
>> +	for_each_possible_cpu(cpu) {
>> +		threads = 1;
>> +
>> +		/* Invalid thread id, this CPU is not in a SMT core */
>> +		if (cpu_topology[cpu].thread_id == -1)
>> +			continue;
>> +
>> +		for_each_possible_cpu(sibling) {
>> +			if (sibling == cpu || cpu_topology[sibling].thread_id == -1)
>> +				continue;
>> +
>> +			if (cpu_topology[cpu].core_id == cpu_topology[sibling].core_id)
>> +				threads++;
>> +		}
>> +
>> +		if (threads > topology_smt_num_threads)
>> +			topology_smt_num_threads = threads;
>> +	}
>> +
>> +	/*
>> +	 * We don't support CONFIG_SMT_NUM_THREADS_DYNAMIC so make the
>> +	 * max_threads == num_threads.
>> +	 */
>> +	cpu_smt_set_num_threads(topology_smt_num_threads, topology_smt_num_threads);
>> +}
>> +
>> +/*
>> + * On SMT Hotplug the primary thread of the SMT won't be disabled. For x86 they
>> + * seem to have a primary thread for special purpose. For other arthitectures
>> + * like arm64 there's no such restriction for a primary thread, so make the
>> + * first thread in the SMT as the primary thread.
>> + */
>> +bool topology_is_primary_thread(unsigned int cpu)
>> +{
>> +	if (cpu == cpumask_first(topology_sibling_cpumask(cpu)))
>> +		return true;
>> +
>> +	return false;
>> +}
>> +#endif
>> +
>>  void update_siblings_masks(unsigned int cpuid)
>>  {
>>  	struct cpu_topology *cpu_topo, *cpuid_topo = &cpu_topology[cpuid];
>> @@ -841,6 +898,12 @@ void __init init_cpu_topology(void)
>>  		reset_cpu_topology();
>>  	}
>>  
>> +	/*
>> +	 * By this stage we get to know whether we support SMT or not, update
>> +	 * the information for the core.
>> +	 */
>> +	topology_smt_set_num_threads();
>> +
> 
> So this would be the diff between x86 and arm64:
> 
> start_kernel() [init/main.c]
> 
>  arch_cpu_finalize_init() [arch/x86/kernel/cpu/common.c] <- x86
> 
>   identify_boot_cpu() [arch/x86/kernel/cpu/common.c]
> 
>    detect_ht() [arch/x86/kernel/cpu/common.c]
> 
>     detect_ht_early() [arch/x86/kernel/cpu/common.c]
> 
>   cpu_smt_set_num_threads(smp_num_siblings, smp_num_siblings) <- (1)
>    
> 
>  arch_call_rest_init() [init/main.c] <- arm64
> 
>   rest_init() [init/main.c]
> 
>    kernel_init() [init/main.c]
> 
>     kernel_init_freeable() [init/main.c]
> 
>      smp_prepare_cpus() [arch/arm64/kernel/smp.c]
> 
>       init_cpu_topology() [drivers/base/arch_topology.c]
> 
>        topology_smt_set_num_threads()
> 
>         cpu_smt_set_num_threads(topology_smt_num_threads, topology_smt_num_threads) <- (1) 
> 
> [...]
> 

Yes we have some differences. On arm64 the SMT information is retrieved from firmware
(ACPI/OF, parse_{acpi, dt}_topology()). So we need to update the SMT information
to the core after parsing the ACPI/OF in init_cpu_topology().

> Did some rough testing with your patch on an SMT4 Arm64 server with 256
> CPUs:
> 
> (1) CPU hp out all secondaries from the thread_siblings masks
> 
> for i in {32..255}; do echo 0 > /sys/devices/system/cpu/cpu$i/online; done
> 
> (2) Check thread_siblings cpumasks
> 
> cat /sys/devices/system/cpu/cpu*/topology/thread_siblings
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000001
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000002
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000400
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000800
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00001000
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00002000
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00004000
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00008000
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00010000
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00020000
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00040000
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00080000
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000004
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00100000
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00200000
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00400000
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00800000
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,01000000
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,02000000
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,04000000
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,08000000
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,10000000
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,20000000
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000008
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,40000000
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,80000000
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000010
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000020
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000040
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000080
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000100
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000200
> 
> (3) CPU hp out and out CPU31
> 
> echo 0 > /sys/devices/system/cpu/cpu31/online
> echo 1 > /sys/devices/system/cpu/cpu31/online
> 
> cpu_smt_control is still CPU_SMT_ENABLED in cpu_smt_allowed() so
> topology_is_primary_thread() isn't called? 
> 

If you manually disable SMT by offline each CPUs the cpu_smt_control will
not be updated. It'll updated when using the interface like
`/sys/devices/system/cpu/smt/control` or cmdline. By these means,
the framework will use topology_is_primary_thread() to decide which CPU
in the SMT will keep online:

// e.g. echo off > /sys/devices/system/cpu/smt/control
[ kernel/cpu.c ]
control_store()
  __store_smt_control()
    cpuhp_smt_disable()
      for_each_online_cpu(cpu)
        if (topology_is_primary_thread(cpu))
          continue;            <---------- will skip the primary thread
      [...]
      cpu_smt_control = CPU_SMT_DISABLED;

topology_is_primary_thread() checking only applies to the SMT control but
not to the CPU offline.

Thanks,
Yicong







