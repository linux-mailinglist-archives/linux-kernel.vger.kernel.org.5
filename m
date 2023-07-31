Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B42B76A0F2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 21:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjGaTOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 15:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGaTOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:14:31 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A65E4B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:14:27 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qQYLY-0001is-1u;
        Mon, 31 Jul 2023 19:14:25 +0000
Date:   Mon, 31 Jul 2023 20:14:14 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH 6/6] mtd: ubi: provide NVMEM layer over UBI volumes
Message-ID: <2bd2368ff137dbac2282f366efa9b5d16046f2f1.1690823629.git.daniel@makrotopia.org>
References: <cover.1690823629.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1690823629.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 drivers/mtd/ubi/Kconfig  |  12 +++
 drivers/mtd/ubi/Makefile |   1 +
 drivers/mtd/ubi/nvmem.c  | 189 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 202 insertions(+)
 create mode 100644 drivers/mtd/ubi/nvmem.c

diff --git a/drivers/mtd/ubi/Kconfig b/drivers/mtd/ubi/Kconfig
index 2ed77b7b3fcb5..45d939bbfa853 100644
--- a/drivers/mtd/ubi/Kconfig
+++ b/drivers/mtd/ubi/Kconfig
@@ -104,4 +104,16 @@ config MTD_UBI_BLOCK
 
 	   If in doubt, say "N".
 
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
index 0000000000000..dd7cc6afb8d00
--- /dev/null
+++ b/drivers/mtd/ubi/nvmem.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 Daniel Golle <daniel@makrotopia.org>
+ */
+
+/* UBI NVMEM provider */
+#include "ubi.h"
+#include <linux/nvmem-provider.h>
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
+	struct ubi_nvmem *unv = priv;
+	struct ubi_volume_desc *desc;
+	int err = 0, lnum, offs, bytes_left;
+	size_t to_read;
+
+	desc = ubi_open_volume(unv->ubi_num, unv->vol_id, UBI_READONLY);
+	if (IS_ERR(desc))
+		return PTR_ERR(desc);
+
+	lnum = div_u64_rem(from, unv->usable_leb_size, &offs);
+	bytes_left = bytes;
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
+	struct nvmem_config config = {};
+	struct ubi_nvmem *unv;
+	int ret;
+
+	if (!device_is_compatible(vi->dev, "nvmem-cells"))
+		return 0;
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
+	config.of_node = dev_of_node(vi->dev);
+
+	if (!config.of_node)
+		config.no_of_node = true;
+
+	unv->ubi_num = vi->ubi_num;
+	unv->vol_id = vi->vol_id;
+	unv->usable_leb_size = vi->usable_leb_size;
+	unv->nvmem = nvmem_register(&config);
+	if (IS_ERR(unv->nvmem)) {
+		/* Just ignore if there is no NVMEM support in the kernel */
+		if (PTR_ERR(unv->nvmem) == -EOPNOTSUPP)
+			ret = 0;
+		else
+			ret = dev_err_probe(vi->dev, PTR_ERR(unv->nvmem),
+					    "Failed to register NVMEM device\n");
+
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
2.41.0
