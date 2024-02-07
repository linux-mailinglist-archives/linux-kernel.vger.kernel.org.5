Return-Path: <linux-kernel+bounces-57140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E35984D468
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14A56B28027
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25874152E1D;
	Wed,  7 Feb 2024 21:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuB/NK2n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9B6152E0A;
	Wed,  7 Feb 2024 21:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341080; cv=none; b=QWjnQ0VD3VpY763/r2oLizSrBOlQKMHy09GAQkBKxPVD4789ylfN+/5wFXGdJ7z1vBWpCTuHrBJCbyST69Y4Wq+Z73Kk+DCUHaVha4nK0nFDQ/oWCb61bSGTiNVLB9basxnL51JsfVbCLCdjSkfx+l8ge5eU0ekMMaL82+Rr5gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341080; c=relaxed/simple;
	bh=i/mbCV0b0uxQRJ+UqETp9tbuXIBupyfw7o85nnlPrWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQrDoVHGQQTSvTm0jBRxhr7dNuwoFBvwvVxWNLwXc3XAxWXg1ZFwCz4t31GddCTs7clUyG5Fb1frW4I847ViHU5KxBauaAJr8DWu13rQVDdX9H9I+fq62crKm5XkGl2YwbQEvSFfWmcjZexcPTT0uHj25vWSEdM2Udll/cDb0S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuB/NK2n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246B1C43399;
	Wed,  7 Feb 2024 21:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341079;
	bh=i/mbCV0b0uxQRJ+UqETp9tbuXIBupyfw7o85nnlPrWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RuB/NK2nel9PhbLVjE5nRS3b0gQk+JLCL5JjbAYvRBrFhJr7rbsMx1NkhmcE3gcg5
	 2PK+GA7XNqdhh/mxXuylOGJPI/wypzLgyoFR73K7XbPmkGSmPFhm4CftF+Iq36uX9J
	 pJM3FaCtga8yt98VY5IaUw2S+5bCtrgYKJi7i72u6mJOX3G26UBp6dZMgJVTPt7s4X
	 qvOxjIvUMloEWRvvGUImVDgvNEADgCjOmDmCHIhHleoEPtWU3Bd8uLyu1jqBbOcUKE
	 C9keJgzfmsT8WEWP/kL10UgGbyV7stVf/twR2Tn3VC8hBdsuU1qsJ+ZOhw+j/vhbgB
	 rh7BtCark/hew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 30/38] nvmet-fc: defer cleanup using RCU properly
Date: Wed,  7 Feb 2024 16:23:16 -0500
Message-ID: <20240207212337.2351-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212337.2351-1-sashal@kernel.org>
References: <20240207212337.2351-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit

From: Daniel Wagner <dwagner@suse.de>

[ Upstream commit 4049dc96b8de7aeb3addcea039446e464726a525 ]

When the target executes a disconnect and the host triggers a reconnect
immediately, the reconnect command still finds an existing association.

The reconnect crashes later on because nvmet_fc_delete_target_assoc
blindly removes resources while the reconnect code wants to use it.

To address this, nvmet_fc_find_target_assoc should not be able to
lookup an association which is being removed. The association list
is already under RCU lifetime management, so let's properly use it
and remove the association from the list and wait for a grace period
before cleaning up all. This means we also can drop the RCU management
on the queues, because this is now handled via the association itself.

