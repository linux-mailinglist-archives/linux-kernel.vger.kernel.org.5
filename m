Return-Path: <linux-kernel+bounces-96255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9C1875958
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5DA1F2584A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAEE1420BE;
	Thu,  7 Mar 2024 21:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Rsrjbrp7"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FB31420D2
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 21:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709847010; cv=none; b=mbsmZ5isloUllW8J+ciGm3V1zeEtrlXV3A8TN/G2mT0e1JwZPc12BZsAUF8VDkALgRLB5KSOdYoyvRnz8Snm3hzFBqxt28G5jM9n26Zee2SKrnRzNAW+q76x0Ctd0ZZN4QjXadFTfk7Uk7GgEGlonLGpIZd5/jZo7ZQ7Yl5C/jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709847010; c=relaxed/simple;
	bh=lpRUzQy6rpCSFDFB+osQZMOAQgUTdaMMxsMeqUa1X4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FHNfvLO56mm+KWOuXTgYKmA4csQRfEa6J4N2fM3UTeWxM9P8NcwpL8h3AOxqOFY4WroNF/pIsbDmDZ9rFPba7VSFUXq8jtl1CQSGW/d9MzCnZeMikFu7diQxR7F8L62roItw3cz0S2BiLEoURWSFyAi7LBS+fF/pqZSAYvv6/2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Rsrjbrp7; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so1062983a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 13:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1709847008; x=1710451808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0waJ47R+uSUCH37mqcNc/cfYdRCKt9nVzYgKPVRqq0I=;
        b=Rsrjbrp77xgQcZt8XUCEQiqRU+glLwNsCxz86BKeoRj7pWe/qUf534UIXc9fhdHlgy
         xKqnzb3JIh7CTuO5uTERctA/0jE52NmwJR4oBCDkhR/2SP1FrSid2Oz2XXvJG6XZ8/Rv
         V2MxPbNZG1NGRUoZzHHFq9AIyUHpvfb0YuFIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709847008; x=1710451808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0waJ47R+uSUCH37mqcNc/cfYdRCKt9nVzYgKPVRqq0I=;
        b=HKT8mxgeWl6V81lAMC0L2rCJrY/RQgvGuaT/+Q/WP1jig6BGf430V+ZPBVwru5tS+W
         J8xVfD+BO6Jq68Oo9gftuG6cOhrYe0fIxm3RZbeqB7DeNT/2Wgj5/Ya1SMFZGxRRc9s4
         ahX/DL6DKlBf5xrjN+ircVXYcRjagY/oiYsTUCPxWCSS6TQ5h0RjkKZqGPljvnBORAYs
         UyGWpPdfYgcRBcsqN9HmNBZn8m2vSbWtnXgHx8JX0S3cPhI76K/U3uLQcJFL6RaJD3e1
         I4bziL+HhgDRc9fcGg9+WB+D5dgXC5VrxziRN0STHeDo6FHkvZaOO799Dw5cGwFHOZH2
         OZZQ==
X-Gm-Message-State: AOJu0YxaPgMqHltfLxZ15fFivyWY0ChMdAgjz7CpdmUnQp3abtLKUJmW
	otj2aaRwwGD0jbdK8aTksMZtt/Md/38mr3P10lyOhXZ82w5B5Vn8c91Q9SkuUDXGDc09H5+hguz
	D87BNgYDOFsmbNRYp1NEIU5IdEEwTnd6D5BsBc1ATe7bdXlmFQVrkyLLk6J2ZlLJWGl27JaAXSE
	38SEnwIAY9MGNpQuFRNVQjz81i2jmJSq3orNdAkjdnUzql6MttTO3n
X-Google-Smtp-Source: AGHT+IF+eZWMzP828aOjCUuvhjlu3p9V7RmoCTtS84xZPzIQU2Key+q+Kn3e2uzSKSrbommHMLrHCQ==
X-Received: by 2002:a17:90a:408f:b0:299:275d:c346 with SMTP id l15-20020a17090a408f00b00299275dc346mr6013496pjg.5.1709847007624;
        Thu, 07 Mar 2024 13:30:07 -0800 (PST)
Received: from amakhalov-build-vm.eng.vmware.com ([64.186.27.43])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090abd0c00b00299db19a81asm1991021pjr.56.2024.03.07.13.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 13:30:07 -0800 (PST)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	tglx@linutronix.de
Cc: x86@kernel.org,
	netdev@vger.kernel.org,
	richardcochran@gmail.com,
	linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	zackr@vmware.com,
	linux-graphics-maintainer@vmware.com,
	pv-drivers@vmware.com,
	namit@vmware.com,
	timothym@vmware.com,
	akaher@vmware.com,
	jsipek@vmware.com,
	dri-devel@lists.freedesktop.org,
	daniel@ffwll.ch,
	airlied@gmail.com,
	tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	horms@kernel.org,
	kirill.shutemov@linux.intel.com
