Return-Path: <linux-kernel+bounces-86017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FCD86BE95
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEAE61F24443
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD0E364AC;
	Thu, 29 Feb 2024 01:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DMfgPJ6G"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5138736B11
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709171637; cv=none; b=GP/03Wr9jpG78iKrh3EGu6rfvYWSzwvVVcMAEPHif+hPW/r4uM9Jut5aTKwgOIxdhNUa3Vha8SpG8KyJqvgASCarSmn7FaMcHTdEBDJv13Kd16Kwl6iV8vlLGMgH6rzrRI2PY9yMpaHGte/kC1iFSf9gMRBB22ltbusMhBvX5r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709171637; c=relaxed/simple;
	bh=edGmOSoQMVD2u38yE1yMurpWdztdrOqPIpxnPb19KFM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Zmk+wo47bjY10fNcecDv9a0O+NUBYdAUHo46NNbukBQCOnZLs3VXXQQ1XFBZt+qjc5kWGQpCaAmpY5Uid43uvwp4K1y5xaAYBVe1By6CffAeOQDuDNLsdtwdUNamkiqXVNYWbIYrJPOuofEUXcg8aB4MIQ1uLNCEt6y83kNsV14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DMfgPJ6G; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608d6ffc64eso6118577b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709171634; x=1709776434; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R6EX1C7KAOXRIXYaHKuIEyWBFy8Yv7CZZQhI1NgZXIY=;
        b=DMfgPJ6G1O2Glc6Tw8flM60YWsytFgnGCn7wZz7Fo0UNj4khvSqeek9eRUZ7et78Zn
         y+PQnKcfAL+6PauzQhPhnfEFcwJI3+eHyoG3tpj/sfZvLP9ZWSonN2Bxjc1Cf4warL6h
         6ZTNsmuL2xiRMzZQbSRJYbqRMjI62yMe54p6v++m8eVya/xxTHjJV5P8D/SObpTFWU40
         u6K6uOWWkxPoMfX6n3h5VmXSRdb5Wly95G6Xs9dsIW1ahkpJRPDRk8uiebsAOElKw8gG
         Nf1yoPKKSR2Bv4KMNOq7YmXWEgUErQrG/7U2oZGk3PHxYpVz5pGpmzg9jM4FiPhRpCYy
         VhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709171634; x=1709776434;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R6EX1C7KAOXRIXYaHKuIEyWBFy8Yv7CZZQhI1NgZXIY=;
        b=ErcEKbBqPNNJq43lGlMdEaiWhbnfoevldaUnrvhCt+BINtfowVsW/mZ/kkqN+8skc9
         ieMbvkM7D8KEteTWgVBtdnyXFu3WJ46MdRyu3o5RL19DsLkp2vheTeBeFSFPMoBHKCCF
         6P18/A4tJ2J0jLiCHGHcWKaJ1rItAw1Y9xZ4HX7joCDboW8yYcUa1KDBtodglnAMMPlR
         uZFU7VbKDMQUJT+3J7vrFmHR3NHuDJSEiXHffWBbvElyZOq/4MmTA0HwhwIouJjKo92S
         c6RGZaADhlapd3XT3PRuWdYQZHM2v/1ODBjiOGSXpqRIcaS3Set5tuOR2pFirxl1qNbJ
         +GMA==
X-Forwarded-Encrypted: i=1; AJvYcCVnAhDisOOXaa0UM61Ot2mNb7Os8Tmq2rGSjWVl8RdZrnatSIIE+vU/YiJwc0W1in8OaSNH/LKrC/oB0jWDZQWHa+82pHQ+o1klOSXc
X-Gm-Message-State: AOJu0Yyki5UlESip8GDryqM7H3wsA0H4jkt6RCvbIbSXwgfDnpBTQPgb
	jHGShvUyoWGOKDfHxTnGsXW/VfWmaHTlkupvv9W53F06R+f4qP6OYj7HVW4lfEXvlqcfTD24UHs
	7KA==
X-Google-Smtp-Source: AGHT+IETW61PxGfv5voanPhWczfn38GrSF3/b+XsG4sMgFRu/sjE0mYmgEFqdbwNz9wPq/BHDQWjJMFYG7Q=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a0d:c346:0:b0:609:3a1f:e852 with SMTP id
 f67-20020a0dc346000000b006093a1fe852mr85473ywd.2.1709171634369; Wed, 28 Feb
 2024 17:53:54 -0800 (PST)
Date: Thu, 29 Feb 2024 01:53:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240229015347.3670266-1-jthies@google.com>
Subject: [PATCH v3 3/4] usb: typec: ucsi: Register SOP/SOP' Discover Identity Responses
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

 drivers/usb/typec/ucsi/ucsi.c | 125 ++++++++++++++++++++++++++++++++++
 drivers/usb/typec/ucsi/ucsi.h |  29 ++++++++
 2 files changed, 154 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 7c84687b5d1a3..4088422b33c74 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -646,6 +646,121 @@ static int ucsi_get_src_pdos(struct ucsi_connector *con)
 	return ret;
 }
 
