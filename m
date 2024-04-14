Return-Path: <linux-kernel+bounces-143967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4481A8A402A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 06:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0F8F1F216BA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 04:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F662A1D4;
	Sun, 14 Apr 2024 04:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qf+KqDEY"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFAB52F8A;
	Sun, 14 Apr 2024 04:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713067421; cv=none; b=gjE+DDMQS3eFewk3/tYjFHnC9rzwr9v5yGx7PgRJwqTtKAm8TJJhVJ3FwIJKR/lqm0x/Qm7i/MuztzLRNzUytvOYe9UwWXQjZ3/D+q8RnngCzHYPCFGf0ReAxprj6+Vg5gcbhHmZvC/PRLKfHWQ/HmjCExdTUMTfYP/sQ7JK81A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713067421; c=relaxed/simple;
	bh=d2ETlxgAp8M6izLLzbQiB0wztYQVBTtipcjXkqIS2cs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WuYeR8yOqLpHqTyNWmO8Fium5y1nz5mKnnfYFc7LbY0K24Uxi+tTkbjKaXOnUCZKtLbkavcp5p3Kuqey8pNP4tvEzIR59q2AC7r1O7sQ+IrukB36traZd2gKVQioes//1sPXjVeDMrBEDPB9UrWlzmO3i0UneKgkyde5KdY3xC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qf+KqDEY; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713067410; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=N9beYP9bVV4gRL+qdUb0xz8P3OcTfpd8+iSeHeQ606w=;
	b=qf+KqDEYsISfSrs8Lrg4y0GkTZQaUtLBw9zUDfri0RjHclAnV619JHxMe06SOg11VjJzBHppy12KiwyhIvmI6mu44Na7auUGEdAcUxevYqJnRqlIWeZTxwfJHgN3Hv+mkJHmSg4jlTM3Ag9wmvu3hkAtmUDfjnhOuzgPRPOE3f4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W4RqRKO_1713067408;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W4RqRKO_1713067408)
          by smtp.aliyun-inc.com;
          Sun, 14 Apr 2024 12:03:29 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: wintera@linux.ibm.com,
	twinkler@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v6 11/11] net/smc: implement DMB-merged operations of loopback-ism
Date: Sun, 14 Apr 2024 12:03:04 +0800
Message-Id: <20240414040304.54255-12-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240414040304.54255-1-guwen@linux.alibaba.com>
References: <20240414040304.54255-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This implements operations related to merging sndbuf with peer DMB in
loopback-ism. The DMB won't be freed until no sndbuf is attached to it.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_loopback.c | 120 +++++++++++++++++++++++++++++++++++------
 net/smc/smc_loopback.h |   3 ++
 2 files changed, 108 insertions(+), 15 deletions(-)

diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
index 94a57f4ee3f9..3c5f64ca4115 100644
--- a/net/smc/smc_loopback.c
+++ b/net/smc/smc_loopback.c
@@ -20,6 +20,7 @@
 #include "smc_loopback.h"
 
 #define SMC_LO_V2_CAPABLE	0x1 /* loopback-ism acts as ISMv2 */
+#define SMC_LO_SUPPORT_NOCOPY	0x1
 #define SMC_DMA_ADDR_INVALID	(~(dma_addr_t)0)
 
 static const char smc_lo_dev_name[] = "loopback-ism";
@@ -81,6 +82,7 @@ static int smc_lo_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
 		goto err_node;
 	}
 	dmb_node->dma_addr = SMC_DMA_ADDR_INVALID;
+	refcount_set(&dmb_node->refcnt, 1);
 
 again:
 	/* add new dmb into hash table */
@@ -94,6 +96,7 @@ static int smc_lo_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
 	}
 	hash_add(ldev->dmb_ht, &dmb_node->list, dmb_node->token);
 	write_unlock_bh(&ldev->dmb_ht_lock);
+	atomic_inc(&ldev->dmb_cnt);
 
 	dmb->sba_idx = dmb_node->sba_idx;
 	dmb->dmb_tok = dmb_node->token;
@@ -110,13 +113,29 @@ static int smc_lo_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
 	return rc;
 }
 
+static void __smc_lo_unregister_dmb(struct smc_lo_dev *ldev,
+				    struct smc_lo_dmb_node *dmb_node)
+{
+	/* remove dmb from hash table */
+	write_lock_bh(&ldev->dmb_ht_lock);
+	hash_del(&dmb_node->list);
+	write_unlock_bh(&ldev->dmb_ht_lock);
+
+	clear_bit(dmb_node->sba_idx, ldev->sba_idx_mask);
+	kvfree(dmb_node->cpu_addr);
+	kfree(dmb_node);
+
+	if (atomic_dec_and_test(&ldev->dmb_cnt))
+		wake_up(&ldev->ldev_release);
+}
+
 static int smc_lo_unregister_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb)
 {
 	struct smc_lo_dmb_node *dmb_node = NULL, *tmp_node;
 	struct smc_lo_dev *ldev = smcd->priv;
 
-	/* remove dmb from hash table */
-	write_lock_bh(&ldev->dmb_ht_lock);
+	/* find dmb from hash table */
+	read_lock_bh(&ldev->dmb_ht_lock);
 	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb->dmb_tok) {
 		if (tmp_node->token == dmb->dmb_tok) {
 			dmb_node = tmp_node;
@@ -124,16 +143,76 @@ static int smc_lo_unregister_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb)
 		}
 	}
 	if (!dmb_node) {
-		write_unlock_bh(&ldev->dmb_ht_lock);
+		read_unlock_bh(&ldev->dmb_ht_lock);
 		return -EINVAL;
 	}
