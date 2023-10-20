Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D997D1630
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 21:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbjJTTIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 15:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjJTTH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 15:07:27 -0400
Received: from rcdn-iport-7.cisco.com (rcdn-iport-7.cisco.com [173.37.86.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE43D7D;
        Fri, 20 Oct 2023 12:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=14031; q=dns/txt;
  s=iport; t=1697828844; x=1699038444;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=La0OzOjS9Qjtj75o0AAOU1kJMPpGDvVA+U0OgbgI454=;
  b=WUVRxO0XRIXoUopHvgulzjqqrR7tPv1UQUofU1FjBq2wiTQq4Mwmom0y
   DZ6AkhHDS+5qaRspqY6Cg/NW35+NkQVxh3frMqGcAVwjsownZlRFHletG
   4Xxi7a2GaMAtCnxbCp13Wkl+eXKsfQF4lliymVO0l/l0LlxgaKc/HmzxH
   w=;
X-CSE-ConnectionGUID: LT/J5LskRuy8DBmHCxZWbQ==
X-CSE-MsgGUID: y4j48l5yTCa9xRejKqw0OQ==
X-IronPort-AV: E=Sophos;i="6.03,239,1694736000"; 
   d="scan'208";a="126421382"
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
  by rcdn-iport-7.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 19:07:23 +0000
Received: from localhost.cisco.com ([10.193.101.253])
        (authenticated bits=0)
        by rcdn-core-11.cisco.com (8.15.2/8.15.2) with ESMTPSA id 39KJ6XPP026372
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 20 Oct 2023 19:07:23 GMT
From:   Karan Tilak Kumar <kartilak@cisco.com>
To:     sebaddel@cisco.com
Cc:     arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
        mkai2@cisco.com, satishkh@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Karan Tilak Kumar <kartilak@cisco.com>
Subject: [PATCH 13/13] scsi: fnic: Improve logs and add support for multiqueue (MQ)
Date:   Fri, 20 Oct 2023 12:06:29 -0700
Message-Id: <20231020190629.338623-14-kartilak@cisco.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231020190629.338623-1-kartilak@cisco.com>
References: <20231020190629.338623-1-kartilak@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: kartilak@cisco.com
X-Outbound-SMTP-Client: 10.193.101.253, [10.193.101.253]
X-Outbound-Node: rcdn-core-11.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve existing logs by adding fnic number, hardware queue,
tag, and mqtag in the prints.
Add logs with the above elements for effective debugging.

Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Tested-by: Karan Tilak Kumar <kartilak@cisco.com>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
---
 drivers/scsi/fnic/fnic.h      |   2 +-
 drivers/scsi/fnic/fnic_scsi.c | 127 ++++++++++++++++++++--------------
 2 files changed, 77 insertions(+), 52 deletions(-)

diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
index bfc333366d1f..35c570d595e9 100644
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -27,7 +27,7 @@
 
 #define DRV_NAME		"fnic"
 #define DRV_DESCRIPTION		"Cisco FCoE HBA Driver"
-#define DRV_VERSION		"1.6.0.56"
+#define DRV_VERSION		"1.6.0.58"
 #define PFX			DRV_NAME ": "
 #define DFX                     DRV_NAME "%d: "
 
diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
index 7ca34a76f84e..f5b7a7de83d7 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -211,12 +211,14 @@ int fnic_fw_reset_handler(struct fnic *fnic)
 
 	if (!ret) {
 		atomic64_inc(&fnic->fnic_stats.reset_stats.fw_resets);
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
-			      "Issued fw reset\n");
+		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
+				"fnic<%d>: %s: %d: Issued fw reset\n",
+				fnic->fnic_num, __func__, __LINE__);
 	} else {
 		fnic_clear_state_flags(fnic, FNIC_FLAGS_FWRESET);
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
-			      "Failed to issue fw reset\n");
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
+				"fnic<%d>: %s: %d: Failed to issue fw reset\n",
+				fnic->fnic_num, __func__, __LINE__);
 	}
 
 	return ret;
@@ -265,9 +267,9 @@ int fnic_flogi_reg_handler(struct fnic *fnic, u32 fc_id)
 	} else {
 		fnic_queue_wq_copy_desc_flogi_reg(wq, SCSI_NO_TAG,
 						  format, fc_id, gw_mac);
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
-			      "FLOGI reg issued fcid %x map %d dest %pM\n",
-			      fc_id, fnic->ctlr.map_dest, gw_mac);
+		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
+			"fnic<%d>: %s: %d: FLOGI reg issued fcid 0x%x map %d dest 0x%p\n",
+			fnic->fnic_num, __func__, __LINE__, fc_id, fnic->ctlr.map_dest, gw_mac);
 	}
 
 	atomic64_inc(&fnic->fnic_stats.fw_stats.active_fw_reqs);
