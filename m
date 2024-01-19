Return-Path: <linux-kernel+bounces-30778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34314832443
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 581791C22D51
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 05:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9906117;
	Fri, 19 Jan 2024 05:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RK5pRqjg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448A3523A;
	Fri, 19 Jan 2024 05:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705642552; cv=none; b=sWfecSEhKq6vmcy7fc6doCELWS2xGK+YB82oWM+Bg7LP8kueNbKhpWPXrjG5j+68HfjnUBRcGqeoGD+IjLTLJdG4oK9ipH7UD3YkfZ3d6PESAOuDHhFNxbD0RX1vX7VncX4e98H5xJWIGqnZakpUECLzuAAtSZiMQzmq73ExelQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705642552; c=relaxed/simple;
	bh=xwIvYirzcQSwftyIx5L3JhM83cF7QaQjlnMuqrVIBW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovSNdYmTdMfqbu0H8DbzFJMv281Eyy4MPr+qidX3L/0HDwurKxhpMxqU06hRIInTl6D6uYl7YAgktKI8eAF8J1qIb8elKuviAI4Yb9Pv4zHq2PKa/C+heOG5ydeJmlh4VqCZ2yl+a2CzBfDDEFMuG+52og4pdHUYKzT5QYkU87k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RK5pRqjg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076E6C433C7;
	Fri, 19 Jan 2024 05:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705642551;
	bh=xwIvYirzcQSwftyIx5L3JhM83cF7QaQjlnMuqrVIBW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RK5pRqjgi6Jn5tJ8rmDeMlYrbrTcn13P1in9jNFBBmtQye8lmAYZVLH5sgNDwDYcj
	 G/W7j8+u6jGvZIpeWfD/1/0yVMJWag21Fy71X8+gFqOwq+7MnSVVVpj0QefvOT3yE4
	 oCGZgYFbu705V1AUa+l476kv25eE1SK0a3p09xGI=
Date: Fri, 19 Jan 2024 06:35:48 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Huang Shijie <shijie@os.amperecomputing.com>
Cc: patches@amperecomputing.com, rafael@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	yury.norov@gmail.com, kuba@kernel.org, vschneid@redhat.com,
	mingo@kernel.org, akpm@linux-foundation.org, vbabka@suse.cz,
	rppt@kernel.org, tglx@linutronix.de, jpoimboe@kernel.org,
	ndesaulniers@google.com, mikelley@microsoft.com,
	mhiramat@kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	will@kernel.org, mark.rutland@arm.com, mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org, chenhuacai@kernel.org,
	jiaxun.yang@flygoat.com, linux-mips@vger.kernel.org,
	cl@os.amperecomputing.com
Subject: Re: [PATCH] NUMA: Early use of cpu_to_node() returns 0 instead of
 the correct node id
Message-ID: <2024011937-multitude-yield-fd4d@gregkh>
References: <20240119033227.14113-1-shijie@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119033227.14113-1-shijie@os.amperecomputing.com>

