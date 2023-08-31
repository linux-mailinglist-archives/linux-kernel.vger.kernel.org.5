Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488A678E96D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 11:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244873AbjHaJbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 05:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjHaJbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 05:31:03 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DC0CED
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 02:31:00 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 14A52223;
        Thu, 31 Aug 2023 11:29:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693474176;
        bh=KuTQdJ5OL0CxZyWRrXxMK+X9+ye8IsH5E2ej6cztE70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CbdKr9DD6cu4aYvBW9X1mzemtVVDIEbNReal1bAJcfO6A4VS0s4wzSxGFl7EebNp4
         hKG00Lko9bMkxDeccVr7kCWtPjGQ8GCMyJIzNUTsP2OudSHeBXufrC7/9J0uK1yJFZ
         pSOWH+41QqjuFr22LK0LMxlzyW8GKMW3Bo3d0UeQ=
Date:   Thu, 31 Aug 2023 12:31:08 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v6 4/4] drm/bridge: panel: Drop CONFIG_OF conditional
 around  *_of_get_bridge()
Message-ID: <20230831093108.GF2698@pendragon.ideasonboard.com>
References: <20230831080938.47454-1-biju.das.jz@bp.renesas.com>
 <20230831080938.47454-5-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831080938.47454-5-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 09:09:38AM +0100, Biju Das wrote:
> Drop unnecessary CONFIG_OF conditional around devm_drm_of_get_bridge() and
> drmm_of_get_bridge() as it is guarded with #if..#else blocks in
> drm_bridge.h.

This will increase the kernel size on non-OF system, to add functions
that are not used. I don't think the #ifdef here is problematic.

> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v6:
>  * New patch.
> ---
>  drivers/gpu/drm/bridge/panel.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
> index 7f41525f7a6e..9220a1c23697 100644
> --- a/drivers/gpu/drm/bridge/panel.c
> +++ b/drivers/gpu/drm/bridge/panel.c
> @@ -482,7 +482,6 @@ struct drm_connector *drm_panel_bridge_connector(struct drm_bridge *bridge)
>  }
>  EXPORT_SYMBOL(drm_panel_bridge_connector);
>  
> -#ifdef CONFIG_OF
>  /**
>   * devm_drm_of_get_bridge - Return next bridge in the chain
>   * @dev: device to tie the bridge lifetime to
> @@ -550,5 +549,3 @@ struct drm_bridge *drmm_of_get_bridge(struct drm_device *drm,
>  	return bridge;
>  }
>  EXPORT_SYMBOL(drmm_of_get_bridge);
> -
> -#endif

-- 
Regards,

Laurent Pinchart
