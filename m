Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD4E754600
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 03:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjGOBFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 21:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjGOBE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 21:04:59 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A12933C18;
        Fri, 14 Jul 2023 18:04:40 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,206,1684767600"; 
   d="scan'208";a="172657855"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 15 Jul 2023 10:04:40 +0900
Received: from mulinux.home (unknown [10.226.92.194])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 59A9C40C4DBE;
        Sat, 15 Jul 2023 10:04:37 +0900 (JST)
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
Subject: [PATCH 07/10] spi: rzv2m-csi: Switch to using {read,write}s{b,w}
Date:   Sat, 15 Jul 2023 02:04:04 +0100
Message-Id: <20230715010407.1751715-8-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230715010407.1751715-1-fabrizio.castro.jz@renesas.com>
References: <20230715010407.1751715-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RX/TX FIFOs implemented by the CSI IP are accessed by
repeatedly reading/writing the same memory address, and
therefore they are the ideal candidate for {read,write}s{b,w}.
The RZ/V2M CSI driver currently implements loops to fill up
the TX FIFO and empty the RX FIFO, differentiating between
8-bit and 16-bit word size.
Switch to using {read,write}s{b,w} to get rid of the bespoke
loops.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 drivers/spi/spi-rzv2m-csi.c | 42 +++++++++++++------------------------
 1 file changed, 14 insertions(+), 28 deletions(-)

diff --git a/drivers/spi/spi-rzv2m-csi.c b/drivers/spi/spi-rzv2m-csi.c
index faf5898bc3e0..d0d6b183ffaf 100644
--- a/drivers/spi/spi-rzv2m-csi.c
+++ b/drivers/spi/spi-rzv2m-csi.c
@@ -86,8 +86,8 @@ struct rzv2m_csi_priv {
 	struct clk *pclk;
 	struct device *dev;
 	struct spi_controller *controller;
-	const u8 *txbuf;
-	u8 *rxbuf;
+	const void *txbuf;
+	void *rxbuf;
 	int buffer_len;
 	int bytes_sent;
 	int bytes_received;
@@ -157,22 +157,15 @@ static int rzv2m_csi_start_stop_operation(const struct rzv2m_csi_priv *csi,
 
 static int rzv2m_csi_fill_txfifo(struct rzv2m_csi_priv *csi)
 {
-	int i;
-
 	if (readl(csi->base + CSI_OFIFOL))
 		return -EIO;
 
-	if (csi->bytes_per_word == 2) {
-		u16 *buf = (u16 *)csi->txbuf;
-
-		for (i = 0; i < csi->words_to_transfer; i++)
-			writel(buf[i], csi->base + CSI_OFIFO);
-	} else {
-		u8 *buf = (u8 *)csi->txbuf;
-
-		for (i = 0; i < csi->words_to_transfer; i++)
-			writel(buf[i], csi->base + CSI_OFIFO);
-	}
+	if (csi->bytes_per_word == 2)
+		writesw(csi->base + CSI_OFIFO, csi->txbuf,
+			csi->words_to_transfer);
+	else
+		writesb(csi->base + CSI_OFIFO, csi->txbuf,
+			csi->words_to_transfer);
 
 	csi->txbuf += csi->bytes_to_transfer;
 	csi->bytes_sent += csi->bytes_to_transfer;
@@ -182,22 +175,15 @@ static int rzv2m_csi_fill_txfifo(struct rzv2m_csi_priv *csi)
 
 static int rzv2m_csi_read_rxfifo(struct rzv2m_csi_priv *csi)
 {
-	int i;
-
 	if (readl(csi->base + CSI_IFIFOL) != csi->bytes_to_transfer)
 		return -EIO;
 
-	if (csi->bytes_per_word == 2) {
-		u16 *buf = (u16 *)csi->rxbuf;
-
-		for (i = 0; i < csi->words_to_transfer; i++)
-			buf[i] = (u16)readl(csi->base + CSI_IFIFO);
-	} else {
-		u8 *buf = (u8 *)csi->rxbuf;
-
-		for (i = 0; i < csi->words_to_transfer; i++)
-			buf[i] = (u8)readl(csi->base + CSI_IFIFO);
-	}
+	if (csi->bytes_per_word == 2)
+		readsw(csi->base + CSI_IFIFO, csi->rxbuf,
+		       csi->words_to_transfer);
+	else
+		readsb(csi->base + CSI_IFIFO, csi->rxbuf,
+		       csi->words_to_transfer);
 
 	csi->rxbuf += csi->bytes_to_transfer;
 	csi->bytes_received += csi->bytes_to_transfer;
-- 
2.34.1

