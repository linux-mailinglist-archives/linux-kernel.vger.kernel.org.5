Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03958772D32
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjHGRm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjHGRmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:42:24 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F4010F3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:42:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d052f49702dso5645916276.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691430138; x=1692034938;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cE840IY96OqTljZhYSAn/hHb4EfgMMxzDLXkeKeBfQ8=;
        b=l8xMiaEYbabYON68pbIR8Zr7Mc8JCzDXd6QM9kiT0hkWDgl9bDzqGaeL+5m+O5RHpp
         yWgFIJkIJ45WRMHMbH+jSPpYopeFMUXZhYVSvm19+0s8SzDSMgH/rrqlEy2PPkXgp0KC
         u0ldwi96Pqp0Z/Ao1TYjErWJ01qJ0gk9rhs9oj/eUnQsksyW+RKV5z/tuR/GPtUx77X5
         tunhMZFNl8DTl6JeSs/8EdZnuMH0iFVnRc1wK1t6LkV82Ma/yc1pDThme7NXMxQpLN1K
         EQvMLV88QvlF8u4mZKd5TUX/FNIBp9vxEFXM5f7R4HaoH5nubIRwagJXLDlyz8/RFezV
         kmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691430138; x=1692034938;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cE840IY96OqTljZhYSAn/hHb4EfgMMxzDLXkeKeBfQ8=;
        b=drX2i59650qyQa5AGLMucWTIkyF4Dd+hwsdDmtY8PibXKzPpi4KQVbYG7PJtS3QCWi
         62rEJVhVxhQp/fyMZp1i5rshYeLuowC1sXxlg3xvR6bNcTwxwHJ78mIT+de0wiW99Z3C
         /Dk0cQ8WwM6bRTPHIAQaA6rlmZClKjzPMDtXpAz6fD8xMK9e1Jg1X1m7h1ImF53/0dE9
         h7rYjxMoA/ofJA4dZgaDo9sObfzuxhuyEdjEd/JYeJUiT0t1aUcHaLYhw7GiqsfNjeyd
         h3UBiNUjO9D6feSW2f6acGH4NiXD+3sbJk8nhkVrwq+12uRPSfrSCbWEngHpqKkRaRgz
         9VNg==
X-Gm-Message-State: AOJu0Yyg40VIGxqF086XHrFG1EtC/KY4hPG7taH/q5wlPSx1pzMf4BTG
        jYOm6CurPGq/Ov88hhFZPB56iuZlCuIY
X-Google-Smtp-Source: AGHT+IEbvvq/rvNAkXuXeQPKzf5elL+7mbxPymkc8nG7BSn2I2ERI2KzcQWc9s39jzq7YYzEo1+ol/0pdOTg
X-Received: from kyletso-p620lin01.ntc.corp.google.com ([2401:fa00:fc:202:c7c:f93d:372a:1641])
 (user=kyletso job=sendgmr) by 2002:a25:4088:0:b0:d0c:e37:b749 with SMTP id
 n130-20020a254088000000b00d0c0e37b749mr61429yba.10.1691430138764; Mon, 07 Aug
 2023 10:42:18 -0700 (PDT)
Date:   Tue,  8 Aug 2023 01:41:59 +0800
In-Reply-To: <20230807174159.1140957-1-kyletso@google.com>
Mime-Version: 1.0
References: <20230807174159.1140957-1-kyletso@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230807174159.1140957-3-kyletso@google.com>
Subject: [PATCH v2 2/2] usb: typec: tcpm: Support multiple capabilities
From:   Kyle Tso <kyletso@google.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     badhri@google.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit refactors tcpm_fw_get_caps to support the multiple pd
capabilities got from fwnode. For backward compatibility, the original
single capability is still applicable. The fetched data are stored in
the newly defined structure "pd_data" and there is an array "pd_list" to
store the pointers to them. A dedicated array "pds" is used to store the
handles of the registered usb_power_delivery instances.

