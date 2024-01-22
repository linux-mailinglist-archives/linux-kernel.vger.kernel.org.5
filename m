Return-Path: <linux-kernel+bounces-33157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFF7836561
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C684B25CBD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B873D3AE;
	Mon, 22 Jan 2024 14:28:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730453D540;
	Mon, 22 Jan 2024 14:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705933714; cv=none; b=AGnKKfnOEG+8Qo+0bZqSTanfNEj2yJzbVlirTrd8bvvJVfxrby80nxyYj55I30Rsc+31pjdTQBfFaK2/5mkBW5SajM/SpP4IPpzC+fcVOuqZ1CurKmIl+sk1PlFS2syxykpJL+yOFCqU7FPRTZZ2Bs4UMugKIIO2wYKUAcfCqVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705933714; c=relaxed/simple;
	bh=wKYLc46OaXYdyZIR8EPFUIwqMGtJkElacXNktfcfIqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TcHK4bcZlXXOIY+k3HvtWmSnjvuYllhRYcNSLDaojOOcIiK1BrS4y+bzjaInWhrbJNej/yjXrOPFpycx1bRxsbjxl6XIdXzf8Y/wXW6gNozsVMVSOSB9Lh2BjY1FRxuAYwNX+wc2qOWqBTibZaSo761AUKytrGo1oH/s5N6+SFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C2121FB;
	Mon, 22 Jan 2024 06:29:16 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 151A73F73F;
	Mon, 22 Jan 2024 06:28:28 -0800 (PST)
Date: Mon, 22 Jan 2024 14:28:26 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: sudeep.holla@arm.com, jdelvare@suse.com, linux@roeck-us.net,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] hwmon: scmi-hwmon: implement change_mode
Message-ID: <Za57itGEQtLqCNcg@pluto>
References: <20240122080441.1957022-1-peng.fan@oss.nxp.com>
 <Za5Kgp6_qUEMc-AO@pluto>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za5Kgp6_qUEMc-AO@pluto>

On Mon, Jan 22, 2024 at 10:59:18AM +0000, Cristian Marussi wrote:
> On Mon, Jan 22, 2024 at 04:04:41PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> > 
> > The sensor maybe disabled before kernel boot, so add change_mode
> > to support configuring the sensor to enabled state.
> > 
> 
> Hi Peng,
> 
> minor remarks down below
> 
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/hwmon/scmi-hwmon.c | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> > 
> > diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
> > index 364199b332c0..f7bd63d52d15 100644
> > --- a/drivers/hwmon/scmi-hwmon.c
> > +++ b/drivers/hwmon/scmi-hwmon.c
> > @@ -151,7 +151,36 @@ static int scmi_hwmon_thermal_get_temp(struct thermal_zone_device *tz,
> >  	return ret;
> >  }
> >  
> > +static int scmi_hwmon_thermal_change_mode(struct thermal_zone_device *tz,
> > +					  enum thermal_device_mode new_mode)
> > +{
> > +	int ret;
> > +	u32 config;
> > +	enum thermal_device_mode cur_mode = THERMAL_DEVICE_DISABLED;
> > +	struct scmi_thermal_sensor *th_sensor = thermal_zone_device_priv(tz);
> > +
> > +	ret = sensor_ops->config_get(th_sensor->ph, th_sensor->info->id,
> > +				     &config);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (config & BIT(0))
> 
> if SCMI_SENS_CFG_IS_ENABLED(config)
> 
> > +		cur_mode = THERMAL_DEVICE_ENABLED;
> > +
> > +	if (cur_mode == new_mode)
> > +		return 0;
> > +
> > +	if (new_mode == THERMAL_DEVICE_ENABLED)
> > +		config |= SCMI_SENS_CFG_SENSOR_ENABLED_MASK;
> > +	else
> > +		config &= ~SCMI_SENS_CFG_SENSOR_ENABLED_MASK;
> > +
> 
> Here you are ORing the enable bit to preserve the value obtained by
> config_get (rightly so), BUT unfortunately looking at the spec
> CONFIG_SET uses bits [10:9] for setting the rounding mode while
> CONFIG_GET does NOT report (bits [10:2] are Reserved) so you are
> in fact setting ROUNDING to 00 probably, meaning ROUND_DOWN.
> 
> We could have to add (in the future not now) something in CONFIG_GET
> to get the round mode (I'll speak with Souvik) BUT in the meantime I
> wonder if it is not more safe here to just explicitly set the mode to
> 10 to signify it is up to the platform to autonomously choose how to
> round. (there are SCMI_SENS_CFG_ROUND_ macros and mask in
> scmi_protocol.h)

..so after a quick check with ATG, this ROUNDING mode is indeed related
to this specific CONFIG_SET request being issued...it is not a general
sensor config, so it is not and will not be needed to be reported from
CONFIG_GET (and was indeed clear from the spec my bad...).

Moreover looking better at SENSOR_CONFIG_SET spec the sensor_update_interval
field can be set to 0 if not required to be updated....so I suppose the
better policy here is to just clear out all the bits [31:9] before setting
the enable bit, while KEEPING the original timestamp bit untouched.

A bit tricky...sorry for the confusion.

Thanks,
Cristian

