Return-Path: <linux-kernel+bounces-77913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BAD860C14
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B240283BF8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3D3199B9;
	Fri, 23 Feb 2024 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q8NnMJki"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5787F18E3F;
	Fri, 23 Feb 2024 08:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708676359; cv=none; b=YNDIrZvp1YhUFdcOqE/QiAZYgKjpuGii0B5UzLE7/Ycd7Z7BTc6Nyyi4S3JEa/AHN0FfxqEEQnjoB5aVLoCiW/Xb0VlPEaaz1B9nGqCfBwbEc+aie4JWRbhR7SKQpjjJOkRuiyu2HdhEItLhsLKQcYpRqicFKnoLUYPlf41KUXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708676359; c=relaxed/simple;
	bh=WOz3K7fGcR+hiIvIfBIGp8ujfEAcshj/zn68XDonDmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V18LN2ZHEH37ES57jg9CM4QmEsmTRsDeOCsXiTpp8hLxvVDjzx+eWYRV1hfPP0Cleqza+mSBPT0Vxze6nR3MGsmsSNkgwuH/p21md10bblSogYvCzgpToKlCXOUqls2Fre7anCPdCxYVJ7sNimkRZrim2J8xt7q+2tOjikFWGk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q8NnMJki; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708676359; x=1740212359;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WOz3K7fGcR+hiIvIfBIGp8ujfEAcshj/zn68XDonDmA=;
  b=Q8NnMJkisXYY6o8rfxrg1bmUYHaPp+vige1A2dScm1MZTnMucXykTCZ+
   G/xTetnlNp/LYEPyb1GMeQaouyMjzQEZ6gOSeqyTQ5b1ZWAqhofjAD9vE
   Qs7o3VTan70itf7t8iYgHRZ8n0e/RlR5bXhO/5jRL3SSB9egRCXbwqR1q
   5ZIs0VcilbN6NNSIYiY+bsDTJwbyx+RIDfbi3ZqQm8dbP9eVMTtFtn3OD
   FrKCBWEHzADYrROSq1iQ/q6prRAnRqZsVNS0a/imSfZJCRxuy+sik3ALV
   o5a6R2dIa1wv1w3foMDCQuuoNmGp27n/gCWgg/euZQJSDN6E/Tj4v26Lx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="14405366"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="14405366"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 00:19:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="6036345"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 00:19:15 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 7A52711F81D;
	Fri, 23 Feb 2024 10:19:12 +0200 (EET)
Date: Fri, 23 Feb 2024 08:19:12 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Mikhail Rudenko <mike.rudenko@gmail.com>
Cc: Sakari Ailus <sakari.ailus@iki.fi>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2 09/20] media: i2c: ov4689: Use runtime PM autosuspend
Message-ID: <ZdhVAEElqzmJAynB@kekkonen.localdomain>
References: <20231218174042.794012-1-mike.rudenko@gmail.com>
 <20231218174042.794012-10-mike.rudenko@gmail.com>
 <ZZvaDyGSMrjb6e75@valkosipuli.retiisi.eu>
 <878r4z4ysb.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878r4z4ysb.fsf@gmail.com>

Hi Mikhail,

