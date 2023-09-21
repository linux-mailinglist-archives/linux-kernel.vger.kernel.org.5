Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4A87AA069
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjIUUgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjIUUfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:35:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96A3266362
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:34:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89DDA16A3;
        Thu, 21 Sep 2023 08:04:14 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D70353F59C;
        Thu, 21 Sep 2023 08:03:35 -0700 (PDT)
Date:   Thu, 21 Sep 2023 16:03:33 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, jonathan.cameron@huawei.com,
        prime.zeng@hisilicon.com, linuxarm@huawei.com,
        yangyicong@hisilicon.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch_topology: Support SMT control on arm64
Message-ID: <20230921150333.c2zqigs3xxwcg4ln@bogus>
References: <20230919123319.23785-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919123319.23785-1-yangyicong@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 08:33:19PM +0800, Yicong Yang wrote:
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
> - update the SMT status after the topology enumerated on arm64
> - select HOTPLUG_SMT for arm64
> 
> For disabling SMT we'll offline all the secondary threads and
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

I would really like to avoid parsing all the cpus here(O(cpu^2))

Another random thought(just looking at DT parsing) is we can count threads
while parsing itself if we need the info early before the topology cpumasks
are setup. Need to look at ACPI parsing and how to make that generic but
thought of checking the idea here first.

[...]

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

Does this have to be done this early ? I was wondering if we can defer until
all the cpumasks are set and you can rely on the thread_sibling mask ?
You can just get the weight of that mask on all cpus and choose the max value.

-- 
Regards,
Sudeep
