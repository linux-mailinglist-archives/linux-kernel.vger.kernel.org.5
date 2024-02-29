Return-Path: <linux-kernel+bounces-86600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 805B986C7A1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 275421F26FA2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0C37A738;
	Thu, 29 Feb 2024 11:01:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDE865194
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 11:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709204476; cv=none; b=IPMWtSHBXAGn8TUUm5yV9UlcYTzghlGjMYtwYiYqln5mDC964Hi7pGdl9NgXAmpR36oPxfAGhSTaWIyYfR9/3bUzYuN2DVAdQ+I0vu+qkWjaOs2ISLX+/rzdWi96t3hrpMNCWhfl/HiB8Wn4MopQZzfQg/fp4c43e92giR7GQRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709204476; c=relaxed/simple;
	bh=Jk/YXrLELPDA8NUIr7K8YZn7C3zRBGDzJ3JNfUDio2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BO/k5isjCD3EPCVVL8GIlYBZMyokRPB7ZVM8ynPYewZLtOvzKLF3O8KzkQPOzmR13zuWP4Otqx9NZT4q21n1m60A4yHigNT1G7rycnZcPdGp+hcqNeIDwngelSwmICow7qQCpINlvU4fF7tD0j65vbi9aLhlaPPGCq/w1K0dAMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18D7A1FB;
	Thu, 29 Feb 2024 03:01:51 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.67.138])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A10D3F762;
	Thu, 29 Feb 2024 03:01:10 -0800 (PST)
Date: Thu, 29 Feb 2024 10:59:46 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2] arm64/hw_breakpoint: Directly use ESR_ELx_WNR for an
 watchpoint exception
Message-ID: <ZeBjoq2bzi57EBsU@FVFF77S0Q05N>
References: <20240229083431.356578-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229083431.356578-1-anshuman.khandual@arm.com>

On Thu, Feb 29, 2024 at 02:04:31PM +0530, Anshuman Khandual wrote:
> Let's use existing ISS encoding for an watchpoint exception i.e ESR_ELx_WNR
> This represents an instruction's either writing to or reading from a memory
> location during an watchpoint exception. While here this drops non-standard
> macro AARCH64_ESR_ACCESS_MASK.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

This looks like a sensible cleanup, so:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
> This applies on v6.8-rc5
> 
> Changes in V2:
> 
> - Dropped new ISS encoding details ESR_ELx_WnR and ESR_ELx_WnR_SHIFT
> - Directly used existing ESR_ELx_WNR per Catalin
> - Updated the commit message as required
> 
> Changes in V1:
> 
> https://lore.kernel.org/all/20240223094615.3977323-1-anshuman.khandual@arm.com/ 
> 
>  arch/arm64/include/asm/hw_breakpoint.h | 1 -
>  arch/arm64/kernel/hw_breakpoint.c      | 3 ++-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/hw_breakpoint.h b/arch/arm64/include/asm/hw_breakpoint.h
> index 84055329cd8b..bd81cf17744a 100644
> --- a/arch/arm64/include/asm/hw_breakpoint.h
> +++ b/arch/arm64/include/asm/hw_breakpoint.h
> @@ -59,7 +59,6 @@ static inline void decode_ctrl_reg(u32 reg,
>  /* Watchpoints */
>  #define ARM_BREAKPOINT_LOAD	1
>  #define ARM_BREAKPOINT_STORE	2
> -#define AARCH64_ESR_ACCESS_MASK	(1 << 6)
>  
>  /* Lengths */
>  #define ARM_BREAKPOINT_LEN_1	0x1
> diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
> index 35225632d70a..2f5755192c2b 100644
> --- a/arch/arm64/kernel/hw_breakpoint.c
> +++ b/arch/arm64/kernel/hw_breakpoint.c
> @@ -21,6 +21,7 @@
>  
>  #include <asm/current.h>
>  #include <asm/debug-monitors.h>
> +#include <asm/esr.h>
>  #include <asm/hw_breakpoint.h>
>  #include <asm/traps.h>
>  #include <asm/cputype.h>
> @@ -779,7 +780,7 @@ static int watchpoint_handler(unsigned long addr, unsigned long esr,
>  		 * Check that the access type matches.
>  		 * 0 => load, otherwise => store
>  		 */
> -		access = (esr & AARCH64_ESR_ACCESS_MASK) ? HW_BREAKPOINT_W :
> +		access = (esr & ESR_ELx_WNR) ? HW_BREAKPOINT_W :
>  			 HW_BREAKPOINT_R;
>  		if (!(access & hw_breakpoint_type(wp)))
>  			continue;
> -- 
> 2.25.1
> 