A second step split the execution context so that the initial disconnect
command can complete without running the reconnect code in the same
context. As usual, this is done by deferring the ->done to a workqueue.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fc.c | 83 ++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 46 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 0075d9636b06..c9ef642313c8 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -165,7 +165,7 @@ struct nvmet_fc_tgt_assoc {
 	struct nvmet_fc_hostport	*hostport;
 	struct nvmet_fc_ls_iod		*rcv_disconn;
 	struct list_head		a_list;
-	struct nvmet_fc_tgt_queue __rcu	*queues[NVMET_NR_QUEUES + 1];
+	struct nvmet_fc_tgt_queue 	*queues[NVMET_NR_QUEUES + 1];
 	struct kref			ref;
 	struct work_struct		del_work;
 	struct rcu_head			rcu;
@@ -802,14 +802,11 @@ nvmet_fc_alloc_target_queue(struct nvmet_fc_tgt_assoc *assoc,
 	if (!queue)
 		return NULL;
 
-	if (!nvmet_fc_tgt_a_get(assoc))
-		goto out_free_queue;
-
 	queue->work_q = alloc_workqueue("ntfc%d.%d.%d", 0, 0,
 				assoc->tgtport->fc_target_port.port_num,
 				assoc->a_id, qid);
 	if (!queue->work_q)
-		goto out_a_put;
+		goto out_free_queue;
 
 	queue->qid = qid;
 	queue->sqsize = sqsize;
@@ -831,15 +828,13 @@ nvmet_fc_alloc_target_queue(struct nvmet_fc_tgt_assoc *assoc,
 		goto out_fail_iodlist;
 
 	WARN_ON(assoc->queues[qid]);
-	rcu_assign_pointer(assoc->queues[qid], queue);
+	assoc->queues[qid] = queue;
 
 	return queue;
 
 out_fail_iodlist:
 	nvmet_fc_destroy_fcp_iodlist(assoc->tgtport, queue);
 	destroy_workqueue(queue->work_q);
-out_a_put:
-	nvmet_fc_tgt_a_put(assoc);
 out_free_queue:
 	kfree(queue);
 	return NULL;
@@ -852,12 +847,8 @@ nvmet_fc_tgt_queue_free(struct kref *ref)
 	struct nvmet_fc_tgt_queue *queue =
 		container_of(ref, struct nvmet_fc_tgt_queue, ref);
 
-	rcu_assign_pointer(queue->assoc->queues[queue->qid], NULL);
-
 	nvmet_fc_destroy_fcp_iodlist(queue->assoc->tgtport, queue);
 
-	nvmet_fc_tgt_a_put(queue->assoc);
-
 	destroy_workqueue(queue->work_q);
 
 	kfree_rcu(queue, rcu);
@@ -969,7 +960,7 @@ nvmet_fc_find_target_queue(struct nvmet_fc_tgtport *tgtport,
 	rcu_read_lock();
 	list_for_each_entry_rcu(assoc, &tgtport->assoc_list, a_list) {
 		if (association_id == assoc->association_id) {
-			queue = rcu_dereference(assoc->queues[qid]);
+			queue = assoc->queues[qid];
 			if (queue &&
 			    (!atomic_read(&queue->connected) ||
 			     !nvmet_fc_tgt_q_get(queue)))
@@ -1172,13 +1163,18 @@ nvmet_fc_target_assoc_free(struct kref *ref)
 	struct nvmet_fc_tgtport *tgtport = assoc->tgtport;
 	struct nvmet_fc_ls_iod	*oldls;
 	unsigned long flags;
+	int i;
+
+	for (i = NVMET_NR_QUEUES; i >= 0; i--) {
+		if (assoc->queues[i])
+			nvmet_fc_delete_target_queue(assoc->queues[i]);
+	}
 
 	/* Send Disconnect now that all i/o has completed */
 	nvmet_fc_xmt_disconnect_assoc(assoc);
 
 	nvmet_fc_free_hostport(assoc->hostport);
 	spin_lock_irqsave(&tgtport->lock, flags);
-	list_del_rcu(&assoc->a_list);
 	oldls = assoc->rcv_disconn;
 	spin_unlock_irqrestore(&tgtport->lock, flags);
 	/* if pending Rcv Disconnect Association LS, send rsp now */
@@ -1208,7 +1204,7 @@ static void
 nvmet_fc_delete_target_assoc(struct nvmet_fc_tgt_assoc *assoc)
 {
 	struct nvmet_fc_tgtport *tgtport = assoc->tgtport;
-	struct nvmet_fc_tgt_queue *queue;
+	unsigned long flags;
 	int i, terminating;
 
 	terminating = atomic_xchg(&assoc->terminating, 1);
@@ -1217,29 +1213,21 @@ nvmet_fc_delete_target_assoc(struct nvmet_fc_tgt_assoc *assoc)
 	if (terminating)
 		return;
 
+	spin_lock_irqsave(&tgtport->lock, flags);
+	list_del_rcu(&assoc->a_list);
+	spin_unlock_irqrestore(&tgtport->lock, flags);
 
-	for (i = NVMET_NR_QUEUES; i >= 0; i--) {
-		rcu_read_lock();
-		queue = rcu_dereference(assoc->queues[i]);
-		if (!queue) {
-			rcu_read_unlock();
-			continue;
-		}
+	synchronize_rcu();
 
-		if (!nvmet_fc_tgt_q_get(queue)) {
-			rcu_read_unlock();
-			continue;
-		}
-		rcu_read_unlock();
-		nvmet_fc_delete_target_queue(queue);
-		nvmet_fc_tgt_q_put(queue);
+	/* ensure all in-flight I/Os have been processed */
+	for (i = NVMET_NR_QUEUES; i >= 0; i--) {
+		if (assoc->queues[i])
+			flush_workqueue(assoc->queues[i]->work_q);
 	}
 
 	dev_info(tgtport->dev,
 		"{%d:%d} Association deleted\n",
 		tgtport->fc_target_port.port_num, assoc->a_id);
-
-	nvmet_fc_tgt_a_put(assoc);
 }
 
 static struct nvmet_fc_tgt_assoc *
@@ -1492,9 +1480,8 @@ __nvmet_fc_free_assocs(struct nvmet_fc_tgtport *tgtport)
 	list_for_each_entry_rcu(assoc, &tgtport->assoc_list, a_list) {
 		if (!nvmet_fc_tgt_a_get(assoc))
 			continue;
-		if (!queue_work(nvmet_wq, &assoc->del_work))
-			/* already deleting - release local reference */
-			nvmet_fc_tgt_a_put(assoc);
+		queue_work(nvmet_wq, &assoc->del_work);
+		nvmet_fc_tgt_a_put(assoc);
 	}
 	rcu_read_unlock();
 }
@@ -1547,9 +1534,8 @@ nvmet_fc_invalidate_host(struct nvmet_fc_target_port *target_port,
 			continue;
 		assoc->hostport->invalid = 1;
 		noassoc = false;
-		if (!queue_work(nvmet_wq, &assoc->del_work))
-			/* already deleting - release local reference */
-			nvmet_fc_tgt_a_put(assoc);
+		queue_work(nvmet_wq, &assoc->del_work);
+		nvmet_fc_tgt_a_put(assoc);
 	}
 	spin_unlock_irqrestore(&tgtport->lock, flags);
 
@@ -1581,7 +1567,7 @@ nvmet_fc_delete_ctrl(struct nvmet_ctrl *ctrl)
 
 		rcu_read_lock();
 		list_for_each_entry_rcu(assoc, &tgtport->assoc_list, a_list) {
-			queue = rcu_dereference(assoc->queues[0]);
+			queue = assoc->queues[0];
 			if (queue && queue->nvme_sq.ctrl == ctrl) {
 				if (nvmet_fc_tgt_a_get(assoc))
 					found_ctrl = true;
@@ -1593,9 +1579,8 @@ nvmet_fc_delete_ctrl(struct nvmet_ctrl *ctrl)
 		nvmet_fc_tgtport_put(tgtport);
 
 		if (found_ctrl) {
-			if (!queue_work(nvmet_wq, &assoc->del_work))
-				/* already deleting - release local reference */
-				nvmet_fc_tgt_a_put(assoc);
+			queue_work(nvmet_wq, &assoc->del_work);
+			nvmet_fc_tgt_a_put(assoc);
 			return;
 		}
 
@@ -1625,6 +1610,8 @@ nvmet_fc_unregister_targetport(struct nvmet_fc_target_port *target_port)
 	/* terminate any outstanding associations */
 	__nvmet_fc_free_assocs(tgtport);
 
+	flush_workqueue(nvmet_wq);
+
 	/*
 	 * should terminate LS's as well. However, LS's will be generated
 	 * at the tail end of association termination, so they likely don't
@@ -1870,9 +1857,6 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 				sizeof(struct fcnvme_ls_disconnect_assoc_acc)),
 			FCNVME_LS_DISCONNECT_ASSOC);
 
-	/* release get taken in nvmet_fc_find_target_assoc */
-	nvmet_fc_tgt_a_put(assoc);
-
 	/*
 	 * The rules for LS response says the response cannot
 	 * go back until ABTS's have been sent for all outstanding
@@ -1887,8 +1871,6 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 	assoc->rcv_disconn = iod;
 	spin_unlock_irqrestore(&tgtport->lock, flags);
 
-	nvmet_fc_delete_target_assoc(assoc);
-
 	if (oldls) {
 		dev_info(tgtport->dev,
 			"{%d:%d} Multiple Disconnect Association LS's "
@@ -1904,6 +1886,9 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 		nvmet_fc_xmt_ls_rsp(tgtport, oldls);
 	}
 
+	queue_work(nvmet_wq, &assoc->del_work);
+	nvmet_fc_tgt_a_put(assoc);
+
 	return false;
 }
 
@@ -2902,6 +2887,9 @@ nvmet_fc_remove_port(struct nvmet_port *port)
 
 	nvmet_fc_portentry_unbind(pe);
 
+	/* terminate any outstanding associations */
+	__nvmet_fc_free_assocs(pe->tgtport);
+
 	kfree(pe);
 }
 
@@ -2933,6 +2921,9 @@ static int __init nvmet_fc_init_module(void)
 
 static void __exit nvmet_fc_exit_module(void)
 {
+	/* ensure any shutdown operation, e.g. delete ctrls have finished */
+	flush_workqueue(nvmet_wq);
+
 	/* sanity check - all lports should be removed */
 	if (!list_empty(&nvmet_fc_target_list))
 		pr_warn("%s: targetport list not empty\n", __func__);
-- 
2.43.0


