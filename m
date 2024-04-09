Return-Path: <linux-kernel+bounces-136437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BFD89D40A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC74DB20E6E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41A77F46F;
	Tue,  9 Apr 2024 08:19:02 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F517E572
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 08:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712650741; cv=none; b=oaHgiwbXSDq61kUYFkHBvpANieDXAnpmm+FEgZS/eof/wjbwiJQsLhU8u9++tHwXP57mit7c0Le/BYX1uYoGRXcXEhSfz61qKuSGj7tmoWb2gkIfAk3GZlEokSg/XRYrAmgImPR+GDEZgzUa3Pxc+MkWS1XUmzMeo186a3GzOcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712650741; c=relaxed/simple;
	bh=Qjb8udiUnw5ls5ypyZbytvpkn5nU+tT5QfOsZXoNbhI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P+w555BBaK9Nywxj58K+HIPakDGbCDzA0jCS32JwTkWLSXOPk7lXRXHVK+SmgDPtHnbaMWkbJEEhlRcZHuOpfU9v6E7hwN5gxYDIbkshyv2Rms1Zoy3B2xYVEbQ0GicRGwZ2REWuw8rEc8ZyeZq9Mrac3dZyoYDuKNRCQRSmes4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1ru6gw-0006VO-Nk; Tue, 09 Apr 2024 10:18:54 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1ru6gu-00BGpa-RG; Tue, 09 Apr 2024 10:18:52 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1ru6gu-00EoVl-2O;
	Tue, 09 Apr 2024 10:18:52 +0200
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
Subject: [PATCH net-next v5 8/9] net: dsa: microchip: init predictable IPV to queue mapping for all non KSZ8xxx variants
Date: Tue,  9 Apr 2024 10:18:50 +0200
Message-Id: <20240409081851.3530641-9-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240409081851.3530641-1-o.rempel@pengutronix.de>
References: <20240409081851.3530641-1-o.rempel@pengutronix.de>
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

Init priority to queue mapping in the way as it shown in IEEE 802.1Q
mapping example.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v2:
- s/ksz_set_default_prio_queue_mapping/ksz9477_set_default_prio_queue_mapping
- remove error on queue < 0.
---
 drivers/net/dsa/microchip/ksz_common.c | 57 +++++++++++++++-----------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 87a807ac7900e..8a5d41025604a 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -24,6 +24,7 @@
 #include <linux/of_net.h>
 #include <linux/micrel_phy.h>
 #include <net/dsa.h>
+#include <net/ieee8021q.h>
 #include <net/pkt_cls.h>
 #include <net/switchdev.h>
 
@@ -2672,9 +2673,33 @@ static int ksz_port_mdb_del(struct dsa_switch *ds, int port,
 	return dev->dev_ops->mdb_del(dev, port, mdb, db);
 }
 
+static int ksz9477_set_default_prio_queue_mapping(struct ksz_device *dev,
+						  int port)
+{
+	u32 queue_map = 0;
+	int ipv;
+
+	for (ipv = 0; ipv < dev->info->num_ipvs; ipv++) {
+		int queue;
+
+		/* Traffic Type (TT) is corresponding to the Internal Priority
+		 * Value (IPV) in the switch. Traffic Class (TC) is
+		 * corresponding to the queue in the switch.
+		 */
+		queue = ieee8021q_tt_to_tc(ipv, dev->info->num_tx_queues);
+		if (queue < 0)
+			return queue;
+
+		queue_map |= queue << (ipv * KSZ9477_PORT_TC_MAP_S);
+	}
+
+	return ksz_pwrite32(dev, port, KSZ9477_PORT_MRI_TC_MAP__4, queue_map);
+}
+
 static int ksz_port_setup(struct dsa_switch *ds, int port)
 {
 	struct ksz_device *dev = ds->priv;
+	int ret;
 
 	if (!dsa_is_user_port(ds, port))
 		return 0;
@@ -2682,6 +2707,12 @@ static int ksz_port_setup(struct dsa_switch *ds, int port)
 	/* setup user port */
 	dev->dev_ops->port_setup(dev, port, false);
 
+	if (!is_ksz8(dev)) {
+		ret = ksz9477_set_default_prio_queue_mapping(dev, port);
+		if (ret)
+			return ret;
+	}
+
 	/* port_stp_state_set() will be called after to enable the port so
 	 * there is no need to do anything.
 	 */
@@ -3546,8 +3577,7 @@ static int ksz_tc_ets_add(struct ksz_device *dev, int port,
 
 static int ksz_tc_ets_del(struct ksz_device *dev, int port)
 {
-	int ret, queue, tc_prio, s;
-	u32 queue_map = 0;
+	int ret, queue;
 
 	/* To restore the default chip configuration, set all queues to use the
 	 * WRR scheduler with a weight of 1.
@@ -3559,31 +3589,10 @@ static int ksz_tc_ets_del(struct ksz_device *dev, int port)
 			return ret;
 	}
 
-	switch (dev->info->num_tx_queues) {
-	case 2:
-		s = 2;
-		break;
-	case 4:
-		s = 1;
-		break;
-	case 8:
-		s = 0;
-		break;
-	default:
-		return -EINVAL;
-	}
-
 	/* Revert the queue mapping for TC-priority to its default setting on
 	 * the chip.
 	 */
-	for (tc_prio = 0; tc_prio < dev->info->num_ipvs; tc_prio++) {
-		int queue;
-
-		queue = tc_prio >> s;
-		queue_map |= queue << (tc_prio * KSZ9477_PORT_TC_MAP_S);
-	}
-
-	return ksz_pwrite32(dev, port, KSZ9477_PORT_MRI_TC_MAP__4, queue_map);
+	return ksz9477_set_default_prio_queue_mapping(dev, port);
 }
 
 static int ksz_tc_ets_validate(struct ksz_device *dev, int port,
-- 
2.39.2


