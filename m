Return-Path: <linux-kernel+bounces-78218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE13861064
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E9281C216C8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B135178B57;
	Fri, 23 Feb 2024 11:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="rPjDAoWc"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E075C911;
	Fri, 23 Feb 2024 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708687806; cv=none; b=PXKNKmFVkstqm4LvjH4mCp5wsQwZdf8dxbliDYzdjssofNacooXdJ3607ljWkE/8kIEDzm6CkukypNf6gJZ9GEYdvkdT5levv2ENNM1iAZs/SDTF+/I+7S+tXmzrKitBWLpSnDcWIDVU74MxMGqnHLnNQJY5eR802BpeusLgZx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708687806; c=relaxed/simple;
	bh=sRCQO7RgeHDKkHCU1kxMeMy3uw8Xi1J+ZxGRQNaYUcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cvpf6vjbGs3yYr/YQFP2LtRQeVOddNiPg0Q45KBCyS3fyr5oRG+1ie+utInUXDDzWc+OQi7j2+d+3Tbw4h9iEHCBgay/HxLbn+HdPDerSr/NUaxAafEm7Ni0odzosbPggW6HPTLaFZ94RHZTAbXGTgf3ZhGD9RwSdx4dBAncbS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=rPjDAoWc; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D3D362E7;
	Fri, 23 Feb 2024 12:29:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1708687794;
	bh=sRCQO7RgeHDKkHCU1kxMeMy3uw8Xi1J+ZxGRQNaYUcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rPjDAoWc5pQn7WOZrzCCb/5X0o7B+XiUunlbrAVbQiQSXTGrDp2prI77cFL4FrSQz
	 ZQ7z5b0h7UrEimNNMHwIser5cs2A9/40YqN9gW4iZ68e+NoW9fgjAJhb0zTY/qNSn3
	 dqHBlp/VJq9WhUxcuUOjet+2dGPYXxABrwxlp4kI=
Date: Fri, 23 Feb 2024 13:30:06 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mikhail Rudenko <mike.rudenko@gmail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2 13/20] media: i2c: ov4689: Implement digital gain
 control
Message-ID: <20240223113006.GQ31348@pendragon.ideasonboard.com>
References: <20231218174042.794012-1-mike.rudenko@gmail.com>
 <20231218174042.794012-14-mike.rudenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231218174042.794012-14-mike.rudenko@gmail.com>

Hi Mikhail,

Thank you for the patch.

On Mon, Dec 18, 2023 at 08:40:34PM +0300, Mikhail Rudenko wrote:
> The OV4689 sensor supports digital gain up to 16x. Implement
> corresponding control in the driver. Default digital gain value is not
> modified by this patch.
> 
> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/i2c/ov4689.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
> index 6cf986bf305d..579362570ba4 100644
> --- a/drivers/media/i2c/ov4689.c
> +++ b/drivers/media/i2c/ov4689.c
> @@ -35,6 +35,12 @@
>  #define OV4689_GAIN_STEP		1
>  #define OV4689_GAIN_DEFAULT		0x80
>  
> +#define OV4689_REG_DIG_GAIN		CCI_REG16(0x352a)
> +#define OV4689_DIG_GAIN_MIN		1
> +#define OV4689_DIG_GAIN_MAX		0x7fff
> +#define OV4689_DIG_GAIN_STEP		1
> +#define OV4689_DIG_GAIN_DEFAULT		0x800
> +
>  #define OV4689_REG_HTS			CCI_REG16(0x380c)
>  #define OV4689_HTS_DIVIDER		4
>  #define OV4689_HTS_MAX			0x7fff
> @@ -131,7 +137,6 @@ static const struct cci_reg_sequence ov4689_2688x1520_regs[] = {
>  
>  	/* AEC PK */
>  	{CCI_REG8(0x3503), 0x04}, /* AEC_MANUAL gain_input_as_sensor_gain_format = 1 */
> -	{CCI_REG8(0x352a), 0x08}, /* DIG_GAIN_FRAC_LONG dig_gain_long[14:8] = 0x08 (2x) */
>  
>  	/* ADC and analog control*/
>  	{CCI_REG8(0x3603), 0x40},
> @@ -624,6 +629,9 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>  				OV4689_TIMING_FLIP_MASK,
>  				ctrl->val ? 0 : OV4689_TIMING_FLIP_BOTH, &ret);
>  		break;
> +	case V4L2_CID_DIGITAL_GAIN:
> +		cci_write(regmap, OV4689_REG_DIG_GAIN, ctrl->val, &ret);
> +		break;
>  	default:
>  		dev_warn(dev, "%s Unhandled id:0x%x, val:0x%x\n",
>  			 __func__, ctrl->id, ctrl->val);
> @@ -654,7 +662,7 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
>  
>  	handler = &ov4689->ctrl_handler;
>  	mode = ov4689->cur_mode;
> -	ret = v4l2_ctrl_handler_init(handler, 12);
> +	ret = v4l2_ctrl_handler_init(handler, 13);
>  	if (ret)
>  		return ret;
>  
> @@ -697,6 +705,10 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
>  	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_VFLIP, 0, 1, 1, 0);
>  	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_HFLIP, 0, 1, 1, 0);
>  
> +	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_DIGITAL_GAIN,
> +			  OV4689_DIG_GAIN_MIN, OV4689_DIG_GAIN_MAX,
> +			  OV4689_DIG_GAIN_STEP, OV4689_DIG_GAIN_DEFAULT);
> +
>  	if (handler->error) {
>  		ret = handler->error;
>  		dev_err(ov4689->dev, "Failed to init controls(%d)\n", ret);

-- 
Regards,

Laurent Pinchart

