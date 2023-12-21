Return-Path: <linux-kernel+bounces-8897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C19581BDDA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 076B41F253DE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAD678E9F;
	Thu, 21 Dec 2023 18:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="P6xGgCOK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D213577F15;
	Thu, 21 Dec 2023 18:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3E95E1C0016;
	Thu, 21 Dec 2023 18:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703181667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/L19pZWpSlfJz7sFcUtDttLXAqUoAX7c8SoAYBK8OTY=;
	b=P6xGgCOKorZryCpY6TqXW4ee+fpKUS3ufxMako30VtrgsBSpMao5GVTiipfMuAqcrLOpOp
	cGnbWs+8Cmv6ED6C+T3amboYSJm+SFOmildQqMEAsEAIeZJB+E8wxKpYDXZCQ8CW4L62dx
	03+SDYBURFfmjf3FjQRp0BU8r1/0jD/q6KvcSD+lfFYXEITbMG/6WLQIvtE9EbfzElpohv
	YHg546L8k9t3ug/sCwP6E743YHUz9DLqag//ifXK8l+bbg0RTpXXLqGoVh11bEL3HK1iY9
	DWNlBwZEROul3C7X5IlvPzaTMaGZnvzYgdNh3Mw78Wc00SYBBj/uWSSoS7z5tQ==
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
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v5 12/13] net: ethtool: strset: Allow querying phy stats by index
Date: Thu, 21 Dec 2023 19:00:45 +0100
Message-ID: <20231221180047.1924733-13-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221180047.1924733-1-maxime.chevallier@bootlin.com>
References: <20231221180047.1924733-1-maxime.chevallier@bootlin.com>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
V5: Added Andrew's R-b
V4: No changes
V3: No changes
V2: New patch

 net/ethtool/strset.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/ethtool/strset.c b/net/ethtool/strset.c
index c678b484a079..70c00631c51f 100644
--- a/net/ethtool/strset.c
+++ b/net/ethtool/strset.c
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


