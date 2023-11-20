Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47DD7F134F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 13:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbjKTMaV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Nov 2023 07:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbjKTMaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:30:17 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84345F2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 04:30:13 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id ACC3CFF811;
        Mon, 20 Nov 2023 12:30:10 +0000 (UTC)
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
Subject: [PATCH v2 2/2] drm/rockchip: lvds: do not print scary message when probing defer
Date:   Mon, 20 Nov 2023 13:29:49 +0100
Message-ID: <20231120-rk-lvds-defer-msg-v2-2-9c59a5779cf9@theobroma-systems.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231120-rk-lvds-defer-msg-v2-0-9c59a5779cf9@theobroma-systems.com>
References: <20231120-rk-lvds-defer-msg-v2-0-9c59a5779cf9@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8BIT
X-GND-Sasl: foss@0leil.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

This scary message can misled the user into thinking something bad has
happened and needs to be fixed, however it could simply be part of a
normal boot process where EPROBE_DEFER is taken into account. Therefore,
let's use dev_err_probe so that this message doesn't get shown (by
default) when the return code is EPROBE_DEFER.

Fixes: 34cc0aa25456 ("drm/rockchip: Add support for Rockchip Soc LVDS")
Cc: Quentin Schulz <foss+kernel@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 drivers/gpu/drm/rockchip/rockchip_lvds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index 17d8fc797151..f2831d304e7b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -577,7 +577,7 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 		ret = -EINVAL;
 		goto err_put_port;
 	} else if (ret) {
-		DRM_DEV_ERROR(dev, "failed to find panel and bridge node\n");
+		dev_err_probe(dev, ret, "failed to find panel and bridge node\n");
 		goto err_put_port;
 	}
 	if (lvds->panel)

-- 
2.42.0

