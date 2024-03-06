Return-Path: <linux-kernel+bounces-94313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F671873CF1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A17D9B24E57
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2613913BAD2;
	Wed,  6 Mar 2024 17:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aL2grcG3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50457139571;
	Wed,  6 Mar 2024 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709744793; cv=none; b=a/gR/YMHeIFM7vBukAVc9N9ne9ipWN2ilAgBAbjtGmCvWP+ZP+Z6Nywd6SlLU/ThdqLVVjDdo0Cilyy7eSmVTrpkxVLdyStJgH/NDqCM72hzhwGIwoGBeID07JpRig5FJBa4CaKnGB2C8g19xi1TXj/UTB+BdR/GYUw0qLYW6v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709744793; c=relaxed/simple;
	bh=APs7YpuKqgr7T1dZ7WJBALbURNcjg8hifJUos7wpiz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dc7Wa4j3eKIPnt3mZHoIgbP6QjcF0EN4ymDQCMTFbXgP7aFvEoL6QRlNJ2MQhv7H+MLZPM9iMG3kknjrcgxI4zIb13StVemOusjdZBCZJZFJklJoNJG/EGLhBOC7vh9TQWqUH6f/a5zTB/CVc6Px7AM3C2szUfBMujTXx3nRI+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aL2grcG3; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709744792; x=1741280792;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=APs7YpuKqgr7T1dZ7WJBALbURNcjg8hifJUos7wpiz4=;
  b=aL2grcG3NsWAWtaDSd4DiKSRuYkX8zt0egconHwAozEmkNJpQSAZLFNV
   MzLpqckybog9rUoijTNWShLr10Ur0CyCSSyI/ZtiznCJpaQ0GdIpuUO6T
   G8OHpzR22TyHImUFIrfu2WPQDvGpLSD6LmOrofQgelvEN6ObVrpSByU/F
   lkgDS4B6ENe1sKIll4mhlwQs8Hnip5L0731Uc+si6tmaD8wHEp2/nvxU6
   k0qduOfvsnapeiCWatxe+Dh3n8QpnWwrjLlAUfTvK07wXRfU7g6DAWbpZ
   gAnoOq3ADCiLXyQjC/81cspTVP1lVdPGYtE+PvYdb0gGfSJVzHGo8NheN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="7309790"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="7309790"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 09:06:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="40795059"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 09:06:28 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id A190411F8B1;
	Wed,  6 Mar 2024 19:06:25 +0200 (EET)
Date: Wed, 6 Mar 2024 17:06:25 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org,
	Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] media: imx335: Support 2 or 4 lane operation modes
Message-ID: <ZeiikZcVm0YZJKU0@kekkonen.localdomain>
References: <20240306081038.212412-1-umang.jain@ideasonboard.com>
 <20240306081038.212412-2-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306081038.212412-2-umang.jain@ideasonboard.com>

Hi Umang,

