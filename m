Return-Path: <linux-kernel+bounces-135044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B58189BA57
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC0011C21E9D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4B338FA0;
	Mon,  8 Apr 2024 08:31:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C517941A80
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712565103; cv=none; b=FewfCQTH0dyrnpRmM+EODTDQTOIuUCri5QXHnAmM/7a8Ck6AhCn3wfuyUW85PGbUeb11YPSVfZRybRmDSRR5Y4c/y/v4e60jXzcYFp1/sLMzCX1UB0OrHXnxiW7iaOxaKLewSWqtRgHkrwb97fx/gVr5dMgb4sSW6iqLiTo3Em8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712565103; c=relaxed/simple;
	bh=cHVXQgWWYQikdi7cXresunZR0HbsRYAMbamgl+6vPTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AXrylmDhBuzlXzIk18vzdYWKpD7u7JbI1zodkfcMQF8G847A/rnnHXbvOyGfe8s2buMm07l9ipNszJHGsTrejRdlS+wPik7wOaSoP2nWR6yplkDMQfDOCoa46M6XRDdrPRYmGyxdkaJZ9zz5G1GcFJeFuWLBcxocr7EhQJT72cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E77B12FC;
	Mon,  8 Apr 2024 01:32:10 -0700 (PDT)
Received: from [10.57.73.169] (unknown [10.57.73.169])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE95E3F766;
	Mon,  8 Apr 2024 01:31:37 -0700 (PDT)
Message-ID: <7766689e-a473-475d-8bf6-c1d7435881c9@arm.com>
Date: Mon, 8 Apr 2024 09:31:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] arm64: tlb: Improve __TLBI_VADDR_RANGE()
Content-Language: en-GB
To: Gavin Shan <gshan@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org,
 maz@kernel.org, oliver.upton@linux.dev, apopple@nvidia.com,
 rananta@google.com, mark.rutland@arm.com, v-songbaohua@oppo.com,
 yangyicong@hisilicon.com, shahuang@redhat.com, yihyu@redhat.com,
 shan.gavin@gmail.com
References: <20240405035852.1532010-1-gshan@redhat.com>
 <20240405035852.1532010-3-gshan@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240405035852.1532010-3-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/04/2024 04:58, Gavin Shan wrote:
> The macro returns the operand of TLBI RANGE instruction. A mask needs
> to be applied to each individual field upon producing the operand, to
> avoid the adjacent fields can interfere with each other when invalid
> arguments have been provided. The code looks more tidy at least with
> a mask and FIELD_PREP().
> 
> Suggested-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Gavin Shan <gshan@redhat.com>

LGTM!

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  arch/arm64/include/asm/tlbflush.h | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index a75de2665d84..243d71f7bc1f 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -142,17 +142,24 @@ static inline unsigned long get_trans_granule(void)
>   * EL1, Inner Shareable".
>   *
>   */
> -#define __TLBI_VADDR_RANGE(baddr, asid, scale, num, ttl)			\
> -	({									\
> -		unsigned long __ta = (baddr);					\
> -		unsigned long __ttl = (ttl >= 1 && ttl <= 3) ? ttl : 0;		\
> -		__ta &= GENMASK_ULL(36, 0);					\
> -		__ta |= __ttl << 37;						\
> -		__ta |= (unsigned long)(num) << 39;				\
> -		__ta |= (unsigned long)(scale) << 44;				\
> -		__ta |= get_trans_granule() << 46;				\
> -		__ta |= (unsigned long)(asid) << 48;				\
> -		__ta;								\
> +#define TLBIR_ASID_MASK		GENMASK_ULL(63, 48)
> +#define TLBIR_TG_MASK		GENMASK_ULL(47, 46)
> +#define TLBIR_SCALE_MASK	GENMASK_ULL(45, 44)
> +#define TLBIR_NUM_MASK		GENMASK_ULL(43, 39)
> +#define TLBIR_TTL_MASK		GENMASK_ULL(38, 37)
> +#define TLBIR_BADDR_MASK	GENMASK_ULL(36,  0)
> +
> +#define __TLBI_VADDR_RANGE(baddr, asid, scale, num, ttl)		\
> +	({								\
> +		unsigned long __ta = 0;					\
> +		unsigned long __ttl = (ttl >= 1 && ttl <= 3) ? ttl : 0;	\
> +		__ta |= FIELD_PREP(TLBIR_BADDR_MASK, baddr);		\
> +		__ta |= FIELD_PREP(TLBIR_TTL_MASK, __ttl);		\
> +		__ta |= FIELD_PREP(TLBIR_NUM_MASK, num);		\
> +		__ta |= FIELD_PREP(TLBIR_SCALE_MASK, scale);		\
> +		__ta |= FIELD_PREP(TLBIR_TG_MASK, get_trans_granule());	\
> +		__ta |= FIELD_PREP(TLBIR_ASID_MASK, asid);		\
> +		__ta;							\
>  	})
>  
>  /* These macros are used by the TLBI RANGE feature. */


