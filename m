Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2CB77BA09
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjHNN3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjHNN33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:29:29 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96376ED
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:29:28 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6FDEBD51;
        Mon, 14 Aug 2023 15:28:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1692019695;
        bh=BmzEZgZVXN+6fGTllLHO5VdMx+53GoPnZExdNymjSxw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gP42c/v+sIW71Yevxqalg1Gf5bZBSQokEVSQ6DOwdYTbj3iKzy6W2pr5NYMDbLtzP
         PVf3nkEYAegdIO78dD9lIfvYeU4M1ENh4gEcdoQYM/uWeT0rKNF7a80YLW6TIiek5t
         ixey1YBnlJoYqKjeDzdq7E6efsKVGLgSVG/4mqUQ=
Message-ID: <aca4785f-ab3b-ac1c-d661-e1a103dfc24a@ideasonboard.com>
Date:   Mon, 14 Aug 2023 16:29:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 11/11] drm/bridge: tc358768: Add
 DRM_BRIDGE_ATTACH_NO_CONNECTOR support
Content-Language: en-US
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Maxim Schwalm <maxim.schwalm@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        Francesco Dolcini <francesco@dolcini.it>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Aradhya Bhatia <a-bhatia1@ti.com>
References: <20230804-tc358768-v1-0-1afd44b7826b@ideasonboard.com>
 <20230804-tc358768-v1-11-1afd44b7826b@ideasonboard.com>
 <e857d383-2287-a985-24c5-fa1fff1da199@gmail.com>
 <0855d804-3ba3-4f29-32b1-bab3b999e506@ideasonboard.com>
 <20230814101041.GA277347@ravnborg.org>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20230814101041.GA277347@ravnborg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On 14/08/2023 13:10, Sam Ravnborg wrote:
> Hi Tomi,
> 
>>  From c13c691bd8826b978325575be9a87f577b83b86b Mon Sep 17 00:00:00 2001
>> From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>> Date: Mon, 14 Aug 2023 13:02:23 +0300
>> Subject: [PATCH] drm/bridge: tc358768: fix 'Add DRM_BRIDGE_ATTACH_NO_CONNECTOR
>>   support'
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>> ---
>>   drivers/gpu/drm/bridge/tc358768.c | 56 +++++++++++++------------------
>>   1 file changed, 24 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
>> index 82ea4d9a814a..9705ce1bd028 100644
>> --- a/drivers/gpu/drm/bridge/tc358768.c
>> +++ b/drivers/gpu/drm/bridge/tc358768.c
>> @@ -455,8 +455,6 @@ static int tc358768_dsi_host_detach(struct mipi_dsi_host *host,
>>   	struct tc358768_priv *priv = dsi_host_to_tc358768(host);
>>   
>>   	drm_bridge_remove(&priv->bridge);
>> -	if (priv->output.panel)
>> -		drm_panel_bridge_remove(priv->output.next_bridge);
>>   
>>   	return 0;
>>   }
>> @@ -531,49 +529,42 @@ static int tc358768_bridge_attach(struct drm_bridge *bridge,
>>   				  enum drm_bridge_attach_flags flags)
>>   {
>>   	struct tc358768_priv *priv = bridge_to_tc358768(bridge);
>> +	struct drm_bridge *next_bridge;
>> +	struct drm_panel *panel;
>> +	int ret;
>>   
>>   	if (!drm_core_check_feature(bridge->dev, DRIVER_ATOMIC)) {
>>   		dev_err(priv->dev, "needs atomic updates support\n");
>>   		return -ENOTSUPP;
>>   	}
>>   
>> -	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR) {
>> -		struct device_node *node;
>> -
>> -		/* Get the next bridge, connected to port@1. */
>> -		node = of_graph_get_remote_node(priv->dev->of_node, 1, -1);
>> -		if (!node)
>> -			return -ENODEV;
>> -
>> -		priv->output.next_bridge = of_drm_find_bridge(node);
>> -		of_node_put(node);
>> -		if (!priv->output.next_bridge)
>> -			return -EPROBE_DEFER;
>> -	} else {
>> -		struct drm_bridge *bridge;
>> -		struct drm_panel *panel;
>> -		int ret;
>> -
>> -		ret = drm_of_find_panel_or_bridge(priv->dev->of_node, 1, 0,
>> -						  &panel, &bridge);
>> -		if (ret)
>> -			return ret;
>> -
>> -		if (panel) {
>> -			bridge = drm_panel_bridge_add_typed(panel,
>> -				DRM_MODE_CONNECTOR_DSI);
>> -			if (IS_ERR(bridge))
>> -				return PTR_ERR(bridge);
>> -		}
>> +	ret = drm_of_find_panel_or_bridge(priv->dev->of_node, 1, -1, &panel,
>> +					  &next_bridge);
> 
> I think the right way is to wrap the panel in a bridge,
> so something like:
> 
> 	next_bridge = devm_drm_of_get_bridge(dev, priv->dev->of_node, 1, -1)
> 
> 	if (IS_ERR(next_bridge))
> 		return ...
> 	priv->output.next_bridge = next_bridge;

I tried that, but I had trouble with the cleanup side.

In the fixup patch I attached in my reply to Maxim I used 
drm_of_find_panel_or_bridge() + drm_panel_bridge_add_typed(), and on 
bridge_detach callback I used drm_panel_bridge_remove() (if there is a 
panel). This worked for me, but it does feel like a bit too much work 
for a driver to do.

  Tomi

