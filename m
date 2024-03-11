Return-Path: <linux-kernel+bounces-99291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0656878613
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900EE281F20
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030864D59B;
	Mon, 11 Mar 2024 17:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g8ju/OH8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5C33BB29;
	Mon, 11 Mar 2024 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710177066; cv=none; b=Rkm+Nyeg2J72lmCqSW4D3yqMj9w+5tzzLwkzXQ7hzCi5Vo/zuT7O1iicR1cD//NJkB4zsNP/3c9EvpUo12O314vB4w5HL8OT6n+GTPcArEZYbuK7MyK07cfnB5s8OvcHqGtjY627KrjXU+lgC4JcSLbBcZ7VTeOFqmD37cIWGUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710177066; c=relaxed/simple;
	bh=SnWDqsNR8fmTdDjQzqXGo9Y1BV3aJUfcIxhmuN3gCeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vd71HvyEb4FGYfnlFImEYrzFomFphiggLg/56lzLzeGBn5FZ60JJcs4CLDt4JAkndvk86xNImVKXkx5ScYswXl/WOWyYSlkO4XpHAZbV7Vbfz+vmhdRf37MYhxt1FjUM2sSvSbR4iq+dlaKT4q3TvKqpVAmquMMhPBx0b4jh5+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g8ju/OH8; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710177063; x=1741713063;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SnWDqsNR8fmTdDjQzqXGo9Y1BV3aJUfcIxhmuN3gCeY=;
  b=g8ju/OH8GcMWiTHLqg9wqys/Oo9zwXjmOLBOgS1j4U0MO+tXLony16PK
   +Vji5IXB5nLU521ONnS8JP0YViK4QU3D+eocrTbCcBRtggID1UiAM0xtL
   JRGK9sPWFb6gg8r+3v+3mT/8uq304uB3tVIvkfz1xjGF+JVYtx9HFqNIv
   fN2wDszntwwFo8I4xXhf9LhZFpaAQxFNJ9sytPY/vZe0cZ6iffmv5PKLE
   ZvkSzwYArhnDoF6jWysvv7VEPoJYCFDqBO2mObRG4ZsbMCeNmxW3bGSvG
   5gljO2fCrKQvAPNaoWsP+Y4FQyHryHICA6AabCUDK2SKXEB2nn5OXPreA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="30297475"
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="30297475"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 10:11:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="42150015"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 10:10:57 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 322D711FCAC;
	Mon, 11 Mar 2024 19:10:55 +0200 (EET)
Date: Mon, 11 Mar 2024 17:10:55 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Umang Jain <umang.jain@ideasonboard.com>, linux-media@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	willl will <will@willwhang.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Hans de Goede <hdegoede@redhat.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Paul Elder <paul.elder@ideasonboard.com>,
	Mehdi Djait <mehdi.djait@bootlin.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] media: i2c: Add imx283 camera sensor driver
Message-ID: <Ze87Hya-cqmkqjMC@kekkonen.localdomain>
References: <20240307214048.858318-1-umang.jain@ideasonboard.com>
 <20240307214048.858318-3-umang.jain@ideasonboard.com>
 <Zeq7HBMqqrw4nSPj@kekkonen.localdomain>
 <171016009901.2924028.16001544322304093037@ping.linuxembedded.co.uk>
 <Ze8xY1bqTiXzRvKp@kekkonen.localdomain>
 <171017536692.2924028.6522729664515712567@ping.linuxembedded.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171017536692.2924028.6522729664515712567@ping.linuxembedded.co.uk>

Hi Kieran,

