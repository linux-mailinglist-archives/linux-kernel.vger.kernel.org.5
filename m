Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76717D8FB1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345376AbjJ0HYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJ0HYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:24:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE66E116;
        Fri, 27 Oct 2023 00:24:01 -0700 (PDT)
Date:   Fri, 27 Oct 2023 07:23:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698391440;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O//1fsnSIZl/qZYdPGy7Kgy5AC0iiFOxPF2WMdZrKEg=;
        b=VbnGo70cgtk7inlZGoUs8cHI7wppwyITCaDRuQaXsoKv48ZF9OwO9UCSc3RBOfK6kYRlGy
        DcYQZRXQbWg+To9s5i+R+Tc4BKHTPeGN5URvuiSsFmm893OqRacMvbjlBwhCDZs5AssjyY
        9yAuUlV7yPk4qx47GqvZ57QP5VT8uv8Y0wJIO6KZ0rLvbsEfMSevpOGJ1crz14kgrwKHJw
        3aX/ozdzhRutX7XzvWS7qa7fXkzDB+FdltVm3xkttmDzU0o5F5Hk5i08IL3/TqPAAsCwIx
        LMlrSDxSMN4H9MPLHuBoCOKIMYTeNUSFZPRgv0qj+nmM4Cgj+MazHU3YMhmr3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698391440;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O//1fsnSIZl/qZYdPGy7Kgy5AC0iiFOxPF2WMdZrKEg=;
        b=3WY3Xh5Uf2Ai/4uJVd12SOBNAH5SAXxOoVgbPKaelLzS30uZcnbVu2YnoB15kEUsb/mye7
        ArdxiDIJgQY48kAg==
From:   "tip-bot2 for Rob Herring" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/ls-scfg-msi: Use device_get_match_data()
Cc:     Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Oltean <vladimir.oltean@nxp.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20231020130255.2954415-3-robh@kernel.org>
References: <20231020130255.2954415-3-robh@kernel.org>
MIME-Version: 1.0
Message-ID: <169839143971.3135.1761692121713696071.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     08d4c174828d868d314d2475fbcaa1393f0bbba9
Gitweb:        https://git.kernel.org/tip/08d4c174828d868d314d2475fbcaa1393f0bbba9
Author:        Rob Herring <robh@kernel.org>
AuthorDate:    Fri, 20 Oct 2023 08:02:56 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 27 Oct 2023 09:15:44 +02:00

irqchip/ls-scfg-msi: Use device_get_match_data()

Use preferred device_get_match_data() instead of of_match_device() to
get the driver match data in a single step without the unnecessary
intermediate match pointer.

With this, adjust the includes to explicitly include the correct
headers. That also serves as preparation to remove implicit includes within
the DT headers.  of_platform.h currently includes platform_device.h among
others.

Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://lore.kernel.org/r/20231020130255.2954415-3-robh@kernel.org

---
 drivers/irqchip/irq-ls-scfg-msi.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
index f31a262..15cf80b 100644
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
