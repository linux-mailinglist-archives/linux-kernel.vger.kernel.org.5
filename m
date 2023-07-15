Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63AD7545FC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 03:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjGOBE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 21:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjGOBEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 21:04:54 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2D2B3AA6;
        Fri, 14 Jul 2023 18:04:37 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,206,1684767600"; 
   d="scan'208";a="169014747"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 15 Jul 2023 10:04:36 +0900
Received: from mulinux.home (unknown [10.226.92.194])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id AFF4240C4DAF;
        Sat, 15 Jul 2023 10:04:33 +0900 (JST)
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
Subject: [PATCH 06/10] spi: rzv2m-csi: Squash timing settings into one statement
Date:   Sat, 15 Jul 2023 02:04:03 +0100
Message-Id: <20230715010407.1751715-7-fabrizio.castro.jz@renesas.com>
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

Register CLKSEL hosts the configuration for both clock polarity
and data phase, and both values can be set in one write operation.

Squash the clock polarity and data phase register writes into
one statement, for efficiency.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 drivers/spi/spi-rzv2m-csi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-rzv2m-csi.c b/drivers/spi/spi-rzv2m-csi.c
index 038f1486b7d7..faf5898bc3e0 100644
--- a/drivers/spi/spi-rzv2m-csi.c
+++ b/drivers/spi/spi-rzv2m-csi.c
@@ -38,6 +38,7 @@
 /* CSI_CLKSEL */
 #define CSI_CLKSEL_CKP		BIT(17)
 #define CSI_CLKSEL_DAP		BIT(16)
+#define CSI_CLKSEL_MODE		(CSI_CLKSEL_CKP|CSI_CLKSEL_DAP)
 #define CSI_CLKSEL_SLAVE	BIT(15)
 #define CSI_CLKSEL_CKS		GENMASK(14, 1)
 
@@ -408,10 +409,8 @@ static int rzv2m_csi_setup(struct spi_device *spi)
 	writel(CSI_MODE_SETUP, csi->base + CSI_MODE);
 
 	/* Setup clock polarity and phase timing */
-	rzv2m_csi_reg_write_bit(csi, CSI_CLKSEL, CSI_CLKSEL_CKP,
-				!(spi->mode & SPI_CPOL));
-	rzv2m_csi_reg_write_bit(csi, CSI_CLKSEL, CSI_CLKSEL_DAP,
-				!(spi->mode & SPI_CPHA));
+	rzv2m_csi_reg_write_bit(csi, CSI_CLKSEL, CSI_CLKSEL_MODE,
+				~spi->mode & SPI_MODE_X_MASK);
 
 	/* Setup serial data order */
 	rzv2m_csi_reg_write_bit(csi, CSI_MODE, CSI_MODE_DIR,
-- 
2.34.1