On Mon, Jan 08, 2024 at 06:06:52PM +0300, Mikhail Rudenko wrote:
> Hi Sakari,
> 
> Thanks for the review!
> 
> On 2024-01-08 at 11:18 GMT, Sakari Ailus <sakari.ailus@iki.fi> wrote:
> 
> > Hi Mikhail,
> >
> > On Mon, Dec 18, 2023 at 08:40:30PM +0300, Mikhail Rudenko wrote:
> >> Use runtime PM autosuspend to avoid powering off the sensor during
> >> fast stop-reconfigure-restart cycles.
> >>
> >> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
> >> ---
> >>  drivers/media/i2c/ov4689.c | 22 +++++++++++++++-------
> >>  1 file changed, 15 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
> >> index 5300e621ff90..64cc6d9e48cc 100644
> >> --- a/drivers/media/i2c/ov4689.c
> >> +++ b/drivers/media/i2c/ov4689.c
> >> @@ -407,26 +407,27 @@ static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
> >>  					  ov4689->cur_mode->num_regs,
> >>  					  NULL);
> >>  		if (ret) {
> >> -			pm_runtime_put(dev);
> >> +			pm_runtime_put_sync(dev);
> >
> > Why are you switching to pm_runtime_put_sync() here? That isn't covered by
> > the commit message (nor I think should be done).
> 
> PM autosuspend conversion was suggested earlier by Laurent in his review
> of this series [1], and he adviced looking at how it was done for the
> imx290 driver. I followed along the lines of the corresponding patch
> [2].

There's no need to use the _sync() variant here. And at least it wouldn't
be related to autosuspend, were you to switch to that.

> 
> >>  			goto unlock_and_return;
> >>  		}
> >>
> >>  		ret = __v4l2_ctrl_handler_setup(&ov4689->ctrl_handler);
> >>  		if (ret) {
> >> -			pm_runtime_put(dev);
> >> +			pm_runtime_put_sync(dev);
> >>  			goto unlock_and_return;
> >>  		}
> >>
> >>  		ret = cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
> >>  				OV4689_MODE_STREAMING, NULL);
> >>  		if (ret) {
> >> -			pm_runtime_put(dev);
> >> +			pm_runtime_put_sync(dev);
> >>  			goto unlock_and_return;
> >>  		}
> >>  	} else {
> >>  		cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
> >>  			  OV4689_MODE_SW_STANDBY, NULL);
> >> -		pm_runtime_put(dev);
> >> +		pm_runtime_mark_last_busy(dev);
> >> +		pm_runtime_put_autosuspend(dev);
> >>  	}
> >>
> >>  unlock_and_return:
> >> @@ -606,7 +607,9 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
> >>  		break;
> >>  	}
> >>
> >> -	pm_runtime_put(dev);
> >> +	pm_runtime_mark_last_busy(dev);
> >> +	pm_runtime_put_autosuspend(dev);
> >
> > Also note that with runtime PM autosuspend,  you have to use
> > pm_runtime_get_if_active() instead of pm_runtime_get_if_in_use().
> 
> Noted, will do so in v3.
> 
> >> +
> >>  	return ret;
> >>  }
> >>
> >> @@ -877,8 +880,10 @@ static int ov4689_probe(struct i2c_client *client)
> >>  	}
> >>
> >>  	pm_runtime_set_active(dev);
> >> +	pm_runtime_get_noresume(dev);
> >>  	pm_runtime_enable(dev);
> >> -	pm_runtime_idle(dev);
> >> +	pm_runtime_set_autosuspend_delay(dev, 1000);
> >> +	pm_runtime_use_autosuspend(dev);
> >>
> >>  	ret = v4l2_async_register_subdev_sensor(sd);
> >>  	if (ret) {
> >> @@ -886,11 +891,14 @@ static int ov4689_probe(struct i2c_client *client)
> >>  		goto err_clean_subdev_pm;
> >>  	}
> >>
> >> +	pm_runtime_mark_last_busy(dev);
> >> +	pm_runtime_put_autosuspend(dev);
> >> +
> >>  	return 0;
> >>
> >>  err_clean_subdev_pm:
> >>  	pm_runtime_disable(dev);
> >> -	pm_runtime_set_suspended(dev);
> >> +	pm_runtime_put_noidle(dev);
> >>  	v4l2_subdev_cleanup(sd);
> >>  err_clean_entity:
> >>  	media_entity_cleanup(&sd->entity);
> 
> [1] https://lore.kernel.org/all/20231211181935.GG27535@pendragon.ideasonboard.com/
> [2] https://lore.kernel.org/all/20230116144454.1012-14-laurent.pinchart@ideasonboard.com/
> 

-- 
Regards,

Sakari Ailus

