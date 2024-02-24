Return-Path: <linux-kernel+bounces-79769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A554D862673
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 18:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0871F21BD9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1367F4E1CE;
	Sat, 24 Feb 2024 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qj0iyEGU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8829D481DA;
	Sat, 24 Feb 2024 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708796547; cv=none; b=E3ljo+888i+WbvC9lTnq8nlODlhDcSNsGEn+eP2nsmeD/sBTg3ISwjkI/mgp2TU8o5H2aPIQ3dJ9j1OFT8lXLAmsLNsKDC7VXA9nsEcPrkLROYeI9HOr88yrX0jDAtgD7nPCFN14box+eiNiiElWqCSCKCH6zJchEL34CsE5M6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708796547; c=relaxed/simple;
	bh=aBXH6eHAeemUY+2GjxoEzpq9SPbIFngM8x9dUDRKN8Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d192M1HScBMalaW0dU22B6GoXPbgfTvHSCtZcqPYc8nOx7E7x3/qog02YlBz+617e6bkUAPUfZzJjtUsKD0KgGvEvAg7dHWpkZIKu7qdr/4uet3qdExe6JMlFQIOdKe28xb168RbFAbPm8VvcUBGCBy7cD/0E54ZV7Wx4K4qLaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qj0iyEGU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34D6EC433A6;
	Sat, 24 Feb 2024 17:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708796547;
	bh=aBXH6eHAeemUY+2GjxoEzpq9SPbIFngM8x9dUDRKN8Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Qj0iyEGUTD87Q6hv0J4ltINyVNg+3dcxeIIjTkq/NNXDTGp3UJl3cFpoeb9/Moc9T
	 gl63mLcXK5kolDSy8AmOoXJ9z1dahYRH/MaNhnjwcAyTy16wrB5D/CTeQNWASD+Ttq
	 RhOU48f87j2/hh19WTNytWHNU42SIY5a/LvaamvBuquT0aDvCqgOvvxYNEvhvQr727
	 HLTT+zceQ3MgEuNTPLZEsou+J63ZDQHCwssxPEtqL3EOm5iYIMZJWYEfSOikmsQ3hU
	 UkYAuztwffuSCv0RWkqTWPi6/DFWZ0ldG8byTc6VUOkl3y/0amd1SLqwIRZxaZrYNH
	 SWfjjCpMPgK4Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2428EC54E49;
	Sat, 24 Feb 2024 17:42:27 +0000 (UTC)
From: Sam Ravnborg via B4 Relay <devnull+sam.ravnborg.org@kernel.org>
Date: Sat, 24 Feb 2024 18:42:27 +0100
Subject: [PATCH v2 6/7] sparc32: Fix parport build with sparc32
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id:
 <20240224-sam-fix-sparc32-all-builds-v2-6-1f186603c5c4@ravnborg.org>
References:
 <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org>
In-Reply-To:
 <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>, sparclinux@vger.kernel.org, 
 Andreas Larsson <andreas@gaisler.com>, Randy Dunlap <rdunlap@infradead.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 linux-parport@lists.infradead.org, "David S. Miller" <davem@davemloft.net>, 
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 Sam Ravnborg <sam@ravnborg.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708796545; l=14433;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=oZ0rejxcMTa2joV1C1od/thuO4r9k+TAXb9nS1wKQd4=; =?utf-8?q?b=3DcKBrnF7aWGPD?=
 =?utf-8?q?9vHNuDEXKrQyp1pKioyRJlw9lk76hTdVqYhZ0kEOTq4w/d/ZnlCqXGhef7xfM931?=
 iH9DG/HrDWI0IYkHzo5k5cSODWK2hWXhNuyRkd/lbRLNAWcY7XmO
X-Developer-Key: i=sam@ravnborg.org; a=ed25519;
 pk=R0+pqV7BRYOAeOIGkyOrSNke7arx5y3LkEuNi37YEyU=
