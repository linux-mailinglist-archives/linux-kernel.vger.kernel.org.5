Return-Path: <linux-kernel+bounces-167678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAAD8BAD58
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6750B20EF7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08159154C14;
	Fri,  3 May 2024 13:14:14 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A434215358F
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714742052; cv=none; b=X9VQ9hrnkijRKkGwCaPOHnsRvIe6WKyIt8yUiGoyIwDhUKdj29soAXltRqf7X08C3l4SRfX4nnaDxJyJz4qvvIgROc/hXxBUVsUs+QCCOCNKR/mAe92x3mVuB0K7Ci+IjH9aRKsjMNVPGvEGoRHd9JT8FVq9whTt+BEkYAslUDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714742052; c=relaxed/simple;
	bh=CMmR1PQCL8CPLw2XGxubBH3eRd4+D/IB7iVro70lnfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n8/gcBXBPOx8Rjs8IyFL5SOz96WsLy994/v3a1DOhqqyv+2eA7I4je47RU/oZbGhFLEsRBfgaJzbIexhOOm0AAGtkR5UmCfmDAcajLAhtZsRUwK6ehD2thP+yP9ibJbrf1iu6ZR6LkJ8x2Uf70Tz15eCoyboRLBI8sIZAM5jZr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1s2sjb-0006EL-6l; Fri, 03 May 2024 15:13:55 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1s2sjZ-00FiKN-Sr; Fri, 03 May 2024 15:13:53 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1s2sjZ-008GI0-2S;
	Fri, 03 May 2024 15:13:53 +0200
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
Subject: [PATCH net-next v7 10/12] net: dsa: add support switches global DSCP priority mapping
Date: Fri,  3 May 2024 15:13:49 +0200
Message-Id: <20240503131351.1969097-11-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240503131351.1969097-1-o.rempel@pengutronix.de>
References: <20240503131351.1969097-1-o.rempel@pengutronix.de>
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

Some switches like Microchip KSZ variants do not support per port DSCP
priority configuration. Instead there is a global DSCP mapping table.

To handle it, we will accept set/del request to any of user ports to
make global configuration and update dcb app entries for all other
ports.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 include/net/dsa.h |  9 ++++++
 net/dsa/user.c    | 75 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 40c127a301878..b60e7e410aba7 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -433,6 +433,11 @@ struct dsa_switch {
 	 */
 	u32			fdb_isolation:1;
 
+	/* Drivers that have global DSCP mapping settings must set this to
+	 * true to automatically apply the settings to all ports.
+	 */
+	u32			dscp_prio_mapping_is_global:1;
+
 	/* Listener for switch fabric events */
 	struct notifier_block	nb;
 
@@ -586,6 +591,10 @@ static inline bool dsa_is_user_port(struct dsa_switch *ds, int p)
 	dsa_switch_for_each_port((_dp), (_ds)) \
 		if (dsa_port_is_user((_dp)))
 
+#define dsa_switch_for_each_user_port_continue_reverse(_dp, _ds) \
+	dsa_switch_for_each_port_continue_reverse((_dp), (_ds)) \
+		if (dsa_port_is_user((_dp)))
+
 #define dsa_switch_for_each_cpu_port(_dp, _ds) \
 	dsa_switch_for_each_port((_dp), (_ds)) \
 		if (dsa_port_is_cpu((_dp)))
diff --git a/net/dsa/user.c b/net/dsa/user.c
index f4ac82e8a39e8..b9dd508f1fd9e 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -2189,6 +2189,58 @@ dsa_user_dcbnl_set_default_prio(struct net_device *dev, struct dcb_app *app)
 	return 0;
 }
 
+/* Update the DSCP prio entries on all user ports of the switch in case
+ * the switch supports global DSCP prio instead of per port DSCP prios.
+ */
+static int dsa_user_dcbnl_ieee_global_dscp_setdel(struct net_device *dev,
+						  struct dcb_app *app, bool del)
+{
+	int (*setdel)(struct net_device *dev, struct dcb_app *app);
+	struct dsa_port *dp = dsa_user_to_port(dev);
+	struct dsa_switch *ds = dp->ds;
+	struct dsa_port *other_dp;
+	int err, restore_err;
+
+	if (del)
+		setdel = dcb_ieee_delapp;
+	else
+		setdel = dcb_ieee_setapp;
+
+	dsa_switch_for_each_user_port(other_dp, ds) {
+		struct net_device *user = other_dp->user;
+
+		if (!user || user == dev)
+			continue;
+
+		err = setdel(user, app);
+		if (err)
+			goto err_try_to_restore;
+	}
+
+	return 0;
+
+err_try_to_restore:
+
+	/* Revert logic to restore previous state of app entries */
+	if (!del)
+		setdel = dcb_ieee_delapp;
+	else
+		setdel = dcb_ieee_setapp;
+
+	dsa_switch_for_each_user_port_continue_reverse(other_dp, ds) {
+		struct net_device *user = other_dp->user;
+
+		if (!user || user == dev)
+			continue;
+
+		restore_err = setdel(user, app);
+		if (restore_err)
+			netdev_err(user, "Failed to restore DSCP prio entry configuration\n");
+	}
+
+	return err;
+}
+
 static int __maybe_unused
 dsa_user_dcbnl_add_dscp_prio(struct net_device *dev, struct dcb_app *app)
 {
@@ -2220,6 +2272,17 @@ dsa_user_dcbnl_add_dscp_prio(struct net_device *dev, struct dcb_app *app)
 		return err;
 	}
 
+	if (!ds->dscp_prio_mapping_is_global)
+		return 0;
+
+	err = dsa_user_dcbnl_ieee_global_dscp_setdel(dev, app, false);
+	if (err) {
+		if (ds->ops->port_del_dscp_prio)
+			ds->ops->port_del_dscp_prio(ds, port, dscp, new_prio);
+		dcb_ieee_delapp(dev, app);
+		return err;
+	}
+
 	return 0;
 }
 
@@ -2290,6 +2353,18 @@ dsa_user_dcbnl_del_dscp_prio(struct net_device *dev, struct dcb_app *app)
 		return err;
 	}
 
+	if (!ds->dscp_prio_mapping_is_global)
+		return 0;
+
+	err = dsa_user_dcbnl_ieee_global_dscp_setdel(dev, app, true);
+	if (err) {
+		if (ds->ops->port_add_dscp_prio)
+			ds->ops->port_add_dscp_prio(ds, port, dscp,
+						    app->priority);
+		dcb_ieee_setapp(dev, app);
+		return err;
+	}
+
 	return 0;
 }
 
-- 
2.39.2


