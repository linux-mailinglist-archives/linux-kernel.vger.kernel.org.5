Return-Path: <linux-kernel+bounces-23542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1D582AE35
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C23282E6C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5AE171A6;
	Thu, 11 Jan 2024 12:01:29 +0000 (UTC)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A93168A6;
	Thu, 11 Jan 2024 12:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W-PdqI7_1704974481;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W-PdqI7_1704974481)
          by smtp.aliyun-inc.com;
          Thu, 11 Jan 2024 20:01:23 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: wintera@linux.ibm.com,
	wenjia@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 08/15] net/smc: introduce loopback-ism runtime switch
Date: Thu, 11 Jan 2024 20:00:29 +0800
Message-Id: <20240111120036.109903-9-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240111120036.109903-1-guwen@linux.alibaba.com>
References: <20240111120036.109903-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This provides a runtime switch to activate or deactivate loopback-ism
device by echo {1|0} > /sys/devices/virtual/smc/loopback-ism/active. It
will trigger the registration or removal of loopback-ism from the SMC-D
device list.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_loopback.c | 55 ++++++++++++++++++++++++++++++++++++++++++
 net/smc/smc_loopback.h |  1 +
 2 files changed, 56 insertions(+)

diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
index db0b45f8560c..3bf7bf5e8c96 100644
--- a/net/smc/smc_loopback.c
+++ b/net/smc/smc_loopback.c
@@ -27,6 +27,58 @@ static const char smc_lo_dev_name[] = "loopback-ism";
 static struct smc_lo_dev *lo_dev;
 static struct class *smc_class;
 
+static int smcd_lo_register_dev(struct smc_lo_dev *ldev);
+static void smcd_lo_unregister_dev(struct smc_lo_dev *ldev);
+
+static ssize_t active_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	struct smc_lo_dev *ldev =
+		container_of(dev, struct smc_lo_dev, dev);
+
+	return sysfs_emit(buf, "%d\n", ldev->active);
+}
+
+static ssize_t active_store(struct device *dev,
+			    struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct smc_lo_dev *ldev =
+		container_of(dev, struct smc_lo_dev, dev);
+	bool active;
+	int ret;
+
+	ret = kstrtobool(buf, &active);
+	if (ret)
+		return ret;
+
+	if (active && !ldev->active) {
+		/* activate loopback-ism */
+		ret = smcd_lo_register_dev(ldev);
+		if (ret)
+			return ret;
+	} else if (!active && ldev->active) {
+		/* deactivate loopback-ism */
+		smcd_lo_unregister_dev(ldev);
+	}
+
+	return count;
+}
+static DEVICE_ATTR_RW(active);
+static struct attribute *smc_lo_attrs[] = {
+	&dev_attr_active.attr,
+	NULL,
+};
+
+static struct attribute_group smc_lo_attr_group = {
+	.attrs  = smc_lo_attrs,
+};
+
+static const struct attribute_group *smc_lo_attr_groups[] = {
+	&smc_lo_attr_group,
+	NULL,
+};
+
 static void smc_lo_generate_id(struct smc_lo_dev *ldev)
 {
 	struct smcd_gid *lgid = &ldev->local_gid;
@@ -282,6 +334,7 @@ static int smcd_lo_register_dev(struct smc_lo_dev *ldev)
 	mutex_lock(&smcd_dev_list.mutex);
 	list_add(&smcd->list, &smcd_dev_list.list);
 	mutex_unlock(&smcd_dev_list.mutex);
+	ldev->active = 1;
 	pr_warn_ratelimited("smc: adding smcd device %s\n",
 			    smc_lo_dev_name);
 	return 0;
@@ -293,6 +346,7 @@ static void smcd_lo_unregister_dev(struct smc_lo_dev *ldev)
 
 	pr_warn_ratelimited("smc: removing smcd device %s\n",
 			    smc_lo_dev_name);
+	ldev->active = 0;
 	smcd->going_away = 1;
 	smc_smcd_terminate_all(smcd);
 	mutex_lock(&smcd_dev_list.mutex);
@@ -340,6 +394,7 @@ static int smc_lo_dev_probe(void)
 
 	ldev->dev.parent = NULL;
 	ldev->dev.class = smc_class;
+	ldev->dev.groups = smc_lo_attr_groups;
 	ldev->dev.release = smc_lo_dev_release;
 	device_initialize(&ldev->dev);
 	dev_set_name(&ldev->dev, smc_lo_dev_name);
diff --git a/net/smc/smc_loopback.h b/net/smc/smc_loopback.h
index 24ab9d747613..02a522e322b4 100644
--- a/net/smc/smc_loopback.h
+++ b/net/smc/smc_loopback.h
@@ -35,6 +35,7 @@ struct smc_lo_dmb_node {
 struct smc_lo_dev {
 	struct smcd_dev *smcd;
 	struct device dev;
+	u8 active;
 	u16 chid;
 	struct smcd_gid local_gid;
 	rwlock_t dmb_ht_lock;
-- 
2.32.0.3.g01195cf9f


