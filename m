Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF437765F5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 19:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbjHIRCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbjHIRCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:02:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2192106;
        Wed,  9 Aug 2023 10:02:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B5D5641C3;
        Wed,  9 Aug 2023 17:02:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F458C433CD;
        Wed,  9 Aug 2023 17:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691600520;
        bh=DE4uo4JK2isjtFObJJyFLlrT5b6CK5kuMo4uw+Jhg2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JFN6RYl+M59YpWe19hAChu5SWzQB35nUp6hDH8BPSvUnpKx+NF67xEXL973v0+iFA
         TGP89k4RRXhABdvN2W/azWDTKPMFI8EdXLVK3dM9dpW0tPGHNrrZ9+/JZlbAR4G2Jo
         ZeZ1O0hxTM4wpzr04uaJaAj1HVdeeVB9UOjW6P6a9aSf72SMMtlE63TtxQLvwdvrg6
         FMQSzTEIbp4Aygb5LqkP5LD6HB/89fr7vnxDbBzniKXx9RmhvU31Y0QcQ2jF9m2DgG
         h7S5q3X4/qYytyNUkhxXsgc/CtiJziehwwDwnqjTeXW28QF7JDPGLuFT3wIIG7O+pS
         YcsQZk9Y4C4yA==
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
Subject: [PATCH net-next v3 04/10] net: stmmac: enlarge max rx/tx queues and channels to 16
Date:   Thu, 10 Aug 2023 00:50:01 +0800
Message-Id: <20230809165007.1439-5-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230809165007.1439-1-jszhang@kernel.org>
References: <20230809165007.1439-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xgmac supports up to 16 rx/tx queues and up to 16 channels.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 5 ++---
 include/linux/stmmac.h                              | 6 +++---
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index a0c2ef8bb0ac..aaae82d3d9dc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -202,9 +202,8 @@ static void dwxgmac2_map_mtl_to_dma(struct mac_device_info *hw, u32 queue,
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value, reg;
 
-	reg = (queue < 4) ? XGMAC_MTL_RXQ_DMA_MAP0 : XGMAC_MTL_RXQ_DMA_MAP1;
-	if (queue >= 4)
-		queue -= 4;
+	reg = XGMAC_MTL_RXQ_DMA_MAP0 + (queue & ~0x3);
+	queue &= 0x3;
 
 	value = readl(ioaddr + reg);
 	value &= ~XGMAC_QxMDMACH(queue);
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index ef67dba775d0..11671fd6adee 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -15,9 +15,9 @@
 #include <linux/platform_device.h>
 #include <linux/phy.h>
 
-#define MTL_MAX_RX_QUEUES	8
-#define MTL_MAX_TX_QUEUES	8
-#define STMMAC_CH_MAX		8
+#define MTL_MAX_RX_QUEUES	16
+#define MTL_MAX_TX_QUEUES	16
+#define STMMAC_CH_MAX		16
 
 #define STMMAC_RX_COE_NONE	0
 #define STMMAC_RX_COE_TYPE1	1
-- 
2.40.1

