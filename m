Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992B98063C2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 01:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376404AbjLFA5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 19:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjLFA5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 19:57:30 -0500
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F27D62;
        Tue,  5 Dec 2023 16:57:33 -0800 (PST)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1rAgE7-0002TW-12;
        Wed, 06 Dec 2023 00:57:24 +0000
Date:   Wed, 6 Dec 2023 00:57:20 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Daniel Golle <daniel@makrotopia.org>,
        Jianhui Zhao <zhaojh329@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        "Garmin.Chang" <Garmin.Chang@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: [PATCH v3 3/4] clk: mediatek: Add pcw_chg_shift control
Message-ID: <40981d0bb722eb509628bcf82c31f632e4cf747a.1701823757.git.daniel@makrotopia.org>
References: <23bc89d407e7797e97b703fa939b43bfe79296ce.1701823757.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23bc89d407e7797e97b703fa939b43bfe79296ce.1701823757.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Shih <sam.shih@mediatek.com>

Introduce pcw_chg_shfit control to optionally use that instead of the
hardcoded PCW_CHG_MASK macro.
This will needed for clocks on the MT7988 SoC.

Signed-off-by: Sam Shih <sam.shih@mediatek.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v3: use git --from ...
v2: no changes

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
2.43.0
