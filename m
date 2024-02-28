Return-Path: <linux-kernel+bounces-85770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0C086BA84
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E7B4286217
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDFF1361C0;
	Wed, 28 Feb 2024 22:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EdIfd3dW"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8421361A9
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 22:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709157849; cv=none; b=Ypdq7+EZd0IUKYYuEGlXOsrKmVlTYHWqQsM1qq/kYV4HlfPptTZ+idO5Q1hUxr7GM1SbTS86NTF3Ss4UD5xtMEij3pr0hYO0D+S+TARZI5fChKnowE/ZwTFi7F6wtUz/HQoPHZRuldzSZSS4A8ddizxY5/6L6JfMOsSwP1rdY9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709157849; c=relaxed/simple;
	bh=Ck20RD7SWLmT3wN/hjyZSTuoMvNa2KJPDTQ2bpCa8rU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IBPNta+yXDz9zmM4x3pe6HtPmuYGmRCKHyl0ukI6srwg1wi2cSQnAahDnzcVPjaYJLkIhUDqsATuo1WRENweDfzrGPEtKzN4JIWmz35QWmcolRqhfYBw5WMAuy5ZwK87bur5Fw+uANNqDbOZ69362l6O8b0o6uBveY/rnvmcJQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EdIfd3dW; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc746178515so373906276.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709157846; x=1709762646; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jb2gwN6bxiLt3LtO6maFpO1+dlXHorrZhIAqEy+dyf0=;
        b=EdIfd3dWgZ+phOaF12ToGLCveiEDgRPqBtkW1VAVQpFh+v7MRCW/9e2ePDD6Qi3uZG
         o8CLvN5p0LP/DBMyyeHKFjkyK45rEhN3k0IJWa0E2IjDaq2U00krCVzAnqUHSG8kN5cD
         Gisuau13EutHypOu7zGPTYgESX/HWHSoCaiWOdxn6NIvuvncTyn1CoONAfjxnlHiWkDp
         j6CGfC0jM8dNrV/0TcHwnaH1LtnZEC1TRJMxonedv7ThC95r1PcOrepnbIf83OKWzkgG
         joS4XMVIYP2Kv52/NoUQ64DpcWhrnElhCxRmi4/oFal5kbwm0jTsAqWqwMkACs2jq6V8
         SBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709157846; x=1709762646;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jb2gwN6bxiLt3LtO6maFpO1+dlXHorrZhIAqEy+dyf0=;
        b=MEogq077DHrGnJXhKu2gSOUzDioRi1fhghKWEAOw/jh7/jnurQjXzDMY0ftUm7G+2i
         tB4bIL3lmjYEj1amTRpM584ejTns/ihYb1OS47r9hpDa5e6p3pPnUjaMp4qh86FHe25K
         089VGFVIKiLLoauJBe9sFG5gmmIc9BzumRSMjErUu0JTYbmFwdU67snjOV5QjA7fm5ri
         PiZNcT1cGtPdVDAiIKBBm9SClYe71seeZAE9wg0F1DTPXUnOXvlp6pgcZzkTMqF9DaKo
         shMdjXMn0GzwGBJ3Xl5LmzjrQHKs8b6m7WYrm5ugLqokjEMaA/Ah0PGlK+zF6Rscd7he
         C6Vg==
X-Forwarded-Encrypted: i=1; AJvYcCXTJzqbKKtxnutdh71uVoqOJfkSo7VsG7KCrjlewdCeW3eEYEU0nt92Yf465AvtvDTulojnKjRhczQ3EiVLHnVDMTkt8IFRhQ9hEs8O
X-Gm-Message-State: AOJu0YyJiyM/Rmql4hQe+VoLyMNoADXiAWrIP/eXCF29ptGqdz6MUbqN
	AeWgCBFEyQcuTNFkfA0TLcb+9IqAMPtboBOYrFAN28Yq9wmStGPvbHK37rSQ9nHP8/ZuoteyIb8
	WeA==
X-Google-Smtp-Source: AGHT+IGMObvTbyRYVynt1WQ166gAI0nZBfbogex59iyxp3MG5aS6oyV+QzKMWgqsF735JJkDDkfnULmb9+M=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a05:6902:150f:b0:dc6:207e:e8b1 with SMTP id
 q15-20020a056902150f00b00dc6207ee8b1mr125822ybu.2.1709157845820; Wed, 28 Feb
 2024 14:04:05 -0800 (PST)
Date: Wed, 28 Feb 2024 22:04:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240228220403.3614604-1-jthies@google.com>
Subject: [PATCH v2 4/4] usb: typec: ucsi: Register SOP' alternate modes with
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


