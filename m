Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1645F78E14C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241018AbjH3VRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjH3VRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:17:33 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6192CE8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:16:59 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id EB4452D8;
        Wed, 30 Aug 2023 22:36:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693427814;
        bh=w4+pDGg4A1xcuvMXkOpdT0G3fedDIjjTTZZ9xWTuDTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ue3LRcWcsrr2zVLKt4WKB29r46N/I73/p9ISbY3c1NiT+V0uS4dBtbShEWJd0utjr
         KvuPl3MME623fVBQw1MLG1BOJU3zMn2xoLQKUtIa+Ux5R0OREtqQOZqW3L2bUpXoZQ
         HbZjfBGRiXR5PT5/N/Q7bvDT0Njs/3fk7okNJTAw=
Date:   Wed, 30 Aug 2023 23:38:25 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v5 2/3] drm/bridge: Drop conditionals around of_node
 pointers
Message-ID: <20230830203825.GP6477@pendragon.ideasonboard.com>
References: <20230830170819.309269-1-biju.das.jz@bp.renesas.com>
 <20230830170819.309269-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230830170819.309269-3-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Biju,

Thank you for the patch.

In the commit message, s/pointers/pointer/ as you're only touching a
single one.

On Wed, Aug 30, 2023 at 06:08:18PM +0100, Biju Das wrote:
> The commit c9e358dfc4a8 ("driver-core: remove conditionals around
> devicetree pointers") supposed to remove conditionals around of_node
> pointer, but it missed out drm/bridge.h. So drop #if conditionals by
> adding struct device_node forward declaration.

You can hardly blame commit c9e358dfc4a8 for forgetting drm_bridge, as
that commit dates back from 2011 and the drm_bridge of_node field was
added in 2015 :-)

I would simply copy the rationale from the commit message of
c9e358dfc4a8 and write something like

--------
Having conditional around the of_node pointer of the drm_bridge
structure turns out to make driver code use ugly #ifdef blocks. Drop the
conditionals to simplify drivers. While this slightly increases the size
of struct drm_bridge on non-OF system, the number of bridges used today
and foreseen tomorrow on those systems is very low, so this shouldn't be
an issue.
--------

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
> v5:
>  * Split from patch#2
>  * Updated commit description
>  * Added struct device_node forward declaration.
> ---
>  include/drm/drm_bridge.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index c339fc85fd07..843736627f60 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -32,6 +32,8 @@
>  #include <drm/drm_mode_object.h>
>  #include <drm/drm_modes.h>
>  
> +struct device_node;
> +
>  struct drm_bridge;
>  struct drm_bridge_timings;
>  struct drm_connector;
> @@ -716,10 +718,8 @@ struct drm_bridge {
>  	struct drm_encoder *encoder;
>  	/** @chain_node: used to form a bridge chain */
>  	struct list_head chain_node;
> -#ifdef CONFIG_OF
>  	/** @of_node: device node pointer to the bridge */
>  	struct device_node *of_node;
> -#endif
>  	/** @list: to keep track of all added bridges */
>  	struct list_head list;
>  	/**

-- 
Regards,

Laurent Pinchart
