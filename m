Return-Path: <linux-kernel+bounces-3498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B9A816D17
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D3AA2838EC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC1A1A732;
	Mon, 18 Dec 2023 11:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="EDNW29O/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2BE36B12;
	Mon, 18 Dec 2023 11:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B240157E;
	Mon, 18 Dec 2023 12:43:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1702899821;
	bh=3anQqr6EPhRx63Y+Yf/FCOblorVpIHDuk9OxWytz5Wo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EDNW29O/o9aBN8u55RWjRIw6Q7WCxWuCef8kAzu22DfwBHZUgcVi605/aJHE4AViR
	 hQ/+5eUgjanEyWhoHztrYqTZ4HAbkIQEh5pS1JLKq0iRACEOCslMA9RUVe6zXxffjY
	 7RXK6S+wAoBjGE2b0h8+1kNzdPf2KsW3AD+jpTDA=
Date: Mon, 18 Dec 2023 13:44:37 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tommaso Merciai <tomm.merciai@gmail.com>
Cc: linuxfancy@googlegroups.com, sakari.ailus@linux.intel.com,
	Martin Hecht <martin.hecht@avnet.eu>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] media: i2c: alvium: store frame interval in subdev
 state
Message-ID: <20231218114437.GB21105@pendragon.ideasonboard.com>
References: <20231215082452.1720481-1-tomm.merciai@gmail.com>
 <20231215082452.1720481-4-tomm.merciai@gmail.com>
 <20231218025905.GJ5290@pendragon.ideasonboard.com>
 <ZYAfThT/mHdzGdAh@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <20231218110331.GQ5290@pendragon.ideasonboard.com>
 <ZYAqyOEfKp/oiqs9@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <20231218113618.GA21105@pendragon.ideasonboard.com>
 <ZYAvifztnTGoQB51@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZYAvifztnTGoQB51@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>

