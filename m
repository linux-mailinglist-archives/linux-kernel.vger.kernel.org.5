Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F877FE6E7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 03:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344323AbjK3Cgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 21:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbjK3Cg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 21:36:29 -0500
Received: from rcdn-iport-4.cisco.com (rcdn-iport-4.cisco.com [173.37.86.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F9D10F8;
        Wed, 29 Nov 2023 18:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=33728; q=dns/txt;
  s=iport; t=1701311779; x=1702521379;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cF+GhyerNtyFIqKFFhQdnueAZFi0IBtMGL3QsfkHd7A=;
  b=S80c0KETRPdxs+Mq1MTOEClgMlshBMdDWG0qFDFNeYvu06fMM2IbD2ri
   WiFSI158F+/f5mPFxpbdh+hMFVGyEEWm4HBTAjRqhRlFPo9lYWYhzmdkC
   Yzgs5kxpv9gT/AubO36Ne6Ul/KENwVIVcL/36KuUWb3RzZPiIAabUKvu5
   U=;
X-CSE-ConnectionGUID: mCxYwyAyRASTbPJ1nnDoSQ==
X-CSE-MsgGUID: 4P/O0OYeRvq0EgMkIx185Q==
X-IronPort-AV: E=Sophos;i="6.04,237,1695686400"; 
   d="scan'208";a="149343653"
Received: from rcdn-core-9.cisco.com ([173.37.93.145])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 02:36:18 +0000
Received: from localhost.cisco.com ([10.193.101.253])
        (authenticated bits=0)
        by rcdn-core-9.cisco.com (8.15.2/8.15.2) with ESMTPSA id 3AU2YA4E007614
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 30 Nov 2023 02:36:17 GMT
From:   Karan Tilak Kumar <kartilak@cisco.com>
To:     sebaddel@cisco.com
Cc:     arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
        mkai2@cisco.com, satishkh@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Karan Tilak Kumar <kartilak@cisco.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v4 12/13] scsi: fnic: Improve logs and add support for multiqueue (MQ)
Date:   Wed, 29 Nov 2023 18:34:01 -0800
Message-Id: <20231130023402.802282-13-kartilak@cisco.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231130023402.802282-1-kartilak@cisco.com>
References: <20231130023402.802282-1-kartilak@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: kartilak@cisco.com
X-Outbound-SMTP-Client: 10.193.101.253, [10.193.101.253]
X-Outbound-Node: rcdn-core-9.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve existing logs by adding fnic number, hardware queue,
tag, and mqtag in the prints.
Add logs with the above elements for effective debugging.

Changes between v2 and v3:
    Incorporate the following review comment from Hannes:
	Use fnic_num as an argument to FNIC_SCSI_DBG.
	Modify definition of FNIC_SCSI_DBG.
	Host number is still an argument since
	FNIC_SCSI_DBG in turn uses shost_printk.

Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Tested-by: Karan Tilak Kumar <kartilak@cisco.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
---
 drivers/scsi/fnic/fnic.h      |   6 +-
 drivers/scsi/fnic/fnic_scsi.c | 288 ++++++++++++++++++----------------
 2 files changed, 154 insertions(+), 140 deletions(-)

diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
index d5b9590894d2..c4edbd7dfc25 100644
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -155,9 +155,11 @@ do {								\
 				"fnic<%d>: %s: %d: " fmt, fnic_num,\
 				__func__, __LINE__, ##args);)
 
-#define FNIC_SCSI_DBG(kern_level, host, fmt, args...)		\
+#define FNIC_SCSI_DBG(kern_level, host, fnic_num, fmt, args...)		\
 	FNIC_CHECK_LOGGING(FNIC_SCSI_LOGGING,			\
-			 shost_printk(kern_level, host, fmt, ##args);)
+			 shost_printk(kern_level, host,			\
+				"fnic<%d>: %s: %d: " fmt, fnic_num,\
+				__func__, __LINE__, ##args);)
 
 #define FNIC_ISR_DBG(kern_level, host, fnic_num, fmt, args...)		\
 	FNIC_CHECK_LOGGING(FNIC_ISR_LOGGING,			\
diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
index 648cb8aff92c..192daab00f0f 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -211,12 +211,12 @@ int fnic_fw_reset_handler(struct fnic *fnic)
 
 	if (!ret) {
 		atomic64_inc(&fnic->fnic_stats.reset_stats.fw_resets);
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
-			      "Issued fw reset\n");
+		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				"Issued fw reset\n");
 	} else {
 		fnic_clear_state_flags(fnic, FNIC_FLAGS_FWRESET);
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
-			      "Failed to issue fw reset\n");
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+				"Failed to issue fw reset\n");
 	}
 
 	return ret;
@@ -259,15 +259,15 @@ int fnic_flogi_reg_handler(struct fnic *fnic, u32 fc_id)
 						fc_id, gw_mac,
 						fnic->data_src_addr,
 						lp->r_a_tov, lp->e_d_tov);
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
+		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
 			      "FLOGI FIP reg issued fcid %x src %pM dest %pM\n",
 			      fc_id, fnic->data_src_addr, gw_mac);
 	} else {
 		fnic_queue_wq_copy_desc_flogi_reg(wq, SCSI_NO_TAG,
 						  format, fc_id, gw_mac);
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
-			      "FLOGI reg issued fcid %x map %d dest %pM\n",
-			      fc_id, fnic->ctlr.map_dest, gw_mac);
+		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			"FLOGI reg issued fcid 0x%x map %d dest 0x%p\n",
+			fc_id, fnic->ctlr.map_dest, gw_mac);
 	}
 
 	atomic64_inc(&fnic->fnic_stats.fw_stats.active_fw_reqs);
