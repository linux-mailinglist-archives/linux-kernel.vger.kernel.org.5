Return-Path: <linux-kernel+bounces-1402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF45A814E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F2CD283F5C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8217EFCC;
	Fri, 15 Dec 2023 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Hj8cTg8F"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442AD5F854;
	Fri, 15 Dec 2023 17:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 78F1BC0003;
	Fri, 15 Dec 2023 17:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702660374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4gmaLaOCrQ9K49CYdnYsU/QMfrtPAaYJooY5eXRUFpg=;
	b=Hj8cTg8FLIF3xrJaSs5mYKSSXfTCzB+Wr4q7ktrmg3VCgqYssmb7JROEm+KWU3eftMfNEF
	WwLPN0RQ6Lhf+3DvnH+s6Kildm3DQNfw6ymOWGDv/Ce+1lXcyV6raE7w8iswZcm73thRrN
	JJsKOo6DWf/ZE2zVsc/vazlGVsNixtI2vyNHUEUIlOX+Ep5I2CvDe3LL0vTmxERb46ViqP
	iesK+6qXguUFUHOAqN5CSl3rXc9Zbuv2dzLRurRvWlMWKDhAJpZnRDj1Gq5ZlCIaUBBrKO
	vse6BZAUV3wuULC8wA6dfdNNOQibiQOemmYVAWpTabvyT0oFntyqccBE4lFfYQ==
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
Subject: [PATCH net-next v4 10/13] net: ethtool: pse-pd: Target the command to the requested PHY
Date: Fri, 15 Dec 2023 18:12:32 +0100
Message-ID: <20231215171237.1152563-11-maxime.chevallier@bootlin.com>
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

PSE and PD configuration is a PHY-specific command. Instead of targeting
the command towards dev->phydev, use the request to pick the targeted
PHY device.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V4: No changes
V3: No changes
V2: New patch

 net/ethtool/pse-pd.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index cc478af77111..0d9cd9c87104 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -31,17 +31,10 @@ const struct nla_policy ethnl_pse_get_policy[ETHTOOL_A_PSE_HEADER + 1] = {
 	[ETHTOOL_A_PSE_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy),
 };
 
-static int pse_get_pse_attributes(struct net_device *dev,
+static int pse_get_pse_attributes(struct phy_device *phydev,
 				  struct netlink_ext_ack *extack,
 				  struct pse_reply_data *data)
 {
-	struct phy_device *phydev = dev->phydev;
-
-	if (!phydev) {
-		NL_SET_ERR_MSG(extack, "No PHY is attached");
-		return -EOPNOTSUPP;
-	}
-
 	if (!phydev->psec) {
 		NL_SET_ERR_MSG(extack, "No PSE is attached");
 		return -EOPNOTSUPP;
@@ -64,7 +57,7 @@ static int pse_prepare_data(const struct ethnl_req_info *req_base,
 	if (ret < 0)
 		return ret;
 
-	ret = pse_get_pse_attributes(dev, info->extack, data);
+	ret = pse_get_pse_attributes(req_base->phydev, info->extack, data);
 
 	ethnl_ops_complete(dev);
 
@@ -124,7 +117,6 @@ ethnl_set_pse_validate(struct ethnl_req_info *req_info, struct genl_info *info)
 static int
 ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
 {
-	struct net_device *dev = req_info->dev;
 	struct pse_control_config config = {};
 	struct nlattr **tb = info->attrs;
 	struct phy_device *phydev;
@@ -132,7 +124,7 @@ ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
 	/* this values are already validated by the ethnl_pse_set_policy */
 	config.admin_cotrol = nla_get_u32(tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL]);
 
-	phydev = dev->phydev;
+	phydev = req_info->phydev;
 	if (!phydev) {
 		NL_SET_ERR_MSG(info->extack, "No PHY is attached");
 		return -EOPNOTSUPP;
-- 
2.43.0


