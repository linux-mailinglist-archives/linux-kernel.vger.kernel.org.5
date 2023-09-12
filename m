Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6FD79C56F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjILEzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjILEyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:54:17 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D131BF6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:52:53 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31c7912416bso5479864f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694494371; x=1695099171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZrXEHLewwIpzFJPJw9ph6sFFEuvirlybn7ranZprDM=;
        b=k/CZfxgQCy33tkfuJEVCGzCoVCc7Xaa6jy0gZBPnkioMfbmCyPYmMfHMR5x9jHlYFY
         UXeOmaPZHzF5YNG85WPjgyB2HYLAnbL/MXgLzUIQSTXpQt8rGvWuzg99RYgbl+R8i89p
         qxqVjrPA2HW6/1fdzNQpEuUUTT4DbOog5k0zsNaupLiIyohv6MzYKjZMjetSAZ8yZMAc
         vE9REdyQG7NY8Tyv+w6XLy695LxTNyutPPD5VK19EueNDP47qzTRqHSpnbQi8VrzBJ++
         c9TZEoavdJviTd5gI5FQ/M+Utmv0ru71L811TeVHKZgtvoEbA4tXhNfDlwzz3YSXepAr
         rY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694494371; x=1695099171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZrXEHLewwIpzFJPJw9ph6sFFEuvirlybn7ranZprDM=;
        b=O8qh8Jf1+8DQTlnjdDIUWHTaYGOok8DuMp9t0+ASMvGrC2Toto9O+WkblBOD8pmC9B
         YhWP/EGfdFljbJXiltX1nn7kW6KQjvYM1APe/MgvOJYNb+OxZVNrxtsO4XTaBkcVSBM2
         5CfK6mtXFkFrje0sjeXYuX+9LlrmG2lU1xtK9YR3/Mz/s+Mj8snqnO7/7qEJx8XnM3oB
         wbc5JhNwaWhG5/UYVh4BW1RMXf73uPMG5lf1pAwHIYDPm4GWBqdxlhNhiTBtN8oagZPN
         RygW6dO9CGqoei1mryquV8oAZ3JQ8bLo8rJCuwHhlVw6Vz9spWvONkrP3sdqfuwtC99o
         +lqA==
X-Gm-Message-State: AOJu0YyHLYAZoGHQlAAGyaYhQ5Zw0dtKcpX+c/tw1ZPPwWtHyUEtfBEz
        iUgliAfU01ZNs8kuvfC7gl2zXg==
X-Google-Smtp-Source: AGHT+IG1rjKY6PdX0reO37GcGkK8PfBAZZSEyIxtJBCRBVAtWdggOFsVPvGv/qvp5mSLbdv/CJcXhA==
X-Received: by 2002:a5d:468f:0:b0:317:6a07:83a7 with SMTP id u15-20020a5d468f000000b003176a0783a7mr9936755wrq.38.1694494371550;
        Mon, 11 Sep 2023 21:52:51 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id f21-20020a05640214d500b0051e22660835sm5422415edx.46.2023.09.11.21.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 21:52:51 -0700 (PDT)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, magnus.damm@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 17/37] clk: renesas: rzg2l: remove CPG_SDHI_DSEL from generic header
Date:   Tue, 12 Sep 2023 07:51:37 +0300
Message-Id: <20230912045157.177966-18-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Remove CPG_SDHI_DSEL and its bits form generic header as RZ/G3S has
different offset register and bits for this, thus avoid mixing them.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g043-cpg.c | 11 +++++++++--
 drivers/clk/renesas/r9a07g044-cpg.c | 11 +++++++++--
 drivers/clk/renesas/rzg2l-cpg.h     |  4 ----
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/renesas/r9a07g043-cpg.c b/drivers/clk/renesas/r9a07g043-cpg.c
index 1a7a6d60aca4..e87cbb54a640 100644
--- a/drivers/clk/renesas/r9a07g043-cpg.c
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -14,6 +14,13 @@
 
 #include "rzg2l-cpg.h"
 
