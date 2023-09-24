Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7117ACA71
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 17:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjIXPSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 11:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjIXPSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 11:18:13 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339F3CD8;
        Sun, 24 Sep 2023 08:17:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0Vsio80D_1695568659;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vsio80D_1695568659)
          by smtp.aliyun-inc.com;
          Sun, 24 Sep 2023 23:17:41 +0800
From:   Wen Gu <guwen@linux.alibaba.com>
To:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     wintera@linux.ibm.com, schnelle@linux.ibm.com,
        gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        dust.li@linux.alibaba.com, guwen@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 18/18] net/smc: add interface implementation of loopback device
Date:   Sun, 24 Sep 2023 23:16:53 +0800
Message-Id: <1695568613-125057-19-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
References: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch completes the specific implementation of loopback device
for the newly added SMC-D DMB-related interface.

The loopback device always provides mappable DMB because the device
users are in the same OS instance.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_loopback.c | 104 ++++++++++++++++++++++++++++++++++++++++++++-----
 net/smc/smc_loopback.h |   5 +++
 2 files changed, 99 insertions(+), 10 deletions(-)

diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
index 8375575..e9d2d62 100644
--- a/net/smc/smc_loopback.c
+++ b/net/smc/smc_loopback.c
@@ -106,6 +106,7 @@ static int smc_lo_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
 	}
 	dmb_node->len = dmb->dmb_len;
 	dmb_node->dma_addr = SMC_DMA_ADDR_INVALID;
+	refcount_set(&dmb_node->refcnt, 1);
 
 again:
 	/* add new dmb into hash table */
@@ -119,6 +120,7 @@ static int smc_lo_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
 	}
 	hash_add(ldev->dmb_ht, &dmb_node->list, dmb_node->token);
 	write_unlock(&ldev->dmb_ht_lock);
+	atomic_inc(&ldev->dmb_cnt);
 
 	dmb->sba_idx = dmb_node->sba_idx;
 	dmb->dmb_tok = dmb_node->token;
@@ -140,18 +142,27 @@ static int smc_lo_unregister_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb)
 	struct smc_lo_dmb_node *dmb_node = NULL, *tmp_node;
 	struct smc_lo_dev *ldev = smcd->priv;
 
-	/* remove dmb from hash table */
-	write_lock(&ldev->dmb_ht_lock);
+	/* find dmb from hash table */
+	read_lock(&ldev->dmb_ht_lock);
 	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb->dmb_tok) {
 		if (tmp_node->token == dmb->dmb_tok) {
 			dmb_node = tmp_node;
+			dmb_node->freeing = 1;
 			break;
 		}
 	}
 	if (!dmb_node) {
-		write_unlock(&ldev->dmb_ht_lock);
+		read_unlock(&ldev->dmb_ht_lock);
 		return -EINVAL;
 	}
+	read_unlock(&ldev->dmb_ht_lock);
+
+	/* wait for dmb refcnt to be 0 */
+	if (!refcount_dec_and_test(&dmb_node->refcnt))
+		wait_event(ldev->dmbs_release, !refcount_read(&dmb_node->refcnt));
+
+	/* remove dmb from hash table */
+	write_lock(&ldev->dmb_ht_lock);
 	hash_del(&dmb_node->list);
 	write_unlock(&ldev->dmb_ht_lock);
 
@@ -159,9 +170,69 @@ static int smc_lo_unregister_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb)
 	vfree(dmb_node->cpu_addr);
 	kfree(dmb_node);
 
+	if (atomic_dec_and_test(&ldev->dmb_cnt))
+		wake_up(&ldev->ldev_release);
 	return 0;
 }
 
