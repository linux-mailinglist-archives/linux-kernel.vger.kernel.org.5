Return-Path: <linux-kernel+bounces-122060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A84B88F15F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD1AA1F29878
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1779815357C;
	Wed, 27 Mar 2024 21:53:23 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B91C14F9E4
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 21:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711576402; cv=none; b=kvF46SwDAhX8Vtd/9PPd1seV8NJysmefWul+vLvvYXt3q8aJZPcpMhSbmEXfuN7HmKRL0DBUt1uFIQYW/DvCl2nGa2c2SHUfSf9lQxpsPiVtTud3kbk+F3m8qmOu+wmgX9+N0uqEc3t+TvLvhERIr6/GZ5dJCgbnrxJkejWywmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711576402; c=relaxed/simple;
	bh=2v7wc9fQwYf7d5X1GIFIUQt0lyBTBGde+QP7rENxUrY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OV1E7A/VTcwhLcZJYEqKb9WKibL24QAcLCpUR1yKcsUacxvLGxoxfi4ehnI2OyVV8+FeyTom0eOsq2UNLa0SR/ij9+F7QXfwYEebVTOc55U6uPS8SfNtp+9C452JDzLYfc0cGzT+Pdl4mT7pSZ4uZDVDYmnoujZYhqFDyKRigbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 4324b3c1-ec84-11ee-b972-005056bdfda7;
	Wed, 27 Mar 2024 23:52:10 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Armin Wolf <W_Armin@gmx.de>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v1 1/1] platform/x86: quickstart: Miscellaneous improvements
Date: Wed, 27 Mar 2024 23:52:08 +0200
Message-ID: <20240327215208.649020-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a mix of a few improvements to the driver.
I have done this instead of review, so it can quickly be
folded into the original code (partially or fully).

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/platform/x86/quickstart.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/quickstart.c b/drivers/platform/x86/quickstart.c
index ba3a7a25dda70..f686942662ccc 100644
--- a/drivers/platform/x86/quickstart.c
+++ b/drivers/platform/x86/quickstart.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * quickstart.c - ACPI Direct App Launch driver
+ * ACPI Direct App Launch driver
  *
  * Copyright (C) 2024 Armin Wolf <W_Armin@gmx.de>
  * Copyright (C) 2022 Arvid Norlander <lkml@vorapal.se>
@@ -10,15 +10,18 @@
  * <https://archive.org/details/microsoft-acpi-dirapplaunch>
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
-#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm_wakeup.h>
+#include <linux/printk.h>
+#include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
 
@@ -165,7 +168,8 @@ static int quickstart_probe(struct platform_device *pdev)
 	data->dev = &pdev->dev;
 	dev_set_drvdata(&pdev->dev, data);
 
-	/* We have to initialize the device wakeup before evaluating GHID because
+	/*
+	 * We have to initialize the device wakeup before evaluating GHID because
 	 * doing so will notify the device if the button was used to wake the machine
 	 * from S5.
 	 */
@@ -202,7 +206,7 @@ static int quickstart_probe(struct platform_device *pdev)
 }
 
 static const struct acpi_device_id quickstart_device_ids[] = {
-	{ "PNP0C32", 0 },
+	{ "PNP0C32" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, quickstart_device_ids);
-- 
2.44.0