+/* Specific registers. */
+#define G2UL_CPG_PL2SDHI_DSEL	(0x218)
+
+/* Clock select configuration. */
+#define G2UL_SEL_SDHI0		SEL_PLL_PACK(G2UL_CPG_PL2SDHI_DSEL, 0, 2)
+#define G2UL_SEL_SDHI1		SEL_PLL_PACK(G2UL_CPG_PL2SDHI_DSEL, 4, 2)
+
 enum clk_ids {
 	/* Core Clock Outputs exported to DT */
 	LAST_DT_CORE_CLK = R9A07G043_CLK_P0_DIV2,
@@ -123,8 +130,8 @@ static const struct cpg_core_clk r9a07g043_core_clks[] __initconst = {
 	DEF_MUX("HP", R9A07G043_CLK_HP, SEL_PLL6_2, sel_pll6_2),
 	DEF_FIXED("SPI0", R9A07G043_CLK_SPI0, CLK_DIV_PLL3_C, 1, 2),
 	DEF_FIXED("SPI1", R9A07G043_CLK_SPI1, CLK_DIV_PLL3_C, 1, 4),
-	DEF_SD_MUX("SD0", R9A07G043_CLK_SD0, SEL_SDHI0, sel_shdi),
-	DEF_SD_MUX("SD1", R9A07G043_CLK_SD1, SEL_SDHI1, sel_shdi),
+	DEF_SD_MUX("SD0", R9A07G043_CLK_SD0, G2UL_SEL_SDHI0, sel_shdi),
+	DEF_SD_MUX("SD1", R9A07G043_CLK_SD1, G2UL_SEL_SDHI1, sel_shdi),
 	DEF_FIXED("SD0_DIV4", CLK_SD0_DIV4, R9A07G043_CLK_SD0, 1, 4),
 	DEF_FIXED("SD1_DIV4", CLK_SD1_DIV4, R9A07G043_CLK_SD1, 1, 4),
 };
diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index c597414a94d8..8911f6053a9f 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -15,6 +15,13 @@
 
 #include "rzg2l-cpg.h"
 
+/* Specific registers. */
+#define G2L_CPG_PL2SDHI_DSEL	(0x218)
+
+/* Clock select configuration. */
+#define G2L_SEL_SDHI0		SEL_PLL_PACK(G2L_CPG_PL2SDHI_DSEL, 0, 2)
+#define G2L_SEL_SDHI1		SEL_PLL_PACK(G2L_CPG_PL2SDHI_DSEL, 4, 2)
+
 enum clk_ids {
 	/* Core Clock Outputs exported to DT */
 	LAST_DT_CORE_CLK = R9A07G054_CLK_DRP_A,
@@ -163,8 +170,8 @@ static const struct {
 		DEF_MUX("HP", R9A07G044_CLK_HP, SEL_PLL6_2, sel_pll6_2),
 		DEF_FIXED("SPI0", R9A07G044_CLK_SPI0, CLK_DIV_PLL3_C, 1, 2),
 		DEF_FIXED("SPI1", R9A07G044_CLK_SPI1, CLK_DIV_PLL3_C, 1, 4),
-		DEF_SD_MUX("SD0", R9A07G044_CLK_SD0, SEL_SDHI0, sel_shdi),
-		DEF_SD_MUX("SD1", R9A07G044_CLK_SD1, SEL_SDHI1, sel_shdi),
+		DEF_SD_MUX("SD0", R9A07G044_CLK_SD0, G2L_SEL_SDHI0, sel_shdi),
+		DEF_SD_MUX("SD1", R9A07G044_CLK_SD1, G2L_SEL_SDHI1, sel_shdi),
 		DEF_FIXED("SD0_DIV4", CLK_SD0_DIV4, R9A07G044_CLK_SD0, 1, 4),
 		DEF_FIXED("SD1_DIV4", CLK_SD1_DIV4, R9A07G044_CLK_SD1, 1, 4),
 		DEF_DIV("G", R9A07G044_CLK_G, CLK_SEL_GPU2, DIVGPU, dtable_1_8),
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index 16f7a1872814..99a82567d1f8 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -19,7 +19,6 @@
 #define CPG_PL2_DDIV		(0x204)
 #define CPG_PL3A_DDIV		(0x208)
 #define CPG_PL6_DDIV		(0x210)
-#define CPG_PL2SDHI_DSEL	(0x218)
 #define CPG_CLKSTATUS		(0x280)
 #define CPG_PL3_SSEL		(0x408)
 #define CPG_PL6_SSEL		(0x414)
@@ -69,9 +68,6 @@
 #define SEL_PLL6_2	SEL_PLL_PACK(CPG_PL6_ETH_SSEL, 0, 1)
 #define SEL_GPU2	SEL_PLL_PACK(CPG_PL6_SSEL, 12, 1)
 
-#define SEL_SDHI0	DDIV_PACK(CPG_PL2SDHI_DSEL, 0, 2)
-#define SEL_SDHI1	DDIV_PACK(CPG_PL2SDHI_DSEL, 4, 2)
-
 #define EXTAL_FREQ_IN_MEGA_HZ	(24)
 
 /**
-- 
2.39.2

