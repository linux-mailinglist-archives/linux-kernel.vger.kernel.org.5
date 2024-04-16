Return-Path: <linux-kernel+bounces-147484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD158A7518
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5791EB217DF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064D513956B;
	Tue, 16 Apr 2024 19:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MIPC4Cde"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC361386A8;
	Tue, 16 Apr 2024 19:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713296961; cv=none; b=nBnEy6Dxvp3/+U2XNMvCGnHcaxZwvKIIZ2/+968yYXTGzpt5RxLpJc/vzqK8/KxVXtNtUnBPm6QoRrXmZruA06aDyNWIBuYXxVKPmnfhJ8A4jCyjLBtbON1+6tzq6iB4IStQw+L9SDvaXY/S+hLM42oQLDpcSMyB8ZlF4n1bF3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713296961; c=relaxed/simple;
	bh=9lZXQQb2otPcrvmQIRJEDc1staJ0Dw4ScCLzO4hLTAw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qmgBEb+bMMfOi19DFRMDBqYgHnVnVu0TOws27cdv7ZOxjwsgBdB3t+ZmlONWU/SajXYPc33lL54yqA7H5P0nrNoqXiVnph+YmpXltHau8p//40RwCL4ZhUCRBBYYkfbj4tPo4GaIx54n5Sr51P/nUHO4opUNwW1wWa8CViEFcOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MIPC4Cde; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id BC5CBC0000F3;
	Tue, 16 Apr 2024 12:43:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com BC5CBC0000F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1713296631;
	bh=9lZXQQb2otPcrvmQIRJEDc1staJ0Dw4ScCLzO4hLTAw=;
	h=From:To:Cc:Subject:Date:From;
	b=MIPC4Cdeho+xCKH8H/m1aVuXOX5OIg0PcZVQq44xwUMWCbiGRcMmKroyi49tdAbDN
	 m1gUsoa7pAta2ZyE5vG7CfFcwxhb3nH52YMexj5PtCrYGOZgFZUsZut9zg2p3qFcZG
	 ptnpw1FK/Zskg7wKq6teGEj3CsM0UuoSy9qCQjnc=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id DD7A318041CAC4;
	Tue, 16 Apr 2024 12:43:49 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: opendmb@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Tim Ross <tim.ross@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-mips@vger.kernel.org (open list:BROADCOM BMIPS MIPS ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE)
Subject: [PATCH] irqchip/irq-brcmstb-l2: Avoid saving mask on shutdown
Date: Tue, 16 Apr 2024 12:43:42 -0700
Message-Id: <20240416194343.469318-1-florian.fainelli@broadcom.com>
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
is akin to a cold boot, or a kexec'd kernel.

Reported-by: Tim Ross <tim.ross@broadcom.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
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


