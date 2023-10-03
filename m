Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38ABF7B6ACB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbjJCNoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbjJCNoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:44:03 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570F9AB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 06:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1696340638;
        bh=h9Dl1eU0sLgzqglZswblCFsHlzD2Di7RAdG7+6ob61Y=;
        h=Message-ID:Subject:From:To:Date:From;
        b=EXf6bM7xe+OPhyON1dqFpnHVuz5ZsqfviJo+8uee14ZukSYYxZW0PaYxu/DEnBKHk
         WXFe1dSNGS1mo3bvdx51cs2Qy6UP7JUmCIYfaAWo6437CeLQDdTOLxd31joH8MFKSd
         ZdH377+MjPdsfPkkyX9i8pfN40xXQUeq6cEYfCKE=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id DA0C51280A7D;
        Tue,  3 Oct 2023 09:43:58 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id klVYvpDGpFnT; Tue,  3 Oct 2023 09:43:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1696340638;
        bh=h9Dl1eU0sLgzqglZswblCFsHlzD2Di7RAdG7+6ob61Y=;
        h=Message-ID:Subject:From:To:Date:From;
        b=EXf6bM7xe+OPhyON1dqFpnHVuz5ZsqfviJo+8uee14ZukSYYxZW0PaYxu/DEnBKHk
         WXFe1dSNGS1mo3bvdx51cs2Qy6UP7JUmCIYfaAWo6437CeLQDdTOLxd31joH8MFKSd
         ZdH377+MjPdsfPkkyX9i8pfN40xXQUeq6cEYfCKE=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1C8AB128071D;
        Tue,  3 Oct 2023 09:43:58 -0400 (EDT)
Message-ID: <82544739f91f3d64c8307205cfddac59365fc137.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.6-rc4
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 03 Oct 2023 09:43:56 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three fixes, all in drivers.  The fnic one is the most extensive
because the little used user initiated device reset path never tagged
the command and adding a tag is rather involved.  The other two fixes
are smaller and more obvious.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Dinghao Liu (1):
      scsi: zfcp: Fix a double put in zfcp_port_enqueue()

Junxiao Bi (1):
      scsi: target: core: Fix deadlock due to recursive locking

Karan Tilak Kumar (1):
      scsi: fnic: Fix sg_reset success path

And the diffstat:

 drivers/s390/scsi/zfcp_aux.c        |  9 +++---
 drivers/scsi/fnic/fnic.h            |  4 ++-
 drivers/scsi/fnic/fnic_io.h         |  2 ++
 drivers/scsi/fnic/fnic_main.c       |  2 ++
 drivers/scsi/fnic/fnic_scsi.c       | 64 +++++++++++++++++++++++++++----------
 drivers/target/target_core_device.c | 11 +++----
 6 files changed, 63 insertions(+), 29 deletions(-)

With full diff below.

James

---

diff --git a/drivers/s390/scsi/zfcp_aux.c b/drivers/s390/scsi/zfcp_aux.c
index df782646e856..ab2f35bc294d 100644
--- a/drivers/s390/scsi/zfcp_aux.c
+++ b/drivers/s390/scsi/zfcp_aux.c
@@ -518,12 +518,12 @@ struct zfcp_port *zfcp_port_enqueue(struct zfcp_adapter *adapter, u64 wwpn,
 	if (port) {
 		put_device(&port->dev);
 		retval = -EEXIST;
-		goto err_out;
+		goto err_put;
 	}
 
 	port = kzalloc(sizeof(struct zfcp_port), GFP_KERNEL);
 	if (!port)
-		goto err_out;
+		goto err_put;
 
 	rwlock_init(&port->unit_list_lock);
 	INIT_LIST_HEAD(&port->unit_list);
@@ -546,7 +546,7 @@ struct zfcp_port *zfcp_port_enqueue(struct zfcp_adapter *adapter, u64 wwpn,
 
 	if (dev_set_name(&port->dev, "0x%016llx", (unsigned long long)wwpn)) {
 		kfree(port);
-		goto err_out;
+		goto err_put;
 	}
 	retval = -EINVAL;
 
@@ -563,7 +563,8 @@ struct zfcp_port *zfcp_port_enqueue(struct zfcp_adapter *adapter, u64 wwpn,
 
 	return port;
 
-err_out:
+err_put:
 	zfcp_ccw_adapter_put(adapter);
+err_out:
 	return ERR_PTR(retval);
 }
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
diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index b7ac60f4a219..b6523d4b9259 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -843,7 +843,6 @@ sector_t target_to_linux_sector(struct se_device *dev, sector_t lb)
 EXPORT_SYMBOL(target_to_linux_sector);
 
 struct devices_idr_iter {
-	struct config_item *prev_item;
 	int (*fn)(struct se_device *dev, void *data);
 	void *data;
 };
@@ -853,11 +852,9 @@ static int target_devices_idr_iter(int id, void *p, void *data)
 {
 	struct devices_idr_iter *iter = data;
 	struct se_device *dev = p;
+	struct config_item *item;
 	int ret;
 
-	config_item_put(iter->prev_item);
-	iter->prev_item = NULL;
-
 	/*
 	 * We add the device early to the idr, so it can be used
 	 * by backend modules during configuration. We do not want
@@ -867,12 +864,13 @@ static int target_devices_idr_iter(int id, void *p, void *data)
 	if (!target_dev_configured(dev))
 		return 0;
 
-	iter->prev_item = config_item_get_unless_zero(&dev->dev_group.cg_item);
-	if (!iter->prev_item)
+	item = config_item_get_unless_zero(&dev->dev_group.cg_item);
+	if (!item)
 		return 0;
 	mutex_unlock(&device_mutex);
 
 	ret = iter->fn(dev, iter->data);
+	config_item_put(item);
 
 	mutex_lock(&device_mutex);
 	return ret;
@@ -895,7 +893,6 @@ int target_for_each_device(int (*fn)(struct se_device *dev, void *data),
 	mutex_lock(&device_mutex);
 	ret = idr_for_each(&devices_idr, target_devices_idr_iter, &iter);
 	mutex_unlock(&device_mutex);
-	config_item_put(iter.prev_item);
 	return ret;
 }
 

