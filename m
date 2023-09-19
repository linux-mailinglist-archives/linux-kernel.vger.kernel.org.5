Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CABA7A6AA8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 20:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjISSZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 14:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjISSZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 14:25:06 -0400
Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC28BC;
        Tue, 19 Sep 2023 11:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=7559; q=dns/txt; s=iport;
  t=1695147900; x=1696357500;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Rsn3PPMulBps4MjaC5P5HHpE7afvTwGULlEwTuNevO4=;
  b=eok0yt6XlnidbjY7o/d9PHx7LHiY+z9qYSEzsycuDg7qC1HBF5cAlNRJ
   7EFvZqGCzZx8ASia5j3UwU99dO7qYGWT4Fz4AofYhFqOiOKOPbPMpMaTz
   VwEI+KF/EjtnXCNaKnQr+6vMuNkEAeSVuq1ZHxngs9Ngpg9gBBWyZXuxk
   0=;
X-CSE-ConnectionGUID: Wlx2ulGsQTyj0Utd6R4ZYA==
X-CSE-MsgGUID: ynZzxJJzRGCM0OpoVlM7Bg==
X-IronPort-AV: E=Sophos;i="6.02,160,1688428800"; 
   d="scan'208";a="117513323"
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 18:24:59 +0000
Received: from localhost.cisco.com ([10.193.101.253])
        (authenticated bits=0)
        by rcdn-core-5.cisco.com (8.15.2/8.15.2) with ESMTPSA id 38JIOpo9021635
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 Sep 2023 18:24:58 GMT
From:   Karan Tilak Kumar <kartilak@cisco.com>
To:     sebaddel@cisco.com
Cc:     arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
        mkai2@cisco.com, satishkh@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Karan Tilak Kumar <kartilak@cisco.com>
Subject: [PATCH] scsi: fnic: Fix sg_reset success path
Date:   Tue, 19 Sep 2023 11:24:36 -0700
Message-Id: <20230919182436.6895-1-kartilak@cisco.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: kartilak@cisco.com
X-Outbound-SMTP-Client: 10.193.101.253, [10.193.101.253]
X-Outbound-Node: rcdn-core-5.cisco.com
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

sg_reset performs a device reset/lun reset on a lun.
Since it is issued by the user, it does not come into the
driver with a tag or a queue id.
Fix the fnic driver to create an io_req and use a scsi command tag.
Fix the ITMF path to special case the sg_reset response.

Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Tested-by: Karan Tilak Kumar <kartilak@cisco.com>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
---
 drivers/scsi/fnic/fnic.h      |  4 ++-
 drivers/scsi/fnic/fnic_io.h   |  2 ++
 drivers/scsi/fnic/fnic_main.c |  2 ++
 drivers/scsi/fnic/fnic_scsi.c | 64 +++++++++++++++++++++++++----------
 4 files changed, 54 insertions(+), 18 deletions(-)

diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
index 93c68931a593..22cef283b2b9 100644
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -27,7 +27,7 @@
 
 #define DRV_NAME		"fnic"
 #define DRV_DESCRIPTION		"Cisco FCoE HBA Driver"
-#define DRV_VERSION		"1.6.0.56"
+#define DRV_VERSION		"1.6.0.57"
 #define PFX			DRV_NAME ": "
 #define DFX                     DRV_NAME "%d: "
 
