Return-Path: <linux-kernel+bounces-132835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 861A9899AF4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25C081F218FE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E90745C2;
	Fri,  5 Apr 2024 10:33:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A146BFDE
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 10:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712313237; cv=none; b=oitKzRNsn1RyhDegj73yCxEVvLHU/bKeFGmav39lgErjZ/l4tl8Upl2buDXkyAmWfClOnwQ2Q3geUn1tx5Lh7GC7elre5E0vQCGUSv1XMf65203PwLxBFEfJptfcQHlneHF5O5F5V2tsvAmHqAFzyrgmj8UjU9aZ7kWieoLHFcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712313237; c=relaxed/simple;
	bh=p7ZAvO/qd0UYRWTBD+/oZAmMWVhCUySh9wsYtGRad0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=atF7QxeYmCaOZh9VsfLgyqpcY8hUccUdCKUzQaP7w2ffnc+kNhLFR/ZDE1Knjsz+JgMUdYzhGfncbyb1Uvd1iFCnt736gxgqcDMvdq9LNW11qtdYRewvBhTy/+JkMMJAqL46sT40YPtXKiQMYKvMOBshY8MTTJmYr81mXvtA85s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4E54FEC;
	Fri,  5 Apr 2024 03:34:24 -0700 (PDT)
Received: from [10.57.54.111] (unknown [10.57.54.111])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6D873F64C;
	Fri,  5 Apr 2024 03:33:52 -0700 (PDT)
Message-ID: <042bbb32-481e-40d8-a46a-472b724ec33f@arm.com>
Date: Fri, 5 Apr 2024 11:33:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: arm_cspmu: Don't touch interrupt registers if no
 interrupt was assigned
Content-Language: en-GB
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
 Besar Wicaksono <bwicaksono@nvidia.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Raag Jadav <raag.jadav@intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240307193104.58302-1-ilkka@os.amperecomputing.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240307193104.58302-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-07 7:31 pm, Ilkka Koskinen wrote:
> The driver enabled and disabled interrupts even if no interrupt was
> assigned to the device.

Why's that a concern - if the interrupt isn't routed anywhere, surely it 
makes no difference what happens at the source end?

Thanks,
Robin.

> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>   drivers/perf/arm_cspmu/arm_cspmu.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index 50b89b989ce7..2cbdb5dcb6ff 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -795,7 +795,8 @@ static void arm_cspmu_enable_counter(struct arm_cspmu *cspmu, int idx)
>   	inten_off = PMINTENSET + (4 * reg_id);
>   	cnten_off = PMCNTENSET + (4 * reg_id);
>   
> -	writel(BIT(reg_bit), cspmu->base0 + inten_off);
> +	if (cspmu->irq)
> +		writel(BIT(reg_bit), cspmu->base0 + inten_off);
>   	writel(BIT(reg_bit), cspmu->base0 + cnten_off);
>   }
>   
> @@ -810,7 +811,8 @@ static void arm_cspmu_disable_counter(struct arm_cspmu *cspmu, int idx)
>   	cnten_off = PMCNTENCLR + (4 * reg_id);
>   
>   	writel(BIT(reg_bit), cspmu->base0 + cnten_off);
> -	writel(BIT(reg_bit), cspmu->base0 + inten_off);
> +	if (cspmu->irq)
> +		writel(BIT(reg_bit), cspmu->base0 + inten_off);
>   }
>   
>   static void arm_cspmu_event_update(struct perf_event *event)