@@ -342,7 +342,7 @@ static inline int fnic_queue_wq_copy_desc(struct fnic *fnic,
 		free_wq_copy_descs(fnic, wq, hwq);
 
 	if (unlikely(!vnic_wq_copy_desc_avail(wq))) {
-		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
+		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 			  "fnic_queue_wq_copy_desc failure - no descriptors\n");
 		atomic64_inc(&misc_stats->io_cpwq_alloc_failures);
 		return SCSI_MLQUEUE_HOST_BUSY;
@@ -408,24 +408,24 @@ int fnic_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *sc)
 
 	if (unlikely(fnic_chk_state_flags_locked(fnic, FNIC_FLAGS_IO_BLOCKED))) {
 		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
-			"fnic<%d>: %s: %d: fnic IO blocked flags: 0x%lx. Returning SCSI_MLQUEUE_HOST_BUSY\n",
-			fnic->fnic_num, __func__, __LINE__, fnic->state_flags);
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+			"fnic IO blocked flags: 0x%lx. Returning SCSI_MLQUEUE_HOST_BUSY\n",
+			fnic->state_flags);
 		return SCSI_MLQUEUE_HOST_BUSY;
 	}
 
 	if (unlikely(fnic_chk_state_flags_locked(fnic, FNIC_FLAGS_FWRESET))) {
 		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
-			"fnic<%d>: %s: %d: fnic flags: 0x%lx. Returning SCSI_MLQUEUE_HOST_BUSY\n",
-			fnic->fnic_num, __func__, __LINE__, fnic->state_flags);
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+			"fnic flags: 0x%lx. Returning SCSI_MLQUEUE_HOST_BUSY\n",
+			fnic->state_flags);
 		return SCSI_MLQUEUE_HOST_BUSY;
 	}
 
 	rport = starget_to_rport(scsi_target(sc->device));
 	if (!rport) {
 		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
+		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
 				"returning DID_NO_CONNECT for IO as rport is NULL\n");
 		sc->result = DID_NO_CONNECT << 16;
 		done(sc);
@@ -435,7 +435,7 @@ int fnic_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *sc)
 	ret = fc_remote_port_chkready(rport);
 	if (ret) {
 		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
+		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
 				"rport is not ready\n");
 		atomic64_inc(&fnic_stats->misc_stats.rport_not_ready);
 		sc->result = ret;
@@ -446,7 +446,7 @@ int fnic_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *sc)
 	rp = rport->dd_data;
 	if (!rp || rp->rp_state == RPORT_ST_DELETE) {
 		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
+		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
 			"rport 0x%x removed, returning DID_NO_CONNECT\n",
 			rport->port_id);
 
@@ -458,7 +458,7 @@ int fnic_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *sc)
 
 	if (rp->rp_state != RPORT_ST_READY) {
 		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
+		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
 			"rport 0x%x in state 0x%x, returning DID_IMM_RETRY\n",
 			rport->port_id, rp->rp_state);
 
@@ -469,9 +469,9 @@ int fnic_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *sc)
 
 	if (lp->state != LPORT_ST_READY || !(lp->link_up)) {
 		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
-			"fnic<%d>: %s: %d: state not ready: %d/link not up: %d Returning HOST_BUSY\n",
-			fnic->fnic_num, __func__, __LINE__, lp->state, lp->link_up);
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+			"state not ready: %d/link not up: %d Returning HOST_BUSY\n",
+			lp->state, lp->link_up);
 		return SCSI_MLQUEUE_HOST_BUSY;
 	}
 
