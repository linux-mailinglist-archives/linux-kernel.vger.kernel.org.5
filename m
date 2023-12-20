Return-Path: <linux-kernel+bounces-6324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B70A819740
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39052878BF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142E415AF0;
	Wed, 20 Dec 2023 03:45:34 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91504156E0;
	Wed, 20 Dec 2023 03:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from localhost.localdomain (unknown [10.190.71.26])
	by mail-app3 (Coremail) with SMTP id cC_KCgD3_o5CY4JlrmYuAQ--.11768S4;
	Wed, 20 Dec 2023 11:45:14 +0800 (CST)
From: Dinghao Liu <dinghao.liu@zju.edu.cn>
To: dinghao.liu@zju.edu.cn
Cc: Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"himanshu.madhani@cavium.com" <himanshu.madhani@cavium.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: qla2xxx: fix a double free in qla2x00_probe_one
Date: Wed, 20 Dec 2023 11:44:48 +0800
Message-Id: <20231220034448.13249-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:cC_KCgD3_o5CY4JlrmYuAQ--.11768S4
X-Coremail-Antispam: 1UD129KBjvJXoWrZryrJrWruFWrZw1ftryUtrb_yoW8JF4rpa
	97tryYy3yrXayUCrWjyr47Zr9YyayIkrWUKayxWa43ua1Yqr9FyrW0vFW7Xas7C3yDJ3Wf
	tFn5Gry7Jay7JF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk21xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxF
	aVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
	4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxG
	rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
	CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
	z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgYNBmV+xhdIjwAPsN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

When qla2x00_mem_alloc() fails, it has cleaned up resources
in its error paths. However, qla2x00_probe_one() calls
qla2x00_mem_free() on failure of qla2x00_mem_alloc() and
tries to free the resources again, which may casue a
double-free.

Fixes: d64d6c5671db ("scsi: qla2xxx: Fix NULL pointer crash due to probe failure")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/scsi/qla2xxx/qla_os.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 03348f605c2e..0d8d6c814723 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -3249,7 +3249,7 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		ql_log_pci(ql_log_fatal, pdev, 0x0031,
 		    "Failed to allocate memory for adapter, aborting.\n");
 
-		goto probe_hw_failed;
+		goto mem_alloc_failed;
 	}
 
 	req->max_q_depth = MAX_Q_DEPTH;
@@ -3660,6 +3660,8 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 
 probe_hw_failed:
 	qla2x00_mem_free(ha);
+
+mem_alloc_failed:
 	qla2x00_free_req_que(ha, req);
 	qla2x00_free_rsp_que(ha, rsp);
 	qla2x00_clear_drv_active(ha);
-- 
2.17.1


