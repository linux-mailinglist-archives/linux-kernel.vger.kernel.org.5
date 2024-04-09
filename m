Return-Path: <linux-kernel+bounces-136441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD21789D419
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6D5C28335B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2403083A14;
	Tue,  9 Apr 2024 08:19:05 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A867E765
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 08:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712650743; cv=none; b=sSHx3FtLZSMAbMAcCwXQf08+psKwR2PB8dLXWVOwnyDYUKfoqzWcYuCfz15vYQ80foTS68XOV1LBQ0jzeBKLLZn9vGfwGWzhhe42GIZAL3Sa+vixDKo5g4rDCMWjWvyuKcYHl74W2AjyIthFnA5O8C3fhInbMg9jpJRI6VRfdT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712650743; c=relaxed/simple;
	bh=oNE2Ro8bkWHCpERvlQWe0qFnsxIFXbaTSbvqasJT+GU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QbBwe17rAW+Uz1aBtQbF4lzUIsDDEKP35j32Y1wELsteSkVbzEelmUC9yMwft8GJkkAGJXRcl1ZYAv53sKxFq5wwu/u7lB/ACPPsTwOiBLQ06dudsmYuZ1/ytc0I0yNVoXdvnwcNod0fYVt1UM3HPTtKcUZgClQ933AZBUUE6p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1ru6gw-0006VH-PK; Tue, 09 Apr 2024 10:18:54 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1ru6gu-00BGpO-Lf; Tue, 09 Apr 2024 10:18:52 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1ru6gu-00EoUa-1v;
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
	Florian Fainelli <florian.fainelli@broadcom.com>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH net-next v5 1/9] net: dsa: add support for DCB get/set apptrust configuration
Date: Tue,  9 Apr 2024 10:18:43 +0200
Message-Id: <20240409081851.3530641-2-o.rempel@pengutronix.de>
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

Add DCB support to get/set trust configuration for different packet
priority information sources. Some switch allow to chose different
source of packet priority classification. For example on KSZ switches it
is possible to configure VLAN PCP and/or DSCP sources.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
changes v3:
- s/to choice/to chose/
---
 include/net/dsa.h |  4 ++++
 net/dsa/user.c    | 28 ++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 7c0da9effe4e9..96bde2aa86efd 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -955,6 +955,10 @@ struct dsa_switch_ops {
 				      u8 prio);
 	int	(*port_del_dscp_prio)(struct dsa_switch *ds, int port, u8 dscp,
 				      u8 prio);
+	int	(*port_set_apptrust)(struct dsa_switch *ds, int port,
+				     const u8 *sel, int nsel);
+	int	(*port_get_apptrust)(struct dsa_switch *ds, int port, u8 *sel,
+				     int *nsel);
 
 	/*
 	 * Suspend and resume
diff --git a/net/dsa/user.c b/net/dsa/user.c
index 16d395bb1a1fe..b6aec6615c76e 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -2136,6 +2136,32 @@ int dsa_user_change_mtu(struct net_device *dev, int new_mtu)
 	return err;
 }
 
+static int __maybe_unused
+dsa_user_dcbnl_set_apptrust(struct net_device *dev, u8 *sel, int nsel)
+{
+	struct dsa_port *dp = dsa_user_to_port(dev);
+	struct dsa_switch *ds = dp->ds;
+	int port = dp->index;
+
+	if (!ds->ops->port_get_apptrust)
+		return -EOPNOTSUPP;
+
+	return ds->ops->port_set_apptrust(ds, port, sel, nsel);
+}
+
+static int __maybe_unused
+dsa_user_dcbnl_get_apptrust(struct net_device *dev, u8 *sel, int *nsel)
+{
+	struct dsa_port *dp = dsa_user_to_port(dev);
+	struct dsa_switch *ds = dp->ds;
+	int port = dp->index;
+
+	if (!ds->ops->port_get_apptrust)
+		return -EOPNOTSUPP;
+
+	return ds->ops->port_get_apptrust(ds, port, sel, nsel);
+}
+
 static int __maybe_unused
 dsa_user_dcbnl_set_default_prio(struct net_device *dev, struct dcb_app *app)
 {
@@ -2376,6 +2402,8 @@ static const struct ethtool_ops dsa_user_ethtool_ops = {
 static const struct dcbnl_rtnl_ops __maybe_unused dsa_user_dcbnl_ops = {
 	.ieee_setapp		= dsa_user_dcbnl_ieee_setapp,
 	.ieee_delapp		= dsa_user_dcbnl_ieee_delapp,
+	.dcbnl_setapptrust	= dsa_user_dcbnl_set_apptrust,
+	.dcbnl_getapptrust	= dsa_user_dcbnl_get_apptrust,
 };
 
 static void dsa_user_get_stats64(struct net_device *dev,
-- 
2.39.2


