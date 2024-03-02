Return-Path: <linux-kernel+bounces-89574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 641EA86F230
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 20:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 963551C20EE8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 19:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1444776E;
	Sat,  2 Mar 2024 19:53:23 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8A54087C
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 19:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709409203; cv=none; b=qM8dcQ7nNq3mPuvJn9HBKd11+rzq8DpkY8+6m30ZaoX4c15hD5Y1Uc7YOMToqF59Pcf9+LcSUbj7HIzRnPr919gSLj/fpkrsQM5K4WXWFz81ztkDUYBw2yvoanY3RRc2S7oyptY7TBUNPcFo6SE5qWbaYhFEJ7sqLaIZfYaGjOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709409203; c=relaxed/simple;
	bh=dVniOLfoKxaNTw/jk9o77Mf8NrQSWJwOOaH6nhjN2VM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LySc2ZeGrVCLaAwsklWUFtrOSuCXFtCFSE0gmLRR/GiMPhl0GN8dbeV5lvhabQonfqk9CnFv+JYKkoSJy7gWRoiOXHXnnMimzdyEltxfZuAxH63FYAelyw0KxN/unDsyZ5eULO3i1bomudX88VzP0TdW07j3M6OMMo18jjSZ9e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rgVPx-0007Gt-MY; Sat, 02 Mar 2024 20:53:09 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rgVPv-0041mC-Nq; Sat, 02 Mar 2024 20:53:07 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rgVPv-00DSU3-27;
	Sat, 02 Mar 2024 20:53:07 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH net-next v9 1/7] net: add helpers for EEE configuration
Date: Sat,  2 Mar 2024 20:53:00 +0100
Message-Id: <20240302195306.3207716-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240302195306.3207716-1-o.rempel@pengutronix.de>
References: <20240302195306.3207716-1-o.rempel@pengutronix.de>
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

From: Russell King <rmk+kernel@armlinux.org.uk>

Add helpers that phylib and phylink can use to manage EEE configuration
and determine whether the MAC should be permitted to use LPI based on
that configuration.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
v8: change dst<>src order
---
 include/net/eee.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 include/net/eee.h

diff --git a/include/net/eee.h b/include/net/eee.h
new file mode 100644
index 0000000000000..84837aba3cd9e
--- /dev/null
+++ b/include/net/eee.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _EEE_H
+#define _EEE_H
+
+#include <linux/types.h>
+
+struct eee_config {
+	u32 tx_lpi_timer;
+	bool tx_lpi_enabled;
+	bool eee_enabled;
+};
+
+static inline bool eeecfg_mac_can_tx_lpi(const struct eee_config *eeecfg)
+{
+	/* eee_enabled is the master on/off */
+	if (!eeecfg->eee_enabled || !eeecfg->tx_lpi_enabled)
+		return false;
+
+	return true;
+}
+
+static inline void eeecfg_to_eee(struct ethtool_keee *eee,
+				 const struct eee_config *eeecfg)
+{
+	eee->tx_lpi_timer = eeecfg->tx_lpi_timer;
+	eee->tx_lpi_enabled = eeecfg->tx_lpi_enabled;
+	eee->eee_enabled = eeecfg->eee_enabled;
+}
+
+static inline void eee_to_eeecfg(struct eee_config *eeecfg,
+				 const struct ethtool_keee *eee)
+{
+	eeecfg->tx_lpi_timer = eee->tx_lpi_timer;
+	eeecfg->tx_lpi_enabled = eee->tx_lpi_enabled;
+	eeecfg->eee_enabled = eee->eee_enabled;
+}
+
+#endif
-- 
2.39.2


