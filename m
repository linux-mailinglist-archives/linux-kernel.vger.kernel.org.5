Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D646B7BC181
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbjJFVp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbjJFVpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:45:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70739BD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 14:45:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AEB4C433C8;
        Fri,  6 Oct 2023 21:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696628721;
        bh=i+PAI5tS9dQFHq2UMHdhk9RfN5pkw2PWAlQmRe31xno=;
        h=From:To:Cc:Subject:Date:From;
        b=Vo565lnSLZ2W3SIoc47sdQoPbrIHs2BdRkW2RJdfXI5ijLO4KPy069jJH4ezPmAW3
         V815SJZ08RdABhfA4NuEXVWyYKjXEZZG+Ztpk9zcmI0H0P8l7x3u0AX5f2C5v+olqJ
         v0kMx1q58+WOxorH6l/5iby1Om0tmcVwsZc72MjEhN0+Nu+2vI5pWdDA9cEv7bB7fn
         b4tMJst71tkSu2c+vZ9f6afbA8B3PipHNsYNW/zbJZFwOWgww8mxyTp6eaIRu79w3Q
         iQXWlhQURfMbq4H7FYj3HtvfWlJMg4ZLOjNumE2jwRZlAANkD9DRsivzE3BnRduGch
         zO8W9upmtgjwA==
Received: (nullmailer pid 340666 invoked by uid 1000);
        Fri, 06 Oct 2023 21:45:19 -0000
From:   Rob Herring <robh@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: fsl_msi: Use device_get_match_data()
Date:   Fri,  6 Oct 2023 16:45:16 -0500
Message-Id: <20231006214516.340589-1-robh@kernel.org>
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
 arch/powerpc/sysdev/fsl_msi.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 57978a44d55b..558ec68d768e 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -11,9 +11,11 @@
 #include <linux/msi.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
 #include <linux/seq_file.h>
@@ -392,7 +394,6 @@ static int fsl_msi_setup_hwirq(struct fsl_msi *msi, struct platform_device *dev,
 static const struct of_device_id fsl_of_msi_ids[];
 static int fsl_of_msi_probe(struct platform_device *dev)
 {
-	const struct of_device_id *match;
 	struct fsl_msi *msi;
 	struct resource res, msiir;
 	int err, i, j, irq_index, count;
@@ -402,10 +403,7 @@ static int fsl_of_msi_probe(struct platform_device *dev)
 	u32 offset;
 	struct pci_controller *phb;
 
-	match = of_match_device(fsl_of_msi_ids, &dev->dev);
-	if (!match)
-		return -EINVAL;
-	features = match->data;
+	features = device_get_match_data(&dev->dev);
 
 	printk(KERN_DEBUG "Setting up Freescale MSI support\n");
 
-- 
2.40.1

