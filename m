Return-Path: <linux-kernel+bounces-73534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E538985C3D8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13BDA1C227C1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA7812FB38;
	Tue, 20 Feb 2024 18:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Lr1l7ik5"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C5A14D449;
	Tue, 20 Feb 2024 18:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708454558; cv=none; b=UrmpD/5XczOAHEtw6te5hxhxk2YLVUSLSByFPX2dme+uuwLywCrFKQXFJBK77Hd3SNsqJx3JyCV7Yolf33U+GJaqz7CBCMQ5M/nRKEsbymOp/TewD6rOM+VQ6+c6+8rngJoNV7+7iouKasa7Ve54hbq7rxs5luj6+3giK25cYFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708454558; c=relaxed/simple;
	bh=r/uVsV/6gheJ71ckBPTzJJCWYWCGXBT7FpJkIkxkIo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBIXjs8X14n9HGrPLEzet2CFoArxrwPVDzs1ku4A5PMXvCZ57EY92KxHz62FiTW47J01IAFw8JOEPaf195t2rRXZUxNdUolwmu1h9YjedfZRSNCOTEPwt/tSxDCoo49Nr7MruMp9KdVDKnh8NG9NTJDn2xWYZDrGgKhMVrKaJZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Lr1l7ik5; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5FA2660005;
	Tue, 20 Feb 2024 18:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708454554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S/5kHf9FQTDtK6maMI4eMWGwo27QbbMaxtC8PnKRi0M=;
	b=Lr1l7ik5MyZ1ztxB/ozLYCtsbJadcemikK0+Y4VTsqdIJPxgpwvTUGSaCWdFMoB9LEa/Qs
	Hx1CWaag1OuKgyCAfjfvFbN9zAkMGRlp9CaR3MCk8yPlpL227Hyzrw0IKtwKnlniYtUUtk
	Q7B/qo0N/8tCllfe+TEOzdULhKoD2ZsIQW4Y4MJ5agfa/FGdBdDjeXO/6lCWhD25brGZYI
	3DZtq5B8wfi2LyaILmotV1OxYDn2Oqb5GODGAIdytk5JcUZdoyvj35cL2Dhxyh3YQiwAdx
	rT31E+o/6R/rYuMp48evyDcviP8SO9tpcRGJDA9PVg8QuDNKxgyrTaBPW1FXDg==
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
Subject: [PATCH net-next v8 09/13] net: ethtool: plca: Target the command to the requested PHY
Date: Tue, 20 Feb 2024 19:42:12 +0100
Message-ID: <20240220184217.3689988-10-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220184217.3689988-1-maxime.chevallier@bootlin.com>
References: <20240220184217.3689988-1-maxime.chevallier@bootlin.com>
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
2.43.2


