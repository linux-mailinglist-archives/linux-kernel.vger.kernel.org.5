Return-Path: <linux-kernel+bounces-164420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E438B7D71
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B1562840A4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B952417BB0D;
	Tue, 30 Apr 2024 16:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aWUH8n2K"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF51143756;
	Tue, 30 Apr 2024 16:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495707; cv=none; b=QHPUBcoZy4nUMl3BEZQyeEknOyeAVEzOkvqwE+PUuDoRP/YiY9DMIGcyLBMPf2AzlBFAHMY1UyQr7fRgq+CFh2bxxQpfmxC0VwZ+xJGUDdSbq9IHZrd2HixZ2sbqjulAHTPaRohoiBfxZWs7KMBMcPQgyBPfNNj0rqE5s2MIfYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495707; c=relaxed/simple;
	bh=YMlFVmBynb+YgzmJ3e8EyJYDfIpgeF7HrDt8f15qLA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=peNnnVSUve93wGo5JJbhDdLEQbbzWFkfye9NxsTOiTb5VM1oK4qDO4BzPOP5K32rN5nnZyRO6QhuIEJ8qVQyEZVkGL9NDmTc1DufdnvgtpW9mpibvIqMvDOOIBO1Ugk6fnzzNDlbbY1N50d32pUhNXh9Us1wdPQRnIqG17sdYH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aWUH8n2K; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id DE8B0C0000E7;
	Tue, 30 Apr 2024 09:48:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com DE8B0C0000E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1714495705;
	bh=YMlFVmBynb+YgzmJ3e8EyJYDfIpgeF7HrDt8f15qLA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aWUH8n2Kp5M8mXVLqFPgXilLdwIh0JWF8FwBF+G+maXnTvmQBv0KUks97JK2ffqh5
	 hX8dDcSsK5vRuHCArUjINChoqGARLYCC56GujaRROAWglaccneF3QUvdlqpF4fjaeX
	 dr1l0L8CPm5muMej5EfwgXUMJqkE4XKoNuZ013pA=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 0172118041CAC7;
	Tue, 30 Apr 2024 09:48:22 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v3 2/2] net: dsa: Remove adjust_link paths
Date: Tue, 30 Apr 2024 09:48:16 -0700
Message-Id: <20240430164816.2400606-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430164816.2400606-1-florian.fainelli@broadcom.com>
References: <20240430164816.2400606-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we no longer any drivers using PHYLIB's adjust_link callback,
remove all paths that made use of adjust_link as well as the associated
functions.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 include/net/dsa.h |   7 ---
 net/dsa/dsa.c     |   3 +-
 net/dsa/port.c    | 139 ++++------------------------------------------
 3 files changed, 12 insertions(+), 137 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 678f1fd8b189..eef702dbea78 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -24,8 +24,6 @@
 
 struct dsa_8021q_context;
 struct tc_action;
-struct phy_device;
-struct phylink_link_state;
 
 #define DSA_TAG_PROTO_NONE_VALUE		0
 #define DSA_TAG_PROTO_BRCM_VALUE		1
@@ -867,11 +865,6 @@ struct dsa_switch_ops {
 	int	(*phy_write)(struct dsa_switch *ds, int port,
 			     int regnum, u16 val);
 
-	/*
-	 * Link state adjustment (called from libphy)
-	 */
-	void	(*adjust_link)(struct dsa_switch *ds, int port,
-				struct phy_device *phydev);
 	/*
 	 * PHYLINK integration
 	 */
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 2f347cd37316..12521a7d4048 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -1511,8 +1511,7 @@ static int dsa_switch_probe(struct dsa_switch *ds)
 		    ds->ops->phylink_mac_config ||
 		    ds->ops->phylink_mac_finish ||
 		    ds->ops->phylink_mac_link_down ||
-		    ds->ops->phylink_mac_link_up ||
-		    ds->ops->adjust_link)
+		    ds->ops->phylink_mac_link_up)
 			return -EINVAL;
 	}
 
diff --git a/net/dsa/port.c b/net/dsa/port.c
index c6febc3d96d9..9a249d4ac3a5 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -1535,25 +1535,6 @@ void dsa_port_set_tag_protocol(struct dsa_port *cpu_dp,
 	cpu_dp->tag_ops = tag_ops;
 }
 
-static struct phy_device *dsa_port_get_phy_device(struct dsa_port *dp)
-{
-	struct device_node *phy_dn;
-	struct phy_device *phydev;
-
-	phy_dn = of_parse_phandle(dp->dn, "phy-handle", 0);
-	if (!phy_dn)
-		return NULL;
-
-	phydev = of_phy_find_device(phy_dn);
-	if (!phydev) {
-		of_node_put(phy_dn);
-		return ERR_PTR(-EPROBE_DEFER);
-	}
-
-	of_node_put(phy_dn);
-	return phydev;
-}
-
 static struct phylink_pcs *
 dsa_port_phylink_mac_select_pcs(struct phylink_config *config,
 				phy_interface_t interface)
@@ -1616,17 +1597,10 @@ static void dsa_port_phylink_mac_link_down(struct phylink_config *config,
 					   phy_interface_t interface)
 {
 	struct dsa_port *dp = dsa_phylink_to_port(config);
-	struct phy_device *phydev = NULL;
 	struct dsa_switch *ds = dp->ds;
 
-	if (dsa_port_is_user(dp))
-		phydev = dp->user->phydev;
-
-	if (!ds->ops->phylink_mac_link_down) {
-		if (ds->ops->adjust_link && phydev)
-			ds->ops->adjust_link(ds, dp->index, phydev);
+	if (!ds->ops->phylink_mac_link_down)
 		return;
-	}
 
 	ds->ops->phylink_mac_link_down(ds, dp->index, mode, interface);
 }
