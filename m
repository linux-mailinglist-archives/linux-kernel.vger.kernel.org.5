Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C9F7FA23F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbjK0OQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbjK0OQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:16:02 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240F94C2F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:04:23 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1r7cDc-0006Xd-V7; Mon, 27 Nov 2023 15:04:12 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1r7cDc-00BxOJ-Gd; Mon, 27 Nov 2023 15:04:12 +0100
Received: from sha by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1r7cDc-0046wB-Dz; Mon, 27 Nov 2023 15:04:12 +0100
Date:   Mon, 27 Nov 2023 15:04:12 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Andy Yan <andyshrk@163.com>
Cc:     heiko@sntech.de, hjc@rock-chips.com,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, sebastian.reichel@collabora.com,
        kever.yang@rock-chips.com, chris.obbard@collabora.com,
        Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v2 02/12] Revert "drm/rockchip: vop2: Use regcache_sync()
 to fix suspend/resume"
Message-ID: <20231127140412.GC977968@pengutronix.de>
References: <20231122125316.3454268-1-andyshrk@163.com>
 <20231122125400.3454430-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122125400.3454430-1-andyshrk@163.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 08:54:00PM +0800, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> This reverts commit b63a553e8f5aa6574eeb535a551817a93c426d8c.
> 
> regcache_sync will try to reload the configuration in regcache to
> hardware, but the registers of 4 Cluster windows and Esmart1/2/3 on
> the upcoming rk3588 can not be set successfully before internal PD
> power on.
> 
> Also it's better to keep the hardware register as it is before we really
> enable it.
> 
> So let's revert this version, and keep the first version:
> commit afa965a45e01 ("drm/rockchip: vop2: fix suspend/resume")
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> ---
> 
> (no changes since v1)
> 
>  drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> index 312da5783362..57784d0a22a6 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> @@ -217,6 +217,8 @@ struct vop2 {
>  	struct vop2_win win[];
>  };
>  
> +static const struct regmap_config vop2_regmap_config;
> +
>  static struct vop2_video_port *to_vop2_video_port(struct drm_crtc *crtc)
>  {
>  	return container_of(crtc, struct vop2_video_port, crtc);
> @@ -883,7 +885,11 @@ static void vop2_enable(struct vop2 *vop2)
>  		return;
>  	}
>  
> -	regcache_sync(vop2->map);
> +	ret = regmap_reinit_cache(vop2->map, &vop2_regmap_config);
> +	if (ret) {
> +		drm_err(vop2->drm, "failed to reinit cache: %d\n", ret);
> +		return;
> +	}
>  
>  	if (vop2->data->soc_id == 3566)
>  		vop2_writel(vop2, RK3568_OTP_WIN_EN, 1);
> @@ -913,8 +919,6 @@ static void vop2_disable(struct vop2 *vop2)
>  
>  	pm_runtime_put_sync(vop2->dev);
>  
> -	regcache_mark_dirty(vop2->map);
> -
>  	clk_disable_unprepare(vop2->aclk);
>  	clk_disable_unprepare(vop2->hclk);
>  }
> -- 
> 2.34.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