Subject: [PATCH v7 4/7] input/vmmouse: Use VMware hypercall API
Date: Thu,  7 Mar 2024 13:29:46 -0800
Message-Id: <20240307212949.4166120-5-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240307212949.4166120-1-alexey.makhalov@broadcom.com>
References: <20240307212949.4166120-1-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexey Makhalov <amakhalov@vmware.com>

Switch from VMWARE_HYPERCALL macro to vmware_hypercall API.
Eliminate arch specific code. No functional changes intended.

Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Nadav Amit <namit@vmware.com>
Reviewed-by: Zack Rusin <zackr@vmware.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/vmmouse.c | 78 ++++++++++-------------------------
 1 file changed, 22 insertions(+), 56 deletions(-)

diff --git a/drivers/input/mouse/vmmouse.c b/drivers/input/mouse/vmmouse.c
index ad94c835ee66..fb1d986a6895 100644
--- a/drivers/input/mouse/vmmouse.c
+++ b/drivers/input/mouse/vmmouse.c
@@ -21,19 +21,16 @@
 #include "psmouse.h"
 #include "vmmouse.h"
 
-#define VMMOUSE_PROTO_MAGIC			0x564D5868U
-
 /*
  * Main commands supported by the vmmouse hypervisor port.
  */
-#define VMMOUSE_PROTO_CMD_GETVERSION		10
-#define VMMOUSE_PROTO_CMD_ABSPOINTER_DATA	39
-#define VMMOUSE_PROTO_CMD_ABSPOINTER_STATUS	40
-#define VMMOUSE_PROTO_CMD_ABSPOINTER_COMMAND	41
-#define VMMOUSE_PROTO_CMD_ABSPOINTER_RESTRICT   86
+#define VMWARE_CMD_ABSPOINTER_DATA	39
+#define VMWARE_CMD_ABSPOINTER_STATUS	40
+#define VMWARE_CMD_ABSPOINTER_COMMAND	41
+#define VMWARE_CMD_ABSPOINTER_RESTRICT	86
 
 /*
- * Subcommands for VMMOUSE_PROTO_CMD_ABSPOINTER_COMMAND
+ * Subcommands for VMWARE_CMD_ABSPOINTER_COMMAND
  */
 #define VMMOUSE_CMD_ENABLE			0x45414552U
 #define VMMOUSE_CMD_DISABLE			0x000000f5U
@@ -76,30 +73,6 @@ struct vmmouse_data {
 	char dev_name[128];
 };
 
