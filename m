Return-Path: <linux-kernel+bounces-123213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D21EF890491
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886BD297603
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14666137769;
	Thu, 28 Mar 2024 16:05:42 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C051E130A4D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711641940; cv=none; b=XpSna9mUcY3ywS2rap6GStFK94Xa/XBoGYJOFi3Veez1OZR09KBw/iP8vMO17nuqjmV1b6tKA9Bu1lTP/BuR1EUMXAjWGFAPVEBuCmeoSBOhhbUNz8pxMoM2op86ji9p91lFPVPhcpn6qKCnunAfOUDvf94u89z6E9YgQ/HZz8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711641940; c=relaxed/simple;
	bh=h3mUp113EuS+pYH6g9qCQyZzMqErhSLV2EvjsvWtczs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=exaVuo8YxPwYMjIeumC2j2hLcm6qtyYyqraE1qvIOTy+0QrSUEc+Y7MIwzmM88z+doU+KJxYozkFXFcFbraUmTrXSrkNq+7Dcpq259K9u91PKJDiW4lm/enBBMN1BEkTo1TUsJCP7kfRbNDmwurVPWnwz1y/GnN6B/NzLK/08Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rpsFm-00058k-N5; Thu, 28 Mar 2024 17:05:22 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rpsFj-0092JK-El; Thu, 28 Mar 2024 17:05:19 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rpsFj-00A3OL-1F;
	Thu, 28 Mar 2024 17:05:19 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH net-next v1 4/9] net: dsa: microchip: add multi queue support for KSZ88X3 variants
Date: Thu, 28 Mar 2024 17:05:13 +0100
Message-Id: <20240328160518.2396238-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328160518.2396238-1-o.rempel@pengutronix.de>
References: <20240328160518.2396238-1-o.rempel@pengutronix.de>
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

KSZ88X3 switches support up to 4 queues. Rework ksz8795_set_prio_queue()
to support KSZ8795 and KSZ88X3 families of switches.

Per default, configure KSZ88X3 to use one queue, since it need special
handling due to priority related errata. Errata handling is implemented
in a separate patch.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz8795.c     | 87 ++++++++++++++++---------
 drivers/net/dsa/microchip/ksz8795_reg.h |  9 ++-
 2 files changed, 61 insertions(+), 35 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index 14923535ca7e8..0ead198bacb2c 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -127,37 +127,56 @@ int ksz8_change_mtu(struct ksz_device *dev, int port, int mtu)
 	return -EOPNOTSUPP;
 }
 
