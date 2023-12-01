Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5911280115D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjLARLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjLARLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:11:36 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08215C1;
        Fri,  1 Dec 2023 09:11:41 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EBCFD24000F;
        Fri,  1 Dec 2023 17:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701450700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ixu1ARHL6TBB4MJVE7+xLhAwRI9CASAllQuYJeHOESE=;
        b=ijkFw9kxCCy9HiJZDhE1rkSUduA8nz6fkKKyq5QqSofI7lcEcBDrxOBgaYYqTp7z3n3G6p
        oEvxD717bNj/dqs6AYOCqe3SsbxKDFawYOjuRymcT1BJud0C5pZCq2lDtblGoTI5WSr7Iq
        0K6+iQXwuTLZu/4OYLPQg5Lc28HWLfz9vJ6yHfbeQFDHxtOdTwPfpbIJVqUT9tEGOrKj6d
        X+6gV8vrtEr3rd9HPEdkGYHPoKuePeinhBkH7PQz3VymvIIPIywIC3dJFl10g7cV/dWreU
        9nrDXN/lnlx8kXXO+MR8o2jWEL+gqiX7wlnVFG/Wv1M56EhGKvtX31EcuZb7jA==
From:   Kory Maincent <kory.maincent@bootlin.com>
Date:   Fri, 01 Dec 2023 18:10:27 +0100
Subject: [PATCH net-next v2 5/8] netlink: specs: Modify pse attribute
 prefix
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231201-feature_poe-v2-5-56d8cac607fa@bootlin.com>
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

Remove podl from the attribute prefix to prepare the support of PoE pse
netlink spec.

Update the ethtool generated code accordingly.

Sponsored-by: Dent Project <dentproject@linuxfoundation.org>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v2:
- Add the ethtool auto generated code.
---
 Documentation/netlink/specs/ethtool.yaml | 18 ++++++------
 tools/net/ynl/generated/ethtool-user.c   | 30 ++++++++++----------
 tools/net/ynl/generated/ethtool-user.h   | 48 ++++++++++++++++----------------
 3 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 5c7a65b009b4..e1bf75099264 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -878,17 +878,17 @@ attribute-sets:
         type: nest
         nested-attributes: header
       -
-        name: admin-state
+        name: podl-pse-admin-state
         type: u32
-        name-prefix: ethtool-a-podl-pse-
+        name-prefix: ethtool-a-
       -
-        name: admin-control
+        name: podl-pse-admin-control
         type: u32
-        name-prefix: ethtool-a-podl-pse-
+        name-prefix: ethtool-a-
       -
-        name: pw-d-status
+        name: podl-pse-pw-d-status
         type: u32
-        name-prefix: ethtool-a-podl-pse-
+        name-prefix: ethtool-a-
   -
     name: rss
     attributes:
@@ -1568,9 +1568,9 @@ operations:
         reply:
           attributes: &pse
             - header
-            - admin-state
-            - admin-control
-            - pw-d-status
+            - podl-pse-admin-state
+            - podl-pse-admin-control
+            - podl-pse-pw-d-status
       dump: *pse-get-op
     -
       name: pse-set
diff --git a/tools/net/ynl/generated/ethtool-user.c b/tools/net/ynl/generated/ethtool-user.c
index 660435639e2b..922bbd07ee95 100644
--- a/tools/net/ynl/generated/ethtool-user.c
+++ b/tools/net/ynl/generated/ethtool-user.c
@@ -607,9 +607,9 @@ struct ynl_policy_nest ethtool_module_nest = {
 
 struct ynl_policy_attr ethtool_pse_policy[ETHTOOL_A_PSE_MAX + 1] = {
 	[ETHTOOL_A_PSE_HEADER] = { .name = "header", .type = YNL_PT_NEST, .nest = &ethtool_header_nest, },
-	[ETHTOOL_A_PODL_PSE_ADMIN_STATE] = { .name = "admin-state", .type = YNL_PT_U32, },
-	[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL] = { .name = "admin-control", .type = YNL_PT_U32, },
-	[ETHTOOL_A_PODL_PSE_PW_D_STATUS] = { .name = "pw-d-status", .type = YNL_PT_U32, },
+	[ETHTOOL_A_PODL_PSE_ADMIN_STATE] = { .name = "podl-pse-admin-state", .type = YNL_PT_U32, },
+	[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL] = { .name = "podl-pse-admin-control", .type = YNL_PT_U32, },
+	[ETHTOOL_A_PODL_PSE_PW_D_STATUS] = { .name = "podl-pse-pw-d-status", .type = YNL_PT_U32, },
 };
 
 struct ynl_policy_nest ethtool_pse_nest = {
@@ -5308,18 +5308,18 @@ int ethtool_pse_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
 		} else if (type == ETHTOOL_A_PODL_PSE_ADMIN_STATE) {
 			if (ynl_attr_validate(yarg, attr))
 				return MNL_CB_ERROR;
-			dst->_present.admin_state = 1;
-			dst->admin_state = mnl_attr_get_u32(attr);
+			dst->_present.podl_pse_admin_state = 1;
+			dst->podl_pse_admin_state = mnl_attr_get_u32(attr);
 		} else if (type == ETHTOOL_A_PODL_PSE_ADMIN_CONTROL) {
 			if (ynl_attr_validate(yarg, attr))
 				return MNL_CB_ERROR;
-			dst->_present.admin_control = 1;
-			dst->admin_control = mnl_attr_get_u32(attr);
+			dst->_present.podl_pse_admin_control = 1;
+			dst->podl_pse_admin_control = mnl_attr_get_u32(attr);
 		} else if (type == ETHTOOL_A_PODL_PSE_PW_D_STATUS) {
 			if (ynl_attr_validate(yarg, attr))
 				return MNL_CB_ERROR;
-			dst->_present.pw_d_status = 1;
-			dst->pw_d_status = mnl_attr_get_u32(attr);
+			dst->_present.podl_pse_pw_d_status = 1;
+			dst->podl_pse_pw_d_status = mnl_attr_get_u32(attr);
 		}
 	}
 
