Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5F7803B58
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343590AbjLDRXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343823AbjLDRW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:22:58 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAEEE6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:23:03 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db548f8dae4so3025309276.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 09:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701710583; x=1702315383; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IMTdqm5zTqzrJY530vTWepDMpb2IhVN8gCn/w9vuFws=;
        b=LTdTiE1S3yT9tXk0HTE1Iu+7Ll5D8u07EviSov0FxkAIoXShM8IhLaCFfzX5pGKC0e
         EDwOxKKuf2FlBg8xU1KV/qlkhzmbeuJ2fwzATkkga19uLbs/fuxP0ukhpZdCnB8+8W1h
         YU+dcNru63cFnsChDr0sCEHzT8aKeqnIQZxRmXaza0ttyImQaCMdHD5McxLquxBuZd6y
         I6ObReA6+KWy4EnCD3/dVROhmpOu1QxgKUqONPXmyhZoTRyRjXHipXtUewpH4hT9ago/
         GeyLLzm6Om3AUkMZV65blf2SpsVmAa9sI2gAiPrAIiyT1SI55gMytkIznRPL2wle31+l
         WoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701710583; x=1702315383;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IMTdqm5zTqzrJY530vTWepDMpb2IhVN8gCn/w9vuFws=;
        b=GlwLHXSYueHfO/i7HVHrXQ9p7NiNy0B0WUkQrPp96Ll1MVkIvXYDdxnNeyGgwUysjz
         te2SB2UYxzNGO0hKLiag13+zXVfcOloCGixKmFcDwZyNnlbM90knpP+sT/iDC2+KFGef
         rGnrVAnv7+icWdJrdHHFUT3dpOkdWV0RcB1fdog8mb3oIkliU6Micb/YK1tZu/kWmt5I
         ihma1FUdm1ofCu61e/42M2lAkvSZ1vaZ1KuI9XTyxzgYUoHWsrPjCMY2m4p9YkKpgMrJ
         NYfH12P8RCv+Dx08E6xOS490dLxeRAoVa2RjFfoa/HQyps0jErqFtobbal9zh7lOuUht
         EdVQ==
X-Gm-Message-State: AOJu0YzcEFeB+F+z1XYYlfeFumTgp1/uAXg1z7BuH2auvGbM3ceOngQX
        edAr4NHbRlLPalTzShnDHs1GGRf9QYb1
X-Google-Smtp-Source: AGHT+IH0puCD9cgeSgd8Wj1uts99I485HDVLfKGlWnVQyNxMxJXZjXmxIDHJ17obUssocToHIAjTAS2ZClk9
X-Received: from kyletso-p620lin01.ntc.corp.google.com ([2401:fa00:fc:202:ac51:a57:5e72:a957])
 (user=kyletso job=sendgmr) by 2002:a25:d4cc:0:b0:db9:772b:1020 with SMTP id
 m195-20020a25d4cc000000b00db9772b1020mr41355ybf.5.1701710583151; Mon, 04 Dec
 2023 09:23:03 -0800 (PST)
Date:   Tue,  5 Dec 2023 01:22:47 +0800
In-Reply-To: <20231204172247.1087152-1-kyletso@google.com>
Mime-Version: 1.0
References: <20231204172247.1087152-1-kyletso@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204172247.1087152-3-kyletso@google.com>
Subject: [PATCH v4 2/2] usb: typec: tcpm: Support multiple capabilities
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor tcpm_fw_get_caps to support the multiple pd capabilities got
from fwnode. For backward compatibility, the original single capability
is still applicable. The fetched data is stored in the newly defined
structure "pd_data" and there is an array "pd_list" to store the
pointers to them. A dedicated array "pds" is used to store the handles
of the registered usb_power_delivery instances.

