Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B4E763A7C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjGZPL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 11:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbjGZPLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:11:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728EF30D7;
        Wed, 26 Jul 2023 08:10:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EE8E61B54;
        Wed, 26 Jul 2023 15:09:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBBDC433C8;
        Wed, 26 Jul 2023 15:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690384189;
        bh=RsGxXpD8wM1bkzPyo17f7G/JJ9RXJd2b48b/SmqDinI=;
        h=From:To:Cc:Subject:Date:From;
        b=ob5iblM5Z1/6wGa8zVkoa98SmM4gkOg2m9K693glsZJZZF/dspRpCUgPgf+03cEq1
         /8PEFhEm3SnrO8xemrKSWSuDtbyzeQkJnGViCCnbw8E8zaMvYuhPzMUCeMEZUnbI0m
         2IWaRvwygw0AJp14aRGxitt6QMcvgvQQKN3SbbgnPE1Ms6ZOs/4naQViPT6WweOqoJ
         vu4QS8eOWOlZedsppdy0QIq4M35pQa1ZXgrsMCKeECWNU76EtFdDM90Bx4dsnxGL+U
         Ir2Zr3X9qNCFYZLV1oEVhhW+rHfoguIzcg8sJPVvrXKw7F04hqmj9ymJU7G3LGbf5Z
         8IjXGFOn7zYuw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] parport: gsc: remove DMA leftover code
Date:   Wed, 26 Jul 2023 17:09:14 +0200
Message-Id: <20230726150944.2265044-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This driver does not actually work with DMA mode, but still tries
to call ISA DMA interface functions that are stubbed out on
parisc, resulting in a W=1 build warning:

drivers/parport/parport_gsc.c: In function 'parport_remove_chip':
drivers/parport/parport_gsc.c:389:20: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
  389 |    free_dma(p->dma);

Remove the corresponding code as a prerequisite for turning on -Wempty-body
by default in all kernels.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/parport/parport_gsc.c | 28 ++++------------------------
 drivers/parport/parport_gsc.h |  7 -------
 2 files changed, 4 insertions(+), 31 deletions(-)

diff --git a/drivers/parport/parport_gsc.c b/drivers/parport/parport_gsc.c
index 0dcc497b0449a..5e4475254bd0a 100644
--- a/drivers/parport/parport_gsc.c
+++ b/drivers/parport/parport_gsc.c
@@ -28,7 +28,6 @@
 #include <linux/sysctl.h>
 
 #include <asm/io.h>
-#include <asm/dma.h>
 #include <linux/uaccess.h>
 #include <asm/superio.h>
 
@@ -226,9 +225,9 @@ static int parport_PS2_supported(struct parport *pb)
 
 /* --- Initialisation code -------------------------------- */
 
-struct parport *parport_gsc_probe_port(unsigned long base,
+static struct parport *parport_gsc_probe_port(unsigned long base,
 				       unsigned long base_hi, int irq,
-				       int dma, struct parisc_device *padev)
+				       struct parisc_device *padev)
 {
 	struct parport_gsc_private *priv;
 	struct parport_operations *ops;
@@ -250,12 +249,9 @@ struct parport *parport_gsc_probe_port(unsigned long base,
 	}
 	priv->ctr = 0xc;
 	priv->ctr_writable = 0xff;
-	priv->dma_buf = NULL;
-	priv->dma_handle = 0;
 	p->base = base;
 	p->base_hi = base_hi;
 	p->irq = irq;
-	p->dma = dma;
 	p->modes = PARPORT_MODE_PCSPP | PARPORT_MODE_SAFEININT;
 	p->ops = ops;
 	p->private_data = priv;
@@ -286,17 +282,9 @@ struct parport *parport_gsc_probe_port(unsigned long base,
 	if (p->irq == PARPORT_IRQ_AUTO) {
 		p->irq = PARPORT_IRQ_NONE;
 	}
-	if (p->irq != PARPORT_IRQ_NONE) {
+	if (p->irq != PARPORT_IRQ_NONE)
 		pr_cont(", irq %d", p->irq);
 
-		if (p->dma == PARPORT_DMA_AUTO) {
-			p->dma = PARPORT_DMA_NONE;
-		}
-	}
-	if (p->dma == PARPORT_DMA_AUTO) /* To use DMA, giving the irq
-                                           is mandatory (see above) */
-		p->dma = PARPORT_DMA_NONE;
-
 	pr_cont(" [");
 #define printmode(x)							\
 do {									\
@@ -321,7 +309,6 @@ do {									\
 			pr_warn("%s: irq %d in use, resorting to polled operation\n",
 				p->name, p->irq);
 			p->irq = PARPORT_IRQ_NONE;
-			p->dma = PARPORT_DMA_NONE;
 		}
 	}
 
@@ -369,8 +356,7 @@ static int __init parport_init_chip(struct parisc_device *dev)
 		pr_info("%s: enhanced parport-modes not supported\n", __func__);
 	}
 	
-	p = parport_gsc_probe_port(port, 0, dev->irq,
-			/* PARPORT_IRQ_NONE */ PARPORT_DMA_NONE, dev);
+	p = parport_gsc_probe_port(port, 0, dev->irq, dev);
 	if (p)
 		parport_count++;
 	dev_set_drvdata(&dev->dev, p);
@@ -382,16 +368,10 @@ static void __exit parport_remove_chip(struct parisc_device *dev)
 {
 	struct parport *p = dev_get_drvdata(&dev->dev);
 	if (p) {
-		struct parport_gsc_private *priv = p->private_data;
 		struct parport_operations *ops = p->ops;
 		parport_remove_port(p);
-		if (p->dma != PARPORT_DMA_NONE)
-			free_dma(p->dma);
 		if (p->irq != PARPORT_IRQ_NONE)
 			free_irq(p->irq, p);
-		if (priv->dma_buf)
-			dma_free_coherent(&priv->dev->dev, PAGE_SIZE,
-					  priv->dma_buf, priv->dma_handle);
 		kfree (p->private_data);
 		parport_put_port(p);
 		kfree (ops); /* hope no-one cached it */
diff --git a/drivers/parport/parport_gsc.h b/drivers/parport/parport_gsc.h
index 9301217edf12c..d447a568c2570 100644
--- a/drivers/parport/parport_gsc.h
+++ b/drivers/parport/parport_gsc.h
@@ -63,8 +63,6 @@ struct parport_gsc_private {
 	int writeIntrThreshold;
 
 	/* buffer suitable for DMA, if DMA enabled */
-	char *dma_buf;
-	dma_addr_t dma_handle;
 	struct pci_dev *dev;
 };
 
@@ -199,9 +197,4 @@ extern void parport_gsc_inc_use_count(void);
 
 extern void parport_gsc_dec_use_count(void);
 
-extern struct parport *parport_gsc_probe_port(unsigned long base,
-						unsigned long base_hi,
-						int irq, int dma,
-						struct parisc_device *padev);
-
 #endif	/* __DRIVERS_PARPORT_PARPORT_GSC_H */
-- 
2.39.2

