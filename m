Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053787C68F1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235508AbjJLJCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbjJLJCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:02:41 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E3810D
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:02:38 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qqraM-0000CJ-Lr; Thu, 12 Oct 2023 11:02:26 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qqraK-0016dM-WC; Thu, 12 Oct 2023 11:02:25 +0200
Received: from localhost ([::1] helo=dude03.red.stw.pengutronix.de)
        by dude03.red.stw.pengutronix.de with esmtp (Exim 4.96)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qqral-00FyMl-1O;
        Thu, 12 Oct 2023 11:02:24 +0200
From:   Johannes Zink <j.zink@pengutronix.de>
Date:   Thu, 12 Oct 2023 11:02:15 +0200
Subject: [PATCH net-next 4/5] net: stmmac: ptp: stmmac_enable(): move
 change of plat->flags into mutex
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231010-stmmac_fix_auxiliary_event_capture-v1-4-3eeca9e844fa@pengutronix.de>
References: <20231010-stmmac_fix_auxiliary_event_capture-v1-0-3eeca9e844fa@pengutronix.de>
In-Reply-To: <20231010-stmmac_fix_auxiliary_event_capture-v1-0-3eeca9e844fa@pengutronix.de>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Kurt Kanzenbach <kurt@linutronix.de>
Cc:     patchwork-jzi@pengutronix.de, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Johannes Zink <j.zink@pengutronix.de>
X-Mailer: b4 0.12.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparation patch. The next patch will check if an external TS
is active and return with an error. So we have to move the change of the
plat->flags that tracks if external timestamping is enabled after that
check.

Prepare for this change and move the plat->flags change into the mutex
and the if (on).

Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 60e3d3ff42f3..2a141db70c2e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -192,17 +192,17 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 		write_unlock_irqrestore(&priv->ptp_lock, flags);
 		break;
 	case PTP_CLK_REQ_EXTTS:
-		if (on)
-			priv->plat->flags |= STMMAC_FLAG_EXT_SNAPSHOT_EN;
-		else
-			priv->plat->flags &= ~STMMAC_FLAG_EXT_SNAPSHOT_EN;
 		mutex_lock(&priv->aux_ts_lock);
 		acr_value = readl(ptpaddr + PTP_ACR);
 		acr_value &= ~PTP_ACR_MASK;
 		if (on) {
+			priv->plat->flags |= STMMAC_FLAG_EXT_SNAPSHOT_EN;
+
 			/* Enable External snapshot trigger */
 			acr_value |= PTP_ACR_ATSEN(rq->extts.index);
 			acr_value |= PTP_ACR_ATSFC;
+		} else {
+			priv->plat->flags &= ~STMMAC_FLAG_EXT_SNAPSHOT_EN;
 		}
 		netdev_dbg(priv->dev, "Auxiliary Snapshot %d %s.\n",
 			   rq->extts.index, on ? "enabled" : "disabled");

-- 
2.39.2