@@ -636,15 +636,14 @@ static int fnic_fcpio_fw_reset_cmpl_handler(struct fnic *fnic,
 	if (fnic->state == FNIC_IN_FC_TRANS_ETH_MODE) {
 		/* Check status of reset completion */
 		if (!hdr_status) {
-			FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
-				      "reset cmpl success\n");
+			FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					"reset cmpl success\n");
 			/* Ready to send flogi out */
 			fnic->state = FNIC_IN_ETH_MODE;
 		} else {
-			FNIC_SCSI_DBG(KERN_DEBUG,
-				      fnic->lport->host,
-				      "fnic fw_reset : failed %s\n",
-				      fnic_fcpio_status_to_str(hdr_status));
+			FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+				"reset failed with header status: %s\n",
+				fnic_fcpio_status_to_str(hdr_status));
 
 			/*
 			 * Unable to change to eth mode, cannot send out flogi
@@ -657,10 +656,9 @@ static int fnic_fcpio_fw_reset_cmpl_handler(struct fnic *fnic,
 			ret = -1;
 		}
 	} else {
-		FNIC_SCSI_DBG(KERN_DEBUG,
-			      fnic->lport->host,
-			      "Unexpected state %s while processing"
-			      " reset cmpl\n", fnic_state_to_str(fnic->state));
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+			"Unexpected state while processing reset completion: %s\n",
+			fnic_state_to_str(fnic->state));
 		atomic64_inc(&reset_stats->fw_reset_failures);
 		ret = -1;
 	}
@@ -711,19 +709,19 @@ static int fnic_fcpio_flogi_reg_cmpl_handler(struct fnic *fnic,
 
 		/* Check flogi registration completion status */
 		if (!hdr_status) {
-			FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
+			FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
 				      "flog reg succeeded\n");
 			fnic->state = FNIC_IN_FC_MODE;
 		} else {
 			FNIC_SCSI_DBG(KERN_DEBUG,
-				      fnic->lport->host,
+				      fnic->lport->host, fnic->fnic_num,
 				      "fnic flogi reg :failed %s\n",
 				      fnic_fcpio_status_to_str(hdr_status));
 			fnic->state = FNIC_IN_ETH_MODE;
 			ret = -1;
 		}
 	} else {
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
+		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
 			      "Unexpected fnic state %s while"
 			      " processing flogi reg completion\n",
 			      fnic_state_to_str(fnic->state));
@@ -834,22 +832,20 @@ static void fnic_fcpio_icmnd_cmpl_handler(struct fnic *fnic, unsigned int cq_ind
 	hwq = blk_mq_unique_tag_to_hwq(mqtag);
 
 	if (hwq != cq_index) {
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
-			"fnic<%d>: %s: %d: hwq: %d mqtag: 0x%x tag: 0x%x cq index: %d ",
-			fnic->fnic_num, __func__, __LINE__, hwq, mqtag, tag, cq_index);
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
-			"fnic<%d>: %s: %d: hdr status: %s icmnd completion on the wrong queue\n",
-			fnic->fnic_num, __func__, __LINE__,
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+			"hwq: %d mqtag: 0x%x tag: 0x%x cq index: %d ",
+			hwq, mqtag, tag, cq_index);
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+			"hdr status: %s icmnd completion on the wrong queue\n",
 			fnic_fcpio_status_to_str(hdr_status));
 	}
 
 	if (tag >= fnic->fnic_max_tag_id) {
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
-			"fnic<%d>: %s: %d: hwq: %d mqtag: 0x%x tag: 0x%x cq index: %d ",
-			fnic->fnic_num, __func__, __LINE__, hwq, mqtag, tag, cq_index);
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
-			"fnic<%d>: %s: %d: hdr status: %s Out of range tag\n",
-			fnic->fnic_num, __func__, __LINE__,
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+			"hwq: %d mqtag: 0x%x tag: 0x%x cq index: %d ",
+			hwq, mqtag, tag, cq_index);
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+			"hdr status: %s Out of range tag\n",
 			fnic_fcpio_status_to_str(hdr_status));
 		return;
 	}
