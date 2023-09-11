Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B468479BD34
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344324AbjIKVNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbjIKJXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:23:40 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AC8CD3;
        Mon, 11 Sep 2023 02:23:36 -0700 (PDT)
Received: from ideasonboard.com (mob-5-90-67-213.net.vodafone.it [5.90.67.213])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1ED639D5;
        Mon, 11 Sep 2023 11:22:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694424124;
        bh=10Op016e24YbHBoh5oTwtjeE1FfF3dhBUviHYQrKAg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dy4ltQ5NGPE2Tu12u6L4m4SLuSL5p063f1+EjUIZDuTVZEXhDpOqOER57aoNWue2b
         ZlTxrNHEFtLs8cJnqf71X08E0XRUWKK7Nx4fgBKZqMgYBSlewdWflMC2Cmyjz83T0y
         Xf5dJ/GLPE31uYgjq8a5TrxR5YdHADTcCq5esHMg=
Date:   Mon, 11 Sep 2023 11:23:31 +0200
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/2] media: tvp541x: Extend match support for OF tables
Message-ID: <qhe7q6lpoey266iprugqjc2mdsc6wf7rz2e4o72pcpjoxhkdp5@ij47vwvjcxmh>
References: <20230910174051.85070-1-biju.das.jz@bp.renesas.com>
 <20230910174051.85070-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230910174051.85070-2-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Biju

On Sun, Sep 10, 2023 at 06:40:50PM +0100, Biju Das wrote:
> The driver has an OF match table, still, it uses an ID lookup table for
> retrieving match data. Currently, the driver is working on the
> assumption that an I2C device registered via OF will always match a
> legacy I2C device ID. The correct approach is to have an OF device ID
> table using i2c_get_match_data() if the devices are registered via OF/ID.
>
> Unify the OF/ID table by using tvp514x_reg as match data for both
> these tables and replace the ID lookup table for the match data by
> i2c_get_match_data() and simplifly probe().
>
> While at it, remove the trailing comma in the terminator entry for the OF
> table making code robust against (theoretical) misrebases or other similar
> things where the new entry goes _after_ the termination without the
> compiler noticing.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Jacopo Mondi <jacopo.mondi+renesas@ideasonboard.com>

Thanks
  j

> ---
>  drivers/media/i2c/tvp514x.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/media/i2c/tvp514x.c b/drivers/media/i2c/tvp514x.c
> index aa6d4b67b6d5..4d0ffaa312c5 100644
> --- a/drivers/media/i2c/tvp514x.c
> +++ b/drivers/media/i2c/tvp514x.c
> @@ -118,7 +118,7 @@ struct tvp514x_decoder {
>  	struct media_pad pad;
>  	struct v4l2_mbus_framefmt format;
>
> -	struct tvp514x_reg *int_seq;
> +	const struct tvp514x_reg *int_seq;
>  };
>
>  /* TVP514x default register values */
> @@ -1024,7 +1024,6 @@ tvp514x_get_pdata(struct i2c_client *client)
>  static int
>  tvp514x_probe(struct i2c_client *client)
>  {
> -	const struct i2c_device_id *id = i2c_client_get_device_id(client);
>  	struct tvp514x_platform_data *pdata = tvp514x_get_pdata(client);
>  	struct tvp514x_decoder *decoder;
>  	struct v4l2_subdev *sd;
> @@ -1049,7 +1048,7 @@ tvp514x_probe(struct i2c_client *client)
>  	memcpy(decoder->tvp514x_regs, tvp514x_reg_list_default,
>  			sizeof(tvp514x_reg_list_default));
>
> -	decoder->int_seq = (struct tvp514x_reg *)id->driver_data;
> +	decoder->int_seq = i2c_get_match_data(client);
>
>  	/* Copy board specific information here */
>  	decoder->pdata = pdata;
> @@ -1183,22 +1182,21 @@ static const struct tvp514x_reg tvp514xm_init_reg_seq[] = {
>   * driver_data - Driver data
>   */
>  static const struct i2c_device_id tvp514x_id[] = {
> -	{"tvp5146", (unsigned long)tvp5146_init_reg_seq},
> -	{"tvp5146m2", (unsigned long)tvp514xm_init_reg_seq},
> -	{"tvp5147", (unsigned long)tvp5147_init_reg_seq},
> -	{"tvp5147m1", (unsigned long)tvp514xm_init_reg_seq},
> -	{},
> +	{"tvp5146", (kernel_ulong_t)tvp5146_init_reg_seq },
> +	{"tvp5146m2", (kernel_ulong_t)tvp514xm_init_reg_seq },
> +	{"tvp5147", (kernel_ulong_t)tvp5147_init_reg_seq },
> +	{"tvp5147m1", (kernel_ulong_t)tvp514xm_init_reg_seq },
> +	{ /* sentinel */ }
>  };
> -
>  MODULE_DEVICE_TABLE(i2c, tvp514x_id);
>
>  #if IS_ENABLED(CONFIG_OF)
>  static const struct of_device_id tvp514x_of_match[] = {
> -	{ .compatible = "ti,tvp5146", },
> -	{ .compatible = "ti,tvp5146m2", },
> -	{ .compatible = "ti,tvp5147", },
> -	{ .compatible = "ti,tvp5147m1", },
> -	{ /* sentinel */ },
> +	{ .compatible = "ti,tvp5146", .data = tvp5146_init_reg_seq },
> +	{ .compatible = "ti,tvp5146m2", .data = tvp514xm_init_reg_seq },
> +	{ .compatible = "ti,tvp5147", .data = tvp5147_init_reg_seq },
> +	{ .compatible = "ti,tvp5147m1", .data = tvp514xm_init_reg_seq },
> +	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, tvp514x_of_match);
>  #endif
> --
> 2.25.1
>