-	hash_del(&dmb_node->list);
-	write_unlock_bh(&ldev->dmb_ht_lock);
+	read_unlock_bh(&ldev->dmb_ht_lock);
 
-	clear_bit(dmb_node->sba_idx, ldev->sba_idx_mask);
-	kfree(dmb_node->cpu_addr);
-	kfree(dmb_node);
+	if (refcount_dec_and_test(&dmb_node->refcnt))
+		__smc_lo_unregister_dmb(ldev, dmb_node);
+	return 0;
+}
+
+static int smc_lo_support_dmb_nocopy(struct smcd_dev *smcd)
+{
+	return SMC_LO_SUPPORT_NOCOPY;
+}
+
+static int smc_lo_attach_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb)
+{
+	struct smc_lo_dmb_node *dmb_node = NULL, *tmp_node;
+	struct smc_lo_dev *ldev = smcd->priv;
+
+	/* find dmb_node according to dmb->dmb_tok */
+	read_lock_bh(&ldev->dmb_ht_lock);
+	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb->dmb_tok) {
+		if (tmp_node->token == dmb->dmb_tok) {
+			dmb_node = tmp_node;
+			break;
+		}
+	}
+	if (!dmb_node) {
+		read_unlock_bh(&ldev->dmb_ht_lock);
+		return -EINVAL;
+	}
+	read_unlock_bh(&ldev->dmb_ht_lock);
+
+	if (!refcount_inc_not_zero(&dmb_node->refcnt))
+		/* the dmb is being unregistered, but has
+		 * not been removed from the hash table.
+		 */
+		return -EINVAL;
 
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
+	read_lock_bh(&ldev->dmb_ht_lock);
+	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, token) {
+		if (tmp_node->token == token) {
+			dmb_node = tmp_node;
+			break;
+		}
+	}
+	if (!dmb_node) {
+		read_unlock_bh(&ldev->dmb_ht_lock);
+		return -EINVAL;
+	}
+	read_unlock_bh(&ldev->dmb_ht_lock);
+
+	if (refcount_dec_and_test(&dmb_node->refcnt))
+		__smc_lo_unregister_dmb(ldev, dmb_node);
 	return 0;
 }
 
@@ -145,6 +224,12 @@ static int smc_lo_move_data(struct smcd_dev *smcd, u64 dmb_tok,
 	struct smc_lo_dev *ldev = smcd->priv;
 	struct smc_connection *conn;
 
+	if (!sf)
+		/* since sndbuf is merged with peer DMB, there is
+		 * no need to copy data from sndbuf to peer DMB.
+		 */
+		return 0;
+
 	read_lock_bh(&ldev->dmb_ht_lock);
 	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb_tok) {
 		if (tmp_node->token == dmb_tok) {
@@ -159,13 +244,10 @@ static int smc_lo_move_data(struct smcd_dev *smcd, u64 dmb_tok,
 	memcpy((char *)rmb_node->cpu_addr + offset, data, size);
 	read_unlock_bh(&ldev->dmb_ht_lock);
 
-	if (sf) {
-		conn = smcd->conn[rmb_node->sba_idx];
-		if (conn && !conn->killed)
-			tasklet_schedule(&conn->rx_tsklet);
-		else
-			return -EPIPE;
-	}
+	conn = smcd->conn[rmb_node->sba_idx];
+	if (!conn || conn->killed)
+		return -EPIPE;
+	tasklet_schedule(&conn->rx_tsklet);
 	return 0;
 }
 
@@ -197,6 +279,9 @@ static const struct smcd_ops lo_ops = {
 	.query_remote_gid = smc_lo_query_rgid,
 	.register_dmb = smc_lo_register_dmb,
 	.unregister_dmb = smc_lo_unregister_dmb,
+	.support_dmb_nocopy = smc_lo_support_dmb_nocopy,
+	.attach_dmb = smc_lo_attach_dmb,
+	.detach_dmb = smc_lo_detach_dmb,
 	.add_vlan_id		= NULL,
 	.del_vlan_id		= NULL,
 	.set_vlan_required	= NULL,
@@ -275,12 +360,17 @@ static int smc_lo_dev_init(struct smc_lo_dev *ldev)
 	smc_lo_generate_ids(ldev);
 	rwlock_init(&ldev->dmb_ht_lock);
 	hash_init(ldev->dmb_ht);
+	atomic_set(&ldev->dmb_cnt, 0);
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
index 4b36acbc27da..387407b8b385 100644
--- a/net/smc/smc_loopback.h
+++ b/net/smc/smc_loopback.h
@@ -30,6 +30,7 @@ struct smc_lo_dmb_node {
 	u32 sba_idx;
 	void *cpu_addr;
 	dma_addr_t dma_addr;
+	refcount_t refcnt;
 };
 
 struct smc_lo_dev {
@@ -37,9 +38,11 @@ struct smc_lo_dev {
 	struct device dev;
 	u16 chid;
 	struct smcd_gid local_gid;
+	atomic_t dmb_cnt;
 	rwlock_t dmb_ht_lock;
 	DECLARE_BITMAP(sba_idx_mask, SMC_LO_MAX_DMBS);
 	DECLARE_HASHTABLE(dmb_ht, SMC_LO_DMBS_HASH_BITS);
+	wait_queue_head_t ldev_release;
 };
 
 int smc_loopback_init(void);
-- 
2.32.0.3.g01195cf9f


