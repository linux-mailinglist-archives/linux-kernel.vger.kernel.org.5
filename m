Return-Path: <linux-kernel+bounces-56435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A61FB84CA1D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BEF2283E8C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A31F59B64;
	Wed,  7 Feb 2024 12:01:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A928B59B5D
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 12:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307312; cv=none; b=RAbrX+cXkp8B0GoPTeEgxtzJe9cNcQTTeelFAEGj3/DTQmZ3ADnq6WgzZp/KSOX+ImNx1qlyp2lGR3PcRJLNbJK+Ra/I01dAvTV+XezoL+J9yFKu5V2T+ETANBsXedxLZ4admr2n7KOeRicjRSGj8r/89Xhf9VKPGXoJCqIaTB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307312; c=relaxed/simple;
	bh=JCThxR/yoD0vXi5xAKnNDQA/XzT1+8Kj1dMdpzGXaPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ThcJKENfKsfZ3pkl6p50HVQFLNuR9Ci2UA8HCb1olN5LGwup3HhIdNe7J6G/K4ls7t1AT4v+wdFif8rRmm8Hbk9uMYiaXsxA36FsKAECxuTl7JmNt98+RbFAZn/yKhX/Gmy8rHtU2eB/v5ein7ucLRHtIGXRAVqHEp2tMqzrxII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 582291FB;
	Wed,  7 Feb 2024 04:02:32 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 377D93F5A1;
	Wed,  7 Feb 2024 04:01:49 -0800 (PST)
Date: Wed, 7 Feb 2024 12:01:43 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/sve: Document that __SVE_VQ_MAX is much larger
 than needed
Message-ID: <ZcNxJ56+bvcUTGlT@e133380.arm.com>
References: <20240206-arm64-sve-vl-max-comment-v1-1-dddf16414412@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206-arm64-sve-vl-max-comment-v1-1-dddf16414412@kernel.org>

On Tue, Feb 06, 2024 at 04:27:01PM +0000, Mark Brown wrote:
> __SVE_VQ_MAX is defined without comment as 512 but the actual
> architectural maximum is 16, a substantial difference which might not
> be obvious to readers especially given the several different units used
> for specifying vector sizes in various contexts and the fact that it's
> often used via macros.  In an effort to minimise surprises for users who
> might assume the value is the architectural maximum and use it to do
> things like size allocations add a comment noting the difference.

Well, the value 512 was semi-deliberately chosen to be surprising.

But the point about units is valid: to the casual reader, "512" does
look suspiciously like a bit count when it really really isn't...

> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/include/uapi/asm/sve_context.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/include/uapi/asm/sve_context.h b/arch/arm64/include/uapi/asm/sve_context.h
> index 754ab751b523..59f283f373a6 100644
> --- a/arch/arm64/include/uapi/asm/sve_context.h
> +++ b/arch/arm64/include/uapi/asm/sve_context.h
> @@ -13,6 +13,10 @@
>  
>  #define __SVE_VQ_BYTES		16	/* number of bytes per quadword */
>  
> +/*
> + * Note that for future proofing __SVE_VQ_MAX is defined much larger
> + * than the actual architecture maximum of 16.
> + */

I think that putting shadow #defines in comments in UAPI headers is a
really bad idea...  is this a normative statement about the user API,
or what?

My concern is that if we muddy the waters here different bits of
software will do different things and we will get a mess with no
advantages.

Portability issues may ensue if userspace software feels it can
substitute some other value for this constant, since we can't control
what userspace uses it for.

>  #define __SVE_VQ_MIN		1

Would it be sufficient to say something like:

/*
 * Yes, this is 512 QUADWORDS.
 * Never allocate memory or size structures based on the value of this
 * constant.
 */
>  #define __SVE_VQ_MAX		512

Though comments might be better placed alongsize SVE_VQ_MAX at al., in
ptrace.h and sigcontext.h rather than here.  The leading __ should at
least be a hint that __SVE_VQ_MAX shouldn't be used directly by
anyone...

Cheers
---Dave

