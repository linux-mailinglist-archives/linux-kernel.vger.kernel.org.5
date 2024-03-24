Return-Path: <linux-kernel+bounces-113479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1878884AE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C548B25516
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E376713CFA5;
	Sun, 24 Mar 2024 22:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTz/cbz3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D9F13CF8C;
	Sun, 24 Mar 2024 22:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320280; cv=none; b=AJRMdw8pvUW+EZ0WFJN65DkneatJ8dkycN0rcuB6mkWcftwFMjFTywCCupeEKQ0Hfg9scR07xJ/HAuTxrMSCUTA/cPkuSEfjBNNxTmeYnEchQYdL/fHj3mAUds/EnM39h01ElaMR7VSGTDzzhkM/t0nEBhuQ5/KKbTEXFXBRI44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320280; c=relaxed/simple;
	bh=SppE/WtshS4gUFpM8GlVk5iUAieSSvCRwv5pH2ujPDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rND8SCutD+Ia2hcAkHBLfEgawprmNAhC3EAyR4K8YmpYX/OMxiq270YUUouf5BtAQdBd6ePT3UuG4ziuFFWoNjDLiZJIjbyji+/MQdADFU5Kw5OR1kO9KK3WDPxxJFOquxGR3cCha8OTL/umKnvttoeYd/1ORQbrRIZrpq/Kjhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTz/cbz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4455BC433F1;
	Sun, 24 Mar 2024 22:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320279;
	bh=SppE/WtshS4gUFpM8GlVk5iUAieSSvCRwv5pH2ujPDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iTz/cbz31o2pbeBgu8lsk8Cc+ZVbCGNQ3h6VYY6ebIerVCLhpgAKMuSldWXstMnn8
	 oEPxdnJBGddKGC6Wi84/uppoW7YyBYX6vasyBr3RvXk1G7ecTuXCeR8QrX6jQbPT+Q
	 J6E9ze4JS1ckw965P97ulY7l/AXXPEnK2d+MA4JmfEhkxrkIPXkqEh/fsrpwGKFgyP
	 DGsLCWcsTbI2z/HGb9nl9RniXP+BgCRplQ2gJnudA+ydA4+WV0pu6ThviGoWpCJog6
	 BuViZgVYWK8Y3XbwhW7DD4zmiw6kQLZoWdI8XAUROmmI15Yyvs/IE/rIoRvgavAmtA
	 bh81zb61J2flQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Taranov <kotaranov@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 588/715] RDMA/mana_ib: Introduce mana_ib_install_cq_cb helper function
Date: Sun, 24 Mar 2024 18:32:47 -0400
Message-ID: <20240324223455.1342824-589-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Konstantin Taranov <kotaranov@microsoft.com>

[ Upstream commit 2a31c5a7e0d87959a03e846523013c75f4395a91 ]

Use a helper function to install callbacks to CQs.
This patch removes code repetition.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
Link: https://lore.kernel.org/r/1705965781-3235-4-git-send-email-kotaranov@linux.microsoft.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Stable-dep-of: 2d5c00815778 ("RDMA/mana_ib: Use virtual address in dma regions for MRs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mana/cq.c      | 21 ++++++++++++++++++++-
 drivers/infiniband/hw/mana/mana_ib.h |  4 ++--
 drivers/infiniband/hw/mana/qp.c      | 28 +++++-----------------------
 3 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index 3369e7b665f9f..83d20c3f048df 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -100,10 +100,29 @@ int mana_ib_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 	return 0;
 }
 
-void mana_ib_cq_handler(void *ctx, struct gdma_queue *gdma_cq)
+static void mana_ib_cq_handler(void *ctx, struct gdma_queue *gdma_cq)
 {
 	struct mana_ib_cq *cq = ctx;
 
 	if (cq->ibcq.comp_handler)
 		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
 }
+
+int mana_ib_install_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq *cq)
+{
+	struct gdma_context *gc = mdev_to_gc(mdev);
+	struct gdma_queue *gdma_cq;
+
+	/* Create CQ table entry */
+	WARN_ON(gc->cq_table[cq->id]);
+	gdma_cq = kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
+	if (!gdma_cq)
+		return -ENOMEM;
+
+	gdma_cq->cq.context = cq;
+	gdma_cq->type = GDMA_CQ;
+	gdma_cq->cq.callback = mana_ib_cq_handler;
+	gdma_cq->id = cq->id;
+	gc->cq_table[cq->id] = gdma_cq;
+	return 0;
+}
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index d373639e25d4a..6a03ae645c012 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -158,6 +158,8 @@ static inline struct net_device *mana_ib_get_netdev(struct ib_device *ibdev, u32
 	return mc->ports[port - 1];
 }
 
+int mana_ib_install_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq *cq);
+
 int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
 				 mana_handle_t *gdma_region);
 
@@ -226,6 +228,4 @@ int mana_ib_query_gid(struct ib_device *ibdev, u32 port, int index,
 void mana_ib_disassociate_ucontext(struct ib_ucontext *ibcontext);
 
 int mana_ib_gd_query_adapter_caps(struct mana_ib_dev *mdev);
-
-void mana_ib_cq_handler(void *ctx, struct gdma_queue *gdma_cq);
 #endif
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index f5427599e0336..5d4c05dcd0032 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -104,7 +104,6 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 	struct gdma_queue **gdma_cq_allocated;
 	mana_handle_t *mana_ind_table;
 	struct mana_port_context *mpc;
-	struct gdma_queue *gdma_cq;
 	unsigned int ind_tbl_size;
 	struct net_device *ndev;
 	struct mana_ib_cq *cq;
@@ -229,19 +228,11 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		mana_ind_table[i] = wq->rx_object;
 
 		/* Create CQ table entry */
-		WARN_ON(gc->cq_table[cq->id]);
-		gdma_cq = kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
-		if (!gdma_cq) {
-			ret = -ENOMEM;
+		ret = mana_ib_install_cq_cb(mdev, cq);
+		if (ret)
 			goto fail;
-		}
-		gdma_cq_allocated[i] = gdma_cq;
 
-		gdma_cq->cq.context = cq;
-		gdma_cq->type = GDMA_CQ;
-		gdma_cq->cq.callback = mana_ib_cq_handler;
-		gdma_cq->id = cq->id;
-		gc->cq_table[cq->id] = gdma_cq;
+		gdma_cq_allocated[i] = gc->cq_table[cq->id];
 	}
 	resp.num_entries = i;
 
@@ -407,18 +398,9 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	send_cq->id = cq_spec.queue_index;
 
 	/* Create CQ table entry */
-	WARN_ON(gc->cq_table[send_cq->id]);
-	gdma_cq = kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
-	if (!gdma_cq) {
-		err = -ENOMEM;
+	err = mana_ib_install_cq_cb(mdev, send_cq);
+	if (err)
 		goto err_destroy_wq_obj;
-	}
-
-	gdma_cq->cq.context = send_cq;
-	gdma_cq->type = GDMA_CQ;
-	gdma_cq->cq.callback = mana_ib_cq_handler;
-	gdma_cq->id = send_cq->id;
-	gc->cq_table[send_cq->id] = gdma_cq;
 
 	ibdev_dbg(&mdev->ib_dev,
 		  "ret %d qp->tx_object 0x%llx sq id %llu cq id %llu\n", err,
-- 
2.43.0


