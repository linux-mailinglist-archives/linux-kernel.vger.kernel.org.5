Return-Path: <linux-kernel+bounces-68264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1D98577F2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282791F231AB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDCF1DFEC;
	Fri, 16 Feb 2024 08:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kYf5PqOc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YtqxCydH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kYf5PqOc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YtqxCydH"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC091BC3E
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708073147; cv=none; b=IS5GHqLz6fAhHwxy7n1XirM0l8G3ncwmM1aEimxJkjUSKNrn0Y8DmGAAZufpiSMZ/HIslsSNPim9q6pZwGT9QFRgBvM6XCBh+jJYnnt5nDpJLDbssf+siVPHQa//2lqTzAknrqPkP3JPURPrfH/aSLz//2HukpBd35WgnfOaYuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708073147; c=relaxed/simple;
	bh=ZQqWgSE8R5Qshr1qfw0l31ynIeWNLu5UYlIa9dfmPDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJAa8c6+v9HhfOxYKdZqFC/3EAm+XSaboV+KFpiZAO+WBcxjDIYQ/y3zyUbG5qM5zZjudbdj2M+Q8xUUMN21vBvriXcHsup6brrx1b5J3b8OL9ydo/n2h0GTTLtYVMsPCpAQ0GiXvZrdDJPopj460vxOdpbiz4ghwuq89+/HQsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kYf5PqOc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YtqxCydH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kYf5PqOc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YtqxCydH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 000601FB5B;
	Fri, 16 Feb 2024 08:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708073142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KOMF03VoR44oi8HBDybO4VHaz2uWr0tXKdQfzeE88jU=;
	b=kYf5PqOcqoHsPCA/qVHThVdNHh3ePxwkMACcTtEupis528qr+jTGO4k+0e48VNtEG8ck6y
	pBB9vJFbWYbGruvzodR6oGscuU78WsbHfTI1GMZ8rkSGxhnKIMNB3Zna7yFK/8dBaTQzYp
	nqQ7I1RLi4wO1+5t00hCKZSXjKaAy9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708073142;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KOMF03VoR44oi8HBDybO4VHaz2uWr0tXKdQfzeE88jU=;
	b=YtqxCydHQhlozWU3aHBNT/6zHHzsTimDCx+z1JUUUAsnDJKDl/2EL1k7ma1ptu34w6Ww41
	e3rC6Iq8o8WqLBDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708073142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KOMF03VoR44oi8HBDybO4VHaz2uWr0tXKdQfzeE88jU=;
	b=kYf5PqOcqoHsPCA/qVHThVdNHh3ePxwkMACcTtEupis528qr+jTGO4k+0e48VNtEG8ck6y
	pBB9vJFbWYbGruvzodR6oGscuU78WsbHfTI1GMZ8rkSGxhnKIMNB3Zna7yFK/8dBaTQzYp
	nqQ7I1RLi4wO1+5t00hCKZSXjKaAy9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708073142;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KOMF03VoR44oi8HBDybO4VHaz2uWr0tXKdQfzeE88jU=;
	b=YtqxCydHQhlozWU3aHBNT/6zHHzsTimDCx+z1JUUUAsnDJKDl/2EL1k7ma1ptu34w6Ww41
	e3rC6Iq8o8WqLBDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E0F4013343;
	Fri, 16 Feb 2024 08:45:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id w2dyNbUgz2WicwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Fri, 16 Feb 2024 08:45:41 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v0 5/6] nvme-fc: redesign locking and refcounting
Date: Fri, 16 Feb 2024 09:45:25 +0100
Message-ID: <20240216084526.14133-6-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216084526.14133-1-dwagner@suse.de>
References: <20240216084526.14133-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

The life time of the controller is managed by the upper layers.

Thus just ref counting the controller when creating it and giving the
ref back on the cleanup path. This is how the other transport are
managed as well. Until now, the ref count has been taken per LS request
which is not really necessary as the core guarantees that there is no in
flight request when shuting down (if we use the nvme APIs are used
correctly).

