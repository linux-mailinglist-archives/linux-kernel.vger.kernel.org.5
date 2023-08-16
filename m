Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C198C77E562
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344258AbjHPPln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344219AbjHPPlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:41:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7042F26A6;
        Wed, 16 Aug 2023 08:41:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EB4D64577;
        Wed, 16 Aug 2023 15:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EDDAC433C8;
        Wed, 16 Aug 2023 15:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692200479;
        bh=nrZBBHIvwoY7+NGVTUVo+wQxGv/rQfcOhG+8CHuUfbw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C9DDETRHcmDn3/sjpx52V0ObTTzXJ88g3duA+PD4y0N2+ENXQpaqYfP1KCUg6CsQF
         cd8lPDX80SN4yQo5cc/HQ7ZK+j4MTYNyGi66qcc2R/WLTn7oIgUGEMGOF3EB4ZFBNd
         hTYzpuggcWcvg6SUX8PL2M8sMTDpciHjTHKn1WtclbXgkaavZ2E3lF/6pJIZWD+Zfi
         WBpgcapVp6pEypxnImqKGbudMs8zBd2UuFuLmW5vSLBtK6x/VNjxzNhhOvJ8AsF7ha
         G9VE0inA/4S1/mB+/Df5yxPCtXI1iD9jPQ61ur3FKetxVOCRUaeXtS7kWWRncwj/MV
         NuImxW7m1C9RA==
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
Subject: [PATCH net-next v4 2/9] net: stmmac: xgmac: add more feature parsing from hw cap
Date:   Wed, 16 Aug 2023 23:29:19 +0800
Message-Id: <20230816152926.4093-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230816152926.4093-1-jszhang@kernel.org>
References: <20230816152926.4093-1-jszhang@kernel.org>
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

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Acked-by: Alexandre TORGUE <alexandre.torgue@foss.st.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 3aacf791efeb..1ef8fc132c2d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -410,6 +410,7 @@ static int dwxgmac2_get_hw_feature(void __iomem *ioaddr,
 	dma_cap->vlhash = (hw_cap & XGMAC_HWFEAT_VLHASH) >> 4;
 	dma_cap->half_duplex = (hw_cap & XGMAC_HWFEAT_HDSEL) >> 3;
 	dma_cap->mbps_1000 = (hw_cap & XGMAC_HWFEAT_GMIISEL) >> 1;
+	dma_cap->mbps_10_100 = (hw_cap & XGMAC_HWFEAT_GMIISEL) >> 1;
 
 	/* MAC HW feature 1 */
 	hw_cap = readl(ioaddr + XGMAC_HW_FEATURE1);
-- 
2.40.1

