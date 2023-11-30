Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BADB7FFB2F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376462AbjK3TXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376391AbjK3TX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:23:29 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798BA10E2;
        Thu, 30 Nov 2023 11:23:33 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Sh5b03s3Yz6H830;
        Fri,  1 Dec 2023 03:18:52 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
        by mail.maildlp.com (Postfix) with ESMTPS id A39481404F4;
        Fri,  1 Dec 2023 03:23:31 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 30 Nov 2023 19:23:30 +0000
From:   <shiju.jose@huawei.com>
To:     <linux-cxl@vger.kernel.org>, <linux-mm@kvack.org>,
        <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
        <dave.jiang@intel.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <dan.j.williams@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <david@redhat.com>, <Vilas.Sridharan@amd.com>, <leo.duran@amd.com>,
        <Yazen.Ghannam@amd.com>, <rientjes@google.com>,
        <jiaqiyan@google.com>, <tony.luck@intel.com>, <Jon.Grimm@amd.com>,
        <dave.hansen@linux.intel.com>, <rafael@kernel.org>,
        <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
        <james.morse@arm.com>, <jthoughton@google.com>,
        <somasundaram.a@hpe.com>, <erdemaktas@google.com>,
        <pgonda@google.com>, <duenwen@google.com>,
        <mike.malvestuto@intel.com>, <gthelen@google.com>,
        <wschwartz@amperecomputing.com>, <dferguson@amperecomputing.com>,
        <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
        <kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
        <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v4 06/11] memory: scrub: Add scrub driver supports configuring memory scrubs in the system
Date:   Fri, 1 Dec 2023 03:23:08 +0800
Message-ID: <20231130192314.1220-7-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20231130192314.1220-1-shiju.jose@huawei.com>
References: <20231130192314.1220-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.234]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

Add scrub driver supports configuring the memory scrubs in the system.
The scrub driver provides the interface for registering the scrub devices
and to configure the attributes of memory scrubs in the system.
Driver exposes the scrub parameter attributes to the user via sysfs in
/sys/class/scrub/scrubX/regionY/

This driver has been implemented referring to the hwmon subsystem.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/memory/Kconfig              |   1 +
 drivers/memory/Makefile             |   1 +
 drivers/memory/scrub/Kconfig        |  11 +
 drivers/memory/scrub/Makefile       |   6 +
 drivers/memory/scrub/memory-scrub.c | 470 ++++++++++++++++++++++++++++
 include/memory/memory-scrub.h       |  80 +++++
 6 files changed, 569 insertions(+)
 create mode 100644 drivers/memory/scrub/Kconfig
 create mode 100644 drivers/memory/scrub/Makefile
 create mode 100755 drivers/memory/scrub/memory-scrub.c
 create mode 100755 include/memory/memory-scrub.h

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 8efdd1f97139..d2e015c09d83 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -227,5 +227,6 @@ config STM32_FMC2_EBI
 
 source "drivers/memory/samsung/Kconfig"
 source "drivers/memory/tegra/Kconfig"
+source "drivers/memory/scrub/Kconfig"
 
 endif
diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index d2e6ca9abbe0..4b37312cb342 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_STM32_FMC2_EBI)	+= stm32-fmc2-ebi.o
 
 obj-$(CONFIG_SAMSUNG_MC)	+= samsung/
 obj-$(CONFIG_TEGRA_MC)		+= tegra/
+obj-$(CONFIG_SCRUB)		+= scrub/
 obj-$(CONFIG_TI_EMIF_SRAM)	+= ti-emif-sram.o
 obj-$(CONFIG_FPGA_DFL_EMIF)	+= dfl-emif.o
 