-static void ksz8795_set_prio_queue(struct ksz_device *dev, int port, int queue)
+static int ksz8_port_queue_split(struct ksz_device *dev, int port, int queues)
 {
-	u8 hi, lo;
+	u8 mask_4q, mask_2q;
+	u8 reg_4q, reg_2q;
+	u8 data_4q = 0;
+	u8 data_2q = 0;
+	int ret;
 
-	/* Number of queues can only be 1, 2, or 4. */
-	switch (queue) {
-	case 4:
-	case 3:
-		queue = PORT_QUEUE_SPLIT_4;
-		break;
-	case 2:
-		queue = PORT_QUEUE_SPLIT_2;
-		break;
-	default:
-		queue = PORT_QUEUE_SPLIT_1;
+	if (ksz_is_ksz88x3(dev)) {
+		mask_4q = KSZ8873_PORT_4QUEUE_SPLIT_EN;
+		mask_2q = KSZ8873_PORT_2QUEUE_SPLIT_EN;
+		reg_4q = REG_PORT_CTRL_0;
+		reg_2q = REG_PORT_CTRL_2;
+
+		/* KSZ8795 family switches have Weighted Fair Queueing (WFQ)
+		 * enabled by default. Enable it for KSZ8873 family switches
+		 * too. Default value for KSZ8873 family is strict priority,
+		 * which should be enabled by using TC_SETUP_QDISC_ETS, not
+		 * by default.
+		 */
+		ret = ksz_rmw8(dev, REG_SW_CTRL_3, WEIGHTED_FAIR_QUEUE_ENABLE,
+			       WEIGHTED_FAIR_QUEUE_ENABLE);
+		if (ret)
+			return ret;
+	} else {
+		mask_4q = KSZ8795_PORT_4QUEUE_SPLIT_EN;
+		mask_2q = KSZ8795_PORT_2QUEUE_SPLIT_EN;
+		reg_4q = REG_PORT_CTRL_13;
+		reg_2q = REG_PORT_CTRL_0;
+
+		/* TODO: this is legacy from initial KSZ8795 driver, should be
+		 * moved to appropriate place in the future.
+		 */
+		ret = ksz_rmw8(dev, REG_SW_CTRL_19,
+			       SW_OUT_RATE_LIMIT_QUEUE_BASED,
+			       SW_OUT_RATE_LIMIT_QUEUE_BASED);
+		if (ret)
+			return ret;
 	}
-	ksz_pread8(dev, port, REG_PORT_CTRL_0, &lo);
-	ksz_pread8(dev, port, P_DROP_TAG_CTRL, &hi);
-	lo &= ~PORT_QUEUE_SPLIT_L;
-	if (queue & PORT_QUEUE_SPLIT_2)
-		lo |= PORT_QUEUE_SPLIT_L;
-	hi &= ~PORT_QUEUE_SPLIT_H;
-	if (queue & PORT_QUEUE_SPLIT_4)
-		hi |= PORT_QUEUE_SPLIT_H;
-	ksz_pwrite8(dev, port, REG_PORT_CTRL_0, lo);
-	ksz_pwrite8(dev, port, P_DROP_TAG_CTRL, hi);
-
-	/* Default is port based for egress rate limit. */
-	if (queue != PORT_QUEUE_SPLIT_1)
-		ksz_cfg(dev, REG_SW_CTRL_19, SW_OUT_RATE_LIMIT_QUEUE_BASED,
-			true);
+
+	if (queues == 4)
+		data_4q = mask_4q;
+	if (queues == 2)
+		data_2q = mask_2q;
+
+	ret = ksz_prmw8(dev, port, reg_4q, mask_4q, data_4q);
+	if (ret)
+		return ret;
+
+	return ksz_prmw8(dev, port, reg_2q, mask_2q, data_2q);
 }
 
 void ksz8_r_mib_cnt(struct ksz_device *dev, int port, u16 addr, u64 *cnt)
@@ -1512,6 +1531,7 @@ void ksz8_port_setup(struct ksz_device *dev, int port, bool cpu_port)
 {
 	struct dsa_switch *ds = dev->ds;
 	const u32 *masks;
+	int queues;
 	u8 member;
 
 	masks = dev->info->masks;
@@ -1519,8 +1539,15 @@ void ksz8_port_setup(struct ksz_device *dev, int port, bool cpu_port)
 	/* enable broadcast storm limit */
 	ksz_port_cfg(dev, port, P_BCAST_STORM_CTRL, PORT_BROADCAST_STORM, true);
 
-	if (!ksz_is_ksz88x3(dev))
-		ksz8795_set_prio_queue(dev, port, 4);
+	/* For KSZ88x3 enable only one queue by default, otherwise we won't
+	 * be able to get rid of PCP prios on Port 2.
+	 */
+	if (ksz_is_ksz88x3(dev))
+		queues = 1;
+	else
+		queues = dev->info->num_tx_queues;
+
+	ksz8_port_queue_split(dev, port, queues);
 
 	/* disable DiffServ priority */
 	ksz_port_cfg(dev, port, P_PRIO_CTRL, PORT_DIFFSERV_ENABLE, false);
diff --git a/drivers/net/dsa/microchip/ksz8795_reg.h b/drivers/net/dsa/microchip/ksz8795_reg.h
index 7c9341ef73b03..2a2a00202f643 100644
--- a/drivers/net/dsa/microchip/ksz8795_reg.h
+++ b/drivers/net/dsa/microchip/ksz8795_reg.h
@@ -124,7 +124,8 @@
 #define PORT_BASED_PRIO_3		3
 #define PORT_INSERT_TAG			BIT(2)
 #define PORT_REMOVE_TAG			BIT(1)
-#define PORT_QUEUE_SPLIT_L		BIT(0)
+#define KSZ8795_PORT_2QUEUE_SPLIT_EN	BIT(0)
+#define KSZ8873_PORT_4QUEUE_SPLIT_EN	BIT(0)
 
 #define REG_PORT_1_CTRL_1		0x11
 #define REG_PORT_2_CTRL_1		0x21
@@ -143,6 +144,7 @@
 #define REG_PORT_4_CTRL_2		0x42
 #define REG_PORT_5_CTRL_2		0x52
 
+#define KSZ8873_PORT_2QUEUE_SPLIT_EN	BIT(7)
 #define PORT_INGRESS_FILTER		BIT(6)
 #define PORT_DISCARD_NON_VID		BIT(5)
 #define PORT_FORCE_FLOW_CTRL		BIT(4)
@@ -463,10 +465,7 @@
 #define REG_PORT_4_CTRL_13		0xE1
 #define REG_PORT_5_CTRL_13		0xF1
 
-#define PORT_QUEUE_SPLIT_H		BIT(1)
-#define PORT_QUEUE_SPLIT_1		0
-#define PORT_QUEUE_SPLIT_2		1
-#define PORT_QUEUE_SPLIT_4		2
+#define KSZ8795_PORT_4QUEUE_SPLIT_EN	BIT(1)
 #define PORT_DROP_TAG			BIT(0)
 
 #define REG_PORT_1_CTRL_14		0xB2
-- 
2.39.2


