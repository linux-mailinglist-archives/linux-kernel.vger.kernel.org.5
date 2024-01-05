Return-Path: <linux-kernel+bounces-17422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE927824CFD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 03:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFC321C222A5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FDC5CBE;
	Fri,  5 Jan 2024 02:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JIXxl8dP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30925524B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 02:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704422140; x=1735958140;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vi0eoi8r8C+7nkWC6UdV72H0qgS+bhDRqse1pLGLWsQ=;
  b=JIXxl8dPJA6qTgrJUQ5M0lxdxY10D6bCrGkE49cGQTY+UdPZFKUav2Ku
   W4UARMw1h5m0SUIIQhik3g7rZfnE5IiLHwxPLw5EpwHvVJC8U1+TC4Two
   rvyQVMmgJQZzy4v4gvGqu6Ay9YQF4dlJ7Kna90WNdtfw+NTusA3sePoSs
   YXoKjBSrLT88OpqevtOujprnT3IRHn6YkfUGjRZP20HJgF9ptJFNuxLYo
   V6CxvUGciV0Y6BD583uo2tHvP4FaW3GtZPDh5Di2h95CX/n28obxurNeW
   VerRBIIRzy+BPOVobDRrStoAGpmbCO4jjOBYQuvVzcA5I+R315YMFJSIf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="483589562"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="483589562"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 18:35:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="22705950"
Received: from yy-desk-7060.sh.intel.com (HELO localhost) ([10.239.159.76])
  by fmviesa001.fm.intel.com with ESMTP; 04 Jan 2024 18:35:34 -0800
Date: Fri, 5 Jan 2024 10:35:33 +0800
From: Yuan Yao <yuan.yao@linux.intel.com>
To: Kai Huang <kai.huang@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, dave.hansen@intel.com,
	kirill.shutemov@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
	mingo@redhat.com, peterz@infradead.org, rafael@kernel.org,
	dan.j.williams@intel.com, hpa@zytor.com, geert@linux-m68k.org,
	bhe@redhat.com, akpm@linux-foundation.org, rppt@kernel.org,
	frederic@kernel.org, dave.jiang@intel.com, xin3.li@intel.com,
	rick.p.edgecombe@intel.com, isaku.yamahata@intel.com,
	yuan.yao@intel.com
Subject: Re: [PATCH] x86/asm: Remove the __iomem annotation of movdir64b()'s
 dst argument
Message-ID: <20240105023533.4whnuskzbp4h4gbx@yy-desk-7060>
References: <20240104221219.572258-1-kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104221219.572258-1-kai.huang@intel.com>
User-Agent: NeoMutt/20171215

On Fri, Jan 05, 2024 at 11:12:19AM +1300, Kai Huang wrote:
> Commit e56d28df2f66 ("x86/virt/tdx: Configure global KeyID on all
> packages") causes below sparse check warning:
>
>   arch/x86/virt/vmx/tdx/tdx.c:683:27: warning: incorrect type in argument 1 (different address spaces)
>   arch/x86/virt/vmx/tdx/tdx.c:683:27:    expected void [noderef] __iomem *dst
>   arch/x86/virt/vmx/tdx/tdx.c:683:27:    got void *
>
> The reason is TDX must use the MOVDIR64B instruction to convert TDX
> private memory (which is normal RAM but not MMIO) back to normal.  The
> TDX code uses existing movdir64b() helper to do that, but the first
> argument @dst of movdir64b() is annotated with __iomem.
>
> When movdir64b() was firstly introduced in commit 0888e1030d3e
> ("x86/asm: Carve out a generic movdir64b() helper for general usage"),
> it didn't have the __iomem annotation.  But this commit also introduced
> the same "incorrect type" sparse warning because the iosubmit_cmds512(),
> which was the solo caller of movdir64b(), has the __iomem annotation.
>
> This was later fixed by commit 6ae58d871319 ("x86/asm: Annotate
> movdir64b()'s dst argument with __iomem").  That fix was reasonable
> because until TDX code the movdir64b() was only used to move data to
> MMIO location, as described by the commit message:
>
>   ... The current usages send a 64-bytes command descriptor to an MMIO
>   location (portal) on a device for consumption. When future usages for
>   the MOVDIR64B instruction warrant a separate variant of a memory to
>   memory operation, the argument annotation can be revisited.
>
> Now TDX code uses MOVDIR64B to move data to normal memory so it's time
> to revisit.
>
> The SDM says the destination of MOVDIR64B is "memory location specified
> in a general register", thus it's more reasonable that movdir64b() does
> not have the __iomem annotation on the @dst.
>
> Remove the __iomem annotation from the @dst argument of movdir64b() to
> fix the sparse warning in TDX code.  Similar to memset_io(), introduce a
> new movdir64b_io() to cover the case where the destination is an MMIO
> location, and change the solo caller iosubmit_cmds512() to use the new
> movdir64b_io().
>
> In movdir64b_io() explicitly use __force in the type casting otherwise
> there will be below sparse warning:
>
>   warning: cast removes address space '__iomem' of expression
>
> Fixes: e56d28df2f66 ("x86/virt/tdx: Configure global KeyID on all packages")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312311924.tGjsBIQD-lkp@intel.com/
> Signed-off-by: Kai Huang <kai.huang@intel.com>

Reviewed-by: Yuan Yao <yuan.yao@intel.com>

> ---
>  arch/x86/include/asm/io.h            | 2 +-
>  arch/x86/include/asm/special_insns.h | 9 +++++++--
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
> index 76238842406a..de2dc9837f11 100644
> --- a/arch/x86/include/asm/io.h
> +++ b/arch/x86/include/asm/io.h
> @@ -379,7 +379,7 @@ static inline void iosubmit_cmds512(void __iomem *dst, const void *src,
>  	const u8 *end = from + count * 64;
>
>  	while (from < end) {
> -		movdir64b(dst, from);
> +		movdir64b_io(dst, from);
>  		from += 64;
>  	}
>  }
> diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
> index d6cd9344f6c7..f661277e52d6 100644
> --- a/arch/x86/include/asm/special_insns.h
> +++ b/arch/x86/include/asm/special_insns.h
> @@ -224,10 +224,10 @@ static inline void serialize(void)
>  }
>
>  /* The dst parameter must be 64-bytes aligned */
> -static inline void movdir64b(void __iomem *dst, const void *src)
> +static inline void movdir64b(void *dst, const void *src)
>  {
>  	const struct { char _[64]; } *__src = src;
> -	struct { char _[64]; } __iomem *__dst = dst;
> +	struct { char _[64]; } *__dst = dst;
>
>  	/*
>  	 * MOVDIR64B %(rdx), rax.
> @@ -245,6 +245,11 @@ static inline void movdir64b(void __iomem *dst, const void *src)
>  		     :  "m" (*__src), "a" (__dst), "d" (__src));
>  }
>
> +static inline void movdir64b_io(void __iomem *dst, const void *src)
> +{
> +	movdir64b((void __force *)dst, src);
> +}
> +
>  /**
>   * enqcmds - Enqueue a command in supervisor (CPL0) mode
>   * @dst: destination, in MMIO space (must be 512-bit aligned)
>
> base-commit: 83e1bdc94f32dcf52dfcd2025acc7a2b9376b1e8
> --
> 2.43.0
>

