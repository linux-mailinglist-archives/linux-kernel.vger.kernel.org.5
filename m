Return-Path: <linux-kernel+bounces-74141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD1E85D061
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A10D1F2216D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F753AC10;
	Wed, 21 Feb 2024 06:21:23 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D71138F9B
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 06:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708496483; cv=none; b=R8FIjMV7/PQR9YKyz1REQA7cmmyK+NSOhYjHkuokO6L9KUp7OIti43EsgVea1kRfYS0hPwzXVrDEo0mvDNoKLjcSY2C+jL5hPc2j8ChDKSwZ0b9+nzJEFs4dYB+oWYr9Y/mMTgzxolg10Ln71J0+R3f1NqJEpNEmadXoLcqdA6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708496483; c=relaxed/simple;
	bh=ribYwwU2eYYQYy246dGBmImjTqf7cR9f+vDKzHX0BOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gSibx0FOWlYEviMyEq06VGDZPNmmzH3mK3IE05VNenCM5dhj5MOINFyxz2foJLYyTvZKGwDl22Oph2Qs+IEGkf8/TRPJiSLqgIRZxEhx8wR9zcOiZgFgA8BWOhkWC9RdT8NNKdrlMh+Eh9uycjEQJ8jl7NHiLVbZnUs4qqJF6qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rcfyh-00010V-4Z; Wed, 21 Feb 2024 07:21:11 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rcfye-001zFK-Py; Wed, 21 Feb 2024 07:21:08 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rcfye-003Gam-2H;
	Wed, 21 Feb 2024 07:21:08 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH net-next v5 7/8] net: fec: Move fec_enet_eee_mode_set() and helper earlier
Date: Wed, 21 Feb 2024 07:21:06 +0100
Message-Id: <20240221062107.778661-8-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240221062107.778661-1-o.rempel@pengutronix.de>
References: <20240221062107.778661-1-o.rempel@pengutronix.de>
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

From: Andrew Lunn <andrew@lunn.ch>

FEC is about to get its EEE code re-written. To allow this, move
fec_enet_eee_mode_set() before fec_enet_adjust_link() which will
need to call it.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/ethernet/freescale/fec_main.c | 75 ++++++++++++-----------
 1 file changed, 38 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 207f1f66c117..a2c786550342 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2017,6 +2017,44 @@ static int fec_get_mac(struct net_device *ndev)
 /*
  * Phy section
  */
+
+/* LPI Sleep Ts count base on tx clk (clk_ref).
+ * The lpi sleep cnt value = X us / (cycle_ns).
+ */
+static int fec_enet_us_to_tx_cycle(struct net_device *ndev, int us)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+
+	return us * (fep->clk_ref_rate / 1000) / 1000;
+}
+
+static int fec_enet_eee_mode_set(struct net_device *ndev, bool enable)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct ethtool_keee *p = &fep->eee;
+	unsigned int sleep_cycle, wake_cycle;
+	int ret = 0;
+
+	if (enable) {
+		ret = phy_init_eee(ndev->phydev, false);
+		if (ret)
+			return ret;
+
+		sleep_cycle = fec_enet_us_to_tx_cycle(ndev, p->tx_lpi_timer);
+		wake_cycle = sleep_cycle;
+	} else {
+		sleep_cycle = 0;
+		wake_cycle = 0;
+	}
+
+	p->tx_lpi_enabled = enable;
+
+	writel(sleep_cycle, fep->hwp + FEC_LPI_SLEEP);
+	writel(wake_cycle, fep->hwp + FEC_LPI_WAKE);
+
+	return 0;
+}
+
 static void fec_enet_adjust_link(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
@@ -3121,43 +3159,6 @@ static int fec_enet_set_coalesce(struct net_device *ndev,
 	return 0;
 }
 
-/* LPI Sleep Ts count base on tx clk (clk_ref).
- * The lpi sleep cnt value = X us / (cycle_ns).
- */
-static int fec_enet_us_to_tx_cycle(struct net_device *ndev, int us)
-{
-	struct fec_enet_private *fep = netdev_priv(ndev);
-
-	return us * (fep->clk_ref_rate / 1000) / 1000;
-}
-
-static int fec_enet_eee_mode_set(struct net_device *ndev, bool enable)
-{
-	struct fec_enet_private *fep = netdev_priv(ndev);
-	struct ethtool_keee *p = &fep->eee;
-	unsigned int sleep_cycle, wake_cycle;
-	int ret = 0;
-
-	if (enable) {
-		ret = phy_init_eee(ndev->phydev, false);
-		if (ret)
-			return ret;
-
-		sleep_cycle = fec_enet_us_to_tx_cycle(ndev, p->tx_lpi_timer);
-		wake_cycle = sleep_cycle;
-	} else {
-		sleep_cycle = 0;
-		wake_cycle = 0;
-	}
-
-	p->tx_lpi_enabled = enable;
-
-	writel(sleep_cycle, fep->hwp + FEC_LPI_SLEEP);
-	writel(wake_cycle, fep->hwp + FEC_LPI_WAKE);
-
-	return 0;
-}
-
 static int
 fec_enet_get_eee(struct net_device *ndev, struct ethtool_keee *edata)
 {
-- 
2.39.2


