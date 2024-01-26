Return-Path: <linux-kernel+bounces-40516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F97C83E1CC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F04FB25540
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C40224EA;
	Fri, 26 Jan 2024 18:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CtTVhxSm"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05FF1DDFC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706294380; cv=none; b=LZEgydHaOXFt1GlNhA/avZUfb1zjaUb8zYpSwFH22kW91YAtv6bfFLXmD6AfrzqnXL2xG0bYY8Rm0OoGUh1i6EelCCw9vMdUk87taSvYTw+dCLqjjoB0/U+pfo3YufjRd1Xwdy3JX+36uuFW1/MqPUCQYSqIVC9NbJYuv9ciyXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706294380; c=relaxed/simple;
	bh=Zf4po2lIj74L/2H1x9dpz7ZypE07tj/ZkQxhvMSDimI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCzvACm6F9tP2U9ETOVWWcLfUEeZ2X1zRcM3SN8DJHWTP6lFOTgfyClcez67C9alLdQZFwZMLxpnf6FaGMUG35WyxdivZQaFAWWClFi5TK04qhIh4DWa+n/3gLmxm4lBAvOaTbN2Vq92rmLV5JD/3GA9WzcUfSj9RACVDmKtSBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CtTVhxSm; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5c65ca2e1eeso452474a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 10:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706294378; x=1706899178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHV9AzCH6l6u75fGidc3n6qwYGzVGl876orPWZA6mpw=;
        b=CtTVhxSmoYzNOeFeQe4PY1bFGrB51bfn+jTAhsBDPIkJD24qPJ2xQpazxmlUr5fpR2
         QkaKZZod5ieorCm+wykv/S96kILXJpb4GZZ+vPGrMyUQgCM/0+T7uULz/NCMTo0eeGtl
         uAZFG8bzRhoc3aT16eEiuJtrzLt8nTEWvIFJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706294378; x=1706899178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHV9AzCH6l6u75fGidc3n6qwYGzVGl876orPWZA6mpw=;
        b=SYY+/USIhwXXnGRoOWywd0xrr6XQyfzfWmbd7686xuBEiQxR+yvG662UA7nJgl3Bhg
         YgJqW+jd9cfeuUl7fFcA0IAyBxYl3cnVgg5IC8DqiK3fNqJBEzbVd7N8RDX4dAFq9axM
         H8sW/XGITvq1y8qwj27wGSrxdVUAgklfTK+fg+2AgPv7H2oNyLAPukkUwlPit8uM6vuS
         SajD1Z+Z8Hymayh26i/dpkDO9p1g1bSgHsnvv3Rs6KbJ/O6FFASgM9n5PEJYQKBUVxtU
         ok6AV9qrxmxh3caNeWyoUJOfzfluV5Im6HZsV4Jl7KC6yJTRqXAwrMfxtP8ML1SjztuZ
         Eomg==
X-Gm-Message-State: AOJu0YxrM84u8wRe49hRVTAp8CKHSahCLXQiR5odUobIqBLc5VSwUOVv
	5bRfOaebrg8ZPKbgM3hsvwEY4WVGJImr/8MQnzu1OUKnNPMOCL3Kqwi9KxYRCw==
X-Google-Smtp-Source: AGHT+IGJzKM/7LHkDWwhdEcMQvj3Y2OcI7SiCfcl/LNcdq7TRPU82AhEx8wDF2COYeF11jlgQ5pZKw==
X-Received: by 2002:a05:6a20:6a94:b0:19c:881c:8cf8 with SMTP id bi20-20020a056a206a9400b0019c881c8cf8mr117328pzb.95.1706294378274;
        Fri, 26 Jan 2024 10:39:38 -0800 (PST)
Received: from localhost (209.148.168.34.bc.googleusercontent.com. [34.168.148.209])
        by smtp.gmail.com with UTF8SMTPSA id y17-20020a62f251000000b006dd8643d468sm1382561pfl.193.2024.01.26.10.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 10:39:37 -0800 (PST)
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org
Cc: pmalani@chromium.org,
	jthies@google.com,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Prashanth K <quic_prashk@quicinc.com>,
	Rajaram Regupathy <rajaram.regupathy@intel.com>,
	Saranya Gopal <saranya.gopal@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] usb: typec: ucsi: Limit read size on v1.2
Date: Fri, 26 Jan 2024 10:39:07 -0800
Message-ID: <20240126103859.v3.1.Iacf5570a66b82b73ef03daa6557e2fc0db10266a@changeid>
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

Between UCSI 1.2 and UCSI 2.0, the size of the MESSAGE_IN region was
increased from 16 to 256. In order to avoid overflowing reads for older
systems, add a mechanism to use the read UCSI version to truncate read
sizes on UCSI v1.2.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---
Tested on 6.6 kernel. Dmesg output from this change:
[  105.058162] ucsi_um_test ucsi_um_test_device.0: Registered UCSI
interface with version 3.0.0


(no changes since v2)

Changes in v2:
  - Changed log message to DEBUG

 drivers/usb/typec/ucsi/ucsi.c | 26 ++++++++++++++++++++++++--
 drivers/usb/typec/ucsi/ucsi.h | 11 +++++++++++
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 5392ec698959..a35056ee3e96 100644
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
@@ -1556,6 +1569,15 @@ int ucsi_register(struct ucsi *ucsi)
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
2.43.0.429.g432eaa2c6b-goog


