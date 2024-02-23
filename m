Return-Path: <linux-kernel+bounces-77604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B524E8607FD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09D80B22653
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1034D101FA;
	Fri, 23 Feb 2024 01:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RIawMauK"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE566F9E0
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708650304; cv=none; b=USjw5f7mF0TTJTeT5u5qL0JpXNgOx4mMDc11T/krE80FFHvBwB3e3AplPD+JzgVxrJFwBWqnsDiF2AxCBkZv/pErmyrsJ29g7RBePyNp853ywEwk/zyVNpPYs14RSTVJoT8WmU1Q5RI3GfAcb7rp+Y+14IbTdt6z1XKjcP8JWpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708650304; c=relaxed/simple;
	bh=qGvxPb9wBNo74qyixFNMzC5WpsOmHQBVgooo0liTEMQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cB3CGyXigt59/70KpBtZC9L857Dt1ZA0YPCFWJj4YYZFqQESBrMBtq0E7BZ0UlF/GSybKoQLpAywzGclM/TtNVaS7XpiqXdogIWdmBiRxI/kqDDhkeP3g1j0zN7T3xg/emB6lJbqYDFluW/gAzfNJvt7pmMDzLD6/DPa+K+eS3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RIawMauK; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dccc49ef73eso511053276.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 17:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708650302; x=1709255102; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SfnrjBnv6BQLK9jEvV+2jcZHgVods2JgdI/a3aIK/Hg=;
        b=RIawMauK6dglklq7bJsuGxYAINPh+ApIup/nn8UfQwGvD4qL8UiAjniCbTMzJmWJo2
         W+8+5DCvrEKo0QmHjhV8H18VKrK6o9gux2M1Lk4yn3XQVObd186qn/Y814HZtLp8Bga5
         9PAnrcdxhnFvnfr0OCTS3QnDmWAE90fJ4mxu2o7tLWxhgVOMkTIvGfCrqJzdZOQnVkx/
         C9XBpqzp9vK5FeTaKQlkVNfDP0Q4dReg9020u+QrrmNckcSFjwskbNQH4KSkf5sYZokY
         Harp8+YUM37m5mipGfmLJ8afDol6FJriPL9zGHSDNvD2wk+jMJpkHRp59wZTj0nH0RrD
         qUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708650302; x=1709255102;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SfnrjBnv6BQLK9jEvV+2jcZHgVods2JgdI/a3aIK/Hg=;
        b=I2++fhi2V30VkjzMaDrRKlF9RD2umK4wPyr1H7A3+bXZvSSRhT5bZpvU4R4tgAibTE
         N9qorcSF3x0WCQQCeYTWPPWVyXfaoi9VJsrwryV48bJB7iAfeAILpMUv6QZmUbE6v3m2
         Qe/TlbujVC1N/W2wE9nCkoqLGm/0kCZnGICfuePnB3i121zK2Tmyh0wX3EteinkUPHiR
         hoDUplSsgoNC6ySN9naAK7sbBM9QHcuycJEf6/RbLAudchzqMwuys5o4bFT+5wgnKc92
         wuDkB6TFNN6s/n7SNLhExhS11EB7EJj8QnsPXjgdgabw0RzDXIAG9poLsFDu5sqqx20e
         ySDw==
X-Forwarded-Encrypted: i=1; AJvYcCW1mBEGY7KKzgpoI5qotI6xOiucy3iOXC2WOtjM3MKFVJeUSJg3KQrKnkDclNhf6wwLfGFkDER7r+HdPv0yg0WF7RDJGWP2Vt/C1PCU
X-Gm-Message-State: AOJu0YzsaEuVvVTB0pZz3RZmlDi0bGDiqK+miWfTzJsmMIFiWzYy4ElF
	zmTv5h4pTdsfUh0bg0D6LMFmkyvjVSosJ9GdBptzKAgJR/0jkdDlEN+BcuzOECGQJOljJ1/Au2g
	EGA==
X-Google-Smtp-Source: AGHT+IHsrtZJ1Y2yJh2vWG/92/vGGtCGaCqZx8RLto3Oa1J1XPVKZ8hDFBaEnXp8vdfKzzBfgbY83a/+iyU=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a05:6902:1146:b0:dc6:d9eb:6422 with SMTP id
 p6-20020a056902114600b00dc6d9eb6422mr27236ybu.10.1708650301885; Thu, 22 Feb
 2024 17:05:01 -0800 (PST)
Date: Fri, 23 Feb 2024 01:03:28 +0000
In-Reply-To: <20240223010328.2826774-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240223010328.2826774-1-jthies@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240223010328.2826774-5-jthies@google.com>
Subject: [PATCH 4/4] usb: typec: ucsi: Register SOP' alternate modes with
 cable plug
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: jthies@google.com, pmalani@chromium.org, bleung@google.com, 
	abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Register SOP' alternate modes with a Type-C Connector Class cable plug.
Alternate modes are queried from the PPM using the GET_ALTERNATE_MODES
command with recipient set to SOP'.

Signed-off-by: Jameson Thies <jthies@google.com>
---
Tested on v6.6 kernel. SOP' GET_ALTERNATE_MODE responses from the PPM
are correctly registered as to the cable plug.
redrix-rev3 /sys/class/typec # ls port2-cable/port2-plug0/
device  port2-plug0.0  port2-plug0.1  power  subsystem  uevent

 drivers/usb/typec/ucsi/ucsi.c | 60 +++++++++++++++++++++++++++++++++++
 drivers/usb/typec/ucsi/ucsi.h |  2 ++
 2 files changed, 62 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 6d6443e61faa..9b541547917b 100644
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
@@ -801,6 +825,33 @@ static void ucsi_unregister_partner_pdos(struct ucsi_connector *con)
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
@@ -842,6 +893,7 @@ static void ucsi_unregister_cable(struct ucsi_connector *con)
 	if (!con->cable)
 		return;
 
+	ucsi_unregister_plug(con);
 	typec_unregister_cable(con->cable);
 	con->cable = NULL;
 	memset(&con->cable_identity, 0, sizeof(con->cable_identity));
@@ -1046,6 +1098,14 @@ static int ucsi_check_cable(struct ucsi_connector *con)
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
index b89fae82e8ce..32daf5f58650 100644
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
2.44.0.rc0.258.g7320e95886-goog


