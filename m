Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0F577BA50
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjHNNlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjHNNkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:40:46 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D6AE54
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:40:45 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPA id A427DE0004;
        Mon, 14 Aug 2023 13:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692020443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iv1cYDOnIeoz6q9otJ3llit4PPG5QkApkUhlm5iTdLU=;
        b=Yfd2WnGT7XC+FqcmMhS6v6/TfT8NX4n1+qLXsfId1dABFmMSRmyp86j4Lj1itHHXLVmbGP
        nsttf1o+GSqs/YzLjLDqXZri534GHfZCxWRdRdxA9F4Ns1243k24CjhVSyrRxOTccl9Wz7
        48XVdLo23AIwJg05jD1bvv0Y5P574UadmzqaCqQTJ9EqwIczLeb2loPsZ3FpCNUuzY2KSj
        JJr/hYC3LJVMqgg2/jScUUTwMraYqzaVHfZE4zQvlnfbwz0RG7dWm9Biet5ryf0GfuBa75
        icH0XL9Kgth2LSer7f489VS2P9U0ADPWf8SdkD+20fGyvmcmcj8rG0kke46frQ==
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
Subject: [PATCH v2] drm/panel: simple: Fix Innolux G156HCE-L01 LVDS clock
Date:   Mon, 14 Aug 2023 15:40:24 +0200
Message-Id: <20230814134024.397739-1-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: luca.ceresoli@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

Fixes: eae7488814b5 ("drm/panel-simple: Add Innolux G156HCE-L01 panel entry")
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Tested-by: Marek Vasut <marex@denx.de> # MX8MM with LT9211
Reviewed-by: Marek Vasut <marex@denx.de>

---

Changed in v2:
 - fix commit hash in "Fixes:" line
 - add tested/reviewed by Marek
---
 drivers/gpu/drm/panel/panel-simple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 701013b3ad13..a1bbc7f11e83 100644
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

