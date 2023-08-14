Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EE377B670
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbjHNKS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236941AbjHNKST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:18:19 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373A9173B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 03:17:51 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8254F6BE;
        Mon, 14 Aug 2023 12:16:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1692008191;
        bh=+tNL4NQA0CoBOCXHjja5RO3urDrFcvaNCJTMS8guwcY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EzctgWqnagqN8IGEy/u7xkW4p3ki+DpVeJoONsRnBXdloH6uhY0XlmAeUJsz2Q8Bh
         YZRNvFlGcKEb4l8vk58h71jwZ4NLrFcofw4jMPUz9zcB1WUMYiocfErE5pcXRWBSYZ
         kEIRuihUgGsvTYMr7HAjpdl0oo8jAEfgmJPmLaFs=
Date:   Mon, 14 Aug 2023 13:17:50 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@gmail.com>,
        Francesco Dolcini <francesco@dolcini.it>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: Re: [PATCH 11/11] drm/bridge: tc358768: Add
 DRM_BRIDGE_ATTACH_NO_CONNECTOR support
Message-ID: <20230814101750.GA5723@pendragon.ideasonboard.com>
References: <20230804-tc358768-v1-0-1afd44b7826b@ideasonboard.com>
 <20230804-tc358768-v1-11-1afd44b7826b@ideasonboard.com>
 <e857d383-2287-a985-24c5-fa1fff1da199@gmail.com>
 <0855d804-3ba3-4f29-32b1-bab3b999e506@ideasonboard.com>
 <20230814101041.GA277347@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230814101041.GA277347@ravnborg.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 12:10:41PM +0200, Sam Ravnborg wrote:
> > From c13c691bd8826b978325575be9a87f577b83b86b Mon Sep 17 00:00:00 2001
> > From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > Date: Mon, 14 Aug 2023 13:02:23 +0300
> > Subject: [PATCH] drm/bridge: tc358768: fix 'Add DRM_BRIDGE_ATTACH_NO_CONNECTOR
> >  support'
> > 
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > ---
> >  drivers/gpu/drm/bridge/tc358768.c | 56 +++++++++++++------------------
> >  1 file changed, 24 insertions(+), 32 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
> > index 82ea4d9a814a..9705ce1bd028 100644
> > --- a/drivers/gpu/drm/bridge/tc358768.c
> > +++ b/drivers/gpu/drm/bridge/tc358768.c
> > @@ -455,8 +455,6 @@ static int tc358768_dsi_host_detach(struct mipi_dsi_host *host,
> >  	struct tc358768_priv *priv = dsi_host_to_tc358768(host);
> >  
> >  	drm_bridge_remove(&priv->bridge);
> > -	if (priv->output.panel)
> > -		drm_panel_bridge_remove(priv->output.next_bridge);
> >  
> >  	return 0;
> >  }
> > @@ -531,49 +529,42 @@ static int tc358768_bridge_attach(struct drm_bridge *bridge,
> >  				  enum drm_bridge_attach_flags flags)
> >  {
> >  	struct tc358768_priv *priv = bridge_to_tc358768(bridge);
> > +	struct drm_bridge *next_bridge;
> > +	struct drm_panel *panel;
> > +	int ret;
> >  
> >  	if (!drm_core_check_feature(bridge->dev, DRIVER_ATOMIC)) {
> >  		dev_err(priv->dev, "needs atomic updates support\n");
> >  		return -ENOTSUPP;
> >  	}
> >  
> > -	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR) {
> > -		struct device_node *node;
> > -
> > -		/* Get the next bridge, connected to port@1. */
> > -		node = of_graph_get_remote_node(priv->dev->of_node, 1, -1);
> > -		if (!node)
> > -			return -ENODEV;
> > -
> > -		priv->output.next_bridge = of_drm_find_bridge(node);
> > -		of_node_put(node);
> > -		if (!priv->output.next_bridge)
> > -			return -EPROBE_DEFER;
> > -	} else {
> > -		struct drm_bridge *bridge;
> > -		struct drm_panel *panel;
> > -		int ret;
> > -
> > -		ret = drm_of_find_panel_or_bridge(priv->dev->of_node, 1, 0,
> > -						  &panel, &bridge);
> > -		if (ret)
> > -			return ret;
> > -
> > -		if (panel) {
> > -			bridge = drm_panel_bridge_add_typed(panel,
> > -				DRM_MODE_CONNECTOR_DSI);
> > -			if (IS_ERR(bridge))
> > -				return PTR_ERR(bridge);
> > -		}
> > +	ret = drm_of_find_panel_or_bridge(priv->dev->of_node, 1, -1, &panel,
> > +					  &next_bridge);
> 
> I think the right way is to wrap the panel in a bridge,
> so something like:
> 
> 	next_bridge = devm_drm_of_get_bridge(dev, priv->dev->of_node, 1, -1)
> 
> 	if (IS_ERR(next_bridge))
> 		return ...
> 	priv->output.next_bridge = next_bridge;

Should we at some point bite the bullet and wrap panels in bridges
directly in drm_panel.c ? That would simplify all the consumers.

> > +	if (ret)
> > +		return ret;
> >  
> > -		priv->output.next_bridge = bridge;
> > -		priv->output.panel = panel;
> > +	if (panel) {
> > +		next_bridge = drm_panel_bridge_add_typed(panel,
> > +			DRM_MODE_CONNECTOR_DSI);
> > +		if (IS_ERR(next_bridge))
> > +			return PTR_ERR(next_bridge);
> >  	}
> >  
> > +	priv->output.next_bridge = next_bridge;
> > +	priv->output.panel = panel;
> > +
> >  	return drm_bridge_attach(bridge->encoder, priv->output.next_bridge, bridge,
> >  				 flags);
> >  }
> >  
> > +void tc358768_bridge_detach(struct drm_bridge *bridge)
> > +{
> > +	struct tc358768_priv *priv = bridge_to_tc358768(bridge);
> > +
> > +	if (priv->output.panel)
> > +		drm_panel_bridge_remove(priv->output.next_bridge);
> > +}
> > +
> >  static enum drm_mode_status
> >  tc358768_bridge_mode_valid(struct drm_bridge *bridge,
> >  			   const struct drm_display_info *info,
> > @@ -1156,6 +1147,7 @@ tc358768_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
> >  
> >  static const struct drm_bridge_funcs tc358768_bridge_funcs = {
> >  	.attach = tc358768_bridge_attach,
> > +	.detach = tc358768_bridge_detach,
> >  	.mode_valid = tc358768_bridge_mode_valid,
> >  	.pre_enable = tc358768_bridge_pre_enable,
> >  	.enable = tc358768_bridge_enable,

-- 
Regards,

Laurent Pinchart
