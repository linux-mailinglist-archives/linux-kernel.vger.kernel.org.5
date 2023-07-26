Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB9B763BB0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbjGZPzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 11:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbjGZPzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:55:01 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AEE1FDA;
        Wed, 26 Jul 2023 08:55:00 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b89cfb4571so54932025ad.3;
        Wed, 26 Jul 2023 08:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690386899; x=1690991699;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYiHL2ozOyveWI+inxTTjHDwvkbYdJrgipWUXhsAZL8=;
        b=XEEaYSyrQBL08qMVHdURLxPg5HEFytl+QWJysi0dcml55zzU8VjgK8f0K9eoPnPn5/
         wkZeb8U0u9i3QUMPEurHZgt1aw0tyAWrIOUzonI2QSR+Ln3Os5J2YUMquG1TK/Nv2vZ8
         278UlKmWtO4ihPhYVt1c8pwksd1D1ApNGMJjGqW+rZo4ibZRdeJtu/WZYbhH5IF6kEqD
         YMqjY69FaoPO861gPmitfAVMeyZkMR5cqyrfHFtBQqwLrBOR0IT7pK7J/crhzKuVDJrB
         1VLym1UabHqIGpuNWm2rg81GzSr6ukS1i+clRe4g/AN7DTisy10Z7Q+2gBltfWg7zMOC
         67ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690386899; x=1690991699;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYiHL2ozOyveWI+inxTTjHDwvkbYdJrgipWUXhsAZL8=;
        b=GPlqM+FL8rctGZbtJyP0uTPotlE5xOnKY4BicVVnlvMV4N0UXEWNstus/UQGmJj5s1
         2Nn/JjWB9aJOunedqTWf1zq1mvxfN6buEJTDurrRZ1MXTUSmkfwby7cxEcu+wbZMmRoV
         UKg1DlaZUF1egp+k/KLO5cHiNyxqdf5v/Hx0zxBmOp2iHUsB4ScJ0ANAnBr2HR2T4NBJ
         MAM0bxkaev35f1HvvISzD2XATY42/Xcw3VSDWJ6pMD+LME8Qmuh3El1vGitMdg54JkOj
         g1e1+WUyq/dtkFjnu/ltat7N216Li357P5+TfRGv+k/Vcoh83zyfeeqlfS5nEoZVJ37E
         gozw==
X-Gm-Message-State: ABy/qLYtoo0RMx90EkHnBRFWw0UQD6rintAstTCIplIgD1sy32xTR6Sj
        NQ8YT32s6tJ8zvCKwAvxB4c=
X-Google-Smtp-Source: APBJJlGRulKVjZFH9+XlJrADMb7WxxRiq7QGaFsRAROTOVPtbMDCVpTbHAi/LgejMzkTaatj9FFNAQ==
X-Received: by 2002:a17:902:ced2:b0:1b8:b459:f47a with SMTP id d18-20020a170902ced200b001b8b459f47amr3168837plg.34.1690386899385;
        Wed, 26 Jul 2023 08:54:59 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id q17-20020a170902dad100b001ac6b926621sm13314320plx.292.2023.07.26.08.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 08:54:58 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        justin.tee@broadcom.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] scsi: lpfc: Fix potential deadlock on &phba->hbalock
Date:   Wed, 26 Jul 2023 15:53:42 +0000
Message-Id: <20230726155342.51623-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As &phba->hbalock is acquired by hardirq such as lpfc_sli_intr_handler(),
process context code acquiring the lock &phba->hbalock should disable
irq, otherwise deadlock could happen if the irq preempt the execution
while the lock is held in process context on the same CPU.

Most lock acquicision site disables irq but inside the callback
lpfc_cmpl_els_uvem() the lock is acquired without explicitly disable irq.
The outside caller of this callback also seems not disable irq.

[Deadlock Scenario]
lpfc_cmpl_els_uvem()
    -> spin_lock(&phba->hbalock)
        <irq>
        -> lpfc_sli_intr_handle()
        -> spin_lock(&phba->hbalock); (deadlock here)

This flaw was found by an experimental static analysis tool I am
developing for irq-related deadlock.

The patch fix the potential deadlock by spin_lock_irqsave() just like
other callsite.

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/scsi/lpfc/lpfc_els.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 2bad9954c355..9667b4937b3a 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -12398,6 +12398,7 @@ lpfc_cmpl_els_uvem(struct lpfc_hba *phba, struct lpfc_iocbq *icmdiocb,
 	u32 ulp_word4 = get_job_word4(phba, rspiocb);
 	struct lpfc_dmabuf *dmabuf = icmdiocb->cmd_dmabuf;
 	struct lpfc_vmid *vmid;
+	unsigned long flags;
 
 	vmid = vmid_context->vmp;
 	if (!ndlp || ndlp->nlp_state != NLP_STE_UNMAPPED_NODE)
@@ -12419,11 +12420,11 @@ lpfc_cmpl_els_uvem(struct lpfc_hba *phba, struct lpfc_iocbq *icmdiocb,
 				 ulp_status, ulp_word4);
 		goto out;
 	}
-	spin_lock(&phba->hbalock);
+	spin_lock_irqsave(&phba->hbalock, flags);
 	/* Set IN USE flag */
 	vport->vmid_flag |= LPFC_VMID_IN_USE;
 	phba->pport->vmid_flag |= LPFC_VMID_IN_USE;
-	spin_unlock(&phba->hbalock);
+	spin_unlock_irqrestore(&phba->hbalock, flags);
 
 	if (vmid_context->instantiated) {
 		write_lock(&vport->vmid_lock);
-- 
2.17.1

