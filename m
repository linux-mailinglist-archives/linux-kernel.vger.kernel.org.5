Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84D27DB8C6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 12:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjJ3LLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 07:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjJ3LLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 07:11:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 053E5C1;
        Mon, 30 Oct 2023 04:11:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A7ABFEC;
        Mon, 30 Oct 2023 04:11:54 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD12C3F67D;
        Mon, 30 Oct 2023 04:11:07 -0700 (PDT)
Message-ID: <197007e5-e334-cd7e-0bbd-b84c828f5f7b@arm.com>
Date:   Mon, 30 Oct 2023 11:11:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/8] coresight-tpda: Add support to configure CMB
 element
To:     Tao Zhang <quic_taozha@quicinc.com>
Cc:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Song Chai <quic_songchai@quicinc.com>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <1698202408-14608-1-git-send-email-quic_taozha@quicinc.com>
 <1698202408-14608-3-git-send-email-quic_taozha@quicinc.com>
Content-Language: en-US
From:   James Clark <james.clark@arm.com>
In-Reply-To: <1698202408-14608-3-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/10/2023 03:53, Tao Zhang wrote:
> Read the CMB element size from the device tree. Set the register
> bit that controls the CMB element size of the corresponding port.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  drivers/hwtracing/coresight/coresight-tpda.c | 108 ++++++++++++++++-----------
>  drivers/hwtracing/coresight/coresight-tpda.h |   6 ++
>  2 files changed, 69 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
> index 5f82737..3101d2a 100644
> --- a/drivers/hwtracing/coresight/coresight-tpda.c
> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
> @@ -28,24 +28,54 @@ static bool coresight_device_is_tpdm(struct coresight_device *csdev)
>  			CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM);
>  }
>  
> +static void tpdm_clear_element_size(struct coresight_device *csdev)
> +{
> +	struct tpda_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +	if (drvdata->dsb_esize)
> +		drvdata->dsb_esize = 0;
> +	if (drvdata->cmb_esize)
> +		drvdata->cmb_esize = 0;
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
>  /*
>   * Read the DSB element size from the TPDM device
>   * Returns
>   *    The dsb element size read from the devicetree if available.

Hi Tao,

I think the function description and the return value description above
need updating now.

>   *    0 - Otherwise, with a warning once.
>   */
> -static int tpdm_read_dsb_element_size(struct coresight_device *csdev)
> +static int tpdm_read_element_size(struct tpda_drvdata *drvdata,
> +				  struct coresight_device *csdev)
>  {
> -	int rc = 0;
> -	u8 size = 0;
> -
> -	rc = fwnode_property_read_u8(dev_fwnode(csdev->dev.parent),
> -			"qcom,dsb-element-size", &size);
> +	int rc = -EEXIST;
> +
> +	if (!fwnode_property_read_u8(dev_fwnode(csdev->dev.parent),
> +			"qcom,dsb-element-size", &drvdata->dsb_esize))
> +		rc &= 0;

Is &= 0 significant? Why not = 0?

> +	if (!fwnode_property_read_u8(dev_fwnode(csdev->dev.parent),
> +			"qcom,cmb-element-size", &drvdata->cmb_esize))
> +		rc &= 0;
>  	if (rc)
>  		dev_warn_once(&csdev->dev,
> -			"Failed to read TPDM DSB Element size: %d\n", rc);
> +			"Failed to read TPDM Element size: %d\n", rc);
>  
> -	return size;
> +	return rc;
>  }
>  
>  /*
> @@ -56,13 +86,17 @@ static int tpdm_read_dsb_element_size(struct coresight_device *csdev)
>   * Parameter "inport" is used to pass in the input port number
>   * of TPDA, and it is set to -1 in the recursize call.
>   */
> -static int tpda_get_element_size(struct coresight_device *csdev,
> +static int tpda_get_element_size(struct tpda_drvdata *drvdata,
> +				 struct coresight_device *csdev,
>  				 int inport)
>  {
> -	int dsb_size = -ENOENT;
> -	int i, size;
> +	int rc = -ENOENT;
> +	int i;
>  	struct coresight_device *in;
>  
> +	if (inport > 0)
> +		tpdm_clear_element_size(csdev);
> +
>  	for (i = 0; i < csdev->pdata->nr_inconns; i++) {
>  		in = csdev->pdata->in_conns[i]->src_dev;
>  		if (!in)
> @@ -74,25 +108,20 @@ static int tpda_get_element_size(struct coresight_device *csdev,
>  			continue;
>  
>  		if (coresight_device_is_tpdm(in)) {
> -			size = tpdm_read_dsb_element_size(in);
> +			if (rc)
> +				rc = tpdm_read_element_size(drvdata, in);
> +			else
> +				return -EINVAL;

This is quite hard to follow, is checking rc here before calling
tpdm_read_element_size() some kind of way of only calling it once?

rc isn't actually a return value at this point, it's just default
initialised to -ENOENT.

Then it's not clear why the else condition returns an error?

>  		} else {
>  			/* Recurse down the path */
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

And then why it's assigned here but not checked for an error in this case?

Maybe some comments explaining the flow would help. Or to me it seems
like a second variable to track the thing that's actually intended could
be used as well. Like "bool found_element" or something, rather than
re-using rc to also track another thing.

>  		}
>  	}
>  
> -	return dsb_size;
> +	if ((drvdata->dsb_esize) || (drvdata->cmb_esize))
> +		rc = 0;
> +
> +	return rc;
>  }
>  
>  /* Settings pre enabling port control register */
> @@ -109,7 +138,7 @@ static void tpda_enable_pre_port(struct tpda_drvdata *drvdata)
>  static int tpda_enable_port(struct tpda_drvdata *drvdata, int port)
>  {
>  	u32 val;
> -	int size;
> +	int rc;
>  
>  	val = readl_relaxed(drvdata->base + TPDA_Pn_CR(port));
>  	/*
> @@ -117,29 +146,18 @@ static int tpda_enable_port(struct tpda_drvdata *drvdata, int port)
>  	 * Set the bit to 0 if the size is 32
>  	 * Set the bit to 1 if the size is 64
>  	 */
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
> +	rc = tpda_get_element_size(drvdata, drvdata->csdev, port);
> +	if (!rc) {
> +		tpda_set_element_size(drvdata, &val);
> +		/* Enable the port */
> +		val |= TPDA_Pn_CR_ENA;
> +		writel_relaxed(val, drvdata->base + TPDA_Pn_CR(port));
> +	} else if (rc == -EINVAL) {
>  		dev_warn_once(&drvdata->csdev->dev,
>  			"Detected multiple TPDMs on port %d", -EEXIST);

tpdm_read_element_size() can return EEXIST, but then it gets changed
back to EINVAL in tpda_get_element_size() without caring about the
specific code, before finally being changed back to EEXIST for the
warning here. Can it just be propagated as the original value? Or use
EINVAL or EEXIST all the way through. That would probably be easier to
follow.

And then also a comment about why the other possible error values don't
result in a warning.

Thanks
James

> -		return -EEXIST;
> -	default:
> -		return -EINVAL;
>  	}
>  
> -	/* Enable the port */
> -	val |= TPDA_Pn_CR_ENA;
> -	writel_relaxed(val, drvdata->base + TPDA_Pn_CR(port));
> -
> -	return 0;
> +	return rc;
>  }
>  
>  static int __tpda_enable(struct tpda_drvdata *drvdata, int port)
> diff --git a/drivers/hwtracing/coresight/coresight-tpda.h b/drivers/hwtracing/coresight/coresight-tpda.h
> index b3b38fd..29164fd 100644
> --- a/drivers/hwtracing/coresight/coresight-tpda.h
> +++ b/drivers/hwtracing/coresight/coresight-tpda.h
> @@ -10,6 +10,8 @@
>  #define TPDA_Pn_CR(n)		(0x004 + (n * 4))
>  /* Aggregator port enable bit */
>  #define TPDA_Pn_CR_ENA		BIT(0)
> +/* Aggregator port CMB data set element size bit */
> +#define TPDA_Pn_CR_CMBSIZE		GENMASK(7, 6)
>  /* Aggregator port DSB data set element size bit */
>  #define TPDA_Pn_CR_DSBSIZE		BIT(8)
>  
> @@ -25,6 +27,8 @@
>   * @csdev:      component vitals needed by the framework.
>   * @spinlock:   lock for the drvdata value.
>   * @enable:     enable status of the component.
> + * @dsb_esize   Record the DSB element size.
> + * @cmb_esize   Record the CMB element size.
>   */
>  struct tpda_drvdata {
>  	void __iomem		*base;
> @@ -32,6 +36,8 @@ struct tpda_drvdata {
>  	struct coresight_device	*csdev;
>  	spinlock_t		spinlock;
>  	u8			atid;
> +	u8			dsb_esize;
> +	u8			cmb_esize;
>  };
>  
>  #endif  /* _CORESIGHT_CORESIGHT_TPDA_H */
