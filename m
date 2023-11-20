Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6227F1350
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 13:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbjKTMaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 07:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbjKTMaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:30:15 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC465F1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 04:30:11 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0143AFF813;
        Mon, 20 Nov 2023 12:30:08 +0000 (UTC)
From:   Quentin Schulz <foss+kernel@0leil.net>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Yao <markyao0591@gmail.com>
Cc:     Quentin Schulz <foss+kernel@0leil.net>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH v2 1/2] drm/rockchip: lvds: do not overwrite error code
Date:   Mon, 20 Nov 2023 13:29:48 +0100
Message-ID: <20231120-rk-lvds-defer-msg-v2-1-9c59a5779cf9@theobroma-systems.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231120-rk-lvds-defer-msg-v2-0-9c59a5779cf9@theobroma-systems.com>
References: <20231120-rk-lvds-defer-msg-v2-0-9c59a5779cf9@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
X-GND-Sasl: foss@0leil.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

ret variable stores the return value of drm_of_find_panel_or_bridge
which can return error codes different from EPROBE_DEFER. Therefore,
let's just return that error code instead of forcing it to EPROBE_DEFER.

Fixes: 34cc0aa25456 ("drm/rockchip: Add support for Rockchip Soc LVDS")
Cc: Quentin Schulz <foss+kernel@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 drivers/gpu/drm/rockchip/rockchip_lvds.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index f0f47e9abf5a..17d8fc797151 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -578,7 +578,6 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 		goto err_put_port;
 	} else if (ret) {
 		DRM_DEV_ERROR(dev, "failed to find panel and bridge node\n");
-		ret = -EPROBE_DEFER;
 		goto err_put_port;
 	}
 	if (lvds->panel)

-- 
2.42.0

