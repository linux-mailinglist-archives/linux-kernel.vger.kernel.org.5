Return-Path: <linux-kernel+bounces-118170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFEA88B567
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 418751C37AEE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBEB84D19;
	Mon, 25 Mar 2024 23:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X7r7327u"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F145A83A0C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 23:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711409853; cv=none; b=CadcDT2PGtF3/trhuw1fY5hg0jkO0oyiTDqJkjOTxLD8VqtpBuOtD058R7n/H0IIFInvKSLIJrMicQ3+DXhdGo78Z0vpTcf0e2cDEQv0mT4FY7tZPBL+xcHHJXO31VrWdsNgJZIURCUeSWpq5RAo5TuMoC8yv+f/0GzrDPnXBVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711409853; c=relaxed/simple;
	bh=SeQce1gFW0K6iI86gWi0GbaKVMdi8pBaBD+m2qO3U+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nlXGHYpRTNnj7fybIHVX3zdGJLalq51cmHG3BxVBvZ1dp/Jobrzv27yLy+E0/xpOGpTPsRzLXxpcqZCWJJz9tboaMEquBAgYjMG0PF3GnVaW26tuH76IHnj1LKG9q1F6FhM37Hfm1pzGfQ8QnYXzoyUvS+GJOHAqKizhUakZcE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X7r7327u; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5ce2aada130so3478519a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711409851; x=1712014651; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xjzk4UlrSrkiNY4MQm3fy1SXk2w8u62oB9H2yAhe2y4=;
        b=X7r7327ukCopXcNDVK5Zb4vPn01or3mfsbQJVThzsCR4RaUN16cfmGB2A+POmU/xZt
         efQTLa7jh7BFElW4wcvYvFiUwghSXXeu3W6TOSCYSeuCtu2edjrwobWA+2oRgZS+r+YZ
         ACFzjkgbpQmXQm0S9U9V5dIN2Uf/AfrBZ6unI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711409851; x=1712014651;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xjzk4UlrSrkiNY4MQm3fy1SXk2w8u62oB9H2yAhe2y4=;
        b=gEy2GyuBB8HmezSGOgVF50Eh8Bb7XfcS8yaEt4+189eRIKkZ7sXLsW3SEDdor9ikF2
         BeL0d1TCf6ZCFGXmAMKXB0/Ed2V3VSpreaXxtQEHRQNTe7bDGmcJoQVPE7V/5pTeEea+
         BsqiVfF3gGHLXWhnf2sPcCeiBirhFSnWjwVbVMGiQ343IZ/KoUkIFK+CbBY9Qugdk4BQ
         Iyk+QrRi2K0TckWb1Lk4GuUxxG5pWGUcYfHfyzSJ8jaCUYbRT/OXq2yCWbIoQFD9rMy/
         AKifSMpfZ67bXNp0p1hwbdFIUzfUlIm7L5DG+MMH+LWerIiZTngURH40pe02ufsWMeIP
         2UUw==
X-Gm-Message-State: AOJu0Ywy35wCJoA38WU2ILZ33tBLM9bmcmcpfLX7umEdOW26JscfPt4I
	zTwqITuggj8pRnro0WZPgeZSP8ESdwOshTy64VBHzKsC2hApApAejxJtu74btA==
X-Google-Smtp-Source: AGHT+IHos6yf4HEDXfACT1evg6Afi/lraKi98CPeCOt8FPOl7GJNXA8bS1mUPTItrMx+IQRMRVEKUQ==
X-Received: by 2002:a05:6a20:7491:b0:1a3:c96e:be07 with SMTP id p17-20020a056a20749100b001a3c96ebe07mr1575943pzd.61.1711409851327;
        Mon, 25 Mar 2024 16:37:31 -0700 (PDT)
