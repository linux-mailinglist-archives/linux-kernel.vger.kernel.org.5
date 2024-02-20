Return-Path: <linux-kernel+bounces-72863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DB685B9AD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 413C0B2485C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E8165BB8;
	Tue, 20 Feb 2024 10:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kDsk/a21"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A42465190;
	Tue, 20 Feb 2024 10:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708426530; cv=none; b=MjOvSjM+qL1FkR9Vr7jlJE0qKKDwrMBkp2bUXNTTSFvuOevX4KlYFSSOM2EmmpJPXTKkwjvyMMPIOeorXvNPh+RfEZuFRNtnhfO/qne4tQ+BAa7d29KViE+xwTbCH7aHPHa2jSQlkEHDtn0xDOriSh6VamQGwHlzXa/g2eh8x1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708426530; c=relaxed/simple;
	bh=BKKwgJxTsthDhT/YS0/ipstafMeFwfOSGB3VEFS9+Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9naY9NuB/tiJl+yYqlai6pYLfdKoKN0vpLUU21XzXIeQU6X0CPqJbGjSGYevmQQTNHLSAVHwUsFM2sO+uo7iL16R4E4WLvB9V4GKtSekJhXhaQNN4vaoAZBR033yGIddwLSfUyn/MY3C1EyjP7vBeqzeJSjUs4If22FHfkPyGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kDsk/a21; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708426528; x=1739962528;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BKKwgJxTsthDhT/YS0/ipstafMeFwfOSGB3VEFS9+Ng=;
  b=kDsk/a2130z79J9OBSdnzRgV4VM4qEsHqhLmiyTXRhv+qQRJKm67P3Xc
   2/LkbaAI2wmMsOOYPGSB56kcW+2E3x2kV7gKNDJ9Ry5EzkPnVKS2wv8x3
   BJWpkTXVXYajiWWffivQW/lm4bzAEQEC/VyAmFzNzLvcFx7mmgunKCUYG
   wkcQbY0kWC5Zp+MV2NK/LKoYWS3PRGkkDHXfgAjCqsJziscw6XsPNXuF9
   GAB7CiluUl97t5biizS1jHQx4KpXeV+4dOUd8lQSk33gaQxiMLcE55rS+
   2JxTujPmf2Z0PLltHJ29wxk7vmAS/br6BMuz7xA1RntsWltMhWEDWHcBs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="13080523"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="13080523"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 02:55:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="5035753"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 02:55:25 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id E6CAA11F7E1;
	Tue, 20 Feb 2024 12:55:21 +0200 (EET)
Date: Tue, 20 Feb 2024 10:55:21 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Alain Volmat <alain.volmat@foss.st.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
	Pavel Machek <pavel@ucw.cz>,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: Re: [PATCH 2/2] media: gc2145: implement basic dvp bus support
Message-ID: <ZdSFGaJ9qnayYI5C@kekkonen.localdomain>
References: <20240217220308.594883-1-andrej.skvortzov@gmail.com>
 <20240217220308.594883-3-andrej.skvortzov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217220308.594883-3-andrej.skvortzov@gmail.com>

Hi Andrey,

