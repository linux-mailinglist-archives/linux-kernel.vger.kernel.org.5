Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E11D7EE21E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345325AbjKPOCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345297AbjKPOCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:02:04 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBA6135;
        Thu, 16 Nov 2023 06:02:00 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1B4C920010;
        Thu, 16 Nov 2023 14:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700143318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=19uS5MsNCGK8Sqz35QAF1nCoCA1F75jO4Byem6JeTyY=;
        b=eHDWxrIkgnNyyN1JZp7UYJxdIs5vuMgx3Z8BMjtesuHwC/z6thjQ1zclugaSNPNc8J/QGu
        sI1k1znd81fezTFKKW1LL/x5RzC5M5/TGL6jKt3Spqr0XAYPnHu4llfH4SfpSmsISy+Pl5
        QGx2N5GgC9j3I6HaeKiiAUx54dSdrxeE4MeGZHKgDcs2crKicASQKOMcESIvVHcccstMvT
        I2escKDNjfdDLJM6IJANG0IF4pChRzEczUWrTP/1pP4mIEAn8DrqWmTDN9H1v+DRyQKwXQ
        2GqeM2tKW2abc6wNiisrzjnXKoD6WwzxnFPTbd3pCeJvbiK1Xgz/DExIUv1ZSw==
From:   Kory Maincent <kory.maincent@bootlin.com>
Date:   Thu, 16 Nov 2023 15:01:36 +0100
Subject: [PATCH net-next 4/9] net: ethtool: pse-pd: Expand pse commands
 with the PSE PoE interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231116-feature_poe-v1-4-be48044bf249@bootlin.com>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
In-Reply-To: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PSE PoE interface support in the ethtool pse command.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 Documentation/networking/ethtool-netlink.rst | 20 +++++++++
 net/ethtool/pse-pd.c                         | 64 +++++++++++++++++++++++-----
 2 files changed, 74 insertions(+), 10 deletions(-)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 2540c70952ff..a0b6437e1497 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1711,6 +1711,10 @@ Kernel response contents:
                                                   PSE functions
   ``ETHTOOL_A_PODL_PSE_PW_D_STATUS``         u32  power detection status of the
                                                   PoDL PSE.
+  ``ETHTOOL_A_PSE_ADMIN_STATE``              u32  Operational state of the PoE
+                                                  PSE functions.
+  ``ETHTOOL_A_PSE_PW_D_STATUS``              u32  power detection status of the
+                                                  PoE PSE.
   ======================================  ======  =============================
 
 When set, the optional ``ETHTOOL_A_PODL_PSE_ADMIN_STATE`` attribute identifies
@@ -1722,6 +1726,12 @@ aPoDLPSEAdminState. Possible values are:
 .. kernel-doc:: include/uapi/linux/ethtool.h
     :identifiers: ethtool_podl_pse_admin_state
 
+The same goes for ``ETHTOOL_A_PSE_ADMIN_STATE`` implementing
+``IEEE 802.3-2022`` 30.9.1.1.2 aPSEAdminState.
+
+.. kernel-doc:: include/uapi/linux/ethtool.h
+    :identifiers: ethtool_pse_admin_state
+
 When set, the optional ``ETHTOOL_A_PODL_PSE_PW_D_STATUS`` attribute identifies
 the power detection status of the PoDL PSE.  The status depend on internal PSE
 state machine and automatic PD classification support. This option is
@@ -1731,6 +1741,12 @@ Possible values are:
 .. kernel-doc:: include/uapi/linux/ethtool.h
     :identifiers: ethtool_podl_pse_pw_d_status
 
+The same goes for ``ETHTOOL_A_PSE_ADMIN_PW_D_STATUS`` implementing
+``IEEE 802.3-2022`` 30.9.1.1.5 aPSEPowerDetectionStatus.
+
+.. kernel-doc:: include/uapi/linux/ethtool.h
+    :identifiers: ethtool_pse_pw_d_status
+
 PSE_SET
 =======
 
@@ -1741,6 +1757,7 @@ Request contents:
   ======================================  ======  =============================
   ``ETHTOOL_A_PSE_HEADER``                nested  request header
   ``ETHTOOL_A_PODL_PSE_ADMIN_CONTROL``       u32  Control PoDL PSE Admin state
