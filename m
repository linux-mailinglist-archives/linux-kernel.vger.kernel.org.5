Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A634B7C946B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 13:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbjJNL5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 07:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbjJNL4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 07:56:48 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB787AD;
        Sat, 14 Oct 2023 04:56:44 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-406619b53caso30357375e9.1;
        Sat, 14 Oct 2023 04:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697284603; x=1697889403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HcvZ+aXOynMpDzQNzlsLqcG5LjH/lrOgjIR3ADaupcI=;
        b=NhFuxeKsdDQUc17FSexSuT1kP9jfHMDXKHqZwDNAxkJevelmj20LS31wvUCSdOZ5jZ
         Mi3ZQIFZdD8qpDg+aN4H6TvOPXsS2Ii5H92TyZFAJrEj5zqNaU2DV2MbmRiSpnns2WWC
         2uHQos8tOolQ406WQXT+Z6RiGK1M+B5z/EVf62o27p1uEDP3oR7XXMw64j2ZMtF0sIZu
         QLnKXcuFftMFhyBzJJdi6PZwgj/hLYuLDcPYvNS20pHxl9wQ3y+w8iaNdvo93+VLCwVz
         vB/At0F+TYF4o+g7Y1rkaU1XhDqQuJc5V14HtAWi+SNhQtieHYZ8yZzqvtP5WI1Ffqm8
         +07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697284603; x=1697889403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HcvZ+aXOynMpDzQNzlsLqcG5LjH/lrOgjIR3ADaupcI=;
        b=FJbOzv8P4NP4HdcYaIQo+vGdDfZ7QY8nrWP7Lz13fR/rmIf7SpBvTQiXuIaTqzB0eC
         mAVPcdXVsN4lfDrJ9fnXJnk/YizgmiFOKYnJtJTOHNMCwlJSxe4V13cTUX6XLiAftlRI
         jQyRAxrhp9tbxP7Q4jd2iZexMg34TgPO/8ORM2rviM/8TK2CMiz8WRS3ylJqv/9GnGh0
         x76CQg8ekva/3IRnk4aNQ+JeJ68W4gg7Bwi9RdmFNsNQkKuct56iqeiFY4rC6q0PBm25
         hLJXAhuG033i5jZZe86ArE6w55R53wIsFWJxjqeShBomjsMOe7a1OjjS2nY7X4gvR/9N
         6tLA==
X-Gm-Message-State: AOJu0Yw37Oww6YDuqzDdinzRDp+wjhKBMwWaU3Em46XVbPbf/Wf58Tde
        rvWhbtkqUnRka4MOqnfE0RTFiUAdFyPPxg==
X-Google-Smtp-Source: AGHT+IE4UmJmzPROZ4eItT2e2nw9W/dYbkY8/Nxze+h7mScDJem4AvrIZ39j0ePw6U+vP7jwij6x9Q==
X-Received: by 2002:adf:fc09:0:b0:31c:7ada:5e05 with SMTP id i9-20020adffc09000000b0031c7ada5e05mr22976317wrr.51.1697284602571;
        Sat, 14 Oct 2023 04:56:42 -0700 (PDT)
Received: from localhost.localdomain ([111.88.101.202])
        by smtp.gmail.com with ESMTPSA id p13-20020a5d68cd000000b0031ae8d86af4sm22721758wrw.103.2023.10.14.04.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 04:56:42 -0700 (PDT)
