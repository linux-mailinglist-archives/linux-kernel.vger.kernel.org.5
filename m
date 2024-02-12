Return-Path: <linux-kernel+bounces-62107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F057851B93
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F3128821B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F12D3FB39;
	Mon, 12 Feb 2024 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GEnv0Joe"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752BD3F8DE;
	Mon, 12 Feb 2024 17:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707759197; cv=none; b=CRCjSXQmT2dt3jmXdGlpl/THZp3Rp+QfduG/8D4i4HqjXhtLTJ5AeJw4eXCy5RT7roncMjrEbBSh2Bk4dKHzxbrPz6b8AfpX5yL2qTAI0u/TjYHdTFXmDW7AbH/mBZTPfZUuPq7+xuYh0TxG3KL2jdyaCzu1qg358zs/hyhDj6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707759197; c=relaxed/simple;
	bh=i3tBLXpDgL97ApAAc/myRBKDc6BXBci9AQkztMAQQSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iXouoHfpwbwqGkSIC7cy9t0KOJBK8Hk3dTaNusbwBoHYCsq8aX+BsjNGqD9phDUdBVNYj+0JcfRb8IKAhMjRgmb3NYznoPvBOiJcOJz2VYH0hwAe6mGhDPGkzW7eaFq1adlhpoQyjkfjU7A7jpcJkQPpdmCoD4nwCxjOG3HBtxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GEnv0Joe; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0051A24000C;
	Mon, 12 Feb 2024 17:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707759193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OqMyrFgvZSVFVEQbpSUBQUwWGZOOdWjRIaxjKm9ptpQ=;
	b=GEnv0JoelA7Iu+UQnmNreAfbqeUVGbH+VJFW0Wx2kgYwoVTBYxA0U7pQj3bMCI+KEqZDtJ
	LEO5s6MRucjZqsXsB4P5J9da01tihMx3i8B3bb3f4431i4EPKv3GDVqlHyEcgeGxIQSikC
	Yxk4xi+uhdBt2TrAdqESawJ1JoO6giLawy/hFG7hxaihEg3Nn70U9s9u3puwupSRw0mlAb
	l4cypgQHHnNOtRQKCEb+k6Cp/sN0djKByZ1Vo8++hUbha+INNv9GE1Z/OX1evbO499z6K/
	So2MMF+B8L9i/s0qXVGdKY+8kLtqvIkb3DnkiTUMcPNB0TZadQCSOKe5yjMhog==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>
Subject: [PATCH net-next 3/3] net: phy: micrel: Add QUSGMII support and PCH extension
Date: Mon, 12 Feb 2024 18:33:06 +0100
Message-ID: <20240212173307.1124120-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212173307.1124120-1-maxime.chevallier@bootlin.com>
References: <20240212173307.1124120-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

This commit adds support for the PCH extension in the Lan8814 PHY,
allowing the PHY to report RX timestamps to the MAC in the ethernet
preamble.

When using the PCH extension, the PHY will only report the nanoseconds
part of the timestamp in-band, and the seconds part out-of-band.
The main goal in the end is to lower the pressure on the MDIO bus, which
may get pushed to its limit on 48 ports switches doing PTP at a high
rate.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/micrel.c | 84 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 9b6973581989..d8084174c5a7 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -149,6 +149,10 @@
 #define LTC_HARD_RESET				0x023F
 #define LTC_HARD_RESET_				BIT(0)
 
+#define TSU_GENERAL_CONFIG			0x2C0
+#define TSU_GENERAL_CONFIG_TSU_ENABLE_		BIT(0)
+#define TSU_GENERAL_CONFIG_TSU_ENABLE_PCH_	BIT(1)
+
 #define TSU_HARD_RESET				0x02C1
 #define TSU_HARD_RESET_				BIT(0)
 
@@ -174,6 +178,7 @@
 
 #define PTP_OPERATING_MODE			0x0241
 #define PTP_OPERATING_MODE_STANDALONE_		BIT(0)
+#define PTP_OPERATING_MODE_PCH_			BIT(1)
 
 #define PTP_TX_MOD				0x028F
 #define PTP_TX_MOD_TX_PTP_SYNC_TS_INSERT_	BIT(12)
@@ -2360,6 +2365,16 @@ static void lan8814_ptp_rx_ts_get(struct phy_device *phydev,
 	*seq_id = lanphy_read_page_reg(phydev, 5, PTP_RX_MSG_HEADER2);
 }
 
