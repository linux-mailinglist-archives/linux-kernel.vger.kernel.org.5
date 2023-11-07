Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D347D7E4516
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344373AbjKGQBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344467AbjKGP7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:59:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAE0729A;
        Tue,  7 Nov 2023 07:51:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037E8C433CA;
        Tue,  7 Nov 2023 15:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372316;
        bh=rTJbUZVQ+Cm2dTze9P7sJg+z/3v13akRmZ7fwzN9wfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ACJzaKTEbLD3E5QodrgZoOJQ9OVDypbArHTODDvXlEHxhOwIgXiryMVrzRrc26xEj
         DI2/0vP3DFET7st/PgEowCodaYE16qmc2rjd8au3O152/QS3jzP+cLY2P2MNu6jGBW
         xPkYd9WvQFXsu0w+1+BPvesN8aPwcPpqbxoGqLHz6ly0aOJddr7aScu+yOB0ngZWkG
         ft7rqeK9FSgpYIFraZoGYRz9a1OHmSq6xMdTQUqns3OWkeg3ngOiiTwe2KRVhp4e0T
         FYd/c+uZ+5JOLkm+919HjDYPSp0/evecZcZlMZavUTfPdync96JjQZywRz7BRVW0SY
         xSQXBLjqsef3Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, mpe@ellerman.id.au,
        jejb@linux.ibm.com, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.15 05/22] scsi: ibmvfc: Remove BUG_ON in the case of an empty event pool
Date:   Tue,  7 Nov 2023 10:51:14 -0500
Message-ID: <20231107155146.3767610-5-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155146.3767610-1-sashal@kernel.org>
References: <20231107155146.3767610-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.137
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tyrel Datwyler <tyreld@linux.ibm.com>

[ Upstream commit b39f2d10b86d0af353ea339e5815820026bca48f ]

In practice the driver should never send more commands than are allocated
to a queue's event pool. In the unlikely event that this happens, the code
asserts a BUG_ON, and in the case that the kernel is not configured to
crash on panic returns a junk event pointer from the empty event list
causing things to spiral from there. This BUG_ON is a historical artifact
of the ibmvfc driver first being upstreamed, and it is well known now that
the use of BUG_ON is bad practice except in the most unrecoverable
scenario. There is nothing about this scenario that prevents the driver
from recovering and carrying on.

Remove the BUG_ON in question from ibmvfc_get_event() and return a NULL
pointer in the case of an empty event pool. Update all call sites to
ibmvfc_get_event() to check for a NULL pointer and perfrom the appropriate
failure or recovery action.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
Link: https://lore.kernel.org/r/20230921225435.3537728-2-tyreld@linux.ibm.com
Reviewed-by: Brian King <brking@linux.vnet.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 124 ++++++++++++++++++++++++++++++++-
 1 file changed, 122 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index 45ef78f388dc9..e1895686987f0 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -1519,7 +1519,11 @@ static struct ibmvfc_event *ibmvfc_get_event(struct ibmvfc_queue *queue)
 	unsigned long flags;
 
 	spin_lock_irqsave(&queue->l_lock, flags);
-	BUG_ON(list_empty(&queue->free));
+	if (list_empty(&queue->free)) {
+		ibmvfc_log(queue->vhost, 4, "empty event pool on queue:%ld\n", queue->hwq_id);
+		spin_unlock_irqrestore(&queue->l_lock, flags);
+		return NULL;
+	}
 	evt = list_entry(queue->free.next, struct ibmvfc_event, queue_list);
 	atomic_set(&evt->free, 0);
 	list_del(&evt->queue_list);
@@ -1948,9 +1952,15 @@ static int ibmvfc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *cmnd)
 	if (vhost->using_channels) {
 		scsi_channel = hwq % vhost->scsi_scrqs.active_queues;
 		evt = ibmvfc_get_event(&vhost->scsi_scrqs.scrqs[scsi_channel]);
+		if (!evt)
+			return SCSI_MLQUEUE_HOST_BUSY;
+
 		evt->hwq = hwq % vhost->scsi_scrqs.active_queues;
-	} else
+	} else {
 		evt = ibmvfc_get_event(&vhost->crq);
+		if (!evt)
+			return SCSI_MLQUEUE_HOST_BUSY;
+	}
 
 	ibmvfc_init_event(evt, ibmvfc_scsi_done, IBMVFC_CMD_FORMAT);
 	evt->cmnd = cmnd;
