Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2651076EC5E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236654AbjHCOWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236643AbjHCOVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:21:49 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396B73ABE;
        Thu,  3 Aug 2023 07:21:26 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RGr4s4mwJz9t57;
        Thu,  3 Aug 2023 15:57:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CZiBhBspuz9s; Thu,  3 Aug 2023 15:57:17 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RGr4m0Tfxz9t4f;
        Thu,  3 Aug 2023 15:57:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0C66F8B763;
        Thu,  3 Aug 2023 15:57:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ZEwKmc-3qekQ; Thu,  3 Aug 2023 15:57:11 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.144])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 59B6D8B776;
        Thu,  3 Aug 2023 15:57:11 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 373Dv3b6494193
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 3 Aug 2023 15:57:03 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 373Dv3OP494192;
        Thu, 3 Aug 2023 15:57:03 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Timur Tabi <timur@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-serial@vger.kernel.org
Subject: [PATCH v1 07/12] serial: cpm_uart: Refactor cpm_uart_allocbuf()/cpm_uart_freebuf()
Date:   Thu,  3 Aug 2023 15:56:48 +0200
Message-ID: <606dfdd258a4f2f2882e2e189bef37526bb3b499.1691068700.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691068700.git.christophe.leroy@csgroup.eu>
References: <cover.1691068700.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691071001; l=10344; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=fmng3Yf13DSccy9K/kGH8+3XHyPP4k1wDxdkiZ3ooIc=; b=evVODVaZYCr7v2sQu1GSMFW4wvKfaKvuYWagIcYq3jPk100Nlz8BTMH9CH15gjJqGHwzdchiP FKwkHAh7WiLDGVcCINH4WS+tg7HufZCFs22qhaxGjsojSIKbZXcrGzg
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpm_uart_freebuf() is identical for CPM1 and CPM2.

cpm_uart_allocbuf() only has a small difference between CPM1 and CPM2
as shown below:

CPM1:
	if (is_con) {
		/* was hostalloc but changed cause it blows away the */
		/* large tlb mapping when pinning the kernel area    */
		mem_addr = (u8 *) cpm_dpram_addr(cpm_dpalloc(memsz, 8));
		dma_addr = (u32)cpm_dpram_phys(mem_addr);
	} else
		mem_addr = dma_alloc_coherent(pinfo->port.dev, memsz, &dma_addr,
					      GFP_KERNEL);

CPM2:

	if (is_con) {
		mem_addr = kzalloc(memsz, GFP_NOWAIT);
		dma_addr = virt_to_bus(mem_addr);
	}
	else
		mem_addr = dma_alloc_coherent(pinfo->port.dev, memsz, &dma_addr,
					      GFP_KERNEL);

Refactor this by using IS_ENABLED(CONFIG_CPM1)
and move both functions in cpm_uart_core.c as they are used only there.

While doing this, add the necessary casts to silence sparse for the CPM1
part. This is because a dma alloc is not expected to be an iomem but
for CPM1 as we use DPRAM this is seen as iomem.

Also replace calls to cpm_dpxxxx() by relevant cpm_muram_xxxx() calls.
This is needed at least for cpm_dpram_phys() which is only defined
for CPM1. Just do the same for all so that cpm_dpxxxx() macros can get
droped in the future.

