Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429767736D3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 04:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjHHCjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 22:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjHHCjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 22:39:31 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F19E78
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 19:39:29 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKcn52fVSzrRgf;
        Tue,  8 Aug 2023 10:38:17 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 10:39:26 +0800
From:   Huisong Li <lihuisong@huawei.com>
To:     <xuwei5@hisilicon.com>, <arnd@arndb.de>, <krzk@kernel.org>,
        <sudeep.holla@arm.com>, <rdunlap@infradead.org>,
        <zenghui.yu@linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <wanghuiqiang@huawei.com>,
        <tanxiaofei@huawei.com>, <liuyonglong@huawei.com>,
        <lihuisong@huawei.com>
Subject: [PATCH v7 2/3] soc: hisilicon: add sysfs entry to query information of HCCS
Date:   Tue, 8 Aug 2023 10:36:39 +0800
Message-ID: <20230808023640.25263-3-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230808023640.25263-1-lihuisong@huawei.com>
References: <20230424073020.4039-1-lihuisong@huawei.com>
 <20230808023640.25263-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch creates chip, die and port directory based on the actual
hardware implementation of platform. Some sysfs entries under these
directories are created to query the health status and port information
of HCCS.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/soc/hisilicon/kunpeng_hccs.c | 638 +++++++++++++++++++++++++++
 drivers/soc/hisilicon/kunpeng_hccs.h |  22 +
 2 files changed, 660 insertions(+)

diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
index b61de32ce00c..6864d203c678 100644
--- a/drivers/soc/hisilicon/kunpeng_hccs.c
+++ b/drivers/soc/hisilicon/kunpeng_hccs.c
@@ -5,10 +5,27 @@
  *
  * Copyright (c) 2023 Hisilicon Limited.
  * Author: Huisong Li <lihuisong@huawei.com>
+ *
+ * HCCS driver for Kunpeng SoC provides the following features:
+ * - Retrieve the following information about each port:
+ *    - port type
+ *    - lane mode
+ *    - enable
+ *    - current lane mode
+ *    - link finite state machine
+ *    - lane mask
+ *    - CRC error count
+ *
+ * - Retrieve the following information about all the ports on the chip or
+ *   the die:
+ *    - if all enabled ports are in linked
+ *    - if all linked ports are in full lane
+ *    - CRC error count sum
  */
 #include <linux/acpi.h>
 #include <linux/iopoll.h>
 #include <linux/platform_device.h>
+#include <linux/sysfs.h>
 
 #include <acpi/pcc.h>
 
@@ -25,6 +42,21 @@
 #define HCCS_PCC_CMD_WAIT_RETRIES_NUM		500ULL
 #define HCCS_POLL_STATUS_TIME_INTERVAL_US	3
 
+static struct hccs_port_info *kobj_to_port_info(struct kobject *k)
+{
+	return container_of(k, struct hccs_port_info, kobj);
+}
+
+static struct hccs_die_info *kobj_to_die_info(struct kobject *k)
+{
+	return container_of(k, struct hccs_die_info, kobj);
+}
+
+static struct hccs_chip_info *kobj_to_chip_info(struct kobject *k)
+{
+	return container_of(k, struct hccs_chip_info, kobj);
+}
+
 struct hccs_register_ctx {
 	struct device *dev;
 	u8 chan_id;
@@ -561,6 +593,607 @@ static int hccs_get_hw_info(struct hccs_dev *hdev)
 	return 0;
 }
 
