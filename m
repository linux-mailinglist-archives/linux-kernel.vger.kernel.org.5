Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86644804DE4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjLEJag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235635AbjLEJaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:30:21 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FA42116
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:29:48 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1rARkJ-0000u2-RS; Tue, 05 Dec 2023 10:29:39 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1rARkH-00DiAv-0a; Tue, 05 Dec 2023 10:29:37 +0100
Received: from sha by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1rARkG-005MUP-U7; Tue, 05 Dec 2023 10:29:36 +0100
Date:   Tue, 5 Dec 2023 10:29:36 +0100
To:     Andy Yan <andyshrk@163.com>
Cc:     heiko@sntech.de, hjc@rock-chips.com,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, sebastian.reichel@collabora.com,
        kever.yang@rock-chips.com, chris.obbard@collabora.com,
        Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v3 11/14] drm/rockchip: vop2: Add support for rk3588
Message-ID: <20231205092936.GW1057032@pengutronix.de>
References: <20231130122001.12474-1-andyshrk@163.com>
 <20231130122439.13374-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130122439.13374-1-andyshrk@163.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
From:   Sascha Hauer <sha@pengutronix.de>
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

On Thu, Nov 30, 2023 at 08:24:39PM +0800, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> VOP2 on rk3588:
> 
> Four video ports:
> VP0 Max 4096x2160
> VP1 Max 4096x2160
> VP2 Max 4096x2160
> VP3 Max 2048x1080
> 
> 4 4K Cluster windows with AFBC/line RGB and AFBC-only YUV support
> 4 4K Esmart windows with line RGB/YUV support
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

With the two nits below feel free to add my:

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Thanks for working on this.

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
> index 8d7ff52523fb..8b16031eda52 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
> @@ -13,9 +13,16 @@
>  
>  #define VOP_FEATURE_OUTPUT_10BIT        BIT(0)

You could rename this to include "VP" for Video Port so it's not so
easily mixed up with the defines below.

>  
> +#define VOP2_FEATURE_HAS_SYS_GRF	BIT(0)
> +#define VOP2_FEATURE_HAS_VO0_GRF	BIT(1)
> +#define VOP2_FEATURE_HAS_VO1_GRF	BIT(2)
> +#define VOP2_FEATURE_HAS_VOP_GRF	BIT(3)
> +#define VOP2_FEATURE_HAS_SYS_PMU	BIT(5)

Should be BIT(4)

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