To silence checkpatch, replace printk(KERN_ERR by pr_err( and display
function name instead of hard coded filename. Also replace
mem_addr == NULL by !mem_addr.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/tty/serial/cpm_uart/cpm_uart.h      |  2 -
 drivers/tty/serial/cpm_uart/cpm_uart_core.c | 72 +++++++++++++++++++++
 drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c | 69 --------------------
 drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c | 69 --------------------
 4 files changed, 72 insertions(+), 140 deletions(-)

diff --git a/drivers/tty/serial/cpm_uart/cpm_uart.h b/drivers/tty/serial/cpm_uart/cpm_uart.h
index 1b5523474ab4..6d6046d45bec 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart.h
+++ b/drivers/tty/serial/cpm_uart/cpm_uart.h
@@ -79,8 +79,6 @@ struct uart_cpm_port {
 void __iomem *cpm_uart_map_pram(struct uart_cpm_port *port,
 				struct device_node *np);
 void cpm_uart_unmap_pram(struct uart_cpm_port *port, void __iomem *pram);
-int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int is_con);
-void cpm_uart_freebuf(struct uart_cpm_port *pinfo);
 
 /*
    virtual to phys transtalion
diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index e6f3e4da3144..fa5466518536 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -868,6 +868,78 @@ static void cpm_uart_init_smc(struct uart_cpm_port *pinfo)
 	setbits16(&sp->smc_smcmr, SMCMR_REN | SMCMR_TEN);
 }
 
+/*
+ * Allocate DP-Ram and memory buffers. We need to allocate a transmit and
+ * receive buffer descriptors from dual port ram, and a character
+ * buffer area from host mem. If we are allocating for the console we need
+ * to do it from bootmem
+ */
+static int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int is_con)
+{
+	int dpmemsz, memsz;
+	u8 __iomem *dp_mem;
+	unsigned long dp_offset;
+	u8 *mem_addr;
+	dma_addr_t dma_addr = 0;
+
+	pr_debug("CPM uart[%d]:allocbuf\n", pinfo->port.line);
+
+	dpmemsz = sizeof(cbd_t) * (pinfo->rx_nrfifos + pinfo->tx_nrfifos);
+	dp_offset = cpm_muram_alloc(dpmemsz, 8);
+	if (IS_ERR_VALUE(dp_offset)) {
+		pr_err("%s: could not allocate buffer descriptors\n", __func__);
+		return -ENOMEM;
+	}
+
+	dp_mem = cpm_muram_addr(dp_offset);
+
+	memsz = L1_CACHE_ALIGN(pinfo->rx_nrfifos * pinfo->rx_fifosize) +
+	    L1_CACHE_ALIGN(pinfo->tx_nrfifos * pinfo->tx_fifosize);
+	if (IS_ENABLED(CONFIG_CPM1) && is_con) {
+		/* was hostalloc but changed cause it blows away the */
+		/* large tlb mapping when pinning the kernel area    */
+		mem_addr = (u8 __force *)cpm_muram_addr(cpm_muram_alloc(memsz, 8));
+		dma_addr = cpm_muram_dma((void __iomem *)mem_addr);
+	} else if (is_con) {
+		mem_addr = kzalloc(memsz, GFP_NOWAIT);
+		dma_addr = virt_to_bus(mem_addr);
+	} else {
+		mem_addr = dma_alloc_coherent(pinfo->port.dev, memsz, &dma_addr,
+					      GFP_KERNEL);
+	}
+
+	if (!mem_addr) {
+		cpm_muram_free(dp_offset);
+		pr_err("%s: could not allocate coherent memory\n", __func__);
+		return -ENOMEM;
+	}
+
+	pinfo->dp_addr = dp_offset;
+	pinfo->mem_addr = mem_addr;
+	pinfo->dma_addr = dma_addr;
+	pinfo->mem_size = memsz;
+
+	pinfo->rx_buf = mem_addr;
+	pinfo->tx_buf = pinfo->rx_buf + L1_CACHE_ALIGN(pinfo->rx_nrfifos
+						       * pinfo->rx_fifosize);
+
+	pinfo->rx_bd_base = (cbd_t __iomem *)dp_mem;
+	pinfo->tx_bd_base = pinfo->rx_bd_base + pinfo->rx_nrfifos;
+
+	return 0;
+}
+
+static void cpm_uart_freebuf(struct uart_cpm_port *pinfo)
+{
+	dma_free_coherent(pinfo->port.dev, L1_CACHE_ALIGN(pinfo->rx_nrfifos *
+							  pinfo->rx_fifosize) +
+			  L1_CACHE_ALIGN(pinfo->tx_nrfifos *
+					 pinfo->tx_fifosize), (void __force *)pinfo->mem_addr,
+			  pinfo->dma_addr);
+
+	cpm_muram_free(pinfo->dp_addr);
+}
+
 /*
  * Initialize port. This is called from early_console stuff
  * so we have to be careful here !
diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c b/drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c
index b5680376ff3c..3fe436dc2f95 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c
@@ -46,72 +46,3 @@ void cpm_uart_unmap_pram(struct uart_cpm_port *port, void __iomem *pram)
 {
 	iounmap(pram);
 }
-
-/*
- * Allocate DP-Ram and memory buffers. We need to allocate a transmit and
- * receive buffer descriptors from dual port ram, and a character
- * buffer area from host mem. If we are allocating for the console we need
- * to do it from bootmem
- */
-int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int is_con)
-{
-	int dpmemsz, memsz;
-	u8 *dp_mem;
-	unsigned long dp_offset;
-	u8 *mem_addr;
-	dma_addr_t dma_addr = 0;
-
-	pr_debug("CPM uart[%d]:allocbuf\n", pinfo->port.line);
-
-	dpmemsz = sizeof(cbd_t) * (pinfo->rx_nrfifos + pinfo->tx_nrfifos);
-	dp_offset = cpm_dpalloc(dpmemsz, 8);
-	if (IS_ERR_VALUE(dp_offset)) {
-		printk(KERN_ERR
-		       "cpm_uart_cpm1.c: could not allocate buffer descriptors\n");
-		return -ENOMEM;
-	}
-	dp_mem = cpm_dpram_addr(dp_offset);
-
-	memsz = L1_CACHE_ALIGN(pinfo->rx_nrfifos * pinfo->rx_fifosize) +
-	    L1_CACHE_ALIGN(pinfo->tx_nrfifos * pinfo->tx_fifosize);
-	if (is_con) {
-		/* was hostalloc but changed cause it blows away the */
-		/* large tlb mapping when pinning the kernel area    */
-		mem_addr = (u8 *) cpm_dpram_addr(cpm_dpalloc(memsz, 8));
-		dma_addr = (u32)cpm_dpram_phys(mem_addr);
-	} else
-		mem_addr = dma_alloc_coherent(pinfo->port.dev, memsz, &dma_addr,
-					      GFP_KERNEL);
-
-	if (mem_addr == NULL) {
-		cpm_dpfree(dp_offset);
-		printk(KERN_ERR
-		       "cpm_uart_cpm1.c: could not allocate coherent memory\n");
-		return -ENOMEM;
-	}
-
-	pinfo->dp_addr = dp_offset;
-	pinfo->mem_addr = mem_addr;             /*  virtual address*/
-	pinfo->dma_addr = dma_addr;             /*  physical address*/
-	pinfo->mem_size = memsz;
-
-	pinfo->rx_buf = mem_addr;
-	pinfo->tx_buf = pinfo->rx_buf + L1_CACHE_ALIGN(pinfo->rx_nrfifos
-						       * pinfo->rx_fifosize);
-
-	pinfo->rx_bd_base = (cbd_t __iomem __force *)dp_mem;
-	pinfo->tx_bd_base = pinfo->rx_bd_base + pinfo->rx_nrfifos;
-
-	return 0;
-}
-
-void cpm_uart_freebuf(struct uart_cpm_port *pinfo)
-{
-	dma_free_coherent(pinfo->port.dev, L1_CACHE_ALIGN(pinfo->rx_nrfifos *
-							  pinfo->rx_fifosize) +
-			  L1_CACHE_ALIGN(pinfo->tx_nrfifos *
-					 pinfo->tx_fifosize), pinfo->mem_addr,
-			  pinfo->dma_addr);
-
-	cpm_dpfree(pinfo->dp_addr);
-}
diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c b/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c
index 35f539fcfde8..09d46255aa9d 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c
@@ -80,72 +80,3 @@ void cpm_uart_unmap_pram(struct uart_cpm_port *port, void __iomem *pram)
 	if (!IS_SMC(port))
 		iounmap(pram);
 }
