Return-Path: <linux-kernel+bounces-132770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9458999ED
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514B21C2150F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9C616C436;
	Fri,  5 Apr 2024 09:52:31 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E451607BF
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712310749; cv=none; b=M7d9biZd369AsTh85VsjKxmqCeuCa8vSidf/vvBqT9lUZTlTC6oDdcMSCG9NFASDLRnzqhVlcx7/x95Vz9haO0Ij7KdTpab7iStCVnKUAlL7JXYtbDSquTmj/zHQdL2MqVRLM5YOf8NPNnyLxLcYallxD7lSWxKN26SG9t3IjRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712310749; c=relaxed/simple;
	bh=UbJm4CAN9/EAj1i27GEuzt2Qj9RP8AyisQ+CWSykUA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XuTX5ES9s2C29apYmarGdpv2rYTBEHZyAFfSzY5+dIJdlExhx2WAZ1trPfXaZN6lRbL6rjYlUs175a0aMdp7J91YibNeWaFWEZuIL85KOlDs4OsPOSiQpNG1ls8Bqvi+S4tEqteQokE6LtcaxTanlUY5LUGyXfeiM7IPSBi8bHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rsgFA-0005E9-S9; Fri, 05 Apr 2024 11:52:20 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rsgF8-00AXqb-AG; Fri, 05 Apr 2024 11:52:18 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rsgF8-001U4i-0l;
	Fri, 05 Apr 2024 11:52:18 +0200
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
Subject: [PATCH net-next v3 2/9] net: dsa: microchip: add IPV information support
Date: Fri,  5 Apr 2024 11:52:09 +0200
Message-Id: <20240405095216.353829-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240405095216.353829-1-o.rempel@pengutronix.de>
References: <20240405095216.353829-1-o.rempel@pengutronix.de>
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

Most of Microchip KSZ switches use Internal Priority Value associated
with every frame. For example, it is possible to map any VLAN PCP or
DSCP value to IPV and at the end, map IPV to a queue.

Since amount of IPVs is not equal to amount of queues, add this
information and make use of it in some functions.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
---
changes v3:
- rename max_ipvs to num_ipvs
- drop comparison of num_tx_queues and num_ipvs. It makes no much sense.
---
 drivers/net/dsa/microchip/ksz_common.c | 21 +++++++++++++++++++--
 drivers/net/dsa/microchip/ksz_common.h |  2 +-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 42330e8fd26e7..b2d1c61400c51 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1194,6 +1194,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 3,		/* total port count */
 		.port_nirqs = 3,
 		.num_tx_queues = 4,
+		.num_ipvs = 8,
 		.tc_cbs_supported = true,
 		.tc_ets_supported = true,
 		.ops = &ksz9477_dev_ops,
@@ -1223,6 +1224,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.cpu_ports = 0x10,	/* can be configured as cpu port */
 		.port_cnt = 5,		/* total cpu and user ports */
 		.num_tx_queues = 4,
+		.num_ipvs = 4,
 		.ops = &ksz8_dev_ops,
 		.ksz87xx_eee_link_erratum = true,
 		.mib_names = ksz9477_mib_names,
@@ -1262,6 +1264,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.cpu_ports = 0x10,	/* can be configured as cpu port */
 		.port_cnt = 5,		/* total cpu and user ports */
 		.num_tx_queues = 4,
+		.num_ipvs = 4,
 		.ops = &ksz8_dev_ops,
 		.ksz87xx_eee_link_erratum = true,
 		.mib_names = ksz9477_mib_names,
@@ -1287,6 +1290,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.cpu_ports = 0x10,	/* can be configured as cpu port */
 		.port_cnt = 5,		/* total cpu and user ports */
 		.num_tx_queues = 4,
+		.num_ipvs = 4,
 		.ops = &ksz8_dev_ops,
 		.ksz87xx_eee_link_erratum = true,
 		.mib_names = ksz9477_mib_names,
@@ -1312,6 +1316,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.cpu_ports = 0x4,	/* can be configured as cpu port */
 		.port_cnt = 3,
 		.num_tx_queues = 4,
+		.num_ipvs = 4,
 		.ops = &ksz8_dev_ops,
 		.mib_names = ksz88xx_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz88xx_mib_names),
@@ -1336,6 +1341,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 7,		/* total physical port count */
 		.port_nirqs = 4,
 		.num_tx_queues = 4,
+		.num_ipvs = 8,
 		.tc_cbs_supported = true,
 		.tc_ets_supported = true,
 		.ops = &ksz9477_dev_ops,
@@ -1370,6 +1376,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 6,		/* total physical port count */
 		.port_nirqs = 2,
 		.num_tx_queues = 4,
+		.num_ipvs = 8,
 		.ops = &ksz9477_dev_ops,
 		.mib_names = ksz9477_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
