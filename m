Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D966D7A8A0A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbjITRIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 13:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjITRIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:08:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F41F7A3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 10:08:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 452341FB;
        Wed, 20 Sep 2023 10:09:09 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65EC93F67D;
        Wed, 20 Sep 2023 10:08:30 -0700 (PDT)
Message-ID: <130ce530-a3c1-0918-e04f-cb7d94aef57b@arm.com>
Date:   Wed, 20 Sep 2023 19:08:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] arch_topology: Support SMT control on arm64
Content-Language: en-US
To:     Yicong Yang <yangyicong@huawei.com>, catalin.marinas@arm.com,
        will@kernel.org, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        jonathan.cameron@huawei.com, prime.zeng@hisilicon.com,
        linuxarm@huawei.com, yangyicong@hisilicon.com,
        linux-kernel@vger.kernel.org
References: <20230919123319.23785-1-yangyicong@huawei.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230919123319.23785-1-yangyicong@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2023 14:33, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> The core CPU control framework supports runtime SMT control which
> is not yet supported on arm64. Besides the general vulnerabilities
> concerns we want this runtime control on our arm64 server for:
> 
> - better single CPU performance in some cases
> - saving overall power consumption
> 
> This patch implements it in the following aspects:
> 
> - implement the callbacks of the core

I see only 1 function here: topology_is_primary_thread() ?

> - update the SMT status after the topology enumerated on arm64

That's the call init_cpu_topology()
                 topology_smt_set_num_threads()
                  cpu_smt_set_num_threads()

> - select HOTPLUG_SMT for arm64
> 
> For disabling SMT we'll offline all the secondary threads and

`disabling SMT` means here setting cpu_smt_control=CPU_SMT_DISABLED ?

> only leave the primary thread. Since we don't have restriction
> for primary thread selection, the first thread is chosen as the
> primary thread in this implementation.
> 
> Tests has been done on our ACPI based arm64 server and on
> ACPI/OF based QEMU VMs.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  arch/arm64/Kconfig            |  1 +
>  drivers/base/arch_topology.c  | 63 +++++++++++++++++++++++++++++++++++
>  include/linux/arch_topology.h | 11 ++++++
>  3 files changed, 75 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b10515c0200b..531a71c7f499 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -233,6 +233,7 @@ config ARM64
>  	select HAVE_KRETPROBES
>  	select HAVE_GENERIC_VDSO
>  	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
> +	select HOTPLUG_SMT if SMP
>  	select IRQ_DOMAIN
>  	select IRQ_FORCED_THREADING
>  	select KASAN_VMALLOC if KASAN
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index b741b5ba82bd..75a693834fff 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -729,6 +729,63 @@ const struct cpumask *cpu_clustergroup_mask(int cpu)
>  	return &cpu_topology[cpu].cluster_sibling;
>  }
>  
> +#ifdef CONFIG_HOTPLUG_SMT
> +static int topology_smt_num_threads = 1;
> +
> +void __init topology_smt_set_num_threads(void)
> +{
> +	int cpu, sibling, threads;
> +
> +	/*
> +	 * Walk all the CPUs to find the largest thread number, in case we're
> +	 * on a heterogeneous platform with only part of the CPU cores support
> +	 * SMT.
> +	 *
> +	 * Get the thread number by checking the CPUs with same core id
> +	 * rather than checking the topology_sibling_cpumask(), since the
> +	 * sibling mask will not cover all the CPUs if there's CPU offline.
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		threads = 1;
> +
> +		/* Invalid thread id, this CPU is not in a SMT core */
> +		if (cpu_topology[cpu].thread_id == -1)
> +			continue;
> +
> +		for_each_possible_cpu(sibling) {
> +			if (sibling == cpu || cpu_topology[sibling].thread_id == -1)
> +				continue;
> +
> +			if (cpu_topology[cpu].core_id == cpu_topology[sibling].core_id)
> +				threads++;
> +		}
> +
> +		if (threads > topology_smt_num_threads)
> +			topology_smt_num_threads = threads;
> +	}
> +
> +	/*
> +	 * We don't support CONFIG_SMT_NUM_THREADS_DYNAMIC so make the
> +	 * max_threads == num_threads.
> +	 */
> +	cpu_smt_set_num_threads(topology_smt_num_threads, topology_smt_num_threads);
> +}
> +
> +/*
> + * On SMT Hotplug the primary thread of the SMT won't be disabled. For x86 they
> + * seem to have a primary thread for special purpose. For other arthitectures
> + * like arm64 there's no such restriction for a primary thread, so make the
> + * first thread in the SMT as the primary thread.
> + */
> +bool topology_is_primary_thread(unsigned int cpu)
> +{
> +	if (cpu == cpumask_first(topology_sibling_cpumask(cpu)))
> +		return true;
> +
> +	return false;
> +}
> +#endif
> +
>  void update_siblings_masks(unsigned int cpuid)
>  {
>  	struct cpu_topology *cpu_topo, *cpuid_topo = &cpu_topology[cpuid];
> @@ -841,6 +898,12 @@ void __init init_cpu_topology(void)
>  		reset_cpu_topology();
>  	}
>  
> +	/*
> +	 * By this stage we get to know whether we support SMT or not, update
> +	 * the information for the core.
> +	 */
> +	topology_smt_set_num_threads();
> +

