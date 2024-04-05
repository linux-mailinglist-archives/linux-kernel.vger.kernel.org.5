Return-Path: <linux-kernel+bounces-132764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 324BD8999DE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D31F11F22A79
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE9216131E;
	Fri,  5 Apr 2024 09:52:28 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014E615FCEC
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712310747; cv=none; b=aEWS2nar/vzdQ+pyjSzVpyMCIV+jKuwnRP7z3qwVeYCFIPQpX1DEUhyDJekUW9mmr5ylL9+dm8xXA6QPI/lQcqNADUE9eHN5G0KCDTc5pOeUILUuNy6nUMVpM2k0T8KxVfqEYDBd3+buKMBQaO5LyBbVeP+Th7tXer7jx4E+y0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712310747; c=relaxed/simple;
	bh=cDY1hCw7M8ZviUcPfvgRPAT7J54RvZFu0CmQkhff66o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VLb0hBt41Ukac6chTl/dZXOQC/RbLz2Hx291ar+HbFQmI1TMkQW0v1A2brdS7V0to5PZYvjLplWkjS9peG2JHZQxviPFuRUyz/JyvAMkuK1J+QKC30bTNgYei3zUiUQw+LtTb5mzXpqoobaMAyOCyMoyS/OhYTcI0UPSgtgTUVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rsgFA-0005EE-S9; Fri, 05 Apr 2024 11:52:20 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rsgF8-00AXqn-FL; Fri, 05 Apr 2024 11:52:18 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rsgF8-001U5s-1A;
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
Subject: [PATCH net-next v3 9/9] net: dsa: microchip: let DCB code do PCP and DSCP policy configuration
Date: Fri,  5 Apr 2024 11:52:16 +0200
Message-Id: <20240405095216.353829-10-o.rempel@pengutronix.de>
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

802.1P (PCP) and DiffServ (DSCP) are handled now by DCB code. Let it do
all needed initial configuration.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz8795.c | 6 ------
 drivers/net/dsa/microchip/ksz9477.c | 6 ------
 2 files changed, 12 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index 5f0d72137b484..ddfac08b5a6a6 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -1565,16 +1565,10 @@ void ksz8_port_setup(struct ksz_device *dev, int port, bool cpu_port)
 
 	ksz8_port_queue_split(dev, port, queues);
 
-	/* disable DiffServ priority */
-	ksz_port_cfg(dev, port, P_PRIO_CTRL, PORT_DIFFSERV_ENABLE, false);
-
 	/* replace priority */
 	ksz_port_cfg(dev, port, P_802_1P_CTRL,
 		     masks[PORT_802_1P_REMAPPING], false);
 
-	/* enable 802.1p priority */
-	ksz_port_cfg(dev, port, P_PRIO_CTRL, PORT_802_1P_ENABLE, true);
-
 	if (cpu_port)
 		member = dsa_user_ports(ds);
 	else
diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 7f745628c84d1..f8ad7833f5d9d 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1158,18 +1158,12 @@ void ksz9477_port_setup(struct ksz_device *dev, int port, bool cpu_port)
 	/* enable broadcast storm limit */
 	ksz_port_cfg(dev, port, P_BCAST_STORM_CTRL, PORT_BROADCAST_STORM, true);
 
-	/* disable DiffServ priority */
-	ksz_port_cfg(dev, port, P_PRIO_CTRL, PORT_DIFFSERV_PRIO_ENABLE, false);
-
 	/* replace priority */
 	ksz_port_cfg(dev, port, REG_PORT_MRI_MAC_CTRL, PORT_USER_PRIO_CEILING,
 		     false);
 	ksz9477_port_cfg32(dev, port, REG_PORT_MTI_QUEUE_CTRL_0__4,
 			   MTI_PVID_REPLACE, false);
 
-	/* enable 802.1p priority */
-	ksz_port_cfg(dev, port, P_PRIO_CTRL, PORT_802_1P_PRIO_ENABLE, true);
-
 	/* force flow control for non-PHY ports only */
 	ksz_port_cfg(dev, port, REG_PORT_CTRL_0,
 		     PORT_FORCE_TX_FLOW_CTRL | PORT_FORCE_RX_FLOW_CTRL,
-- 
2.39.2


