Return-Path: <linux-kernel+bounces-23545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A0182AE3F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 257351C23958
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF09817992;
	Thu, 11 Jan 2024 12:01:37 +0000 (UTC)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526B71802D;
	Thu, 11 Jan 2024 12:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W-Pewe3_1704974491;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W-Pewe3_1704974491)
          by smtp.aliyun-inc.com;
          Thu, 11 Jan 2024 20:01:33 +0800
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
Subject: [PATCH net-next 13/15] net/smc: introduce loopback-ism DMB type control
Date: Thu, 11 Jan 2024 20:00:34 +0800
Message-Id: <20240111120036.109903-14-guwen@linux.alibaba.com>
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

This provides a way to {get|set} type of DMB offered by loopback-ism,
whether it is physically or virtually contiguous memory.

echo 0 > /sys/devices/virtual/smc/loopback-ism/dmb_type # physically
echo 1 > /sys/devices/virtual/smc/loopback-ism/dmb_type # virtually

The settings take effect after re-activating loopback-ism by:

echo 0 > /sys/devices/virtual/smc/loopback-ism/active
echo 1 > /sys/devices/virtual/smc/loopback-ism/active

After this, the link group and DMBs related to loopback-ism will be
flushed and subsequent DMBs created will be of the desired type.

The motivation of this control is that physically contiguous DMB has
best performance but is usually expensive, while the virtually
contiguous DMB is cheap and perform well in most scenarios, but if
sndbuf and DMB are merged, virtual DMB will be accessed concurrently
in Tx and Rx and there will be a bottleneck caused by lock contention
of find_vmap_area when there are many CPUs and CONFIG_HARDENED_USERCOPY
is set (see link below). So an option is provided.

Link: https://lore.kernel.org/all/238e63cd-e0e8-4fbf-852f-bc4d5bc35d5a@linux.alibaba.com/
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_loopback.c | 80 +++++++++++++++++++++++++++++++++++-------
 net/smc/smc_loopback.h |  6 ++++
 2 files changed, 74 insertions(+), 12 deletions(-)

diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
index a89dbf84aea5..2e734f8e08f5 100644
--- a/net/smc/smc_loopback.c
+++ b/net/smc/smc_loopback.c
@@ -13,6 +13,7 @@
 
 #include <linux/device.h>
 #include <linux/types.h>
+#include <linux/vmalloc.h>
 #include <net/smc.h>
 
 #include "smc_cdc.h"
@@ -24,6 +25,7 @@
 #define SMC_DMA_ADDR_INVALID	(~(dma_addr_t)0)
 
 static const char smc_lo_dev_name[] = "loopback-ism";
+static unsigned int smc_lo_dmb_type = SMC_LO_DMB_PHYS;
 static struct smc_lo_dev *lo_dev;
 static struct class *smc_class;
 
@@ -124,8 +126,50 @@ static ssize_t active_store(struct device *dev,
 	return count;
 }
 static DEVICE_ATTR_RW(active);
