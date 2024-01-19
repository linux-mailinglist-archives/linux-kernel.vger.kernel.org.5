Return-Path: <linux-kernel+bounces-31121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30FE83294E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E96286E51
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E964F1F4;
	Fri, 19 Jan 2024 11:58:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BE524B5E;
	Fri, 19 Jan 2024 11:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705665508; cv=none; b=thqRwpgIJposqS6p81sGoAaxE4+9vW46wLoC/ipdlCezjBLDKvbgIDRKNFjsf7Qx4/IWiaT1R01bIsCijCR4zlX/BlybYejaLNWVHEiit7hmBvEFG8hYwsOCPMmFri1hNyR+GsfJKteDNENWemBbG9fViAe3+j3FiHJ7MQOx+bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705665508; c=relaxed/simple;
	bh=yXwiRAsMr8h7baj7xy5yFVaOTTD+HkQfavgGqVB2GXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b4bpdEhYxP3DeHrC4EGGvGDaUDB1hTyq30kF3pTacPaODBEmiNp6twBiqlbkTxWUrq5QB/PLNJ4JFjpJs2uyCJ9eGn+ttlPyXcoy0ttgVryfuH+prXKFDL3n4yB7ZELtZb+EnNjoCRY4q2TunibtDHR6Qhpw+zveI1/6Bcw0qQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC70E1042;
	Fri, 19 Jan 2024 03:59:09 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15A8E3F73F;
	Fri, 19 Jan 2024 03:58:19 -0800 (PST)
Message-ID: <7831e83e-9c26-412a-b78a-ed58ee02c5b1@arm.com>
Date: Fri, 19 Jan 2024 11:58:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/10] coresight-tpdm: Add pattern registers support
 for CMB
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
 <1705634583-17631-8-git-send-email-quic_taozha@quicinc.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1705634583-17631-8-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/01/2024 03:23, Tao Zhang wrote:
> Timestamps are requested if the monitor’s CMB data set unit input
> data matches the value in the Monitor CMB timestamp pattern and mask
> registers (M_CMB_TPR and M_CMB_TPMR) when CMB timestamp enabled
> via the timestamp insertion enable register bit(CMB_TIER.PATT_TSENAB).
> The pattern match trigger output is achieved via setting values into
> the CMB trigger pattern and mask registers (CMB_XPR and CMB_XPMR).
> After configuring a pattern through these registers, the TPDM subunit
> will assert an output trigger every time it receives new input data
> that matches the configured pattern value. Values in a given bit
> number of the mask register correspond to the same bit number in
> the corresponding pattern register.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>   .../testing/sysfs-bus-coresight-devices-tpdm  | 30 ++++++
>   drivers/hwtracing/coresight/coresight-tpdm.c  | 98 ++++++++++++++++++-
>   drivers/hwtracing/coresight/coresight-tpdm.h  | 39 ++++++++
>   3 files changed, 166 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> index 3ae21ccf3f29..898aee81e20d 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> @@ -184,3 +184,33 @@ Description:	(Write) Set the data collection mode of CMB tpdm. Continuous
>   		Accepts only one of the 2 values -  0 or 1.
>   		0 : Continuous CMB collection mode.
>   		1 : Trace-on-change CMB collection mode.
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/cmb_trig_patt/xpr[0:1]
> +Date:		March 2023
> +KernelVersion	6.7

This must be fixed to 6.9 now and also move the year to 2024. Rest looks 
fine.

Suzuki

> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		(RW) Set/Get the value of the trigger pattern for the CMB
> +		subunit TPDM.
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/cmb_trig_patt/xpmr[0:1]
> +Date:		March 2023
> +KernelVersion	6.7
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		(RW) Set/Get the mask of the trigger pattern for the CMB
> +		subunit TPDM.
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_patt/tpr[0:1]
> +Date:		March 2023
> +KernelVersion	6.7
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		(RW) Set/Get the value of the pattern for the CMB subunit TPDM.
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_patt/tpmr[0:1]
> +Date:		March 2023
> +KernelVersion	6.7
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		(RW) Set/Get the mask of the pattern for the CMB subunit TPDM.
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index b55aee65a856..079c875ad667 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -66,6 +66,26 @@ static ssize_t tpdm_simple_dataset_show(struct device *dev,
>   			return -EINVAL;
>   		return sysfs_emit(buf, "0x%x\n",
>   				drvdata->dsb->msr[tpdm_attr->idx]);
> +	case CMB_TRIG_PATT:
> +		if (tpdm_attr->idx >= TPDM_CMB_MAX_PATT)
> +			return -EINVAL;
> +		return sysfs_emit(buf, "0x%x\n",
> +			drvdata->cmb->trig_patt[tpdm_attr->idx]);
> +	case CMB_TRIG_PATT_MASK:
> +		if (tpdm_attr->idx >= TPDM_CMB_MAX_PATT)
> +			return -EINVAL;
> +		return sysfs_emit(buf, "0x%x\n",
> +			drvdata->cmb->trig_patt_mask[tpdm_attr->idx]);
> +	case CMB_PATT:
> +		if (tpdm_attr->idx >= TPDM_CMB_MAX_PATT)
> +			return -EINVAL;
> +		return sysfs_emit(buf, "0x%x\n",
> +			drvdata->cmb->patt_val[tpdm_attr->idx]);
> +	case CMB_PATT_MASK:
> +		if (tpdm_attr->idx >= TPDM_CMB_MAX_PATT)
> +			return -EINVAL;
> +		return sysfs_emit(buf, "0x%x\n",
> +			drvdata->cmb->patt_mask[tpdm_attr->idx]);
>   	}
>   	return -EINVAL;
>   }
> @@ -118,6 +138,30 @@ static ssize_t tpdm_simple_dataset_store(struct device *dev,
>   			ret = size;
>   		}
>   		break;
> +	case CMB_TRIG_PATT:
> +		if (tpdm_attr->idx < TPDM_CMB_MAX_PATT) {
> +			drvdata->cmb->trig_patt[tpdm_attr->idx] = val;
> +			ret = size;
> +		}
> +		break;
> +	case CMB_TRIG_PATT_MASK:
> +		if (tpdm_attr->idx < TPDM_CMB_MAX_PATT) {
> +			drvdata->cmb->trig_patt_mask[tpdm_attr->idx] = val;
> +			ret = size;
> +		}
> +		break;
> +	case CMB_PATT:
> +		if (tpdm_attr->idx < TPDM_CMB_MAX_PATT) {
> +			drvdata->cmb->patt_val[tpdm_attr->idx] = val;
> +			ret = size;
> +		}
> +		break;
> +	case CMB_PATT_MASK:
> +		if (tpdm_attr->idx < TPDM_CMB_MAX_PATT) {
> +			drvdata->cmb->patt_mask[tpdm_attr->idx] = val;
> +			ret = size;
> +		}
> +		break;
>   	default:
>   		break;
>   	}
> @@ -279,10 +323,32 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>   
>   static void tpdm_enable_cmb(struct tpdm_drvdata *drvdata)
>   {
> -	u32 val;
> +	u32 val, i;
>   
>   	if (tpdm_has_cmb_dataset(drvdata)) {
> +		/* Configure pattern registers */
> +		for (i = 0; i < TPDM_CMB_MAX_PATT; i++) {
> +			writel_relaxed(drvdata->cmb->patt_val[i],
> +				drvdata->base + TPDM_CMB_TPR(i));
> +			writel_relaxed(drvdata->cmb->patt_mask[i],
> +				drvdata->base + TPDM_CMB_TPMR(i));
> +			writel_relaxed(drvdata->cmb->trig_patt[i],
> +				drvdata->base + TPDM_CMB_XPR(i));
> +			writel_relaxed(drvdata->cmb->trig_patt_mask[i],
> +				drvdata->base + TPDM_CMB_XPMR(i));
> +		}
> +
>   		val = readl_relaxed(drvdata->base + TPDM_CMB_CR);
> +		/*
> +		 * Set to 0 for continuous CMB collection mode,
> +		 * 1 for trace-on-change CMB collection mode.
> +		 */
> +		if (drvdata->cmb->trace_mode)
> +			val |= TPDM_CMB_CR_MODE;
> +		else
> +			val &= ~TPDM_CMB_CR_MODE;
> +
> +		/* Set the enable bit of CMB control register to 1 */
>   		val |= TPDM_CMB_CR_ENA;
>   
>   		/* Set the enable bit of CMB control register to 1 */
> @@ -886,6 +952,22 @@ static struct attribute *tpdm_dsb_msr_attrs[] = {
>   	NULL,
>   };
>   
> +static struct attribute *tpdm_cmb_trig_patt_attrs[] = {
> +	CMB_TRIG_PATT_ATTR(0),
> +	CMB_TRIG_PATT_ATTR(1),
> +	CMB_TRIG_PATT_MASK_ATTR(0),
> +	CMB_TRIG_PATT_MASK_ATTR(1),
> +	NULL,
> +};
> +
> +static struct attribute *tpdm_cmb_patt_attrs[] = {
> +	CMB_PATT_ATTR(0),
> +	CMB_PATT_ATTR(1),
> +	CMB_PATT_MASK_ATTR(0),
> +	CMB_PATT_MASK_ATTR(1),
> +	NULL,
> +};
> +
>   static struct attribute *tpdm_dsb_attrs[] = {
>   	&dev_attr_dsb_mode.attr,
>   	&dev_attr_dsb_trig_ts.attr,
> @@ -932,6 +1014,18 @@ static struct attribute_group tpdm_cmb_attr_grp = {
>   	.is_visible = tpdm_cmb_is_visible,
>   };
>   
> +static struct attribute_group tpdm_cmb_trig_patt_grp = {
> +	.attrs = tpdm_cmb_trig_patt_attrs,
> +	.is_visible = tpdm_cmb_is_visible,
> +	.name = "cmb_trig_patt",
> +};
> +
> +static struct attribute_group tpdm_cmb_patt_grp = {
> +	.attrs = tpdm_cmb_patt_attrs,
> +	.is_visible = tpdm_cmb_is_visible,
> +	.name = "cmb_patt",
> +};
> +
>   static const struct attribute_group *tpdm_attr_grps[] = {
>   	&tpdm_attr_grp,
>   	&tpdm_dsb_attr_grp,
> @@ -940,6 +1034,8 @@ static const struct attribute_group *tpdm_attr_grps[] = {
>   	&tpdm_dsb_patt_grp,
>   	&tpdm_dsb_msr_grp,
>   	&tpdm_cmb_attr_grp,
> +	&tpdm_cmb_trig_patt_grp,
> +	&tpdm_cmb_patt_grp,
>   	NULL,
>   };
>   
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
> index 2af92c270ed1..8cb8a9b35384 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
> @@ -11,12 +11,23 @@
>   
>   /* CMB Subunit Registers */
>   #define TPDM_CMB_CR		(0xA00)
> +/*CMB subunit timestamp pattern registers*/
> +#define TPDM_CMB_TPR(n)		(0xA08 + (n * 4))
> +/*CMB subunit timestamp pattern mask registers*/
> +#define TPDM_CMB_TPMR(n)	(0xA10 + (n * 4))
> +/*CMB subunit trigger pattern registers*/
> +#define TPDM_CMB_XPR(n)		(0xA18 + (n * 4))
> +/*CMB subunit trigger pattern mask registers*/
> +#define TPDM_CMB_XPMR(n)	(0xA20 + (n * 4))
>   
>   /* Enable bit for CMB subunit */
>   #define TPDM_CMB_CR_ENA		BIT(0)
>   /* Trace collection mode for CMB subunit */
>   #define TPDM_CMB_CR_MODE	BIT(1)
>   
> +/*Patten register number*/
> +#define TPDM_CMB_MAX_PATT		2
> +
>   /* DSB Subunit Registers */
>   #define TPDM_DSB_CR		(0x780)
>   #define TPDM_DSB_TIER		(0x784)
> @@ -151,6 +162,22 @@
>   		tpdm_simple_dataset_rw(msr##nr,			\
>   		DSB_MSR, nr)
>   
> +#define CMB_TRIG_PATT_ATTR(nr)					\
> +		tpdm_simple_dataset_rw(xpr##nr,			\
> +		CMB_TRIG_PATT, nr)
> +
> +#define CMB_TRIG_PATT_MASK_ATTR(nr)				\
> +		tpdm_simple_dataset_rw(xpmr##nr,		\
> +		CMB_TRIG_PATT_MASK, nr)
> +
> +#define CMB_PATT_ATTR(nr)					\
> +		tpdm_simple_dataset_rw(tpr##nr,			\
> +		CMB_PATT, nr)
> +
> +#define CMB_PATT_MASK_ATTR(nr)					\
> +		tpdm_simple_dataset_rw(tpmr##nr,		\
> +		CMB_PATT_MASK, nr)
> +
>   /**
>    * struct dsb_dataset - specifics associated to dsb dataset
>    * @mode:             DSB programming mode
> @@ -186,9 +213,17 @@ struct dsb_dataset {
>   /**
>    * struct cmb_dataset
>    * @trace_mode:       Dataset collection mode
> + * @patt_val:         Save value for pattern
> + * @patt_mask:        Save value for pattern mask
> + * @trig_patt:        Save value for trigger pattern
> + * @trig_patt_mask:   Save value for trigger pattern mask
>    */
>   struct cmb_dataset {
>   	u32			trace_mode;
> +	u32			patt_val[TPDM_CMB_MAX_PATT];
> +	u32			patt_mask[TPDM_CMB_MAX_PATT];
> +	u32			trig_patt[TPDM_CMB_MAX_PATT];
> +	u32			trig_patt_mask[TPDM_CMB_MAX_PATT];
>   };
>   
>   /**
> @@ -225,6 +260,10 @@ enum dataset_mem {
>   	DSB_PATT,
>   	DSB_PATT_MASK,
>   	DSB_MSR,
> +	CMB_TRIG_PATT,
> +	CMB_TRIG_PATT_MASK,
> +	CMB_PATT,
> +	CMB_PATT_MASK
>   };
>   
>   /**


