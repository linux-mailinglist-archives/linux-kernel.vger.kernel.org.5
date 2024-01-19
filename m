Return-Path: <linux-kernel+bounces-31111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19250832928
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8042860EC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8343E4EB58;
	Fri, 19 Jan 2024 11:47:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C2F4C600;
	Fri, 19 Jan 2024 11:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705664831; cv=none; b=mhCfVtkLy0axSWd/oneEBbwwX8uRtWpnSkbgRTGResUWf2FPMlfJ//0vQUP5gQx1H2ZcEqj6eZLHwdz5uUIvF+9mNvaRFvFJOrEOEDq+kePoBKtEw113iG6kpNEnNtexfpiqqkkmLml2dPNqosc1fCqldzI115vTvqOHwgD0UxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705664831; c=relaxed/simple;
	bh=JIWIUdcAdMllC44xvZZTQGPLVyOETGznBc1v65Aq44A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V97qv+L0Vs/6CsJD4zh03EORi9sU86LEf3CxSq3JgzI0lE+5YYB4vYzxygOJQ097EOuoxUx1g1yyt2UFpwsbi/hhtfs3RyLgRO6TVU0Z68Rfbc29nRdS7JTEs+sM78rtQktzPyNsYNPm9PaxB3ytq45PgClDX6pzsv9koR1FupE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D02611042;
	Fri, 19 Jan 2024 03:47:52 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F8103F5A1;
	Fri, 19 Jan 2024 03:47:01 -0800 (PST)
Message-ID: <78b998a4-1760-4442-8b49-3aa07271785e@arm.com>
Date: Fri, 19 Jan 2024 11:47:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/10] coresight-tpda: Add support to configure CMB
 element
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
 <1705634583-17631-6-git-send-email-quic_taozha@quicinc.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1705634583-17631-6-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/01/2024 03:22, Tao Zhang wrote:
