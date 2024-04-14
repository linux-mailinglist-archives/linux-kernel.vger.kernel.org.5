Return-Path: <linux-kernel+bounces-144197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3648A42FF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DA9F1C20AC6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8578058AAC;
	Sun, 14 Apr 2024 14:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fStDFGOK"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EDF5C8FF;
	Sun, 14 Apr 2024 14:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713104599; cv=none; b=p9vPIYGvhmD5IVa1KS39TMXn6foWpQ37OJcy/F/J1eSYqrdDoVnI8J3Fqoyp3Wr5SjFm8zEOLnj7uQtIPhs1Ri7LV7qYy/xGhgT8ay80b8JDRcIXm8W29ZOVvFbiXteL5myje0JI5PCQsNCoqw/EfWHCtUSBzFctCxcm0oIgvqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713104599; c=relaxed/simple;
	bh=INCBmbHklrXaMQH4C45vA4yY84KIIBiVFvbNmAgmo/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lMJOO14DTSHDLAGOWME9yi9DhzXlrYf69ityEekzj50+pjVxS+a0fIudi6MfYvguE+DRAuuEZzoTS/2ChqRiWuQQw00ThVyxVyzlfic0vq/CLKKxHxMRLDSxKn++bwSVmg2TzRCbR5I54PC0TO7IPoTnDbwI47IfM2MrZiJrfNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fStDFGOK; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4F76BC0004;
	Sun, 14 Apr 2024 14:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713104595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EIpNiETCS+BMRG+DegU2BMgR65cCCgRIJRDcSbHd4gc=;
	b=fStDFGOKOe5iXgRdow8d/m/I8NhyemJZKODAsY+h7DG9sE3A662nOa0wNdZkBxgeNGKW/i
	rkZb+h5qTbzsctUjtYCGKiPRROmolIeD4ZNbojfbbmDVTOr0whQF0MCgL437E44WxxukTJ
	pqdnFn75bEQJ1c73qqngJ3REF6JoW9W329RbfrgySsYkQMqrOYaqgLhpKlsybcNXBLoCOE
	tjIagfKnuA6LF8TTq357l4gcOrdpYPG2V38jyWlmonQE8FWzqITHGMZGEQwS7nDrqClFzw
	zZyyQr40Untb9+5rkyRgRFIjFXcR5CrlDKPivOaHo4xTh5sMyL5yhNE9U7GvcQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Sun, 14 Apr 2024 16:21:55 +0200
Subject: [PATCH net-next v8 06/17] net: ethtool: pse-pd: Expand pse
 commands with the PSE PoE interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-feature_poe-v8-6-e4bf1e860da5@bootlin.com>
References: <20240414-feature_poe-v8-0-e4bf1e860da5@bootlin.com>
In-Reply-To: <20240414-feature_poe-v8-0-e4bf1e860da5@bootlin.com>
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
 kernel@pengutronix.de, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14-dev
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Add PSE PoE interface support in the ethtool pse command.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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
index 4e63d3708ed9..8bc71f249448 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1733,6 +1733,10 @@ Kernel response contents:
                                                   PSE functions
   ``ETHTOOL_A_PODL_PSE_PW_D_STATUS``         u32  power detection status of the
                                                   PoDL PSE.
+  ``ETHTOOL_A_C33_PSE_ADMIN_STATE``          u32  Operational state of the PoE
+                                                  PSE functions.
+  ``ETHTOOL_A_C33_PSE_PW_D_STATUS``          u32  power detection status of the
+                                                  PoE PSE.
   ======================================  ======  =============================
 
 When set, the optional ``ETHTOOL_A_PODL_PSE_ADMIN_STATE`` attribute identifies
@@ -1744,6 +1748,12 @@ aPoDLPSEAdminState. Possible values are:
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
@@ -1753,6 +1763,12 @@ Possible values are:
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
 
@@ -1763,6 +1779,7 @@ Request contents:
   ======================================  ======  =============================
   ``ETHTOOL_A_PSE_HEADER``                nested  request header
   ``ETHTOOL_A_PODL_PSE_ADMIN_CONTROL``       u32  Control PoDL PSE Admin state
+  ``ETHTOOL_A_C33_PSE_ADMIN_CONTROL``        u32  Control PSE Admin state
   ======================================  ======  =============================
 
 When set, the optional ``ETHTOOL_A_PODL_PSE_ADMIN_CONTROL`` attribute is used
@@ -1770,6 +1787,9 @@ to control PoDL PSE Admin functions. This option is implementing
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
2.34.1


