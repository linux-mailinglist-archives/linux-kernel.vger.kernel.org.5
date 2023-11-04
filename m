Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329097E0E1F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 07:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjKDGrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 02:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjKDGr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 02:47:27 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD1ED4E;
        Fri,  3 Nov 2023 23:47:24 -0700 (PDT)
Received: from mail.maildlp.com (unknown [172.19.93.142])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SMp7n3p7Pz4f3lDl;
        Sat,  4 Nov 2023 14:47:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
        by mail.maildlp.com (Postfix) with ESMTP id 29FEF1A016E;
        Sat,  4 Nov 2023 14:47:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
        by APP4 (Coremail) with SMTP id gCh0CgDnfd3z6EVlglQtEw--.50758S8;
        Sat, 04 Nov 2023 14:47:21 +0800 (CST)
From:   Zhang Xiaoxu <zhangxiaoxu@huaweicloud.com>
To:     zhangxiaoxu5@huawei.com, weiyongjun1@huawei.com,
        broonie@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        frowand.list@gmail.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 -next 4/5] spi: mockup: Add speed and flags attribute support
Date:   Sat,  4 Nov 2023 14:46:49 +0800
Message-Id: <20231104064650.972687-5-zhangxiaoxu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231104064650.972687-1-zhangxiaoxu@huaweicloud.com>
References: <20231104064650.972687-1-zhangxiaoxu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDnfd3z6EVlglQtEw--.50758S8
X-Coremail-Antispam: 1UD129KBjvJXoWxCF18Kw1xCw4DJF4fZr1UJrb_yoWrJF43pF
        WUAFy5t3y8JFn8WF43J3yku345Arn5KrWUGa4akr1Fk3s8KrykX3Z7JF15tan5JFWDCF4j
        vFWIvF40kF4Ivr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
        42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjxUrCJmUUUUU
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

This enable configure the spi speed and flags through configfs:

  echo 40000 > /sys/kernel/config/spi-mockup/spi0/min_speed
  echo 25000000 > /sys/kernel/config/spi-mockup/spi0/max_speed
  echo 0 > /sys/kernel/config/spi-mockup/spi0/flags
  echo 8 > /sys/kernel/config/spi-mockup/spi0/num_cs

Then enable the device can use the special config:

  echo 1 > /sys/kernel/config/spi-mockup/spi0/enable

Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 drivers/spi/spi-mockup.c | 55 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/spi/spi-mockup.c b/drivers/spi/spi-mockup.c
index b449a2b7cdd4..06848504d144 100644
--- a/drivers/spi/spi-mockup.c
+++ b/drivers/spi/spi-mockup.c
@@ -207,11 +207,19 @@ static int spi_mockup_transfer(struct spi_controller *ctrl,
 	return ret;
 }
 
+struct spi_mockup_priv_data {
+	u32 min_speed;
+	u32 max_speed;
+	u16 flags;
+	u16 num_cs;
+};
+
 static int spi_mockup_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct mockup_spi *mock;
 	struct spi_controller *ctrl;
+	struct spi_mockup_priv_data *data;
 
 	ctrl = spi_alloc_host(&pdev->dev, sizeof(struct mockup_spi));
 	if (!ctrl) {
@@ -228,6 +236,14 @@ static int spi_mockup_probe(struct platform_device *pdev)
 	ctrl->bus_num = pdev->id;
 	ctrl->transfer_one_message = spi_mockup_transfer;
 
+	data = dev_get_platdata(&pdev->dev);
+	if (data) {
+		ctrl->min_speed_hz = data->min_speed;
+		ctrl->max_speed_hz = data->max_speed;
+		ctrl->flags = data->flags;
+		ctrl->num_chipselect = data->num_cs;
+	}
+
 	mock = spi_controller_get_devdata(ctrl);
 	mutex_init(&mock->lock);
 
@@ -259,6 +275,7 @@ struct spi_mockup_device {
 	unsigned int bus_nr;
 	struct mutex lock;
 	struct platform_device *pdev;
+	struct spi_mockup_priv_data data;
 };
 
 static struct spi_mockup_device *to_spi_mockup_dev(struct config_item *item)
@@ -283,6 +300,9 @@ spi_mockup_enable_store(struct config_item *item, const char *page, size_t len)
 
 	pdevinfo.name = "spi-mockup";
 	pdevinfo.id = dev->bus_nr;
+	pdevinfo.data = &dev->data;
+	pdevinfo.size_data = sizeof(dev->data);
+
 	dev->pdev = platform_device_register_full(&pdevinfo);
 	if (IS_ERR(dev->pdev)) {
 		ret = PTR_ERR(dev->pdev);
@@ -315,9 +335,43 @@ spi_mockup_disable_store(struct config_item *item, const char *page, size_t len)
 }
 CONFIGFS_ATTR_WO(spi_mockup_, disable);
 
+#define SPI_MOCKUP_ATTR(type, name) \
+static ssize_t spi_mockup_ ## name ## _store(struct config_item *item,	   \
+					     const char *page, size_t len) \
+{									   \
+	int ret;							   \
+	type val;							   \
+	struct spi_mockup_device *dev = to_spi_mockup_dev(item);	   \
+									   \
+	mutex_lock(&dev->lock);						   \
+	if (dev->pdev) {						   \
+		ret = -EBUSY;						   \
+		goto out;						   \
+	}								   \
+									   \
+	ret = kstrto ## type(page, 0, &val);				   \
+	if (ret)							   \
+		goto out;						   \
+									   \
+	dev->data.name = val;						   \
+out:									   \
+	mutex_unlock(&dev->lock);					   \
+	return ret ? ret : len;						   \
+}									   \
+CONFIGFS_ATTR_WO(spi_mockup_, name)					   \
+
+SPI_MOCKUP_ATTR(u32, min_speed)
+SPI_MOCKUP_ATTR(u32, max_speed)
+SPI_MOCKUP_ATTR(u16, flags)
+SPI_MOCKUP_ATTR(u16, num_cs)
+
 static struct configfs_attribute *spi_mockup_configfs_attrs[] = {
 	&spi_mockup_attr_enable,
 	&spi_mockup_attr_disable,
+	&spi_mockup_attr_min_speed,
+	&spi_mockup_attr_max_speed,
+	&spi_mockup_attr_flags,
+	&spi_mockup_attr_num_cs,
 	NULL,
 };
 
@@ -342,6 +396,7 @@ spi_mockup_config_make_device_group(struct config_group *group,
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
 
+	dev->data.num_cs = MOCKUP_CHIPSELECT_MAX;
 	dev->bus_nr = nr;
 	mutex_init(&dev->lock);
 
-- 
2.34.1

