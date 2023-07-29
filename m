Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223F1767FED
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 16:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjG2OGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 10:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjG2OGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 10:06:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7112F1FFA;
        Sat, 29 Jul 2023 07:06:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 101AE60C22;
        Sat, 29 Jul 2023 14:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B2CC433C8;
        Sat, 29 Jul 2023 14:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690639570;
        bh=SRGf7FK1u0KPJyTANIUHafFykElxV+SW0zRcMWEOZpY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZEzn92Rmxlg6KXfTZ1m2GtMSGSPSQtF6V65344hkY5oGtag4/JQYO6VcukhUtQpO1
         xEVGjqzjHtDdObDDIpdZqDXc1zw4dRRyqN17KaUCEMojhNGds7fbmrcTVlGQw98sea
         PD6AuwIwoSFNVtOyINDZ/QrmXHQDjUsqBJKb/6oURLzefxL9Mb/L8RIKleQAM1hB5O
         UZn9HYNwLETOOykePknIHtQeWYlYnY09Zi53gJAGw6o5yg+dw4yOLgDftkhim0dk8x
         MXRsCw8fgyXKEHkkwz2qXTv22dyvdLLQTBvbeLeSUNUsHl3ZzbmU18KnJjp8eavY5r
         fujTrxHSykslg==
Date:   Sat, 29 Jul 2023 15:06:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] drivers:iio:admv1013: add vcc regulators
Message-ID: <20230729150615.50f19564@jic23-huawei>
In-Reply-To: <20230727110121.93546-2-antoniu.miclaus@analog.com>
References: <20230727110121.93546-1-antoniu.miclaus@analog.com>
        <20230727110121.93546-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2023 14:01:21 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add regulators for the VCC supplies of the admv1013.
> 
> The patch aims to align the implementation with the current admv1014
> driver where all the VCC supplies are handled as regulators.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Hi Antoniu

Use the devm_regulator_bulk_get_enable() route
to simplify things for these regulators.  The vcm one needs to remain
handled separately as we need to get the voltage for that one and hence
need access to the struct regulator.

> ---
> no changes in v2.
>  drivers/iio/frequency/admv1013.c | 35 ++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
> index 9bf8337806fc..086e2f35b52c 100644
> --- a/drivers/iio/frequency/admv1013.c
> +++ b/drivers/iio/frequency/admv1013.c
> @@ -73,6 +73,7 @@
>  #define ADMV1013_REG_ADDR_READ_MSK		GENMASK(6, 1)
>  #define ADMV1013_REG_ADDR_WRITE_MSK		GENMASK(22, 17)
>  #define ADMV1013_REG_DATA_MSK			GENMASK(16, 1)
> +#define ADMV1013_VCC_NUM_REGULATORS		10
>  
>  enum {
>  	ADMV1013_IQ_MODE,
> @@ -96,6 +97,7 @@ struct admv1013_state {
>  	/* Protect against concurrent accesses to the device and to data */
>  	struct mutex		lock;
>  	struct regulator	*reg;
> +	struct regulator_bulk_data vcc_regs[ADMV1013_VCC_NUM_REGULATORS];
>  	struct notifier_block	nb;
>  	unsigned int		input_mode;
>  	unsigned int		quad_se_mode;
> @@ -379,6 +381,11 @@ static const struct iio_info admv1013_info = {
>  	.debugfs_reg_access = &admv1013_reg_access,
>  };
>  
> +static const char * const admv1013_reg_name[] = {
> +	 "vcc-drv", "vcc2-drv", "vcc-vva", "vcc-amp1", "vcc-amp2",
> +	 "vcc-env", "vcc-bg", "vcc-bg2", "vcc-mixer", "vcc-quad"
> +};
> +
>  static int admv1013_freq_change(struct notifier_block *nb, unsigned long action, void *data)
>  {
>  	struct admv1013_state *st = container_of(nb, struct admv1013_state, nb);
> @@ -495,6 +502,11 @@ static void admv1013_reg_disable(void *data)
>  	regulator_disable(data);
>  }
>  
> +static void admv1013_vcc_reg_disable(void *data)
> +{
> +	regulator_bulk_disable(ADMV1013_VCC_NUM_REGULATORS, data);
> +}
> +
>  static void admv1013_powerdown(void *data)
>  {
>  	unsigned int enable_reg, enable_reg_msk;
> @@ -520,6 +532,7 @@ static void admv1013_powerdown(void *data)
>  static int admv1013_properties_parse(struct admv1013_state *st)
>  {
>  	int ret;
> +	unsigned int i;
>  	const char *str;
>  	struct spi_device *spi = st->spi;
>  
> @@ -554,6 +567,17 @@ static int admv1013_properties_parse(struct admv1013_state *st)
>  		return dev_err_probe(&spi->dev, PTR_ERR(st->reg),
>  				     "failed to get the common-mode voltage\n");
>  
> +	for (i = 0; i < ADMV1013_VCC_NUM_REGULATORS; ++i)
> +		st->vcc_regs[i].supply = admv1013_reg_name[i];
> +
> +	ret = devm_regulator_bulk_get(&st->spi->dev,
> +				      ADMV1013_VCC_NUM_REGULATORS,
> +				      st->vcc_regs);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to request VCC regulators");
> +		return ret;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -591,6 +615,17 @@ static int admv1013_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> +	ret = regulator_bulk_enable(ADMV1013_VCC_NUM_REGULATORS, st->vcc_regs);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to enable regulators");
> +		return ret;

I don't think the driver needs explicit access to any of these regulators.

Thus you can use devm_regulator_bulk_get_enable() here and no need to get
them separately earlier.

> +	}
> +
> +	ret = devm_add_action_or_reset(&spi->dev, admv1013_vcc_reg_disable,
> +				       st->vcc_regs);
> +	if (ret)
> +		return ret;
> +
>  	st->clkin = devm_clk_get_enabled(&spi->dev, "lo_in");
>  	if (IS_ERR(st->clkin))
>  		return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),