> Read the CMB element size from the device tree. Set the register
> bit that controls the CMB element size of the corresponding port.
> 
> Reviewed-by: James Clark <james.clark@arm.com>
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>   drivers/hwtracing/coresight/coresight-tpda.c | 123 +++++++++++--------
>   drivers/hwtracing/coresight/coresight-tpda.h |   6 +
>   2 files changed, 79 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
> index 4ac954f4bc13..987a69428c93 100644
> --- a/drivers/hwtracing/coresight/coresight-tpda.c
> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
> @@ -18,6 +18,7 @@
>   #include "coresight-priv.h"
>   #include "coresight-tpda.h"
>   #include "coresight-trace-id.h"
> +#include "coresight-tpdm.h"
>   
>   DEFINE_CORESIGHT_DEVLIST(tpda_devs, "tpda");
>   
> @@ -28,24 +29,57 @@ static bool coresight_device_is_tpdm(struct coresight_device *csdev)
>   			CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM);
>   }
>   
> +static void tpdm_clear_element_size(struct coresight_device *csdev)
> +{
> +	struct tpda_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +	drvdata->dsb_esize = 0;
> +	drvdata->cmb_esize = 0;
> +}
> +
> +static void tpda_set_element_size(struct tpda_drvdata *drvdata, u32 *val)
> +{
> +
> +	if (drvdata->dsb_esize == 64)
> +		*val |= TPDA_Pn_CR_DSBSIZE;
> +	else if (drvdata->dsb_esize == 32)
> +		*val &= ~TPDA_Pn_CR_DSBSIZE;
> +
> +	if (drvdata->cmb_esize == 64)
> +		*val |= FIELD_PREP(TPDA_Pn_CR_CMBSIZE, 0x2);
> +	else if (drvdata->cmb_esize == 32)
> +		*val |= FIELD_PREP(TPDA_Pn_CR_CMBSIZE, 0x1);
> +	else if (drvdata->cmb_esize == 8)
> +		*val &= ~TPDA_Pn_CR_CMBSIZE;
> +}
> +
>   /*
> - * Read the DSB element size from the TPDM device
> + * Read the element size from the TPDM device. One TPDM must have at least one of the
> + * element size property.
>    * Returns
> - *    The dsb element size read from the devicetree if available.
> - *    0 - Otherwise, with a warning once.
> + *    0 - The element size property is read
> + *    Others - Cannot read the property of the element size
>    */
> -static int tpdm_read_dsb_element_size(struct coresight_device *csdev)
> +static int tpdm_read_element_size(struct tpda_drvdata *drvdata,
> +				  struct coresight_device *csdev)
>   {
> -	int rc = 0;
> -	u8 size = 0;
> +	int rc = -EINVAL;
> +	struct tpdm_drvdata *tpdm_data = dev_get_drvdata(csdev->dev.parent);
> +
> +	if (tpdm_has_dsb_dataset(tpdm_data)) {
> +		rc = fwnode_property_read_u8(dev_fwnode(csdev->dev.parent),
> +				"qcom,dsb-element-size", &drvdata->dsb_esize);
> +	}
> +	if (tpdm_has_cmb_dataset(tpdm_data)) {
> +		rc = fwnode_property_read_u8(dev_fwnode(csdev->dev.parent),
> +				"qcom,cmb-element-size", &drvdata->cmb_esize);
> +	}
>   
> -	rc = fwnode_property_read_u8(dev_fwnode(csdev->dev.parent),
> -			"qcom,dsb-element-size", &size);
>   	if (rc)
>   		dev_warn_once(&csdev->dev,
> -			"Failed to read TPDM DSB Element size: %d\n", rc);
> +			"Failed to read TPDM Element size: %d\n", rc);
>   
> -	return size;
> +	return rc;
>   }
>   
>   /*
> @@ -56,11 +90,12 @@ static int tpdm_read_dsb_element_size(struct coresight_device *csdev)
>    * Parameter "inport" is used to pass in the input port number
>    * of TPDA, and it is set to -1 in the recursize call.
>    */
> -static int tpda_get_element_size(struct coresight_device *csdev,
> +static int tpda_get_element_size(struct tpda_drvdata *drvdata,
> +				 struct coresight_device *csdev,
>   				 int inport)
>   {
> -	int dsb_size = -ENOENT;
> -	int i, size;
> +	int rc = 0;
> +	int i;
>   	struct coresight_device *in;
>   
>   	for (i = 0; i < csdev->pdata->nr_inconns; i++) {
> @@ -69,30 +104,26 @@ static int tpda_get_element_size(struct coresight_device *csdev,
>   			continue;
>   
>   		/* Ignore the paths that do not match port */
> -		if (inport > 0 &&
> +		if (inport >= 0 &&
>   		    csdev->pdata->in_conns[i]->dest_port != inport)
>   			continue;
>   
>   		if (coresight_device_is_tpdm(in)) {
> -			size = tpdm_read_dsb_element_size(in);
> +			if ((drvdata->dsb_esize) || (drvdata->cmb_esize))
> +				return -EEXIST;
> +			rc = tpdm_read_element_size(drvdata, in);
> +			if (rc)
> +				return rc;
>   		} else {
>   			/* Recurse down the path */
> -			size = tpda_get_element_size(in, -1);
> -		}
> -
> -		if (size < 0)
> -			return size;
> -
> -		if (dsb_size < 0) {
> -			/* Found a size, save it. */
> -			dsb_size = size;
> -		} else {
> -			/* Found duplicate TPDMs */
> -			return -EEXIST;
> +			rc = tpda_get_element_size(drvdata, in, -1);
> +			if (rc)
> +				return rc;
>   		}
>   	}
>   
> -	return dsb_size;
> +
> +	return rc;
>   }
>   
>   /* Settings pre enabling port control register */
> @@ -109,7 +140,7 @@ static void tpda_enable_pre_port(struct tpda_drvdata *drvdata)
>   static int tpda_enable_port(struct tpda_drvdata *drvdata, int port)
>   {
>   	u32 val;
> -	int size;
> +	int rc;
>   
>   	val = readl_relaxed(drvdata->base + TPDA_Pn_CR(port));
>   	/*
> @@ -117,29 +148,21 @@ static int tpda_enable_port(struct tpda_drvdata *drvdata, int port)
>   	 * Set the bit to 0 if the size is 32
>   	 * Set the bit to 1 if the size is 64
>   	 */
> -	size = tpda_get_element_size(drvdata->csdev, port);
> -	switch (size) {
> -	case 32:
> -		val &= ~TPDA_Pn_CR_DSBSIZE;
> -		break;
> -	case 64:
> -		val |= TPDA_Pn_CR_DSBSIZE;
> -		break;
> -	case 0:
> -		return -EEXIST;
> -	case -EEXIST:
> +	tpdm_clear_element_size(drvdata->csdev);
> +	rc = tpda_get_element_size(drvdata, drvdata->csdev, port);
> +	if (!rc && ((drvdata->dsb_esize) || (drvdata->cmb_esize))) {

minor nit: Drop unnecessary () around the drvdata member access.

	if (!rc && (drvdata->dsb_esize || drvdata->cmb_esize))

> +		tpda_set_element_size(drvdata, &val);
> +		/* Enable the port */
> +		val |= TPDA_Pn_CR_ENA;
> +		writel_relaxed(val, drvdata->base + TPDA_Pn_CR(port));
> +	} else if (rc == -EEXIST)
>   		dev_warn_once(&drvdata->csdev->dev,
> -			"Detected multiple TPDMs on port %d", -EEXIST);
> -		return -EEXIST;
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	/* Enable the port */
> -	val |= TPDA_Pn_CR_ENA;
> -	writel_relaxed(val, drvdata->base + TPDA_Pn_CR(port));
> +			      "Detected multiple TPDMs on port %d", -EEXIST);

s/-EEXIST/port ?

Rest looks fine to me.

Suzuki