-/*
- * Hypervisor-specific bi-directional communication channel
- * implementing the vmmouse protocol. Should never execute on
- * bare metal hardware.
- */
-#define VMMOUSE_CMD(cmd, in1, out1, out2, out3, out4)	\
-({							\
-	unsigned long __dummy1, __dummy2;		\
-	__asm__ __volatile__ (VMWARE_HYPERCALL :	\
-		"=a"(out1),				\
-		"=b"(out2),				\
-		"=c"(out3),				\
-		"=d"(out4),				\
-		"=S"(__dummy1),				\
-		"=D"(__dummy2) :			\
-         [port] "i" (VMWARE_HYPERVISOR_PORT),		\
-         [mode] "m" (vmware_hypercall_mode),		\
-		"a"(VMMOUSE_PROTO_MAGIC),		\
-		"b"(in1),				\
-		"c"(VMMOUSE_PROTO_CMD_##cmd),		\
-		"d"(0) :			        \
-		"memory");		                \
-})
-
 /**
  * vmmouse_report_button - report button state on the correct input device
  *
@@ -147,14 +120,12 @@ static psmouse_ret_t vmmouse_report_events(struct psmouse *psmouse)
 	struct input_dev *abs_dev = priv->abs_dev;
 	struct input_dev *pref_dev;
 	u32 status, x, y, z;
-	u32 dummy1, dummy2, dummy3;
 	unsigned int queue_length;
 	unsigned int count = 255;
 
 	while (count--) {
 		/* See if we have motion data. */
-		VMMOUSE_CMD(ABSPOINTER_STATUS, 0,
-			    status, dummy1, dummy2, dummy3);
+		status = vmware_hypercall1(VMWARE_CMD_ABSPOINTER_STATUS, 0);
 		if ((status & VMMOUSE_ERROR) == VMMOUSE_ERROR) {
 			psmouse_err(psmouse, "failed to fetch status data\n");
 			/*
@@ -174,7 +145,8 @@ static psmouse_ret_t vmmouse_report_events(struct psmouse *psmouse)
 		}
 
 		/* Now get it */
-		VMMOUSE_CMD(ABSPOINTER_DATA, 4, status, x, y, z);
+		status = vmware_hypercall4(VMWARE_CMD_ABSPOINTER_DATA, 4,
+					   &x, &y, &z);
 
 		/*
 		 * And report what we've got. Prefer to report button
@@ -249,14 +221,10 @@ static psmouse_ret_t vmmouse_process_byte(struct psmouse *psmouse)
 static void vmmouse_disable(struct psmouse *psmouse)
 {
 	u32 status;
-	u32 dummy1, dummy2, dummy3, dummy4;
-
-	VMMOUSE_CMD(ABSPOINTER_COMMAND, VMMOUSE_CMD_DISABLE,
-		    dummy1, dummy2, dummy3, dummy4);
 
-	VMMOUSE_CMD(ABSPOINTER_STATUS, 0,
-		    status, dummy1, dummy2, dummy3);
+	vmware_hypercall1(VMWARE_CMD_ABSPOINTER_COMMAND, VMMOUSE_CMD_DISABLE);
 
+	status = vmware_hypercall1(VMWARE_CMD_ABSPOINTER_STATUS, 0);
 	if ((status & VMMOUSE_ERROR) != VMMOUSE_ERROR)
 		psmouse_warn(psmouse, "failed to disable vmmouse device\n");
 }
@@ -273,26 +241,24 @@ static void vmmouse_disable(struct psmouse *psmouse)
 static int vmmouse_enable(struct psmouse *psmouse)
 {
 	u32 status, version;
-	u32 dummy1, dummy2, dummy3, dummy4;
 
 	/*
 	 * Try enabling the device. If successful, we should be able to
 	 * read valid version ID back from it.
 	 */
-	VMMOUSE_CMD(ABSPOINTER_COMMAND, VMMOUSE_CMD_ENABLE,
-		    dummy1, dummy2, dummy3, dummy4);
+	vmware_hypercall1(VMWARE_CMD_ABSPOINTER_COMMAND, VMMOUSE_CMD_ENABLE);
 
 	/*
 	 * See if version ID can be retrieved.
 	 */
-	VMMOUSE_CMD(ABSPOINTER_STATUS, 0, status, dummy1, dummy2, dummy3);
+	status = vmware_hypercall1(VMWARE_CMD_ABSPOINTER_STATUS, 0);
 	if ((status & 0x0000ffff) == 0) {
 		psmouse_dbg(psmouse, "empty flags - assuming no device\n");
 		return -ENXIO;
 	}
 
-	VMMOUSE_CMD(ABSPOINTER_DATA, 1 /* single item */,
-		    version, dummy1, dummy2, dummy3);
+	version = vmware_hypercall1(VMWARE_CMD_ABSPOINTER_DATA,
+				    1 /* single item */);
 	if (version != VMMOUSE_VERSION_ID) {
 		psmouse_dbg(psmouse, "Unexpected version value: %u vs %u\n",
 			    (unsigned) version, VMMOUSE_VERSION_ID);
@@ -303,11 +269,11 @@ static int vmmouse_enable(struct psmouse *psmouse)
 	/*
 	 * Restrict ioport access, if possible.
 	 */
-	VMMOUSE_CMD(ABSPOINTER_RESTRICT, VMMOUSE_RESTRICT_CPL0,
-		    dummy1, dummy2, dummy3, dummy4);
+	vmware_hypercall1(VMWARE_CMD_ABSPOINTER_RESTRICT,
+			  VMMOUSE_RESTRICT_CPL0);
 
-	VMMOUSE_CMD(ABSPOINTER_COMMAND, VMMOUSE_CMD_REQUEST_ABSOLUTE,
-		    dummy1, dummy2, dummy3, dummy4);
+	vmware_hypercall1(VMWARE_CMD_ABSPOINTER_COMMAND,
+			  VMMOUSE_CMD_REQUEST_ABSOLUTE);
 
 	return 0;
 }
@@ -344,7 +310,7 @@ static bool vmmouse_check_hypervisor(void)
  */
 int vmmouse_detect(struct psmouse *psmouse, bool set_properties)
 {
-	u32 response, version, dummy1, dummy2;
+	u32 response, version, type;
 
 	if (!vmmouse_check_hypervisor()) {
 		psmouse_dbg(psmouse,
@@ -353,9 +319,9 @@ int vmmouse_detect(struct psmouse *psmouse, bool set_properties)
 	}
 
 	/* Check if the device is present */
-	response = ~VMMOUSE_PROTO_MAGIC;
-	VMMOUSE_CMD(GETVERSION, 0, version, response, dummy1, dummy2);
-	if (response != VMMOUSE_PROTO_MAGIC || version == 0xffffffffU)
+	response = ~VMWARE_HYPERVISOR_MAGIC;
+	version = vmware_hypercall3(VMWARE_CMD_GETVERSION, 0, &response, &type);
+	if (response != VMWARE_HYPERVISOR_MAGIC || version == 0xffffffffU)
 		return -ENXIO;
 
 	if (set_properties) {
-- 
2.39.0


