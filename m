Return-Path: <linux-kernel+bounces-44610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEE9842501
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E5E288DA3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D336A03B;
	Tue, 30 Jan 2024 12:35:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C8F67E7F;
	Tue, 30 Jan 2024 12:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618109; cv=none; b=Cq4DOqfdznuYTGZSQK+OJr1uFUmAtWxJc467H0TehRWWpyqXZBTXc7DB9F63c+jvEqR3QDv2LqPiNR7RcwFxTOij1iMySGMSGBfysrvwyvO0LBG+HMDlBMnUxTOwKX+N9CVujoQFoxTA+hoeN0H1E9Oj9fvKNbvW8K7cgat62qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618109; c=relaxed/simple;
	bh=FjucVxqt30Vtepeq9kUvqCOzcmOtmYscLeSgDyFRdL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cv2Hb6jCUjIOWlZH4tGaPDLScxY9xJSw5+zPOyUidkinxAwtELMXKXmCahFJCr1VNKC/ktjnw9C9r12ozWzAWf7kiT/u95mRGkiqTaLZWp4Emt6bCW0lC4GXjWWcZTPlHxEw5GhteIMIhLS+HL6zCAtSmgCQG8AfdaSuF2F3EwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90344DA7;
	Tue, 30 Jan 2024 04:35:50 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9271E3F762;
	Tue, 30 Jan 2024 04:35:04 -0800 (PST)
Message-ID: <6ccb98f2-2f68-45db-9941-1c7b05da84d0@arm.com>
Date: Tue, 30 Jan 2024 12:35:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/10] coresight-tpda: Add support to configure CMB
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
References: <1706605366-31705-1-git-send-email-quic_taozha@quicinc.com>
 <1706605366-31705-6-git-send-email-quic_taozha@quicinc.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1706605366-31705-6-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/01/2024 09:02, Tao Zhang wrote:
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
> index 4ac954f4bc13..fcddff3ded81 100644
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

We don't seem to be clearing the fields we modify, before updating them. 
This may be OK in real world where the device connected to TPDA port
may not change. But it is always safer to clear the bits and set it.

e.g.:
	*val &= ~(TPDA_Pn_CR_DSBSIZE | TPDA_Pn_CR_CMBSIZE);

	

> +	else if (drvdata->dsb_esize == 32)
> +		*val &= ~TPDA_Pn_CR_DSBSIZE;
> +
> +	if (drvdata->cmb_esize == 64)
> +		*val |= FIELD_PREP(TPDA_Pn_CR_CMBSIZE, 0x2);
> +	else if (drvdata->cmb_esize == 32)
> +		*val |= FIELD_PREP(TPDA_Pn_CR_CMBSIZE, 0x1);

Similarly here ^^^. I am happy to fix it up if you are OK with it 
(unless there are other changes that need a respin)

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

That looks like a bug fix, but if you don't care about fixing this in < 
v6.8,  I don't mind.


Rest looks fine to me

Suzuki