+static int hccs_query_port_link_status(struct hccs_dev *hdev,
+				       const struct hccs_port_info *port,
+				       struct hccs_link_status *link_status)
+{
+	const struct hccs_die_info *die = port->die;
+	const struct hccs_chip_info *chip = die->chip;
+	struct hccs_port_comm_req_param *req_param;
+	struct hccs_desc desc;
+	int ret;
+
+	hccs_init_req_desc(&desc);
+	req_param = (struct hccs_port_comm_req_param *)desc.req.data;
+	req_param->chip_id = chip->chip_id;
+	req_param->die_id = die->die_id;
+	req_param->port_id = port->port_id;
+	ret = hccs_pcc_cmd_send(hdev, HCCS_GET_PORT_LINK_STATUS, &desc);
+	if (ret) {
+		dev_err(hdev->dev,
+			"get port link status info failed, ret = %d.\n", ret);
+		return ret;
+	}
+
+	*link_status = *((struct hccs_link_status *)desc.rsp.data);
+
+	return 0;
+}
+
+static int hccs_query_port_crc_err_cnt(struct hccs_dev *hdev,
+				       const struct hccs_port_info *port,
+				       u64 *crc_err_cnt)
+{
+	const struct hccs_die_info *die = port->die;
+	const struct hccs_chip_info *chip = die->chip;
+	struct hccs_port_comm_req_param *req_param;
+	struct hccs_desc desc;
+	int ret;
+
+	hccs_init_req_desc(&desc);
+	req_param = (struct hccs_port_comm_req_param *)desc.req.data;
+	req_param->chip_id = chip->chip_id;
+	req_param->die_id = die->die_id;
+	req_param->port_id = port->port_id;
+	ret = hccs_pcc_cmd_send(hdev, HCCS_GET_PORT_CRC_ERR_CNT, &desc);
+	if (ret) {
+		dev_err(hdev->dev,
+			"get port crc error count failed, ret = %d.\n", ret);
+		return ret;
+	}
+
+	memcpy(crc_err_cnt, &desc.rsp.data, sizeof(u64));
+
+	return 0;
+}
+
+static int hccs_get_die_all_link_status(struct hccs_dev *hdev,
+					const struct hccs_die_info *die,
+					u8 *all_linked)
+{
+	struct hccs_die_comm_req_param *req_param;
+	struct hccs_desc desc;
+	int ret;
+
+	if (die->port_num == 0) {
+		*all_linked = 1;
+		return 0;
+	}
+
+	hccs_init_req_desc(&desc);
+	req_param = (struct hccs_die_comm_req_param *)desc.req.data;
+	req_param->chip_id = die->chip->chip_id;
+	req_param->die_id = die->die_id;
+	ret = hccs_pcc_cmd_send(hdev, HCCS_GET_DIE_PORTS_LINK_STA, &desc);
+	if (ret) {
+		dev_err(hdev->dev,
+			"get link status of all ports failed on die%u, ret = %d.\n",
+			die->die_id, ret);
+		return ret;
+	}
+
+	*all_linked = *((u8 *)&desc.rsp.data);
+
+	return 0;
+}
+
+static int hccs_get_die_all_port_lane_status(struct hccs_dev *hdev,
+					     const struct hccs_die_info *die,
+					     u8 *full_lane)
+{
+	struct hccs_die_comm_req_param *req_param;
+	struct hccs_desc desc;
+	int ret;
+
+	if (die->port_num == 0) {
+		*full_lane = 1;
+		return 0;
+	}
+
+	hccs_init_req_desc(&desc);
+	req_param = (struct hccs_die_comm_req_param *)desc.req.data;
+	req_param->chip_id = die->chip->chip_id;
+	req_param->die_id = die->die_id;
+	ret = hccs_pcc_cmd_send(hdev, HCCS_GET_DIE_PORTS_LANE_STA, &desc);
+	if (ret) {
+		dev_err(hdev->dev, "get lane status of all ports failed on die%u, ret = %d.\n",
+			die->die_id, ret);
+		return ret;
+	}
+
+	*full_lane = *((u8 *)&desc.rsp.data);
+
+	return 0;
+}
+
+static int hccs_get_die_total_crc_err_cnt(struct hccs_dev *hdev,
+					  const struct hccs_die_info *die,
+					  u64 *total_crc_err_cnt)
+{
+	struct hccs_die_comm_req_param *req_param;
+	struct hccs_desc desc;
+	int ret;
+
+	if (die->port_num == 0) {
+		*total_crc_err_cnt = 0;
+		return 0;
+	}
+
+	hccs_init_req_desc(&desc);
+	req_param = (struct hccs_die_comm_req_param *)desc.req.data;
+	req_param->chip_id = die->chip->chip_id;
+	req_param->die_id = die->die_id;
+	ret = hccs_pcc_cmd_send(hdev, HCCS_GET_DIE_PORTS_CRC_ERR_CNT, &desc);
+	if (ret) {
+		dev_err(hdev->dev, "get crc error count sum failed on die%u, ret = %d.\n",
+			die->die_id, ret);
+		return ret;
+	}
+
+	memcpy(total_crc_err_cnt, &desc.rsp.data, sizeof(u64));
+
+	return 0;
+}
+
+static ssize_t hccs_show(struct kobject *k, struct attribute *attr, char *buf)
+{
+	struct kobj_attribute *kobj_attr;
+
+	kobj_attr = container_of(attr, struct kobj_attribute, attr);
+
+	return kobj_attr->show(k, kobj_attr, buf);
+}
+
+static const struct sysfs_ops hccs_comm_ops = {
+	.show = hccs_show,
+};
+
+static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *attr,
+			 char *buf)
+{
+	const struct hccs_port_info *port = kobj_to_port_info(kobj);
+
+	return sysfs_emit(buf, "HCCS-v%u\n", port->port_type);
+}
+static struct kobj_attribute hccs_type_attr = __ATTR_RO(type);
+
+static ssize_t lane_mode_show(struct kobject *kobj, struct kobj_attribute *attr,
+			      char *buf)
+{
+	const struct hccs_port_info *port = kobj_to_port_info(kobj);
+
+	return sysfs_emit(buf, "x%u\n", port->lane_mode);
+}
+static struct kobj_attribute lane_mode_attr = __ATTR_RO(lane_mode);
+
+static ssize_t enable_show(struct kobject *kobj,
+				 struct kobj_attribute *attr, char *buf)
+{
+	const struct hccs_port_info *port = kobj_to_port_info(kobj);
+
+	return sysfs_emit(buf, "%u\n", port->enable);
+}
+static struct kobj_attribute port_enable_attr = __ATTR_RO(enable);
+
+static ssize_t cur_lane_num_show(struct kobject *kobj,
+				 struct kobj_attribute *attr, char *buf)
+{
+	const struct hccs_port_info *port = kobj_to_port_info(kobj);
+	struct hccs_dev *hdev = port->die->chip->hdev;
+	struct hccs_link_status link_status = {0};
+	int ret;
+
+	mutex_lock(&hdev->lock);
+	ret = hccs_query_port_link_status(hdev, port, &link_status);
+	mutex_unlock(&hdev->lock);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%u\n", link_status.lane_num);
+}
+static struct kobj_attribute cur_lane_num_attr = __ATTR_RO(cur_lane_num);
+
+static ssize_t link_fsm_show(struct kobject *kobj,
+			     struct kobj_attribute *attr, char *buf)
+{
+	const struct hccs_port_info *port = kobj_to_port_info(kobj);
+	struct hccs_dev *hdev = port->die->chip->hdev;
+	struct hccs_link_status link_status = {0};
+	const struct {
+		u8 link_fsm;
+		char *str;
+	} link_fsm_map[] = {
+		{HCCS_PORT_RESET, "reset"},
+		{HCCS_PORT_SETUP, "setup"},
+		{HCCS_PORT_CONFIG, "config"},
+		{HCCS_PORT_READY, "link-up"},
+	};
+	const char *link_fsm_str = "unknown";
+	size_t i;
+	int ret;
+
+	mutex_lock(&hdev->lock);
+	ret = hccs_query_port_link_status(hdev, port, &link_status);
+	mutex_unlock(&hdev->lock);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(link_fsm_map); i++) {
+		if (link_fsm_map[i].link_fsm == link_status.link_fsm) {
+			link_fsm_str = link_fsm_map[i].str;
+			break;
+		}
+	}
+
+	return sysfs_emit(buf, "%s\n", link_fsm_str);
+}
+static struct kobj_attribute link_fsm_attr = __ATTR_RO(link_fsm);
+
+static ssize_t lane_mask_show(struct kobject *kobj,
+			      struct kobj_attribute *attr, char *buf)
+{
+	const struct hccs_port_info *port = kobj_to_port_info(kobj);
+	struct hccs_dev *hdev = port->die->chip->hdev;
+	struct hccs_link_status link_status = {0};
+	int ret;
+
+	mutex_lock(&hdev->lock);
+	ret = hccs_query_port_link_status(hdev, port, &link_status);
+	mutex_unlock(&hdev->lock);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "0x%x\n", link_status.lane_mask);
+}
+static struct kobj_attribute lane_mask_attr = __ATTR_RO(lane_mask);
+
+static ssize_t crc_err_cnt_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	const struct hccs_port_info *port = kobj_to_port_info(kobj);
+	struct hccs_dev *hdev = port->die->chip->hdev;
+	u64 crc_err_cnt;
+	int ret;
+
+	mutex_lock(&hdev->lock);
+	ret = hccs_query_port_crc_err_cnt(hdev, port, &crc_err_cnt);
+	mutex_unlock(&hdev->lock);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%llu\n", crc_err_cnt);
+}
+static struct kobj_attribute crc_err_cnt_attr = __ATTR_RO(crc_err_cnt);
+
+static struct attribute *hccs_port_default_attrs[] = {
+	&hccs_type_attr.attr,
+	&lane_mode_attr.attr,
+	&port_enable_attr.attr,
+	&cur_lane_num_attr.attr,
+	&link_fsm_attr.attr,
+	&lane_mask_attr.attr,
+	&crc_err_cnt_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(hccs_port_default);
+
+static const struct kobj_type hccs_port_type = {
+	.sysfs_ops = &hccs_comm_ops,
+	.default_groups = hccs_port_default_groups,
+};
+
+static ssize_t all_linked_on_die_show(struct kobject *kobj,
+				      struct kobj_attribute *attr, char *buf)
+{
+	const struct hccs_die_info *die = kobj_to_die_info(kobj);
+	struct hccs_dev *hdev = die->chip->hdev;
+	u8 all_linked;
+	int ret;
+
+	mutex_lock(&hdev->lock);
+	ret = hccs_get_die_all_link_status(hdev, die, &all_linked);
+	mutex_unlock(&hdev->lock);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%u\n", all_linked);
+}
+static struct kobj_attribute all_linked_on_die_attr =
+		__ATTR(all_linked, 0444, all_linked_on_die_show, NULL);
+
+static ssize_t linked_full_lane_on_die_show(struct kobject *kobj,
+					    struct kobj_attribute *attr,
+					    char *buf)
+{
+	const struct hccs_die_info *die = kobj_to_die_info(kobj);
+	struct hccs_dev *hdev = die->chip->hdev;
+	u8 full_lane;
+	int ret;
+
+	mutex_lock(&hdev->lock);
+	ret = hccs_get_die_all_port_lane_status(hdev, die, &full_lane);
+	mutex_unlock(&hdev->lock);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%u\n", full_lane);
+}
+static struct kobj_attribute linked_full_lane_on_die_attr =
+	__ATTR(linked_full_lane, 0444, linked_full_lane_on_die_show, NULL);
+
+static ssize_t crc_err_cnt_sum_on_die_show(struct kobject *kobj,
+					   struct kobj_attribute *attr,
+					   char *buf)
+{
+	const struct hccs_die_info *die = kobj_to_die_info(kobj);
+	struct hccs_dev *hdev = die->chip->hdev;
+	u64 total_crc_err_cnt;
+	int ret;
+
+	mutex_lock(&hdev->lock);
+	ret = hccs_get_die_total_crc_err_cnt(hdev, die, &total_crc_err_cnt);
+	mutex_unlock(&hdev->lock);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%llu\n", total_crc_err_cnt);
+}
+static struct kobj_attribute crc_err_cnt_sum_on_die_attr =
+	__ATTR(crc_err_cnt, 0444, crc_err_cnt_sum_on_die_show, NULL);
+
+static struct attribute *hccs_die_default_attrs[] = {
+	&all_linked_on_die_attr.attr,
+	&linked_full_lane_on_die_attr.attr,
+	&crc_err_cnt_sum_on_die_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(hccs_die_default);
+
+static const struct kobj_type hccs_die_type = {
+	.sysfs_ops = &hccs_comm_ops,
+	.default_groups = hccs_die_default_groups,
+};
+
+static ssize_t all_linked_on_chip_show(struct kobject *kobj,
+				       struct kobj_attribute *attr, char *buf)
+{
+	const struct hccs_chip_info *chip = kobj_to_chip_info(kobj);
+	struct hccs_dev *hdev = chip->hdev;
+	const struct hccs_die_info *die;
+	u8 all_linked = 1;
+	u8 i, tmp;
+	int ret;
+
+	mutex_lock(&hdev->lock);
+	for (i = 0; i < chip->die_num; i++) {
+		die = &chip->dies[i];
+		ret = hccs_get_die_all_link_status(hdev, die, &tmp);
+		if (ret) {
+			mutex_unlock(&hdev->lock);
+			return ret;
+		}
+		if (tmp != all_linked) {
+			all_linked = 0;
+			break;
+		}
+	}
+	mutex_unlock(&hdev->lock);
+
+	return sysfs_emit(buf, "%u\n", all_linked);
+}
+static struct kobj_attribute all_linked_on_chip_attr =
+		__ATTR(all_linked, 0444, all_linked_on_chip_show, NULL);
+
+static ssize_t linked_full_lane_on_chip_show(struct kobject *kobj,
+					     struct kobj_attribute *attr,
+					     char *buf)
+{
+	const struct hccs_chip_info *chip = kobj_to_chip_info(kobj);
+	struct hccs_dev *hdev = chip->hdev;
+	const struct hccs_die_info *die;
+	u8 full_lane = 1;
+	u8 i, tmp;
+	int ret;
+
+	mutex_lock(&hdev->lock);
+	for (i = 0; i < chip->die_num; i++) {
+		die = &chip->dies[i];
+		ret = hccs_get_die_all_port_lane_status(hdev, die, &tmp);
+		if (ret) {
+			mutex_unlock(&hdev->lock);
+			return ret;
+		}
+		if (tmp != full_lane) {
+			full_lane = 0;
+			break;
+		}
+	}
+	mutex_unlock(&hdev->lock);
+
+	return sysfs_emit(buf, "%u\n", full_lane);
+}
+static struct kobj_attribute linked_full_lane_on_chip_attr =
+	__ATTR(linked_full_lane, 0444, linked_full_lane_on_chip_show, NULL);
+
+static ssize_t crc_err_cnt_sum_on_chip_show(struct kobject *kobj,
+					    struct kobj_attribute *attr,
+					    char *buf)
+{
+	const struct hccs_chip_info *chip = kobj_to_chip_info(kobj);
+	u64 crc_err_cnt, total_crc_err_cnt = 0;
+	struct hccs_dev *hdev = chip->hdev;
+	const struct hccs_die_info *die;
+	int ret;
+	u16 i;
+
+	mutex_lock(&hdev->lock);
+	for (i = 0; i < chip->die_num; i++) {
+		die = &chip->dies[i];
+		ret = hccs_get_die_total_crc_err_cnt(hdev, die, &crc_err_cnt);
+		if (ret) {
+			mutex_unlock(&hdev->lock);
+			return ret;
+		}
+
+		total_crc_err_cnt += crc_err_cnt;
+	}
+	mutex_unlock(&hdev->lock);
+
+	return sysfs_emit(buf, "%llu\n", total_crc_err_cnt);
+}
+static struct kobj_attribute crc_err_cnt_sum_on_chip_attr =
+		__ATTR(crc_err_cnt, 0444, crc_err_cnt_sum_on_chip_show, NULL);
+
+static struct attribute *hccs_chip_default_attrs[] = {
+	&all_linked_on_chip_attr.attr,
+	&linked_full_lane_on_chip_attr.attr,
+	&crc_err_cnt_sum_on_chip_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(hccs_chip_default);
+
+static const struct kobj_type hccs_chip_type = {
+	.sysfs_ops = &hccs_comm_ops,
+	.default_groups = hccs_chip_default_groups,
+};
+
+static void hccs_remove_die_dir(struct hccs_die_info *die)
+{
+	struct hccs_port_info *port;
+	u8 i;
+
+	for (i = 0; i < die->port_num; i++) {
+		port = &die->ports[i];
+		if (port->dir_created)
+			kobject_put(&port->kobj);
+	}
+
+	kobject_put(&die->kobj);
+}
+
+static void hccs_remove_chip_dir(struct hccs_chip_info *chip)
+{
+	struct hccs_die_info *die;
+	u8 i;
+
+	for (i = 0; i < chip->die_num; i++) {
+		die = &chip->dies[i];
+		if (die->dir_created)
+			hccs_remove_die_dir(die);
+	}
+
+	kobject_put(&chip->kobj);
+}
+
+static void hccs_remove_topo_dirs(struct hccs_dev *hdev)
+{
+	u8 i;
+
+	for (i = 0; i < hdev->chip_num; i++)
+		hccs_remove_chip_dir(&hdev->chips[i]);
+}
+
+static int hccs_create_hccs_dir(struct hccs_dev *hdev,
+				struct hccs_die_info *die,
+				struct hccs_port_info *port)
+{
+	int ret;
+
+	ret = kobject_init_and_add(&port->kobj, &hccs_port_type,
+				   &die->kobj, "hccs%d", port->port_id);
+	if (ret) {
+		kobject_put(&port->kobj);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int hccs_create_die_dir(struct hccs_dev *hdev,
+			       struct hccs_chip_info *chip,
+			       struct hccs_die_info *die)
+{
+	struct hccs_port_info *port;
+	int ret;
+	u16 i;
+
+	ret = kobject_init_and_add(&die->kobj, &hccs_die_type,
+				   &chip->kobj, "die%d", die->die_id);
+	if (ret) {
+		kobject_put(&die->kobj);
+		return ret;
+	}
+
+	for (i = 0; i < die->port_num; i++) {
+		port = &die->ports[i];
+		ret = hccs_create_hccs_dir(hdev, die, port);
+		if (ret) {
+			dev_err(hdev->dev, "create hccs%d dir failed.\n",
+				port->port_id);
+			goto err;
+		}
+		port->dir_created = true;
+	}
+
+	return 0;
+err:
+	hccs_remove_die_dir(die);
+
+	return ret;
+}
+
+static int hccs_create_chip_dir(struct hccs_dev *hdev,
+				struct hccs_chip_info *chip)
+{
+	struct hccs_die_info *die;
+	int ret;
+	u16 id;
+
+	ret = kobject_init_and_add(&chip->kobj, &hccs_chip_type,
+				   &hdev->dev->kobj, "chip%d", chip->chip_id);
+	if (ret) {
+		kobject_put(&chip->kobj);
+		return ret;
+	}
+
+	for (id = 0; id < chip->die_num; id++) {
+		die = &chip->dies[id];
+		ret = hccs_create_die_dir(hdev, chip, die);
+		if (ret)
+			goto err;
+		die->dir_created = true;
+	}
+
+	return 0;
+err:
+	hccs_remove_chip_dir(chip);
+
+	return ret;
+}
+
+static int hccs_create_topo_dirs(struct hccs_dev *hdev)
+{
+	struct hccs_chip_info *chip;
+	u8 id, k;
+	int ret;
+
+	for (id = 0; id < hdev->chip_num; id++) {
+		chip = &hdev->chips[id];
+		ret = hccs_create_chip_dir(hdev, chip);
+		if (ret) {
+			dev_err(hdev->dev, "init chip%d dir failed!\n", id);
+			goto err;
+		}
+	}
+
+	return 0;
+err:
+	for (k = 0; k < id; k++)
+		hccs_remove_chip_dir(&hdev->chips[k]);
+
+	return ret;
+}
+
 static int hccs_probe(struct platform_device *pdev)
 {
 	struct acpi_device *acpi_dev;
@@ -598,6 +1231,10 @@ static int hccs_probe(struct platform_device *pdev)
 	if (rc)
 		goto unregister_pcc_chan;
 
+	rc = hccs_create_topo_dirs(hdev);
+	if (rc)
+		goto unregister_pcc_chan;
+
 	return 0;
 
 unregister_pcc_chan:
@@ -610,6 +1247,7 @@ static int hccs_remove(struct platform_device *pdev)
 {
 	struct hccs_dev *hdev = platform_get_drvdata(pdev);
 
+	hccs_remove_topo_dirs(hdev);
 	hccs_unregister_pcc_channel(hdev);
 
 	return 0;
diff --git a/drivers/soc/hisilicon/kunpeng_hccs.h b/drivers/soc/hisilicon/kunpeng_hccs.h
index fcc95e7e2a60..9d71fb78443f 100644
--- a/drivers/soc/hisilicon/kunpeng_hccs.h
+++ b/drivers/soc/hisilicon/kunpeng_hccs.h
@@ -21,6 +21,8 @@ struct hccs_port_info {
 	u8 port_type;
 	u8 lane_mode;
 	bool enable; /* if the port is enabled */
+	struct kobject kobj;
+	bool dir_created;
 	struct hccs_die_info *die; /* point to the die the port is located */
 };
 
@@ -30,6 +32,8 @@ struct hccs_die_info {
 	u8 min_port_id;
 	u8 max_port_id;
 	struct hccs_port_info *ports;
+	struct kobject kobj;
+	bool dir_created;
 	struct hccs_chip_info *chip; /* point to the chip the die is located */
 };
 
@@ -37,6 +41,7 @@ struct hccs_chip_info {
 	u8 chip_id;
 	u8 die_num;
 	struct hccs_die_info *dies;
+	struct kobject kobj;
 	struct hccs_dev *hdev;
 };
 
@@ -107,6 +112,23 @@ struct hccs_die_comm_req_param {
 	u8 die_id; /* id in hardware */
 };
 
+/* The common command request for getting the information of a specific port */
+struct hccs_port_comm_req_param {
+	u8 chip_id;
+	u8 die_id;
+	u8 port_id;
+};
+
+#define HCCS_PORT_RESET         1
+#define HCCS_PORT_SETUP         2
+#define HCCS_PORT_CONFIG        3
+#define HCCS_PORT_READY         4
+struct hccs_link_status {
+	u8 lane_mask; /* indicate which lanes are used. */
+	u8 link_fsm : 3; /* link fsm, 1: reset 2: setup 3: config 4: link-up */
+	u8 lane_num : 5; /* current lane number */
+};
+
 struct hccs_req_head {
 	u8 module_code; /* set to 0x32 for serdes */
 	u8 start_id;
-- 
2.33.0

