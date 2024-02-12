Return-Path: <linux-kernel+bounces-61843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F07F851756
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 545171C21567
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925693CF4C;
	Mon, 12 Feb 2024 14:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jCh3ZlbA"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A193CF40;
	Mon, 12 Feb 2024 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707749493; cv=none; b=kd27ijvdO//p/m+GTpzhpFiofBkMpwY/TCHpr3LhKhQQBfBpiGJcDwi/9GrhNmjqX+Jko7ywyOqT6bgk/0vp8g3GRHYScwjjpuXHz6XyELztbodcNU/0SOA/EJUla85qRwhxrYBE7bSRvTLOx/CtUIf20WcHinBUw2NCnyLZXiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707749493; c=relaxed/simple;
	bh=2YazRus17kIzAJnZt/Xcx5DkIWkxOxNttVVGwgfNxTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JXX3k2ww6r6PE0cscsPGKzFCcmddml8ZpnYkp5lNIWmnZZMUBhDy9J7vx1pWUVsRtHGXP+DYBquDsFlD2fq4+Nl4BQOGDnMLXWwP/RDKYsjbyg+0ZPUTwl1ketHu/Q7BBYtQmtKl8V3eRoBgqA9L93gw3IH/PZxdb2XBsG7Pb3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jCh3ZlbA; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707749489;
	bh=2YazRus17kIzAJnZt/Xcx5DkIWkxOxNttVVGwgfNxTY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jCh3ZlbAWxcEHTFfj5OiAFAso89vXFUCdMfUZqDWIPseDllYp/WgvIN9bATtwLl83
	 RTCSEem/cOIhHvdMz9aEwFrtEvESaUkg4RKNkvjK+6m+p90ADLFoSjxtCW7h5L3WcC
	 2x10zi3CWnek0QCaQPNxqBVnsiCB7mxJDb3a1Fayy3JljwWgXaqACLQ4eCwTFnhC6/
	 89GyFxcYdEeK+3AueFqyy3Zmg1G3vE5+F2RxWHR03XOLQAmDzkblkb7NyjlsOBB6EX
	 aBNL89HbdtVss8OBJDHpotNii13wkHK2icQER2iXjrgAkUCxyiU3PKR0XFJadyum3g
	 AqgW5hG6lzuLg==
Received: from [192.168.1.30] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 931A33780C22;
	Mon, 12 Feb 2024 14:51:26 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 12 Feb 2024 09:50:07 -0500
Subject: [PATCH v4 3/4] firmware: coreboot: Replace tag with id table in
 driver struct
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240212-coreboot-mod-defconfig-v4-3-d14172676f6d@collabora.com>
References: <20240212-coreboot-mod-defconfig-v4-0-d14172676f6d@collabora.com>
In-Reply-To: <20240212-coreboot-mod-defconfig-v4-0-d14172676f6d@collabora.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Brian Norris <briannorris@chromium.org>, 
 Julius Werner <jwerner@chromium.org>, 
 Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@collabora.com, 
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.12.4

Switch the plain 'tag' field in struct coreboot_driver for the newly
created coreboot_device_id struct, which also contains a tag field and
has the benefit of allowing modalias generation, and update all coreboot
drivers accordingly.

While at it, also add the id table for each driver to the module device
table to allow automatically loading the module.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/firmware/google/cbmem.c                |  8 +++++++-
 drivers/firmware/google/coreboot_table.c       | 11 ++++++++++-
 drivers/firmware/google/coreboot_table.h       |  3 ++-
 drivers/firmware/google/framebuffer-coreboot.c |  8 +++++++-
 drivers/firmware/google/memconsole-coreboot.c  |  8 +++++++-
 drivers/firmware/google/vpd.c                  |  8 +++++++-
 6 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/google/cbmem.c b/drivers/firmware/google/cbmem.c
index 88e587ba1e0d..c2bffdc352a3 100644
--- a/drivers/firmware/google/cbmem.c
+++ b/drivers/firmware/google/cbmem.c
@@ -114,6 +114,12 @@ static int cbmem_entry_probe(struct coreboot_device *dev)
 	return 0;
 }
 
