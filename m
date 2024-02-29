Return-Path: <linux-kernel+bounces-86018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E19086BE97
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982651F233E9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805E7364B1;
	Thu, 29 Feb 2024 01:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ybG3037R"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1D33714C
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709171654; cv=none; b=JSCET+4RZySHVKH/dspmOW5atW1q0nGrURZh2WTW1dj0Ww1DIrgTq1JHgIEKymCw8v/gQlxZO6oVHOvqu1AJuyDhHDC5T1BbduGN/UnlcjBdt3OV5tr+i24xDmp1qizogVtoEVCxMzaz7CwaEoNgVO7y4fHWU+bt4rxkCZVFefU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709171654; c=relaxed/simple;
	bh=sjFQtDvhvEyWLfprHkf57jFvK86g9+U0imPTasrTbf0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YlMhAyY5fkuSG80hQNtcCJXMLx6zvfr4Jg2J7dIVZVRKUvO/G9jPkHJaFL7EnBTMpOzLRwancdjnzJkzryvjLDcH28ff44kR3CPwofdmTRQx+8Em8+45JA81vIKiHSbm9hL1rpq2J7Lpp5ovZfaJVo6lJQ+vMVcX9JIZQLl18pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ybG3037R; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60802b0afd2so4204237b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709171652; x=1709776452; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DIpbzGnuxG/veYQVRb7uyrg5E8imeH2l3OOJtVWsq90=;
        b=ybG3037RhHAR7djkpGn2mv1iiZ2PXpMKTja9borXOj7S0GsBF5O57QEw88eFon/Qqx
         yGyzUIYvQ/zYcyD5m6LNFH1jR3zGvnSwRHA0DnLs3E2i/SC62EOKIdPb45MlwHY+hZOE
         12FQvGxDgjILPY4W3idYeZjy5hK+cHPRDIY9nqDLYI3jzkJYqPNUqbG9P0bnuISsl9pl
         w7L8BIASylHmrUqrFQNNgAFslASALdo2Ko1zOKEiEnsGYm+yXWIDdpriwGQAwdp6pfmE
         6qcql+uAPGQ4dUgZJB0FI8+Zy6iK962Yxl5a5Zi+hBFGBN4Gqz29W6xNvZeEBxzUCYAi
         uRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709171652; x=1709776452;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DIpbzGnuxG/veYQVRb7uyrg5E8imeH2l3OOJtVWsq90=;
        b=bY+Fv7uP6O65uC1jfAV3pew06XPPJ2hrwhM0AzpxH1aZLVfoan1kzUc68EeEnWqqsC
         MsjdrJ+A4gSJPecxA7kW/UJLRSzoau6bAIhDJq/FPaQaJ5HuULxrcrPNoZfCyY71QJsm
         5Qq1zrYnsRnhds70cZtU2/w7yPwZ4LVOzM1VFgKycJXIk8jrEFJzcwGRfd3rRLMI6ELA
         Vl0oE0ShqKUpJuaB8u1KXH1ft7kg5udLZJwRghuNhb90FehxmVEB3CU6EK4MWmgJkHtu
         FxscVzXzqsV1CzzoQM3AaNgK5yefZFcQEPpNm/JVGGXrEXweCLElHqVJMlNxCtrWjuQo
         5KxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpjquPF9Ib+rxIG2Lg2zf/eBcJaBIeCQBxp1BGga06g3nE4RMKMkfHUu2TZVRhK3YYzllF/nut+tl43i2rj8+G5gUDZJHlNG4s1M0V
X-Gm-Message-State: AOJu0YxAuP0isCd+P+Z+KQZbn+jlTKj/jUU1heTipWiy/kGncVpy3RkK
	VyyPkKe9R3gGKQmlIeonTRJSy+0Jq8RAAsSlkOLphR2Cl7z/0hf9RhU4wGzoJAmr+rdzt+J2NCG
	7uQ==
X-Google-Smtp-Source: AGHT+IFi43E2BC6ebc/lFL3qKA94jv+XBuJJgbVeCpAVgT6e2VRPHxJEmdf7YN8EBHsQecokVwDzzYUcPiY=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a05:690c:2d04:b0:608:b57f:59b2 with SMTP id
 eq4-20020a05690c2d0400b00608b57f59b2mr84148ywb.3.1709171652170; Wed, 28 Feb
 2024 17:54:12 -0800 (PST)
Date: Thu, 29 Feb 2024 01:54:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240229015402.3671136-1-jthies@google.com>
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