On Fri, Jan 19, 2024 at 11:32:27AM +0800, Huang Shijie wrote:
> During the kernel booting, the generic cpu_to_node() is called too early in
> arm64, powerpc and riscv when CONFIG_NUMA is enabled.
> 
> There are at least four places in the common code where
> the generic cpu_to_node() is called before it is initialized:
> 	   1.) early_trace_init()         in kernel/trace/trace.c
> 	   2.) sched_init()               in kernel/sched/core.c
> 	   3.) init_sched_fair_class()    in kernel/sched/fair.c
> 	   4.) workqueue_init_early()     in kernel/workqueue.c
> 
> In order to fix the bug, the patch changes generic cpu_to_node to
> function pointer, and export it for kernel modules.
> Introduce smp_prepare_boot_cpu_start() to wrap the original
> smp_prepare_boot_cpu(), and set cpu_to_node with early_cpu_to_node.
> Introduce smp_prepare_cpus_done() to wrap the original smp_prepare_cpus(),
> and set the cpu_to_node to formal _cpu_to_node().
> 
> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
> ---
>  drivers/base/arch_numa.c | 11 +++++++++++
>  include/linux/topology.h |  6 ++----
>  init/main.c              | 29 +++++++++++++++++++++++++++--
>  3 files changed, 40 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
> index 5b59d133b6af..867a477fa975 100644
> --- a/drivers/base/arch_numa.c
> +++ b/drivers/base/arch_numa.c
> @@ -61,6 +61,17 @@ EXPORT_SYMBOL(cpumask_of_node);
>  
>  #endif
>  
> +#ifdef CONFIG_USE_PERCPU_NUMA_NODE_ID
> +#ifndef cpu_to_node
> +int _cpu_to_node(int cpu)
> +{
> +	return per_cpu(numa_node, cpu);
> +}
> +int (*cpu_to_node)(int cpu);
> +EXPORT_SYMBOL(cpu_to_node);
> +#endif
> +#endif
> +
>  static void numa_update_cpu(unsigned int cpu, bool remove)
>  {
>  	int nid = cpu_to_node(cpu);
> diff --git a/include/linux/topology.h b/include/linux/topology.h
> index 52f5850730b3..e7ce2bae11dd 100644
> --- a/include/linux/topology.h
> +++ b/include/linux/topology.h
> @@ -91,10 +91,8 @@ static inline int numa_node_id(void)
>  #endif
>  
>  #ifndef cpu_to_node
> -static inline int cpu_to_node(int cpu)
> -{
> -	return per_cpu(numa_node, cpu);
> -}
> +extern int (*cpu_to_node)(int cpu);
> +extern int _cpu_to_node(int cpu);
>  #endif
>  
>  #ifndef set_numa_node
> diff --git a/init/main.c b/init/main.c
> index e24b0780fdff..b142e9c51161 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -870,6 +870,18 @@ static void __init print_unknown_bootoptions(void)
>  	memblock_free(unknown_options, len);
>  }
>  
> +static void __init smp_prepare_boot_cpu_start(void)
> +{
> +	smp_prepare_boot_cpu();	/* arch-specific boot-cpu hooks */
> +
> +#ifdef CONFIG_USE_PERCPU_NUMA_NODE_ID
> +#ifndef cpu_to_node
> +	/* The early_cpu_to_node should be ready now. */
> +	cpu_to_node = early_cpu_to_node;
> +#endif
> +#endif
> +}
> +
>  asmlinkage __visible __init __no_sanitize_address __noreturn __no_stack_protector
>  void start_kernel(void)
>  {
> @@ -899,7 +911,7 @@ void start_kernel(void)
>  	setup_command_line(command_line);
>  	setup_nr_cpu_ids();
>  	setup_per_cpu_areas();
> -	smp_prepare_boot_cpu();	/* arch-specific boot-cpu hooks */
> +	smp_prepare_boot_cpu_start();
>  	boot_cpu_hotplug_init();
>  
>  	pr_notice("Kernel command line: %s\n", saved_command_line);
> @@ -1519,6 +1531,19 @@ void __init console_on_rootfs(void)
>  	fput(file);
>  }
>  
> +static void __init smp_prepare_cpus_done(unsigned int setup_max_cpus)
> +{
> +	/* Different ARCHs may override smp_prepare_cpus() */
> +	smp_prepare_cpus(setup_max_cpus);
> +
> +#ifdef CONFIG_USE_PERCPU_NUMA_NODE_ID
> +#ifndef cpu_to_node
> +	/* Change to the formal function. */
> +	cpu_to_node = _cpu_to_node;
> +#endif
> +#endif
> +}
> +
>  static noinline void __init kernel_init_freeable(void)
>  {
>  	/* Now the scheduler is fully set up and can do blocking allocations */
> @@ -1531,7 +1556,7 @@ static noinline void __init kernel_init_freeable(void)
>  
>  	cad_pid = get_pid(task_pid(current));
>  
> -	smp_prepare_cpus(setup_max_cpus);
> +	smp_prepare_cpus_done(setup_max_cpus);
>  
>  	workqueue_init();
>  
> -- 
> 2.40.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

