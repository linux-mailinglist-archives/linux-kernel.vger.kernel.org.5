Return-Path: <linux-kernel+bounces-77603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9D78607FB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E035D1C21051
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEC6E57B;
	Fri, 23 Feb 2024 01:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4sMjwBCN"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F5DC2FE
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708650300; cv=none; b=jqAxQ6aQ0lUhAIvr19md3QnjQVY8of3eUzReCh9Jt7h6BEf6ufD3ERyu/i/IQUnnLHwzk6adbQC3KOUK3kY1oIrN1t8ozdVGIamvF7oGn4bCgEmtLioxMflfoILJJPqBuKWzu9FzaMzD0k47d80Cw2U8V0nCq5Mp1XJw6+cUn0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708650300; c=relaxed/simple;
	bh=djqlNsa6R1dXZ3viePd2hZAocsyo8u3alB6TS2xk+fc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CXr46ThMOCyobZ1xFdSofCNOsjjANteA0TXH5f0zF+pXwuHrzKSK0GJW/5GvNRtO+3CEzhMKsiALl9f6EvXi/NjoVUahxILcK3AHvf4to9LJHqCFwzWWOWjWG0vDNai871q4mvSrXqhirDJM0o8MSE3OGTL/jo2hIsS+GE86+Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4sMjwBCN; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc693399655so566203276.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 17:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708650298; x=1709255098; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E/AmGDcfgM6pSbOLU88NIVIJmr/j1xj0yT5Nk8P+cUw=;
        b=4sMjwBCNo0/XmVxDVMWcjH0FcjZEvOB41tz9wHgC6JnxS3h11SGPl8vG9ApY0VYZxD
         wNN33XUemgWAais5SeIu0iqzcNM9hAJIN15FY5/unPgbaogqIqtkyIHh0Mbb6Q6aqxQw
         PWlYOllzTzpKzB1UJL8WpYliN7tUbKPH0B9QxUVx1C/KEsK+Peo0ubb/fqnJMVlx3FQ7
         JLi558JE0NvoXxWqKmheq47q+fRjNrshO+0A7/kZQ4omu9eHlWFgkCnVnJtieRnHdTU3
         sInSmaZpjIilfe2j2jR9I9VSPjMpgGvbrevMFJ/HXLg8Yqc7NHfKImMgATGfMn+ztP0V
         uLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708650298; x=1709255098;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/AmGDcfgM6pSbOLU88NIVIJmr/j1xj0yT5Nk8P+cUw=;
        b=oY+gzo/lHOvxBEjEGImwkGnlrujo4l4LsQ3QWro7gDFDuETDG3k2OzYSo5yhNRf5pZ
         ExoDvUtSAX9+K5Csnq5QZUb2Tr+7uRPljrsUJwfi42ZOHqxNtbbnveD3FFmJsB9JTGMi
         V2VpDttNckBZOLntbxSs4aZrfxAFH5NLNhgrWvawYD1mXw/LHs/vCioYaxusBIX4l3+m
         iqsrUPtKSZnP6sAQbQLD9aL9f9F+p0bjPDCQpCv10m6WXzP1vGIV5aaJbnfC+8K/rpfq
         akKLrx4abBJuX/gCzaJbzouIyWfTGuAP9QJatUhHdgk9ZST80R6xmFiqgwzOMRWHq5U1
         e1tQ==
X-Forwarded-Encrypted: i=1; AJvYcCULcjfDfaX2CfEnHsUDdMhxNNUNU8Ts04xpLSYSJiX2jgM1/vFWpJ1e15wT4ASlRokXoCwCY+qlHD4YSz0d0fl9Zxnms/39OuDmCFRz
X-Gm-Message-State: AOJu0YyDeodFYnq+k6NBg9E2Rij3dttU1Vb1hL0cXKo4jZNg3re7IDih
	NiLvQVSe6f62KqiKj4qfFhCWumZufkI4cyYLyoFcmsV/BELiZd40S8idmc2LWWU1JX0WQ2GoHNk
	GmA==
X-Google-Smtp-Source: AGHT+IE8KW+BV9Skf2PKiid4kOdLJB1IdEed7ZYX9DP0T1HouM2WC9WweAYs0HoDiJweNFtH83AFQh8xe9g=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a25:160b:0:b0:dc7:7ce9:fb4d with SMTP id
 11-20020a25160b000000b00dc77ce9fb4dmr198675ybw.12.1708650297856; Thu, 22 Feb
 2024 17:04:57 -0800 (PST)
Date: Fri, 23 Feb 2024 01:03:27 +0000
In-Reply-To: <20240223010328.2826774-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240223010328.2826774-1-jthies@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240223010328.2826774-4-jthies@google.com>
Subject: [PATCH 3/4] usb: typec: ucsi: Register SOP/SOP' Discover Identity Responses
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: jthies@google.com, pmalani@chromium.org, bleung@google.com, 
	abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Register SOP and SOP' Discover Identity responses with the USB Type-C