@@ -915,7 +911,7 @@ static void fnic_fcpio_icmnd_cmpl_handler(struct fnic *fnic, unsigned int cq_ind
 		if(FCPIO_ABORTED == hdr_status)
 			fnic_priv(sc)->flags |= FNIC_IO_ABORTED;
 
-		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
+		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 			"icmnd_cmpl abts pending "
 			  "hdr status = %s tag = 0x%x sc = 0x%p "
 			  "scsi_status = %x residual = %d\n",
@@ -1100,31 +1096,28 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic, unsigned int cq_inde
 	hwq = blk_mq_unique_tag_to_hwq(id & FNIC_TAG_MASK);
 
 	if (hwq != cq_index) {
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
-			"%s: %d: hwq: %d mqtag: 0x%x tag: 0x%x cq index: %d ",
-			__func__, __LINE__, hwq, mqtag, tag, cq_index);
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
-			"%s: %d: hdr status: %s ITMF completion on the wrong queue\n",
-			__func__, __LINE__,
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+			"hwq: %d mqtag: 0x%x tag: 0x%x cq index: %d ",
+			hwq, mqtag, tag, cq_index);
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+			"hdr status: %s ITMF completion on the wrong queue\n",
 			fnic_fcpio_status_to_str(hdr_status));
 	}
 
 	if (tag > fnic->fnic_max_tag_id) {
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
-			"%s: %d: hwq: %d mqtag: 0x%x tag: 0x%x cq index: %d ",
-			__func__, __LINE__, hwq, mqtag, tag, cq_index);
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
-			"%s: %d: hdr status: %s Tag out of range\n",
-			__func__, __LINE__,
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+			"hwq: %d mqtag: 0x%x tag: 0x%x cq index: %d ",
+			hwq, mqtag, tag, cq_index);
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+			"hdr status: %s Tag out of range\n",
 			fnic_fcpio_status_to_str(hdr_status));
 		return;
 	}  else if ((tag == fnic->fnic_max_tag_id) && !(id & FNIC_TAG_DEV_RST)) {
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
-			"%s: %d: hwq: %d mqtag: 0x%x tag: 0x%x cq index: %d ",
-			__func__, __LINE__, hwq, mqtag, tag, cq_index);
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
-			"%s: %d: hdr status: %s Tag out of range\n",
-			__func__, __LINE__,
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+			"hwq: %d mqtag: 0x%x tag: 0x%x cq index: %d ",
+			hwq, mqtag, tag, cq_index);
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+			"hdr status: %s Tag out of range\n",
 			fnic_fcpio_status_to_str(hdr_status));
 		return;
 	}
@@ -1169,9 +1162,10 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic, unsigned int cq_inde
 	if ((id & FNIC_TAG_ABORT) && (id & FNIC_TAG_DEV_RST)) {
 		/* Abort and terminate completion of device reset req */
 		/* REVISIT : Add asserts about various flags */
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
-			      "dev reset abts cmpl recd. id %x status %s\n",
-			      id, fnic_fcpio_status_to_str(hdr_status));
+		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			"hwq: %d mqtag: 0x%x tag: 0x%x hst: %s Abt/term completion received\n",
+			hwq, mqtag, tag,
+			fnic_fcpio_status_to_str(hdr_status));
 		fnic_priv(sc)->state = FNIC_IOREQ_ABTS_COMPLETE;
 		fnic_priv(sc)->abts_status = hdr_status;
 		fnic_priv(sc)->flags |= FNIC_DEV_RST_DONE;
@@ -1180,6 +1174,10 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic, unsigned int cq_inde
 		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 	} else if (id & FNIC_TAG_ABORT) {
 		/* Completion of abort cmd */
+		shost_printk(KERN_DEBUG, fnic->lport->host,
+			"hwq: %d mqtag: 0x%x tag: 0x%x Abort header status: %s\n",
+			hwq, mqtag, tag,
+			fnic_fcpio_status_to_str(hdr_status));
 		switch (hdr_status) {
 		case FCPIO_SUCCESS:
 			break;
@@ -1191,7 +1189,7 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic, unsigned int cq_inde
 					&term_stats->terminate_fw_timeouts);
 			break;
 		case FCPIO_ITMF_REJECTED:
-			FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
+			FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 				"abort reject recd. id %d\n",
 				(int)(id & FNIC_TAG_MASK));
 			break;
@@ -1226,7 +1224,7 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic, unsigned int cq_inde
 		if (!(fnic_priv(sc)->flags & (FNIC_IO_ABORTED | FNIC_IO_DONE)))
 			atomic64_inc(&misc_stats->no_icmnd_itmf_cmpls);
 
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
+		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
 			      "abts cmpl recd. id %d status %s\n",
 			      (int)(id & FNIC_TAG_MASK),
 			      fnic_fcpio_status_to_str(hdr_status));
