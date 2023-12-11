Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106D180D504
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 19:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345283AbjLKSLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 13:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345257AbjLKSLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 13:11:42 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43FC95;
        Mon, 11 Dec 2023 10:11:48 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2964AC58;
        Mon, 11 Dec 2023 19:11:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1702318263;
        bh=iyuo6d2Ac26yQfhw96gW7KS6Y5R6Sy0Mk/XyqYwpjkY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=isKlb227rd7Xhnd9dr7S8UmV4whYM5BqcCv/PCHFyaDRkrqKy+Ob4kMKQpbbvmNjE
         JBWxpq4lwWnb3XKmRXgfbMKtCRTv3Jpa8Z1Cbvv7GVls4MoI37YYHf30/6dA+Ayoge
         vGMeZHdX/yL0KrCUzRqbKOqonhToUNMiGA0B4yI0=
Date:   Mon, 11 Dec 2023 20:11:54 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Mikhail Rudenko <mike.rudenko@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH 06/19] media: i2c: ov4689: Set gain in one 16 bit write
Message-ID: <20231211181154.GE27535@pendragon.ideasonboard.com>
References: <20231211175023.1680247-1-mike.rudenko@gmail.com>
 <20231211175023.1680247-7-mike.rudenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231211175023.1680247-7-mike.rudenko@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 08:50:09PM +0300, Mikhail Rudenko wrote:
> According to the datasheet, bits 0-7 of the AEC LONG GAIN
> register (0x3508) map to bits 8-15 of the gain value and no masking is
> required. Thus set analogue gain in a single 16-bit write instead of
> two 8-bit writes.
> 
> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>

You could squash it with patch 03/19.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/i2c/ov4689.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
> index 42700ecfbe0e..5392f650960c 100644
> --- a/drivers/media/i2c/ov4689.c
> +++ b/drivers/media/i2c/ov4689.c
> @@ -32,11 +32,7 @@
>  #define OV4689_EXPOSURE_STEP		1
>  #define OV4689_VTS_MAX			0x7fff
>  
> -#define OV4689_REG_GAIN_H		CCI_REG8(0x3508)
> -#define OV4689_REG_GAIN_L		CCI_REG8(0x3509)
> -#define OV4689_GAIN_H_MASK		0x07
> -#define OV4689_GAIN_H_SHIFT		8
> -#define OV4689_GAIN_L_MASK		0xff
> +#define OV4689_REG_GAIN			CCI_REG16(0x3508)
>  #define OV4689_GAIN_STEP		1
>  #define OV4689_GAIN_DEFAULT		0x80
>  
> @@ -613,14 +609,7 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>  		break;
>  	case V4L2_CID_ANALOGUE_GAIN:
>  		ret = ov4689_map_gain(ov4689, val, &sensor_gain);
> -
> -		cci_write(regmap, OV4689_REG_GAIN_H,
> -			  (sensor_gain >> OV4689_GAIN_H_SHIFT) &
> -			  OV4689_GAIN_H_MASK, &ret);
> -
> -		cci_write(regmap, OV4689_REG_GAIN_L,
> -			  sensor_gain & OV4689_GAIN_L_MASK,
> -			  &ret);
> +		cci_write(regmap, OV4689_REG_GAIN, sensor_gain, &ret);
>  		break;
>  	case V4L2_CID_VBLANK:
>  		cci_write(regmap, OV4689_REG_VTS,

-- 
Regards,

Laurent Pinchart
