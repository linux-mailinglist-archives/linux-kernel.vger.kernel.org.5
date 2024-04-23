Return-Path: <linux-kernel+bounces-155751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B96A8AF6A6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF057287148
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2DE140363;
	Tue, 23 Apr 2024 18:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XmA1fUKM"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EDC224F0;
	Tue, 23 Apr 2024 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713897229; cv=none; b=uqZKlhjHeSUBgxpUYIHe1a6NFH30+9vWjBuIWed3mKZHm2x5OPWdxjO79V4BPsKQETs5y3tuOJW9zJNCsETVw9kmUI9HMnVUKVvQJFD8tvY6535xTr8urtt1j5K8F/E72c53GHjCk9dFbVlrmIzRuPbBIOhC7njZ9KwT6U0cYXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713897229; c=relaxed/simple;
	bh=5Rs4NDx0w9fZ2G6+ayoz5dB3lgt7R2tOgtEK4vnKs9A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lcbYhgcSSxA4BFFPjS0PLDzBPNXaRfOWuz35vqRtX+GLxbdPk5lxlaGbhgvquDzHwDkTNO52c2/3B8On6Ni3CHVti/HC6w8+aF5GmqBKZsROV5mypd4YxxJgz2LGF+rNu/Ee6JuIRSz4CEtuSs/Q/fMouJmaeDfyyfxkQ7WFMrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XmA1fUKM; arc=none smtp.client-ip=192.19.144.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 86999C002816;
	Tue, 23 Apr 2024 11:33:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 86999C002816
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1713897221;
	bh=5Rs4NDx0w9fZ2G6+ayoz5dB3lgt7R2tOgtEK4vnKs9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XmA1fUKMY2dJWb488nPAXVhe06pqY5QoLWOwatXPdbsEM3h1+PPJUzgRO54ctIZen
	 nBXRGFCU9pTTUyIiWx5m2NRRB0OE/s7MfoW4VWAVH1ePX1z1nEVk7oZSjmayrj5Ujl
	 OsYWgxEta8/qn9YWpIJ+N8/3uEjBKnJQEEIZ44aU=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id AC72C18041CAC6;
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
Subject: [PATCH net-next 5/8] net: dsa: b53: Configure RGMII for 531x5 and MII for 5325
Date: Tue, 23 Apr 2024 11:33:36 -0700
Message-Id: <20240423183339.1368511-6-florian.fainelli@broadcom.com>
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

Call b53_adjust_531x5_rgmii() and b53_adjust_5325_mii() from
b53_phylink_mac_config() when we have a fixed PHY in preparation for removing
b53_adjust_link(). Also move b53_adjust_63xx_rgmii() to
b53_phylink_mac_config() where it logically belongs.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 6277ab7dcb7f..18b87e903943 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1438,6 +1438,20 @@ static void b53_phylink_mac_config(struct dsa_switch *ds, int port,
 				   unsigned int mode,
 				   const struct phylink_link_state *state)
 {
+	phy_interface_t interface = state->interface;
+	struct b53_device *dev = ds->priv;
+
+	if (is63xx(dev) && port >= B53_63XX_RGMII0)
+		b53_adjust_63xx_rgmii(ds, port, interface);
+
+	if (mode == MLO_AN_FIXED) {
+		if (is531x5(dev) && phy_interface_mode_is_rgmii(interface))
+			b53_adjust_531x5_rgmii(ds, port, interface);
+
+		/* configure MII port if necessary */
+		if (is5325(dev))
+			b53_adjust_5325_mii(ds, port);
+	}
 }
 
 static void b53_phylink_mac_link_down(struct dsa_switch *ds, int port,
@@ -1468,9 +1482,6 @@ static void b53_phylink_mac_link_up(struct dsa_switch *ds, int port,
 {
 	struct b53_device *dev = ds->priv;
 
-	if (is63xx(dev) && port >= B53_63XX_RGMII0)
-		b53_adjust_63xx_rgmii(ds, port, interface);
-
 	if (mode == MLO_AN_PHY)
 		return;
 
-- 
2.34.1


