Return-Path: <linux-kernel+bounces-113478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD978884BD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B8A6B252E8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4217113CF92;
	Sun, 24 Mar 2024 22:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2ty/AP5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BD11B4C18;
	Sun, 24 Mar 2024 22:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320279; cv=none; b=I50q6TG5ogMtiY8qkJgzeWpvRrDS8h45UXW73NsbVOS/Sl0zcOI2tIi4pSybFBU7QPB8vx0M+OSemLR+Rm82QOr6LXcfllmguTAxwVNIsez2P2UNL7wPnCAxf22LAx0QNpt67u+nyTu7Keoi4Mgeki8odPwRtJXBBSkWPAw9D/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320279; c=relaxed/simple;
	bh=+1EC03CGTZ3PTFfvNquNrlfWbjcm9Wtgg0nXy3O88ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTpQKcqP0CwNP6ghV6hx4iIiqn4uidJpPTJPhno+nmroo2pP7rxYrwKVCTRStDzUAfW822Wsn1SEAiRgeD/jgtQUxWM1RBwEFnX1kVBcnZ6A533ugayoEhDb9qNvcIDqA2VhC6mpFX8/Siq/ETlcwADsyvzw6VpOgBMwgTvyNRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2ty/AP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145D1C43394;
	Sun, 24 Mar 2024 22:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320279;
	bh=+1EC03CGTZ3PTFfvNquNrlfWbjcm9Wtgg0nXy3O88ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j2ty/AP5Vg9YiQWXXQyC2wMONl2A1h3PXCXL4cBBJeB/A3YaBuAIoHfq2qgFAYjn3
	 REygaUl6uVXXlwEqIPKalR6EyZCOCj6psGpL7LOe8MjN8rtQi4pP7H/JOWS9FPJ21M
	 H8CTj+u3Z+lNVV2dOCD6aTLZW7SVXYMl1H82nv7jXnBV2Q5V8SKc3azSGY4reTYEYa
	 cWzsGkLIAhMqY8Ht7Gp5BmEpI4yZovLaZmfkAd3bfneQyrNIXlBIW2aoBfhl2ysIMW
	 kfex8fYm3LtpLzbxBqJUPA+9eQnq/6bi+KbzeNgSKey1lK0vDpyF2A1BjuOaxE2w4p
	 vMh/Z7aSv+Y4g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Taranov <kotaranov@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 587/715] RDMA/mana_ib: Introduce mana_ib_get_netdev helper function
Date: Sun, 24 Mar 2024 18:32:46 -0400
Message-ID: <20240324223455.1342824-588-sashal@kernel.org>
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

[ Upstream commit 3b73eb3a4acdf563de49d825968bb5f10300acd4 ]

