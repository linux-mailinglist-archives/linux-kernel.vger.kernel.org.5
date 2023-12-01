Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85168801143
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378507AbjLAQhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjLAQh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:37:26 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E96A6;
        Fri,  1 Dec 2023 08:37:17 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7160FC0003;
        Fri,  1 Dec 2023 16:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701448636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TpQ2Lq1/07PThiXwqtF6vKr0dTACC1pOrJXucEn5IXw=;
        b=i1x2casJcKzjprF16OADCP4Tl7KvUnOGNz3Gbunzulg0Vxcr1z48gFP1HyYjH0zTk7ZkCT
        EQ3cFQUipC9DAMIc5Twt7ApUTRUy40KMw5phY4m8SAVgVB89EzjL8RT9wPL85C76cgw7XZ
        +L5idGNx3bJBGheiAPO12Lu0AaNHwLB9wKR1fIjrCzX5CIiyGcFzwFIW7EYJ45shK6KsZQ
        HbufO1XG9zlhc8vUyvaHq9+QpSy3NJqD9n5/oilFhqar9/6A5bG7ArI8hMbFMYuUqrqN7F
        CqOnQ25XJfywEv+a4gDiy133DgcTfln7cfQtAe9nwO+hT4baY1yKh2R9T7PWfg==
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
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        =?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>
Subject: [RFC PATCH net-next v3 06/13] netlink: specs: add phy-index as a header parameter
Date:   Fri,  1 Dec 2023 17:36:56 +0100
Message-ID: <20231201163704.1306431-7-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201163704.1306431-1-maxime.chevallier@bootlin.com>
References: <20231201163704.1306431-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the spec to take the newly introduced phy-index as a generic
request parameter, and bump the generated ethtool-user.c|h accordingly.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V3: New patch

 Documentation/netlink/specs/ethtool.yaml |   3 +
 tools/net/ynl/generated/ethtool-user.c   |   8 +
 tools/net/ynl/generated/ethtool-user.h   | 530 +++++++++++++++++++++++
 3 files changed, 541 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 5c7a65b009b4..4e0790648913 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -30,6 +30,9 @@ attribute-sets:
       -
         name: flags
         type: u32
+      -
+        name: phy-index
+        type: u32
 
   -
     name: bitset-bit
diff --git a/tools/net/ynl/generated/ethtool-user.c b/tools/net/ynl/generated/ethtool-user.c
index 74b883a14958..295661eb3a3e 100644
--- a/tools/net/ynl/generated/ethtool-user.c
+++ b/tools/net/ynl/generated/ethtool-user.c
@@ -96,6 +96,7 @@ struct ynl_policy_attr ethtool_header_policy[ETHTOOL_A_HEADER_MAX + 1] = {
 	[ETHTOOL_A_HEADER_DEV_INDEX] = { .name = "dev-index", .type = YNL_PT_U32, },
 	[ETHTOOL_A_HEADER_DEV_NAME] = { .name = "dev-name", .type = YNL_PT_NUL_STR, },
 	[ETHTOOL_A_HEADER_FLAGS] = { .name = "flags", .type = YNL_PT_U32, },
+	[ETHTOOL_A_HEADER_PHY_INDEX] = { .name = "phy-index", .type = YNL_PT_U32, },
 };
 
 struct ynl_policy_nest ethtool_header_nest = {
@@ -684,6 +685,8 @@ int ethtool_header_put(struct nlmsghdr *nlh, unsigned int attr_type,
 		mnl_attr_put_strz(nlh, ETHTOOL_A_HEADER_DEV_NAME, obj->dev_name);
 	if (obj->_present.flags)
 		mnl_attr_put_u32(nlh, ETHTOOL_A_HEADER_FLAGS, obj->flags);
+	if (obj->_present.phy_index)
+		mnl_attr_put_u32(nlh, ETHTOOL_A_HEADER_PHY_INDEX, obj->phy_index);
 	mnl_attr_nest_end(nlh, nest);
 
 	return 0;
@@ -719,6 +722,11 @@ int ethtool_header_parse(struct ynl_parse_arg *yarg,
 				return MNL_CB_ERROR;
 			dst->_present.flags = 1;
 			dst->flags = mnl_attr_get_u32(attr);
+		} else if (type == ETHTOOL_A_HEADER_PHY_INDEX) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.phy_index = 1;
+			dst->phy_index = mnl_attr_get_u32(attr);
 		}
 	}
 
