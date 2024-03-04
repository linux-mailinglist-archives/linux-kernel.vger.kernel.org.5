Return-Path: <linux-kernel+bounces-90789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3985870511
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4C171C23401
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6645676C;
	Mon,  4 Mar 2024 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XF628UNf"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EAD5491B;
	Mon,  4 Mar 2024 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709565031; cv=none; b=mgE6eFzXVpGs40vhQSmdyRi8c7glrQmE03u8tIeDSDZpG92CQLWHRmalv1HeiHheIx+9gjtNGAx3wUWyRTKhXFi55GXGDkllcK0hs0ownN36LsaXothDSTDb6dZJfQLmJbbyk0ie9OmUa/js+MuKStYFng+cwqMXkoiYrAtpQXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709565031; c=relaxed/simple;
	bh=YOGyQUz8B9RI8LIdyBuQxqlffVGk5aIswPIGBWCAZ8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWMjz1uEqkbGJtRbohX19+0fVzj5twSwoFUzubwqTdtiujlgpaCPIG40JQcszEyCkT6IqGZ+2IqqQrum1HZ6j4RqFIwgjhVMpct9CvQaprlxiVvjf8pKyCCayGJZkQUGqAE1QXrUR4movmDS1MsxLjaLMp9vIjeu2lKQyHyuPlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XF628UNf; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A82521BF20C;
	Mon,  4 Mar 2024 15:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709565027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L/C3xUqQ0tXQjt3ntr9VJkY5S54Kx0JHgdC83Vx8JfM=;
	b=XF628UNfWHEfdCXOgV9bW+M+j4CFu+YlGp6zlH3E7ApeeTwr6/JpE0pS/uCH9j9yEgXCfh
	L21d8/OD4NhEpY0wLiiOydL54WRbZ2ZXItyJ4XUZuL6oFzGbpmkoNSWv7BTnW2ywfSddr/
	ctkqCPEgiLKWY5i9TG3mKu7bdyd40s02p/1sFzponRkc2815P/pejKkr32OH+yeeg65C9X
	JHlKYqPRh8/nlGG5l5YmJZY91R9eFn/F/fatp6gdl3KPWJUavncvcCglIQ/I4V0z7nZThF
	MxnNYC6F2veaN3AA9JrImGgSfXFE3xFe+9+TBYHbHMHMspWmvJikLIkvOccNiw==
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
Subject: [PATCH net-next v10 10/13] net: ethtool: pse-pd: Target the command to the requested PHY
Date: Mon,  4 Mar 2024 16:10:06 +0100
Message-ID: <20240304151011.1610175-11-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304151011.1610175-1-maxime.chevallier@bootlin.com>
References: <20240304151011.1610175-1-maxime.chevallier@bootlin.com>
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
V10: No changes
V9: No changes
V8: No changes
V7: No changes
V6: Use dedicated policy
V5: Added-back an incorrectly removed check
V4: No changes
V3: No changes
V2: New patch

 net/ethtool/pse-pd.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index cc478af77111..be50d79122c4 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -28,15 +28,13 @@ struct pse_reply_data {
 /* PSE_GET */
 
 const struct nla_policy ethnl_pse_get_policy[ETHTOOL_A_PSE_HEADER + 1] = {
-	[ETHTOOL_A_PSE_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy),
+	[ETHTOOL_A_PSE_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy_phy),
 };
 
-static int pse_get_pse_attributes(struct net_device *dev,
+static int pse_get_pse_attributes(struct phy_device *phydev,
 				  struct netlink_ext_ack *extack,
 				  struct pse_reply_data *data)
 {
-	struct phy_device *phydev = dev->phydev;
-
 	if (!phydev) {
 		NL_SET_ERR_MSG(extack, "No PHY is attached");
 		return -EOPNOTSUPP;
@@ -64,7 +62,7 @@ static int pse_prepare_data(const struct ethnl_req_info *req_base,
 	if (ret < 0)
 		return ret;
 
-	ret = pse_get_pse_attributes(dev, info->extack, data);
+	ret = pse_get_pse_attributes(req_base->phydev, info->extack, data);
 
 	ethnl_ops_complete(dev);
 
@@ -109,7 +107,7 @@ static int pse_fill_reply(struct sk_buff *skb,
 /* PSE_SET */
 
 const struct nla_policy ethnl_pse_set_policy[ETHTOOL_A_PSE_MAX + 1] = {
-	[ETHTOOL_A_PSE_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy),
+	[ETHTOOL_A_PSE_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy_phy),
 	[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL] =
 		NLA_POLICY_RANGE(NLA_U32, ETHTOOL_PODL_PSE_ADMIN_STATE_DISABLED,
 				 ETHTOOL_PODL_PSE_ADMIN_STATE_ENABLED),
@@ -124,7 +122,6 @@ ethnl_set_pse_validate(struct ethnl_req_info *req_info, struct genl_info *info)
 static int
 ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
 {
-	struct net_device *dev = req_info->dev;
 	struct pse_control_config config = {};
 	struct nlattr **tb = info->attrs;
 	struct phy_device *phydev;
@@ -132,7 +129,7 @@ ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
 	/* this values are already validated by the ethnl_pse_set_policy */
 	config.admin_cotrol = nla_get_u32(tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL]);
 
-	phydev = dev->phydev;
+	phydev = req_info->phydev;
 	if (!phydev) {
 		NL_SET_ERR_MSG(info->extack, "No PHY is attached");
 		return -EOPNOTSUPP;
-- 
2.44.0


