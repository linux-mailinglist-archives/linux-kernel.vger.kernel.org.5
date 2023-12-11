Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66B880D502
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 19:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345380AbjLKSK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 13:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345369AbjLKSKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 13:10:54 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69A493;
        Mon, 11 Dec 2023 10:11:00 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 708DF922;
        Mon, 11 Dec 2023 19:10:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1702318215;
        bh=Hkw53CbAYCaVZwFD6iEyB0w0BwlSOvyQDw30dZMGkeA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vaJ7Qdr6VFdkee/w1bOqs3IU/FcFR5GgyqCC8hF7BbQjf1JGAhASI6K5GRg4pMXde
         vHOxKyUaDwvp2MroRVdD1sq0w3AIgIg7jMyFQUTVrIq938i5l3AcRbyzF0RXVwNyRk
         CdS3M1LUZuyMsPHA86Jp3+Mdxjng5l+W3F0Wi5P4=
Date:   Mon, 11 Dec 2023 20:11:06 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Mikhail Rudenko <mike.rudenko@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH 05/19] media: i2c: ov4689: Refactor ov4689_set_ctrl
Message-ID: <20231211181106.GD27535@pendragon.ideasonboard.com>
References: <20231211175023.1680247-1-mike.rudenko@gmail.com>
 <20231211175023.1680247-6-mike.rudenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231211175023.1680247-6-mike.rudenko@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikhail,

Thank you for the patch.

On Mon, Dec 11, 2023 at 08:50:08PM +0300, Mikhail Rudenko wrote:
> Introduces local variables for regmap and the control value within the
> ov4689_set_ctrl function. This adjustment eliminates repetition within
> the function.
> 
> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
> ---
>  drivers/media/i2c/ov4689.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
> index 8c120d7f7830..42700ecfbe0e 100644
> --- a/drivers/media/i2c/ov4689.c
> +++ b/drivers/media/i2c/ov4689.c
> @@ -584,7 +584,9 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>  {
>  	struct ov4689 *ov4689 =
>  		container_of(ctrl->handler, struct ov4689, ctrl_handler);
> +	struct regmap *regmap = ov4689->regmap;
>  	struct device *dev = ov4689->dev;
> +	s32 val = ctrl->val;

For ctrl->val, I think the code is clearer without this change. When
reading the function, seeing "val", I need to look up what it is, while
seeing "ctrl->val" gives me more context and makes (in my opinion) the
code more readable.

>  	int sensor_gain;
>  	s64 max_expo;
>  	int ret;
> @@ -593,7 +595,7 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>  	switch (ctrl->id) {
>  	case V4L2_CID_VBLANK:
>  		/* Update max exposure while meeting expected vblanking */
> -		max_expo = ov4689->cur_mode->height + ctrl->val - 4;
> +		max_expo = ov4689->cur_mode->height + val - 4;
>  		__v4l2_ctrl_modify_range(ov4689->exposure,
>  					 ov4689->exposure->minimum, max_expo,
>  					 ov4689->exposure->step,
> @@ -607,36 +609,34 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>  	switch (ctrl->id) {
>  	case V4L2_CID_EXPOSURE:
>  		/* 4 least significant bits of exposure are fractional part */
> -		ret = cci_write(ov4689->regmap, OV4689_REG_EXPOSURE,
> -				ctrl->val << 4, NULL);
> +		cci_write(regmap, OV4689_REG_EXPOSURE, val << 4, &ret);
>  		break;
>  	case V4L2_CID_ANALOGUE_GAIN:
> -		ret = ov4689_map_gain(ov4689, ctrl->val, &sensor_gain);
> +		ret = ov4689_map_gain(ov4689, val, &sensor_gain);
>  
> -		cci_write(ov4689->regmap, OV4689_REG_GAIN_H,
> +		cci_write(regmap, OV4689_REG_GAIN_H,
>  			  (sensor_gain >> OV4689_GAIN_H_SHIFT) &
>  			  OV4689_GAIN_H_MASK, &ret);
>  
> -		cci_write(ov4689->regmap, OV4689_REG_GAIN_L,
> +		cci_write(regmap, OV4689_REG_GAIN_L,
>  			  sensor_gain & OV4689_GAIN_L_MASK,
>  			  &ret);
>  		break;
>  	case V4L2_CID_VBLANK:
> -		ret = cci_write(ov4689->regmap, OV4689_REG_VTS,
> -				ctrl->val + ov4689->cur_mode->height, NULL);
> +		cci_write(regmap, OV4689_REG_VTS,
> +			  val + ov4689->cur_mode->height, &ret);
>  		break;
>  	case V4L2_CID_TEST_PATTERN:
> -		ret = ov4689_enable_test_pattern(ov4689, ctrl->val);
> +		ret = ov4689_enable_test_pattern(ov4689, val);
>  		break;
>  	default:
>  		dev_warn(dev, "%s Unhandled id:0x%x, val:0x%x\n",
> -			 __func__, ctrl->id, ctrl->val);
> +			 __func__, ctrl->id, val);
>  		ret = -EINVAL;
>  		break;
>  	}
>  
>  	pm_runtime_put(dev);
> -
>  	return ret;
>  }
>  
> -- 
> 2.43.0
> 

-- 
Regards,

Laurent Pinchart
