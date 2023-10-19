Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4297CF955
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345616AbjJSMt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345380AbjJSMtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:49:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C199F7;
        Thu, 19 Oct 2023 05:49:23 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DC10D660732D;
        Thu, 19 Oct 2023 13:49:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697719761;
        bh=cSZfxWoSCWS2x6FEp2VdlrLkR6g3cTGCjH9LiGJQjsc=;
        h=From:To:Cc:Subject:Date:From;
        b=Byw5jZaTstRkh8IuXf+2axodIjrnKzDkwHKOGhM9abUwqgSnmOTbPiSBR2ey/dFPM
         zW+XgpaWlo/sxBhnpMQVLvG3hjxMF4bNMLnihyHhHawu2ey/jP665086EZcOy58Ezm
         X2Ivc1hTg0VE1kdLlsmDjyuo95G5JdvOUMobxTDWJ74rkmE2CuqDPHwDCyUEFTGX0q
         PgTR1pENCUmmdhhyr97KeN0bwOuaf/hUqt/LGuqP5WzY31esNqaIl+Ex0IuIsH6Gov
         6Q5Tndd5Ur9TGDdZWhve2jISHTk2w4K2U6uWcOjZow9vgTv/SxcTQzRwZ6WhBNgxGO
         I9p615dFIsnJw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        u.kleine-koenig@pengutronix.de, chun-jie.chen@mediatek.com,
        miles.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] clk: mediatek: mt8186: Change I2C 4/5/6 ap clocks parent to infra
Date:   Thu, 19 Oct 2023 14:49:14 +0200
Message-ID: <20231019124914.13545-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the parenting of clocks imp_iic_wrap_ap_clock_i2c{4-6}, as those
are effectively parented to infra_ao_i2c{4-6} and not to the I2C_AP.
This permits the correct (and full) enablement and disablement of the
I2C4, I2C5 and I2C6 bus clocks, satisfying the whole clock tree of
those.

As an example, when requesting to enable imp_iic_wrap_ap_clock_i2c4:

Before: infra_ao_i2c_ap -> imp_iic_wrap_ap_clock_i2c4
After:  infra_ao_i2c_ap -> infra_ao_i2c4 -> imp_iic_wrap_ap_clock_i2c4

Fixes: 66cd0b4b0ce5 ("clk: mediatek: Add MT8186 imp i2c wrapper clock support")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c | 6 +++---
 drivers/clk/mediatek/clk-mt8186-infra_ao.c     | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c b/drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c
index 640ccb553274..871b8ff4c287 100644
--- a/drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c
+++ b/drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c
@@ -29,11 +29,11 @@ static const struct mtk_gate imp_iic_wrap_clks[] = {
 	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_AP_CLOCK_I2C3,
 		"imp_iic_wrap_ap_clock_i2c3", "infra_ao_i2c_ap", 3),
 	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_AP_CLOCK_I2C4,
-		"imp_iic_wrap_ap_clock_i2c4", "infra_ao_i2c_ap", 4),
+		"imp_iic_wrap_ap_clock_i2c4", "infra_ao_i2c4", 4),
 	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_AP_CLOCK_I2C5,
-		"imp_iic_wrap_ap_clock_i2c5", "infra_ao_i2c_ap", 5),
+		"imp_iic_wrap_ap_clock_i2c5", "infra_ao_i2c5", 5),
 	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_AP_CLOCK_I2C6,
-		"imp_iic_wrap_ap_clock_i2c6", "infra_ao_i2c_ap", 6),
+		"imp_iic_wrap_ap_clock_i2c6", "infra_ao_i2c6", 6),
 	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_AP_CLOCK_I2C7,
 		"imp_iic_wrap_ap_clock_i2c7", "infra_ao_i2c_ap", 7),
 	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_AP_CLOCK_I2C8,
