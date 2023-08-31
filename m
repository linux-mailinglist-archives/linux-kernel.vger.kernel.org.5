Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D55278F098
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245057AbjHaPv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjHaPv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:51:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D3AE1BB;
        Thu, 31 Aug 2023 08:51:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92712C15;
        Thu, 31 Aug 2023 08:52:02 -0700 (PDT)
Received: from [10.57.91.85] (unknown [10.57.91.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 599263F64C;
        Thu, 31 Aug 2023 08:51:20 -0700 (PDT)
Message-ID: <b0453e58-f315-b9dd-ef49-8a9e3d4ed9ed@arm.com>
Date:   Thu, 31 Aug 2023 16:51:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v8 04/13] coresight-tpda: Add DSB dataset support
To:     Tao Zhang <quic_taozha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org
References: <1692681973-20764-1-git-send-email-quic_taozha@quicinc.com>
 <1692681973-20764-5-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1692681973-20764-5-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2023 06:26, Tao Zhang wrote:
> Read the DSB element size from the device tree. Set the register
> bit that controls the DSB element size of the corresponding port.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>   drivers/hwtracing/coresight/coresight-tpda.c | 126 ++++++++++++++++++++++++---
>   drivers/hwtracing/coresight/coresight-tpda.h |   2 +
>   2 files changed, 118 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
> index 8d2b9d2..0f21cd1 100644
> --- a/drivers/hwtracing/coresight/coresight-tpda.c
> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
> @@ -21,6 +21,80 @@
>   
>   DEFINE_CORESIGHT_DEVLIST(tpda_devs, "tpda");
>   
> +static bool coresight_device_is_tpdm(struct coresight_device *csdev)
> +{
> +	return (csdev->type == CORESIGHT_DEV_TYPE_SOURCE) &&
> +			(csdev->subtype.source_subtype ==

minor nit: Please align

	return (csdev->type == CORESIGHT_DEV_TYPE_SOURCE) &&
	       (csdev->subtype.source_subtype ==
> +			CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM);


> +}
> +
> +/*
> + * Read the DSB element size from the TPDM device
> + * Returns
> + *    The dsb element size read from the devicetree if available.
> + *    0 - Otherwise, with a warning once.
> + */
> +static int tpdm_read_dsb_element_size(struct coresight_device *csdev)
> +{
> +	int rc = 0;
> +	u8 size = 0;
> +
> +	rc = fwnode_property_read_u8(dev_fwnode(csdev->dev.parent),
> +			"qcom,dsb-element-size", &size);
> +	if (rc)
> +		dev_warn_once(&csdev->dev,
> +			"Failed to read TPDM DSB Element size: %d\n", rc);
> +
> +	return size;
> +}
> +
> +/*
> + * Search and read element data size from the TPDM node in
> + * the devicetree. Each input port of TPDA is connected to
> + * a TPDM. Different TPDM supports different types of dataset,
> + * and some may support more than one type of dataset.
> + * Parameter "inport" is used to pass in the input port number
> + * of TPDA, and it is set to -1 in the recursize call.
> + */
> +static int tpda_get_element_size(struct coresight_device *csdev,
> +								 int inport)

nit: Again, please align.

static int tpda_get_element_size(struct coresight_device *csdev,
				 int inport)
{

	
> +{
> +	int dsb_size = -ENOENT;
> +	int i, size;
> +	struct coresight_device *in;
> +
> +	for (i = 0; i < csdev->pdata->nr_inconns; i++) {
> +		in = csdev->pdata->in_conns[i]->src_dev;
> +		if (!in)
> +			continue;
> +
> +		/* Ignore the paths that do not match port */
> +		if (inport > 0 &&
> +			(csdev->pdata->in_conns[i]->dest_port != inport))

Align please :

		if (inport > 0 &&
		    (csdev->pdata->in_conns[i]->dest_port != inport))

> +			continue;
> +
> +		if (coresight_device_is_tpdm(in)) {
> +			size = tpdm_read_dsb_element_size(in);
> +		} else {
> +			/* Recurse down the path */
> +			size = tpda_get_element_size(in, -1);
> +		}
> +
> +		if (size < 0)
> +			return size;
> +
> +		if (dsb_size < 0) {
> +			/* Found a size, save it. */
> +			dsb_size = size;
> +		} else {
> +			/* Found duplicate TPDMs */
> +			return -EEXIST;
> +		}
> +	}
> +
> +	return dsb_size;
> +}
> +
>   /* Settings pre enabling port control register */
>   static void tpda_enable_pre_port(struct tpda_drvdata *drvdata)
>   {
> @@ -32,26 +106,55 @@ static void tpda_enable_pre_port(struct tpda_drvdata *drvdata)
>   	writel_relaxed(val, drvdata->base + TPDA_CR);
>   }
>   
> -static void tpda_enable_port(struct tpda_drvdata *drvdata, int port)
> +static int tpda_enable_port(struct tpda_drvdata *drvdata, int port)
>   {
>   	u32 val;
> +	int size;
>   
>   	val = readl_relaxed(drvdata->base + TPDA_Pn_CR(port));
> +	/*
> +	 * Configure aggregator port n DSB data set element size
> +	 * Set the bit to 0 if the size is 32
> +	 * Set the bit to 1 if the size is 64
> +	 */
> +	size = tpda_get_element_size(drvdata->csdev, port);
> +	switch (size) {
> +	case 32:
> +		val &= ~TPDA_Pn_CR_DSBSIZE;
> +		break;
> +	case 64:
> +		val |= TPDA_Pn_CR_DSBSIZE;
> +		break;
> +	case 0:
> +		return -EEXIST;
> +	case -EEXIST:
> +		dev_warn_once(&drvdata->csdev->dev,
> +			"Detected multiple TPDMs on port %d", -EEXIST);
> +		return -EEXIST;
> +	default:
> +		return -EINVAL;
> +	}
> +
>   	/* Enable the port */
>   	val |= TPDA_Pn_CR_ENA;
>   	writel_relaxed(val, drvdata->base + TPDA_Pn_CR(port));
> +
> +	return 0;
>   }
>   
> -static void __tpda_enable(struct tpda_drvdata *drvdata, int port)
> +static int __tpda_enable(struct tpda_drvdata *drvdata, int port)
>   {
> +	int ret;
> +
>   	CS_UNLOCK(drvdata->base);
>   
>   	if (!drvdata->csdev->enable)
>   		tpda_enable_pre_port(drvdata);
>   
> -	tpda_enable_port(drvdata, port);
> -
> +	ret = tpda_enable_port(drvdata, port);
>   	CS_LOCK(drvdata->base);
> +
> +	return ret;
>   }
>   
>   static int tpda_enable(struct coresight_device *csdev,
> @@ -59,16 +162,19 @@ static int tpda_enable(struct coresight_device *csdev,
>   		       struct coresight_connection *out)
>   {
>   	struct tpda_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	int ret;

As reported by the build robot, please initialise this to 0.

>   
>   	spin_lock(&drvdata->spinlock);
> -	if (atomic_read(&in->dest_refcnt) == 0)
> -		__tpda_enable(drvdata, in->dest_port);
> +	if (atomic_read(&in->dest_refcnt) == 0) {
> +		ret = __tpda_enable(drvdata, in->dest_port);
> +		if (!ret) {
> +			atomic_inc(&in->dest_refcnt);
> +			dev_dbg(drvdata->dev, "TPDA inport %d enabled.\n", in->dest_port);
> +		}
> +	}
>   
> -	atomic_inc(&in->dest_refcnt);
>   	spin_unlock(&drvdata->spinlock);
> -
> -	dev_dbg(drvdata->dev, "TPDA inport %d enabled.\n", in->dest_port);
> -	return 0;
> +	return ret;
>   }
>   
>   static void __tpda_disable(struct tpda_drvdata *drvdata, int port)
> diff --git a/drivers/hwtracing/coresight/coresight-tpda.h b/drivers/hwtracing/coresight/coresight-tpda.h
> index 0399678..b3b38fd 100644
> --- a/drivers/hwtracing/coresight/coresight-tpda.h
> +++ b/drivers/hwtracing/coresight/coresight-tpda.h
> @@ -10,6 +10,8 @@
>   #define TPDA_Pn_CR(n)		(0x004 + (n * 4))
>   /* Aggregator port enable bit */
>   #define TPDA_Pn_CR_ENA		BIT(0)
> +/* Aggregator port DSB data set element size bit */
> +#define TPDA_Pn_CR_DSBSIZE		BIT(8)
>   
>   #define TPDA_MAX_INPORTS	32
>   

Rest looks fine to me.

Suzuki