@@ -1402,6 +1409,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 7,		/* total physical port count */
 		.port_nirqs = 2,
 		.num_tx_queues = 4,
+		.num_ipvs = 8,
 		.ops = &ksz9477_dev_ops,
 		.mib_names = ksz9477_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
@@ -1432,6 +1440,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 3,		/* total port count */
 		.port_nirqs = 2,
 		.num_tx_queues = 4,
+		.num_ipvs = 8,
 		.ops = &ksz9477_dev_ops,
 		.mib_names = ksz9477_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
@@ -1458,6 +1467,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 3,		/* total port count */
 		.port_nirqs = 3,
 		.num_tx_queues = 4,
+		.num_ipvs = 8,
 		.tc_cbs_supported = true,
 		.tc_ets_supported = true,
 		.ops = &ksz9477_dev_ops,
@@ -1486,6 +1496,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 7,		/* total port count */
 		.port_nirqs = 3,
 		.num_tx_queues = 4,
+		.num_ipvs = 8,
 		.tc_cbs_supported = true,
 		.tc_ets_supported = true,
 		.ops = &ksz9477_dev_ops,
@@ -1519,6 +1530,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 7,		/* total physical port count */
 		.port_nirqs = 3,
 		.num_tx_queues = 4,
+		.num_ipvs = 8,
 		.tc_cbs_supported = true,
 		.tc_ets_supported = true,
 		.ops = &ksz9477_dev_ops,
@@ -1551,6 +1563,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 5,		/* total physical port count */
 		.port_nirqs = 6,
 		.num_tx_queues = 8,
+		.num_ipvs = 8,
 		.tc_cbs_supported = true,
 		.tc_ets_supported = true,
 		.ops = &lan937x_dev_ops,
@@ -1578,6 +1591,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 6,		/* total physical port count */
 		.port_nirqs = 6,
 		.num_tx_queues = 8,
+		.num_ipvs = 8,
 		.tc_cbs_supported = true,
 		.tc_ets_supported = true,
 		.ops = &lan937x_dev_ops,
@@ -1605,6 +1619,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 8,		/* total physical port count */
 		.port_nirqs = 6,
 		.num_tx_queues = 8,
+		.num_ipvs = 8,
 		.tc_cbs_supported = true,
 		.tc_ets_supported = true,
 		.ops = &lan937x_dev_ops,
@@ -1636,6 +1651,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 5,		/* total physical port count */
 		.port_nirqs = 6,
 		.num_tx_queues = 8,
+		.num_ipvs = 8,
 		.tc_cbs_supported = true,
 		.tc_ets_supported = true,
 		.ops = &lan937x_dev_ops,
@@ -1667,6 +1683,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 8,		/* total physical port count */
 		.port_nirqs = 6,
 		.num_tx_queues = 8,
+		.num_ipvs = 8,
 		.tc_cbs_supported = true,
 		.tc_ets_supported = true,
 		.ops = &lan937x_dev_ops,
@@ -3522,7 +3539,7 @@ static int ksz_tc_ets_add(struct ksz_device *dev, int port,
 	for (tc_prio = 0; tc_prio < ARRAY_SIZE(p->priomap); tc_prio++) {
 		int queue;
 
-		if (tc_prio > KSZ9477_MAX_TC_PRIO)
+		if (tc_prio >= dev->info->num_ipvs)
 			break;
 
 		queue = ksz_ets_band_to_queue(p, p->priomap[tc_prio]);
@@ -3564,7 +3581,7 @@ static int ksz_tc_ets_del(struct ksz_device *dev, int port)
 	/* Revert the queue mapping for TC-priority to its default setting on
 	 * the chip.
 	 */
-	for (tc_prio = 0; tc_prio <= KSZ9477_MAX_TC_PRIO; tc_prio++) {
+	for (tc_prio = 0; tc_prio < dev->info->num_ipvs; tc_prio++) {
 		int queue;
 
 		queue = tc_prio >> s;
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 40c11b0d6b625..900e9ac06d013 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -58,6 +58,7 @@ struct ksz_chip_data {
 	int port_cnt;
 	u8 port_nirqs;
 	u8 num_tx_queues;
+	u8 num_ipvs; /* number of Internal Priority Values */
 	bool tc_cbs_supported;
 	bool tc_ets_supported;
 	const struct ksz_dev_ops *ops;
@@ -722,7 +723,6 @@ static inline int is_lan937x(struct ksz_device *dev)
 #define KSZ9477_PORT_MRI_TC_MAP__4	0x0808
 
 #define KSZ9477_PORT_TC_MAP_S		4
-#define KSZ9477_MAX_TC_PRIO		7
 
 /* CBS related registers */
 #define REG_PORT_MTI_QUEUE_INDEX__4	0x0900
-- 
2.39.2


