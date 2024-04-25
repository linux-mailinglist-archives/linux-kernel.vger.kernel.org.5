Return-Path: <linux-kernel+bounces-159036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A30E8B287F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ACD1B23C0C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A461152DE7;
	Thu, 25 Apr 2024 18:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="V7HTrWa2"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9CC12C7FF;
	Thu, 25 Apr 2024 18:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071226; cv=none; b=r40VQl8R/l9ZCRGa6MHJYrW09RKl/KjC0DXgnaBCwhBEl5sPN0ZAD3mSd6jRFNCt8ewzqek+8Jhj87+1YLcBXKP1tCfOH4B7anHBVdOwQ3bg+LByK28dSFlhQ/aS/SwAozvlR40hG6XCOlvGFAlQDcfzNmZWfOidva7MptchdpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071226; c=relaxed/simple;
	bh=m6fS1VUEsWRrHVWbT4r2pyKL+tz9j9d+2qSWPcDT530=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XyCuDoeQMDCF+wZGtztzNKbTh+8SLGC35iJ2sEOwVOSuLiv8SVRQMmOWBcH6gQ6hD1Y5VeOE1S7aB9x9hEaphpYQfC8JWHSaox3Nw31IL/cvGsfUBLXkD+u1zIQQg6TbAa1TTpaaRfAK5wjUOaoZM6FJbq4Oa5QQEFiNuSZ+zQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=V7HTrWa2; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 4DFE5C003DF7;
	Thu, 25 Apr 2024 11:53:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 4DFE5C003DF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1714071218;
	bh=m6fS1VUEsWRrHVWbT4r2pyKL+tz9j9d+2qSWPcDT530=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V7HTrWa2u/mTRkVnyZF5kpNcUjpDxgrAAKs7gYzMNu26iBsd5VfrEAEsRvoxEuRrp
	 CaRJj+YFA27H2oqjNoN6QXIiTOO3PrM4JTdYlk/gqvYYOBRt2gOgPQEDQ8+kHJLe3C
	 Lo3RVGH4MQ6773m82Ug13R6ASYjS1CrDAIzn2ZMA=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 56DA718041CAC7;
	Thu, 25 Apr 2024 11:53:36 -0700 (PDT)
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
Subject: [PATCH net-next 2/2] net: dsa: Remove adjust_link paths
Date: Thu, 25 Apr 2024 11:53:36 -0700
Message-Id: <20240425185336.2084871-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425185336.2084871-1-florian.fainelli@broadcom.com>
References: <20240425185336.2084871-1-florian.fainelli@broadcom.com>
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
 net/dsa/port.c    | 135 ++++------------------------------------------
 3 files changed, 12 insertions(+), 133 deletions(-)

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
index c6febc3d96d9..08b6d91da430 100644
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
@@ -1622,11 +1603,8 @@ static void dsa_port_phylink_mac_link_down(struct phylink_config *config,
 	if (dsa_port_is_user(dp))
 		phydev = dp->user->phydev;
 
-	if (!ds->ops->phylink_mac_link_down) {
-		if (ds->ops->adjust_link && phydev)
-			ds->ops->adjust_link(ds, dp->index, phydev);
+	if (!ds->ops->phylink_mac_link_down)
 		return;
-	}
 
 	ds->ops->phylink_mac_link_down(ds, dp->index, mode, interface);
 }
@@ -1641,11 +1619,8 @@ static void dsa_port_phylink_mac_link_up(struct phylink_config *config,
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
@@ -1708,78 +1683,6 @@ void dsa_port_phylink_destroy(struct dsa_port *dp)
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
@@ -1983,44 +1886,28 @@ int dsa_shared_port_link_register_of(struct dsa_port *dp)
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


