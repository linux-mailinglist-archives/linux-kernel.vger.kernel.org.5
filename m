Return-Path: <linux-kernel+bounces-86607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECDA86C7C1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE69F1F253C9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282E97AE5D;
	Thu, 29 Feb 2024 11:10:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5497A7A73F
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 11:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709205046; cv=none; b=HHllVzFF8yYKkI+BKOZp/12WUqGZSwsQL/stlG4FffC+3aGIMa38G6Iff4xsjJqsRVt2SYWGZusrvru7NC7WGwZ9X/8wPHge7ON5GxRjCiwvH+hKri/kdcme/GNQxZD9WBqG3QdCNohPclIBuG6Y4RNB2O0gui76D84rhOe8lnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709205046; c=relaxed/simple;
	bh=gnJYMBD5vxbFQv3VEdHFXgM/A+bEYir69Dix+1doZkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWucDsySBkzfvSMVaqW/Auqwh34BYc884pbbAyJUhJG8atv+ghxR9GEUpkAP7hVg/51SoSEyCUNC9zdVt/11eGMtHdibo8yp82i6Itod+OQYrur+HOBZKZwPnWuxlvsbGBlCTWjsrsw2m8tY0YgfnCqbHQoHAjnwa/1GRBjlegU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D16A1FB;
	Thu, 29 Feb 2024 03:11:21 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.67.138])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 617D63F762;
	Thu, 29 Feb 2024 03:10:40 -0800 (PST)
Date: Thu, 29 Feb 2024 11:10:37 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Liao Chang <liaochang1@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org,
	maz@kernel.org, joey.gouly@arm.com, kristina.martsenko@arm.com,
	ryan.roberts@arm.com, jeremy.linton@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: cpufeatures: Clean up temporary variable to
 simplify code
Message-ID: <ZeBmLc9bLhT5qfrB@FVFF77S0Q05N>
References: <20240229105208.456704-1-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229105208.456704-1-liaochang1@huawei.com>

On Thu, Feb 29, 2024 at 10:52:08AM +0000, Liao Chang wrote:
> Clean up one temporary variable to simplifiy code in capability
> detection.
> 
> Signed-off-by: Liao Chang <liaochang1@huawei.com>

This looks line a nice cleanup, so:

Acked-by: Mark Rutland <mark.rutland@arm.com>

For context, we removed the last other user of 'num' in commit:

  21fb26bfb01ffe0d ("arm64: alternatives: add alternative_has_feature_*()")

Mark.

> ---
>  arch/arm64/kernel/cpufeature.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 8d1a634a403e..0e900b23f7ab 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -3052,13 +3052,9 @@ static void __init enable_cpu_capabilities(u16 scope_mask)
>  	boot_scope = !!(scope_mask & SCOPE_BOOT_CPU);
>  
>  	for (i = 0; i < ARM64_NCAPS; i++) {
> -		unsigned int num;
> -
>  		caps = cpucap_ptrs[i];
> -		if (!caps || !(caps->type & scope_mask))
> -			continue;
> -		num = caps->capability;
> -		if (!cpus_have_cap(num))
> +		if (!caps || !(caps->type & scope_mask) ||
> +		    !cpus_have_cap(caps->capability))
>  			continue;
>  
>  		if (boot_scope && caps->cpu_enable)
> -- 
> 2.34.1
> 

