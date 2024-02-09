Return-Path: <linux-kernel+bounces-59034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF8884F01D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 813FB1C217DD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35BC5789B;
	Fri,  9 Feb 2024 06:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pt5FX2BL"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CC95732C
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 06:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707458748; cv=none; b=eRxaVqGjZjjJVH81eWS45ZnIeqZn3NoJCjmBNlJDshnGTvPk3JuQwq2yqf3Rzpb1JxXKHrTITWJafxzwA53uu0xVsN5e4WK26aGWMc/H/87iMYRuq0aAF+Z9/ruoRGXMo7qru/vrX1az2yyjgDuMb1TImBzkuXHby1Kd4bLpSWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707458748; c=relaxed/simple;
	bh=CT/55tN9O9NYhHK5DTcn9HOMKpKvx8iNl9/zVWpYct8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CPen20hEskz+plmli9ZA1u4WoLv/RPcYzI+10mU8B6vmlk4wzHNz5hBpPvLNmLo7UB3UCaAMbxo0xpBUB90TCyu3c+GUbch+STjAQIip50xkBUeSA3G8CLcN3975l8bZ/DWXsHHRvOyKdp3hWgAoTHMvGPDFI7Y8N5F6ieIPenY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Pt5FX2BL; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7bff28b2937so21094839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 22:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707458746; x=1708063546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kU3WAfQM9Sfnlpso5o0A7y5vYgNomm9R2kIzE533//Q=;
        b=Pt5FX2BL+WdT+X/S1BzX+Drg3p8s3dmM+ARVTt3WafDvhefJD/0m0dLoOyfu1C/JGj
         L4ISxaDGt2q5WMP3Df+s7DdGMBD1m5d/KIJ+zAD3tKhFapAuepy8CSJtPPDbGnibGnax
         v4KPN8HuiQzcDj603YFbt89PStwygTEqoccJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707458746; x=1708063546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kU3WAfQM9Sfnlpso5o0A7y5vYgNomm9R2kIzE533//Q=;
        b=Qqt/5FKUHYxbqk+Catiq5cYM25o1gdwV6Nscgli/HZpqKFRZJel3bH7vvTCJta3D6H
         H8bcfsBXr+hPhqpZSrgJSKtpDyxzktn3f5J2aAgOoTgn96W5rjZSA1eN//mZLMXGUUB8
         Kp7wG3cWdtBynBWJkHy2wvM1TPZGn1PdesQW3cy8IrXlN/TNtBOwQFuMOk1DuxQKusji
         OANNEZpT8dYCZYA4gxsQnFJOHEuP5iXw6fg2HslpaVPapR9bhuEwF5PURIW7rKFWgj+D
         hfoDOtmWuPPcAmR9oB9qlUOuIM+2VRsSaL53e2w0PCa4dQoWq16NT4raIo9c9W0W98VE
         Uw0A==
X-Gm-Message-State: AOJu0YxQUbMwycZ1XVzjL+PtbI99ewVvClwN70EMjmdViAxgduwLQER1
	WBzrocHTwxEWod/aIatlqoNincoCf85EvjBRUKlUk2l/xCNHbsWLIgeZckXxDA==
X-Google-Smtp-Source: AGHT+IHP+NjS4yp7VoWj2By/R3AqIn7H5z3FI0hBMySpju7l+jOZ91KrI+JmLbXSUOeNmmmRlMYvvQ==
X-Received: by 2002:a92:cd4c:0:b0:363:ad01:f052 with SMTP id v12-20020a92cd4c000000b00363ad01f052mr896942ilq.24.1707458746569;
        Thu, 08 Feb 2024 22:05:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWaphZWR2HcRx/d5LRSMw8Ym1cUB+1VtpM/wc17o8hWhUpKC65d6RP5tTdJBwapePscSe+m58FHz4Grp/YuVpQx9LXvn6l7xULE3VtoUJx5SHhC4aX6qb3fhQjmlF7GHfzH0HRMQReywu3u5Jdlcb7oXpkn74YV0JQRfp+/IvlHJ3O6VpoKiTwbT7a9Dh3MHR24KDKA9DkcuLXns12hqJlfGeIsxWQsGD0V4GI5aKf+wMH+A7eYJzPt4LYsFZ5w8OeT9w7WWBMumkaPtggo2xRiphVUOXfKejlNKVU5PkR4N2y1RMZZjRjxTYKLZc4acYiusezGw/3PeSkk0aoWs3U/W+BjbAkzxmP1gc39LY+Jgur1QJNHevBCXNjxanTYQzLOr6WKMG65NVY7COa7Cfw5fvy/k1U=
Received: from localhost (209.148.168.34.bc.googleusercontent.com. [34.168.148.209])
        by smtp.gmail.com with UTF8SMTPSA id cf11-20020a056a02084b00b005dc26144d96sm753263pgb.75.2024.02.08.22.05.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 22:05:46 -0800 (PST)
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org
Cc: jthies@google.com,
	pmalani@chromium.org,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Prashanth K <quic_prashk@quicinc.com>,
	Saranya Gopal <saranya.gopal@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] usb: typec: ucsi: Get PD revision for partner
Date: Thu,  8 Feb 2024 22:02:40 -0800
Message-ID: <20240208220230.v4.3.Idf7d373c3cbb54058403cb951d644f1f09973d15@changeid>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240209060353.6613-1-abhishekpandit@chromium.org>
References: <20240209060353.6613-1-abhishekpandit@chromium.org>
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

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Prashant Malani <pmalani@chromium.org>
Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---
$ cat /sys/class/typec/port2-partner/usb_power_delivery_revision
3.0

Changes in v4:
  - Replace IS_MIN_VERSION macro and just compare version directly.

Changes in v2:
  - Formatting changes and update macro to use brackets.
  - Fix incorrect guard condition when checking connector capability.

 drivers/usb/typec/ucsi/ucsi.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index d9a345ec62c3..9d49dbeee9d5 100644
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
+	if (!con->partner || con->ucsi->version < UCSI_VERSION_2_0)
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
-- 
2.43.0.687.g38aa6559b0-goog


