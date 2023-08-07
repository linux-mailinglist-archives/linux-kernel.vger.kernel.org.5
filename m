Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E263771D1B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjHGJ3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjHGJ24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:28:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3666910C0;
        Mon,  7 Aug 2023 02:28:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C88221FB;
        Mon,  7 Aug 2023 02:29:36 -0700 (PDT)
Received: from [10.57.90.63] (unknown [10.57.90.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12D273F59C;
        Mon,  7 Aug 2023 02:28:50 -0700 (PDT)
Message-ID: <1e24afa4-7945-351f-2ba2-c5ba4ce925ae@arm.com>
Date:   Mon, 7 Aug 2023 10:28:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v7 05/13] coresight-tpdm: Initialize DSB subunit
 configuration
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
References: <1690269353-10829-1-git-send-email-quic_taozha@quicinc.com>
 <1690269353-10829-6-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1690269353-10829-6-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2023 08:15, Tao Zhang wrote:
> DSB is used for monitoring “events”. Events are something that
> occurs at some point in time. It could be a state decode, the
> act of writing/reading a particular address, a FIFO being empty,
> etc. This decoding of the event desired is done outside TPDM.
> DSB subunit need to be configured in enablement and disablement.
> A struct that specifics associated to dsb dataset is needed. It
> saves the configuration and parameters of the dsb datasets. This
> change is to add this struct and initialize the configuration of
> DSB subunit.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>   drivers/hwtracing/coresight/coresight-tpdm.c | 55 ++++++++++++++++++++++++++--
>   drivers/hwtracing/coresight/coresight-tpdm.h | 18 +++++++++
>   2 files changed, 69 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index abaff0b..52aa48a6 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -20,17 +20,46 @@
>   
>   DEFINE_CORESIGHT_DEVLIST(tpdm_devs, "tpdm");
>   
> +static void tpdm_reset_datasets(struct tpdm_drvdata *drvdata)
> +{
> +	if (drvdata->datasets & TPDM_PIDR0_DS_DSB) {

Do we need a helper for this, we seem to be doing this more than once ?

tpdm_has_dsb_dataset(drvdata) ?

> +		memset(drvdata->dsb, 0, sizeof(struct dsb_dataset));
> +
> +		drvdata->dsb->trig_ts = true;
> +		drvdata->dsb->trig_type = false;
> +	}
> +}
> +
>   static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>   {
>   	u32 val;
>   
> -	/* Set the enable bit of DSB control register to 1 */
> +	val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
> +	/* Set trigger timestamp */
> +	if (drvdata->dsb->trig_ts)
> +		val |= TPDM_DSB_TIER_XTRIG_TSENAB;
> +	else
> +		val &= ~TPDM_DSB_TIER_XTRIG_TSENAB;
> +	writel_relaxed(val, drvdata->base + TPDM_DSB_TIER);
> +
>   	val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
> +	/* Set trigger type */
> +	if (drvdata->dsb->trig_type)
> +		val |= TPDM_DSB_CR_TRIG_TYPE;
> +	else
> +		val &= ~TPDM_DSB_CR_TRIG_TYPE;
> +	/* Set the enable bit of DSB control register to 1 */
>   	val |= TPDM_DSB_CR_ENA;
>   	writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
>   }
>   
> -/* TPDM enable operations */
> +/* TPDM enable operations

minor nit:

/*
  * TPDM enable..

> + * The TPDM or Monitor serves as data collection component for various
> + * dataset types. It covers Basic Counts(BC), Tenure Counts(TC),
> + * Continuous Multi-Bit(CMB), Multi-lane CMB(MCMB) and Discrete Single
> + * Bit(DSB). This function will initialize the configuration according
> + * to the dataset type supported by the TPDM.
> + */
>   static void __tpdm_enable(struct tpdm_drvdata *drvdata)
>   {
>   	CS_UNLOCK(drvdata->base);
> @@ -110,13 +139,24 @@ static const struct coresight_ops tpdm_cs_ops = {
>   	.source_ops	= &tpdm_source_ops,
>   };
>   
> -static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
> +static int tpdm_datasets_setup(struct tpdm_drvdata *drvdata)
>   {
>   	u32 pidr;
>   
>   	/*  Get the datasets present on the TPDM. */
>   	pidr = readl_relaxed(drvdata->base + CORESIGHT_PERIPHIDR0);
>   	drvdata->datasets |= pidr & GENMASK(TPDM_DATASETS - 1, 0);
> +
> +	if (drvdata->datasets & TPDM_PIDR0_DS_DSB) {
> +		if (!drvdata->dsb) {

This could be :

	if (tpdm_has_dsb_dataset(drvdata) && !drvdata->dsb) {
> +			drvdata->dsb = devm_kzalloc(drvdata->dev,
> +						    sizeof(*drvdata->dsb), GFP_KERNEL);
> +			if (!drvdata->dsb)
> +				return -ENOMEM;

	}

> +		}
> +	}

Could we move the reset datasets here ?
	tpdm_reset_datasets(drvdata);

> +
> +	return 0;
>   }
>   
>   /*
> @@ -179,6 +219,7 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
>   	struct coresight_platform_data *pdata;
>   	struct tpdm_drvdata *drvdata;
>   	struct coresight_desc desc = { 0 };
> +	int ret;
>   
>   	pdata = coresight_get_platform_data(dev);
>   	if (IS_ERR(pdata))
> @@ -198,6 +239,12 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
>   
>   	drvdata->base = base;
>   
> +	ret = tpdm_datasets_setup(drvdata);
> +	if (ret)
> +		return ret;
> +
> +	tpdm_reset_datasets(drvdata);

^^ We could move this to datasets_setup(), see above.

> +
>   	/* Set up coresight component description */
>   	desc.name = coresight_alloc_device_name(&tpdm_devs, dev);
>   	if (!desc.name)
> @@ -214,7 +261,7 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
>   		return PTR_ERR(drvdata->csdev);
>   
>   	spin_lock_init(&drvdata->spinlock);
> -	tpdm_init_default_data(drvdata);
> +
>   	/* Decrease pm refcount when probe is done.*/
>   	pm_runtime_put(&adev->dev);
>   
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
> index 5438540..92c34cd 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
> @@ -11,8 +11,14 @@
>   
>   /* DSB Subunit Registers */
>   #define TPDM_DSB_CR		(0x780)
> +#define TPDM_DSB_TIER		(0x784)
> +
>   /* Enable bit for DSB subunit */
>   #define TPDM_DSB_CR_ENA		BIT(0)
> +/* Enable bit for DSB subunit trigger type */
> +#define TPDM_DSB_CR_TRIG_TYPE		BIT(12)
> +/* Enable bit for DSB subunit trigger timestamp */
> +#define TPDM_DSB_TIER_XTRIG_TSENAB		BIT(1)
>   
>   /* TPDM integration test registers */
>   #define TPDM_ITATBCNTRL		(0xEF0)
> @@ -41,6 +47,16 @@
>   #define TPDM_PIDR0_DS_DSB	BIT(1)
>   
>   /**
> + * struct dsb_dataset - specifics associated to dsb dataset
> + * @trig_ts:          Enable/Disable trigger timestamp.
> + * @trig_type:        Enable/Disable trigger type.
> + */
> +struct dsb_dataset {
> +	bool			trig_ts;
> +	bool			trig_type;
> +};
> +
> +/**
>    * struct tpdm_drvdata - specifics associated to an TPDM component
>    * @base:       memory mapped base address for this component.
>    * @dev:        The device entity associated to this component.
> @@ -48,6 +64,7 @@
>    * @spinlock:   lock for the drvdata value.
>    * @enable:     enable status of the component.
>    * @datasets:   The datasets types present of the TPDM.
> + * @dsb         Specifics associated to an TPDM component.

		    TPDM DSB related settings ?

Suzuki


>    */
>   
>   struct tpdm_drvdata {
> @@ -57,6 +74,7 @@ struct tpdm_drvdata {
>   	spinlock_t		spinlock;
>   	bool			enable;
>   	unsigned long		datasets;
> +	struct dsb_dataset	*dsb;
>   };
>   
>   #endif  /* _CORESIGHT_CORESIGHT_TPDM_H */