+static void lan8814_ptp_rx_ts_get_partial(struct phy_device *phydev,
+					  u32 *seconds, u16 *seq_id)
+{
+	*seconds = lanphy_read_page_reg(phydev, 5, PTP_RX_INGRESS_SEC_HI);
+	*seconds = (*seconds << 16) |
+		   lanphy_read_page_reg(phydev, 5, PTP_RX_INGRESS_SEC_LO);
+
+	*seq_id = lanphy_read_page_reg(phydev, 5, PTP_RX_MSG_HEADER2);
+}
+
 static void lan8814_ptp_tx_ts_get(struct phy_device *phydev,
 				  u32 *seconds, u32 *nano_seconds, u16 *seq_id)
 {
@@ -2504,6 +2519,12 @@ static int lan8814_hwtstamp(struct mii_timestamper *mii_ts,
 	lan8814_flush_fifo(ptp_priv->phydev, false);
 	lan8814_flush_fifo(ptp_priv->phydev, true);
 
+	if (phydev->interface == PHY_INTERFACE_MODE_QUSGMII &&
+	    ptp_priv->hwts_tx_type == HWTSTAMP_TX_ON)
+		phy_inband_ext_set_available(phydev, PHY_INBAND_EXT_PCH_TIMESTAMP);
+	else
+		phy_inband_ext_set_unavailable(phydev, PHY_INBAND_EXT_PCH_TIMESTAMP);
+
 	return 0;
 }
 
@@ -2917,8 +2938,20 @@ static bool lan8814_match_skb(struct kszphy_ptp_priv *ptp_priv,
 
 	if (ret) {
 		shhwtstamps = skb_hwtstamps(skb);
-		memset(shhwtstamps, 0, sizeof(*shhwtstamps));
-		shhwtstamps->hwtstamp = ktime_set(rx_ts->seconds, rx_ts->nsec);
+
+		if (phy_inband_ext_enabled(ptp_priv->phydev, PHY_INBAND_EXT_PCH_TIMESTAMP)) {
+			/* When using the PCH extension, we get the seconds part
+			 * from MDIO accesses, but the seconds part gets
+			 * set by the MAC driver according to the PCH data in the
+			 * preamble
+			 */
+			struct timespec64 ts = ktime_to_timespec64(shhwtstamps->hwtstamp);
+
+			shhwtstamps->hwtstamp = ktime_set(rx_ts->seconds, ts.tv_nsec);
+		} else {
+			memset(shhwtstamps, 0, sizeof(*shhwtstamps));
+			shhwtstamps->hwtstamp = ktime_set(rx_ts->seconds, rx_ts->nsec);
+		}
 		netif_rx(skb);
 	}
 
@@ -2953,8 +2986,18 @@ static void lan8814_get_rx_ts(struct kszphy_ptp_priv *ptp_priv)
 		if (!rx_ts)
 			return;
 
-		lan8814_ptp_rx_ts_get(phydev, &rx_ts->seconds, &rx_ts->nsec,
-				      &rx_ts->seq_id);
+		/* When using PCH mode, the nanoseconds part of the timestamp is
+		 * transmitted inband through the ethernet preamble. We only need
+		 * to retrieve the seconds part along with the seq_id, the MAC
+		 * driver will fill-in the nanoseconds part itself
+		 */
+		if (phy_inband_ext_enabled(ptp_priv->phydev, PHY_INBAND_EXT_PCH_TIMESTAMP))
+			lan8814_ptp_rx_ts_get_partial(phydev, &rx_ts->seconds,
+						      &rx_ts->seq_id);
+		else
+			lan8814_ptp_rx_ts_get(phydev, &rx_ts->seconds,
+					      &rx_ts->nsec, &rx_ts->seq_id);
+
 		lan8814_match_rx_ts(ptp_priv, rx_ts);
 
 		/* If other timestamps are available in the FIFO,
@@ -3240,6 +3283,37 @@ static void lan8814_setup_led(struct phy_device *phydev, int val)
 	lanphy_write_page_reg(phydev, 5, LAN8814_LED_CTRL_1, temp);
 }
 
+static int lan8814_set_inband_ext(struct phy_device *phydev,
+				  enum phy_inband_ext ext, bool enable)
+{
+	u32 tsu_cfg;
+
+	if (ext != PHY_INBAND_EXT_PCH_TIMESTAMP)
+		return -EOPNOTSUPP;
+
+	tsu_cfg = ~TSU_GENERAL_CONFIG_TSU_ENABLE_;
+
+	lanphy_write_page_reg(phydev, 5, TSU_GENERAL_CONFIG, tsu_cfg);
+
+	if (enable) {
+		lanphy_write_page_reg(phydev, 4, PTP_OPERATING_MODE,
+				      PTP_OPERATING_MODE_PCH_);
+
+		tsu_cfg |= TSU_GENERAL_CONFIG_TSU_ENABLE_PCH_;
+	} else {
+		lanphy_write_page_reg(phydev, 4, PTP_OPERATING_MODE,
+				      PTP_OPERATING_MODE_STANDALONE_);
+
+		tsu_cfg &= ~TSU_GENERAL_CONFIG_TSU_ENABLE_PCH_;
+	}
+
+	tsu_cfg |= TSU_GENERAL_CONFIG_TSU_ENABLE_;
+
+	lanphy_write_page_reg(phydev, 5, TSU_GENERAL_CONFIG, tsu_cfg);
+
+	return 0;
+}
+
 static int lan8814_config_init(struct phy_device *phydev)
 {
 	struct kszphy_priv *lan8814 = phydev->priv;
@@ -4805,6 +4879,7 @@ static struct phy_driver ksphy_driver[] = {
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
 	.name		= "Microchip INDY Gigabit Quad PHY",
 	.flags          = PHY_POLL_CABLE_TEST,
+	.inband_ext	= PHY_INBAND_EXT_PCH_TIMESTAMP,
 	.config_init	= lan8814_config_init,
 	.driver_data	= &lan8814_type,
 	.probe		= lan8814_probe,
@@ -4819,6 +4894,7 @@ static struct phy_driver ksphy_driver[] = {
 	.handle_interrupt = lan8814_handle_interrupt,
 	.cable_test_start	= lan8814_cable_test_start,
 	.cable_test_get_status	= ksz886x_cable_test_get_status,
+	.set_inband_ext = lan8814_set_inband_ext,
 }, {
 	.phy_id		= PHY_ID_LAN8804,
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
-- 
2.43.0


