Return-Path: <linux-kernel+bounces-19814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4F982749D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1D3283938
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7042524C8;
	Mon,  8 Jan 2024 16:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IQHlGjSV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D195524A8;
	Mon,  8 Jan 2024 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704729808; x=1736265808;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CKxV7cW/dr88DaCe3HV5TLid9v8tv0V60AXriv3nGP8=;
  b=IQHlGjSVXqguU2+LpC2Etofv7rlnlOBvo4eREZidl+OKLYGnekuHWhR7
   kaw5NZeyuyj3koJHDw3TUBTCBklSvbh9MkvPg0DBbDMp0b5Eg5rvzdxFU
   gyXnRvLs/tmLXffUcA3r9/B2JKSmxcLpnloVt2ftKd1cMfHLsHtrTBh11
   9NWlkzzZPIKta6+pQ96DrGjCXn6wuP+H2OQ0GZh1U5abbXJhCzw+1JpRP
   glUDvSnoJa89cdnXEcGtREBJFQhL8Zk1dVP4B9gPM8EwXKBREiN4ZFb6+
   bFXrBSCsV0NDPBb3q7KY6TMse4vQSVUXorSXXi3zG4p722a0aiYy/iNkV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5291062"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="5291062"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 08:03:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="757657915"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="757657915"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 08:03:23 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 5640911F913;
	Mon,  8 Jan 2024 18:03:20 +0200 (EET)
Date: Mon, 8 Jan 2024 16:03:20 +0000
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
Message-ID: <ZZwcyGDJ6Gc2kuOR@kekkonen.localdomain>
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

Ah, I suppose all of these are error cases. I suppose it won't do any harm
in this case but it's not really useful either.

You can get more benefits from autosuspend if you can avoid writing
registers that already have the same values you're writing to them. Thay
may be better left outside this set as it's already fairly big.

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

