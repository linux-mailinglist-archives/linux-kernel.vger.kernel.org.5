Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6B875857A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 21:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjGRTZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 15:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjGRTZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 15:25:13 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E602B19A5;
        Tue, 18 Jul 2023 12:25:09 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,214,1684767600"; 
   d="scan'208";a="169810348"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 19 Jul 2023 04:25:09 +0900
Received: from mulinux.home (unknown [10.226.93.62])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 76FB04067F07;
        Wed, 19 Jul 2023 04:25:06 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 2/4] spi: rzv2m-csi: Improve data types, casting and alignment
Date:   Tue, 18 Jul 2023 20:24:51 +0100
Message-Id: <20230718192453.543549-3-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230718192453.543549-1-fabrizio.castro.jz@renesas.com>
References: <20230718192453.543549-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"unsigned int" is more appropriate than "int" for the members
of "struct rzv2m_csi_priv".
Using void* rather than u8* for txbuf and rxbuf allows for
the removal of some type casting.
Remove the unnecessary casting of "data" to "struct rzv2m_csi_priv*"
in function "rzv2m_csi_irq_handler".
Also, members "bytes_per_word" and "errors" introduce gaps
in the structure.
Adjust "struct rzv2m_csi_priv" and its members usage accordingly.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

v2: This is basically v1 with the addition of changes to the data
    types of txbuf and rxbuf and related touches.
    Also, both the title of this patch and its changelog have been
    changed to reflect the new additions.
    Although both Geert and Andy kindly allowed for their Reviewed-by
    tags to used for this patch, I have dropped them in case they want
    to jump in.

 drivers/spi/spi-rzv2m-csi.c | 46 ++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-rzv2m-csi.c b/drivers/spi/spi-rzv2m-csi.c
index faf5898bc3e0..4dbb8c185a8a 100644
--- a/drivers/spi/spi-rzv2m-csi.c
+++ b/drivers/spi/spi-rzv2m-csi.c
@@ -63,8 +63,8 @@
 /* CSI_FIFOTRG */
 #define CSI_FIFOTRG_R_TRG       GENMASK(2, 0)
 
-#define CSI_FIFO_SIZE_BYTES	32
-#define CSI_FIFO_HALF_SIZE	16
+#define CSI_FIFO_SIZE_BYTES	32U
+#define CSI_FIFO_HALF_SIZE	16U
 #define CSI_EN_DIS_TIMEOUT_US	100
 /*
  * Clock "csiclk" gets divided by 2 * CSI_CLKSEL_CKS in order to generate the
@@ -86,16 +86,16 @@ struct rzv2m_csi_priv {
 	struct clk *pclk;
 	struct device *dev;
 	struct spi_controller *controller;
-	const u8 *txbuf;
-	u8 *rxbuf;
-	int buffer_len;
-	int bytes_sent;
-	int bytes_received;
-	int bytes_to_transfer;
-	int words_to_transfer;
-	unsigned char bytes_per_word;
+	const void *txbuf;
+	void *rxbuf;
+	unsigned int buffer_len;
+	unsigned int bytes_sent;
+	unsigned int bytes_received;
+	unsigned int bytes_to_transfer;
+	unsigned int words_to_transfer;
+	unsigned int bytes_per_word;
 	wait_queue_head_t wait;
-	u8 errors;
+	u32 errors;
 	u32 status;
 };
 
@@ -157,18 +157,18 @@ static int rzv2m_csi_start_stop_operation(const struct rzv2m_csi_priv *csi,
 
 static int rzv2m_csi_fill_txfifo(struct rzv2m_csi_priv *csi)
 {
-	int i;
+	unsigned int i;
 
 	if (readl(csi->base + CSI_OFIFOL))
 		return -EIO;
 
 	if (csi->bytes_per_word == 2) {
-		u16 *buf = (u16 *)csi->txbuf;
+		const u16 *buf = csi->txbuf;
 
 		for (i = 0; i < csi->words_to_transfer; i++)
 			writel(buf[i], csi->base + CSI_OFIFO);
 	} else {
-		u8 *buf = (u8 *)csi->txbuf;
+		const u8 *buf = csi->txbuf;
 
 		for (i = 0; i < csi->words_to_transfer; i++)
 			writel(buf[i], csi->base + CSI_OFIFO);
@@ -182,18 +182,18 @@ static int rzv2m_csi_fill_txfifo(struct rzv2m_csi_priv *csi)
 
 static int rzv2m_csi_read_rxfifo(struct rzv2m_csi_priv *csi)
 {
-	int i;
+	unsigned int i;
 
 	if (readl(csi->base + CSI_IFIFOL) != csi->bytes_to_transfer)
 		return -EIO;
 
 	if (csi->bytes_per_word == 2) {
-		u16 *buf = (u16 *)csi->rxbuf;
+		u16 *buf = csi->rxbuf;
 
 		for (i = 0; i < csi->words_to_transfer; i++)
 			buf[i] = (u16)readl(csi->base + CSI_IFIFO);
 	} else {
-		u8 *buf = (u8 *)csi->rxbuf;
+		u8 *buf = csi->rxbuf;
 
 		for (i = 0; i < csi->words_to_transfer; i++)
 			buf[i] = (u8)readl(csi->base + CSI_IFIFO);
@@ -207,9 +207,9 @@ static int rzv2m_csi_read_rxfifo(struct rzv2m_csi_priv *csi)
 
 static inline void rzv2m_csi_calc_current_transfer(struct rzv2m_csi_priv *csi)
 {
-	int bytes_transferred = max_t(int, csi->bytes_received, csi->bytes_sent);
-	int bytes_remaining = csi->buffer_len - bytes_transferred;
-	int to_transfer;
+	unsigned int bytes_transferred = max(csi->bytes_received, csi->bytes_sent);
+	unsigned int bytes_remaining = csi->buffer_len - bytes_transferred;
+	unsigned int to_transfer;
 
 	if (csi->txbuf)
 		/*
@@ -217,9 +217,9 @@ static inline void rzv2m_csi_calc_current_transfer(struct rzv2m_csi_priv *csi)
 		 * hard to raise an overflow error (which is only possible
 		 * when IP transmits and receives at the same time).
 		 */
-		to_transfer = min_t(int, CSI_FIFO_HALF_SIZE, bytes_remaining);
+		to_transfer = min(CSI_FIFO_HALF_SIZE, bytes_remaining);
 	else
-		to_transfer = min_t(int, CSI_FIFO_SIZE_BYTES, bytes_remaining);
+		to_transfer = min(CSI_FIFO_SIZE_BYTES, bytes_remaining);
 
 	if (csi->bytes_per_word == 2)
 		to_transfer >>= 1;
@@ -339,7 +339,7 @@ static inline int rzv2m_csi_wait_for_rx_ready(struct rzv2m_csi_priv *csi)
 
 static irqreturn_t rzv2m_csi_irq_handler(int irq, void *data)
 {
-	struct rzv2m_csi_priv *csi = (struct rzv2m_csi_priv *)data;
+	struct rzv2m_csi_priv *csi = data;
 
 	csi->status = readl(csi->base + CSI_INT);
 	rzv2m_csi_disable_irqs(csi, csi->status);
-- 
2.34.1

