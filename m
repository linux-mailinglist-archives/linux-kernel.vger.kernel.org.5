Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FDA7E015D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346496AbjKCK0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 06:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjKCKZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 06:25:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F09D4F;
        Fri,  3 Nov 2023 03:25:42 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1D7B366073E1;
        Fri,  3 Nov 2023 10:25:40 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699007141;
        bh=5p8awgj8e9mrJgUArKBpZscHWI/PcsajbEzfr8YryCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k3hE/NbBI7SY0ZUoVlB6zmyDkR9PCWZPjNLjbiOLAN4mCBj5wSf4O4Ylws0F4mSPG
         WQMuwg43oQSs0I1gTUolf8XoJLaTZRDnAo/rXWpj6YmAxk3TBABba16IA7M3MA5+uU
         RqJpfKrRb3mjp8dlOg2ih8IUmclLdB+ChJI5Ux60SCSEFq7WjO3lPHbtpoS5zP95xp
         hm9H9WLFTC9bX3NYp6zmYAgOdnA1AIGjCuMG66gdhsOagN8QRsb/1JQOAOClwUxWQv
         TcE5c1fkkx2pn0Q+X5l8xaNMCyVmSciG2meqIXsVpOZhLy71B4Dm1HvIvtsXffCowV
         oq4leed1/rYtA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        msp@baylibre.com, amergnat@baylibre.com, yangyingliang@huawei.com,
        u.kleine-koenig@pengutronix.de, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: [PATCH v3 2/3] clk: mediatek: mt8195-topckgen: Refactor parents for top_dp/edp muxes
Date:   Fri,  3 Nov 2023 11:25:32 +0100
Message-ID: <20231103102533.69280-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231103102533.69280-1-angelogioacchino.delregno@collabora.com>
References: <20231103102533.69280-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The top_dp and top_edp muxes can be both parented to either TVDPLL1
or TVDPLL2, two identically specced PLLs for the specific purpose of
giving out pixel clock: this becomes a problem when the MediaTek
DisplayPort Interface (DPI) driver tries to set the pixel clock rate.

In the usecase of two simultaneous outputs (using two controllers),
it was seen that one of the displays would sometimes display garbled
output (if any at all) and this was because:
 - top_edp was set to TVDPLL1, outputting X GHz
 - top_dp was set to TVDPLL2, outputting Y GHz
   - mtk_dpi calls clk_set_rate(top_edp, Z GHz)
     - top_dp is switched to TVDPLL1
     - TVDPLL1 changes its rate, top_edp outputs the wrong rate.
     - eDP display is garbled

To solve this issue, remove all TVDPLL1 parents from `top_dp` and
all TVDPLL2 parents from `top_edp`, plus, necessarily switch both
clocks to use the new MUX_GATE_CLR_SET_UPD_INDEXED() macro to be
able to use the right bit index for the new parents list.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt8195-topckgen.c | 27 +++++++++++++++-------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8195-topckgen.c b/drivers/clk/mediatek/clk-mt8195-topckgen.c
index 5c426a1c94c7..8f713a3341a9 100644
--- a/drivers/clk/mediatek/clk-mt8195-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8195-topckgen.c
@@ -415,17 +415,28 @@ static const char * const pwrmcu_parents[] = {
 	"mainpll_d4_d2"
 };
 
+/*
+ * Both DP/eDP can be parented to TVDPLL1 and TVDPLL2, but we force using
+ * TVDPLL1 on eDP and TVDPLL2 on DP to avoid changing the "other" PLL rate
+ * in dual output case, which would lead to corruption of functionality loss.
+ */
 static const char * const dp_parents[] = {
 	"clk26m",
-	"tvdpll1_d2",
 	"tvdpll2_d2",
-	"tvdpll1_d4",
 	"tvdpll2_d4",
-	"tvdpll1_d8",
 	"tvdpll2_d8",
-	"tvdpll1_d16",
 	"tvdpll2_d16"
 };
+static const u8 dp_parents_idx[] = { 0, 2, 4, 6, 8 };
+
+static const char * const edp_parents[] = {
+	"clk26m",
+	"tvdpll1_d2",
+	"tvdpll1_d4",
+	"tvdpll1_d8",
+	"tvdpll1_d16"
+};
+static const u8 edp_parents_idx[] = { 0, 1, 3, 5, 7 };
 
 static const char * const disp_pwm_parents[] = {
 	"clk26m",
@@ -957,11 +968,11 @@ static const struct mtk_mux top_mtk_muxes[] = {
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_PWRMCU, "top_pwrmcu",
 		pwrmcu_parents, 0x08C, 0x090, 0x094, 16, 3, 23, 0x08, 6,
 		CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_DP, "top_dp",
-		dp_parents, 0x08C, 0x090, 0x094, 24, 4, 31, 0x08, 7),
+	MUX_GATE_CLR_SET_UPD_INDEXED(CLK_TOP_DP, "top_dp",
+		dp_parents, dp_parents_idx, 0x08C, 0x090, 0x094, 24, 4, 31, 0x08, 7),
 	/* CLK_CFG_10 */
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_EDP, "top_edp",
-		dp_parents, 0x098, 0x09C, 0x0A0, 0, 4, 7, 0x08, 8),
+	MUX_GATE_CLR_SET_UPD_INDEXED(CLK_TOP_EDP, "top_edp",
+		edp_parents, edp_parents_idx, 0x098, 0x09C, 0x0A0, 0, 4, 7, 0x08, 8),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_DPI, "top_dpi",
 		dp_parents, 0x098, 0x09C, 0x0A0, 8, 4, 15, 0x08, 9),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_DISP_PWM0, "top_disp_pwm0",
-- 
2.42.0

