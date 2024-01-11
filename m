Return-Path: <linux-kernel+bounces-23544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 875D482AE3B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 203CF1F26146
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5614917740;
	Thu, 11 Jan 2024 12:01:32 +0000 (UTC)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343A0171A3;
	Thu, 11 Jan 2024 12:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W-PfIj6_1704974483;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W-PfIj6_1704974483)
          by smtp.aliyun-inc.com;
          Thu, 11 Jan 2024 20:01:25 +0800
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
Subject: [PATCH net-next 09/15] net/smc: introduce loopback-ism statistics attributes
Date: Thu, 11 Jan 2024 20:00:30 +0800
Message-Id: <20240111120036.109903-10-guwen@linux.alibaba.com>
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

This introduces some statistics attributes of loopback-ism. They can be
read from /sys/devices/virtual/smc/loopback-ism/{xfer_tytes|dmbs_cnt}.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_loopback.c | 74 ++++++++++++++++++++++++++++++++++++++++++
 net/smc/smc_loopback.h | 22 +++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
index 3bf7bf5e8c96..a89dbf84aea5 100644
--- a/net/smc/smc_loopback.c
+++ b/net/smc/smc_loopback.c
@@ -30,6 +30,65 @@ static struct class *smc_class;
 static int smcd_lo_register_dev(struct smc_lo_dev *ldev);
 static void smcd_lo_unregister_dev(struct smc_lo_dev *ldev);
 
+static void smc_lo_clear_stats(struct smc_lo_dev *ldev)
+{
+	struct smc_lo_dev_stats64 *tmp;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		tmp = per_cpu_ptr(ldev->stats, cpu);
+		tmp->xfer_bytes = 0;
+	}
+}
+
+static void smc_lo_get_stats(struct smc_lo_dev *ldev,
+			     struct smc_lo_dev_stats64 *stats)
+{
+	int size, cpu, i;
+	u64 *src, *sum;
+
+	memset(stats, 0, sizeof(*stats));
+	size = sizeof(*stats) / sizeof(u64);
+	for_each_possible_cpu(cpu) {
+		src = (u64 *)per_cpu_ptr(ldev->stats, cpu);
+		sum = (u64 *)stats;
+		for (i = 0; i < size; i++)
+			*(sum++) += *(src++);
+	}
+}
+
+static ssize_t smc_lo_show_stats(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf, unsigned long offset)
+{
+	struct smc_lo_dev *ldev =
+		container_of(dev, struct smc_lo_dev, dev);
+	struct smc_lo_dev_stats64 stats;
+	ssize_t ret = -EINVAL;
+
+	if (WARN_ON(offset > sizeof(struct smc_lo_dev_stats64) ||
+		    offset % sizeof(u64) != 0))
+		goto out;
+
+	smc_lo_get_stats(ldev, &stats);
+	ret = sysfs_emit(buf, "%llu\n", *(u64 *)(((u8 *)&stats) + offset));
+out:
+	return ret;
+}
+
+/* generate a read-only statistics attribute */
+#define SMC_LO_DEVICE_ATTR_RO(name) \
+static ssize_t name##_show(struct device *dev, \
+			   struct device_attribute *attr, char *buf) \
+{ \
+	return smc_lo_show_stats(dev, attr, buf, \
+				 offsetof(struct smc_lo_dev_stats64, name)); \
+} \
+static DEVICE_ATTR_RO(name)
+
+SMC_LO_DEVICE_ATTR_RO(xfer_bytes);
+SMC_LO_DEVICE_ATTR_RO(dmbs_cnt);
+
 static ssize_t active_show(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
@@ -67,6 +126,8 @@ static ssize_t active_store(struct device *dev,
 static DEVICE_ATTR_RW(active);
 static struct attribute *smc_lo_attrs[] = {
 	&dev_attr_active.attr,
+	&dev_attr_xfer_bytes.attr,
+	&dev_attr_dmbs_cnt.attr,
 	NULL,
 };
 
@@ -152,6 +213,7 @@ static int smc_lo_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
 	}
 	hash_add(ldev->dmb_ht, &dmb_node->list, dmb_node->token);
 	write_unlock(&ldev->dmb_ht_lock);
+	SMC_LO_STAT_DMBS_INC(ldev);
 
 	dmb->sba_idx = dmb_node->sba_idx;
 	dmb->dmb_tok = dmb_node->token;
@@ -191,6 +253,7 @@ static int smc_lo_unregister_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb)
 	clear_bit(dmb_node->sba_idx, ldev->sba_idx_mask);
 	kfree(dmb_node->cpu_addr);
 	kfree(dmb_node);