Connector Class as partner and cable identities, respectively. Discover
Identity responses are requested from the PPM using the GET_PD_MESSAGE
UCSI command.

Signed-off-by: Jameson Thies <jthies@google.com>
---
Tested on v6.6 kernel. GET_PD_MESSAGE responses from the PPM populate
partner and cable identity in sysfs.
redrix-rev3 /sys/class/typec # ls port2-partner/identity/
cert_stat  id_header  product  product_type_vdo1  product_type_vdo2
product_type_vdo3
redrix-rev3 /sys/class/typec # ls port2-cable/identity/
cert_stat  id_header  product  product_type_vdo1  product_type_vdo2
product_type_vdo3

 drivers/usb/typec/ucsi/ucsi.c | 77 +++++++++++++++++++++++++++++++++++
 drivers/usb/typec/ucsi/ucsi.h | 29 +++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 15e82f5fab37..6d6443e61faa 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -646,6 +646,73 @@ static int ucsi_get_src_pdos(struct ucsi_connector *con)
 	return ret;
 }
 
+static int ucsi_read_identity(struct ucsi_connector *con, u8 recipient, struct usb_pd_identity *id)
+{
+	struct ucsi *ucsi = con->ucsi;
+	struct ucsi_pd_message_disc_id resp = {};
+	u64 command;
+	int ret;
+
+	/*
+	 * Skip identity discovery and registration if UCSI version is less than
+	 * v2.0. Before v2.0 MESSAGE_IN is 16 bytes which cannot fit a complete
+	 * 24 byte identity response.
+	 */
+	if (ucsi->version < UCSI_VERSION_2_0)
+		return -EPROTO;
+
+	command = UCSI_COMMAND(UCSI_GET_PD_MESSAGE) | UCSI_CONNECTOR_NUMBER(con->num);
+	command |= UCSI_GET_PD_MESSAGE_RECIPIENT(recipient);
+	/* VDM Header + 6 VDOs (0x1c bytes) without an offset */
+	command |= UCSI_GET_PD_MESSAGE_OFFSET(0);
+	command |= UCSI_GET_PD_MESSAGE_BYTES(0x1c);
+	command |= UCSI_GET_PD_MESSAGE_TYPE(UCSI_GET_PD_MESSAGE_TYPE_IDENTITY);
+
+	ret = ucsi_send_command(ucsi, command, &resp, sizeof(resp));
+	if (ret < 0) {
+		dev_err(ucsi->dev, "UCSI_GET_PD_MESSAGE failed (%d)\n", ret);
+		return ret;
+	}
+
+	id->id_header = resp.id_header;
+	id->cert_stat = resp.cert_stat;
+	id->product = resp.product;
+	id->vdo[0] = resp.vdo[0];
+	id->vdo[1] = resp.vdo[1];
+	id->vdo[2] = resp.vdo[2];
+	return 0;
+}
+
+static int ucsi_get_partner_identity(struct ucsi_connector *con)
+{
+	int ret;
+
+	ret = ucsi_read_identity(con, UCSI_RECIPIENT_SOP, &con->partner_identity);
+	if (ret < 0)
+		return ret;
+
+	ret = typec_partner_set_identity(con->partner);
+	if (ret < 0)
+		dev_err(con->ucsi->dev, "Failed to set partner identity (%d)\n", ret);
+
+	return ret;
+}
+
+static int ucsi_get_cable_identity(struct ucsi_connector *con)
+{
+	int ret;
+
+	ret = ucsi_read_identity(con, UCSI_RECIPIENT_SOP_P, &con->cable_identity);
+	if (ret < 0)
+		return ret;
+
+	ret = typec_cable_set_identity(con->cable);
+	if (ret < 0)
+		dev_err(con->ucsi->dev, "Failed to set cable identity (%d)\n", ret);
+
+	return ret;
+}
+
 static int ucsi_check_altmodes(struct ucsi_connector *con)
 {
 	int ret, num_partner_am;
@@ -754,6 +821,7 @@ static int ucsi_register_cable(struct ucsi_connector *con)
 		break;
 	}
 
+	desc.identity = &con->cable_identity;
 	desc.active = !!(UCSI_CABLE_PROP_FLAG_ACTIVE_CABLE & con->cable_prop.flags);
 	desc.pd_revision = UCSI_CABLE_PROP_FLAG_PD_MAJOR_REV_AS_BCD(con->cable_prop.flags);
 
@@ -776,6 +844,7 @@ static void ucsi_unregister_cable(struct ucsi_connector *con)
 
 	typec_unregister_cable(con->cable);
 	con->cable = NULL;
+	memset(&con->cable_identity, 0, sizeof(con->cable_identity));
 }
 
 static void ucsi_pwr_opmode_change(struct ucsi_connector *con)
@@ -825,6 +894,7 @@ static int ucsi_register_partner(struct ucsi_connector *con)
 		break;
 	}
 
