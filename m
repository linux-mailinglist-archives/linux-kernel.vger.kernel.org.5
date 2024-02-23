Return-Path: <linux-kernel+bounces-78220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB1A861069
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F4BEB22F51
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E6E78B7B;
	Fri, 23 Feb 2024 11:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="hdIFdBbd"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E49A5C911;
	Fri, 23 Feb 2024 11:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708687870; cv=none; b=BgXEMINKwpN4YZMSNtLAKMZT7lN1LMY91iH6MBqno9mmtmYnonFSX2gHjl23dhMzO5LunGitVlfTgBc1+d0t2GGflPMB1B7U1zFGU6wbfoUI6Raa3mEk6mwPxqFGDizecMB7PLwmO4OFLQcWc9r0MIzOa0rbpXAyFAJF3qtgid8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708687870; c=relaxed/simple;
	bh=wOUQz5eeBlIh1yOYBEKMmJSEt1nsckcfcWxLMJnrpUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBCCZrLntNgZGOweR+R7K7p7H4Eh6zwQMiisoas4qfx2sxfFkjRkIacXrKTZY9aA3T/CGLss8jcV0Mb7HA4hvDrXxOCXMoLmYgJKhVqqueX0Fa4EHzRfUHW4Kq3ITuGk0hzbnfJnFl62cuYI4NeYId8r0B7ZXzhKizXolerjc3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=hdIFdBbd; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7DAA62E7;
	Fri, 23 Feb 2024 12:30:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1708687858;
	bh=wOUQz5eeBlIh1yOYBEKMmJSEt1nsckcfcWxLMJnrpUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hdIFdBbdGSqin5//k4Tj5zgUlyJAdidCsSXK3pTNpcaJvMN6hiK41M4EbzUL4Lcn1
	 LQQ9FyXWWeSz+A26qYMhL/pWtN5FaXNeWp9yfK5bSXgBxn5QiHxmG8gzCfXpxi0W0e
	 qkBmFdSh4NqujWUFz07C1tu711t84gMYZ9WWwxk4=
Date: Fri, 23 Feb 2024 13:31:11 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mikhail Rudenko <mike.rudenko@gmail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2 14/20] media: i2c: ov4689: Implement manual color
 balance controls
Message-ID: <20240223113111.GR31348@pendragon.ideasonboard.com>
References: <20231218174042.794012-1-mike.rudenko@gmail.com>
 <20231218174042.794012-15-mike.rudenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231218174042.794012-15-mike.rudenko@gmail.com>

Hi Mikhail,

Thank you for the patch.

On Mon, Dec 18, 2023 at 08:40:35PM +0300, Mikhail Rudenko wrote:
> The OV4689 sensor has separate red and blue gain settings (up to 4x).
> Implement appropriate controls in the driver. Default gain values
> are not modified.
> 
> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/i2c/ov4689.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
> index 579362570ba4..b43fb1d7b15f 100644
> --- a/drivers/media/i2c/ov4689.c
> +++ b/drivers/media/i2c/ov4689.c
> @@ -56,6 +56,13 @@
>  #define OV4689_TIMING_FLIP_BOTH		(OV4689_TIMING_FLIP_ARRAY |\
>  					 OV4689_TIMING_FLIP_DIGITAL)
>  
> +#define OV4689_REG_WB_GAIN_RED		CCI_REG16(0x500c)
> +#define OV4689_REG_WB_GAIN_BLUE		CCI_REG16(0x5010)
> +#define OV4689_WB_GAIN_MIN		1
> +#define OV4689_WB_GAIN_MAX		0xfff
> +#define OV4689_WB_GAIN_STEP		1
> +#define OV4689_WB_GAIN_DEFAULT		0x400
> +
>  #define OV4689_REG_TEST_PATTERN		CCI_REG8(0x5040)
>  #define OV4689_TEST_PATTERN_ENABLE	0x80
>  #define OV4689_TEST_PATTERN_DISABLE	0x0
> @@ -632,6 +639,12 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>  	case V4L2_CID_DIGITAL_GAIN:
>  		cci_write(regmap, OV4689_REG_DIG_GAIN, ctrl->val, &ret);
>  		break;
> +	case V4L2_CID_RED_BALANCE:
> +		cci_write(regmap, OV4689_REG_WB_GAIN_RED, ctrl->val, &ret);
> +		break;
> +	case V4L2_CID_BLUE_BALANCE:
> +		cci_write(regmap, OV4689_REG_WB_GAIN_BLUE, ctrl->val, &ret);
> +		break;
>  	default:
>  		dev_warn(dev, "%s Unhandled id:0x%x, val:0x%x\n",
>  			 __func__, ctrl->id, ctrl->val);
> @@ -662,7 +675,7 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
>  
>  	handler = &ov4689->ctrl_handler;
>  	mode = ov4689->cur_mode;
> -	ret = v4l2_ctrl_handler_init(handler, 13);
> +	ret = v4l2_ctrl_handler_init(handler, 15);
>  	if (ret)
>  		return ret;
>  
> @@ -709,6 +722,14 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
>  			  OV4689_DIG_GAIN_MIN, OV4689_DIG_GAIN_MAX,
>  			  OV4689_DIG_GAIN_STEP, OV4689_DIG_GAIN_DEFAULT);
>  
> +	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_RED_BALANCE,
> +			  OV4689_WB_GAIN_MIN, OV4689_WB_GAIN_MAX,
> +			  OV4689_WB_GAIN_STEP, OV4689_WB_GAIN_DEFAULT);
> +
> +	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_BLUE_BALANCE,
> +			  OV4689_WB_GAIN_MIN, OV4689_WB_GAIN_MAX,
> +			  OV4689_WB_GAIN_STEP, OV4689_WB_GAIN_DEFAULT);
> +
>  	if (handler->error) {
>  		ret = handler->error;
>  		dev_err(ov4689->dev, "Failed to init controls(%d)\n", ret);

-- 
Regards,

Laurent Pinchart

