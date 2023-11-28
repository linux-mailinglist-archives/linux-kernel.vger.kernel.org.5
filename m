Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618147FB4C3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344234AbjK1IuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbjK1IuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:50:04 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91230E7;
        Tue, 28 Nov 2023 00:50:09 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2A138C0011;
        Tue, 28 Nov 2023 08:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701161408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qYJnE4Z1r7jKRPOrGAwXhHc797bbl+1US3cszB9aa9E=;
        b=Biez3ElIDFQtKoAoSEC77AQXzKbt7Ch1XeZiVYhh0NXtG9v9GlfxXJMHUGbOSfb77LUOcn
        3R+0msBidXWkzyP/oA03LjO59JoGEB8nwVxWQhzryO7/3lBgdfOGe+ccmpFTRzo+6Hyh/S
        GD+Y3ayQHKYfSpqkoEeBAFW7jASzaG7FBLQy3BcrLGsrxmfREYLffgYMaUk3magZpde8IY
        Jpkm3fVUL0fUT7BMlooYuZIqQDCRhLrK/p3fM+xSrJ+AkeIXExE94qMn2452ctDbzk7VWP
        2n/LDss+hsxqQFoi5sfx/ccHyQ5hgvuoH436OaEzpLi2b4pI+5FaKvrDAG795Q==
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Simon Horman <horms@kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        alexis.lothore@bootlin.com
Subject: [PATCH net] net: stmmac: dwmac-socfpga: Don't access SGMII adapter when not available
Date:   Tue, 28 Nov 2023 10:45:37 +0100
Message-ID: <20231128094538.228039-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SGMII adapter isn't present on all dwmac-socfpga implementations.
Make sure we don't try to configure it if we don't have this adapter.

Fixes: 5d1f3fe7d2d5 ("net: stmmac: dwmac-sogfpga: use the lynx pcs driver")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index ba2ce776bd4d..ae120792e1b6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -243,7 +243,8 @@ static void socfpga_sgmii_config(struct socfpga_dwmac *dwmac, bool enable)
 {
 	u16 val = enable ? SGMII_ADAPTER_ENABLE : SGMII_ADAPTER_DISABLE;
 
-	writew(val, dwmac->sgmii_adapter_base + SGMII_ADAPTER_CTRL_REG);
+	if (dwmac->sgmii_adapter_base)
+		writew(val, dwmac->sgmii_adapter_base + SGMII_ADAPTER_CTRL_REG);
 }
 
 static int socfpga_set_phy_mode_common(int phymode, u32 *val)
-- 
2.42.0

