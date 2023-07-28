Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3ED7668B6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbjG1JXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235712AbjG1JXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:23:23 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258C959E6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 02:18:01 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:12b0:7b7e:d1ff:7873])
        by michel.telenet-ops.be with bizsmtp
        id SZHA2A0070d1nm806ZHAPB; Fri, 28 Jul 2023 11:17:10 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qPJaj-002lsM-7l;
        Fri, 28 Jul 2023 11:17:10 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qPJaw-00AoD2-9T;
        Fri, 28 Jul 2023 11:17:10 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] drm/panel: simple: Simplify matching using of_device_get_match_data()
Date:   Fri, 28 Jul 2023 11:17:09 +0200
Message-Id: <64ded5b7e809e4c6e915b2c4d8b82e02319cd206.1690535800.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
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

Both the patform_driver and mipi_dsi_driver structures contain pointers
to the match table used, so the custom code to obtain match and match
data can be replaced by calls to of_device_get_match_data().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
v2:
  - Add Reviewed-by.
---
 drivers/gpu/drm/panel/panel-simple.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 4badda6570d5d868..f27d5d8cffbf3553 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -4455,13 +4455,13 @@ MODULE_DEVICE_TABLE(of, platform_of_match);
 
 static int panel_simple_platform_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *id;
+	const struct panel_desc *desc;
 
-	id = of_match_node(platform_of_match, pdev->dev.of_node);
-	if (!id)
+	desc = of_device_get_match_data(&pdev->dev);
+	if (!desc)
 		return -ENODEV;
 
-	return panel_simple_probe(&pdev->dev, id->data);
+	return panel_simple_probe(&pdev->dev, desc);
 }
 
 static void panel_simple_platform_remove(struct platform_device *pdev)
@@ -4732,15 +4732,12 @@ MODULE_DEVICE_TABLE(of, dsi_of_match);
 static int panel_simple_dsi_probe(struct mipi_dsi_device *dsi)
 {
 	const struct panel_desc_dsi *desc;
-	const struct of_device_id *id;
 	int err;
 
-	id = of_match_node(dsi_of_match, dsi->dev.of_node);
-	if (!id)
+	desc = of_device_get_match_data(&dsi->dev);
+	if (!desc)
 		return -ENODEV;
 
-	desc = id->data;
-
 	err = panel_simple_probe(&dsi->dev, &desc->desc);
 	if (err < 0)
 		return err;
-- 
2.34.1

