Return-Path: <linux-kernel+bounces-142527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB9F8A2CC9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 219CD1F226B7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D028543AC0;
	Fri, 12 Apr 2024 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DbjrBSH8"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5323620310;
	Fri, 12 Apr 2024 10:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712918784; cv=none; b=Jh8rNeHPUfbNwfyNePksHWbA1yom/YErxWaibCvH2SXgPjt6IWrwnY4o5xbOMi1rXh/fmiKSNWs4zFa/HRTpwSUmxiVO8X31ZZCzaCelDxgPs+oOF2xkkD9xCuHOhAaTxT79YTdr2N7jp+SNMOc0TkrATZ95sCqOpQQMUAXaNX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712918784; c=relaxed/simple;
	bh=Cu3HN4Jc80J7VKYfW/r+tTVJEg6eOmO7O5fflj7dDWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oNEp3Y2i72cotwxeZfOxwgkdiC49zaNlLqhVDfxXTENtNUpoarb+X56fM2fLEotdDyeCGxpUnetWG3QyxXmdwA74rTEFlVMYVuHG8ApqmT2TRMnR2TLVihIhRYHu60+y5wDxsbPcO1UbKIFEjyPn/DPD2A3j/2QOZATPBnOIfsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DbjrBSH8; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 855802000B;
	Fri, 12 Apr 2024 10:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712918779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YNgRIU2UT5K1UZWit6Bh8EiB5voBR6xsuvaO369sMeo=;
	b=DbjrBSH8H+gABaWjk9e+ChddzEQq2eNtOK+JGnuOpIS/mozJBZLVctgS9BA/LBnkCL+OZR
	pI5qZRzOWugtFgNLXMkMUGVk0Qg1JP9fbt3z7s2fwTCL1qjTbbLy2OiePMZ2Nl3Q8m2hYi
	aZ9WAoT2DmEw1S/4OaRrcPuTm7fypSsA81FrQebKftryQdjOd1OLeboWXsTGA4Cpw5IBE+
	QEIninHkS3+Aa4fE65wVZrX76Pg68NeuhNoeL2726ljbk4vr17Do17x+C27icNZgWb/zQj
	r/eCdmkuRb5bfQz6+wsKkcCJdoWF6tIYk4of3BDJ4o/RbtFxHRAOKgYRctek1A==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH net-next] net: phy: phy_link_topology: Handle NULL topologies
Date: Fri, 12 Apr 2024 12:46:14 +0200
Message-ID: <20240412104615.3779632-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

In situations where phylib is a module, the topology can be NULL as it's
not initialized at netdev creation.

Allow passing a NULL topology pointer to phy_link_topo helpers.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Closes: https://lore.kernel.org/netdev/2e11b89d-100f-49e7-9c9a-834cc0b82f97@gmail.com/
Closes: https://lore.kernel.org/netdev/20240409201553.GA4124869@dev-arch.thelio-3990X/
---

Hi,

This patch fixes a commit that is in net-next, hence the net-next tag and the
lack of "Fixes" tag.

Nathan, Heiner, can you confirm this solves what you're seeing ?

I think we can improve on this solution by moving the topology init at
the first PHY insertion and clearing it at netdev destruction.

Maxime

 drivers/net/phy/phy_link_topology.c | 10 +++++++++-
 include/linux/phy_link_topology.h   |  7 ++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
index 985941c5c558..0f3973f07fac 100644
--- a/drivers/net/phy/phy_link_topology.c
+++ b/drivers/net/phy/phy_link_topology.c
@@ -42,6 +42,9 @@ int phy_link_topo_add_phy(struct phy_link_topology *topo,
 	struct phy_device_node *pdn;
 	int ret;
 
+	if (!topo)
+		return 0;
+
 	pdn = kzalloc(sizeof(*pdn), GFP_KERNEL);
 	if (!pdn)
 		return -ENOMEM;
@@ -93,7 +96,12 @@ EXPORT_SYMBOL_GPL(phy_link_topo_add_phy);
 void phy_link_topo_del_phy(struct phy_link_topology *topo,
 			   struct phy_device *phy)
 {
-	struct phy_device_node *pdn = xa_erase(&topo->phys, phy->phyindex);
+	struct phy_device_node *pdn;
+
+	if (!topo)
+		return;
+
+	pdn = xa_erase(&topo->phys, phy->phyindex);
 
 	/* We delete the PHY from the topology, however we don't re-set the
 	 * phy->phyindex field. If the PHY isn't gone, we can re-assign it the
diff --git a/include/linux/phy_link_topology.h b/include/linux/phy_link_topology.h
index 6b79feb607e7..21ca78127d0f 100644
--- a/include/linux/phy_link_topology.h
+++ b/include/linux/phy_link_topology.h
@@ -40,7 +40,12 @@ struct phy_link_topology {
 static inline struct phy_device *
 phy_link_topo_get_phy(struct phy_link_topology *topo, u32 phyindex)
 {
-	struct phy_device_node *pdn = xa_load(&topo->phys, phyindex);
+	struct phy_device_node *pdn;
+
+	if (!topo)
+		return NULL;
+
+	pdn = xa_load(&topo->phys, phyindex);
 
 	if (pdn)
 		return pdn->phy;
-- 
2.44.0