So this would be the diff between x86 and arm64:

start_kernel() [init/main.c]

 arch_cpu_finalize_init() [arch/x86/kernel/cpu/common.c] <- x86

  identify_boot_cpu() [arch/x86/kernel/cpu/common.c]

   detect_ht() [arch/x86/kernel/cpu/common.c]

    detect_ht_early() [arch/x86/kernel/cpu/common.c]

  cpu_smt_set_num_threads(smp_num_siblings, smp_num_siblings) <- (1)
   

 arch_call_rest_init() [init/main.c] <- arm64

  rest_init() [init/main.c]

   kernel_init() [init/main.c]

    kernel_init_freeable() [init/main.c]

     smp_prepare_cpus() [arch/arm64/kernel/smp.c]

      init_cpu_topology() [drivers/base/arch_topology.c]

       topology_smt_set_num_threads()

        cpu_smt_set_num_threads(topology_smt_num_threads, topology_smt_num_threads) <- (1) 

[...]

Did some rough testing with your patch on an SMT4 Arm64 server with 256
CPUs:

(1) CPU hp out all secondaries from the thread_siblings masks

for i in {32..255}; do echo 0 > /sys/devices/system/cpu/cpu$i/online; done

(2) Check thread_siblings cpumasks

cat /sys/devices/system/cpu/cpu*/topology/thread_siblings
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000001
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000002
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000400
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000800
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00001000
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00002000
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00004000
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00008000
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00010000
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00020000
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00040000
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00080000
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000004
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00100000
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00200000
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00400000
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00800000
00000000,00000000,00000000,00000000,00000000,00000000,00000000,01000000
00000000,00000000,00000000,00000000,00000000,00000000,00000000,02000000
00000000,00000000,00000000,00000000,00000000,00000000,00000000,04000000
00000000,00000000,00000000,00000000,00000000,00000000,00000000,08000000
00000000,00000000,00000000,00000000,00000000,00000000,00000000,10000000
00000000,00000000,00000000,00000000,00000000,00000000,00000000,20000000
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000008
00000000,00000000,00000000,00000000,00000000,00000000,00000000,40000000
00000000,00000000,00000000,00000000,00000000,00000000,00000000,80000000
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000010
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000020
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000040
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000080
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000100
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000200

(3) CPU hp out and out CPU31

echo 0 > /sys/devices/system/cpu/cpu31/online
echo 1 > /sys/devices/system/cpu/cpu31/online

cpu_smt_control is still CPU_SMT_ENABLED in cpu_smt_allowed() so
topology_is_primary_thread() isn't called? 
