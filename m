Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706C179B575
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241835AbjIKU5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbjIKJOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:14:17 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918CBCCD;
        Mon, 11 Sep 2023 02:14:11 -0700 (PDT)
Received: from ideasonboard.com (mob-5-90-67-213.net.vodafone.it [5.90.67.213])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0B4689D5;
        Mon, 11 Sep 2023 11:12:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694423559;
        bh=PQvgBMFVfg9p0JkaGeZRDd/KuQauwd1zf6vIWL9FQFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=teWm55eaNuD4/5A3smPnlFZTavXt0xP4a3VMtTKdgRLcJZgWNmFC7qAwkzwQf57xG
         mujiE/ZDuk8o3PQAF0j96xzJVvWzBGES1A4ZwT+xDNSXPQiuOgy9ipetdnltAR4Is6
         qT/IqTBPLYC4yqOquDpBczSIRrwicDsxI3+4hP4U=
Date:   Mon, 11 Sep 2023 11:14:06 +0200
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/2] media: i2c: mt9v032: Extend match support for OF
 tables
Message-ID: <zikxzzjvfcrxdvjkx3sfu3hpkpd26k3empbqakx2ko35vw2tpo@zzvnnnhmbwl4>
References: <20230910165432.76378-1-biju.das.jz@bp.renesas.com>
 <20230910165432.76378-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230910165432.76378-2-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Biju

On Sun, Sep 10, 2023 at 05:54:31PM +0100, Biju Das wrote:
> The driver has an OF match table, still, it uses an ID lookup table for
> retrieving match data. Currently, the driver is working on the
> assumption that an I2C device registered via OF will always match a
> legacy I2C device ID. The correct approach is to have an OF device ID
> table using i2c_get_match_data() if the devices are registered via OF/ID.
>
> Unify the OF/ID table by using mt9v032_model_info as match data for both

s/Unify/Align ? As the tables are still separate..

> these tables and replace the ID lookup table for the match data by
> i2c_get_match_data() and simplifly probe().
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Jacopo Mondi <jacopo.mondi+renesas@ideasonboard.com>

Thanks
  j


> ---
>  drivers/media/i2c/mt9v032.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/media/i2c/mt9v032.c b/drivers/media/i2c/mt9v032.c
> index 00e7bc6e3235..0f448aa27e53 100644
> --- a/drivers/media/i2c/mt9v032.c
> +++ b/drivers/media/i2c/mt9v032.c
> @@ -1046,7 +1046,6 @@ mt9v032_get_pdata(struct i2c_client *client)
>
>  static int mt9v032_probe(struct i2c_client *client)
>  {
> -	const struct i2c_device_id *did = i2c_client_get_device_id(client);
>  	struct mt9v032_platform_data *pdata = mt9v032_get_pdata(client);
>  	struct mt9v032 *mt9v032;
>  	unsigned int i;
> @@ -1076,7 +1075,7 @@ static int mt9v032_probe(struct i2c_client *client)
>
>  	mutex_init(&mt9v032->power_lock);
>  	mt9v032->pdata = pdata;
> -	mt9v032->model = (const void *)did->driver_data;
> +	mt9v032->model = i2c_get_match_data(client);
>
>  	v4l2_ctrl_handler_init(&mt9v032->ctrls, 11 +
>  			       ARRAY_SIZE(mt9v032_aegc_controls));
> @@ -1272,20 +1271,20 @@ static const struct i2c_device_id mt9v032_id[] = {
>  	{ "mt9v032m", (kernel_ulong_t)&mt9v032_models[MT9V032_MODEL_V032_MONO] },
>  	{ "mt9v034", (kernel_ulong_t)&mt9v032_models[MT9V032_MODEL_V034_COLOR] },
>  	{ "mt9v034m", (kernel_ulong_t)&mt9v032_models[MT9V032_MODEL_V034_MONO] },
> -	{ }
> +	{ /* Sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(i2c, mt9v032_id);
>
>  #if IS_ENABLED(CONFIG_OF)
>  static const struct of_device_id mt9v032_of_match[] = {
> -	{ .compatible = "aptina,mt9v022" },
> -	{ .compatible = "aptina,mt9v022m" },
> -	{ .compatible = "aptina,mt9v024" },
> -	{ .compatible = "aptina,mt9v024m" },
> -	{ .compatible = "aptina,mt9v032" },
> -	{ .compatible = "aptina,mt9v032m" },
> -	{ .compatible = "aptina,mt9v034" },
> -	{ .compatible = "aptina,mt9v034m" },
> +	{ .compatible = "aptina,mt9v022", .data = &mt9v032_models[MT9V032_MODEL_V022_COLOR] },
> +	{ .compatible = "aptina,mt9v022m", .data = &mt9v032_models[MT9V032_MODEL_V022_MONO] },
> +	{ .compatible = "aptina,mt9v024", .data = &mt9v032_models[MT9V032_MODEL_V024_COLOR] },
> +	{ .compatible = "aptina,mt9v024m", .data = &mt9v032_models[MT9V032_MODEL_V024_MONO] },
> +	{ .compatible = "aptina,mt9v032", .data = &mt9v032_models[MT9V032_MODEL_V032_COLOR] },
> +	{ .compatible = "aptina,mt9v032m", .data = &mt9v032_models[MT9V032_MODEL_V032_MONO] },
> +	{ .compatible = "aptina,mt9v034", .data = &mt9v032_models[MT9V032_MODEL_V034_COLOR] },
> +	{ .compatible = "aptina,mt9v034m", .data = &mt9v032_models[MT9V032_MODEL_V034_MONO] },
>  	{ /* Sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, mt9v032_of_match);
> --
> 2.25.1
>
