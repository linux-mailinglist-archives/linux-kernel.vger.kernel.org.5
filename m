Return-Path: <linux-kernel+bounces-38903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD04483C82C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AD401F2196C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D9B12FF82;
	Thu, 25 Jan 2024 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S/qUzuqs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A3519472;
	Thu, 25 Jan 2024 16:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200557; cv=none; b=R6+3fPR+RgSuBDfS3DCT2pIdvRFFbuoLYzufg5/mgcskcwKYpQXsL6jdx1hxF2oxPXmXDidS0XRCo/KZOrXYzle4wozMSLSIpMnF8cYlwBbQ56qGfHjacB21JPub53rMT80nWSTBC3XW2XyCIvi6VpPqJ9A5+NbxxhMfD/aGQ8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200557; c=relaxed/simple;
	bh=9YTKm9bJOh7AgESo5uZMHfPE6MS+bUQJlQ0XWGia/i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D279R2MXJWgXJ8bZmCKKKSoYD9N9TTjhWN2V9yNctVccTfzF/HcpDYaJptQa2SamY4zS492aIQ84kaXDivbkdf3m+hYyQdAxzr7j6SwbFzO0pKGiIbDiH9Tdc/pNzyca4GgUqTrmMaZUEnSI0oErDhDqI+2ZIdclcjIlytb2Rqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S/qUzuqs; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706200555; x=1737736555;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9YTKm9bJOh7AgESo5uZMHfPE6MS+bUQJlQ0XWGia/i4=;
  b=S/qUzuqsAb8M5mKYotCQtwwwt/9ttFb56MrZ3DXHUGAyiIUXqW+x9Q0t
   YqbdUpOSHd1dSBQEqy7fvl9RWCcBI4PyQKvX89VAyvvWNF5/a+Io76e9W
   BVc4inUZDQXS7kQBG3lJCzmKdwvD/f4nT9m2vPhW5a7Zyv6xgeiBu2gcl
   f0aByUbW56WLHr/HCdh1BrQlP7/j0F+iUytBQNRbpVAMmbYUuDL3YMSUs
   cpedQPOOyvMq2eQL7omAWf4daZvOyRs1ncBwooH9iC1psCp2ReO1HFgYE
   T8TwPX7QlkmCgCaGxPw78/ygAIE8Y+SNvI2ehn9B3bvW3O+SLAcFGMlFm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9329623"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9329623"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 08:35:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="959894545"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="959894545"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 08:35:52 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id C4E4B11FAD4;
	Thu, 25 Jan 2024 18:19:17 +0200 (EET)
Date: Thu, 25 Jan 2024 16:19:17 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Matthias Fend <matthias.fend@emfend.at>
Subject: Re: [PATCH 4/4] media: i2c: imx335: Add support for test pattern
 generator
Message-ID: <ZbKKBcf2PX8u3JGV@kekkonen.localdomain>
References: <20240125154908.465191-1-umang.jain@ideasonboard.com>
 <20240125154908.465191-5-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125154908.465191-5-umang.jain@ideasonboard.com>

Hi Umang,

