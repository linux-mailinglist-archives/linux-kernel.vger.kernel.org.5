Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641C0804244
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 00:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbjLDXD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 18:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbjLDXD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 18:03:27 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB136113;
        Mon,  4 Dec 2023 15:03:29 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id 1120220B74C0; Mon,  4 Dec 2023 15:03:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1120220B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1701731009;
        bh=ngAycXySFu4N9asp5N94AoSgcu94Gkaier8id6EuzFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PqJ89naWt4ooIpRRBteYXPk5M/MbYTzuuzIKOe1A2rjqqj/Csgx3Fxue4SSTHEkvK
         GmSvzzv0cSYENKJ1NE1Q4PSgr21CmF/hCMcGkfAnXHRpwRXnX1ujC1lXRKU+DcgqEs
         iUY6ofrrXerwP+1gZ/c0wyQhQZoWjhnYEcsnWc7s=
From:   longli@linuxonhyperv.com
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Long Li <longli@microsoft.com>
Subject: [Patch v2 3/3] RDMA/mana_ib: Add CQ interrupt support for RAW QP
Date:   Mon,  4 Dec 2023 15:02:59 -0800
Message-Id: <1701730979-1148-4-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1701730979-1148-1-git-send-email-longli@linuxonhyperv.com>
References: <1701730979-1148-1-git-send-email-longli@linuxonhyperv.com>
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

At probing time, the MANA core code allocates EQs for supporting interrupts
on Ethernet queues. The same interrupt mechanisum is used by RAW QP.

Use the same EQs for delivering interrupts on the CQ for the RAW QP.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/infiniband/hw/mana/cq.c      | 32 ++++++++++++-
 drivers/infiniband/hw/mana/mana_ib.h |  3 ++
 drivers/infiniband/hw/mana/qp.c      | 72 ++++++++++++++++++++++++++--
 3 files changed, 102 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index 09a2c263e39b..83ebd070535a 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -12,13 +12,20 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct ib_device *ibdev = ibcq->device;
 	struct mana_ib_create_cq ucmd = {};
 	struct mana_ib_dev *mdev;
+	struct gdma_context *gc;
 	int err;
 
 	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
+	gc = mdev->gdma_dev->gdma_context;
 
 	if (udata->inlen < sizeof(ucmd))
 		return -EINVAL;
 
+	if (attr->comp_vector > gc->max_num_queues)
+		return -EINVAL;
+
+	cq->comp_vector = attr->comp_vector;
+
 	err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
 	if (err) {
 		ibdev_dbg(ibdev,
@@ -56,6 +63,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	/*
 	 * The CQ ID is not known at this time. The ID is generated at create_qp
 	 */
+	cq->id = INVALID_QUEUE_ID;
 
 	return 0;
 
@@ -69,11 +77,33 @@ int mana_ib_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 	struct mana_ib_cq *cq = container_of(ibcq, struct mana_ib_cq, ibcq);
 	struct ib_device *ibdev = ibcq->device;
 	struct mana_ib_dev *mdev;
+	struct gdma_context *gc;
+	int err;
 
 	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
+	gc = mdev->gdma_dev->gdma_context;
+
+	err = mana_ib_gd_destroy_dma_region(mdev, cq->gdma_region);
+	if (err) {
+		ibdev_dbg(ibdev,
+			  "Failed to destroy dma region, %d\n", err);
+		return err;
+	}
+
+	if (cq->id != INVALID_QUEUE_ID) {
+		kfree(gc->cq_table[cq->id]);
+		gc->cq_table[cq->id] = NULL;
+	}
 
-	mana_ib_gd_destroy_dma_region(mdev, cq->gdma_region);
 	ib_umem_release(cq->umem);
 
 	return 0;
 }
+
+void mana_ib_cq_handler(void *ctx, struct gdma_queue *gdma_cq)
+{
+	struct mana_ib_cq *cq = ctx;
+
+	if (cq->ibcq.comp_handler)
+		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
+}
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 7cb3d8ee4292..53bb4905afd5 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -86,6 +86,7 @@ struct mana_ib_cq {
 	int cqe;
 	u64 gdma_region;
 	u64 id;
+	u32 comp_vector;
 };
 
 struct mana_ib_qp {
@@ -209,4 +210,6 @@ int mana_ib_query_gid(struct ib_device *ibdev, u32 port, int index,
 void mana_ib_disassociate_ucontext(struct ib_ucontext *ibcontext);
 
 int mana_ib_query_adapter_caps(struct mana_ib_dev *mdev);
+
+void mana_ib_cq_handler(void *ctx, struct gdma_queue *gdma_cq);
 #endif
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 4667b18ec1dd..186d9829bb93 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -99,25 +99,34 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 	struct mana_ib_qp *qp = container_of(ibqp, struct mana_ib_qp, ibqp);
 	struct mana_ib_dev *mdev =
 		container_of(pd->device, struct mana_ib_dev, ib_dev);
+	struct ib_ucontext *ib_ucontext = pd->uobject->context;
 	struct ib_rwq_ind_table *ind_tbl = attr->rwq_ind_tbl;
 	struct mana_ib_create_qp_rss_resp resp = {};
 	struct mana_ib_create_qp_rss ucmd = {};
+	struct mana_ib_ucontext *mana_ucontext;
+	struct gdma_queue **gdma_cq_allocated;
 	mana_handle_t *mana_ind_table;
 	struct mana_port_context *mpc;
+	struct gdma_queue *gdma_cq;
 	unsigned int ind_tbl_size;
 	struct mana_context *mc;
 	struct net_device *ndev;
+	struct gdma_context *gc;
 	struct mana_ib_cq *cq;
 	struct mana_ib_wq *wq;
 	struct gdma_dev *gd;
+	struct mana_eq *eq;
 	struct ib_cq *ibcq;
 	struct ib_wq *ibwq;
 	int i = 0;
 	u32 port;
 	int ret;
 
-	gd = &mdev->gdma_dev->gdma_context->mana;
+	gc = mdev->gdma_dev->gdma_context;
+	gd = &gc->mana;
 	mc = gd->driver_data;
+	mana_ucontext =
+		container_of(ib_ucontext, struct mana_ib_ucontext, ibucontext);
 
 	if (!udata || udata->inlen < sizeof(ucmd))
 		return -EINVAL;
@@ -179,6 +188,13 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		goto fail;
 	}
 
+	gdma_cq_allocated = kcalloc(ind_tbl_size, sizeof(*gdma_cq_allocated),
+				    GFP_KERNEL);
+	if (!gdma_cq_allocated) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
 	qp->port = port;
 
 	for (i = 0; i < ind_tbl_size; i++) {
@@ -197,7 +213,8 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		cq_spec.gdma_region = cq->gdma_region;
 		cq_spec.queue_size = cq->cqe * COMP_ENTRY_SIZE;
 		cq_spec.modr_ctx_id = 0;
-		cq_spec.attached_eq = GDMA_CQ_NO_EQ;
+		eq = &mc->eqs[cq->comp_vector % gc->max_num_queues];
+		cq_spec.attached_eq = eq->eq->id;
 
 		ret = mana_create_wq_obj(mpc, mpc->port_handle, GDMA_RQ,
 					 &wq_spec, &cq_spec, &wq->rx_object);
@@ -219,6 +236,21 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		resp.entries[i].wqid = wq->id;
 
 		mana_ind_table[i] = wq->rx_object;
+
+		/* Create CQ table entry */
+		WARN_ON(gc->cq_table[cq->id]);
+		gdma_cq = kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
+		if (!gdma_cq) {
+			ret = -ENOMEM;
+			goto fail;
+		}
+		gdma_cq_allocated[i] = gdma_cq;
+
+		gdma_cq->cq.context = cq;
+		gdma_cq->type = GDMA_CQ;
+		gdma_cq->cq.callback = mana_ib_cq_handler;
+		gdma_cq->id = cq->id;
+		gc->cq_table[cq->id] = gdma_cq;
 	}
 	resp.num_entries = i;
 
@@ -238,6 +270,7 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		goto fail;
 	}
 
+	kfree(gdma_cq_allocated);
 	kfree(mana_ind_table);
 
 	return 0;
@@ -247,8 +280,15 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		ibwq = ind_tbl->ind_tbl[i];
 		wq = container_of(ibwq, struct mana_ib_wq, ibwq);
 		mana_destroy_wq_obj(mpc, GDMA_RQ, wq->rx_object);
+
+		if (gdma_cq_allocated[i]) {
+			gc->cq_table[gdma_cq_allocated[i]->id] =
+				NULL;
+			kfree(gdma_cq_allocated[i]);
+		}
 	}
 
