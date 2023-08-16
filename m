Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412D577DFC1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244124AbjHPKpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244048AbjHPKpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:45:01 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D3E2D5F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 03:44:42 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5d0c:f209:12a7:4ce5])
        by andre.telenet-ops.be with bizsmtp
        id aAkg2A00U45ualL01AkgCW; Wed, 16 Aug 2023 12:44:41 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWE0w-000os0-EB;
        Wed, 16 Aug 2023 12:44:40 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWDAw-006761-RX;
        Wed, 16 Aug 2023 11:50:50 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 24/41] drm: renesas: shmobile: Use media bus formats in platform data
Date:   Wed, 16 Aug 2023 11:50:31 +0200
Message-Id: <24f997286075a71b85d1d148b69f4303cfe7e2c9.1692178020.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1692178020.git.geert+renesas@glider.be>
References: <cover.1692178020.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the custom shmob_drm_interface enumeration values with standard
media bus formats.  This simplifies driver handling of bus formats and
prepares for DT support.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - No changes,

v2:
  - Keep table instead of replacing it by a switch() statement,
  - Fix shmob_drm_interface_data.bus_fmt comment.
---
 .../gpu/drm/renesas/shmobile/shmob_drm_drv.c  | 37 +++++++++++--------
 include/linux/platform_data/shmob_drm.h       | 13 +------
 2 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
index c9ac8a86a7c39097..08b254f0f2874786 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
@@ -9,6 +9,7 @@
 
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/media-bus-format.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -34,25 +35,31 @@
 
 static int shmob_drm_init_interface(struct shmob_drm_device *sdev)
 {
-	static const u32 ldmt1r[] = {
-		[SHMOB_DRM_IFACE_RGB8] = LDMT1R_MIFTYP_RGB8,
-		[SHMOB_DRM_IFACE_RGB9] = LDMT1R_MIFTYP_RGB9,
-		[SHMOB_DRM_IFACE_RGB12A] = LDMT1R_MIFTYP_RGB12A,
-		[SHMOB_DRM_IFACE_RGB12B] = LDMT1R_MIFTYP_RGB12B,
-		[SHMOB_DRM_IFACE_RGB16] = LDMT1R_MIFTYP_RGB16,
-		[SHMOB_DRM_IFACE_RGB18] = LDMT1R_MIFTYP_RGB18,
-		[SHMOB_DRM_IFACE_RGB24] = LDMT1R_MIFTYP_RGB24,
-		[SHMOB_DRM_IFACE_YUV422] = LDMT1R_MIFTYP_YCBCR,
+	static const struct {
+		u32 fmt;
+		u32 ldmt1r;
+	} bus_fmts[] = {
+		{ MEDIA_BUS_FMT_RGB888_3X8,	 LDMT1R_MIFTYP_RGB8 },
+		{ MEDIA_BUS_FMT_RGB666_2X9_BE,	 LDMT1R_MIFTYP_RGB9 },
+		{ MEDIA_BUS_FMT_RGB888_2X12_BE,	 LDMT1R_MIFTYP_RGB12A },
+		{ MEDIA_BUS_FMT_RGB444_1X12,	 LDMT1R_MIFTYP_RGB12B },
+		{ MEDIA_BUS_FMT_RGB565_1X16,	 LDMT1R_MIFTYP_RGB16 },
+		{ MEDIA_BUS_FMT_RGB666_1X18,	 LDMT1R_MIFTYP_RGB18 },
+		{ MEDIA_BUS_FMT_RGB888_1X24,	 LDMT1R_MIFTYP_RGB24 },
+		{ MEDIA_BUS_FMT_UYVY8_1X16,	 LDMT1R_MIFTYP_YCBCR },
 	};
+	unsigned int i;
 
-	if (sdev->pdata->iface.interface >= ARRAY_SIZE(ldmt1r)) {
-		dev_err(sdev->dev, "invalid interface type %u\n",
-			sdev->pdata->iface.interface);
-		return -EINVAL;
+	for (i = 0; i < ARRAY_SIZE(bus_fmts); i++) {
+		if (bus_fmts[i].fmt == sdev->pdata->iface.bus_fmt) {
+			sdev->ldmt1r = bus_fmts[i].ldmt1r;
+			return 0;
+		}
 	}
 
-	sdev->ldmt1r = ldmt1r[sdev->pdata->iface.interface];
-	return 0;
+	dev_err(sdev->dev, "unsupported bus format 0x%x\n",
+		sdev->pdata->iface.bus_fmt);
+	return -EINVAL;
 }
 
 static int shmob_drm_setup_clocks(struct shmob_drm_device *sdev,
diff --git a/include/linux/platform_data/shmob_drm.h b/include/linux/platform_data/shmob_drm.h
index f3cb19ff9f818aca..6c19d4fbbe39586b 100644
--- a/include/linux/platform_data/shmob_drm.h
+++ b/include/linux/platform_data/shmob_drm.h
@@ -18,17 +18,6 @@ enum shmob_drm_clk_source {
 	SHMOB_DRM_CLK_EXTERNAL,
 };
 
-enum shmob_drm_interface {
-	SHMOB_DRM_IFACE_RGB8,		/* 24bpp, 8:8:8 */
-	SHMOB_DRM_IFACE_RGB9,		/* 18bpp, 9:9 */
-	SHMOB_DRM_IFACE_RGB12A,		/* 24bpp, 12:12 */
-	SHMOB_DRM_IFACE_RGB12B,		/* 12bpp */
-	SHMOB_DRM_IFACE_RGB16,		/* 16bpp */
-	SHMOB_DRM_IFACE_RGB18,		/* 18bpp */
-	SHMOB_DRM_IFACE_RGB24,		/* 24bpp */
-	SHMOB_DRM_IFACE_YUV422,		/* 16bpp */
-};
-
 struct shmob_drm_panel_data {
 	unsigned int width_mm;		/* Panel width in mm */
 	unsigned int height_mm;		/* Panel height in mm */
@@ -36,7 +25,7 @@ struct shmob_drm_panel_data {
 };
 
 struct shmob_drm_interface_data {
-	enum shmob_drm_interface interface;
+	unsigned int bus_fmt;		/* MEDIA_BUS_FMT_* */
 	unsigned int clk_div;
 };
 
-- 
2.34.1