In fact we don't really need the ref count for nvme_fc_ctrl at this
point. Though, the FC transport is offloading the connect attempt to a
workqueue and in the next patch we introduce a sync option for which the
ref counter is necessary. So let's keep it around.

Also take a ref for lport and rport when creating the controller and
give it back when we destroy the controller. This means these refs are
tied to the life time of the controller and not the other way around.

We have also to reorder the cleanup code in nvme_fc_delete_ctrl and
nvme_fc_free_ctrl so that we do not expose resources too long and run
into use after free situations which are currently possible.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fc.c | 136 +++++++++++++----------------------------
 1 file changed, 41 insertions(+), 95 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index ddbc5b21af5b..7f9edab57550 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -229,6 +229,9 @@ static struct device *fc_udev_device;
 
 static void nvme_fc_complete_rq(struct request *rq);
 
+static void nvme_fc_ctrl_put(struct nvme_fc_ctrl *);
+static int nvme_fc_ctrl_get(struct nvme_fc_ctrl *);
+
 /* *********************** FC-NVME Port Management ************************ */
 
 static void __nvme_fc_delete_hw_queue(struct nvme_fc_ctrl *,
@@ -800,7 +803,7 @@ nvme_fc_ctrl_connectivity_loss(struct nvme_fc_ctrl *ctrl)
 			dev_warn(ctrl->ctrl.device,
 				"NVME-FC{%d}: Couldn't schedule reset.\n",
 				ctrl->cnum);
-			nvme_delete_ctrl(&ctrl->ctrl);
+			nvme_fc_ctrl_put(ctrl);
 		}
 		break;
 
@@ -868,7 +871,7 @@ nvme_fc_unregister_remoteport(struct nvme_fc_remote_port *portptr)
 			dev_warn(ctrl->ctrl.device,
 				"NVME-FC{%d}: controller connectivity lost.\n",
 				ctrl->cnum);
-			nvme_delete_ctrl(&ctrl->ctrl);
+			nvme_fc_ctrl_put(ctrl);
 		} else
 			nvme_fc_ctrl_connectivity_loss(ctrl);
 	}
@@ -1022,9 +1025,6 @@ fc_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
 
 /* *********************** FC-NVME LS Handling **************************** */
 
-static void nvme_fc_ctrl_put(struct nvme_fc_ctrl *);
-static int nvme_fc_ctrl_get(struct nvme_fc_ctrl *);
-
 static void nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg);
 
 static void
@@ -1050,8 +1050,6 @@ __nvme_fc_finish_ls_req(struct nvmefc_ls_req_op *lsop)
 	fc_dma_unmap_single(rport->dev, lsreq->rqstdma,
 				  (lsreq->rqstlen + lsreq->rsplen),
 				  DMA_BIDIRECTIONAL);
-
-	nvme_fc_rport_put(rport);
 }
 
 static int
