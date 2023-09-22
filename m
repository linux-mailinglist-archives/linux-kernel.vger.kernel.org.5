Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490017AB80E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbjIVRtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbjIVRtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:49:19 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E2FFB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:49:08 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E4FDEE000A;
        Fri, 22 Sep 2023 17:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695404947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4k0Z84iQwNUIVc6FLE5hSxSxMdXUZ7GlWGeFkWoDCwY=;
        b=Q0wEF9C7xM1CT1kgwI/XWJ6VtQ2uyD8P+JNF2259pxLIOqN7/2hORl4XMG8umqgjCNQpv8
        sQfn8Mu3JpfQHEl5d6PL6Lq36dCXWVZpS8s6j4sjKPf28OxsnOW+vDiDtBfC3NyGC9ViMC
        SHIqZR4qBiuvqll4+9ThGpvTnQERiQJAm7xymlVpddj3J+Vof3TMyrKmWkQ3OsaSwx64P2
        3Jm0+dhWTud//stPg8wQb+HJ52ETUNaX8YKXQdN3vklKVa39OQLHGH+TNojOUBJs08QhiK
        6cp6yAtkkbDA6EoE6GZyNXpsEW1lMgt9QLW4R9ZU00Ycw0v8Grv7LLYyzcalMA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Michael Walle <michael@walle.cc>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v10 3/3] nvmem: core: Expose cells through sysfs
Date:   Fri, 22 Sep 2023 19:48:54 +0200
Message-Id: <20230922174854.611975-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922174854.611975-1-miquel.raynal@bootlin.com>
References: <20230922174854.611975-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The binary content of nvmem devices is available to the user so in the
easiest cases, finding the content of a cell is rather easy as it is
just a matter of looking at a known and fixed offset. However, nvmem
layouts have been recently introduced to cope with more advanced
situations, where the offset and size of the cells is not known in
advance or is dynamic. When using layouts, more advanced parsers are
used by the kernel in order to give direct access to the content of each
cell, regardless of its position/size in the underlying
device. Unfortunately, these information are not accessible by users,
unless by fully re-implementing the parser logic in userland.

Let's expose the cells and their content through sysfs to avoid these
situations. Of course the relevant NVMEM sysfs Kconfig option must be
enabled for this support to be available.

Not all nvmem devices expose cells. Indeed, the .bin_attrs attribute
group member will be filled at runtime only when relevant and will
remain empty otherwise. In this case, as the cells attribute group will
be empty, it will not lead to any additional folder/file creation.

Exposed cells are read-only. There is, in practice, everything in the
core to support a write path, but as I don't see any need for that, I
prefer to keep the interface simple (and probably safer). The interface
is documented as being in the "testing" state which means we can later
add a write attribute if though relevant.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/nvmem/core.c | 117 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 14dd3ae777bb..b3c4345ab48a 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -43,6 +43,7 @@ struct nvmem_device {
 	struct gpio_desc	*wp_gpio;
 	struct nvmem_layout	*layout;
 	void *priv;
+	bool			sysfs_cells_populated;
 };
 
 #define to_nvmem_device(d) container_of(d, struct nvmem_device, dev)
@@ -327,6 +328,43 @@ static umode_t nvmem_bin_attr_is_visible(struct kobject *kobj,
 	return nvmem_bin_attr_get_umode(nvmem);
 }
 