@@ -237,6 +237,8 @@ struct fnic {
 	unsigned int cq_count;
 
 	struct mutex sgreset_mutex;
+	spinlock_t sgreset_lock; /* lock for sgreset */
+	struct scsi_cmnd *sgreset_sc;
 	struct dentry *fnic_stats_debugfs_host;
 	struct dentry *fnic_stats_debugfs_file;
 	struct dentry *fnic_reset_debugfs_file;
diff --git a/drivers/scsi/fnic/fnic_io.h b/drivers/scsi/fnic/fnic_io.h
index f4c8769df312..9ec41aadb04e 100644
--- a/drivers/scsi/fnic/fnic_io.h
+++ b/drivers/scsi/fnic/fnic_io.h
@@ -52,6 +52,8 @@ struct fnic_io_req {
 	unsigned long start_time; /* in jiffies */
 	struct completion *abts_done; /* completion for abts */
 	struct completion *dr_done; /* completion for device reset */
+	unsigned int tag;
+	struct scsi_cmnd *sc; /* midlayer's cmd pointer*/
 };
 
 enum fnic_port_speeds {
diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
index 984bc5fc55e2..f27f9319e0b2 100644
--- a/drivers/scsi/fnic/fnic_main.c
+++ b/drivers/scsi/fnic/fnic_main.c
@@ -754,6 +754,8 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	for (i = 0; i < FNIC_IO_LOCKS; i++)
 		spin_lock_init(&fnic->io_req_lock[i]);
 
+	spin_lock_init(&fnic->sgreset_lock);
+
 	err = -ENOMEM;
 	fnic->io_req_pool = mempool_create_slab_pool(2, fnic_io_req_cache);
 	if (!fnic->io_req_pool)
diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
index 9761b2c9db48..416d81954819 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -1047,9 +1047,9 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic,
 {
 	u8 type;
 	u8 hdr_status;
-	struct fcpio_tag tag;
+	struct fcpio_tag ftag;
 	u32 id;
-	struct scsi_cmnd *sc;
+	struct scsi_cmnd *sc = NULL;
 	struct fnic_io_req *io_req;
 	struct fnic_stats *fnic_stats = &fnic->fnic_stats;
 	struct abort_stats *abts_stats = &fnic->fnic_stats.abts_stats;
@@ -1058,27 +1058,43 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic,
 	unsigned long flags;
 	spinlock_t *io_lock;
 	unsigned long start_time;
+	unsigned int tag;
 
-	fcpio_header_dec(&desc->hdr, &type, &hdr_status, &tag);
-	fcpio_tag_id_dec(&tag, &id);
+	fcpio_header_dec(&desc->hdr, &type, &hdr_status, &ftag);
+	fcpio_tag_id_dec(&ftag, &id);
 
-	if ((id & FNIC_TAG_MASK) >= fnic->fnic_max_tag_id) {
+	tag = id & FNIC_TAG_MASK;
+	if (tag == fnic->fnic_max_tag_id) {
+		if (!(id & FNIC_TAG_DEV_RST)) {
+			shost_printk(KERN_ERR, fnic->lport->host,
+						"Tag out of range id 0x%x hdr status = %s\n",
+						id, fnic_fcpio_status_to_str(hdr_status));
+			return;
+		}
+	} else if (tag > fnic->fnic_max_tag_id) {
 		shost_printk(KERN_ERR, fnic->lport->host,
-		"Tag out of range tag %x hdr status = %s\n",
-		id, fnic_fcpio_status_to_str(hdr_status));
+					"Tag out of range tag 0x%x hdr status = %s\n",
+					tag, fnic_fcpio_status_to_str(hdr_status));
 		return;
 	}
 
-	sc = scsi_host_find_tag(fnic->lport->host, id & FNIC_TAG_MASK);
+	if ((tag == fnic->fnic_max_tag_id) && (id & FNIC_TAG_DEV_RST)) {
+		sc = fnic->sgreset_sc;
+		io_lock = &fnic->sgreset_lock;
+	} else {
+		sc = scsi_host_find_tag(fnic->lport->host, id & FNIC_TAG_MASK);
+		io_lock = fnic_io_lock_hash(fnic, sc);
+	}
+
 	WARN_ON_ONCE(!sc);
 	if (!sc) {
 		atomic64_inc(&fnic_stats->io_stats.sc_null);
 		shost_printk(KERN_ERR, fnic->lport->host,
 			  "itmf_cmpl sc is null - hdr status = %s tag = 0x%x\n",
-			  fnic_fcpio_status_to_str(hdr_status), id);
+			  fnic_fcpio_status_to_str(hdr_status), tag);
 		return;
 	}
-	io_lock = fnic_io_lock_hash(fnic, sc);
+
 	spin_lock_irqsave(io_lock, flags);
 	io_req = fnic_priv(sc)->io_req;
 	WARN_ON_ONCE(!io_req);
@@ -1089,7 +1105,7 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic,
 		shost_printk(KERN_ERR, fnic->lport->host,
 			  "itmf_cmpl io_req is null - "
 			  "hdr status = %s tag = 0x%x sc 0x%p\n",
-			  fnic_fcpio_status_to_str(hdr_status), id, sc);
+			  fnic_fcpio_status_to_str(hdr_status), tag, sc);
 		return;
 	}
 	start_time = io_req->start_time;
