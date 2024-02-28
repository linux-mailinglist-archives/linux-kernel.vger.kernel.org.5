Return-Path: <linux-kernel+bounces-85768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D72B786BA7F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 077F51C22417
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F0872911;
	Wed, 28 Feb 2024 22:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T0RTPi+U"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32801361B2
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 22:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709157825; cv=none; b=rwPikMHYShohsm2SGUQ5bC0yltNSN60Wn3rCYOTL668E9MHRmKpcaTOP0JlapFGd5kyPBsnFj94/ijgyXxFDrqd6depWwEaKmDl3QhpQJWCUR5mHV0RYubVYotVxBqlMC+CGPNUuqamaf1EA+wWeZFqiY0ZUgYzvS9shUljfck4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709157825; c=relaxed/simple;
	bh=ryVPktQRnYCrMHD3Ujbd8hCR3CnuJmpQVQb/Vo2KVQE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GKL6JYUv0fLQQmnfpQWhowK2iF8KRQ0WGuF/ovWoU2OxhWYZC0YLoLK5bA/Lkx740GxRRv228iJIn8M/rHCtrE5spM7xYFRvYmFpthAx48znPYPeDhbVlEeTmamPDJ6rb3tBxBbAsAr1u+SmqW+HFpK+/YYpIbA2eLf+wP5hnhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T0RTPi+U; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60802b0afd2so2670007b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709157823; x=1709762623; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yFg4YW/Z3HZfFTzuAYbv+SLduBl2JOv/FXcutS6mDuE=;
        b=T0RTPi+UEGCOI1/7M8mLrEcVq5UTpoilBoa96pK7u50SFnP8a9FQ3pKeV21lW3lq3L
         T4TIYMRvutkN4M7dxhowx77zS1EY/xytitgVUS0dIJC2jD6peeNJyJdO0arLcv8UNXrQ
         DyqMhc8BTLQtPZ2u8yA7GnPtZFBHpr87kSedxDVyNQrl0TUz+t/Pd3M4Uvhc+w1XSLSc
         UYD8fM7gqbdmpuZhxfkjCoRrQZr9kVGFVpM3XBuMLpsOLhaK74hYBWospbf+JRC7pVPH
         M4YQKSlidhfOjKNcbAhXmUphxf+aW1aaz0vbESoTXQRQUqy7oBfvj3TFwm/dTCa6RhjZ
         66lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709157823; x=1709762623;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yFg4YW/Z3HZfFTzuAYbv+SLduBl2JOv/FXcutS6mDuE=;
        b=L98/lOb5ykBPSBJc2es/O+gUgRgLowrOtFPTP5YS/lTBKfGxso9ebaUDsZZwZ9IAOm
         52MzxkpmTQD+xYyQunvcUtf3vs5wxrEvsRvY/WYaUZPlSGLMgnVGKE6/Cm9QY5UGLuIR
         he4FUsRKb44/TJsR7hpP/YyxvWHY5kBvg6rHq06ip1aLY21BPwiZBkw/iY3IdD3tY1A1
         RgEgC/VBrmJwKGUAuS6wJbS5iJA8EIYIdrBUF+7sKrjKWQ+q/YXDN+6YQIcg1FPih3uq
         5XzRiajRfHrym4XYH0lYBN5gf7gXTT1LxXXZ7Asg/051r7P9Ej2YPIWPZsKzLjWLkiyM
         fVbw==
X-Forwarded-Encrypted: i=1; AJvYcCV2Qj2G4kwC3tdS5iWX3/ksJZ0iXCu7+vUh+NPane1V+V6jVS2PvGVsBZJlq7UXdtkGlHKKjsog5usnhPXGDr08rXRDGJ+7qa+PF2n1
X-Gm-Message-State: AOJu0YynoanMakNBPuCs23k+hJoSETJ9Tb6sW/y5KV1pn5AcgC3YBz9m
	VfmJbj/HzXhUdpgM34rsHdqOMFh+wAM7Sw742/2m3A2WxbeH4OyZwGO5Jms8vch3qk6WkO0yFbh
	fQw==
X-Google-Smtp-Source: AGHT+IH3gXdkNlGOCUOpQn9NRG+QodN+v1KpsdgX7hK/n1lG8ZbyY5XCY/TKkiNrtNGu6ZUG5H0TZT9YIp8=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a05:690c:5:b0:609:3a33:bacc with SMTP id
 bc5-20020a05690c000500b006093a33baccmr2310ywb.5.1709157822956; Wed, 28 Feb
 2024 14:03:42 -0800 (PST)
Date: Wed, 28 Feb 2024 22:03:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240228220339.3613870-1-jthies@google.com>
Subject: [PATCH v2 2/4] usb: typec: ucsi: Register cables based on GET_CABLE_PROPERTY
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: jthies@google.com, pmalani@chromium.org, bleung@google.com, 
	abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Register cables with the Type-C Connector Class in the UCSI driver based
on the PPM response to GET_CABLE_PROPERTY. Registered cable properties
include plug type, cable type and major revision.

Reviewed-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Jameson Thies <jthies@google.com>
---
Expected cable properties populate the USB Type-C connector class sysfs
paths:
nospike-rev4 /sys/class/typec # ls port0-cable
device  identity  plug_type  port0-plug0  power  subsystem  type  uevent
usb_power_delivery_revision

Changes in v2:
- Shortened lines to within 80 characters.
- Tested on usb-testing branch merged with chromeOS 6.8-rc2 kernel.

 drivers/usb/typec/ucsi/ucsi.c | 73 +++++++++++++++++++++++++++++++++++
 drivers/usb/typec/ucsi/ucsi.h |  5 +++
 2 files changed, 78 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index ae105383e69e7..7c84687b5d1a3 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -734,6 +734,52 @@ static void ucsi_unregister_partner_pdos(struct ucsi_connector *con)
 	con->partner_pd = NULL;
 }
 
