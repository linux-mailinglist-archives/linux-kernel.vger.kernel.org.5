Return-Path: <linux-kernel+bounces-1403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F4F814E7F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A586B22FD9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D98E30116;
	Fri, 15 Dec 2023 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kltrZKiS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F26570989;
	Fri, 15 Dec 2023 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DAA06C0005;
	Fri, 15 Dec 2023 17:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702660376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6acbIxUaygwdBAtcndMa1MEIHVnUPv1H6l3Q0oeoTb8=;
	b=kltrZKiSAvQwP+ota8LHc3U+65OeMlfKlBC4ccwoQ4jPPSeKlYmStIXg6TvPVi5AjyTm+u
	JvO6UZ2ExzsujhGJXmbVHcpadK95FHA98eWZ531St5iNvXCKINbSkpoSZmbLu3UZl6Gh0s
	eHB3ORRqSA05sKQVme7+w0GFgWH68/3P1EHxLluUT7rXxUO2a9cLdgCGg4iyN7u4EK79gV
	3ZMgcVb/ZScXFk0Me2it/K0dA1/y4EPvYBxbb/V7E7F51kc1mS2Z3G2ET2YQCp3Kb+ypqq
	Sf2tx0M8wLaBFvYwWhTohhyAMng+lD1CqeQi8wQlsnbHAfQ4mDl4haQWQrRkVg==
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
	Jonathan Corbet <corbet@lwn.net>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>
Subject: [PATCH net-next v4 11/13] net: ethtool: cable-test: Target the command to the requested PHY
Date: Fri, 15 Dec 2023 18:12:33 +0100
Message-ID: <20231215171237.1152563-12-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215171237.1152563-1-maxime.chevallier@bootlin.com>
References: <20231215171237.1152563-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Cable testing is a PHY-specific command. Instead of targeting the command
towards dev->phydev, use the request to pick the targeted PHY.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V4: No changes
V3: No changes
V2: New patch

 net/ethtool/cabletest.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/ethtool/cabletest.c b/net/ethtool/cabletest.c
index 06a151165c31..6b00d0800f23 100644
--- a/net/ethtool/cabletest.c
+++ b/net/ethtool/cabletest.c
@@ -69,7 +69,7 @@ int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info)
 		return ret;
 
 	dev = req_info.dev;
-	if (!dev->phydev) {
+	if (!req_info.phydev) {
 		ret = -EOPNOTSUPP;
 		goto out_dev_put;
 	}
@@ -85,12 +85,12 @@ int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		goto out_rtnl;
 
-	ret = ops->start_cable_test(dev->phydev, info->extack);
+	ret = ops->start_cable_test(req_info.phydev, info->extack);
 
 	ethnl_ops_complete(dev);
 
 	if (!ret)
-		ethnl_cable_test_started(dev->phydev,
+		ethnl_cable_test_started(req_info.phydev,
 					 ETHTOOL_MSG_CABLE_TEST_NTF);
 
 out_rtnl:
@@ -321,7 +321,7 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
 		return ret;
 
 	dev = req_info.dev;
-	if (!dev->phydev) {
+	if (!req_info.phydev) {
 		ret = -EOPNOTSUPP;
 		goto out_dev_put;
 	}
@@ -342,12 +342,12 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		goto out_rtnl;
 
-	ret = ops->start_cable_test_tdr(dev->phydev, info->extack, &cfg);
+	ret = ops->start_cable_test_tdr(req_info.phydev, info->extack, &cfg);
 
 	ethnl_ops_complete(dev);
 
 	if (!ret)
-		ethnl_cable_test_started(dev->phydev,
+		ethnl_cable_test_started(req_info.phydev,
 					 ETHTOOL_MSG_CABLE_TEST_TDR_NTF);
 
 out_rtnl:
-- 
2.43.0


