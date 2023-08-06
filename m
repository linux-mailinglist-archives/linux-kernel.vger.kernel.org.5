Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD40771535
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 15:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjHFNIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 09:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjHFNIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 09:08:00 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050:0:465::102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C0613E;
        Sun,  6 Aug 2023 06:07:45 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RJfrG08w3z9sNX;
        Sun,  6 Aug 2023 15:07:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1691327262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EgnnlUl7wAsOZuNby/ZOzIkp3rYwogNkugsRmSM4dN4=;
        b=Oamc0eUc+caJbT3llSZ/q6b+lWvtssblgMESdXbBqF+aDwaRcE43PwpdliTubte0OM/mpr
        RbaqPgMmpDMyPoXcQ5Wh7gJ5BsS3qwMvj/dA1R0qAbYR1rgWGmp6Vfxk/bjO3z48xmZf6l
        kgeRq3u3cQKCVV5g/70bM5FGSQjwo+rngM+GrdcYRdOsBgK3TcAeDvOfbqZnYJMaEtJsAD
        e8paPNb/t5u5u6F9Y4RbgkV7BGC1uc4YyhzF41tthWjS+rzHeRPwqLrrHcUxT7Xxmz8GkF
        8ELsGNroP1p0nfHmvkCfHofrd7O3O8wtyMSH8KK5Cv0b7M18KPkHPhcLPicong==
From:   Frank Oltmanns <frank@oltmanns.dev>
Date:   Sun, 06 Aug 2023 15:06:55 +0200
Subject: [PATCH v5 10/11] clk: sunxi-ng: a64: select closest rate for
 pll-video0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230806-pll-mipi_set_rate_parent-v5-10-db4f5ca33fc3@oltmanns.dev>
References: <20230806-pll-mipi_set_rate_parent-v5-0-db4f5ca33fc3@oltmanns.dev>
In-Reply-To: <20230806-pll-mipi_set_rate_parent-v5-0-db4f5ca33fc3@oltmanns.dev>
To:     Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Roman Beranek <me@crly.cz>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Frank Oltmanns <frank@oltmanns.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4345; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=Gs6RR7GAGvt8jNifuVDTyJFgyhezVvB3N0uotsIXiYE=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBkz5sI2W3KVoFsEpyhNZufEpHKsMDFj2N3dECmG
 IZH7swpYoSJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZM+bCAAKCRCaaaIIlErT
 x/GkC/0Uvn309wWj85qTwxXJHBkGmcPgf4dl2G/5cczIUB2bwI5DSBy5ia2SgsqNAn0S+ShjyJJ
 agTwcjYGOBXe0CHhf21Td5DISs+c/5VlVCEOTFJsMe50dv4Xt5QWh8o5vPvKwgtPNZD7gQuzi4o
 c7oKYEH+0RoMrE+7L1pjvoFdkhj2pdf2Z5b4fgqxa1zENKCWNb26PFtKVKBKGgIgRyKdcNiJkYe
 xJnwVFTXAEx8QhNdddzhy/Mg6UMXwqWsVOfk7egYsnfwcS0BLEWkimt8yJl7Ebh+aq1XasrNyr9
 B5Sse+Pk36DYsNT8T/KQhnwLYt7jvvIM6SCYFTZfabhuHz1WuKgpeKx1iXPURDfYzoNL+IvPrdm
 yHc8mjvTyBV4auuuWeI0PMAv/HyaLtopaKbRqMbRbN8vc5JO01HmtmJcWm2qaQHqa73I2avoir4
 F7IkVC76qStDcgYlHPMBMItgai5GVsNBAyWJvwDv9zEgTYo9ixoUZ4zaBmH6xBPE/y9KU=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Selecting the closest rate for pll-video0 instead of the closest rate
that is less than the requested rate has no downside for this clock,
while allowing for selecting a more suitable rate, e.g. for the
connected panels.

Furthermore, the algorithm that sets an NKM clock's parent benefits from
the closest rate. Without it, the NKM clock's rate might drift away from
the requested rate in the multiple successive calls to
ccu_nkm_determine_rate that the clk framework performs when setting a
clock rate.

Therefore, configure pll-video0 and, in consequence, all of its
descendents to select the closest rate.

Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index a139a5c438d4..73c84d20f3ee 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -68,7 +68,7 @@ static SUNXI_CCU_NM_WITH_SDM_GATE_LOCK(pll_audio_base_clk, "pll-audio-base",
 				       BIT(28),	/* lock */
 				       CLK_SET_RATE_UNGATE);
 