From:   Muhammad Muzammil <m.muzzammilashraf@gmail.com>
To:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Subject: [PATCH] drivers: scsi: lpfc: Fixed multiple typos in multiple files
Date:   Sat, 14 Oct 2023 16:55:51 +0500
Message-Id: <20231014115551.8607-1-m.muzzammilashraf@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lpfc.h: Fixed multiple typos
lpfc_attr.c: Fixed multiple typos
lpfc_bsg.c: Fixed multiple typos
lpfc_ct.c: Fixed multiple typos
lpfc_debugfs.c: Fixed multiple typos
lpfc_disc.h: Fixed multiple typos
lpfc_els.c: Fixed multiple typos
lpfc_hbadisc.c: Fixed multiple typos
lpfc_init.c: Fixed multiple typos
lpfc_nportdisc.c: Fixed multiple typos
lpfc_nvme.c: Fixed multiple typos
lpfc_nvmet.c: Fixed multiple typos
lpfc_scsi.c: Fixed multiple typos
lpfc_sli.c: Fixed multiple typos

Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
---
 drivers/scsi/lpfc/lpfc.h           |  2 +-
 drivers/scsi/lpfc/lpfc_attr.c      |  2 +-
 drivers/scsi/lpfc/lpfc_bsg.c       |  6 +++---
 drivers/scsi/lpfc/lpfc_ct.c        |  4 ++--
 drivers/scsi/lpfc/lpfc_debugfs.c   |  4 ++--
 drivers/scsi/lpfc/lpfc_disc.h      |  4 ++--
 drivers/scsi/lpfc/lpfc_els.c       | 16 ++++++++--------
 drivers/scsi/lpfc/lpfc_hbadisc.c   |  8 ++++----
 drivers/scsi/lpfc/lpfc_init.c      | 22 +++++++++++-----------
 drivers/scsi/lpfc/lpfc_nportdisc.c |  4 ++--
 drivers/scsi/lpfc/lpfc_nvme.c      |  2 +-
 drivers/scsi/lpfc/lpfc_nvmet.c     | 12 ++++++------
 drivers/scsi/lpfc/lpfc_scsi.c      |  6 +++---
 drivers/scsi/lpfc/lpfc_sli.c       |  8 ++++----
 14 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index af15f7a22d25..04da321425e2 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -1208,7 +1208,7 @@ struct lpfc_hba {
 
 	uint32_t hbq_in_use;		/* HBQs in use flag */
 	uint32_t hbq_count;	        /* Count of configured HBQs */
-	struct hbq_s hbqs[LPFC_MAX_HBQS]; /* local copy of hbq indicies  */
+	struct hbq_s hbqs[LPFC_MAX_HBQS]; /* local copy of hbq indices  */
 
 	atomic_t fcp_qidx;         /* next FCP WQ (RR Policy) */
 	atomic_t nvme_qidx;        /* next NVME WQ (RR Policy) */
diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index b1c9107d3408..50915ac4d7a9 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -3985,7 +3985,7 @@ lpfc_tgt_queue_depth_set(struct lpfc_vport *vport, uint val)
 	spin_lock_irq(shost->host_lock);
 	vport->cfg_tgt_queue_depth = val;
 
-	/* Next loop thru nodelist and change cmd_qdepth */
+	/* Next loop through nodelist and change cmd_qdepth */
 	list_for_each_entry(ndlp, &vport->fc_nodes, nlp_listp)
 		ndlp->cmd_qdepth = vport->cfg_tgt_queue_depth;
 
diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
index 595dca92e8db..233333f4b9f4 100644
--- a/drivers/scsi/lpfc/lpfc_bsg.c
+++ b/drivers/scsi/lpfc/lpfc_bsg.c
@@ -2057,7 +2057,7 @@ lpfc_sli4_bsg_diag_loopback_mode(struct lpfc_hba *phba, struct bsg_job *job)
 	phba->link_flag |= LS_LOOPBACK_MODE;
 	spin_unlock_irq(&phba->hbalock);
 
-	/* reset port to start frome scratch */
+	/* reset port to start from scratch */
 	rc = lpfc_selective_reset(phba);
 	if (rc)
 		goto job_done;
@@ -2328,7 +2328,7 @@ lpfc_sli4_bsg_diag_mode_end(struct bsg_job *job)
  * @job: LPFC_BSG_VENDOR_DIAG_LINK_TEST
  *
  * This function is to perform SLI4 diag link test request from the user
- * applicaiton.
+ * application.
  */
 static int
 lpfc_sli4_bsg_link_diag_test(struct bsg_job *job)
@@ -4804,7 +4804,7 @@ lpfc_bsg_issue_mbox(struct lpfc_hba *phba, struct bsg_job *job,
 	} else if (phba->sli_rev == LPFC_SLI_REV4) {
 		/* Let type 4 (well known data) through because the data is
 		 * returned in varwords[4-8]
-		 * otherwise check the recieve length and fetch the buffer addr
+		 * otherwise check the receive length and fetch the buffer addr
 		 */
 		if ((pmb->mbxCommand == MBX_DUMP_MEMORY) &&
 			(pmb->un.varDmp.type != DMP_WELL_KNOWN)) {
diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
index baae1f8279e0..2501fa166528 100644
--- a/drivers/scsi/lpfc/lpfc_ct.c
+++ b/drivers/scsi/lpfc/lpfc_ct.c
@@ -2356,7 +2356,7 @@ lpfc_cmpl_ct_disc_fdmi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	}
 
 	/*
-	 * On success, need to cycle thru FDMI registration for discovery
+	 * On success, need to cycle through FDMI registration for discovery
 	 * DHBA -> DPRT -> RHBA -> RPA  (physical port)
 	 * DPRT -> RPRT (vports)
 	 */
@@ -2468,7 +2468,7 @@ lpfc_fdmi_change_check(struct lpfc_vport *vport)
 		lpfc_ns_cmd(vport, SLI_CTNS_RSNN_NN, 0, 0);
 
 		/* Since this effects multiple HBA and PORT attributes, we need
-		 * de-register and go thru the whole FDMI registration cycle.
+		 * de-register and go through the whole FDMI registration cycle.
 		 * DHBA -> DPRT -> RHBA -> RPA  (physical port)
 		 * DPRT -> RPRT (vports)
 		 */
diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index ea9b42225e62..39a743cf20ae 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -3152,7 +3152,7 @@ static int lpfc_idiag_cmd_get(const char __user *buf, size_t nbytes,
 	memset(mybuf, 0, sizeof(mybuf));
 	memset(idiag_cmd, 0, sizeof(*idiag_cmd));
 	bsize = min(nbytes, (sizeof(mybuf)-1));
-
+.
 	if (copy_from_user(mybuf, buf, bsize))
 		return -EFAULT;
 	pbuf = &mybuf[0];
@@ -6655,7 +6655,7 @@ lpfc_debugfs_terminate(struct lpfc_vport *vport)
  * lpfc_debug_dump_all_queues - dump all the queues with a hba
  * @phba: Pointer to HBA context object.
  *
- * This function dumps entries of all the queues asociated with the @phba.
+ * This function dumps entries of all the queues associated with the @phba.
  **/
 void
 lpfc_debug_dump_all_queues(struct lpfc_hba *phba)
diff --git a/drivers/scsi/lpfc/lpfc_disc.h b/drivers/scsi/lpfc/lpfc_disc.h
index f82615d87c4b..c5507eedabda 100644
--- a/drivers/scsi/lpfc/lpfc_disc.h
+++ b/drivers/scsi/lpfc/lpfc_disc.h
@@ -261,13 +261,13 @@ struct lpfc_node_rrq {
  * from the PLOGI or ADISC lists. Once the PLOGI and ADISC lists are populated,
  * we will first process the ADISC list.  32 entries are processed initially and
  * ADISC is initited for each one.  Completions / Events for each node are
- * funnelled thru the state machine.  As each node finishes ADISC processing, it
+ * funnelled through the state machine.  As each node finishes ADISC processing, it
  * starts ADISC for any nodes waiting for ADISC processing. If no nodes are
  * waiting, and the ADISC list count is identically 0, then we are done. For
  * Link Up discovery, since all nodes on the PLOGI list are UNREG_LOGIN'ed, we
  * can issue a CLEAR_LA and reenable Link Events. Next we will process the PLOGI
  * list.  32 entries are processed initially and PLOGI is initited for each one.
- * Completions / Events for each node are funnelled thru the state machine.  As
+ * Completions / Events for each node are funnelled through the state machine.  As
  * each node finishes PLOGI processing, it starts PLOGI for any nodes waiting
  * for PLOGI processing. If no nodes are waiting, and the PLOGI list count is
  * identically 0, then we are done. We have now completed discovery / RSCN
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 54e47f268235..e06f235d4865 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -1639,7 +1639,7 @@ lpfc_more_plogi(struct lpfc_vport *vport)
 			 vport->fc_flag, vport->port_state);
 	/* Check to see if there are more PLOGIs to be sent */
 	if (vport->fc_flag & FC_NLP_MORE)
-		/* go thru NPR nodes and issue any remaining ELS PLOGIs */
+		/* go through NPR nodes and issue any remaining ELS PLOGIs */
 		lpfc_els_disc_plogi(vport);
 
 	return;
@@ -2480,7 +2480,7 @@ lpfc_issue_els_prli(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	 * If we are in RSCN mode, the FC4 types supported from a
 	 * previous GFT_ID command may not be accurate. So, if we
 	 * are a NVME Initiator, always look for the possibility of
-	 * the remote NPort beng a NVME Target.
+	 * the remote NPort being a NVME Target.
 	 */
 	if (phba->sli_rev == LPFC_SLI_REV4 &&
 	    vport->fc_flag & FC_RSCN_MODE &&
@@ -2659,7 +2659,7 @@ lpfc_rscn_disc(struct lpfc_vport *vport)
 	lpfc_can_disctmo(vport);
 
 	/* RSCN discovery */
-	/* go thru NPR nodes and issue ELS PLOGIs */
+	/* go through NPR nodes and issue ELS PLOGIs */
 	if (vport->fc_npr_cnt)
 		if (lpfc_els_disc_plogi(vport))
 			return;
@@ -2719,7 +2719,7 @@ lpfc_adisc_done(struct lpfc_vport *vport)
 		lpfc_issue_clear_la(phba, vport);
 		if (!(vport->fc_flag & FC_ABORT_DISCOVERY)) {
 			vport->num_disc_nodes = 0;
-			/* go thru NPR list, issue ELS PLOGIs */
+			/* go through NPR list, issue ELS PLOGIs */
 			if (vport->fc_npr_cnt)
 				lpfc_els_disc_plogi(vport);
 			if (!vport->num_disc_nodes) {
@@ -2758,7 +2758,7 @@ lpfc_more_adisc(struct lpfc_vport *vport)
 	/* Check to see if there are more ADISCs to be sent */
 	if (vport->fc_flag & FC_NLP_MORE) {
 		lpfc_set_disctmo(vport);
-		/* go thru NPR nodes and issue any remaining ELS ADISCs */
+		/* go through NPR nodes and issue any remaining ELS ADISCs */
 		lpfc_els_disc_adisc(vport);
 	}
 	if (!vport->num_disc_nodes)
@@ -6522,7 +6522,7 @@ lpfc_els_disc_adisc(struct lpfc_vport *vport)
 	struct lpfc_nodelist *ndlp, *next_ndlp;
 	int sentadisc = 0;
 
-	/* go thru NPR nodes and issue any remaining ELS ADISCs */
+	/* go through NPR nodes and issue any remaining ELS ADISCs */
 	list_for_each_entry_safe(ndlp, next_ndlp, &vport->fc_nodes, nlp_listp) {
 
 		if (ndlp->nlp_state != NLP_STE_NPR_NODE ||
@@ -6594,7 +6594,7 @@ lpfc_els_disc_plogi(struct lpfc_vport *vport)
 	struct lpfc_nodelist *ndlp, *next_ndlp;
 	int sentplogi = 0;
 
-	/* go thru NPR nodes and issue any remaining ELS PLOGIs */
+	/* go through NPR nodes and issue any remaining ELS PLOGIs */
 	list_for_each_entry_safe(ndlp, next_ndlp, &vport->fc_nodes, nlp_listp) {
 		if (ndlp->nlp_state == NLP_STE_NPR_NODE &&
 				(ndlp->nlp_flag & NLP_NPR_2B_DISC) != 0 &&
@@ -9440,7 +9440,7 @@ lpfc_els_rcv_edc(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 }
 
 /**
- * lpfc_els_timeout - Handler funciton to the els timer
+ * lpfc_els_timeout - Handler function to the els timer
  * @t: timer context used to obtain the vport.
  *
  * This routine is invoked by the ELS timer after timeout. It posts the ELS
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 5154eeaee0ec..935c225fa7d8 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -3896,7 +3896,7 @@ lpfc_mbx_cmpl_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 		 * mbox reg login, we may have cycled
 		 * back through the state and be
 		 * back at reg login state so this
-		 * mbox needs to be ignored becase
+		 * mbox needs to be ignored because
 		 * there is another reg login in
 		 * process.
 		 */
@@ -3906,7 +3906,7 @@ lpfc_mbx_cmpl_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 
 		/*
 		 * We cannot leave the RPI registered because
-		 * if we go thru discovery again for this ndlp
+		 * if we go through discovery again for this ndlp
 		 * a subsequent REG_RPI will fail.
 		 */
 		ndlp->nlp_flag |= NLP_RPI_REGISTERED;
@@ -4022,7 +4022,7 @@ lpfc_mbx_cmpl_reg_vpi(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	vport->fc_flag &= ~FC_VPORT_NEEDS_REG_VPI;
 	spin_unlock_irq(shost->host_lock);
 	vport->num_disc_nodes = 0;
-	/* go thru NPR list and issue ELS PLOGIs */
+	/* go through NPR list and issue ELS PLOGIs */
 	if (vport->fc_npr_cnt)
 		lpfc_els_disc_plogi(vport);
 
@@ -5988,7 +5988,7 @@ lpfc_disc_start(struct lpfc_vport *vport)
 
 		if (!(vport->fc_flag & FC_ABORT_DISCOVERY)) {
 			vport->num_disc_nodes = 0;
-			/* go thru NPR nodes and issue ELS PLOGIs */
+			/* go through NPR nodes and issue ELS PLOGIs */
 			if (vport->fc_npr_cnt)
 				lpfc_els_disc_plogi(vport);
 
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 9e59c050103d..42c0d7a36878 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -4117,7 +4117,7 @@ lpfc_sli4_els_sgl_update(struct lpfc_hba *phba)
 				 &phba->sli4_hba.lpfc_els_sgl_list);
 		spin_unlock_irq(&phba->sli4_hba.sgl_list_lock);
 	} else if (els_xri_cnt < phba->sli4_hba.els_xri_cnt) {
-		/* els xri-sgl shrinked */
+		/* els xri-sgl shrunk */
 		xri_cnt = phba->sli4_hba.els_xri_cnt - els_xri_cnt;
 		lpfc_printf_log(phba, KERN_INFO, LOG_SLI,
 				"3158 ELS xri-sgl count decreased from "
@@ -10430,7 +10430,7 @@ lpfc_alloc_io_wq_cq(struct lpfc_hba *phba, int idx)
  *
  * Return codes
  *      0 - successful
- *      -ENOMEM - No availble memory
+ *      -ENOMEM - No available memory
  *      -EIO - The mailbox failed to complete successfully.
  **/
 int
@@ -10835,7 +10835,7 @@ lpfc_sli4_release_hdwq(struct lpfc_hba *phba)
 
 	hdwq = phba->sli4_hba.hdwq;
 
-	/* Loop thru all Hardware Queues */
+	/* Loop through all Hardware Queues */
 	for (idx = 0; idx < phba->cfg_hdw_queue; idx++) {
 		/* Free the CQ/WQ corresponding to the Hardware Queue */
 		lpfc_sli4_queue_free(hdwq[idx].io_cq);
@@ -10847,7 +10847,7 @@ lpfc_sli4_release_hdwq(struct lpfc_hba *phba)
 			lpfc_free_sgl_per_hdwq(phba, &hdwq[idx]);
 		lpfc_free_cmd_rsp_buf_per_hdwq(phba, &hdwq[idx]);
 	}
-	/* Loop thru all IRQ vectors */
+	/* Loop through all IRQ vectors */
 	for (idx = 0; idx < phba->cfg_irq_chann; idx++) {
 		/* Free the EQ corresponding to the IRQ vector */
 		eq = phba->sli4_hba.hba_eq_hdl[idx].eq;
@@ -11037,7 +11037,7 @@ lpfc_setup_cq_lookup(struct lpfc_hba *phba)
 
 	memset(phba->sli4_hba.cq_lookup, 0,
 	       (sizeof(struct lpfc_queue *) * (phba->sli4_hba.cq_max + 1)));
-	/* Loop thru all IRQ vectors */
+	/* Loop through all IRQ vectors */
 	for (qidx = 0; qidx < phba->cfg_irq_chann; qidx++) {
 		/* Get the EQ corresponding to the IRQ vector */
 		eq = phba->sli4_hba.hba_eq_hdl[qidx].eq;
@@ -11134,7 +11134,7 @@ lpfc_sli4_queue_setup(struct lpfc_hba *phba)
 		goto out_error;
 	}
 
-	/* Loop thru all IRQ vectors */
+	/* Loop through all IRQ vectors */
 	for (qidx = 0; qidx < phba->cfg_irq_chann; qidx++) {
 		/* Create HBA Event Queues (EQs) in order */
 		for_each_present_cpu(cpu) {
@@ -11170,7 +11170,7 @@ lpfc_sli4_queue_setup(struct lpfc_hba *phba)
 		}
 	}
 
-	/* Loop thru all Hardware Queues */
+	/* Loop through all Hardware Queues */
 	for (qidx = 0; qidx < phba->cfg_hdw_queue; qidx++) {
 		cpu = lpfc_find_cpu_handle(phba, qidx, LPFC_FIND_BY_HDWQ);
 		cpup = &phba->sli4_hba.cpu_map[cpu];
@@ -11482,14 +11482,14 @@ lpfc_sli4_queue_unset(struct lpfc_hba *phba)
 
 	/* Unset fast-path SLI4 queues */
 	if (phba->sli4_hba.hdwq) {
-		/* Loop thru all Hardware Queues */
+		/* Loop through all Hardware Queues */
 		for (qidx = 0; qidx < phba->cfg_hdw_queue; qidx++) {
 			/* Destroy the CQ/WQ corresponding to Hardware Queue */
 			qp = &phba->sli4_hba.hdwq[qidx];
 			lpfc_wq_destroy(phba, qp->io_wq);
 			lpfc_cq_destroy(phba, qp->io_cq);
 		}
-		/* Loop thru all IRQ vectors */
+		/* Loop through all IRQ vectors */
 		for (qidx = 0; qidx < phba->cfg_irq_chann; qidx++) {
 			/* Destroy the EQ corresponding to the IRQ vector */
 			eq = phba->sli4_hba.hba_eq_hdl[qidx].eq;
@@ -12253,7 +12253,7 @@ lpfc_sli_enable_intr(struct lpfc_hba *phba, uint32_t cfg_mode)
 		}
 	}
 
-	/* Fallback to INTx if both MSI-X/MSI initalization failed */
+	/* Fallback to INTx if both MSI-X/MSI initialization failed */
 	if (phba->intr_type == NONE) {
 		retval = request_irq(phba->pcidev->irq, lpfc_sli_intr_handler,
 				     IRQF_SHARED, LPFC_DRIVER_NAME, phba);
@@ -13242,7 +13242,7 @@ lpfc_sli4_enable_intr(struct lpfc_hba *phba, uint32_t cfg_mode)
 		}
 	}
 
-	/* Fallback to INTx if both MSI-X/MSI initalization failed */
+	/* Fallback to INTx if both MSI-X/MSI initialization failed */
 	if (phba->intr_type == NONE) {
 		retval = request_irq(phba->pcidev->irq, lpfc_sli4_intr_handler,
 				     IRQF_SHARED, LPFC_DRIVER_NAME, phba);
diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_nportdisc.c
index 1eb7f7e60bba..df249fce27a3 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -2950,13 +2950,13 @@ lpfc_device_recov_npr_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
  * the PLOGI or ADISC lists. Once the PLOGI and ADISC lists are populated,
  * we will first process the ADISC list.  32 entries are processed initially and
  * ADISC is initited for each one.  Completions / Events for each node are
- * funnelled thru the state machine.  As each node finishes ADISC processing, it
+ * funnelled through the state machine.  As each node finishes ADISC processing, it
  * starts ADISC for any nodes waiting for ADISC processing. If no nodes are
  * waiting, and the ADISC list count is identically 0, then we are done. For
  * Link Up discovery, since all nodes on the PLOGI list are UNREG_LOGIN'ed, we
  * can issue a CLEAR_LA and reenable Link Events. Next we will process the PLOGI
  * list.  32 entries are processed initially and PLOGI is initited for each one.
- * Completions / Events for each node are funnelled thru the state machine.  As
+ * Completions / Events for each node are funnelled through the state machine.  As
  * each node finishes PLOGI processing, it starts PLOGI for any nodes waiting
  * for PLOGI processing. If no nodes are waiting, and the PLOGI list count is
  * indentically 0, then we are done. We have now completed discovery / RSCN
diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index 96e11a26c297..5273b8522a3b 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -242,7 +242,7 @@ lpfc_nvme_remoteport_delete(struct nvme_fc_remote_port *remoteport)
  * @phba: pointer to lpfc hba data structure.
  * @axchg: pointer to exchange context for the NVME LS request
  *
- * This routine is used for processing an asychronously received NVME LS
+ * This routine is used for processing an asynchronously received NVME LS
  * request. Any remaining validation is done and the LS is then forwarded
  * to the nvme-fc transport via nvme_fc_rcv_ls_req().
  *
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index 425328d9c2d8..a7787915c6d1 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -567,8 +567,8 @@ lpfc_nvmet_ktime(struct lpfc_hba *phba,
 	 * TRSP cmpl is passed to NVME Layer.
 	 * Segment 10 - Time from FCP command received by
 	 * MSI-X ISR to command is completed on wire.
-	 * (Segments 1 thru 8) for READDATA / WRITEDATA
-	 * (Segments 1 thru 4) for READDATA_RSP
+	 * (Segments 1 through 8) for READDATA / WRITEDATA
+	 * (Segments 1 through 4) for READDATA_RSP
 	 */
 	seg1 = ctxp->ts_cmd_nvme - ctxp->ts_isr_cmd;
 	segsum = seg1;
@@ -598,7 +598,7 @@ lpfc_nvmet_ktime(struct lpfc_hba *phba,
 	segsum += seg5;
 
 
-	/* For auto rsp commands seg6 thru seg10 will be 0 */
+	/* For auto rsp commands seg6 through seg10 will be 0 */
 	if (ctxp->ts_nvme_status > ctxp->ts_data_nvme) {
 		seg6 = ctxp->ts_nvme_status - ctxp->ts_isr_cmd;
 		if (segsum > seg6)
@@ -1534,8 +1534,8 @@ lpfc_nvmet_setup_io_context(struct lpfc_hba *phba)
 
 	/*
 	 * Setup the next CPU context info ptr for each MRQ.
-	 * MRQ 0 will cycle thru CPUs 0 - X separately from
-	 * MRQ 1 cycling thru CPUs 0 - X, and so on.
+	 * MRQ 0 will cycle through CPUs 0 - X separately from
+	 * MRQ 1 cycling through CPUs 0 - X, and so on.
 	 */
 	for (j = 0; j < phba->cfg_nvmet_mrq; j++) {
 		last_infop = lpfc_get_ctx_list(phba,
@@ -2129,7 +2129,7 @@ lpfc_nvmet_destroy_targetport(struct lpfc_hba *phba)
  * @phba: pointer to lpfc hba data structure.
  * @axchg: pointer to exchange context for the NVME LS request
  *
- * This routine is used for processing an asychronously received NVME LS
+ * This routine is used for processing an asynchronously received NVME LS
  * request. Any remaining validation is done and the LS is then forwarded
  * to the nvmet-fc transport via nvmet_fc_rcv_ls_req().
  *
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index d26941b131fd..682c1e4c69ba 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -2568,7 +2568,7 @@ lpfc_bg_scsi_prep_dma_buf_s3(struct lpfc_hba *phba,
 			lpfc_cmd->prot_seg_cnt = protsegcnt;
 
 			/*
-			 * There is a minimun of 4 BPLs used for every
+			 * There is a minimum of 4 BPLs used for every
 			 * protection data segment.
 			 */
 			if ((lpfc_cmd->prot_seg_cnt * 4) >
@@ -3373,7 +3373,7 @@ lpfc_bg_scsi_prep_dma_buf_s4(struct lpfc_hba *phba,
 
 			lpfc_cmd->prot_seg_cnt = protsegcnt;
 			/*
-			 * There is a minimun of 3 SGEs used for every
+			 * There is a minimum of 3 SGEs used for every
 			 * protection data segment.
 			 */
 			if (((lpfc_cmd->prot_seg_cnt * 3) >
@@ -5690,7 +5690,7 @@ lpfc_taskmgmt_name(uint8_t task_mgmt_cmd)
  * @vport: The virtual port for which this call is being executed.
  * @lpfc_cmd: Pointer to lpfc_io_buf data structure.
  *
- * This routine checks the FCP RSP INFO to see if the tsk mgmt command succeded
+ * This routine checks the FCP RSP INFO to see if the tsk mgmt command succeeded
  *
  * Return code :
  *   0x2003 - Error
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 4dfadf254a72..24d82df23d81 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -1162,7 +1162,7 @@ lpfc_test_rrq_active(struct lpfc_hba *phba, struct lpfc_nodelist *ndlp,
  * The active bit is always set in the active rrq xri_bitmap even
  * if there is no slot avaiable for the other rrq information.
  *
- * returns 0 rrq actived for this xri
+ * returns 0 rrq activated for this xri
  *         < 0 No memory or invalid ndlp.
  **/
 int
@@ -6150,7 +6150,7 @@ lpfc_sli4_arm_cqeq_intr(struct lpfc_hba *phba)
 					   LPFC_QUEUE_REARM);
 
 	if (sli4_hba->hdwq) {
-		/* Loop thru all Hardware Queues */
+		/* Loop through all Hardware Queues */
 		for (qidx = 0; qidx < phba->cfg_hdw_queue; qidx++) {
 			qp = &sli4_hba->hdwq[qidx];
 			/* ARM the corresponding CQ */
@@ -6158,7 +6158,7 @@ lpfc_sli4_arm_cqeq_intr(struct lpfc_hba *phba)
 						LPFC_QUEUE_REARM);
 		}
 
-		/* Loop thru all IRQ vectors */
+		/* Loop through all IRQ vectors */
 		for (qidx = 0; qidx < phba->cfg_irq_chann; qidx++) {
 			eq = sli4_hba->hba_eq_hdl[qidx].eq;
 			/* ARM the corresponding EQ */
@@ -15744,7 +15744,7 @@ __lpfc_sli4_switch_eqmode(struct lpfc_queue *eq, uint8_t mode)
 	 * try to process the eq _but_ that's fine.  We have a
 	 * synchronization mechanism in place (queue_claimed) to
 	 * deal with it.  This is just a draining phase for int-
-	 * errupt handler (not eq's) as we have guranteed through
+	 * errupt handler (not eq's) as we have guaranteed through
 	 * barrier that all the CPUs have seen the new CQ_POLLED
 	 * state. which will effectively disable the REARMING of
 	 * the EQ.  The whole idea is eq's die off eventually as
-- 
2.27.0