diff --git a/tools/net/ynl/generated/ethtool-user.h b/tools/net/ynl/generated/ethtool-user.h
index ca0ec5fd7798..97c079c0f332 100644
--- a/tools/net/ynl/generated/ethtool-user.h
+++ b/tools/net/ynl/generated/ethtool-user.h
@@ -27,11 +27,13 @@ struct ethtool_header {
 		__u32 dev_index:1;
 		__u32 dev_name_len;
 		__u32 flags:1;
+		__u32 phy_index:1;
 	} _present;
 
 	__u32 dev_index;
 	char *dev_name;
 	__u32 flags;
+	__u32 phy_index;
 };
 
 struct ethtool_pause_stat {
@@ -253,6 +255,14 @@ ethtool_strset_get_req_set_header_flags(struct ethtool_strset_get_req *req,
 	req->header.flags = flags;
 }
 static inline void
+ethtool_strset_get_req_set_header_phy_index(struct ethtool_strset_get_req *req,
+					    __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
+static inline void
 __ethtool_strset_get_req_set_stringsets_stringset(struct ethtool_strset_get_req *req,
 						  struct ethtool_stringset_ *stringset,
 						  unsigned int n_stringset)
@@ -331,6 +341,14 @@ ethtool_strset_get_req_dump_set_header_flags(struct ethtool_strset_get_req_dump
 	req->header.flags = flags;
 }
 static inline void
+ethtool_strset_get_req_dump_set_header_phy_index(struct ethtool_strset_get_req_dump *req,
+						 __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
+static inline void
 __ethtool_strset_get_req_dump_set_stringsets_stringset(struct ethtool_strset_get_req_dump *req,
 						       struct ethtool_stringset_ *stringset,
 						       unsigned int n_stringset)
@@ -399,6 +417,14 @@ ethtool_linkinfo_get_req_set_header_flags(struct ethtool_linkinfo_get_req *req,
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_linkinfo_get_req_set_header_phy_index(struct ethtool_linkinfo_get_req *req,
+					      __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_linkinfo_get_rsp {
 	struct {
@@ -469,6 +495,14 @@ ethtool_linkinfo_get_req_dump_set_header_flags(struct ethtool_linkinfo_get_req_d
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_linkinfo_get_req_dump_set_header_phy_index(struct ethtool_linkinfo_get_req_dump *req,
+						   __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_linkinfo_get_list {
 	struct ethtool_linkinfo_get_list *next;
@@ -546,6 +580,14 @@ ethtool_linkinfo_set_req_set_header_flags(struct ethtool_linkinfo_set_req *req,
 	req->header.flags = flags;
 }
 static inline void
+ethtool_linkinfo_set_req_set_header_phy_index(struct ethtool_linkinfo_set_req *req,
+					      __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
+static inline void
 ethtool_linkinfo_set_req_set_port(struct ethtool_linkinfo_set_req *req,
 				  __u8 port)
 {
@@ -630,6 +672,14 @@ ethtool_linkmodes_get_req_set_header_flags(struct ethtool_linkmodes_get_req *req
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_linkmodes_get_req_set_header_phy_index(struct ethtool_linkmodes_get_req *req,
+					       __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_linkmodes_get_rsp {
 	struct {
@@ -709,6 +759,14 @@ ethtool_linkmodes_get_req_dump_set_header_flags(struct ethtool_linkmodes_get_req
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_linkmodes_get_req_dump_set_header_phy_index(struct ethtool_linkmodes_get_req_dump *req,
+						    __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_linkmodes_get_list {
 	struct ethtool_linkmodes_get_list *next;
@@ -794,6 +852,14 @@ ethtool_linkmodes_set_req_set_header_flags(struct ethtool_linkmodes_set_req *req
 	req->header.flags = flags;
 }
 static inline void
+ethtool_linkmodes_set_req_set_header_phy_index(struct ethtool_linkmodes_set_req *req,
+					       __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
+static inline void
 ethtool_linkmodes_set_req_set_autoneg(struct ethtool_linkmodes_set_req *req,
 				      __u8 autoneg)
 {
@@ -938,6 +1004,14 @@ ethtool_linkstate_get_req_set_header_flags(struct ethtool_linkstate_get_req *req
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_linkstate_get_req_set_header_phy_index(struct ethtool_linkstate_get_req *req,
+					       __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_linkstate_get_rsp {
 	struct {
@@ -1011,6 +1085,14 @@ ethtool_linkstate_get_req_dump_set_header_flags(struct ethtool_linkstate_get_req
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_linkstate_get_req_dump_set_header_phy_index(struct ethtool_linkstate_get_req_dump *req,
+						    __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_linkstate_get_list {
 	struct ethtool_linkstate_get_list *next;
@@ -1065,6 +1147,14 @@ ethtool_debug_get_req_set_header_flags(struct ethtool_debug_get_req *req,
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_debug_get_req_set_header_phy_index(struct ethtool_debug_get_req *req,
+					   __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_debug_get_rsp {
 	struct {
@@ -1126,6 +1216,14 @@ ethtool_debug_get_req_dump_set_header_flags(struct ethtool_debug_get_req_dump *r
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_debug_get_req_dump_set_header_phy_index(struct ethtool_debug_get_req_dump *req,
+						__u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_debug_get_list {
 	struct ethtool_debug_get_list *next;
@@ -1194,6 +1292,14 @@ ethtool_debug_set_req_set_header_flags(struct ethtool_debug_set_req *req,
 	req->header.flags = flags;
 }
 static inline void
+ethtool_debug_set_req_set_header_phy_index(struct ethtool_debug_set_req *req,
+					   __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
+static inline void
 ethtool_debug_set_req_set_msgmask_nomask(struct ethtool_debug_set_req *req)
 {
 	req->_present.msgmask = 1;
@@ -1264,6 +1370,14 @@ ethtool_wol_get_req_set_header_flags(struct ethtool_wol_get_req *req,
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_wol_get_req_set_header_phy_index(struct ethtool_wol_get_req *req,
+					 __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_wol_get_rsp {
 	struct {
@@ -1327,6 +1441,14 @@ ethtool_wol_get_req_dump_set_header_flags(struct ethtool_wol_get_req_dump *req,
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_wol_get_req_dump_set_header_phy_index(struct ethtool_wol_get_req_dump *req,
+					      __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_wol_get_list {
 	struct ethtool_wol_get_list *next;
@@ -1396,6 +1518,14 @@ ethtool_wol_set_req_set_header_flags(struct ethtool_wol_set_req *req,
 	req->header.flags = flags;
 }
 static inline void
+ethtool_wol_set_req_set_header_phy_index(struct ethtool_wol_set_req *req,
+					 __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
+static inline void
 ethtool_wol_set_req_set_modes_nomask(struct ethtool_wol_set_req *req)
 {
 	req->_present.modes = 1;
@@ -1475,6 +1605,14 @@ ethtool_features_get_req_set_header_flags(struct ethtool_features_get_req *req,
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_features_get_req_set_header_phy_index(struct ethtool_features_get_req *req,
+					      __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_features_get_rsp {
 	struct {
@@ -1543,6 +1681,14 @@ ethtool_features_get_req_dump_set_header_flags(struct ethtool_features_get_req_d
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_features_get_req_dump_set_header_phy_index(struct ethtool_features_get_req_dump *req,
+						   __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_features_get_list {
 	struct ethtool_features_get_list *next;
@@ -1618,6 +1764,14 @@ ethtool_features_set_req_set_header_flags(struct ethtool_features_set_req *req,
 	req->header.flags = flags;
 }
 static inline void
+ethtool_features_set_req_set_header_phy_index(struct ethtool_features_set_req *req,
+					      __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
+static inline void
 ethtool_features_set_req_set_hw_nomask(struct ethtool_features_set_req *req)
 {
 	req->_present.hw = 1;
@@ -1777,6 +1931,14 @@ ethtool_privflags_get_req_set_header_flags(struct ethtool_privflags_get_req *req
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_privflags_get_req_set_header_phy_index(struct ethtool_privflags_get_req *req,
+					       __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_privflags_get_rsp {
 	struct {
@@ -1840,6 +2002,14 @@ ethtool_privflags_get_req_dump_set_header_flags(struct ethtool_privflags_get_req
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_privflags_get_req_dump_set_header_phy_index(struct ethtool_privflags_get_req_dump *req,
+						    __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_privflags_get_list {
 	struct ethtool_privflags_get_list *next;
@@ -1909,6 +2079,14 @@ ethtool_privflags_set_req_set_header_flags(struct ethtool_privflags_set_req *req
 	req->header.flags = flags;
 }
 static inline void
+ethtool_privflags_set_req_set_header_phy_index(struct ethtool_privflags_set_req *req,
+					       __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
+static inline void
 ethtool_privflags_set_req_set_flags_nomask(struct ethtool_privflags_set_req *req)
 {
 	req->_present.flags = 1;
@@ -1980,6 +2158,14 @@ ethtool_rings_get_req_set_header_flags(struct ethtool_rings_get_req *req,
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_rings_get_req_set_header_phy_index(struct ethtool_rings_get_req *req,
+					   __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_rings_get_rsp {
 	struct {
@@ -2069,6 +2255,14 @@ ethtool_rings_get_req_dump_set_header_flags(struct ethtool_rings_get_req_dump *r
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_rings_get_req_dump_set_header_phy_index(struct ethtool_rings_get_req_dump *req,
+						__u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_rings_get_list {
 	struct ethtool_rings_get_list *next;
@@ -2165,6 +2359,14 @@ ethtool_rings_set_req_set_header_flags(struct ethtool_rings_set_req *req,
 	req->header.flags = flags;
 }
 static inline void
+ethtool_rings_set_req_set_header_phy_index(struct ethtool_rings_set_req *req,
+					   __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
+static inline void
 ethtool_rings_set_req_set_rx_max(struct ethtool_rings_set_req *req,
 				 __u32 rx_max)
 {
@@ -2316,6 +2518,14 @@ ethtool_channels_get_req_set_header_flags(struct ethtool_channels_get_req *req,
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_channels_get_req_set_header_phy_index(struct ethtool_channels_get_req *req,
+					      __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_channels_get_rsp {
 	struct {
@@ -2392,6 +2602,14 @@ ethtool_channels_get_req_dump_set_header_flags(struct ethtool_channels_get_req_d
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_channels_get_req_dump_set_header_phy_index(struct ethtool_channels_get_req_dump *req,
+						   __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_channels_get_list {
 	struct ethtool_channels_get_list *next;
@@ -2475,6 +2693,14 @@ ethtool_channels_set_req_set_header_flags(struct ethtool_channels_set_req *req,
 	req->header.flags = flags;
 }
 static inline void
+ethtool_channels_set_req_set_header_phy_index(struct ethtool_channels_set_req *req,
+					      __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
+static inline void
 ethtool_channels_set_req_set_rx_max(struct ethtool_channels_set_req *req,
 				    __u32 rx_max)
 {
@@ -2580,6 +2806,14 @@ ethtool_coalesce_get_req_set_header_flags(struct ethtool_coalesce_get_req *req,
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_coalesce_get_req_set_header_phy_index(struct ethtool_coalesce_get_req *req,
+					      __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_coalesce_get_rsp {
 	struct {
@@ -2694,6 +2928,14 @@ ethtool_coalesce_get_req_dump_set_header_flags(struct ethtool_coalesce_get_req_d
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_coalesce_get_req_dump_set_header_phy_index(struct ethtool_coalesce_get_req_dump *req,
+						   __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_coalesce_get_list {
 	struct ethtool_coalesce_get_list *next;
@@ -2815,6 +3057,14 @@ ethtool_coalesce_set_req_set_header_flags(struct ethtool_coalesce_set_req *req,
 	req->header.flags = flags;
 }
 static inline void
+ethtool_coalesce_set_req_set_header_phy_index(struct ethtool_coalesce_set_req *req,
+					      __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
+static inline void
 ethtool_coalesce_set_req_set_rx_usecs(struct ethtool_coalesce_set_req *req,
 				      __u32 rx_usecs)
 {
@@ -3052,6 +3302,14 @@ ethtool_pause_get_req_set_header_flags(struct ethtool_pause_get_req *req,
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_pause_get_req_set_header_phy_index(struct ethtool_pause_get_req *req,
+					   __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_pause_get_rsp {
 	struct {
@@ -3121,6 +3379,14 @@ ethtool_pause_get_req_dump_set_header_flags(struct ethtool_pause_get_req_dump *r
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_pause_get_req_dump_set_header_phy_index(struct ethtool_pause_get_req_dump *req,
+						__u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_pause_get_list {
 	struct ethtool_pause_get_list *next;
@@ -3197,6 +3463,14 @@ ethtool_pause_set_req_set_header_flags(struct ethtool_pause_set_req *req,
 	req->header.flags = flags;
 }
 static inline void
+ethtool_pause_set_req_set_header_phy_index(struct ethtool_pause_set_req *req,
+					   __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
+static inline void
 ethtool_pause_set_req_set_autoneg(struct ethtool_pause_set_req *req,
 				  __u8 autoneg)
 {
@@ -3286,6 +3560,14 @@ ethtool_eee_get_req_set_header_flags(struct ethtool_eee_get_req *req,
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_eee_get_req_set_header_phy_index(struct ethtool_eee_get_req *req,
+					 __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_eee_get_rsp {
 	struct {
@@ -3357,6 +3639,14 @@ ethtool_eee_get_req_dump_set_header_flags(struct ethtool_eee_get_req_dump *req,
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_eee_get_req_dump_set_header_phy_index(struct ethtool_eee_get_req_dump *req,
+					      __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_eee_get_list {
 	struct ethtool_eee_get_list *next;
@@ -3434,6 +3724,14 @@ ethtool_eee_set_req_set_header_flags(struct ethtool_eee_set_req *req,
 	req->header.flags = flags;
 }
 static inline void
+ethtool_eee_set_req_set_header_phy_index(struct ethtool_eee_set_req *req,
+					 __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
+static inline void
 ethtool_eee_set_req_set_modes_ours_nomask(struct ethtool_eee_set_req *req)
 {
 	req->_present.modes_ours = 1;
@@ -3553,6 +3851,14 @@ ethtool_tsinfo_get_req_set_header_flags(struct ethtool_tsinfo_get_req *req,
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_tsinfo_get_req_set_header_phy_index(struct ethtool_tsinfo_get_req *req,
+					    __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_tsinfo_get_rsp {
 	struct {
@@ -3620,6 +3926,14 @@ ethtool_tsinfo_get_req_dump_set_header_flags(struct ethtool_tsinfo_get_req_dump
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_tsinfo_get_req_dump_set_header_phy_index(struct ethtool_tsinfo_get_req_dump *req,
+						 __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_tsinfo_get_list {
 	struct ethtool_tsinfo_get_list *next;
@@ -3675,6 +3989,14 @@ ethtool_cable_test_act_req_set_header_flags(struct ethtool_cable_test_act_req *r
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_cable_test_act_req_set_header_phy_index(struct ethtool_cable_test_act_req *req,
+						__u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 /*
  * Cable test.
@@ -3726,6 +4048,14 @@ ethtool_cable_test_tdr_act_req_set_header_flags(struct ethtool_cable_test_tdr_ac
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_cable_test_tdr_act_req_set_header_phy_index(struct ethtool_cable_test_tdr_act_req *req,
+						    __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 /*
  * Cable test TDR.
@@ -3776,6 +4106,14 @@ ethtool_tunnel_info_get_req_set_header_flags(struct ethtool_tunnel_info_get_req
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_tunnel_info_get_req_set_header_phy_index(struct ethtool_tunnel_info_get_req *req,
+						 __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_tunnel_info_get_rsp {
 	struct {
@@ -3839,6 +4177,14 @@ ethtool_tunnel_info_get_req_dump_set_header_flags(struct ethtool_tunnel_info_get
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_tunnel_info_get_req_dump_set_header_phy_index(struct ethtool_tunnel_info_get_req_dump *req,
+						      __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_tunnel_info_get_list {
 	struct ethtool_tunnel_info_get_list *next;
@@ -3894,6 +4240,14 @@ ethtool_fec_get_req_set_header_flags(struct ethtool_fec_get_req *req,
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_fec_get_req_set_header_phy_index(struct ethtool_fec_get_req *req,
+					 __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_fec_get_rsp {
 	struct {
@@ -3961,6 +4315,14 @@ ethtool_fec_get_req_dump_set_header_flags(struct ethtool_fec_get_req_dump *req,
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_fec_get_req_dump_set_header_phy_index(struct ethtool_fec_get_req_dump *req,
+					      __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_fec_get_list {
 	struct ethtool_fec_get_list *next;
@@ -4034,6 +4396,14 @@ ethtool_fec_set_req_set_header_flags(struct ethtool_fec_set_req *req,
 	req->header.flags = flags;
 }
 static inline void
+ethtool_fec_set_req_set_header_phy_index(struct ethtool_fec_set_req *req,
+					 __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
+static inline void
 ethtool_fec_set_req_set_modes_nomask(struct ethtool_fec_set_req *req)
 {
 	req->_present.modes = 1;
@@ -4144,6 +4514,14 @@ ethtool_module_eeprom_get_req_set_header_flags(struct ethtool_module_eeprom_get_
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_module_eeprom_get_req_set_header_phy_index(struct ethtool_module_eeprom_get_req *req,
+						   __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_module_eeprom_get_rsp {
 	struct {
@@ -4218,6 +4596,14 @@ ethtool_module_eeprom_get_req_dump_set_header_flags(struct ethtool_module_eeprom
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_module_eeprom_get_req_dump_set_header_phy_index(struct ethtool_module_eeprom_get_req_dump *req,
+							__u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_module_eeprom_get_list {
 	struct ethtool_module_eeprom_get_list *next;
@@ -4274,6 +4660,14 @@ ethtool_phc_vclocks_get_req_set_header_flags(struct ethtool_phc_vclocks_get_req
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_phc_vclocks_get_req_set_header_phy_index(struct ethtool_phc_vclocks_get_req *req,
+						 __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_phc_vclocks_get_rsp {
 	struct {
@@ -4337,6 +4731,14 @@ ethtool_phc_vclocks_get_req_dump_set_header_flags(struct ethtool_phc_vclocks_get
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_phc_vclocks_get_req_dump_set_header_phy_index(struct ethtool_phc_vclocks_get_req_dump *req,
+						      __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_phc_vclocks_get_list {
 	struct ethtool_phc_vclocks_get_list *next;
@@ -4392,6 +4794,14 @@ ethtool_module_get_req_set_header_flags(struct ethtool_module_get_req *req,
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_module_get_req_set_header_phy_index(struct ethtool_module_get_req *req,
+					    __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_module_get_rsp {
 	struct {
@@ -4455,6 +4865,14 @@ ethtool_module_get_req_dump_set_header_flags(struct ethtool_module_get_req_dump
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_module_get_req_dump_set_header_phy_index(struct ethtool_module_get_req_dump *req,
+						 __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_module_get_list {
 	struct ethtool_module_get_list *next;
@@ -4525,6 +4943,14 @@ ethtool_module_set_req_set_header_flags(struct ethtool_module_set_req *req,
 	req->header.flags = flags;
 }
 static inline void
+ethtool_module_set_req_set_header_phy_index(struct ethtool_module_set_req *req,
+					    __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
+static inline void
 ethtool_module_set_req_set_power_mode_policy(struct ethtool_module_set_req *req,
 					     __u8 power_mode_policy)
 {
@@ -4586,6 +5012,14 @@ ethtool_pse_get_req_set_header_flags(struct ethtool_pse_get_req *req,
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_pse_get_req_set_header_phy_index(struct ethtool_pse_get_req *req,
+					 __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_pse_get_rsp {
 	struct {
@@ -4651,6 +5085,14 @@ ethtool_pse_get_req_dump_set_header_flags(struct ethtool_pse_get_req_dump *req,
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_pse_get_req_dump_set_header_phy_index(struct ethtool_pse_get_req_dump *req,
+					      __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_pse_get_list {
 	struct ethtool_pse_get_list *next;
@@ -4711,6 +5153,14 @@ ethtool_pse_set_req_set_header_flags(struct ethtool_pse_set_req *req,
 	req->header.flags = flags;
 }
 static inline void
+ethtool_pse_set_req_set_header_phy_index(struct ethtool_pse_set_req *req,
+					 __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
+static inline void
 ethtool_pse_set_req_set_admin_state(struct ethtool_pse_set_req *req,
 				    __u32 admin_state)
 {
@@ -4779,6 +5229,14 @@ ethtool_rss_get_req_set_header_flags(struct ethtool_rss_get_req *req,
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_rss_get_req_set_header_phy_index(struct ethtool_rss_get_req *req,
+					 __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_rss_get_rsp {
 	struct {
@@ -4846,6 +5304,14 @@ ethtool_rss_get_req_dump_set_header_flags(struct ethtool_rss_get_req_dump *req,
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_rss_get_req_dump_set_header_phy_index(struct ethtool_rss_get_req_dump *req,
+					      __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_rss_get_list {
 	struct ethtool_rss_get_list *next;
@@ -4900,6 +5366,14 @@ ethtool_plca_get_cfg_req_set_header_flags(struct ethtool_plca_get_cfg_req *req,
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_plca_get_cfg_req_set_header_phy_index(struct ethtool_plca_get_cfg_req *req,
+					      __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_plca_get_cfg_rsp {
 	struct {
@@ -4976,6 +5450,14 @@ ethtool_plca_get_cfg_req_dump_set_header_flags(struct ethtool_plca_get_cfg_req_d
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_plca_get_cfg_req_dump_set_header_phy_index(struct ethtool_plca_get_cfg_req_dump *req,
+						   __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_plca_get_cfg_list {
 	struct ethtool_plca_get_cfg_list *next;
@@ -5059,6 +5541,14 @@ ethtool_plca_set_cfg_req_set_header_flags(struct ethtool_plca_set_cfg_req *req,
 	req->header.flags = flags;
 }
 static inline void
+ethtool_plca_set_cfg_req_set_header_phy_index(struct ethtool_plca_set_cfg_req *req,
+					      __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
+static inline void
 ethtool_plca_set_cfg_req_set_version(struct ethtool_plca_set_cfg_req *req,
 				     __u16 version)
 {
@@ -5164,6 +5654,14 @@ ethtool_plca_get_status_req_set_header_flags(struct ethtool_plca_get_status_req
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_plca_get_status_req_set_header_phy_index(struct ethtool_plca_get_status_req *req,
+						 __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_plca_get_status_rsp {
 	struct {
@@ -5241,6 +5739,14 @@ ethtool_plca_get_status_req_dump_set_header_flags(struct ethtool_plca_get_status
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_plca_get_status_req_dump_set_header_phy_index(struct ethtool_plca_get_status_req_dump *req,
+						      __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_plca_get_status_list {
 	struct ethtool_plca_get_status_list *next;
@@ -5296,6 +5802,14 @@ ethtool_mm_get_req_set_header_flags(struct ethtool_mm_get_req *req,
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_mm_get_req_set_header_phy_index(struct ethtool_mm_get_req *req,
+					__u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_mm_get_rsp {
 	struct {
@@ -5373,6 +5887,14 @@ ethtool_mm_get_req_dump_set_header_flags(struct ethtool_mm_get_req_dump *req,
 	req->header._present.flags = 1;
 	req->header.flags = flags;
 }
+static inline void
+ethtool_mm_get_req_dump_set_header_phy_index(struct ethtool_mm_get_req_dump *req,
+					     __u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
 
 struct ethtool_mm_get_list {
 	struct ethtool_mm_get_list *next;
@@ -5448,6 +5970,14 @@ ethtool_mm_set_req_set_header_flags(struct ethtool_mm_set_req *req,
 	req->header.flags = flags;
 }
 static inline void
+ethtool_mm_set_req_set_header_phy_index(struct ethtool_mm_set_req *req,
+					__u32 phy_index)
+{
+	req->_present.header = 1;
+	req->header._present.phy_index = 1;
+	req->header.phy_index = phy_index;
+}
+static inline void
 ethtool_mm_set_req_set_verify_enabled(struct ethtool_mm_set_req *req,
 				      __u8 verify_enabled)
 {
-- 
2.42.0

