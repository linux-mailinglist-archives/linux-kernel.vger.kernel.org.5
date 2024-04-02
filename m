Return-Path: <linux-kernel+bounces-127687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72340894F73
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22221C20862
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873195C90A;
	Tue,  2 Apr 2024 10:02:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579675D729
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712052125; cv=none; b=evUoZ5pT3CB49mRa83YAsdFcCE2gttblVpaCEwLWVAAJ3PJCcXfMR1q00qYjJd6hAq/Wl0E5Kml/9JbL58+zUyzyoypbAAiBLfnViiZhSoY4HL36YRMdCF+FNuv233jdK+mdmo/YPhUfrxXTS1/AXRUQEo3kKtSf3iY5YvO3eyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712052125; c=relaxed/simple;
	bh=ETE+5vV7Xb6mUUuPbDP6zNYT+xqHfhls+TzoIUYk98Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjQ2owsA8jbw/FB/ocqb4P1otVgVLfoB85Pda6d6PODASSDwVliwHWV8ULa8JmDDjCyh+GNBs4MeGCIIt7/H/vgZ05dqS5Dl7S+AbfpFgQJUpjIQXwzIftFQr2Sia3PrxeYWokUclJCgddMeglXFdmqep/mjDavTfOlzGh20wc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AC1D1042;
	Tue,  2 Apr 2024 03:02:34 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.18.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65ACB3F766;
	Tue,  2 Apr 2024 03:02:01 -0700 (PDT)
Date: Tue, 2 Apr 2024 11:01:58 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Steven Price <steven.price@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: remove redundant 'extern'
Message-ID: <ZgvXljt6vdlVc1sF@FVFF77S0Q05N>
References: <20240327112439.200455-1-steven.price@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327112439.200455-1-steven.price@arm.com>

On Wed, Mar 27, 2024 at 11:24:39AM +0000, Steven Price wrote:
> It isn't necessary to mark function definitions extern and goes against
> the kernel coding style. Remove the redundant extern keyword.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>

We (unfortunately) have extern misused in a number of places:

| [mark@lakrids:~/src/linux]% git grep 'extern.*(' -- arch/arm64/include | cut -d: -f 1 | uniq -c
|      11 arch/arm64/include/asm/cacheflush.h
|       1 arch/arm64/include/asm/checksum.h
|       1 arch/arm64/include/asm/cpu_ops.h
|       4 arch/arm64/include/asm/cpufeature.h
|       2 arch/arm64/include/asm/efi.h
|       2 arch/arm64/include/asm/elf.h
|       1 arch/arm64/include/asm/exec.h
|       1 arch/arm64/include/asm/fixmap.h
|      48 arch/arm64/include/asm/fpsimd.h
|       3 arch/arm64/include/asm/ftrace.h
|      10 arch/arm64/include/asm/hugetlb.h
|      11 arch/arm64/include/asm/hw_breakpoint.h
|       6 arch/arm64/include/asm/io.h
|       4 arch/arm64/include/asm/kexec.h
|       1 arch/arm64/include/asm/kgdb.h
|      16 arch/arm64/include/asm/kvm_asm.h
|       3 arch/arm64/include/asm/kvm_host.h
|      11 arch/arm64/include/asm/kvm_hyp.h
|       2 arch/arm64/include/asm/kvm_pkvm.h
|       2 arch/arm64/include/asm/memory.h
|       8 arch/arm64/include/asm/mmu.h
|       2 arch/arm64/include/asm/page.h
|       1 arch/arm64/include/asm/percpu.h
|       2 arch/arm64/include/asm/perf_event.h
|       2 arch/arm64/include/asm/pgalloc.h
|      18 arch/arm64/include/asm/pgtable.h
|       3 arch/arm64/include/asm/pointer_auth.h
|       3 arch/arm64/include/asm/proc-fns.h
|       2 arch/arm64/include/asm/processor.h
|       3 arch/arm64/include/asm/ptrace.h
|      12 arch/arm64/include/asm/smp.h
|       1 arch/arm64/include/asm/stacktrace.h
|      14 arch/arm64/include/asm/string.h
|       2 arch/arm64/include/asm/suspend.h
|       1 arch/arm64/include/asm/system_misc.h
|       6 arch/arm64/include/asm/uaccess.h

.. so it'd probably be best to make the commit title more specific to this
instance, and maybe go clean those up in bulk as a series to avoid a steady
stream of copycat patches.

Mark.

> ---
>  arch/arm64/include/asm/fixmap.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
> index 87e307804b99..75b22b89db1a 100644
> --- a/arch/arm64/include/asm/fixmap.h
> +++ b/arch/arm64/include/asm/fixmap.h
> @@ -107,7 +107,7 @@ void __init early_fixmap_init(void);
>  #define __late_set_fixmap __set_fixmap
>  #define __late_clear_fixmap(idx) __set_fixmap((idx), 0, FIXMAP_PAGE_CLEAR)
>  
> -extern void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot);
> +void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot);
>  
>  #include <asm-generic/fixmap.h>
>  
> -- 
> 2.34.1
> 
> 