+	SMC_LO_STAT_DMBS_DEC(ldev);
 
 	return 0;
 }
@@ -249,6 +312,8 @@ static int smc_lo_move_data(struct smcd_dev *smcd, u64 dmb_tok,
 
 		if (conn && !conn->killed)
 			smcd_cdc_rx_handler(conn);
+	} else {
+		SMC_LO_STAT_XFER_BYTES(ldev, size);
 	}
 	return 0;
 }
@@ -354,6 +419,7 @@ static void smcd_lo_unregister_dev(struct smc_lo_dev *ldev)
 	mutex_unlock(&smcd_dev_list.mutex);
 	kfree(smcd->conn);
 	kfree(smcd);
+	smc_lo_clear_stats(ldev);
 }
 
 static int smc_lo_dev_init(struct smc_lo_dev *ldev)
@@ -374,6 +440,7 @@ static void smc_lo_dev_release(struct device *dev)
 	struct smc_lo_dev *ldev =
 		container_of(dev, struct smc_lo_dev, dev);
 
+	free_percpu(ldev->stats);
 	kfree(ldev);
 }
 
@@ -392,6 +459,13 @@ static int smc_lo_dev_probe(void)
 		goto destroy_class;
 	}
 
+	ldev->stats = alloc_percpu(struct smc_lo_dev_stats64);
+	if (!ldev->stats) {
+		ret = -ENOMEM;
+		kfree(ldev);
+		goto destroy_class;
+	}
+
 	ldev->dev.parent = NULL;
 	ldev->dev.class = smc_class;
 	ldev->dev.groups = smc_lo_attr_groups;
diff --git a/net/smc/smc_loopback.h b/net/smc/smc_loopback.h
index 02a522e322b4..d4572ca42f08 100644
--- a/net/smc/smc_loopback.h
+++ b/net/smc/smc_loopback.h
@@ -32,16 +32,38 @@ struct smc_lo_dmb_node {
 	dma_addr_t dma_addr;
 };
 
+struct smc_lo_dev_stats64 {
+	__u64	xfer_bytes;
+	__u64	dmbs_cnt;
+};
+
 struct smc_lo_dev {
 	struct smcd_dev *smcd;
 	struct device dev;
 	u8 active;
 	u16 chid;
 	struct smcd_gid local_gid;
+	struct smc_lo_dev_stats64 __percpu *stats;
 	rwlock_t dmb_ht_lock;
 	DECLARE_BITMAP(sba_idx_mask, SMC_LO_MAX_DMBS);
 	DECLARE_HASHTABLE(dmb_ht, SMC_LO_DMBS_HASH_BITS);
 };
+
+#define SMC_LO_STAT_SUB(ldev, key, val) \
+do { \
+	struct smc_lo_dev_stats64 *_stats = (ldev)->stats; \
+	this_cpu_add((*(_stats)).key, val); \
+} \
+while (0)
+
+#define SMC_LO_STAT_XFER_BYTES(ldev, val) \
+	SMC_LO_STAT_SUB(ldev, xfer_bytes, val)
+
+#define SMC_LO_STAT_DMBS_INC(ldev) \
+	SMC_LO_STAT_SUB(ldev, dmbs_cnt, 1)
+
+#define SMC_LO_STAT_DMBS_DEC(ldev) \
+	SMC_LO_STAT_SUB(ldev, dmbs_cnt, -1)
 #endif
 
 int smc_loopback_init(void);
-- 
2.32.0.3.g01195cf9f


