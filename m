Return-Path: <linux-kernel+bounces-162337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C118B5988
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5731028DA58
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E7670CAA;
	Mon, 29 Apr 2024 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="G9OxHGn6"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAA9C2C6;
	Mon, 29 Apr 2024 13:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714396220; cv=none; b=IYLsTqkSe9Ur1sIp5fdDSXCTd7Auxns2nkTjs3VlXmsE87hJpltKYwDEMzY2cEnd3k01TCCvzI2y7e7v/1P+1HFtdWXir4cLW5GH3nAI9mPIW5/qHf7erlFW8i7D/gGj5A24QV9xNDTss3ucJAQWb+kuJdXxqViGNEfHVoF9Qhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714396220; c=relaxed/simple;
	bh=l2ypQGYvXw8D2rq+W/qtidSrfjuL+50QzlaZg2ZjPhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k8qSc157Z6lVn97rzYab2V9tsno4IOyns8YF9ujrWBXEo1vF9LrQ49e1Gkp/33VVeQfRPmmwQXWEaqhe3J7BZQt0IIte6V5C+63tnq3H0NEGrvVCcPhx0/cJLCR80BdlbPkprz6wCG5Vh1xVwxXjpWqrohPpiwLTs60HcY2fRZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=G9OxHGn6; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CA48D240004;
	Mon, 29 Apr 2024 13:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714396214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=c2nY9oW5/iUT6Zx2N63VDP2nYCyfzTT6a6pD8hndgb8=;
	b=G9OxHGn6e5kmPlbyzBHCQ+YkrA8iFhVI7DgJ4gnbkO81DdHTf4Uhn3awWQ9rcMdpE/NY/A
	8+cTE81yeNqg9MHep3OY4Xu9J1bLoFi2NKS0It1lA7TsGPVSDtCP6PGoHadhmeStFzGntm
	ogVXGm/jMXXqJ0xpj6I4B3XI5W7KtMmo+YE03uKdqloA9vtNuYypXJmkWmdExhIcJhJ7M8
	ESVccH7WSn/bFzoQuyilX1S4T0QY4aI6jS/Q7ehFE2soYTaJ2FtsU8How2FCdFEHEbrY2O
	UXeYT8ZlllNsefzIubBl6RD0jb9Xd76CmXp0J412ZYzNXV3Mqy23UpNQUMe0TQ==
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
	Nathan Chancellor <nathan@kernel.org>,
	Antoine Tenart <atenart@kernel.org>
Subject: [PATCH net-next] net: phy: Don't conditionally compile the phy_link_topology creation
Date: Mon, 29 Apr 2024 15:10:07 +0200
Message-ID: <20240429131008.439231-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

The core of the phy_link_topology isn't directly tied to phylib, and at
the moment it's initialized, phylib might not be loaded yet. Move the
initialization of the topology to the phy_link_topology_core header,
which contains the bare minimum so that we can initialize it at netdev
creation.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Closes: https://lore.kernel.org/netdev/2e11b89d-100f-49e7-9c9a-834cc0b82f97@gmail.com/
Closes: https://lore.kernel.org/netdev/20240409201553.GA4124869@dev-arch.thelio-3990X/
---
 drivers/net/phy/phy_link_topology.c    | 23 --------------------
 include/linux/phy_link_topology.h      |  5 -----
 include/linux/phy_link_topology_core.h | 30 +++++++++++++++++---------
 3 files changed, 20 insertions(+), 38 deletions(-)

diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
index 985941c5c558..960aedd73308 100644
--- a/drivers/net/phy/phy_link_topology.c
+++ b/drivers/net/phy/phy_link_topology.c
@@ -12,29 +12,6 @@
 #include <linux/rtnetlink.h>
 #include <linux/xarray.h>
 
-struct phy_link_topology *phy_link_topo_create(struct net_device *dev)
-{
-	struct phy_link_topology *topo;
-
-	topo = kzalloc(sizeof(*topo), GFP_KERNEL);
-	if (!topo)
-		return ERR_PTR(-ENOMEM);
-
-	xa_init_flags(&topo->phys, XA_FLAGS_ALLOC1);
-	topo->next_phy_index = 1;
-
-	return topo;
-}
-
-void phy_link_topo_destroy(struct phy_link_topology *topo)
-{
-	if (!topo)
-		return;
-
-	xa_destroy(&topo->phys);
-	kfree(topo);
-}
-
 int phy_link_topo_add_phy(struct phy_link_topology *topo,
 			  struct phy_device *phy,
 			  enum phy_upstream upt, void *upstream)
diff --git a/include/linux/phy_link_topology.h b/include/linux/phy_link_topology.h
index 6b79feb607e7..ad72d7881257 100644
--- a/include/linux/phy_link_topology.h
+++ b/include/linux/phy_link_topology.h
@@ -32,11 +32,6 @@ struct phy_device_node {
 	struct phy_device *phy;
 };
 
-struct phy_link_topology {
-	struct xarray phys;
-	u32 next_phy_index;
-};
-
 static inline struct phy_device *
 phy_link_topo_get_phy(struct phy_link_topology *topo, u32 phyindex)
 {
diff --git a/include/linux/phy_link_topology_core.h b/include/linux/phy_link_topology_core.h
index 0a6479055745..0116ec49cd1b 100644
--- a/include/linux/phy_link_topology_core.h
+++ b/include/linux/phy_link_topology_core.h
@@ -2,24 +2,34 @@
 #ifndef __PHY_LINK_TOPOLOGY_CORE_H
 #define __PHY_LINK_TOPOLOGY_CORE_H
 
-struct phy_link_topology;
+#include <linux/xarray.h>
 
-#if IS_REACHABLE(CONFIG_PHYLIB)
-
-struct phy_link_topology *phy_link_topo_create(struct net_device *dev);
-void phy_link_topo_destroy(struct phy_link_topology *topo);
-
-#else
+struct phy_link_topology {
+	struct xarray phys;
+	u32 next_phy_index;
+};
 
 static inline struct phy_link_topology *phy_link_topo_create(struct net_device *dev)
 {
-	return NULL;
+	struct phy_link_topology *topo;
+
+	topo = kzalloc(sizeof(*topo), GFP_KERNEL);
+	if (!topo)
+		return ERR_PTR(-ENOMEM);
+
+	xa_init_flags(&topo->phys, XA_FLAGS_ALLOC1);
+	topo->next_phy_index = 1;
+
+	return topo;
 }
 
 static inline void phy_link_topo_destroy(struct phy_link_topology *topo)
 {
-}
+	if (!topo)
+		return;
 
-#endif
+	xa_destroy(&topo->phys);
+	kfree(topo);
+}
 
 #endif /* __PHY_LINK_TOPOLOGY_CORE_H */
-- 
2.44.0


