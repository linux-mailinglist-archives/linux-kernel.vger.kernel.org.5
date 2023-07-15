Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9E67545F9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 03:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjGOBEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 21:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjGOBEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 21:04:43 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B7963AAF;
        Fri, 14 Jul 2023 18:04:33 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,206,1684767600"; 
   d="scan'208";a="172657821"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 15 Jul 2023 10:04:33 +0900
Received: from mulinux.home (unknown [10.226.92.194])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 14F9340C4DAF;
        Sat, 15 Jul 2023 10:04:29 +0900 (JST)
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
Subject: [PATCH 05/10] spi: rzv2m-csi: Replace unnecessary ternary operators
Date:   Sat, 15 Jul 2023 02:04:02 +0100
Message-Id: <20230715010407.1751715-6-fabrizio.castro.jz@renesas.com>
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

The ternary operators used to initialize tx_completed and rx_completed
are not necessary, replace them with a better implementation.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 drivers/spi/spi-rzv2m-csi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rzv2m-csi.c b/drivers/spi/spi-rzv2m-csi.c
index 1c65cd5f2039..038f1486b7d7 100644
--- a/drivers/spi/spi-rzv2m-csi.c
+++ b/drivers/spi/spi-rzv2m-csi.c
@@ -439,8 +439,8 @@ static int rzv2m_csi_setup(struct spi_device *spi)
 
 static int rzv2m_csi_pio_transfer(struct rzv2m_csi_priv *csi)
 {
-	bool tx_completed = csi->txbuf ? false : true;
-	bool rx_completed = csi->rxbuf ? false : true;
+	bool tx_completed = !csi->txbuf;
+	bool rx_completed = !csi->rxbuf;
 	int ret = 0;
 
 	/* Make sure the TX FIFO is empty */
-- 
2.34.1

