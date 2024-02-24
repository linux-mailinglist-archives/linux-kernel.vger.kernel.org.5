Return-Path: <linux-kernel+bounces-79806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CBC862708
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0633F1C20CEE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 19:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C864C631;
	Sat, 24 Feb 2024 19:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bb45UtiT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E74A1119C;
	Sat, 24 Feb 2024 19:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708803529; cv=none; b=eiUod6529umOLoY7g90fuEwvnPSf8GP5lSAZNcoULfq4jlwwzsE/t76f097yBSAQgT0eyDf8KQM2QJZf3V+FMLCpXV/PLl14FSnOpd38HGHGtwGgeRvioGnRC1ICTlnoDaDo4/TIx8ya3aOruNG0oU7oSgaFwvGKxC4/xvCoQQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708803529; c=relaxed/simple;
	bh=PXqNba8sde+VywJIwPzENto8mlwD0XFpHcxY9M1Joz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O651tv7tnoXQFV3KJN3yef+1FVMg6Mx7bpA/Kz46/QN+mBErsfZlqS6Jl+J2YBROGrZkgdxD5NhNKC/POdrohFXx4r8i2ym7A7fLSaxIO69h0jy0THZQ8RLFQb05KcESKw0sYRzfA94drnGhAIKa/USl8HTD2b5fVUETEuJmcDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bb45UtiT; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708803528; x=1740339528;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PXqNba8sde+VywJIwPzENto8mlwD0XFpHcxY9M1Joz4=;
  b=bb45UtiT3ZmN05p45CSJ5QbSHzLWwPO+Vc1H7wOZYpaK5fcQA6ChWa/x
   T+FClJNKCkpLAZMuSbiNgB8vpu8HM3ylDozU8U0KqSOVpJYrSUKqvnQaf
   SDWRfvx/zWNp3c5jZ7UiA6CInTZ8nxI9Axros2gp9QC9Wb0XCOra/gm6m
   ys913V5Ay/1mPdD8BsQgbRRmstkrKn+Aq8kdWgRtXB0aWXN6M5reRbMed
   WkdrHot/p0ZXuqKiZTb4kb2tSWy0Ba+HEUMbTEj/KEQ0LApOK9o4X36f0
   knfXlcrBp2CgM03NJHiysKLj6teOKvd8ww78QhTw2xcuSGrThXRj6wyfE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10994"; a="3246192"
X-IronPort-AV: E=Sophos;i="6.06,182,1705392000"; 
   d="scan'208";a="3246192"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2024 11:38:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,182,1705392000"; 
   d="scan'208";a="6244808"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2024 11:38:44 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 2B2C111F853;
	Sat, 24 Feb 2024 21:38:42 +0200 (EET)
Date: Sat, 24 Feb 2024 19:38:42 +0000
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
Message-ID: <ZdpFwtU0iJEFWxhu@kekkonen.localdomain>
References: <20231218174042.794012-1-mike.rudenko@gmail.com>
 <20231218174042.794012-10-mike.rudenko@gmail.com>
 <ZZvaDyGSMrjb6e75@valkosipuli.retiisi.eu>
 <878r4z4ysb.fsf@gmail.com>
 <ZdhVAEElqzmJAynB@kekkonen.localdomain>
 <87le7bdsk4.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87le7bdsk4.fsf@gmail.com>

Hi Mikhail,

