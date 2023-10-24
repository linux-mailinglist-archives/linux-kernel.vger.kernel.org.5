Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29277D4863
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 09:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbjJXHWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 03:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbjJXHWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 03:22:45 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D670CA6;
        Tue, 24 Oct 2023 00:22:41 -0700 (PDT)
Received: from ideasonboard.com (93-61-96-190.ip145.fastwebnet.it [93.61.96.190])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 633E2B53;
        Tue, 24 Oct 2023 09:22:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1698132149;
        bh=1OJ+UP1AFg7UjqMyj3WVyBs8U6OqMpmbSzaYrKuhgKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VmRXptrG9HkvYnSGB8LNFItDphjqe8fbi1ipeoLM37sT80Uk/KoGqLQvtsaCG8yhr
         vE3X0+awEjCVLASuA3CyfPNwQn42Vnv+dCflQPr8JE4A07EIJ6DVl1F/HJRuyAc/at
         LEoEf9bftAQzdkH7dP5vb7p6dQZTgTz4JaCgQOnM=
Date:   Tue, 24 Oct 2023 09:22:37 +0200
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     =?utf-8?B?QW5kcsOp?= Apitzsch <git@apitzsch.eu>
Cc:     Ricardo Ribalda <ribalda@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 2/4] media: i2c: imx214: Move controls init to separate
 function
Message-ID: <kdp6brzqdllnyokwsalkpsbjl6cfnpv62gojfp3xoilsurphke@qqqa4gufb7xf>
References: <20231023-imx214-v1-0-b33f1bbd1fcf@apitzsch.eu>
 <20231023-imx214-v1-2-b33f1bbd1fcf@apitzsch.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231023-imx214-v1-2-b33f1bbd1fcf@apitzsch.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre'