-static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX(pll_video0_clk, "pll-video0",
+static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_CLOSEST(pll_video0_clk, "pll-video0",
 						"osc24M", 0x010,
 						192000000,	/* Minimum rate */
 						1008000000,	/* Maximum rate */
@@ -181,6 +181,7 @@ static struct ccu_nkm pll_mipi_clk = {
 		.hw.init	= CLK_HW_INIT("pll-mipi", "pll-video0",
 					      &ccu_nkm_ops,
 					      CLK_SET_RATE_UNGATE | CLK_SET_RATE_PARENT),
+		.features	= CCU_FEATURE_CLOSEST_RATE,
 	},
 };
 
@@ -531,24 +532,18 @@ static SUNXI_CCU_M_WITH_MUX_GATE(de_clk, "de", de_parents,
 
 static const char * const tcon0_parents[] = { "pll-mipi", "pll-video0-2x" };
 static const u8 tcon0_table[] = { 0, 2, };
-static SUNXI_CCU_MUX_TABLE_WITH_GATE(tcon0_clk, "tcon0", tcon0_parents,
+static SUNXI_CCU_MUX_TABLE_WITH_GATE_CLOSEST(tcon0_clk, "tcon0", tcon0_parents,
 				     tcon0_table, 0x118, 24, 3, BIT(31),
 				     CLK_SET_RATE_PARENT);
 
 static const char * const tcon1_parents[] = { "pll-video0", "pll-video1" };
 static const u8 tcon1_table[] = { 0, 2, };
-static struct ccu_div tcon1_clk = {
-	.enable		= BIT(31),
-	.div		= _SUNXI_CCU_DIV(0, 4),
-	.mux		= _SUNXI_CCU_MUX_TABLE(24, 2, tcon1_table),
-	.common		= {
-		.reg		= 0x11c,
-		.hw.init	= CLK_HW_INIT_PARENTS("tcon1",
-						      tcon1_parents,
-						      &ccu_div_ops,
-						      CLK_SET_RATE_PARENT),
-	},
-};
+static SUNXI_CCU_M_WITH_MUX_TABLE_GATE_CLOSEST(tcon1_clk, "tcon1", tcon1_parents,
+					       tcon1_table, 0x11c,
+					       0, 4,	/* M */
+					       24, 2,	/* mux */
+					       BIT(31),	/* gate */
+					       CLK_SET_RATE_PARENT);
 
 static const char * const deinterlace_parents[] = { "pll-periph0", "pll-periph1" };
 static SUNXI_CCU_M_WITH_MUX_GATE(deinterlace_clk, "deinterlace", deinterlace_parents,
@@ -578,8 +573,8 @@ static SUNXI_CCU_GATE(avs_clk,		"avs",		"osc24M",
 		      0x144, BIT(31), 0);
 
 static const char * const hdmi_parents[] = { "pll-video0", "pll-video1" };
-static SUNXI_CCU_M_WITH_MUX_GATE(hdmi_clk, "hdmi", hdmi_parents,
-				 0x150, 0, 4, 24, 2, BIT(31), CLK_SET_RATE_PARENT);
+static SUNXI_CCU_M_WITH_MUX_GATE_CLOSEST(hdmi_clk, "hdmi", hdmi_parents,
+					 0x150, 0, 4, 24, 2, BIT(31), CLK_SET_RATE_PARENT);
 
 static SUNXI_CCU_GATE(hdmi_ddc_clk,	"hdmi-ddc",	"osc24M",
 		      0x154, BIT(31), 0);
@@ -591,9 +586,9 @@ static SUNXI_CCU_M_WITH_MUX_GATE(mbus_clk, "mbus", mbus_parents,
 
 static const char * const dsi_dphy_parents[] = { "pll-video0", "pll-periph0" };
 static const u8 dsi_dphy_table[] = { 0, 2, };
-static SUNXI_CCU_M_WITH_MUX_TABLE_GATE(dsi_dphy_clk, "dsi-dphy",
-				       dsi_dphy_parents, dsi_dphy_table,
-				       0x168, 0, 4, 8, 2, BIT(15), CLK_SET_RATE_PARENT);
+static SUNXI_CCU_M_WITH_MUX_TABLE_GATE_CLOSEST(dsi_dphy_clk, "dsi-dphy",
+					       dsi_dphy_parents, dsi_dphy_table,
+					       0x168, 0, 4, 8, 2, BIT(15), CLK_SET_RATE_PARENT);
 
 static SUNXI_CCU_M_WITH_GATE(gpu_clk, "gpu", "pll-gpu",
 			     0x1a0, 0, 3, BIT(31), CLK_SET_RATE_PARENT);

-- 
2.41.0

