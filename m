Return-Path: <linux-kernel+bounces-76028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD1285F228
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE44B284DCD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE8517BAC;
	Thu, 22 Feb 2024 07:51:24 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F5B1799F
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 07:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708588284; cv=none; b=ueoqyAD3VQt6AtjfEQwPxeBSV+Besf5X/meWV1W1d6hPsQlgQ0ctjDJU0parX7+fq0eX+GUhawk8xv078zokdVbOqhu8bGOUB8LYnWt4EhUJoLP6uiJR15Nqwmpm0KsQ4jsArtvE7GldJKJN+dutlLfR5MBQaPOAgQ5n5/YwMAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708588284; c=relaxed/simple;
	bh=YABI2wY90F4ti0YQ+FYf2izsdH0x6Nl4/AuuHydNCm8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RlTGNuVw0noz9OZ/1R2WGIwv8KYq2rdBu2pdl9UrBBz5FIUnByErgzeKwSz+go3A1/rhcU95VG9A6s0Max4YSI0sP14bQ4bQV8MoTK470nHCkSY03ixgMRVAdqH38IZ4PNBFtvL7f2MQQRUXgMsRErCpf5Ok2j7P1JwXadgX080=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rd3rP-0007Wg-9I; Thu, 22 Feb 2024 08:51:15 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rd3rO-002Bn0-D6; Thu, 22 Feb 2024 08:51:14 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rd3rO-00Al9r-16;
	Thu, 22 Feb 2024 08:51:14 +0100
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
	UNGLinuxDriver@microchip.com
Subject: [PATCH net-next v3 1/1] net: dsa: microchip: Add support for bridge port isolation
Date: Thu, 22 Feb 2024 08:51:13 +0100
Message-Id: <20240222075113.2564540-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
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

Implement bridge port isolation for KSZ switches. Enabling the isolation
of switch ports from each other while maintaining connectivity with the
CPU and other forwarding ports. For instance, to isolate swp1 and swp2
from each other, use the following commands:
- bridge link set dev swp1 isolated on
- bridge link set dev swp2 isolated on

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
---
changes v3:
- fix documentation

changes v2:
- add comments and new lines
---
 drivers/net/dsa/microchip/ksz_common.c | 55 +++++++++++++++++++++++---
 drivers/net/dsa/microchip/ksz_common.h |  1 +
 2 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 7cd37133ec05..d58cc685478b 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1898,6 +1898,29 @@ static void ksz_get_strings(struct dsa_switch *ds, int port,
 	}
 }
 
+/**
+ * ksz_update_port_member - Adjust port forwarding rules based on STP state and
+ *			    isolation settings.
+ * @dev: A pointer to the struct ksz_device representing the device.
+ * @port: The port number to adjust.
+ *
+ * This function dynamically adjusts the port membership configuration for a
+ * specified port and other device ports, based on Spanning Tree Protocol (STP)
+ * states and port isolation settings. Each port, including the CPU port, has a
+ * membership register, represented as a bitfield, where each bit corresponds
+ * to a port number. A set bit indicates permission to forward frames to that
+ * port. This function iterates over all ports, updating the membership register
+ * to reflect current forwarding permissions:
+ *
+ * 1. Forwards frames only to ports that are part of the same bridge group and
+ *    in the BR_STATE_FORWARDING state.
+ * 2. Takes into account the isolation status of ports; ports in the
+ *    BR_STATE_FORWARDING state with BR_ISOLATED configuration will not forward
+ *    frames to each other, even if they are in the same bridge group.
+ * 3. Ensures that the CPU port is included in the membership based on its
+ *    upstream port configuration, allowing for management and control traffic
+ *    to flow as required.
+ */
 static void ksz_update_port_member(struct ksz_device *dev, int port)
 {
 	struct ksz_port *p = &dev->ports[port];
@@ -1926,7 +1949,14 @@ static void ksz_update_port_member(struct ksz_device *dev, int port)
 		if (other_p->stp_state != BR_STATE_FORWARDING)
 			continue;
 
-		if (p->stp_state == BR_STATE_FORWARDING) {
+		/* At this point we know that "port" and "other" port [i] are in
+		 * the same bridge group and that "other" port [i] is in
+		 * forwarding stp state. If "port" is also in forwarding stp
+		 * state, we can allow forwarding from port [port] to port [i].
+		 * Except if both ports are isolated.
+		 */
+		if (p->stp_state == BR_STATE_FORWARDING &&
+		    !(p->isolated && other_p->isolated)) {
 			val |= BIT(port);
 			port_member |= BIT(i);
 		}
@@ -1945,8 +1975,19 @@ static void ksz_update_port_member(struct ksz_device *dev, int port)
 			third_p = &dev->ports[j];
 			if (third_p->stp_state != BR_STATE_FORWARDING)
 				continue;
+
 			third_dp = dsa_to_port(ds, j);
-			if (dsa_port_bridge_same(other_dp, third_dp))
+
+			/* Now we updating relation of the "other" port [i] to
+			 * the "third" port [j]. We already know that "other"
+			 * port [i] is in forwarding stp state and that "third"
+			 * port [j] is in forwarding stp state too.
+			 * We need to check if "other" port [i] and "third" port
+			 * [j] are in the same bridge group and not isolated
+			 * before allowing forwarding from port [i] to port [j].
+			 */
+			if (dsa_port_bridge_same(other_dp, third_dp) &&
+			    !(other_p->isolated && third_p->isolated))
 				val |= BIT(j);
 		}
 
@@ -2699,7 +2740,7 @@ static int ksz_port_pre_bridge_flags(struct dsa_switch *ds, int port,
 				     struct switchdev_brport_flags flags,
 				     struct netlink_ext_ack *extack)
 {
-	if (flags.mask & ~BR_LEARNING)
+	if (flags.mask & ~(BR_LEARNING | BR_ISOLATED))
 		return -EINVAL;
 
 	return 0;
@@ -2712,8 +2753,12 @@ static int ksz_port_bridge_flags(struct dsa_switch *ds, int port,
 	struct ksz_device *dev = ds->priv;
 	struct ksz_port *p = &dev->ports[port];
 
-	if (flags.mask & BR_LEARNING) {
-		p->learning = !!(flags.val & BR_LEARNING);
+	if (flags.mask & (BR_LEARNING | BR_ISOLATED)) {
+		if (flags.mask & BR_LEARNING)
+			p->learning = !!(flags.val & BR_LEARNING);
+
+		if (flags.mask & BR_ISOLATED)
+			p->isolated = !!(flags.val & BR_ISOLATED);
 
 		/* Make the change take effect immediately */
 		ksz_port_stp_state_set(ds, port, p->stp_state);
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index a3f69a036fa9..fb76637596fc 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -111,6 +111,7 @@ struct ksz_switch_macaddr {
 struct ksz_port {
 	bool remove_tag;		/* Remove Tag flag set, for ksz8795 only */
 	bool learning;
+	bool isolated;
 	int stp_state;
 	struct phy_device phydev;
 
-- 
2.39.2