-
-/*
- * Allocate DP-Ram and memory buffers. We need to allocate a transmit and
- * receive buffer descriptors from dual port ram, and a character
- * buffer area from host mem. If we are allocating for the console we need
- * to do it from bootmem
- */
-int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int is_con)
-{
-	int dpmemsz, memsz;
-	u8 __iomem *dp_mem;
-	unsigned long dp_offset;
-	u8 *mem_addr;
-	dma_addr_t dma_addr = 0;
-
-	pr_debug("CPM uart[%d]:allocbuf\n", pinfo->port.line);
-
-	dpmemsz = sizeof(cbd_t) * (pinfo->rx_nrfifos + pinfo->tx_nrfifos);
-	dp_offset = cpm_dpalloc(dpmemsz, 8);
-	if (IS_ERR_VALUE(dp_offset)) {
-		printk(KERN_ERR
-		       "cpm_uart_cpm.c: could not allocate buffer descriptors\n");
-		return -ENOMEM;
-	}
-
-	dp_mem = cpm_dpram_addr(dp_offset);
-
-	memsz = L1_CACHE_ALIGN(pinfo->rx_nrfifos * pinfo->rx_fifosize) +
-	    L1_CACHE_ALIGN(pinfo->tx_nrfifos * pinfo->tx_fifosize);
-	if (is_con) {
-		mem_addr = kzalloc(memsz, GFP_NOWAIT);
-		dma_addr = virt_to_bus(mem_addr);
-	}
-	else
-		mem_addr = dma_alloc_coherent(pinfo->port.dev, memsz, &dma_addr,
-					      GFP_KERNEL);
-
-	if (mem_addr == NULL) {
-		cpm_dpfree(dp_offset);
-		printk(KERN_ERR
-		       "cpm_uart_cpm.c: could not allocate coherent memory\n");
-		return -ENOMEM;
-	}
-
-	pinfo->dp_addr = dp_offset;
-	pinfo->mem_addr = mem_addr;
-	pinfo->dma_addr = dma_addr;
-	pinfo->mem_size = memsz;
-
-	pinfo->rx_buf = mem_addr;
-	pinfo->tx_buf = pinfo->rx_buf + L1_CACHE_ALIGN(pinfo->rx_nrfifos
-						       * pinfo->rx_fifosize);
-
-	pinfo->rx_bd_base = (cbd_t __iomem *)dp_mem;
-	pinfo->tx_bd_base = pinfo->rx_bd_base + pinfo->rx_nrfifos;
-
-	return 0;
-}
-
-void cpm_uart_freebuf(struct uart_cpm_port *pinfo)
-{
-	dma_free_coherent(pinfo->port.dev, L1_CACHE_ALIGN(pinfo->rx_nrfifos *
-							  pinfo->rx_fifosize) +
-			  L1_CACHE_ALIGN(pinfo->tx_nrfifos *
-					 pinfo->tx_fifosize), (void __force *)pinfo->mem_addr,
-			  pinfo->dma_addr);
-
-	cpm_dpfree(pinfo->dp_addr);
-}
-- 
2.41.0