@@ -1239,9 +1237,14 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic, unsigned int cq_inde
 		if (io_req->abts_done) {
 			complete(io_req->abts_done);
 			spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
+			shost_printk(KERN_INFO, fnic->lport->host,
+					"hwq: %d mqtag: 0x%x tag: 0x%x Waking up abort thread\n",
+					hwq, mqtag, tag);
 		} else {
-			FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
-				      "abts cmpl, completing IO\n");
+			FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+				"hwq: %d mqtag: 0x%x tag: 0x%x hst: %s Completing IO\n",
+				hwq, mqtag,
+				tag, fnic_fcpio_status_to_str(hdr_status));
 			fnic_priv(sc)->io_req = NULL;
 			sc->result = (DID_ERROR << 16);
 			fnic->sw_copy_wq[hwq].io_req_table[tag] = NULL;
@@ -1269,6 +1272,10 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic, unsigned int cq_inde
 		}
 	} else if (id & FNIC_TAG_DEV_RST) {
 		/* Completion of device reset */
+		shost_printk(KERN_INFO, fnic->lport->host,
+			"hwq: %d mqtag: 0x%x tag: 0x%x DR hst: %s\n",
+			hwq, mqtag,
+			tag, fnic_fcpio_status_to_str(hdr_status));
 		fnic_priv(sc)->lr_status = hdr_status;
 		if (fnic_priv(sc)->state == FNIC_IOREQ_ABTS_PENDING) {
 			spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
@@ -1277,11 +1284,10 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic, unsigned int cq_inde
 				  sc->device->host->host_no, id, sc,
 				  jiffies_to_msecs(jiffies - start_time),
 				  desc, 0, fnic_flags_and_state(sc));
-			FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
-				"Terminate pending "
-				"dev reset cmpl recd. id %d status %s\n",
-				(int)(id & FNIC_TAG_MASK),
-				fnic_fcpio_status_to_str(hdr_status));
+			FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+				"hwq: %d mqtag: 0x%x tag: 0x%x hst: %s Terminate pending\n",
+				hwq, mqtag,
+				tag, fnic_fcpio_status_to_str(hdr_status));
 			return;
 		}
 		if (fnic_priv(sc)->flags & FNIC_DEV_RST_TIMED_OUT) {
@@ -1291,7 +1297,7 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic, unsigned int cq_inde
 				  sc->device->host->host_no, id, sc,
 				  jiffies_to_msecs(jiffies - start_time),
 				  desc, 0, fnic_flags_and_state(sc));
-			FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
+			FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
 				"dev reset cmpl recd after time out. "
 				"id %d status %s\n",
 				(int)(id & FNIC_TAG_MASK),
@@ -1300,18 +1306,18 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic, unsigned int cq_inde
 		}
 		fnic_priv(sc)->state = FNIC_IOREQ_CMD_COMPLETE;
 		fnic_priv(sc)->flags |= FNIC_DEV_RST_DONE;
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
-			      "dev reset cmpl recd. id %d status %s\n",
-			      (int)(id & FNIC_TAG_MASK),
-			      fnic_fcpio_status_to_str(hdr_status));
+		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			"hwq: %d mqtag: 0x%x tag: 0x%x hst: %s DR completion received\n",
+			hwq, mqtag,
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
 
@@ -1364,7 +1370,7 @@ static int fnic_fcpio_cmpl_handler(struct vnic_dev *vdev,
 		break;
 
 	default:
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
+		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
 			      "firmware completion type %d\n",
 			      desc->hdr.type);
 		break;
@@ -1425,9 +1431,9 @@ static bool fnic_cleanup_io_iter(struct scsi_cmnd *sc, void *data)
 	io_req = fnic_priv(sc)->io_req;
 	if (!io_req) {
 		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
-			"fnic<%d>: %s: %d: hwq: %d mqtag: 0x%x tag: 0x%x flags: 0x%x No ioreq. Returning\n",
-			fnic->fnic_num, __func__, __LINE__, hwq, mqtag, tag, fnic_priv(sc)->flags);
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+			"hwq: %d mqtag: 0x%x tag: 0x%x flags: 0x%x No ioreq. Returning\n",
+			hwq, mqtag, tag, fnic_priv(sc)->flags);
 		return true;
 	}
 
@@ -1462,9 +1468,9 @@ static bool fnic_cleanup_io_iter(struct scsi_cmnd *sc, void *data)
 	mempool_free(io_req, fnic->io_req_pool);
 
 	sc->result = DID_TRANSPORT_DISRUPTED << 16;