@@ -2038,6 +2048,11 @@ static int ibmvfc_bsg_timeout(struct bsg_job *job)
 
 	vhost->aborting_passthru = 1;
 	evt = ibmvfc_get_event(&vhost->crq);
+	if (!evt) {
+		spin_unlock_irqrestore(vhost->host->host_lock, flags);
+		return -ENOMEM;
+	}
+
 	ibmvfc_init_event(evt, ibmvfc_bsg_timeout_done, IBMVFC_MAD_FORMAT);
 
 	tmf = &evt->iu.tmf;
@@ -2096,6 +2111,10 @@ static int ibmvfc_bsg_plogi(struct ibmvfc_host *vhost, unsigned int port_id)
 		goto unlock_out;
 
 	evt = ibmvfc_get_event(&vhost->crq);
+	if (!evt) {
+		rc = -ENOMEM;
+		goto unlock_out;
+	}
 	ibmvfc_init_event(evt, ibmvfc_sync_completion, IBMVFC_MAD_FORMAT);
 	plogi = &evt->iu.plogi;
 	memset(plogi, 0, sizeof(*plogi));
@@ -2214,6 +2233,11 @@ static int ibmvfc_bsg_request(struct bsg_job *job)
 	}
 
 	evt = ibmvfc_get_event(&vhost->crq);
+	if (!evt) {
+		spin_unlock_irqrestore(vhost->host->host_lock, flags);
+		rc = -ENOMEM;
+		goto out;
+	}
 	ibmvfc_init_event(evt, ibmvfc_sync_completion, IBMVFC_MAD_FORMAT);
 	mad = &evt->iu.passthru;
 
@@ -2302,6 +2326,11 @@ static int ibmvfc_reset_device(struct scsi_device *sdev, int type, char *desc)
 		else
 			evt = ibmvfc_get_event(&vhost->crq);
 
+		if (!evt) {
+			spin_unlock_irqrestore(vhost->host->host_lock, flags);
+			return -ENOMEM;
+		}
+
 		ibmvfc_init_event(evt, ibmvfc_sync_completion, IBMVFC_CMD_FORMAT);
 		tmf = ibmvfc_init_vfc_cmd(evt, sdev);
 		iu = ibmvfc_get_fcp_iu(vhost, tmf);
@@ -2505,6 +2534,8 @@ static struct ibmvfc_event *ibmvfc_init_tmf(struct ibmvfc_queue *queue,
 	struct ibmvfc_tmf *tmf;
 
 	evt = ibmvfc_get_event(queue);
+	if (!evt)
+		return NULL;
 	ibmvfc_init_event(evt, ibmvfc_sync_completion, IBMVFC_MAD_FORMAT);
 
 	tmf = &evt->iu.tmf;
@@ -2561,6 +2592,11 @@ static int ibmvfc_cancel_all_mq(struct scsi_device *sdev, int type)
 
 		if (found_evt && vhost->logged_in) {
 			evt = ibmvfc_init_tmf(&queues[i], sdev, type);
+			if (!evt) {
+				spin_unlock(queues[i].q_lock);
+				spin_unlock_irqrestore(vhost->host->host_lock, flags);
+				return -ENOMEM;
+			}
 			evt->sync_iu = &queues[i].cancel_rsp;
 			ibmvfc_send_event(evt, vhost, default_timeout);
 			list_add_tail(&evt->cancel, &cancelq);
@@ -2774,6 +2810,10 @@ static int ibmvfc_abort_task_set(struct scsi_device *sdev)
 
 	if (vhost->state == IBMVFC_ACTIVE) {
 		evt = ibmvfc_get_event(&vhost->crq);
+		if (!evt) {
+			spin_unlock_irqrestore(vhost->host->host_lock, flags);
+			return -ENOMEM;
+		}
 		ibmvfc_init_event(evt, ibmvfc_sync_completion, IBMVFC_CMD_FORMAT);
 		tmf = ibmvfc_init_vfc_cmd(evt, sdev);
 		iu = ibmvfc_get_fcp_iu(vhost, tmf);
@@ -4030,6 +4070,12 @@ static void ibmvfc_tgt_send_prli(struct ibmvfc_target *tgt)
 
 	kref_get(&tgt->kref);
 	evt = ibmvfc_get_event(&vhost->crq);
+	if (!evt) {
+		ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_NONE);
+		kref_put(&tgt->kref, ibmvfc_release_tgt);
+		__ibmvfc_reset_host(vhost);
+		return;
+	}
 	vhost->discovery_threads++;
 	ibmvfc_init_event(evt, ibmvfc_tgt_prli_done, IBMVFC_MAD_FORMAT);
 	evt->tgt = tgt;
@@ -4137,6 +4183,12 @@ static void ibmvfc_tgt_send_plogi(struct ibmvfc_target *tgt)
 	kref_get(&tgt->kref);
 	tgt->logo_rcvd = 0;
 	evt = ibmvfc_get_event(&vhost->crq);
+	if (!evt) {
+		ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_NONE);
+		kref_put(&tgt->kref, ibmvfc_release_tgt);
+		__ibmvfc_reset_host(vhost);
+		return;
+	}
 	vhost->discovery_threads++;
 	ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_INIT_WAIT);
 	ibmvfc_init_event(evt, ibmvfc_tgt_plogi_done, IBMVFC_MAD_FORMAT);
