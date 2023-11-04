Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF08D7E0E1E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 07:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjKDGrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 02:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjKDGr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 02:47:27 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13E7D4C;
        Fri,  3 Nov 2023 23:47:23 -0700 (PDT)
Received: from mail.maildlp.com (unknown [172.19.93.142])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SMp7p4MR3z4f3jqq;
        Sat,  4 Nov 2023 14:47:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
        by mail.maildlp.com (Postfix) with ESMTP id CA72A1A0172;
        Sat,  4 Nov 2023 14:47:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
        by APP4 (Coremail) with SMTP id gCh0CgDnfd3z6EVlglQtEw--.50758S7;
        Sat, 04 Nov 2023 14:47:20 +0800 (CST)
From:   Zhang Xiaoxu <zhangxiaoxu@huaweicloud.com>
To:     zhangxiaoxu5@huawei.com, weiyongjun1@huawei.com,
        broonie@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        frowand.list@gmail.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 -next 3/5] spi: mockup: Add support register the device through configfs
Date:   Sat,  4 Nov 2023 14:46:48 +0800
Message-Id: <20231104064650.972687-4-zhangxiaoxu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231104064650.972687-1-zhangxiaoxu@huaweicloud.com>
References: <20231104064650.972687-1-zhangxiaoxu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDnfd3z6EVlglQtEw--.50758S7
X-Coremail-Antispam: 1UD129KBjvJXoW3AF47Jw4rGF13Jw1xurW3KFg_yoW7Zw4DpF
        Z8AFy5trW8GFs8WF4fC34kuF95Gr1xKr4Uta43Aw1FkwnrAry8Zas7WFyYyr48JFWDGF47
        ZFWfZF10krWjvrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjxUrfOzDUUUU
X-CM-SenderInfo: x2kd0wp0ld053x6k3tpzhluzxrxghudrp/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>

This enable/disable the spi mockup device through the configfs:

  mkdir /sys/kernel/config/spi-mockup/spi0

  echo 1 > /sys/kernel/config/spi-mockup/spi0/enable
  echo 1 > /sys/kernel/config/spi-mockup/spi0/disable

Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 drivers/spi/spi-mockup.c | 163 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 161 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mockup.c b/drivers/spi/spi-mockup.c
index fcaaa61bdb38..b449a2b7cdd4 100644
--- a/drivers/spi/spi-mockup.c
+++ b/drivers/spi/spi-mockup.c
@@ -12,6 +12,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
+#include <linux/configfs.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/spi_mockup.h>
@@ -224,7 +225,7 @@ static int spi_mockup_probe(struct platform_device *pdev)
 	ctrl->dev.groups = spi_mockup_groups;
 	ctrl->num_chipselect = MOCKUP_CHIPSELECT_MAX;
 	ctrl->mode_bits = SPI_MODE_USER_MASK;
-	ctrl->bus_num = 0;
+	ctrl->bus_num = pdev->id;
 	ctrl->transfer_one_message = spi_mockup_transfer;
 
 	mock = spi_controller_get_devdata(ctrl);
@@ -252,7 +253,165 @@ static struct platform_driver spi_mockup_driver = {
 		.of_match_table = spi_mockup_match,
 	},
 };
-module_platform_driver(spi_mockup_driver);
+
+struct spi_mockup_device {
+	struct config_group group;
+	unsigned int bus_nr;
+	struct mutex lock;
+	struct platform_device *pdev;
+};
+
+static struct spi_mockup_device *to_spi_mockup_dev(struct config_item *item)
+{
+	struct config_group *group = to_config_group(item);
+
+	return container_of(group, struct spi_mockup_device, group);
+}
+
+static ssize_t
+spi_mockup_enable_store(struct config_item *item, const char *page, size_t len)
+{
+	int ret = len;
+	struct platform_device_info pdevinfo = {0};
+	struct spi_mockup_device *dev = to_spi_mockup_dev(item);
+
+	mutex_lock(&dev->lock);
+	if (dev->pdev) {
+		ret = -EEXIST;
+		goto out;
+	}
+
+	pdevinfo.name = "spi-mockup";
+	pdevinfo.id = dev->bus_nr;
+	dev->pdev = platform_device_register_full(&pdevinfo);
+	if (IS_ERR(dev->pdev)) {
+		ret = PTR_ERR(dev->pdev);
+		dev->pdev = NULL;
+		goto out;
+	}
+out:
+	mutex_unlock(&dev->lock);
+	return ret;
+}
+CONFIGFS_ATTR_WO(spi_mockup_, enable);
+
+static ssize_t
+spi_mockup_disable_store(struct config_item *item, const char *page, size_t len)
+{
+	int ret = len;
+	struct spi_mockup_device *dev = to_spi_mockup_dev(item);
+
+	mutex_lock(&dev->lock);
+	if (!dev->pdev) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	platform_device_unregister(dev->pdev);
+	dev->pdev = NULL;
+out:
+	mutex_unlock(&dev->lock);
+	return ret;
+}
+CONFIGFS_ATTR_WO(spi_mockup_, disable);
+
+static struct configfs_attribute *spi_mockup_configfs_attrs[] = {
+	&spi_mockup_attr_enable,
+	&spi_mockup_attr_disable,
+	NULL,
+};
+
+static const struct config_item_type spi_mockup_device_config_group_type = {
+	.ct_owner	= THIS_MODULE,
+	.ct_attrs	= spi_mockup_configfs_attrs,
+};
+
+static struct config_group *
+spi_mockup_config_make_device_group(struct config_group *group,
+				    const char *name)
+{
+	int ret, nchar;
+	unsigned int nr;
+	struct spi_mockup_device *dev;
+
+	ret = sscanf(name, "spi%u%n", &nr, &nchar);
+	if (ret != 1 || nchar != strlen(name))
+		return ERR_PTR(-EINVAL);
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return ERR_PTR(-ENOMEM);
+
+	dev->bus_nr = nr;
+	mutex_init(&dev->lock);
+
+	config_group_init_type_name(&dev->group, name,
+				    &spi_mockup_device_config_group_type);
+
+	return &dev->group;
+}
+
+static void spi_mockup_config_group_release(struct config_item *item)
+{
+	struct spi_mockup_device *dev = to_spi_mockup_dev(item);
+
+	kfree(dev);
+}
+
+static struct configfs_item_operations spi_mockup_config_item_ops = {
+	.release = spi_mockup_config_group_release,
+};
+
+static struct configfs_group_operations spi_mockup_config_group_ops = {
+	.make_group = spi_mockup_config_make_device_group,
+};
+
+static const struct config_item_type spi_mockup_config_type = {
+	.ct_owner	= THIS_MODULE,
+	.ct_group_ops	= &spi_mockup_config_group_ops,
+	.ct_item_ops	= &spi_mockup_config_item_ops,
+};
+
+static struct configfs_subsystem spi_mockup_config_subsys = {
+	.su_group = {
+		.cg_item = {
+			.ci_namebuf = "spi-mockup",
+			.ci_type = &spi_mockup_config_type,
+		}
+	}
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
 
 MODULE_AUTHOR("Wei Yongjun <weiyongjun1@huawei.com>");
 MODULE_DESCRIPTION("SPI controller Testing Driver");
-- 
2.34.1

