Return-Path: <linux-kernel+bounces-58112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CBB84E180
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09BAFB22256
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BD479923;
	Thu,  8 Feb 2024 13:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="igGp8YRh"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23F0763EB;
	Thu,  8 Feb 2024 13:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707397806; cv=none; b=PBHv4MsJd4JBps8E3AOI4oCiyNg85DxYwnQvFh2tqJOO0adt7AtVcS8Yq6Y5NPtGsNrkHQLe7WyQi/5Sv+4vkkd592+5pDpPmbchBp8cmJZG4lWryRTpPR2Of3aJj3/xeGHHIR856g65EC7ow2yXLokjKSSsh7AEZaXwvnRJCJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707397806; c=relaxed/simple;
	bh=fG1+rRL8+BJIg6y5sZCYlwJKJTX0E+HdGKq8hUkiGoM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=seK/W+z2gvpyqnM/LODmApSsqFUVGc5xUMsGHPfSfLWgm6MfXnUGCZgbbY6IjIvIqyk6DIYHXq5zPQq9ms+INtMl0ehlqKBREaOCtWKTufD7mKAvOePruThaF0aRh/mHu3J5Q4BK4AUN7dd937hVQTOodRvbwpcQU1aZmqVkvM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=igGp8YRh; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BE9591BF214;
	Thu,  8 Feb 2024 13:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707397799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sj0FJ03o9mRcFZ+qONOKhJu/7u+8g/O1HP3VPerOEaM=;
	b=igGp8YRh547KpF44pwCpQbFfdY9ytknExRTo3zf3vjyZ+MzCONiELae8rwH6rkPVKDKQWu
	q4yzKtG/CABJnabu0mRYmYpTg4pGUYAvSqCp4/AgYIWn8qEdjs429ZJBCnzV9pmAcrjRUm
	kiEXnnQcu7asCb8dhBwJNDQM8Vm0fyy1dMP2rlypx00Uk5BhbDn83NIPI4ddzjNI5K5RqV
	mCk6eQQ5MOQOQQhLa3Xm4Id8ihn2UcZWEveHQvrxjlHyZVxmtqInRbP3Vim5/NULtBkg5t
	ja0GaIn+PV6bYzN5PLsVl2nA4juEH5H0gUwWNSEuE8l4Tjj/doMqYl481rj1YA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 08 Feb 2024 14:08:43 +0100
Subject: [PATCH net-next v3 06/17] net: ethtool: pse-pd: Expand pse
 commands with the PSE PoE interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-feature_poe-v3-6-531d2674469e@bootlin.com>
References: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
In-Reply-To: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown <broonie@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com

Add PSE PoE interface support in the ethtool pse command.

Sponsored-by: Dent Project <dentproject@linuxfoundation.org>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v2:
- Follow the "c33" PoE prefix naming change.

Changes in v3:
- Replace the pse_get_types() helper by pse_has_podl() and pse_has_c33().
- Replace PoE to c33 in the netlink error log.
- Fix documentation build warning.
---
 Documentation/networking/ethtool-netlink.rst | 20 ++++++++++
 net/ethtool/pse-pd.c                         | 60 +++++++++++++++++++++++-----
 2 files changed, 70 insertions(+), 10 deletions(-)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index d583d9abf2f8..294187c3a3b0 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1717,6 +1717,10 @@ Kernel response contents:
                                                   PSE functions
   ``ETHTOOL_A_PODL_PSE_PW_D_STATUS``         u32  power detection status of the
                                                   PoDL PSE.
+  ``ETHTOOL_A_C33_PSE_ADMIN_STATE``          u32  Operational state of the PoE
+                                                  PSE functions.
+  ``ETHTOOL_A_C33_PSE_PW_D_STATUS``          u32  power detection status of the
+                                                  PoE PSE.
   ======================================  ======  =============================
 
 When set, the optional ``ETHTOOL_A_PODL_PSE_ADMIN_STATE`` attribute identifies
@@ -1728,6 +1732,12 @@ aPoDLPSEAdminState. Possible values are:
 .. kernel-doc:: include/uapi/linux/ethtool.h
     :identifiers: ethtool_podl_pse_admin_state
 
+The same goes for ``ETHTOOL_A_C33_PSE_ADMIN_STATE`` implementing
+``IEEE 802.3-2022`` 30.9.1.1.2 aPSEAdminState.
+
+.. kernel-doc:: include/uapi/linux/ethtool.h
+    :identifiers: ethtool_c33_pse_admin_state
+
 When set, the optional ``ETHTOOL_A_PODL_PSE_PW_D_STATUS`` attribute identifies
 the power detection status of the PoDL PSE.  The status depend on internal PSE
 state machine and automatic PD classification support. This option is
@@ -1737,6 +1747,12 @@ Possible values are:
 .. kernel-doc:: include/uapi/linux/ethtool.h
     :identifiers: ethtool_podl_pse_pw_d_status
 
+The same goes for ``ETHTOOL_A_C33_PSE_ADMIN_PW_D_STATUS`` implementing
+``IEEE 802.3-2022`` 30.9.1.1.5 aPSEPowerDetectionStatus.
+
+.. kernel-doc:: include/uapi/linux/ethtool.h
+    :identifiers: ethtool_c33_pse_pw_d_status
+
 PSE_SET
 =======
 
