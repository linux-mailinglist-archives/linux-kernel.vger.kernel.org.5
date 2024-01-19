Return-Path: <linux-kernel+bounces-31105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F538328E8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74A0F1F21512
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD0B4EB4E;
	Fri, 19 Jan 2024 11:36:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0574F89D;
	Fri, 19 Jan 2024 11:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705664161; cv=none; b=OE/RjDiziK/HgXDONaUoC/1AZ5z9EMpdy/83QXap5ZrGiRBoTBrlBvrqJIHha9WUgkJ4PH/736WwuuJwSStEfeDBJJfaESNQ2gv9VpM7nLtN2zS18z9veQL2qN6TcKKFpeacf6oWCN1Ap0mKp+l/KoXjAt/vvee8qMp6sGJOA/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705664161; c=relaxed/simple;
	bh=AD/Bv/GbiHi4oggZkUxGXy6r3y/xcMRYEqX9cQzZ0NM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=slARWX8hVTSY7DcqmsXcB+CiBBkB7yROAUUHfqsSTzDuSXGOk95VmnOAa2BdjTCdGbPwtdhEIdhwyneg2iAe1EvMA/ADVW7zdAQ5mgfiLs5SirJ5rZLDzL0nNBauEZXPM7uSBgwOwvHwQYMKgEk7PFb7yZJUPO8lMRE6VnXoRFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AA871042;
	Fri, 19 Jan 2024 03:36:41 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 901AA3F5A1;
	Fri, 19 Jan 2024 03:35:50 -0800 (PST)
Message-ID: <3cd64a92-594d-483e-b134-a45f57d318f6@arm.com>
Date: Fri, 19 Jan 2024 11:35:48 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] coresight-tpdm: Optimize the useage of
 tpdm_has_dsb_dataset
Content-Language: en-US
To: Tao Zhang <quic_taozha@quicinc.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Konrad Dybcio <konradybcio@gmail.com>, Mike Leach <mike.leach@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Jinlong Mao <quic_jinlmao@quicinc.com>, Leo Yan <leo.yan@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Tingwei Zhang <quic_tingweiz@quicinc.com>,
 Yuanfang Zhang <quic_yuanfang@quicinc.com>,
 Trilok Soni <quic_tsoni@quicinc.com>, Song Chai <quic_songchai@quicinc.com>,
 linux-arm-msm@vger.kernel.org, andersson@kernel.org
References: <1705634583-17631-1-git-send-email-quic_taozha@quicinc.com>
 <1705634583-17631-3-git-send-email-quic_taozha@quicinc.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1705634583-17631-3-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/01/2024 03:22, Tao Zhang wrote:
