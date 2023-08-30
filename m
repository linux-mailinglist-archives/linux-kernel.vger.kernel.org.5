Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4234378D924
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjH3Sc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242110AbjH3HTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:19:25 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926441BB;
        Wed, 30 Aug 2023 00:19:22 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 34C654E6;
        Wed, 30 Aug 2023 09:17:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693379877;
        bh=ebYMIXSud5++a5TF9waHihcGKaRw+z3M0sYuJ7iKXlE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IoFOVVsZvrsw3nPoP4ayfGt6FAoG8dZHmmBaxx1AUkRVnE+T5vPNOxTB2yrPoWgmY
         rLaDciZw3GEYUZXsljjBFHJ8bXvCBsSUBFoY6C68qL6I8X29xbsFWWUTbqGqcNVte4
         hPD7E2UFKSE3ccvymA+oojg4RufaQEhEVp6LJEug=
Date:   Wed, 30 Aug 2023 10:19:29 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: Re: [PATCH 1/2] media: i2c: imx214: Use v4l2_subdev_get_fmt()
Message-ID: <20230830071929.GI6477@pendragon.ideasonboard.com>
References: <20230830045323.71768-1-umang.jain@ideasonboard.com>
 <20230830045323.71768-2-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230830045323.71768-2-umang.jain@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 10:23:22AM +0530, Umang Jain wrote:
> The imx214 driver uses the subdev active state, there's no

Does it ? I don't see a call to v4l2_subdev_init_finalize(), and the
imx214 struct has fmt and crop fields in which it stores the active
format.

> need to implement the .get_fmt() operation manually. Use the
> v4l2_subdev_get_fmt() helper instead.
> 
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  drivers/media/i2c/imx214.c | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/drivers/media/i2c/imx214.c b/drivers/media/i2c/imx214.c
> index 2f9c8582f940..d8bdc52f552a 100644
> --- a/drivers/media/i2c/imx214.c
> +++ b/drivers/media/i2c/imx214.c
> @@ -548,21 +548,6 @@ __imx214_get_pad_format(struct imx214 *imx214,
>  	}
>  }
>  
> -static int imx214_get_format(struct v4l2_subdev *sd,
> -			     struct v4l2_subdev_state *sd_state,
> -			     struct v4l2_subdev_format *format)
> -{
> -	struct imx214 *imx214 = to_imx214(sd);
> -
> -	mutex_lock(&imx214->mutex);
> -	format->format = *__imx214_get_pad_format(imx214, sd_state,
> -						  format->pad,
> -						  format->which);
> -	mutex_unlock(&imx214->mutex);
> -
> -	return 0;
> -}
> -
>  static struct v4l2_rect *
>  __imx214_get_pad_crop(struct imx214 *imx214,
>  		      struct v4l2_subdev_state *sd_state,
> @@ -842,7 +827,7 @@ static const struct v4l2_subdev_pad_ops imx214_subdev_pad_ops = {
>  	.enum_mbus_code = imx214_enum_mbus_code,
>  	.enum_frame_size = imx214_enum_frame_size,
>  	.enum_frame_interval = imx214_enum_frame_interval,
> -	.get_fmt = imx214_get_format,
> +	.get_fmt = v4l2_subdev_get_fmt,
>  	.set_fmt = imx214_set_format,
>  	.get_selection = imx214_get_selection,
>  	.init_cfg = imx214_entity_init_cfg,

-- 
Regards,

Laurent Pinchart
