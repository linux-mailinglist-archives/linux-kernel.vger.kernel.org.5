Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D616176F4CB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 23:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjHCVqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 17:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjHCVqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 17:46:44 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14EB30F6;
        Thu,  3 Aug 2023 14:46:42 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 360CD2CF;
        Thu,  3 Aug 2023 23:45:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1691099136;
        bh=zy94nhAkVOenwdKf6tH4n6dWK6GQVb/Axh3wAY+sReQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t8VmNLKSA4SV+PLH71xBfI1eWKXVgb2NI0eqEwBRC2cLOJwBGZx2ZUKEqxz7UxuxK
         cMOnpTv+9d5a2pouGYGULn+yntOzaejMsDzNisQjut9rRuDJrkAijq8dIGQ63Y4nMI
         02BAi/pnpeVDrTyEXUTfTv/qX2NsxMbJye6hAyWY=
Date:   Fri, 4 Aug 2023 00:46:46 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] media: i2c: ds90ub9x3: Fix use of uninitialized
 variables
Message-ID: <20230803214646.GG27752@pendragon.ideasonboard.com>
References: <20230803-ub9xx-uninit-vars-v1-0-284a5455260f@ideasonboard.com>
 <20230803-ub9xx-uninit-vars-v1-1-284a5455260f@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230803-ub9xx-uninit-vars-v1-1-284a5455260f@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi,

Thank you for the patch.

On Thu, Aug 03, 2023 at 11:41:38AM +0300, Tomi Valkeinen wrote:
> smatch reports some uninitialized variables:
> 
> drivers/media/i2c/ds90ub913.c:481 ub913_log_status() error: uninitialized symbol 'v1'.
> drivers/media/i2c/ds90ub913.c:481 ub913_log_status() error: uninitialized symbol 'v2'.
> drivers/media/i2c/ds90ub953.c:655 ub953_log_status() error: uninitialized symbol 'gpio_local_data'.
> drivers/media/i2c/ds90ub953.c:655 ub953_log_status() error: uninitialized symbol 'gpio_input_ctrl'.
> drivers/media/i2c/ds90ub953.c:655 ub953_log_status() error: uninitialized symbol 'gpio_pin_sts'.
> 
> These are used only for printing debug information, and the use of an
> uninitialized variable only happens if an i2c transaction has failed,
> which will print an error. Thus, fix the errors just by initializing the
> variables to 0.
> 
> Fixes: 6363db1c9d45 ("media: i2c: add DS90UB953 driver")
> Fixes: c158d0d4ff15 ("media: i2c: add DS90UB913 driver")
> Reported-by: Hans Verkuil <hverkuil@xs4all.nl>
> Closes: https://lore.kernel.org/all/8d6daeb1-b62a-bbb2-b840-8759c84f2085@xs4all.nl/
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/media/i2c/ds90ub913.c | 2 +-
>  drivers/media/i2c/ds90ub953.c | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/i2c/ds90ub913.c b/drivers/media/i2c/ds90ub913.c
> index 80d9cf6dd945..b2115e3519e2 100644
> --- a/drivers/media/i2c/ds90ub913.c
> +++ b/drivers/media/i2c/ds90ub913.c
> @@ -469,7 +469,7 @@ static int ub913_log_status(struct v4l2_subdev *sd)
>  {
>  	struct ub913_data *priv = sd_to_ub913(sd);
>  	struct device *dev = &priv->client->dev;
> -	u8 v = 0, v1, v2;
> +	u8 v = 0, v1 = 0, v2 = 0;

This seems to work around the lack of error checking when calling
ub913_read(). Wouldn't it be better to check for errors there ? Or,
because this is ub913_log_status(), do you consider that we can print an
invalid CRC errors count, given that the ub913_read() function will have
printed an error message before ?

>  
>  	ub913_read(priv, UB913_REG_MODE_SEL, &v);
>  	dev_info(dev, "MODE_SEL %#02x\n", v);
> diff --git a/drivers/media/i2c/ds90ub953.c b/drivers/media/i2c/ds90ub953.c
> index cadf75eb0773..27471249a62a 100644
> --- a/drivers/media/i2c/ds90ub953.c
> +++ b/drivers/media/i2c/ds90ub953.c
> @@ -593,9 +593,9 @@ static int ub953_log_status(struct v4l2_subdev *sd)
>  	u8 v = 0, v1 = 0, v2 = 0;
>  	unsigned int i;
>  	char id[UB953_REG_FPD3_RX_ID_LEN];
> -	u8 gpio_local_data;
> -	u8 gpio_input_ctrl;
> -	u8 gpio_pin_sts;
> +	u8 gpio_local_data = 0;
> +	u8 gpio_input_ctrl = 0;
> +	u8 gpio_pin_sts = 0;
>  
>  	for (i = 0; i < sizeof(id); i++)
>  		ub953_read(priv, UB953_REG_FPD3_RX_ID(i), &id[i]);
> 

-- 
Regards,

Laurent Pinchart