+	desc.identity = &con->partner_identity;
 	desc.usb_pd = pwr_opmode == UCSI_CONSTAT_PWR_OPMODE_PD;
 	desc.pd_revision = UCSI_CONCAP_FLAG_PARTNER_PD_MAJOR_REV_AS_BCD(con->cap.flags);
 
@@ -854,6 +924,7 @@ static void ucsi_unregister_partner(struct ucsi_connector *con)
 	ucsi_unregister_cable(con);
 	typec_unregister_partner(con->partner);
 	con->partner = NULL;
+	memset(&con->partner_identity, 0, sizeof(con->partner_identity));
 }
 
 static void ucsi_partner_change(struct ucsi_connector *con)
@@ -971,6 +1042,10 @@ static int ucsi_check_cable(struct ucsi_connector *con)
 	if (ret < 0)
 		return ret;
 
+	ret = ucsi_get_cable_identity(con);
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
 
@@ -1015,6 +1090,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 			ucsi_register_partner(con);
 			ucsi_partner_task(con, ucsi_check_connection, 1, HZ);
 			ucsi_partner_task(con, ucsi_check_connector_capability, 1, HZ);
+			ucsi_partner_task(con, ucsi_get_partner_identity, 1, HZ);
 			ucsi_partner_task(con, ucsi_check_cable, 1, HZ);
 
 			if (UCSI_CONSTAT_PWR_OPMODE(con->status.flags) ==
@@ -1414,6 +1490,7 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
 		ucsi_register_partner(con);
 		ucsi_pwr_opmode_change(con);
 		ucsi_port_psy_changed(con);
+		ucsi_get_partner_identity(con);
 		ucsi_check_cable(con);
 	}
 
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index f0aabef0b7c6..b89fae82e8ce 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -106,6 +106,7 @@ void ucsi_connector_change(struct ucsi *ucsi, u8 num);
 #define UCSI_GET_CABLE_PROPERTY		0x11
 #define UCSI_GET_CONNECTOR_STATUS	0x12
 #define UCSI_GET_ERROR_STATUS		0x13
+#define UCSI_GET_PD_MESSAGE		0x15
 
 #define UCSI_CONNECTOR_NUMBER(_num_)		((u64)(_num_) << 16)
 #define UCSI_COMMAND(_cmd_)			((_cmd_) & 0xff)
@@ -159,6 +160,18 @@ void ucsi_connector_change(struct ucsi *ucsi, u8 num);
 #define UCSI_MAX_PDOS				(4)
 #define UCSI_GET_PDOS_SRC_PDOS			((u64)1 << 34)
 
+/* GET_PD_MESSAGE command bits */
+#define UCSI_GET_PD_MESSAGE_RECIPIENT(_r_)	((u64)(_r_) << 23)
+#define UCSI_GET_PD_MESSAGE_OFFSET(_r_)		((u64)(_r_) << 26)
+#define UCSI_GET_PD_MESSAGE_BYTES(_r_)		((u64)(_r_) << 34)
+#define UCSI_GET_PD_MESSAGE_TYPE(_r_)		((u64)(_r_) << 42)
+#define   UCSI_GET_PD_MESSAGE_TYPE_SNK_CAP_EXT	0
+#define   UCSI_GET_PD_MESSAGE_TYPE_SRC_CAP_EXT	1
+#define   UCSI_GET_PD_MESSAGE_TYPE_BAT_CAP	2
+#define   UCSI_GET_PD_MESSAGE_TYPE_BAT_STAT	3
+#define   UCSI_GET_PD_MESSAGE_TYPE_IDENTITY	4
+#define   UCSI_GET_PD_MESSAGE_TYPE_REVISION	5
+
 /* -------------------------------------------------------------------------- */
 
 /* Error information returned by PPM in response to GET_ERROR_STATUS command. */
@@ -338,6 +351,18 @@ struct ucsi_connector_status {
 	((get_unaligned_le32(&(_p_)[5]) & GENMASK(16, 1)) >> 1)
 } __packed;
 
+/*
+ * Data structure filled by PPM in response to GET_PD_MESSAGE command with the
+ * Response Message Type set to Discover Identity Response.
+ */
+struct ucsi_pd_message_disc_id {
+	u32 vdm_header;
+	u32 id_header;
+	u32 cert_stat;
+	u32 product;
+	u32 vdo[3];
+} __packed;
+
 /* -------------------------------------------------------------------------- */
 
 struct ucsi_debugfs_entry {
@@ -428,6 +453,10 @@ struct ucsi_connector {
 	struct usb_power_delivery_capabilities *partner_sink_caps;
 
 	struct usb_role_switch *usb_role_sw;
+
+	/* USB PD identity */
+	struct usb_pd_identity partner_identity;
+	struct usb_pd_identity cable_identity;
 };
 
 int ucsi_send_command(struct ucsi *ucsi, u64 command,
-- 
2.44.0.rc0.258.g7320e95886-goog


