Return-Path: <linux-kernel+bounces-71393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A77B885A47E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA1411C224B9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F8136135;
	Mon, 19 Feb 2024 13:16:26 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9782536122
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 13:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708348586; cv=none; b=Go7JCilU42FIIt2Mm+3mVQpd1S4LTVR6dsU8RgqJt3pQDeUE8Yt3kwJuOGu8MvBmi8WiqYJ4wQI+H78l7He0vtWqgijnJSMkT99kglsAOLzgBFwXb2RmJwDmv6rKAfhnHDssT9/h5NClMaXZTzlNss/IxcRPpZCGfxPHbgOTigA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708348586; c=relaxed/simple;
	bh=viLe7fGFuuP1eD4ZJQHWtFdibptfI/8RvafqbQAvd2U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YaxeLiWsp1a7vzvCam/jlwyi4+EJ2DmFueJPq0ZpyRH+eqISajVdNhl/rud4FdFqpf25XR0qNpGbUirXO8jtOaiobUXkDJTL90nS5Q6QW8QhBUNNl0Xgrl6AQhDSK18XKoW28wGy5M05n372g2Oep7W47mEM9wnoaKMZz4Ru1Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rc3VJ-0000LF-2m; Mon, 19 Feb 2024 14:16:17 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rc3VG-001ey9-S4; Mon, 19 Feb 2024 14:16:14 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rc3VG-00FcnU-2Z;
	Mon, 19 Feb 2024 14:16:14 +0100
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
Subject: [PATCH net-next v1 1/1] net: dsa: microchip: Add support for bridge port isolation
Date: Mon, 19 Feb 2024 14:16:13 +0100
Message-Id: <20240219131614.3724037-1-o.rempel@pengutronix.de>
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
---
 drivers/net/dsa/microchip/ksz_common.c | 16 +++++++++++-----
 drivers/net/dsa/microchip/ksz_common.h |  1 +
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 7cd37133ec05..10e4a14671e2 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1926,7 +1926,8 @@ static void ksz_update_port_member(struct ksz_device *dev, int port)
 		if (other_p->stp_state != BR_STATE_FORWARDING)
 			continue;
 
-		if (p->stp_state == BR_STATE_FORWARDING) {
+		if (p->stp_state == BR_STATE_FORWARDING &&
+		    !(p->isolated && other_p->isolated)) {
 			val |= BIT(port);
 			port_member |= BIT(i);
 		}
@@ -1946,7 +1947,8 @@ static void ksz_update_port_member(struct ksz_device *dev, int port)
 			if (third_p->stp_state != BR_STATE_FORWARDING)
 				continue;
 			third_dp = dsa_to_port(ds, j);
-			if (dsa_port_bridge_same(other_dp, third_dp))
+			if (dsa_port_bridge_same(other_dp, third_dp) &&
+			    !(other_p->isolated && third_p->isolated))
 				val |= BIT(j);
 		}
 
@@ -2699,7 +2701,7 @@ static int ksz_port_pre_bridge_flags(struct dsa_switch *ds, int port,
 				     struct switchdev_brport_flags flags,
 				     struct netlink_ext_ack *extack)
 {
-	if (flags.mask & ~BR_LEARNING)
+	if (flags.mask & ~(BR_LEARNING | BR_ISOLATED))
 		return -EINVAL;
 
 	return 0;
@@ -2712,8 +2714,12 @@ static int ksz_port_bridge_flags(struct dsa_switch *ds, int port,
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


