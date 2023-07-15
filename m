Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559E9754602
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 03:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjGOBFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 21:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjGOBFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 21:05:05 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E4493C22;
        Fri, 14 Jul 2023 18:04:44 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,206,1684767600"; 
   d="scan'208";a="172657866"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 15 Jul 2023 10:04:44 +0900
Received: from mulinux.home (unknown [10.226.92.194])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id F419B40C4DAF;
        Sat, 15 Jul 2023 10:04:40 +0900 (JST)
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
Subject: [PATCH 08/10] spi: rzv2m-csi: Improve data types and alignment
Date:   Sat, 15 Jul 2023 02:04:05 +0100
Message-Id: <20230715010407.1751715-9-fabrizio.castro.jz@renesas.com>
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

"unsigned int" is more appropriate than "int" for the members
of "struct rzv2m_csi_priv".
Also, members "bytes_per_word" and "errors" introduce gaps
in the structure.
Adjust "struct rzv2m_csi_priv" and its members usage accordingly.
While at it, remove the unnecessary casting of "data" to
"struct rzv2m_csi_priv*" in function "rzv2m_csi_irq_handler".

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 drivers/spi/spi-rzv2m-csi.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-rzv2m-csi.c b/drivers/spi/spi-rzv2m-csi.c
index d0d6b183ffaf..1e5ed1089f42 100644
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
@@ -88,14 +88,14 @@ struct rzv2m_csi_priv {
 	struct spi_controller *controller;
 	const void *txbuf;
 	void *rxbuf;
-	int buffer_len;
-	int bytes_sent;
-	int bytes_received;
-	int bytes_to_transfer;
-	int words_to_transfer;
-	unsigned char bytes_per_word;
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
 
@@ -193,9 +193,9 @@ static int rzv2m_csi_read_rxfifo(struct rzv2m_csi_priv *csi)
 
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
@@ -203,9 +203,9 @@ static inline void rzv2m_csi_calc_current_transfer(struct rzv2m_csi_priv *csi)
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
@@ -325,7 +325,7 @@ static inline int rzv2m_csi_wait_for_rx_ready(struct rzv2m_csi_priv *csi)
 
 static irqreturn_t rzv2m_csi_irq_handler(int irq, void *data)
 {
-	struct rzv2m_csi_priv *csi = (struct rzv2m_csi_priv *)data;
+	struct rzv2m_csi_priv *csi = data;
 
 	csi->status = readl(csi->base + CSI_INT);
 	rzv2m_csi_disable_irqs(csi, csi->status);
-- 
2.34.1