On Mon, Dec 18, 2023 at 12:39:53PM +0100, Tommaso Merciai wrote:
> On Mon, Dec 18, 2023 at 01:36:18PM +0200, Laurent Pinchart wrote:
> > On Mon, Dec 18, 2023 at 12:19:36PM +0100, Tommaso Merciai wrote:
> > > On Mon, Dec 18, 2023 at 01:03:31PM +0200, Laurent Pinchart wrote:
> > > > On Mon, Dec 18, 2023 at 11:30:38AM +0100, Tommaso Merciai wrote:
> > > > > On Mon, Dec 18, 2023 at 04:59:05AM +0200, Laurent Pinchart wrote:
> > > > > > On Fri, Dec 15, 2023 at 09:24:52AM +0100, Tommaso Merciai wrote:
> > > > > > > Use the newly added storage for frame interval in the subdev state to
> > > > > > > simplify the driver.
> > > > > > > 
> > > > > > > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > > > > > > ---
> > > > > > >  drivers/media/i2c/alvium-csi2.c | 40 ++++++++++-----------------------
> > > > > > >  drivers/media/i2c/alvium-csi2.h |  2 --
> > > > > > >  2 files changed, 12 insertions(+), 30 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
> > > > > > > index fde456357be1..81f683b3c849 100644
> > > > > > > --- a/drivers/media/i2c/alvium-csi2.c
> > > > > > > +++ b/drivers/media/i2c/alvium-csi2.c
> > > > > > > @@ -1643,25 +1643,6 @@ static int alvium_hw_init(struct alvium_dev *alvium)
> > > > > > >  }
> > > > > > >  
> > > > > > >  /* --------------- Subdev Operations --------------- */
> > > > > > > -
> > > > > > > -static int alvium_g_frame_interval(struct v4l2_subdev *sd,
> > > > > > > -				   struct v4l2_subdev_state *sd_state,
> > > > > > > -				   struct v4l2_subdev_frame_interval *fi)
> > > > > > > -{
> > > > > > > -	struct alvium_dev *alvium = sd_to_alvium(sd);
> > > > > > > -
> > > > > > > -	/*
> > > > > > > -	 * FIXME: Implement support for V4L2_SUBDEV_FORMAT_TRY, using the V4L2
> > > > > > > -	 * subdev active state API.
> > > > > > > -	 */
> > > > > > > -	if (fi->which != V4L2_SUBDEV_FORMAT_ACTIVE)
> > > > > > > -		return -EINVAL;
> > > > > > > -
> > > > > > > -	fi->interval = alvium->frame_interval;
> > > > > > > -
> > > > > > > -	return 0;
> > > > > > > -}
> > > > > > > -
> > > > > > >  static int alvium_s_frame_interval(struct v4l2_subdev *sd,
> > > > > > >  				   struct v4l2_subdev_state *sd_state,
> > > > > > >  				   struct v4l2_subdev_frame_interval *fi)
> > > > > > > @@ -1669,6 +1650,7 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
> > > > > > >  	struct alvium_dev *alvium = sd_to_alvium(sd);
> > > > > > >  	struct device *dev = &alvium->i2c_client->dev;
> > > > > > >  	u64 req_fr, dft_fr, min_fr, max_fr;
> > > > > > > +	struct v4l2_fract *interval;
> > > > > > >  	int ret;
> > > > > > >  
> > > > > > >  	/*
> > > > > > 
> > > > > > You should drop the FIXME comment here and the ACTIVE check...
> > > > > 
> > > > > Oks, thanks.
> > > > > 
> > > > > > > @@ -1701,9 +1683,10 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
> > > > > > >  	if (req_fr >= max_fr && req_fr <= min_fr)
> > > > > > >  		req_fr = dft_fr;
> > > > > > >  
> > > > > > > -	alvium->fr = req_fr;
> > > > > > > -	alvium->frame_interval.numerator = fi->interval.numerator;
> > > > > > > -	alvium->frame_interval.denominator = fi->interval.denominator;
> > > > > > > +	interval = v4l2_subdev_state_get_interval(sd_state, 0);
> > > > > > > +
> > > > > > > +	interval->numerator = fi->interval.numerator;
> > > > > > > +	interval->denominator = fi->interval.denominator;
> > > > > > >  
> > > > > > 
> > > > > > ... and here only call alvium_set_frame_rate() for the ACTIVE frame
> > > > > > interval.
> > > > > 
> > > > > I don't completely got this comment, can you give me more details about
> > > > > please. Thanks in advance!
> > > > 
> > > > alvium_s_frame_interval() can be called both for the TRY and ACTIVE
> > > > status. The hardware registers should be written only for the ACTIVE
> > > > state.
> > > 
> > > Do you think could be sufficient an if check like this?
> > > 
> > > -	return alvium_set_frame_rate(alvium, req_fr);
> > > +	if (fi->which == V4L2_SUBDEV_FORMAT_ACTIVE)
> > > +		return alvium_set_frame_rate(alvium, req_fr);
> > > +
> > > +	return ret;
> > 
> > That's the idea, yes. The "return ret" can become "return 0". Or you
> > could write
> > 
> > 	if (fi->which != V4L2_SUBDEV_FORMAT_ACTIVE)
> > 		return 0;
> > 
> > 	return alvium_set_frame_rate(alvium, req_fr);
> > 
> > >  }
> 
> (This is my personal idea eh :) )
> 
> Maybe better:
> 
> 	if (fi->which == V4L2_SUBDEV_FORMAT_ACTIVE)
> 		ret = alvium_set_frame_rate(alvium, req_fr);
> 
> 	return ret;

Works fine too (assuming ret gets initialized properly).

> > > > > > > @@ -1853,6 +1836,7 @@ static int alvium_init_state(struct v4l2_subdev *sd,
> > > > > > >  {
> > > > > > >  	struct alvium_dev *alvium = sd_to_alvium(sd);
> > > > > > >  	struct alvium_mode *mode = &alvium->mode;
> > > > > > > +	struct v4l2_fract *interval;
> > > > > > >  	struct v4l2_subdev_format sd_fmt = {
> > > > > > >  		.which = V4L2_SUBDEV_FORMAT_TRY,
> > > > > > >  		.format = alvium_csi2_default_fmt,
> > > > > > > @@ -1870,6 +1854,11 @@ static int alvium_init_state(struct v4l2_subdev *sd,
> > > > > > >  	*v4l2_subdev_state_get_crop(state, 0) = sd_crop.rect;
> > > > > > >  	*v4l2_subdev_state_get_format(state, 0) = sd_fmt.format;
> > > > > > >  
> > > > > > > +	/* Setup initial frame interval*/
> > > > > > > +	interval = v4l2_subdev_state_get_interval(state, 0);
> > > > > > > +	interval->numerator = 1;
> > > > > > > +	interval->denominator = ALVIUM_DEFAULT_FR_HZ;
> > > > > > > +
> > > > > > >  	return 0;
> > > > > > >  }
> > > > > > >  
> > > > > > > @@ -2239,7 +2228,7 @@ static const struct v4l2_subdev_pad_ops alvium_pad_ops = {
> > > > > > >  	.set_fmt = alvium_set_fmt,
> > > > > > >  	.get_selection = alvium_get_selection,
> > > > > > >  	.set_selection = alvium_set_selection,
> > > > > > > -	.get_frame_interval = alvium_g_frame_interval,
> > > > > > > +	.get_frame_interval = v4l2_subdev_get_frame_interval,
> > > > > > >  	.set_frame_interval = alvium_s_frame_interval,
> > > > > > >  };
> > > > > > >  
> > > > > > > @@ -2260,11 +2249,6 @@ static int alvium_subdev_init(struct alvium_dev *alvium)
> > > > > > >  	struct v4l2_subdev *sd = &alvium->sd;
> > > > > > >  	int ret;
> > > > > > >  
> > > > > > > -	/* Setup initial frame interval*/
> > > > > > > -	alvium->frame_interval.numerator = 1;
> > > > > > > -	alvium->frame_interval.denominator = ALVIUM_DEFAULT_FR_HZ;
> > > > > > > -	alvium->fr = ALVIUM_DEFAULT_FR_HZ;
> > > > > > > -
> > > > > > >  	/* Setup the initial mode */
> > > > > > >  	alvium->mode.fmt = alvium_csi2_default_fmt;
> > > > > > >  	alvium->mode.width = alvium_csi2_default_fmt.width;
> > > > > > > diff --git a/drivers/media/i2c/alvium-csi2.h b/drivers/media/i2c/alvium-csi2.h
> > > > > > > index a6529b28e7dd..f5e26257b042 100644
> > > > > > > --- a/drivers/media/i2c/alvium-csi2.h
> > > > > > > +++ b/drivers/media/i2c/alvium-csi2.h
> > > > > > > @@ -442,8 +442,6 @@ struct alvium_dev {
> > > > > > >  	s32 inc_sharp;
> > > > > > >  
> > > > > > >  	struct alvium_mode mode;
> > > > > > > -	struct v4l2_fract frame_interval;
> > > > > > > -	u64 fr;
> > > > > > 
> > > > > > The fr field should have been removed by a previous patch (the one that
> > > > > > will go between 1/3 an 2/3, see my review of 1/3) as shown by the fact
> > > > > > that this patch only removes two locations where the field is set but
> > > > > > none where it's read.
> > > > > > 
> > > > > > >  
> > > > > > >  	u8 h_sup_csi_lanes;
> > > > > > >  	u64 link_freq;

-- 
Regards,

Laurent Pinchart

