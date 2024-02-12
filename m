Return-Path: <linux-kernel+bounces-62024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A213851A42
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57159282B22
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE213D984;
	Mon, 12 Feb 2024 16:54:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C282629C
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756892; cv=none; b=jL/tA1gD6UwnhGBn4K591KahD3WnsvOW9IlwayIZeW7k/SZDQOpzHVwmn4wOVU5QbAA6v16X7BssYvXaX7Q1P+6g/CNMNR3wYqEjBYUD0EfJirx2wPPEAmv1ESwmsmJtp1R5yqABIY//cHoMsWwOSgqXbA1bkXLrl8pPk/8Rq8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756892; c=relaxed/simple;
	bh=8XJlfKI7qCRZiFjdMvUanEGADCWAeJ5w8mUzbgIqBtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUccxFSC6nSj8/M5tpdYrNbtOlX6u1DnR/VhuNNxRRZAVNyl65vdrdiy1lwON+9PC8lhIuMDG4Ytmnr4WbBRF2MpfIpfVxEyYG5hgWOWhae6zVenDNnmo+8ZiJt/1FFPqXUJ7kPWN9ZGDzWMCEAHa1QFStW5MOi4tJTvkyrEGms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB083DA7;
	Mon, 12 Feb 2024 08:55:31 -0800 (PST)
Received: from e133344.arm.com (e133344.arm.com [10.1.25.137])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE38C3F762;
	Mon, 12 Feb 2024 08:54:49 -0800 (PST)
Date: Mon, 12 Feb 2024 16:54:47 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64/sve: Document that __SVE_VQ_MAX is much larger
 than needed
Message-ID: <ZcpNV9wws5poOY8w@e133344.arm.com>
References: <20240209-arm64-sve-vl-max-comment-v2-1-111b283469ee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209-arm64-sve-vl-max-comment-v2-1-111b283469ee@kernel.org>

On Fri, Feb 09, 2024 at 04:53:36PM +0000, Mark Brown wrote:
> __SVE_VQ_MAX is defined without comment as 512 but the actual
> architectural maximum is 16, a substantial difference which might not
> be obvious to readers especially given the several different units used
> for specifying vector sizes in various contexts and the fact that it's
> often used via macros.  In an effort to minimise surprises for users who
> might assume the value is the architectural maximum and use it to do
> things like size allocations add a comment noting the difference, and
> add a note for SVE_VQ_MAX to aid discoverability.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> Changes in v2:
> - Use new wording mostly provided by Dave Martin.
> - Reference __SVE_VQ_MAX comment near SVE_VQ_MAX define.
> - Link to v1: https://lore.kernel.org/r/20240206-arm64-sve-vl-max-comment-v1-1-dddf16414412@kernel.org
> ---
>  arch/arm64/include/uapi/asm/sve_context.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/include/uapi/asm/sve_context.h b/arch/arm64/include/uapi/asm/sve_context.h
> index 754ab751b523..72aefc081061 100644
> --- a/arch/arm64/include/uapi/asm/sve_context.h
> +++ b/arch/arm64/include/uapi/asm/sve_context.h
> @@ -13,6 +13,17 @@
>  
>  #define __SVE_VQ_BYTES		16	/* number of bytes per quadword */
>  
> +/*
> + * Yes, __SVE_VQ_MAX is 512 QUADWORDS.
> + *
> + * To help ensure forward portability, this is much larger than the
> + * current maximum value defined by the SVE architecture.  While arrays
> + * or static allocations can be sized based on this value, watch out!
> + * It will waste a surprisingly large amount of memory.
> + *
> + * Dynamic sizing based on the actual runtime vector length is likely to
> + * be preferable for most purposes.
> + */
>  #define __SVE_VQ_MIN		1
>  #define __SVE_VQ_MAX		512

Acked-by: Dave Martin <Dave.Martin@arm.com>

[...]