On Sun, Feb 18, 2024 at 01:03:08AM +0300, Andrey Skvortsov wrote:
> Tested on PinePhone with libcamera-based GNOME screenshot.
> 
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> ---
>  drivers/media/i2c/gc2145.c | 117 ++++++++++++++++++++++++++++---------
>  1 file changed, 90 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/media/i2c/gc2145.c b/drivers/media/i2c/gc2145.c
> index bef7b0e056a8..9a70b8d504e1 100644
> --- a/drivers/media/i2c/gc2145.c
> +++ b/drivers/media/i2c/gc2145.c
> @@ -39,6 +39,10 @@
>  #define GC2145_REG_ANALOG_MODE1	CCI_REG8(0x17)
>  #define GC2145_REG_OUTPUT_FMT	CCI_REG8(0x84)
>  #define GC2145_REG_SYNC_MODE	CCI_REG8(0x86)
> +#define GC2145_SYNC_MODE_VSYNC_POL	BIT(0)
> +#define GC2145_SYNC_MODE_HSYNC_POL	BIT(1)
> +#define GC2145_SYNC_MODE_OPCLK_POL	BIT(2)
> +#define GC2145_SYNC_MODE_OPCLK_GATE	BIT(3)
>  #define GC2145_SYNC_MODE_COL_SWITCH	BIT(4)
>  #define GC2145_SYNC_MODE_ROW_SWITCH	BIT(5)
>  #define GC2145_REG_BYPASS_MODE	CCI_REG8(0x89)
> @@ -53,6 +57,12 @@
>  #define GC2145_REG_GLOBAL_GAIN	CCI_REG8(0xb0)
>  #define GC2145_REG_CHIP_ID	CCI_REG16(0xf0)
>  #define GC2145_REG_PAD_IO	CCI_REG8(0xf2)
> +#define GC2145_REG_PLL_MODE1	CCI_REG8(0xf7)
> +#define GC2145_REG_PLL_MODE2	CCI_REG8(0xf8)
> +#define GC2145_REG_CM_MODE	CCI_REG8(0xf9)
> +#define GC2145_REG_CLK_DIV_MODE	CCI_REG8(0xfa)
> +#define GC2145_REG_ANALOG_PWC	CCI_REG8(0xfc)
> +#define GC2145_REG_PAD_IO	CCI_REG8(0xf2)
>  #define GC2145_REG_PAGE_SELECT	CCI_REG8(0xfe)
>  /* Page 3 */
>  #define GC2145_REG_DPHY_ANALOG_MODE1	CCI_REG8(0x01)
> @@ -598,6 +608,7 @@ struct gc2145 {
>  	struct v4l2_subdev sd;
>  	struct media_pad pad;
>  
> +	struct v4l2_fwnode_endpoint ep; /* the parsed DT endpoint info */
>  	struct regmap *regmap;
>  	struct clk *xclk;
>  
> @@ -612,6 +623,11 @@ struct gc2145 {
>  	const struct gc2145_mode *mode;
>  };
>  
> +static inline bool gc2145_is_csi2(const struct gc2145 *gc2145)
> +{
> +	return gc2145->ep.bus_type == V4L2_MBUS_CSI2_DPHY;

This is used in a single place. Could you move this comparison there?

> +}
> +
>  static inline struct gc2145 *to_gc2145(struct v4l2_subdev *_sd)
>  {
>  	return container_of(_sd, struct gc2145, sd);
> @@ -773,6 +789,38 @@ static int gc2145_set_pad_format(struct v4l2_subdev *sd,
>  	return 0;
>  }
>  
> +static int gc2145_config_dvp_mode(struct gc2145 *gc2145,
> +				   const struct gc2145_format *gc2145_format)
> +{
> +	int ret = 0;
> +	u64 sync_mode;
> +	int flags;
> +
> +	flags = gc2145->ep.bus.parallel.flags;
> +
> +	ret = cci_read(gc2145->regmap, GC2145_REG_SYNC_MODE, &sync_mode, NULL);
> +	if (ret)
> +		return ret;
> +
> +	sync_mode &= ~(GC2145_SYNC_MODE_VSYNC_POL |
> +		       GC2145_SYNC_MODE_HSYNC_POL |
> +		       GC2145_SYNC_MODE_OPCLK_POL);
> +
> +	if (flags & V4L2_MBUS_VSYNC_ACTIVE_LOW)
> +		sync_mode |= GC2145_SYNC_MODE_VSYNC_POL;
> +
> +	if (flags & V4L2_MBUS_HSYNC_ACTIVE_LOW)
> +		sync_mode |= GC2145_SYNC_MODE_HSYNC_POL;
> +
> +	if (flags & V4L2_MBUS_PCLK_SAMPLE_FALLING)
> +		sync_mode |= GC2145_SYNC_MODE_OPCLK_POL;
> +
> +	cci_write(gc2145->regmap, GC2145_REG_SYNC_MODE, sync_mode, &ret);
> +	cci_write(gc2145->regmap, GC2145_REG_PAD_IO, 0x0f, &ret);
> +
> +	return ret;
> +}
> +
>  static const struct cci_reg_sequence gc2145_common_mipi_regs[] = {
>  	{GC2145_REG_PAGE_SELECT, 0x03},
>  	{GC2145_REG_DPHY_ANALOG_MODE1, GC2145_DPHY_MODE_PHY_CLK_EN |
> @@ -895,10 +943,13 @@ static int gc2145_start_streaming(struct gc2145 *gc2145,
>  		goto err_rpm_put;
>  	}
>  
> -	/* Perform MIPI specific configuration */
> -	ret = gc2145_config_mipi_mode(gc2145, gc2145_format);
> +	/* Perform interface specific configuration */
> +	if (gc2145_is_csi2(gc2145))
> +		ret = gc2145_config_mipi_mode(gc2145, gc2145_format);
> +	else
> +		ret = gc2145_config_dvp_mode(gc2145, gc2145_format);
>  	if (ret) {
> -		dev_err(&client->dev, "%s failed to write mipi conf\n",
> +		dev_err(&client->dev, "%s failed to write interface conf\n",
>  			__func__);
>  		goto err_rpm_put;
>  	}
> @@ -924,6 +975,9 @@ static void gc2145_stop_streaming(struct gc2145 *gc2145)
>  			GC2145_CSI2_MODE_EN | GC2145_CSI2_MODE_MIPI_EN, 0,
>  			&ret);
>  	cci_write(gc2145->regmap, GC2145_REG_PAGE_SELECT, 0x00, &ret);
> +
> +	/* Disable dvp streaming */
> +	cci_write(gc2145->regmap, GC2145_REG_PAD_IO, 0x00, &ret);
>  	if (ret)
>  		dev_err(&client->dev, "%s failed to write regs\n", __func__);
>  
> @@ -1233,9 +1287,8 @@ static int gc2145_init_controls(struct gc2145 *gc2145)
>  static int gc2145_check_hwcfg(struct device *dev)
>  {
>  	struct fwnode_handle *endpoint;
> -	struct v4l2_fwnode_endpoint ep_cfg = {
> -		.bus_type = V4L2_MBUS_CSI2_DPHY
> -	};

First try D-PHY and if that fails, then try PARALLEL.

> +	struct v4l2_subdev *sd = dev_get_drvdata(dev);
> +	struct gc2145 *gc2145 = to_gc2145(sd);
>  	int ret;
>  
>  	endpoint = fwnode_graph_get_next_endpoint(dev_fwnode(dev), NULL);
> @@ -1244,36 +1297,46 @@ static int gc2145_check_hwcfg(struct device *dev)
>  		return -EINVAL;
>  	}
>  
> -	ret = v4l2_fwnode_endpoint_alloc_parse(endpoint, &ep_cfg);
> +	ret = v4l2_fwnode_endpoint_parse(endpoint, &gc2145->ep);

You won't have any link frequencies available with this change.

>  	fwnode_handle_put(endpoint);
>  	if (ret)
>  		return ret;
>  
> -	/* Check the number of MIPI CSI2 data lanes */
> -	if (ep_cfg.bus.mipi_csi2.num_data_lanes != 2) {
> -		dev_err(dev, "only 2 data lanes are currently supported\n");
> -		ret = -EINVAL;
> -		goto out;
> -	}
> +	switch (gc2145->ep.bus_type) {
> +	case V4L2_MBUS_CSI2_DPHY:
> +		/* Check the link frequency set in device tree */
> +		if (!gc2145->ep.nr_of_link_frequencies) {
> +			dev_err(dev, "link-frequencies property not found in DT\n");
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +
> +		/* Check the number of MIPI CSI2 data lanes */
> +		if (gc2145->ep.bus.mipi_csi2.num_data_lanes != 2) {
> +			dev_err(dev, "only 2 data lanes are currently supported\n");
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +
> +		if (gc2145->ep.nr_of_link_frequencies != 3 ||
> +			gc2145->ep.link_frequencies[0] != GC2145_640_480_LINKFREQ ||
> +			gc2145->ep.link_frequencies[1] != GC2145_1280_720_LINKFREQ ||
> +			gc2145->ep.link_frequencies[2] != GC2145_1600_1200_LINKFREQ) {
> +			dev_err(dev, "Invalid link-frequencies provided\n");
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +		break;
>  
> -	/* Check the link frequency set in device tree */
> -	if (!ep_cfg.nr_of_link_frequencies) {
> -		dev_err(dev, "link-frequency property not found in DT\n");
> +	case V4L2_MBUS_PARALLEL:
> +		break;
> +	default:
> +		dev_err(dev, "unsupported bus type %u\n",
> +			gc2145->ep.bus_type);

Fits on the previous line.

>  		ret = -EINVAL;
>  		goto out;
>  	}
> -
> -	if (ep_cfg.nr_of_link_frequencies != 3 ||
> -	    ep_cfg.link_frequencies[0] != GC2145_640_480_LINKFREQ ||
> -	    ep_cfg.link_frequencies[1] != GC2145_1280_720_LINKFREQ ||
> -	    ep_cfg.link_frequencies[2] != GC2145_1600_1200_LINKFREQ) {
> -		dev_err(dev, "Invalid link-frequencies provided\n");
> -		ret = -EINVAL;
> -	}
> -
>  out:
> -	v4l2_fwnode_endpoint_free(&ep_cfg);
> -
>  	return ret;
>  }
>  

-- 
Regards,

Sakari Ailus