On Fri, Feb 23, 2024 at 06:18:12PM +0300, Mikhail Rudenko wrote:
> 
> Hi Sakari,
> 
> and thanks for the review!
> 
> On 2024-02-23 at 08:19 GMT, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
> 
> > Hi Mikhail,
> >
> > On Mon, Jan 08, 2024 at 06:06:52PM +0300, Mikhail Rudenko wrote:
> >> Hi Sakari,
> >>
> >> Thanks for the review!
> >>
> >> On 2024-01-08 at 11:18 GMT, Sakari Ailus <sakari.ailus@iki.fi> wrote:
> >>
> >> > Hi Mikhail,
> >> >
> >> > On Mon, Dec 18, 2023 at 08:40:30PM +0300, Mikhail Rudenko wrote:
> >> >> Use runtime PM autosuspend to avoid powering off the sensor during
> >> >> fast stop-reconfigure-restart cycles.
> >> >>
> >> >> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
> >> >> ---
> >> >>  drivers/media/i2c/ov4689.c | 22 +++++++++++++++-------
> >> >>  1 file changed, 15 insertions(+), 7 deletions(-)
> >> >>
> >> >> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
> >> >> index 5300e621ff90..64cc6d9e48cc 100644
> >> >> --- a/drivers/media/i2c/ov4689.c
> >> >> +++ b/drivers/media/i2c/ov4689.c
> >> >> @@ -407,26 +407,27 @@ static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
> >> >>  					  ov4689->cur_mode->num_regs,
> >> >>  					  NULL);
> >> >>  		if (ret) {
> >> >> -			pm_runtime_put(dev);
> >> >> +			pm_runtime_put_sync(dev);
> >> >
> >> > Why are you switching to pm_runtime_put_sync() here? That isn't covered by
> >> > the commit message (nor I think should be done).
> >>
> >> PM autosuspend conversion was suggested earlier by Laurent in his review
> >> of this series [1], and he adviced looking at how it was done for the
> >> imx290 driver. I followed along the lines of the corresponding patch
> >> [2].
> >
> > There's no need to use the _sync() variant here. And at least it wouldn't
> > be related to autosuspend, were you to switch to that.
> 
> Ok, will use pm_runtime_put in v3. Or do you suggest dropping this patch
> altogether? Laurent?

Using autosuspend is preferred.

Much of the benefit come from avoiding redundant register writes but that's
a separate matter.

> 
> >>
> >> >>  			goto unlock_and_return;
> >> >>  		}
> >> >>
> >> >>  		ret = __v4l2_ctrl_handler_setup(&ov4689->ctrl_handler);
> >> >>  		if (ret) {
> >> >> -			pm_runtime_put(dev);
> >> >> +			pm_runtime_put_sync(dev);
> >> >>  			goto unlock_and_return;
> >> >>  		}
> >> >>
> >> >>  		ret = cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
> >> >>  				OV4689_MODE_STREAMING, NULL);
> >> >>  		if (ret) {
> >> >> -			pm_runtime_put(dev);
> >> >> +			pm_runtime_put_sync(dev);
> >> >>  			goto unlock_and_return;
> >> >>  		}
> >> >>  	} else {
> >> >>  		cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
> >> >>  			  OV4689_MODE_SW_STANDBY, NULL);
> >> >> -		pm_runtime_put(dev);
> >> >> +		pm_runtime_mark_last_busy(dev);
> >> >> +		pm_runtime_put_autosuspend(dev);
> >> >>  	}
> >> >>
> >> >>  unlock_and_return:
> >> >> @@ -606,7 +607,9 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
> >> >>  		break;
> >> >>  	}
> >> >>
> >> >> -	pm_runtime_put(dev);
> >> >> +	pm_runtime_mark_last_busy(dev);
> >> >> +	pm_runtime_put_autosuspend(dev);
> >> >
> >> > Also note that with runtime PM autosuspend,  you have to use
> >> > pm_runtime_get_if_active() instead of pm_runtime_get_if_in_use().
> >>
> >> Noted, will do so in v3.
> >>
> >> >> +
> >> >>  	return ret;
> >> >>  }
> >> >>
> >> >> @@ -877,8 +880,10 @@ static int ov4689_probe(struct i2c_client *client)
> >> >>  	}
> >> >>
> >> >>  	pm_runtime_set_active(dev);
> >> >> +	pm_runtime_get_noresume(dev);
> >> >>  	pm_runtime_enable(dev);
> >> >> -	pm_runtime_idle(dev);
> >> >> +	pm_runtime_set_autosuspend_delay(dev, 1000);
> >> >> +	pm_runtime_use_autosuspend(dev);
> >> >>
> >> >>  	ret = v4l2_async_register_subdev_sensor(sd);
> >> >>  	if (ret) {
> >> >> @@ -886,11 +891,14 @@ static int ov4689_probe(struct i2c_client *client)
> >> >>  		goto err_clean_subdev_pm;
> >> >>  	}
> >> >>
> >> >> +	pm_runtime_mark_last_busy(dev);
> >> >> +	pm_runtime_put_autosuspend(dev);
> >> >> +
> >> >>  	return 0;
> >> >>
> >> >>  err_clean_subdev_pm:
> >> >>  	pm_runtime_disable(dev);
> >> >> -	pm_runtime_set_suspended(dev);
> >> >> +	pm_runtime_put_noidle(dev);
> >> >>  	v4l2_subdev_cleanup(sd);
> >> >>  err_clean_entity:
> >> >>  	media_entity_cleanup(&sd->entity);
> >>
> >> [1] https://lore.kernel.org/all/20231211181935.GG27535@pendragon.ideasonboard.com/
> >> [2] https://lore.kernel.org/all/20230116144454.1012-14-laurent.pinchart@ideasonboard.com/
> >>
> 
> 

-- 
Kind regards,

Sakari Ailus

