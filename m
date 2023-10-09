Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFC97BEC8C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378597AbjJIVO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378710AbjJIVOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:14:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBCFC6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 14:14:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0C1C433CC;
        Mon,  9 Oct 2023 21:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696886067;
        bh=bcVRBerKLN3z3a+n5ySbsO9a5UW+yPFpaZA09Z5pSJk=;
        h=From:To:Cc:Subject:Date:From;
        b=GXEcZDA6r/rvEEam379V7bL2vQA6BSnMY/2ii+6JzoSKwAZ7fCq4dvF2giTpe2LgD
         dRHLvHwuzHOHW0qi1/g923ZkJLX6U8xVJMm+3YBYtnzq+1PvH1mg0gzVP75oQN95hl
         UIRGfg7IUGUqcwXrY9FEKK9huJzVdjBlk0hiSJgDFPUt14CQztmQ+JpUUXTkY6padr
         qMype6Kyk8Lin20Tm5giIT0/q3jqVLFSLocLdRMRzJ11/VoKNeYQll+KSKnLoOcnKg
         iVrOQrGhzcu75mrrpWLJowrpSc8ax9RluLmdXcq9+UYQB83go3Hnb+r4LZSUQ63+uG
         eg4CwyTfHiQxg==
Received: (nullmailer pid 3246090 invoked by uid 1000);
        Mon, 09 Oct 2023 21:14:13 -0000
From:   Rob Herring <robh@kernel.org>
To:     Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] reset: Use device_get_match_data()
Date:   Mon,  9 Oct 2023 16:13:41 -0500
Message-ID: <20231009211356.3242037-11-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preferred device_get_match_data() instead of of_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/reset/reset-npcm.c       |  5 ++---
 drivers/reset/sti/reset-syscfg.c | 11 ++++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/reset/reset-npcm.c b/drivers/reset/reset-npcm.c
index f6c4f854f2be..8935ef95a2d1 100644
--- a/drivers/reset/reset-npcm.c
+++ b/drivers/reset/reset-npcm.c
@@ -6,8 +6,8 @@
 #include <linux/io.h>
 #include <linux/init.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/reboot.h>
 #include <linux/reset-controller.h>
 #include <linux/spinlock.h>
@@ -351,8 +351,7 @@ static int npcm_usb_reset(struct platform_device *pdev, struct npcm_rc_data *rc)
 		}
 	}
 
-	rc->info = (const struct npcm_reset_info *)
-			of_match_device(dev->driver->of_match_table, dev)->data;
+	rc->info = device_get_match_data(dev);
 	switch (rc->info->bmc_id) {
 	case BMC_NPCM7XX:
 		npcm_usb_reset_npcm7xx(rc);
diff --git a/drivers/reset/sti/reset-syscfg.c b/drivers/reset/sti/reset-syscfg.c
index c1ba04f6f155..2324060b747c 100644
--- a/drivers/reset/sti/reset-syscfg.c
+++ b/drivers/reset/sti/reset-syscfg.c
@@ -7,10 +7,11 @@
  */
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/module.h>
 #include <linux/err.h>
 #include <linux/types.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
 
@@ -183,14 +184,14 @@ static int syscfg_reset_controller_register(struct device *dev,
 int syscfg_reset_probe(struct platform_device *pdev)
 {
 	struct device *dev = pdev ? &pdev->dev : NULL;
-	const struct of_device_id *match;
+	const void *data;
 
 	if (!dev || !dev->driver)
 		return -ENODEV;
 
-	match = of_match_device(dev->driver->of_match_table, dev);
-	if (!match || !match->data)
+	data = device_get_match_data(&pdev->dev);
+	if (!data)
 		return -EINVAL;
 
-	return syscfg_reset_controller_register(dev, match->data);
+	return syscfg_reset_controller_register(dev, data);
 }
-- 
2.42.0