Also implement the .pd_get and .pd_set ops which are introduced in
commit a7cff92f0635 ("usb: typec: USB Power Delivery helpers for ports
and partners"). Once the .pd_set is called, the current capability will
be updated and state machine will re-negotiate the power contract if
possible.

Signed-off-by: Kyle Tso <kyletso@google.com>
---
v3 -> v4
 - no change

drivers/usb/typec/tcpm/tcpm.c | 389 ++++++++++++++++++++++++++--------
 1 file changed, 303 insertions(+), 86 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 50cbc52386b3..9c8d7317f8b9 100644
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
@@ -6045,12 +6057,114 @@ static int tcpm_port_type_set(struct typec_port *p, enum typec_port_type type)
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
+	if (IS_ERR(data)) {
+		ret = PTR_ERR(data);
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
@@ -6064,58 +6178,63 @@ EXPORT_SYMBOL_GPL(tcpm_tcpc_reset);
 
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
+		usb_power_delivery_unregister_capabilities(port->pd_list[i]->sink_cap);
+		kfree(port->pd_list[i]->sink_cap);
+		usb_power_delivery_unregister_capabilities(port->pd_list[i]->source_cap);
+		kfree(port->pd_list[i]->source_cap);
+		devm_kfree(port->dev, port->pd_list[i]);
+		port->pd_list[i] = NULL;
+		usb_power_delivery_unregister(port->pds[i]);
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
@@ -6124,12 +6243,11 @@ static int tcpm_port_register_pd(struct tcpm_port *port)
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
@@ -6149,28 +6267,10 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 
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
@@ -6180,43 +6280,156 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 		port->src_rp = tcpm_pwr_opmode_to_rp(ret);
 	}
 
-	if (port->port_type == TYPEC_PORT_SRC)
-		return 0;
+	/* FRS can only be supported by DRP ports */
+	if (port->port_type == TYPEC_PORT_DRP) {
+		ret = fwnode_property_read_u32(fwnode, "new-source-frs-typec-current",
+					       &frs_current);
+		if (!ret && frs_current <= FRS_5V_3A)
+			port->new_source_frs_current = frs_current;
+	}
 
-sink:
-	port->self_powered = fwnode_property_read_bool(fwnode, "self-powered");
+	return 0;
+}
+
+static int tcpm_fw_get_caps(struct tcpm_port *port, struct fwnode_handle *fwnode)
+{
+	struct fwnode_handle *capabilities, *child, *caps = NULL;
+	unsigned int nr_src_pdo, nr_snk_pdo;
+	u32 *src_pdo, *snk_pdo;
+	u32 uw;
+	int ret = 0, i;
 
 	if (!port->pd_supported)
 		return 0;
 
-	/* Get sink pdos */
-	ret = fwnode_property_count_u32(fwnode, "sink-pdos");
-	if (ret <= 0)
-		return -EINVAL;
+	/* For the backward compatibility, "capabilities" node is optional. */
+	capabilities = fwnode_get_named_child_node(fwnode, "capabilities");
+	if (!capabilities) {
+		port->pd_count = 1;
+	} else {
+		fwnode_for_each_child_node(capabilities, child)
+			port->pd_count++;
 
-	port->nr_snk_pdo = min(ret, PDO_MAX_OBJECTS);
-	ret = fwnode_property_read_u32_array(fwnode, "sink-pdos",
-					     port->snk_pdo, port->nr_snk_pdo);
-	if ((ret < 0) || tcpm_validate_caps(port, port->snk_pdo,
-					    port->nr_snk_pdo))
-		return -EINVAL;
+		if (!port->pd_count) {
+			ret = -ENODATA;
+			goto put_capabilities;
+		}
+	}
 
-	if (fwnode_property_read_u32(fwnode, "op-sink-microwatt", &mw) < 0)
-		return -EINVAL;
-	port->operating_snk_mw = mw / 1000;
+	port->pds = devm_kcalloc(port->dev, port->pd_count, sizeof(struct usb_power_delivery *),
+				 GFP_KERNEL);
+	if (!port->pds) {
+		ret = -ENOMEM;
+		goto put_capabilities;
+	}
 
-	/* FRS can only be supported by DRP ports */
-	if (port->port_type == TYPEC_PORT_DRP) {
-		ret = fwnode_property_read_u32(fwnode, "new-source-frs-typec-current",
-					       &frs_current);
-		if (ret >= 0 && frs_current <= FRS_5V_3A)
-			port->new_source_frs_current = frs_current;
+	port->pd_list = devm_kcalloc(port->dev, port->pd_count, sizeof(struct pd_data *),
+				     GFP_KERNEL);
+	if (!port->pd_list) {
+		ret = -ENOMEM;
+		goto put_capabilities;
 	}
 
+	for (i = 0; i < port->pd_count; i++) {
+		port->pd_list[i] = devm_kzalloc(port->dev, sizeof(struct pd_data), GFP_KERNEL);
+		if (!port->pd_list[i]) {
+			ret = -ENOMEM;
+			goto put_capabilities;
+		}
+
+		src_pdo = port->pd_list[i]->source_desc.pdo;
+		port->pd_list[i]->source_desc.role = TYPEC_SOURCE;
+		snk_pdo = port->pd_list[i]->sink_desc.pdo;
+		port->pd_list[i]->sink_desc.role = TYPEC_SINK;
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
+				goto put_caps;
+			}
+			if (ret < 0)
+				goto put_caps;
+
+			nr_src_pdo = min(ret, PDO_MAX_OBJECTS);
+			ret = fwnode_property_read_u32_array(caps, "source-pdos", src_pdo,
+							     nr_src_pdo);
+			if (ret)
+				goto put_caps;
+
+			ret = tcpm_validate_caps(port, src_pdo, nr_src_pdo);
+			if (ret)
+				goto put_caps;
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
+				goto put_caps;
+			}
+
+			if (ret < 0)
+				goto put_caps;
+
+			nr_snk_pdo = min(ret, PDO_MAX_OBJECTS);
+			ret = fwnode_property_read_u32_array(caps, "sink-pdos", snk_pdo,
+							     nr_snk_pdo);
+			if (ret)
+				goto put_caps;
+
+			ret = tcpm_validate_caps(port, snk_pdo, nr_snk_pdo);
+			if (ret)
+				goto put_caps;
+
+			if (fwnode_property_read_u32(caps, "op-sink-microwatt", &uw) < 0) {
+				ret = -EINVAL;
+				goto put_caps;
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
+	}
+
+put_caps:
+	if (caps != fwnode)
+		fwnode_handle_put(caps);
+put_capabilities:
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
@@ -6581,13 +6794,18 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
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
@@ -6596,7 +6814,6 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	port->typec_caps.orientation_aware = 1;
 
 	port->partner_desc.identity = &port->partner_ident;
-	port->port_type = port->typec_caps.type;
 
 	port->role_sw = usb_role_switch_get(port->dev);
 	if (!port->role_sw)
@@ -6615,7 +6832,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	if (err)
 		goto out_role_sw_put;
 
-	port->typec_caps.pd = port->pd;
+	port->typec_caps.pd = port->pds[0];
 
 	port->typec_port = typec_register_port(port->dev, &port->typec_caps);
 	if (IS_ERR(port->typec_port)) {
-- 
2.43.0.rc2.451.g8631bc7472-goog

