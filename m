Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121617F5D2A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344884AbjKWLCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjKWLCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:02:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B224A1BF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:02:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62CFBC433C7;
        Thu, 23 Nov 2023 11:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700737335;
        bh=wGEC7NeVuil562coNYSljHzRxwtVUGQAUh7l2e2swGA=;
        h=From:To:Cc:Subject:Date:From;
        b=Dn6wlwSYfiG7Sidrra0kIMHkZaNULLwwBRrTsZLHXaDjU9uyw3MIYxtdhe4Mmm4lZ
         htgWBW2kjBpWattsDiGm95gY0c6oZ/qfw0fEj/lsgfIuDvt0bnqlUzQDVpsuhfhrSW
         jqLWo2DOAJilMah1rmmFYa/vwFnL3Sl9Q66WNnHPpDpS0MZl8bwTO3dnR6AT1ciLHo
         ob5udTeYtRofrHZp286+dX5hK1+s6vYy4knsFoGuQtWomA+nMFvq/mdNV9rInSq0xr
         7CGC0fo5B/x//hrPPmYPpshnnz+fVHSeAPgPQ7UE++s6pUIuhEE/YpJt1RVstdt8Jt
         b083dvF0JJf9A==
From:   Michael Walle <mwalle@kernel.org>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        CK Hu <ck.hu@mediatek.com>, Jitao Shi <jitao.shi@mediatek.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Walle <mwalle@kernel.org>
Subject: [PATCH] phy: mediatek: mipi: mt8183: fix minimal supported frequency
Date:   Thu, 23 Nov 2023 12:02:02 +0100
Message-Id: <20231123110202.2025585-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lowest supported clock frequency of the PHY is 125MHz (see also
mtk_mipi_tx_pll_enable()), but the clamping in .round_rate() has the
wrong minimal value, which will make the .enable() op return -EINVAL on
low frequencies. Fix the minimal clamping value.

Fixes: efda51a58b4a ("drm/mediatek: add mipi_tx driver for mt8183")
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
index f021ec5a70e5..553725e1269c 100644
--- a/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
+++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
@@ -100,7 +100,7 @@ static void mtk_mipi_tx_pll_disable(struct clk_hw *hw)
 static long mtk_mipi_tx_pll_round_rate(struct clk_hw *hw, unsigned long rate,
 				       unsigned long *prate)
 {
-	return clamp_val(rate, 50000000, 1600000000);
+	return clamp_val(rate, 125000000, 1600000000);
 }
 
 static const struct clk_ops mtk_mipi_tx_pll_ops = {
-- 
2.39.2