@@ -1938,6 +1954,10 @@ static inline int fnic_queue_dr_io_req(struct fnic *fnic,
 	struct scsi_lun fc_lun;
 	int ret = 0;
 	unsigned long intr_flags;
+	unsigned int tag = scsi_cmd_to_rq(sc)->tag;
+
+	if (tag == SCSI_NO_TAG)
+		tag = io_req->tag;
 
 	spin_lock_irqsave(host->host_lock, intr_flags);
 	if (unlikely(fnic_chk_state_flags_locked(fnic,
@@ -1964,7 +1984,8 @@ static inline int fnic_queue_dr_io_req(struct fnic *fnic,
 	/* fill in the lun info */
 	int_to_scsilun(sc->device->lun, &fc_lun);
 
-	fnic_queue_wq_copy_desc_itmf(wq, scsi_cmd_to_rq(sc)->tag | FNIC_TAG_DEV_RST,
+	tag |= FNIC_TAG_DEV_RST;
+	fnic_queue_wq_copy_desc_itmf(wq, tag,
 				     0, FCPIO_ITMF_LUN_RESET, SCSI_NO_TAG,
 				     fc_lun.scsi_lun, io_req->port_id,
 				     fnic->config.ra_tov, fnic->config.ed_tov);
@@ -2146,8 +2167,7 @@ static int fnic_clean_pending_aborts(struct fnic *fnic,
 		.ret = SUCCESS,
 	};
 
-	if (new_sc)
-		iter_data.lr_sc = lr_sc;
+	iter_data.lr_sc = lr_sc;
 
 	scsi_host_busy_iter(fnic->lport->host,
 			    fnic_pending_aborts_iter, &iter_data);
@@ -2230,8 +2250,14 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 		mutex_lock(&fnic->sgreset_mutex);
 		tag = fnic->fnic_max_tag_id;
 		new_sc = 1;
-	}
-	io_lock = fnic_io_lock_hash(fnic, sc);
+		fnic->sgreset_sc = sc;
+		io_lock = &fnic->sgreset_lock;
+		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
+			"fcid: 0x%x lun: 0x%llx flags: 0x%x tag: 0x%x Issuing sgreset\n",
+			rport->port_id, sc->device->lun, fnic_priv(sc)->flags, tag);
+	} else
+		io_lock = fnic_io_lock_hash(fnic, sc);
+
 	spin_lock_irqsave(io_lock, flags);
 	io_req = fnic_priv(sc)->io_req;
 
@@ -2247,6 +2273,8 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 		}
 		memset(io_req, 0, sizeof(*io_req));
 		io_req->port_id = rport->port_id;
+		io_req->tag = tag;
+		io_req->sc = sc;
 		fnic_priv(sc)->io_req = io_req;
 	}
 	io_req->dr_done = &tm_done;
@@ -2400,8 +2428,10 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 		  (u64)sc->cmnd[4] << 8 | sc->cmnd[5]),
 		  fnic_flags_and_state(sc));
 
-	if (new_sc)
+	if (new_sc) {
+		fnic->sgreset_sc = NULL;
 		mutex_unlock(&fnic->sgreset_mutex);
+	}
 
 	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
 		      "Returning from device reset %s\n",
-- 
2.31.1