@@ -1066,9 +1064,6 @@ __nvme_fc_send_ls_req(struct nvme_fc_rport *rport,
 	if (rport->remoteport.port_state != FC_OBJSTATE_ONLINE)
 		return -ECONNREFUSED;
 
-	if (!nvme_fc_rport_get(rport))
-		return -ESHUTDOWN;
-
 	lsreq->done = done;
 	lsop->rport = rport;
 	lsop->req_queued = false;
@@ -1078,10 +1073,8 @@ __nvme_fc_send_ls_req(struct nvme_fc_rport *rport,
 	lsreq->rqstdma = fc_dma_map_single(rport->dev, lsreq->rqstaddr,
 				  lsreq->rqstlen + lsreq->rsplen,
 				  DMA_BIDIRECTIONAL);
-	if (fc_dma_mapping_error(rport->dev, lsreq->rqstdma)) {
-		ret = -EFAULT;
-		goto out_putrport;
-	}
+	if (fc_dma_mapping_error(rport->dev, lsreq->rqstdma))
+		return -EFAULT;
 	lsreq->rspdma = lsreq->rqstdma + lsreq->rqstlen;
 
 	spin_lock_irqsave(&rport->lock, flags);
@@ -1108,9 +1101,6 @@ __nvme_fc_send_ls_req(struct nvme_fc_rport *rport,
 	fc_dma_unmap_single(rport->dev, lsreq->rqstdma,
 				  (lsreq->rqstlen + lsreq->rsplen),
 				  DMA_BIDIRECTIONAL);
-out_putrport:
-	nvme_fc_rport_put(rport);
-
 	return ret;
 }
 
@@ -1471,8 +1461,6 @@ nvme_fc_xmt_ls_rsp_done(struct nvmefc_ls_rsp *lsrsp)
 	kfree(lsop->rspbuf);
 	kfree(lsop->rqstbuf);
 	kfree(lsop);
-
-	nvme_fc_rport_put(rport);
 }
 
 static void
@@ -1511,8 +1499,6 @@ nvme_fc_match_disconn_ls(struct nvme_fc_rport *rport,
 	spin_lock_irqsave(&rport->lock, flags);
 
 	list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list) {
-		if (!nvme_fc_ctrl_get(ctrl))
-			continue;
 		spin_lock(&ctrl->lock);
 		if (association_id == ctrl->association_id) {
 			oldls = ctrl->rcv_disconn;
@@ -1520,10 +1506,6 @@ nvme_fc_match_disconn_ls(struct nvme_fc_rport *rport,
 			ret = ctrl;
 		}
 		spin_unlock(&ctrl->lock);
-		if (ret)
-			/* leave the ctrl get reference */
-			break;
-		nvme_fc_ctrl_put(ctrl);
 	}
 
 	spin_unlock_irqrestore(&rport->lock, flags);
@@ -1602,9 +1584,6 @@ nvme_fc_ls_disconnect_assoc(struct nvmefc_ls_rcv_op *lsop)
 	/* fail the association */
 	nvme_fc_error_recovery(ctrl, "Disconnect Association LS received");
 
-	/* release the reference taken by nvme_fc_match_disconn_ls() */
-	nvme_fc_ctrl_put(ctrl);
-
 	return false;
 }
 
@@ -1734,16 +1713,13 @@ nvme_fc_rcv_ls_req(struct nvme_fc_remote_port *portptr,
 	unsigned long flags;
 	int ret;
 
-	nvme_fc_rport_get(rport);
-
 	/* validate there's a routine to transmit a response */
 	if (!lport->ops->xmt_ls_rsp) {
 		dev_info(lport->dev,
 			"RCV %s LS failed: no LLDD xmt_ls_rsp\n",
 			(w0->ls_cmd <= NVME_FC_LAST_LS_CMD_VALUE) ?
 				nvmefc_ls_names[w0->ls_cmd] : "");
-		ret = -EINVAL;
-		goto out_put;
+		return -EINVAL;
 	}
 
 	if (lsreqbuf_len > sizeof(union nvmefc_ls_requests)) {
@@ -1751,15 +1727,13 @@ nvme_fc_rcv_ls_req(struct nvme_fc_remote_port *portptr,
 			"RCV %s LS failed: payload too large\n",
 			(w0->ls_cmd <= NVME_FC_LAST_LS_CMD_VALUE) ?
 				nvmefc_ls_names[w0->ls_cmd] : "");
-		ret = -E2BIG;
-		goto out_put;
+		return -E2BIG;
 	}
 
 	lsop = kzalloc(sizeof(*lsop), GFP_KERNEL);
 	if (!lsop) {
 		nvme_fc_rcv_ls_req_err_msg(lport, w0);
-		ret = -ENOMEM;
-		goto out_put;
+		return -ENOMEM;
 	}
 
 	lsop->rqstbuf = kzalloc(sizeof(*lsop->rqstbuf), GFP_KERNEL);
@@ -1808,8 +1782,6 @@ nvme_fc_rcv_ls_req(struct nvme_fc_remote_port *portptr,
 	kfree(lsop->rspbuf);
 	kfree(lsop->rqstbuf);
 	kfree(lsop);
-out_put:
-	nvme_fc_rport_put(rport);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_fc_rcv_ls_req);
@@ -2071,7 +2043,6 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 		__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
 		atomic_set(&op->state, FCPOP_STATE_IDLE);
 		op->flags = FCOP_FLAGS_AEN;	/* clear other flags */
-		nvme_fc_ctrl_put(ctrl);
 		goto check_error;
 	}
 
@@ -2383,37 +2354,18 @@ nvme_fc_init_io_queues(struct nvme_fc_ctrl *ctrl)
 }
 
 static void
