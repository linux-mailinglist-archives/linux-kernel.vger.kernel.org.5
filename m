Return-Path: <linux-kernel+bounces-23543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4E182AE38
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141DD2840B6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13122171D8;
	Thu, 11 Jan 2024 12:01:31 +0000 (UTC)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7AC171A0;
	Thu, 11 Jan 2024 12:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W-Pgn8A_1704974477;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W-Pgn8A_1704974477)
          by smtp.aliyun-inc.com;
          Thu, 11 Jan 2024 20:01:19 +0800
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
Subject: [PATCH net-next 06/15] net/smc: implement DMB-related operations of loopback-ism
Date: Thu, 11 Jan 2024 20:00:27 +0800
Message-Id: <20240111120036.109903-7-guwen@linux.alibaba.com>
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

This implements DMB (un)registration and data move operations of
loopback-ism device.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_cdc.c      |   6 ++
 net/smc/smc_cdc.h      |   1 +
 net/smc/smc_loopback.c | 133 ++++++++++++++++++++++++++++++++++++++++-
 net/smc/smc_loopback.h |  13 ++++
 4 files changed, 150 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index 3c06625ceb20..c820ef197610 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -410,6 +410,12 @@ static void smc_cdc_msg_recv(struct smc_sock *smc, struct smc_cdc_msg *cdc)
 static void smcd_cdc_rx_tsklet(struct tasklet_struct *t)
 {
 	struct smc_connection *conn = from_tasklet(conn, t, rx_tsklet);
+
+	smcd_cdc_rx_handler(conn);
+}
+
+void smcd_cdc_rx_handler(struct smc_connection *conn)
+{
 	struct smcd_cdc_msg *data_cdc;
 	struct smcd_cdc_msg cdc;
 	struct smc_sock *smc;
diff --git a/net/smc/smc_cdc.h b/net/smc/smc_cdc.h
index 696cc11f2303..11559d4ebf2b 100644
--- a/net/smc/smc_cdc.h
+++ b/net/smc/smc_cdc.h
@@ -301,5 +301,6 @@ int smcr_cdc_msg_send_validation(struct smc_connection *conn,
 				 struct smc_wr_buf *wr_buf);
 int smc_cdc_init(void) __init;
 void smcd_cdc_rx_init(struct smc_connection *conn);
+void smcd_cdc_rx_handler(struct smc_connection *conn);
 
 #endif /* SMC_CDC_H */
diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
index 353d4a2d69a1..f72e7b24fc1a 100644
--- a/net/smc/smc_loopback.c
+++ b/net/smc/smc_loopback.c
@@ -15,11 +15,13 @@
 #include <linux/types.h>
 #include <net/smc.h>
 
+#include "smc_cdc.h"
 #include "smc_ism.h"
 #include "smc_loopback.h"
 
 #if IS_ENABLED(CONFIG_SMC_LO)
 #define SMC_LO_V2_CAPABLE	0x1 /* loopback-ism acts as ISMv2 */
+#define SMC_DMA_ADDR_INVALID	(~(dma_addr_t)0)
 
 static const char smc_lo_dev_name[] = "loopback-ism";
 static struct smc_lo_dev *lo_dev;
@@ -50,6 +52,97 @@ static int smc_lo_query_rgid(struct smcd_dev *smcd, struct smcd_gid *rgid,
 	return 0;
 }
 
+static int smc_lo_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
+			       void *client_priv)
+{
+	struct smc_lo_dmb_node *dmb_node, *tmp_node;
+	struct smc_lo_dev *ldev = smcd->priv;
+	int sba_idx, order, rc;
+	struct page *pages;
+
+	/* check space for new dmb */
+	for_each_clear_bit(sba_idx, ldev->sba_idx_mask, SMC_LO_MAX_DMBS) {
+		if (!test_and_set_bit(sba_idx, ldev->sba_idx_mask))
+			break;
+	}
+	if (sba_idx == SMC_LO_MAX_DMBS)
+		return -ENOSPC;
+
+	dmb_node = kzalloc(sizeof(*dmb_node), GFP_KERNEL);
+	if (!dmb_node) {
+		rc = -ENOMEM;
+		goto err_bit;
+	}
+
+	dmb_node->sba_idx = sba_idx;
+	order = get_order(dmb->dmb_len);
+	pages = alloc_pages(GFP_KERNEL | __GFP_NOWARN |
+			    __GFP_NOMEMALLOC | __GFP_COMP |
+			    __GFP_NORETRY | __GFP_ZERO,
+			    order);
+	if (!pages) {
+		rc = -ENOMEM;
+		goto err_node;
+	}
+	dmb_node->cpu_addr = (void *)page_address(pages);
+	dmb_node->len = dmb->dmb_len;
+	dmb_node->dma_addr = SMC_DMA_ADDR_INVALID;
+
+again:
+	/* add new dmb into hash table */
+	get_random_bytes(&dmb_node->token, sizeof(dmb_node->token));
+	write_lock(&ldev->dmb_ht_lock);
+	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb_node->token) {
+		if (tmp_node->token == dmb_node->token) {
+			write_unlock(&ldev->dmb_ht_lock);
+			goto again;
+		}
+	}
+	hash_add(ldev->dmb_ht, &dmb_node->list, dmb_node->token);
+	write_unlock(&ldev->dmb_ht_lock);
+
+	dmb->sba_idx = dmb_node->sba_idx;
+	dmb->dmb_tok = dmb_node->token;
+	dmb->cpu_addr = dmb_node->cpu_addr;
+	dmb->dma_addr = dmb_node->dma_addr;
+	dmb->dmb_len = dmb_node->len;
+
+	return 0;
+
+err_node:
+	kfree(dmb_node);
+err_bit:
+	clear_bit(sba_idx, ldev->sba_idx_mask);
+	return rc;
+}
+
+static int smc_lo_unregister_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb)
+{
+	struct smc_lo_dmb_node *dmb_node = NULL, *tmp_node;
+	struct smc_lo_dev *ldev = smcd->priv;
+
+	/* remove dmb from hash table */
+	write_lock(&ldev->dmb_ht_lock);
+	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb->dmb_tok) {
+		if (tmp_node->token == dmb->dmb_tok) {
+			dmb_node = tmp_node;
+			break;
+		}
+	}
+	if (!dmb_node) {
+		write_unlock(&ldev->dmb_ht_lock);
+		return -EINVAL;
+	}
+	hash_del(&dmb_node->list);
+	write_unlock(&ldev->dmb_ht_lock);
+
+	clear_bit(dmb_node->sba_idx, ldev->sba_idx_mask);
+	kfree(dmb_node->cpu_addr);
+	kfree(dmb_node);
+
+	return 0;
+}
+
 static int smc_lo_add_vlan_id(struct smcd_dev *smcd, u64 vlan_id)
 {
 	return -EOPNOTSUPP;
@@ -76,6 +169,38 @@ static int smc_lo_signal_event(struct smcd_dev *dev, struct smcd_gid *rgid,
 	return 0;
 }
 
+static int smc_lo_move_data(struct smcd_dev *smcd, u64 dmb_tok,
+			    unsigned int idx, bool sf, unsigned int offset,
+			    void *data, unsigned int size)
+{
+	struct smc_lo_dmb_node *rmb_node = NULL, *tmp_node;
+	struct smc_lo_dev *ldev = smcd->priv;
+
+	read_lock(&ldev->dmb_ht_lock);
+	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb_tok) {
+		if (tmp_node->token == dmb_tok) {
+			rmb_node = tmp_node;
+			break;
+		}
+	}
+	if (!rmb_node) {
+		read_unlock(&ldev->dmb_ht_lock);
+		return -EINVAL;
+	}
+	read_unlock(&ldev->dmb_ht_lock);
+
+	memcpy((char *)rmb_node->cpu_addr + offset, data, size);
+
+	if (sf) {
+		struct smc_connection *conn =
+			smcd->conn[rmb_node->sba_idx];
+
+		if (conn && !conn->killed)
+			smcd_cdc_rx_handler(conn);
+	}
+	return 0;
+}
+
 static int smc_lo_supports_v2(void)
 {
 	return SMC_LO_V2_CAPABLE;
@@ -102,14 +227,14 @@ static struct device *smc_lo_get_dev(struct smcd_dev *smcd)
 
 static const struct smcd_ops lo_ops = {
 	.query_remote_gid = smc_lo_query_rgid,
-	.register_dmb		= NULL,
-	.unregister_dmb		= NULL,
+	.register_dmb = smc_lo_register_dmb,
+	.unregister_dmb = smc_lo_unregister_dmb,
 	.add_vlan_id = smc_lo_add_vlan_id,
 	.del_vlan_id = smc_lo_del_vlan_id,
 	.set_vlan_required = smc_lo_set_vlan_required,
 	.reset_vlan_required = smc_lo_reset_vlan_required,
 	.signal_event = smc_lo_signal_event,
-	.move_data		= NULL,
+	.move_data = smc_lo_move_data,
 	.supports_v2 = smc_lo_supports_v2,
 	.get_local_gid = smc_lo_get_local_gid,
 	.get_chid = smc_lo_get_chid,
@@ -174,6 +299,8 @@ static void smcd_lo_unregister_dev(struct smc_lo_dev *ldev)
 static int smc_lo_dev_init(struct smc_lo_dev *ldev)
 {
 	smc_lo_generate_id(ldev);
+	rwlock_init(&ldev->dmb_ht_lock);
+	hash_init(ldev->dmb_ht);
 	return smcd_lo_register_dev(ldev);
 }
 
diff --git a/net/smc/smc_loopback.h b/net/smc/smc_loopback.h
index 55b41133a97f..24ab9d747613 100644
--- a/net/smc/smc_loopback.h
+++ b/net/smc/smc_loopback.h
@@ -20,13 +20,26 @@
 
 #if IS_ENABLED(CONFIG_SMC_LO)
 #define SMC_LO_MAX_DMBS		5000
+#define SMC_LO_DMBS_HASH_BITS	12
 #define SMC_LO_CHID		0xFFFF
 
+struct smc_lo_dmb_node {
+	struct hlist_node list;
+	u64 token;
+	u32 len;
+	u32 sba_idx;
+	void *cpu_addr;
+	dma_addr_t dma_addr;
+};
+
 struct smc_lo_dev {
 	struct smcd_dev *smcd;
 	struct device dev;
 	u16 chid;
 	struct smcd_gid local_gid;
+	rwlock_t dmb_ht_lock;
+	DECLARE_BITMAP(sba_idx_mask, SMC_LO_MAX_DMBS);
+	DECLARE_HASHTABLE(dmb_ht, SMC_LO_DMBS_HASH_BITS);
 };
 #endif
 
-- 
2.32.0.3.g01195cf9f


