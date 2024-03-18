Return-Path: <linux-kernel+bounces-106347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4814D87ECD5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0542C280199
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EE552F7F;
	Mon, 18 Mar 2024 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="oJi+aZA/"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8D952F62
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710777453; cv=none; b=rLvbaqDJEApHqTuHkTjdATdcfO12Ah0ghRvWEUNvSDUV+CcgEqBbF3js6BuaZN7BXANFubEdF75WgLZPxBkgH3gyNg5Hj6WKsOWczjl5aVbrwqBqm9bOdKPqEiFNvD80K7yP41B6+DjWkEAJA9jSn1aQS/A38hFWwgO6gYHZLO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710777453; c=relaxed/simple;
	bh=SCTurdP0/3uyYnnbKe4OqBQbTcgNX6zxdBuyRbZZ3Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k73910OP71TlFitUKF+FX+3nrOuOjwh7b4XhUZ6rXcZJQOwapytSOazD9K2iOwS5TFdisHafr8rVuHjJifMDoTaRBeDKpkVgAGXn42eO0o+1zyJXX6IGBN7yw0B9B9QocxDWKKXyFWvVsM6Fm7c25oDw2ThD1E14YlN60aWCdig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=oJi+aZA/; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 732BF2A5;
	Mon, 18 Mar 2024 16:57:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1710777424;
	bh=SCTurdP0/3uyYnnbKe4OqBQbTcgNX6zxdBuyRbZZ3Qo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oJi+aZA/9Mu50X41lwDmXAl9IbZDoPPi+Oq1KicNuRaXrnT8yCOMzUAXWU7CYDplz
	 TDHSdnRzOfNwRWrJJ8K4nAQb0RFKaGqKOIlwApb+4NtvTSvAFmAc7Q4skBqGw730dU
	 WXseanWU1m1/7msbXAUjIP5Ru3FJDU/YiYB3nBYg=
Date: Mon, 18 Mar 2024 17:57:26 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: bridge: thc63lvd1024: Switch to use
 of_graph_get_remote_node()
Message-ID: <20240318155726.GE13682@pendragon.ideasonboard.com>
References: <20240316172800.1168390-1-sui.jingfeng@linux.dev>
 <20240318153326.GD13682@pendragon.ideasonboard.com>
 <22229306-aa72-4367-b029-fbdff4410cec@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <22229306-aa72-4367-b029-fbdff4410cec@linux.dev>

On Mon, Mar 18, 2024 at 11:53:11PM +0800, Sui Jingfeng wrote:
> On 2024/3/18 23:33, Laurent Pinchart wrote:
> > On Sun, Mar 17, 2024 at 01:28:00AM +0800, Sui Jingfeng wrote:
> >> To reduce boilerplate, use of_graph_get_remote_node() helper instead of
> >> the hand-rolling code.
> >>
> >> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> >> ---
> >>   drivers/gpu/drm/bridge/thc63lvd1024.c | 24 +++---------------------
> >>   1 file changed, 3 insertions(+), 21 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/bridge/thc63lvd1024.c b/drivers/gpu/drm/bridge/thc63lvd1024.c
> >> index d4c1a601bbb5..5f99f9724081 100644
> >> --- a/drivers/gpu/drm/bridge/thc63lvd1024.c
> >> +++ b/drivers/gpu/drm/bridge/thc63lvd1024.c
> >> @@ -123,28 +123,10 @@ static int thc63_parse_dt(struct thc63_dev *thc63)
> >>   	struct device_node *endpoint;
> >>   	struct device_node *remote;
> >>   
> >> -	endpoint = of_graph_get_endpoint_by_regs(thc63->dev->of_node,
> >> -						 THC63_RGB_OUT0, -1);
> >> -	if (!endpoint) {
> >> -		dev_err(thc63->dev, "Missing endpoint in port@%u\n",
> >> -			THC63_RGB_OUT0);
> >> -		return -ENODEV;
> >> -	}
> >> -
> >> -	remote = of_graph_get_remote_port_parent(endpoint);
> >> -	of_node_put(endpoint);
> >> -	if (!remote) {
> >> -		dev_err(thc63->dev, "Endpoint in port@%u unconnected\n",
> >> -			THC63_RGB_OUT0);
> >> +	remote = of_graph_get_remote_node(thc63->dev->of_node,
> >> +					  THC63_RGB_OUT0, -1);
> >> +	if (!remote)
> > The old logic is equivalent to of_graph_get_remote_node(), but now the
> > driver will fail probing without an error message. That's not very nice
> > as it leads to difficult to debug problems. I would keep one dev_err()
> > here:
> >
> > 		dev_err(thc63->dev, "No remote endpoint for port@%u\n",
> > 			THC63_RGB_OUT0);
> >
> > As your patch has been merged already, would you like to post a
> > follow-up patch to fix this ?
> 
> Yes, this is indeed a difference. I will post a follow-up patch to fix this.

I'm actually build-testing a patch I already wrote :-) I'll post it in a
moment.

> >>   		return -ENODEV;
> >> -	}
> >> -
> >> -	if (!of_device_is_available(remote)) {
> >> -		dev_err(thc63->dev, "port@%u remote endpoint is disabled\n",
> >> -			THC63_RGB_OUT0);
> >> -		of_node_put(remote);
> >> -		return -ENODEV;
> >> -	}
> >>   
> >>   	thc63->next = of_drm_find_bridge(remote);
> >>   	of_node_put(remote);

-- 
Regards,

Laurent Pinchart

