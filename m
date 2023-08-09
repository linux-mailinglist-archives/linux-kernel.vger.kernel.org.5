Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D15A77563C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 11:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjHIJUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 05:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjHIJUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:20:12 -0400
X-Greylist: delayed 1524 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Aug 2023 02:20:10 PDT
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C151FD6;
        Wed,  9 Aug 2023 02:20:10 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RLP5127NWz9sYr;
        Wed,  9 Aug 2023 10:54:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VzC1S8RKR2PW; Wed,  9 Aug 2023 10:54:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RLP511Vjtz9sH7;
        Wed,  9 Aug 2023 10:54:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2A6A28B76C;
        Wed,  9 Aug 2023 10:54:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id og0r7JjTaFLp; Wed,  9 Aug 2023 10:54:45 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 098318B763;
        Wed,  9 Aug 2023 10:54:45 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 3798sfdq1500455
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 9 Aug 2023 10:54:41 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 3798sXhr1500417;
        Wed, 9 Aug 2023 10:54:33 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Mark Brown <broonie@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kernel test robot <lkp@intel.com>
Subject: [PATCH] spi: fsl-cpm: Properly define and use IO pointers
Date:   Wed,  9 Aug 2023 10:54:27 +0200
Message-ID: <18a65dca9134f6fc35932408066d4a8284cbfa65.1691571190.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691571266; l=5794; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=VuXEfMqJp7gg4dKMuwL+i/LPRuHDbw4JD9A1/m04C+8=; b=Tj96cTgjRfyppsgo3+qoWAoKKA4JYZCp3H/40Wfqf9H39TZDBShIHXitkjDYaXQ9Y4LHAT9Fq h2RpnX412moBVcUSAL5tThGNaEk1J9KVtyf35+c2G/S8rU63GMlzF8D
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports several issues with IO pointers.