+static struct nvmem_cell *nvmem_create_cell(struct nvmem_cell_entry *entry,
+					    const char *id, int index);
+
+static ssize_t nvmem_cell_attr_read(struct file *filp, struct kobject *kobj,
+				    struct bin_attribute *attr, char *buf,
+				    loff_t pos, size_t count)
+{
+	struct nvmem_cell_entry *entry;
+	struct nvmem_cell *cell = NULL;
+	size_t cell_sz, read_len;
+	void *content;
+
+	entry = attr->private;
+	cell = nvmem_create_cell(entry, entry->name, 0);
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	if (!cell)
+		return -EINVAL;
+
+	content = nvmem_cell_read(cell, &cell_sz);
+	if (IS_ERR(content)) {
+		read_len = PTR_ERR(content);
+		goto destroy_cell;
+	}
+
+	read_len = min_t(unsigned int, cell_sz - pos, count);
+	memcpy(buf, content + pos, read_len);
+	kfree(content);
+
+destroy_cell:
+	kfree_const(cell->id);
+	kfree(cell);
+
+	return read_len;
+}
+
 /* default read/write permissions */
 static struct bin_attribute bin_attr_rw_nvmem = {
 	.attr	= {
@@ -348,11 +386,21 @@ static const struct attribute_group nvmem_bin_group = {
 	.is_bin_visible = nvmem_bin_attr_is_visible,
 };
 
+/* Cell attributes will be dynamically allocated */
+static struct attribute_group nvmem_cells_group = {
+	.name		= "cells",
+};
+
 static const struct attribute_group *nvmem_dev_groups[] = {
 	&nvmem_bin_group,
 	NULL,
 };
 
+static const struct attribute_group *nvmem_cells_groups[] = {
+	&nvmem_cells_group,
+	NULL,
+};
+
 static struct bin_attribute bin_attr_nvmem_eeprom_compat = {
 	.attr	= {
 		.name	= "eeprom",
@@ -408,6 +456,69 @@ static void nvmem_sysfs_remove_compat(struct nvmem_device *nvmem,
 		device_remove_bin_file(nvmem->base_dev, &nvmem->eeprom);
 }
 
+static int nvmem_dev_populate_sysfs_cells(struct device *dev, void *data)
+{
+	struct nvmem_device *nvmem = to_nvmem_device(dev);
+	struct bin_attribute **cells_attrs, *attrs;
+	struct nvmem_cell_entry *entry;
+	unsigned int ncells = 0, i = 0;
+	int ret = 0;
+
+	mutex_lock(&nvmem_mutex);
+
+	if (list_empty(&nvmem->cells) || nvmem->sysfs_cells_populated) {
+		nvmem_cells_group.bin_attrs = NULL;
+		goto unlock_mutex;
+	}
+
+	/* Allocate an array of attributes with a sentinel */
+	ncells = list_count_nodes(&nvmem->cells);
+	cells_attrs = devm_kcalloc(&nvmem->dev, ncells + 1,
+				   sizeof(struct bin_attribute *), GFP_KERNEL);
+	if (!cells_attrs) {
+		ret = -ENOMEM;
+		goto unlock_mutex;
+	}
+
+	attrs = devm_kcalloc(&nvmem->dev, ncells, sizeof(struct bin_attribute), GFP_KERNEL);
+	if (!attrs) {
+		ret = -ENOMEM;
+		goto unlock_mutex;
+	}
+
+	/* Initialize each attribute to take the name and size of the cell */
+	list_for_each_entry(entry, &nvmem->cells, node) {
+		sysfs_bin_attr_init(&attrs[i]);
+		attrs[i].attr.name = devm_kasprintf(&nvmem->dev, GFP_KERNEL,
+						    "%s@%x", entry->name,
+						    entry->offset);
+		attrs[i].attr.mode = 0444;
+		attrs[i].size = entry->bytes;
+		attrs[i].read = &nvmem_cell_attr_read;
+		attrs[i].private = entry;
+		if (!attrs[i].attr.name) {
+			ret = -ENOMEM;
+			goto unlock_mutex;
+		}
+
+		cells_attrs[i] = &attrs[i];
+		i++;
+	}
+
+	nvmem_cells_group.bin_attrs = cells_attrs;
+
+	ret = devm_device_add_groups(&nvmem->dev, nvmem_cells_groups);
+	if (ret)
+		goto unlock_mutex;
+
+	nvmem->sysfs_cells_populated = true;
+
+unlock_mutex:
+	mutex_unlock(&nvmem_mutex);
+
+	return ret;
+}
+
 #else /* CONFIG_NVMEM_SYSFS */
 
 static int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,
@@ -2193,6 +2304,12 @@ static int nvmem_notifier_call(struct notifier_block *notifier,
 	if (ret)
 		return notifier_from_errno(ret);
 
+#ifdef CONFIG_NVMEM_SYSFS
+	ret = nvmem_for_each_dev(nvmem_dev_populate_sysfs_cells);
+	if (ret)
+		return notifier_from_errno(ret);
+#endif
+
 	return NOTIFY_OK;
 }
 
-- 
2.34.1

