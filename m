Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A78758578
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 21:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjGRTZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 15:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjGRTZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 15:25:09 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F51D19AF;
        Tue, 18 Jul 2023 12:25:06 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,214,1684767600"; 
   d="scan'208";a="169810329"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 19 Jul 2023 04:25:05 +0900
Received: from mulinux.home (unknown [10.226.93.62])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id CD2E44067F07;
        Wed, 19 Jul 2023 04:25:02 +0900 (JST)
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
Subject: [PATCH v2 1/4] spi: rzv2m-csi: Squash timing settings into one statement
Date:   Tue, 18 Jul 2023 20:24:50 +0100
Message-Id: <20230718192453.543549-2-fabrizio.castro.jz@renesas.com>
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

Register CLKSEL hosts the configuration for both clock polarity
and data phase, and both values can be set in one write operation.

Squash the clock polarity and data phase register writes into
one statement, for efficiency.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---

v2: No change.

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

