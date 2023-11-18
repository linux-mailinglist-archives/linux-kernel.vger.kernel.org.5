Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A7B7EFF19
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 11:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjKRKph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 05:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjKRKpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 05:45:35 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2D695;
        Sat, 18 Nov 2023 02:45:30 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SXVm52g3lz4f3jqj;
        Sat, 18 Nov 2023 18:45:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id F35C11A01A4;
        Sat, 18 Nov 2023 18:45:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
        by APP1 (Coremail) with SMTP id cCh0CgBXWhDClVhlAjMGBQ--.58652S5;
        Sat, 18 Nov 2023 18:45:27 +0800 (CST)
From:   Zhang Xiaoxu <zhangxiaoxu@huawecloud.com>
To:     zhangxiaoxu5@huawei.com, weiyongjun1@huawei.com,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, frowand.list@gmail.com,
        linux-spi@vger.kernel.org
Subject: [PATCH v4 -next 1/4] spi: mockup: Add SPI controller testing driver
Date:   Sat, 18 Nov 2023 18:44:39 +0800
Message-Id: <20231118104442.861759-2-zhangxiaoxu@huawecloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118104442.861759-1-zhangxiaoxu@huawecloud.com>
References: <20231118104442.861759-1-zhangxiaoxu@huawecloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBXWhDClVhlAjMGBQ--.58652S5
X-Coremail-Antispam: 1UD129KBjvJXoWxtFWfJw4rGr4rWr18ZrW7CFg_yoWDGry3pF
        W5CFy3trW8JFs8Wr4fGay8uF95Crn29ryUt3s3Z34FywnxtrWkZwn7GFy5tFs5JFWDGr12
        vFWFyF1UCrWYyr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l42xK82IY64kExVAvwVAq07
        x20xyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUzb18DUUUU
Sender: zhangxiaoxu@huaweicloud.com
X-CM-SenderInfo: x2kd0wp0ld053x6k3tpzhluzxrxghudrp/
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>

This enables SPI controller testing driver, which provides a
way to test SPI subsystem. Its controlled by configfs and can
by use as below:

Create the controller by executing the following command:

  $ mkdir /config/spi-mockup/spi0

Configure it by:

  $ echo 40000 > /config/spi-mockup/spi0/min_speed
  $ echo 25000000 > /config/spi-mockup/spi0/max_speed
  $ echo 0 > /config/spi-mockup/spi0/flags
  $ echo 8 > /config/spi-mockup/spi0/num_cs

Enable:  $ echo 1 > /config/spi-mockup/spi0/live
Disable: $ echo 0 > /config/spi-mockup/spi0/live
Remove:  $ rmdir /config/spi-mockup/spi0

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 drivers/spi/Kconfig      |  11 ++
 drivers/spi/Makefile     |   1 +
 drivers/spi/spi-mockup.c | 305 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 317 insertions(+)
 create mode 100644 drivers/spi/spi-mockup.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 35dbfacecf1c..6524735a4936 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1230,6 +1230,17 @@ config SPI_TLE62X0
 	  sysfs interface, with each line presented as a kind of GPIO
 	  exposing both switch control and diagnostic feedback.
 
+config SPI_MOCKUP
+	tristate "SPI controller Testing Driver"
+	help
+	  This enables SPI controller testing driver, which provides a way to
+	  test SPI subsystem.
+
+	  If you do build this module, be sure to read the notes and warnings
+	  in <file:Documentation/spi/spi-mockup.rst>.
+
+	  If you don't know what to do here, definitely say N.
+
 #
 # Add new SPI protocol masters in alphabetical order above this line
 #
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 4ff8d725ba5e..ab5a1a12b5ac 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_SPI_MEM)			+= spi-mem.o
 obj-$(CONFIG_SPI_MUX)			+= spi-mux.o
 obj-$(CONFIG_SPI_SPIDEV)		+= spidev.o
 obj-$(CONFIG_SPI_LOOPBACK_TEST)		+= spi-loopback-test.o
+obj-$(CONFIG_SPI_MOCKUP)		+= spi-mockup.o
 
 # SPI master controller drivers (bus)
 obj-$(CONFIG_SPI_ALTERA)		+= spi-altera-platform.o