@@ -4213,6 +4265,8 @@ static struct ibmvfc_event *__ibmvfc_tgt_get_implicit_logout_evt(struct ibmvfc_t
 
 	kref_get(&tgt->kref);
 	evt = ibmvfc_get_event(&vhost->crq);
+	if (!evt)
+		return NULL;
 	ibmvfc_init_event(evt, done, IBMVFC_MAD_FORMAT);
 	evt->tgt = tgt;
 	mad = &evt->iu.implicit_logout;
@@ -4240,6 +4294,13 @@ static void ibmvfc_tgt_implicit_logout(struct ibmvfc_target *tgt)
 	vhost->discovery_threads++;
 	evt = __ibmvfc_tgt_get_implicit_logout_evt(tgt,
 						   ibmvfc_tgt_implicit_logout_done);
+	if (!evt) {
+		vhost->discovery_threads--;
+		ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_NONE);
+		kref_put(&tgt->kref, ibmvfc_release_tgt);
+		__ibmvfc_reset_host(vhost);
+		return;
+	}
 
 	ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_INIT_WAIT);
 	if (ibmvfc_send_event(evt, vhost, default_timeout)) {
@@ -4379,6 +4440,12 @@ static void ibmvfc_tgt_move_login(struct ibmvfc_target *tgt)
 
 	kref_get(&tgt->kref);
 	evt = ibmvfc_get_event(&vhost->crq);
+	if (!evt) {
+		ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_DEL_RPORT);
+		kref_put(&tgt->kref, ibmvfc_release_tgt);
+		__ibmvfc_reset_host(vhost);
+		return;
+	}
 	vhost->discovery_threads++;
 	ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_INIT_WAIT);
 	ibmvfc_init_event(evt, ibmvfc_tgt_move_login_done, IBMVFC_MAD_FORMAT);
@@ -4545,6 +4612,14 @@ static void ibmvfc_adisc_timeout(struct timer_list *t)
 	vhost->abort_threads++;
 	kref_get(&tgt->kref);
 	evt = ibmvfc_get_event(&vhost->crq);
+	if (!evt) {
+		tgt_err(tgt, "Failed to get cancel event for ADISC.\n");
+		vhost->abort_threads--;
+		kref_put(&tgt->kref, ibmvfc_release_tgt);
+		__ibmvfc_reset_host(vhost);
+		spin_unlock_irqrestore(vhost->host->host_lock, flags);
+		return;
+	}
 	ibmvfc_init_event(evt, ibmvfc_tgt_adisc_cancel_done, IBMVFC_MAD_FORMAT);
 
 	evt->tgt = tgt;
@@ -4595,6 +4670,12 @@ static void ibmvfc_tgt_adisc(struct ibmvfc_target *tgt)
 
 	kref_get(&tgt->kref);
 	evt = ibmvfc_get_event(&vhost->crq);
+	if (!evt) {
+		ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_NONE);
+		kref_put(&tgt->kref, ibmvfc_release_tgt);
+		__ibmvfc_reset_host(vhost);
+		return;
+	}
 	vhost->discovery_threads++;
 	ibmvfc_init_event(evt, ibmvfc_tgt_adisc_done, IBMVFC_MAD_FORMAT);
 	evt->tgt = tgt;
