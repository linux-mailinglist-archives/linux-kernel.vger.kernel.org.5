Return-Path: <linux-kernel+bounces-148928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0A28A8917
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934141C22F48
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8282D17106C;
	Wed, 17 Apr 2024 16:43:33 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC17A16FF5E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 16:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713372213; cv=none; b=gOYVv2dxpeWkT1n/ihQjdASkCkmlmhL8nEaP9CxQY1VTxbm6po/G0Ig4VDA1AAeDm0LjKzzpqgvEChLvo/ikyNstHpm9FaS2TB7kZr25jsMygx6knSUnNXqqordDr+3WFJy859m4B0vPwgUWKKOHE/feD2YGoV8U/8U0bbv9uFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713372213; c=relaxed/simple;
	bh=Z9l2/soyE5tzoITheZvO69xxT5aKufMAHBzJHx8l/e0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q0c6x0GIvExs0SM6gKH7+qUi0KeGdBIGILftj0sU2PqiN666kigOzN0vDtFYx0sxMRkF01EIG2JOF7+sMbBAUCx9JYM510gyr9nA7NZJckyByWFvc+z0Ha0TWm9YSR+2vxHh/8ggOPSVgGNtVwh2seQ1+93ZxbqesfLG20QABFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rx8NT-0007N3-VQ; Wed, 17 Apr 2024 18:43:19 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rx8NR-00CpCe-S0; Wed, 17 Apr 2024 18:43:17 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rx8NR-007MeM-2W;
	Wed, 17 Apr 2024 18:43:17 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH net-next v1 4/4] net: stmmac: use delays reported by the PHY driver to correct MAC propagation delay
Date: Wed, 17 Apr 2024 18:43:16 +0200
Message-Id: <20240417164316.1755299-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240417164316.1755299-1-o.rempel@pengutronix.de>
References: <20240417164316.1755299-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Now after PHY drivers are able to report data path delays, we can use
them in the MAC drivers for the delay correction.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h    |  2 ++
 .../ethernet/stmicro/stmmac/stmmac_hwtstamp.c   |  4 ++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c   | 17 ++++++++++++++++-
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index dddcaa9220cc3..6db54ce33ea72 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -288,6 +288,8 @@ struct stmmac_priv {
 	u32 sub_second_inc;
 	u32 systime_flags;
 	u32 adv_ts;
+	u64 phy_tx_delay_ns;
+	u64 phy_rx_delay_ns;
 	int use_riwt;
 	int irq_wake;
 	rwlock_t ptp_lock;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
index f05bd757dfe52..bbf284cb7cc2a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -71,6 +71,8 @@ static void hwtstamp_correct_latency(struct stmmac_priv *priv)
 	/* MAC-internal ingress latency */
 	scaled_ns = readl(ioaddr + PTP_TS_INGR_LAT);
 
+	scaled_ns += priv->phy_rx_delay_ns << 16;
+
 	/* See section 11.7.2.5.3.1 "Ingress Correction" on page 4001 of
 	 * i.MX8MP Applications Processor Reference Manual Rev. 1, 06/2021
 	 */
@@ -95,6 +97,8 @@ static void hwtstamp_correct_latency(struct stmmac_priv *priv)
 	/* MAC-internal egress latency */
 	scaled_ns = readl(ioaddr + PTP_TS_EGR_LAT);
 
+	scaled_ns += priv->phy_tx_delay_ns << 16;
+
 	reg_tsec = scaled_ns >> 16;
 	reg_tsecsns = scaled_ns & 0xff00;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index fe3498e86de9d..30c7c278b7062 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1097,8 +1097,23 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 	if (priv->dma_cap.fpesel)
 		stmmac_fpe_link_state_handle(priv, true);
 
-	if (priv->plat->flags & STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY)
+	if (priv->plat->flags & STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY) {
+		int ret = 0;
+
+		if (phy)
+			ret = phy_get_timesync_data_path_delays(phy,
+								&priv->phy_tx_delay_ns,
+								&priv->phy_rx_delay_ns);
+		if (!phy || ret) {
+			if (ret != -EOPNOTSUPP)
+				netdev_err(priv->dev, "Failed to get PHY delay: %pe\n",
+					   ERR_PTR(ret));
+			priv->phy_tx_delay_ns = 0;
+			priv->phy_rx_delay_ns = 0;
+		}
+
 		stmmac_hwtstamp_correct_latency(priv, priv);
+	}
 }
 
 static const struct phylink_mac_ops stmmac_phylink_mac_ops = {
-- 
2.39.2


