Return-Path: <linux-kernel+bounces-23548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F4782AE52
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 683241C22CB8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4D23A8FF;
	Thu, 11 Jan 2024 12:01:42 +0000 (UTC)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FCC22093;
	Thu, 11 Jan 2024 12:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W-PfInN_1704974495;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W-PfInN_1704974495)
          by smtp.aliyun-inc.com;
          Thu, 11 Jan 2024 20:01:36 +0800
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
Subject: [PATCH net-next 15/15] net/smc: implement DMB-merged operations of loopback-ism
Date: Thu, 11 Jan 2024 20:00:36 +0800
Message-Id: <20240111120036.109903-16-guwen@linux.alibaba.com>
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

This implements operations related to merging sndbuf with peer DMB in
loopback-ism. The DMB won't be unregistered until no sndbuf is attached
to it.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_loopback.c | 101 +++++++++++++++++++++++++++++++++++++++--
 net/smc/smc_loopback.h |   4 ++
 2 files changed, 102 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
index bfbb346ef01a..296a4d1f1a33 100644
--- a/net/smc/smc_loopback.c
+++ b/net/smc/smc_loopback.c
@@ -298,6 +298,7 @@ static int smc_lo_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
 	}
 	dmb_node->len = dmb->dmb_len;
 	dmb_node->dma_addr = SMC_DMA_ADDR_INVALID;
+	refcount_set(&dmb_node->refcnt, 1);
 
 again:
 	/* add new dmb into hash table */
@@ -311,6 +312,7 @@ static int smc_lo_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
 	}
 	hash_add(ldev->dmb_ht, &dmb_node->list, dmb_node->token);
 	write_unlock(&ldev->dmb_ht_lock);
+	atomic_inc(&ldev->dmb_cnt);
 	SMC_LO_STAT_DMBS_INC(ldev);
 
 	dmb->sba_idx = dmb_node->sba_idx;
@@ -333,8 +335,8 @@ static int smc_lo_unregister_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb)
 	struct smc_lo_dmb_node *dmb_node = NULL, *tmp_node;
 	struct smc_lo_dev *ldev = smcd->priv;
 
-	/* remove dmb from hash table */
-	write_lock(&ldev->dmb_ht_lock);
+	/* find dmb from hash table */
+	read_lock(&ldev->dmb_ht_lock);
 	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb->dmb_tok) {
 		if (tmp_node->token == dmb->dmb_tok) {
 			dmb_node = tmp_node;
@@ -342,9 +344,18 @@ static int smc_lo_unregister_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb)
 		}
 	}
 	if (!dmb_node) {
-		write_unlock(&ldev->dmb_ht_lock);
+		read_unlock(&ldev->dmb_ht_lock);
 		return -EINVAL;
 	}
+	read_unlock(&ldev->dmb_ht_lock);
+
+	/* wait for peer sndbuf to detach from this dmb */
+	if (!refcount_dec_and_test(&dmb_node->refcnt))
+		wait_event(ldev->dmbs_release,
+			   !refcount_read(&dmb_node->refcnt));
+
+	/* remove dmb from hash table */
+	write_lock(&ldev->dmb_ht_lock);
 	hash_del(&dmb_node->list);
 	write_unlock(&ldev->dmb_ht_lock);
 
@@ -353,6 +364,73 @@ static int smc_lo_unregister_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb)
 	kfree(dmb_node);
 	SMC_LO_STAT_DMBS_DEC(ldev);
 
+	if (atomic_dec_and_test(&ldev->dmb_cnt))
+		wake_up(&ldev->ldev_release);
+	return 0;
+}
+
+static int smc_lo_support_dmb_nocopy(struct smcd_dev *smcd)
+{
+	struct smc_lo_dev *ldev = smcd->priv;
+
+	return (ldev->dmb_copy == SMC_LO_DMB_NOCOPY);
+}
+
+static int smc_lo_attach_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb)
+{
+	struct smc_lo_dmb_node *dmb_node = NULL, *tmp_node;
+	struct smc_lo_dev *ldev = smcd->priv;
+
+	/* find dmb_node according to dmb->dmb_tok */
+	read_lock(&ldev->dmb_ht_lock);
+	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb->dmb_tok) {
+		if (tmp_node->token == dmb->dmb_tok) {
+			dmb_node = tmp_node;
+			break;
+		}
+	}
+	if (!dmb_node) {
+		read_unlock(&ldev->dmb_ht_lock);
+		return -EINVAL;
+	}
+	read_unlock(&ldev->dmb_ht_lock);
+
+	if (!refcount_inc_not_zero(&dmb_node->refcnt))
+		/* the dmb is being unregistered, but has
+		 * not been removed from the hash table.
+		 */
+		return -EINVAL;
+
+	/* provide dmb information */
+	dmb->sba_idx = dmb_node->sba_idx;
+	dmb->dmb_tok = dmb_node->token;
+	dmb->cpu_addr = dmb_node->cpu_addr;
+	dmb->dma_addr = dmb_node->dma_addr;
+	dmb->dmb_len = dmb_node->len;
+	return 0;
+}
+
+static int smc_lo_detach_dmb(struct smcd_dev *smcd, u64 token)
+{
+	struct smc_lo_dmb_node *dmb_node = NULL, *tmp_node;
+	struct smc_lo_dev *ldev = smcd->priv;
+
+	/* find dmb_node according to dmb->dmb_tok */
+	read_lock(&ldev->dmb_ht_lock);
+	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, token) {
+		if (tmp_node->token == token) {
+			dmb_node = tmp_node;
+			break;
+		}
+	}
+	if (!dmb_node) {
+		read_unlock(&ldev->dmb_ht_lock);
+		return -EINVAL;
+	}
+	read_unlock(&ldev->dmb_ht_lock);
+
+	if (refcount_dec_and_test(&dmb_node->refcnt))
+		wake_up_all(&ldev->dmbs_release);
 	return 0;
 }
 
