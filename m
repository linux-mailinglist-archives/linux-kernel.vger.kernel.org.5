Return-Path: <linux-kernel+bounces-142583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2F98A2D74
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D81742824C2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CD154F86;
	Fri, 12 Apr 2024 11:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="caZylvsN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB50750A6C;
	Fri, 12 Apr 2024 11:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712921469; cv=none; b=bTY/tyKAMvXDZDZ5PayP5HDwfuFBrGQTNgaDw3u1TkcXl0fZSQ3GpJc2JTfG2sf/hoJ29xLmo87HsxB7vng799JTl0TRTRWzbdhI1sULy7L9kANVY6FM+xtRbEhiYzjaV4Fm61K3BVk62n+uQNzZSbbZUXvApKK/gLyHAZw0mPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712921469; c=relaxed/simple;
	bh=L960/YQ59RzbOd8aJJgKPfZJ+eguGt9hV8xigRjXTME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhuxBJZ9KRF2dsivc1CVIv0AqZS7X8txublp0GCNL5H14VHXX0haH1LwWNxnRSatgG7bWV7Io0PhLlIgePGTVN2oSYEVJpFvbUbqPoLiHRTwCKNsAzTTdO6ufVQABtkrX3ufDvrtSi/Ofda/kV+w1VRAz0tP0q38yHjND6gmy9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=caZylvsN; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712921468; x=1744457468;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L960/YQ59RzbOd8aJJgKPfZJ+eguGt9hV8xigRjXTME=;
  b=caZylvsN9zz+dU+ioKn5TP25fa07DShjHnzKP4lLs2iEWbXWEkmj72Nb
   umtVhkaNcwfjkhOxw2nSfVs5JwpMqL2efcLLzFE8gIiAIQE5j7bEyVF5+
   ScqdXCf/bzfp8KX6+nHL3ClpPN5YyXMG/RK9gWyi4Qtk3E9mFUGT8j5VJ
   3wg6JfkADdLMIQIewm+4W5VZPZveMLXfmFyIB+Ae3CSxwzXTM9BrZHCUv
   Vd0x2+P88qyexEVyobG1/qsP0sPAJIwN3Om+7OYj1bZ3zTiAQu/72dVnd
   eXtI3FfA2OnNBc980HecdgTm0zgHeegp7urOyHpgp4M1oZqe2MXy8uY4K
   w==;
X-CSE-ConnectionGUID: 54COLSCpRAOcSrqKP+Xo6A==
X-CSE-MsgGUID: y9glu24hQ9eAAehn+JAnpQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="25827805"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="25827805"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 04:31:08 -0700
X-CSE-ConnectionGUID: 5KxX8M8xRwqYtvWtVt2zMA==
X-CSE-MsgGUID: f6EmvKVfRCe5jt5OCUxFdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="21630403"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 04:31:05 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 7AEBA120359;
	Fri, 12 Apr 2024 14:31:02 +0300 (EEST)
Date: Fri, 12 Apr 2024 11:31:02 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org,
	Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	open list <linux-kernel@vger.kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	jacopo.mondi@ideasonboard.com
Subject: Re: [PATCH v4 2/6] media: imx335: Parse fwnode properties
Message-ID: <Zhkbdu2miLeCNbIg@kekkonen.localdomain>
References: <20240402140924.10009-1-umang.jain@ideasonboard.com>
 <20240402140924.10009-3-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402140924.10009-3-umang.jain@ideasonboard.com>

Hi Umang, Kieran,

On Tue, Apr 02, 2024 at 07:39:20PM +0530, Umang Jain wrote:
> From: Kieran Bingham <kieran.bingham@ideasonboard.com>
> 
> Call the V4L2 fwnode device parser to handle controls that are
> standardised by the framework.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  drivers/media/i2c/imx335.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
> index c633ea1380e7..b8cf85984127 100644
> --- a/drivers/media/i2c/imx335.c
> +++ b/drivers/media/i2c/imx335.c
> @@ -1227,10 +1227,12 @@ static int imx335_init_controls(struct imx335 *imx335)
>  {
>  	struct v4l2_ctrl_handler *ctrl_hdlr = &imx335->ctrl_handler;
>  	const struct imx335_mode *mode = imx335->cur_mode;
> +	struct v4l2_fwnode_device_properties props;
>  	u32 lpfr;
>  	int ret;
>  
> -	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 7);
> +	/* v4l2_fwnode_device_properties can add two more controls */
> +	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 9);
>  	if (ret)
>  		return ret;
>  
> @@ -1296,15 +1298,27 @@ static int imx335_init_controls(struct imx335 *imx335)
>  		imx335->hblank_ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
>  
>  	if (ctrl_hdlr->error) {
> -		dev_err(imx335->dev, "control init failed: %d\n",
> -			ctrl_hdlr->error);
> -		v4l2_ctrl_handler_free(ctrl_hdlr);
> -		return ctrl_hdlr->error;
> +		ret = ctrl_hdlr->error;
> +		dev_err(imx335->dev, "control init failed: %d\n", ret);
> +		goto free_ctrl_hdlr;
>  	}
>  
> +	ret = v4l2_fwnode_device_parse(imx335->dev, &props);
> +	if (ret)
> +		goto free_ctrl_hdlr;
> +
> +	ret = v4l2_ctrl_new_fwnode_properties(ctrl_hdlr, &imx335_ctrl_ops,
> +					      &props);
> +	if (ret)
> +		goto free_ctrl_hdlr;

This works but it'd be nice if v4l2_ctrl_new_fwnode_properties() behaved as
the control framework functions, i.e. bail out if the handler's state has
an error. Then you could have a single check for that, dropping the two
checks above.

Feel free to post a patch. :-)

> +
>  	imx335->sd.ctrl_handler = ctrl_hdlr;
>  
>  	return 0;
> +
> +free_ctrl_hdlr:
> +	v4l2_ctrl_handler_free(ctrl_hdlr);
> +	return ret;
>  }
>  
>  /**

-- 
Regards,

Sakari Ailus

