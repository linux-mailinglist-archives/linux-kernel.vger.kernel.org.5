Return-Path: <linux-kernel+bounces-11839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5953A81EC5D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 049421F22CB0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 06:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E5A5228;
	Wed, 27 Dec 2023 06:00:41 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BA44403;
	Wed, 27 Dec 2023 06:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from localhost.localdomain (unknown [10.190.69.69])
	by mail-app2 (Coremail) with SMTP id by_KCgBXXz9vvYtl1_wJAQ--.25777S4;
	Wed, 27 Dec 2023 14:00:27 +0800 (CST)
From: Dinghao Liu <dinghao.liu@zju.edu.cn>
To: dinghao.liu@zju.edu.cn
Cc: Nilesh Javali <njavali@marvell.com>,
	Manish Rangankar <mrangankar@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Chad Dupuis <chad.dupuis@cavium.com>,
	Adheer Chandravanshi <adheer.chandravanshi@qlogic.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: qedi: fix error handling of qedi_alloc_global_queues
Date: Wed, 27 Dec 2023 14:00:12 +0800
Message-Id: <20231227060012.31844-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:by_KCgBXXz9vvYtl1_wJAQ--.25777S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrWDCw1fGFWrWFy5XF1UJrb_yoW8Xr1fpr
	Z3Jr4qka1YgF15ua4DJ34DJFyaga40vFZrGr47X3yUZa1fCanF9rWIy347Xr1xA3Z7A3W7
	trnrtFWDCF1DJFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvm1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
	c2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgwPBmWCupcTBwAbsC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

If qedi->p_cpuq is NULL, the error handling will jump to
mem_alloc_failure. However, qedi->global_queues has not
been allocated at this point, which may lead to a null-
pointer-dereference in qedi_free_global_queues().

On the other hand, when qedi_alloc_bdq() fails, we should
free qedi->global_queues to prevent potential memleak. It's
the same for the following error paths.

Fixes: ace7f46ba5fd ("scsi: qedi: Add QLogic FastLinQ offload iSCSI driver framework.")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/scsi/qedi/qedi_main.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index cd0180b1f5b9..c0eff34f5470 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -1637,10 +1637,8 @@ static int qedi_alloc_global_queues(struct qedi_ctx *qedi)
 	/* Make sure we allocated the PBL that will contain the physical
 	 * addresses of our queues
 	 */
-	if (!qedi->p_cpuq) {
-		status = -EINVAL;
-		goto mem_alloc_failure;
-	}
+	if (!qedi->p_cpuq)
+		return -EINVAL;
 
 	qedi->global_queues = kzalloc((sizeof(struct global_queue *) *
 				       qedi->num_queues), GFP_KERNEL);
@@ -1751,6 +1749,7 @@ static int qedi_alloc_global_queues(struct qedi_ctx *qedi)
 
 mem_alloc_failure:
 	qedi_free_global_queues(qedi);
+	kfree(qedi->global_queues);
 	return status;
 }
 
-- 
2.17.1


