Return-Path: <linux-kernel+bounces-12410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC6B81F462
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 04:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBE04283B34
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 03:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066931FDD;
	Thu, 28 Dec 2023 03:22:47 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692CC15B3;
	Thu, 28 Dec 2023 03:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from localhost.localdomain (unknown [10.190.65.111])
	by mail-app3 (Coremail) with SMTP id cC_KCgBXX4_w6YxlMc6TAQ--.5357S4;
	Thu, 28 Dec 2023 11:22:31 +0800 (CST)
From: Dinghao Liu <dinghao.liu@zju.edu.cn>
To: dinghao.liu@zju.edu.cn
Cc: James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: lpfc: Fix memleak in lpfc_nvmet_setup_io_context
Date: Thu, 28 Dec 2023 11:22:17 +0800
Message-Id: <20231228032217.4100-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:cC_KCgBXX4_w6YxlMc6TAQ--.5357S4
X-Coremail-Antispam: 1UD129KBjvJXoW7KrW7XFyUKw1UZr4fWw4UJwb_yoW8ury5pa
	1rGF12ywsrGF1IkF43Aw48Cry3ta48Jw4qkFZFvw13CFyrtrW7Kay5A3srJFy3W3WxK34U
	try8Ga47G3WUJFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk21xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxF
	aVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
	4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
	rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
	CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
	z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgwPBmWCupcTBwAjs6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

lpfc_nvmet_setup_io_context() allocates memory for
phba->sli4_hba.nvmet_ctx_info, but does not free it in
the following error handling paths, which may lead to
a memleak.

Fixes: 66d7ce93a0f5 ("scsi: lpfc: Fix MRQ > 1 context list handling")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/scsi/lpfc/lpfc_nvmet.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index 425328d9c2d8..9131a04aea28 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -1556,6 +1556,8 @@ lpfc_nvmet_setup_io_context(struct lpfc_hba *phba)
 	for (i = 0; i < phba->sli4_hba.nvmet_xri_cnt; i++) {
 		ctx_buf = kzalloc(sizeof(*ctx_buf), GFP_KERNEL);
 		if (!ctx_buf) {
+			kfree(phba->sli4_hba.nvmet_ctx_info);
+			phba->sli4_hba.nvmet_ctx_info = NULL;
 			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"6404 Ran out of memory for NVMET\n");
 			return -ENOMEM;
@@ -1565,6 +1567,8 @@ lpfc_nvmet_setup_io_context(struct lpfc_hba *phba)
 					   GFP_KERNEL);
 		if (!ctx_buf->context) {
 			kfree(ctx_buf);
+			kfree(phba->sli4_hba.nvmet_ctx_info);
+			phba->sli4_hba.nvmet_ctx_info = NULL;
 			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"6405 Ran out of NVMET "
 					"context memory\n");
@@ -1577,6 +1581,8 @@ lpfc_nvmet_setup_io_context(struct lpfc_hba *phba)
 		if (!ctx_buf->iocbq) {
 			kfree(ctx_buf->context);
 			kfree(ctx_buf);
+			kfree(phba->sli4_hba.nvmet_ctx_info);
+			phba->sli4_hba.nvmet_ctx_info = NULL;
 			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"6406 Ran out of NVMET iocb/WQEs\n");
 			return -ENOMEM;
@@ -1596,6 +1602,8 @@ lpfc_nvmet_setup_io_context(struct lpfc_hba *phba)
 			lpfc_sli_release_iocbq(phba, ctx_buf->iocbq);
 			kfree(ctx_buf->context);
 			kfree(ctx_buf);
+			kfree(phba->sli4_hba.nvmet_ctx_info);
+			phba->sli4_hba.nvmet_ctx_info = NULL;
 			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"6407 Ran out of NVMET XRIs\n");
 			return -ENOMEM;
-- 
2.17.1


