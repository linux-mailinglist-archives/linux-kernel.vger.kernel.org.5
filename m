Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADB47765EF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 19:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjHIRCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjHIRB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:01:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D072100;
        Wed,  9 Aug 2023 10:01:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A473641BB;
        Wed,  9 Aug 2023 17:01:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC994C43395;
        Wed,  9 Aug 2023 17:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691600514;
        bh=xPpxwJzBLsCaca6qQZWRTcviG5VQc7YuCxtBnfOO0Sc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ftjeWrM2vszKk0pjhd+iTUqKRNmgdY1xZjDlMzt5r946dcWZeTuzXpMXhTWepbwms
         FEyiMj65e6ZxDlJsDTz6TLJHsZUq/TGnRIy8xcd0VxzDf92xW/rZSjSvAb3scYb/od
         rzqe5DdkB81Dg+uPVTqCgeOzEoGH1+1J2JDsKgsDhpVf6nLCCbHivao/q9iuIKc1wr
         EEk77jrxEbC7B5sn6dFiQAGCRNC8XnAhX8hpGw3o0qWlY+3nqumnfRojn4UISfTW9m
         fOx+ywo9pD1aFXWEc6YK/OnGP/5bslpHQyanjdby3W++CMvpCH3lJVTf8sGOQWpIsx
         nOcbFtlOD+6IA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v3 02/10] net: stmmac: xgmac: add more feature parsing from hw cap
Date:   Thu, 10 Aug 2023 00:49:59 +0800
Message-Id: <20230809165007.1439-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230809165007.1439-1-jszhang@kernel.org>
References: <20230809165007.1439-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XGMAC_HWFEAT_GMIISEL bit also indicates whether support 10/100Mbps
or not.
The XGMAC_HWFEAT_HDSEL bit indicates whether support half duplex or
not.
The XGMAC_HWFEAT_ADDMACADRSEL bit indicates whether support Multiple
MAC address registers or not.
The XGMAC_HWFEAT_SMASEL bit indicates whether support SMA (MDIO)
Interface or not.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     | 3 +++
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 153321fe42c3..81cbb13a101d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -111,6 +111,7 @@
 #define XGMAC_LPI_TIMER_CTRL		0x000000d4
 #define XGMAC_HW_FEATURE0		0x0000011c
 #define XGMAC_HWFEAT_SAVLANINS		BIT(27)
+#define XGMAC_HWFEAT_ADDMACADRSEL	GENMASK(22, 18)
 #define XGMAC_HWFEAT_RXCOESEL		BIT(16)
 #define XGMAC_HWFEAT_TXCOESEL		BIT(14)
 #define XGMAC_HWFEAT_EEESEL		BIT(13)
@@ -121,7 +122,9 @@
 #define XGMAC_HWFEAT_MMCSEL		BIT(8)
 #define XGMAC_HWFEAT_MGKSEL		BIT(7)
 #define XGMAC_HWFEAT_RWKSEL		BIT(6)
+#define XGMAC_HWFEAT_SMASEL		BIT(5)
 #define XGMAC_HWFEAT_VLHASH		BIT(4)
+#define XGMAC_HWFEAT_HDSEL		BIT(3)
 #define XGMAC_HWFEAT_GMIISEL		BIT(1)
 #define XGMAC_HW_FEATURE1		0x00000120
 #define XGMAC_HWFEAT_L3L4FNUM		GENMASK(30, 27)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index b09395f5edcb..b5ba4e0cca55 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -406,6 +406,10 @@ static int dwxgmac2_get_hw_feature(void __iomem *ioaddr,
 	dma_cap->pmt_remote_wake_up = (hw_cap & XGMAC_HWFEAT_RWKSEL) >> 6;
 	dma_cap->vlhash = (hw_cap & XGMAC_HWFEAT_VLHASH) >> 4;
 	dma_cap->mbps_1000 = (hw_cap & XGMAC_HWFEAT_GMIISEL) >> 1;
+	dma_cap->mbps_10_100 = (hw_cap & XGMAC_HWFEAT_GMIISEL) >> 1;
+	dma_cap->half_duplex = (hw_cap & XGMAC_HWFEAT_HDSEL) >> 3;
+	dma_cap->multi_addr = (hw_cap & XGMAC_HWFEAT_ADDMACADRSEL) >> 18;
+	dma_cap->sma_mdio = (hw_cap & XGMAC_HWFEAT_SMASEL) >> 5;
 
 	/* MAC HW feature 1 */
 	hw_cap = readl(ioaddr + XGMAC_HW_FEATURE1);
-- 
2.40.1

