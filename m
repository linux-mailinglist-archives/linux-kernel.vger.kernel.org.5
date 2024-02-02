Return-Path: <linux-kernel+bounces-49608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B8C846CE0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0CBA1F255D1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044A67765E;
	Fri,  2 Feb 2024 09:45:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B54A17C64;
	Fri,  2 Feb 2024 09:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706867152; cv=none; b=nGH9gA7hkmD1UUBscdcGHubSpfG6zzqwJ+zmSbzHxou9OtIqlqzq9fBsGyD6P2CHgRZhyd3eQ7iJpudcnG4JK0S7vJEedP2LWeFf2lIQa1C9gzQUHHUwK+9Jmc4j1ueZzGXpR4HX5xzw2kV3Hvw71/liwmkkwwZcORFvyD903io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706867152; c=relaxed/simple;
	bh=5xFuomcwnrwyRx1HFbKp/WWSYby2ejYWfm3TW4yvIiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PgIBP0jQoDKlIsYEAEbNlepzhDi8LuPx8SpvW0AyQ5BM4vWanEpEaelgJPtS6s2mcV6WWnpHP+K+lgJLqgDIgqb8llvEB3R/CKthNzv/NRVCRoToPn3yKkwPsiprm7nL3gvlZR++5MJL85sRcNdXJUK0rOiSD8jndbizx9oo5+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD1ACDA7;
	Fri,  2 Feb 2024 01:46:31 -0800 (PST)
Received: from [192.168.4.86] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0F3A3F5A1;
	Fri,  2 Feb 2024 01:45:46 -0800 (PST)
Message-ID: <58e91497-1794-46d9-a935-fc23f327f32b@arm.com>
Date: Fri, 2 Feb 2024 09:45:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/10] coresight-tpda: Add support to configure CMB
 element
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
References: <1706866364-19861-1-git-send-email-quic_taozha@quicinc.com>
 <1706866364-19861-6-git-send-email-quic_taozha@quicinc.com>
Content-Language: en-GB
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1706866364-19861-6-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/02/2024 09:32, Tao Zhang wrote:
> Read the CMB element size from the device tree. Set the register
> bit that controls the CMB element size of the corresponding port.
> 
> Reviewed-by: James Clark <james.clark@arm.com>
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>   drivers/hwtracing/coresight/coresight-tpda.c | 125 +++++++++++--------
>   drivers/hwtracing/coresight/coresight-tpda.h |   6 +
>   2 files changed, 81 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
> index 4ac954f4bc13..27d567f4c8bf 100644
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
> @@ -28,24 +29,59 @@ static bool coresight_device_is_tpdm(struct coresight_device *csdev)
>   			CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM);
>   }
>   
> +static void tpdm_clear_element_size(struct coresight_device *csdev)

I just noticed this anomaly. This is supposed to be :

tpda_clear_element_size() ? I can fix it up locally.


Suzuki


> +{
> +	struct tpda_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +	drvdata->dsb_esize = 0;
> +	drvdata->cmb_esize = 0;
> +}
> +
> +static void tpda_set_element_size(struct tpda_drvdata *drvdata, u32 *val)
> +{
> +	/* Clear all relevant fields */
> +	*val &= ~(TPDA_Pn_CR_DSBSIZE | TPDA_Pn_CR_CMBSIZE);
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
> +		rc = fwnode_property_read_u32(dev_fwnode(csdev->dev.parent),
> +				"qcom,cmb-element-bits", &drvdata->cmb_esize);
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
> @@ -56,11 +92,12 @@ static int tpdm_read_dsb_element_size(struct coresight_device *csdev)
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
> @@ -69,30 +106,26 @@ static int tpda_get_element_size(struct coresight_device *csdev,
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
> +			if (drvdata->dsb_esize || drvdata->cmb_esize)
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
> @@ -109,7 +142,7 @@ static void tpda_enable_pre_port(struct tpda_drvdata *drvdata)
>   static int tpda_enable_port(struct tpda_drvdata *drvdata, int port)
>   {
>   	u32 val;
> -	int size;
> +	int rc;
>   
>   	val = readl_relaxed(drvdata->base + TPDA_Pn_CR(port));
>   	/*
> @@ -117,29 +150,21 @@ static int tpda_enable_port(struct tpda_drvdata *drvdata, int port)
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
> +	if (!rc && (drvdata->dsb_esize || drvdata->cmb_esize)) {
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
> +			      "Detected multiple TPDMs on port %d", port);
> +	else
> +		dev_warn_once(&drvdata->csdev->dev,
> +			      "Didn't find TPDM element size");
>   
> -	return 0;
> +	return rc;
>   }
>   
>   static int __tpda_enable(struct tpda_drvdata *drvdata, int port)
> diff --git a/drivers/hwtracing/coresight/coresight-tpda.h b/drivers/hwtracing/coresight/coresight-tpda.h
> index b3b38fd41b64..19af64120fcf 100644
> --- a/drivers/hwtracing/coresight/coresight-tpda.h
> +++ b/drivers/hwtracing/coresight/coresight-tpda.h
> @@ -10,6 +10,8 @@
>   #define TPDA_Pn_CR(n)		(0x004 + (n * 4))
>   /* Aggregator port enable bit */
>   #define TPDA_Pn_CR_ENA		BIT(0)
> +/* Aggregator port CMB data set element size bit */
> +#define TPDA_Pn_CR_CMBSIZE		GENMASK(7, 6)
>   /* Aggregator port DSB data set element size bit */
>   #define TPDA_Pn_CR_DSBSIZE		BIT(8)
>   
> @@ -25,6 +27,8 @@
>    * @csdev:      component vitals needed by the framework.
>    * @spinlock:   lock for the drvdata value.
>    * @enable:     enable status of the component.
> + * @dsb_esize   Record the DSB element size.
> + * @cmb_esize   Record the CMB element size.
>    */
>   struct tpda_drvdata {
>   	void __iomem		*base;
> @@ -32,6 +36,8 @@ struct tpda_drvdata {
>   	struct coresight_device	*csdev;
>   	spinlock_t		spinlock;
>   	u8			atid;
> +	u8			dsb_esize;
> +	u32			cmb_esize;
>   };
>   
>   #endif  /* _CORESIGHT_CORESIGHT_TPDA_H */


