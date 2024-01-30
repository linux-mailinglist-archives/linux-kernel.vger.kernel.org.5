Return-Path: <linux-kernel+bounces-44620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEDD84252A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61C471C2226E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6506A32B;
	Tue, 30 Jan 2024 12:40:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC466A028;
	Tue, 30 Jan 2024 12:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618422; cv=none; b=Lybnd6d/YW/rCpF0EhzQCsr67GtTXuljPEmNEAAGQYGCF9JIS9QTBcE6+ExE5dkI2YcULNv89deGrN292ipu9cHoYaG2OFncxmQpSnHFlEh1CVHEn1Dx0MNl89dYhqNfxt/oq1lf6ZQzMsHx4bnmzcc/fzg44nI/0+L1DEqGfTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618422; c=relaxed/simple;
	bh=+x2GutARnczCwp8oHhn8Qn8q8WfRfeqIQxjDzAXlzfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MEIWnJweYPuOmA9CUCL163C5b1SJILFzGvYOHxeOof74KjZR5lIJtq0xJmewjBp/6buurFARK3wSovarq2y7OxXrtflfJbvvAvnWZFwhrcjuVVX30k4jPXpuTXkqmQPwZ0P1PDYl+//86Yhdfa6bWHN+ZjVvxhx1ToV47D8BCZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88463DA7;
	Tue, 30 Jan 2024 04:41:02 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2EEF3F762;
	Tue, 30 Jan 2024 04:40:13 -0800 (PST)
Message-ID: <69ff07d9-85e2-4cef-8db5-612287ee1638@arm.com>
Date: Tue, 30 Jan 2024 12:40:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/10] coresight-tpdm: Add pattern registers support
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
References: <1706605366-31705-1-git-send-email-quic_taozha@quicinc.com>
 <1706605366-31705-8-git-send-email-quic_taozha@quicinc.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1706605366-31705-8-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/01/2024 09:02, Tao Zhang wrote:
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
> Reviewed-by: James Clark <james.clark@arm.com>
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Jinlong Mao <quic_jinlmao@quicinc.com>
> ---
>   .../testing/sysfs-bus-coresight-devices-tpdm  | 30 ++++++
>   drivers/hwtracing/coresight/coresight-tpdm.c  | 96 ++++++++++++++++++-
>   drivers/hwtracing/coresight/coresight-tpdm.h  | 39 ++++++++
>   3 files changed, 164 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> index 6dfb18d6d64a..b6cf050861ed 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> @@ -184,3 +184,33 @@ Description:	(Write) Set the data collection mode of CMB tpdm. Continuous
>   		Accepts only one of the 2 values -  0 or 1.
>   		0 : Continuous CMB collection mode.
>   		1 : Trace-on-change CMB collection mode.
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/cmb_trig_patt/xpr[0:1]
> +Date:		January 2024
> +KernelVersion	6.9
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		(RW) Set/Get the value of the trigger pattern for the CMB
> +		subunit TPDM.
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/cmb_trig_patt/xpmr[0:1]
> +Date:		January 2024
> +KernelVersion	6.9
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		(RW) Set/Get the mask of the trigger pattern for the CMB
> +		subunit TPDM.
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_patt/tpr[0:1]
> +Date:		January 2024
> +KernelVersion	6.9
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		(RW) Set/Get the value of the pattern for the CMB subunit TPDM.
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_patt/tpmr[0:1]
> +Date:		January 2024
> +KernelVersion	6.9
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		(RW) Set/Get the mask of the pattern for the CMB subunit TPDM.
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index b20071460375..07587287d9fa 100644
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
> @@ -280,12 +324,32 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>   
>   static void tpdm_enable_cmb(struct tpdm_drvdata *drvdata)
>   {
> -	u32 val;
> +	u32 val, i;
>   
>   	if (!tpdm_has_cmb_dataset(drvdata))
>   		return;
>   
> +	/* Configure pattern registers */
> +	for (i = 0; i < TPDM_CMB_MAX_PATT; i++) {
> +		writel_relaxed(drvdata->cmb->patt_val[i],
> +			drvdata->base + TPDM_CMB_TPR(i));
> +		writel_relaxed(drvdata->cmb->patt_mask[i],
> +			drvdata->base + TPDM_CMB_TPMR(i));
> +		writel_relaxed(drvdata->cmb->trig_patt[i],
> +			drvdata->base + TPDM_CMB_XPR(i));
> +		writel_relaxed(drvdata->cmb->trig_patt_mask[i],
> +			drvdata->base + TPDM_CMB_XPMR(i));
> +	}
> +
>   	val = readl_relaxed(drvdata->base + TPDM_CMB_CR);
> +	/*
> +	 * Set to 0 for continuous CMB collection mode,
> +	 * 1 for trace-on-change CMB collection mode.
> +	 */
> +	if (drvdata->cmb->trace_mode)
> +		val |= TPDM_CMB_CR_MODE;
> +	else
> +		val &= ~TPDM_CMB_CR_MODE;
>   	/* Set the enable bit of CMB control register to 1 */
>   	val |= TPDM_CMB_CR_ENA;
>   	writel_relaxed(val, drvdata->base + TPDM_CMB_CR);
> @@ -887,6 +951,22 @@ static struct attribute *tpdm_dsb_msr_attrs[] = {
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
> @@ -933,6 +1013,18 @@ static struct attribute_group tpdm_cmb_attr_grp = {
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
> @@ -941,6 +1033,8 @@ static const struct attribute_group *tpdm_attr_grps[] = {
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

minor nit: Leave a space after/before '/*' & '*/'

Suzuki



