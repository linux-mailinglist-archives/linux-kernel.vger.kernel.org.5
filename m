Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3957BFB87
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjJJMeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjJJMeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:34:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DC4119
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:33:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F4CC433CD;
        Tue, 10 Oct 2023 12:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696941236;
        bh=oznR6XQdRr7L8Dhr66StdtoNkpNcXhBFf2d/wh3vR04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O/eDQxKP8fTlHt9gTJPQk6doq39YGd1PaKQQWAC6Mtvu/2ZJ7lHLDFsIt4UWUiGDn
         4J9uZ1P5AJOxlvwklx8ceeky+v44SzRQAXmp/8xGCiy0KQdpnZn7JPEHeT5pRpGf+U
         ++8rwO70rKpGeWE7QCRL/CDvykvxbsPQl+Pi1+ww=
Date:   Tue, 10 Oct 2023 14:33:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, jonathan.cameron@huawei.com,
        prime.zeng@hisilicon.com, linuxarm@huawei.com,
        yangyicong@hisilicon.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arch_topology: Support SMT control on arm64
Message-ID: <2023101025-thieving-eagle-406f@gregkh>
References: <20231010115335.13862-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010115335.13862-1-yangyicong@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 07:53:35PM +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> The core CPU control framework supports runtime SMT control which
> is not yet supported on arm64. Besides the general vulnerabilities
> concerns we want this runtime control on our arm64 server for:

But shouldn't this be part of UEFI?  Why manually try to determine this
at powerup in Linux?

> - better single CPU performance in some cases
> - saving overall power consumption
> 
> This patch implements it in the following aspects:
> 
> - implement the callbacks of the core
> - update the SMT status after the topology enumerated on arm64
> - select HOTPLUG_SMT for arm64
> 
> For disabling SMT we'll offline all the secondary threads and
> only leave the primary thread. Since we don't have restriction
> for primary thread selection, the first thread is chosen as the
> primary thread in this implementation.
> 
> Tests has been done on our real ACPI based arm64 server and on
> ACPI/OF based QEMU VMs.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
> Change since v1:
> - Avoid the complexity on SMT detecting by visiting each CPU once, concerned by Sudeep
> Link: https://lore.kernel.org/all/20230919123319.23785-1-yangyicong@huawei.com/
> 
>  arch/arm64/Kconfig            |  1 +
>  drivers/base/arch_topology.c  | 75 +++++++++++++++++++++++++++++++++++
>  include/linux/arch_topology.h | 11 +++++
>  3 files changed, 87 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 78f20e632712..339661ceabc8 100644
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
> index b741b5ba82bd..c5b453c2cd61 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -729,6 +729,75 @@ const struct cpumask *cpu_clustergroup_mask(int cpu)
>  	return &cpu_topology[cpu].cluster_sibling;
>  }
>  
> +#ifdef CONFIG_HOTPLUG_SMT
> +static int topology_smt_num_threads = 1;
> +
> +void __init topology_smt_set_num_threads(void)
> +{
> +	int cpu, sibling, threads;
> +	cpumask_var_t to_visit;
> +
> +	if (!alloc_cpumask_var(&to_visit, GFP_KERNEL)) {
> +		pr_err("Failed to update the SMT info\n");
> +		return;
> +	}
> +
> +	cpumask_or(to_visit, to_visit, cpu_possible_mask);
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
> +	for_each_cpu(cpu, to_visit) {
> +		threads = 1;
> +
> +		cpumask_clear_cpu(cpu, to_visit);
> +
> +		/* Invalid thread id, this CPU is not in a SMT core */
> +		if (cpu_topology[cpu].thread_id == -1)
> +			continue;
> +
> +		for_each_cpu(sibling, to_visit) {
> +			if (cpu_topology[sibling].thread_id != -1 &&
> +			    cpu_topology[cpu].core_id == cpu_topology[sibling].core_id)
> +				threads++;
> +
> +			cpumask_clear_cpu(sibling, to_visit);
> +		}
> +
> +		if (threads > topology_smt_num_threads)
> +			topology_smt_num_threads = threads;
> +	}
> +
> +	free_cpumask_var(to_visit);
> +
> +	/*
> +	 * We don't support CONFIG_SMT_NUM_THREADS_DYNAMIC so make the
> +	 * max_threads == num_threads.
> +	 */
> +	cpu_smt_set_num_threads(topology_smt_num_threads, topology_smt_num_threads);
> +}

How is this going to affect non-arm64 systems?  Will we now be doing
this double loop for all cpus in the systems (i.e. for 10's of thousands
on x86)?

And again, why is this not an issue on the current platforms that
already support CONFIG_HOTPLUG_SMT?  What makes ARM64 so broken it
requires this manual intervention?

thanks,

greg k-h
