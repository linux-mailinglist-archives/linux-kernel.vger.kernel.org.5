Return-Path: <linux-kernel+bounces-88222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F5E86DEC5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65863289B06
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9566BFB5;
	Fri,  1 Mar 2024 10:02:11 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A3F6BFB4
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 10:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709287331; cv=none; b=V4A/OT8SqOc34zJK5fMHZH3eZehkzMXHCmqMYq9YKoboMW3eHLTZAslTr9EiK34ZsgooHFzqUpnz0fI57bIzsa8AS57hO/Ls+/BH2bntscD0gp9xNySyqaa5ENjcODANdDQ2DQa6J2+fTNRZp5GPJu5PJxWwehI9PPf1FHxkwjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709287331; c=relaxed/simple;
	bh=bnczvboHhvoEalEW9xSpju92M4P2dgF3JOLgOD2eOHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ODwH3B+qvv2o3PNNAJbASMigp7IXDDBiiZHKRbEMNDZk71Rw+563ad4yU00+VJIs5Gvbc7IGeeGlMkHR0rPTyIYk9KvmgFR4jBDiPdcDXiOZ7lLvNZoOTrDXASNhhrqlKOXstI2RNSMcypby1Xord/bdmSqwVroR+r5fme+TZnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rfziG-0003oe-LC; Fri, 01 Mar 2024 11:01:56 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rfziE-003kq3-H9; Fri, 01 Mar 2024 11:01:54 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rfziE-003tMK-1S;
	Fri, 01 Mar 2024 11:01:54 +0100
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
Subject: [PATCH net-next v8 1/8] net: add helpers for EEE configuration
Date: Fri,  1 Mar 2024 11:01:46 +0100
Message-Id: <20240301100153.927743-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240301100153.927743-1-o.rempel@pengutronix.de>
References: <20240301100153.927743-1-o.rempel@pengutronix.de>
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
 include/net/eee.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 include/net/eee.h

diff --git a/include/net/eee.h b/include/net/eee.h
new file mode 100644
index 0000000000000..1232658b32f40
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
+static inline void eeecfg_to_eee(const struct eee_config *eeecfg,
+			  struct ethtool_keee *eee)
+{
+	eee->tx_lpi_timer = eeecfg->tx_lpi_timer;
+	eee->tx_lpi_enabled = eeecfg->tx_lpi_enabled;
+	eee->eee_enabled = eeecfg->eee_enabled;
+}
+
+static inline void eee_to_eeecfg(const struct ethtool_keee *eee,
+				 struct eee_config *eeecfg)
+{
+	eeecfg->tx_lpi_timer = eee->tx_lpi_timer;
+	eeecfg->tx_lpi_enabled = eee->tx_lpi_enabled;
+	eeecfg->eee_enabled = eee->eee_enabled;
+}
+
+#endif
-- 
2.39.2


