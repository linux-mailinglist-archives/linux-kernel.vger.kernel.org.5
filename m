Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C2D751A73
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbjGMHz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbjGMHzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:55:15 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8766C10FA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:55:14 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 84B76C000B;
        Thu, 13 Jul 2023 07:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689234913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RrYa81jVjDuF0o+K2o6QuVvcpzCkZHcHCjfMG1eLeRQ=;
        b=iLRncOLWdNl3B9tqqtbmNllAd6sz39Cw7tjmi+aFV5uTDKA74L65FZ0OUKfzr22ZLNVaht
        QA8lDLh0zXdECcElfB/R76uHgzFTRSM0rcWxMakA0d49LP3D2jUEur1/Pdb+QNtZQU0wSe
        oRl0/yNLvQzZOfmfiqwE1Y74NNi5ESisVrMvLdoYjIDaEVzVpXGG/IdS7clMPbY5+sRSaH
        Km/WADOkbpYbUoP8VhyPKf2XIziJBZtCe47JzQDriteuThnmGwiPdgCmc+V1lhJ0AI3+V+
        u1JChlc4GWedht7u9Kimwg4TlPR59p9+Q3DWu4gcqQ2EiRPoGx9lHHuANQS5WQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH RESEND v5 3/3] nvmem: core: Expose cells through sysfs
Date:   Thu, 13 Jul 2023 09:55:08 +0200
Message-Id: <20230713075508.485072-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713075508.485072-1-miquel.raynal@bootlin.com>
References: <20230713075508.485072-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

There is one limitation though: if a layout is built as a module but is
not properly installed in the system and loaded manually with insmod
while the nvmem device driver was built-in, the cells won't appear in
sysfs. But if done like that, the cells won't be usable by the built-in
kernel drivers anyway.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvmem/core.c | 101 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 48659106a1e2..6c04a9cf6919 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -325,6 +325,43 @@ static umode_t nvmem_bin_attr_is_visible(struct kobject *kobj,
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
@@ -346,8 +383,14 @@ static const struct attribute_group nvmem_bin_group = {
 	.is_bin_visible = nvmem_bin_attr_is_visible,
 };
 
+/* Cell attributes will be dynamically allocated */
+static struct attribute_group nvmem_cells_group = {
+	.name		= "cells",
+};
+
 static const struct attribute_group *nvmem_dev_groups[] = {
 	&nvmem_bin_group,
+	&nvmem_cells_group,
 	NULL,
 };
 
@@ -406,6 +449,58 @@ static void nvmem_sysfs_remove_compat(struct nvmem_device *nvmem,
 		device_remove_bin_file(nvmem->base_dev, &nvmem->eeprom);
 }
 
+static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
+{
+	struct bin_attribute **cells_attrs, *attrs;
+	struct nvmem_cell_entry *entry;
+	unsigned int ncells = 0, i = 0;
+	int ret = 0;
+
+	mutex_lock(&nvmem_mutex);
+
+	if (list_empty(&nvmem->cells))
+		goto unlock_mutex;
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
+		attrs[i].attr.name = devm_kstrdup(&nvmem->dev, entry->name, GFP_KERNEL);
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
+unlock_mutex:
+	mutex_unlock(&nvmem_mutex);
+
+	return ret;
+}
+
 #else /* CONFIG_NVMEM_SYSFS */
 
 static int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,
@@ -1006,6 +1101,12 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (rval)
 		goto err_remove_cells;
 
+#ifdef CONFIG_NVMEM_SYSFS
+	rval = nvmem_populate_sysfs_cells(nvmem);
+	if (rval)
+		goto err_remove_cells;
+#endif
+
 	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
 
 	rval = device_add(&nvmem->dev);
-- 
2.34.1