@@ -4698,6 +4779,12 @@ static void ibmvfc_tgt_query_target(struct ibmvfc_target *tgt)
 
 	kref_get(&tgt->kref);
 	evt = ibmvfc_get_event(&vhost->crq);
+	if (!evt) {
+		ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_NONE);
+		kref_put(&tgt->kref, ibmvfc_release_tgt);
+		__ibmvfc_reset_host(vhost);
+		return;
+	}
 	vhost->discovery_threads++;
 	evt->tgt = tgt;
 	ibmvfc_init_event(evt, ibmvfc_tgt_query_target_done, IBMVFC_MAD_FORMAT);
@@ -4870,6 +4957,13 @@ static void ibmvfc_discover_targets(struct ibmvfc_host *vhost)
 {
 	struct ibmvfc_discover_targets *mad;
 	struct ibmvfc_event *evt = ibmvfc_get_event(&vhost->crq);
+	int level = IBMVFC_DEFAULT_LOG_LEVEL;
+
+	if (!evt) {
+		ibmvfc_log(vhost, level, "Discover Targets failed: no available events\n");
+		ibmvfc_hard_reset_host(vhost);
+		return;
+	}
 
 	ibmvfc_init_event(evt, ibmvfc_discover_targets_done, IBMVFC_MAD_FORMAT);
 	mad = &evt->iu.discover_targets;
@@ -4947,8 +5041,15 @@ static void ibmvfc_channel_setup(struct ibmvfc_host *vhost)
 	struct ibmvfc_scsi_channels *scrqs = &vhost->scsi_scrqs;
 	unsigned int num_channels =
 		min(vhost->client_scsi_channels, vhost->max_vios_scsi_channels);
+	int level = IBMVFC_DEFAULT_LOG_LEVEL;
 	int i;
 
+	if (!evt) {
+		ibmvfc_log(vhost, level, "Channel Setup failed: no available events\n");
+		ibmvfc_hard_reset_host(vhost);
+		return;
+	}
+
 	memset(setup_buf, 0, sizeof(*setup_buf));
 	if (num_channels == 0)
 		setup_buf->flags = cpu_to_be32(IBMVFC_CANCEL_CHANNELS);
@@ -5010,6 +5111,13 @@ static void ibmvfc_channel_enquiry(struct ibmvfc_host *vhost)
 {
 	struct ibmvfc_channel_enquiry *mad;
 	struct ibmvfc_event *evt = ibmvfc_get_event(&vhost->crq);
+	int level = IBMVFC_DEFAULT_LOG_LEVEL;
+
+	if (!evt) {
+		ibmvfc_log(vhost, level, "Channel Enquiry failed: no available events\n");
+		ibmvfc_hard_reset_host(vhost);
+		return;
+	}
 
 	ibmvfc_init_event(evt, ibmvfc_channel_enquiry_done, IBMVFC_MAD_FORMAT);
 	mad = &evt->iu.channel_enquiry;
@@ -5132,6 +5240,12 @@ static void ibmvfc_npiv_login(struct ibmvfc_host *vhost)
 	struct ibmvfc_npiv_login_mad *mad;
 	struct ibmvfc_event *evt = ibmvfc_get_event(&vhost->crq);
 
+	if (!evt) {
+		ibmvfc_dbg(vhost, "NPIV Login failed: no available events\n");
+		ibmvfc_hard_reset_host(vhost);
+		return;
+	}
+
 	ibmvfc_gather_partition_info(vhost);
 	ibmvfc_set_login_info(vhost);
 	ibmvfc_init_event(evt, ibmvfc_npiv_login_done, IBMVFC_MAD_FORMAT);
@@ -5196,6 +5310,12 @@ static void ibmvfc_npiv_logout(struct ibmvfc_host *vhost)
 	struct ibmvfc_event *evt;
 
 	evt = ibmvfc_get_event(&vhost->crq);
+	if (!evt) {
+		ibmvfc_dbg(vhost, "NPIV Logout failed: no available events\n");
+		ibmvfc_hard_reset_host(vhost);
+		return;
+	}
+
 	ibmvfc_init_event(evt, ibmvfc_npiv_logout_done, IBMVFC_MAD_FORMAT);
 
 	mad = &evt->iu.npiv_logout;
-- 
2.42.0

