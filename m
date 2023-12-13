Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0DD81107A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378005AbjLMLro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbjLMLrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:47:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5839B0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:47:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7FAC433C8;
        Wed, 13 Dec 2023 11:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702468068;
        bh=JyyObBeV7lx+piW0vGHGGe7J7czaHg1baDvRFTL1YFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r7rMuQG8++rxezs7n/Y9sURdpr7XIY9fEftxwfu1W5eXx4Y+9uZ3CtJyrCwuP9xWJ
         aE/wcDKQULl2X4+3Kc/UN5ORX+LcVFbaN3Qo10IiJRgrOAODQRfyvKH7St5lgHiOs6
         ojTwBd9rDcqql2hJSZrhFgKnp5q72PJFJ+Z/Mlb3z08YwvtNXlcKOU2NP811pDxw66
         PkqMFn+ihwCmUdHaazAMubK69lhReNpD6dT8mWZzRQYdWqFRI+EgDLaTwm6erXOz/e
         u9JfzsxmjIuNqS6jbqz+tIh3oDPhyjsB1nIb4l+WISuj9zjqGqU5VLzwrrVGan7Jm0
         EHsZFsoRPpImQ==
Date:   Wed, 13 Dec 2023 11:47:44 +0000
From:   Lee Jones <lee@kernel.org>
To:     Amitesh Singh <singh.amitesh@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] feat(kernel/pca963x): implement power management
Message-ID: <20231213114744.GK111411@google.com>
References: <881c6ba1-1701-41be-a4ac-81cdca5f0eea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <881c6ba1-1701-41be-a4ac-81cdca5f0eea@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2023, Amitesh Singh wrote:

> From a22dbd7390ce875e81d67f14f05f593d7f03d5c1 Mon Sep 17 00:00:00 2001
> From: Amitesh Singh <singh.amitesh@gmail.com>
> Date: Fri, 8 Dec 2023 15:08:33 +0530
> Subject: [PATCH] feat(kernel/pca963x): implement power management

What are you using to send this patch?

Please use the Git tools provided:

  git format-patch
  git send-email

The subject line is also totally incorrect.  Again Git can help:

  git log --oneline -- <subsystem>

Please fix the bot's complaints before re-submitting.

Thank you.

> This implements power management in upstream driver
> for pca9633 which enables device sleep and resume
> on system-wide sleep/hibernation
> 
> Signed-off-by: Amitesh Singh <singh.amitesh@gmail.com>
> ---
>  drivers/leds/leds-pca963x.c | 41 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/leds/leds-pca963x.c b/drivers/leds/leds-pca963x.c
> index 47223c850e4b..462f917dc986 100644
> --- a/drivers/leds/leds-pca963x.c
> +++ b/drivers/leds/leds-pca963x.c
> @@ -39,6 +39,7 @@
>  #define PCA963X_LED_PWM		0x2	/* Controlled through PWM */
>  #define PCA963X_LED_GRP_PWM	0x3	/* Controlled through PWM/GRPPWM */
> 
> +#define PCA963X_MODE1_SLEEP     0x04    /* Normal mode or Low Power mode,
> oscillator off */
>  #define PCA963X_MODE2_OUTDRV	0x04	/* Open-drain or totem pole */
>  #define PCA963X_MODE2_INVRT	0x10	/* Normal or inverted direction */
>  #define PCA963X_MODE2_DMBLNK	0x20	/* Enable blinking */
> @@ -380,6 +381,45 @@ static int pca963x_register_leds(struct i2c_client
> *client,
>  	return ret;
>  }
> 
> +#ifdef CONFIG_PM
> +static int pca963x_suspend(struct device *dev)
> +{
> +	struct pca963x *chip;
> +	u8 reg;
> +
> +	chip = dev_get_drvdata(dev);
> +
> +	reg = i2c_smbus_read_byte_data(chip->client, PCA963X_MODE1);
> +	reg = reg | (1 << PCA963X_MODE1_SLEEP);
> +	i2c_smbus_write_byte_data(chip->client, PCA963X_MODE1, reg);
> +
> +	return 0;
> +}
> +
> +static int pca963x_resume(struct device *dev)
> +{
> +	struct pca963x *chip;
> +	u8 reg;
> +
> +	chip = dev_get_drvdata(dev);
> +
> +	reg = i2c_smbus_read_byte_data(chip->client, PCA963X_MODE1);
> +	reg = reg & ~(1 << PCA963X_MODE1_SLEEP);
> +	i2c_smbus_write_byte_data(chip->client, PCA963X_MODE1, reg);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops pca963x_pmops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(pca963x_suspend, pca963x_resume)
> +};
> +
> +#define PCA963X_SMBUS_PMOPS (&pca963x_pmops)
> +
> +#else
> +#define PCA963X_SMBUS_PMOPS NULL
> +#endif
> +
>  static const struct of_device_id of_pca963x_match[] = {
>  	{ .compatible = "nxp,pca9632", },
>  	{ .compatible = "nxp,pca9633", },
> @@ -430,6 +470,7 @@ static struct i2c_driver pca963x_driver = {
>  	.driver = {
>  		.name	= "leds-pca963x",
>  		.of_match_table = of_pca963x_match,
> +		.pm = PCA963X_SMBUS_PMOPS
>  	},
>  	.probe = pca963x_probe,
>  	.id_table = pca963x_id,
> -- 
> 2.43.0
> 

-- 
Lee Jones [李琼斯]
