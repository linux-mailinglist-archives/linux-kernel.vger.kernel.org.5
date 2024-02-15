Return-Path: <linux-kernel+bounces-66926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2780A8563AF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9B0C1F2617B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBED12EBD8;
	Thu, 15 Feb 2024 12:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TQONDs1P"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F283EA86;
	Thu, 15 Feb 2024 12:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708001486; cv=none; b=chLe7EQOChFB3njoc/aTBHDQVaqa8Vs4GZ+BEtydCdMFUlQkGWMZHvUInCEs4MRUfcm5ieqM/SV7eMfYH8p2T0qvOuh6ePAjDu+cPrTkI3tvIBh4WcJq7ilwO4nNS6W8MML+BUEQ/9nyAOUTbrYW7g2vtMVUEQoIbg3OECtFBXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708001486; c=relaxed/simple;
	bh=Q8RXEieFWbklk94sgp9zpA7bkSc1ZAounH3k4h1iIQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rf+DzG806G9psr7RgH7CQOIU+k0HKfhdAGryDHmqlvUsZWEctmMt9k34xtWR3AbsLphNOrEZmw9hd/YLIEt9JdKNVyH1rmL8B0AI957ojVz0Bk34v+xwnTZrhnlbDIBoT1RFtlfzigT4SMyISUhCfF4XGLbzSGiIe5jTOuPmXmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TQONDs1P; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708001483; x=1739537483;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q8RXEieFWbklk94sgp9zpA7bkSc1ZAounH3k4h1iIQo=;
  b=TQONDs1Pk3SnBy3ic+QeloaRm2pUX+8gqucYErCvRgelEJzTIScFpjM5
   sKjtC79SFZB+KR/OYg/omVdSL0zqsiTK90qhZfTzUxhhsryXlGcdhRld3
   In0xH0w6CpnBY6fqLqEXYixehRe1JzdIwmOWfhQVK/OWmM7H8NEEqTpnw
   tAwNpmVCztVz/L4kqQxADvbVMIjG+8GE0iSjctdL6dtkVTwrHAoLa5DHO
   rquo86qlHKWMWtOujRj9daeJM2UZFtR9kwvCfvMbtsdxZ9cQo8g5+h2mV
   Scp7f2JGAu4nKSqIhk1m7o5u7tsqlETX19v5izDS/Ws4xBHTV2TEQo7HH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="2228323"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="2228323"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 04:51:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="3869792"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 04:51:23 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id D831511F871;
	Thu, 15 Feb 2024 14:51:19 +0200 (EET)
Date: Thu, 15 Feb 2024 12:51:19 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] media: imx335: Use v4l2_link_freq_to_bitmap helper
Message-ID: <Zc4Ix32Ld_bCD-LO@kekkonen.localdomain>
References: <20240131055208.170934-1-umang.jain@ideasonboard.com>
 <20240131055208.170934-3-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131055208.170934-3-umang.jain@ideasonboard.com>

Hi Umang,

On Wed, Jan 31, 2024 at 11:22:05AM +0530, Umang Jain wrote:
> Use the v4l2_link_freq_to_bitmap() helper to figure out which
> driver-supported link frequencies can be used on a given system.
> 
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  drivers/media/i2c/imx335.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
> index 927b4806a5d7..73691069556f 100644
> --- a/drivers/media/i2c/imx335.c
> +++ b/drivers/media/i2c/imx335.c
> @@ -49,7 +49,7 @@
>  #define IMX335_INCLK_RATE	24000000
>  
>  /* CSI2 HW configuration */
> -#define IMX335_LINK_FREQ	594000000
> +#define IMX335_LINK_FREQ	594000000LL

If you change this, please make it ULL---it's unsigned.

>  #define IMX335_NUM_DATA_LANES	4
>  
>  #define IMX335_REG_MIN		0x00
> @@ -134,6 +134,7 @@ struct imx335_mode {
>   * @vblank: Vertical blanking in lines
>   * @cur_mode: Pointer to current selected sensor mode
>   * @mutex: Mutex for serializing sensor controls
> + * @link_freq_bitmap: Menu bitmap for link_freq_ctrl
>   * @cur_mbus_code: Currently selected media bus format code
>   */
>  struct imx335 {
> @@ -157,6 +158,7 @@ struct imx335 {
>  	u32 vblank;
>  	const struct imx335_mode *cur_mode;
>  	struct mutex mutex;
> +	unsigned long link_freq_bitmap;
>  	u32 cur_mbus_code;
>  };
>  
> @@ -404,7 +406,8 @@ static int imx335_update_controls(struct imx335 *imx335,
>  {
>  	int ret;
>  
> -	ret = __v4l2_ctrl_s_ctrl(imx335->link_freq_ctrl, mode->link_freq_idx);
> +	ret = __v4l2_ctrl_s_ctrl(imx335->link_freq_ctrl,
> +				 __ffs(imx335->link_freq_bitmap));
>  	if (ret)
>  		return ret;
>  
> @@ -690,6 +693,13 @@ static int imx335_init_state(struct v4l2_subdev *sd,
>  	fmt.which = sd_state ? V4L2_SUBDEV_FORMAT_TRY : V4L2_SUBDEV_FORMAT_ACTIVE;
>  	imx335_fill_pad_format(imx335, &supported_mode, &fmt);
>  
> +	mutex_lock(&imx335->mutex);
> +	__v4l2_ctrl_modify_range(imx335->link_freq_ctrl, 0,
> +				 __fls(imx335->link_freq_bitmap),
> +				 ~(imx335->link_freq_bitmap),
> +				 __ffs(imx335->link_freq_bitmap));
> +	mutex_unlock(&imx335->mutex);
> +
>  	return imx335_set_pad_format(sd, sd_state, &fmt);
>  }
>  
> @@ -938,19 +948,10 @@ static int imx335_parse_hw_config(struct imx335 *imx335)
>  		goto done_endpoint_free;
>  	}
>  
> -	if (!bus_cfg.nr_of_link_frequencies) {
> -		dev_err(imx335->dev, "no link frequencies defined\n");
> -		ret = -EINVAL;
> -		goto done_endpoint_free;
> -	}
> -
> -	for (i = 0; i < bus_cfg.nr_of_link_frequencies; i++)
> -		if (bus_cfg.link_frequencies[i] == IMX335_LINK_FREQ)
> -			goto done_endpoint_free;
> -
> -	dev_err(imx335->dev, "no compatible link frequencies found\n");
> -
> -	ret = -EINVAL;
> +	ret = v4l2_link_freq_to_bitmap(imx335->dev, bus_cfg.link_frequencies,
> +				       bus_cfg.nr_of_link_frequencies,
> +				       link_freq, ARRAY_SIZE(link_freq),
> +				       &imx335->link_freq_bitmap);

Thanks! :-)

>  
>  done_endpoint_free:
>  	v4l2_fwnode_endpoint_free(&bus_cfg);
> @@ -1098,9 +1099,8 @@ static int imx335_init_controls(struct imx335 *imx335)
>  	imx335->link_freq_ctrl = v4l2_ctrl_new_int_menu(ctrl_hdlr,
>  							&imx335_ctrl_ops,
>  							V4L2_CID_LINK_FREQ,
> -							ARRAY_SIZE(link_freq) -
> -							1,
> -							mode->link_freq_idx,
> +							__fls(imx335->link_freq_bitmap),
> +							__ffs(imx335->link_freq_bitmap),
>  							link_freq);
>  	if (imx335->link_freq_ctrl)
>  		imx335->link_freq_ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;

-- 
Regards,

Sakari Ailus