This commit also implements the .pd_get and .pd_set ops which are
introduced in commit a7cff92f0635 ("usb: typec: USB Power Delivery
helpers for ports and partners"). Once the .pd_set is called, the
current capability will be updated and state machine will re-negotiate
the power contract if possible.

Signed-off-by: Kyle Tso <kyletso@google.com>
---
v1 -> v2:
- Added some missing cleanups in the function tcpm_port_unregister_pd

 drivers/usb/typec/tcpm/tcpm.c | 419 +++++++++++++++++++++++++++-------
 1 file changed, 333 insertions(+), 86 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 5a7d8cc04628..dd21d593979d 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -296,6 +296,15 @@ struct pd_pps_data {
 	bool active;
 };
 
+struct pd_data {
+	struct usb_power_delivery *pd;
+	struct usb_power_delivery_capabilities *source_cap;
+	struct usb_power_delivery_capabilities_desc source_desc;
+	struct usb_power_delivery_capabilities *sink_cap;
+	struct usb_power_delivery_capabilities_desc sink_desc;
+	unsigned int operating_snk_mw;
+};
+
 struct tcpm_port {
 	struct device *dev;
 
@@ -397,12 +406,14 @@ struct tcpm_port {
 	unsigned int rx_msgid;
 
 	/* USB PD objects */
-	struct usb_power_delivery *pd;
+	struct usb_power_delivery **pds;
+	struct pd_data **pd_list;
 	struct usb_power_delivery_capabilities *port_source_caps;
 	struct usb_power_delivery_capabilities *port_sink_caps;
 	struct usb_power_delivery *partner_pd;
 	struct usb_power_delivery_capabilities *partner_source_caps;
 	struct usb_power_delivery_capabilities *partner_sink_caps;
+	struct usb_power_delivery *selected_pd;
 
 	/* Partner capabilities/requests */
 	u32 sink_request;
@@ -412,6 +423,7 @@ struct tcpm_port {
 	unsigned int nr_sink_caps;
 
 	/* Local capabilities */
+	unsigned int pd_count;
 	u32 src_pdo[PDO_MAX_OBJECTS];
 	unsigned int nr_src_pdo;
 	u32 snk_pdo[PDO_MAX_OBJECTS];
@@ -5985,12 +5997,114 @@ static int tcpm_port_type_set(struct typec_port *p, enum typec_port_type type)
 	return 0;
 }
 
+static struct pd_data *tcpm_find_pd_data(struct tcpm_port *port, struct usb_power_delivery *pd)
+{
+	int i;
+
+	for (i = 0; port->pd_list[i]; i++) {
+		if (port->pd_list[i]->pd == pd)
+			return port->pd_list[i];
+	}
+
+	return ERR_PTR(-ENODATA);
+}
+
+static struct usb_power_delivery **tcpm_pd_get(struct typec_port *p)
+{
+	struct tcpm_port *port = typec_get_drvdata(p);
+
+	return port->pds;
+}
+
+static int tcpm_pd_set(struct typec_port *p, struct usb_power_delivery *pd)
+{
+	struct tcpm_port *port = typec_get_drvdata(p);
+	struct pd_data *data;
+	int i, ret = 0;
+
+	mutex_lock(&port->lock);
+
+	if (port->selected_pd == pd)
+		goto unlock;
+
+	data = tcpm_find_pd_data(port, pd);
+	if (IS_ERR_OR_NULL(data)) {
+		ret = -ENODATA;
+		goto unlock;
+	}
+
+	if (data->sink_desc.pdo[0]) {
+		for (i = 0; i < PDO_MAX_OBJECTS && data->sink_desc.pdo[i]; i++)
+			port->snk_pdo[i] = data->sink_desc.pdo[i];
+		port->nr_snk_pdo = i + 1;
+		port->operating_snk_mw = data->operating_snk_mw;
+	}
+
+	if (data->source_desc.pdo[0]) {
+		for (i = 0; i < PDO_MAX_OBJECTS && data->source_desc.pdo[i]; i++)
+			port->snk_pdo[i] = data->source_desc.pdo[i];
+		port->nr_src_pdo = i + 1;
+	}
+
+	switch (port->state) {
+	case SRC_UNATTACHED:
+	case SRC_ATTACH_WAIT:
+	case SRC_TRYWAIT:
+		tcpm_set_cc(port, tcpm_rp_cc(port));
+		break;
+	case SRC_SEND_CAPABILITIES:
+	case SRC_SEND_CAPABILITIES_TIMEOUT:
+	case SRC_NEGOTIATE_CAPABILITIES:
+	case SRC_READY:
+	case SRC_WAIT_NEW_CAPABILITIES:
+		port->caps_count = 0;
+		port->upcoming_state = SRC_SEND_CAPABILITIES;
+		ret = tcpm_ams_start(port, POWER_NEGOTIATION);
+		if (ret == -EAGAIN) {
+			port->upcoming_state = INVALID_STATE;
+			goto unlock;
+		}
+		break;
+	case SNK_NEGOTIATE_CAPABILITIES:
+	case SNK_NEGOTIATE_PPS_CAPABILITIES:
+	case SNK_READY:
+	case SNK_TRANSITION_SINK:
+	case SNK_TRANSITION_SINK_VBUS:
+		if (port->pps_data.active)
+			port->upcoming_state = SNK_NEGOTIATE_PPS_CAPABILITIES;
+		else if (port->pd_capable)
+			port->upcoming_state = SNK_NEGOTIATE_CAPABILITIES;
+		else
+			break;
+
+		port->update_sink_caps = true;
+
+		ret = tcpm_ams_start(port, POWER_NEGOTIATION);
+		if (ret == -EAGAIN) {
+			port->upcoming_state = INVALID_STATE;
+			goto unlock;
+		}
+		break;
+	default:
+		break;
+	}
+
+	port->port_source_caps = data->source_cap;
+	port->port_sink_caps = data->sink_cap;
+	port->selected_pd = pd;
+unlock:
+	mutex_unlock(&port->lock);
+	return ret;
+}
+
 static const struct typec_operations tcpm_ops = {
 	.try_role = tcpm_try_role,
 	.dr_set = tcpm_dr_set,
 	.pr_set = tcpm_pr_set,
 	.vconn_set = tcpm_vconn_set,
-	.port_type_set = tcpm_port_type_set
+	.port_type_set = tcpm_port_type_set,
+	.pd_get = tcpm_pd_get,
+	.pd_set = tcpm_pd_set
 };
 
 void tcpm_tcpc_reset(struct tcpm_port *port)
@@ -6004,58 +6118,75 @@ EXPORT_SYMBOL_GPL(tcpm_tcpc_reset);
 
 static void tcpm_port_unregister_pd(struct tcpm_port *port)
 {
-	usb_power_delivery_unregister_capabilities(port->port_sink_caps);
+	int i;
+
 	port->port_sink_caps = NULL;
-	usb_power_delivery_unregister_capabilities(port->port_source_caps);
 	port->port_source_caps = NULL;
-	usb_power_delivery_unregister(port->pd);
-	port->pd = NULL;
+	for (i = 0; i < port->pd_count; i++) {
+		if (!IS_ERR_OR_NULL(port->pd_list[i]) &&
+		    !IS_ERR_OR_NULL(port->pd_list[i]->sink_cap)) {
+			usb_power_delivery_unregister_capabilities(port->pd_list[i]->sink_cap);
+			kfree(port->pd_list[i]->sink_cap);
+			port->pd_list[i]->sink_cap = NULL;
+		}
+		if (!IS_ERR_OR_NULL(port->pd_list[i]) &&
+		    !IS_ERR_OR_NULL(port->pd_list[i]->source_cap)) {
+			usb_power_delivery_unregister_capabilities(port->pd_list[i]->source_cap);
+			kfree(port->pd_list[i]->source_cap);
+			port->pd_list[i]->source_cap = NULL;
+		}
+		if (!IS_ERR_OR_NULL(port->pd_list[i])) {
+			port->pd_list[i]->pd = NULL;
+			devm_kfree(port->dev, port->pd_list[i]);
+			port->pd_list[i] = NULL;
+		}
+		if (!IS_ERR_OR_NULL(port->pds[i]))
+			usb_power_delivery_unregister(port->pds[i]);
+		port->pds[i] = NULL;
+	}
 }
 
 static int tcpm_port_register_pd(struct tcpm_port *port)
 {
 	struct usb_power_delivery_desc desc = { port->typec_caps.pd_revision };
-	struct usb_power_delivery_capabilities_desc caps = { };
 	struct usb_power_delivery_capabilities *cap;
-	int ret;
+	int ret, i;
 
 	if (!port->nr_src_pdo && !port->nr_snk_pdo)
 		return 0;
 
-	port->pd = usb_power_delivery_register(port->dev, &desc);
-	if (IS_ERR(port->pd)) {
-		ret = PTR_ERR(port->pd);
-		goto err_unregister;
-	}
-
-	if (port->nr_src_pdo) {
-		memcpy_and_pad(caps.pdo, sizeof(caps.pdo), port->src_pdo,
-			       port->nr_src_pdo * sizeof(u32), 0);
-		caps.role = TYPEC_SOURCE;
-
-		cap = usb_power_delivery_register_capabilities(port->pd, &caps);
-		if (IS_ERR(cap)) {
-			ret = PTR_ERR(cap);
+	for (i = 0; i < port->pd_count; i++) {
+		port->pds[i] = usb_power_delivery_register(port->dev, &desc);
+		if (IS_ERR(port->pds[i])) {
+			ret = PTR_ERR(port->pds[i]);
 			goto err_unregister;
 		}
-
-		port->port_source_caps = cap;
-	}
-
-	if (port->nr_snk_pdo) {
-		memcpy_and_pad(caps.pdo, sizeof(caps.pdo), port->snk_pdo,
-			       port->nr_snk_pdo * sizeof(u32), 0);
-		caps.role = TYPEC_SINK;
-
-		cap = usb_power_delivery_register_capabilities(port->pd, &caps);
-		if (IS_ERR(cap)) {
-			ret = PTR_ERR(cap);
-			goto err_unregister;
+		port->pd_list[i]->pd = port->pds[i];
+
+		if (port->pd_list[i]->source_desc.pdo[0]) {
+			cap = usb_power_delivery_register_capabilities(port->pds[i],
+								&port->pd_list[i]->source_desc);
+			if (IS_ERR(cap)) {
+				ret = PTR_ERR(cap);
+				goto err_unregister;
+			}
+			port->pd_list[i]->source_cap = cap;
 		}
 
-		port->port_sink_caps = cap;
+		if (port->pd_list[i]->sink_desc.pdo[0]) {
+			cap = usb_power_delivery_register_capabilities(port->pds[i],
+								&port->pd_list[i]->sink_desc);
+			if (IS_ERR(cap)) {
+				ret = PTR_ERR(cap);
+				goto err_unregister;
+			}
+			port->pd_list[i]->sink_cap = cap;
+		}
 	}
 
+	port->port_source_caps = port->pd_list[0]->source_cap;
+	port->port_sink_caps = port->pd_list[0]->sink_cap;
+	port->selected_pd = port->pds[0];
 	return 0;
 
 err_unregister:
@@ -6064,12 +6195,11 @@ static int tcpm_port_register_pd(struct tcpm_port *port)
 	return ret;
 }
 
-static int tcpm_fw_get_caps(struct tcpm_port *port,
-			    struct fwnode_handle *fwnode)
+static int tcpm_fw_get_properties(struct tcpm_port *port, struct fwnode_handle *fwnode)
 {
 	const char *opmode_str;
+	u32 frs_current;
 	int ret;
-	u32 mw, frs_current;
 
 	if (!fwnode)
 		return -EINVAL;
@@ -6089,28 +6219,10 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 
 	port->port_type = port->typec_caps.type;
 	port->pd_supported = !fwnode_property_read_bool(fwnode, "pd-disable");
-
 	port->slow_charger_loop = fwnode_property_read_bool(fwnode, "slow-charger-loop");
-	if (port->port_type == TYPEC_PORT_SNK)
-		goto sink;
-
-	/* Get Source PDOs for the PD port or Source Rp value for the non-PD port */
-	if (port->pd_supported) {
-		ret = fwnode_property_count_u32(fwnode, "source-pdos");
-		if (ret == 0)
-			return -EINVAL;
-		else if (ret < 0)
-			return ret;
+	port->self_powered = fwnode_property_read_bool(fwnode, "self-powered");
 
-		port->nr_src_pdo = min(ret, PDO_MAX_OBJECTS);
-		ret = fwnode_property_read_u32_array(fwnode, "source-pdos",
-						     port->src_pdo, port->nr_src_pdo);
-		if (ret)
-			return ret;
-		ret = tcpm_validate_caps(port, port->src_pdo, port->nr_src_pdo);
-		if (ret)
-			return ret;
-	} else {
+	if (!port->pd_supported) {
 		ret = fwnode_property_read_string(fwnode, "typec-power-opmode", &opmode_str);
 		if (ret)
 			return ret;
@@ -6120,43 +6232,174 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 		port->src_rp = tcpm_pwr_opmode_to_rp(ret);
 	}
 
-	if (port->port_type == TYPEC_PORT_SRC)
-		return 0;
+	/* FRS can only be supported by DRP ports */
+	if (port->port_type == TYPEC_PORT_DRP) {
+		ret = fwnode_property_read_u32(fwnode, "new-source-frs-typec-current",
+					       &frs_current);
+		if (ret >= 0 && frs_current <= FRS_5V_3A)
+			port->new_source_frs_current = frs_current;
+	}
 
-sink:
-	port->self_powered = fwnode_property_read_bool(fwnode, "self-powered");
+	return 0;
+}
+
+static unsigned int tcpm_fw_count_pd(struct fwnode_handle *capabilities)
+{
+	struct fwnode_handle *child = NULL;
+	unsigned int count = 0;
+
+	do {
+		count++;
+		child = fwnode_get_next_child_node(capabilities, child);
+		fwnode_handle_put(child);
+	} while (child);
+
+	return --count;
+}
+
+static int tcpm_fw_get_caps(struct tcpm_port *port, struct fwnode_handle *fwnode)
+{
+	struct fwnode_handle *capabilities, *caps = NULL;
+	unsigned int nr_src_pdo, nr_snk_pdo;
+	u32 *src_pdo, *snk_pdo;
+	u32 uw;
+	int ret, i;
+
+	if (!fwnode)
+		return -EINVAL;
 
 	if (!port->pd_supported)
 		return 0;
 
-	/* Get sink pdos */
-	ret = fwnode_property_count_u32(fwnode, "sink-pdos");
-	if (ret <= 0)
-		return -EINVAL;
+	/* For the backward compatibility, "capabilities" node is optional. */
+	capabilities = fwnode_get_named_child_node(fwnode, "capabilities");
+	if (IS_ERR_OR_NULL(capabilities)) {
+		port->pd_count = 1;
+		capabilities = NULL;
+	} else {
+		port->pd_count = tcpm_fw_count_pd(capabilities);
+		if (!port->pd_count) {
+			fwnode_handle_put(capabilities);
+			return -ENODATA;
+		}
+	}
 
-	port->nr_snk_pdo = min(ret, PDO_MAX_OBJECTS);
-	ret = fwnode_property_read_u32_array(fwnode, "sink-pdos",
-					     port->snk_pdo, port->nr_snk_pdo);
-	if ((ret < 0) || tcpm_validate_caps(port, port->snk_pdo,
-					    port->nr_snk_pdo))
-		return -EINVAL;
+	port->pds = devm_kcalloc(port->dev, port->pd_count, sizeof(struct usb_power_delivery *),
+				 GFP_KERNEL);
+	if (IS_ERR_OR_NULL(port->pds)) {
+		fwnode_handle_put(capabilities);
+		return -ENOMEM;
+	}
 
-	if (fwnode_property_read_u32(fwnode, "op-sink-microwatt", &mw) < 0)
-		return -EINVAL;
-	port->operating_snk_mw = mw / 1000;
+	port->pd_list = devm_kcalloc(port->dev, port->pd_count, sizeof(struct pd_data *),
+				     GFP_KERNEL);
+	if (IS_ERR_OR_NULL(port->pd_list)) {
+		fwnode_handle_put(capabilities);
+		return -ENOMEM;
+	}
 
-	/* FRS can only be supported by DRP ports */
-	if (port->port_type == TYPEC_PORT_DRP) {
-		ret = fwnode_property_read_u32(fwnode, "new-source-frs-typec-current",
-					       &frs_current);
-		if (ret >= 0 && frs_current <= FRS_5V_3A)
-			port->new_source_frs_current = frs_current;
+	for (i = 0; i < port->pd_count; i++) {
+		port->pd_list[i] = devm_kzalloc(port->dev, sizeof(struct pd_data), GFP_KERNEL);
+
+		src_pdo = port->pd_list[i]->source_desc.pdo;
+		port->pd_list[i]->source_desc.role = TYPEC_SOURCE;
+		snk_pdo = port->pd_list[i]->sink_desc.pdo;
+		port->pd_list[i]->sink_desc.role = TYPEC_SINK;
+
+		/*
+		 * The last put is in "exit_fwnode_put" so forward the put to the beginning of this
+		 * "for loop". It doesn't matter for the first put because the first caps is NULL.
+		 * It won't run the second time if caps == fwnode because port->pd_count is 1 in
+		 * that case.
+		 */
+		fwnode_handle_put(caps);
+
+		/* If "capabilities" is NULL, fall back to single pd cap population. */
+		if (!capabilities)
+			caps = fwnode;
+		else
+			caps = fwnode_get_next_child_node(capabilities, caps);
+
+		if (port->port_type != TYPEC_PORT_SNK) {
+			ret = fwnode_property_count_u32(caps, "source-pdos");
+			if (ret == 0) {
+				ret = -EINVAL;
+				goto exit_fwnode_put;
+			} else if (ret < 0) {
+				goto exit_fwnode_put;
+			}
+
+			nr_src_pdo = min(ret, PDO_MAX_OBJECTS);
+			ret = fwnode_property_read_u32_array(caps, "source-pdos", src_pdo,
+							     nr_src_pdo);
+			if (ret)
+				goto exit_fwnode_put;
+
+			ret = tcpm_validate_caps(port, src_pdo, nr_src_pdo);
+			if (ret)
+				goto exit_fwnode_put;
+
+			if (i == 0) {
+				port->nr_src_pdo = nr_src_pdo;
+				memcpy_and_pad(port->src_pdo, sizeof(u32) * PDO_MAX_OBJECTS,
+					       port->pd_list[0]->source_desc.pdo,
+					       sizeof(u32) * nr_src_pdo,
+					       0);
+			}
+		}
+
+		if (port->port_type != TYPEC_PORT_SRC) {
+			ret = fwnode_property_count_u32(caps, "sink-pdos");
+			if (ret == 0) {
+				ret = -EINVAL;
+				goto exit_fwnode_put;
+			} else if (ret < 0) {
+				goto exit_fwnode_put;
+			}
+
+			nr_snk_pdo = min(ret, PDO_MAX_OBJECTS);
+			ret = fwnode_property_read_u32_array(caps, "sink-pdos", snk_pdo,
+							     nr_snk_pdo);
+			if (ret)
+				goto exit_fwnode_put;
+
+			ret = tcpm_validate_caps(port, snk_pdo, nr_snk_pdo);
+			if (ret)
+				goto exit_fwnode_put;
+
+			if (fwnode_property_read_u32(caps, "op-sink-microwatt", &uw) < 0) {
+				ret = -EINVAL;
+				goto exit_fwnode_put;
+			}
+
+			port->pd_list[i]->operating_snk_mw = uw / 1000;
+
+			if (i == 0) {
+				port->nr_snk_pdo = nr_snk_pdo;
+				memcpy_and_pad(port->snk_pdo, sizeof(u32) * PDO_MAX_OBJECTS,
+					       port->pd_list[0]->sink_desc.pdo,
+					       sizeof(u32) * nr_snk_pdo,
+					       0);
+				port->operating_snk_mw = port->pd_list[0]->operating_snk_mw;
+			}
+		}
 	}
 
+exit_fwnode_put:
+	if (caps != fwnode)
+		fwnode_handle_put(caps);
+	fwnode_handle_put(capabilities);
+	return ret;
+}
+
+static int tcpm_fw_get_snk_vdos(struct tcpm_port *port, struct fwnode_handle *fwnode)
+{
+	int ret;
+
 	/* sink-vdos is optional */
 	ret = fwnode_property_count_u32(fwnode, "sink-vdos");
 	if (ret < 0)
-		ret = 0;
+		return 0;
 
 	port->nr_snk_vdo = min(ret, VDO_MAX_OBJECTS);
 	if (port->nr_snk_vdo) {
@@ -6521,13 +6764,18 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	init_completion(&port->pps_complete);
 	tcpm_debugfs_init(port);
 
+	err = tcpm_fw_get_properties(port, tcpc->fwnode);
+	if (err < 0)
+		goto out_destroy_wq;
 	err = tcpm_fw_get_caps(port, tcpc->fwnode);
+	if (err < 0)
+		goto out_destroy_wq;
+	err = tcpm_fw_get_snk_vdos(port, tcpc->fwnode);
 	if (err < 0)
 		goto out_destroy_wq;
 
 	port->try_role = port->typec_caps.prefer_role;
 
-	port->typec_caps.fwnode = tcpc->fwnode;
 	port->typec_caps.revision = 0x0120;	/* Type-C spec release 1.2 */
 	port->typec_caps.pd_revision = 0x0300;	/* USB-PD spec release 3.0 */
 	port->typec_caps.svdm_version = SVDM_VER_2_0;
@@ -6536,7 +6784,6 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	port->typec_caps.orientation_aware = 1;
 
 	port->partner_desc.identity = &port->partner_ident;
-	port->port_type = port->typec_caps.type;
 
 	port->role_sw = usb_role_switch_get(port->dev);
 	if (!port->role_sw)
@@ -6555,7 +6802,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	if (err)
 		goto out_role_sw_put;
 
-	port->typec_caps.pd = port->pd;
+	port->typec_caps.pd = port->pds[0];
 
 	port->typec_port = typec_register_port(port->dev, &port->typec_caps);
 	if (IS_ERR(port->typec_port)) {
-- 
2.41.0.585.gd2178a4bd4-goog

