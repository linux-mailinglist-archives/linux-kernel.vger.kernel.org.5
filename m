Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2791A7545F6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 03:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjGOBEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 21:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjGOBEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 21:04:36 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 108933AB7;
        Fri, 14 Jul 2023 18:04:29 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,206,1684767600"; 
   d="scan'208";a="169014721"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 15 Jul 2023 10:04:29 +0900
Received: from mulinux.home (unknown [10.226.92.194])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6D12240C4DAF;
        Sat, 15 Jul 2023 10:04:26 +0900 (JST)
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
Subject: [PATCH 04/10] spi: rzv2m-csi: Leave readl_poll_timeout calls for last
Date:   Sat, 15 Jul 2023 02:04:01 +0100
Message-Id: <20230715010407.1751715-5-fabrizio.castro.jz@renesas.com>
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

Both rzv2m_csi_sw_reset and rzv2m_csi_start_stop_operation
call into readl_poll_timeout upon a certain condition, and
return 0 otherwise.
Flip the logic to improve readability.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 drivers/spi/spi-rzv2m-csi.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-rzv2m-csi.c b/drivers/spi/spi-rzv2m-csi.c
index 621774949bde..1c65cd5f2039 100644
--- a/drivers/spi/spi-rzv2m-csi.c
+++ b/drivers/spi/spi-rzv2m-csi.c
@@ -131,13 +131,12 @@ static int rzv2m_csi_sw_reset(struct rzv2m_csi_priv *csi, int assert)
 
 	rzv2m_csi_reg_write_bit(csi, CSI_CNT, CSI_CNT_CSIRST, assert);
 
-	if (assert) {
-		return readl_poll_timeout(csi->base + CSI_MODE, reg,
-					  !(reg & CSI_MODE_CSOT), 0,
-					  CSI_EN_DIS_TIMEOUT_US);
-	}
+	if (!assert)
+		return 0;
 
-	return 0;
+	return readl_poll_timeout(csi->base + CSI_MODE, reg,
+				  !(reg & CSI_MODE_CSOT), 0,
+				  CSI_EN_DIS_TIMEOUT_US);
 }
 
 static int rzv2m_csi_start_stop_operation(const struct rzv2m_csi_priv *csi,
@@ -147,12 +146,12 @@ static int rzv2m_csi_start_stop_operation(const struct rzv2m_csi_priv *csi,
 
 	rzv2m_csi_reg_write_bit(csi, CSI_MODE, CSI_MODE_CSIE, enable);
 
-	if (!enable && wait)
-		return readl_poll_timeout(csi->base + CSI_MODE, reg,
-					  !(reg & CSI_MODE_CSOT), 0,
-					  CSI_EN_DIS_TIMEOUT_US);
+	if (enable || !wait)
+		return 0;
 
-	return 0;
+	return readl_poll_timeout(csi->base + CSI_MODE, reg,
+				  !(reg & CSI_MODE_CSOT), 0,
+				  CSI_EN_DIS_TIMEOUT_US);
 }
 
 static int rzv2m_csi_fill_txfifo(struct rzv2m_csi_priv *csi)
-- 
2.34.1

