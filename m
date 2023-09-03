Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C7F790DE7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 22:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347788AbjICUhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 16:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbjICUhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 16:37:15 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066D6B7
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 13:37:11 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213.211-177-91.adsl-dyn.isp.belgacom.be [91.177.211.213])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 03FAF124F;
        Sun,  3 Sep 2023 22:35:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693773343;
        bh=3Syqt4RzQElMVE3m9YlbsJMf/MMnFPd1yJeeLCFsm6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pi0badBv9oNyexedpmTr7+rbbEV+xblngLCS/jic0BXJs4wUTfX9vPCQmcUSD4UjX
         bfSbfpMMQmUE/LQ7i+bzQ4Te6pi9xMaPcYO/33Sqb84iX4Jj6z03Tk5kx7NnG301Bu
         zTOWEPb+cmeM7K7751Z1oeW7Yz9NVy0YHxGZ1Bjw=
Date:   Sun, 3 Sep 2023 23:37:19 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] regulator: max20086: Make similar OF and ID table
Message-ID: <20230903203719.GC13794@pendragon.ideasonboard.com>
References: <20230903154257.70800-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230903154257.70800-1-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Biju,

Thank you for the patch.

On Sun, Sep 03, 2023 at 04:42:57PM +0100, Biju Das wrote:
> Make similar OF and ID table to extend support for ID match using
> i2c_match_data(). Currently it works only for OF match tables as the
> driver_data is wrong for ID match.

If it's currently broken for the I2C ID table, let's drop it instead of
fixing it. We can always add it back when this device will appear on
non-OF systems, if it ever does. The max20086_dt_ids table would then
not need to be modified to extract the max20086_chip_info instances.

> While at it, drop blank lines before MODULE_DEVICE_TABLE* and remove
> trailing comma in the terminator entry for OF/ID table.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> Note:
>  This patch is only compile tested.
> 
> v1->v2:
>  * Removed trailing comma in the terminator entry for OF/ID table.
> ---
>  drivers/regulator/max20086-regulator.c | 65 ++++++++++++--------------
>  1 file changed, 31 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/regulator/max20086-regulator.c b/drivers/regulator/max20086-regulator.c
> index 32f47b896fd1..59eb23d467ec 100644
> --- a/drivers/regulator/max20086-regulator.c
> +++ b/drivers/regulator/max20086-regulator.c
> @@ -223,7 +223,7 @@ static int max20086_i2c_probe(struct i2c_client *i2c)
>  		return -ENOMEM;
>  
>  	chip->dev = &i2c->dev;
> -	chip->info = device_get_match_data(chip->dev);
> +	chip->info = i2c_get_match_data(i2c);
>  
>  	i2c_set_clientdata(i2c, chip);
>  
> @@ -275,45 +275,42 @@ static int max20086_i2c_probe(struct i2c_client *i2c)
>  	return 0;
>  }
>  
> -static const struct i2c_device_id max20086_i2c_id[] = {
> -	{ "max20086" },
> -	{ "max20087" },
> -	{ "max20088" },
> -	{ "max20089" },
> -	{ /* Sentinel */ },
> +static const struct max20086_chip_info max20086_chip_info = {
> +	.id = MAX20086_DEVICE_ID_MAX20086,
> +	.num_outputs = 4,
> +};
> +
> +static const struct max20086_chip_info max20087_chip_info = {
> +	.id = MAX20086_DEVICE_ID_MAX20087,
> +	.num_outputs = 4,
> +};
> +
> +static const struct max20086_chip_info max20088_chip_info = {
> +	.id = MAX20086_DEVICE_ID_MAX20088,
> +	.num_outputs = 2,
> +};
> +
> +static const struct max20086_chip_info max20089_chip_info = {
> +	.id = MAX20086_DEVICE_ID_MAX20089,
> +	.num_outputs = 2,
>  };
>  
> +static const struct i2c_device_id max20086_i2c_id[] = {
> +	{ "max20086", (kernel_ulong_t)&max20086_chip_info },
> +	{ "max20087", (kernel_ulong_t)&max20087_chip_info },
> +	{ "max20088", (kernel_ulong_t)&max20088_chip_info },
> +	{ "max20089", (kernel_ulong_t)&max20089_chip_info },
> +	{ /* Sentinel */ }
> +};
>  MODULE_DEVICE_TABLE(i2c, max20086_i2c_id);
>  
>  static const struct of_device_id max20086_dt_ids[] __maybe_unused = {
> -	{
> -		.compatible = "maxim,max20086",
> -		.data = &(const struct max20086_chip_info) {
> -			.id = MAX20086_DEVICE_ID_MAX20086,
> -			.num_outputs = 4,
> -		}
> -	}, {
> -		.compatible = "maxim,max20087",
> -		.data = &(const struct max20086_chip_info) {
> -			.id = MAX20086_DEVICE_ID_MAX20087,
> -			.num_outputs = 4,
> -		}
> -	}, {
> -		.compatible = "maxim,max20088",
> -		.data = &(const struct max20086_chip_info) {
> -			.id = MAX20086_DEVICE_ID_MAX20088,
> -			.num_outputs = 2,
> -		}
> -	}, {
> -		.compatible = "maxim,max20089",
> -		.data = &(const struct max20086_chip_info) {
> -			.id = MAX20086_DEVICE_ID_MAX20089,
> -			.num_outputs = 2,
> -		}
> -	},
> -	{ /* Sentinel */ },
> +	{ .compatible = "maxim,max20086", .data = &max20086_chip_info },
> +	{ .compatible = "maxim,max20087", .data = &max20087_chip_info },
> +	{ .compatible = "maxim,max20088", .data = &max20088_chip_info },
> +	{ .compatible = "maxim,max20089", .data = &max20089_chip_info },
> +	{ /* Sentinel */ }
>  };
> -
>  MODULE_DEVICE_TABLE(of, max20086_dt_ids);
>  
>  static struct i2c_driver max20086_regulator_driver = {

-- 
Regards,

Laurent Pinchart
