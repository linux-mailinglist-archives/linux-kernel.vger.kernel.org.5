Return-Path: <linux-kernel+bounces-157426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4988E8B118A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDC331F22D0E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8937816D4FE;
	Wed, 24 Apr 2024 17:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bjx9UMH2"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D4F16D4EF;
	Wed, 24 Apr 2024 17:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713981459; cv=none; b=E//NsXC+Sm1a4uDfBfMFu+wz0QERXGf2IyQQXcDb7q8Xrr60/48/1WlFXBx7Sx9pJ/PNA44jT8j6bAPtxNWphoAxTorNNW17nCUzQ8W/fP4zf3VglhyMu1xeEKA93zW68lR3JAKbgliw8dX79trmWBf/nR0zfAArfhTga827ciE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713981459; c=relaxed/simple;
	bh=AbpQ6ac5gCGcv4jIbn0lkX2wvKzhocFgo1B53jkt0Js=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qgzJIic7zh/85H3uUt+6GHtMBmx7lnh9Cs2FXnPPuNvN9mJKMA7VA7CMkOqoF7XQTdgTOnUftm5iv87X+9gpNDTdg3jmZmLIQ6kWuuOm/BlWu6q+I2pRMYJQDoAQAuiXHKR9WB38wHZ7aDUSRIgPJ+vSp8jekDdc8GgzW+CdsC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bjx9UMH2; arc=none smtp.client-ip=192.19.144.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id CD44AC00498D;
	Wed, 24 Apr 2024 10:57:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com CD44AC00498D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1713981455;
	bh=AbpQ6ac5gCGcv4jIbn0lkX2wvKzhocFgo1B53jkt0Js=;
	h=From:To:Cc:Subject:Date:From;
	b=bjx9UMH2pQaATU4j8GayhhrOxm/n8zAzh70UWVcibyUaFDLqXjZ+cBWN99PVBcuiw
	 Ap+NHVHmxPruuED8jRgFuEUCVU/727oVLy4tz2ggeMe9X9cJULEBh+2Ee5qzGNCPco
	 fhkhKikh3xi9rggpaKxRt6A542+ORH2bMyp0uA+Q=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id E2F5D18041CAC4;
	Wed, 24 Apr 2024 10:57:33 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Tim Ross <tim.ross@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-mips@vger.kernel.org (open list:BROADCOM BMIPS MIPS ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE)
Subject: [PATCH v2] irqchip/irq-brcmstb-l2: Avoid saving mask on shutdown
Date: Wed, 24 Apr 2024 10:57:32 -0700
Message-Id: <20240424175732.1526531-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The interrupt controller shutdown path does not need to save the mask of
enabled interrupts because the next state the system is going to be in
is akin to a cold boot, or a kexec'd kernel. Saving the mask only makes
sense if the software state needs to preserve the hardware state across
a system suspend/resume cycle.

As an optimization, and given that there are systems with dozens of such
interrupt controller, we can save a "slow" memory mapped I/O read in the
shutdown path where no saving/restoring is required.

Reported-by: Tim Ross <tim.ross@broadcom.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---

Changes in v2:

- expand the commit message to explain this is an optimiation saving a
  slow MMIO read

 drivers/irqchip/irq-brcmstb-l2.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index 2b0b3175cea0..c988886917f7 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -118,7 +118,7 @@ static void brcmstb_l2_intc_irq_handle(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static void brcmstb_l2_intc_suspend(struct irq_data *d)
+static void __brcmstb_l2_intc_suspend(struct irq_data *d, bool save)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
@@ -127,7 +127,8 @@ static void brcmstb_l2_intc_suspend(struct irq_data *d)
 
 	irq_gc_lock_irqsave(gc, flags);
 	/* Save the current mask */
-	b->saved_mask = irq_reg_readl(gc, ct->regs.mask);
+	if (save)
+		b->saved_mask = irq_reg_readl(gc, ct->regs.mask);
 
 	if (b->can_wake) {
 		/* Program the wakeup mask */
@@ -137,6 +138,16 @@ static void brcmstb_l2_intc_suspend(struct irq_data *d)
 	irq_gc_unlock_irqrestore(gc, flags);
 }
 
+static void brcmstb_l2_intc_shutdown(struct irq_data *d)
+{
+	__brcmstb_l2_intc_suspend(d, false);
+}
+
+static void brcmstb_l2_intc_suspend(struct irq_data *d)
+{
+	__brcmstb_l2_intc_suspend(d, true);
+}
+
 static void brcmstb_l2_intc_resume(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
@@ -252,7 +263,7 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
 
 	ct->chip.irq_suspend = brcmstb_l2_intc_suspend;
 	ct->chip.irq_resume = brcmstb_l2_intc_resume;
-	ct->chip.irq_pm_shutdown = brcmstb_l2_intc_suspend;
+	ct->chip.irq_pm_shutdown = brcmstb_l2_intc_shutdown;
 
 	if (data->can_wake) {
 		/* This IRQ chip can wake the system, set all child interrupts
-- 
2.34.1


