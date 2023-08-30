Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7FF78DFD1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbjH3TGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242163AbjH3HUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:20:42 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1D5CE7;
        Wed, 30 Aug 2023 00:20:38 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 740DA4E6;
        Wed, 30 Aug 2023 09:19:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693379955;
        bh=YynOPe7GJ1pEydbC/IRziS1v7VAAof8QC8uKJjmlKhE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WFQSSEoj1j5u/gEIUWAOPLiCyLXMGsDevvhZtmJrT4K9QyY7pHuOSdGfHqdi6i+dR
         H6M0vpVC/GeNzKw7AGOzfkO2C6btvQdsO/PlBTT8cY4AUi0IMIGSqbAreN2xlziC+N
         fFW0n51RdoSfF0110UJkedlc5n2Ka5jKjP1nbiOc=
Date:   Wed, 30 Aug 2023 10:20:47 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: Re: [PATCH 2/2] media: i2c: imx415: Use v4l2_subdev_get_fmt()
Message-ID: <20230830072047.GJ6477@pendragon.ideasonboard.com>
References: <20230830045323.71768-1-umang.jain@ideasonboard.com>
 <20230830045323.71768-3-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230830045323.71768-3-umang.jain@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

Thank you for the patch.

On Wed, Aug 30, 2023 at 10:23:23AM +0530, Umang Jain wrote:
> The imx415 driver uses the subdev active state, there's
> no need to implement the .get_fmt() operation manually. Use
> the v4l2_subdev_get_fmt() helper instead.
> 
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/i2c/imx415.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/media/i2c/imx415.c b/drivers/media/i2c/imx415.c
> index 3f00172df3cc..9a7ac81edc28 100644
> --- a/drivers/media/i2c/imx415.c
> +++ b/drivers/media/i2c/imx415.c
> @@ -842,15 +842,6 @@ static int imx415_enum_frame_size(struct v4l2_subdev *sd,
>  	return 0;
>  }
>  
> -static int imx415_get_format(struct v4l2_subdev *sd,
> -			     struct v4l2_subdev_state *state,
> -			     struct v4l2_subdev_format *fmt)
> -{
> -	fmt->format = *v4l2_subdev_get_pad_format(sd, state, fmt->pad);
> -
> -	return 0;
> -}
> -
>  static int imx415_set_format(struct v4l2_subdev *sd,
>  			     struct v4l2_subdev_state *state,
>  			     struct v4l2_subdev_format *fmt)
> @@ -913,7 +904,7 @@ static const struct v4l2_subdev_video_ops imx415_subdev_video_ops = {
>  static const struct v4l2_subdev_pad_ops imx415_subdev_pad_ops = {
>  	.enum_mbus_code = imx415_enum_mbus_code,
>  	.enum_frame_size = imx415_enum_frame_size,
> -	.get_fmt = imx415_get_format,
> +	.get_fmt = v4l2_subdev_get_fmt,
>  	.set_fmt = imx415_set_format,
>  	.get_selection = imx415_get_selection,
>  	.init_cfg = imx415_init_cfg,

-- 
Regards,

Laurent Pinchart
