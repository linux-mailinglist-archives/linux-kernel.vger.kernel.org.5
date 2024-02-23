Return-Path: <linux-kernel+bounces-79038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5670A861CAF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A38E1C21B2E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B4E14938B;
	Fri, 23 Feb 2024 19:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLkiBjBm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2AD145352;
	Fri, 23 Feb 2024 19:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708717025; cv=none; b=p3cb+Uqdzr4Ww+S1+6FrtB2dDZ9/pGmjQNr907JK69smsc/wD8/RYEgLziqLV735eLheSRmVO6R/gngCRwCiIOtuLWtJMkR9RUqhXqRyjLQir00LmdTXFNLc9uCLGlR84wUfCjp7BX7VU5fjtupY0QKYIaGaorGeBOFv2f/d37I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708717025; c=relaxed/simple;
	bh=aBXH6eHAeemUY+2GjxoEzpq9SPbIFngM8x9dUDRKN8Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rcmjAH7u3ddlFKFhjAzeh814oz1LyMT09OORoaduWNMLZhtB2e+BF/SdiduZyNAbAFKVZxMxowmDLOSpMCV0EpQ0wtPBUvBOgSdGltCJuzlSWGl9DhWnrqpfLcw5moU+k2NNK+ilvwV2BysU/I35STN7X2BWcdlYdxBThsuRChk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLkiBjBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22D8BC433A6;
	Fri, 23 Feb 2024 19:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708717025;
	bh=aBXH6eHAeemUY+2GjxoEzpq9SPbIFngM8x9dUDRKN8Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oLkiBjBmO51vEqSQnqroAmDKo1os6qINGe+cdVwTGPwi3wVtTQW3Al1Sq7XKLwX1t
	 rAVD2HH6ApCrIFmjFdW6n8Xsv0bqFdBOPXxK1jpSgaMK+lBU/Tl3yEj+uh+kHieTWE
	 KhwTgLhNV3Lg6IVWQhkJnIr3DMp/nZmG+FU16FcxZJs6U9V/x+MmQ9aLgFzhIleLZ5
	 hurDQxz9qWCZxsHIMoLKcsHUm9AOtDLei/ybBvNJQW3ti/5lltpX3YY9/DZCaYJFNc
	 yF8GcJtVhpzk/MGaczS1PhGLFunI3k3vy+LvQC2nBe7/9KbmOnVNenyZ0LHzjacnob
	 02eLEe38A66pA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114D5C54798;
	Fri, 23 Feb 2024 19:37:05 +0000 (UTC)
From: Sam Ravnborg via B4 Relay <devnull+sam.ravnborg.org@kernel.org>
Date: Fri, 23 Feb 2024 20:36:52 +0100
Subject: [PATCH 6/6] sparc32: Fix parport build with sparc32
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id:
 <20240223-sam-fix-sparc32-all-builds-v1-6-5c60fd5c9250@ravnborg.org>
References:
 <20240223-sam-fix-sparc32-all-builds-v1-0-5c60fd5c9250@ravnborg.org>
In-Reply-To:
 <20240223-sam-fix-sparc32-all-builds-v1-0-5c60fd5c9250@ravnborg.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: sparclinux@vger.kernel.org, linux-parport@lists.infradead.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Randy Dunlap <rdunlap@infradead.org>, 
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 Sam Ravnborg <sam@ravnborg.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708717023; l=14433;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=oZ0rejxcMTa2joV1C1od/thuO4r9k+TAXb9nS1wKQd4=; =?utf-8?q?b=3D7vEYqNiBTKxh?=
 =?utf-8?q?2kQAwVzrtGTqDdIx14R6uAPlxCNn3ptSt16UpexblzLBwYp9vWes/W2ZT/n178UC?=
 lE+FsQmSD6Er4hxo7pk14VWl3ewNH4EYEKy/ANliOQ5XtJveWqmw
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


