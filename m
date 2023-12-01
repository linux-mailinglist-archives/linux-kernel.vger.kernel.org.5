Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADD8801128
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjLARL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjLARLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:11:37 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC30131;
        Fri,  1 Dec 2023 09:11:42 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E10C9240007;
        Fri,  1 Dec 2023 17:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701450701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lwpjtsb4vZRwM2eK/2Qxes8YTGtiPBW1F4mvBxoQ974=;
        b=bJSI6nE/WN/p9onyAoGJxA9IgpJ/ir9a+vhgPSqSwgCEOH36CNdeS+ghoo4PKkp+cg4toI
        180lv6wqy4m9TAsnz/DMs51NCv3Rk/kmwwo5Fu91Bbe2F1VpOtxY6SWoco/3dEKjjDBNvU
        2zYx/Yt87QMy0YIx6zKRv4y00B3QcHD1mM2lqcyhWRBkJvaw1LTKOo7CFS5UmIQj6v+Jou
        ap+c7GvyYzEY3wDuRr2ZehZJJm4hF/xXLKwfAQgwY4P6mXZ7SsbNukPqTvm/aW1n3o8UJG
        tJekVAzU7EZjdHtTezmJiBmD3PhhkIhWh2b5cUu+HkKaAnzGC7ipHbsMhyRjjg==
From:   Kory Maincent <kory.maincent@bootlin.com>
Date:   Fri, 01 Dec 2023 18:10:28 +0100
Subject: [PATCH net-next v2 6/8] netlink: specs: Expand the pse netlink
 command with PoE interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231201-feature_poe-v2-6-56d8cac607fa@bootlin.com>
References: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
In-Reply-To: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
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
        Conor Dooley <conor+dt@kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        Dent Project <dentproject@linuxfoundation.org>,
        Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the PoE pse attributes prefix to be able to use PoE interface.

Example usage:
./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do pse-get \
             --json '{"header":{"dev-name":"eth0"}}'
{'header': {'dev-index': 4, 'dev-name': 'eth0'},
 'c33-pse-admin-state': 3,
 'c33-pse-pw-d-status': 4}

./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do pse-set \
             --json '{"header":{"dev-name":"eth0"},
		     "c33-pse-admin-control":3}'

Update the ethtool generated code accordingly.

Sponsored-by: Dent Project <dentproject@linuxfoundation.org>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v2:
- Follow the "c33" PoE prefix naming change.
- Add the ethtool auto generated code.
---
 Documentation/netlink/specs/ethtool.yaml | 15 +++++++++++++++
 tools/net/ynl/generated/ethtool-user.c   | 24 +++++++++++++++++++++++
 tools/net/ynl/generated/ethtool-user.h   | 33 ++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index e1bf75099264..6870106bf50c 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -889,6 +889,18 @@ attribute-sets:
         name: podl-pse-pw-d-status
         type: u32
         name-prefix: ethtool-a-
+      -
+        name: c33-pse-admin-state
+        type: u32
+        name-prefix: ethtool-a-
+      -
+        name: c33-pse-admin-control
+        type: u32
+        name-prefix: ethtool-a-
+      -
+        name: c33-pse-pw-d-status
+        type: u32
+        name-prefix: ethtool-a-
   -
     name: rss
     attributes:
@@ -1571,6 +1583,9 @@ operations:
             - podl-pse-admin-state
             - podl-pse-admin-control
             - podl-pse-pw-d-status
+            - c33-pse-admin-state
+            - c33-pse-admin-control
+            - c33-pse-pw-d-status
       dump: *pse-get-op
     -
       name: pse-set
diff --git a/tools/net/ynl/generated/ethtool-user.c b/tools/net/ynl/generated/ethtool-user.c
index 922bbd07ee95..bcf97b46ed6a 100644
--- a/tools/net/ynl/generated/ethtool-user.c
+++ b/tools/net/ynl/generated/ethtool-user.c
@@ -610,6 +610,9 @@ struct ynl_policy_attr ethtool_pse_policy[ETHTOOL_A_PSE_MAX + 1] = {
 	[ETHTOOL_A_PODL_PSE_ADMIN_STATE] = { .name = "podl-pse-admin-state", .type = YNL_PT_U32, },
 	[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL] = { .name = "podl-pse-admin-control", .type = YNL_PT_U32, },
 	[ETHTOOL_A_PODL_PSE_PW_D_STATUS] = { .name = "podl-pse-pw-d-status", .type = YNL_PT_U32, },
+	[ETHTOOL_A_C33_PSE_ADMIN_STATE] = { .name = "c33-pse-admin-state", .type = YNL_PT_U32, },
+	[ETHTOOL_A_C33_PSE_ADMIN_CONTROL] = { .name = "c33-pse-admin-control", .type = YNL_PT_U32, },
+	[ETHTOOL_A_C33_PSE_PW_D_STATUS] = { .name = "c33-pse-pw-d-status", .type = YNL_PT_U32, },
 };
 
 struct ynl_policy_nest ethtool_pse_nest = {
@@ -5320,6 +5323,21 @@ int ethtool_pse_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
 				return MNL_CB_ERROR;
 			dst->_present.podl_pse_pw_d_status = 1;
 			dst->podl_pse_pw_d_status = mnl_attr_get_u32(attr);
+		} else if (type == ETHTOOL_A_C33_PSE_ADMIN_STATE) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.c33_pse_admin_state = 1;
+			dst->c33_pse_admin_state = mnl_attr_get_u32(attr);
+		} else if (type == ETHTOOL_A_C33_PSE_ADMIN_CONTROL) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.c33_pse_admin_control = 1;
+			dst->c33_pse_admin_control = mnl_attr_get_u32(attr);
+		} else if (type == ETHTOOL_A_C33_PSE_PW_D_STATUS) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.c33_pse_pw_d_status = 1;
+			dst->c33_pse_pw_d_status = mnl_attr_get_u32(attr);
 		}
 	}
 