Use a helper function to access netdevs using a port number.
This patch removes code repetitions as well as removes the need
to explicitly use gdma_dev, which was error-prone.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
Link: https://lore.kernel.org/r/1705965781-3235-3-git-send-email-kotaranov@linux.microsoft.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Stable-dep-of: 2d5c00815778 ("RDMA/mana_ib: Use virtual address in dma regions for MRs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mana/main.c    | 10 ++----
 drivers/infiniband/hw/mana/mana_ib.h | 11 ++++++
 drivers/infiniband/hw/mana/qp.c      | 52 ++++++++++------------------
 3 files changed, 32 insertions(+), 41 deletions(-)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 233ee76402641..dd570832d61ea 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -8,13 +8,10 @@
 void mana_ib_uncfg_vport(struct mana_ib_dev *dev, struct mana_ib_pd *pd,
 			 u32 port)
 {
-	struct gdma_dev *gd = &dev->gdma_dev->gdma_context->mana;
 	struct mana_port_context *mpc;
 	struct net_device *ndev;
-	struct mana_context *mc;
 
-	mc = gd->driver_data;
-	ndev = mc->ports[port];
+	ndev = mana_ib_get_netdev(&dev->ib_dev, port);
 	mpc = netdev_priv(ndev);
 
 	mutex_lock(&pd->vport_mutex);
@@ -31,14 +28,11 @@ void mana_ib_uncfg_vport(struct mana_ib_dev *dev, struct mana_ib_pd *pd,
 int mana_ib_cfg_vport(struct mana_ib_dev *dev, u32 port, struct mana_ib_pd *pd,
 		      u32 doorbell_id)
 {
-	struct gdma_dev *mdev = &dev->gdma_dev->gdma_context->mana;
 	struct mana_port_context *mpc;
-	struct mana_context *mc;
 	struct net_device *ndev;
 	int err;
 
-	mc = mdev->driver_data;
-	ndev = mc->ports[port];
+	ndev = mana_ib_get_netdev(&dev->ib_dev, port);
 	mpc = netdev_priv(ndev);
 
 	mutex_lock(&pd->vport_mutex);
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index ebb6537620eea..d373639e25d4a 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -147,6 +147,17 @@ static inline struct gdma_context *mdev_to_gc(struct mana_ib_dev *mdev)
 	return mdev->gdma_dev->gdma_context;
 }
 
+static inline struct net_device *mana_ib_get_netdev(struct ib_device *ibdev, u32 port)
+{
+	struct mana_ib_dev *mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
+	struct gdma_context *gc = mdev_to_gc(mdev);
+	struct mana_context *mc = gc->mana.driver_data;
+
+	if (port < 1 || port > mc->num_ports)
+		return NULL;
+	return mc->ports[port - 1];
+}
+
 int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
 				 mana_handle_t *gdma_region);
 
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 0c8d6ecfbb2a3..f5427599e0336 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -106,11 +106,9 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 	struct mana_port_context *mpc;
 	struct gdma_queue *gdma_cq;
 	unsigned int ind_tbl_size;
-	struct mana_context *mc;
 	struct net_device *ndev;
 	struct mana_ib_cq *cq;
 	struct mana_ib_wq *wq;
-	struct gdma_dev *gd;
 	struct mana_eq *eq;
 	struct ib_cq *ibcq;
 	struct ib_wq *ibwq;
@@ -118,9 +116,6 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 	u32 port;
 	int ret;
 
-	gd = &gc->mana;
-	mc = gd->driver_data;
-
 	if (!udata || udata->inlen < sizeof(ucmd))
 		return -EINVAL;
 
@@ -163,12 +158,12 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 
 	/* IB ports start with 1, MANA start with 0 */
 	port = ucmd.port;
-	if (port < 1 || port > mc->num_ports) {
+	ndev = mana_ib_get_netdev(pd->device, port);
+	if (!ndev) {
 		ibdev_dbg(&mdev->ib_dev, "Invalid port %u in creating qp\n",
 			  port);
 		return -EINVAL;
 	}
-	ndev = mc->ports[port - 1];
 	mpc = netdev_priv(ndev);
 
 	ibdev_dbg(&mdev->ib_dev, "rx_hash_function %d port %d\n",
@@ -206,7 +201,7 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		cq_spec.gdma_region = cq->gdma_region;
 		cq_spec.queue_size = cq->cqe * COMP_ENTRY_SIZE;
 		cq_spec.modr_ctx_id = 0;
-		eq = &mc->eqs[cq->comp_vector % gc->max_num_queues];
+		eq = &mpc->ac->eqs[cq->comp_vector % gc->max_num_queues];
 		cq_spec.attached_eq = eq->eq->id;
 
 		ret = mana_create_wq_obj(mpc, mpc->port_handle, GDMA_RQ,
@@ -303,7 +298,6 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	struct mana_ib_ucontext *mana_ucontext =
 		rdma_udata_to_drv_context(udata, struct mana_ib_ucontext,
 					  ibucontext);
-	struct gdma_dev *gd = &mdev->gdma_dev->gdma_context->mana;
 	struct gdma_context *gc = mdev_to_gc(mdev);
 	struct mana_ib_create_qp_resp resp = {};
 	struct mana_ib_create_qp ucmd = {};
@@ -311,7 +305,6 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	struct mana_obj_spec wq_spec = {};
 	struct mana_obj_spec cq_spec = {};
 	struct mana_port_context *mpc;
-	struct mana_context *mc;
 	struct net_device *ndev;
 	struct ib_umem *umem;
 	struct mana_eq *eq;
@@ -319,8 +312,6 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	u32 port;
 	int err;
 
-	mc = gd->driver_data;
-
 	if (!mana_ucontext || udata->inlen < sizeof(ucmd))
 		return -EINVAL;
 
@@ -331,11 +322,6 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 		return err;
 	}
 
-	/* IB ports start with 1, MANA Ethernet ports start with 0 */
-	port = ucmd.port;
-	if (port < 1 || port > mc->num_ports)
-		return -EINVAL;
-
 	if (attr->cap.max_send_wr > mdev->adapter_caps.max_qp_wr) {
 		ibdev_dbg(&mdev->ib_dev,
 			  "Requested max_send_wr %d exceeding limit\n",
@@ -350,11 +336,17 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 		return -EINVAL;
 	}
 
-	ndev = mc->ports[port - 1];
+	port = ucmd.port;
+	ndev = mana_ib_get_netdev(ibpd->device, port);
+	if (!ndev) {
+		ibdev_dbg(&mdev->ib_dev, "Invalid port %u in creating qp\n",
+			  port);
+		return -EINVAL;
+	}
 	mpc = netdev_priv(ndev);
 	ibdev_dbg(&mdev->ib_dev, "port %u ndev %p mpc %p\n", port, ndev, mpc);
 
-	err = mana_ib_cfg_vport(mdev, port - 1, pd, mana_ucontext->doorbell);
+	err = mana_ib_cfg_vport(mdev, port, pd, mana_ucontext->doorbell);
 	if (err)
 		return -ENODEV;
 
@@ -394,8 +386,8 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	cq_spec.gdma_region = send_cq->gdma_region;
 	cq_spec.queue_size = send_cq->cqe * COMP_ENTRY_SIZE;
 	cq_spec.modr_ctx_id = 0;
-	eq_vec = send_cq->comp_vector % gd->gdma_context->max_num_queues;
-	eq = &mc->eqs[eq_vec];
+	eq_vec = send_cq->comp_vector % gc->max_num_queues;
+	eq = &mpc->ac->eqs[eq_vec];
 	cq_spec.attached_eq = eq->eq->id;
 
 	err = mana_create_wq_obj(mpc, mpc->port_handle, GDMA_SQ, &wq_spec,
@@ -415,7 +407,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	send_cq->id = cq_spec.queue_index;
 
 	/* Create CQ table entry */
-	WARN_ON(gd->gdma_context->cq_table[send_cq->id]);
+	WARN_ON(gc->cq_table[send_cq->id]);
 	gdma_cq = kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
 	if (!gdma_cq) {
 		err = -ENOMEM;
@@ -426,7 +418,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	gdma_cq->type = GDMA_CQ;
 	gdma_cq->cq.callback = mana_ib_cq_handler;
 	gdma_cq->id = send_cq->id;
-	gd->gdma_context->cq_table[send_cq->id] = gdma_cq;
+	gc->cq_table[send_cq->id] = gdma_cq;
 
 	ibdev_dbg(&mdev->ib_dev,
 		  "ret %d qp->tx_object 0x%llx sq id %llu cq id %llu\n", err,
@@ -460,7 +452,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	ib_umem_release(umem);
 
 err_free_vport:
-	mana_ib_uncfg_vport(mdev, pd, port - 1);
+	mana_ib_uncfg_vport(mdev, pd, port);
 
 	return err;
 }
@@ -498,16 +490,13 @@ static int mana_ib_destroy_qp_rss(struct mana_ib_qp *qp,
 {
 	struct mana_ib_dev *mdev =
 		container_of(qp->ibqp.device, struct mana_ib_dev, ib_dev);
-	struct gdma_dev *gd = &mdev->gdma_dev->gdma_context->mana;
 	struct mana_port_context *mpc;
-	struct mana_context *mc;
 	struct net_device *ndev;
 	struct mana_ib_wq *wq;
 	struct ib_wq *ibwq;
 	int i;
 
-	mc = gd->driver_data;
-	ndev = mc->ports[qp->port - 1];
+	ndev = mana_ib_get_netdev(qp->ibqp.device, qp->port);
 	mpc = netdev_priv(ndev);
 
 	for (i = 0; i < (1 << ind_tbl->log_ind_tbl_size); i++) {
@@ -525,15 +514,12 @@ static int mana_ib_destroy_qp_raw(struct mana_ib_qp *qp, struct ib_udata *udata)
 {
 	struct mana_ib_dev *mdev =
 		container_of(qp->ibqp.device, struct mana_ib_dev, ib_dev);
-	struct gdma_dev *gd = &mdev->gdma_dev->gdma_context->mana;
 	struct ib_pd *ibpd = qp->ibqp.pd;
 	struct mana_port_context *mpc;
-	struct mana_context *mc;
 	struct net_device *ndev;
 	struct mana_ib_pd *pd;
 
-	mc = gd->driver_data;
-	ndev = mc->ports[qp->port - 1];
+	ndev = mana_ib_get_netdev(qp->ibqp.device, qp->port);
 	mpc = netdev_priv(ndev);
 	pd = container_of(ibpd, struct mana_ib_pd, ibpd);
 
@@ -544,7 +530,7 @@ static int mana_ib_destroy_qp_raw(struct mana_ib_qp *qp, struct ib_udata *udata)
 		ib_umem_release(qp->sq_umem);
 	}
 
-	mana_ib_uncfg_vport(mdev, pd, qp->port - 1);
+	mana_ib_uncfg_vport(mdev, pd, qp->port);
 
 	return 0;
 }
-- 
2.43.0


