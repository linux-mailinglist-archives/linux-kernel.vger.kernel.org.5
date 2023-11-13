Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544157EA553
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 22:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjKMVMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 16:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKMVMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 16:12:52 -0500
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A0A10D9;
        Mon, 13 Nov 2023 13:12:49 -0800 (PST)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1r2eEa-0004c2-1b;
        Mon, 13 Nov 2023 21:12:40 +0000
Date:   Mon, 13 Nov 2023 21:12:36 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Daniel Golle <daniel@makrotopia.org>,
        Jianhui Zhao <zhaojh329@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        "Garmin.Chang" <Garmin.Chang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 3/4] clk: mediatek: Add pcw_chg_shift control
Message-ID: <7b0b54dd3c248d8bb0daef8be91996d36b2aefd4.1699909748.git.daniel@makrotopia.org>
References: <cde7269e5975907ed2b7799328ea814e529ecf51.1699909748.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cde7269e5975907ed2b7799328ea814e529ecf51.1699909748.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce pcw_chg_shfit control to optionally use that instead of the
hardcoded PCW_CHG_MASK macro.
This will needed for clocks on the MT7988 SoC.

Signed-off-by: Sam Shih <sam.shih@mediatek.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/clk/mediatek/clk-pll.c | 5 ++++-
 drivers/clk/mediatek/clk-pll.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index 513ab6b1b3229..9f08bc5d2a8a2 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -114,7 +114,10 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
 			pll->data->pcw_shift);
 	val |= pcw << pll->data->pcw_shift;
 	writel(val, pll->pcw_addr);
-	chg = readl(pll->pcw_chg_addr) | PCW_CHG_MASK;
+	if (pll->data->pcw_chg_shift)
+		chg = readl(pll->pcw_chg_addr) | BIT(pll->data->pcw_chg_shift);
+	else
+		chg = readl(pll->pcw_chg_addr) | PCW_CHG_MASK;
 	writel(chg, pll->pcw_chg_addr);
 	if (pll->tuner_addr)
 		writel(val + 1, pll->tuner_addr);
diff --git a/drivers/clk/mediatek/clk-pll.h b/drivers/clk/mediatek/clk-pll.h
index f17278ff15d78..d28d317e84377 100644
--- a/drivers/clk/mediatek/clk-pll.h
+++ b/drivers/clk/mediatek/clk-pll.h
@@ -44,6 +44,7 @@ struct mtk_pll_data {
 	u32 pcw_reg;
 	int pcw_shift;
 	u32 pcw_chg_reg;
+	int pcw_chg_shift;
 	const struct mtk_pll_div_table *div_table;
 	const char *parent_name;
 	u32 en_reg;
-- 
2.42.1
