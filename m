Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C317EF57A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 16:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346120AbjKQPkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 10:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346037AbjKQPkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 10:40:32 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520B11725;
        Fri, 17 Nov 2023 07:40:26 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2AE2E1BF203;
        Fri, 17 Nov 2023 15:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700235625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kXxJ0TrHFImH7zE70wLic8+UDT+BnrrM17/SjpFD0yM=;
        b=RJEak+H91AMx4emFkYkt+nG0xDcSuVhmV6A8H2x0qfE8ZJ77GUqNjtryRlqjh2dCndJ8Wj
        f54fF0oC2g+3Pmtqhzydl9C71Zj8baX08xe87gdMZ+TFzHE0mKseUjBG5yMd4t8MEm3VI0
        O3IalIcklK7joaglnahP0XZElQzcz+fHVdGGol49YEhmVB+iBW29IG0D4CV0Y1qM1nX8yr
        3nvKMA7BqBM6YjLRrc80KdgpUrCOU1n/S0Jr5F7Rs+C8rvCYBusRNc+BKubAiNQTeorim5
        QG3iw2ILXrtvxyzi3A4z+KncNWNlj7N+Fa6bmEhUZ1Zpbkgejc3McxO1j5dmWw==
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
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
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [RFC PATCH net-next v2 08/10] net: ethtool: pse-pd: Target the command to the requested PHY
Date:   Fri, 17 Nov 2023 17:23:19 +0100
Message-ID: <20231117162323.626979-9-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231117162323.626979-1-maxime.chevallier@bootlin.com>
References: <20231117162323.626979-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PSE and PD configuration is a PHY-specific command. Instead of targeting
the command towards dev->phydev, use the request to pick the targeted
PHY device.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
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
2.41.0

