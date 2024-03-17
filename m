Return-Path: <linux-kernel+bounces-105366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7956E87DCDB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 11:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91591F214E5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 10:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32401D529;
	Sun, 17 Mar 2024 10:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dFLDcg55"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAE318049;
	Sun, 17 Mar 2024 10:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710669966; cv=none; b=O553TS4BPJG4qne0DJkkU3t2Lf/VS+vibj7vkzc0xN7jFh7CcBVSBvInqnFqpIQgobECDtdCct9ZQAAfPbWrmHxqUd/U4CCb9U3R98jZjWRU8L1AHux1ecSSl97viauPXEBwjwzwMJ4tylHb6/2k9cxAUlsXLwXd+4cxP2WTyIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710669966; c=relaxed/simple;
	bh=d/f+rqWWrCiPLTlsK6uCCqAGcWyrx4HXB+EIx9nXQ9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HaVfP4jiRLWTYRz5OBYNyeL3m71y/6be8GXVgUieIRQ/Y+cOuOQh6IL+h7LWUCfs3mxNqNshxqRnMSU4ef9F98aXHfHHmOGpHEJ01tE+ctKauj4xFtmhpcmYeyKvEOlqMJ4pJVgJTJHE3m1b0JtEtuh+7h5S4lSHuXcForBoD3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dFLDcg55; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710669959; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=XXmNb7lQNGh1Pf1v4VwP/UCVKB/+4h+FT8aHZoBzRfQ=;
	b=dFLDcg55GMv3sDGujARuD1pJz0ClqCY8SEQbtipmC2ViLEd5iycEQHdUa8kj5qKRBAVbYPq+zn1ljv+OcqT1yZTtX0rf1LOqwjvHLav132WPpeDH76pO7N6MhBcoxuV/Fqz1YscuiiN9aGXdE2Vo+X3Gzm5Hrb+S2N2961U5xnw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W2c852a_1710669957;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W2c852a_1710669957)
          by smtp.aliyun-inc.com;
          Sun, 17 Mar 2024 18:05:58 +0800
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
Subject: [RFC PATCH net-next v4 05/11] net/smc: implement DMB-related operations of loopback-ism
Date: Sun, 17 Mar 2024 18:05:39 +0800
Message-Id: <20240317100545.96663-6-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240317100545.96663-1-guwen@linux.alibaba.com>
References: <20240317100545.96663-1-guwen@linux.alibaba.com>
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
 net/smc/smc_loopback.c | 131 ++++++++++++++++++++++++++++++++++++++++-
 net/smc/smc_loopback.h |  13 ++++
 2 files changed, 141 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
index 253128c77208..7335acb03920 100644
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
@@ -49,6 +51,93 @@ static int smc_lo_query_rgid(struct smcd_dev *smcd, struct smcd_gid *rgid,
 	return 0;
 }
 
+static int smc_lo_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
+			       void *client_priv)
+{
+	struct smc_lo_dmb_node *dmb_node, *tmp_node;
+	struct smc_lo_dev *ldev = smcd->priv;
+	int sba_idx, rc;
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
+	dmb_node->len = dmb->dmb_len;
+	dmb_node->cpu_addr = kzalloc(dmb_node->len, GFP_KERNEL |
+				     __GFP_NOWARN | __GFP_NORETRY |
+				     __GFP_NOMEMALLOC);
+	if (!dmb_node->cpu_addr) {
+		rc = -ENOMEM;
+		goto err_node;
+	}
+	dmb_node->dma_addr = SMC_DMA_ADDR_INVALID;
+
+again:
+	/* add new dmb into hash table */
+	get_random_bytes(&dmb_node->token, sizeof(dmb_node->token));
+	write_lock_bh(&ldev->dmb_ht_lock);
+	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb_node->token) {
+		if (tmp_node->token == dmb_node->token) {
+			write_unlock_bh(&ldev->dmb_ht_lock);
+			goto again;
+		}
+	}
+	hash_add(ldev->dmb_ht, &dmb_node->list, dmb_node->token);
+	write_unlock_bh(&ldev->dmb_ht_lock);
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
+	write_lock_bh(&ldev->dmb_ht_lock);
+	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb->dmb_tok) {
+		if (tmp_node->token == dmb->dmb_tok) {
+			dmb_node = tmp_node;
+			break;
+		}
+	}
+	if (!dmb_node) {
+		write_unlock_bh(&ldev->dmb_ht_lock);
+		return -EINVAL;
+	}
+	hash_del(&dmb_node->list);
+	write_unlock_bh(&ldev->dmb_ht_lock);
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
@@ -75,6 +164,40 @@ static int smc_lo_signal_event(struct smcd_dev *dev, struct smcd_gid *rgid,
 	return 0;
 }
 
+static int smc_lo_move_data(struct smcd_dev *smcd, u64 dmb_tok,
+			    unsigned int idx, bool sf, unsigned int offset,
+			    void *data, unsigned int size)
+{
+	struct smc_lo_dmb_node *rmb_node = NULL, *tmp_node;
+	struct smc_lo_dev *ldev = smcd->priv;
+
+	read_lock_bh(&ldev->dmb_ht_lock);
+	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb_tok) {
+		if (tmp_node->token == dmb_tok) {
+			rmb_node = tmp_node;
+			break;
+		}
+	}
+	if (!rmb_node) {
+		read_unlock_bh(&ldev->dmb_ht_lock);
+		return -EINVAL;
+	}
+	read_unlock_bh(&ldev->dmb_ht_lock);
+
+	memcpy((char *)rmb_node->cpu_addr + offset, data, size);
+
+	if (sf) {
+		struct smc_connection *conn =
+			smcd->conn[rmb_node->sba_idx];
+
+		if (conn && !conn->killed)
+			tasklet_schedule(&conn->rx_tsklet);
+		else
+			return -EPIPE;
+	}
+	return 0;
+}
+
 static int smc_lo_supports_v2(void)
 {
 	return SMC_LO_V2_CAPABLE;
@@ -101,14 +224,14 @@ static struct device *smc_lo_get_dev(struct smcd_dev *smcd)
 
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
@@ -173,6 +296,8 @@ static void smcd_lo_unregister_dev(struct smc_lo_dev *ldev)
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


