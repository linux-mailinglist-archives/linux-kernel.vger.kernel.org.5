Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DDD76FB57
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 09:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbjHDHpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 03:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjHDHpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 03:45:51 -0400
X-Greylist: delayed 432 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Aug 2023 00:45:48 PDT
Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0374210
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 00:45:48 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 5F95CFB03;
        Fri,  4 Aug 2023 09:38:33 +0200 (CEST)
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id b8W9eJmQqxIH; Fri,  4 Aug 2023 09:38:32 +0200 (CEST)
Date:   Fri, 4 Aug 2023 09:38:29 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Aleksandr Nogikh <nogikh@google.com>,
        Adam Ford <aford173@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: bridge: for GENERIC_PHY_MIPI_DPHY also select
 GENERIC_PHY
Message-ID: <ZMyq9e/On2wzSJWj@qwark.sigxcpu.org>
References: <20230804030140.21395-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230804030140.21395-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Thu, Aug 03, 2023 at 08:01:37PM -0700, Randy Dunlap wrote:
> Three DRM bridge drivers select GENERIC_PHY_MIPI_DPHY when GENERIC_PHY
> might not be set.  This causes Kconfig warnings and a build error.
> 
> WARNING: unmet direct dependencies detected for GENERIC_PHY_MIPI_DPHY
>   Depends on [n]: GENERIC_PHY [=n]
>   Selected by [y]:
>   - DRM_NWL_MIPI_DSI [=y] && DRM_BRIDGE [=y] && DRM [=y] && COMMON_CLK [=y] && OF [=y] && HAS_IOMEM [=y]
>   - DRM_SAMSUNG_DSIM [=y] && DRM [=y] && DRM_BRIDGE [=y] && COMMON_CLK [=y] && OF [=y] && HAS_IOMEM [=y]
> 
> (drm/bridge/cadence/Kconfig was found by inspection.)
> 
> aarch64-linux-ld: drivers/gpu/drm/bridge/samsung-dsim.o: in function `samsung_dsim_set_phy_ctrl':
> drivers/gpu/drm/bridge/samsung-dsim.c:731: undefined reference to `phy_mipi_dphy_get_default_config_for_hsclk'
> 
> Prevent these warnings and build error by also selecting GENERIC_PHY
n> whenever selecting GENERIC_PHY_MIPI_DPHY.
> 
> Fixes: fced5a364dee ("drm/bridge: cdns: Convert to phy framework")
> Fixes: 44cfc6233447 ("drm/bridge: Add NWL MIPI DSI host controller support")
> Fixes: 171b3b1e0f8b ("drm: bridge: samsung-dsim: Select GENERIC_PHY_MIPI_DPHY")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Aleksandr Nogikh <nogikh@google.com>
> Link: lore.kernel.org/r/20230803144227.2187749-1-nogikh@google.com
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Guido Günther <agx@sigxcpu.org>
> Cc: Robert Chiras <robert.chiras@nxp.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> Cc: Robert Foss <rfoss@kernel.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> ---
>  drivers/gpu/drm/bridge/Kconfig         |    2 ++
>  drivers/gpu/drm/bridge/cadence/Kconfig |    1 +
>  2 files changed, 3 insertions(+)
> 
> diff -- a/drivers/gpu/drm/bridge/cadence/Kconfig b/drivers/gpu/drm/bridge/cadence/Kconfig
> --- a/drivers/gpu/drm/bridge/cadence/Kconfig
> +++ b/drivers/gpu/drm/bridge/cadence/Kconfig
> @@ -4,6 +4,7 @@ config DRM_CDNS_DSI
>  	select DRM_KMS_HELPER
>  	select DRM_MIPI_DSI
>  	select DRM_PANEL_BRIDGE
> +	select GENERIC_PHY
>  	select GENERIC_PHY_MIPI_DPHY
>  	depends on OF
>  	help
> diff -- a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -181,6 +181,7 @@ config DRM_NWL_MIPI_DSI
>  	select DRM_KMS_HELPER
>  	select DRM_MIPI_DSI
>  	select DRM_PANEL_BRIDGE
> +	select GENERIC_PHY
>  	select GENERIC_PHY_MIPI_DPHY
>  	select MFD_SYSCON
>  	select MULTIPLEXER
> @@ -227,6 +228,7 @@ config DRM_SAMSUNG_DSIM
>  	select DRM_KMS_HELPER
>  	select DRM_MIPI_DSI
>  	select DRM_PANEL_BRIDGE
> +	select GENERIC_PHY
>  	select GENERIC_PHY_MIPI_DPHY
>  	help
>  	  The Samsung MIPI DSIM bridge controller driver.
> 

For NWL:

Reviewed-by: Guido Günther <agx@sigxcpu.org>

Cheers,
  -- Guido
