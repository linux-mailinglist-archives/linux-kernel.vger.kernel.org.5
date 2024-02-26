Return-Path: <linux-kernel+bounces-80361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041FC866759
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 01:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 871C12818BA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 00:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C7CD502;
	Mon, 26 Feb 2024 00:23:54 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B3F33EC;
	Mon, 26 Feb 2024 00:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708907034; cv=none; b=vE5rD4VYqdmhfBeQgX0LPZIoBrSeJBNES6qoDFAFrf3FWQlq/p7uXkv6fQzfo8Sc3C6kGNpSd0mCLPPIJC/VnoK0KT7jurm2jC224JlqxEkYDwYMaMr/NZ65IiPp8ybTZm2qaZhy9zmO7fmgU4M96T0ae7jqXRxMQ1bDSnk3SoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708907034; c=relaxed/simple;
	bh=CF56sxrMUbhfd9jdc++hHknqQjW6Pw4Hu7N6DnVeMhE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KeAHZH83r/HNzshF3XnT395FZkZlfLK8vbMLiImKsB2Go8oKmKY5jAxSxjk9ntsjfYkbt54CV8aVQHIyHs2Rs2cSEhiQtghqM0+UbZrP75/gNLQGWvSVMLlNYVbAjboMkSXHIvIueUdsRuu41arGN47HWBd3cgRsTBkGpWJt5cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1reOmW-0001qY-0d;
	Mon, 26 Feb 2024 00:23:44 +0000
Date: Mon, 26 Feb 2024 00:23:41 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>, linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 7/7] mtd: ubi: provide NVMEM layer over UBI volumes
Message-ID: <3ac88da4adc342af428b359cd27037b1498f6c91.1708906456.git.daniel@makrotopia.org>
References: <cover.1708906456.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1708906456.git.daniel@makrotopia.org>

In an ideal world we would like UBI to be used where ever possible on a
NAND chip. And with UBI support in ARM Trusted Firmware and U-Boot it
is possible to achieve an (almost-)all-UBI flash layout. Hence the need
for a way to also use UBI volumes to store board-level constants, such
as MAC addresses and calibration data of wireless interfaces.

Add UBI volume NVMEM driver module exposing UBI volumes as NVMEM
providers. Allow UBI devices to have a "volumes" firmware subnode with
volumes which may be compatible with "nvmem-cells".
Access to UBI volumes via the NVMEM interface at this point is
read-only, and it is slow, opening and closing the UBI volume for each
access due to limitations of the NVMEM provider API.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/mtd/ubi/Kconfig  |  13 +++
 drivers/mtd/ubi/Makefile |   1 +
 drivers/mtd/ubi/nvmem.c  | 191 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 205 insertions(+)
 create mode 100644 drivers/mtd/ubi/nvmem.c

diff --git a/drivers/mtd/ubi/Kconfig b/drivers/mtd/ubi/Kconfig
index 7499a540121e8..e28a3af83c0eb 100644
--- a/drivers/mtd/ubi/Kconfig
+++ b/drivers/mtd/ubi/Kconfig
@@ -113,4 +113,17 @@ config MTD_UBI_FAULT_INJECTION
 	   testing purposes.
 
 	   If in doubt, say "N".
+
+config MTD_UBI_NVMEM
+	tristate "UBI virtual NVMEM"
+	default n
+	depends on NVMEM
+	help
+	   This option enabled an additional driver exposing UBI volumes as NVMEM
+	   providers, intended for platforms where UBI is part of the firmware
+	   specification and used to store also e.g. MAC addresses or board-
+	   specific Wi-Fi calibration data.
+
+	   If in doubt, say "N".
+
 endif # MTD_UBI
diff --git a/drivers/mtd/ubi/Makefile b/drivers/mtd/ubi/Makefile
index 543673605ca72..4b51aaf00d1a2 100644
--- a/drivers/mtd/ubi/Makefile
+++ b/drivers/mtd/ubi/Makefile
@@ -7,3 +7,4 @@ ubi-$(CONFIG_MTD_UBI_FASTMAP) += fastmap.o
 ubi-$(CONFIG_MTD_UBI_BLOCK) += block.o
 
 obj-$(CONFIG_MTD_UBI_GLUEBI) += gluebi.o