On Thu, Jan 25, 2024 at 09:19:08PM +0530, Umang Jain wrote:
> From: Matthias Fend <matthias.fend@emfend.at>
> 
> Add support for the sensor's test pattern generator.
> 
> Signed-off-by: Matthias Fend <matthias.fend@emfend.at>
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  drivers/media/i2c/imx335.c | 99 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 98 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
> index e64ee99cbae4..f9a2337a80c0 100644
> --- a/drivers/media/i2c/imx335.c
> +++ b/drivers/media/i2c/imx335.c
> @@ -45,6 +45,21 @@
>  /* Group hold register */
>  #define IMX335_REG_HOLD		0x3001
>  
> +/* Test pattern generator */
> +#define IMX335_REG_TPG		0x329e
> +#define IMX335_TPG_ALL_000	0
> +#define IMX335_TPG_ALL_FFF	1
> +#define IMX335_TPG_ALL_555	2
> +#define IMX335_TPG_ALL_AAA	3
> +#define IMX335_TPG_TOG_555_AAA	4
> +#define IMX335_TPG_TOG_AAA_555	5
> +#define IMX335_TPG_TOG_000_555	6
> +#define IMX335_TPG_TOG_555_000	7
> +#define IMX335_TPG_TOG_000_FFF	8
> +#define IMX335_TPG_TOG_FFF_000	9
> +#define IMX335_TPG_H_COLOR_BARS 10
> +#define IMX335_TPG_V_COLOR_BARS 11
> +
>  /* Input clock rate */
>  #define IMX335_INCLK_RATE	24000000
>  
> @@ -162,6 +177,38 @@ struct imx335 {
>  };
>  
>  
> +static const char * const imx335_tpg_menu[] = {
> +	"Disabled",
> +	"All 000h",
> +	"All FFFh",
> +	"All 555h",
> +	"All AAAh",
> +	"Toggle 555/AAAh",
> +	"Toggle AAA/555h",
> +	"Toggle 000/555h",
> +	"Toggle 555/000h",
> +	"Toggle 000/FFFh",
> +	"Toggle FFF/000h",
> +	"Horizontal color bars",
> +	"Vertical color bars",
> +};
> +
> +static const int imx335_tpg_val[] = {
> +	IMX335_TPG_ALL_000,
> +	IMX335_TPG_ALL_000,
> +	IMX335_TPG_ALL_FFF,
> +	IMX335_TPG_ALL_555,
> +	IMX335_TPG_ALL_AAA,
> +	IMX335_TPG_TOG_555_AAA,
> +	IMX335_TPG_TOG_AAA_555,
> +	IMX335_TPG_TOG_000_555,
> +	IMX335_TPG_TOG_555_000,
> +	IMX335_TPG_TOG_000_FFF,
> +	IMX335_TPG_TOG_FFF_000,
> +	IMX335_TPG_H_COLOR_BARS,
> +	IMX335_TPG_V_COLOR_BARS,
> +};
> +
>  /* Sensor mode registers */
>  static const struct imx335_reg mode_2592x1940_regs[] = {
>  	{0x3000, 0x01},
> @@ -505,6 +552,46 @@ static int imx335_update_exp_gain(struct imx335 *imx335, u32 exposure, u32 gain)
>  	return ret;
>  }
>  
> +static int imx335_update_test_pattern(struct imx335 *imx335, u32 pattern_index)
> +{
> +	int ret;
> +
> +	if (pattern_index >= ARRAY_SIZE(imx335_tpg_val))
> +		return -EINVAL;

This is unnecessary, the control framework ensures this already.

> +
> +	if (pattern_index) {
> +		const struct imx335_reg tpg_enable_regs[] = {
> +			{ 0x3148, 0x10 },
> +			{ 0x3280, 0x00 },
> +			{ 0x329c, 0x01 },
> +			{ 0x32a0, 0x11 },
> +			{ 0x3302, 0x00 },
> +			{ 0x3303, 0x00 },
> +			{ 0x336c, 0x00 },
> +		};
> +
> +		ret = imx335_write_reg(imx335, IMX335_REG_TPG, 1, imx335_tpg_val[pattern_index]);

Can you do:

	$ ./scripts/checkpatch.pl --strict --max-line-length=80

on these?

> +		if (ret)
> +			return ret;
> +
> +		ret = imx335_write_regs(imx335, tpg_enable_regs, ARRAY_SIZE(tpg_enable_regs));

Return already here.

> +	} else {
> +		const struct imx335_reg tpg_disable_regs[] = {
> +			{ 0x3148, 0x00 },
> +			{ 0x3280, 0x01 },
> +			{ 0x329c, 0x00 },
> +			{ 0x32a0, 0x10 },
> +			{ 0x3302, 0x32 },
> +			{ 0x3303, 0x00 },
> +			{ 0x336c, 0x01 },
> +		};
> +
> +		ret = imx335_write_regs(imx335, tpg_disable_regs, ARRAY_SIZE(tpg_disable_regs));

And here.

> +	}
> +
> +	return ret;
> +}
> +
>  /**
>   * imx335_set_ctrl() - Set subdevice control
>   * @ctrl: pointer to v4l2_ctrl structure
> @@ -558,6 +645,10 @@ static int imx335_set_ctrl(struct v4l2_ctrl *ctrl)
>  
>  		ret = imx335_update_exp_gain(imx335, exposure, analog_gain);
>  
> +		break;
> +	case V4L2_CID_TEST_PATTERN:
> +		ret = imx335_update_test_pattern(imx335, ctrl->val);
> +
>  		break;
>  	default:
>  		dev_err(imx335->dev, "Invalid control %d\n", ctrl->id);
> @@ -1122,7 +1213,7 @@ static int imx335_init_controls(struct imx335 *imx335)
>  	u32 lpfr;
>  	int ret;
>  
> -	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 6);
> +	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 7);
>  	if (ret)
>  		return ret;
>  
> @@ -1156,6 +1247,12 @@ static int imx335_init_controls(struct imx335 *imx335)
>  						mode->vblank_max,
>  						1, mode->vblank);
>  
> +	v4l2_ctrl_new_std_menu_items(ctrl_hdlr,
> +				     &imx335_ctrl_ops,
> +				     V4L2_CID_TEST_PATTERN,
> +				     ARRAY_SIZE(imx335_tpg_menu) - 1,
> +				     0, 0, imx335_tpg_menu);
> +
>  	/* Read only controls */
>  	imx335->pclk_ctrl = v4l2_ctrl_new_std(ctrl_hdlr,
>  					      &imx335_ctrl_ops,

-- 
Regards,

Sakari Ailus

