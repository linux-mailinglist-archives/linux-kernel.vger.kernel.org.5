Return-Path: <linux-kernel+bounces-35527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC8D839276
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8011728AF5E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC0660279;
	Tue, 23 Jan 2024 15:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="MdnrkFeL"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B456026C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706023120; cv=none; b=bHGie9VW5v4zTDhiz0UIbRLOpJLSW2DF6/h/yDyWgrN9M/kOLYReaNWmpeVghNyVJvm2J7VwKb9afpQXVa78wnH2c7b/V2azDtV5iMP82BKC72dmiU8aJhKZCaJtyL9CrZN+jSbueev49qI8nohWV6Y7mS58fjT8hEZINPjMwM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706023120; c=relaxed/simple;
	bh=J/S95DX1QU5VPJPLhg+znioJCc/WJtd5g+KxFYUz0KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMt62AnLY68Lqn2tNEdnv9JeaHk84bH4UqJF58+6HE+ayfO/K73a3SweMIOhNo8AVBT1AUsgKZOTnE5VXvZkL9TRE+ByiGJKrfR0KfXoBs8rUba8MKUGTqzIpOoQteLG/9EPqjmYk1/tGPrqmPC/QsBAKqBTXAuo8dCW7/lmU5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=MdnrkFeL; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 628CD1B9A;
	Tue, 23 Jan 2024 16:17:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1706023043;
	bh=J/S95DX1QU5VPJPLhg+znioJCc/WJtd5g+KxFYUz0KM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MdnrkFeL6QoQ7ARy5Niyl5LRvNhoL3BujJNf+iSgcZ5JoAPsOL7c+v1/vCw8E1J1Y
	 uLu9ljtftxDTKYs/5axFhxajvx73BgJV74SRqzmcIsqeGbdsCFPCDvkUh/kl5nPCFz
	 S1McHh6NG/2eB9v32FG9SXWbXxs0yr8SLolWa2R4=
Date: Tue, 23 Jan 2024 17:18:35 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: David Airlie <airlied@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] drm/bridge: simple-bridge: Allow acquiring the next
 bridge with fwnode API
Message-ID: <20240123151835.GO10679@pendragon.ideasonboard.com>
References: <20240122163220.110788-1-sui.jingfeng@linux.dev>
 <20240122163220.110788-4-sui.jingfeng@linux.dev>
 <20240123011859.GB22880@pendragon.ideasonboard.com>
 <7f5e1c37-a637-494a-ab52-cad83095f2a6@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7f5e1c37-a637-494a-ab52-cad83095f2a6@linux.dev>

Hello Sui,

On Tue, Jan 23, 2024 at 08:18:22PM +0800, Sui Jingfeng wrote:
> On 2024/1/23 09:18, Laurent Pinchart wrote:
> > On Tue, Jan 23, 2024 at 12:32:18AM +0800, Sui Jingfeng wrote:
> >> Which make it possible to use this driver on non-DT based systems,
> >> meanwhile, made no functional changes for DT based systems.
> >>
> >> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> >> ---
> >>   drivers/gpu/drm/bridge/simple-bridge.c | 51 ++++++++++++++++++++++----
> >>   1 file changed, 44 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
> >> index 595f672745b9..cfea5a67cc5b 100644
> >> --- a/drivers/gpu/drm/bridge/simple-bridge.c
> >> +++ b/drivers/gpu/drm/bridge/simple-bridge.c
> >> @@ -184,6 +184,39 @@ static const void *simple_bridge_get_match_data(const struct device *dev)
> >>   	return NULL;
> >>   }
> >>   
> >> +static int simple_bridge_get_next_bridge_by_fwnode(struct device *dev,
> >> +						   struct drm_bridge **next_bridge)
> >> +{
> >> +	struct drm_bridge *bridge;
> >> +	struct fwnode_handle *ep;
> >> +	struct fwnode_handle *remote;
> >> +
> >> +	ep = fwnode_graph_get_endpoint_by_id(dev->fwnode, 1, 0, 0);
> >> +	if (!ep) {
> >> +		dev_err(dev, "The endpoint is unconnected\n");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	remote = fwnode_graph_get_remote_port_parent(ep);
> >> +	fwnode_handle_put(ep);
> >> +	if (!remote) {
> >> +		dev_err(dev, "No valid remote node\n");
> >> +		return -ENODEV;
> >> +	}
> >> +
> >> +	bridge = drm_bridge_find_by_fwnode(remote);
> >> +	fwnode_handle_put(remote);
> >> +
> >> +	if (!bridge) {
> >> +		dev_warn(dev, "Next bridge not found, deferring probe\n");
> >> +		return -EPROBE_DEFER;
> >> +	}
> >> +
> >> +	*next_bridge = bridge;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >
> > Hmmmm yes, this convinces me further that we should switch to fwnode,
> > not implement fwnode and OF side-by-side.
> 
> OK, I'm agree with you.
> 
> But this means that I have to make the drm_bridge_find_by_fwnode() function works
> on both DT systems and non-DT systems. This is also means that we will no longer
> need to call of_drm_find_bridge() function anymore. This will eventually lead to
> completely remove of_drm_find_bridge()?

It would be replaced by fwnode_drm_find_bridge(). Although, if we need
to rename the function, I think it would be best to make have a drm_
prefix, maybe drm_bridge_find-by_fwnode() or something similar.

> As far as I can see, if I follow you suggestion, drm/bridge subsystem will
> encountering a *big* refactor. My 'side-by-side' approach allows co-exist.
> It is not really meant to purge OF. I feel it is a little bit of aggressive.
> 
> hello Maxime, are you watching this? what do you think?
> 
> >>   static int simple_bridge_probe(struct platform_device *pdev)
> >>   {
> >>   	struct simple_bridge *sbridge;
> >> @@ -199,14 +232,17 @@ static int simple_bridge_probe(struct platform_device *pdev)
> >>   	else
> >>   		sbridge->info = simple_bridge_get_match_data(&pdev->dev);
> >>   
> >> -	/* Get the next bridge in the pipeline. */
> >> -	remote = of_graph_get_remote_node(pdev->dev.of_node, 1, -1);
> >> -	if (!remote)
> >> -		return -EINVAL;
> >> -
> >> -	sbridge->next_bridge = of_drm_find_bridge(remote);
> >> -	of_node_put(remote);
> >> +	if (pdev->dev.of_node) {
> >> +		/* Get the next bridge in the pipeline. */
> >> +		remote = of_graph_get_remote_node(pdev->dev.of_node, 1, -1);
> >> +		if (!remote)
> >> +			return -EINVAL;
> >>   
> >> +		sbridge->next_bridge = of_drm_find_bridge(remote);
> >> +		of_node_put(remote);
> >> +	} else {
> >> +		simple_bridge_get_next_bridge_by_fwnode(&pdev->dev, &sbridge->next_bridge);
> >> +	}
> >>   	if (!sbridge->next_bridge) {
> >>   		dev_dbg(&pdev->dev, "Next bridge not found, deferring probe\n");
> >>   		return -EPROBE_DEFER;
> >> @@ -231,6 +267,7 @@ static int simple_bridge_probe(struct platform_device *pdev)
> >>   	/* Register the bridge. */
> >>   	sbridge->bridge.funcs = &simple_bridge_bridge_funcs;
> >>   	sbridge->bridge.of_node = pdev->dev.of_node;
> >> +	sbridge->bridge.fwnode = pdev->dev.fwnode;
> >>   	sbridge->bridge.timings = sbridge->info->timings;
> >>   
> >>   	drm_bridge_add(&sbridge->bridge);

-- 
Regards,

Laurent Pinchart