X-Endpoint-Received: by B4 Relay for sam@ravnborg.org/20230107 with auth_id=22
X-Original-From: Sam Ravnborg <sam@ravnborg.org>
Reply-To: <sam@ravnborg.org>

From: Sam Ravnborg <sam@ravnborg.org>

include/asm/parport.h is sparc64 specific.
Rename it to parport_64.h and use the generic version for sparc32.

This fixed all{mod,yes}config build errors like:

parport_pc.c:(.text):undefined-reference-to-ebus_dma_enable
parport_pc.c:(.text):undefined-reference-to-ebus_dma_irq_enable
parport_pc.c:(.text):undefined-reference-to-ebus_dma_register

The errors occur as the sparc32 build references sparc64 symbols.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Maciej W. Rozycki <macro@orcam.me.uk>
Closes: https://lore.kernel.org/r/20230406160548.25721-1-rdunlap@infradead.org/
Fixes: 66bcd06099bb ("parport_pc: Also enable driver for PCI systems")
Cc: stable@vger.kernel.org # v5.18+
---
 arch/sparc/include/asm/parport.h    | 259 +-----------------------------------
 arch/sparc/include/asm/parport_64.h | 256 +++++++++++++++++++++++++++++++++++
 2 files changed, 263 insertions(+), 252 deletions(-)

diff --git a/arch/sparc/include/asm/parport.h b/arch/sparc/include/asm/parport.h
index 0a7ffcfd59cd..e2eed8f97665 100644
--- a/arch/sparc/include/asm/parport.h
+++ b/arch/sparc/include/asm/parport.h
@@ -1,256 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* parport.h: sparc64 specific parport initialization and dma.
- *
- * Copyright (C) 1999  Eddie C. Dost  (ecd@skynet.be)
- */
+#ifndef ___ASM_SPARC_PARPORT_H
+#define ___ASM_SPARC_PARPORT_H
 
-#ifndef _ASM_SPARC64_PARPORT_H
-#define _ASM_SPARC64_PARPORT_H 1
-
-#include <linux/of.h>
-#include <linux/platform_device.h>
-
-#include <asm/ebus_dma.h>
-#include <asm/ns87303.h>
-#include <asm/prom.h>
-
-#define PARPORT_PC_MAX_PORTS	PARPORT_MAX
-
-/*
- * While sparc64 doesn't have an ISA DMA API, we provide something that looks
- * close enough to make parport_pc happy
- */
-#define HAS_DMA
-
-#ifdef CONFIG_PARPORT_PC_FIFO
-static DEFINE_SPINLOCK(dma_spin_lock);
-
-#define claim_dma_lock() \
-({	unsigned long flags; \
-	spin_lock_irqsave(&dma_spin_lock, flags); \
-	flags; \
-})
-
-#define release_dma_lock(__flags) \
-	spin_unlock_irqrestore(&dma_spin_lock, __flags);
+#if defined(__sparc__) && defined(__arch64__)
+#include <asm/parport_64.h>
+#else
+#include <asm-generic/parport.h>
+#endif
 #endif
 
