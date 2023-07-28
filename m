Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7254766AAD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbjG1KcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbjG1Kbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:31:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986B1524E;
        Fri, 28 Jul 2023 03:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690540193; x=1722076193;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f1dps+oGiDe/KHzYb18t8lFz4154pwNNCSulv4GCbrs=;
  b=SIdC84STOF9b087VL4m3alBzYCcrG+8TKXrfTSpTuGmLVWafh3qoISsH
   AEDqtkKyXg/G4gnzANUURsKWAi3QmCPxQ7787FY3U5STakVqnfX96oObc
   ES7182zY8m0HQSG6tg9RgczFFBBRWp8F8totxJVwD7/6uyfInoiRf2SKZ
   Q5AJwvSrFBkS1xiEqGu0xRCkLUNHBOBaoGpUir6Fv5kod7Ns9qBFXlelb
   ngKG/xAb7PK9qnGeXHA3FhA+/rJOVnGqW1c9ZiDgoY/eZuR8jBto4fN6a
   X+KjUSM8FLAXNKamDyVctdxcgNGq6AEJ4/L77AgGOhSJUsa8AoYsV0cMF
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="226623427"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 03:29:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 03:29:42 -0700
Received: from che-lt-i67070.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 28 Jul 2023 03:29:38 -0700
From:   Varshini Rajendran <varshini.rajendran@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <mripard@kernel.org>,
        <varshini.rajendran@microchip.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 39/50] clk: at91: sama7g5: move mux table macros to header file
Date:   Fri, 28 Jul 2023 15:59:35 +0530
Message-ID: <20230728102935.267294-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the mux table init and fill macro function definitions from the
sama7g5 pmc driver to the pmc.h header file since they will be used
by other SoC's pmc drivers as well like sam9x7.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 drivers/clk/at91/pmc.h     | 16 ++++++++++++++++
 drivers/clk/at91/sama7g5.c | 35 ++++++++++-------------------------
 2 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 91d1c6305d95..4fb29ca111f7 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -121,6 +121,22 @@ struct at91_clk_pms {
 
 #define ndck(a, s) (a[s - 1].id + 1)
 #define nck(a) (a[ARRAY_SIZE(a) - 1].id + 1)
+
+#define PMC_INIT_TABLE(_table, _count)			\
+	do {						\
+		u8 _i;					\
+		for (_i = 0; _i < (_count); _i++)	\
+			(_table)[_i] = _i;		\
+	} while (0)
+
+#define PMC_FILL_TABLE(_to, _from, _count)		\
+	do {						\
+		u8 _i;					\
+		for (_i = 0; _i < (_count); _i++) {	\
+			(_to)[_i] = (_from)[_i];	\
+		}					\
+	} while (0)
+
 struct pmc_data *pmc_data_allocate(unsigned int ncore, unsigned int nsystem,
 				   unsigned int nperiph, unsigned int ngck,
 				   unsigned int npck);
diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index e6eb5afba93d..6706d1305baa 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -16,21 +16,6 @@
 
 #include "pmc.h"
 
-#define SAMA7G5_INIT_TABLE(_table, _count)		\
-	do {						\
-		u8 _i;					\
-		for (_i = 0; _i < (_count); _i++)	\
-			(_table)[_i] = _i;		\
-	} while (0)
-
-#define SAMA7G5_FILL_TABLE(_to, _from, _count)		\
-	do {						\
-		u8 _i;					\
-		for (_i = 0; _i < (_count); _i++) {	\
-			(_to)[_i] = (_from)[_i];	\
-		}					\
-	} while (0)
-
 static DEFINE_SPINLOCK(pmc_pll_lock);
 static DEFINE_SPINLOCK(pmc_mck0_lock);
 static DEFINE_SPINLOCK(pmc_mckX_lock);
@@ -1119,17 +1104,17 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 		if (!mux_table)
 			goto err_free;
 
-		SAMA7G5_INIT_TABLE(mux_table, 3);
-		SAMA7G5_FILL_TABLE(&mux_table[3], sama7g5_mckx[i].ep_mux_table,
-				   sama7g5_mckx[i].ep_count);
+		PMC_INIT_TABLE(mux_table, 3);
+		PMC_FILL_TABLE(&mux_table[3], sama7g5_mckx[i].ep_mux_table,
+			       sama7g5_mckx[i].ep_count);
 		for (j = 0; j < sama7g5_mckx[i].ep_count; j++) {
 			u8 pll_id = sama7g5_mckx[i].ep[j].pll_id;
 			u8 pll_compid = sama7g5_mckx[i].ep[j].pll_compid;
 
 			tmp_parent_hws[j] = sama7g5_plls[pll_id][pll_compid].hw;
 		}
-		SAMA7G5_FILL_TABLE(&parent_hws[3], tmp_parent_hws,
-				   sama7g5_mckx[i].ep_count);
+		PMC_FILL_TABLE(&parent_hws[3], tmp_parent_hws,
+			       sama7g5_mckx[i].ep_count);
 
 		hw = at91_clk_sama7g5_register_master(regmap, sama7g5_mckx[i].n,
 				   num_parents, NULL, parent_hws, mux_table,
@@ -1215,17 +1200,17 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 		if (!mux_table)
 			goto err_free;
 
-		SAMA7G5_INIT_TABLE(mux_table, 3);
-		SAMA7G5_FILL_TABLE(&mux_table[3], sama7g5_gck[i].pp_mux_table,
-				   sama7g5_gck[i].pp_count);
+		PMC_INIT_TABLE(mux_table, 3);
+		PMC_FILL_TABLE(&mux_table[3], sama7g5_gck[i].pp_mux_table,
+			       sama7g5_gck[i].pp_count);
 		for (j = 0; j < sama7g5_gck[i].pp_count; j++) {
 			u8 pll_id = sama7g5_gck[i].pp[j].pll_id;
 			u8 pll_compid = sama7g5_gck[i].pp[j].pll_compid;
 
 			tmp_parent_hws[j] = sama7g5_plls[pll_id][pll_compid].hw;
 		}
-		SAMA7G5_FILL_TABLE(&parent_hws[3], tmp_parent_hws,
-				   sama7g5_gck[i].pp_count);
+		PMC_FILL_TABLE(&parent_hws[3], tmp_parent_hws,
+			       sama7g5_gck[i].pp_count);
 
 		hw = at91_clk_register_generated(regmap, &pmc_pcr_lock,
 						 &sama7g5_pcr_layout,
-- 
2.25.1