On Wed, Mar 06, 2024 at 01:40:34PM +0530, Umang Jain wrote:
> From: Kieran Bingham <kieran.bingham@ideasonboard.com>
> 
> The IMX335 can support both 2 and 4 lane configurations.
> Extend the driver to configure the lane mode accordingly.
> Update the pixel rate depending on the number of lanes in use.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  drivers/media/i2c/imx335.c | 46 +++++++++++++++++++++++++++++++-------
>  1 file changed, 38 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
> index dab6d080bc4c..a42f48823515 100644
> --- a/drivers/media/i2c/imx335.c
> +++ b/drivers/media/i2c/imx335.c
> @@ -21,6 +21,11 @@
>  #define IMX335_MODE_STANDBY	0x01
>  #define IMX335_MODE_STREAMING	0x00
>  
> +/* Data Lanes */
> +#define IMX335_LANEMODE		0x3a01
> +#define IMX335_2LANE		1
> +#define IMX335_4LANE		3
> +
>  /* Lines per frame */
>  #define IMX335_REG_LPFR		0x3030
>  
> @@ -67,8 +72,6 @@
>  #define IMX335_LINK_FREQ_594MHz		594000000LL
>  #define IMX335_LINK_FREQ_445MHz		445500000LL
>  
> -#define IMX335_NUM_DATA_LANES	4
> -
>  #define IMX335_REG_MIN		0x00
>  #define IMX335_REG_MAX		0xfffff
>  
> @@ -115,7 +118,6 @@ static const char * const imx335_supply_name[] = {
>   * @vblank: Vertical blanking in lines
>   * @vblank_min: Minimum vertical blanking in lines
>   * @vblank_max: Maximum vertical blanking in lines
> - * @pclk: Sensor pixel clock
>   * @reg_list: Register list for sensor mode
>   */
>  struct imx335_mode {
> @@ -126,7 +128,6 @@ struct imx335_mode {
>  	u32 vblank;
>  	u32 vblank_min;
>  	u32 vblank_max;
> -	u64 pclk;
>  	struct imx335_reg_list reg_list;
>  };
>  
> @@ -147,6 +148,7 @@ struct imx335_mode {
>   * @exp_ctrl: Pointer to exposure control
>   * @again_ctrl: Pointer to analog gain control
>   * @vblank: Vertical blanking in lines
> + * @lane_mode Mode for number of connected data lanes
>   * @cur_mode: Pointer to current selected sensor mode
>   * @mutex: Mutex for serializing sensor controls
>   * @link_freq_bitmap: Menu bitmap for link_freq_ctrl
> @@ -171,6 +173,7 @@ struct imx335 {
>  		struct v4l2_ctrl *again_ctrl;
>  	};
>  	u32 vblank;
> +	u32 lane_mode;
>  	const struct imx335_mode *cur_mode;
>  	struct mutex mutex;
>  	unsigned long link_freq_bitmap;
> @@ -377,7 +380,6 @@ static const struct imx335_mode supported_mode = {
>  	.vblank = 2560,
>  	.vblank_min = 2560,
>  	.vblank_max = 133060,
> -	.pclk = 396000000,
>  	.reg_list = {
>  		.num_of_regs = ARRAY_SIZE(mode_2592x1940_regs),
>  		.regs = mode_2592x1940_regs,
> @@ -936,6 +938,11 @@ static int imx335_start_streaming(struct imx335 *imx335)
>  		return ret;
>  	}
>  
> +	/* Configure lanes */
> +	ret = imx335_write_reg(imx335, IMX335_LANEMODE, 1, imx335->lane_mode);
> +	if (ret)
> +		return ret;
> +
>  	/* Setup handler will write actual exposure and gain */
>  	ret =  __v4l2_ctrl_handler_setup(imx335->sd.ctrl_handler);
>  	if (ret) {
> @@ -1096,7 +1103,14 @@ static int imx335_parse_hw_config(struct imx335 *imx335)
>  	if (ret)
>  		return ret;
>  
> -	if (bus_cfg.bus.mipi_csi2.num_data_lanes != IMX335_NUM_DATA_LANES) {
> +	switch (bus_cfg.bus.mipi_csi2.num_data_lanes) {
> +	case 2:
> +		imx335->lane_mode = IMX335_2LANE;
> +		break;
> +	case 4:
> +		imx335->lane_mode = IMX335_4LANE;
> +		break;
> +	default:
>  		dev_err(imx335->dev,
>  			"number of CSI2 data lanes %d is not supported\n",
>  			bus_cfg.bus.mipi_csi2.num_data_lanes);
> @@ -1209,6 +1223,9 @@ static int imx335_init_controls(struct imx335 *imx335)
>  	struct v4l2_ctrl_handler *ctrl_hdlr = &imx335->ctrl_handler;
>  	const struct imx335_mode *mode = imx335->cur_mode;
>  	u32 lpfr;
> +	u64 pclk;
> +	s64 link_freq_in_use;
> +	u8 bpp;
>  	int ret;
>  
>  	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 7);
> @@ -1252,11 +1269,24 @@ static int imx335_init_controls(struct imx335 *imx335)
>  				     0, 0, imx335_tpg_menu);
>  
>  	/* Read only controls */
> +
> +	/* pixel rate = link frequency * lanes * 2 / bits_per_pixel */
> +	switch (imx335->cur_mbus_code) {
> +	case MEDIA_BUS_FMT_SRGGB10_1X10:
> +		bpp = 10;
> +		break;
> +	case MEDIA_BUS_FMT_SRGGB12_1X12:
> +		bpp = 12;
> +		break;
> +	}
> +
> +	link_freq_in_use = link_freq[__ffs(imx335->link_freq_bitmap)];
> +	pclk = link_freq_in_use * (imx335->lane_mode + 1) * 2 / bpp;

Please use div_s64() for this.

>  	imx335->pclk_ctrl = v4l2_ctrl_new_std(ctrl_hdlr,
>  					      &imx335_ctrl_ops,
>  					      V4L2_CID_PIXEL_RATE,
> -					      mode->pclk, mode->pclk,
> -					      1, mode->pclk);
> +					      pclk, pclk,
> +					      1, pclk);
>  
>  	imx335->link_freq_ctrl = v4l2_ctrl_new_int_menu(ctrl_hdlr,
>  							&imx335_ctrl_ops,

-- 
Regards,

Sakari Ailus