diff --git a/drivers/memory/scrub/Kconfig b/drivers/memory/scrub/Kconfig
new file mode 100644
index 000000000000..fa7d68f53a69
--- /dev/null
+++ b/drivers/memory/scrub/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Memory scrub driver configurations
+#
+
+config SCRUB
+	bool "Memory scrub driver"
+	help
+	  This option selects the memory scrub subsystem, supports
+	  configuring the parameters of underlying scrubbers in the
+	  system for the DRAM memories.
diff --git a/drivers/memory/scrub/Makefile b/drivers/memory/scrub/Makefile
new file mode 100644
index 000000000000..1b677132ca13
--- /dev/null
+++ b/drivers/memory/scrub/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for memory scrub drivers
+#
+
+obj-$(CONFIG_SCRUB)		+= memory-scrub.o
diff --git a/drivers/memory/scrub/memory-scrub.c b/drivers/memory/scrub/memory-scrub.c
new file mode 100755
index 000000000000..c2d794b2624b
--- /dev/null
+++ b/drivers/memory/scrub/memory-scrub.c
@@ -0,0 +1,470 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Memory scrub controller driver support to configure
+ * the parameters of the memory scrubbers and enable.
+ *
+ * Copyright (c) 2023 HiSilicon Limited.
+ */
+
+#define pr_fmt(fmt)     "MEM SCRUB: " fmt
+
+#include <linux/acpi.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/kfifo.h>
+#include <linux/spinlock.h>
+#include <memory/memory-scrub.h>
+
+/* memory scrubber config definitions */
+#define SCRUB_ID_PREFIX "scrub"
+#define SCRUB_ID_FORMAT SCRUB_ID_PREFIX "%d"
+#define SCRUB_DEV_MAX_NAME_LENGTH	128
+
+static DEFINE_IDA(scrub_ida);
+
+struct scrub_device {
+	char name[SCRUB_DEV_MAX_NAME_LENGTH];
+	int id;
+	struct device dev;
+	const struct scrub_source_info *source_info;
+	struct list_head tzdata;
+	char (*region_name)[];
+	struct attribute_group group;
+	int ngroups;
+	struct attribute_group *region_groups;
+	const struct attribute_group **groups;
+};
+
+#define to_scrub_device(d) container_of(d, struct scrub_device, dev)
+#define SCRUB_MAX_SYSFS_ATTR_NAME_LENGTH	64
+
+struct scrub_device_attribute {
+	struct device_attribute dev_attr;
+	const struct scrub_ops *ops;
+	u32 attr;
+	int region_id;
+	char name[SCRUB_MAX_SYSFS_ATTR_NAME_LENGTH];
+};
+
+#define to_scrub_attr(d) \
+	container_of(d, struct scrub_device_attribute, dev_attr)
+#define to_dev_attr(a) container_of(a, struct device_attribute, attr)
+
+static ssize_t name_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%s\n", to_scrub_device(dev)->name);
+}
+static DEVICE_ATTR_RO(name);
+
+static struct attribute *scrub_dev_attrs[] = {
+	&dev_attr_name.attr,
+	NULL
+};
+
+static umode_t scrub_dev_attr_is_visible(struct kobject *kobj,
+					    struct attribute *attr, int n)
+{
+	if (attr != &dev_attr_name.attr)
+		return 0;
+
+	return attr->mode;
+}
+
+static const struct attribute_group scrub_dev_attr_group = {
+	.attrs		= scrub_dev_attrs,
+	.is_visible	= scrub_dev_attr_is_visible,
+};
+
+static const struct attribute_group *scrub_dev_attr_groups[] = {
+	&scrub_dev_attr_group,
+	NULL
+};
+
+static void scrub_free_attrs(struct attribute **attrs)
+{
+	int i;
+
+	for (i = 0; attrs[i]; i++) {
+		struct device_attribute *dattr = to_dev_attr(attrs[i]);
+		struct scrub_device_attribute *hattr = to_scrub_attr(dattr);
+
+		kfree(hattr);
+	}
+	kfree(attrs);
+}
+
+static void scrub_dev_release(struct device *dev)
+{
+	int count;
+	struct attribute_group *group;
+	struct scrub_device *scrub_dev = to_scrub_device(dev);
+
+	for (count = 0; count < scrub_dev->ngroups; count++) {
+		group = (struct attribute_group *)scrub_dev->groups[count];
+		if (group)
+			scrub_free_attrs(group->attrs);
+	}
+	kfree(scrub_dev->region_name);
+	kfree(scrub_dev->region_groups);
+	kfree(scrub_dev->groups);
+	ida_free(&scrub_ida, scrub_dev->id);
+	kfree(scrub_dev);
+}
+
+static struct class scrub_class = {
+	.name = "scrub",
+	.dev_groups = scrub_dev_attr_groups,
+	.dev_release = scrub_dev_release,
+};
+
+/* sysfs attribute management */
+
+static ssize_t scrub_attr_show(struct device *dev,
+			       struct device_attribute *devattr, char *buf)
+{
+	int ret;
+	u64 val;
+	struct scrub_device_attribute *hattr = to_scrub_attr(devattr);
+
+	ret = hattr->ops->read(dev, hattr->attr, hattr->region_id, &val);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "%lld\n", val);
+}
+
+static ssize_t scrub_attr_show_hex(struct device *dev,
+				   struct device_attribute *devattr, char *buf)
+{
+	int ret;
+	u64 val;
+	struct scrub_device_attribute *hattr = to_scrub_attr(devattr);
+
+	ret = hattr->ops->read(dev, hattr->attr, hattr->region_id, &val);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "0x%llx\n", val);
+}
+
+static ssize_t scrub_attr_show_string(struct device *dev,
+				      struct device_attribute *devattr,
+				      char *buf)
+{
+	int ret;
+	struct scrub_device_attribute *hattr = to_scrub_attr(devattr);
+
+	ret = hattr->ops->read_string(dev, hattr->attr, hattr->region_id, buf);
+	if (ret < 0)
+		return ret;
+
+	return strlen(buf);
+}
+
+static ssize_t scrub_attr_store(struct device *dev,
+				struct device_attribute *devattr,
+				const char *buf, size_t count)
+{
+	int ret;
+	long val;
+	struct scrub_device_attribute *hattr = to_scrub_attr(devattr);
+
+	ret = kstrtol(buf, 10, &val);
+	if (ret < 0)
+		return ret;
+
+	ret = hattr->ops->write(dev, hattr->attr, hattr->region_id, val);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static ssize_t scrub_attr_store_hex(struct device *dev,
+				    struct device_attribute *devattr,
+				    const char *buf, size_t count)
+{
+	int ret;
+	u64 val;
+	struct scrub_device_attribute *hattr = to_scrub_attr(devattr);
+
+	ret = kstrtou64(buf, 16, &val);
+	if (ret < 0)
+		return ret;
+
+	ret = hattr->ops->write(dev, hattr->attr, hattr->region_id, val);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static bool is_hex_attr(u32 attr)
+{
+	return	(attr == scrub_addr_base) ||
+		(attr == scrub_addr_size);
+}
+
+static bool is_string_attr(u32 attr)
+{
+	return	attr == scrub_speed_available;
+}
+
+static struct attribute *scrub_genattr(const void *drvdata,
+				       u32 attr,
+				       const char *attrb_name,
+				       const struct scrub_ops *ops,
+				       int region_id)
+{
+	umode_t mode;
+	struct attribute *a;
+	struct device_attribute *dattr;
+	bool is_hex = is_hex_attr(attr);
+	struct scrub_device_attribute *hattr;
+	bool is_string = is_string_attr(attr);
+
+	/* The attribute is invisible if there is no template string */
+	if (!attrb_name)
+		return ERR_PTR(-ENOENT);
+
+	mode = ops->is_visible(drvdata, attr, region_id);
+	if (!mode)
+		return ERR_PTR(-ENOENT);
+
+	if ((mode & 0444) && ((is_string && !ops->read_string) ||
+			      (!is_string && !ops->read)))
+		return ERR_PTR(-EINVAL);
+	if ((mode & 0222) && (!ops->write))
+		return ERR_PTR(-EINVAL);
+
+	hattr = kzalloc(sizeof(*hattr), GFP_KERNEL);
+	if (!hattr)
+		return ERR_PTR(-ENOMEM);
+
+	hattr->attr = attr;
+	hattr->ops = ops;
+	hattr->region_id = region_id;
+
+	dattr = &hattr->dev_attr;
+	if (is_string) {
+		dattr->show = scrub_attr_show_string;
+	} else {
+		dattr->show = is_hex ? scrub_attr_show_hex : scrub_attr_show;
+		dattr->store = is_hex ? scrub_attr_store_hex : scrub_attr_store;
+	}
+
+	a = &dattr->attr;
+	sysfs_attr_init(a);
+	a->name = attrb_name;
+	a->mode = mode;
+
+	return a;
+}
+
+static const char * const scrub_common_attrs[] = {
+	/* scrub attributes - common */
+	[scrub_addr_base] = "addr_base",
+	[scrub_addr_size] = "addr_size",
+	[scrub_enable] = "enable",
+	[scrub_speed] = "speed",
+	[scrub_speed_available] = "speed_available",
+};
+
+static struct attribute **
+scrub_create_attrs(const void *drvdata, const struct scrub_ops *ops, int region_id)
+{
+	u32 attr;
+	int aindex = 0;
+	struct attribute *a;
+	struct attribute **attrs;
+
+	attrs = kcalloc(max_attrs, sizeof(*attrs), GFP_KERNEL);
+	if (!attrs)
+		return ERR_PTR(-ENOMEM);
+
+	for (attr = 0; attr < max_attrs; attr++) {
+		a = scrub_genattr(drvdata, attr, scrub_common_attrs[attr],
+				  ops, region_id);
+		if (IS_ERR(a)) {
+			if (PTR_ERR(a) != -ENOENT) {
+				scrub_free_attrs(attrs);
+				return ERR_PTR(PTR_ERR(a));
+			}
+			continue;
+		}
+		attrs[aindex++] = a;
+	}
+
+	return attrs;
+}
+
+static struct device *
+scrub_device_register(struct device *dev, const char *name, void *drvdata,
+		      const struct scrub_ops *ops,
+		      int nregions)
+{
+	struct device *hdev;
+	struct attribute **attrs;
+	int err, count, region_id;
+	struct attribute_group *group;
+	struct scrub_device *scrub_dev;
+	char (*region_name)[SCRUB_MAX_SYSFS_ATTR_NAME_LENGTH];
+
+	scrub_dev = kzalloc(sizeof(*scrub_dev), GFP_KERNEL);
+	if (!scrub_dev)
+		return ERR_PTR(-ENOMEM);
+	hdev = &scrub_dev->dev;
+
+	scrub_dev->id = ida_alloc(&scrub_ida, GFP_KERNEL);
+	if (scrub_dev->id < 0) {
+		err = -ENOMEM;
+		goto free_scrub_dev;
+	}
+	int ngroups = 2; /* terminating NULL plus &scrub_dev->groups */
+
+	ngroups += nregions;
+
+	scrub_dev->groups = kcalloc(ngroups, sizeof(struct attribute_group *), GFP_KERNEL);
+	if (!scrub_dev->groups) {
+		err = -ENOMEM;
+		goto free_ida;
+	}
+
+	if (nregions) {
+		scrub_dev->region_groups = kcalloc(nregions, sizeof(struct attribute_group),
+						   GFP_KERNEL);
+		if (!scrub_dev->groups) {
+			err = -ENOMEM;
+			goto free_groups;
+		}
+		scrub_dev->region_name = kcalloc(nregions, SCRUB_MAX_SYSFS_ATTR_NAME_LENGTH,
+						 GFP_KERNEL);
+		if (!scrub_dev->region_name) {
+			err = -ENOMEM;
+			goto free_region_groups;
+		}
+	}
+
+	ngroups = 0;
+	scrub_dev->ngroups = 0;
+	if (nregions) {
+		region_name = scrub_dev->region_name;
+		for (region_id = 0; region_id < nregions; region_id++) {
+			attrs = scrub_create_attrs(drvdata, ops, region_id);
+			if (IS_ERR(attrs)) {
+				err = PTR_ERR(attrs);
+				goto free_attrs;
+			}
+			snprintf((char *)region_name, SCRUB_MAX_SYSFS_ATTR_NAME_LENGTH,
+				 "region%d", region_id);
+			scrub_dev->region_groups[region_id].name = (char *)region_name;
+			scrub_dev->region_groups[region_id].attrs = attrs;
+			region_name++;
+			scrub_dev->groups[ngroups++] = &scrub_dev->region_groups[region_id];
+			scrub_dev->ngroups = ngroups;
+		}
+	} else {
+		attrs = scrub_create_attrs(drvdata, ops, -1);
+		if (IS_ERR(attrs)) {
+			err = PTR_ERR(attrs);
+			goto free_region_name;
+		}
+		scrub_dev->group.attrs = attrs;
+		scrub_dev->groups[ngroups++] = &scrub_dev->group;
+		scrub_dev->ngroups = ngroups;
+	}
+
+	hdev->groups = scrub_dev->groups;
+	hdev->class = &scrub_class;
+	hdev->parent = dev;
+	dev_set_drvdata(hdev, drvdata);
+	dev_set_name(hdev, SCRUB_ID_FORMAT, scrub_dev->id);
+	snprintf(scrub_dev->name, SCRUB_DEV_MAX_NAME_LENGTH, "%s", name);
+	err = device_register(hdev);
+	if (err) {
+		put_device(hdev);
+		return ERR_PTR(err);
+	}
+
+	return hdev;
+
+free_attrs:
+	for (count = 0; count < scrub_dev->ngroups; count++) {
+		group = (struct attribute_group *)scrub_dev->groups[count];
+		if (group)
+			scrub_free_attrs(group->attrs);
+	}
+
+free_region_name:
+	kfree(scrub_dev->region_name);
+
+free_region_groups:
+	kfree(scrub_dev->region_groups);
+
+free_groups:
+	kfree(scrub_dev->groups);
+
+free_ida:
+	ida_free(&scrub_ida, scrub_dev->id);
+
+free_scrub_dev:
+	kfree(scrub_dev);
+	return ERR_PTR(err);
+}
+
+static void devm_scrub_release(void *dev)
+{
+	struct device *hdev = dev;
+
+	device_unregister(hdev);
+}
+
+/**
+ * devm_scrub_device_register - register hw scrubber device
+ * @dev: the parent device (mandatory)
+ * @name: hw scrubber name attribute (mandatory)
+ * @drvdata: driver data to attach to created device (mandatory)
+ * @ops: pointer to scrub_ops structure (mandatory)
+ * @nregions: number of scrub regions to create (optional)
+ *
+ * Returns the pointer to the new device. The new device is automatically
+ * unregistered with the parent device.
+ */
+struct device *
+devm_scrub_device_register(struct device *dev, const char *name,
+			   void *drvdata,
+			   const struct scrub_ops *ops,
+			   int nregions)
+{
+	struct device *hdev;
+	int ret;
+
+	if (!dev || !name || !ops)
+		return ERR_PTR(-EINVAL);
+
+	hdev = scrub_device_register(dev, name, drvdata, ops, nregions);
+	if (IS_ERR(hdev))
+		return hdev;
+
+	ret = devm_add_action_or_reset(dev, devm_scrub_release, hdev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return hdev;
+}
+EXPORT_SYMBOL_GPL(devm_scrub_device_register);
+
+static int __init memory_scrub_control_init(void)
+{
+	int err;
+
+	err = class_register(&scrub_class);
+	if (err) {
+		pr_err("couldn't register memory scrub control sysfs class\n");
+		return err;
+	}
+
+	return 0;
+}
+subsys_initcall(memory_scrub_control_init);
diff --git a/include/memory/memory-scrub.h b/include/memory/memory-scrub.h
new file mode 100755
index 000000000000..d7cbde4718d0
--- /dev/null
+++ b/include/memory/memory-scrub.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Memory scrub controller driver support to configure
+ * the parameters of the memory scrubbers and enable.
+ *
+ * Copyright (c) 2023 HiSilicon Limited.
+ */
+
+#ifndef __MEMORY_SCRUB_H
+#define __MEMORY_SCRUB_H
+
+#include <linux/types.h>
+
+enum scrub_types {
+	scrub_common,
+	scrub_max,
+};
+
+enum scrub_attributes {
+	/* scrub attributes - common */
+	scrub_addr_base,
+	scrub_addr_size,
+	scrub_enable,
+	scrub_speed,
+	scrub_speed_available,
+	max_attrs,
+};
+
+/**
+ * struct scrub_ops - scrub device operations
+ * @is_visible: Callback to return attribute visibility. Mandatory.
+ *		Parameters are:
+ *		@drvdata:
+ *			pointer to driver-private data structure passed
+ *			as argument to scrub_device_register().
+ *		@attr:	scrubber attribute
+ *		@region_id:
+ *			memory region id
+ *		The function returns the file permissions.
+ *		If the return value is 0, no attribute will be created.
+ * @read:	Read callback for data attributes. Mandatory if readable
+ *		data attributes are present.
+ *		Parameters are:
+ *		@dev:	pointer to hardware scrub device
+ *		@attr:	scrubber attribute
+ *		@region_id:
+ *			memory region id
+ *		@val:	pointer to returned value
+ *		The function returns 0 on success or a negative error number.
+ * @read_string: Read callback for string attributes. Mandatory if string
+ *		attributes are present.
+ *		Parameters are:
+ *		@dev:	pointer to hardware scrub device
+ *		@attr:	scrubber attribute
+ *		@region_id:
+ *			memory region id
+ *		@buf:	pointer to buffer to copy string
+ *		The function returns 0 on success or a negative error number.
+ * @write:	Write callback for data attributes. Mandatory if writeable
+ *		data attributes are present.
+ *		Parameters are:
+ *		@dev:	pointer to hardware scrub device
+ *		@attr:	scrubber attribute
+ *		@region_id:
+ *			memory region id
+ *		@val:	value to write
+ *		The function returns 0 on success or a negative error number.
+ */
+struct scrub_ops {
+	umode_t (*is_visible)(const void *drvdata, u32 attr, int region_id);
+	int (*read)(struct device *dev, u32 attr, int region_id, u64 *val);
+	int (*read_string)(struct device *dev, u32 attr, int region_id, char *buf);
+	int (*write)(struct device *dev, u32 attr, int region_id, u64 val);
+};
+
+struct device *
+devm_scrub_device_register(struct device *dev, const char *name,
+			   void *drvdata, const struct scrub_ops *ops,
+			   int nregions);
+#endif /* __MEMORY_SCRUB_H */
-- 
2.34.1

