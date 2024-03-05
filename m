Return-Path: <linux-kernel+bounces-91592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 552B9871409
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBCEEB20C25
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E0A29CED;
	Tue,  5 Mar 2024 02:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cF2Wejyi"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33F529CE9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 02:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709607547; cv=none; b=FfJdZn4FGlaz8m+80O3YwXXusv0YveZwxpZYNCItC5WKWSplYth/ygGpBMYeIIlJwNhCo7QO7YH2pmioOhlwZRgSPsOPtF43apZxqL3HI0SmmKTkBGblUrVfd1HYkwn3Bc2hhXrbX4dTCIWWUGyN6ZY4NP+md8ApJZt99wLNfYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709607547; c=relaxed/simple;
	bh=8iTRt/ugF4t12jZL9EK+VJTyU9uwz8R1k7TOmI3VIqw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lAX4A/+Hw/MRukkbhbI7q6ITeYGKJoDr0qYjvq5Uigrbsn/ga6oeD1mbVNLT8E9b2CX9cip4AimeJDlb1FWTYk3y7971zdzUzhfwFPDAt2qbVVHLdzEPn0T+A751q1tfcR19h3W9liVtouTvLUxq50hyw7NQapGrYPtB307QHuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cF2Wejyi; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc58cddb50so8927745276.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 18:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709607545; x=1710212345; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PlfabyPBCsArFs95Uhi0iCO9WU5ZlWKeqsmPsHbycmE=;
        b=cF2WejyijmARdlGQ3MtLvM1cok2Gu7tW/6hpb7F0SVQkqJfcnqC5wvQXBEtyw/dpmY
         TYAgi3tj83keQOCLJSTf29AKBJJv8WI1NzMfwK/44tv4xcPu4AatLk2gCHoKSqYfCWa0
         WVLuSPxC1N8ToWx6tSAzsqOC3Q81QrTozgHjmEKer8hew8ITA6IR8Ze+CSNijD6z4Y8o
         DPJmdeMyCjRcZivSHUJbUtl+YyJ8GxxuPQNX3DE/B+/qjuT9I1K2PZdgDGfnLMdyC6ee
         hleWxukzXjDYLVrc+5ajWcwY3s5n3EpMljBt6PuqOtDnhQutmowEj751PBz3XOQDi69C
         b7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709607545; x=1710212345;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PlfabyPBCsArFs95Uhi0iCO9WU5ZlWKeqsmPsHbycmE=;
        b=Kq8BYt45wwHrZkCrGjNkn0yaCfDP1atXlcoPSdx7CjGkOQn1YAiaF82hLtbeev6HlR
         cW/oprPVdVdbQOcH1kvfFh+qWD9Wek12DQEahdoG6gPPaiUzWTZ78FiHoLO5ZaVhMt+G
         ywOOAcx9t0mrajH52c93vhe9TiC8tOPhn6PScsxYKAxMkTCZgDMa/zeSW6viyT21t7Gy
         aS3Xk9OF0/NMv8TQYnTcqPwILUVEXTGFW5GbqB+mUfVgu87E3sTgn48/cQPszqXWm60N
         Lh3OmwQ1BS+m7j6Qy0EfAi/cLef8uTmhl1yOpD+5h9VMTcafN9Ck9BzJ5c2feNP7v7yT
         B0Cw==
X-Forwarded-Encrypted: i=1; AJvYcCVnAKt50TfeCL+g0QsYxEcJGFGso83i0UyCQxUljb90bweyqOD83K1Z5TZWVqT6Y9MfDLKpVW9PnFHuzXHT95wqfFO5MoPlnD8wUqDA
X-Gm-Message-State: AOJu0Yz5YpEXbsB+8Bh/KQcyX9plyCecb80NInIn7w/OJJM3JsYyMqBU
	of1buEbps17MHWRZrajqjVMdGBwgxG3iaG5LPjpXf9pAp/3mdXuCH9UyChTspmWq9PFOjqQv+kn
	Xkg==