+static int smc_lo_attach_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb)
+{
+	struct smc_lo_dmb_node *dmb_node = NULL, *tmp_node;
+	struct smc_lo_dev *ldev = smcd->priv;
+
+	/* find dmb_node according to dmb->dmb_tok */
+	read_lock(&ldev->dmb_ht_lock);
+	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb->dmb_tok) {
+		if (tmp_node->token == dmb->dmb_tok && !tmp_node->freeing) {
+			dmb_node = tmp_node;
+			break;
+		}
+	}
+	if (!dmb_node) {
+		read_unlock(&ldev->dmb_ht_lock);
+		return -EINVAL;
+	}
+	refcount_inc(&dmb_node->refcnt);
+	read_unlock(&ldev->dmb_ht_lock);
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
+	return 0;
+}
+
+static int smc_lo_get_dev_attr(struct smcd_dev *smcd)
+{
+	return BIT(ISM_ATTR_DMB_MAP);
+}
+
 static int smc_lo_add_vlan_id(struct smcd_dev *smcd, u64 vlan_id)
 {
 	return -EOPNOTSUPP;
@@ -194,7 +265,15 @@ static int smc_lo_move_data(struct smcd_dev *smcd, u64 dmb_tok, unsigned int idx
 {
 	struct smc_lo_dmb_node *rmb_node = NULL, *tmp_node;
 	struct smc_lo_dev *ldev = smcd->priv;
-
+	struct smc_connection *conn;
+
+	if (!sf) {
+		/* local sndbuf shares the same physical memory with
+		 * peer RMB, so no need to copy data from local sndbuf
+		 * to peer RMB.
+		 */
+		return 0;
+	}
 	read_lock(&ldev->dmb_ht_lock);
 	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb_tok) {
 		if (tmp_node->token == dmb_tok) {
@@ -210,13 +289,10 @@ static int smc_lo_move_data(struct smcd_dev *smcd, u64 dmb_tok, unsigned int idx
 
 	memcpy((char *)rmb_node->cpu_addr + offset, data, size);
 
-	if (sf) {
-		struct smc_connection *conn =
-			smcd->conn[rmb_node->sba_idx];
+	conn = smcd->conn[rmb_node->sba_idx];
+	if (conn && !conn->killed)
+		smcd_cdc_rx_handler(conn);
 
-		if (conn && !conn->killed)
-			smcd_cdc_rx_handler(conn);
-	}
 	return 0;
 }
 
@@ -253,6 +329,8 @@ static struct device *smc_lo_get_dev(struct smcd_dev *smcd)
 	.query_remote_gid = smc_lo_query_rgid,
 	.register_dmb = smc_lo_register_dmb,
 	.unregister_dmb = smc_lo_unregister_dmb,
+	.attach_dmb = smc_lo_attach_dmb,
+	.detach_dmb = smc_lo_detach_dmb,
 	.add_vlan_id = smc_lo_add_vlan_id,
 	.del_vlan_id = smc_lo_del_vlan_id,
 	.set_vlan_required = smc_lo_set_vlan_required,
@@ -264,6 +342,7 @@ static struct device *smc_lo_get_dev(struct smcd_dev *smcd)
 	.get_local_gid = smc_lo_get_local_gid,
 	.get_chid = smc_lo_get_chid,
 	.get_dev = smc_lo_get_dev,
+	.get_dev_attr = smc_lo_get_dev_attr,
 };
 
 static struct smcd_dev *smcd_lo_alloc_dev(const struct smcd_ops *ops,
@@ -343,6 +422,9 @@ static int smc_lo_dev_init(struct smc_lo_dev *ldev)
 	smc_lo_generate_id(ldev);
 	rwlock_init(&ldev->dmb_ht_lock);
 	hash_init(ldev->dmb_ht);
+	atomic_set(&ldev->dmb_cnt, 0);
+	init_waitqueue_head(&ldev->dmbs_release);
+	init_waitqueue_head(&ldev->ldev_release);
 
 	return smcd_lo_register_dev(ldev);
 }
@@ -376,6 +458,8 @@ static int smc_lo_dev_probe(void)
 static void smc_lo_dev_exit(struct smc_lo_dev *ldev)
 {
 	smcd_lo_unregister_dev(ldev);
+	if (atomic_read(&ldev->dmb_cnt))
+		wait_event(ldev->ldev_release, !atomic_read(&ldev->dmb_cnt));
 }
 
 static void smc_lo_dev_remove(void)
diff --git a/net/smc/smc_loopback.h b/net/smc/smc_loopback.h
index a5b501b..e42c807 100644
--- a/net/smc/smc_loopback.h
+++ b/net/smc/smc_loopback.h
@@ -30,6 +30,8 @@ struct smc_lo_dmb_node {
 	u32 sba_idx;
 	void *cpu_addr;
 	dma_addr_t dma_addr;
+	refcount_t refcnt;
+	u8 freeing : 1;
 };
 
 struct smc_lo_dev {
@@ -40,6 +42,9 @@ struct smc_lo_dev {
 	DECLARE_BITMAP(sba_idx_mask, SMC_LODEV_MAX_DMBS);
 	rwlock_t dmb_ht_lock;
 	DECLARE_HASHTABLE(dmb_ht, SMC_LODEV_DMBS_HASH_BITS);
+	atomic_t dmb_cnt;
+	wait_queue_head_t dmbs_release;
+	wait_queue_head_t ldev_release;
 };
 #endif
 
-- 
1.8.3.1

