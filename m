Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67731771DAF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 12:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjHGKAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 06:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjHGKAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 06:00:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9D1DD;
        Mon,  7 Aug 2023 03:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691402408; x=1722938408;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Cnv86AvV5oXeXJaWvkZrIjdDJcntU03jA75p6wKRBLg=;
  b=h3O5dousvy/5Qc9ljW32WaQmhn9d+Dk/lu8/jKohuEmrXdqy7si9QLg7
   G+dlr1IIiTbDaCEgwUqvYW9D+AN07UtzvIbRvH3LuVL3qFnAM/yZ68/Pj
   aGsTRltTpd0FgdCTVdORl8KE9NeZUqvfMpYMGRGgdowJBPg+VwZ9I1bcE
   Aq24SH/N9j7mhxjV10/gpUV7SEoazQOcDUp9unlu0LQZbjFfGEz06sLtW
   qgGJO2k8CtafL5+gWOE6GlIOyYPZJz3iRxHe1HSWPczO4cb+Nvv7bH5o2
   LOIgqom6zMM5YtrPe88ZSEj2Oou9ChgZ36om3DSXgsQwyw6zM0ZIlFYym
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="369406962"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
   d="scan'208";a="369406962"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 03:00:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="1061536245"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
   d="scan'208";a="1061536245"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 07 Aug 2023 03:00:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 58C1917C; Mon,  7 Aug 2023 13:02:19 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Justin Tee <justin.tee@broadcom.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] scsi: lpfc: Do not abuse UUID APIs
Date:   Mon,  7 Aug 2023 13:02:17 +0300
Message-Id: <20230807100217.34646-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lpfc_vmid_host_uuid is not defined as uuid_t and its usage is not
the same as for uuid_t operations (like exporting or importing).
Hence replace call to uuid_is_null() by respective memchr_inv() without
abusing casting.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: fixed the logic: memchr_inv() returns "true" when uuid_is_null() returns false.
 drivers/scsi/lpfc/lpfc_els.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 2bad9954c355..1e74ae65768d 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -1332,7 +1332,7 @@ lpfc_issue_els_flogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	if (phba->cfg_vmid_priority_tagging) {
 		sp->cmn.priority_tagging = 1;
 		/* lpfc_vmid_host_uuid is combination of wwpn and wwnn */
-		if (uuid_is_null((uuid_t *)vport->lpfc_vmid_host_uuid)) {
+		if (!memchr_inv(vport->lpfc_vmid_host_uuid, 0, LPFC_COMPRESS_VMID_SIZE)) {
 			memcpy(vport->lpfc_vmid_host_uuid, phba->wwpn,
 			       sizeof(phba->wwpn));
 			memcpy(&vport->lpfc_vmid_host_uuid[8], phba->wwnn,
@@ -12331,7 +12331,7 @@ lpfc_vmid_uvem(struct lpfc_vport *vport,
 	elsiocb->vmid_tag.vmid_context = vmid_context;
 	pcmd = (u8 *)elsiocb->cmd_dmabuf->virt;
 
-	if (uuid_is_null((uuid_t *)vport->lpfc_vmid_host_uuid))
+	if (!memchr_inv(vport->lpfc_vmid_host_uuid, 0, LPFC_COMPRESS_VMID_SIZE))
 		memcpy(vport->lpfc_vmid_host_uuid, vmid->host_vmid,
 		       LPFC_COMPRESS_VMID_SIZE);
 
-- 
2.40.0.1.gaa8946217a0b