Received: from pholla1.c.googlers.com (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with ESMTPSA id c14-20020a170903234e00b001e0e2fde71fsm526533plh.9.2024.03.25.16.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 16:37:30 -0700 (PDT)
From: Pavan Holla <pholla@chromium.org>
Date: Mon, 25 Mar 2024 23:37:28 +0000
Subject: [PATCH 1/3] usb: typec: ucsi: Provide interface for UCSI transport
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240325-public-ucsi-h-v1-1-7c7e888edc0a@chromium.org>
References: <20240325-public-ucsi-h-v1-0-7c7e888edc0a@chromium.org>
In-Reply-To: <20240325-public-ucsi-h-v1-0-7c7e888edc0a@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, 
 Pavan Holla <pholla@chromium.org>
X-Mailer: b4 0.12.4

The ucsi.h include can be used by driver implementations that
provide transport for UCSI commands.

Signed-off-by: Pavan Holla <pholla@chromium.org>
---
 MAINTAINERS              |  1 +
 include/linux/usb/ucsi.h | 66 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa3b947fb080..e799d67a8fa5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22987,6 +22987,7 @@ F:	Documentation/ABI/testing/sysfs-class-typec
 F:	Documentation/driver-api/usb/typec.rst
 F:	drivers/usb/typec/
 F:	include/linux/usb/typec.h
+F:	include/linux/usb/ucsi.h
 
 USB TYPEC INTEL PMC MUX DRIVER
 M:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
diff --git a/include/linux/usb/ucsi.h b/include/linux/usb/ucsi.h
new file mode 100644
index 000000000000..3ec1db968070
--- /dev/null
+++ b/include/linux/usb/ucsi.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __LINUX_USB_UCSI_H
+#define __LINUX_USB_UCSI_H
+
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/types.h>
+
+/* -------------------------------------------------------------------------- */
+
+struct ucsi;
+struct ucsi_altmode;
+
+/* UCSI offsets (Bytes) */
+#define UCSI_VERSION			0
+#define UCSI_CCI			4
+#define UCSI_CONTROL			8
+#define UCSI_MESSAGE_IN			16
+#define UCSI_MESSAGE_OUT		32
+#define UCSIv2_MESSAGE_OUT		272
+
+/* Command Status and Connector Change Indication (CCI) bits */
+#define UCSI_CCI_CONNECTOR(_c_)		(((_c_) & GENMASK(7, 1)) >> 1)
+#define UCSI_CCI_LENGTH(_c_)		(((_c_) & GENMASK(15, 8)) >> 8)
+#define UCSI_CCI_NOT_SUPPORTED		BIT(25)
+#define UCSI_CCI_CANCEL_COMPLETE	BIT(26)
+#define UCSI_CCI_RESET_COMPLETE		BIT(27)
+#define UCSI_CCI_BUSY			BIT(28)
+#define UCSI_CCI_ACK_COMPLETE		BIT(29)
+#define UCSI_CCI_ERROR			BIT(30)
+#define UCSI_CCI_COMMAND_COMPLETE	BIT(31)
+
+/**
+ * struct ucsi_operations - UCSI I/O operations
+ * @read: Read operation
+ * @sync_write: Blocking write operation
+ * @async_write: Non-blocking write operation
+ * @update_altmodes: Squashes duplicate DP altmodes
+ *
+ * Read and write routines for UCSI interface. @sync_write must wait for the
+ * Command Completion Event from the PPM before returning, and @async_write must
+ * return immediately after sending the data to the PPM.
+ */
+struct ucsi_operations {
+	int (*read)(struct ucsi *ucsi, unsigned int offset,
+		    void *val, size_t val_len);
+	int (*sync_write)(struct ucsi *ucsi, unsigned int offset,
+			  const void *val, size_t val_len);
+	int (*async_write)(struct ucsi *ucsi, unsigned int offset,
+			   const void *val, size_t val_len);
+	bool (*update_altmodes)(struct ucsi *ucsi, struct ucsi_altmode *orig,
+				struct ucsi_altmode *updated);
+};
+
+struct ucsi *ucsi_create(struct device *dev, const struct ucsi_operations *ops);
+void ucsi_destroy(struct ucsi *ucsi);
+int ucsi_register(struct ucsi *ucsi);
+void ucsi_unregister(struct ucsi *ucsi);
+int ucsi_resume(struct ucsi *ucsi);
+void *ucsi_get_drvdata(struct ucsi *ucsi);
+void ucsi_set_drvdata(struct ucsi *ucsi, void *data);
+
+void ucsi_connector_change(struct ucsi *ucsi, u8 num);
+
+#endif /* __LINUX_USB_UCSI_H */

-- 
2.44.0.396.g6e790dbe36-goog


