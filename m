Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35F077FC76
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353798AbjHQRDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353806AbjHQRC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:02:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301AF2D72
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:02:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE18462A46
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 17:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063C4C433C8;
        Thu, 17 Aug 2023 17:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692291747;
        bh=+KQ89hvzJjJz94xMs0/u8k1ZzeYX9RfNSYrMe60V3Ns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BRfOiaSY+b3WobepTSO5wm9H44z7qK4ARX9fihXXqOGNXTAXSU6Le5TT43jPEQPDV
         5HOg58rNEMRz29/Kt8ZQN2Q+Jokxj+x9r5wOtgSsyLbHghi867B4AAOV8Bk5T1e3zL
         KYqtI7+R14HYNU7iu/n4eF57jWTmFICbKYb3ZPUDTRpS7LxJYuT+s1TyGBqvJPu5pu
         0d6r8VMKGqY9bIFixPb9+7NdAn5kgL0znZ4paY8HBVbPUyfD8oazcQsgbhZ6tJPGBq
         /R3TtzqifCJmbjk311fiGgnjyjeZzsoo2CpYG/9vm1+nsbdXxG42MXeLXP4hCQok1H
         15ZkOVsphtnFQ==
Date:   Thu, 17 Aug 2023 18:02:23 +0100
From:   Lee Jones <lee@kernel.org>
To:     werneazc@gmail.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>
Subject: Re: [PATCH 1/2] mfd: (tps65086): Read DEVICE ID register 1 from
 device
Message-ID: <20230817170223.GI986605@google.com>
References: <20230809101429.7885-1-andre.werner@systec-electronic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230809101429.7885-1-andre.werner@systec-electronic.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Aug 2023, werneazc@gmail.com wrote:

