Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9C580BB0C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 14:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjLJNZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 08:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbjLJNZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 08:25:03 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F591BEF;
        Sun, 10 Dec 2023 05:24:48 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0Vy8DodD_1702214684;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vy8DodD_1702214684)
          by smtp.aliyun-inc.com;
          Sun, 10 Dec 2023 21:24:46 +0800
From:   Wen Gu <guwen@linux.alibaba.com>
To:     wintera@linux.ibm.com, wenjia@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc:     borntraeger@linux.ibm.com, svens@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 13/13] net/smc: implement {at|de}tach_dmb interfaces of loopback-ism
Date:   Sun, 10 Dec 2023 21:24:14 +0800
Message-Id: <1702214654-32069-14-git-send-email-guwen@linux.alibaba.com>
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

This implements attach_dmb and detach_dmb interfaces of loopback-ism.
The DMB won't be unregistered by loopback-ism until no sndbuf is
attached to it.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_loopback.c | 107 +++++++++++++++++++++++++++++++++++++++++++------
 net/smc/smc_loopback.h |   4 ++
 2 files changed, 99 insertions(+), 12 deletions(-)

diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
index 057ea6a..909c069 100644
--- a/net/smc/smc_loopback.c
+++ b/net/smc/smc_loopback.c
@@ -198,6 +198,7 @@ static int smc_lo_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
 	}
 	dmb_node->len = dmb->dmb_len;
 	dmb_node->dma_addr = SMC_DMA_ADDR_INVALID;
+	refcount_set(&dmb_node->refcnt, 1);
 
 again:
 	/* add new dmb into hash table */
@@ -211,6 +212,7 @@ static int smc_lo_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
 	}
 	hash_add(ldev->dmb_ht, &dmb_node->list, dmb_node->token);
 	write_unlock(&ldev->dmb_ht_lock);
+	atomic_inc(&ldev->dmb_cnt);
 	SMC_LO_STAT_DMBS_INC(ldev);
 
 	dmb->sba_idx = dmb_node->sba_idx;
@@ -233,8 +235,8 @@ static int smc_lo_unregister_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb)
 	struct smc_lo_dmb_node *dmb_node = NULL, *tmp_node;
 	struct smc_lo_dev *ldev = smcd->priv;
 
-	/* remove dmb from hash table */
-	write_lock(&ldev->dmb_ht_lock);
+	/* find dmb from hash table */
+	read_lock(&ldev->dmb_ht_lock);
 	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb->dmb_tok) {
 		if (tmp_node->token == dmb->dmb_tok) {
 			dmb_node = tmp_node;
@@ -242,9 +244,18 @@ static int smc_lo_unregister_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb)
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
 
@@ -253,6 +264,66 @@ static int smc_lo_unregister_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb)
 	kfree(dmb_node);
 	SMC_LO_STAT_DMBS_DEC(ldev);
 
+	if (atomic_dec_and_test(&ldev->dmb_cnt))
+		wake_up(&ldev->ldev_release);
+	return 0;
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
 
@@ -288,7 +359,15 @@ static int smc_lo_move_data(struct smcd_dev *smcd, u64 dmb_tok,
 {
 	struct smc_lo_dmb_node *rmb_node = NULL, *tmp_node;
 	struct smc_lo_dev *ldev = smcd->priv;
-
+	struct smc_connection *conn;
+
+	if (!sf) {
+		/* Since ghost sndbuf shares the same memory region
+		 * with peer DMB, there is no need to 'transfer' data
+		 * from sndbuf to peer DMB.
+		 */
+		return 0;
+	}
 	read_lock(&ldev->dmb_ht_lock);
 	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb_tok) {
 		if (tmp_node->token == dmb_tok) {
@@ -305,14 +384,10 @@ static int smc_lo_move_data(struct smcd_dev *smcd, u64 dmb_tok,
 	memcpy((char *)rmb_node->cpu_addr + offset, data, size);
 	SMC_LO_STAT_TX_BYTES(ldev, size);
 
-	if (sf) {
-		struct smc_connection *conn =
-			smcd->conn[rmb_node->sba_idx];
-
-		if (conn && !conn->killed) {
-			SMC_LO_STAT_RX_BYTES(ldev, size);
-			smcd_cdc_rx_handler(conn);
-		}
+	conn = smcd->conn[rmb_node->sba_idx];
+	if (conn && !conn->killed) {
+		SMC_LO_STAT_RX_BYTES(ldev, size);
+		smcd_cdc_rx_handler(conn);
 	}
 	return 0;
 }
@@ -345,6 +420,8 @@ static struct device *smc_lo_get_dev(struct smcd_dev *smcd)
 	.query_remote_gid = smc_lo_query_rgid,
 	.register_dmb = smc_lo_register_dmb,
 	.unregister_dmb = smc_lo_unregister_dmb,
+	.attach_dmb = smc_lo_attach_dmb,
+	.detach_dmb = smc_lo_detach_dmb,
 	.add_vlan_id = smc_lo_add_vlan_id,
 	.del_vlan_id = smc_lo_del_vlan_id,
 	.set_vlan_required = smc_lo_set_vlan_required,
@@ -426,12 +503,18 @@ static int smc_lo_dev_init(struct smc_lo_dev *ldev)
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
index ad0feaa..df6c252 100644
--- a/net/smc/smc_loopback.h
+++ b/net/smc/smc_loopback.h
@@ -30,6 +30,7 @@ struct smc_lo_dmb_node {
 	u32 sba_idx;
 	void *cpu_addr;
 	dma_addr_t dma_addr;
+	refcount_t refcnt;
 };
 
 struct smc_lo_dev_stats64 {
@@ -45,9 +46,12 @@ struct smc_lo_dev {
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
1.8.3.1