@@ -1747,6 +1763,7 @@ Request contents:
   ======================================  ======  =============================
   ``ETHTOOL_A_PSE_HEADER``                nested  request header
   ``ETHTOOL_A_PODL_PSE_ADMIN_CONTROL``       u32  Control PoDL PSE Admin state
+  ``ETHTOOL_A_C33_PSE_ADMIN_CONTROL``        u32  Control PSE Admin state
   ======================================  ======  =============================
 
 When set, the optional ``ETHTOOL_A_PODL_PSE_ADMIN_CONTROL`` attribute is used
@@ -1754,6 +1771,9 @@ to control PoDL PSE Admin functions. This option is implementing
 ``IEEE 802.3-2018`` 30.15.1.2.1 acPoDLPSEAdminControl. See
 ``ETHTOOL_A_PODL_PSE_ADMIN_STATE`` for supported values.
 
+The same goes for ``ETHTOOL_A_C33_PSE_ADMIN_CONTROL`` implementing
+``IEEE 802.3-2022`` 30.9.1.2.1 acPSEAdminControl.
+
 RSS_GET
 =======
 
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index aef57a058f0d..a3bfc3d9644e 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -82,6 +82,10 @@ static int pse_reply_size(const struct ethnl_req_info *req_base,
 		len += nla_total_size(sizeof(u32)); /* _PODL_PSE_ADMIN_STATE */
 	if (st->podl_pw_status > 0)
 		len += nla_total_size(sizeof(u32)); /* _PODL_PSE_PW_D_STATUS */
+	if (st->c33_admin_state > 0)
+		len += nla_total_size(sizeof(u32)); /* _C33_PSE_ADMIN_STATE */
+	if (st->c33_pw_status > 0)
+		len += nla_total_size(sizeof(u32)); /* _C33_PSE_PW_D_STATUS */
 
 	return len;
 }
@@ -103,6 +107,16 @@ static int pse_fill_reply(struct sk_buff *skb,
 			st->podl_pw_status))
 		return -EMSGSIZE;
 
+	if (st->c33_admin_state > 0 &&
+	    nla_put_u32(skb, ETHTOOL_A_C33_PSE_ADMIN_STATE,
+			st->c33_admin_state))
+		return -EMSGSIZE;
+
+	if (st->c33_pw_status > 0 &&
+	    nla_put_u32(skb, ETHTOOL_A_C33_PSE_PW_D_STATUS,
+			st->c33_pw_status))
+		return -EMSGSIZE;
+
 	return 0;
 }
 
@@ -113,25 +127,18 @@ const struct nla_policy ethnl_pse_set_policy[ETHTOOL_A_PSE_MAX + 1] = {
 	[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL] =
 		NLA_POLICY_RANGE(NLA_U32, ETHTOOL_PODL_PSE_ADMIN_STATE_DISABLED,
 				 ETHTOOL_PODL_PSE_ADMIN_STATE_ENABLED),
+	[ETHTOOL_A_C33_PSE_ADMIN_CONTROL] =
+		NLA_POLICY_RANGE(NLA_U32, ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED,
+				 ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED),
 };
 
 static int
 ethnl_set_pse_validate(struct ethnl_req_info *req_info, struct genl_info *info)
-{
-	return !!info->attrs[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL];
-}
-
-static int
-ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
 {
 	struct net_device *dev = req_info->dev;
-	struct pse_control_config config = {};
 	struct nlattr **tb = info->attrs;
 	struct phy_device *phydev;
 
-	/* this values are already validated by the ethnl_pse_set_policy */
-	config.podl_admin_control = nla_get_u32(tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL]);
-
 	phydev = dev->phydev;
 	if (!phydev) {
 		NL_SET_ERR_MSG(info->extack, "No PHY is attached");
@@ -143,6 +150,39 @@ ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
 		return -EOPNOTSUPP;
 	}
 
+	if (tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL] &&
+	    !(pse_has_podl(phydev->psec))) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL],
+				    "setting PoDL PSE admin control not supported");
+		return -EOPNOTSUPP;
+	}
+	if (tb[ETHTOOL_A_C33_PSE_ADMIN_CONTROL] &&
+	    !(pse_has_c33(phydev->psec))) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[ETHTOOL_A_C33_PSE_ADMIN_CONTROL],
+				    "setting C33 PSE admin control not supported");
+		return -EOPNOTSUPP;
+	}
+
+	return 1;
+}
+
+static int
+ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
+{
+	struct net_device *dev = req_info->dev;
+	struct pse_control_config config = {};
+	struct nlattr **tb = info->attrs;
+	struct phy_device *phydev;
+
+	phydev = dev->phydev;
+	/* These values are already validated by the ethnl_pse_set_policy */
+	if (pse_has_podl(phydev->psec))
+		config.podl_admin_control = nla_get_u32(tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL]);
+	if (pse_has_c33(phydev->psec))
+		config.c33_admin_control = nla_get_u32(tb[ETHTOOL_A_C33_PSE_ADMIN_CONTROL]);
+
 	/* Return errno directly - PSE has no notification */
 	return pse_ethtool_set_config(phydev->psec, info->extack, &config);
 }

-- 
2.25.1