X-Google-Smtp-Source: AGHT+IHwj/NP1go51eLld0Go47cxMyVlTIldoEsk6c25SHu9G5gr+Yco47YYtvUoUDoVLsukyGuh+URfS0Y=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a05:6902:724:b0:dcc:5a91:aee9 with SMTP id
 l4-20020a056902072400b00dcc5a91aee9mr2735695ybt.7.1709607545153; Mon, 04 Mar
 2024 18:59:05 -0800 (PST)
Date: Tue,  5 Mar 2024 02:58:03 +0000
In-Reply-To: <20240305025804.1290919-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305025804.1290919-1-jthies@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240305025804.1290919-4-jthies@google.com>
Subject: [PATCH v4 3/4] usb: typec: ucsi: Register SOP/SOP' Discover Identity Responses
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
GET_PD_MESSAGE responses from the PPM populate partner and cable
identity in sysfs:
nospike-rev4 /sys/class/typec # ls port0-partner/identity/
cert_stat  id_header  product  product_type_vdo1  product_type_vdo2
product_type_vdo3
nospike-rev4 /sys/class/typec # ls port0-cable/identity/
cert_stat  id_header  product  product_type_vdo1  product_type_vdo2
product_type_vdo3

Changes in v4:
- Cleaned up redundent ucsi_send_command calls for discovering identity.

Changes in v3:
- None.

Changes in v2:
- Re-ordered memset call and null assignment when unregistering partners
and cables.
- Supports registering partner and cable identity with UCSI versions
before v2.0.
- Shortened lines to within 80 characters with the exception of two
error log lines with three indentations.
- Tested on usb-testing branch merged with chromeOS 6.8-rc2 kernel.

drivers/usb/typec/ucsi/ucsi.c | 112 ++++++++++++++++++++++++++++++++++
 drivers/usb/typec/ucsi/ucsi.h |  29 +++++++++
 2 files changed, 141 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 7c84687b5d1a3..3b64a0f51041c 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -646,6 +646,108 @@ static int ucsi_get_src_pdos(struct ucsi_connector *con)
 	return ret;
 }
 
