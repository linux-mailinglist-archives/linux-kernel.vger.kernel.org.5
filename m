Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B89D7FD5D2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbjK2Leu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbjK2Leq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:34:46 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0F5A10DF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=ZAsQiqQtYrl7dfrofE
        u3bEncXTW4ARayG+BTXJ6pdqE=; b=JVUaCztkrUfhYVpftCkPcJzISA6ReUW6G6
        Lb0ic9gSx8IjfkhQmG53TqHphSEzXyQTlzT72ZtfKWK6iIw3u/W4hIBAqoxcgmIT
        S2xZL9+j/r0ND6gJP+5I46qfi31vroS9LDV3ENPPIPW4izkH9X5PnVLiG8wTPOd6
        4uouplpE8=
Received: from localhost.localdomain (unknown [39.144.190.126])
        by zwqz-smtp-mta-g5-3 (Coremail) with SMTP id _____wDXXmKvIWdl8CEBEQ--.41793S2;
        Wed, 29 Nov 2023 19:34:09 +0800 (CST)
From:   Haoran Liu <liuhaoran14@163.com>
To:     maarten.lankhorst@linux.intel.com
Cc:     neil.armstrong@linaro.org, mripard@kernel.org, tzimmermann@suse.de,
        airlied@gmail.com, daniel@ffwll.ch, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH v2] [drm/meson] meson_plane: Add error handling v2(re-aligned)
Date:   Wed, 29 Nov 2023 03:34:05 -0800
Message-Id: <20231129113405.33057-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wDXXmKvIWdl8CEBEQ--.41793S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WrWfWryftry3Gr48KFy8Zrb_yoW8AFy3pF
        47CFyY9ry7Aa1Ut347Ar4YyFW3Ww4rGFyUur18trnYkwnxKFy7Cry3KFZFkFyUXFW5u3Z3
        KrnxCr4DCr1ayFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRb4SrUUUUU=
X-Originating-IP: [39.144.190.126]
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/1tbiwh83glc661p0cgABsz
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/gpu/drm/meson/meson_plane.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_plane.c b/drivers/gpu/drm/meson/meson_plane.c
index 815dfe30492b..b43ac61201f3 100644
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
-				 &meson_plane_funcs,
-				 supported_drm_formats,
-				 ARRAY_SIZE(supported_drm_formats),
-				 format_modifiers,
-				 DRM_PLANE_TYPE_PRIMARY, "meson_primary_plane");
+	ret = drm_universal_plane_init(priv->drm, plane, 0xFF,
+					&meson_plane_funcs,
+					supported_drm_formats,
+					ARRAY_SIZE(supported_drm_formats),
+					format_modifiers,
+					DRM_PLANE_TYPE_PRIMARY, "meson_primary_plane");
+	if (ret) {
+		devm_kfree(priv->drm->dev, meson_plane);
+		return ret;
+	}
 
 	drm_plane_helper_add(plane, &meson_plane_helper_funcs);
 
-- 
2.17.1