diff --git a/drivers/clk/mediatek/clk-mt8186-infra_ao.c b/drivers/clk/mediatek/clk-mt8186-infra_ao.c
index 837304cd0ed7..c490f1a310f8 100644
--- a/drivers/clk/mediatek/clk-mt8186-infra_ao.c
+++ b/drivers/clk/mediatek/clk-mt8186-infra_ao.c
@@ -132,7 +132,7 @@ static const struct mtk_gate infra_ao_clks[] = {
 	GATE_INFRA_AO2(CLK_INFRA_AO_AUDIO_26M_BCLK, "infra_ao_audio26m", "clk26m", 4),
 	GATE_INFRA_AO2(CLK_INFRA_AO_SSUSB_TOP_P1_HCLK, "infra_ao_ssusb_p1_hclk", "top_axi", 5),
 	GATE_INFRA_AO2(CLK_INFRA_AO_SPI1, "infra_ao_spi1", "top_spi", 6),
-	GATE_INFRA_AO2(CLK_INFRA_AO_I2C4, "infra_ao_i2c4", "top_i2c", 7),
+	GATE_INFRA_AO2(CLK_INFRA_AO_I2C4, "infra_ao_i2c4", "infra_ao_i2c_ap", 7),
 	GATE_INFRA_AO2(CLK_INFRA_AO_MODEM_TEMP_SHARE, "infra_ao_mdtemp", "clk26m", 8),
 	GATE_INFRA_AO2(CLK_INFRA_AO_SPI2, "infra_ao_spi2", "top_spi", 9),
 	GATE_INFRA_AO2(CLK_INFRA_AO_SPI3, "infra_ao_spi3", "top_spi", 10),
@@ -145,7 +145,7 @@ static const struct mtk_gate infra_ao_clks[] = {
 	GATE_INFRA_AO2_FLAGS(CLK_INFRA_AO_SSPM, "infra_ao_sspm", "top_sspm", 15, CLK_IS_CRITICAL),
 	GATE_INFRA_AO2(CLK_INFRA_AO_SSUSB_TOP_P1_SYS,
 		       "infra_ao_ssusb_p1_sys", "top_ssusb_1p", 16),
-	GATE_INFRA_AO2(CLK_INFRA_AO_I2C5, "infra_ao_i2c5", "top_i2c", 18),
+	GATE_INFRA_AO2(CLK_INFRA_AO_I2C5, "infra_ao_i2c5", "infra_ao_i2c_ap", 18),
 	GATE_INFRA_AO2(CLK_INFRA_AO_I2C5_ARBITER, "infra_ao_i2c5a", "top_i2c", 19),
 	GATE_INFRA_AO2(CLK_INFRA_AO_I2C5_IMM, "infra_ao_i2c5_imm", "top_i2c", 20),
 	GATE_INFRA_AO2(CLK_INFRA_AO_I2C1_ARBITER, "infra_ao_i2c1a", "top_i2c", 21),
@@ -167,7 +167,7 @@ static const struct mtk_gate infra_ao_clks[] = {
 			     CLK_IS_CRITICAL),
 	GATE_INFRA_AO3_FLAGS(CLK_INFRA_AO_SSPM_32K_SELF, "infra_ao_sspm_32k", "clk32k", 4,
 			     CLK_IS_CRITICAL),
-	GATE_INFRA_AO3(CLK_INFRA_AO_I2C6, "infra_ao_i2c6", "top_i2c", 6),
+	GATE_INFRA_AO3(CLK_INFRA_AO_I2C6, "infra_ao_i2c6", "infra_ao_i2c_ap", 6),
 	GATE_INFRA_AO3(CLK_INFRA_AO_AP_MSDC0, "infra_ao_ap_msdc0", "top_axi", 7),
 	GATE_INFRA_AO3(CLK_INFRA_AO_MD_MSDC0, "infra_ao_md_msdc0", "top_axi", 8),
 	GATE_INFRA_AO3(CLK_INFRA_AO_MSDC0_SRC, "infra_ao_msdc0_clk", "top_msdc50_0", 9),
-- 
2.42.0