+static int ucsi_read_identity(struct ucsi_connector *con, u8 recipient,
+			      u8 offset, u8 bytes, void *resp)
+{
+	struct ucsi *ucsi = con->ucsi;
+	u64 command;
+	int ret;
+
+	command = UCSI_COMMAND(UCSI_GET_PD_MESSAGE) |
+	    UCSI_CONNECTOR_NUMBER(con->num);
+	command |= UCSI_GET_PD_MESSAGE_RECIPIENT(recipient);
+	command |= UCSI_GET_PD_MESSAGE_OFFSET(offset);
+	command |= UCSI_GET_PD_MESSAGE_BYTES(bytes);
+	command |= UCSI_GET_PD_MESSAGE_TYPE(UCSI_GET_PD_MESSAGE_TYPE_IDENTITY);
+
+	ret = ucsi_send_command(ucsi, command, resp, bytes);
+	if (ret < 0)
+		dev_err(ucsi->dev, "UCSI_GET_PD_MESSAGE failed (%d)\n", ret);
+
+	return ret;
+}
+
+static int ucsi_get_identity(struct ucsi_connector *con, u8 recipient,
+			      struct usb_pd_identity *id)
+{
+	struct ucsi *ucsi = con->ucsi;
+	struct ucsi_pd_message_disc_id resp = {};
+	int ret;
+
+	if (ucsi->version < UCSI_VERSION_2_0) {
+		/*
+		 * Before UCSI v2.0, MESSAGE_IN is 16 bytes which cannot fit
+		 * the 28 byte identity response including the VDM header.
+		 * First request the VDM header, ID Header VDO, Cert Stat VDO
+		 * and Product VDO.
+		 */
+		ret = ucsi_read_identity(con, recipient, 0, 0x10, &resp);
+		if (ret < 0)
+			return ret;
+
+
+		/* Then request Product Type VDO1 through Product Type VDO3. */
+		ret = ucsi_read_identity(con, recipient, 0x10, 0xc,
+					 &resp.vdo[0]);
+		if (ret < 0)
+			return ret;
+
+	} else {
+		/*
+		 * In UCSI v2.0 and after, MESSAGE_IN is large enough to request
+		 * the large enough to request the full Discover Identity
+		 * response at once.
+		 */
+		ret = ucsi_read_identity(con, recipient, 0x0, 0x1c, &resp);
+		if (ret < 0)
+			return ret;
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
+	ret = ucsi_get_identity(con, UCSI_RECIPIENT_SOP,
+				 &con->partner_identity);
+	if (ret < 0)
+		return ret;
+
+	ret = typec_partner_set_identity(con->partner);
+	if (ret < 0) {
+		dev_err(con->ucsi->dev, "Failed to set partner identity (%d)\n",
+			ret);
+	}
+
+	return ret;
+}
+
+static int ucsi_get_cable_identity(struct ucsi_connector *con)
+{
+	int ret;
+
+	ret = ucsi_get_identity(con, UCSI_RECIPIENT_SOP_P,
+				 &con->cable_identity);
+	if (ret < 0)
+		return ret;
+
+	ret = typec_cable_set_identity(con->cable);
+	if (ret < 0) {
+		dev_err(con->ucsi->dev, "Failed to set cable identity (%d)\n",
+			ret);
+	}
+
+	return ret;
+}
+
 static int ucsi_check_altmodes(struct ucsi_connector *con)
 {
 	int ret, num_partner_am;
@@ -754,6 +856,7 @@ static int ucsi_register_cable(struct ucsi_connector *con)
 		break;
 	}
 
+	desc.identity = &con->cable_identity;
 	desc.active = !!(UCSI_CABLE_PROP_FLAG_ACTIVE_CABLE &
 			 con->cable_prop.flags);
 	desc.pd_revision = UCSI_CABLE_PROP_FLAG_PD_MAJOR_REV_AS_BCD(
@@ -777,6 +880,7 @@ static void ucsi_unregister_cable(struct ucsi_connector *con)
 		return;
 
 	typec_unregister_cable(con->cable);
+	memset(&con->cable_identity, 0, sizeof(con->cable_identity));
 	con->cable = NULL;
 }
 
@@ -827,6 +931,7 @@ static int ucsi_register_partner(struct ucsi_connector *con)
 		break;
 	}
 
+	desc.identity = &con->partner_identity;
 	desc.usb_pd = pwr_opmode == UCSI_CONSTAT_PWR_OPMODE_PD;
 	desc.pd_revision = UCSI_CONCAP_FLAG_PARTNER_PD_MAJOR_REV_AS_BCD(con->cap.flags);
 
@@ -855,6 +960,7 @@ static void ucsi_unregister_partner(struct ucsi_connector *con)
 	ucsi_unregister_altmodes(con, UCSI_RECIPIENT_SOP);
 	ucsi_unregister_cable(con);
 	typec_unregister_partner(con->partner);
+	memset(&con->partner_identity, 0, sizeof(con->partner_identity));
 	con->partner = NULL;
 }
 
@@ -975,6 +1081,10 @@ static int ucsi_check_cable(struct ucsi_connector *con)
 	if (ret < 0)
 		return ret;
 
+	ret = ucsi_get_cable_identity(con);
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
 
@@ -1019,6 +1129,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 			ucsi_register_partner(con);
 			ucsi_partner_task(con, ucsi_check_connection, 1, HZ);
 			ucsi_partner_task(con, ucsi_check_connector_capability, 1, HZ);
+			ucsi_partner_task(con, ucsi_get_partner_identity, 1, HZ);
 			ucsi_partner_task(con, ucsi_check_cable, 1, HZ);
 
 			if (UCSI_CONSTAT_PWR_OPMODE(con->status.flags) ==
@@ -1418,6 +1529,7 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
 		ucsi_register_partner(con);
 		ucsi_pwr_opmode_change(con);
 		ucsi_port_psy_changed(con);
+		ucsi_get_partner_identity(con);
 		ucsi_check_cable(con);
 	}
 
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index f0aabef0b7c64..b89fae82e8ce7 100644
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
2.44.0.rc1.240.g4c46232300-goog


