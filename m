Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1D579A592
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 10:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbjIKIJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 04:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbjIKIJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:09:05 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C0812B;
        Mon, 11 Sep 2023 01:08:28 -0700 (PDT)
Received: from ideasonboard.com (mob-5-90-67-213.net.vodafone.it [5.90.67.213])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9F2A4475;
        Mon, 11 Sep 2023 10:06:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694419615;
        bh=bUPq/rMCnD0rTNCalN5ej5Gv1tldSBPD5W4GFHZFRl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q2gBYYRi7UO3rUvwi7f1KlCHPytx0XxF5WRnLbSN8hnPFws47lEv27ZKjQmd32UHl
         QNKDQr22M2KUqcTICqN+5JU00wc8Y96tgIMU34jpTIozREE7W5qGYzkyVmGqFZCdL8
         UgdpVOLu9w4pHKpRwQqsr69uxnvUhXreQKML1hO4=
Date:   Mon, 11 Sep 2023 10:08:22 +0200
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/2] media: i2c: ov7670: Extend match support for OF
 tables
Message-ID: <6yvrergos76akx42x33owvxwlye5nsgp6tgywqkfzcbmiaywhc@vx6ubzvrmtq2>
References: <20230910150033.50596-1-biju.das.jz@bp.renesas.com>
 <20230910150033.50596-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230910150033.50596-2-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Biju

On Sun, Sep 10, 2023 at 04:00:32PM +0100, Biju Das wrote:
> The driver has an OF match table, still, it uses an ID lookup table for
> retrieving match data. Currently, the driver is working on the
> assumption that an I2C device registered via OF will always match a
> legacy I2C device ID. The correct approach is to have an OF device ID
> table using i2c_get_match_data() if the devices are registered via OF/ID.
>
> Unify the OF/ID table by using struct ov7670_devtype as match data for
> both these tables and replace the ID lookup table for the match data by
> i2c_get_match_data().
>
> Split the array ov7670_devdata[] as individual variables, and
> make lines shorter by referring to e.g. &ov7670_devdata instead of
> &ov7670_devdata[MODEL_OV7670].
>
> Drop enum ov7670_model as there is no user.
>
> While at it, remove the trailing comma in the terminator entry for the OF
> table making code robust against (theoretical) misrebases or other similar
> things where the new entry goes _after_ the termination without the
> compiler noticing.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/media/i2c/ov7670.c | 47 ++++++++++++++++----------------------
>  1 file changed, 20 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/media/i2c/ov7670.c b/drivers/media/i2c/ov7670.c
> index 2f55491ef571..644457e6993d 100644
> --- a/drivers/media/i2c/ov7670.c
> +++ b/drivers/media/i2c/ov7670.c
> @@ -186,11 +186,6 @@ MODULE_PARM_DESC(debug, "Debug level (0-1)");
>  #define REG_HAECC7	0xaa	/* Hist AEC/AGC control 7 */
>  #define REG_BD60MAX	0xab	/* 60hz banding step limit */
>
> -enum ov7670_model {
> -	MODEL_OV7670 = 0,
> -	MODEL_OV7675,
> -};
> -
>  struct ov7670_win_size {
>  	int	width;
>  	int	height;
> @@ -1774,21 +1769,6 @@ static const struct v4l2_subdev_internal_ops ov7670_subdev_internal_ops = {
>
>  /* ----------------------------------------------------------------------- */
>
> -static const struct ov7670_devtype ov7670_devdata[] = {
> -	[MODEL_OV7670] = {
> -		.win_sizes = ov7670_win_sizes,
> -		.n_win_sizes = ARRAY_SIZE(ov7670_win_sizes),
> -		.set_framerate = ov7670_set_framerate_legacy,
> -		.get_framerate = ov7670_get_framerate_legacy,
> -	},
> -	[MODEL_OV7675] = {
> -		.win_sizes = ov7675_win_sizes,
> -		.n_win_sizes = ARRAY_SIZE(ov7675_win_sizes),
> -		.set_framerate = ov7675_set_framerate,
> -		.get_framerate = ov7675_get_framerate,
> -	},
> -};
> -
>  static int ov7670_init_gpio(struct i2c_client *client, struct ov7670_info *info)
>  {
>  	info->pwdn_gpio = devm_gpiod_get_optional(&client->dev, "powerdown",
> @@ -1849,7 +1829,6 @@ static int ov7670_parse_dt(struct device *dev,
>
>  static int ov7670_probe(struct i2c_client *client)
>  {
> -	const struct i2c_device_id *id = i2c_client_get_device_id(client);
>  	struct v4l2_fract tpf;
>  	struct v4l2_subdev *sd;
>  	struct ov7670_info *info;
> @@ -1923,7 +1902,7 @@ static int ov7670_probe(struct i2c_client *client)
>  	v4l_info(client, "chip found @ 0x%02x (%s)\n",
>  			client->addr << 1, client->adapter->name);
>
> -	info->devtype = &ov7670_devdata[id->driver_data];
> +	info->devtype = i2c_get_match_data(client);

I was about to complain this function is not used, but then I noticed
you just introduced it, so this is like the first user!


>  	info->fmt = &ov7670_formats[0];
>  	info->wsize = &info->devtype->win_sizes[0];
>
> @@ -2013,17 +1992,31 @@ static void ov7670_remove(struct i2c_client *client)
>  	media_entity_cleanup(&info->sd.entity);
>  }
>
> +static const struct ov7670_devtype ov7670_devdata = {
> +	.win_sizes = ov7670_win_sizes,
> +	.n_win_sizes = ARRAY_SIZE(ov7670_win_sizes),
> +	.set_framerate = ov7670_set_framerate_legacy,
> +	.get_framerate = ov7670_get_framerate_legacy,
> +};
> +
> +static const struct ov7670_devtype ov7675_devdata = {
> +	.win_sizes = ov7675_win_sizes,
> +	.n_win_sizes = ARRAY_SIZE(ov7675_win_sizes),
> +	.set_framerate = ov7675_set_framerate,
> +	.get_framerate = ov7675_get_framerate,
> +};
> +
>  static const struct i2c_device_id ov7670_id[] = {
> -	{ "ov7670", MODEL_OV7670 },
> -	{ "ov7675", MODEL_OV7675 },
> -	{ }
> +	{ "ov7670", (kernel_ulong_t)&ov7670_devdata },
> +	{ "ov7675", (kernel_ulong_t)&ov7675_devdata },
> +	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ov7670_id);
>
>  #if IS_ENABLED(CONFIG_OF)
>  static const struct of_device_id ov7670_of_match[] = {
> -	{ .compatible = "ovti,ov7670", },
> -	{ /* sentinel */ },
> +	{ .compatible = "ovti,ov7670", &ov7670_devdata },
> +	{ /* sentinel */ }

The patch looks good to me, would be nice to know if you have been
able to run-time test at least one of the drivers you have moved to
use i2c_get_match_data().

Reviewed-by: Jacopo Mondi <jacopo.mondi+renesas@ideasonboard.com>

>  };
>  MODULE_DEVICE_TABLE(of, ov7670_of_match);
>  #endif
> --
> 2.25.1
>