-	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
-		      "fnic_cleanup_io: tag:0x%x : sc:0x%p duration = %lu DID_TRANSPORT_DISRUPTED\n",
-		      tag, sc, jiffies - start_time);
+	FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		"mqtag:0x%x tag: 0x%x sc:0x%p duration = %lu DID_TRANSPORT_DISRUPTED\n",
+		mqtag, tag, sc, (jiffies - start_time));
 
 	if (atomic64_read(&fnic->io_cmpl_skip))
 		atomic64_dec(&fnic->io_cmpl_skip);
@@ -1538,7 +1544,7 @@ void fnic_wq_copy_cleanup_handler(struct vnic_wq_copy *wq,
 
 wq_copy_cleanup_scsi_cmd:
 	sc->result = DID_NO_CONNECT << 16;
-	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, "wq_copy_cleanup_handler:"
+	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num, "wq_copy_cleanup_handler:"
 		      " DID_NO_CONNECT\n");
 
 	FNIC_TRACE(fnic_wq_copy_cleanup_handler,
@@ -1578,7 +1584,7 @@ static inline int fnic_queue_abort_io_req(struct fnic *fnic, int tag,
 	if (!vnic_wq_copy_desc_avail(wq)) {
 		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		atomic_dec(&fnic->in_flight);
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
+		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
 			"fnic_queue_abort_io_req: failure: no descriptors\n");
 		atomic64_inc(&misc_stats->abts_cpwq_alloc_failures);
 		return 1;
@@ -1633,9 +1639,9 @@ static bool fnic_rport_abort_io_iter(struct scsi_cmnd *sc, void *data)
 
 	if ((fnic_priv(sc)->flags & FNIC_DEVICE_RESET) &&
 	    !(fnic_priv(sc)->flags & FNIC_DEV_RST_ISSUED)) {
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
-			"fnic_rport_exch_reset dev rst not pending sc 0x%p\n",
-			sc);
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+			"hwq: %d abt_tag: 0x%x flags: 0x%x Device reset is not pending\n",
+			hwq, abt_tag, fnic_priv(sc)->flags);
 		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		return true;
 	}
@@ -1669,11 +1675,11 @@ static bool fnic_rport_abort_io_iter(struct scsi_cmnd *sc, void *data)
 		atomic64_inc(&reset_stats->device_reset_terminates);
 		abt_tag |= FNIC_TAG_DEV_RST;
 	}
-	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
+	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
 		      "fnic_rport_exch_reset dev rst sc 0x%p\n", sc);
 	BUG_ON(io_req->abts_done);
 
-	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
+	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
 		      "fnic_rport_reset_exch: Issuing abts\n");
 
 	spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
@@ -1691,6 +1697,9 @@ static bool fnic_rport_abort_io_iter(struct scsi_cmnd *sc, void *data)
 		 * lun reset
 		 */
 		spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+			"hwq: %d abt_tag: 0x%x flags: 0x%x Queuing abort failed\n",
+			hwq, abt_tag, fnic_priv(sc)->flags);
 		if (fnic_priv(sc)->state == FNIC_IOREQ_ABTS_PENDING)
 			fnic_priv(sc)->state = old_ioreq_state;
 		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
@@ -1717,7 +1726,7 @@ static void fnic_rport_exch_reset(struct fnic *fnic, u32 port_id)
 	};
 
 	FNIC_SCSI_DBG(KERN_DEBUG,
-		      fnic->lport->host,
+		      fnic->lport->host, fnic->fnic_num,
 		      "fnic_rport_exch_reset called portid 0x%06x\n",
 		      port_id);
 
@@ -1754,9 +1763,8 @@ void fnic_terminate_rport_io(struct fc_rport *rport)
 		return;
 	}
 	fnic = lport_priv(lport);
-	FNIC_SCSI_DBG(KERN_DEBUG,
-		      fnic->lport->host, "fnic_terminate_rport_io called"
-		      " wwpn 0x%llx, wwnn0x%llx, rport 0x%p, portid 0x%06x\n",
+	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+		      "wwpn 0x%llx, wwnn0x%llx, rport 0x%p, portid 0x%06x\n",
 		      rport->port_name, rport->node_name, rport,
 		      rport->port_id);
 
@@ -1861,8 +1869,9 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 	else
 		atomic64_inc(&abts_stats->abort_issued_greater_than_60_sec);
 
