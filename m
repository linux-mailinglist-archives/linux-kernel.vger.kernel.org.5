Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4C37582E8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbjGRQzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbjGRQzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:55:00 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F591711
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:54:54 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5803:2d6d:5bbc:e252])
        by laurent.telenet-ops.be with bizsmtp
        id Ngur2A0070ucMBo01gurj7; Tue, 18 Jul 2023 18:54:53 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qLnyD-001nYU-Aw;
        Tue, 18 Jul 2023 18:54:51 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qLnyN-000gcO-C2;
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
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 16/41] drm: renesas: shmobile: Improve error handling
Date:   Tue, 18 Jul 2023 18:54:21 +0200
Message-Id: <d64239a9c58422319ff2822c25a3027507815c4a.1689698048.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1689698048.git.geert+renesas@glider.be>
References: <cover.1689698048.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for DT conversion, where panel probe can be deferred, by
streamlining error propagation and handling:
  - Use dev_err_probe() to avoid printing error messages in case of
    probe deferral,
  - Propagate errors where needed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
v2:
  - Add Reviewed-by.
---
 drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c |  3 ++-
 drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.c | 14 +++++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
index 782767fc66d00c4f..91daab80b0ede058 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
@@ -255,7 +255,8 @@ static int shmob_drm_probe(struct platform_device *pdev)
 
 	ret = shmob_drm_modeset_init(sdev);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to initialize mode setting\n");
+		dev_err_probe(&pdev->dev, ret,
+			      "failed to initialize mode setting\n");
 		goto err_free_drm_dev;
 	}
 
diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.c
index 3051318ddc7999bc..1a62e7f8a8a9e6df 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.c
@@ -157,9 +157,17 @@ int shmob_drm_modeset_init(struct shmob_drm_device *sdev)
 	if (ret)
 		return ret;
 
-	shmob_drm_crtc_create(sdev);
-	shmob_drm_encoder_create(sdev);
-	shmob_drm_connector_create(sdev, &sdev->encoder);
+	ret = shmob_drm_crtc_create(sdev);
+	if (ret < 0)
+		return ret;
+
+	ret = shmob_drm_encoder_create(sdev);
+	if (ret < 0)
+		return ret;
+
+	ret = shmob_drm_connector_create(sdev, &sdev->encoder);
+	if (ret < 0)
+		return ret;
 
 	drm_kms_helper_poll_init(sdev->ddev);
 
-- 
2.34.1