@@ -5420,12 +5420,12 @@ int ethtool_pse_set(struct ynl_sock *ys, struct ethtool_pse_set_req *req)
 
 	if (req->_present.header)
 		ethtool_header_put(nlh, ETHTOOL_A_PSE_HEADER, &req->header);
-	if (req->_present.admin_state)
-		mnl_attr_put_u32(nlh, ETHTOOL_A_PODL_PSE_ADMIN_STATE, req->admin_state);
-	if (req->_present.admin_control)
-		mnl_attr_put_u32(nlh, ETHTOOL_A_PODL_PSE_ADMIN_CONTROL, req->admin_control);
-	if (req->_present.pw_d_status)
-		mnl_attr_put_u32(nlh, ETHTOOL_A_PODL_PSE_PW_D_STATUS, req->pw_d_status);
+	if (req->_present.podl_pse_admin_state)
+		mnl_attr_put_u32(nlh, ETHTOOL_A_PODL_PSE_ADMIN_STATE, req->podl_pse_admin_state);
+	if (req->_present.podl_pse_admin_control)
+		mnl_attr_put_u32(nlh, ETHTOOL_A_PODL_PSE_ADMIN_CONTROL, req->podl_pse_admin_control);
+	if (req->_present.podl_pse_pw_d_status)
+		mnl_attr_put_u32(nlh, ETHTOOL_A_PODL_PSE_PW_D_STATUS, req->podl_pse_pw_d_status);
 
 	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
diff --git a/tools/net/ynl/generated/ethtool-user.h b/tools/net/ynl/generated/ethtool-user.h
index ca0ec5fd7798..a2c69264c021 100644
--- a/tools/net/ynl/generated/ethtool-user.h
+++ b/tools/net/ynl/generated/ethtool-user.h
@@ -4590,15 +4590,15 @@ ethtool_pse_get_req_set_header_flags(struct ethtool_pse_get_req *req,
 struct ethtool_pse_get_rsp {
 	struct {
 		__u32 header:1;
-		__u32 admin_state:1;
-		__u32 admin_control:1;
-		__u32 pw_d_status:1;
+		__u32 podl_pse_admin_state:1;
+		__u32 podl_pse_admin_control:1;
+		__u32 podl_pse_pw_d_status:1;
 	} _present;
 
 	struct ethtool_header header;
-	__u32 admin_state;
-	__u32 admin_control;
-	__u32 pw_d_status;
+	__u32 podl_pse_admin_state;
+	__u32 podl_pse_admin_control;
+	__u32 podl_pse_pw_d_status;
 };
 
 void ethtool_pse_get_rsp_free(struct ethtool_pse_get_rsp *rsp);
@@ -4667,15 +4667,15 @@ ethtool_pse_get_dump(struct ynl_sock *ys, struct ethtool_pse_get_req_dump *req);
 struct ethtool_pse_set_req {
 	struct {
 		__u32 header:1;
-		__u32 admin_state:1;
-		__u32 admin_control:1;
-		__u32 pw_d_status:1;
+		__u32 podl_pse_admin_state:1;
+		__u32 podl_pse_admin_control:1;
+		__u32 podl_pse_pw_d_status:1;
 	} _present;
 
 	struct ethtool_header header;
-	__u32 admin_state;
-	__u32 admin_control;
-	__u32 pw_d_status;
+	__u32 podl_pse_admin_state;
+	__u32 podl_pse_admin_control;
+	__u32 podl_pse_pw_d_status;
 };
 
 static inline struct ethtool_pse_set_req *ethtool_pse_set_req_alloc(void)
@@ -4711,25 +4711,25 @@ ethtool_pse_set_req_set_header_flags(struct ethtool_pse_set_req *req,
 	req->header.flags = flags;
 }
 static inline void
-ethtool_pse_set_req_set_admin_state(struct ethtool_pse_set_req *req,
-				    __u32 admin_state)
+ethtool_pse_set_req_set_podl_pse_admin_state(struct ethtool_pse_set_req *req,
+					     __u32 podl_pse_admin_state)
 {
-	req->_present.admin_state = 1;
-	req->admin_state = admin_state;
+	req->_present.podl_pse_admin_state = 1;
+	req->podl_pse_admin_state = podl_pse_admin_state;
 }
 static inline void
-ethtool_pse_set_req_set_admin_control(struct ethtool_pse_set_req *req,
-				      __u32 admin_control)
+ethtool_pse_set_req_set_podl_pse_admin_control(struct ethtool_pse_set_req *req,
+					       __u32 podl_pse_admin_control)
 {
-	req->_present.admin_control = 1;
-	req->admin_control = admin_control;
+	req->_present.podl_pse_admin_control = 1;
+	req->podl_pse_admin_control = podl_pse_admin_control;
 }
 static inline void
-ethtool_pse_set_req_set_pw_d_status(struct ethtool_pse_set_req *req,
-				    __u32 pw_d_status)
+ethtool_pse_set_req_set_podl_pse_pw_d_status(struct ethtool_pse_set_req *req,
+					     __u32 podl_pse_pw_d_status)
 {
-	req->_present.pw_d_status = 1;
-	req->pw_d_status = pw_d_status;
+	req->_present.podl_pse_pw_d_status = 1;
+	req->podl_pse_pw_d_status = podl_pse_pw_d_status;
 }
 
 /*

-- 
2.25.1

