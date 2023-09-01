Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4446B78FD56
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349482AbjIAMeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238417AbjIAMeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:34:20 -0400
X-Greylist: delayed 577 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Sep 2023 05:34:17 PDT
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C6F910CF;
        Fri,  1 Sep 2023 05:34:17 -0700 (PDT)
Received: from hq-00595.fritz.box (unknown [176.126.217.202])
        by mail.bugwerft.de (Postfix) with ESMTPSA id C227D280203;
        Fri,  1 Sep 2023 12:24:37 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     linux-gpio@vger.kernel.org, manikanta.guntupalli@amd.com
Cc:     linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        stable@kernel.org
Subject: [PATCH] gpio: zynq: restore zynq_gpio_irq_reqres/zynq_gpio_irq_relres callbacks
Date:   Fri,  1 Sep 2023 14:24:24 +0200
Message-ID: <20230901122424.247070-1-daniel@zonque.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f56914393537 ("gpio: zynq: fix zynqmp_gpio not an immutable chip
warning") ditched the open-coded resource allocation handlers in favor
of the generic ones. These generic handlers don't maintain the PM
runtime anymore, which causes a regression in that level IRQs are no
longer reported.

Restore the original handlers to fix this.

Signed-off-by: Daniel Mack <daniel@zonque.org>
Fixes: f56914393537 ("gpio: zynq: fix zynqmp_gpio not an immutable chip warning")
Cc: stable@kernel.org
---
 drivers/gpio/gpio-zynq.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index 0a7264aabe48..324e942c0650 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -575,6 +575,26 @@ static int zynq_gpio_set_wake(struct irq_data *data, unsigned int on)
 	return 0;
 }
 
+static int zynq_gpio_irq_reqres(struct irq_data *d)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(chip->parent);
+	if (ret < 0)
+		return ret;
+
+	return gpiochip_reqres_irq(chip, d->hwirq);
+}
+
+static void zynq_gpio_irq_relres(struct irq_data *d)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
+
+	gpiochip_relres_irq(chip, d->hwirq);
+	pm_runtime_put(chip->parent);
+}
+
 /* irq chip descriptor */
 static const struct irq_chip zynq_gpio_level_irqchip = {
 	.name		= DRIVER_NAME,
@@ -584,9 +604,10 @@ static const struct irq_chip zynq_gpio_level_irqchip = {
 	.irq_unmask	= zynq_gpio_irq_unmask,
 	.irq_set_type	= zynq_gpio_set_irq_type,
 	.irq_set_wake	= zynq_gpio_set_wake,
+	.irq_request_resources = zynq_gpio_irq_reqres,
+	.irq_release_resources = zynq_gpio_irq_relres,
 	.flags		= IRQCHIP_EOI_THREADED | IRQCHIP_EOI_IF_HANDLED |
 			  IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_IMMUTABLE,
-	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
 static const struct irq_chip zynq_gpio_edge_irqchip = {
@@ -597,8 +618,9 @@ static const struct irq_chip zynq_gpio_edge_irqchip = {
 	.irq_unmask	= zynq_gpio_irq_unmask,
 	.irq_set_type	= zynq_gpio_set_irq_type,
 	.irq_set_wake	= zynq_gpio_set_wake,
+	.irq_request_resources = zynq_gpio_irq_reqres,
+	.irq_release_resources = zynq_gpio_irq_relres,
 	.flags		= IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_IMMUTABLE,
-	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
 static void zynq_gpio_handle_bank_irq(struct zynq_gpio *gpio,
-- 
2.41.0

