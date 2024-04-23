Return-Path: <linux-kernel+bounces-155752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9368AF6A8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57F0E28766D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C471411D1;
	Tue, 23 Apr 2024 18:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="t+CvzY17"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F0F22F00;
	Tue, 23 Apr 2024 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713897229; cv=none; b=tSS8F2th7ThZYwuAQNL5ZOxOd3OKhym0PV/dqDunQFwtNvGOFJKf/wz4bkDOd36pPJAKevnqjEMUvoC5/HQfIsli8XS6Hy7F6ONucei6M2uvSzFxxArH7R14+YulE88eH6dl/dY0tUDqgeif9HOMHupTkDZeSayZtlzVQS+9E/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713897229; c=relaxed/simple;
	bh=W6upYFSbC/AtRfsSGseW2eq7TXbXu8gGNZXAsNYKnS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sB5df5fQqw0q3KmF/T4engHk+WLHLUEwsux1DEsUCI43UL4hei7glOWy2LsqAtrPOrWp2sVaWJD7AzGV4wQiF8/vArLzYkyoqdMuwvYzwidBvIiEhyzoWSgt3TyNVQEzVhR2WsPQCL177LfotEYbFNugum/c8N2SkofZwVSR/CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=t+CvzY17; arc=none smtp.client-ip=192.19.144.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id EB5D4C002812;
	Tue, 23 Apr 2024 11:33:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com EB5D4C002812
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1713897221;
	bh=W6upYFSbC/AtRfsSGseW2eq7TXbXu8gGNZXAsNYKnS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t+CvzY17XndT/hK+dyqJz4NhWnjFZc0M1KoTMa2vEiuGb4kYVS4Z2TGxpQuhFMeM6
	 LjVoI6ucW+dKLXtPO8qnrC+Za/pftGZYMnBpNqMzhl5rUo8vUlrt+YSdtSlgDFdaRI
	 Nu46B/JWmANstUV/zuO5088U4dQwGVuGczuHg0Js=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 1BFE618041CAC6;
	Tue, 23 Apr 2024 11:33:39 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 1/8] net: dsa: b53: Stop exporting b53_phylink_* routines
Date: Tue, 23 Apr 2024 11:33:32 -0700
Message-Id: <20240423183339.1368511-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423183339.1368511-1-florian.fainelli@broadcom.com>
References: <20240423183339.1368511-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

They are not used outside of the b53_common.c file, no need to be
exported.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 27 ++++++++++++---------------
 drivers/net/dsa/b53/b53_priv.h   | 12 ------------
 2 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index b2eeff04f4c8..bd069439549f 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1420,16 +1420,15 @@ static struct phylink_pcs *b53_phylink_mac_select_pcs(struct dsa_switch *ds,
 	return dev->ops->phylink_mac_select_pcs(dev, port, interface);
 }
 
-void b53_phylink_mac_config(struct dsa_switch *ds, int port,
-			    unsigned int mode,
-			    const struct phylink_link_state *state)
+static void b53_phylink_mac_config(struct dsa_switch *ds, int port,
+				   unsigned int mode,
+				   const struct phylink_link_state *state)
 {
 }
-EXPORT_SYMBOL(b53_phylink_mac_config);
 
-void b53_phylink_mac_link_down(struct dsa_switch *ds, int port,
-			       unsigned int mode,
-			       phy_interface_t interface)
+static void b53_phylink_mac_link_down(struct dsa_switch *ds, int port,
+				      unsigned int mode,
+				      phy_interface_t interface)
 {
 	struct b53_device *dev = ds->priv;
 
@@ -1445,14 +1444,13 @@ void b53_phylink_mac_link_down(struct dsa_switch *ds, int port,
 	    dev->ops->serdes_link_set)
 		dev->ops->serdes_link_set(dev, port, mode, interface, false);
 }
-EXPORT_SYMBOL(b53_phylink_mac_link_down);
 
-void b53_phylink_mac_link_up(struct dsa_switch *ds, int port,
-			     unsigned int mode,
-			     phy_interface_t interface,
-			     struct phy_device *phydev,
-			     int speed, int duplex,
-			     bool tx_pause, bool rx_pause)
+static void b53_phylink_mac_link_up(struct dsa_switch *ds, int port,
+				    unsigned int mode,
+				    phy_interface_t interface,
+				    struct phy_device *phydev,
+				    int speed, int duplex,
+				    bool tx_pause, bool rx_pause)
 {
 	struct b53_device *dev = ds->priv;
 
@@ -1473,7 +1471,6 @@ void b53_phylink_mac_link_up(struct dsa_switch *ds, int port,
 	    dev->ops->serdes_link_set)
 		dev->ops->serdes_link_set(dev, port, mode, interface, true);
 }
-EXPORT_SYMBOL(b53_phylink_mac_link_up);
 
 int b53_vlan_filtering(struct dsa_switch *ds, int port, bool vlan_filtering,
 		       struct netlink_ext_ack *extack)
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index c13a907947f1..05141176daf5 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -352,18 +352,6 @@ int b53_br_flags(struct dsa_switch *ds, int port,
 		 struct netlink_ext_ack *extack);
 int b53_setup_devlink_resources(struct dsa_switch *ds);
 void b53_port_event(struct dsa_switch *ds, int port);
-void b53_phylink_mac_config(struct dsa_switch *ds, int port,
-			    unsigned int mode,
-			    const struct phylink_link_state *state);
-void b53_phylink_mac_link_down(struct dsa_switch *ds, int port,
-			       unsigned int mode,
-			       phy_interface_t interface);
-void b53_phylink_mac_link_up(struct dsa_switch *ds, int port,
-			     unsigned int mode,
-			     phy_interface_t interface,
-			     struct phy_device *phydev,
-			     int speed, int duplex,
-			     bool tx_pause, bool rx_pause);
 int b53_vlan_filtering(struct dsa_switch *ds, int port, bool vlan_filtering,
 		       struct netlink_ext_ack *extack);
 int b53_vlan_add(struct dsa_switch *ds, int port,
-- 
2.34.1


