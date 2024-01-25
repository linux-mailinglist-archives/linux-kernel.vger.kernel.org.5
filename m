Return-Path: <linux-kernel+bounces-37834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 891CA83B633
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 016271F262A4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 00:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA00882D;
	Thu, 25 Jan 2024 00:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mk3yUOT+"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5B67482
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 00:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706143509; cv=none; b=szh3dQWMCdOVz9XwnLSMctzjJYP8BKD9w2lozVmwllvvMfUWoJLDrAu1ou8tsf3KWumNkPCVDdSj5v9X/Hva+k6MTsNrFPuGL6JE5H8Pr+PN+HLAwr5sJ9TH4LGZKklDyAYVxBzYqH59TIObtXIoYWDKYbcd7en+qNhE9g7l2y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706143509; c=relaxed/simple;
	bh=LUt4uhKuLzhEnRnMjdtUyO4l1frrpeODKi23vzrA7s8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l9gcSRsIJfTwq3dkIaF7UyMuaNq4IeFs0TdHAinaQvWUmxvyUwtO0X1TosEd+JTJwatYPtLSJgXFSaGRyifeim+/zjr/Bo/mKpyPWGahUfoTrhbkCn+3MwJ/bXMuK6T/Z0YxbQh5fahyMRio13ZWTbv748c/4ppiUEn+lt0FS60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abhishekpandit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mk3yUOT+; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abhishekpandit.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5fffb2798bfso65171547b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706143506; x=1706748306; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FTG13zB4Cw+QMij5k9sqfIjmokZzi07qqv8LYcYcXhI=;
        b=mk3yUOT+B5tSEy60QAtLTr5546Ng7KvLeZP/FfPFLzV6h/ks6S5jPuabgjx3NVCkyB
         YI3Y1ZaTJDsu7b1oPGetx4Gkvrv0pJc+W6l3ISryy5MPNh+2yo9MqbOMtxjhhf/UgmKV
         /oXmWSKSYsGynRiYNnBddvw1gqDVg9UFX+lD0MKucw6RzTCEEi30IKgQscYPayK4Ko/b
         nZSnHhhXQfJNjyx5B7uMRsOXEkDhkxkjeS/w6puD/RQBUOiIxX4R48P3bYEnokRFSTz3
         S82REcj5IK6iM7gfpwKj/dhVYAbLAJmBZesajxgxa/JAxYIHlKNWgJGJy4fhzQrJF0Ss
         /cxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706143506; x=1706748306;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FTG13zB4Cw+QMij5k9sqfIjmokZzi07qqv8LYcYcXhI=;
        b=Uh8C094c83HjQ4n3MYT9TunsPmACUDw6NRjHleHZufF3FDv7pmNDb4dTRDkQ2l4VMk
         JlEepFpFMhl/AC3Cje2st5o/dldwGs6fXTLqQWv23gWtIkywLqr/rabif9aobjJIyQFr
         XTtysa4fTvmyt6ku/GVLCNf/wWh+38u6VHo0akPBXnAFIdiUvbrkuSzMKovAE1/WdsAf
         tDSgAoI2YzcZMisaBo+O+gN3s3g9tcYZ3fXUkrigoR+DpwAD/TGBiNH72ojDLfOHy++Y
         sQ+9AoNrfhwAKcO+tNsFinvdzgS55zmI76pxGnrHvk+1jz5G0uxMSTBty0SaA+9or0zi
         4Q+A==
X-Gm-Message-State: AOJu0YxaaIuQhw40D6vjjhxqRNwe5wUoxTqmfT/URzgRu7Kck1S2i73e
	OfopXBuwVn5UGwuH85bY6to/OfKPF6WSLdc85CRTevjzEorb2OTxYBYJZzPq2FGkan01dOiuSth
	JCP283dnP43TRVdUGuP9NnuydsAolQ++5Ew==
X-Google-Smtp-Source: AGHT+IGExB7gvGZM7JciBviHyowPn/wR9Sv5XLUASVZ2ni/v0X4Gsm4Wc1QEW3P9KXAf/QE5gZWRzR/8S85JAYClMjJfAw==
X-Received: from abps.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:9b4])
 (user=abhishekpandit job=sendgmr) by 2002:a81:7991:0:b0:5fa:4896:7114 with
 SMTP id u139-20020a817991000000b005fa48967114mr252ywc.5.1706143505848; Wed,
 24 Jan 2024 16:45:05 -0800 (PST)
