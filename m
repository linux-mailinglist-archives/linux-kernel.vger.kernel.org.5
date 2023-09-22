Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CE27AAE4F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjIVJhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbjIVJhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:37:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EA6CE;
        Fri, 22 Sep 2023 02:37:01 -0700 (PDT)
Received: from kwepemm000012.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RsRs41nW5zGppG;
        Fri, 22 Sep 2023 17:33:12 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm000012.china.huawei.com (7.193.23.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 22 Sep 2023 17:36:58 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <louhongxiang@huawei.com>,
        Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH 2/2] scsi: scsi_error: Fix device reset is not triggered
Date:   Fri, 22 Sep 2023 17:36:36 +0800
Message-ID: <20230922093636.2645961-3-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230922093636.2645961-1-haowenchao2@huawei.com>
References: <20230922093636.2645961-1-haowenchao2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000012.china.huawei.com (7.193.23.142)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the issue of skipping scsi_try_bus_device_reset() for devices
which is in progress of removing in following order:

T1:					T2:scsi_error_handle
__scsi_remove_device
  scsi_device_set_state(sdev, SDEV_DEL)
					// would skip device with SDEV_DEL state
  					shost_for_each_device()
					  scsi_try_bus_device_reset
					flush all commands
 ...
 scsi_device is released

Some drivers like smartpqi only implement eh_device_reset_handler,
if device reset is skipped, the commands which had been sent to
firmware or devices hardware are not cleared. The error handle
would flush all these commands in scsi_unjam_host().

When the commands are finished by hardware, use after free issue is
triggered.

Add parameter "check_state" to macro shost_for_each_device() to
determine if check device status when traversal scsi_device
of Scsi_Host, and set this parameter to false when traversal
in scsi_error_handle to address this issue.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 drivers/infiniband/ulp/srp/ib_srp.c         |  2 +-
 drivers/message/fusion/mptctl.c             |  6 ++--
 drivers/message/fusion/mptsas.c             |  8 ++---
 drivers/message/fusion/mptspi.c             |  6 ++--
 drivers/s390/scsi/zfcp_fsf.c                |  4 +--
 drivers/s390/scsi/zfcp_scsi.c               |  2 +-
 drivers/scsi/arm/acornscsi.c                |  2 +-
 drivers/scsi/arm/fas216.c                   |  4 +--
 drivers/scsi/bfa/bfad_im.c                  |  4 +--
 drivers/scsi/ibmvscsi/ibmvfc.c              |  2 +-
 drivers/scsi/lpfc/lpfc_scsi.c               |  4 +--
 drivers/scsi/megaraid/megaraid_sas_base.c   |  2 +-
 drivers/scsi/megaraid/megaraid_sas_fusion.c |  2 +-
 drivers/scsi/mpt3sas/mpt3sas_ctl.c          |  4 +--
 drivers/scsi/mpt3sas/mpt3sas_scsih.c        | 16 ++++-----
 drivers/scsi/myrb.c                         |  2 +-
 drivers/scsi/myrs.c                         |  2 +-
 drivers/scsi/scsi.c                         | 37 ++++++++++++---------
 drivers/scsi/scsi_debug.c                   |  2 +-
 drivers/scsi/scsi_error.c                   | 12 +++----
 drivers/scsi/scsi_lib.c                     |  6 ++--
 drivers/scsi/scsi_scan.c                    |  2 +-
 drivers/scsi/scsi_transport_srp.c           |  2 +-
 drivers/scsi/ses.c                          |  2 +-
 drivers/scsi/storvsc_drv.c                  |  2 +-
 drivers/scsi/virtio_scsi.c                  |  2 +-
 drivers/ufs/core/ufshcd.c                   |  4 +--
 include/scsi/scsi_device.h                  | 12 ++++---
 28 files changed, 83 insertions(+), 72 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 1574218764e0..219516e33ca7 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -3098,7 +3098,7 @@ static int srp_sdev_count(struct Scsi_Host *host)
 	struct scsi_device *sdev;
 	int c = 0;
 
-	shost_for_each_device(sdev, host)
+	shost_for_each_device(sdev, host, 1)
 		c++;
 
 	return c;
