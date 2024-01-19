Return-Path: <linux-kernel+bounces-30763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBD4832418
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 05:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5DC21C22B9A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 04:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBD346AD;
	Fri, 19 Jan 2024 04:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SI3kopc9"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C24B1378;
	Fri, 19 Jan 2024 04:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705639349; cv=none; b=cm7YSlNV5kixqr7XFedFk/6v4nnthmrJs+HYTY5H/CbGwDTLxtv46DaXsYgEaFB2umY6+m2Law5Ne5vK8OUNI+Mlj6MmLyYJboBw2PKR9lL0Njd88QjBBO78evLyknzK6L7BQYRY6Dx4As9U3acgt96y6lAJW5OPS4OhP4p/F1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705639349; c=relaxed/simple;
	bh=z24jcwvn6VeQRgpx1lwkI92V/+RzeY7DygX/TmFY/mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRpO21SvEqBoZeu1Pm3soMrIECXV2N6nI/p1s+RxNGBcjgye9MrgC3SaO/ONcLm2DgoQ/k3F58ZZEfPzXl24bR72twjgXv9YuJACxMuUE1zD52hVBoxEboGBHAcvQP1gvAElIww58s0fkO0t1EYyNCyE4p2tFsnMsCQSon2EPCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SI3kopc9; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5f254d1a6daso3769297b3.2;
        Thu, 18 Jan 2024 20:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705639347; x=1706244147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QUbzb1YsPTuj5pO3yS3gRXNyLqhUcfVQnRjTyZebgdY=;
        b=SI3kopc9wYy1KWXEIE0WTkfDsc/GZNiHKUJ88KHI9Lti8tSGPQ+Hds1ODrr3QiqahA
         F6k5bwsdj8om9MvBfeJDIDSXQhCe7LWIcqdJWo2lYNUko02oVjgdOL8/R75PcSm9S2xm
         YM4nh0znZpkVtsilvPDQy354PggmzcfFrmbOR5JRkyDFFvwkk/kVzV1SRMDl3MdV9cWL
         LVkJL2U5LDh1hTG9B1IhWMHIiK4bEl9sJR+2tkrODYoufR2KQ+0LUA0kpsUGBmKGS40H
         efYtx98C0yaQoK2M57YhNswP242mQni2MgCFhQi54k7RDiFGfNlIvHo9GHQBf6IWPLeu
         dZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705639347; x=1706244147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUbzb1YsPTuj5pO3yS3gRXNyLqhUcfVQnRjTyZebgdY=;
        b=GERVMEiwIDM+sUG95f7S3ZW5L1PnrZ4ySseyKrGyfKQfRLmiTRDO2u5GHAoAWR3sjS
         Gw/4OlRJ9vLsDSNJgN03YfGW6RHvjWBBxM/FVZy5xOCUJsVW4U21LjIDK+Lu/ZAPQTB+
         bIEgzlN4zlfjp2GvDhB1tuqScro1KAb5xd1VNS+YAzKXi8693hAmRXA99rHMvQWryy4I
         0mWG2ukTmzJLqF7R+ZeK0/Dd6TQYx0Glzn/AftbY55ZynngqsW8uxkk/vjvjcEsf/vGX
         Vo0KIOh8d8tH5cXaUjs1l94sJECFUpJsULIyhokh6q1eAr+E7kkyaZrxe8FhI0eN/2ob
         G0Zg==
X-Gm-Message-State: AOJu0YwIvOe2LuYuJIsDMhqfx9fJiOWgBhhbHDXWjiYsv3H21/I2zvDf
	AwygYgXJA+YUbXfVFS7S+D2ldqh6AZgs5MebqL+kZgmOmzX8MV7z
X-Google-Smtp-Source: AGHT+IHLrd8uaTT0OOHdcytJ8iHjmKPtxYqdGqH2+DZik5pfzx5cxI60sO/qbir/GslTPLU+qYhC/Q==
X-Received: by 2002:a81:4e85:0:b0:5ff:3087:a378 with SMTP id c127-20020a814e85000000b005ff3087a378mr1746436ywb.13.1705639347074;
        Thu, 18 Jan 2024 20:42:27 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:b45f:9648:c2e:2e36])
        by smtp.gmail.com with ESMTPSA id b6-20020a0dd906000000b005f941afab71sm21362ywe.30.2024.01.18.20.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 20:42:26 -0800 (PST)
Date: Thu, 18 Jan 2024 20:42:25 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Huang Shijie <shijie@os.amperecomputing.com>
Cc: gregkh@linuxfoundation.org, patches@amperecomputing.com,
	rafael@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, kuba@kernel.org, vschneid@redhat.com,
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
Message-ID: <Zan9sb0vtSvVvQeA@yury-ThinkPad>
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
> hZ7bkEvc+Z19RHkS/HVG3KMg
> X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB7144
> Status: O
> Content-Length: 3779
> Lines: 126
> 
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

This adds another level of indirection, I think. Currently cpu_to_node
is a simple inliner. After the patch it would be a real function with
all the associate overhead. Can you share a bloat-o-meter output here?

Regardless, I don't think that the approach is correct. As per your
description, some initialization functions erroneously call
cpu_to_node() instead of early_cpu_to_node() which exists specifically
for that case.

If the above correct, it's clearly a caller problem, and the fix is to
simply switch all those callers to use early version.

I would also initialize the numa_node with NUMA_NO_NODE at declaration,
so that if someone calls cpu_to_node() before the variable is properly
initialized at runtime, he'll get NO_NODE, which is obviously an error.

Thanks,
Yury
 
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
>  	cad_pid = get_pid(t