@@ -662,15 +664,16 @@ static int fnic_fcpio_fw_reset_cmpl_handler(struct fnic *fnic,
 	if (fnic->state == FNIC_IN_FC_TRANS_ETH_MODE) {
 		/* Check status of reset completion */
 		if (!hdr_status) {
-			FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
-				      "reset cmpl success\n");
+			FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
+					"fnic<%d>: %s: %d: reset cmpl success\n",
+					fnic->fnic_num, __func__, __LINE__);
 			/* Ready to send flogi out */
 			fnic->state = FNIC_IN_ETH_MODE;
 		} else {
-			FNIC_SCSI_DBG(KERN_DEBUG,
-				      fnic->lport->host,
-				      "fnic fw_reset : failed %s\n",
-				      fnic_fcpio_status_to_str(hdr_status));
+			FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
+				"fnic<%d>: %s: %d: reset failed with header status: %s\n",
+				fnic->fnic_num, __func__, __LINE__,
+				fnic_fcpio_status_to_str(hdr_status));
 
 			/*
 			 * Unable to change to eth mode, cannot send out flogi
@@ -683,10 +686,9 @@ static int fnic_fcpio_fw_reset_cmpl_handler(struct fnic *fnic,
 			ret = -1;
 		}
 	} else {
-		FNIC_SCSI_DBG(KERN_DEBUG,
-			      fnic->lport->host,
-			      "Unexpected state %s while processing"
-			      " reset cmpl\n", fnic_state_to_str(fnic->state));
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
+			"fnic<%d>: %s: %d: Unexpected state while processing reset completion: %s\n",
+			fnic->fnic_num, __func__, __LINE__, fnic_state_to_str(fnic->state));
 		atomic64_inc(&reset_stats->fw_reset_failures);
 		ret = -1;
 	}
@@ -1195,9 +1197,10 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic, unsigned int cq_inde
 	if ((id & FNIC_TAG_ABORT) && (id & FNIC_TAG_DEV_RST)) {
 		/* Abort and terminate completion of device reset req */
 		/* REVISIT : Add asserts about various flags */
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
-			      "dev reset abts cmpl recd. id %x status %s\n",
-			      id, fnic_fcpio_status_to_str(hdr_status));
+		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
+			"fnic<%d>: %s: %d: hwq: %d mqtag: 0x%x tag: 0x%x hst: %s Abt/term completion received\n",
+			fnic->fnic_num, __func__, __LINE__, hwq, mqtag, tag,
+			fnic_fcpio_status_to_str(hdr_status));
 		fnic_priv(sc)->state = FNIC_IOREQ_ABTS_COMPLETE;
 		fnic_priv(sc)->abts_status = hdr_status;
 		fnic_priv(sc)->flags |= FNIC_DEV_RST_DONE;
