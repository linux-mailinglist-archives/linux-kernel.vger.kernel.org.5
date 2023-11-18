Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE40B7EFF1C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 11:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjKRKpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 05:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjKRKpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 05:45:35 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E079710DF;
        Sat, 18 Nov 2023 02:45:30 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SXVm41TWpz4f3lfP;
        Sat, 18 Nov 2023 18:45:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 540E81A01A1;
        Sat, 18 Nov 2023 18:45:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
        by APP1 (Coremail) with SMTP id cCh0CgBXWhDClVhlAjMGBQ--.58652S6;
        Sat, 18 Nov 2023 18:45:28 +0800 (CST)
From:   Zhang Xiaoxu <zhangxiaoxu@huawecloud.com>
To:     zhangxiaoxu5@huawei.com, weiyongjun1@huawei.com,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, frowand.list@gmail.com,
        linux-spi@vger.kernel.org
Subject: [PATCH v4 -next 2/4] spi: mockup: Add register spi device support
Date:   Sat, 18 Nov 2023 18:44:40 +0800
Message-Id: <20231118104442.861759-3-zhangxiaoxu@huawecloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118104442.861759-1-zhangxiaoxu@huawecloud.com>
References: <20231118104442.861759-1-zhangxiaoxu@huawecloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBXWhDClVhlAjMGBQ--.58652S6
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr4DAFW7Gw1DWw47GFyDWrg_yoW3JFWDpF
        yrAa4YvrWrGrZ8Wr45JFW8W34Fkr18KryUA3s3C3WFkwnxJry8Xas7GF1ayF1rAFWkGF17
        ZFyrAF18Cr4jyrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l42xK82IY64kExVAvwVAq07
        x20xyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxU2TmhDUUUU
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

This enable register the spi device to mockup host, it depends
configfs. After enable the mockup host, register the device by
executing the following command:

  $ mkdir /config/spi-mockup/spi0/max31722
  $ echo -n max31722 > /config/spi-mockup/spi0/max31722/device_id
  $ echo 1 > /config/spi-mockup/spi0/max31722/live

Unregister by:

  $ echo 0 > /config/spi-mockup/spi0/max31722/live
  $ rmdir /config/spi-mockup/spi0/max31722

Signed-off-by: Zhang Xiaoxu <zhangxiaoxu@huawei.com>
---
 drivers/spi/spi-mockup.c | 208 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 208 insertions(+)

diff --git a/drivers/spi/spi-mockup.c b/drivers/spi/spi-mockup.c
index acb502c14676..f053579cc37f 100644
--- a/drivers/spi/spi-mockup.c
+++ b/drivers/spi/spi-mockup.c
@@ -18,6 +18,7 @@
 
 struct spi_mockup_host {
 	struct config_group group;
+	struct config_group targets_group;
 
 	struct mutex lock;
 
@@ -29,6 +30,7 @@ struct spi_mockup_host {
 
 	struct platform_device *pdev;
 	struct spi_controller *ctrl;
+	unsigned long bitmap[BITS_TO_LONGS(MOCKUP_CHIPSELECT_MAX)];
 };
 
 static struct spi_mockup_host *to_spi_mockup_host(struct config_item *item)
@@ -38,6 +40,205 @@ static struct spi_mockup_host *to_spi_mockup_host(struct config_item *item)
 	return container_of(group, struct spi_mockup_host, group);
 }
 
