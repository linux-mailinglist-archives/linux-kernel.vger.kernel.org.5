Return-Path: <linux-kernel+bounces-131180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AC3898413
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D807B27265
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A2A8624C;
	Thu,  4 Apr 2024 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nzC3BRkh"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FFF84D1D;
	Thu,  4 Apr 2024 09:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712223024; cv=none; b=T9ew6apOxoiw0f6/egb5GXqdpTAfWQyEkS0kIyZHvAO8KTYuvKnxujGGAVQQt4RgJQAg+uqSOodzHbaFIBYm8188fXGcQAe8EiCE+IND1SEMEKH3cfalgg+/ORV0q8zczS7RQyzgIeRTH7yRUxWoqDoRz4zKGLv7Eal4QmNsaHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712223024; c=relaxed/simple;
	bh=hus9DxJrp5EshRdYNAbsrRxRWun3Lm80mCfKddvtjdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DiT3GLf8QaC7bKzDHxh8QmSrVixkwN8xbtws38sP62xpvdCyTfyB/aWt+SCY++H7CxxS3ifIqVqGrcsf1Vp3dZDajq0bkEk/vRAj7t9YMhVqxdgSdHw+kl2SyIcG1BUCsdI4lp1sYhGz1GpTroJunsgpOKxqB628euwl3Jnjf+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nzC3BRkh; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CD8F9C000F;
	Thu,  4 Apr 2024 09:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712223021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9in93RZRV/VN7pYGk149z3k+3JvW37l6lpuDeSPhxBo=;
	b=nzC3BRkhUpaDp1ADVOCOPsebpf36wknG4BbGo8Zt5ManmY9BywEuI2BG8K6760UPftCH53
	oIktPYAn8Ss7BYc9PHe78woNKpvgb1eIlpUqjOm79Vsu8mF6WyJ4yz+BNcSHAISQ7ldwdc
	KubNKQjbLGWfZUIJXk38IfLD12UtduR396PNMaiWy84gafotpQA2MoUpDR5WpUANz9wInK
	aDm54AiHoWAmt4kjd78PYa6toMuWqN0Vku6MzBdr4tCP6t0zsE9wBkmm+s2QWa3hL89APU
	WVwovVNA9GWh4r64X5/cVLfU9scKRBwsYWqJHvLEs7vVBp9JUxOvVHMid8luwA==
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
Subject: [PATCH net-next v11 09/13] net: ethtool: plca: Target the command to the requested PHY
Date: Thu,  4 Apr 2024 11:29:59 +0200
Message-ID: <20240404093004.2552221-10-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404093004.2552221-1-maxime.chevallier@bootlin.com>
References: <20240404093004.2552221-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

PLCA is a PHY-specific command. Instead of targeting the command
towards dev->phydev, use the request to pick the targeted PHY.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V11: No changes
V10: No changes
V9: No changes
V8: No changes
V7: No changes
V6: Use dedicated policy
V5: Added Andrew's R-b
V4: No changes
V3: No changes
V2: New patch

 net/ethtool/plca.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/net/ethtool/plca.c b/net/ethtool/plca.c
index b1e2e3b5027f..43b31a4a164e 100644
--- a/net/ethtool/plca.c
+++ b/net/ethtool/plca.c
@@ -25,7 +25,7 @@ struct plca_reply_data {
 
 const struct nla_policy ethnl_plca_get_cfg_policy[] = {
 	[ETHTOOL_A_PLCA_HEADER]		=
-		NLA_POLICY_NESTED(ethnl_header_policy),
+		NLA_POLICY_NESTED(ethnl_header_policy_phy),
 };
 
 static void plca_update_sint(int *dst, struct nlattr **tb, u32 attrid,
@@ -61,7 +61,7 @@ static int plca_get_cfg_prepare_data(const struct ethnl_req_info *req_base,
 	int ret;
 
 	// check that the PHY device is available and connected
-	if (!dev->phydev) {
+	if (!req_base->phydev) {
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
@@ -80,7 +80,7 @@ static int plca_get_cfg_prepare_data(const struct ethnl_req_info *req_base,
 	memset(&data->plca_cfg, 0xff,
 	       sizeof_field(struct plca_reply_data, plca_cfg));
 
-	ret = ops->get_plca_cfg(dev->phydev, &data->plca_cfg);
+	ret = ops->get_plca_cfg(req_base->phydev, &data->plca_cfg);
 	ethnl_ops_complete(dev);
 
 out:
@@ -129,7 +129,7 @@ static int plca_get_cfg_fill_reply(struct sk_buff *skb,
 
 const struct nla_policy ethnl_plca_set_cfg_policy[] = {
 	[ETHTOOL_A_PLCA_HEADER]		=
-		NLA_POLICY_NESTED(ethnl_header_policy),
+		NLA_POLICY_NESTED(ethnl_header_policy_phy),
 	[ETHTOOL_A_PLCA_ENABLED]	= NLA_POLICY_MAX(NLA_U8, 1),
 	[ETHTOOL_A_PLCA_NODE_ID]	= NLA_POLICY_MAX(NLA_U32, 255),
 	[ETHTOOL_A_PLCA_NODE_CNT]	= NLA_POLICY_RANGE(NLA_U32, 1, 255),
@@ -141,7 +141,6 @@ const struct nla_policy ethnl_plca_set_cfg_policy[] = {
 static int
 ethnl_set_plca(struct ethnl_req_info *req_info, struct genl_info *info)
 {
-	struct net_device *dev = req_info->dev;
 	const struct ethtool_phy_ops *ops;
 	struct nlattr **tb = info->attrs;
 	struct phy_plca_cfg plca_cfg;
@@ -149,7 +148,7 @@ ethnl_set_plca(struct ethnl_req_info *req_info, struct genl_info *info)
 	int ret;
 
 	// check that the PHY device is available and connected
-	if (!dev->phydev)
+	if (!req_info->phydev)
 		return -EOPNOTSUPP;
 
 	ops = ethtool_phy_ops;
@@ -168,7 +167,7 @@ ethnl_set_plca(struct ethnl_req_info *req_info, struct genl_info *info)
 	if (!mod)
 		return 0;
 
-	ret = ops->set_plca_cfg(dev->phydev, &plca_cfg, info->extack);
+	ret = ops->set_plca_cfg(req_info->phydev, &plca_cfg, info->extack);
 	return ret < 0 ? ret : 1;
 }
 
@@ -191,7 +190,7 @@ const struct ethnl_request_ops ethnl_plca_cfg_request_ops = {
 
 const struct nla_policy ethnl_plca_get_status_policy[] = {
 	[ETHTOOL_A_PLCA_HEADER]		=
-		NLA_POLICY_NESTED(ethnl_header_policy),
+		NLA_POLICY_NESTED(ethnl_header_policy_phy),
 };
 
 static int plca_get_status_prepare_data(const struct ethnl_req_info *req_base,
@@ -204,7 +203,7 @@ static int plca_get_status_prepare_data(const struct ethnl_req_info *req_base,
 	int ret;
 
 	// check that the PHY device is available and connected
-	if (!dev->phydev) {
+	if (!req_base->phydev) {
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
@@ -223,7 +222,7 @@ static int plca_get_status_prepare_data(const struct ethnl_req_info *req_base,
 	memset(&data->plca_st, 0xff,
 	       sizeof_field(struct plca_reply_data, plca_st));
 
-	ret = ops->get_plca_status(dev->phydev, &data->plca_st);
+	ret = ops->get_plca_status(req_base->phydev, &data->plca_st);
 	ethnl_ops_complete(dev);
 out:
 	return ret;
-- 
2.44.0