+static const struct coreboot_device_id cbmem_ids[] = {
+	{ .tag = LB_TAG_CBMEM_ENTRY },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(coreboot, cbmem_ids);
+
 static struct coreboot_driver cbmem_entry_driver = {
 	.probe = cbmem_entry_probe,
 	.drv = {
@@ -121,7 +127,7 @@ static struct coreboot_driver cbmem_entry_driver = {
 		.owner = THIS_MODULE,
 		.dev_groups = dev_groups,
 	},
-	.tag = LB_TAG_CBMEM_ENTRY,
+	.id_table = cbmem_ids,
 };
 module_coreboot_driver(cbmem_entry_driver);
 
diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
index c1b9a9e8e8ed..33971cf33112 100644
--- a/drivers/firmware/google/coreboot_table.c
+++ b/drivers/firmware/google/coreboot_table.c
@@ -28,8 +28,17 @@ static int coreboot_bus_match(struct device *dev, struct device_driver *drv)
 {
 	struct coreboot_device *device = CB_DEV(dev);
 	struct coreboot_driver *driver = CB_DRV(drv);
+	const struct coreboot_device_id *id;
 
-	return device->entry.tag == driver->tag;
+	if (!driver->id_table)
+		return 0;
+
+	for (id = driver->id_table; id->tag; id++) {
+		if (device->entry.tag == id->tag)
+			return 1;
+	}
+
+	return 0;
 }
 
 static int coreboot_bus_probe(struct device *dev)
diff --git a/drivers/firmware/google/coreboot_table.h b/drivers/firmware/google/coreboot_table.h
index d814dca33a08..86427989c57f 100644
--- a/drivers/firmware/google/coreboot_table.h
+++ b/drivers/firmware/google/coreboot_table.h
@@ -13,6 +13,7 @@
 #define __COREBOOT_TABLE_H
 
 #include <linux/device.h>
+#include <linux/mod_devicetable.h>
 
 /* Coreboot table header structure */
 struct coreboot_table_header {
@@ -93,7 +94,7 @@ struct coreboot_driver {
 	int (*probe)(struct coreboot_device *);
 	void (*remove)(struct coreboot_device *);
 	struct device_driver drv;
-	u32 tag;
+	const struct coreboot_device_id *id_table;
 };
 
 /* Register a driver that uses the data from a coreboot table. */
diff --git a/drivers/firmware/google/framebuffer-coreboot.c b/drivers/firmware/google/framebuffer-coreboot.c
index 5c84bbebfef8..07c458bf64ec 100644
--- a/drivers/firmware/google/framebuffer-coreboot.c
+++ b/drivers/firmware/google/framebuffer-coreboot.c
@@ -80,13 +80,19 @@ static void framebuffer_remove(struct coreboot_device *dev)
 	platform_device_unregister(pdev);
 }
 
+static const struct coreboot_device_id framebuffer_ids[] = {
+	{ .tag = CB_TAG_FRAMEBUFFER },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(coreboot, framebuffer_ids);
+
 static struct coreboot_driver framebuffer_driver = {
 	.probe = framebuffer_probe,
 	.remove = framebuffer_remove,
 	.drv = {
 		.name = "framebuffer",
 	},
-	.tag = CB_TAG_FRAMEBUFFER,
+	.id_table = framebuffer_ids,
 };
 module_coreboot_driver(framebuffer_driver);
 
diff --git a/drivers/firmware/google/memconsole-coreboot.c b/drivers/firmware/google/memconsole-coreboot.c
index 74b5286518ee..24c97a70aa80 100644
--- a/drivers/firmware/google/memconsole-coreboot.c
+++ b/drivers/firmware/google/memconsole-coreboot.c
@@ -96,13 +96,19 @@ static void memconsole_remove(struct coreboot_device *dev)
 	memconsole_exit();
 }
 
+static const struct coreboot_device_id memconsole_ids[] = {
+	{ .tag = CB_TAG_CBMEM_CONSOLE },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(coreboot, memconsole_ids);
+
 static struct coreboot_driver memconsole_driver = {
 	.probe = memconsole_probe,
 	.remove = memconsole_remove,
 	.drv = {
 		.name = "memconsole",
 	},
-	.tag = CB_TAG_CBMEM_CONSOLE,
+	.id_table = memconsole_ids,
 };
 module_coreboot_driver(memconsole_driver);
 
diff --git a/drivers/firmware/google/vpd.c b/drivers/firmware/google/vpd.c
index ee6e08c0592b..8e4216714b29 100644
--- a/drivers/firmware/google/vpd.c
+++ b/drivers/firmware/google/vpd.c
@@ -306,13 +306,19 @@ static void vpd_remove(struct coreboot_device *dev)
 	kobject_put(vpd_kobj);
 }
 
+static const struct coreboot_device_id vpd_ids[] = {
+	{ .tag = CB_TAG_VPD },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(coreboot, vpd_ids);
+
 static struct coreboot_driver vpd_driver = {
 	.probe = vpd_probe,
 	.remove = vpd_remove,
 	.drv = {
 		.name = "vpd",
 	},
-	.tag = CB_TAG_VPD,
+	.id_table = vpd_ids,
 };
 module_coreboot_driver(vpd_driver);
 

-- 
2.43.0