+obj-$(CONFIG_MTD_UBI_NVMEM) += nvmem.o
diff --git a/drivers/mtd/ubi/nvmem.c b/drivers/mtd/ubi/nvmem.c
new file mode 100644
index 0000000000000..5820a170d2512
--- /dev/null
+++ b/drivers/mtd/ubi/nvmem.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 Daniel Golle <daniel@makrotopia.org>
+ */
+
+/* UBI NVMEM provider */
+#include "ubi.h"
+#include <linux/nvmem-provider.h>
+#include <asm/div64.h>
+
+/* List of all NVMEM devices */
+static LIST_HEAD(nvmem_devices);
+static DEFINE_MUTEX(devices_mutex);
+
+struct ubi_nvmem {
+	struct nvmem_device *nvmem;
+	int ubi_num;
+	int vol_id;
+	int usable_leb_size;
+	struct list_head list;
+};
+
+static int ubi_nvmem_reg_read(void *priv, unsigned int from,
+			      void *val, size_t bytes)
+{
+	uint32_t bytes_left, offs, to_read;
+	struct ubi_nvmem *unv = priv;
+	struct ubi_volume_desc *desc;
+	uint64_t lnum = from;
+	int err = 0;
+
+	desc = ubi_open_volume(unv->ubi_num, unv->vol_id, UBI_READONLY);
+	if (IS_ERR(desc))
+		return PTR_ERR(desc);
+
+	bytes_left = bytes;
+	offs = do_div(lnum, unv->usable_leb_size);
+	while (bytes_left) {
+		to_read = unv->usable_leb_size - offs;
+
+		if (to_read > bytes_left)
+			to_read = bytes_left;
+
+		err = ubi_read(desc, lnum, val, offs, to_read);
+		if (err)
+			break;
+
+		lnum += 1;
+		offs = 0;
+		bytes_left -= to_read;
+		val += to_read;
+	}
+	ubi_close_volume(desc);
+
+	if (err)
+		return err;
+
+	return bytes_left == 0 ? 0 : -EIO;
+}
+
+static int ubi_nvmem_add(struct ubi_volume_info *vi)
+{
+	struct device_node *np = dev_of_node(vi->dev);
+	struct nvmem_config config = {};
+	struct ubi_nvmem *unv;
+	int ret;
+
+	if (!np)
+		return 0;
+
+	if (!of_get_child_by_name(np, "nvmem-layout"))
+		return 0;
+
+	if (WARN_ON_ONCE(vi->usable_leb_size <= 0) ||
+	    WARN_ON_ONCE(vi->size <= 0))
+		return -EINVAL;
+
+	unv = kzalloc(sizeof(struct ubi_nvmem), GFP_KERNEL);
+	if (!unv)
+		return -ENOMEM;
+
+	config.id = NVMEM_DEVID_NONE;
+	config.dev = vi->dev;
+	config.name = dev_name(vi->dev);
+	config.owner = THIS_MODULE;
+	config.priv = unv;
+	config.reg_read = ubi_nvmem_reg_read;
+	config.size = vi->usable_leb_size * vi->size;
+	config.word_size = 1;
+	config.stride = 1;
+	config.read_only = true;
+	config.root_only = true;
+	config.ignore_wp = true;
+	config.of_node = np;
+
+	unv->ubi_num = vi->ubi_num;
+	unv->vol_id = vi->vol_id;
+	unv->usable_leb_size = vi->usable_leb_size;
+	unv->nvmem = nvmem_register(&config);
+	if (IS_ERR(unv->nvmem)) {
+		ret = dev_err_probe(vi->dev, PTR_ERR(unv->nvmem),
+				    "Failed to register NVMEM device\n");
+		kfree(unv);
+		return ret;
+	}
+
+	mutex_lock(&devices_mutex);
+	list_add_tail(&unv->list, &nvmem_devices);
+	mutex_unlock(&devices_mutex);
+
+	return 0;
+}
+
+static void ubi_nvmem_remove(struct ubi_volume_info *vi)
+{
+	struct ubi_nvmem *unv_c, *unv = NULL;
+
+	mutex_lock(&devices_mutex);
+	list_for_each_entry(unv_c, &nvmem_devices, list)
+		if (unv_c->ubi_num == vi->ubi_num && unv_c->vol_id == vi->vol_id) {
+			unv = unv_c;
+			break;
+		}
+
+	if (!unv) {
+		mutex_unlock(&devices_mutex);
+		return;
+	}
+
+	list_del(&unv->list);
+	mutex_unlock(&devices_mutex);
+	nvmem_unregister(unv->nvmem);
+	kfree(unv);
+}
+
+/**
+ * nvmem_notify - UBI notification handler.
+ * @nb: registered notifier block
+ * @l: notification type
+ * @ns_ptr: pointer to the &struct ubi_notification object
+ */
+static int nvmem_notify(struct notifier_block *nb, unsigned long l,
+			 void *ns_ptr)
+{
+	struct ubi_notification *nt = ns_ptr;
+
+	switch (l) {
+	case UBI_VOLUME_RESIZED:
+		ubi_nvmem_remove(&nt->vi);
+		fallthrough;
+	case UBI_VOLUME_ADDED:
+		ubi_nvmem_add(&nt->vi);
+		break;
+	case UBI_VOLUME_SHUTDOWN:
+		ubi_nvmem_remove(&nt->vi);
+		break;
+	default:
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block nvmem_notifier = {
+	.notifier_call = nvmem_notify,
+};
+
+static int __init ubi_nvmem_init(void)
+{
+	return ubi_register_volume_notifier(&nvmem_notifier, 0);
+}
+
+static void __exit ubi_nvmem_exit(void)
+{
+	struct ubi_nvmem *unv, *tmp;
+
+	mutex_lock(&devices_mutex);
+	list_for_each_entry_safe(unv, tmp, &nvmem_devices, list) {
+		nvmem_unregister(unv->nvmem);
+		list_del(&unv->list);
+		kfree(unv);
+	}
+	mutex_unlock(&devices_mutex);
+
+	ubi_unregister_volume_notifier(&nvmem_notifier);
+}
+
+module_init(ubi_nvmem_init);
+module_exit(ubi_nvmem_exit);
+MODULE_DESCRIPTION("NVMEM layer over UBI volumes");
+MODULE_AUTHOR("Daniel Golle");
+MODULE_LICENSE("GPL");
-- 
2.44.0