+static int ucsi_register_cable(struct ucsi_connector *con)
+{
+	struct typec_cable *cable;
+	struct typec_cable_desc desc = {};
+
+	switch (UCSI_CABLE_PROP_FLAG_PLUG_TYPE(con->cable_prop.flags)) {
+	case UCSI_CABLE_PROPERTY_PLUG_TYPE_A:
+		desc.type = USB_PLUG_TYPE_A;
+		break;
+	case UCSI_CABLE_PROPERTY_PLUG_TYPE_B:
+		desc.type = USB_PLUG_TYPE_B;
+		break;
+	case UCSI_CABLE_PROPERTY_PLUG_TYPE_C:
+		desc.type = USB_PLUG_TYPE_C;
+		break;
+	default:
+		desc.type = USB_PLUG_NONE;
+		break;
+	}
+
+	desc.active = !!(UCSI_CABLE_PROP_FLAG_ACTIVE_CABLE &
+			 con->cable_prop.flags);
+	desc.pd_revision = UCSI_CABLE_PROP_FLAG_PD_MAJOR_REV_AS_BCD(
+	    con->cable_prop.flags);
+
+	cable = typec_register_cable(con->port, &desc);
+	if (IS_ERR(cable)) {
+		dev_err(con->ucsi->dev,
+			"con%d: failed to register cable (%ld)\n", con->num,
+			PTR_ERR(cable));
+		return PTR_ERR(cable);
+	}
+
+	con->cable = cable;
+	return 0;
+}
+
+static void ucsi_unregister_cable(struct ucsi_connector *con)
+{
+	if (!con->cable)
+		return;
+
+	typec_unregister_cable(con->cable);
+	con->cable = NULL;
+}
+
 static void ucsi_pwr_opmode_change(struct ucsi_connector *con)
 {
 	switch (UCSI_CONSTAT_PWR_OPMODE(con->status.flags)) {
@@ -807,6 +853,7 @@ static void ucsi_unregister_partner(struct ucsi_connector *con)
 	typec_partner_set_usb_power_delivery(con->partner, NULL);
 	ucsi_unregister_partner_pdos(con);
 	ucsi_unregister_altmodes(con, UCSI_RECIPIENT_SOP);
+	ucsi_unregister_cable(con);
 	typec_unregister_partner(con->partner);
 	con->partner = NULL;
 }
@@ -907,6 +954,30 @@ static int ucsi_check_connection(struct ucsi_connector *con)
 	return 0;
 }
 
+static int ucsi_check_cable(struct ucsi_connector *con)
+{
+	u64 command;
+	int ret;
+
+	if (con->cable)
+		return 0;
+
+	command = UCSI_GET_CABLE_PROPERTY | UCSI_CONNECTOR_NUMBER(con->num);
+	ret = ucsi_send_command(con->ucsi, command, &con->cable_prop,
+				sizeof(con->cable_prop));
+	if (ret < 0) {
+		dev_err(con->ucsi->dev, "GET_CABLE_PROPERTY failed (%d)\n",
+			ret);
+		return ret;
+	}
+
+	ret = ucsi_register_cable(con);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static void ucsi_handle_connector_change(struct work_struct *work)
 {
 	struct ucsi_connector *con = container_of(work, struct ucsi_connector,
@@ -948,6 +1019,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 			ucsi_register_partner(con);
 			ucsi_partner_task(con, ucsi_check_connection, 1, HZ);
 			ucsi_partner_task(con, ucsi_check_connector_capability, 1, HZ);
+			ucsi_partner_task(con, ucsi_check_cable, 1, HZ);
 
 			if (UCSI_CONSTAT_PWR_OPMODE(con->status.flags) ==
 			    UCSI_CONSTAT_PWR_OPMODE_PD)
@@ -1346,6 +1418,7 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
 		ucsi_register_partner(con);
 		ucsi_pwr_opmode_change(con);
 		ucsi_port_psy_changed(con);
+		ucsi_check_cable(con);
 	}
 
 	/* Only notify USB controller if partner supports USB data */
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 469a2baf472e4..f0aabef0b7c64 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -265,6 +265,9 @@ struct ucsi_cable_property {
 #define   UCSI_CABLE_PROPERTY_PLUG_TYPE_C	2
 #define   UCSI_CABLE_PROPERTY_PLUG_OTHER	3
 #define UCSI_CABLE_PROP_FLAG_MODE_SUPPORT	BIT(5)
+#define UCSI_CABLE_PROP_FLAG_PD_MAJOR_REV(_f_)	(((_f_) & GENMASK(7, 6)) >> 6)
+#define UCSI_CABLE_PROP_FLAG_PD_MAJOR_REV_AS_BCD(_f_) \
+	UCSI_SPEC_REVISION_TO_BCD(UCSI_CABLE_PROP_FLAG_PD_MAJOR_REV(_f_))
 	u8 latency;
 } __packed;
 
@@ -400,6 +403,7 @@ struct ucsi_connector {
 
 	struct typec_port *port;
 	struct typec_partner *partner;
+	struct typec_cable *cable;
 
 	struct typec_altmode *port_altmode[UCSI_MAX_ALTMODES];
 	struct typec_altmode *partner_altmode[UCSI_MAX_ALTMODES];
@@ -408,6 +412,7 @@ struct ucsi_connector {
 
 	struct ucsi_connector_status status;
 	struct ucsi_connector_capability cap;
+	struct ucsi_cable_property cable_prop;
 	struct power_supply *psy;
 	struct power_supply_desc psy_desc;
 	u32 rdo;
-- 
2.44.0.rc1.240.g4c46232300-goog


