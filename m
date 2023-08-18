Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E17E780FA7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378351AbjHRPzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378381AbjHRPzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:55:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919CD2722;
        Fri, 18 Aug 2023 08:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692374110; x=1723910110;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uHJKMvCK3q3kzQisOI1T7IJ1pZftHrB1L5QcaZ3KIpc=;
  b=hPlOQCBhtjw6DVzaAwB7oO7SQ12pm8Pcdjd/JZtS79yMD0I9CBCHweYj
   wW48GaGprjSUZUuDkzDR3PXtRHGzQbpN3+Rmijvnne2JSfRwhul66ULg5
   kJ3TtcXPjmMJut+bYynmUzzbMxupQXA8vPD74ttCh8vOgNO40j5EAzqwc
   xG2hQIZX4zA6eP+2hV+hxhGl4JeTlcA7sTsMhxBy4H8xjBIrzEVa4Q5oU
   FObIVhei8yyBrQuwVtxWOJeiVH7TIJZw3NxpA63py4nTa+IYLKgktbE94
   9kjpL+R02Q7uFlxdt8ZLrd0Xz64JsqbE3IvVax8qrRf9OO4eagrW4cbWo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="353435802"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="353435802"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 08:55:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="728641393"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="728641393"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 18 Aug 2023 08:54:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9A217DAB; Fri, 18 Aug 2023 18:54:56 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Justin Tee <justin.tee@broadcom.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 1/1] scsi: lpfc: Do not abuse UUID APIs and LPFC_COMPRESS_VMID_SIZE
Date:   Fri, 18 Aug 2023 18:54:52 +0300
Message-Id: <20230818155452.875781-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lpfc_vmid_host_uuid is not defined as uuid_t and its usage is not
the same as for uuid_t operations (like exporting or importing).
Hence replace call to uuid_is_null() by respective memchr_inv() without
abusing casting.

With that, replace LPFC_COMPRESS_VMID_SIZE with plain number and
respective sizeof() to make code robust to changes in the future,
if any.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: dropped LPFC_COMPRESS_VMID_SIZE completely at the same time
 drivers/scsi/lpfc/lpfc.h     |  3 +--
 drivers/scsi/lpfc/lpfc_els.c | 12 +++++++-----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index bc1c5f6df090..af15f7a22d25 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -309,7 +309,6 @@ struct lpfc_hba;
 #define LPFC_VMID_TIMER   300	/* timer interval in seconds */
 
 #define LPFC_MAX_VMID_SIZE      256
-#define LPFC_COMPRESS_VMID_SIZE 16
 
 union lpfc_vmid_io_tag {
 	u32 app_id;	/* App Id vmid */
@@ -667,7 +666,7 @@ struct lpfc_vport {
 	uint32_t cfg_first_burst_size;
 	uint32_t dev_loss_tmo_changed;
 	/* VMID parameters */
-	u8 lpfc_vmid_host_uuid[LPFC_COMPRESS_VMID_SIZE];
+	u8 lpfc_vmid_host_uuid[16];
 	u32 max_vmid;	/* maximum VMIDs allowed per port */
 	u32 cur_vmid_cnt;	/* Current VMID count */
 #define LPFC_MIN_VMID	4
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index b5cd6d1c0a5a..54e47f268235 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -1331,7 +1331,8 @@ lpfc_issue_els_flogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	if (phba->cfg_vmid_priority_tagging) {
 		sp->cmn.priority_tagging = 1;
 		/* lpfc_vmid_host_uuid is combination of wwpn and wwnn */
-		if (uuid_is_null((uuid_t *)vport->lpfc_vmid_host_uuid)) {
+		if (!memchr_inv(vport->lpfc_vmid_host_uuid, 0,
+				sizeof(vport->lpfc_vmid_host_uuid))) {
 			memcpy(vport->lpfc_vmid_host_uuid, phba->wwpn,
 			       sizeof(phba->wwpn));
 			memcpy(&vport->lpfc_vmid_host_uuid[8], phba->wwnn,
@@ -12357,9 +12358,10 @@ lpfc_vmid_uvem(struct lpfc_vport *vport,
 	elsiocb->vmid_tag.vmid_context = vmid_context;
 	pcmd = (u8 *)elsiocb->cmd_dmabuf->virt;
 
-	if (uuid_is_null((uuid_t *)vport->lpfc_vmid_host_uuid))
+	if (!memchr_inv(vport->lpfc_vmid_host_uuid, 0,
+			sizeof(vport->lpfc_vmid_host_uuid)))
 		memcpy(vport->lpfc_vmid_host_uuid, vmid->host_vmid,
-		       LPFC_COMPRESS_VMID_SIZE);
+		       sizeof(vport->lpfc_vmid_host_uuid));
 
 	*((u32 *)(pcmd)) = ELS_CMD_UVEM;
 	len = (u32 *)(pcmd + 4);
@@ -12369,13 +12371,13 @@ lpfc_vmid_uvem(struct lpfc_vport *vport,
 	vem_id_desc->tag = be32_to_cpu(VEM_ID_DESC_TAG);
 	vem_id_desc->length = be32_to_cpu(LPFC_UVEM_VEM_ID_DESC_SIZE);
 	memcpy(vem_id_desc->vem_id, vport->lpfc_vmid_host_uuid,
-	       LPFC_COMPRESS_VMID_SIZE);
+	       sizeof(vem_id_desc->vem_id));
 
 	inst_desc = (struct instantiated_ve_desc *)(pcmd + 32);
 	inst_desc->tag = be32_to_cpu(INSTANTIATED_VE_DESC_TAG);
 	inst_desc->length = be32_to_cpu(LPFC_UVEM_VE_MAP_DESC_SIZE);
 	memcpy(inst_desc->global_vem_id, vmid->host_vmid,
-	       LPFC_COMPRESS_VMID_SIZE);
+	       sizeof(inst_desc->global_vem_id));
 
 	bf_set(lpfc_instantiated_nport_id, inst_desc, vport->fc_myDID);
 	bf_set(lpfc_instantiated_local_id, inst_desc,
-- 
2.40.0.1.gaa8946217a0b

