Return-Path: <linux-kernel+bounces-59031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313AA84F018
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5609F1C2173E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A9C57332;
	Fri,  9 Feb 2024 06:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C2Q5HAcv"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2739E57308
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 06:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707458746; cv=none; b=kfPH8rScoqsiiEnhyiApl/xDEklTAYc7WvZdHWtUkI9u8HQ15bEacrFgjJ+5b9WlPxobgrmX1uTESBj8N8DGHRWhOCHfo7Gte7kFY+lj8t5YEn/lNCUgZ3hBFWvbmGVg4V98KLRA+6VIlHd3tP7sniZnZeqB9BFf4lG9OaBrvCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707458746; c=relaxed/simple;
	bh=noXh4QjalWPeIqmk88xgk+MT1Q1CPYJ7IGWY4FLlLYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jvlcFctCmRB4ZbHrvoopI2jQ5FzLrEoS2Gf5lOwnH1pVN8Wyhfpr6toA7mj9oHASSDRP9sDeScd83GRsg4IOhSN54d/vWahJ09QlYIsqDBe9+eMev48aMYa0PqtStzcO8ps+JqAjwXA2bS9/d1BkHs9s9UJi56aQt4bwnWAolbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C2Q5HAcv; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d94323d547so5456695ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 22:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707458744; x=1708063544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80VtU8v4yD1vE6SrhFnN3XZO/F8XU6EPJRSbswzy3Kk=;
        b=C2Q5HAcvO+drsh2r3n5w4p412q5Cq2KvvZpJIhOo9pLwt9YtmpT5l1istUsiq3WvZr
         icw6LPO0RXhxyNesgOw1qDD85wqJbdrOI8P5ehJl2L/o2pV9ZMJSV8DDVzM9OYS4cF1h
         /A1/3rEzEJtrlg9r4kIqfMTbqXVk46l2tVB1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707458744; x=1708063544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80VtU8v4yD1vE6SrhFnN3XZO/F8XU6EPJRSbswzy3Kk=;
        b=LZhcr5SLV5ftKpqdYfRCJNRHeR5mYpQVDHIhGgQzVP0dVsRKg2Xf84UEg/qBhIWGT/
         gC5951ca/w7rPV6EDv4g2g/B85B6GrSEvYEAwd9PgBOFrh+JfYKnCljjmSEmYVyK0ReW
         ZB5sd4YqWKbe9mg2IVwm9TxRXX6tj+pZG/N3jMFBRmTF4osgTdphMkM/QVACEHEC2Iud
         rsTxEMMz6UWyC6jo6dDyx+SVAefqb1/tKbNL3dNMUvLhKAposxpgarLwcpwUKkNaHUN/
         R7xQ5MFVXIdqPmXDYyIBpLBIjOpxJ3BUh5Ya7ZLADoEgwyIO9y6Id1D6cxwHNQYx/wxf
         A2TQ==
X-Gm-Message-State: AOJu0YxPcjpvH2ZJTBe6KcPcuSBqFjd4hqESW9JR+aoyeBhHKSLSlute
	sBvokjgmd83bL0IdRFWAxC/5fcEw7g6YZ8ze8JRzC6y3aXzumN7WX7W3KsoOZQ==
X-Google-Smtp-Source: AGHT+IEU7HiPSSb8A2SmGJdVFDjjaEA47GKfjWxy4a8AykhqcDenW4A6+Xegy01QgLGONGMTlF9CEw==
X-Received: by 2002:a17:902:650e:b0:1d9:c876:b840 with SMTP id b14-20020a170902650e00b001d9c876b840mr615798plk.2.1707458744421;
        Thu, 08 Feb 2024 22:05:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWJsf3/BOHYsZ6Prh92L/Pt4yIQ338yOw2jB/FbNQKuPUywOFmyJJ4l3t6jRfQsssyox52TwNvuId11bgMbW25wEgRNmM0QZb1DHuv3OFC0anJjfRs6YcrJin6lGf3Wkg0XiU6fP90ywaBmzsQa/bDP3UrkS6cqk0yLNriWjaoT0s1VWEAC5NmNg4GUnwh+cYYhS5VR3Vdaqjq1MJBWU5sxQKADhgCz7Fq4FVHaUEpG4qScqVD9iOZZTh7Pu3sTzbnpJn29ekKla2zpcUEatZxt9Q+ZF5ublL3tnAibbuMvQWOvXg1t0p6OU+K5o3c5K4NoEK0eIgCTESGg8iPVl8xFUVIwFa+ugSF+P5FUsPeFptk5LNDdVtVBqL9qsRXw9iJ8BDp+ihrI4E8Jo3lUZkqUTN47Ns37fiolQkKa06D5e7gyK6H4oT0bFJ/ml8Ed13m/Hd6lGCVbuGSoNer4JFyQFcrro/4bxjOU0ZJbDhUld9vueQfGR5oBZw==