> Since the function tpdm_has_dsb_dataset will be called by TPDA
> driver in subsequent patches, it is moved to the header file.
> And move this judgement form the function __tpdm_{enable/disable}
> to the beginning of the function tpdm_{enable/disable}_dsb.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>   drivers/hwtracing/coresight/coresight-tpdm.c | 82 ++++++++++----------
>   drivers/hwtracing/coresight/coresight-tpdm.h |  4 +
>   2 files changed, 43 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index 0427c0fc0bf3..6549f71ba150 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -125,11 +125,6 @@ static ssize_t tpdm_simple_dataset_store(struct device *dev,
>   	return ret;
>   }
>   
> -static bool tpdm_has_dsb_dataset(struct tpdm_drvdata *drvdata)
> -{
> -	return (drvdata->datasets & TPDM_PIDR0_DS_DSB);
> -}
> -
>   static umode_t tpdm_dsb_is_visible(struct kobject *kobj,
>   				   struct attribute *attr, int n)
>   {
> @@ -232,38 +227,39 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>   {
>   	u32 val, i;
>   
> -	for (i = 0; i < TPDM_DSB_MAX_EDCR; i++)
> -		writel_relaxed(drvdata->dsb->edge_ctrl[i],
> -			   drvdata->base + TPDM_DSB_EDCR(i));
> -	for (i = 0; i < TPDM_DSB_MAX_EDCMR; i++)
> -		writel_relaxed(drvdata->dsb->edge_ctrl_mask[i],
> -			   drvdata->base + TPDM_DSB_EDCMR(i));
> -	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
> -		writel_relaxed(drvdata->dsb->patt_val[i],
> -			   drvdata->base + TPDM_DSB_TPR(i));
> -		writel_relaxed(drvdata->dsb->patt_mask[i],
> -			   drvdata->base + TPDM_DSB_TPMR(i));
> -		writel_relaxed(drvdata->dsb->trig_patt[i],
> -			   drvdata->base + TPDM_DSB_XPR(i));
> -		writel_relaxed(drvdata->dsb->trig_patt_mask[i],
> -			   drvdata->base + TPDM_DSB_XPMR(i));
> -	}
> -
> -	set_dsb_tier(drvdata);
> +	if (tpdm_has_dsb_dataset(drvdata)) {

Minor nit: If you do :

	if (!tpdm_has_dsb_dataset(drvdata))
		return;

You don't need any of these additional churns of moving them.

> +		for (i = 0; i < TPDM_DSB_MAX_EDCR; i++)
> +			writel_relaxed(drvdata->dsb->edge_ctrl[i],
> +				       drvdata->base + TPDM_DSB_EDCR(i));
> +		for (i = 0; i < TPDM_DSB_MAX_EDCMR; i++)
> +			writel_relaxed(drvdata->dsb->edge_ctrl_mask[i],
> +				       drvdata->base + TPDM_DSB_EDCMR(i));
> +		for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
> +			writel_relaxed(drvdata->dsb->patt_val[i],
> +				       drvdata->base + TPDM_DSB_TPR(i));
> +			writel_relaxed(drvdata->dsb->patt_mask[i],
> +				       drvdata->base + TPDM_DSB_TPMR(i));
> +			writel_relaxed(drvdata->dsb->trig_patt[i],
> +				       drvdata->base + TPDM_DSB_XPR(i));
> +			writel_relaxed(drvdata->dsb->trig_patt_mask[i],
> +				       drvdata->base + TPDM_DSB_XPMR(i));
> +		}
>   
> -	set_dsb_msr(drvdata);
> +		set_dsb_tier(drvdata);
> +		set_dsb_msr(drvdata);
>   
> -	val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
> -	/* Set the mode of DSB dataset */
> -	set_dsb_mode(drvdata, &val);
> -	/* Set trigger type */
> -	if (drvdata->dsb->trig_type)
> -		val |= TPDM_DSB_CR_TRIG_TYPE;
> -	else
> -		val &= ~TPDM_DSB_CR_TRIG_TYPE;
> -	/* Set the enable bit of DSB control register to 1 */
> -	val |= TPDM_DSB_CR_ENA;
> -	writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
> +		val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
> +		/* Set the mode of DSB dataset */
> +		set_dsb_mode(drvdata, &val);
> +		/* Set trigger type */
> +		if (drvdata->dsb->trig_type)
> +			val |= TPDM_DSB_CR_TRIG_TYPE;
> +		else
> +			val &= ~TPDM_DSB_CR_TRIG_TYPE;
> +		/* Set the enable bit of DSB control register to 1 */
> +		val |= TPDM_DSB_CR_ENA;
> +		writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
> +	}
>   }
>   
>   /*
> @@ -278,8 +274,7 @@ static void __tpdm_enable(struct tpdm_drvdata *drvdata)
>   {
>   	CS_UNLOCK(drvdata->base);
>   
> -	if (tpdm_has_dsb_dataset(drvdata))
> -		tpdm_enable_dsb(drvdata);
> +	tpdm_enable_dsb(drvdata);
>   
>   	CS_LOCK(drvdata->base);
>   }
> @@ -307,10 +302,12 @@ static void tpdm_disable_dsb(struct tpdm_drvdata *drvdata)
>   {
>   	u32 val;
>   
> -	/* Set the enable bit of DSB control register to 0 */
> -	val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
> -	val &= ~TPDM_DSB_CR_ENA;
> -	writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
> +	if (tpdm_has_dsb_dataset(drvdata)) {
> +		/* Set the enable bit of DSB control register to 0 */
> +		val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
> +		val &= ~TPDM_DSB_CR_ENA;
> +		writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
> +	}

Same suggestion as above:

	if (!tpdm_has...)
		return;


>   }
>   
>   /* TPDM disable operations */
> @@ -318,8 +315,7 @@ static void __tpdm_disable(struct tpdm_drvdata *drvdata)
>   {
>   	CS_UNLOCK(drvdata->base);
>   
> -	if (tpdm_has_dsb_dataset(drvdata))
> -		tpdm_disable_dsb(drvdata);
> +	tpdm_disable_dsb(drvdata);
>   
>   	CS_LOCK(drvdata->base);
>   }
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
> index 4115b2a17b8d..ddaf333fa1c2 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
> @@ -220,4 +220,8 @@ struct tpdm_dataset_attribute {
>   	u32 idx;
>   };
>   
> +static bool tpdm_has_dsb_dataset(struct tpdm_drvdata *drvdata)
> +{
> +	return (drvdata->datasets & TPDM_PIDR0_DS_DSB);
> +}
>   #endif  /* _CORESIGHT_CORESIGHT_TPDM_H */


Suzuki

