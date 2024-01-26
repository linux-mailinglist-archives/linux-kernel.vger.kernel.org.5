Return-Path: <linux-kernel+bounces-40518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D536483E1D0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E6521F27911
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5415056466;
	Fri, 26 Jan 2024 18:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GM59ius0"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174B65467D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 18:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706294383; cv=none; b=SYfv1spTB0gIXex72cMrQZEUApmISa72oqFKcR5NK72aP8JR7gliaQTnMl1umDUKpUUPlksi6qIVGPhDBYKFNU5X+qiVXW4apgN21pJrgqD/7AWyFt50Q9LOK/UCbqQk27MxW60lrYFRVearuYmyMrKSyufADqNS4nt24Ix0HVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706294383; c=relaxed/simple;
	bh=qQ20mYMsYljxRmFVBXSfi1rqbWNANcAPCdD/+60IY8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGl4SVjKyJitnTA+5ZqtfCvq0PotQheLX4+HQFmSpSwmpIvQgS/sEMJ+xecETJRQFhZyVzdPMzdhdhwAyfcTjkwQXFN8NdzQrpcuroJtO1E8DATE/8QtYhWbQ2GPrIL5r/lDnot2lQ8zBROSREJfyBJdtTDyz/BthAaEofV7f7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GM59ius0; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6de0ba30994so220334b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 10:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706294381; x=1706899181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QQrn5zdRS2vcBUSW5uiCOjM9d8+vCQMueTf6c01I2Q=;
        b=GM59ius04vzCGUnLQqoAZYoXawSxOLreTdynV8WlIX6u/2ngpd+RqUUfnCbNs31OAd
         ubXnSzMA8bAH1LcXFnq8oSRnw1vOxgEyA9KOnAx3+zMiZLZVYurhiB/5Gj/7gil9iRii
         leZ/yVFHuScREQQ7O1MM8j1RyuQlTsB8UyJPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706294381; x=1706899181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2QQrn5zdRS2vcBUSW5uiCOjM9d8+vCQMueTf6c01I2Q=;
        b=Q3fogOmdzpsHC+2l+YsGpRVFT3//SUS5lzMO1MC5viZyd/uIJfmcpeT81ETluw8eTo
         gIa5xO0UJkmQjENadhNKErlCKiQOtxhJx2w3H+3+F9D+My5JLJU8z3Hm8H0BuqCl77hQ
         jcmZ8vqgwJPF6ltEcJJLH1kqMoly79lXJJs1Vfd6s+XwzefLX6J47JjHEBOfNbznrLlV
         6pK6+kwVcTdhut+ZHuIV079GVqzvQ3bGwOofSCAW3I7JbZEBX1G+4pf2dAZN1DOzjLm/
         FKwUx4hSEdsob9vy4fNcc/ISNrdw/IVkHLbB7c9Qkstip0L5+ephbc5S9D8sPqX17Qlx
         kLxw==
X-Gm-Message-State: AOJu0YzFUEmjaojYUxpStzm4zfYQ9/id0bOICv1K+QrGeudJlgVkSZOK
	Ta+cqhBbcLoeOCLD/dSGWsBToFVz8E7NX/0+aeTYkQapDCZJev1lGKlJJS5Axw==
X-Google-Smtp-Source: AGHT+IGuK34NiLpOOMCCCv9sSURoiq/Fovr+GwFX0Ab0ow/PfAf2KIPLV7lCTMqtiQuamaiiyJaafQ==
X-Received: by 2002:aa7:8b97:0:b0:6da:af47:95f0 with SMTP id r23-20020aa78b97000000b006daaf4795f0mr272875pfd.27.1706294380577;
        Fri, 26 Jan 2024 10:39:40 -0800 (PST)
Received: from localhost (209.148.168.34.bc.googleusercontent.com. [34.168.148.209])
        by smtp.gmail.com with UTF8SMTPSA id r25-20020aa78b99000000b006dbda9a4e6bsm1410678pfd.44.2024.01.26.10.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 10:39:40 -0800 (PST)
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org
Cc: pmalani@chromium.org,
	jthies@google.com,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rajaram Regupathy <rajaram.regupathy@intel.com>,
	Saranya Gopal <saranya.gopal@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] usb: typec: ucsi: Get PD revision for partner
Date: Fri, 26 Jan 2024 10:39:09 -0800
Message-ID: <20240126103859.v3.3.Idf7d373c3cbb54058403cb951d644f1f09973d15@changeid>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240126183930.1170845-1-abhishekpandit@chromium.org>
References: <20240126183930.1170845-1-abhishekpandit@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PD major revision for the port partner is described in
GET_CONNECTOR_CAPABILITY and is only valid on UCSI 2.0 and newer. Update
the pd_revision on the partner if the UCSI version is 2.0 or newer.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---
$ cat /sys/class/typec/port2-partner/usb_power_delivery_revision
3.0

(no changes since v2)

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
index 1bae4cf8ecdc..d1d0e11b0704 100644
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