@@ -5426,6 +5444,12 @@ int ethtool_pse_set(struct ynl_sock *ys, struct ethtool_pse_set_req *req)
 		mnl_attr_put_u32(nlh, ETHTOOL_A_PODL_PSE_ADMIN_CONTROL, req->podl_pse_admin_control);
 	if (req->_present.podl_pse_pw_d_status)
 		mnl_attr_put_u32(nlh, ETHTOOL_A_PODL_PSE_PW_D_STATUS, req->podl_pse_pw_d_status);
+	if (req->_present.c33_pse_admin_state)
+		mnl_attr_put_u32(nlh, ETHTOOL_A_C33_PSE_ADMIN_STATE, req->c33_pse_admin_state);
+	if (req->_present.c33_pse_admin_control)
+		mnl_attr_put_u32(nlh, ETHTOOL_A_C33_PSE_ADMIN_CONTROL, req->c33_pse_admin_control);
+	if (req->_present.c33_pse_pw_d_status)
+		mnl_attr_put_u32(nlh, ETHTOOL_A_C33_PSE_PW_D_STATUS, req->c33_pse_pw_d_status);
 
 	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
diff --git a/tools/net/ynl/generated/ethtool-user.h b/tools/net/ynl/generated/ethtool-user.h
index a2c69264c021..5bcb9d5f5c89 100644
--- a/tools/net/ynl/generated/ethtool-user.h
+++ b/tools/net/ynl/generated/ethtool-user.h
@@ -4593,12 +4593,18 @@ struct ethtool_pse_get_rsp {
 		__u32 podl_pse_admin_state:1;
 		__u32 podl_pse_admin_control:1;
 		__u32 podl_pse_pw_d_status:1;
+		__u32 c33_pse_admin_state:1;
+		__u32 c33_pse_admin_control:1;
+		__u32 c33_pse_pw_d_status:1;
 	} _present;
 
 	struct ethtool_header header;
 	__u32 podl_pse_admin_state;
 	__u32 podl_pse_admin_control;
 	__u32 podl_pse_pw_d_status;
+	__u32 c33_pse_admin_state;
+	__u32 c33_pse_admin_control;
+	__u32 c33_pse_pw_d_status;
 };
 
 void ethtool_pse_get_rsp_free(struct ethtool_pse_get_rsp *rsp);
@@ -4670,12 +4676,18 @@ struct ethtool_pse_set_req {
 		__u32 podl_pse_admin_state:1;
 		__u32 podl_pse_admin_control:1;
 		__u32 podl_pse_pw_d_status:1;
+		__u32 c33_pse_admin_state:1;
+		__u32 c33_pse_admin_control:1;
+		__u32 c33_pse_pw_d_status:1;
 	} _present;
 
 	struct ethtool_header header;
 	__u32 podl_pse_admin_state;
 	__u32 podl_pse_admin_control;
 	__u32 podl_pse_pw_d_status;
+	__u32 c33_pse_admin_state;
+	__u32 c33_pse_admin_control;
+	__u32 c33_pse_pw_d_status;
 };
 
 static inline struct ethtool_pse_set_req *ethtool_pse_set_req_alloc(void)
@@ -4731,6 +4743,27 @@ ethtool_pse_set_req_set_podl_pse_pw_d_status(struct ethtool_pse_set_req *req,
 	req->_present.podl_pse_pw_d_status = 1;
 	req->podl_pse_pw_d_status = podl_pse_pw_d_status;
 }
+static inline void
+ethtool_pse_set_req_set_c33_pse_admin_state(struct ethtool_pse_set_req *req,
+					    __u32 c33_pse_admin_state)
+{
+	req->_present.c33_pse_admin_state = 1;
+	req->c33_pse_admin_state = c33_pse_admin_state;
+}
+static inline void
+ethtool_pse_set_req_set_c33_pse_admin_control(struct ethtool_pse_set_req *req,
+					      __u32 c33_pse_admin_control)
+{
+	req->_present.c33_pse_admin_control = 1;
+	req->c33_pse_admin_control = c33_pse_admin_control;
+}
+static inline void
+ethtool_pse_set_req_set_c33_pse_pw_d_status(struct ethtool_pse_set_req *req,
+					    __u32 c33_pse_pw_d_status)
+{
+	req->_present.c33_pse_pw_d_status = 1;
+	req->c33_pse_pw_d_status = c33_pse_pw_d_status;
+}
 
 /*
  * Set Power Sourcing Equipment params.

-- 
2.25.1

