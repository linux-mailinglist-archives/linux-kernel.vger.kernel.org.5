Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF65B75830B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjGRQ4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjGRQzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:55:06 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198DE1BDD
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:54:55 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5803:2d6d:5bbc:e252])
        by albert.telenet-ops.be with bizsmtp
        id Ngur2A00v0ucMBo06gurSq; Tue, 18 Jul 2023 18:54:53 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qLnyD-001nZE-Ie;
        Tue, 18 Jul 2023 18:54:51 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qLnyN-000gdM-Jh;
        Tue, 18 Jul 2023 18:54:51 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH v2 28/41] drm: renesas: shmobile: Rename shmob_drm_connector.connector
Date:   Tue, 18 Jul 2023 18:54:33 +0200
Message-Id: <6b292b4ef399cd6ec3932ec9eab7db9c49707d68.1689698048.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1689698048.git.geert+renesas@glider.be>
References: <cover.1689698048.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the "connector" member of the shmob_drm_connector subclass
structure to "base", to improve readability.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
v2:
  - Add Reviewed-by.
---
 drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c | 4 ++--
 drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
index 84a773a5363035e0..f55b5263e611c782 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
@@ -560,7 +560,7 @@ int shmob_drm_encoder_create(struct shmob_drm_device *sdev)
 
 static inline struct shmob_drm_connector *to_shmob_connector(struct drm_connector *connector)
 {
-	return container_of(connector, struct shmob_drm_connector, connector);
+	return container_of(connector, struct shmob_drm_connector, base);
 }
 
 static int shmob_drm_connector_get_modes(struct drm_connector *connector)
@@ -632,7 +632,7 @@ shmob_drm_connector_init(struct shmob_drm_device *sdev,
 	if (!scon)
 		return ERR_PTR(-ENOMEM);
 
-	connector = &scon->connector;
+	connector = &scon->base;
 	scon->encoder = encoder;
 	scon->mode = &sdev->pdata->panel.mode;
 
diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h
index 79cce0a0ada4cfce..2c6d7541427581a6 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h
@@ -33,7 +33,7 @@ struct shmob_drm_crtc {
 };
 
 struct shmob_drm_connector {
-	struct drm_connector connector;
+	struct drm_connector base;
 	struct drm_encoder *encoder;
 	const struct videomode *mode;
 };
-- 
2.34.1