-static struct sparc_ebus_info {
-	struct ebus_dma_info info;
-	unsigned int addr;
-	unsigned int count;
-	int lock;
-
-	struct parport *port;
-} sparc_ebus_dmas[PARPORT_PC_MAX_PORTS];
-
-static DECLARE_BITMAP(dma_slot_map, PARPORT_PC_MAX_PORTS);
-
-static inline int request_dma(unsigned int dmanr, const char *device_id)
-{
-	if (dmanr >= PARPORT_PC_MAX_PORTS)
-		return -EINVAL;
-	if (xchg(&sparc_ebus_dmas[dmanr].lock, 1) != 0)
-		return -EBUSY;
-	return 0;
-}
-
-static inline void free_dma(unsigned int dmanr)
-{
-	if (dmanr >= PARPORT_PC_MAX_PORTS) {
-		printk(KERN_WARNING "Trying to free DMA%d\n", dmanr);
-		return;
-	}
-	if (xchg(&sparc_ebus_dmas[dmanr].lock, 0) == 0) {
-		printk(KERN_WARNING "Trying to free free DMA%d\n", dmanr);
-		return;
-	}
-}
-
-static inline void enable_dma(unsigned int dmanr)
-{
-	ebus_dma_enable(&sparc_ebus_dmas[dmanr].info, 1);
-
-	if (ebus_dma_request(&sparc_ebus_dmas[dmanr].info,
-			     sparc_ebus_dmas[dmanr].addr,
-			     sparc_ebus_dmas[dmanr].count))
-		BUG();
-}
-
-static inline void disable_dma(unsigned int dmanr)
-{
-	ebus_dma_enable(&sparc_ebus_dmas[dmanr].info, 0);
-}
-
-static inline void clear_dma_ff(unsigned int dmanr)
-{
-	/* nothing */
-}
-
-static inline void set_dma_mode(unsigned int dmanr, char mode)
-{
-	ebus_dma_prepare(&sparc_ebus_dmas[dmanr].info, (mode != DMA_MODE_WRITE));
-}
-
-static inline void set_dma_addr(unsigned int dmanr, unsigned int addr)
-{
-	sparc_ebus_dmas[dmanr].addr = addr;
-}
-
-static inline void set_dma_count(unsigned int dmanr, unsigned int count)
-{
-	sparc_ebus_dmas[dmanr].count = count;
-}
-
-static inline unsigned int get_dma_residue(unsigned int dmanr)
-{
-	return ebus_dma_residue(&sparc_ebus_dmas[dmanr].info);
-}
-
-static int ecpp_probe(struct platform_device *op)
-{
-	unsigned long base = op->resource[0].start;
-	unsigned long config = op->resource[1].start;
-	unsigned long d_base = op->resource[2].start;
-	unsigned long d_len;
-	struct device_node *parent;
-	struct parport *p;
-	int slot, err;
-
-	parent = op->dev.of_node->parent;
-	if (of_node_name_eq(parent, "dma")) {
-		p = parport_pc_probe_port(base, base + 0x400,
-					  op->archdata.irqs[0], PARPORT_DMA_NOFIFO,
-					  op->dev.parent->parent, 0);
-		if (!p)
-			return -ENOMEM;
-		dev_set_drvdata(&op->dev, p);
-		return 0;
-	}
-
-	for (slot = 0; slot < PARPORT_PC_MAX_PORTS; slot++) {
-		if (!test_and_set_bit(slot, dma_slot_map))
-			break;
-	}
-	err = -ENODEV;
-	if (slot >= PARPORT_PC_MAX_PORTS)
-		goto out_err;
-
-	spin_lock_init(&sparc_ebus_dmas[slot].info.lock);
-
-	d_len = (op->resource[2].end - d_base) + 1UL;
-	sparc_ebus_dmas[slot].info.regs =
-		of_ioremap(&op->resource[2], 0, d_len, "ECPP DMA");
-
-	if (!sparc_ebus_dmas[slot].info.regs)
-		goto out_clear_map;
-
-	sparc_ebus_dmas[slot].info.flags = 0;
-	sparc_ebus_dmas[slot].info.callback = NULL;
-	sparc_ebus_dmas[slot].info.client_cookie = NULL;
-	sparc_ebus_dmas[slot].info.irq = 0xdeadbeef;
-	strcpy(sparc_ebus_dmas[slot].info.name, "parport");
-	if (ebus_dma_register(&sparc_ebus_dmas[slot].info))
-		goto out_unmap_regs;
-
-	ebus_dma_irq_enable(&sparc_ebus_dmas[slot].info, 1);
-
-	/* Configure IRQ to Push Pull, Level Low */
-	/* Enable ECP, set bit 2 of the CTR first */
-	outb(0x04, base + 0x02);
-	ns87303_modify(config, PCR,
-		       PCR_EPP_ENABLE |
-		       PCR_IRQ_ODRAIN,
-		       PCR_ECP_ENABLE |
-		       PCR_ECP_CLK_ENA |
-		       PCR_IRQ_POLAR);
-
-	/* CTR bit 5 controls direction of port */
-	ns87303_modify(config, PTR,
-		       0, PTR_LPT_REG_DIR);
-
-	p = parport_pc_probe_port(base, base + 0x400,
-				  op->archdata.irqs[0],
-				  slot,
-				  op->dev.parent,
-				  0);
-	err = -ENOMEM;
-	if (!p)
-		goto out_disable_irq;
-
-	dev_set_drvdata(&op->dev, p);
-
-	return 0;
-
-out_disable_irq:
-	ebus_dma_irq_enable(&sparc_ebus_dmas[slot].info, 0);
-	ebus_dma_unregister(&sparc_ebus_dmas[slot].info);
-
-out_unmap_regs:
-	of_iounmap(&op->resource[2], sparc_ebus_dmas[slot].info.regs, d_len);
-
-out_clear_map:
-	clear_bit(slot, dma_slot_map);
-
-out_err:
-	return err;
-}
-
-static int ecpp_remove(struct platform_device *op)
-{
-	struct parport *p = dev_get_drvdata(&op->dev);
-	int slot = p->dma;
-
-	parport_pc_unregister_port(p);
-
-	if (slot != PARPORT_DMA_NOFIFO) {
-		unsigned long d_base = op->resource[2].start;
-		unsigned long d_len;
-
-		d_len = (op->resource[2].end - d_base) + 1UL;
-
-		ebus_dma_irq_enable(&sparc_ebus_dmas[slot].info, 0);
-		ebus_dma_unregister(&sparc_ebus_dmas[slot].info);
-		of_iounmap(&op->resource[2],
-			   sparc_ebus_dmas[slot].info.regs,
-			   d_len);
-		clear_bit(slot, dma_slot_map);
-	}
-
-	return 0;
-}
-
-static const struct of_device_id ecpp_match[] = {
-	{
-		.name = "ecpp",
-	},
-	{
-		.name = "parallel",
-		.compatible = "ecpp",
-	},
-	{
-		.name = "parallel",
-		.compatible = "ns87317-ecpp",
-	},
-	{
-		.name = "parallel",
-		.compatible = "pnpALI,1533,3",
-	},
-	{},
-};
-
-static struct platform_driver ecpp_driver = {
-	.driver = {
-		.name = "ecpp",
-		.of_match_table = ecpp_match,
-	},
-	.probe			= ecpp_probe,
-	.remove			= ecpp_remove,
-};
-
-static int parport_pc_find_nonpci_ports(int autoirq, int autodma)
-{
-	return platform_driver_register(&ecpp_driver);
-}
-
-#endif /* !(_ASM_SPARC64_PARPORT_H */
diff --git a/arch/sparc/include/asm/parport_64.h b/arch/sparc/include/asm/parport_64.h
new file mode 100644
index 000000000000..0a7ffcfd59cd
--- /dev/null
+++ b/arch/sparc/include/asm/parport_64.h
@@ -0,0 +1,256 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* parport.h: sparc64 specific parport initialization and dma.
+ *
+ * Copyright (C) 1999  Eddie C. Dost  (ecd@skynet.be)
+ */
+
+#ifndef _ASM_SPARC64_PARPORT_H
+#define _ASM_SPARC64_PARPORT_H 1
+
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include <asm/ebus_dma.h>
+#include <asm/ns87303.h>
+#include <asm/prom.h>
+
+#define PARPORT_PC_MAX_PORTS	PARPORT_MAX
+
+/*
+ * While sparc64 doesn't have an ISA DMA API, we provide something that looks
+ * close enough to make parport_pc happy
+ */
+#define HAS_DMA
+
+#ifdef CONFIG_PARPORT_PC_FIFO
+static DEFINE_SPINLOCK(dma_spin_lock);
+
+#define claim_dma_lock() \
+({	unsigned long flags; \
+	spin_lock_irqsave(&dma_spin_lock, flags); \
+	flags; \
+})
+
+#define release_dma_lock(__flags) \
+	spin_unlock_irqrestore(&dma_spin_lock, __flags);
+#endif
+
+static struct sparc_ebus_info {
+	struct ebus_dma_info info;
+	unsigned int addr;
+	unsigned int count;
+	int lock;
+
+	struct parport *port;
+} sparc_ebus_dmas[PARPORT_PC_MAX_PORTS];
+
+static DECLARE_BITMAP(dma_slot_map, PARPORT_PC_MAX_PORTS);
+
+static inline int request_dma(unsigned int dmanr, const char *device_id)
+{
+	if (dmanr >= PARPORT_PC_MAX_PORTS)
+		return -EINVAL;
+	if (xchg(&sparc_ebus_dmas[dmanr].lock, 1) != 0)
+		return -EBUSY;
+	return 0;
+}
+
+static inline void free_dma(unsigned int dmanr)
+{
+	if (dmanr >= PARPORT_PC_MAX_PORTS) {
+		printk(KERN_WARNING "Trying to free DMA%d\n", dmanr);
+		return;
+	}
+	if (xchg(&sparc_ebus_dmas[dmanr].lock, 0) == 0) {
+		printk(KERN_WARNING "Trying to free free DMA%d\n", dmanr);
+		return;
+	}
+}
+
+static inline void enable_dma(unsigned int dmanr)
+{
+	ebus_dma_enable(&sparc_ebus_dmas[dmanr].info, 1);
+
+	if (ebus_dma_request(&sparc_ebus_dmas[dmanr].info,
+			     sparc_ebus_dmas[dmanr].addr,
+			     sparc_ebus_dmas[dmanr].count))
+		BUG();
+}
+
+static inline void disable_dma(unsigned int dmanr)
+{
+	ebus_dma_enable(&sparc_ebus_dmas[dmanr].info, 0);
+}
+
+static inline void clear_dma_ff(unsigned int dmanr)
+{
+	/* nothing */
+}
+
+static inline void set_dma_mode(unsigned int dmanr, char mode)
+{
+	ebus_dma_prepare(&sparc_ebus_dmas[dmanr].info, (mode != DMA_MODE_WRITE));
+}
+
+static inline void set_dma_addr(unsigned int dmanr, unsigned int addr)
+{
+	sparc_ebus_dmas[dmanr].addr = addr;
+}
+
+static inline void set_dma_count(unsigned int dmanr, unsigned int count)
+{
+	sparc_ebus_dmas[dmanr].count = count;
+}
+
+static inline unsigned int get_dma_residue(unsigned int dmanr)
+{
+	return ebus_dma_residue(&sparc_ebus_dmas[dmanr].info);
+}
+
+static int ecpp_probe(struct platform_device *op)
+{
+	unsigned long base = op->resource[0].start;
+	unsigned long config = op->resource[1].start;
+	unsigned long d_base = op->resource[2].start;
+	unsigned long d_len;
+	struct device_node *parent;
+	struct parport *p;
+	int slot, err;
+
+	parent = op->dev.of_node->parent;
+	if (of_node_name_eq(parent, "dma")) {
+		p = parport_pc_probe_port(base, base + 0x400,
+					  op->archdata.irqs[0], PARPORT_DMA_NOFIFO,
+					  op->dev.parent->parent, 0);
+		if (!p)
+			return -ENOMEM;
+		dev_set_drvdata(&op->dev, p);
+		return 0;
+	}
+
+	for (slot = 0; slot < PARPORT_PC_MAX_PORTS; slot++) {
+		if (!test_and_set_bit(slot, dma_slot_map))
+			break;
+	}
+	err = -ENODEV;
+	if (slot >= PARPORT_PC_MAX_PORTS)
+		goto out_err;
+
+	spin_lock_init(&sparc_ebus_dmas[slot].info.lock);
+
+	d_len = (op->resource[2].end - d_base) + 1UL;
+	sparc_ebus_dmas[slot].info.regs =
+		of_ioremap(&op->resource[2], 0, d_len, "ECPP DMA");
+
+	if (!sparc_ebus_dmas[slot].info.regs)
+		goto out_clear_map;
+
+	sparc_ebus_dmas[slot].info.flags = 0;
+	sparc_ebus_dmas[slot].info.callback = NULL;
+	sparc_ebus_dmas[slot].info.client_cookie = NULL;
+	sparc_ebus_dmas[slot].info.irq = 0xdeadbeef;
+	strcpy(sparc_ebus_dmas[slot].info.name, "parport");
+	if (ebus_dma_register(&sparc_ebus_dmas[slot].info))
+		goto out_unmap_regs;
+
+	ebus_dma_irq_enable(&sparc_ebus_dmas[slot].info, 1);
+
+	/* Configure IRQ to Push Pull, Level Low */
+	/* Enable ECP, set bit 2 of the CTR first */
+	outb(0x04, base + 0x02);
+	ns87303_modify(config, PCR,
+		       PCR_EPP_ENABLE |
+		       PCR_IRQ_ODRAIN,
+		       PCR_ECP_ENABLE |
+		       PCR_ECP_CLK_ENA |
+		       PCR_IRQ_POLAR);
+
+	/* CTR bit 5 controls direction of port */
+	ns87303_modify(config, PTR,
+		       0, PTR_LPT_REG_DIR);
+
+	p = parport_pc_probe_port(base, base + 0x400,
+				  op->archdata.irqs[0],
+				  slot,
+				  op->dev.parent,
+				  0);
+	err = -ENOMEM;
+	if (!p)
+		goto out_disable_irq;
+
+	dev_set_drvdata(&op->dev, p);
+
+	return 0;
+
+out_disable_irq:
+	ebus_dma_irq_enable(&sparc_ebus_dmas[slot].info, 0);
+	ebus_dma_unregister(&sparc_ebus_dmas[slot].info);
+
+out_unmap_regs:
+	of_iounmap(&op->resource[2], sparc_ebus_dmas[slot].info.regs, d_len);
+
+out_clear_map:
+	clear_bit(slot, dma_slot_map);
+
+out_err:
+	return err;
+}
+
+static int ecpp_remove(struct platform_device *op)
+{
+	struct parport *p = dev_get_drvdata(&op->dev);
+	int slot = p->dma;
+
+	parport_pc_unregister_port(p);
+
+	if (slot != PARPORT_DMA_NOFIFO) {
+		unsigned long d_base = op->resource[2].start;
+		unsigned long d_len;
+
+		d_len = (op->resource[2].end - d_base) + 1UL;
+
+		ebus_dma_irq_enable(&sparc_ebus_dmas[slot].info, 0);
+		ebus_dma_unregister(&sparc_ebus_dmas[slot].info);
+		of_iounmap(&op->resource[2],
+			   sparc_ebus_dmas[slot].info.regs,
+			   d_len);
+		clear_bit(slot, dma_slot_map);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id ecpp_match[] = {
+	{
+		.name = "ecpp",
+	},
+	{
+		.name = "parallel",
+		.compatible = "ecpp",
+	},
+	{
+		.name = "parallel",
+		.compatible = "ns87317-ecpp",
+	},
+	{
+		.name = "parallel",
+		.compatible = "pnpALI,1533,3",
+	},
+	{},
+};
+
+static struct platform_driver ecpp_driver = {
+	.driver = {
+		.name = "ecpp",
+		.of_match_table = ecpp_match,
+	},
+	.probe			= ecpp_probe,
+	.remove			= ecpp_remove,
+};
+
+static int parport_pc_find_nonpci_ports(int autoirq, int autodma)
+{
+	return platform_driver_register(&ecpp_driver);
+}
+
+#endif /* !(_ASM_SPARC64_PARPORT_H */

-- 
2.34.1


