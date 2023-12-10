Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D694C80BAFA
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 14:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjLJNYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 08:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbjLJNYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 08:24:34 -0500
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDEFFE;
        Sun, 10 Dec 2023 05:24:39 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0Vy8BErC_1702214675;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vy8BErC_1702214675)
          by smtp.aliyun-inc.com;
          Sun, 10 Dec 2023 21:24:37 +0800
From:   Wen Gu <guwen@linux.alibaba.com>
To:     wintera@linux.ibm.com, wenjia@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc:     borntraeger@linux.ibm.com, svens@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 09/13] net/smc: introduce loopback-ism statistics attributes
Date:   Sun, 10 Dec 2023 21:24:10 +0800
Message-Id: <1702214654-32069-10-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1702214654-32069-1-git-send-email-guwen@linux.alibaba.com>
References: <1702214654-32069-1-git-send-email-guwen@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces some statistics attributes of loopback-ism. They can be
read from /sys/devices/virtual/smc/loopback-ism/{{tx|rx}_tytes|dmbs_cnt}.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_loopback.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++-
 net/smc/smc_loopback.h | 26 ++++++++++++++++
 2 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
index 04f8612..057ea6a 100644
--- a/net/smc/smc_loopback.c
+++ b/net/smc/smc_loopback.c
@@ -31,6 +31,67 @@
 static int smcd_lo_register_dev(struct smc_lo_dev *ldev);
 static void smcd_lo_unregister_dev(struct smc_lo_dev *ldev);
 
+static void smc_lo_clear_stats(struct smc_lo_dev *ldev)
+{
+	struct smc_lo_dev_stats64 *tmp;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		tmp = per_cpu_ptr(ldev->stats, cpu);
+		tmp->tx_bytes = 0;
+		tmp->rx_bytes = 0;
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
+SMC_LO_DEVICE_ATTR_RO(rx_bytes);
+SMC_LO_DEVICE_ATTR_RO(tx_bytes);
+SMC_LO_DEVICE_ATTR_RO(dmbs_cnt);
+
 static ssize_t active_show(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
@@ -68,6 +129,9 @@ static ssize_t active_store(struct device *dev,
 static DEVICE_ATTR_RW(active);
 static struct attribute *smc_lo_attrs[] = {
 	&dev_attr_active.attr,
+	&dev_attr_rx_bytes.attr,
+	&dev_attr_tx_bytes.attr,
+	&dev_attr_dmbs_cnt.attr,
 	NULL
 };
 
@@ -147,6 +211,7 @@ static int smc_lo_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
 	}
 	hash_add(ldev->dmb_ht, &dmb_node->list, dmb_node->token);
 	write_unlock(&ldev->dmb_ht_lock);
+	SMC_LO_STAT_DMBS_INC(ldev);
 
 	dmb->sba_idx = dmb_node->sba_idx;
 	dmb->dmb_tok = dmb_node->token;
@@ -186,6 +251,7 @@ static int smc_lo_unregister_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb)
 	clear_bit(dmb_node->sba_idx, ldev->sba_idx_mask);
 	vfree(dmb_node->cpu_addr);
 	kfree(dmb_node);
+	SMC_LO_STAT_DMBS_DEC(ldev);
 
 	return 0;
 }
@@ -237,13 +303,16 @@ static int smc_lo_move_data(struct smcd_dev *smcd, u64 dmb_tok,
 	read_unlock(&ldev->dmb_ht_lock);
 
 	memcpy((char *)rmb_node->cpu_addr + offset, data, size);
+	SMC_LO_STAT_TX_BYTES(ldev, size);
 
 	if (sf) {
 		struct smc_connection *conn =
 			smcd->conn[rmb_node->sba_idx];
 
-		if (conn && !conn->killed)
+		if (conn && !conn->killed) {
+			SMC_LO_STAT_RX_BYTES(ldev, size);
 			smcd_cdc_rx_handler(conn);
+		}
 	}
 	return 0;
 }
@@ -349,6 +418,7 @@ static void smcd_lo_unregister_dev(struct smc_lo_dev *ldev)
 	mutex_unlock(&smcd_dev_list.mutex);
 	kfree(smcd->conn);
 	kfree(smcd);
+	smc_lo_clear_stats(ldev);
 }
 
 static int smc_lo_dev_init(struct smc_lo_dev *ldev)
@@ -369,6 +439,7 @@ static void smc_lo_dev_release(struct device *dev)
 	struct smc_lo_dev *ldev =
 		container_of(dev, struct smc_lo_dev, dev);
 
+	free_percpu(ldev->stats);
 	kfree(ldev);
 }
 
@@ -387,6 +458,13 @@ static int smc_lo_dev_probe(void)
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
index 0cc2f83..ad0feaa 100644
--- a/net/smc/smc_loopback.h
+++ b/net/smc/smc_loopback.h
@@ -32,16 +32,42 @@ struct smc_lo_dmb_node {
 	dma_addr_t dma_addr;
 };
 
+struct smc_lo_dev_stats64 {
+	__u64	rx_bytes;
+	__u64	tx_bytes;
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
+#define SMC_LO_STAT_RX_BYTES(ldev, val) \
+	SMC_LO_STAT_SUB(ldev, rx_bytes, val)
+
+#define SMC_LO_STAT_TX_BYTES(ldev, val) \
+	SMC_LO_STAT_SUB(ldev, tx_bytes, val)
+
+#define SMC_LO_STAT_DMBS_INC(ldev) \
+	SMC_LO_STAT_SUB(ldev, dmbs_cnt, 1)
+
+#define SMC_LO_STAT_DMBS_DEC(ldev) \
+	SMC_LO_STAT_SUB(ldev, dmbs_cnt, -1)
 #endif
 
 int smc_loopback_init(void);
-- 
1.8.3.1

