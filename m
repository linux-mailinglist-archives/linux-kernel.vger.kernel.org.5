Return-Path: <linux-kernel+bounces-103926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A8F87C6A0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86DCFB2147B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8DD14AA8;
	Thu, 14 Mar 2024 23:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gqC/UwyK"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643D314A8E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 23:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710460565; cv=none; b=VKDZqHbe1fMy37N2IrUZrsytboGmwswle675ZSROyDLi6c5b/77t9M08ByT1SO4ob3he8jw3g+keNUbCd6bDJOFmjfabhURhl9gBZ7XBpPbtBV0+NgmR6RYViKT4LGVGANoTONwgUlwB+4tv7y1vLMpqgd1joPRm6wdRZRr10YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710460565; c=relaxed/simple;
	bh=lMm8K+AodxiYi8tXqILWI7k7boZWltszeBLr9QNMejs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZxcdrKziTzafV5ImkTTlZ9KZ4+1s/L3/tgLZN1zli2jlRErXiy9qepF98TC5Q9ehnt02N+1cRu6RpKvXB4iy96ZjXZmtDJmgv00ROITYJTYY5O0PnmPQOlonJ2iPOpeiHGWDo8V6jjpAe/+pRojqwU/tITnP6/El18eBorNQkC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gqC/UwyK; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcbee93a3e1so2597395276.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 16:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710460563; x=1711065363; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=reK60bI2JPV8a+NiqxWRY8/H3bq3/jAN6jeedtb0O0Q=;
        b=gqC/UwyKEfLEZ7Mqm7copjJPgdcYh/m3l6j7KndUctC5yPB6N1P7Gy8ZhPcq51BSvI
         2YayZXQXNzujXZYOfB8328oeltjlfpzV3vW8GDxIC0gLdamzPO/lNmwI1YC6M308pHzG
         9UXGVby30QGA+EeVD61j9+VS8+lK3yVGA/hz8pWYDiZAU98IPNqkNzTVtfQbKbCDOOg1
         sy2nPHulqo5B8p0eY6Y+5fOgI5DjLjoJ9CEoEkpTMIbj2aHCDtZGqUvtw4qKQluWyx2h
         pWzUYqIdTufhixffkKBx6DkAoyDP2+KAE+7xi74nP+4acK3DjieAM9avkIj9o9mRgwkP
         c4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710460563; x=1711065363;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=reK60bI2JPV8a+NiqxWRY8/H3bq3/jAN6jeedtb0O0Q=;
        b=YsoV+X6RLZuljFVHwG+vXdEpQ5JEpr7NBdYIuWOI+XPtx0kUqoh7KfW8TfM84BdDf9
         1B5Z8hFH6XYI7iqwGl7xET6xfB364AcFHk1m1lJcMkil6+i8/XtGOELTR2BxKOhx0Q/n
         FnZFcW7mQ9KCB69ZDStrH76D/HWffAWj8gvMCmSlHVsXo8hjH7pzqijp5MMe/tahiwps
         FKArn16cZbDIH2CGUi3jWR3IcHm9ix9jrpUJ4Iu4HHC++ARE29LtYMQejLTXPjrRLqPT
         NNpNrMMiw6ZXMekfSz6bo78Bfe52w8d7CAOPZToJpg1w+rmEEzkRdI9S2hXB/brRqvXE
         xdvA==
X-Forwarded-Encrypted: i=1; AJvYcCVvNkjZlzubpuI8ZXIX41rVy14Ye/kwg5w3NE0b8eIUd7K4UcYDwPC++2BM07JRhQZYB/ATnGNrmYHzWmbNvpJi8m0GmoQTTFOsX03Y
X-Gm-Message-State: AOJu0Yz6KH1QdQfKKh8BbTq97MxIKxLN6sEbAX2OUwKeWPW7nMqX0oy4
	RoCZwybSiMwWskatEPDc6pdxK3Nsm+pLevXQFeUWmGFgxLHGrwKiwBK1JAOCjidNcYJpZk+kV01
	zYQ==
X-Google-Smtp-Source: AGHT+IHygQCMs/pFOpoVvJfUXQCZoyWAzMBz5agD9ur45WKQ5IQ49y2RKNByX1rbw8VPqZe/N0llsbH+Qag=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a05:6902:2848:b0:dc6:d9eb:6422 with SMTP id
 ee8-20020a056902284800b00dc6d9eb6422mr53232ybb.10.1710460563555; Thu, 14 Mar
 2024 16:56:03 -0700 (PDT)
Date: Thu, 14 Mar 2024 23:55:54 +0000
In-Reply-To: <20240314235554.90079-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314235554.90079-1-jthies@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240314235554.90079-2-jthies@google.com>
Subject: [PATCH v1 1/1] usb: typec: ucsi: Check capabilities before cable and
 identity discovery
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: jthies@google.com, pmalani@chromium.org, bleung@google.com, 
	abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Check the UCSI_CAP_GET_PD_MESSAGE bit before sending GET_PD_MESSAGE to
