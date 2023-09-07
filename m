Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBF47978F9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbjIGQ7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243156AbjIGQh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:37:58 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC33049C7;
        Thu,  7 Sep 2023 08:39:50 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qeGiL-0001J0-1g;
        Thu, 07 Sep 2023 15:14:37 +0000
Date:   Thu, 7 Sep 2023 16:14:20 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH net] net: ethernet: mtk_eth_soc: fix uninitialized variable
Message-ID: <51d1ae238aecde07b2b4fe02cdab0dc87287cd96.1694099183.git.daniel@makrotopia.org>
References: <9918f1ae-5604-4bdc-a654-e0566ca77ad6@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9918f1ae-5604-4bdc-a654-e0566ca77ad6@moroto.mountain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable dma_addr in function mtk_poll_rx can be uninitialized on
some of the error paths. In practise this doesn't matter, even random
data present in uninitialized stack memory can safely be used in the
way it happens in the error path.

However, in order to make Smatch happy make sure the variable is
always initialized.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 31090490d47ce..6342eac90793e 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2119,11 +2119,11 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 	u8 *data, *new_data;
 	struct mtk_rx_dma_v2 *rxd, trxd;
 	int done = 0, bytes = 0;
+	dma_addr_t dma_addr = NULL;
 
 	while (done < budget) {
 		unsigned int pktlen, *rxdcsum;
 		struct net_device *netdev;
-		dma_addr_t dma_addr;
 		u32 hash, reason;
 		int mac = 0;
 
-- 
2.42.0