+
+static ssize_t dmb_type_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct smc_lo_dev *ldev =
+		container_of(dev, struct smc_lo_dev, dev);
+	const char *type;
+
+	switch (ldev->dmb_type) {
+	case SMC_LO_DMB_PHYS:
+		type = "Physically contiguous buffer";
+		break;
+	case SMC_LO_DMB_VIRT:
+		type = "Virtually contiguous buffer";
+		break;
+	default:
+		type = "Unknown type";
+	}
+
+	return sysfs_emit(buf, "%d: %s\n", ldev->dmb_type, type);
+}
+
+static ssize_t dmb_type_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	unsigned int dmb_type;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &dmb_type);
+	if (ret)
+		return ret;
+
+	if (dmb_type != SMC_LO_DMB_PHYS &&
+	    dmb_type != SMC_LO_DMB_VIRT)
+		return -EINVAL;
+
+	smc_lo_dmb_type = dmb_type; /* re-activate to take effect */
+	return count;
+}
+static DEVICE_ATTR_RW(dmb_type);
 static struct attribute *smc_lo_attrs[] = {
 	&dev_attr_active.attr,
+	&dev_attr_dmb_type.attr,
 	&dev_attr_xfer_bytes.attr,
 	&dev_attr_dmbs_cnt.attr,
 	NULL,
@@ -170,8 +214,7 @@ static int smc_lo_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
 {
 	struct smc_lo_dmb_node *dmb_node, *tmp_node;
 	struct smc_lo_dev *ldev = smcd->priv;
-	int sba_idx, order, rc;
-	struct page *pages;
+	int sba_idx, rc;
 
 	/* check space for new dmb */
 	for_each_clear_bit(sba_idx, ldev->sba_idx_mask, SMC_LO_MAX_DMBS) {
@@ -188,16 +231,27 @@ static int smc_lo_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
 	}
 
 	dmb_node->sba_idx = sba_idx;
-	order = get_order(dmb->dmb_len);
-	pages = alloc_pages(GFP_KERNEL | __GFP_NOWARN |
-			    __GFP_NOMEMALLOC | __GFP_COMP |
-			    __GFP_NORETRY | __GFP_ZERO,
-			    order);
-	if (!pages) {
-		rc = -ENOMEM;
-		goto err_node;
+	if (ldev->dmb_type == SMC_LO_DMB_PHYS) {
+		struct page *pages;
+		int order;
+
+		order = get_order(dmb->dmb_len);
+		pages = alloc_pages(GFP_KERNEL | __GFP_NOWARN |
+				    __GFP_NOMEMALLOC | __GFP_COMP |
+				    __GFP_NORETRY | __GFP_ZERO,
+				    order);
+		if (!pages) {
+			rc = -ENOMEM;
+			goto err_node;
+		}
+		dmb_node->cpu_addr = (void *)page_address(pages);
+	} else {
+		dmb_node->cpu_addr = vzalloc(dmb->dmb_len);
+		if (!dmb_node->cpu_addr) {
+			rc = -ENOMEM;
+			goto err_node;
+		}
 	}
-	dmb_node->cpu_addr = (void *)page_address(pages);
 	dmb_node->len = dmb->dmb_len;
 	dmb_node->dma_addr = SMC_DMA_ADDR_INVALID;
 
@@ -251,7 +305,7 @@ static int smc_lo_unregister_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb)
 	write_unlock(&ldev->dmb_ht_lock);
 
 	clear_bit(dmb_node->sba_idx, ldev->sba_idx_mask);
-	kfree(dmb_node->cpu_addr);
+	kvfree(dmb_node->cpu_addr);
 	kfree(dmb_node);
 	SMC_LO_STAT_DMBS_DEC(ldev);
 
@@ -396,6 +450,7 @@ static int smcd_lo_register_dev(struct smc_lo_dev *ldev)
 	ldev->smcd = smcd;
 	smcd->priv = ldev;
 	smc_ism_set_v2_capable();
+	ldev->dmb_type = smc_lo_dmb_type;
 	mutex_lock(&smcd_dev_list.mutex);
 	list_add(&smcd->list, &smcd_dev_list.list);
 	mutex_unlock(&smcd_dev_list.mutex);
@@ -419,6 +474,7 @@ static void smcd_lo_unregister_dev(struct smc_lo_dev *ldev)
 	mutex_unlock(&smcd_dev_list.mutex);
 	kfree(smcd->conn);
 	kfree(smcd);
+	ldev->dmb_type = smc_lo_dmb_type;
 	smc_lo_clear_stats(ldev);
 }
 
diff --git a/net/smc/smc_loopback.h b/net/smc/smc_loopback.h
index d4572ca42f08..8ee5c6805fc4 100644
--- a/net/smc/smc_loopback.h
+++ b/net/smc/smc_loopback.h
@@ -23,6 +23,11 @@
 #define SMC_LO_DMBS_HASH_BITS	12
 #define SMC_LO_CHID		0xFFFF
 
+enum {
+	SMC_LO_DMB_PHYS,
+	SMC_LO_DMB_VIRT,
+};
+
 struct smc_lo_dmb_node {
 	struct hlist_node list;
 	u64 token;
@@ -41,6 +46,7 @@ struct smc_lo_dev {
 	struct smcd_dev *smcd;
 	struct device dev;
 	u8 active;
+	u8 dmb_type;
 	u16 chid;
 	struct smcd_gid local_gid;
 	struct smc_lo_dev_stats64 __percpu *stats;
-- 
2.32.0.3.g01195cf9f