+static struct spi_mockup_host *
+to_spi_mockup_host_from_targets(struct config_group *targets_group)
+{
+	return container_of(targets_group,
+			    struct spi_mockup_host, targets_group);
+}
+
+struct spi_mockup_target {
+	struct config_group group;
+	unsigned short chip;
+	char device_id[SPI_NAME_SIZE];
+	struct spi_device *spi;
+	struct spi_mockup_host *host;
+};
+
+static struct spi_mockup_target *to_spi_mockup_target(struct config_item *item)
+{
+	struct config_group *group = to_config_group(item);
+
+	return container_of(group, struct spi_mockup_target, group);
+}
+
+static ssize_t
+spi_mockup_target_device_id_show(struct config_item *item, char *buf)
+{
+	struct spi_mockup_target *target = to_spi_mockup_target(item);
+
+	return sprintf(buf, "%s\n", target->device_id);
+}
+
+static ssize_t
+spi_mockup_target_device_id_store(struct config_item *item,
+				  const char *buf, size_t len)
+{
+	struct spi_mockup_target *target = to_spi_mockup_target(item);
+
+	if (len > SPI_NAME_SIZE)
+		return -EINVAL;
+
+	memcpy(target->device_id, buf, len);
+
+	return len;
+}
+CONFIGFS_ATTR(spi_mockup_target_, device_id);
+
+static int __target_online(struct spi_mockup_target *target)
+{
+	struct spi_board_info info = {0};
+	struct device *dev;
+
+	if (target->spi)
+		return -EBUSY;
+
+	if (!target->host->pdev)
+		return -ENODEV;
+
+	target->chip = find_first_zero_bit(target->host->bitmap,
+					   MOCKUP_CHIPSELECT_MAX);
+	if (target->chip < 0)
+		return target->chip;
+
+	if (target->chip > target->host->num_cs)
+		return -EBUSY;
+
+	info.chip_select = target->chip;
+	strncpy(info.modalias, target->device_id,
+		strlen(target->device_id));
+
+	target->spi = spi_new_device(target->host->ctrl, &info);
+	if (!target->spi)
+		return -ENOMEM;
+
+	bitmap_set(target->host->bitmap, target->chip, 1);
+
+	dev = &target->host->ctrl->dev;
+	dev_info(dev, "Instantiated device %s at 0x%02x\n",
+		 info.modalias, info.chip_select);
+
+	return 0;
+}
+
+static int __target_offline(struct spi_mockup_target *target)
+{
+	struct device *dev;
+
+	if (!target->spi)
+		return -ENODEV;
+
+	dev = &target->host->ctrl->dev;
+	dev_info(dev, "Deleting device %s at 0x%02hx\n",
+		 dev_name(&target->spi->dev), target->chip);
+
+	spi_unregister_device(target->spi);
+	target->spi = NULL;
+
+	bitmap_clear(target->host->bitmap, target->chip, 1);
+
+
+	return 0;
+}
+
+static ssize_t
+spi_mockup_target_live_store(struct config_item *item,
+			     const char *buf, size_t len)
+{
+	struct spi_mockup_target *target = to_spi_mockup_target(item);
+	int ret;
+	bool res;
+
+	ret = kstrtobool(buf, &res);
+	if (ret)
+		return -EINVAL;
+
+	if (!strlen(target->device_id))
+		return -EINVAL;
+
+	mutex_lock(&target->host->lock);
+	if (res)
+		ret = __target_online(target);
+	else
+		ret = __target_offline(target);
+	mutex_unlock(&target->host->lock);
+
+	return ret ? ret : len;
+}
+
+static ssize_t
+spi_mockup_target_live_show(struct config_item *item, char *buf)
+{
+	struct spi_mockup_target *target = to_spi_mockup_target(item);
+
+	return sprintf(buf, "%s\n", (target->spi) ? "true" : "false");
+}
+CONFIGFS_ATTR(spi_mockup_target_, live);
+
+
+static struct configfs_attribute *spi_mockup_target_attrs[] = {
+	&spi_mockup_target_attr_device_id,
+	&spi_mockup_target_attr_live,
+	NULL,
+};
+
+static void spi_mockup_target_release(struct config_item *item)
+{
+	struct spi_mockup_target *target = to_spi_mockup_target(item);
+
+	__target_offline(target);
+	kfree(target);
+}
+
+static struct configfs_item_operations spi_mockup_target_item_ops = {
+	.release = spi_mockup_target_release,
+};
+
+static const struct config_item_type spi_mockup_target_item_type = {
+	.ct_owner	= THIS_MODULE,
+	.ct_attrs	= spi_mockup_target_attrs,
+	.ct_item_ops    = &spi_mockup_target_item_ops,
+};
+
+static struct config_group *
+spi_mockup_target_make_group(struct config_group *group, const char *name)
+{
+	struct spi_mockup_target *target;
+	struct spi_mockup_host *host = to_spi_mockup_host_from_targets(group);
+
+	target = kzalloc(sizeof(*target), GFP_KERNEL);
+	if (!target)
+		return ERR_PTR(-ENOMEM);
+
+	target->host = host;
+
+	config_group_init_type_name(&target->group, name,
+				    &spi_mockup_target_item_type);
+
+	return &target->group;
+}
+
+static struct configfs_group_operations spi_mockup_targets_group_ops = {
+	.make_group = spi_mockup_target_make_group,
+};
+
+static void spi_mockup_targets_group_release(struct config_item *item)
+{
+	struct spi_mockup_target *target = to_spi_mockup_target(item);
+
+	kfree(target);
+}
+
+static struct configfs_item_operations spi_mockup_targets_group_item_ops = {
+	.release = spi_mockup_targets_group_release,
+};
+
+static const struct config_item_type spi_mockup_target_type = {
+	.ct_owner     = THIS_MODULE,
+	.ct_group_ops = &spi_mockup_targets_group_ops,
+	.ct_item_ops  = &spi_mockup_targets_group_item_ops,
+};
+
 static ssize_t __host_online(struct spi_mockup_host *host)
 {
 	int ret;
@@ -69,6 +270,9 @@ static ssize_t __host_offline(struct spi_mockup_host *host)
 	if (!host->pdev)
 		return -ENODEV;
 
+	if (!bitmap_empty(host->bitmap, host->num_cs))
+		return -EBUSY;
+
 	platform_device_unregister(host->pdev);
 	host->pdev = NULL;
 	host->ctrl = NULL;
@@ -192,6 +396,10 @@ spi_mockup_host_make_group(struct config_group *group, const char *name)
 	config_group_init_type_name(&host->group, name,
 				    &spi_mockup_host_config_group_type);
 
+	config_group_init_type_name(&host->targets_group, "targets",
+				    &spi_mockup_target_type);
+	configfs_add_default_group(&host->targets_group, &host->group);
+
 	return &host->group;
 }
 
-- 
2.34.1

