Return-Path: <linux-kernel+bounces-50765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E806B847DAF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25FDE1C22C43
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634187F4;
	Sat,  3 Feb 2024 00:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkVh8rmg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD8F62B;
	Sat,  3 Feb 2024 00:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706919426; cv=none; b=fM46A7gqqaij2pxDY1urIfERM9+EwSKSkkl7907H/2uvGtQaLB4EBo3ICoEg0DYrEd3w/0GauMaIlYVFc6kUukxsvkf/YgxWwkIOMHPlRUt9DAV8CFwnxSzGAjjsLDA+TzSecjiBpnwSTtpI0mTwWJItyjFGi9xU+VBJgWb7tK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706919426; c=relaxed/simple;
	bh=nZQsPsqNPYYXxX4K2h4eMz+56hYUx5rcVPocfkID7bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNpJD0VQjahRg5JW1ulDntc0p5fLeJ0nDwJZCZTcKd+oxx0FY2zUmMx+Z1xktIkiUzAW/kgJUa+/nibPGiP2DTXVp5wFhDUhE+15VZrhhg/WpRE/LTW6sofebU54qaaiVU/2zgIh2WuRw8GTrQb40qZwzvln7AwRLsx6bUD2QUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkVh8rmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871F1C433C7;
	Sat,  3 Feb 2024 00:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706919426;
	bh=nZQsPsqNPYYXxX4K2h4eMz+56hYUx5rcVPocfkID7bk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gkVh8rmg3XviEeH3EY8bNCfbVigkIJj9WT2Y5KnRTScNgFbnoBjbSnmABJOB8o0io
	 mle8q4VPcWx5E4fVoDLFYjRvAdiCEJRkEWoAxi3c+t8YJ0GgPGX0blFma9D8oM+vMy
	 +/WTnug5E9DkyMJWlO5gdxHhfudehvYjgPAX1bsuSjY9GnE0lMDk1NXw412a+Gri4Q
	 kWZYV8TCESgMZkahnRzmA4QUPoLpe8C9oWKbwT+Z6U1f1Iyy+BRIi2lsk3xqut/Ea9
	 Py6mRhFWBOW7bvDMCYT+/HRuh3J00fp8dhNhpGr4He7WW0gEl7LuJwSiP/tLNIScJu
	 Mc1GnRfYytVPg==
Date: Fri, 2 Feb 2024 17:17:03 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, mhklinux@outlook.com
Subject: Re: [PATCH linux-next 1/3] x86, crash: don't nest CONFIG_CRASH_DUMP
 ifdef inside CONFIG_KEXEC_CODE ifdef scope
Message-ID: <20240203001703.GA3735093@dev-arch.thelio-3990X>
References: <20240129135033.157195-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129135033.157195-1-bhe@redhat.com>

This series resolves the build issues I was seeing. Please feel free to
carry

  Tested-by: Nathan Chancellor <nathan@kernel.org> # build

forward if there are any more revisions without drastic changes.

