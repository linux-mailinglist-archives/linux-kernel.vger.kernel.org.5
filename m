Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61A67D9F54
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346446AbjJ0SER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346442AbjJ0SD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:03:56 -0400
Received: from alln-iport-1.cisco.com (alln-iport-1.cisco.com [173.37.142.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B4110FB;
        Fri, 27 Oct 2023 11:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3648; q=dns/txt; s=iport;
  t=1698429827; x=1699639427;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZMSQe9mdkW5xEKe9HP1NH7xCq2D6OUVO+7WD8rJZ7u0=;
  b=EqVqg4zqGOxTd7FDUR0iKyxjnRIYezh8zSbxVyFCDFotKcz5XNXVe+Kg
   rlrRXLOtURvWGFFrNVmTnfoFQWAXyPEXyGNPkUX7f7BgKfA1dNkYtKoZv
   p2izgVVgcvt5ruGfzk6dxvITnG0QXmuJNuDDiztnxRYZlLE83LWiwameF
   s=;
X-CSE-ConnectionGUID: lSi9T67pT7WPMFWQu0ZQ+Q==
X-CSE-MsgGUID: +zeHnyUqSpaPPB00+ydDdA==
X-IronPort-AV: E=Sophos;i="6.03,256,1694736000"; 
   d="scan'208";a="187094586"
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
  by alln-iport-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 18:03:46 +0000
Received: from localhost.cisco.com ([10.193.101.253])
        (authenticated bits=0)
        by rcdn-core-11.cisco.com (8.15.2/8.15.2) with ESMTPSA id 39RI39On029226
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 27 Oct 2023 18:03:45 GMT
From:   Karan Tilak Kumar <kartilak@cisco.com>
To:     sebaddel@cisco.com
Cc:     arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
        mkai2@cisco.com, satishkh@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Karan Tilak Kumar <kartilak@cisco.com>
Subject: [PATCH v2 11/13] scsi: fnic: Use fnic_lock to protect fnic structures in queuecommand
Date:   Fri, 27 Oct 2023 11:03:00 -0700
Message-Id: <20231027180302.418676-12-kartilak@cisco.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231027180302.418676-1-kartilak@cisco.com>
References: <20231027180302.418676-1-kartilak@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: kartilak@cisco.com
X-Outbound-SMTP-Client: 10.193.101.253, [10.193.101.253]
X-Outbound-Node: rcdn-core-11.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fnic does not use host_lock. fnic uses fnic_lock.
Use fnic lock to protect fnic members in fnic_queuecommand.
Add log messages in error cases.

Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
---
 drivers/scsi/fnic/fnic_scsi.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
index 9a1beb3e7269..ffdbdbfcdf57 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -424,14 +424,27 @@ static int fnic_queuecommand_lck(struct scsi_cmnd *sc)
 	int io_lock_acquired = 0;
 	struct fc_rport_libfc_priv *rp;
 
-	if (unlikely(fnic_chk_state_flags_locked(fnic, FNIC_FLAGS_IO_BLOCKED)))
+	spin_lock_irqsave(&fnic->fnic_lock, flags);
+
+	if (unlikely(fnic_chk_state_flags_locked(fnic, FNIC_FLAGS_IO_BLOCKED))) {
+		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
+			"fnic<%d>: %s: %d: fnic IO blocked flags: 0x%lx. Returning SCSI_MLQUEUE_HOST_BUSY\n",
+			fnic->fnic_num, __func__, __LINE__, fnic->state_flags);
 		return SCSI_MLQUEUE_HOST_BUSY;
+	}
 
-	if (unlikely(fnic_chk_state_flags_locked(fnic, FNIC_FLAGS_FWRESET)))
+	if (unlikely(fnic_chk_state_flags_locked(fnic, FNIC_FLAGS_FWRESET))) {
+		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
+			"fnic<%d>: %s: %d: fnic flags: 0x%lx. Returning SCSI_MLQUEUE_HOST_BUSY\n",
+			fnic->fnic_num, __func__, __LINE__, fnic->state_flags);
 		return SCSI_MLQUEUE_HOST_BUSY;
+	}
 
 	rport = starget_to_rport(scsi_target(sc->device));
 	if (!rport) {
+		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
 				"returning DID_NO_CONNECT for IO as rport is NULL\n");
 		sc->result = DID_NO_CONNECT << 16;
@@ -441,6 +454,7 @@ static int fnic_queuecommand_lck(struct scsi_cmnd *sc)
 
 	ret = fc_remote_port_chkready(rport);
 	if (ret) {
+		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
 				"rport is not ready\n");
 		atomic64_inc(&fnic_stats->misc_stats.rport_not_ready);
@@ -451,6 +465,7 @@ static int fnic_queuecommand_lck(struct scsi_cmnd *sc)
 
 	rp = rport->dd_data;
 	if (!rp || rp->rp_state == RPORT_ST_DELETE) {
+		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
 			"rport 0x%x removed, returning DID_NO_CONNECT\n",
 			rport->port_id);
@@ -462,6 +477,7 @@ static int fnic_queuecommand_lck(struct scsi_cmnd *sc)
 	}
 
 	if (rp->rp_state != RPORT_ST_READY) {
+		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
 			"rport 0x%x in state 0x%x, returning DID_IMM_RETRY\n",
 			rport->port_id, rp->rp_state);
@@ -471,11 +487,17 @@ static int fnic_queuecommand_lck(struct scsi_cmnd *sc)
 		return 0;
 	}
 
-	if (lp->state != LPORT_ST_READY || !(lp->link_up))
+	if (lp->state != LPORT_ST_READY || !(lp->link_up)) {
+		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
+			"fnic<%d>: %s: %d: state not ready: %d/link not up: %d Returning HOST_BUSY\n",
+			fnic->fnic_num, __func__, __LINE__, lp->state, lp->link_up);
 		return SCSI_MLQUEUE_HOST_BUSY;
+	}
 
 	atomic_inc(&fnic->in_flight);
 
+	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 	fnic_priv(sc)->state = FNIC_IOREQ_NOT_INITED;
 	fnic_priv(sc)->flags = FNIC_NO_FLAGS;
 
-- 
2.31.1

