Return-Path: <linux-kernel+bounces-77602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA268607F9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 958F21F23876
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0CDC14F;
	Fri, 23 Feb 2024 01:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="coZQTzsb"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D0BBA34
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708650297; cv=none; b=qcuf6P0CNIhzkKfKb6nP2Lya+3Zymr0R5538ZE0TP3c85l9Qpvbz+9YjsrQ3nbUhK7zVJyuE02BWIHCakcCl24ooOOosATunjVWcmDkqfadXBusXfYF2xm/SEWcb5YOn6D70WLm/lvsillshUF7gwQJQdubfLz3HX7Q8sNit7Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708650297; c=relaxed/simple;
	bh=AudtEw/bZJ4k+bg0BQXq7THY6fgEi4z3QFF3Hrqxw/o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oUKMO1OGE/pxcV15BmCIkemDoMKEXGwq5KJgGqvY5qgJll2InlT7mqerOXXYojldxXu0TYOkisbkuYMMy86hjVNK3AP9wzso0JGSgZyvTAY3wnNZaQvjctVn5Vkf2gLLUOI0R+z7IRLn/OBMBaTj1864frPlrkF07LKWC4v85iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=coZQTzsb; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5f38d676cecso18874507b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 17:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708650294; x=1709255094; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nQLpgxev/UCFVGLIwR3AMfjodJpmJGMqgmKMEJOc+QI=;
        b=coZQTzsb+j5y6+fDWV/GhQTsnEY2EaDPan0aE8Jd8U3rmuOvbzPhtiX6PZ6knZJWfH
         /7+ZMMWp1YggZW2i8CTzBdZD4VIDFnTlRztMzTq03XfXqf8E9Hy7y4j1ezQxKiqPpEJx
         Y3BsCnW40ugWxbpCf4vVCwcIrSGakvXQjxEq9/lP7DvI7xW4H6l7UX2XbyAEk8fCj6KT
         fFfLDbHLfaAYg9D0T81D/eYT/npOnEsjnkUcYt/KSjSlnUpyanNcPLeXQG7i2c1RgCTk
         POxTnx6E9NONYcaAE2cedOEXaevaUBA5gN0ZC0AIYlii1ARe8tVVpWMPY2P0kG73kfsw
         8m8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708650294; x=1709255094;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nQLpgxev/UCFVGLIwR3AMfjodJpmJGMqgmKMEJOc+QI=;
        b=QSSjz5ERb9W1qNiyobJy2ykpngoVz7WM1oT231Jj/wCgSxuySwFuJwgSjawow0Idkn
         EfyMBT8sa31kRsIDAXdBXfh8naEY7osa3j/m2Bl8xa3/rKANWoviR/lvZW3t7NhjRgJK
         URtk4qtReLKz4W/tHS7ZAOQfmXGOsmgk/bd1mLiwnI3s6nflIutCADnEp4YJWamcITjv
         3mx9iD8dZr4kxREnar0BHbhbX+MzFv0cT1g+rRgvBA6+LoFZbqGc45suwcWjECucg+MG
         /f8sznnE6WRsSvX6ioBUyZaEBEVxyJVg29hHBU99EeUU0OEhce5ylWga9ZMw7/MuxAIK
         6R1A==
X-Forwarded-Encrypted: i=1; AJvYcCV31yZDh7EktQlRmSiqSJDB0eET4KdMGUt1180xig1IqpoEn7Cy8ZRYsCMqhd6IwwpFHmFIrO/pRJtVi8p3kdVjP/R9nV/WTsyjCo5I
X-Gm-Message-State: AOJu0YxDwujM/qoPNrojDr1A8I05TaAJLd4/ctvu3Kb5GRSbLoOPk0av
	/upvq417GGTqPEXS+0IkVFzctBvrjMzCAPDzcB7l7quYnOCDEhH7Y7QCXpv0POok7MyysDoPf9g
	Jsw==
X-Google-Smtp-Source: AGHT+IH7+MqAZARcx1INh7j3pZVkMPgMbKUi15UsYSr52zBlvbI26cjbHg9VKykt97KsPD1Sdu7371KOR2Y=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a25:ab89:0:b0:dc6:e884:2342 with SMTP id
 v9-20020a25ab89000000b00dc6e8842342mr184752ybi.5.1708650294753; Thu, 22 Feb
 2024 17:04:54 -0800 (PST)
Date: Fri, 23 Feb 2024 01:03:26 +0000
In-Reply-To: <20240223010328.2826774-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240223010328.2826774-1-jthies@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240223010328.2826774-3-jthies@google.com>
Subject: [PATCH 2/4] usb: typec: ucsi: Register cables based on GET_CABLE_PROPERTY
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: jthies@google.com, pmalani@chromium.org, bleung@google.com, 
	abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Register cables with the Type-C Connector Class in the UCSI driver based
on the PPM response to GET_CABLE_PROPERTY. Registered cable properties
include plug type, cable type and major revision.

Signed-off-by: Jameson Thies <jthies@google.com>
---
Tested on v6.6 kernel. Expected cable properties populate the USB Type-C
connector class sysfs paths:
redrix-rev3 /sys/class/typec # ls port2-cable
device  identity  plug_type  port2-plug0  power  subsystem  type  uevent
usb_power_delivery_revision

 drivers/usb/typec/ucsi/ucsi.c | 69 +++++++++++++++++++++++++++++++++++
 drivers/usb/typec/ucsi/ucsi.h |  5 +++
 2 files changed, 74 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index ae105383e69e..15e82f5fab37 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -734,6 +734,50 @@ static void ucsi_unregister_partner_pdos(struct ucsi_connector *con)
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
+	desc.active = !!(UCSI_CABLE_PROP_FLAG_ACTIVE_CABLE & con->cable_prop.flags);
+	desc.pd_revision = UCSI_CABLE_PROP_FLAG_PD_MAJOR_REV_AS_BCD(con->cable_prop.flags);
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
@@ -807,6 +851,7 @@ static void ucsi_unregister_partner(struct ucsi_connector *con)
 	typec_partner_set_usb_power_delivery(con->partner, NULL);
 	ucsi_unregister_partner_pdos(con);
 	ucsi_unregister_altmodes(con, UCSI_RECIPIENT_SOP);
+	ucsi_unregister_cable(con);
 	typec_unregister_partner(con->partner);
 	con->partner = NULL;
 }
@@ -907,6 +952,28 @@ static int ucsi_check_connection(struct ucsi_connector *con)
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
+	ret = ucsi_send_command(con->ucsi, command, &con->cable_prop, sizeof(con->cable_prop));
+	if (ret < 0) {
+		dev_err(con->ucsi->dev, "GET_CABLE_PROPERTY failed (%d)\n", ret);
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
@@ -948,6 +1015,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 			ucsi_register_partner(con);
 			ucsi_partner_task(con, ucsi_check_connection, 1, HZ);
 			ucsi_partner_task(con, ucsi_check_connector_capability, 1, HZ);
+			ucsi_partner_task(con, ucsi_check_cable, 1, HZ);
 
 			if (UCSI_CONSTAT_PWR_OPMODE(con->status.flags) ==
 			    UCSI_CONSTAT_PWR_OPMODE_PD)
@@ -1346,6 +1414,7 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
 		ucsi_register_partner(con);
 		ucsi_pwr_opmode_change(con);
 		ucsi_port_psy_changed(con);
+		ucsi_check_cable(con);
 	}
 
 	/* Only notify USB controller if partner supports USB data */
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 469a2baf472e..f0aabef0b7c6 100644
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
2.44.0.rc0.258.g7320e95886-goog