-nvme_fc_ctrl_free(struct kref *ref)
+nvme_fc_ctrl_delete(struct kref *ref)
 {
 	struct nvme_fc_ctrl *ctrl =
 		container_of(ref, struct nvme_fc_ctrl, ref);
-	unsigned long flags;
-
-	if (ctrl->ctrl.tagset)
-		nvme_remove_io_tag_set(&ctrl->ctrl);
-
-	/* remove from rport list */
-	spin_lock_irqsave(&ctrl->rport->lock, flags);
-	list_del(&ctrl->ctrl_list);
-	spin_unlock_irqrestore(&ctrl->rport->lock, flags);
-
-	nvme_unquiesce_admin_queue(&ctrl->ctrl);
-	nvme_remove_admin_tag_set(&ctrl->ctrl);
-
-	kfree(ctrl->queues);
-
-	put_device(ctrl->dev);
-	nvme_fc_rport_put(ctrl->rport);
 
-	ida_free(&nvme_fc_ctrl_cnt, ctrl->cnum);
-	nvmf_ctrl_options_put(ctrl->ctrl.opts);
-	kfree(ctrl);
+	nvme_delete_ctrl(&ctrl->ctrl);
 }
 
 static void
 nvme_fc_ctrl_put(struct nvme_fc_ctrl *ctrl)
 {
-	kref_put(&ctrl->ref, nvme_fc_ctrl_free);
+	kref_put(&ctrl->ref, nvme_fc_ctrl_delete);
 }
 
 static int
@@ -2431,9 +2383,18 @@ nvme_fc_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
 
-	WARN_ON(nctrl != &ctrl->ctrl);
 
-	nvme_fc_ctrl_put(ctrl);
+	if (ctrl->ctrl.tagset)
+		nvme_remove_io_tag_set(&ctrl->ctrl);
+
+	nvme_unquiesce_admin_queue(&ctrl->ctrl);
+	nvme_remove_admin_tag_set(&ctrl->ctrl);
+
+	kfree(ctrl->queues);
+
+	ida_free(&nvme_fc_ctrl_cnt, ctrl->cnum);
+	nvmf_ctrl_options_put(ctrl->ctrl.opts);
+	kfree(ctrl);
 }
 
 /*
@@ -2682,9 +2643,6 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 	if (ctrl->rport->remoteport.port_state != FC_OBJSTATE_ONLINE)
 		return BLK_STS_RESOURCE;
 
-	if (!nvme_fc_ctrl_get(ctrl))
-		return BLK_STS_IOERR;
-
 	/* format the FC-NVME CMD IU and fcp_req */
 	cmdiu->connection_id = cpu_to_be64(queue->connection_id);
 	cmdiu->data_len = cpu_to_be32(data_len);
@@ -2729,7 +2687,6 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 		ret = nvme_fc_map_data(ctrl, op->rq, op);
 		if (ret < 0) {
 			nvme_cleanup_cmd(op->rq);
-			nvme_fc_ctrl_put(ctrl);
 			if (ret == -ENOMEM || ret == -EAGAIN)
 				return BLK_STS_RESOURCE;
 			return BLK_STS_IOERR;
@@ -2770,8 +2727,6 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 			nvme_cleanup_cmd(op->rq);
 		}
 
-		nvme_fc_ctrl_put(ctrl);
-
 		if (ctrl->rport->remoteport.port_state == FC_OBJSTATE_ONLINE &&
 				ret != -EBUSY)
 			return BLK_STS_IOERR;
@@ -2855,7 +2810,6 @@ nvme_fc_complete_rq(struct request *rq)
 
 	nvme_fc_unmap_data(ctrl, rq, op);
 	nvme_complete_rq(rq);
-	nvme_fc_ctrl_put(ctrl);
 }
 
 static void nvme_fc_map_queues(struct blk_mq_tag_set *set)