diff --git a/drivers/message/fusion/mptctl.c b/drivers/message/fusion/mptctl.c
index dd028df4b283..58c4d27fb386 100644
--- a/drivers/message/fusion/mptctl.c
+++ b/drivers/message/fusion/mptctl.c
@@ -1310,7 +1310,7 @@ mptctl_getiocinfo (MPT_ADAPTER *ioc, unsigned long arg, unsigned int data_size)
          */
 	karg->numDevices = 0;
 	if (ioc->sh) {
-		shost_for_each_device(sdev, ioc->sh) {
+		shost_for_each_device(sdev, ioc->sh, 1) {
 			vdevice = sdev->hostdata;
 			if (vdevice == NULL || vdevice->vtarget == NULL)
 				continue;
@@ -1416,7 +1416,7 @@ mptctl_gettargetinfo (MPT_ADAPTER *ioc, unsigned long arg)
 	/* Get number of devices
          */
 	if (ioc->sh){
-		shost_for_each_device(sdev, ioc->sh) {
+		shost_for_each_device(sdev, ioc->sh, 1) {
 			if (!maxWordsLeft)
 				continue;
 			vdevice = sdev->hostdata;
@@ -1889,7 +1889,7 @@ mptctl_do_mpt_command (MPT_ADAPTER *ioc, struct mpt_ioctl_command karg, void __u
 				cpu_to_le32(ioc->sense_buf_low_dma
 				   + (req_idx * MPT_SENSE_BUFFER_ALLOC));
 
-			shost_for_each_device(sdev, ioc->sh) {
+			shost_for_each_device(sdev, ioc->sh, 1) {
 				struct scsi_target *starget = scsi_target(sdev);
 				VirtTarget *vtarget = starget->hostdata;
 
diff --git a/drivers/message/fusion/mptsas.c b/drivers/message/fusion/mptsas.c
index 86f16f3ea478..0835fd31af7d 100644
--- a/drivers/message/fusion/mptsas.c
+++ b/drivers/message/fusion/mptsas.c
@@ -623,7 +623,7 @@ mptsas_add_device_component(MPT_ADAPTER *ioc, u8 channel, u8 id,
 	/*
 	 * Set OS mapping
 	 */
-	shost_for_each_device(sdev, ioc->sh) {
+	shost_for_each_device(sdev, ioc->sh, 1) {
 		starget = scsi_target(sdev);
 		rphy = dev_to_rphy(starget->dev.parent);
 		if (rphy->identify.sas_address == sas_address) {
@@ -996,7 +996,7 @@ mptsas_find_vtarget(MPT_ADAPTER *ioc, u8 channel, u8 id)
 	VirtDevice			*vdevice;
 	VirtTarget 			*vtarget = NULL;
 
-	shost_for_each_device(sdev, ioc->sh) {
+	shost_for_each_device(sdev, ioc->sh, 1) {
 		vdevice = sdev->hostdata;
 		if ((vdevice == NULL) ||
 			(vdevice->vtarget == NULL))
@@ -3768,7 +3768,7 @@ mptsas_send_link_status_event(struct fw_event_work *fw_event)
 				    ioc->name, phy_info->attached.id,
 				    phy_info->attached.channel));
 
-				shost_for_each_device(sdev, ioc->sh) {
+				shost_for_each_device(sdev, ioc->sh, 1) {
 					vdevice = sdev->hostdata;
 					if ((vdevice == NULL) ||
 						(vdevice->vtarget == NULL))
@@ -4101,7 +4101,7 @@ mptsas_handle_queue_full_event(struct fw_event_work *fw_event)
 	mutex_unlock(&ioc->sas_device_info_mutex);
 
 	if (id != -1) {
-		shost_for_each_device(sdev, ioc->sh) {
+		shost_for_each_device(sdev, ioc->sh, 1) {
 			if (sdev->id == id && sdev->channel == channel) {
 				if (current_depth > sdev->queue_depth) {
 					sdev_printk(KERN_INFO, sdev,
diff --git a/drivers/message/fusion/mptspi.c b/drivers/message/fusion/mptspi.c
index 6c5920db1e9d..5a311e950529 100644
--- a/drivers/message/fusion/mptspi.c
+++ b/drivers/message/fusion/mptspi.c
@@ -1125,7 +1125,7 @@ static void mpt_work_wrapper(struct work_struct *work)
 	if (!pg3)
 		return;
 
-	shost_for_each_device(sdev,shost) {
+	shost_for_each_device(sdev, shost, 1) {
 		struct scsi_target *starget = scsi_target(sdev);
 		VirtTarget *vtarget = starget->hostdata;
 
@@ -1267,7 +1267,7 @@ mptspi_dv_renegotiate_work(struct work_struct *work)
 	kfree(wqw);
 
 	if (hd->spi_pending) {
-		shost_for_each_device(sdev, ioc->sh) {
+		shost_for_each_device(sdev, ioc->sh, 1) {
 			if  (hd->spi_pending & (1 << sdev->id))
 				continue;
 			starget = scsi_target(sdev);
@@ -1278,7 +1278,7 @@ mptspi_dv_renegotiate_work(struct work_struct *work)
 			mptspi_write_spi_device_pg1(starget, &pg1);
 		}
 	} else {
-		shost_for_each_device(sdev, ioc->sh)
+		shost_for_each_device(sdev, ioc->sh, 1)
 			mptspi_dv_device(hd, sdev);
 	}
 }
diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index ceed1b6f7cb6..908b5e95b632 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -2036,7 +2036,7 @@ static void zfcp_fsf_close_physical_port_handler(struct zfcp_fsf_req *req)
 		/* can't use generic zfcp_erp_modify_port_status because
 		 * ZFCP_STATUS_COMMON_OPEN must not be reset for the port */
 		atomic_andnot(ZFCP_STATUS_PORT_PHYS_OPEN, &port->status);
-		shost_for_each_device(sdev, port->adapter->scsi_host)
+		shost_for_each_device(sdev, port->adapter->scsi_host, 1)
 			if (sdev_to_zfcp(sdev)->port == port)
 				atomic_andnot(ZFCP_STATUS_COMMON_OPEN,
 						  &sdev_to_zfcp(sdev)->status);
@@ -2058,7 +2058,7 @@ static void zfcp_fsf_close_physical_port_handler(struct zfcp_fsf_req *req)
 		 * ZFCP_STATUS_COMMON_OPEN must not be reset for the port
 		 */
 		atomic_andnot(ZFCP_STATUS_PORT_PHYS_OPEN, &port->status);
-		shost_for_each_device(sdev, port->adapter->scsi_host)
+		shost_for_each_device(sdev, port->adapter->scsi_host, 1)
 			if (sdev_to_zfcp(sdev)->port == port)
 				atomic_andnot(ZFCP_STATUS_COMMON_OPEN,
 						  &sdev_to_zfcp(sdev)->status);
diff --git a/drivers/s390/scsi/zfcp_scsi.c b/drivers/s390/scsi/zfcp_scsi.c
index b2a8cd792266..de4d45cd33c0 100644
--- a/drivers/s390/scsi/zfcp_scsi.c
+++ b/drivers/s390/scsi/zfcp_scsi.c
@@ -350,7 +350,7 @@ static int zfcp_scsi_eh_target_reset_handler(struct scsi_cmnd *scpnt)
 		(struct zfcp_adapter *)shost->hostdata[0];
 	int ret;
 
-	shost_for_each_device(tmp_sdev, shost) {
+	shost_for_each_device(tmp_sdev, shost, 1) {
 		if (tmp_sdev->id == starget->id) {
 			sdev = tmp_sdev;
 			break;
diff --git a/drivers/scsi/arm/acornscsi.c b/drivers/scsi/arm/acornscsi.c
index 0b046e4b395c..56cbef04e040 100644
--- a/drivers/scsi/arm/acornscsi.c
+++ b/drivers/scsi/arm/acornscsi.c
@@ -2760,7 +2760,7 @@ static int acornscsi_show_info(struct seq_file *m, struct Scsi_Host *instance)
 
     seq_printf(m, "\nAttached devices:\n");
 
-    shost_for_each_device(scd, instance) {
+    shost_for_each_device(scd, instance, 1) {
 	seq_printf(m, "Device/Lun TaggedQ      Sync\n");
 	seq_printf(m, "     %d/%llu   ", scd->id, scd->lun);
 	if (scd->tagged_supported)
diff --git a/drivers/scsi/arm/fas216.c b/drivers/scsi/arm/fas216.c
index 4ce0b2d73614..49c5641b0584 100644
--- a/drivers/scsi/arm/fas216.c
+++ b/drivers/scsi/arm/fas216.c
@@ -2589,7 +2589,7 @@ int fas216_eh_bus_reset(struct scsi_cmnd *SCpnt)
 	 * all command structures.  Leave the running
 	 * command in place.
 	 */
-	shost_for_each_device(SDpnt, info->host) {
+	shost_for_each_device(SDpnt, info->host, 1) {
 		int i;
 
 		if (SDpnt->soft_reset)
@@ -2999,7 +2999,7 @@ void fas216_print_devices(FAS216_Info *info, struct seq_file *m)
 
 	seq_puts(m, "Device/Lun TaggedQ       Parity   Sync\n");
 
-	shost_for_each_device(scd, info->host) {
+	shost_for_each_device(scd, info->host, 1) {
 		dev = &info->device[scd->id];
 		seq_printf(m, "     %d/%llu   ", scd->id, scd->lun);
 		if (scd->tagged_supported)
diff --git a/drivers/scsi/bfa/bfad_im.c b/drivers/scsi/bfa/bfad_im.c
index a9d3d8562d3c..6525be907389 100644
--- a/drivers/scsi/bfa/bfad_im.c
+++ b/drivers/scsi/bfa/bfad_im.c
@@ -874,7 +874,7 @@ bfad_ramp_up_qdepth(struct bfad_itnim_s *itnim, struct scsi_device *sdev)
 		BFA_QUEUE_FULL_RAMP_UP_TIME * HZ) &&
 		((jiffies - itnim->last_queue_full_time) >
 		BFA_QUEUE_FULL_RAMP_UP_TIME * HZ)) {
-		shost_for_each_device(tmp_sdev, sdev->host) {
+		shost_for_each_device(tmp_sdev, sdev->host, 1) {
 			if (bfa_lun_queue_depth > tmp_sdev->queue_depth) {
 				if (tmp_sdev->id != sdev->id)
 					continue;
@@ -894,7 +894,7 @@ bfad_handle_qfull(struct bfad_itnim_s *itnim, struct scsi_device *sdev)
 
 	itnim->last_queue_full_time = jiffies;
 
-	shost_for_each_device(tmp_sdev, sdev->host) {
+	shost_for_each_device(tmp_sdev, sdev->host, 1) {
 		if (tmp_sdev->id != sdev->id)
 			continue;
 		scsi_track_queue_full(tmp_sdev, tmp_sdev->queue_depth - 1);
diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index ce9eb00e2ca0..7ed08c71fbd6 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -3012,7 +3012,7 @@ static void ibmvfc_terminate_rport_io(struct fc_rport *rport)
 	unsigned int found;
 
 	ENTER;
-	shost_for_each_device(sdev, shost) {
+	shost_for_each_device(sdev, shost, 1) {
 		dev_rport = starget_to_rport(scsi_target(sdev));
 		if (dev_rport != rport)
 			continue;
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index d26941b131fd..a52188cbc13d 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -185,7 +185,7 @@ lpfc_ramp_down_queue_handler(struct lpfc_hba *phba)
 	if (vports != NULL)
 		for (i = 0; i <= phba->max_vports && vports[i] != NULL; i++) {
 			shost = lpfc_shost_from_vport(vports[i]);
-			shost_for_each_device(sdev, shost) {
+			shost_for_each_device(sdev, shost, 1) {
 				new_queue_depth =
 					sdev->queue_depth * num_rsrc_err /
 					(num_rsrc_err + num_cmd_success);
@@ -223,7 +223,7 @@ lpfc_scsi_dev_block(struct lpfc_hba *phba)
 	if (vports != NULL)
 		for (i = 0; i <= phba->max_vports && vports[i] != NULL; i++) {
 			shost = lpfc_shost_from_vport(vports[i]);
-			shost_for_each_device(sdev, shost) {
+			shost_for_each_device(sdev, shost, 1) {
 				rport = starget_to_rport(scsi_target(sdev));
 				fc_remote_port_delete(rport);
 			}
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index b9d46dcb5210..84158a3fb517 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -3444,7 +3444,7 @@ enable_sdev_max_qd_store(struct device *cdev,
 	else
 		instance->enable_sdev_max_qd = false;
 
-	shost_for_each_device(sdev, shost) {
+	shost_for_each_device(sdev, shost, 1) {
 		ret_target_prop = megasas_get_target_prop(instance, sdev);
 		is_target_prop = (ret_target_prop == DCMD_SUCCESS) ? true : false;
 		megasas_set_fw_assisted_qd(sdev, is_target_prop);
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index 8a83f3fc2b86..f10f0c5ef9d8 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -5110,7 +5110,7 @@ int megasas_reset_fusion(struct Scsi_Host *shost, int reason)
 				  &instance->reset_flags);
 			instance->instancet->enable_intr(instance);
 			megasas_enable_irq_poll(instance);
-			shost_for_each_device(sdev, shost) {
+			shost_for_each_device(sdev, shost, 1) {
 				if ((instance->tgt_prop) &&
 				    (instance->nvme_page_size))
 					ret_target_prop = megasas_get_target_prop(instance, sdev);
diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index efdb8178db32..ff6692d8e313 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -3879,7 +3879,7 @@ enable_sdev_max_qd_store(struct device *cdev,
 	switch (val) {
 	case 0:
 		ioc->enable_sdev_max_qd = 0;
-		shost_for_each_device(sdev, ioc->shost) {
+		shost_for_each_device(sdev, ioc->shost, 1) {
 			sas_device_priv_data = sdev->hostdata;
 			if (!sas_device_priv_data)
 				continue;
@@ -3922,7 +3922,7 @@ enable_sdev_max_qd_store(struct device *cdev,
 		break;
 	case 1:
 		ioc->enable_sdev_max_qd = 1;
-		shost_for_each_device(sdev, ioc->shost)
+		shost_for_each_device(sdev, ioc->shost, 1)
 			mpt3sas_scsih_change_queue_depth(sdev,
 			    shost->can_queue);
 		break;
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index c3c1f466fe01..b3e0a92d861c 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -2888,7 +2888,7 @@ mpt3sas_scsih_set_tm_flag(struct MPT3SAS_ADAPTER *ioc, u16 handle)
 	struct scsi_device *sdev;
 	u8 skip = 0;
 
-	shost_for_each_device(sdev, ioc->shost) {
+	shost_for_each_device(sdev, ioc->shost, 1) {
 		if (skip)
 			continue;
 		sas_device_priv_data = sdev->hostdata;
@@ -2916,7 +2916,7 @@ mpt3sas_scsih_clear_tm_flag(struct MPT3SAS_ADAPTER *ioc, u16 handle)
 	struct scsi_device *sdev;
 	u8 skip = 0;
 
-	shost_for_each_device(sdev, ioc->shost) {
+	shost_for_each_device(sdev, ioc->shost, 1) {
 		if (skip)
 			continue;
 		sas_device_priv_data = sdev->hostdata;
@@ -3836,7 +3836,7 @@ _scsih_ublock_io_all_device(struct MPT3SAS_ADAPTER *ioc)
 	struct MPT3SAS_DEVICE *sas_device_priv_data;
 	struct scsi_device *sdev;
 
-	shost_for_each_device(sdev, ioc->shost) {
+	shost_for_each_device(sdev, ioc->shost, 1) {
 		sas_device_priv_data = sdev->hostdata;
 		if (!sas_device_priv_data)
 			continue;
@@ -3866,7 +3866,7 @@ _scsih_ublock_io_device(struct MPT3SAS_ADAPTER *ioc,
 	struct MPT3SAS_DEVICE *sas_device_priv_data;
 	struct scsi_device *sdev;
 
-	shost_for_each_device(sdev, ioc->shost) {
+	shost_for_each_device(sdev, ioc->shost, 1) {
 		sas_device_priv_data = sdev->hostdata;
 		if (!sas_device_priv_data || !sas_device_priv_data->sas_target)
 			continue;
@@ -3893,7 +3893,7 @@ _scsih_block_io_all_device(struct MPT3SAS_ADAPTER *ioc)
 	struct MPT3SAS_DEVICE *sas_device_priv_data;
 	struct scsi_device *sdev;
 
-	shost_for_each_device(sdev, ioc->shost) {
+	shost_for_each_device(sdev, ioc->shost, 1) {
 		sas_device_priv_data = sdev->hostdata;
 		if (!sas_device_priv_data)
 			continue;
@@ -3925,7 +3925,7 @@ _scsih_block_io_device(struct MPT3SAS_ADAPTER *ioc, u16 handle)
 
 	sas_device = mpt3sas_get_sdev_by_handle(ioc, handle);
 
-	shost_for_each_device(sdev, ioc->shost) {
+	shost_for_each_device(sdev, ioc->shost, 1) {
 		sas_device_priv_data = sdev->hostdata;
 		if (!sas_device_priv_data)
 			continue;
@@ -9654,7 +9654,7 @@ _scsih_prep_device_scan(struct MPT3SAS_ADAPTER *ioc)
 	struct MPT3SAS_DEVICE *sas_device_priv_data;
 	struct scsi_device *sdev;
 
-	shost_for_each_device(sdev, ioc->shost) {
+	shost_for_each_device(sdev, ioc->shost, 1) {
 		sas_device_priv_data = sdev->hostdata;
 		if (sas_device_priv_data && sas_device_priv_data->sas_target)
 			sas_device_priv_data->sas_target->deleted = 1;
@@ -9676,7 +9676,7 @@ _scsih_update_device_qdepth(struct MPT3SAS_ADAPTER *ioc)
 	u16 qdepth;
 
 	ioc_info(ioc, "Update devices with firmware reported queue depth\n");
-	shost_for_each_device(sdev, ioc->shost) {
+	shost_for_each_device(sdev, ioc->shost, 1) {
 		sas_device_priv_data = sdev->hostdata;
 		if (sas_device_priv_data && sas_device_priv_data->sas_target) {
 			sas_target_priv_data = sas_device_priv_data->sas_target;
diff --git a/drivers/scsi/myrb.c b/drivers/scsi/myrb.c
index ca2e932dd9b7..8157b60ac488 100644
--- a/drivers/scsi/myrb.c
+++ b/drivers/scsi/myrb.c
@@ -357,7 +357,7 @@ static void myrb_get_errtable(struct myrb_hba *cb)
 		size_t err_table_offset;
 		struct scsi_device *sdev;
 
-		shost_for_each_device(sdev, cb->host) {
+		shost_for_each_device(sdev, cb->host, 1) {
 			if (sdev->channel >= myrb_logical_channel(cb->host))
 				continue;
 			err_table_offset = sdev->channel * MYRB_MAX_TARGETS
diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
index a1eec65a9713..2433f0bc1133 100644
--- a/drivers/scsi/myrs.c
+++ b/drivers/scsi/myrs.c
@@ -2141,7 +2141,7 @@ static void myrs_monitor(struct work_struct *work)
 	    info->exp_active != 0) {
 		struct scsi_device *sdev;
 
-		shost_for_each_device(sdev, shost) {
+		shost_for_each_device(sdev, shost, 1) {
 			struct myrs_ldev_info *ldev_info;
 			int ldev_num;
 
diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index d0911bc28663..db8b9e42267c 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -704,6 +704,23 @@ int scsi_cdl_enable(struct scsi_device *sdev, bool enable)
 	return 0;
 }
 
+static int __scsi_device_get(struct scsi_device *sdev, bool check_state)
+{
+	if (check_state &&
+	    (sdev->sdev_state == SDEV_DEL || sdev->sdev_state == SDEV_CANCEL))
+		goto fail;
+	if (!try_module_get(sdev->host->hostt->module))
+		goto fail;
+	if (!get_device(&sdev->sdev_gendev))
+		goto fail_put_module;
+	return 0;
+
+fail_put_module:
+	module_put(sdev->host->hostt->module);
+fail:
+	return -ENXIO;
+}
+
 /**
  * scsi_device_get  -  get an additional reference to a scsi_device
  * @sdev:	device to get a reference to
@@ -717,18 +734,7 @@ int scsi_cdl_enable(struct scsi_device *sdev, bool enable)
  */
 int scsi_device_get(struct scsi_device *sdev)
 {
-	if (sdev->sdev_state == SDEV_DEL || sdev->sdev_state == SDEV_CANCEL)
-		goto fail;
-	if (!try_module_get(sdev->host->hostt->module))
-		goto fail;
-	if (!get_device(&sdev->sdev_gendev))
-		goto fail_put_module;
-	return 0;
-
-fail_put_module:
-	module_put(sdev->host->hostt->module);
-fail:
-	return -ENXIO;
+	return __scsi_device_get(sdev, 1);
 }
 EXPORT_SYMBOL(scsi_device_get);
 
@@ -751,7 +757,8 @@ EXPORT_SYMBOL(scsi_device_put);
 
 /* helper for shost_for_each_device, see that for documentation */
 struct scsi_device *__scsi_iterate_devices(struct Scsi_Host *shost,
-					   struct scsi_device *prev)
+					   struct scsi_device *prev,
+					   bool check_state)
 {
 	struct list_head *list = (prev ? &prev->siblings : &shost->__devices);
 	struct scsi_device *next = NULL;
@@ -761,7 +768,7 @@ struct scsi_device *__scsi_iterate_devices(struct Scsi_Host *shost,
 	while (list->next != &shost->__devices) {
 		next = list_entry(list->next, struct scsi_device, siblings);
 		/* skip devices that we can't get a reference to */
-		if (!scsi_device_get(next))
+		if (!__scsi_device_get(next, check_state))
 			break;
 		next = NULL;
 		list = list->next;
@@ -790,7 +797,7 @@ void starget_for_each_device(struct scsi_target *starget, void *data,
 	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
 	struct scsi_device *sdev;
 
-	shost_for_each_device(sdev, shost) {
+	shost_for_each_device(sdev, shost, 1) {
 		if ((sdev->channel == starget->channel) &&
 		    (sdev->id == starget->id))
 			fn(sdev, data);
diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 8d5253a5b90f..66f384815b80 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -1352,7 +1352,7 @@ static void all_config_cdb_len(void)
 	mutex_lock(&sdebug_host_list_mutex);
 	list_for_each_entry(sdbg_host, &sdebug_host_list, host_list) {
 		shost = sdbg_host->shost;
-		shost_for_each_device(sdev, shost) {
+		shost_for_each_device(sdev, shost, 1) {
 			config_cdb_len(sdev);
 		}
 	}
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index c67cdcdc3ba8..0769f8d7fc8d 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -407,7 +407,7 @@ static inline void scsi_eh_prt_fail_stats(struct Scsi_Host *shost,
 	int cmd_cancel = 0;
 	int devices_failed = 0;
 
-	shost_for_each_device(sdev, shost) {
+	shost_for_each_device(sdev, shost, 0) {
 		list_for_each_entry(scmd, work_q, eh_entry) {
 			if (scmd->device == sdev) {
 				++total_failures;
@@ -743,7 +743,7 @@ static void scsi_handle_queue_ramp_up(struct scsi_device *sdev)
 	 * Walk all devices of a target and do
 	 * ramp up on them.
 	 */
-	shost_for_each_device(tmp_sdev, sdev->host) {
+	shost_for_each_device(tmp_sdev, sdev->host, 1) {
 		if (tmp_sdev->channel != sdev->channel ||
 		    tmp_sdev->id != sdev->id ||
 		    tmp_sdev->queue_depth == sdev->max_queue_depth)
@@ -762,7 +762,7 @@ static void scsi_handle_queue_full(struct scsi_device *sdev)
 	if (!sht->track_queue_depth)
 		return;
 
-	shost_for_each_device(tmp_sdev, sdev->host) {
+	shost_for_each_device(tmp_sdev, sdev->host, 1) {
 		if (tmp_sdev->channel != sdev->channel ||
 		    tmp_sdev->id != sdev->id)
 			continue;
@@ -1501,7 +1501,7 @@ static int scsi_eh_stu(struct Scsi_Host *shost,
 	struct scsi_cmnd *scmd, *stu_scmd, *next;
 	struct scsi_device *sdev;
 
-	shost_for_each_device(sdev, shost) {
+	shost_for_each_device(sdev, shost, 1) {
 		if (scsi_host_eh_past_deadline(shost)) {
 			SCSI_LOG_ERROR_RECOVERY(3,
 				sdev_printk(KERN_INFO, sdev,
@@ -1568,7 +1568,7 @@ static int scsi_eh_bus_device_reset(struct Scsi_Host *shost,
 	struct scsi_device *sdev;
 	enum scsi_disposition rtn;
 
-	shost_for_each_device(sdev, shost) {
+	shost_for_each_device(sdev, shost, 0) {
 		if (scsi_host_eh_past_deadline(shost)) {
 			SCSI_LOG_ERROR_RECOVERY(3,
 				sdev_printk(KERN_INFO, sdev,
@@ -2120,7 +2120,7 @@ static void scsi_restart_operations(struct Scsi_Host *shost)
 	 * onto the head of the SCSI request queue for the device.  There
 	 * is no point trying to lock the door of an off-line device.
 	 */
-	shost_for_each_device(sdev, shost) {
+	shost_for_each_device(sdev, shost, 0) {
 		if (scsi_device_online(sdev) && sdev->was_reset && sdev->locked) {
 			scsi_eh_lock_door(sdev);
 			sdev->was_reset = 0;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index f3e388127dbd..2bb1db0b1846 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -470,7 +470,7 @@ void scsi_run_host_queues(struct Scsi_Host *shost)
 {
 	struct scsi_device *sdev;
 
-	shost_for_each_device(sdev, shost)
+	shost_for_each_device(sdev, shost, 1)
 		scsi_run_queue(sdev->request_queue);
 }
 
@@ -2968,7 +2968,7 @@ scsi_host_block(struct Scsi_Host *shost)
 	 * Call scsi_internal_device_block_nowait so we can avoid
 	 * calling synchronize_rcu() for each LUN.
 	 */
-	shost_for_each_device(sdev, shost) {
+	shost_for_each_device(sdev, shost, 1) {
 		mutex_lock(&sdev->state_mutex);
 		ret = scsi_internal_device_block_nowait(sdev);
 		mutex_unlock(&sdev->state_mutex);
@@ -2991,7 +2991,7 @@ scsi_host_unblock(struct Scsi_Host *shost, int new_state)
 	struct scsi_device *sdev;
 	int ret = 0;
 
-	shost_for_each_device(sdev, shost) {
+	shost_for_each_device(sdev, shost, 1) {
 		ret = scsi_internal_device_unblock(sdev, new_state);
 		if (ret) {
 			scsi_device_put(sdev);
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 52014b2d39e1..f78b42bb7a41 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -1804,7 +1804,7 @@ int scsi_scan_host_selected(struct Scsi_Host *shost, unsigned int channel,
 static void scsi_sysfs_add_devices(struct Scsi_Host *shost)
 {
 	struct scsi_device *sdev;
-	shost_for_each_device(sdev, shost) {
+	shost_for_each_device(sdev, shost, 1) {
 		/* target removed before the device could be added */
 		if (sdev->sdev_state == SDEV_DEL)
 			continue;
diff --git a/drivers/scsi/scsi_transport_srp.c b/drivers/scsi/scsi_transport_srp.c
index 64f6b22e8cc0..9e0da975d31e 100644
--- a/drivers/scsi/scsi_transport_srp.c
+++ b/drivers/scsi/scsi_transport_srp.c
@@ -564,7 +564,7 @@ int srp_reconnect_rport(struct srp_rport *rport)
 		 * invoking scsi_target_unblock() won't change the state of
 		 * these devices into running so do that explicitly.
 		 */
-		shost_for_each_device(sdev, shost) {
+		shost_for_each_device(sdev, shost, 1) {
 			mutex_lock(&sdev->state_mutex);
 			if (sdev->sdev_state == SDEV_OFFLINE)
 				sdev->sdev_state = SDEV_RUNNING;
diff --git a/drivers/scsi/ses.c b/drivers/scsi/ses.c
index d7d0c35c58b8..6b6ea0174a3d 100644
--- a/drivers/scsi/ses.c
+++ b/drivers/scsi/ses.c
@@ -796,7 +796,7 @@ static int ses_intf_add(struct device *cdev)
 
 	/* see if there are any devices matching before
 	 * we found the enclosure */
-	shost_for_each_device(tmp_sdev, sdev->host) {
+	shost_for_each_device(tmp_sdev, sdev->host, 1) {
 		if (tmp_sdev->lun != 0 || scsi_device_enclosure(tmp_sdev))
 			continue;
 		ses_match_to_enclosure(edev, tmp_sdev, 0);
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index a95936b18f69..ae6975434a7d 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -502,7 +502,7 @@ static void storvsc_host_scan(struct work_struct *work)
 	 * may have been removed this way.
 	 */
 	mutex_lock(&host->scan_mutex);
-	shost_for_each_device(sdev, host)
+	shost_for_each_device(sdev, host, 1)
 		scsi_test_unit_ready(sdev, 1, 1, NULL);
 	mutex_unlock(&host->scan_mutex);
 	/*
diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 9d1bdcdc1331..56310a2a63aa 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -341,7 +341,7 @@ static int virtscsi_rescan_hotunplug(struct virtio_scsi *vscsi)
 	if (!inq_result)
 		return -ENOMEM;
 
-	shost_for_each_device(sdev, shost) {
+	shost_for_each_device(sdev, shost, 1) {
 		inquiry_len = sdev->inquiry_len ? sdev->inquiry_len : 36;
 
 		memset(scsi_cmd, 0, sizeof(scsi_cmd));
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 93417518c04d..127dfd919d1b 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -6308,7 +6308,7 @@ static void ufshcd_recover_pm_error(struct ufs_hba *hba)
 	 * blk_queue_enter in case there are bios waiting inside it.
 	 */
 	if (!ret) {
-		shost_for_each_device(sdev, shost) {
+		shost_for_each_device(sdev, shost, 1) {
 			q = sdev->request_queue;
 			if (q->dev && (q->rpm_status == RPM_SUSPENDED ||
 				       q->rpm_status == RPM_SUSPENDING))
@@ -10061,7 +10061,7 @@ static void ufshcd_wl_shutdown(struct device *dev)
 	/* Turn on everything while shutting down */
 	ufshcd_rpm_get_sync(hba);
 	scsi_device_quiesce(sdev);
-	shost_for_each_device(sdev, hba->host) {
+	shost_for_each_device(sdev, hba->host, 1) {
 		if (sdev == hba->ufs_device_wlun)
 			continue;
 		scsi_device_quiesce(sdev);
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index c498a12f7715..e166d053c839 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -389,21 +389,25 @@ extern void __starget_for_each_device(struct scsi_target *, void *,
 
 /* only exposed to implement shost_for_each_device */
 extern struct scsi_device *__scsi_iterate_devices(struct Scsi_Host *,
-						  struct scsi_device *);
+						  struct scsi_device *,
+						  bool);
 
 /**
  * shost_for_each_device - iterate over all devices of a host
  * @sdev: the &struct scsi_device to use as a cursor
  * @shost: the &struct scsi_host to iterate over
+ * @check_state: if skip check scsi_device's state to skip some devices
+ *               scsi_device with SDEV_DEL or SDEV_CANCEL would be skipped
+ *               if this is true
  *
  * Iterator that returns each device attached to @shost.  This loop
  * takes a reference on each device and releases it at the end.  If
  * you break out of the loop, you must call scsi_device_put(sdev).
  */
-#define shost_for_each_device(sdev, shost) \
-	for ((sdev) = __scsi_iterate_devices((shost), NULL); \
+#define shost_for_each_device(sdev, shost, check_state) \
+	for ((sdev) = __scsi_iterate_devices((shost), NULL, check_state); \
 	     (sdev); \
-	     (sdev) = __scsi_iterate_devices((shost), (sdev)))
+	     (sdev) = __scsi_iterate_devices((shost), (sdev), check_state))
 
 /**
  * __shost_for_each_device - iterate over all devices of a host (UNLOCKED)
-- 
2.32.0