On Mon, Oct 23, 2023 at 11:47:51PM +0200, André Apitzsch wrote:
> Code refinement, no functional changes.
>
> Signed-off-by: André Apitzsch <git@apitzsch.eu>
> ---
>  drivers/media/i2c/imx214.c | 111 ++++++++++++++++++++++++++-------------------
>  1 file changed, 64 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/media/i2c/imx214.c b/drivers/media/i2c/imx214.c
> index 9218c149d4c8..554fc4733128 100644
> --- a/drivers/media/i2c/imx214.c
> +++ b/drivers/media/i2c/imx214.c
> @@ -695,6 +695,68 @@ static const struct v4l2_ctrl_ops imx214_ctrl_ops = {
>  	.s_ctrl = imx214_set_ctrl,
>  };
>
> +static int imx214_ctrls_init(struct imx214 *imx214)
> +{
> +	static const s64 link_freq[] = {
> +		IMX214_DEFAULT_LINK_FREQ
> +	};
> +	static const struct v4l2_area unit_size = {
> +		.width = 1120,
> +		.height = 1120,
> +	};
> +	struct v4l2_ctrl_handler *ctrl_hdlr;
> +	int ret;
> +
> +	ctrl_hdlr = &imx214->ctrls;
> +	ret = v4l2_ctrl_handler_init(&imx214->ctrls, 3);

I know it was already like this, but you could take occasion to
pre-allocate enough control slots. I count 4 here, plus the 2 parsed
from system firware in the next patch.

You can change this here and mention it in the commit message or with
a separate patch on top. Up to you!


> +	if (ret)
> +		return ret;
> +
> +	imx214->pixel_rate = v4l2_ctrl_new_std(ctrl_hdlr, NULL,
> +					       V4L2_CID_PIXEL_RATE, 0,
> +					       IMX214_DEFAULT_PIXEL_RATE, 1,
> +					       IMX214_DEFAULT_PIXEL_RATE);
> +
> +	imx214->link_freq = v4l2_ctrl_new_int_menu(ctrl_hdlr, NULL,
> +						   V4L2_CID_LINK_FREQ,
> +						   ARRAY_SIZE(link_freq) - 1,
> +						   0, link_freq);
> +	if (imx214->link_freq)
> +		imx214->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
> +
> +	/*
> +	 * WARNING!
> +	 * Values obtained reverse engineering blobs and/or devices.
> +	 * Ranges and functionality might be wrong.
> +	 *
> +	 * Sony, please release some register set documentation for the
> +	 * device.
> +	 *
> +	 * Yours sincerely, Ricardo.
> +	 */
> +	imx214->exposure = v4l2_ctrl_new_std(ctrl_hdlr, &imx214_ctrl_ops,
> +					     V4L2_CID_EXPOSURE,
> +					     IMX214_EXPOSURE_MIN,
> +					     IMX214_EXPOSURE_MAX,
> +					     IMX214_EXPOSURE_STEP,
> +					     IMX214_EXPOSURE_DEFAULT);
> +
> +	imx214->unit_size = v4l2_ctrl_new_std_compound(ctrl_hdlr,
> +				NULL,
> +				V4L2_CID_UNIT_CELL_SIZE,
> +				v4l2_ctrl_ptr_create((void *)&unit_size));
> +
> +	ret = ctrl_hdlr->error;
> +	if (ret) {
> +		v4l2_ctrl_handler_free(ctrl_hdlr);
> +		return dev_err_probe(imx214->dev, ret, "failed to add controls\n");

dev_err_probe won't help I think, or could ctrl_hdr->error be
-EPROBE_DEFER ? Not a big deal though!

All minor comments, with these addressed
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

Thanks
  j


> +	}
> +
> +	imx214->sd.ctrl_handler = ctrl_hdlr;
> +
> +	return 0;
> +};
> +
>  #define MAX_CMD 4
>  static int imx214_write_table(struct imx214 *imx214,
>  			      const struct reg_8 table[])
> @@ -918,13 +980,6 @@ static int imx214_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct imx214 *imx214;
> -	static const s64 link_freq[] = {
> -		IMX214_DEFAULT_LINK_FREQ,
> -	};
> -	static const struct v4l2_area unit_size = {
> -		.width = 1120,
> -		.height = 1120,
> -	};
>  	int ret;
>
>  	ret = imx214_parse_fwnode(dev);
> @@ -979,48 +1034,10 @@ static int imx214_probe(struct i2c_client *client)
>  	pm_runtime_enable(imx214->dev);
>  	pm_runtime_idle(imx214->dev);
>
> -	v4l2_ctrl_handler_init(&imx214->ctrls, 3);
> -
> -	imx214->pixel_rate = v4l2_ctrl_new_std(&imx214->ctrls, NULL,
> -					       V4L2_CID_PIXEL_RATE, 0,
> -					       IMX214_DEFAULT_PIXEL_RATE, 1,
> -					       IMX214_DEFAULT_PIXEL_RATE);
> -	imx214->link_freq = v4l2_ctrl_new_int_menu(&imx214->ctrls, NULL,
> -						   V4L2_CID_LINK_FREQ,
> -						   ARRAY_SIZE(link_freq) - 1,
> -						   0, link_freq);
> -	if (imx214->link_freq)
> -		imx214->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
> -
> -	/*
> -	 * WARNING!
> -	 * Values obtained reverse engineering blobs and/or devices.
> -	 * Ranges and functionality might be wrong.
> -	 *
> -	 * Sony, please release some register set documentation for the
> -	 * device.
> -	 *
> -	 * Yours sincerely, Ricardo.
> -	 */
> -	imx214->exposure = v4l2_ctrl_new_std(ctrl_hdlr, &imx214_ctrl_ops,
> -					     V4L2_CID_EXPOSURE,
> -					     IMX214_EXPOSURE_MIN,
> -					     IMX214_EXPOSURE_MAX,
> -					     IMX214_EXPOSURE_STEP,
> -					     IMX214_EXPOSURE_DEFAULT);
> -
> -	imx214->unit_size = v4l2_ctrl_new_std_compound(&imx214->ctrls,
> -				NULL,
> -				V4L2_CID_UNIT_CELL_SIZE,
> -				v4l2_ctrl_ptr_create((void *)&unit_size));
> -	ret = imx214->ctrls.error;
> -	if (ret) {
> -		dev_err(&client->dev, "%s control init failed (%d)\n",
> -			__func__, ret);
> +	ret = imx214_ctrls_init(imx214);
> +	if (ret < 0)
>  		goto free_ctrl;
> -	}
>
> -	imx214->sd.ctrl_handler = &imx214->ctrls;
>  	mutex_init(&imx214->mutex);
>  	imx214->ctrls.lock = &imx214->mutex;
>
>
> --
> 2.42.0
>
