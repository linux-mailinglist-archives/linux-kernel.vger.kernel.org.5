Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9272180CBCF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343963AbjLKNyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbjLKNyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:54:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E8B212E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:53:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88BCC433CC;
        Mon, 11 Dec 2023 13:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702302797;
        bh=jISVUJ4Vnn7RdULOxYgpFhjchzrBfjme2x8jjz/TR34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NdxqSnzVVV8JN3T3T+gNC0B7brYw0Cdi6HvF0Fe7RElWQDpCK63dOzs/wvx0aJk82
         LIgGapwtdfwfPEExp/RiZ0EZMMZ4+UmO0ULJe5+ReagNlJgM0acKezG+90IsgE+YvN
         2Beqqit4MetMDkiAA+wHpBt8hlvomI3FQitJgZuGWE3B9psn74mfAv9kyoGRzgLv6s
         UNJgLqHIAlsy8wUahoDB+TrtYcNUJhISBMyCidhTvRiphpV00RY4I5JfWT1woE7F78
         FtIvnLbw/1XNScb8YBxhHCu5T64fN7vN4mGD9hKrFXl8s1ivALm0SB/Z+pxr703KcM
         IsygtHIZq7vJQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Keith Busch <kbusch@kernel.org>, Minh Hoang <mh2022@meta.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        Sasha Levin <sashal@kernel.org>, james.smart@broadcom.com,
        linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 31/47] nvme: ensure reset state check ordering
Date:   Mon, 11 Dec 2023 08:50:32 -0500
Message-ID: <20231211135147.380223-31-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135147.380223-1-sashal@kernel.org>
References: <20231211135147.380223-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit e6e7f7ac03e40795346f1b2994a05f507ad8d345 ]

A different CPU may be setting the ctrl->state value, so ensure proper
barriers to prevent optimizing to a stale state. Normally it isn't a
problem to observe the wrong state as it is merely advisory to take a
quicker path during initialization and error recovery, but seeing an old
state can report unexpected ENETRESET errors when a reset request was in
fact successful.

Reported-by: Minh Hoang <mh2022@meta.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 42 +++++++++++++++++++++-------------------
 drivers/nvme/host/fc.c   |  6 +++---
 drivers/nvme/host/pci.c  | 14 +++++++-------
 drivers/nvme/host/rdma.c | 23 +++++++++++++---------
 drivers/nvme/host/tcp.c  | 27 ++++++++++++++++----------
 5 files changed, 63 insertions(+), 49 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c09048984a277..4e7bda7749caa 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -131,7 +131,7 @@ void nvme_queue_scan(struct nvme_ctrl *ctrl)
 	/*
 	 * Only new queue scan work when admin and IO queues are both alive
 	 */
-	if (ctrl->state == NVME_CTRL_LIVE && ctrl->tagset)
+	if (nvme_ctrl_state(ctrl) == NVME_CTRL_LIVE && ctrl->tagset)
 		queue_work(nvme_wq, &ctrl->scan_work);
 }
 
@@ -143,7 +143,7 @@ void nvme_queue_scan(struct nvme_ctrl *ctrl)
  */
 int nvme_try_sched_reset(struct nvme_ctrl *ctrl)
 {
-	if (ctrl->state != NVME_CTRL_RESETTING)
+	if (nvme_ctrl_state(ctrl) != NVME_CTRL_RESETTING)
 		return -EBUSY;
 	if (!queue_work(nvme_reset_wq, &ctrl->reset_work))
 		return -EBUSY;
@@ -156,7 +156,7 @@ static void nvme_failfast_work(struct work_struct *work)
 	struct nvme_ctrl *ctrl = container_of(to_delayed_work(work),
 			struct nvme_ctrl, failfast_work);
 
-	if (ctrl->state != NVME_CTRL_CONNECTING)
+	if (nvme_ctrl_state(ctrl) != NVME_CTRL_CONNECTING)
 		return;
 
 	set_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
@@ -200,7 +200,7 @@ int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl)
 	ret = nvme_reset_ctrl(ctrl);
 	if (!ret) {
 		flush_work(&ctrl->reset_work);
-		if (ctrl->state != NVME_CTRL_LIVE)
+		if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE)
 			ret = -ENETRESET;
 	}
 
