Return-Path: <linux-kernel+bounces-144653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F99D8A48D4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C87D51F23995
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2AA224D4;
	Mon, 15 Apr 2024 07:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="eNYQa6g/"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC63A22612;
	Mon, 15 Apr 2024 07:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713165506; cv=none; b=iHzArV1KVkRZHjpfVPOHucqanm7XtYjAJ+GLU5C1g7vTGyj0x6dN3N5aqITFjgMMAXPaBoeHq4462QivFm0rjaV5gwyqWvaUfb9Z5sqfqUvqNONktCkTVApeuo7kChj+dO9uGnzBu/qfTrklkK5pQ5PFxeT5FNQUqJ2cegeQSZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713165506; c=relaxed/simple;
	bh=dO+wwri8RKNTUotnubm3FEtVFSPmKseSMliGzOdZKYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8TzDADznNvniKHaEHtdREPQupUFhqMDNPTv2DupvI73MFWbg7aOJJTRwrxtMXZMZzWUI3GwSemI27ONdVGhDUntXnelSWmgLObkfpL4EWEAiG6t93x+zCtnqg//oRwAUl9k6Z36GAd+pEXW0sp1P/hFOFflmvx42Ctkug3aIKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=eNYQa6g/; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 57D4C5B2;
	Mon, 15 Apr 2024 09:17:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713165455;
	bh=dO+wwri8RKNTUotnubm3FEtVFSPmKseSMliGzOdZKYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eNYQa6g/Ss6fgdbUooyY3CdWXFDF79FU7TE5n+lJqXz2UdInxYRqd3KzYLuutdg58
	 O5/XMmkee91vt8+qk848SfNhkfilbfR1R5sbiZhV0llGb4FHSL8/OyceseEuvrU9L1
	 e23kqLOaYIoquMau6aE8HxAJXUynFbrMgvqi+VDU=
Date: Mon, 15 Apr 2024 10:18:12 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, tomi.valkeinen@ideasonboard.com,
	Hans de Goede <hdegoede@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] media: v4l: Don't turn on privacy LED if streamon
 fails
Message-ID: <20240415071812.GA25078@pendragon.ideasonboard.com>
References: <20240410114712.661186-1-sakari.ailus@linux.intel.com>
 <20240412174621.GA5444@pendragon.ideasonboard.com>
 <ZhzUHs7lpdeMa22l@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZhzUHs7lpdeMa22l@kekkonen.localdomain>

On Mon, Apr 15, 2024 at 07:15:42AM +0000, Sakari Ailus wrote:
> Hi Laurent,
> 
> On Fri, Apr 12, 2024 at 08:46:21PM +0300, Laurent Pinchart wrote:
> > Hi Sakari,
> > 
> > Thank you for the patch.
> > 
> > On Wed, Apr 10, 2024 at 02:47:12PM +0300, Sakari Ailus wrote:
> > > Turn on the privacy LED only if streamon succeeds. This can be done after
> > > enabling streaming on the sensor.
> > > 
> > > Fixes: b6e10ff6c23d ("media: v4l2-core: Make the v4l2-core code enable/disable the privacy LED if present")
> > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > ---
> > >  drivers/media/v4l2-core/v4l2-subdev.c | 22 ++++++++++++----------
> > >  1 file changed, 12 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> > > index 4c6198c48dd6..012b757eac9f 100644
> > > --- a/drivers/media/v4l2-core/v4l2-subdev.c
> > > +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> > > @@ -412,15 +412,6 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
> > >  	if (WARN_ON(!!sd->enabled_streams == !!enable))
> > >  		return 0;
> > >  
> > > -#if IS_REACHABLE(CONFIG_LEDS_CLASS)
> > > -	if (!IS_ERR_OR_NULL(sd->privacy_led)) {
> > > -		if (enable)
> > > -			led_set_brightness(sd->privacy_led,
> > > -					   sd->privacy_led->max_brightness);
> > > -		else
> > > -			led_set_brightness(sd->privacy_led, 0);
> > > -	}
> > > -#endif
> > >  	ret = sd->ops->video->s_stream(sd, enable);
> > >  
> > >  	if (!enable && ret < 0) {
> > > @@ -428,9 +419,20 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
> > >  		ret = 0;
> > >  	}
> > >  
> > > -	if (!ret)
> > > +	if (!ret) {
> > >  		sd->enabled_streams = enable ? BIT(0) : 0;
> > >  
> > > +#if IS_REACHABLE(CONFIG_LEDS_CLASS)
> > > +		if (!IS_ERR_OR_NULL(sd->privacy_led)) {
> > > +			if (enable)
> > > +				led_set_brightness(sd->privacy_led,
> > > +						   sd->privacy_led->max_brightness);
> > > +			else
> > > +				led_set_brightness(sd->privacy_led, 0);
> > > +		}
> > > +#endif
> > 
> > This means that the LED will be turned slightly after the camera is
> > enabled. I don't think it's an issue in practice. Another possibly more
> 
> That's what I'd think as well. Typically even the exposure time is much,
> much longer than what it takes to get here.
> 
> > important concern is that we should maybe check the return value of
> > led_set_brightness(), and fail .s_stream() when we can't enable the
> > privacy LED at stream on time. In that case, it would be best to keep
> > turning the privacy LED on before calling .s_stream(). It should still
> > be turned off only after calling .s_stream() though.
> 
> The return type of led_set_brightness() is void.

Oops :-S

> Maybe because a large majority is GPIO-controlled?

GPIOs can fail, in particular when they're on I2C GPIO expanders.

-- 
Regards,

Laurent Pinchart

