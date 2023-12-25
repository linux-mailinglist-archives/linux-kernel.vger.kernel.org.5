Return-Path: <linux-kernel+bounces-10906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1184C81DEA2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 07:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAA2F1F21467
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 06:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A70515C9;
	Mon, 25 Dec 2023 06:37:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE3A110E;
	Mon, 25 Dec 2023 06:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from localhost.localdomain (unknown [10.190.71.239])
	by mail-app2 (Coremail) with SMTP id by_KCgCnHdX4IolltND0AA--.46236S4;
	Mon, 25 Dec 2023 14:36:45 +0800 (CST)
From: Dinghao Liu <dinghao.liu@zju.edu.cn>
To: dinghao.liu@zju.edu.cn
Cc: Sathya Prakash <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	MPT-FusionLinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: mpt3sas: fix potential use-after-free in mpt3sas_base_attach
Date: Mon, 25 Dec 2023 14:36:12 +0800
Message-Id: <20231225063613.9829-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:by_KCgCnHdX4IolltND0AA--.46236S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Ary7AF45KF1Dtr4fJw1xAFb_yoW8Xry8pr
	y8JFZIkrs8Xr4xGr47Was8ur10q3WrCr1UKFW0y3ZI9w1fJry0yws7CFsrKr1kAFs3A39r
	XrnrGrW3CF15JFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgwPBmWCupcTBwAPsW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

_base_allocate_memory_pools() calls _base_release_memory_pools()
to clean up memory in several error paths. However,
mpt3sas_base_attach() calls _base_release_memory_pools() again
on failure of _base_allocate_memory_pools(), which may lead to
use-after-free.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index a75f670bf551..9be7e493e56c 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -5844,6 +5844,7 @@ _base_release_memory_pools(struct MPT3SAS_ADAPTER *ioc)
 		}
 		dma_pool_destroy(ioc->reply_post_free_array_dma_pool);
 		kfree(ioc->reply_post);
+		ioc->reply_post = NULL;
 	}
 
 	if (ioc->pcie_sgl_dma_pool) {
@@ -5854,6 +5855,7 @@ _base_release_memory_pools(struct MPT3SAS_ADAPTER *ioc)
 			ioc->pcie_sg_lookup[i].pcie_sgl = NULL;
 		}
 		dma_pool_destroy(ioc->pcie_sgl_dma_pool);
+		ioc->pcie_sgl_dma_pool = NULL;
 	}
 	kfree(ioc->pcie_sg_lookup);
 	ioc->pcie_sg_lookup = NULL;
@@ -5864,6 +5866,7 @@ _base_release_memory_pools(struct MPT3SAS_ADAPTER *ioc)
 				     ioc->config_page));
 		dma_free_coherent(&ioc->pdev->dev, ioc->config_page_sz,
 		    ioc->config_page, ioc->config_page_dma);
+		ioc->config_page = NULL;
 	}
 
 	kfree(ioc->hpr_lookup);
-- 
2.17.1