@@ -3284,14 +3238,24 @@ static void
 nvme_fc_delete_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
+	unsigned long flags;
 
 	cancel_work_sync(&ctrl->ioerr_work);
 	cancel_delayed_work_sync(&ctrl->connect_work);
+
+	/* remove from rport list */
+	spin_lock_irqsave(&ctrl->rport->lock, flags);
+	list_del(&ctrl->ctrl_list);
+	spin_unlock_irqrestore(&ctrl->rport->lock, flags);
+
 	/*
 	 * kill the association on the link side.  this will block
 	 * waiting for io to terminate
 	 */
 	nvme_fc_delete_association(ctrl);
+
+	nvme_fc_rport_put(ctrl->rport);
+	nvme_fc_lport_put(ctrl->lport);
 }
 
 static void
@@ -3344,7 +3308,7 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 				ctrl->cnum, min_t(int, portptr->dev_loss_tmo,
 					(ctrl->ctrl.opts->max_reconnects *
 					 ctrl->ctrl.opts->reconnect_delay)));
-		WARN_ON(nvme_delete_ctrl(&ctrl->ctrl));
+		nvme_fc_ctrl_put(ctrl);
 	}
 }
 
@@ -3502,12 +3466,13 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	INIT_LIST_HEAD(&ctrl->ctrl_list);
 	ctrl->lport = lport;
 	ctrl->rport = rport;
+	nvme_fc_lport_get(lport);
+	nvme_fc_rport_get(rport);
 	ctrl->dev = lport->dev;
 	ctrl->cnum = idx;
 	ctrl->ioq_live = false;
 	init_waitqueue_head(&ctrl->ioabort_wait);
 
-	get_device(ctrl->dev);
 	kref_init(&ctrl->ref);
 
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_fc_reset_ctrl_work);
@@ -3582,32 +3547,13 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	return &ctrl->ctrl;
 
 fail_ctrl:
-	nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETING);
-	cancel_work_sync(&ctrl->ioerr_work);
-	cancel_work_sync(&ctrl->ctrl.reset_work);
-	cancel_delayed_work_sync(&ctrl->connect_work);
-
-	/* initiate nvme ctrl ref counting teardown */
-	nvme_uninit_ctrl(&ctrl->ctrl);
-
-	/* Remove core ctrl ref. */
-	nvme_put_ctrl(&ctrl->ctrl);
-
-	/* as we're past the point where we transition to the ref
-	 * counting teardown path, if we return a bad pointer here,
-	 * the calling routine, thinking it's prior to the
-	 * transition, will do an rport put. Since the teardown
-	 * path also does a rport put, we do an extra get here to
-	 * so proper order/teardown happens.
-	 */
-	nvme_fc_rport_get(rport);
+	nvme_fc_ctrl_put(ctrl);
 
 	return ERR_PTR(-EIO);
 
 out_free_queues:
 	kfree(ctrl->queues);
 out_free_ida:
-	put_device(ctrl->dev);
 	ida_free(&nvme_fc_ctrl_cnt, ctrl->cnum);
 out_free_opts:
 	nvmf_ctrl_options_put(opts);
@@ -3724,8 +3670,8 @@ nvme_fc_create_ctrl(struct device *dev, struct nvmf_ctrl_options *opts)
 			spin_unlock_irqrestore(&nvme_fc_lock, flags);
 
 			ctrl = nvme_fc_init_ctrl(dev, opts, lport, rport);
-			if (IS_ERR(ctrl))
-				nvme_fc_rport_put(rport);
+			nvme_fc_rport_put(rport);
+
 			return ctrl;
 		}
 	}
@@ -3950,7 +3896,7 @@ nvme_fc_delete_controllers(struct nvme_fc_rport *rport)
 		dev_warn(ctrl->ctrl.device,
 			"NVME-FC{%d}: transport unloading: deleting ctrl\n",
 			ctrl->cnum);
-		nvme_delete_ctrl(&ctrl->ctrl);
+		nvme_fc_ctrl_put(ctrl);
 	}
 	spin_unlock(&rport->lock);
 }
-- 
2.43.0


