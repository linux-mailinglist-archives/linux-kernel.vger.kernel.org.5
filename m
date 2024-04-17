Return-Path: <linux-kernel+bounces-148673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 449E58A85ED
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFCDD1F21A9F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1BD141995;
	Wed, 17 Apr 2024 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XCQvZbM4"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27117140397;
	Wed, 17 Apr 2024 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364049; cv=none; b=fPVfzLUyIICJC2WLNwsRQaGbFnjDDQxwpw3oSIILQPngbTeue28Ks0d6P+gw4kL9qotPRL/vfaJpGc1urikuIjSyREdP0zjB/1FTssfCEsqZFzwjHLFRvWyC8eFfl3RAnbu2hwQuOKaeJI+ZwJMplV6MuuEqt39DAfCG5Xw+Le8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364049; c=relaxed/simple;
	bh=K+f/3Fw0l/IbMbZkGP+l5j+8E9MRO2mxZSVM7HRjjgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tho4BYbHbMpkme1FZrnPq35Y75vHQBMoD1jYLIape1Uq02nIaxJ8caBbOiKUxk1BtKCKYR4hHlhvR9IZWAdtvO4TPUnP6pnEVBbXRf7IrrEt4zTeYEJQS/lMCmfPFUMYz9kMD9yeuNwe9QzsxQnRNmme0K2iX++2yfnatAuuny0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XCQvZbM4; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4F879C0011;
	Wed, 17 Apr 2024 14:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713364044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+gblB2roJbwC6k0Ap41QA3FYglfv4FFJz0F7EnAebFE=;
	b=XCQvZbM4nqNpj6mMFURbYjC7Sp/+tvMg/HEtaMxlh0cCcgU3JtIHPxNUETADzJzzbISEUG
	CwbRAHSEthGj0nEzp1Ab6SSx0aRONpZkAf6zrALy0SOA/d35LpzEiU55ZtmAsbfGCJu3AS
	8x33SC7ycOCYTD9XSUvlGipx1+lFMbdavNFj2hp57pzYBUsdeRuwkZe+jkGOKCuukXpBlb
	WMOt/ByIdnwRdgLm71mwRbFK2v4NDejcZh9Gh7rqQfro20z8PhhEHNHiaisDcLLCPF9u6l
	+iSysDrG9ODCQSLJCVUgpJ8qZ/flJ93DOGL0YStli+0eiXVTEFJBZp39bnBOjA==
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
Subject: [PATCH net-next] net: phy: link_topology: Don't stub-away the topology creation
Date: Wed, 17 Apr 2024 16:27:05 +0200
Message-ID: <20240417142707.2082523-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Some of the phy_link_topology operations are protected by IS_REACHABLE,
which can lead to scenarios where the consumer, built as modules, sees the topology
unstubbed, whereas the initialization didn't occur.

Don't stub away the creation of the topology, it has no dependency on
any other parts like phylib, so we can make it always available.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Closes: https://lore.kernel.org/netdev/2e11b89d-100f-49e7-9c9a-834cc0b82f97@gmail.com/
Closes: https://lore.kernel.org/netdev/20240409201553.GA4124869@dev-arch.thelio-3990X/
---
Hi Nathan, Heiner,

I'm currently at EOSS, so I'm sending this patch without having been
able to properly test it (build-tested only), but as this addresses an
issue for people using -next, I'm sending this anyway, sorry about that.

Hopefully it can address the issue for now, I haven't given-up on your
idea to introduce a config option Heiner :)

Thanks,

Maxime

 include/linux/phy_link_topology_core.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/include/linux/phy_link_topology_core.h b/include/linux/phy_link_topology_core.h
index 0a6479055745..61e2592f24ac 100644
--- a/include/linux/phy_link_topology_core.h
+++ b/include/linux/phy_link_topology_core.h
@@ -4,22 +4,7 @@
 
 struct phy_link_topology;
 
-#if IS_REACHABLE(CONFIG_PHYLIB)
-
 struct phy_link_topology *phy_link_topo_create(struct net_device *dev);
 void phy_link_topo_destroy(struct phy_link_topology *topo);
 
-#else
-
-static inline struct phy_link_topology *phy_link_topo_create(struct net_device *dev)
-{
-	return NULL;
-}
-
-static inline void phy_link_topo_destroy(struct phy_link_topology *topo)
-{
-}
-
-#endif
-
 #endif /* __PHY_LINK_TOPOLOGY_CORE_H */
-- 
2.44.0