@@ -1206,6 +1209,10 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic, unsigned int cq_inde
 		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 	} else if (id & FNIC_TAG_ABORT) {
 		/* Completion of abort cmd */
+		shost_printk(KERN_DEBUG, fnic->lport->host,
+			"fnic<%d>: %s: %d: hwq: %d mqtag: 0x%x tag: 0x%x Abort header status: %s\n",
+			fnic->fnic_num, __func__, __LINE__, hwq, mqtag, tag,
+			fnic_fcpio_status_to_str(hdr_status));
 		switch (hdr_status) {
 		case FCPIO_SUCCESS:
 			break;
@@ -1265,9 +1272,14 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic, unsigned int cq_inde
 		if (io_req->abts_done) {
 			complete(io_req->abts_done);
 			spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
+			shost_printk(KERN_INFO, fnic->lport->host,
+					"fnic<%d>: %s: %d: hwq: %d mqtag: 0x%x tag: 0x%x Waking up abort thread\n",
+					fnic->fnic_num, __func__, __LINE__, hwq, mqtag, tag);
 		} else {
 			FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
-				      "abts cmpl, completing IO\n");
+				"fnic<%d>: %s: %d: hwq: %d mqtag: 0x%x tag: 0x%x hst: %s Completing IO\n",
+				fnic->fnic_num, __func__, __LINE__, hwq, mqtag,
+				tag, fnic_fcpio_status_to_str(hdr_status));
 			fnic_priv(sc)->io_req = NULL;
 			sc->result = (DID_ERROR << 16);
 			fnic->sw_copy_wq[hwq].io_req_table[tag] = NULL;
@@ -1295,6 +1307,10 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic, unsigned int cq_inde
 		}
 	} else if (id & FNIC_TAG_DEV_RST) {
 		/* Completion of device reset */
+		shost_printk(KERN_INFO, fnic->lport->host,
+			"fnic<%d>: %s: %d: hwq: %d mqtag: 0x%x tag: 0x%x DR hst: %s\n",
+			fnic->fnic_num, __func__, __LINE__, hwq, mqtag,
+			tag, fnic_fcpio_status_to_str(hdr_status));
 		fnic_priv(sc)->lr_status = hdr_status;
 		if (fnic_priv(sc)->state == FNIC_IOREQ_ABTS_PENDING) {
 			spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
@@ -1304,10 +1320,9 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic, unsigned int cq_inde
 				  jiffies_to_msecs(jiffies - start_time),
 				  desc, 0, fnic_flags_and_state(sc));
 			FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
-				"Terminate pending "
-				"dev reset cmpl recd. id %d status %s\n",
-				(int)(id & FNIC_TAG_MASK),
-				fnic_fcpio_status_to_str(hdr_status));
+				"fnic<%d>: %s: %d: hwq: %d mqtag: 0x%x tag: 0x%x hst: %s Terminate pending\n",
+				fnic->fnic_num, __func__, __LINE__, hwq, mqtag,
+				tag, fnic_fcpio_status_to_str(hdr_status));
 			return;
 		}
 		if (fnic_priv(sc)->flags & FNIC_DEV_RST_TIMED_OUT) {
@@ -1326,18 +1341,18 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic, unsigned int cq_inde
 		}
 		fnic_priv(sc)->state = FNIC_IOREQ_CMD_COMPLETE;
 		fnic_priv(sc)->flags |= FNIC_DEV_RST_DONE;
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
-			      "dev reset cmpl recd. id %d status %s\n",
-			      (int)(id & FNIC_TAG_MASK),
-			      fnic_fcpio_status_to_str(hdr_status));
+		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
+			"fnic<%d>: %s: %d: hwq: %d mqtag: 0x%x tag: 0x%x hst: %s DR completion received\n",
+			fnic->fnic_num, __func__, __LINE__, hwq, mqtag,
+			tag, fnic_fcpio_status_to_str(hdr_status));
 		if (io_req->dr_done)
 			complete(io_req->dr_done);
 		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 
 	} else {
 		shost_printk(KERN_ERR, fnic->lport->host,
-			     "Unexpected itmf io state %s tag %x\n",
-			     fnic_ioreq_state_to_str(fnic_priv(sc)->state), id);
+			"%s: Unexpected itmf io state: hwq: %d tag 0x%x %s\n",
+			__func__, hwq, id, fnic_ioreq_state_to_str(fnic_priv(sc)->state));
 		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 	}
 
@@ -1488,9 +1503,9 @@ static bool fnic_cleanup_io_iter(struct scsi_cmnd *sc, void *data)
 	mempool_free(io_req, fnic->io_req_pool);
 
 	sc->result = DID_TRANSPORT_DISRUPTED << 16;
-	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
-		      "fnic_cleanup_io: tag:0x%x : sc:0x%p duration = %lu DID_TRANSPORT_DISRUPTED\n",
-		      tag, sc, jiffies - start_time);
+	FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
+		"fnic<%d>: %s: %d: mqtag:0x%x tag: 0x%x sc:0x%p duration = %lu DID_TRANSPORT_DISRUPTED\n",
+		fnic->fnic_num, __func__, __LINE__, mqtag, tag, sc, (jiffies - start_time));
 
 	if (atomic64_read(&fnic->io_cmpl_skip))
 		atomic64_dec(&fnic->io_cmpl_skip);
@@ -1659,9 +1674,9 @@ static bool fnic_rport_abort_io_iter(struct scsi_cmnd *sc, void *data)
 
 	if ((fnic_priv(sc)->flags & FNIC_DEVICE_RESET) &&
 	    !(fnic_priv(sc)->flags & FNIC_DEV_RST_ISSUED)) {
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
-			"fnic_rport_exch_reset dev rst not pending sc 0x%p\n",
-			sc);
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
+			"fnic<%d>: %s: %d: hwq: %d abt_tag: 0x%x flags: 0x%x Device reset is not pending\n",
+			fnic->fnic_num, __func__, __LINE__, hwq, abt_tag, fnic_priv(sc)->flags);
 		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		return true;
 	}
@@ -1717,6 +1732,9 @@ static bool fnic_rport_abort_io_iter(struct scsi_cmnd *sc, void *data)
 		 * lun reset
 		 */
 		spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