On Mon, Jan 29, 2024 at 09:50:31PM +0800, Baoquan He wrote:
> Michael pointed out that the #ifdef CONFIG_CRASH_DUMP is nested inside
> arch/x86/xen/enlighten_hvm.c.
> 
> Although the nesting works well too since CONFIG_CRASH_DUMP has
> dependency on CONFIG_KEXEC_CORE, it may cause confuse because there
> are places where it's not nested, and people may think it need be nested
> even though it doesn't have to.
> 
> Fix that by moving  CONFIG_CRASH_DUMP ifdeffery of codes out of
> CONFIG_KEXEC_CODE ifdeffery scope.
> 
> And also fix a building error Nathan reported as below by replacing
> CONFIG_KEXEC_CORE ifdef with CONFIG_VMCORE_INFO ifdef.
> 
> ====
> $ curl -LSso .config https://git.alpinelinux.org/aports/plain/community/linux-edge/config-edge.x86_64
> $ make -skj"$(nproc)" ARCH=x86_64 CROSS_COMPILE=x86_64-linux- olddefconfig all
> ...
> x86_64-linux-ld: arch/x86/xen/mmu_pv.o: in function `paddr_vmcoreinfo_note':
> mmu_pv.c:(.text+0x3af3): undefined reference to `vmcoreinfo_note'
> ====
> 
> Link: https://lore.kernel.org/all/SN6PR02MB4157931105FA68D72E3D3DB8D47B2@SN6PR02MB4157.namprd02.prod.outlook.com/T/#u
> Link: https://lore.kernel.org/all/20240126045551.GA126645@dev-arch.thelio-3990X/T/#u
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 10 ++++++----
>  arch/x86/kernel/reboot.c       |  2 +-
>  arch/x86/xen/enlighten_hvm.c   |  4 ++--
>  arch/x86/xen/mmu_pv.c          |  2 +-
>  4 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index f8163a59026b..2e8cd5a4ae85 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -209,6 +209,7 @@ static void hv_machine_shutdown(void)
>  	if (kexec_in_progress)
>  		hyperv_cleanup();
>  }
> +#endif /* CONFIG_KEXEC_CORE */
>  
>  #ifdef CONFIG_CRASH_DUMP
>  static void hv_machine_crash_shutdown(struct pt_regs *regs)
> @@ -222,8 +223,7 @@ static void hv_machine_crash_shutdown(struct pt_regs *regs)
>  	/* Disable the hypercall page when there is only 1 active CPU. */
>  	hyperv_cleanup();
>  }
> -#endif
> -#endif /* CONFIG_KEXEC_CORE */
> +#endif /* CONFIG_CRASH_DUMP */
>  #endif /* CONFIG_HYPERV */
>  
>  static uint32_t  __init ms_hyperv_platform(void)
> @@ -497,9 +497,11 @@ static void __init ms_hyperv_init_platform(void)
>  	no_timer_check = 1;
>  #endif
>  
> -#if IS_ENABLED(CONFIG_HYPERV) && defined(CONFIG_KEXEC_CORE)
> +#if IS_ENABLED(CONFIG_HYPERV)
> +#if defined(CONFIG_KEXEC_CORE)
>  	machine_ops.shutdown = hv_machine_shutdown;
> -#ifdef CONFIG_CRASH_DUMP
> +#endif
> +#if defined(CONFIG_CRASH_DUMP)
>  	machine_ops.crash_shutdown = hv_machine_crash_shutdown;
>  #endif
>  #endif
> diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> index 1287b0d5962f..f3130f762784 100644
> --- a/arch/x86/kernel/reboot.c
> +++ b/arch/x86/kernel/reboot.c
> @@ -826,7 +826,7 @@ void machine_halt(void)
>  	machine_ops.halt();
>  }
>  
> -#ifdef CONFIG_KEXEC_CORE
> +#ifdef CONFIG_CRASH_DUMP
>  void machine_crash_shutdown(struct pt_regs *regs)
>  {
>  	machine_ops.crash_shutdown(regs);
> diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
> index 09e3db7ff990..0b367c1e086d 100644
> --- a/arch/x86/xen/enlighten_hvm.c
> +++ b/arch/x86/xen/enlighten_hvm.c
> @@ -148,6 +148,7 @@ static void xen_hvm_shutdown(void)
>  	if (kexec_in_progress)
>  		xen_reboot(SHUTDOWN_soft_reset);
>  }
> +#endif
>  
>  #ifdef CONFIG_CRASH_DUMP
>  static void xen_hvm_crash_shutdown(struct pt_regs *regs)
> @@ -156,7 +157,6 @@ static void xen_hvm_crash_shutdown(struct pt_regs *regs)
>  	xen_reboot(SHUTDOWN_soft_reset);
>  }
>  #endif
> -#endif
>  
>  static int xen_cpu_up_prepare_hvm(unsigned int cpu)
>  {
> @@ -238,10 +238,10 @@ static void __init xen_hvm_guest_init(void)
>  
>  #ifdef CONFIG_KEXEC_CORE
>  	machine_ops.shutdown = xen_hvm_shutdown;
> +#endif
>  #ifdef CONFIG_CRASH_DUMP
>  	machine_ops.crash_shutdown = xen_hvm_crash_shutdown;
>  #endif
> -#endif
>  }
>  
>  static __init int xen_parse_nopv(char *arg)
> diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
> index 218773cfb009..e21974f2cf2d 100644
> --- a/arch/x86/xen/mmu_pv.c
> +++ b/arch/x86/xen/mmu_pv.c
> @@ -2520,7 +2520,7 @@ int xen_remap_pfn(struct vm_area_struct *vma, unsigned long addr,
>  }
>  EXPORT_SYMBOL_GPL(xen_remap_pfn);
>  
> -#ifdef CONFIG_KEXEC_CORE
> +#ifdef CONFIG_VMCORE_INFO
>  phys_addr_t paddr_vmcoreinfo_note(void)
>  {
>  	if (xen_pv_domain())
> -- 
> 2.41.0
> 