On Mon, Mar 11, 2024 at 04:42:46PM +0000, Kieran Bingham wrote:
> Quoting Sakari Ailus (2024-03-11 16:29:23)
> > Hi Kieran,
> > 
> > On Mon, Mar 11, 2024 at 12:28:19PM +0000, Kieran Bingham wrote:
> > > Hi Sakari, Umang,
> > > 
> > > I've replied inline below to a couple of points that I was responsible for.
> > > 
> > > > 
> > > > > +
> > > > > +struct imx283 {
> > > > > +     struct device *dev;
> > > > > +     struct regmap *cci;
> > > > > +
> > > > > +     const struct imx283_input_frequency *freq;
> > > > > +
> > > > > +     struct v4l2_subdev sd;
> > > > > +     struct media_pad pad;
> > > > > +
> > > > > +     struct clk *xclk;
> > > > > +
> > > > > +     struct gpio_desc *reset_gpio;
> > > > > +     struct regulator_bulk_data supplies[ARRAY_SIZE(imx283_supply_name)];
> > > > > +
> > > > > +     /* V4L2 Controls */
> > > > > +     struct v4l2_ctrl_handler ctrl_handler;
> > > > > +     struct v4l2_ctrl *exposure;
> > > > > +     struct v4l2_ctrl *vblank;
> > > > > +     struct v4l2_ctrl *hblank;
> > > > > +     struct v4l2_ctrl *vflip;
> > > > > +
> > > > > +     unsigned long link_freq_bitmap;
> > > > > +
> > > > > +     u16 hmax;
> > > > > +     u32 vmax;
> > > > > +};
> > > > > +
> > > > > +static inline struct imx283 *to_imx283(struct v4l2_subdev *_sd)
> > > > > +{
> > > > > +     return container_of(_sd, struct imx283, sd);
> > > > 
> > > > It's a function, you can call _sd sd instead.
> > > 
> > > Except then that could 'look' like it is passed as the first and third
> > > argument to container_of...
> > 
> > It's really a non-issue: the third argument is a field name, not a
> > variable.
> 
> That's not so easy to determine when the args are the same name.., but
> it's fine with me either way.
> 
> > > But if it's fine / accepted otherwise then sure.
> > 
> > And please use container_of_const(). :)
> 
> Ack. Or rather ... I'll leave that to Umang to handle, as he's managing
> this driver now.
> 
> > > > > +
> > > > > +/* Determine the exposure based on current hmax, vmax and a given SHR */
> > > > > +static u64 imx283_exposure(struct imx283 *imx283,
> > > > > +                        const struct imx283_mode *mode, u64 shr)
> > > > > +{
> > > > > +     u32 svr = 0; /* SVR feature is not currently supported */
> > > > 
> > > > What does this refer to? I guess you could just drop it as well if it's not
> > > > supported?
> > > 
> > > Keeping this will keep the calculation matching the datasheet, and
> > > provide clear value for what to update when we/others return to enable
> > > long exposures.
> > > 
> > > So it would be nice to keep as it sort of documents/tracks the
> > > datasheet.
> > 
> > Ack.
> > 
> > > 
> > > 
> > > > > +     u32 hmax = imx283->hmax;
> > > > > +     u64 vmax = imx283->vmax;
> > > > 
> > > > You're not changing the values here. I wouldn't introduce temporary
> > > > variables just for that.
> > > > 
> > > > > +     u32 offset;
> > > > > +     u64 numerator;
> > > > > +
> > > > > +     /* Number of clocks per internal offset period */
> > > > > +     offset = mode->mode == IMX283_MODE_0 ? 209 : 157;
> > > > 
> > > > Shouldn't this be in the mode definition?
> > > 
> > > It could be, but then there would be one copy of 209, and 9 copies of
> > > 157. 
> > 
> > That would still be specified explicitly. Someone adding a new mode would
> > easily miss this.
> > 
> > Or, if you can, derive this from something else that is now a part of the
> > mode itself.
> 
> I don't understand the above, other than ... That's exactly what we're
> doing here.

Index of the mode, not the mode itself. They're different.

> 
> *Only* MODE_0 has an offset of 209 in the datasheet. All other modes are
> 157.
> 
> This is the table being codified:
>   https://pasteboard.co/OsKf4VX7rtrS.png

Ok, fine by me. Maybe a comment at the end of the mode list to check this
when adding new modes? There are other sources of modes than the datasheet.

-- 
Sakari Ailus