diff --git a/drivers/spi/spi-mockup.c b/drivers/spi/spi-mockup.c
new file mode 100644
index 000000000000..acb502c14676
--- /dev/null
+++ b/drivers/spi/spi-mockup.c
@@ -0,0 +1,305 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * SPI controller Testing Driver
+ *
+ * Copyright(c) 2022 Huawei Technologies Co., Ltd.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/configfs.h>
+
+#define MOCKUP_CHIPSELECT_MAX	U16_MAX
+
+struct spi_mockup_host {
+	struct config_group group;
+
+	struct mutex lock;
+
+	unsigned int bus_nr;
+	u32 min_speed;
+	u32 max_speed;
+	u16 flags;
+	u16 num_cs;
+
+	struct platform_device *pdev;
+	struct spi_controller *ctrl;
+};
+
+static struct spi_mockup_host *to_spi_mockup_host(struct config_item *item)
+{
+	struct config_group *group = to_config_group(item);
+
+	return container_of(group, struct spi_mockup_host, group);
+}
+
+static ssize_t __host_online(struct spi_mockup_host *host)
+{
+	int ret;
+	struct platform_device_info pdevinfo = {0};
+
+	if (host->pdev)
+		return -EEXIST;
+
+	pdevinfo.name = "spi-mockup";
+	pdevinfo.id = host->bus_nr;
+
+	/* Use the pointer of host as the data, then probe
+	 * can init the host->ctrl */
+	pdevinfo.data = &host;
+	pdevinfo.size_data = sizeof(&host);
+
+	host->pdev = platform_device_register_full(&pdevinfo);
+	if (IS_ERR(host->pdev)) {
+		ret = PTR_ERR(host->pdev);
+		host->pdev = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+
+static ssize_t __host_offline(struct spi_mockup_host *host)
+{
+	if (!host->pdev)
+		return -ENODEV;
+
+	platform_device_unregister(host->pdev);
+	host->pdev = NULL;
+	host->ctrl = NULL;
+
+	return 0;
+}
+
+static ssize_t
+spi_mockup_live_store(struct config_item *item, const char *buf, size_t len)
+{
+	struct spi_mockup_host *host = to_spi_mockup_host(item);
+	int ret;
+	bool res;
+
+	ret = kstrtobool(buf, &res);
+	if (ret)
+		return ret;
+
+	mutex_lock(&host->lock);
+	if (res)
+		ret = __host_online(host);
+	else
+		ret = __host_offline(host);
+	mutex_unlock(&host->lock);
+
+	return ret ? ret : len;
+}
+
+static ssize_t
+spi_mockup_live_show(struct config_item *item, char *buf)
+{
+	struct spi_mockup_host *host = to_spi_mockup_host(item);
+
+	return sprintf(buf, "%s", (host->pdev) ? "true" : "false");
+}
+CONFIGFS_ATTR(spi_mockup_, live);
+
+
+#define SPI_MOCKUP_ATTR(type, name)					  \
+static ssize_t spi_mockup_ ## name ## _store(struct config_item *item,	  \
+					     const char *buf, size_t len) \
+{									  \
+	int ret;							  \
+	type val;							  \
+	struct spi_mockup_host *host = to_spi_mockup_host(item);	  \
+									  \
+	mutex_lock(&host->lock);					  \
+	if (host->pdev) {						  \
+		ret = -EBUSY;						  \
+		goto out;						  \
+	}								  \
+									  \
+	ret = kstrto ## type(buf, 0, &val);				  \
+	if (ret)							  \
+		goto out;						  \
+									  \
+	host->name = val;						  \
+out:									  \
+	mutex_unlock(&host->lock);					  \
+	return ret ? ret : len;						  \
+}									  \
+static ssize_t spi_mockup_ ## name ## _show(struct config_item *item,	  \
+					    char *buf)			  \
+{									  \
+	struct spi_mockup_host *host = to_spi_mockup_host(item);	  \
+	return sprintf(buf, "%u", host->name);                            \
+}                                                                         \
+CONFIGFS_ATTR(spi_mockup_, name)					  \
+
+SPI_MOCKUP_ATTR(u32, min_speed);
+SPI_MOCKUP_ATTR(u32, max_speed);
+SPI_MOCKUP_ATTR(u16, flags);
+SPI_MOCKUP_ATTR(u16, num_cs);
+
+static struct configfs_attribute *spi_mockup_host_attrs[] = {
+	&spi_mockup_attr_live,
+	&spi_mockup_attr_min_speed,
+	&spi_mockup_attr_max_speed,
+	&spi_mockup_attr_flags,
+	&spi_mockup_attr_num_cs,
+	NULL,
+};
+
+static void spi_mockup_host_release(struct config_item *item)
+{
+	struct spi_mockup_host *host = to_spi_mockup_host(item);
+
+	__host_offline(host);
+	kfree(host);
+}
+
+static struct configfs_item_operations spi_mockup_host_item_ops = {
+	.release = spi_mockup_host_release,
+};
+
+static const struct config_item_type spi_mockup_host_config_group_type = {
+	.ct_owner	= THIS_MODULE,
+	.ct_attrs	= spi_mockup_host_attrs,
+	.ct_item_ops	= &spi_mockup_host_item_ops,
+};
+
+static struct config_group *
+spi_mockup_host_make_group(struct config_group *group, const char *name)
+{
+	int ret, nchar;
+	unsigned int nr;
+	struct spi_mockup_host *host;
+
+	ret = sscanf(name, "spi%u%n", &nr, &nchar);
+	if (ret != 1 || nchar != strlen(name))
+		return ERR_PTR(-EINVAL);
+
+	host = kzalloc(sizeof(*host), GFP_KERNEL);
+	if (!host)
+		return ERR_PTR(-ENOMEM);
+
+	host->bus_nr = nr;
+	host->num_cs = MOCKUP_CHIPSELECT_MAX;
+	mutex_init(&host->lock);
+
+	config_group_init_type_name(&host->group, name,
+				    &spi_mockup_host_config_group_type);
+
+	return &host->group;
+}
+
+static struct configfs_group_operations spi_mockup_host_group_ops = {
+	.make_group = spi_mockup_host_make_group,
+};
+
+static const struct config_item_type spi_mockup_host_type = {
+	.ct_owner	= THIS_MODULE,
+	.ct_group_ops	= &spi_mockup_host_group_ops,
+};
+
+static struct configfs_subsystem spi_mockup_config_subsys = {
+	.su_group = {
+		.cg_item = {
+			.ci_namebuf = "spi-mockup",
+			.ci_type = &spi_mockup_host_type,
+		}
+	}
+};
+
+static int
+spi_mockup_transfer(struct spi_controller *ctrl, struct spi_message *msg)
+{
+	msg->status = 0;
+	spi_finalize_current_message(ctrl);
+
+	return 0;
+}
+
+static int
+spi_mockup_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct spi_controller *ctrl;
+	struct spi_mockup_host **host;
+
+	host = dev_get_platdata(&pdev->dev);
+	if (!host || !(*host))
+		return -EINVAL;
+
+	ctrl = spi_alloc_host(&pdev->dev, 0);
+	if (!ctrl) {
+		pr_err("failed to alloc spi controller\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(pdev, ctrl);
+
+	ctrl->bus_num = pdev->id;
+	ctrl->mode_bits = SPI_MODE_USER_MASK;
+	ctrl->dev.of_node = pdev->dev.of_node;
+	ctrl->transfer_one_message = spi_mockup_transfer;
+	ctrl->min_speed_hz = (*host)->min_speed;
+	ctrl->max_speed_hz = (*host)->max_speed;
+	ctrl->num_chipselect = (*host)->num_cs;
+	ctrl->flags = (*host)->flags;
+
+	ret = devm_spi_register_controller(&pdev->dev, ctrl);
+	if (ret) {
+		spi_controller_put(ctrl);
+		return ret;
+	}
+
+	(*host)->ctrl = ctrl;
+
+	return 0;
+}
+
+static struct platform_driver spi_mockup_driver = {
+	.probe = spi_mockup_probe,
+	.driver = {
+		.name = "spi-mockup",
+	},
+};
+
+static int __init spi_mockup_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&spi_mockup_driver);
+	if (ret) {
+		pr_err("spi mockup driver registering failed with %d\n", ret);
+		return ret;
+	}
+
+	config_group_init(&spi_mockup_config_subsys.su_group);
+	mutex_init(&spi_mockup_config_subsys.su_mutex);
+	ret = configfs_register_subsystem(&spi_mockup_config_subsys);
+	if (ret) {
+		pr_err("spi mockup configfs registering failed with %d\n", ret);
+		mutex_destroy(&spi_mockup_config_subsys.su_mutex);
+		platform_driver_unregister(&spi_mockup_driver);
+		return ret;
+	}
+
+	return ret;
+}
+module_init(spi_mockup_init);
+
+static void __exit spi_mockup_exit(void)
+{
+	configfs_unregister_subsystem(&spi_mockup_config_subsys);
+	mutex_destroy(&spi_mockup_config_subsys.su_mutex);
+	return platform_driver_unregister(&spi_mockup_driver);
+}
+module_exit(spi_mockup_exit);
+
+MODULE_AUTHOR("Wei Yongjun <weiyongjun1@huawei.com>");
+MODULE_DESCRIPTION("SPI controller Testing Driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