-	FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
-		"CBD Opcode: %02x Abort issued time: %lu msec\n", sc->cmnd[0], abt_issued_time);
+	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+		"CDB Opcode: 0x%02x Abort issued time: %lu msec\n",
+		sc->cmnd[0], abt_issued_time);
 	/*
 	 * Command is still pending, need to abort it
 	 * If the firmware completes the command after this point,
@@ -1951,8 +1960,8 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 
 	if (!(fnic_priv(sc)->flags & (FNIC_IO_ABORTED | FNIC_IO_DONE))) {
 		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
-			"Issuing Host reset due to out of order IO\n");
+	    FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+			"Issuing host reset due to out of order IO\n");
 
 		ret = FAILED;
 		goto fnic_abort_cmd_end;
@@ -1999,7 +2008,7 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 		  (u64)sc->cmnd[4] << 8 | sc->cmnd[5]),
 		  fnic_flags_and_state(sc));
 
-	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
+	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
 		      "Returning from abort cmd type %x %s\n", task_req,
 		      (ret == SUCCESS) ?
 		      "SUCCESS" : "FAILED");
@@ -2037,7 +2046,7 @@ static inline int fnic_queue_dr_io_req(struct fnic *fnic,
 		free_wq_copy_descs(fnic, wq, hwq);
 
 	if (!vnic_wq_copy_desc_avail(wq)) {
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
+		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
 			  "queue_dr_io_req failure - no descriptors\n");
 		atomic64_inc(&misc_stats->devrst_cpwq_alloc_failures);
 		ret = -EAGAIN;
@@ -2103,7 +2112,7 @@ static bool fnic_pending_aborts_iter(struct scsi_cmnd *sc, void *data)
 	 * Found IO that is still pending with firmware and
 	 * belongs to the LUN that we are resetting
 	 */
-	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
+	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
 		      "Found IO in %s on lun\n",
 		      fnic_ioreq_state_to_str(fnic_priv(sc)->state));
 
@@ -2113,9 +2122,8 @@ static bool fnic_pending_aborts_iter(struct scsi_cmnd *sc, void *data)
 	}
 	if ((fnic_priv(sc)->flags & FNIC_DEVICE_RESET) &&
 	    (!(fnic_priv(sc)->flags & FNIC_DEV_RST_ISSUED))) {
-		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
-			      "%s dev rst not pending sc 0x%p\n", __func__,
-			      sc);
+		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			      "dev rst not pending sc 0x%p\n", sc);
 		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		return true;
 	}
@@ -2137,8 +2145,8 @@ static bool fnic_pending_aborts_iter(struct scsi_cmnd *sc, void *data)
 	BUG_ON(io_req->abts_done);
 
 	if (fnic_priv(sc)->flags & FNIC_DEVICE_RESET) {
-		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
-			      "%s: dev rst sc 0x%p\n", __func__, sc);
+		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			      "dev rst sc 0x%p\n", sc);
 	}
 
 	fnic_priv(sc)->abts_status = FCPIO_INVALID_CODE;
@@ -2159,6 +2167,9 @@ static bool fnic_pending_aborts_iter(struct scsi_cmnd *sc, void *data)
 			fnic_priv(sc)->state = old_ioreq_state;
 		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		iter_data->ret = FAILED;
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+			"hwq: %d abt_tag: 0x%lx Abort could not be queued\n",
+			hwq, abt_tag);
 		return false;
 	} else {
 		spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
@@ -2249,8 +2260,8 @@ static int fnic_clean_pending_aborts(struct fnic *fnic,
 		ret = 1;
 
 clean_pending_aborts_end:
-	FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
-			"%s: exit status: %d\n", __func__, ret);
+	FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			"exit status: %d\n", ret);
 	return ret;
 }
 
@@ -2291,9 +2302,10 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 	atomic64_inc(&reset_stats->device_resets);
 
 	rport = starget_to_rport(scsi_target(sc->device));
-	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
-		      "Device reset called FCID 0x%x, LUN 0x%llx sc 0x%p\n",
-		      rport->port_id, sc->device->lun, sc);
+	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+		"fcid: 0x%x lun: 0x%llx hwq: %d mqtag: 0x%x flags: 0x%x Device reset\n",
+		rport->port_id, sc->device->lun, hwq, mqtag,
+		fnic_priv(sc)->flags);
 
 	if (lp->state != LPORT_ST_READY || !(lp->link_up))
 		goto fnic_device_reset_end;
@@ -2353,7 +2365,7 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 	fnic_priv(sc)->lr_status = FCPIO_INVALID_CODE;
 	spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 