> From: Andre Werner <andre.werner@systec-electronic.com>
> 
> This commit prepares a following commit for the regulator part of the MFD.
> The driver should support different device chips that differ in their
> register definitions, for instance to control LDOA1 and SWB2.
> So it is necessary to use a dedicated regulator description for a
> specific device variant. Thus, the content from DEVICEID Register 1 is
> used to choose a dedicated configuration between the different device
> variants.
> 
> Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
> ---
>  drivers/mfd/tps65086.c       | 37 ++++++++++++++++++++++++++++++------
>  include/linux/mfd/tps65086.h | 27 ++++++++++++++++++++------
>  2 files changed, 52 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mfd/tps65086.c b/drivers/mfd/tps65086.c
> index 6a21000aad4a..38f8572c265e 100644
> --- a/drivers/mfd/tps65086.c
> +++ b/drivers/mfd/tps65086.c
> @@ -64,7 +64,7 @@ MODULE_DEVICE_TABLE(of, tps65086_of_match_table);
>  static int tps65086_probe(struct i2c_client *client)
>  {
>  	struct tps65086 *tps;
> -	unsigned int version;
> +	unsigned int version, id;
>  	int ret;
>  
>  	tps = devm_kzalloc(&client->dev, sizeof(*tps), GFP_KERNEL);
> @@ -81,16 +81,41 @@ static int tps65086_probe(struct i2c_client *client)
>  		return PTR_ERR(tps->regmap);
>  	}
>  
> -	ret = regmap_read(tps->regmap, TPS65086_DEVICEID, &version);
> +	ret = regmap_read(tps->regmap, TPS65086_DEVICEID1, &id);
>  	if (ret) {
> -		dev_err(tps->dev, "Failed to read revision register\n");
> +		dev_err(tps->dev, "Failed to read revision register 1\n");
> +		return ret;
> +	}
> +
> +	/* Store device ID to load regulator configuration that fit to IC variant */
> +	switch (id) {
> +	case TPS6508640_ID:
> +		tps->chip_id = TPS6508640;

Why not use the meaningful TPS6508640_ID for the chip_id instead of an
arbitrary enum?

> +		break;
> +	case TPS65086401_ID:
> +		tps->chip_id = TPS65086401;
> +		break;
> +	case TPS6508641_ID:
> +		tps->chip_id = TPS6508641;
> +		break;
> +	case TPS65086470_ID:
> +		tps->chip_id = TPS65086470;
> +		break;
> +	default:
> +		dev_err(tps->dev, "Unknown device ID. Cannot determine regulator config.\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = regmap_read(tps->regmap, TPS65086_DEVICEID2, &version);
> +	if (ret) {
> +		dev_err(tps->dev, "Failed to read revision register 2\n");
>  		return ret;
>  	}
>  
>  	dev_info(tps->dev, "Device: TPS65086%01lX, OTP: %c, Rev: %ld\n",
> -		 (version & TPS65086_DEVICEID_PART_MASK),
> -		 (char)((version & TPS65086_DEVICEID_OTP_MASK) >> 4) + 'A',
> -		 (version & TPS65086_DEVICEID_REV_MASK) >> 6);
> +		 (version & TPS65086_DEVICEID2_PART_MASK),
> +		 (char)((version & TPS65086_DEVICEID2_OTP_MASK) >> 4) + 'A',
> +		 (version & TPS65086_DEVICEID2_REV_MASK) >> 6);
>  
>  	if (tps->irq > 0) {
>  		ret = regmap_add_irq_chip(tps->regmap, tps->irq, IRQF_ONESHOT, 0,
> diff --git a/include/linux/mfd/tps65086.h b/include/linux/mfd/tps65086.h
> index 16f87cccc003..88df344b38df 100644
> --- a/include/linux/mfd/tps65086.h
> +++ b/include/linux/mfd/tps65086.h
> @@ -13,8 +13,9 @@
>  #include <linux/regmap.h>
>  
>  /* List of registers for TPS65086 */
> -#define TPS65086_DEVICEID		0x01
> -#define TPS65086_IRQ			0x02
> +#define TPS65086_DEVICEID1		0x00
> +#define TPS65086_DEVICEID2		0x01
> +#define TPS65086_IRQ		0x02
>  #define TPS65086_IRQ_MASK		0x03
>  #define TPS65086_PMICSTAT		0x04
>  #define TPS65086_SHUTDNSRC		0x05
> @@ -75,16 +76,29 @@
>  #define TPS65086_IRQ_SHUTDN_MASK	BIT(3)
>  #define TPS65086_IRQ_FAULT_MASK		BIT(7)
>  
> -/* DEVICEID Register field definitions */
> -#define TPS65086_DEVICEID_PART_MASK	GENMASK(3, 0)
> -#define TPS65086_DEVICEID_OTP_MASK	GENMASK(5, 4)
> -#define TPS65086_DEVICEID_REV_MASK	GENMASK(7, 6)
> +/* DEVICEID1 Register field definitions */
> +#define TPS6508640_ID			0x00
> +#define TPS65086401_ID			0x01
> +#define TPS6508641_ID			0x10
> +#define TPS65086470_ID			0x70
> +
> +/* DEVICEID2 Register field definitions */
> +#define TPS65086_DEVICEID2_PART_MASK	GENMASK(3, 0)
> +#define TPS65086_DEVICEID2_OTP_MASK	GENMASK(5, 4)
> +#define TPS65086_DEVICEID2_REV_MASK	GENMASK(7, 6)
>  
>  /* VID Masks */
>  #define BUCK_VID_MASK			GENMASK(7, 1)
>  #define VDOA1_VID_MASK			GENMASK(4, 1)
>  #define VDOA23_VID_MASK			GENMASK(3, 0)
>  
> +enum tps65086_ids {
> +	TPS6508640,
> +	TPS65086401,
> +	TPS6508641,
> +	TPS65086470,
> +};
> +
>  /* Define the TPS65086 IRQ numbers */
>  enum tps65086_irqs {
>  	TPS65086_IRQ_DIETEMP,
> @@ -100,6 +114,7 @@ enum tps65086_irqs {
>  struct tps65086 {
>  	struct device *dev;
>  	struct regmap *regmap;
> +	unsigned int chip_id;
>  
>  	/* IRQ Data */
>  	int irq;
> -- 
> 2.41.0
> 

-- 
Lee Jones [李琼斯]