discover partner and cable identity, check UCSI_CAP_CABLE_DETAILS before
sending GET_CABLE_PROPERTY to discover the cable and check
UCSI_CAP_ALT_MODE_DETAILS before registering the a cable plug.

Suggested-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Jameson Thies <jthies@google.com>
---
Confirmed a device which supports GET_PD_MESSAGE, GET_CABLE_PROPERTY and
GET_ALTERNATE_MODES still requested identity and cable information.

This moves 8 bits from "reserved_1" to "features" in the ucsi_capability
struct. Really, this should be 24 bits to reflect the field size in UCSI.
But, as of UCSI 3.0, this will not overflow becasue the bmOptionalFeatures
description only defines 14 bits.

 drivers/usb/typec/ucsi/ucsi.c | 34 +++++++++++++++++++++-------------
 drivers/usb/typec/ucsi/ucsi.h |  5 +++--
 2 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index cf52cb34d2859..958dc82989b60 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1133,17 +1133,21 @@ static int ucsi_check_cable(struct ucsi_connector *con)
 	if (ret < 0)
 		return ret;
 
-	ret = ucsi_get_cable_identity(con);
-	if (ret < 0)
-		return ret;
+	if (con->ucsi->cap.features & UCSI_CAP_GET_PD_MESSAGE) {
+		ret = ucsi_get_cable_identity(con);
+		if (ret < 0)
+			return ret;
+	}
 
-	ret = ucsi_register_plug(con);
-	if (ret < 0)
-		return ret;
+	if (con->ucsi->cap.features & UCSI_CAP_ALT_MODE_DETAILS) {
+		ret = ucsi_register_plug(con);
+		if (ret < 0)
+			return ret;
 
-	ret = ucsi_register_altmodes(con, UCSI_RECIPIENT_SOP_P);
-	if (ret < 0)
-		return ret;
+		ret = ucsi_register_altmodes(con, UCSI_RECIPIENT_SOP_P);
+		if (ret < 0)
+			return ret;
+	}
 
 	return 0;
 }
@@ -1189,8 +1193,10 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 			ucsi_register_partner(con);
 			ucsi_partner_task(con, ucsi_check_connection, 1, HZ);
 			ucsi_partner_task(con, ucsi_check_connector_capability, 1, HZ);
-			ucsi_partner_task(con, ucsi_get_partner_identity, 1, HZ);
-			ucsi_partner_task(con, ucsi_check_cable, 1, HZ);
+			if (con->ucsi->cap.features & UCSI_CAP_GET_PD_MESSAGE)
+				ucsi_partner_task(con, ucsi_get_partner_identity, 1, HZ);
+			if (con->ucsi->cap.features & UCSI_CAP_CABLE_DETAILS)
+				ucsi_partner_task(con, ucsi_check_cable, 1, HZ);
 
 			if (UCSI_CONSTAT_PWR_OPMODE(con->status.flags) ==
 			    UCSI_CONSTAT_PWR_OPMODE_PD)
@@ -1589,8 +1595,10 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
 		ucsi_register_partner(con);
 		ucsi_pwr_opmode_change(con);
 		ucsi_port_psy_changed(con);
-		ucsi_get_partner_identity(con);
-		ucsi_check_cable(con);
+		if (con->ucsi->cap.features & UCSI_CAP_GET_PD_MESSAGE)
+			ucsi_get_partner_identity(con);
+		if (con->ucsi->cap.features & UCSI_CAP_CABLE_DETAILS)
+			ucsi_check_cable(con);
 	}
 
 	/* Only notify USB controller if partner supports USB data */
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 32daf5f586505..0e7c92eb1b227 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -206,7 +206,7 @@ struct ucsi_capability {
 #define UCSI_CAP_ATTR_POWER_OTHER		BIT(10)
 #define UCSI_CAP_ATTR_POWER_VBUS		BIT(14)
 	u8 num_connectors;
-	u8 features;
+	u16 features;
 #define UCSI_CAP_SET_UOM			BIT(0)
 #define UCSI_CAP_SET_PDM			BIT(1)
 #define UCSI_CAP_ALT_MODE_DETAILS		BIT(2)
@@ -215,7 +215,8 @@ struct ucsi_capability {
 #define UCSI_CAP_CABLE_DETAILS			BIT(5)
 #define UCSI_CAP_EXT_SUPPLY_NOTIFICATIONS	BIT(6)
 #define UCSI_CAP_PD_RESET			BIT(7)
-	u16 reserved_1;
+#define UCSI_CAP_GET_PD_MESSAGE		BIT(8)
+	u8 reserved_1;
 	u8 num_alt_modes;
 	u8 reserved_2;
 	u16 bc_version;
-- 
2.44.0.291.gc1ea87d7ee-goog