+  ``ETHTOOL_A_PSE_ADMIN_CONTROL``            u32  Control PSE Admin state
   ======================================  ======  =============================
 
 When set, the optional ``ETHTOOL_A_PODL_PSE_ADMIN_CONTROL`` attribute is used
@@ -1748,6 +1765,9 @@ to control PoDL PSE Admin functions. This option is implementing
 ``IEEE 802.3-2018`` 30.15.1.2.1 acPoDLPSEAdminControl. See
 ``ETHTOOL_A_PODL_PSE_ADMIN_STATE`` for supported values.
 
+The same goes for ``ETHTOOL_A_PSE_ADMIN_CONTROL`` implementing
+``IEEE 802.3-2022`` 30.9.1.2.1 acPSEAdminControl.
+
 RSS_GET
 =======
 
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index aef57a058f0d..88ab5e3576bc 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -82,6 +82,10 @@ static int pse_reply_size(const struct ethnl_req_info *req_base,
 		len += nla_total_size(sizeof(u32)); /* _PODL_PSE_ADMIN_STATE */
 	if (st->podl_pw_status > 0)
 		len += nla_total_size(sizeof(u32)); /* _PODL_PSE_PW_D_STATUS */
+	if (st->admin_state > 0)
+		len += nla_total_size(sizeof(u32)); /* _PSE_ADMIN_STATE */
+	if (st->pw_status > 0)
+		len += nla_total_size(sizeof(u32)); /* _PSE_PW_D_STATUS */
 
 	return len;
 }
@@ -103,6 +107,16 @@ static int pse_fill_reply(struct sk_buff *skb,
 			st->podl_pw_status))
 		return -EMSGSIZE;
 
+	if (st->admin_state > 0 &&
+	    nla_put_u32(skb, ETHTOOL_A_PSE_ADMIN_STATE,
+			st->admin_state))
+		return -EMSGSIZE;
+
+	if (st->pw_status > 0 &&
+	    nla_put_u32(skb, ETHTOOL_A_PSE_PW_D_STATUS,
+			st->pw_status))
+		return -EMSGSIZE;
+
 	return 0;
 }
 
@@ -113,25 +127,18 @@ const struct nla_policy ethnl_pse_set_policy[ETHTOOL_A_PSE_MAX + 1] = {
 	[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL] =
 		NLA_POLICY_RANGE(NLA_U32, ETHTOOL_PODL_PSE_ADMIN_STATE_DISABLED,
 				 ETHTOOL_PODL_PSE_ADMIN_STATE_ENABLED),
+	[ETHTOOL_A_PSE_ADMIN_CONTROL] =
+		NLA_POLICY_RANGE(NLA_U32, ETHTOOL_PSE_ADMIN_STATE_DISABLED,
+				 ETHTOOL_PSE_ADMIN_STATE_ENABLED),
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
@@ -143,6 +150,43 @@ ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
 		return -EOPNOTSUPP;
 	}
 
+	if (!tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL] &&
+	    !tb[ETHTOOL_A_PSE_ADMIN_CONTROL])
+		return 0;
+
+	if (tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL] &&
+	    !(pse_get_types(phydev->psec) & PSE_PODL)) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL],
+				    "setting PSE PoDL admin control not supported");
+		return -EOPNOTSUPP;
+	}
+	if (tb[ETHTOOL_A_PSE_ADMIN_CONTROL] &&
+	    !(pse_get_types(phydev->psec) & PSE_POE)) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[ETHTOOL_A_PSE_ADMIN_CONTROL],
+				    "setting PSE admin control not supported");
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
+	if (pse_get_types(phydev->psec) & PSE_PODL)
+		config.podl_admin_control = nla_get_u32(tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL]);
+	if (pse_get_types(phydev->psec) & PSE_POE)
+		config.admin_control = nla_get_u32(tb[ETHTOOL_A_PSE_ADMIN_CONTROL]);
+
 	/* Return errno directly - PSE has no notification */
 	return pse_ethtool_set_config(phydev->psec, info->extack, &config);
 }

-- 
2.25.1