Date: Wed, 24 Jan 2024 16:44:54 -0800
In-Reply-To: <20240125004456.575891-1-abhishekpandit@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240125004456.575891-1-abhishekpandit@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240124164443.v2.3.Idf7d373c3cbb54058403cb951d644f1f09973d15@changeid>
Subject: [PATCH v2 3/3] usb: typec: ucsi: Get PD revision for partner
From: Abhishek Pandit-Subedi <abhishekpandit@google.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-usb@vger.kernel.org
Cc: jthies@google.com, pmalani@chromium.org, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Bjorn Andersson <andersson@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Saranya Gopal <saranya.gopal@intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

PD major revision for the port partner is described in
GET_CONNECTOR_CAPABILITY and is only valid on UCSI 2.0 and newer. Update
the pd_revision on the partner if the UCSI version is 2.0 or newer.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---
$ cat /sys/class/typec/port2-partner/usb_power_delivery_revision
3.0

Changes in v2:
  - Formatting changes and update macro to use brackets.
  - Fix incorrect guard condition when checking connector capability.

 drivers/usb/typec/ucsi/ucsi.c | 23 +++++++++++++++++++++++
 drivers/usb/typec/ucsi/ucsi.h |  3 +++
 2 files changed, 26 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index a35056ee3e96..2b7983d2fdae 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -782,6 +782,7 @@ static int ucsi_register_partner(struct ucsi_connector *con)
 	}
 
 	desc.usb_pd = pwr_opmode == UCSI_CONSTAT_PWR_OPMODE_PD;
+	desc.pd_revision = UCSI_CONCAP_FLAG_PARTNER_PD_MAJOR_REV_AS_BCD(con->cap.flags);
 
 	partner = typec_register_partner(con->port, &desc);
 	if (IS_ERR(partner)) {
@@ -856,6 +857,27 @@ static void ucsi_partner_change(struct ucsi_connector *con)
 			con->num, u_role);
 }
 
+static int ucsi_check_connector_capability(struct ucsi_connector *con)
+{
+	u64 command;
+	int ret;
+
+	if (!con->partner || !IS_MIN_VERSION_2_0(con->ucsi))
+		return 0;
+
+	command = UCSI_GET_CONNECTOR_CAPABILITY | UCSI_CONNECTOR_NUMBER(con->num);
+	ret = ucsi_send_command(con->ucsi, command, &con->cap, sizeof(con->cap));
+	if (ret < 0) {
+		dev_err(con->ucsi->dev, "GET_CONNECTOR_CAPABILITY failed (%d)\n", ret);
+		return ret;
+	}
+
+	typec_partner_set_pd_revision(con->partner,
+		UCSI_CONCAP_FLAG_PARTNER_PD_MAJOR_REV_AS_BCD(con->cap.flags));
+
+	return ret;
+}
+
 static int ucsi_check_connection(struct ucsi_connector *con)
 {
 	u8 prev_flags = con->status.flags;
@@ -925,6 +947,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 		if (con->status.flags & UCSI_CONSTAT_CONNECTED) {
 			ucsi_register_partner(con);
 			ucsi_partner_task(con, ucsi_check_connection, 1, HZ);
+			ucsi_partner_task(con, ucsi_check_connector_capability, 1, HZ);
 
 			if (UCSI_CONSTAT_PWR_OPMODE(con->status.flags) ==
 			    UCSI_CONSTAT_PWR_OPMODE_PD)
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 94b373378f63..a0c452d09cf6 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -36,6 +36,9 @@ struct dentry;
 #define UCSI_BCD_GET_MINOR(_v_)		(((_v_) >> 4) & 0x0F)
 #define UCSI_BCD_GET_SUBMINOR(_v_)	((_v_) & 0x0F)
 
+#define IS_MIN_VERSION(ucsi, min_ver)	((ucsi)->version >= (min_ver))
+#define IS_MIN_VERSION_2_0(ucsi)	IS_MIN_VERSION(ucsi, UCSI_VERSION_2_0)
+
 /* Command Status and Connector Change Indication (CCI) bits */
 #define UCSI_CCI_CONNECTOR(_c_)		(((_c_) & GENMASK(7, 1)) >> 1)
 #define UCSI_CCI_LENGTH(_c_)		(((_c_) & GENMASK(15, 8)) >> 8)
-- 
2.43.0.429.g432eaa2c6b-goog