@@ -499,7 +499,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 
 	spin_lock_irqsave(&ctrl->lock, flags);
 
-	old_state = ctrl->state;
+	old_state = nvme_ctrl_state(ctrl);
 	switch (new_state) {
 	case NVME_CTRL_LIVE:
 		switch (old_state) {
@@ -567,7 +567,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	}
 
 	if (changed) {
-		ctrl->state = new_state;
+		WRITE_ONCE(ctrl->state, new_state);
 		wake_up_all(&ctrl->state_wq);
 	}
 
@@ -575,11 +575,11 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	if (!changed)
 		return false;
 
-	if (ctrl->state == NVME_CTRL_LIVE) {
+	if (new_state == NVME_CTRL_LIVE) {
 		if (old_state == NVME_CTRL_CONNECTING)
 			nvme_stop_failfast_work(ctrl);
 		nvme_kick_requeue_lists(ctrl);
-	} else if (ctrl->state == NVME_CTRL_CONNECTING &&
+	} else if (new_state == NVME_CTRL_CONNECTING &&
 		old_state == NVME_CTRL_RESETTING) {
 		nvme_start_failfast_work(ctrl);
 	}
@@ -592,7 +592,7 @@ EXPORT_SYMBOL_GPL(nvme_change_ctrl_state);
  */
 static bool nvme_state_terminal(struct nvme_ctrl *ctrl)
 {
-	switch (ctrl->state) {
+	switch (nvme_ctrl_state(ctrl)) {
 	case NVME_CTRL_NEW:
 	case NVME_CTRL_LIVE:
 	case NVME_CTRL_RESETTING:
@@ -617,7 +617,7 @@ bool nvme_wait_reset(struct nvme_ctrl *ctrl)
 	wait_event(ctrl->state_wq,
 		   nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING) ||
 		   nvme_state_terminal(ctrl));
-	return ctrl->state == NVME_CTRL_RESETTING;
+	return nvme_ctrl_state(ctrl) == NVME_CTRL_RESETTING;
 }
 EXPORT_SYMBOL_GPL(nvme_wait_reset);
 
@@ -704,9 +704,11 @@ EXPORT_SYMBOL_GPL(nvme_init_request);
 blk_status_t nvme_fail_nonready_command(struct nvme_ctrl *ctrl,
 		struct request *rq)
 {
-	if (ctrl->state != NVME_CTRL_DELETING_NOIO &&
-	    ctrl->state != NVME_CTRL_DELETING &&
-	    ctrl->state != NVME_CTRL_DEAD &&
+	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
+
+	if (state != NVME_CTRL_DELETING_NOIO &&
+	    state != NVME_CTRL_DELETING &&
+	    state != NVME_CTRL_DEAD &&
 	    !test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags) &&
 	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
 		return BLK_STS_RESOURCE;
@@ -736,7 +738,7 @@ bool __nvme_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 		 * command, which is require to set the queue live in the
 		 * appropinquate states.
 		 */
-		switch (ctrl->state) {
+		switch (nvme_ctrl_state(ctrl)) {
 		case NVME_CTRL_CONNECTING:
 			if (blk_rq_is_passthrough(rq) && nvme_is_fabrics(req->cmd) &&
 			    (req->cmd->fabrics.fctype == nvme_fabrics_type_connect ||
@@ -2531,7 +2533,7 @@ static void nvme_set_latency_tolerance(struct device *dev, s32 val)
 
 	if (ctrl->ps_max_latency_us != latency) {
 		ctrl->ps_max_latency_us = latency;
-		if (ctrl->state == NVME_CTRL_LIVE)
+		if (nvme_ctrl_state(ctrl) == NVME_CTRL_LIVE)
 			nvme_configure_apst(ctrl);
 	}
 }
@@ -3217,7 +3219,7 @@ static int nvme_dev_open(struct inode *inode, struct file *file)
 	struct nvme_ctrl *ctrl =
 		container_of(inode->i_cdev, struct nvme_ctrl, cdev);
 
-	switch (ctrl->state) {
+	switch (nvme_ctrl_state(ctrl)) {
 	case NVME_CTRL_LIVE:
 		break;
 	default:
@@ -3903,7 +3905,7 @@ static void nvme_scan_work(struct work_struct *work)
 	int ret;
 
 	/* No tagset on a live ctrl means IO queues could not created */
-	if (ctrl->state != NVME_CTRL_LIVE || !ctrl->tagset)
+	if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE || !ctrl->tagset)
 		return;
 
 	/*
@@ -3973,7 +3975,7 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	 * removing the namespaces' disks; fail all the queues now to avoid
 	 * potentially having to clean up the failed sync later.
 	 */
-	if (ctrl->state == NVME_CTRL_DEAD)
+	if (nvme_ctrl_state(ctrl) == NVME_CTRL_DEAD)
 		nvme_mark_namespaces_dead(ctrl);
 
 	/* this is a no-op when called from the controller reset handler */
@@ -4055,7 +4057,7 @@ static void nvme_async_event_work(struct work_struct *work)
 	 * flushing ctrl async_event_work after changing the controller state
 	 * from LIVE and before freeing the admin queue.
 	*/
-	if (ctrl->state == NVME_CTRL_LIVE)
+	if (nvme_ctrl_state(ctrl) == NVME_CTRL_LIVE)
 		ctrl->ops->submit_async_event(ctrl);
 }
 
@@ -4439,7 +4441,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 {
 	int ret;
 
-	ctrl->state = NVME_CTRL_NEW;
+	WRITE_ONCE(ctrl->state, NVME_CTRL_NEW);
 	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
 	spin_lock_init(&ctrl->lock);
 	mutex_init(&ctrl->scan_lock);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index a15b37750d6e9..8ba8d1393535f 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -557,7 +557,7 @@ nvme_fc_rport_get(struct nvme_fc_rport *rport)
 static void
 nvme_fc_resume_controller(struct nvme_fc_ctrl *ctrl)
 {
-	switch (ctrl->ctrl.state) {
+	switch (nvme_ctrl_state(&ctrl->ctrl)) {
 	case NVME_CTRL_NEW:
 	case NVME_CTRL_CONNECTING:
 		/*
@@ -793,7 +793,7 @@ nvme_fc_ctrl_connectivity_loss(struct nvme_fc_ctrl *ctrl)
 		"NVME-FC{%d}: controller connectivity lost. Awaiting "
 		"Reconnect", ctrl->cnum);
 
-	switch (ctrl->ctrl.state) {
+	switch (nvme_ctrl_state(&ctrl->ctrl)) {
 	case NVME_CTRL_NEW:
 	case NVME_CTRL_LIVE:
 		/*
@@ -3316,7 +3316,7 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 	unsigned long recon_delay = ctrl->ctrl.opts->reconnect_delay * HZ;
 	bool recon = true;
 
-	if (ctrl->ctrl.state != NVME_CTRL_CONNECTING)
+	if (nvme_ctrl_state(&ctrl->ctrl) != NVME_CTRL_CONNECTING)
 		return;
 
 	if (portptr->port_state == FC_OBJSTATE_ONLINE) {
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3f0c9ee09a12b..0b4ee3164e660 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1234,7 +1234,7 @@ static bool nvme_should_reset(struct nvme_dev *dev, u32 csts)
 	bool nssro = dev->subsystem && (csts & NVME_CSTS_NSSRO);
 
 	/* If there is a reset/reinit ongoing, we shouldn't reset again. */
-	switch (dev->ctrl.state) {
+	switch (nvme_ctrl_state(&dev->ctrl)) {
 	case NVME_CTRL_RESETTING:
 	case NVME_CTRL_CONNECTING:
 		return false;
@@ -1322,7 +1322,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 	 * cancellation error. All outstanding requests are completed on
 	 * shutdown, so we return BLK_EH_DONE.
 	 */
-	switch (dev->ctrl.state) {
+	switch (nvme_ctrl_state(&dev->ctrl)) {
 	case NVME_CTRL_CONNECTING:
 		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
 		fallthrough;
@@ -1594,7 +1594,7 @@ static int nvme_setup_io_queues_trylock(struct nvme_dev *dev)
 	/*
 	 * Controller is in wrong state, fail early.
 	 */
-	if (dev->ctrl.state != NVME_CTRL_CONNECTING) {
+	if (nvme_ctrl_state(&dev->ctrl) != NVME_CTRL_CONNECTING) {
 		mutex_unlock(&dev->shutdown_lock);
 		return -ENODEV;
 	}
@@ -2574,13 +2574,13 @@ static bool nvme_pci_ctrl_is_dead(struct nvme_dev *dev)
 
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 {
+	enum nvme_ctrl_state state = nvme_ctrl_state(&dev->ctrl);
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	bool dead;
 
 	mutex_lock(&dev->shutdown_lock);
 	dead = nvme_pci_ctrl_is_dead(dev);
-	if (dev->ctrl.state == NVME_CTRL_LIVE ||
-	    dev->ctrl.state == NVME_CTRL_RESETTING) {
+	if (state == NVME_CTRL_LIVE || state == NVME_CTRL_RESETTING) {
 		if (pci_is_enabled(pdev))
 			nvme_start_freeze(&dev->ctrl);
 		/*
@@ -2691,7 +2691,7 @@ static void nvme_reset_work(struct work_struct *work)
 	bool was_suspend = !!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL);
 	int result;
 
-	if (dev->ctrl.state != NVME_CTRL_RESETTING) {
+	if (nvme_ctrl_state(&dev->ctrl) != NVME_CTRL_RESETTING) {
 		dev_warn(dev->ctrl.device, "ctrl state %d is not RESETTING\n",
 			 dev->ctrl.state);
 		result = -ENODEV;
@@ -3193,7 +3193,7 @@ static int nvme_suspend(struct device *dev)
 	nvme_wait_freeze(ctrl);
 	nvme_sync_queues(ctrl);
 
-	if (ctrl->state != NVME_CTRL_LIVE)
+	if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE)
 		goto unfreeze;
 
 	/*
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index a7fea4cbacd75..c04317a966b38 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -984,10 +984,11 @@ static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 
 static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl)
 {
+	enum nvme_ctrl_state state = nvme_ctrl_state(&ctrl->ctrl);
+
 	/* If we are resetting/deleting then do nothing */
-	if (ctrl->ctrl.state != NVME_CTRL_CONNECTING) {
-		WARN_ON_ONCE(ctrl->ctrl.state == NVME_CTRL_NEW ||
-			ctrl->ctrl.state == NVME_CTRL_LIVE);
+	if (state != NVME_CTRL_CONNECTING) {
+		WARN_ON_ONCE(state == NVME_CTRL_NEW || state == NVME_CTRL_LIVE);
 		return;
 	}
 
@@ -1059,8 +1060,10 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 		 * unless we're during creation of a new controller to
 		 * avoid races with teardown flow.
 		 */
-		WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETING &&
-			     ctrl->ctrl.state != NVME_CTRL_DELETING_NOIO);
+		enum nvme_ctrl_state state = nvme_ctrl_state(&ctrl->ctrl);
+
+		WARN_ON_ONCE(state != NVME_CTRL_DELETING &&
+			     state != NVME_CTRL_DELETING_NOIO);
 		WARN_ON_ONCE(new);
 		ret = -EINVAL;
 		goto destroy_io;
@@ -1128,8 +1131,10 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
 		/* state change failure is ok if we started ctrl delete */
-		WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETING &&
-			     ctrl->ctrl.state != NVME_CTRL_DELETING_NOIO);
+		enum nvme_ctrl_state state = nvme_ctrl_state(&ctrl->ctrl);
+
+		WARN_ON_ONCE(state != NVME_CTRL_DELETING &&
+			     state != NVME_CTRL_DELETING_NOIO);
 		return;
 	}
 
@@ -1161,7 +1166,7 @@ static void nvme_rdma_wr_error(struct ib_cq *cq, struct ib_wc *wc,
 	struct nvme_rdma_queue *queue = wc->qp->qp_context;
 	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
 
-	if (ctrl->ctrl.state == NVME_CTRL_LIVE)
+	if (nvme_ctrl_state(&ctrl->ctrl) == NVME_CTRL_LIVE)
 		dev_info(ctrl->ctrl.device,
 			     "%s for CQE 0x%p failed with status %s (%d)\n",
 			     op, wc->wr_cqe,
@@ -1944,7 +1949,7 @@ static enum blk_eh_timer_return nvme_rdma_timeout(struct request *rq)
 	dev_warn(ctrl->ctrl.device, "I/O %d QID %d timeout\n",
 		 rq->tag, nvme_rdma_queue_idx(queue));
 
-	if (ctrl->ctrl.state != NVME_CTRL_LIVE) {
+	if (nvme_ctrl_state(&ctrl->ctrl) != NVME_CTRL_LIVE) {
 		/*
 		 * If we are resetting, connecting or deleting we should
 		 * complete immediately because we may block controller
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 5b332d9f87fc3..f1d62d74426f0 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1993,10 +1993,11 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 
 static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
 {
+	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
+
 	/* If we are resetting/deleting then do nothing */
-	if (ctrl->state != NVME_CTRL_CONNECTING) {
-		WARN_ON_ONCE(ctrl->state == NVME_CTRL_NEW ||
-			ctrl->state == NVME_CTRL_LIVE);
+	if (state != NVME_CTRL_CONNECTING) {
+		WARN_ON_ONCE(state == NVME_CTRL_NEW || state == NVME_CTRL_LIVE);
 		return;
 	}
 
@@ -2056,8 +2057,10 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 		 * unless we're during creation of a new controller to
 		 * avoid races with teardown flow.
 		 */
-		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
-			     ctrl->state != NVME_CTRL_DELETING_NOIO);
+		enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
+
+		WARN_ON_ONCE(state != NVME_CTRL_DELETING &&
+			     state != NVME_CTRL_DELETING_NOIO);
 		WARN_ON_ONCE(new);
 		ret = -EINVAL;
 		goto destroy_io;
@@ -2124,8 +2127,10 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
 		/* state change failure is ok if we started ctrl delete */
-		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
-			     ctrl->state != NVME_CTRL_DELETING_NOIO);
+		enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
+
+		WARN_ON_ONCE(state != NVME_CTRL_DELETING &&
+			     state != NVME_CTRL_DELETING_NOIO);
 		return;
 	}
 
@@ -2155,8 +2160,10 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
 		/* state change failure is ok if we started ctrl delete */
-		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
-			     ctrl->state != NVME_CTRL_DELETING_NOIO);
+		enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
+
+		WARN_ON_ONCE(state != NVME_CTRL_DELETING &&
+			     state != NVME_CTRL_DELETING_NOIO);
 		return;
 	}
 
@@ -2274,7 +2281,7 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
 		nvme_tcp_queue_id(req->queue), nvme_cid(rq), pdu->hdr.type,
 		opc, nvme_opcode_str(qid, opc, fctype));
 
-	if (ctrl->state != NVME_CTRL_LIVE) {
+	if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE) {
 		/*
 		 * If we are resetting, connecting or deleting we should
 		 * complete immediately because we may block controller
-- 
2.42.0

