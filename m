Return-Path: <linux-kernel+bounces-87693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E200F86D7C9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 123C71C21A2F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAC813E7C7;
	Thu, 29 Feb 2024 23:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nm8n2PeT"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5957F200BA
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709249304; cv=none; b=rM6rhew+FhyClQ9wuQHJram/MvGiwfk6iq3n5I+4NJGGlaIhoA3u5XS7yAQkRvYCKjJKIbZv+CTfG7taBzhNdErPAPcYT0TmBqf2Yvj6W1dy5f5hzdqj+YsK3MAIHk3D7qm1adEujWB1dl6uMPw1pslgU3ybXa3MWoaOHF67dt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709249304; c=relaxed/simple;
	bh=sjFQtDvhvEyWLfprHkf57jFvK86g9+U0imPTasrTbf0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OJzvawEVQ+g1g2eP+Av3osnQApIZsY6oEZm/PhyOypZWeSmdEmer7cP1vgzhYMEVFsMv4q3YAQkAR3Fsln2+KEh2F5AalLdnWiyukb5x6niYbef+oTq4w8rrHnipBYH17BpeBxdlCwxVCxjgOVqnkHUANWUSowMC7JNu6lMXaak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nm8n2PeT; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608ad239f8fso24636287b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709249302; x=1709854102; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DIpbzGnuxG/veYQVRb7uyrg5E8imeH2l3OOJtVWsq90=;
        b=nm8n2PeTnaFNoXXE3u8FAy2WgfsyzGQ8mEd5TNbxK2nlw9kMeOGqJPEg05bc9NGooO
         r+a0QYlNZWUnopzncKv1u/IU/dXFTc19fIHqy+2uPi50AA29And35/HEyi0lRtmdpY5C
         yoaAC6dVp23EBDzefol2IOhW2r/uEPgNfMQTrqnNOMGrkylV+YId3A5jV+CB7T7Jag4F
         E5HeaOXV0B+Psn2ImVbftPyjZmZWvyyHsLWMU+TvhpYwS4oHHBGSMl7TL+ysDpU4euHG
         hOgjxSE0zzESIJ47nt82kq/EPBZ7RxgFT169F4HXAZmS9X3uIO/stly3KQBQPrk3IzO2
         rsYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709249302; x=1709854102;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DIpbzGnuxG/veYQVRb7uyrg5E8imeH2l3OOJtVWsq90=;
        b=B/1ToJIu6QFAd1Gv5tJlegA54y8iwsnpsk82PHiaBOwco17lapvQptkZeZ3bOOlddX
         oap4Vj1wqlcIXMwO/fAf0x6qbAr4lKFAd4yL8eQYLoVZGh1WLbvHKFEwcuoq1En0hgLR
         HNdKBNR50lYi6l0spQbVn61pn7qPbKcDy7wTJbdstd5jxmthcUl8QMsM9KUejHeXQILy
         6TXIe3K5OyI2QAr+yNa7N5KS90AyuZtnRzGEgAnDA1fOT8TI/tIPmK4attsLBcSFrwpS
         M0n8FvUhdGLDAH8z10r82Wkx8yH5C/7bZZuOHvtpbUwX6qaHdYvy5flyZBYpBnpr6AxK
         VEUA==
X-Forwarded-Encrypted: i=1; AJvYcCUWkN1oBsqbZzK5P98pSQYNqIPH321gcq5AJuqifoUnqI5VIpQxOJQJXHGeVvP/EmdML9RDfCcGYxtQ9VBhgg06i6JkDbHD8MaAaoT8
X-Gm-Message-State: AOJu0YwvdbLoIjabtbIWrZfUbj0muk0xUz6mzualspY43XKZlKZ5XloV
	qdSGIOjwWIEXXLmmtCOdy5Dqp6DXaKprrpZ/dVYFKepEzHUiz2CZpL/CPUYIc+RYwrOG+jROaxk
	WBA==
X-Google-Smtp-Source: AGHT+IEQdV7H7CHxrnccmLNuQKd/TUmgGzmqv3n4/NAfpiq2qW0h/l/JfxuMlMpEcrlOT+b5qU1x1R6kbbw=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a81:9808:0:b0:609:5dc8:fc81 with SMTP id
 p8-20020a819808000000b006095dc8fc81mr1551ywg.1.1709249302545; Thu, 29 Feb
 2024 15:28:22 -0800 (PST)
Date: Thu, 29 Feb 2024 23:26:25 +0000
In-Reply-To: <20240229232625.3944115-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229232625.3944115-1-jthies@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240229232625.3944115-5-jthies@google.com>
Subject: [PATCH v3 4/4] usb: typec: ucsi: Register SOP' alternate modes with
 cable plug
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: jthies@google.com, pmalani@chromium.org, bleung@google.com, 
	abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Register SOP' alternate modes with a Type-C Connector Class cable plug.
