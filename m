Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6748B7D1629
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 21:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjJTTHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 15:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjJTTHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 15:07:20 -0400
Received: from rcdn-iport-7.cisco.com (rcdn-iport-7.cisco.com [173.37.86.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C49910CE;
        Fri, 20 Oct 2023 12:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3879; q=dns/txt; s=iport;
  t=1697828837; x=1699038437;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hZgDvmmCEAxvPN4JkZ38Ljv3qILjjtSEDDA9V6Ihu/s=;
  b=Y4k2rjY0KboSYN1kVMz0iW2zNTF+GScqTVLaWKWnFbYsjW6UfXjNBKys
   TEOPM3FMLElksYdCg06Knux5qLkQJjHz5yqPIh6ps1qEmXbEDsdAY6Y6E
   ka+vZkceDGTyCDgrGlTkheFKiAvYDEqkHFHBDb4eQtPrvgJLHPl2br+QX
   8=;
X-CSE-ConnectionGUID: uknWTbhaT7aHbKUh/XUSUA==
X-CSE-MsgGUID: 7Jhf3EGIQ6ybieU/1iB7tw==
X-IronPort-AV: E=Sophos;i="6.03,239,1694736000"; 
   d="scan'208";a="126421366"
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
  by rcdn-iport-7.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 19:07:17 +0000
Received: from localhost.cisco.com ([10.193.101.253])
        (authenticated bits=0)
        by rcdn-core-11.cisco.com (8.15.2/8.15.2) with ESMTPSA id 39KJ6XPL026372
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 20 Oct 2023 19:07:16 GMT
From:   Karan Tilak Kumar <kartilak@cisco.com>
To:     sebaddel@cisco.com
Cc:     arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
        mkai2@cisco.com, satishkh@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Karan Tilak Kumar <kartilak@cisco.com>
Subject: [PATCH 09/13] scsi: fnic: Remove usage of host_lock
Date:   Fri, 20 Oct 2023 12:06:25 -0700
Message-Id: <20231020190629.338623-10-kartilak@cisco.com>
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

Remove usage of host_lock.
Replace with fnic_lock, where necessary.

Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
---
 drivers/scsi/fnic/fnic_scsi.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
index f32781f8fdd0..9a1beb3e7269 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -170,17 +170,14 @@ __fnic_set_state_flags(struct fnic *fnic, unsigned long st_flags,
 			unsigned long clearbits)
 {
 	unsigned long flags = 0;
-	unsigned long host_lock_flags = 0;
 
 	spin_lock_irqsave(&fnic->fnic_lock, flags);
-	spin_lock_irqsave(fnic->lport->host->host_lock, host_lock_flags);
 
 	if (clearbits)
 		fnic->state_flags &= ~st_flags;
 	else
 		fnic->state_flags |= st_flags;
 
-	spin_unlock_irqrestore(fnic->lport->host->host_lock, host_lock_flags);
 	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 
 	return;
@@ -479,12 +476,6 @@ static int fnic_queuecommand_lck(struct scsi_cmnd *sc)
 
 	atomic_inc(&fnic->in_flight);
 
-	/*
-	 * Release host lock, use driver resource specific locks from here.
-	 * Don't re-enable interrupts in case they were disabled prior to the
-	 * caller disabling them.
-	 */
-	spin_unlock(lp->host->host_lock);
 	fnic_priv(sc)->state = FNIC_IOREQ_NOT_INITED;
 	fnic_priv(sc)->flags = FNIC_NO_FLAGS;
 
@@ -569,8 +560,6 @@ static int fnic_queuecommand_lck(struct scsi_cmnd *sc)
 			mempool_free(io_req, fnic->io_req_pool);
 		}
 		atomic_dec(&fnic->in_flight);
-		/* acquire host lock before returning to SCSI */
-		spin_lock(lp->host->host_lock);
 		return ret;
 	} else {
 		atomic64_inc(&fnic_stats->io_stats.active_ios);
@@ -598,8 +587,6 @@ static int fnic_queuecommand_lck(struct scsi_cmnd *sc)
 		spin_unlock_irqrestore(io_lock, flags);
 
 	atomic_dec(&fnic->in_flight);
-	/* acquire host lock before returning to SCSI */
-	spin_lock(lp->host->host_lock);
 	return ret;
 }
 
@@ -1477,18 +1464,17 @@ static inline int fnic_queue_abort_io_req(struct fnic *fnic, int tag,
 					  struct fnic_io_req *io_req)
 {
 	struct vnic_wq_copy *wq = &fnic->hw_copy_wq[0];
-	struct Scsi_Host *host = fnic->lport->host;
 	struct misc_stats *misc_stats = &fnic->fnic_stats.misc_stats;
 	unsigned long flags;
 
-	spin_lock_irqsave(host->host_lock, flags);
+	spin_lock_irqsave(&fnic->fnic_lock, flags);
 	if (unlikely(fnic_chk_state_flags_locked(fnic,
 						FNIC_FLAGS_IO_BLOCKED))) {
-		spin_unlock_irqrestore(host->host_lock, flags);
+		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 		return 1;
 	} else
 		atomic_inc(&fnic->in_flight);
-	spin_unlock_irqrestore(host->host_lock, flags);
+	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 
 	spin_lock_irqsave(&fnic->wq_copy_lock[0], flags);
 
@@ -1923,20 +1909,19 @@ static inline int fnic_queue_dr_io_req(struct fnic *fnic,
 				       struct fnic_io_req *io_req)
 {
 	struct vnic_wq_copy *wq = &fnic->hw_copy_wq[0];
-	struct Scsi_Host *host = fnic->lport->host;
 	struct misc_stats *misc_stats = &fnic->fnic_stats.misc_stats;
 	struct scsi_lun fc_lun;
 	int ret = 0;
 	unsigned long intr_flags;
 
-	spin_lock_irqsave(host->host_lock, intr_flags);
+	spin_lock_irqsave(&fnic->fnic_lock, intr_flags);
 	if (unlikely(fnic_chk_state_flags_locked(fnic,
 						FNIC_FLAGS_IO_BLOCKED))) {
-		spin_unlock_irqrestore(host->host_lock, intr_flags);
+		spin_unlock_irqrestore(&fnic->fnic_lock, intr_flags);
 		return FAILED;
 	} else
 		atomic_inc(&fnic->in_flight);
-	spin_unlock_irqrestore(host->host_lock, intr_flags);
+	spin_unlock_irqrestore(&fnic->fnic_lock, intr_flags);
 
 	spin_lock_irqsave(&fnic->wq_copy_lock[0], intr_flags);
 
-- 
2.31.1