-	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, "TAG %x\n", mqtag);
+	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num, "TAG %x\n", mqtag);
 
 	/*
 	 * issue the device reset, if enqueue failed, clean up the ioreq
@@ -2381,7 +2393,7 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 	io_req = fnic_priv(sc)->io_req;
 	if (!io_req) {
 		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
+		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
 				"io_req is null mqtag 0x%x sc 0x%p\n", mqtag, sc);
 		goto fnic_device_reset_end;
 	}
@@ -2395,7 +2407,7 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 	 */
 	if (status == FCPIO_INVALID_CODE) {
 		atomic64_inc(&reset_stats->device_reset_timeouts);
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
+		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
 			      "Device reset timed out\n");
 		fnic_priv(sc)->flags |= FNIC_DEV_RST_TIMED_OUT;
 		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
@@ -2423,7 +2435,7 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 				fnic_priv(sc)->state = FNIC_IOREQ_ABTS_PENDING;
 				io_req->abts_done = &tm_done;
 				spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
-				FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
+				FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
 				"Abort and terminate issued on Device reset mqtag 0x%x sc 0x%p\n",
 				mqtag, sc);
 				break;
@@ -2450,7 +2462,7 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 	if (status != FCPIO_SUCCESS) {
 		spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
 		FNIC_SCSI_DBG(KERN_DEBUG,
-			      fnic->lport->host,
+			      fnic->lport->host, fnic->fnic_num,
 			      "Device reset completed - failed\n");
 		io_req = fnic_priv(sc)->io_req;
 		goto fnic_device_reset_clean;
@@ -2466,7 +2478,7 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 	if (fnic_clean_pending_aborts(fnic, sc, new_sc)) {
 		spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
 		io_req = fnic_priv(sc)->io_req;
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
+		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
 			      "Device reset failed"
 			      " since could not abort all IOs\n");
 		goto fnic_device_reset_clean;
@@ -2505,7 +2517,7 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 	if (new_sc)
 		mutex_unlock(&fnic->sgreset_mutex);
 
-	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
+	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
 		      "Returning from device reset %s\n",
 		      (ret == SUCCESS) ?
 		      "SUCCESS" : "FAILED");
@@ -2528,8 +2540,8 @@ int fnic_reset(struct Scsi_Host *shost)
 	fnic = lport_priv(lp);
 	reset_stats = &fnic->fnic_stats.reset_stats;
 
-	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
-		      "fnic_reset called\n");
+	FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			"Issuing fnic reset\n");
 
 	atomic64_inc(&reset_stats->fnic_resets);
 
@@ -2539,10 +2551,9 @@ int fnic_reset(struct Scsi_Host *shost)
 	 */
 	ret = fc_lport_reset(lp);
 
-	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
-		      "Returning from fnic reset %s\n",
-		      (ret == 0) ?
-		      "SUCCESS" : "FAILED");
+	FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		"Returning from fnic reset with: %s\n",
+		(ret == 0) ? "SUCCESS" : "FAILED");
 
 	if (ret == 0)
 		atomic64_inc(&reset_stats->fnic_reset_completions);
@@ -2575,7 +2586,7 @@ int fnic_host_reset(struct scsi_cmnd *sc)
 		fnic->internal_reset_inprogress = true;
 	} else {
 		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
+		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
 			"host reset in progress skipping another host reset\n");
 		return SUCCESS;
 	}
@@ -2650,7 +2661,7 @@ void fnic_scsi_abort_io(struct fc_lport *lp)
 
 	spin_lock_irqsave(&fnic->fnic_lock, flags);
 	fnic->remove_wait = NULL;
-	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
+	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
 		      "fnic_scsi_abort_io %s\n",
 		      (fnic->state == FNIC_IN_ETH_MODE) ?
 		      "SUCCESS" : "FAILED");
@@ -2757,9 +2768,10 @@ static bool fnic_abts_pending_iter(struct scsi_cmnd *sc, void *data)
 	 * Found IO that is still pending with firmware and
 	 * belongs to the LUN that we are resetting
 	 */
-	FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
-		      "Found IO in %s on lun\n",
-		      fnic_ioreq_state_to_str(fnic_priv(sc)->state));
+	FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		"hwq: %d tag: 0x%x Found IO in state: %s on lun\n",
+		hwq, tag,
+		fnic_ioreq_state_to_str(fnic_priv(sc)->state));
 	cmd_state = fnic_priv(sc)->state;
 	spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 	if (cmd_state == FNIC_IOREQ_ABTS_PENDING)
-- 
2.31.1