Received: from localhost (209.148.168.34.bc.googleusercontent.com. [34.168.148.209])
        by smtp.gmail.com with UTF8SMTPSA id kd5-20020a17090313c500b001d8ffe741basm753922plb.36.2024.02.08.22.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 22:05:44 -0800 (PST)
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org
Cc: jthies@google.com,
	pmalani@chromium.org,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Rajaram Regupathy <rajaram.regupathy@intel.com>,
	Saranya Gopal <saranya.gopal@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] usb: typec: ucsi: Limit read size on v1.2
Date: Thu,  8 Feb 2024 22:02:38 -0800
Message-ID: <20240208220230.v4.1.Iacf5570a66b82b73ef03daa6557e2fc0db10266a@changeid>
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

Between UCSI 1.2 and UCSI 2.0, the size of the MESSAGE_IN region was
increased from 16 to 256. In order to avoid overflowing reads for older
systems, add a mechanism to use the read UCSI version to truncate read
sizes on UCSI v1.2.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---
Tested on 6.6 kernel. Dmesg output from this change:
[  105.058162] ucsi_um_test ucsi_um_test_device.0: Registered UCSI
interface with version 3.0.0


Changes in v4:
  - Added missing Tested-By tags from v1 and reviewed-by tags.

Changes in v2:
  - Changed log message to DEBUG

 drivers/usb/typec/ucsi/ucsi.c | 26 ++++++++++++++++++++++++--
 drivers/usb/typec/ucsi/ucsi.h | 11 +++++++++++
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 14f5a7bfae2e..d9a345ec62c3 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -36,6 +36,19 @@
  */
 #define UCSI_SWAP_TIMEOUT_MS	5000
 
+static int ucsi_read_message_in(struct ucsi *ucsi, void *buf,
+					  size_t buf_size)
+{
+	/*
+	 * Below UCSI 2.0, MESSAGE_IN was limited to 16 bytes. Truncate the
+	 * reads here.
+	 */
+	if (ucsi->version <= UCSI_VERSION_1_2)
+		buf_size = min_t(size_t, 16, buf_size);
+
+	return ucsi->ops->read(ucsi, UCSI_MESSAGE_IN, buf, buf_size);
+}
+
 static int ucsi_acknowledge_command(struct ucsi *ucsi)
 {
 	u64 ctrl;
@@ -72,7 +85,7 @@ static int ucsi_read_error(struct ucsi *ucsi)
 	if (ret < 0)
 		return ret;
 
-	ret = ucsi->ops->read(ucsi, UCSI_MESSAGE_IN, &error, sizeof(error));
+	ret = ucsi_read_message_in(ucsi, &error, sizeof(error));
 	if (ret)
 		return ret;
 
@@ -170,7 +183,7 @@ int ucsi_send_command(struct ucsi *ucsi, u64 command,
 	length = ret;
 
 	if (data) {
-		ret = ucsi->ops->read(ucsi, UCSI_MESSAGE_IN, data, size);
+		ret = ucsi_read_message_in(ucsi, data, size);
 		if (ret)
 			goto out;
 	}
@@ -1558,6 +1571,15 @@ int ucsi_register(struct ucsi *ucsi)
 	if (!ucsi->version)
 		return -ENODEV;
 
+	/*
+	 * Version format is JJ.M.N (JJ = Major version, M = Minor version,
+	 * N = sub-minor version).
+	 */
+	dev_dbg(ucsi->dev, "Registered UCSI interface with version %x.%x.%x",
+		UCSI_BCD_GET_MAJOR(ucsi->version),
+		UCSI_BCD_GET_MINOR(ucsi->version),
+		UCSI_BCD_GET_SUBMINOR(ucsi->version));
+
 	queue_delayed_work(system_long_wq, &ucsi->work, 0);
 
 	ucsi_debugfs_register(ucsi);
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 6478016d5cb8..bec920fa6b8a 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -23,6 +23,17 @@ struct dentry;
 #define UCSI_CONTROL			8
 #define UCSI_MESSAGE_IN			16
 #define UCSI_MESSAGE_OUT		32
+#define UCSIv2_MESSAGE_OUT		272
+
+/* UCSI versions */
+#define UCSI_VERSION_1_2	0x0120
+#define UCSI_VERSION_2_0	0x0200
+#define UCSI_VERSION_2_1	0x0210
+#define UCSI_VERSION_3_0	0x0300
+
+#define UCSI_BCD_GET_MAJOR(_v_)		(((_v_) >> 8) & 0xFF)
+#define UCSI_BCD_GET_MINOR(_v_)		(((_v_) >> 4) & 0x0F)
+#define UCSI_BCD_GET_SUBMINOR(_v_)	((_v_) & 0x0F)
 
 /* Command Status and Connector Change Indication (CCI) bits */
 #define UCSI_CCI_CONNECTOR(_c_)		(((_c_) & GENMASK(7, 1)) >> 1)
-- 
2.43.0.687.g38aa6559b0-goog


