Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C4B7BC24A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 00:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbjJFWoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 18:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbjJFWoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 18:44:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29ED093
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 15:44:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68DEAC433C8;
        Fri,  6 Oct 2023 22:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696632271;
        bh=kLBBvmt6zja6l1H2kl0074A16902exhUloqRcMFqCwA=;
        h=From:To:Cc:Subject:Date:From;
        b=B/B7N/O5k7Kz3bqzzp45Z0IB4Gx00Xyu0Ur8CTEAYFvtWVppzeunPwYF81XY1MDIp
         o/CHscO81d6wyUFCyk5Z6gSHD3rX88eXGmyBMcQ87ExMsnXFv5sMOIIUFTTI0uKgR/
         jTNakNxEBn7AhnV6C1GTVeeFMiOEq+t5d1N5vHwSJpDWASAd0bCzs4xKq3gQOwxqz2
         FMgGNb0RqkpYpvGif1z2M3mqUfO3Bne4D7P4X9QD/1TvUxf27O5fB7fTnmwnYE/JXa
         YgMj0UaA+UfGJwEL5u65q9xuw+XBXSp+IBH5BjpMndoW2i8JxxAiP+aQPXokH7f0JO
         2fc490xC9sAuA==
Received: (nullmailer pid 442674 invoked by uid 1000);
        Fri, 06 Oct 2023 22:44:30 -0000
From:   Rob Herring <robh@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] irqchip: ls-scfg-msi: Use device_get_match_data()
Date:   Fri,  6 Oct 2023 17:44:21 -0500
Message-Id: <20231006224422.442491-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/irqchip/irq-ls-scfg-msi.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
index f31a262fe438..15cf80b46322 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -17,7 +17,8 @@
 #include <linux/irqdomain.h>
 #include <linux/of_irq.h>
 #include <linux/of_pci.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/spinlock.h>
 
 #define MSI_IRQS_PER_MSIR	32
@@ -334,20 +335,17 @@ MODULE_DEVICE_TABLE(of, ls_scfg_msi_id);
 
 static int ls_scfg_msi_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
 	struct ls_scfg_msi *msi_data;
 	struct resource *res;
 	int i, ret;
 
-	match = of_match_device(ls_scfg_msi_id, &pdev->dev);
-	if (!match)
-		return -ENODEV;
-
 	msi_data = devm_kzalloc(&pdev->dev, sizeof(*msi_data), GFP_KERNEL);
 	if (!msi_data)
 		return -ENOMEM;
 
-	msi_data->cfg = (struct ls_scfg_msi_cfg *) match->data;
+	msi_data->cfg = (struct ls_scfg_msi_cfg *)device_get_match_data(&pdev->dev);
+	if (!msi_data->cfg)
+		return -ENODEV;
 
 	msi_data->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(msi_data->regs)) {
-- 
2.40.1

