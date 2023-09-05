Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A189792AB7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244195AbjIEQkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354425AbjIELdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:33:12 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0091AB;
        Tue,  5 Sep 2023 04:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1693913588;
  x=1725449588;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=HtxaOh0HXiNtmtO9oVDVopIAjyLosZo9U19YoUIEmw0=;
  b=X8I9yFOuZ2bCPY2vLTs/ptX4mtm3Ibpmohq6GQJWJ4uIBVmfobN1yQiU
   XLkfOM2JNeoDrDXSTBtFyUh/yhD602ibZs5/gVr3bJVihjrS9c0qI4DYI
   SkvwFeczsuwFcB9L9MAmhZ1SZ4vdj6WRERRmfeBjiplL15bdl3cjMI9CG
   GnxJxMZbtNPQtn61D/E1x/+dabxEHCK2ZhdFZ7quyKJZCr2GEunOiISFq
   RNgEP7aCN953f+sBi5I7RnlFvwreDFS0UKgjK07+0ep1WXrnjuTzUFO3E
   OdRpUWY5BdKH3kbqx7lroUp/zW/Tdo0Jc9HxHSEghzhdUbcb6wZdjKHvJ
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Tue, 5 Sep 2023 13:32:48 +0200
Subject: [PATCH net] net: stmmac: fix handling of zero coalescing tx-usecs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230905-stmmac-coaloff-v1-1-e29820e8ff6d@axis.com>
X-B4-Tracking: v=1; b=H4sIAN8R92QC/x3MQQqAIBBA0avErBPMIqirRIvRxhpIDY0IxLsnL
 d/i/wyJIlOCuckQ6eHEwVd0bQPmQL+T4K0alFS9nOQg0u0cGmECnsFagQZHTVZvatBQoyuS5fc
 fLuDphrWUD/eQ/oJlAAAA
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     Felix Fietkau <nbd@nbd.name>,
        Maxim Mikityanskiy <maxtram95@gmail.com>,
        <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting ethtool -C eth0 tx-usecs 0 is supposed to disable the use of the
coalescing timer but currently it gets programmed with zero delay
instead.

Disable the use of the coalescing timer if tx-usecs is zero by
preventing it from being restarted.  Note that to keep things simple we
don't start/stop the timer when the coalescing settings are changed, but
just let that happen on the next transmit or timer expiry.

Fixes: 8fce33317023 ("net: stmmac: Rework coalesce timer and fix multi-queue races")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 4727f7be4f86..6931973028ae 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2703,9 +2703,7 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue)
 
 	/* We still have pending packets, let's call for a new scheduling */
 	if (tx_q->dirty_tx != tx_q->cur_tx)
-		hrtimer_start(&tx_q->txtimer,
-			      STMMAC_COAL_TIMER(priv->tx_coal_timer[queue]),
-			      HRTIMER_MODE_REL);
+		stmmac_tx_timer_arm(priv, queue);
 
 	__netif_tx_unlock_bh(netdev_get_tx_queue(priv->dev, queue));
 
@@ -2986,9 +2984,13 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
 static void stmmac_tx_timer_arm(struct stmmac_priv *priv, u32 queue)
 {
 	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
+	u32 tx_coal_timer = priv->tx_coal_timer[queue];
+
+	if (!tx_coal_timer)
+		return;
 
 	hrtimer_start(&tx_q->txtimer,
-		      STMMAC_COAL_TIMER(priv->tx_coal_timer[queue]),
+		      STMMAC_COAL_TIMER(tx_coal_timer),
 		      HRTIMER_MODE_REL);
 }
 

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230904-stmmac-coaloff-aca6befbd24b

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>