+static int ucsi_read_identity(struct ucsi_connector *con, u8 recipient,
+			      struct usb_pd_identity *id)
+{
+	struct ucsi *ucsi = con->ucsi;
+	struct ucsi_pd_message_disc_id resp = {};
+	u64 command;
+	int ret;
+
+	if (ucsi->version < UCSI_VERSION_2_0) {
+		/*
+		 * Before UCSI v2.0, MESSAGE_IN is 16 bytes which cannot fit
+		 * the 28 byte identity response including the VDM header.
+		 * First request the VDM header, ID Header VDO, Cert Stat VDO
+		 * and Product VDO.
+		 */
+		command = UCSI_COMMAND(UCSI_GET_PD_MESSAGE) |
+		    UCSI_CONNECTOR_NUMBER(con->num);
+		command |= UCSI_GET_PD_MESSAGE_RECIPIENT(recipient);
+		command |= UCSI_GET_PD_MESSAGE_OFFSET(0);
+		command |= UCSI_GET_PD_MESSAGE_BYTES(0x10);
+		command |= UCSI_GET_PD_MESSAGE_TYPE(
+		    UCSI_GET_PD_MESSAGE_TYPE_IDENTITY);
+
+		ret = ucsi_send_command(ucsi, command, &resp, 0x10);
+		if (ret < 0) {
+			dev_err(ucsi->dev,
+				"UCSI_GET_PD_MESSAGE v1.2 failed first request (%d)\n",
+				ret);
+			return ret;
+		}
+
+		/* Then request Product Type VDO1 through Product Type VDO3. */
+		command = UCSI_COMMAND(UCSI_GET_PD_MESSAGE) |
+		    UCSI_CONNECTOR_NUMBER(con->num);
+		command |= UCSI_GET_PD_MESSAGE_RECIPIENT(recipient);
+		command |= UCSI_GET_PD_MESSAGE_OFFSET(0x10);
+		command |= UCSI_GET_PD_MESSAGE_BYTES(0xc);
+		command |= UCSI_GET_PD_MESSAGE_TYPE(
+		    UCSI_GET_PD_MESSAGE_TYPE_IDENTITY);
+
+		ret = ucsi_send_command(ucsi, command, &resp.vdo[0], 0xc);
+		if (ret < 0) {
+			dev_err(ucsi->dev,
+				"UCSI_GET_PD_MESSAGE v1.2 failed second request (%d)\n",
+				ret);
+			return ret;
+		}
+	} else {
+		/*
+		 * In UCSI v2.0 and after, MESSAGE_IN is large enough to request
+		 * the large enough to request the full Discover Identity
+		 * response at once.
+		 */
+		command = UCSI_COMMAND(UCSI_GET_PD_MESSAGE) |
+		    UCSI_CONNECTOR_NUMBER(con->num);
+		command |= UCSI_GET_PD_MESSAGE_RECIPIENT(recipient);
+		/* VDM Header + 6 VDOs (0x1c bytes) without an offset */
+		command |= UCSI_GET_PD_MESSAGE_OFFSET(0);
+		command |= UCSI_GET_PD_MESSAGE_BYTES(0x1c);
+		command |= UCSI_GET_PD_MESSAGE_TYPE(
+		    UCSI_GET_PD_MESSAGE_TYPE_IDENTITY);
+
+		ret = ucsi_send_command(ucsi, command, &resp, sizeof(resp));
+		if (ret < 0) {
+			dev_err(ucsi->dev, "UCSI_GET_PD_MESSAGE failed (%d)\n",
+				ret);
+			return ret;
+		}
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
+	ret = ucsi_read_identity(con, UCSI_RECIPIENT_SOP,
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
+	ret = ucsi_read_identity(con, UCSI_RECIPIENT_SOP_P,
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
@@ -754,6 +869,7 @@ static int ucsi_register_cable(struct ucsi_connector *con)
 		break;
 	}
 
+	desc.identity = &con->cable_identity;
 	desc.active = !!(UCSI_CABLE_PROP_FLAG_ACTIVE_CABLE &
 			 con->cable_prop.flags);
 	desc.pd_revision = UCSI_CABLE_PROP_FLAG_PD_MAJOR_REV_AS_BCD(
@@ -777,6 +893,7 @@ static void ucsi_unregister_cable(struct ucsi_connector *con)
 		return;
 
 	typec_unregister_cable(con->cable);
+	memset(&con->cable_identity, 0, sizeof(con->cable_identity));
 	con->cable = NULL;
 }
 
@@ -827,6 +944,7 @@ static int ucsi_register_partner(struct ucsi_connector *con)
 		break;
 	}
 
+	desc.identity = &con->partner_identity;
 	desc.usb_pd = pwr_opmode == UCSI_CONSTAT_PWR_OPMODE_PD;
 	desc.pd_revision = UCSI_CONCAP_FLAG_PARTNER_PD_MAJOR_REV_AS_BCD(con->cap.flags);
 
@@ -855,6 +973,7 @@ static void ucsi_unregister_partner(struct ucsi_connector *con)
 	ucsi_unregister_altmodes(con, UCSI_RECIPIENT_SOP);
 	ucsi_unregister_cable(con);
 	typec_unregister_partner(con->partner);
+	memset(&con->partner_identity, 0, sizeof(con->partner_identity));
 	con->partner = NULL;
 }
 
@@ -975,6 +1094,10 @@ static int ucsi_check_cable(struct ucsi_connector *con)
 	if (ret < 0)
 		return ret;
 
+	ret = ucsi_get_cable_identity(con);
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
 
@@ -1019,6 +1142,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 			ucsi_register_partner(con);
 			ucsi_partner_task(con, ucsi_check_connection, 1, HZ);
 			ucsi_partner_task(con, ucsi_check_connector_capability, 1, HZ);
+			ucsi_partner_task(con, ucsi_get_partner_identity, 1, HZ);
 			ucsi_partner_task(con, ucsi_check_cable, 1, HZ);
 
 			if (UCSI_CONSTAT_PWR_OPMODE(con->status.flags) ==
@@ -1418,6 +1542,7 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
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