Fix it by adding missing __iomem flags and using iowriteXXbe()
generic helpers instead of the powerpc specific out_beXX() ones.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307252052.7RqHxFZj-lkp@intel.com/
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/spi/spi-fsl-cpm.c | 74 +++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/spi/spi-fsl-cpm.c b/drivers/spi/spi-fsl-cpm.c
index 38452089e8f3..47c7a5c6257f 100644
--- a/drivers/spi/spi-fsl-cpm.c
+++ b/drivers/spi/spi-fsl-cpm.c
@@ -56,12 +56,12 @@ void fsl_spi_cpm_reinit_txrx(struct mpc8xxx_spi *mspi)
 			     QE_CR_PROTOCOL_UNSPECIFIED, 0);
 	} else {
 		if (mspi->flags & SPI_CPM1) {
-			out_be32(&mspi->pram->rstate, 0);
-			out_be16(&mspi->pram->rbptr,
-				 in_be16(&mspi->pram->rbase));
-			out_be32(&mspi->pram->tstate, 0);
-			out_be16(&mspi->pram->tbptr,
-				 in_be16(&mspi->pram->tbase));
+			iowrite32be(0, &mspi->pram->rstate);
+			iowrite16be(ioread16be(&mspi->pram->rbase),
+				    &mspi->pram->rbptr);
+			iowrite32be(0, &mspi->pram->tstate);
+			iowrite16be(ioread16be(&mspi->pram->tbase),
+				    &mspi->pram->tbptr);
 		} else {
 			cpm_command(CPM_SPI_CMD, CPM_CR_INIT_TRX);
 		}
@@ -75,24 +75,24 @@ static void fsl_spi_cpm_bufs_start(struct mpc8xxx_spi *mspi)
 	struct cpm_buf_desc __iomem *rx_bd = mspi->rx_bd;
 	unsigned int xfer_len = min(mspi->count, SPI_MRBLR);
 	unsigned int xfer_ofs;
-	struct fsl_spi_reg *reg_base = mspi->reg_base;
+	struct fsl_spi_reg __iomem *reg_base = mspi->reg_base;
 
 	xfer_ofs = mspi->xfer_in_progress->len - mspi->count;
 
 	if (mspi->rx_dma == mspi->dma_dummy_rx)
-		out_be32(&rx_bd->cbd_bufaddr, mspi->rx_dma);
+		iowrite32be(mspi->rx_dma, &rx_bd->cbd_bufaddr);
 	else
-		out_be32(&rx_bd->cbd_bufaddr, mspi->rx_dma + xfer_ofs);
-	out_be16(&rx_bd->cbd_datlen, 0);
-	out_be16(&rx_bd->cbd_sc, BD_SC_EMPTY | BD_SC_INTRPT | BD_SC_WRAP);
+		iowrite32be(mspi->rx_dma + xfer_ofs, &rx_bd->cbd_bufaddr);
+	iowrite16be(0, &rx_bd->cbd_datlen);
+	iowrite16be(BD_SC_EMPTY | BD_SC_INTRPT | BD_SC_WRAP, &rx_bd->cbd_sc);
 
 	if (mspi->tx_dma == mspi->dma_dummy_tx)
-		out_be32(&tx_bd->cbd_bufaddr, mspi->tx_dma);
+		iowrite32be(mspi->tx_dma, &tx_bd->cbd_bufaddr);
 	else
-		out_be32(&tx_bd->cbd_bufaddr, mspi->tx_dma + xfer_ofs);
-	out_be16(&tx_bd->cbd_datlen, xfer_len);
-	out_be16(&tx_bd->cbd_sc, BD_SC_READY | BD_SC_INTRPT | BD_SC_WRAP |
-				 BD_SC_LAST);
+		iowrite32be(mspi->tx_dma + xfer_ofs, &tx_bd->cbd_bufaddr);
+	iowrite16be(xfer_len, &tx_bd->cbd_datlen);
+	iowrite16be(BD_SC_READY | BD_SC_INTRPT | BD_SC_WRAP | BD_SC_LAST,
+		    &tx_bd->cbd_sc);
 
 	/* start transfer */
 	mpc8xxx_spi_write_reg(&reg_base->command, SPCOM_STR);
@@ -102,7 +102,7 @@ int fsl_spi_cpm_bufs(struct mpc8xxx_spi *mspi,
 		     struct spi_transfer *t, bool is_dma_mapped)
 {
 	struct device *dev = mspi->dev;
-	struct fsl_spi_reg *reg_base = mspi->reg_base;
+	struct fsl_spi_reg __iomem *reg_base = mspi->reg_base;
 
 	if (is_dma_mapped) {
 		mspi->map_tx_dma = 0;
@@ -123,7 +123,7 @@ int fsl_spi_cpm_bufs(struct mpc8xxx_spi *mspi,
 	}
 	if (t->bits_per_word == 16 && t->tx_buf) {
 		const u16 *src = t->tx_buf;
-		u16 *dst;
+		__le16 *dst;
 		int i;
 
 		dst = kmalloc(t->len, GFP_KERNEL);
@@ -202,12 +202,12 @@ EXPORT_SYMBOL_GPL(fsl_spi_cpm_bufs_complete);
 void fsl_spi_cpm_irq(struct mpc8xxx_spi *mspi, u32 events)
 {
 	u16 len;
-	struct fsl_spi_reg *reg_base = mspi->reg_base;
+	struct fsl_spi_reg __iomem *reg_base = mspi->reg_base;
 
 	dev_dbg(mspi->dev, "%s: bd datlen %d, count %d\n", __func__,
-		in_be16(&mspi->rx_bd->cbd_datlen), mspi->count);
+		ioread16be(&mspi->rx_bd->cbd_datlen), mspi->count);
 
-	len = in_be16(&mspi->rx_bd->cbd_datlen);
+	len = ioread16be(&mspi->rx_bd->cbd_datlen);
 	if (len > mspi->count) {
 		WARN_ON(1);
 		len = mspi->count;
@@ -328,7 +328,7 @@ int fsl_spi_cpm_init(struct mpc8xxx_spi *mspi)
 	}
 
 	if (mspi->flags & SPI_CPM1) {
-		void *pram;
+		void __iomem *pram;
 
 		pram = devm_platform_ioremap_resource(to_platform_device(dev),
 						      1);
@@ -374,21 +374,21 @@ int fsl_spi_cpm_init(struct mpc8xxx_spi *mspi)
 	mspi->rx_bd = cpm_muram_addr(bds_ofs + sizeof(*mspi->tx_bd));
 
 	/* Initialize parameter ram. */
-	out_be16(&mspi->pram->tbase, cpm_muram_offset(mspi->tx_bd));
-	out_be16(&mspi->pram->rbase, cpm_muram_offset(mspi->rx_bd));
-	out_8(&mspi->pram->tfcr, CPMFCR_EB | CPMFCR_GBL);
-	out_8(&mspi->pram->rfcr, CPMFCR_EB | CPMFCR_GBL);
-	out_be16(&mspi->pram->mrblr, SPI_MRBLR);
-	out_be32(&mspi->pram->rstate, 0);
-	out_be32(&mspi->pram->rdp, 0);
-	out_be16(&mspi->pram->rbptr, 0);
-	out_be16(&mspi->pram->rbc, 0);
-	out_be32(&mspi->pram->rxtmp, 0);
-	out_be32(&mspi->pram->tstate, 0);
-	out_be32(&mspi->pram->tdp, 0);
-	out_be16(&mspi->pram->tbptr, 0);
-	out_be16(&mspi->pram->tbc, 0);
-	out_be32(&mspi->pram->txtmp, 0);
+	iowrite16be(cpm_muram_offset(mspi->tx_bd), &mspi->pram->tbase);
+	iowrite16be(cpm_muram_offset(mspi->rx_bd), &mspi->pram->rbase);
+	iowrite8(CPMFCR_EB | CPMFCR_GBL, &mspi->pram->tfcr);
+	iowrite8(CPMFCR_EB | CPMFCR_GBL, &mspi->pram->rfcr);
+	iowrite16be(SPI_MRBLR, &mspi->pram->mrblr);
+	iowrite32be(0, &mspi->pram->rstate);
+	iowrite32be(0, &mspi->pram->rdp);
+	iowrite16be(0, &mspi->pram->rbptr);
+	iowrite16be(0, &mspi->pram->rbc);
+	iowrite32be(0, &mspi->pram->rxtmp);
+	iowrite32be(0, &mspi->pram->tstate);
+	iowrite32be(0, &mspi->pram->tdp);
+	iowrite16be(0, &mspi->pram->tbptr);
+	iowrite16be(0, &mspi->pram->tbc);
+	iowrite32be(0, &mspi->pram->txtmp);
 
 	return 0;
 
-- 
2.41.0