+			"fnic<%d>: %s: %d: hwq: %d abt_tag: 0x%x flags: 0x%x Queuing abort failed\n",
+			fnic->fnic_num, __func__, __LINE__, hwq, abt_tag, fnic_priv(sc)->flags);
 		if (fnic_priv(sc)->state == FNIC_IOREQ_ABTS_PENDING)
 			fnic_priv(sc)->state = old_ioreq_state;
 		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
@@ -1887,8 +1905,9 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 	else
 		atomic64_inc(&abts_stats->abort_issued_greater_than_60_sec);
 
-	FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
-		"CBD Opcode: %02x Abort issued time: %lu msec\n", sc->cmnd[0], abt_issued_time);
+	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
+		"fnic<%d>: %s: CDB Opcode: 0x%02x Abort issued time: %lu msec\n",
+		fnic->fnic_num, __func__, sc->cmnd[0], abt_issued_time);
 	/*
 	 * Command is still pending, need to abort it
 	 * If the firmware completes the command after this point,
@@ -1977,8 +1996,9 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 
 	if (!(fnic_priv(sc)->flags & (FNIC_IO_ABORTED | FNIC_IO_DONE))) {
 		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
-			"Issuing Host reset due to out of order IO\n");
+	    FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
+			"fnic<%d>: %s: Issuing host reset due to out of order IO\n",
+			fnic->fnic_num, __func__);
 
 		ret = FAILED;
 		goto fnic_abort_cmd_end;
@@ -2185,6 +2205,9 @@ static bool fnic_pending_aborts_iter(struct scsi_cmnd *sc, void *data)
 			fnic_priv(sc)->state = old_ioreq_state;
 		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		iter_data->ret = FAILED;
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
+			"fnic<%d>: %s: %d: hwq: %d abt_tag: 0x%lx Abort could not be queued\n",
+			fnic->fnic_num, __func__, __LINE__, hwq, abt_tag);
 		return false;
 	} else {
 		spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
@@ -2318,8 +2341,9 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 
 	rport = starget_to_rport(scsi_target(sc->device));
 	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
-		      "Device reset called FCID 0x%x, LUN 0x%llx sc 0x%p\n",
-		      rport->port_id, sc->device->lun, sc);
+		"fnic<%d>: %s: %d: fcid: 0x%x lun: 0x%llx hwq: %d mqtag: 0x%x flags: 0x%x Device reset\n",
+		fnic->fnic_num, __func__, __LINE__, rport->port_id, sc->device->lun, hwq, mqtag,
+		fnic_priv(sc)->flags);
 
 	if (lp->state != LPORT_ST_READY || !(lp->link_up))
 		goto fnic_device_reset_end;
@@ -2554,8 +2578,9 @@ int fnic_reset(struct Scsi_Host *shost)
 	fnic = lport_priv(lp);
 	reset_stats = &fnic->fnic_stats.reset_stats;
 
-	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
-		      "fnic_reset called\n");
+	FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
+			"fnic<%d>: %s: %d: Issuing fnic reset\n",
+			fnic->fnic_num, __func__, __LINE__);
 
 	atomic64_inc(&reset_stats->fnic_resets);
 
@@ -2565,10 +2590,9 @@ int fnic_reset(struct Scsi_Host *shost)
 	 */
 	ret = fc_lport_reset(lp);
 
-	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
-		      "Returning from fnic reset %s\n",
-		      (ret == 0) ?
-		      "SUCCESS" : "FAILED");
+	FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
+		"fnic<%d>: %s: %d: Returning from fnic reset with: %s\n",
+		fnic->fnic_num, __func__, __LINE__, (ret == 0) ? "SUCCESS" : "FAILED");
 
 	if (ret == 0)
 		atomic64_inc(&reset_stats->fnic_reset_completions);
@@ -2784,8 +2808,9 @@ static bool fnic_abts_pending_iter(struct scsi_cmnd *sc, void *data)
 	 * belongs to the LUN that we are resetting
 	 */
 	FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
-		      "Found IO in %s on lun\n",
-		      fnic_ioreq_state_to_str(fnic_priv(sc)->state));
+		"fnic<%d>: %s: %d: hwq: %d tag: 0x%x Found IO in state: %s on lun\n",
+		fnic->fnic_num, __func__, __LINE__, hwq, tag,
+		fnic_ioreq_state_to_str(fnic_priv(sc)->state));
 	cmd_state = fnic_priv(sc)->state;
 	spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 	if (cmd_state == FNIC_IOREQ_ABTS_PENDING)
-- 
2.31.1