+	kfree(gdma_cq_allocated);
 	kfree(mana_ind_table);
 
 	return ret;
@@ -273,11 +313,14 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	struct mana_obj_spec wq_spec = {};
 	struct mana_obj_spec cq_spec = {};
 	struct mana_port_context *mpc;
+	struct gdma_queue *gdma_cq;
 	struct mana_context *mc;
 	struct net_device *ndev;
 	struct ib_umem *umem;
-	int err;
+	struct mana_eq *eq;
+	int eq_vec;
 	u32 port;
+	int err;
 
 	mc = gd->driver_data;
 
@@ -354,7 +397,9 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	cq_spec.gdma_region = send_cq->gdma_region;
 	cq_spec.queue_size = send_cq->cqe * COMP_ENTRY_SIZE;
 	cq_spec.modr_ctx_id = 0;
-	cq_spec.attached_eq = GDMA_CQ_NO_EQ;
+	eq_vec = send_cq->comp_vector % gd->gdma_context->max_num_queues;
+	eq = &mc->eqs[eq_vec];
+	cq_spec.attached_eq = eq->eq->id;
 
 	err = mana_create_wq_obj(mpc, mpc->port_handle, GDMA_SQ, &wq_spec,
 				 &cq_spec, &qp->tx_object);
@@ -372,6 +417,20 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	qp->sq_id = wq_spec.queue_index;
 	send_cq->id = cq_spec.queue_index;
 
+	/* Create CQ table entry */
+	WARN_ON(gd->gdma_context->cq_table[send_cq->id]);
+	gdma_cq = kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
+	if (!gdma_cq) {
+		err = -ENOMEM;
+		goto err_destroy_wq_obj;
+	}
+
+	gdma_cq->cq.context = send_cq;
+	gdma_cq->type = GDMA_CQ;
+	gdma_cq->cq.callback = mana_ib_cq_handler;
+	gdma_cq->id = send_cq->id;
+	gd->gdma_context->cq_table[send_cq->id] = gdma_cq;
+
 	ibdev_dbg(&mdev->ib_dev,
 		  "ret %d qp->tx_object 0x%llx sq id %llu cq id %llu\n", err,
 		  qp->tx_object, qp->sq_id, send_cq->id);
@@ -391,6 +450,11 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	return 0;
 
 err_destroy_wq_obj:
+	if (gdma_cq) {
+		kfree(gdma_cq);
+		gd->gdma_context->cq_table[send_cq->id] = NULL;
+	}
+
 	mana_destroy_wq_obj(mpc, GDMA_SQ, qp->tx_object);
 
 err_destroy_dma_region:
-- 
2.25.1

