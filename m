Return-Path: <linux-kernel+bounces-63777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0066C85344B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910F31F23D29
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B0060EE0;
	Tue, 13 Feb 2024 15:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="X9imBKQN"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18FD60BB7;
	Tue, 13 Feb 2024 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836695; cv=none; b=DzGF+GfFNr2Y+oGTEglXxwpVN+plWwXI0zzlIBlsXgIQO5+S9cuPYjVJHTupGzbGitqW7NnZerYuiND4y4EyFM4ZUwC4Jr5ypiqurfGyzbAweXh+aJlfS6SVO70CQoFp3lrQlMTCiNtKNjqjihIlN48WQ2ZdIGAcUvesYn1V9VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836695; c=relaxed/simple;
	bh=rn6DALXlDmbDVCt5dynIqvf6ymqJW0h7IDOc9cDX4Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hazxa0DKep2+f/5hwMtE7IGOre4Xi5my/HmaqtiwfYDHpC1AZFDYuT6W3RJ3APBQMvHHwDeBxDCLBmWNbx5C8EqgfsUP6yEBY9nJ7mDSAhKLsPqlI5BC6YFrz3sUIbBhI4HmMbPZZFF4Pc8dS8fZPIL6/fETdoG0vqTU1ceVjWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=X9imBKQN; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 218191BF20E;
	Tue, 13 Feb 2024 15:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707836692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VpcLvlmRCP8z4hAlqgEJxn9ClN29g/4O7Rm+VP+Hs9w=;
	b=X9imBKQNLAigr714rynkVDtm/WslD/djWOsUskD+lRqtUxrzGZKe9p9/mNeeBLTi8rpD0X
	E0jAYdmlU7BeEjcuD97j8QXxd3KXmr6LlTAlyqjci28mF2E3QGok6W/F9APvzD1J/iJB27
	sjQozGbaEr5blLZr5gW1hqUAL/vQKJhAt1xHC9ujmcuEaavpZtJm18oPwUloYaSVzWQ7ty
	WwPuD8h4b1xjQD2f3UazA2Z2Q4yrxO91UBKcFcY6hslFS0OCkLQ6wZNA2WpT/1AzSsddpV
	llHEmy/oDRBTUKWyDxwqfqo7EQPucvYwWVZEbBZ0T1fSg76gjRLUPXcI6vDFlQ==
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
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org
Subject: [PATCH net-next v7 12/13] net: ethtool: strset: Allow querying phy stats by index
Date: Tue, 13 Feb 2024 16:04:29 +0100
Message-ID: <20240213150431.1796171-13-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213150431.1796171-1-maxime.chevallier@bootlin.com>
References: <20240213150431.1796171-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

The ETH_SS_PHY_STATS command gets PHY statistics. Use the phydev pointer
from the ethnl request to allow query phy stats from each PHY on the
link.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V7: No changes
V6: Use dedicated policy
V5: Added Andrew's R-b
V4: No changes
V3: No changes
V2: New patch
 net/ethtool/strset.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/ethtool/strset.c b/net/ethtool/strset.c
index c678b484a079..edc826407564 100644
--- a/net/ethtool/strset.c
+++ b/net/ethtool/strset.c
@@ -126,7 +126,7 @@ struct strset_reply_data {
 
 const struct nla_policy ethnl_strset_get_policy[] = {
 	[ETHTOOL_A_STRSET_HEADER]	=
-		NLA_POLICY_NESTED(ethnl_header_policy),
+		NLA_POLICY_NESTED(ethnl_header_policy_phy),
 	[ETHTOOL_A_STRSET_STRINGSETS]	= { .type = NLA_NESTED },
 	[ETHTOOL_A_STRSET_COUNTS_ONLY]	= { .type = NLA_FLAG },
 };
@@ -233,17 +233,18 @@ static void strset_cleanup_data(struct ethnl_reply_data *reply_base)
 }
 
 static int strset_prepare_set(struct strset_info *info, struct net_device *dev,
-			      unsigned int id, bool counts_only)
+			      struct phy_device *phydev, unsigned int id,
+			      bool counts_only)
 {
 	const struct ethtool_phy_ops *phy_ops = ethtool_phy_ops;
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	void *strings;
 	int count, ret;
 
-	if (id == ETH_SS_PHY_STATS && dev->phydev &&
+	if (id == ETH_SS_PHY_STATS && phydev &&
 	    !ops->get_ethtool_phy_stats && phy_ops &&
 	    phy_ops->get_sset_count)
-		ret = phy_ops->get_sset_count(dev->phydev);
+		ret = phy_ops->get_sset_count(phydev);
 	else if (ops->get_sset_count && ops->get_strings)
 		ret = ops->get_sset_count(dev, id);
 	else
@@ -258,10 +259,10 @@ static int strset_prepare_set(struct strset_info *info, struct net_device *dev,
 		strings = kcalloc(count, ETH_GSTRING_LEN, GFP_KERNEL);
 		if (!strings)
 			return -ENOMEM;
-		if (id == ETH_SS_PHY_STATS && dev->phydev &&
+		if (id == ETH_SS_PHY_STATS && phydev &&
 		    !ops->get_ethtool_phy_stats && phy_ops &&
 		    phy_ops->get_strings)
-			phy_ops->get_strings(dev->phydev, strings);
+			phy_ops->get_strings(phydev, strings);
 		else
 			ops->get_strings(dev, id, strings);
 		info->strings = strings;
@@ -305,8 +306,8 @@ static int strset_prepare_data(const struct ethnl_req_info *req_base,
 		    !data->sets[i].per_dev)
 			continue;
 
-		ret = strset_prepare_set(&data->sets[i], dev, i,
-					 req_info->counts_only);
+		ret = strset_prepare_set(&data->sets[i], dev, req_base->phydev,
+					 i, req_info->counts_only);
 		if (ret < 0)
 			goto err_ops;
 	}
-- 
2.43.0


