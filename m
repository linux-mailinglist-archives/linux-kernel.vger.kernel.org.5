Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8427FD25B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjK2JW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjK2JWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:22:53 -0500
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB937D48
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=RYl3c6WXzDrRpbjIfV
        dIreOF56KOfXk0Od7xbr0Mo5Y=; b=pLbcSYTqLdumG+FJD/65/z0maKYMqRzJSY
        /FpnmpMZlTxnZzDQLOKDusWc6Gtt4KQcKj3V6rmC+x7V/sl8mMjRuIihX8kGEA5q
        HgTtrw82wtg/OG6NvIg/zZo4SnSZxwSTp3z1I6BrFRuQFJsaJYy+3n0jSjrq1WPH
        kb6lGdgRg=
Received: from localhost.localdomain (unknown [39.144.190.126])
        by zwqz-smtp-mta-g0-2 (Coremail) with SMTP id _____wA3X+CMAmdlXBT+CQ--.41354S2;
        Wed, 29 Nov 2023 17:21:17 +0800 (CST)
From:   Haoran Liu <liuhaoran14@163.com>
To:     maarten.lankhorst@linux.intel.com
Cc:     neil.armstrong@linaro.org, mripard@kernel.org, tzimmermann@suse.de,
        airlied@gmail.com, daniel@ffwll.ch, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] [drm/meson] meson_plane: Add error handling
Date:   Wed, 29 Nov 2023 01:21:13 -0800
Message-Id: <20231129092113.32630-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wA3X+CMAmdlXBT+CQ--.41354S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WrWfWryftry3Gr48Kr4DJwb_yoW8Wr1xpF
        4UCF1Y9r17Aa15t347AF4YyFZxWw4fGFyUuFy8twnYkwnxKFy7CFy3KFZrCF4UXFW5u3Z3
        Kr13Cr4DCF17AF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi5EfUUUUUU=
X-Originating-IP: [39.144.190.126]
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/xtbBchI3gletj5ACogAAsQ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds robust error handling to the meson_plane_create
function in drivers/gpu/drm/meson/meson_plane.c. The function
previously lacked proper handling for potential failure scenarios
of the drm_universal_plane_init call.

Signed-off-by: Haoran Liu <liuhaoran14@163.com>
---
 drivers/gpu/drm/meson/meson_plane.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_plane.c b/drivers/gpu/drm/meson/meson_plane.c
index 815dfe30492b..67b36398f146 100644
--- a/drivers/gpu/drm/meson/meson_plane.c
+++ b/drivers/gpu/drm/meson/meson_plane.c
@@ -534,6 +534,7 @@ int meson_plane_create(struct meson_drm *priv)
 	struct meson_plane *meson_plane;
 	struct drm_plane *plane;
 	const uint64_t *format_modifiers = format_modifiers_default;
+	int ret;
 
 	meson_plane = devm_kzalloc(priv->drm->dev, sizeof(*meson_plane),
 				   GFP_KERNEL);
@@ -548,12 +549,16 @@ int meson_plane_create(struct meson_drm *priv)
 	else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A))
 		format_modifiers = format_modifiers_afbc_g12a;
 
-	drm_universal_plane_init(priv->drm, plane, 0xFF,
+	ret = drm_universal_plane_init(priv->drm, plane, 0xFF,
 				 &meson_plane_funcs,
 				 supported_drm_formats,
 				 ARRAY_SIZE(supported_drm_formats),
 				 format_modifiers,
 				 DRM_PLANE_TYPE_PRIMARY, "meson_primary_plane");
+	if (ret) {
+		devm_kfree(priv->drm->dev, meson_plane);
+		return ret;
+	}
 
 	drm_plane_helper_add(plane, &meson_plane_helper_funcs);
 
-- 
2.17.1

