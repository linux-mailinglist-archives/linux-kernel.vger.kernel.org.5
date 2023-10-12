Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5047C68ED
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbjJLJCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbjJLJCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:02:41 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5CEA9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:02:37 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qqraM-0000CL-Lt; Thu, 12 Oct 2023 11:02:26 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qqraL-0016dN-0h; Thu, 12 Oct 2023 11:02:25 +0200
Received: from localhost ([::1] helo=dude03.red.stw.pengutronix.de)
        by dude03.red.stw.pengutronix.de with esmtp (Exim 4.96)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qqral-00FyMl-1P;
        Thu, 12 Oct 2023 11:02:24 +0200
From:   Johannes Zink <j.zink@pengutronix.de>
Date:   Thu, 12 Oct 2023 11:02:16 +0200
Subject: [PATCH net-next 5/5] net: stmmac: do not silently change auxiliary
 snapshot capture channel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231010-stmmac_fix_auxiliary_event_capture-v1-5-3eeca9e844fa@pengutronix.de>
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

Even though the hardware theoretically supports up to 4 simultaneous
auxiliary snapshot capture channels, the stmmac driver does support only
a single channel to be active at a time.

Previously in case of a PTP_CLK_REQ_EXTTS request, previously active
auxiliary snapshot capture channels were silently dropped and the new
channel was activated.

Instead of silently changing the state for all consumers, log an error
and return -EBUSY if a channel is already in use in order to signal to
userspace to disable the currently active channel before enabling another one.

Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 2a141db70c2e..56683afc650c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -191,11 +191,23 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 					     priv->systime_flags);
 		write_unlock_irqrestore(&priv->ptp_lock, flags);
 		break;
-	case PTP_CLK_REQ_EXTTS:
+	case PTP_CLK_REQ_EXTTS: {
+		u8 channel;
+
 		mutex_lock(&priv->aux_ts_lock);
 		acr_value = readl(ptpaddr + PTP_ACR);
+		channel = ilog2(FIELD_GET(PTP_ACR_MASK, acr_value));
 		acr_value &= ~PTP_ACR_MASK;
+
 		if (on) {
+			if (FIELD_GET(PTP_ACR_MASK, acr_value)) {
+				netdev_err(priv->dev,
+					   "Cannot enable auxiliary snapshot %d as auxiliary snapshot %d is already enabled",
+					rq->extts.index, channel);
+				mutex_unlock(&priv->aux_ts_lock);
+				return -EBUSY;
+			}
+
 			priv->plat->flags |= STMMAC_FLAG_EXT_SNAPSHOT_EN;
 
 			/* Enable External snapshot trigger */
@@ -213,6 +225,7 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 					 !(acr_value & PTP_ACR_ATSFC),
 					 10, 10000);
 		break;
+	}
 
 	default:
 		break;

-- 
2.39.2

