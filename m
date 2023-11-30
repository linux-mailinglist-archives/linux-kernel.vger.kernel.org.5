Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E697FE6E6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 03:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344273AbjK3Cgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 21:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjK3Cg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 21:36:29 -0500
Received: from rcdn-iport-2.cisco.com (rcdn-iport-2.cisco.com [173.37.86.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4647510CE;
        Wed, 29 Nov 2023 18:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=57375; q=dns/txt;
  s=iport; t=1701311777; x=1702521377;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jwpwkc3CkEartf5sIJWXYZ5qJB2RmZJRe3/ni5Pt9G4=;
  b=j6jRcBp35lsnmdMc7FINVJsKhjUhlzdtzysmTrOvml5qMm/EtxEP7MPr
   s0aC0VNGHnNe383RPeutqy/kDXxUx4H29s9N9rsS4vYvq+9Y0QQcc53V3
   6wROTHxd5Og22NxnS3B9C37peTm2P+tc5aw5iPbAyugH8FdjvzQUgPrIk
   w=;
X-CSE-ConnectionGUID: BfzmfY07RLOb1WsvObPmbA==
X-CSE-MsgGUID: BHEKh/svScmRjDnFlIWVCA==
X-IronPort-AV: E=Sophos;i="6.04,237,1695686400"; 
   d="scan'208";a="149783437"
Received: from rcdn-core-9.cisco.com ([173.37.93.145])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 02:36:16 +0000
Received: from localhost.cisco.com ([10.193.101.253])
        (authenticated bits=0)
        by rcdn-core-9.cisco.com (8.15.2/8.15.2) with ESMTPSA id 3AU2YA4D007614
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 30 Nov 2023 02:36:15 GMT
From:   Karan Tilak Kumar <kartilak@cisco.com>
To:     sebaddel@cisco.com
Cc:     arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
        mkai2@cisco.com, satishkh@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Karan Tilak Kumar <kartilak@cisco.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v4 11/13] scsi: fnic: Add support for multiqueue (MQ) in fnic driver
Date:   Wed, 29 Nov 2023 18:34:00 -0800
Message-Id: <20231130023402.802282-12-kartilak@cisco.com>
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

Implement support for MQ in fnic driver:

The block multiqueue layer issues IO to the fnic driver
with an MQ tag. Use the mqtag and derive a tag from it.
Derive the hardware queue from the mqtag and use it
in all paths. Modify queuecommand to handle mqtag.

Replace wq and cq indices to support MQ. Replace the
zeroth queue with a hardware queue.
Implement spin locks on a per hardware queue basis.
Replace io_lock with per hardware queue spinlock.
Implement out of range tag checks.

Allocate an io_req_table to track status of the io_req.

Test the driver by building it, loading it,
and configuring 64 queues in UCSM. Issue IOs using
Medusa on multiple fnics. Enable/disable links to exercise
the abort and clean up path.

Changes between v2 and v3:
    Incorporate the following review comments from Hannes:
        Replace cpy_wq_base with copy_wq_base.
	Remove hwq as an argument to fnic_queuecommand_int.
    Suppress warning from kernel test robot.
    Replace new shost_printk comments with FNIC_SCSI_DBG.
    Replace fnic_queuecommand_int with fnic_queuecommand.

Changes between v1 and v2:
    Incorporate the following review comments from Bart:
    Remove outdated comment,
    Remove unnecessary out of range tag checks,
    Remove unnecessary local variable,
    Modify function name.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310300032.2awCqkfn-lkp@intel.com/
Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Tested-by: Karan Tilak Kumar <kartilak@cisco.com>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
---
 drivers/scsi/fnic/fnic.h      |   2 -
 drivers/scsi/fnic/fnic_io.h   |   2 +
 drivers/scsi/fnic/fnic_main.c |   3 -
 drivers/scsi/fnic/fnic_scsi.c | 567 ++++++++++++++++++++--------------
 4 files changed, 340 insertions(+), 234 deletions(-)

diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
index 5777a54c99c3..d5b9590894d2 100644
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -36,7 +36,6 @@
 #define FNIC_MIN_IO_REQ			256 /* Min IO throttle count */
 #define FNIC_MAX_IO_REQ		1024 /* scsi_cmnd tag map entries */
 #define FNIC_DFLT_IO_REQ        256 /* Default scsi_cmnd tag map entries */
-#define	FNIC_IO_LOCKS		64 /* IO locks: power of 2 */
 #define FNIC_DFLT_QUEUE_DEPTH	256
 #define	FNIC_STATS_RATE_LIMIT	4 /* limit rate at which stats are pulled up */
 
@@ -298,7 +297,6 @@ struct fnic {
 	struct fnic_host_tag *tags;
 	mempool_t *io_req_pool;
 	mempool_t *io_sgl_pool[FNIC_SGL_NUM_CACHES];
-	spinlock_t io_req_lock[FNIC_IO_LOCKS];	/* locks for scsi cmnds */
 
 	unsigned int copy_wq_base;
 	struct work_struct link_work;
diff --git a/drivers/scsi/fnic/fnic_io.h b/drivers/scsi/fnic/fnic_io.h
index f4c8769df312..5895ead20e14 100644
--- a/drivers/scsi/fnic/fnic_io.h
+++ b/drivers/scsi/fnic/fnic_io.h
@@ -52,6 +52,8 @@ struct fnic_io_req {
 	unsigned long start_time; /* in jiffies */
 	struct completion *abts_done; /* completion for abts */
 	struct completion *dr_done; /* completion for device reset */
+	unsigned int tag;
+	struct scsi_cmnd *sc; /* midlayer's cmd pointer */
 };
 
 enum fnic_port_speeds {
diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
index 4ce933d5c15f..5ed1d897311a 100644
--- a/drivers/scsi/fnic/fnic_main.c
+++ b/drivers/scsi/fnic/fnic_main.c
@@ -794,9 +794,6 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		fnic->fw_ack_index[i] = -1;
 	}
 
-	for (i = 0; i < FNIC_IO_LOCKS; i++)
-		spin_lock_init(&fnic->io_req_lock[i]);
-
 	err = -ENOMEM;
 	fnic->io_req_pool = mempool_create_slab_pool(2, fnic_io_req_cache);
 	if (!fnic->io_req_pool)
diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
index ffdbdbfcdf57..648cb8aff92c 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -92,20 +92,6 @@ static const char *fnic_fcpio_status_to_str(unsigned int status)
 
 static void fnic_cleanup_io(struct fnic *fnic);
 
-static inline spinlock_t *fnic_io_lock_hash(struct fnic *fnic,
-					    struct scsi_cmnd *sc)
-{
-	u32 hash = scsi_cmd_to_rq(sc)->tag & (FNIC_IO_LOCKS - 1);
-
-	return &fnic->io_req_lock[hash];
-}
-
-static inline spinlock_t *fnic_io_lock_tag(struct fnic *fnic,
-					    int tag)
-{
-	return &fnic->io_req_lock[tag & (FNIC_IO_LOCKS - 1)];
-}
-
 /*
  * Unmap the data buffer and sense buffer for an io_req,
  * also unmap and free the device-private scatter/gather list.
@@ -129,23 +115,23 @@ static void fnic_release_ioreq_buf(struct fnic *fnic,
 }
 
 /* Free up Copy Wq descriptors. Called with copy_wq lock held */
-static int free_wq_copy_descs(struct fnic *fnic, struct vnic_wq_copy *wq)
+static int free_wq_copy_descs(struct fnic *fnic, struct vnic_wq_copy *wq, unsigned int hwq)
 {
 	/* if no Ack received from firmware, then nothing to clean */
-	if (!fnic->fw_ack_recd[0])
+	if (!fnic->fw_ack_recd[hwq])
 		return 1;
 
 	/*
 	 * Update desc_available count based on number of freed descriptors
 	 * Account for wraparound
 	 */
-	if (wq->to_clean_index <= fnic->fw_ack_index[0])
-		wq->ring.desc_avail += (fnic->fw_ack_index[0]
+	if (wq->to_clean_index <= fnic->fw_ack_index[hwq])
+		wq->ring.desc_avail += (fnic->fw_ack_index[hwq]
 					- wq->to_clean_index + 1);
 	else
 		wq->ring.desc_avail += (wq->ring.desc_count
 					- wq->to_clean_index
-					+ fnic->fw_ack_index[0] + 1);
+					+ fnic->fw_ack_index[hwq] + 1);
 
 	/*
 	 * just bump clean index to ack_index+1 accounting for wraparound
@@ -153,10 +139,10 @@ static int free_wq_copy_descs(struct fnic *fnic, struct vnic_wq_copy *wq)
 	 * to_clean_index and fw_ack_index, both inclusive
 	 */
 	wq->to_clean_index =
-		(fnic->fw_ack_index[0] + 1) % wq->ring.desc_count;
+		(fnic->fw_ack_index[hwq] + 1) % wq->ring.desc_count;
 
 	/* we have processed the acks received so far */
-	fnic->fw_ack_recd[0] = 0;
+	fnic->fw_ack_recd[hwq] = 0;
 	return 0;
 }
 
@@ -207,7 +193,7 @@ int fnic_fw_reset_handler(struct fnic *fnic)
 	spin_lock_irqsave(&fnic->wq_copy_lock[0], flags);
 
 	if (vnic_wq_copy_desc_avail(wq) <= fnic->wq_copy_desc_low[0])
-		free_wq_copy_descs(fnic, wq);
+		free_wq_copy_descs(fnic, wq, 0);
 
 	if (!vnic_wq_copy_desc_avail(wq))
 		ret = -EAGAIN;
@@ -253,7 +239,7 @@ int fnic_flogi_reg_handler(struct fnic *fnic, u32 fc_id)
 	spin_lock_irqsave(&fnic->wq_copy_lock[0], flags);
 
 	if (vnic_wq_copy_desc_avail(wq) <= fnic->wq_copy_desc_low[0])
-		free_wq_copy_descs(fnic, wq);
+		free_wq_copy_descs(fnic, wq, 0);
 
 	if (!vnic_wq_copy_desc_avail(wq)) {
 		ret = -EAGAIN;
@@ -303,7 +289,9 @@ static inline int fnic_queue_wq_copy_desc(struct fnic *fnic,
 					  struct vnic_wq_copy *wq,
 					  struct fnic_io_req *io_req,
 					  struct scsi_cmnd *sc,
-					  int sg_count)
+					  int sg_count,
+					  uint32_t mqtag,
+					  uint16_t hwq)
 {
 	struct scatterlist *sg;
 	struct fc_rport *rport = starget_to_rport(scsi_target(sc->device));
@@ -311,7 +299,6 @@ static inline int fnic_queue_wq_copy_desc(struct fnic *fnic,
 	struct host_sg_desc *desc;
 	struct misc_stats *misc_stats = &fnic->fnic_stats.misc_stats;
 	unsigned int i;
-	unsigned long intr_flags;
 	int flags;
 	u8 exch_flags;
 	struct scsi_lun fc_lun;
@@ -351,13 +338,10 @@ static inline int fnic_queue_wq_copy_desc(struct fnic *fnic,
 	int_to_scsilun(sc->device->lun, &fc_lun);
 
 	/* Enqueue the descriptor in the Copy WQ */
-	spin_lock_irqsave(&fnic->wq_copy_lock[0], intr_flags);
-
-	if (vnic_wq_copy_desc_avail(wq) <= fnic->wq_copy_desc_low[0])
-		free_wq_copy_descs(fnic, wq);
+	if (vnic_wq_copy_desc_avail(wq) <= fnic->wq_copy_desc_low[hwq])
+		free_wq_copy_descs(fnic, wq, hwq);
 
 	if (unlikely(!vnic_wq_copy_desc_avail(wq))) {
-		spin_unlock_irqrestore(&fnic->wq_copy_lock[0], intr_flags);
 		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
 			  "fnic_queue_wq_copy_desc failure - no descriptors\n");
 		atomic64_inc(&misc_stats->io_cpwq_alloc_failures);
@@ -375,7 +359,7 @@ static inline int fnic_queue_wq_copy_desc(struct fnic *fnic,
 	    (rp->flags & FC_RP_FLAGS_RETRY))
 		exch_flags |= FCPIO_ICMND_SRFLAG_RETRY;
 
-	fnic_queue_wq_copy_desc_icmnd_16(wq, scsi_cmd_to_rq(sc)->tag,
+	fnic_queue_wq_copy_desc_icmnd_16(wq, mqtag,
 					 0, exch_flags, io_req->sgl_cnt,
 					 SCSI_SENSE_BUFFERSIZE,
 					 io_req->sgl_list_pa,
@@ -396,34 +380,30 @@ static inline int fnic_queue_wq_copy_desc(struct fnic *fnic,
 		atomic64_set(&fnic->fnic_stats.fw_stats.max_fw_reqs,
 		  atomic64_read(&fnic->fnic_stats.fw_stats.active_fw_reqs));
 
-	spin_unlock_irqrestore(&fnic->wq_copy_lock[0], intr_flags);
 	return 0;
 }
 
-/*
- * fnic_queuecommand
- * Routine to send a scsi cdb
- * Called with host_lock held and interrupts disabled.
- */
-static int fnic_queuecommand_lck(struct scsi_cmnd *sc)
+int fnic_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *sc)
 {
+	struct request *const rq = scsi_cmd_to_rq(sc);
+	uint32_t mqtag = 0;
 	void (*done)(struct scsi_cmnd *) = scsi_done;
-	const int tag = scsi_cmd_to_rq(sc)->tag;
 	struct fc_lport *lp = shost_priv(sc->device->host);
 	struct fc_rport *rport;
 	struct fnic_io_req *io_req = NULL;
 	struct fnic *fnic = lport_priv(lp);
 	struct fnic_stats *fnic_stats = &fnic->fnic_stats;
 	struct vnic_wq_copy *wq;
-	int ret;
+	int ret = 1;
 	u64 cmd_trace;
 	int sg_count = 0;
 	unsigned long flags = 0;
 	unsigned long ptr;
-	spinlock_t *io_lock = NULL;
 	int io_lock_acquired = 0;
 	struct fc_rport_libfc_priv *rp;
+	uint16_t hwq = 0;
 
+	mqtag = blk_mq_unique_tag(rq);
 	spin_lock_irqsave(&fnic->fnic_lock, flags);
 
 	if (unlikely(fnic_chk_state_flags_locked(fnic, FNIC_FLAGS_IO_BLOCKED))) {
@@ -514,7 +494,7 @@ static int fnic_queuecommand_lck(struct scsi_cmnd *sc)
 	sg_count = scsi_dma_map(sc);
 	if (sg_count < 0) {
 		FNIC_TRACE(fnic_queuecommand, sc->device->host->host_no,
-			  tag, sc, 0, sc->cmnd[0], sg_count, fnic_priv(sc)->state);
+			  mqtag, sc, 0, sc->cmnd[0], sg_count, fnic_priv(sc)->state);
 		mempool_free(io_req, fnic->io_req_pool);
 		goto out;
 	}
@@ -549,11 +529,10 @@ static int fnic_queuecommand_lck(struct scsi_cmnd *sc)
 	}
 
 	/*
-	* Will acquire lock defore setting to IO initialized.
+	* Will acquire lock before setting to IO initialized.
 	*/
-
-	io_lock = fnic_io_lock_hash(fnic, sc);
-	spin_lock_irqsave(io_lock, flags);
+	hwq = blk_mq_unique_tag_to_hwq(mqtag);
+	spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
 
 	/* initialize rest of io_req */
 	io_lock_acquired = 1;
@@ -562,21 +541,34 @@ static int fnic_queuecommand_lck(struct scsi_cmnd *sc)
 	fnic_priv(sc)->state = FNIC_IOREQ_CMD_PENDING;
 	fnic_priv(sc)->io_req = io_req;
 	fnic_priv(sc)->flags |= FNIC_IO_INITIALIZED;
+	io_req->sc = sc;
+
+	if (fnic->sw_copy_wq[hwq].io_req_table[blk_mq_unique_tag_to_tag(mqtag)] != NULL) {
+		WARN(1, "fnic<%d>: %s: hwq: %d tag 0x%x already exists\n",
+				fnic->fnic_num, __func__, hwq, blk_mq_unique_tag_to_tag(mqtag));
+		return SCSI_MLQUEUE_HOST_BUSY;
+	}
+
+	fnic->sw_copy_wq[hwq].io_req_table[blk_mq_unique_tag_to_tag(mqtag)] = io_req;
+	io_req->tag = mqtag;
 
 	/* create copy wq desc and enqueue it */
-	wq = &fnic->hw_copy_wq[0];
-	ret = fnic_queue_wq_copy_desc(fnic, wq, io_req, sc, sg_count);
+	wq = &fnic->hw_copy_wq[hwq];
+	atomic64_inc(&fnic_stats->io_stats.ios[hwq]);
+	ret = fnic_queue_wq_copy_desc(fnic, wq, io_req, sc, sg_count, mqtag, hwq);
 	if (ret) {
 		/*
 		 * In case another thread cancelled the request,
 		 * refetch the pointer under the lock.
 		 */
 		FNIC_TRACE(fnic_queuecommand, sc->device->host->host_no,
-			  tag, sc, 0, 0, 0, fnic_flags_and_state(sc));
+			  mqtag, sc, 0, 0, 0, fnic_flags_and_state(sc));
 		io_req = fnic_priv(sc)->io_req;
 		fnic_priv(sc)->io_req = NULL;
+		if (io_req)
+			fnic->sw_copy_wq[hwq].io_req_table[blk_mq_unique_tag_to_tag(mqtag)] = NULL;
 		fnic_priv(sc)->state = FNIC_IOREQ_CMD_COMPLETE;
-		spin_unlock_irqrestore(io_lock, flags);
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		if (io_req) {
 			fnic_release_ioreq_buf(fnic, io_req, sc);
 			mempool_free(io_req, fnic->io_req_pool);
@@ -601,18 +593,17 @@ static int fnic_queuecommand_lck(struct scsi_cmnd *sc)
 			sc->cmnd[5]);
 
 	FNIC_TRACE(fnic_queuecommand, sc->device->host->host_no,
-		   tag, sc, io_req, sg_count, cmd_trace,
+		   mqtag, sc, io_req, sg_count, cmd_trace,
 		   fnic_flags_and_state(sc));
 
 	/* if only we issued IO, will we have the io lock */
 	if (io_lock_acquired)
-		spin_unlock_irqrestore(io_lock, flags);
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 
 	atomic_dec(&fnic->in_flight);
 	return ret;
 }
 
-DEF_SCSI_QCMD(fnic_queuecommand)
 
 /*
  * fnic_fcpio_fw_reset_cmpl_handler
@@ -789,20 +780,21 @@ static inline void fnic_fcpio_ack_handler(struct fnic *fnic,
 	u16 request_out = desc->u.ack.request_out;
 	unsigned long flags;
 	u64 *ox_id_tag = (u64 *)(void *)desc;
+	unsigned int wq_index = cq_index;
 
 	/* mark the ack state */
-	wq = &fnic->hw_copy_wq[cq_index - fnic->raw_wq_count - fnic->rq_count];
-	spin_lock_irqsave(&fnic->wq_copy_lock[0], flags);
+	wq = &fnic->hw_copy_wq[cq_index];
+	spin_lock_irqsave(&fnic->wq_copy_lock[wq_index], flags);
 
 	fnic->fnic_stats.misc_stats.last_ack_time = jiffies;
 	if (is_ack_index_in_range(wq, request_out)) {
-		fnic->fw_ack_index[0] = request_out;
-		fnic->fw_ack_recd[0] = 1;
+		fnic->fw_ack_index[wq_index] = request_out;
+		fnic->fw_ack_recd[wq_index] = 1;
 	} else
 		atomic64_inc(
 			&fnic->fnic_stats.misc_stats.ack_index_out_of_range);
 
-	spin_unlock_irqrestore(&fnic->wq_copy_lock[0], flags);
+	spin_unlock_irqrestore(&fnic->wq_copy_lock[wq_index], flags);
 	FNIC_TRACE(fnic_fcpio_ack_handler,
 		  fnic->lport->host->host_no, 0, 0, ox_id_tag[2], ox_id_tag[3],
 		  ox_id_tag[4], ox_id_tag[5]);
@@ -812,12 +804,12 @@ static inline void fnic_fcpio_ack_handler(struct fnic *fnic,
  * fnic_fcpio_icmnd_cmpl_handler
  * Routine to handle icmnd completions
  */
-static void fnic_fcpio_icmnd_cmpl_handler(struct fnic *fnic,
+static void fnic_fcpio_icmnd_cmpl_handler(struct fnic *fnic, unsigned int cq_index,
 					 struct fcpio_fw_req *desc)
 {
 	u8 type;
 	u8 hdr_status;
-	struct fcpio_tag tag;
+	struct fcpio_tag ftag;
 	u32 id;
 	u64 xfer_len = 0;
 	struct fcpio_icmnd_cmpl *icmnd_cmpl;
@@ -825,27 +817,49 @@ static void fnic_fcpio_icmnd_cmpl_handler(struct fnic *fnic,
 	struct scsi_cmnd *sc;
 	struct fnic_stats *fnic_stats = &fnic->fnic_stats;
 	unsigned long flags;
-	spinlock_t *io_lock;
 	u64 cmd_trace;
 	unsigned long start_time;
 	unsigned long io_duration_time;
+	unsigned int hwq = 0;
+	unsigned int mqtag = 0;
+	unsigned int tag = 0;
 
 	/* Decode the cmpl description to get the io_req id */
-	fcpio_header_dec(&desc->hdr, &type, &hdr_status, &tag);
-	fcpio_tag_id_dec(&tag, &id);
+	fcpio_header_dec(&desc->hdr, &type, &hdr_status, &ftag);
+	fcpio_tag_id_dec(&ftag, &id);
 	icmnd_cmpl = &desc->u.icmnd_cmpl;
 
-	if (id >= fnic->fnic_max_tag_id) {
-		shost_printk(KERN_ERR, fnic->lport->host,
-			"Tag out of range tag %x hdr status = %s\n",
-			     id, fnic_fcpio_status_to_str(hdr_status));
+	mqtag = id;
+	tag = blk_mq_unique_tag_to_tag(mqtag);
+	hwq = blk_mq_unique_tag_to_hwq(mqtag);
+
+	if (hwq != cq_index) {
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
+			"fnic<%d>: %s: %d: hwq: %d mqtag: 0x%x tag: 0x%x cq index: %d ",
+			fnic->fnic_num, __func__, __LINE__, hwq, mqtag, tag, cq_index);
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
+			"fnic<%d>: %s: %d: hdr status: %s icmnd completion on the wrong queue\n",
+			fnic->fnic_num, __func__, __LINE__,
+			fnic_fcpio_status_to_str(hdr_status));
+	}
+
+	if (tag >= fnic->fnic_max_tag_id) {
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
+			"fnic<%d>: %s: %d: hwq: %d mqtag: 0x%x tag: 0x%x cq index: %d ",
+			fnic->fnic_num, __func__, __LINE__, hwq, mqtag, tag, cq_index);
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
+			"fnic<%d>: %s: %d: hdr status: %s Out of range tag\n",
+			fnic->fnic_num, __func__, __LINE__,
+			fnic_fcpio_status_to_str(hdr_status));
 		return;
 	}
+	spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
 
 	sc = scsi_host_find_tag(fnic->lport->host, id);
 	WARN_ON_ONCE(!sc);
 	if (!sc) {
 		atomic64_inc(&fnic_stats->io_stats.sc_null);
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		shost_printk(KERN_ERR, fnic->lport->host,
 			  "icmnd_cmpl sc is null - "
 			  "hdr status = %s tag = 0x%x desc = 0x%p\n",
@@ -861,14 +875,19 @@ static void fnic_fcpio_icmnd_cmpl_handler(struct fnic *fnic,
 		return;
 	}
 
-	io_lock = fnic_io_lock_hash(fnic, sc);
-	spin_lock_irqsave(io_lock, flags);
 	io_req = fnic_priv(sc)->io_req;
+	if (fnic->sw_copy_wq[hwq].io_req_table[tag] != io_req) {
+		WARN(1, "%s: %d: hwq: %d mqtag: 0x%x tag: 0x%x io_req tag mismatch\n",
+			__func__, __LINE__, hwq, mqtag, tag);
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
+		return;
+	}
+
 	WARN_ON_ONCE(!io_req);
 	if (!io_req) {
 		atomic64_inc(&fnic_stats->io_stats.ioreq_null);
 		fnic_priv(sc)->flags |= FNIC_IO_REQ_NULL;
-		spin_unlock_irqrestore(io_lock, flags);
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		shost_printk(KERN_ERR, fnic->lport->host,
 			  "icmnd_cmpl io_req is null - "
 			  "hdr status = %s tag = 0x%x sc 0x%p\n",
@@ -892,7 +911,7 @@ static void fnic_fcpio_icmnd_cmpl_handler(struct fnic *fnic,
 		 */
 		fnic_priv(sc)->flags |= FNIC_IO_DONE;
 		fnic_priv(sc)->flags |= FNIC_IO_ABTS_PENDING;
-		spin_unlock_irqrestore(io_lock, flags);
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		if(FCPIO_ABORTED == hdr_status)
 			fnic_priv(sc)->flags |= FNIC_IO_ABORTED;
 
@@ -980,7 +999,11 @@ static void fnic_fcpio_icmnd_cmpl_handler(struct fnic *fnic,
 
 	/* Break link with the SCSI command */
 	fnic_priv(sc)->io_req = NULL;
+	io_req->sc = NULL;
 	fnic_priv(sc)->flags |= FNIC_IO_DONE;
+	fnic->sw_copy_wq[hwq].io_req_table[tag] = NULL;
+
+	spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 
 	if (hdr_status != FCPIO_SUCCESS) {
 		atomic64_inc(&fnic_stats->io_stats.io_failures);
@@ -1014,7 +1037,6 @@ static void fnic_fcpio_icmnd_cmpl_handler(struct fnic *fnic,
 
 	/* Call SCSI completion function to complete the IO */
 	scsi_done(sc);
-	spin_unlock_irqrestore(io_lock, flags);
 
 	mempool_free(io_req, fnic->io_req_pool);
 
@@ -1051,12 +1073,12 @@ static void fnic_fcpio_icmnd_cmpl_handler(struct fnic *fnic,
 /* fnic_fcpio_itmf_cmpl_handler
  * Routine to handle itmf completions
  */
-static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic,
+static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic, unsigned int cq_index,
 					struct fcpio_fw_req *desc)
 {
 	u8 type;
 	u8 hdr_status;
-	struct fcpio_tag tag;
+	struct fcpio_tag ftag;
 	u32 id;
 	struct scsi_cmnd *sc;
 	struct fnic_io_req *io_req;
@@ -1065,35 +1087,76 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic,
 	struct terminate_stats *term_stats = &fnic->fnic_stats.term_stats;
 	struct misc_stats *misc_stats = &fnic->fnic_stats.misc_stats;
 	unsigned long flags;
-	spinlock_t *io_lock;
 	unsigned long start_time;
+	unsigned int hwq = cq_index;
+	unsigned int mqtag;
+	unsigned int tag;
 
-	fcpio_header_dec(&desc->hdr, &type, &hdr_status, &tag);
-	fcpio_tag_id_dec(&tag, &id);
+	fcpio_header_dec(&desc->hdr, &type, &hdr_status, &ftag);
+	fcpio_tag_id_dec(&ftag, &id);
 
-	if ((id & FNIC_TAG_MASK) >= fnic->fnic_max_tag_id) {
-		shost_printk(KERN_ERR, fnic->lport->host,
-		"Tag out of range tag %x hdr status = %s\n",
-		id, fnic_fcpio_status_to_str(hdr_status));
+	mqtag = id & FNIC_TAG_MASK;
+	tag = blk_mq_unique_tag_to_tag(id & FNIC_TAG_MASK);
+	hwq = blk_mq_unique_tag_to_hwq(id & FNIC_TAG_MASK);
+
+	if (hwq != cq_index) {
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
+			"%s: %d: hwq: %d mqtag: 0x%x tag: 0x%x cq index: %d ",
+			__func__, __LINE__, hwq, mqtag, tag, cq_index);
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
+			"%s: %d: hdr status: %s ITMF completion on the wrong queue\n",
+			__func__, __LINE__,
+			fnic_fcpio_status_to_str(hdr_status));
+	}
+
+	if (tag > fnic->fnic_max_tag_id) {
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
+			"%s: %d: hwq: %d mqtag: 0x%x tag: 0x%x cq index: %d ",
+			__func__, __LINE__, hwq, mqtag, tag, cq_index);
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
+			"%s: %d: hdr status: %s Tag out of range\n",
+			__func__, __LINE__,
+			fnic_fcpio_status_to_str(hdr_status));
 		return;
+	}  else if ((tag == fnic->fnic_max_tag_id) && !(id & FNIC_TAG_DEV_RST)) {
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
+			"%s: %d: hwq: %d mqtag: 0x%x tag: 0x%x cq index: %d ",
+			__func__, __LINE__, hwq, mqtag, tag, cq_index);
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
+			"%s: %d: hdr status: %s Tag out of range\n",
+			__func__, __LINE__,
+			fnic_fcpio_status_to_str(hdr_status));
+		return;
+	}
+
+	spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
+
+	/* If it is sg3utils allocated SC then tag_id
+	 * is max_tag_id and SC is retrieved from io_req
+	 */
+	if ((mqtag == fnic->fnic_max_tag_id) && (id & FNIC_TAG_DEV_RST)) {
+		io_req = fnic->sw_copy_wq[hwq].io_req_table[tag];
+		if (io_req)
+			sc = io_req->sc;
+	} else {
+		sc = scsi_host_find_tag(fnic->lport->host, id & FNIC_TAG_MASK);
 	}
 
-	sc = scsi_host_find_tag(fnic->lport->host, id & FNIC_TAG_MASK);
 	WARN_ON_ONCE(!sc);
 	if (!sc) {
 		atomic64_inc(&fnic_stats->io_stats.sc_null);
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		shost_printk(KERN_ERR, fnic->lport->host,
 			  "itmf_cmpl sc is null - hdr status = %s tag = 0x%x\n",
 			  fnic_fcpio_status_to_str(hdr_status), id);
 		return;
 	}
-	io_lock = fnic_io_lock_hash(fnic, sc);
-	spin_lock_irqsave(io_lock, flags);
+
 	io_req = fnic_priv(sc)->io_req;
 	WARN_ON_ONCE(!io_req);
 	if (!io_req) {
 		atomic64_inc(&fnic_stats->io_stats.ioreq_null);
-		spin_unlock_irqrestore(io_lock, flags);
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		fnic_priv(sc)->flags |= FNIC_IO_ABT_TERM_REQ_NULL;
 		shost_printk(KERN_ERR, fnic->lport->host,
 			  "itmf_cmpl io_req is null - "
@@ -1114,7 +1177,7 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic,
 		fnic_priv(sc)->flags |= FNIC_DEV_RST_DONE;
 		if (io_req->abts_done)
 			complete(io_req->abts_done);
-		spin_unlock_irqrestore(io_lock, flags);
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 	} else if (id & FNIC_TAG_ABORT) {
 		/* Completion of abort cmd */
 		switch (hdr_status) {
@@ -1149,7 +1212,7 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic,
 		}
 		if (fnic_priv(sc)->state != FNIC_IOREQ_ABTS_PENDING) {
 			/* This is a late completion. Ignore it */
-			spin_unlock_irqrestore(io_lock, flags);
+			spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 			return;
 		}
 
@@ -1175,14 +1238,14 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic,
 		 */
 		if (io_req->abts_done) {
 			complete(io_req->abts_done);
-			spin_unlock_irqrestore(io_lock, flags);
+			spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		} else {
 			FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
 				      "abts cmpl, completing IO\n");
 			fnic_priv(sc)->io_req = NULL;
 			sc->result = (DID_ERROR << 16);
-
-			spin_unlock_irqrestore(io_lock, flags);
+			fnic->sw_copy_wq[hwq].io_req_table[tag] = NULL;
+			spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 
 			fnic_release_ioreq_buf(fnic, io_req, sc);
 			mempool_free(io_req, fnic->io_req_pool);
@@ -1208,7 +1271,7 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic,
 		/* Completion of device reset */
 		fnic_priv(sc)->lr_status = hdr_status;
 		if (fnic_priv(sc)->state == FNIC_IOREQ_ABTS_PENDING) {
-			spin_unlock_irqrestore(io_lock, flags);
+			spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 			fnic_priv(sc)->flags |= FNIC_DEV_RST_ABTS_PENDING;
 			FNIC_TRACE(fnic_fcpio_itmf_cmpl_handler,
 				  sc->device->host->host_no, id, sc,
@@ -1223,7 +1286,7 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic,
 		}
 		if (fnic_priv(sc)->flags & FNIC_DEV_RST_TIMED_OUT) {
 			/* Need to wait for terminate completion */
-			spin_unlock_irqrestore(io_lock, flags);
+			spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 			FNIC_TRACE(fnic_fcpio_itmf_cmpl_handler,
 				  sc->device->host->host_no, id, sc,
 				  jiffies_to_msecs(jiffies - start_time),
@@ -1243,13 +1306,13 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic,
 			      fnic_fcpio_status_to_str(hdr_status));
 		if (io_req->dr_done)
 			complete(io_req->dr_done);
-		spin_unlock_irqrestore(io_lock, flags);
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 
 	} else {
 		shost_printk(KERN_ERR, fnic->lport->host,
 			     "Unexpected itmf io state %s tag %x\n",
 			     fnic_ioreq_state_to_str(fnic_priv(sc)->state), id);
-		spin_unlock_irqrestore(io_lock, flags);
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 	}
 
 }
@@ -1276,17 +1339,19 @@ static int fnic_fcpio_cmpl_handler(struct vnic_dev *vdev,
 		break;
 	}
 
+	cq_index -= fnic->copy_wq_base;
+
 	switch (desc->hdr.type) {
 	case FCPIO_ACK: /* fw copied copy wq desc to its queue */
 		fnic_fcpio_ack_handler(fnic, cq_index, desc);
 		break;
 
 	case FCPIO_ICMND_CMPL: /* fw completed a command */
-		fnic_fcpio_icmnd_cmpl_handler(fnic, desc);
+		fnic_fcpio_icmnd_cmpl_handler(fnic, cq_index, desc);
 		break;
 
 	case FCPIO_ITMF_CMPL: /* fw completed itmf (abort cmd, lun reset)*/
-		fnic_fcpio_itmf_cmpl_handler(fnic, desc);
+		fnic_fcpio_itmf_cmpl_handler(fnic, cq_index, desc);
 		break;
 
 	case FCPIO_FLOGI_REG_CMPL: /* fw completed flogi_reg */
@@ -1339,18 +1404,33 @@ int fnic_wq_copy_cmpl_handler(struct fnic *fnic, int copy_work_to_do, unsigned i
 
 static bool fnic_cleanup_io_iter(struct scsi_cmnd *sc, void *data)
 {
-	const int tag = scsi_cmd_to_rq(sc)->tag;
+	struct request *const rq = scsi_cmd_to_rq(sc);
 	struct fnic *fnic = data;
 	struct fnic_io_req *io_req;
 	unsigned long flags = 0;
-	spinlock_t *io_lock;
 	unsigned long start_time = 0;
 	struct fnic_stats *fnic_stats = &fnic->fnic_stats;
+	uint16_t hwq = 0;
+	int tag;
+	int mqtag;
+
+	mqtag = blk_mq_unique_tag(rq);
+	hwq = blk_mq_unique_tag_to_hwq(mqtag);
+	tag = blk_mq_unique_tag_to_tag(mqtag);
 
-	io_lock = fnic_io_lock_tag(fnic, tag);
-	spin_lock_irqsave(io_lock, flags);
+	spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
+
+	fnic->sw_copy_wq[hwq].io_req_table[tag] = NULL;
 
 	io_req = fnic_priv(sc)->io_req;
+	if (!io_req) {
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
+			"fnic<%d>: %s: %d: hwq: %d mqtag: 0x%x tag: 0x%x flags: 0x%x No ioreq. Returning\n",
+			fnic->fnic_num, __func__, __LINE__, hwq, mqtag, tag, fnic_priv(sc)->flags);
+		return true;
+	}
+
 	if ((fnic_priv(sc)->flags & FNIC_DEVICE_RESET) &&
 	    !(fnic_priv(sc)->flags & FNIC_DEV_RST_DONE)) {
 		/*
@@ -1362,20 +1442,16 @@ static bool fnic_cleanup_io_iter(struct scsi_cmnd *sc, void *data)
 			complete(io_req->dr_done);
 		else if (io_req && io_req->abts_done)
 			complete(io_req->abts_done);
-		spin_unlock_irqrestore(io_lock, flags);
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		return true;
 	} else if (fnic_priv(sc)->flags & FNIC_DEVICE_RESET) {
-		spin_unlock_irqrestore(io_lock, flags);
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		return true;
 	}
-	if (!io_req) {
-		spin_unlock_irqrestore(io_lock, flags);
-		goto cleanup_scsi_cmd;
-	}
 
 	fnic_priv(sc)->io_req = NULL;
-
-	spin_unlock_irqrestore(io_lock, flags);
+	io_req->sc = NULL;
+	spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 
 	/*
 	 * If there is a scsi_cmnd associated with this io_req, then
@@ -1385,7 +1461,6 @@ static bool fnic_cleanup_io_iter(struct scsi_cmnd *sc, void *data)
 	fnic_release_ioreq_buf(fnic, io_req, sc);
 	mempool_free(io_req, fnic->io_req_pool);
 
-cleanup_scsi_cmd:
 	sc->result = DID_TRANSPORT_DISRUPTED << 16;
 	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
 		      "fnic_cleanup_io: tag:0x%x : sc:0x%p duration = %lu DID_TRANSPORT_DISRUPTED\n",
@@ -1396,12 +1471,6 @@ static bool fnic_cleanup_io_iter(struct scsi_cmnd *sc, void *data)
 	else
 		atomic64_inc(&fnic_stats->io_stats.io_completions);
 
-	/* Complete the command to SCSI */
-	if (!(fnic_priv(sc)->flags & FNIC_IO_ISSUED))
-		shost_printk(KERN_ERR, fnic->lport->host,
-			     "Calling done for IO not issued to fw: tag:0x%x sc:0x%p\n",
-			     tag, sc);
-
 	FNIC_TRACE(fnic_cleanup_io,
 		   sc->device->host->host_no, tag, sc,
 		   jiffies_to_msecs(jiffies - start_time),
@@ -1430,8 +1499,8 @@ void fnic_wq_copy_cleanup_handler(struct vnic_wq_copy *wq,
 	struct fnic_io_req *io_req;
 	struct scsi_cmnd *sc;
 	unsigned long flags;
-	spinlock_t *io_lock;
 	unsigned long start_time = 0;
+	uint16_t hwq;
 
 	/* get the tag reference */
 	fcpio_tag_id_dec(&desc->hdr.tag, &id);
@@ -1444,8 +1513,8 @@ void fnic_wq_copy_cleanup_handler(struct vnic_wq_copy *wq,
 	if (!sc)
 		return;
 
-	io_lock = fnic_io_lock_hash(fnic, sc);
-	spin_lock_irqsave(io_lock, flags);
+	hwq = blk_mq_unique_tag_to_hwq(id);
+	spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
 
 	/* Get the IO context which this desc refers to */
 	io_req = fnic_priv(sc)->io_req;
@@ -1453,13 +1522,15 @@ void fnic_wq_copy_cleanup_handler(struct vnic_wq_copy *wq,
 	/* fnic interrupts are turned off by now */
 
 	if (!io_req) {
-		spin_unlock_irqrestore(io_lock, flags);
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		goto wq_copy_cleanup_scsi_cmd;
 	}
 
 	fnic_priv(sc)->io_req = NULL;
+	io_req->sc = NULL;
+	fnic->sw_copy_wq[hwq].io_req_table[blk_mq_unique_tag_to_tag(id)] = NULL;
 
-	spin_unlock_irqrestore(io_lock, flags);
+	spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 
 	start_time = io_req->start_time;
 	fnic_release_ioreq_buf(fnic, io_req, sc);
@@ -1483,9 +1554,10 @@ void fnic_wq_copy_cleanup_handler(struct vnic_wq_copy *wq,
 
 static inline int fnic_queue_abort_io_req(struct fnic *fnic, int tag,
 					  u32 task_req, u8 *fc_lun,
-					  struct fnic_io_req *io_req)
+					  struct fnic_io_req *io_req,
+					  unsigned int hwq)
 {
-	struct vnic_wq_copy *wq = &fnic->hw_copy_wq[0];
+	struct vnic_wq_copy *wq = &fnic->hw_copy_wq[hwq];
 	struct misc_stats *misc_stats = &fnic->fnic_stats.misc_stats;
 	unsigned long flags;
 
@@ -1498,13 +1570,13 @@ static inline int fnic_queue_abort_io_req(struct fnic *fnic, int tag,
 		atomic_inc(&fnic->in_flight);
 	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 
-	spin_lock_irqsave(&fnic->wq_copy_lock[0], flags);
+	spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
 
-	if (vnic_wq_copy_desc_avail(wq) <= fnic->wq_copy_desc_low[0])
-		free_wq_copy_descs(fnic, wq);
+	if (vnic_wq_copy_desc_avail(wq) <= fnic->wq_copy_desc_low[hwq])
+		free_wq_copy_descs(fnic, wq, hwq);
 
 	if (!vnic_wq_copy_desc_avail(wq)) {
-		spin_unlock_irqrestore(&fnic->wq_copy_lock[0], flags);
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		atomic_dec(&fnic->in_flight);
 		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
 			"fnic_queue_abort_io_req: failure: no descriptors\n");
@@ -1521,7 +1593,7 @@ static inline int fnic_queue_abort_io_req(struct fnic *fnic, int tag,
 		atomic64_set(&fnic->fnic_stats.fw_stats.max_fw_reqs,
 		  atomic64_read(&fnic->fnic_stats.fw_stats.active_fw_reqs));
 
-	spin_unlock_irqrestore(&fnic->wq_copy_lock[0], flags);
+	spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 	atomic_dec(&fnic->in_flight);
 
 	return 0;
@@ -1535,24 +1607,27 @@ struct fnic_rport_abort_io_iter_data {
 
 static bool fnic_rport_abort_io_iter(struct scsi_cmnd *sc, void *data)
 {
+	struct request *const rq = scsi_cmd_to_rq(sc);
 	struct fnic_rport_abort_io_iter_data *iter_data = data;
 	struct fnic *fnic = iter_data->fnic;
-	int abt_tag = scsi_cmd_to_rq(sc)->tag;
+	int abt_tag = 0;
 	struct fnic_io_req *io_req;
-	spinlock_t *io_lock;
 	unsigned long flags;
 	struct reset_stats *reset_stats = &fnic->fnic_stats.reset_stats;
 	struct terminate_stats *term_stats = &fnic->fnic_stats.term_stats;
 	struct scsi_lun fc_lun;
 	enum fnic_ioreq_state old_ioreq_state;
+	uint16_t hwq = 0;
+
+	abt_tag = blk_mq_unique_tag(rq);
+	hwq = blk_mq_unique_tag_to_hwq(abt_tag);
 
-	io_lock = fnic_io_lock_tag(fnic, abt_tag);
-	spin_lock_irqsave(io_lock, flags);
+	spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
 
 	io_req = fnic_priv(sc)->io_req;
 
 	if (!io_req || io_req->port_id != iter_data->port_id) {
-		spin_unlock_irqrestore(io_lock, flags);
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		return true;
 	}
 
@@ -1561,7 +1636,7 @@ static bool fnic_rport_abort_io_iter(struct scsi_cmnd *sc, void *data)
 		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
 			"fnic_rport_exch_reset dev rst not pending sc 0x%p\n",
 			sc);
-		spin_unlock_irqrestore(io_lock, flags);
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		return true;
 	}
 
@@ -1570,7 +1645,7 @@ static bool fnic_rport_abort_io_iter(struct scsi_cmnd *sc, void *data)
 	 * belongs to rport that went away
 	 */
 	if (fnic_priv(sc)->state == FNIC_IOREQ_ABTS_PENDING) {
-		spin_unlock_irqrestore(io_lock, flags);
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		return true;
 	}
 	if (io_req->abts_done) {
@@ -1601,31 +1676,31 @@ static bool fnic_rport_abort_io_iter(struct scsi_cmnd *sc, void *data)
 	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
 		      "fnic_rport_reset_exch: Issuing abts\n");
 
-	spin_unlock_irqrestore(io_lock, flags);
+	spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 
 	/* Now queue the abort command to firmware */
 	int_to_scsilun(sc->device->lun, &fc_lun);
 
 	if (fnic_queue_abort_io_req(fnic, abt_tag,
 				    FCPIO_ITMF_ABT_TASK_TERM,
-				    fc_lun.scsi_lun, io_req)) {
+				    fc_lun.scsi_lun, io_req, hwq)) {
 		/*
 		 * Revert the cmd state back to old state, if
 		 * it hasn't changed in between. This cmd will get
 		 * aborted later by scsi_eh, or cleaned up during
 		 * lun reset
 		 */
-		spin_lock_irqsave(io_lock, flags);
+		spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
 		if (fnic_priv(sc)->state == FNIC_IOREQ_ABTS_PENDING)
 			fnic_priv(sc)->state = old_ioreq_state;
-		spin_unlock_irqrestore(io_lock, flags);
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 	} else {
-		spin_lock_irqsave(io_lock, flags);
+		spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
 		if (fnic_priv(sc)->flags & FNIC_DEVICE_RESET)
 			fnic_priv(sc)->flags |= FNIC_DEV_RST_TERM_ISSUED;
 		else
 			fnic_priv(sc)->flags |= FNIC_IO_INTERNAL_TERM_ISSUED;
-		spin_unlock_irqrestore(io_lock, flags);
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		atomic64_inc(&term_stats->terminates);
 		iter_data->term_cnt++;
 	}
@@ -1703,7 +1778,6 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 	struct fnic *fnic;
 	struct fnic_io_req *io_req = NULL;
 	struct fc_rport *rport;
-	spinlock_t *io_lock;
 	unsigned long flags;
 	unsigned long start_time = 0;
 	int ret = SUCCESS;
@@ -1713,8 +1787,10 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 	struct abort_stats *abts_stats;
 	struct terminate_stats *term_stats;
 	enum fnic_ioreq_state old_ioreq_state;
-	const int tag = rq->tag;
+	int mqtag;
 	unsigned long abt_issued_time;
+	uint16_t hwq = 0;
+
 	DECLARE_COMPLETION_ONSTACK(tm_done);
 
 	/* Wait for rport to unblock */
@@ -1724,23 +1800,25 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 	lp = shost_priv(sc->device->host);
 
 	fnic = lport_priv(lp);
+
+	spin_lock_irqsave(&fnic->fnic_lock, flags);
 	fnic_stats = &fnic->fnic_stats;
 	abts_stats = &fnic->fnic_stats.abts_stats;
 	term_stats = &fnic->fnic_stats.term_stats;
 
 	rport = starget_to_rport(scsi_target(sc->device));
-	FNIC_SCSI_DBG(KERN_DEBUG,
-		fnic->lport->host,
-		"Abort Cmd called FCID 0x%x, LUN 0x%llx TAG %x flags %x\n",
-		rport->port_id, sc->device->lun, tag, fnic_priv(sc)->flags);
+	mqtag = blk_mq_unique_tag(rq);
+	hwq = blk_mq_unique_tag_to_hwq(mqtag);
 
 	fnic_priv(sc)->flags = FNIC_NO_FLAGS;
 
 	if (lp->state != LPORT_ST_READY || !(lp->link_up)) {
 		ret = FAILED;
+		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 		goto fnic_abort_cmd_end;
 	}
 
+	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 	/*
 	 * Avoid a race between SCSI issuing the abort and the device
 	 * completing the command.
@@ -1753,18 +1831,17 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 	 *
 	 * .io_req will not be cleared except while holding io_req_lock.
 	 */
-	io_lock = fnic_io_lock_hash(fnic, sc);
-	spin_lock_irqsave(io_lock, flags);
+	spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
 	io_req = fnic_priv(sc)->io_req;
 	if (!io_req) {
-		spin_unlock_irqrestore(io_lock, flags);
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		goto fnic_abort_cmd_end;
 	}
 
 	io_req->abts_done = &tm_done;
 
 	if (fnic_priv(sc)->state == FNIC_IOREQ_ABTS_PENDING) {
-		spin_unlock_irqrestore(io_lock, flags);
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		goto wait_pending;
 	}
 
@@ -1796,7 +1873,7 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 	fnic_priv(sc)->state = FNIC_IOREQ_ABTS_PENDING;
 	fnic_priv(sc)->abts_status = FCPIO_INVALID_CODE;
 
-	spin_unlock_irqrestore(io_lock, flags);
+	spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 
 	/*
 	 * Check readiness of the remote port. If the path to remote
@@ -1813,15 +1890,15 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 	/* Now queue the abort command to firmware */
 	int_to_scsilun(sc->device->lun, &fc_lun);
 
-	if (fnic_queue_abort_io_req(fnic, tag, task_req, fc_lun.scsi_lun,
-				    io_req)) {
-		spin_lock_irqsave(io_lock, flags);
+	if (fnic_queue_abort_io_req(fnic, mqtag, task_req, fc_lun.scsi_lun,
+				    io_req, hwq)) {
+		spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
 		if (fnic_priv(sc)->state == FNIC_IOREQ_ABTS_PENDING)
 			fnic_priv(sc)->state = old_ioreq_state;
 		io_req = fnic_priv(sc)->io_req;
 		if (io_req)
 			io_req->abts_done = NULL;
-		spin_unlock_irqrestore(io_lock, flags);
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		ret = FAILED;
 		goto fnic_abort_cmd_end;
 	}
@@ -1845,12 +1922,12 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 				     fnic->config.ed_tov));
 
 	/* Check the abort status */
-	spin_lock_irqsave(io_lock, flags);
+	spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
 
 	io_req = fnic_priv(sc)->io_req;
 	if (!io_req) {
 		atomic64_inc(&fnic_stats->io_stats.ioreq_null);
-		spin_unlock_irqrestore(io_lock, flags);
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		fnic_priv(sc)->flags |= FNIC_IO_ABT_TERM_REQ_NULL;
 		ret = FAILED;
 		goto fnic_abort_cmd_end;
@@ -1859,7 +1936,7 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 
 	/* fw did not complete abort, timed out */
 	if (fnic_priv(sc)->abts_status == FCPIO_INVALID_CODE) {
-		spin_unlock_irqrestore(io_lock, flags);
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		if (task_req == FCPIO_ITMF_ABT_TASK) {
 			atomic64_inc(&abts_stats->abort_drv_timeouts);
 		} else {
@@ -1873,7 +1950,7 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 	/* IO out of order */
 
 	if (!(fnic_priv(sc)->flags & (FNIC_IO_ABORTED | FNIC_IO_DONE))) {
-		spin_unlock_irqrestore(io_lock, flags);
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
 			"Issuing Host reset due to out of order IO\n");
 
@@ -1889,15 +1966,18 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 	 * free the io_req if successful. If abort fails,
 	 * Device reset will clean the I/O.
 	 */
-	if (fnic_priv(sc)->abts_status == FCPIO_SUCCESS) {
+	if (fnic_priv(sc)->abts_status == FCPIO_SUCCESS ||
+		(fnic_priv(sc)->abts_status == FCPIO_ABORTED)) {
 		fnic_priv(sc)->io_req = NULL;
+		io_req->sc = NULL;
 	} else {
 		ret = FAILED;
-		spin_unlock_irqrestore(io_lock, flags);
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		goto fnic_abort_cmd_end;
 	}
 
-	spin_unlock_irqrestore(io_lock, flags);
+	fnic->sw_copy_wq[hwq].io_req_table[blk_mq_unique_tag_to_tag(mqtag)] = NULL;
+	spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 
 	fnic_release_ioreq_buf(fnic, io_req, sc);
 	mempool_free(io_req, fnic->io_req_pool);
@@ -1912,7 +1992,7 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 		atomic64_inc(&fnic_stats->io_stats.io_completions);
 
 fnic_abort_cmd_end:
-	FNIC_TRACE(fnic_abort_cmd, sc->device->host->host_no, tag, sc,
+	FNIC_TRACE(fnic_abort_cmd, sc->device->host->host_no, mqtag, sc,
 		  jiffies_to_msecs(jiffies - start_time),
 		  0, ((u64)sc->cmnd[0] << 32 |
 		  (u64)sc->cmnd[2] << 24 | (u64)sc->cmnd[3] << 16 |
@@ -1930,25 +2010,31 @@ static inline int fnic_queue_dr_io_req(struct fnic *fnic,
 				       struct scsi_cmnd *sc,
 				       struct fnic_io_req *io_req)
 {
-	struct vnic_wq_copy *wq = &fnic->hw_copy_wq[0];
+	struct vnic_wq_copy *wq;
 	struct misc_stats *misc_stats = &fnic->fnic_stats.misc_stats;
 	struct scsi_lun fc_lun;
 	int ret = 0;
-	unsigned long intr_flags;
+	unsigned long flags;
+	uint16_t hwq = 0;
+	uint32_t tag = 0;
+
+	tag = io_req->tag;
+	hwq = blk_mq_unique_tag_to_hwq(tag);
+	wq = &fnic->hw_copy_wq[hwq];
 
-	spin_lock_irqsave(&fnic->fnic_lock, intr_flags);
+	spin_lock_irqsave(&fnic->fnic_lock, flags);
 	if (unlikely(fnic_chk_state_flags_locked(fnic,
 						FNIC_FLAGS_IO_BLOCKED))) {
-		spin_unlock_irqrestore(&fnic->fnic_lock, intr_flags);
+		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 		return FAILED;
 	} else
 		atomic_inc(&fnic->in_flight);
-	spin_unlock_irqrestore(&fnic->fnic_lock, intr_flags);
+	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 
-	spin_lock_irqsave(&fnic->wq_copy_lock[0], intr_flags);
+	spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
 
-	if (vnic_wq_copy_desc_avail(wq) <= fnic->wq_copy_desc_low[0])
-		free_wq_copy_descs(fnic, wq);
+	if (vnic_wq_copy_desc_avail(wq) <= fnic->wq_copy_desc_low[hwq])
+		free_wq_copy_descs(fnic, wq, hwq);
 
 	if (!vnic_wq_copy_desc_avail(wq)) {
 		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
@@ -1973,7 +2059,7 @@ static inline int fnic_queue_dr_io_req(struct fnic *fnic,
 		  atomic64_read(&fnic->fnic_stats.fw_stats.active_fw_reqs));
 
 lr_io_req_end:
-	spin_unlock_irqrestore(&fnic->wq_copy_lock[0], intr_flags);
+	spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 	atomic_dec(&fnic->in_flight);
 
 	return ret;
@@ -1988,12 +2074,13 @@ struct fnic_pending_aborts_iter_data {
 
 static bool fnic_pending_aborts_iter(struct scsi_cmnd *sc, void *data)
 {
+	struct request *const rq = scsi_cmd_to_rq(sc);
 	struct fnic_pending_aborts_iter_data *iter_data = data;
 	struct fnic *fnic = iter_data->fnic;
 	struct scsi_device *lun_dev = iter_data->lun_dev;
-	int abt_tag = scsi_cmd_to_rq(sc)->tag;
+	unsigned long abt_tag = 0;
+	uint16_t hwq = 0;
 	struct fnic_io_req *io_req;
-	spinlock_t *io_lock;
 	unsigned long flags;
 	struct scsi_lun fc_lun;
 	DECLARE_COMPLETION_ONSTACK(tm_done);
@@ -2002,11 +2089,13 @@ static bool fnic_pending_aborts_iter(struct scsi_cmnd *sc, void *data)
 	if (sc == iter_data->lr_sc || sc->device != lun_dev)
 		return true;
 
-	io_lock = fnic_io_lock_tag(fnic, abt_tag);
-	spin_lock_irqsave(io_lock, flags);
+	abt_tag = blk_mq_unique_tag(rq);
+	hwq = blk_mq_unique_tag_to_hwq(abt_tag);
+
+	spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
 	io_req = fnic_priv(sc)->io_req;
 	if (!io_req) {
-		spin_unlock_irqrestore(io_lock, flags);
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		return true;
 	}
 
@@ -2019,7 +2108,7 @@ static bool fnic_pending_aborts_iter(struct scsi_cmnd *sc, void *data)
 		      fnic_ioreq_state_to_str(fnic_priv(sc)->state));
 
 	if (fnic_priv(sc)->state == FNIC_IOREQ_ABTS_PENDING) {
-		spin_unlock_irqrestore(io_lock, flags);
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		return true;
 	}
 	if ((fnic_priv(sc)->flags & FNIC_DEVICE_RESET) &&
@@ -2027,7 +2116,7 @@ static bool fnic_pending_aborts_iter(struct scsi_cmnd *sc, void *data)
 		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
 			      "%s dev rst not pending sc 0x%p\n", __func__,
 			      sc);
-		spin_unlock_irqrestore(io_lock, flags);
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		return true;
 	}
 
@@ -2048,35 +2137,34 @@ static bool fnic_pending_aborts_iter(struct scsi_cmnd *sc, void *data)
 	BUG_ON(io_req->abts_done);
 
 	if (fnic_priv(sc)->flags & FNIC_DEVICE_RESET) {
-		abt_tag |= FNIC_TAG_DEV_RST;
 		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
 			      "%s: dev rst sc 0x%p\n", __func__, sc);
 	}
 
 	fnic_priv(sc)->abts_status = FCPIO_INVALID_CODE;
 	io_req->abts_done = &tm_done;
-	spin_unlock_irqrestore(io_lock, flags);
+	spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 
 	/* Now queue the abort command to firmware */
 	int_to_scsilun(sc->device->lun, &fc_lun);
 
 	if (fnic_queue_abort_io_req(fnic, abt_tag,
 				    FCPIO_ITMF_ABT_TASK_TERM,
-				    fc_lun.scsi_lun, io_req)) {
-		spin_lock_irqsave(io_lock, flags);
+				    fc_lun.scsi_lun, io_req, hwq)) {
+		spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
 		io_req = fnic_priv(sc)->io_req;
 		if (io_req)
 			io_req->abts_done = NULL;
 		if (fnic_priv(sc)->state == FNIC_IOREQ_ABTS_PENDING)
 			fnic_priv(sc)->state = old_ioreq_state;
-		spin_unlock_irqrestore(io_lock, flags);
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		iter_data->ret = FAILED;
 		return false;
 	} else {
-		spin_lock_irqsave(io_lock, flags);
+		spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
 		if (fnic_priv(sc)->flags & FNIC_DEVICE_RESET)
 			fnic_priv(sc)->flags |= FNIC_DEV_RST_TERM_ISSUED;
-		spin_unlock_irqrestore(io_lock, flags);
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 	}
 	fnic_priv(sc)->flags |= FNIC_IO_INTERNAL_TERM_ISSUED;
 
@@ -2084,10 +2172,10 @@ static bool fnic_pending_aborts_iter(struct scsi_cmnd *sc, void *data)
 				    (fnic->config.ed_tov));
 
 	/* Recheck cmd state to check if it is now aborted */
-	spin_lock_irqsave(io_lock, flags);
+	spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
 	io_req = fnic_priv(sc)->io_req;
 	if (!io_req) {
-		spin_unlock_irqrestore(io_lock, flags);
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		fnic_priv(sc)->flags |= FNIC_IO_ABT_TERM_REQ_NULL;
 		return true;
 	}
@@ -2096,7 +2184,7 @@ static bool fnic_pending_aborts_iter(struct scsi_cmnd *sc, void *data)
 
 	/* if abort is still pending with fw, fail */
 	if (fnic_priv(sc)->abts_status == FCPIO_INVALID_CODE) {
-		spin_unlock_irqrestore(io_lock, flags);
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		fnic_priv(sc)->flags |= FNIC_IO_ABT_TERM_DONE;
 		iter_data->ret = FAILED;
 		return false;
@@ -2104,9 +2192,11 @@ static bool fnic_pending_aborts_iter(struct scsi_cmnd *sc, void *data)
 	fnic_priv(sc)->state = FNIC_IOREQ_ABTS_COMPLETE;
 
 	/* original sc used for lr is handled by dev reset code */
-	if (sc != iter_data->lr_sc)
+	if (sc != iter_data->lr_sc) {
 		fnic_priv(sc)->io_req = NULL;
-	spin_unlock_irqrestore(io_lock, flags);
+		fnic->sw_copy_wq[hwq].io_req_table[blk_mq_unique_tag_to_tag(abt_tag)] = NULL;
+	}
+	spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 
 	/* original sc used for lr is handled by dev reset code */
 	if (sc != iter_data->lr_sc) {
@@ -2178,15 +2268,15 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 	struct fc_rport *rport;
 	int status;
 	int ret = FAILED;
-	spinlock_t *io_lock;
 	unsigned long flags;
 	unsigned long start_time = 0;
 	struct scsi_lun fc_lun;
 	struct fnic_stats *fnic_stats;
 	struct reset_stats *reset_stats;
-	int tag = rq->tag;
+	int mqtag = rq->tag;
 	DECLARE_COMPLETION_ONSTACK(tm_done);
 	bool new_sc = 0;
+	uint16_t hwq = 0;
 
 	/* Wait for rport to unblock */
 	fc_block_scsi_eh(sc);
@@ -2216,7 +2306,7 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 
 	fnic_priv(sc)->flags = FNIC_DEVICE_RESET;
 
-	if (unlikely(tag < 0)) {
+	if (unlikely(mqtag < 0)) {
 		/*
 		 * For device reset issued through sg3utils, we let
 		 * only one LUN_RESET to go through and use a special
@@ -2225,11 +2315,14 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 		 * allocated by mid layer.
 		 */
 		mutex_lock(&fnic->sgreset_mutex);
-		tag = fnic->fnic_max_tag_id;
+		mqtag = fnic->fnic_max_tag_id;
 		new_sc = 1;
+	}  else {
+		mqtag = blk_mq_unique_tag(rq);
+		hwq = blk_mq_unique_tag_to_hwq(mqtag);
 	}
-	io_lock = fnic_io_lock_hash(fnic, sc);
-	spin_lock_irqsave(io_lock, flags);
+
+	spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
 	io_req = fnic_priv(sc)->io_req;
 
 	/*
@@ -2239,34 +2332,43 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 	if (!io_req) {
 		io_req = mempool_alloc(fnic->io_req_pool, GFP_ATOMIC);
 		if (!io_req) {
-			spin_unlock_irqrestore(io_lock, flags);
+			spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 			goto fnic_device_reset_end;
 		}
 		memset(io_req, 0, sizeof(*io_req));
 		io_req->port_id = rport->port_id;
+		io_req->tag = mqtag;
 		fnic_priv(sc)->io_req = io_req;
+		io_req->sc = sc;
+
+		if (fnic->sw_copy_wq[hwq].io_req_table[blk_mq_unique_tag_to_tag(mqtag)] != NULL)
+			WARN(1, "fnic<%d>: %s: tag 0x%x already exists\n",
+					fnic->fnic_num, __func__, blk_mq_unique_tag_to_tag(mqtag));
+
+		fnic->sw_copy_wq[hwq].io_req_table[blk_mq_unique_tag_to_tag(mqtag)] =
+				io_req;
 	}
 	io_req->dr_done = &tm_done;
 	fnic_priv(sc)->state = FNIC_IOREQ_CMD_PENDING;
 	fnic_priv(sc)->lr_status = FCPIO_INVALID_CODE;
-	spin_unlock_irqrestore(io_lock, flags);
+	spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 
-	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, "TAG %x\n", tag);
+	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, "TAG %x\n", mqtag);
 
 	/*
 	 * issue the device reset, if enqueue failed, clean up the ioreq
 	 * and break assoc with scsi cmd
 	 */
 	if (fnic_queue_dr_io_req(fnic, sc, io_req)) {
-		spin_lock_irqsave(io_lock, flags);
+		spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
 		io_req = fnic_priv(sc)->io_req;
 		if (io_req)
 			io_req->dr_done = NULL;
 		goto fnic_device_reset_clean;
 	}
-	spin_lock_irqsave(io_lock, flags);
+	spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
 	fnic_priv(sc)->flags |= FNIC_DEV_RST_ISSUED;
-	spin_unlock_irqrestore(io_lock, flags);
+	spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 
 	/*
 	 * Wait on the local completion for LUN reset.  The io_req may be
@@ -2275,12 +2377,12 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 	wait_for_completion_timeout(&tm_done,
 				    msecs_to_jiffies(FNIC_LUN_RESET_TIMEOUT));
 
-	spin_lock_irqsave(io_lock, flags);
+	spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
 	io_req = fnic_priv(sc)->io_req;
 	if (!io_req) {
-		spin_unlock_irqrestore(io_lock, flags);
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
-				"io_req is null tag 0x%x sc 0x%p\n", tag, sc);
+				"io_req is null mqtag 0x%x sc 0x%p\n", mqtag, sc);
 		goto fnic_device_reset_end;
 	}
 	io_req->dr_done = NULL;
@@ -2296,41 +2398,41 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
 			      "Device reset timed out\n");
 		fnic_priv(sc)->flags |= FNIC_DEV_RST_TIMED_OUT;
-		spin_unlock_irqrestore(io_lock, flags);
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		int_to_scsilun(sc->device->lun, &fc_lun);
 		/*
 		 * Issue abort and terminate on device reset request.
 		 * If q'ing of terminate fails, retry it after a delay.
 		 */
 		while (1) {
-			spin_lock_irqsave(io_lock, flags);
+			spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
 			if (fnic_priv(sc)->flags & FNIC_DEV_RST_TERM_ISSUED) {
-				spin_unlock_irqrestore(io_lock, flags);
+				spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 				break;
 			}
-			spin_unlock_irqrestore(io_lock, flags);
+			spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 			if (fnic_queue_abort_io_req(fnic,
-				tag | FNIC_TAG_DEV_RST,
+				mqtag | FNIC_TAG_DEV_RST,
 				FCPIO_ITMF_ABT_TASK_TERM,
-				fc_lun.scsi_lun, io_req)) {
+				fc_lun.scsi_lun, io_req, hwq)) {
 				wait_for_completion_timeout(&tm_done,
 				msecs_to_jiffies(FNIC_ABT_TERM_DELAY_TIMEOUT));
 			} else {
-				spin_lock_irqsave(io_lock, flags);
+				spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
 				fnic_priv(sc)->flags |= FNIC_DEV_RST_TERM_ISSUED;
 				fnic_priv(sc)->state = FNIC_IOREQ_ABTS_PENDING;
 				io_req->abts_done = &tm_done;
-				spin_unlock_irqrestore(io_lock, flags);
+				spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 				FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
-				"Abort and terminate issued on Device reset "
-				"tag 0x%x sc 0x%p\n", tag, sc);
+				"Abort and terminate issued on Device reset mqtag 0x%x sc 0x%p\n",
+				mqtag, sc);
 				break;
 			}
 		}
 		while (1) {
-			spin_lock_irqsave(io_lock, flags);
+			spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
 			if (!(fnic_priv(sc)->flags & FNIC_DEV_RST_DONE)) {
-				spin_unlock_irqrestore(io_lock, flags);
+				spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 				wait_for_completion_timeout(&tm_done,
 				msecs_to_jiffies(FNIC_LUN_RESET_TIMEOUT));
 				break;
@@ -2341,12 +2443,12 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 			}
 		}
 	} else {
-		spin_unlock_irqrestore(io_lock, flags);
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 	}
 
 	/* Completed, but not successful, clean up the io_req, return fail */
 	if (status != FCPIO_SUCCESS) {
-		spin_lock_irqsave(io_lock, flags);
+		spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
 		FNIC_SCSI_DBG(KERN_DEBUG,
 			      fnic->lport->host,
 			      "Device reset completed - failed\n");
@@ -2362,7 +2464,7 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 	 * succeeds
 	 */
 	if (fnic_clean_pending_aborts(fnic, sc, new_sc)) {
-		spin_lock_irqsave(io_lock, flags);
+		spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
 		io_req = fnic_priv(sc)->io_req;
 		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
 			      "Device reset failed"
@@ -2371,17 +2473,20 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 	}
 
 	/* Clean lun reset command */
-	spin_lock_irqsave(io_lock, flags);
+	spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
 	io_req = fnic_priv(sc)->io_req;
 	if (io_req)
 		/* Completed, and successful */
 		ret = SUCCESS;
 
 fnic_device_reset_clean:
-	if (io_req)
+	if (io_req) {
 		fnic_priv(sc)->io_req = NULL;
+		io_req->sc = NULL;
+		fnic->sw_copy_wq[hwq].io_req_table[blk_mq_unique_tag_to_tag(io_req->tag)] = NULL;
+	}
 
-	spin_unlock_irqrestore(io_lock, flags);
+	spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 
 	if (io_req) {
 		start_time = io_req->start_time;
@@ -2619,12 +2724,17 @@ void fnic_exch_mgr_reset(struct fc_lport *lp, u32 sid, u32 did)
 
 static bool fnic_abts_pending_iter(struct scsi_cmnd *sc, void *data)
 {
+	struct request *const rq = scsi_cmd_to_rq(sc);
 	struct fnic_pending_aborts_iter_data *iter_data = data;
 	struct fnic *fnic = iter_data->fnic;
 	int cmd_state;
 	struct fnic_io_req *io_req;
-	spinlock_t *io_lock;
 	unsigned long flags;
+	uint16_t hwq = 0;
+	int tag;
+
+	tag = blk_mq_unique_tag(rq);
+	hwq = blk_mq_unique_tag_to_hwq(tag);
 
 	/*
 	 * ignore this lun reset cmd or cmds that do not belong to
@@ -2635,12 +2745,11 @@ static bool fnic_abts_pending_iter(struct scsi_cmnd *sc, void *data)
 	if (iter_data->lun_dev && sc->device != iter_data->lun_dev)
 		return true;
 
-	io_lock = fnic_io_lock_hash(fnic, sc);
-	spin_lock_irqsave(io_lock, flags);
+	spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
 
 	io_req = fnic_priv(sc)->io_req;
 	if (!io_req) {
-		spin_unlock_irqrestore(io_lock, flags);
+		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		return true;
 	}
 
@@ -2652,7 +2761,7 @@ static bool fnic_abts_pending_iter(struct scsi_cmnd *sc, void *data)
 		      "Found IO in %s on lun\n",
 		      fnic_ioreq_state_to_str(fnic_priv(sc)->state));
 	cmd_state = fnic_priv(sc)->state;
-	spin_unlock_irqrestore(io_lock, flags);
+	spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 	if (cmd_state == FNIC_IOREQ_ABTS_PENDING)
 		iter_data->ret = 1;
 
-- 
2.31.1

