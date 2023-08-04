Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BC477041A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjHDPKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjHDPKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:10:50 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916844EED
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 08:10:28 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPA id E82DE1C0003;
        Fri,  4 Aug 2023 15:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691161818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nwlqseqskDNjzuWWUqN4ODDJjpTVWn6NU0l72pzeoK8=;
        b=VJ3+2Iipwpe+7bbRgZ3Mo67/svscBp1VM/IOxmXTYkyXxPjyEmtxd/Hky19XhZ5oL9fCLu
        t7Gq3LmgnoAGGBYDZE9M3hH23wH+aOCjMPBUgv3+Ceq5jjReDtthR2I/f5P6wu+1k8YcrD
        eZ9tLWMUSvkUu/drZksipTTqowzEM0Wxi9T2Aooi0ZQR7mizfrLpEDL4AJgSsZcxWo6z2c
        00cmITNpOfY5J9uq636y8vBF4H0oAJfzR5835PRXjsyD00P+HmktpLX2TnRq2FSPMrH7X+
        fTu9WGVlYoa55oHc/feQRnvujlYU8yA+RnLwOOi/61mcDBMEVvT7Ecrxf2Fx3g==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Marek Vasut <marex@denx.de>,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH] drm/panel: simple: Fix Innolux G156HCE-L01 LVDS clock
Date:   Fri,  4 Aug 2023 17:10:10 +0200
Message-Id: <20230804151010.834990-1-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: luca.ceresoli@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This panel has been implemented in commit 225213f24c79 ("drm/panel-simple:
Add Innolux G156HCE-L01 panel entry") with a higher clock than the typical
one mentioned on the documentation to avoid flickering on the unit
tested. Testing on a different unit shows that the panel actually works
with the intended 70.93 MHz clock and even lower frequencies so the
flickering is likely caused either by a defective unit or by other
different components such as the bridge.

Fixes: 225213f24c79 ("drm/panel-simple: Add Innolux G156HCE-L01 panel entry")
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 56854f78441e..ec3a73bbfe30 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2379,7 +2379,7 @@ static const struct panel_desc innolux_g121x1_l03 = {
 };
 
 static const struct display_timing innolux_g156hce_l01_timings = {
-	.pixelclock = { 120000000, 144000000, 150000000 },
+	.pixelclock = { 120000000, 141860000, 150000000 },
 	.hactive = { 1920, 1920, 1920 },
 	.hfront_porch = { 80, 90, 100 },
 	.hback_porch = { 80, 90, 100 },
-- 
2.34.1

