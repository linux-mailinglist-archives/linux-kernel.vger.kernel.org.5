Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D648008DD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 11:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378401AbjLAKsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 05:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378395AbjLAKsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 05:48:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B8CD40
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 02:48:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E38BC433C9;
        Fri,  1 Dec 2023 10:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701427706;
        bh=bYTnVPbpbtB9dCl6tLzUGkhooFvdgeD9g8sXerKrUws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vag/pdaIry/wEOswBHKkPevJLTu5viOPQ+B8P35F9eUC/wIdR4uMvH3mo4N4rwTqE
         FBMwaDrS6mPTp7O6oJp9hvSjhf26wlvskqxQ3IqGs8c9APx8+YMxjphhjTei/mPOHo
         aS3usPHg4YrBT2T6ahOnzL1RcMdh79yQT8Lxi3Bl2OeMACyCdmkLDPlmjSnY9Ms8Pm
         KsudgtU0FmabCtQX1UTogPJP0PoRNkjnMFnsIco6wPio+KOSnS4gjxYHahzobnaMie
         QwswwPu4W8hsVj6j2O686b5H63A2ac63OgJbCOr+zrFEHEP1N/2K0IZjaOniUCiFQT
         yq/+zVHP+p/4Q==
Date:   Fri, 1 Dec 2023 10:48:20 +0000
From:   Lee Jones <lee@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, bcousson@baylibre.com, tony@atomide.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH v2 2/6] twl-core: add power off implementation for twl603x
Message-ID: <20231201104820.GC3259151@google.com>
References: <20231127221907.177442-1-andreas@kemnade.info>
 <20231127221907.177442-3-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231127221907.177442-3-andreas@kemnade.info>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2023, Andreas Kemnade wrote:

> If the system-power-controller property is there, enable power off.
> Implementation is based on a Linux v3.0 vendor kernel.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/mfd/twl-core.c  | 34 ++++++++++++++++++++++++++++++++++
>  include/linux/mfd/twl.h |  1 +
>  2 files changed, 35 insertions(+)
> 
> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index 6e384a79e3418..54482d5d8888b 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -687,6 +687,31 @@ static void twl_remove(struct i2c_client *client)
>  	twl_priv->ready = false;
>  }
>  
> +static void twl6030_power_off(void)
> +{
> +#define APP_DEVOFF      (1<<0)
> +#define CON_DEVOFF      (1<<1)
> +#define MOD_DEVOFF      (1<<2)

Please place these at the top somewhere.

You should also have spaces around the '<<'s.

These look like they should be BIT()s though.

> +
> +	int err;
> +	u8 val;
> +
> +	err = twl_i2c_read_u8(TWL_MODULE_PM_MASTER, &val,
> +			      TWL6030_PHOENIX_DEV_ON);

You can use 100-chars if you like.

> +	if (err) {
> +		pr_err("I2C error %d reading PHOENIX_DEV_ON\n", err);

It would save an awful lot of lines and space if we could place these
warnings/errors inside twl_i2c_read_u8().

> +		return;
> +	}
> +
> +	val |= APP_DEVOFF | CON_DEVOFF | MOD_DEVOFF;
> +
> +	err = twl_i2c_write_u8(TWL_MODULE_PM_MASTER, val,
> +			       TWL6030_PHOENIX_DEV_ON);
> +	if (err)
> +		pr_err("TWL6030 Unable to power off\n");
> +}
> +
> +
>  static struct of_dev_auxdata twl_auxdata_lookup[] = {
>  	OF_DEV_AUXDATA("ti,twl4030-gpio", 0, "twl4030-gpio", NULL),
>  	{ /* sentinel */ },
> @@ -852,6 +877,15 @@ twl_probe(struct i2c_client *client)
>  			goto free;
>  	}
>  
> +	if (twl_class_is_6030()) {
> +		if (of_device_is_system_power_controller(client->dev.of_node)) {

Use 'node' instead.

> +			if (!pm_power_off)
> +				pm_power_off = twl6030_power_off;
> +			else
> +				dev_warn(&client->dev, "Poweroff callback already assigned\n");
> +		}
> +	}
> +
>  	status = of_platform_populate(node, NULL, twl_auxdata_lookup,
>  				      &client->dev);
>  
> diff --git a/include/linux/mfd/twl.h b/include/linux/mfd/twl.h
> index c062d91a67d92..85dc406173dba 100644
> --- a/include/linux/mfd/twl.h
> +++ b/include/linux/mfd/twl.h
> @@ -461,6 +461,7 @@ static inline int twl6030_mmc_card_detect(struct device *dev, int slot)
>  
>  #define TWL4030_PM_MASTER_GLOBAL_TST		0xb6
>  
> +#define TWL6030_PHOENIX_DEV_ON                  0x06
>  /*----------------------------------------------------------------------*/
>  
>  /* Power bus message definitions */
> -- 
> 2.39.2
> 

-- 
Lee Jones [李琼斯]