Alternate modes are queried from the PPM using the GET_ALTERNATE_MODES
command with recipient set to SOP'.

Reviewed-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Jameson Thies <jthies@google.com>
---
SOP' GET_ALTERNATE_MODE responses from the PPM are correctly registered
to the cable plug.
nospike-rev4 /sys/class/typec # ls port0-cable/port0-plug0/
device  port0-plug0.0  port0-plug0.1  power  subsystem  uevent

Changes in v3:
- None.

Changes in v2:
- Shortened lines to within 80 characters.
- Tested on usb-testing branch merged with chromeOS 6.8-rc2 kernel.

 drivers/usb/typec/ucsi/ucsi.c | 60 +++++++++++++++++++++++++++++++++++
 drivers/usb/typec/ucsi/ucsi.h |  2 ++
 2 files changed, 62 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 4088422b33c74..281954fe9d855 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -399,6 +399,27 @@ static int ucsi_register_altmode(struct ucsi_connector *con,
 
 		con->partner_altmode[i] = alt;
 		break;
+	case UCSI_RECIPIENT_SOP_P:
+		i = ucsi_next_altmode(con->plug_altmode);
+		if (i < 0) {
+			ret = i;
+			goto err;
+		}
+
+		ret = ucsi_altmode_next_mode(con->plug_altmode, desc->svid);
+		if (ret < 0)
+			return ret;
+
+		desc->mode = ret;
+
+		alt = typec_plug_register_altmode(con->plug, desc);
+		if (IS_ERR(alt)) {
+			ret = PTR_ERR(alt);
+			goto err;
+		}
+
+		con->plug_altmode[i] = alt;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -566,6 +587,9 @@ static void ucsi_unregister_altmodes(struct ucsi_connector *con, u8 recipient)
 	case UCSI_RECIPIENT_SOP:
 		adev = con->partner_altmode;
 		break;
+	case UCSI_RECIPIENT_SOP_P:
+		adev = con->plug_altmode;
+		break;
 	default:
 		return;
 	}
@@ -849,6 +873,33 @@ static void ucsi_unregister_partner_pdos(struct ucsi_connector *con)
 	con->partner_pd = NULL;
 }
 
+static int ucsi_register_plug(struct ucsi_connector *con)
+{
+	struct typec_plug *plug;
+	struct typec_plug_desc desc = {.index = TYPEC_PLUG_SOP_P};
+
+	plug = typec_register_plug(con->cable, &desc);
+	if (IS_ERR(plug)) {
+		dev_err(con->ucsi->dev,
+			"con%d: failed to register plug (%ld)\n", con->num,
+			PTR_ERR(plug));
+		return PTR_ERR(plug);
+	}
+
+	con->plug = plug;
+	return 0;
+}
+
+static void ucsi_unregister_plug(struct ucsi_connector *con)
+{
+	if (!con->plug)
+		return;
+
+	ucsi_unregister_altmodes(con, UCSI_RECIPIENT_SOP_P);
+	typec_unregister_plug(con->plug);
+	con->plug = NULL;
+}
+
 static int ucsi_register_cable(struct ucsi_connector *con)
 {
 	struct typec_cable *cable;
@@ -892,6 +943,7 @@ static void ucsi_unregister_cable(struct ucsi_connector *con)
 	if (!con->cable)
 		return;
 
+	ucsi_unregister_plug(con);
 	typec_unregister_cable(con->cable);
 	memset(&con->cable_identity, 0, sizeof(con->cable_identity));
 	con->cable = NULL;
@@ -1098,6 +1150,14 @@ static int ucsi_check_cable(struct ucsi_connector *con)
 	if (ret < 0)
 		return ret;
 
+	ret = ucsi_register_plug(con);
+	if (ret < 0)
+		return ret;
+
+	ret = ucsi_register_altmodes(con, UCSI_RECIPIENT_SOP_P);
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
 
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index b89fae82e8ce7..32daf5f586505 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -429,9 +429,11 @@ struct ucsi_connector {
 	struct typec_port *port;
 	struct typec_partner *partner;
 	struct typec_cable *cable;
+	struct typec_plug *plug;
 
 	struct typec_altmode *port_altmode[UCSI_MAX_ALTMODES];
 	struct typec_altmode *partner_altmode[UCSI_MAX_ALTMODES];
+	struct typec_altmode *plug_altmode[UCSI_MAX_ALTMODES];
 
 	struct typec_capability typec_cap;
 
-- 
2.44.0.rc1.240.g4c46232300-goog


