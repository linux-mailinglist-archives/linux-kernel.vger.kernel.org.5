Return-Path: <linux-kernel+bounces-118178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8E988B57E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 580FA1F61BFF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D7A1272AA;
	Mon, 25 Mar 2024 23:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PyQqCp2e"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C97D83CA8
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 23:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711410151; cv=none; b=JkQVvwNjk7rL3BUNR8izp5hAoyVh2EOcBD1k14cFDZQIkcAQ7YhAK/5MLl9MLvc0ThwJ/Kpdp5YCYKfGD8/Fd+BBe5jWC8DK+Rwg2PwWdc9IgNdp6GVhzk2SN3wFratUI9EwmXQSNiGvNY6CeucQEKFzMyZeaeoGzylKDLosSos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711410151; c=relaxed/simple;
	bh=SeQce1gFW0K6iI86gWi0GbaKVMdi8pBaBD+m2qO3U+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pb+sKVpHdMv2tlvYd4JOfXRxAg3ScZYw/r+sR8+cPT9H6c38lrLvGw4TAORqsMMLlxuFfbNA7WC6RUcIZOVU0j9nYz0dcUcMO7JpBVR92RaT4KtON9FH2C+mYR6Fi5zMR6VzA0aTQznBWtyGexEqVQoEYp6Cqs4YZAg2ZeBOT2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PyQqCp2e; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-229cbc52318so2200477fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711410147; x=1712014947; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xjzk4UlrSrkiNY4MQm3fy1SXk2w8u62oB9H2yAhe2y4=;
        b=PyQqCp2e6majR5vcCF9NFxrZr+aDMsxcvAS6xCuJ2WOx2DmmI3MRCImR11vdk2wwIV
         3a++VYPAuwVjsza2Ulb/pV0O8loovqd55qCUrHqVHKy26zFagy7nAvAeVlaJQOD2MPmK
         TQV6plS8kUy3rl3YPnza+0v8ilGvsaAlRclG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711410147; x=1712014947;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xjzk4UlrSrkiNY4MQm3fy1SXk2w8u62oB9H2yAhe2y4=;
        b=fATm/mhfP+Uz35Bg8iafnXFWwPKZqEanEAgdsVPFCEphT+81hYL3/M+Z52CTrGlTse
         39Sl1qR14CwicmcCKV2UceYkKwgWXM6ueFhFFTQvFP+SqRF98ci+9e0c77XnTOEJ5wWx
         XoFOB4qd0heUf8ZRoG31Yn7oWrfgh+k/TbqBuUnDSpKF6dY/iJF7mir/rKs6DafBFllK
         EfthBFdlG5ledas3/ro/BYtvs7HRVDRmgv34K1qSaK4XNk7JZjnTGhnUmxONv5Y7ML8f
         S7Ak05MK5s0trIq7doYhSMw+MRulwjYRdQ6MWRqSQ4pJZSRtX+GeXuuukWkFaEJsu54i
         ly5g==
X-Gm-Message-State: AOJu0Yw++d79WbsPKLF+JxF3A0mLhqAYdYmlXqgFLN4wQJjTzDV3oTLm
	CiMw467u6jcR5VieliFkSGLY6guBPaKNDoL0ocL3pPE73QaHkllKR8TG1PXZKw==
X-Google-Smtp-Source: AGHT+IHOQHJIiFr3Qyf80KKrpxpe99WiMfSTkA4PVy4Z9qbl88vOkaegWkYPoXJ3Lr2DgnAnuU9Neg==
X-Received: by 2002:a05:6870:c689:b0:229:87f6:ee8a with SMTP id cv9-20020a056870c68900b0022987f6ee8amr9631946oab.30.1711410147426;
        Mon, 25 Mar 2024 16:42:27 -0700 (PDT)
Received: from pholla1.c.googlers.com (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with ESMTPSA id e12-20020aa7824c000000b006e5f754646csm4705250pfn.139.2024.03.25.16.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 16:42:27 -0700 (PDT)
From: Pavan Holla <pholla@chromium.org>
Date: Mon, 25 Mar 2024 23:42:25 +0000
Subject: [PATCH v2 1/3] usb: typec: ucsi: Provide interface for UCSI
 transport
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240325-public-ucsi-h-v2-1-a6d716968bb1@chromium.org>
References: <20240325-public-ucsi-h-v2-0-a6d716968bb1@chromium.org>
In-Reply-To: <20240325-public-ucsi-h-v2-0-a6d716968bb1@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Guenter Roeck <groeck@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, 
 chrome-platform@lists.linux.dev, Pavan Holla <pholla@chromium.org>
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