@@ -1641,11 +1615,8 @@ static void dsa_port_phylink_mac_link_up(struct phylink_config *config,
 	struct dsa_port *dp = dsa_phylink_to_port(config);
 	struct dsa_switch *ds = dp->ds;
 
-	if (!ds->ops->phylink_mac_link_up) {
-		if (ds->ops->adjust_link && phydev)
-			ds->ops->adjust_link(ds, dp->index, phydev);
+	if (!ds->ops->phylink_mac_link_up)
 		return;
-	}
 
 	ds->ops->phylink_mac_link_up(ds, dp->index, mode, interface, phydev,
 				     speed, duplex, tx_pause, rx_pause);
@@ -1708,78 +1679,6 @@ void dsa_port_phylink_destroy(struct dsa_port *dp)
 	dp->pl = NULL;
 }
 
-static int dsa_shared_port_setup_phy_of(struct dsa_port *dp, bool enable)
-{
-	struct dsa_switch *ds = dp->ds;
-	struct phy_device *phydev;
-	int port = dp->index;
-	int err = 0;
-
-	phydev = dsa_port_get_phy_device(dp);
-	if (!phydev)
-		return 0;
-
-	if (IS_ERR(phydev))
-		return PTR_ERR(phydev);
-
-	if (enable) {
-		err = genphy_resume(phydev);
-		if (err < 0)
-			goto err_put_dev;
-
-		err = genphy_read_status(phydev);
-		if (err < 0)
-			goto err_put_dev;
-	} else {
-		err = genphy_suspend(phydev);
-		if (err < 0)
-			goto err_put_dev;
-	}
-
-	if (ds->ops->adjust_link)
-		ds->ops->adjust_link(ds, port, phydev);
-
-	dev_dbg(ds->dev, "enabled port's phy: %s", phydev_name(phydev));
-
-err_put_dev:
-	put_device(&phydev->mdio.dev);
-	return err;
-}
-
-static int dsa_shared_port_fixed_link_register_of(struct dsa_port *dp)
-{
-	struct device_node *dn = dp->dn;
-	struct dsa_switch *ds = dp->ds;
-	struct phy_device *phydev;
-	int port = dp->index;
-	phy_interface_t mode;
-	int err;
-
-	err = of_phy_register_fixed_link(dn);
-	if (err) {
-		dev_err(ds->dev,
-			"failed to register the fixed PHY of port %d\n",
-			port);
-		return err;
-	}
-
-	phydev = of_phy_find_device(dn);
-
-	err = of_get_phy_mode(dn, &mode);
-	if (err)
-		mode = PHY_INTERFACE_MODE_NA;
-	phydev->interface = mode;
-
-	genphy_read_status(phydev);
-
-	if (ds->ops->adjust_link)
-		ds->ops->adjust_link(ds, port, phydev);
-
-	put_device(&phydev->mdio.dev);
-
-	return 0;
-}
-
 static int dsa_shared_port_phylink_register(struct dsa_port *dp)
 {
 	struct dsa_switch *ds = dp->ds;
@@ -1983,44 +1882,28 @@ int dsa_shared_port_link_register_of(struct dsa_port *dp)
 					dsa_switches_apply_workarounds))
 		return -EINVAL;
 
-	if (!ds->ops->adjust_link) {
-		if (missing_link_description) {
-			dev_warn(ds->dev,
-				 "Skipping phylink registration for %s port %d\n",
-				 dsa_port_is_cpu(dp) ? "CPU" : "DSA", dp->index);
-		} else {
-			dsa_shared_port_link_down(dp);
+	if (missing_link_description) {
+		dev_warn(ds->dev,
+			 "Skipping phylink registration for %s port %d\n",
+			 dsa_port_is_cpu(dp) ? "CPU" : "DSA", dp->index);
+	} else {
+		dsa_shared_port_link_down(dp);
 
-			return dsa_shared_port_phylink_register(dp);
-		}
-		return 0;
+		return dsa_shared_port_phylink_register(dp);
 	}
 
-	dev_warn(ds->dev,
-		 "Using legacy PHYLIB callbacks. Please migrate to PHYLINK!\n");
-
-	if (of_phy_is_fixed_link(dp->dn))
-		return dsa_shared_port_fixed_link_register_of(dp);
-	else
-		return dsa_shared_port_setup_phy_of(dp, true);
+	return 0;
 }
 
 void dsa_shared_port_link_unregister_of(struct dsa_port *dp)
 {
-	struct dsa_switch *ds = dp->ds;
-
-	if (!ds->ops->adjust_link && dp->pl) {
+	if (dp->pl) {
 		rtnl_lock();
 		phylink_disconnect_phy(dp->pl);
 		rtnl_unlock();
 		dsa_port_phylink_destroy(dp);
 		return;
 	}
-
-	if (of_phy_is_fixed_link(dp->dn))
-		of_phy_deregister_fixed_link(dp->dn);
-	else
-		dsa_shared_port_setup_phy_of(dp, false);
 }
 
 int dsa_port_hsr_join(struct dsa_port *dp, struct net_device *hsr,
-- 
2.34.1