@@ -389,6 +467,14 @@ static int smc_lo_move_data(struct smcd_dev *smcd, u64 dmb_tok,
 	struct smc_lo_dmb_node *rmb_node = NULL, *tmp_node;
 	struct smc_lo_dev *ldev = smcd->priv;
 
+	/* if sndbuf is merged with peer DMB, there is
+	 * no need to copy data from sndbuf to peer DMB.
+	 */
+	if (!sf && smc_lo_support_dmb_nocopy(smcd)) {
+		SMC_LO_STAT_XFER_BYTES(ldev, size);
+		return 0;
+	}
+
 	read_lock(&ldev->dmb_ht_lock);
 	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb_tok) {
 		if (tmp_node->token == dmb_tok) {
@@ -444,6 +530,9 @@ static const struct smcd_ops lo_ops = {
 	.query_remote_gid = smc_lo_query_rgid,
 	.register_dmb = smc_lo_register_dmb,
 	.unregister_dmb = smc_lo_unregister_dmb,
+	.support_dmb_nocopy = smc_lo_support_dmb_nocopy,
+	.attach_dmb = smc_lo_attach_dmb,
+	.detach_dmb = smc_lo_detach_dmb,
 	.add_vlan_id = smc_lo_add_vlan_id,
 	.del_vlan_id = smc_lo_del_vlan_id,
 	.set_vlan_required = smc_lo_set_vlan_required,
@@ -529,12 +618,18 @@ static int smc_lo_dev_init(struct smc_lo_dev *ldev)
 	smc_lo_generate_id(ldev);
 	rwlock_init(&ldev->dmb_ht_lock);
 	hash_init(ldev->dmb_ht);
+	atomic_set(&ldev->dmb_cnt, 0);
+	init_waitqueue_head(&ldev->dmbs_release);
+	init_waitqueue_head(&ldev->ldev_release);
+
 	return smcd_lo_register_dev(ldev);
 }
 
 static void smc_lo_dev_exit(struct smc_lo_dev *ldev)
 {
 	smcd_lo_unregister_dev(ldev);
+	if (atomic_read(&ldev->dmb_cnt))
+		wait_event(ldev->ldev_release, !atomic_read(&ldev->dmb_cnt));
 }
 
 static void smc_lo_dev_release(struct device *dev)
diff --git a/net/smc/smc_loopback.h b/net/smc/smc_loopback.h
index 7ecb4a35eb36..19a1eace2255 100644
--- a/net/smc/smc_loopback.h
+++ b/net/smc/smc_loopback.h
@@ -40,6 +40,7 @@ struct smc_lo_dmb_node {
 	u32 sba_idx;
 	void *cpu_addr;
 	dma_addr_t dma_addr;
+	refcount_t refcnt;
 };
 
 struct smc_lo_dev_stats64 {
@@ -56,9 +57,12 @@ struct smc_lo_dev {
 	u16 chid;
 	struct smcd_gid local_gid;
 	struct smc_lo_dev_stats64 __percpu *stats;
+	atomic_t dmb_cnt;
 	rwlock_t dmb_ht_lock;
 	DECLARE_BITMAP(sba_idx_mask, SMC_LO_MAX_DMBS);
 	DECLARE_HASHTABLE(dmb_ht, SMC_LO_DMBS_HASH_BITS);
+	wait_queue_head_t dmbs_release;
+	wait_queue_head_t ldev_release;
 };
 
 #define SMC_LO_STAT_SUB(ldev, key, val) \
-- 
2.32.0.3.g01195cf9f


