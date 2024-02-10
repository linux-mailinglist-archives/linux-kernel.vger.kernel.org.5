Return-Path: <linux-kernel+bounces-60370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C552E85041B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 12:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D2D8B246F5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 11:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E89F37168;
	Sat, 10 Feb 2024 11:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="QQsHSNJn"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A6233CF5;
	Sat, 10 Feb 2024 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707563339; cv=none; b=EXirCAR7zf2V1UN/RN5Ix2uZv2CkroyqmncxcYI7W7Ww9xM5JtnWvHvNYxcsieL9jOhMnkgdC4VePNQ6bf7Yr3q9muMe3kHpNtcZV8H1NwDRCTlKJlvGQ65WW3IFj666334SkMtdvbNzwtmjd2CmE81Jr6S1MRCc8XAa2xii0Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707563339; c=relaxed/simple;
	bh=MC8dluckGiUt4vKus3dFF0Hblt2kHtloo5fOlZcHL1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MLKm+sDVzTHvB/77snAAcuJ6vsBjvK4Q2SdFT4dvtc9QbhyJdPOauSMsjEby5Zk3zdgjC7kQ/cC8lMJSZEn3L9BRcfVYictZ6CiTulo1j6bZWRWRhh/SpS4HY0tl4ZLWCNB2d90dWmpez1P1T74vRHs+5qLNWdC5lHBS4V/IMVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=QQsHSNJn; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc.intra.ispras.ru (unknown [10.10.165.7])
	by mail.ispras.ru (Postfix) with ESMTPSA id A3B6740F1DEB;
	Sat, 10 Feb 2024 11:08:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru A3B6740F1DEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1707563325;
	bh=UZN3/YB5tI2Be9XIqEj/LszzpwAWHGIHc7dh/SwZb74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QQsHSNJnRyTuxeyOVAh1kDIBNQ9CU9zFLv5WoNW4L+gBdYyD7Wp1azBw+QX6oBRGq
	 1nOnE8Qnv0ccKO/YkJhpHdg1ziO/oZxWeFHeyQ+g4Go2Qu4C4UPiJ79qM3Z1DD+lZp
	 nXvnQi2Gl+5d6Cxe6SKkncyzb2KS3FdkLIWdvRTo=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Daniel Wagner <dwagner@suse.de>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	James Smart <james.smart@broadcom.com>,
	Ram Vegesna <ram.vegesna@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH v2] scsi: elx: efct: adjust error handling inside efct_hw_setup_io
Date: Sat, 10 Feb 2024 14:08:33 +0300
Message-Id: <20240210110833.27723-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <2ik7x74hq6exam5ab4v2moauy4lfvqe3r626bxxettseat2nmv@q4gykxnezkff>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IO and WQE buffers are allocated once per HW and can be reused later. If
WQE buffers allocation fails then the whole allocation is marked as failed
but already created IO array internal objects are not freed. hw->io is
freed but not nullified in that specific case - it may become a problem
later as efct_hw_setup_io() is supposed to be reusable for the same HW.

Also rollback if HW IO objects initialization loop fails due to memory
allocation error.

While at it, use kcalloc instead of kmalloc_array/memset-zero combination
and get rid of some needless NULL assignments: nullifying hw->io[i]
elements just before freeing hw->io is not really useful.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 4df84e846624 ("scsi: elx: efct: Driver initialization routines")
Cc: stable@vger.kernel.org
Suggested-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
v2: per Daniel Wagner's notice, handle the other possible memory
    allocation errors inside the function.

 drivers/scsi/elx/efct/efct_hw.c | 66 +++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 19 deletions(-)

diff --git a/drivers/scsi/elx/efct/efct_hw.c b/drivers/scsi/elx/efct/efct_hw.c
index 5a5525054d71..a0871a53f71d 100644
--- a/drivers/scsi/elx/efct/efct_hw.c
+++ b/drivers/scsi/elx/efct/efct_hw.c
@@ -485,27 +485,24 @@ efct_hw_setup_io(struct efct_hw *hw)
 	bool new_alloc = true;
 	struct efc_dma *dma;
 	struct efct *efct = hw->os;
+	int err = -ENOMEM;
 
 	if (!hw->io) {
-		hw->io = kmalloc_array(hw->config.n_io, sizeof(io), GFP_KERNEL);
+		hw->io = kcalloc(hw->config.n_io, sizeof(io), GFP_KERNEL);
 		if (!hw->io)
-			return -ENOMEM;
-
-		memset(hw->io, 0, hw->config.n_io * sizeof(io));
+			return err;
 
 		for (i = 0; i < hw->config.n_io; i++) {
 			hw->io[i] = kzalloc(sizeof(*io), GFP_KERNEL);
 			if (!hw->io[i])
-				goto error;
+				goto err_alloc_io;
 		}
 
 		/* Create WQE buffs for IO */
 		hw->wqe_buffs = kzalloc((hw->config.n_io * hw->sli.wqe_size),
 					GFP_KERNEL);
-		if (!hw->wqe_buffs) {
-			kfree(hw->io);
-			return -ENOMEM;
-		}
+		if (!hw->wqe_buffs)
+			goto err_alloc_io;
 
 	} else {
 		/* re-use existing IOs, including SGLs */
@@ -517,8 +514,10 @@ efct_hw_setup_io(struct efct_hw *hw)
 		dma->size = sizeof(struct fcp_txrdy) * hw->config.n_io;
 		dma->virt = dma_alloc_coherent(&efct->pci->dev,
 					       dma->size, &dma->phys, GFP_KERNEL);
-		if (!dma->virt)
-			return -ENOMEM;
+		if (!dma->virt) {
+			memset(&hw->xfer_rdy, 0, sizeof(struct efc_dma));
+			goto err_alloc_wqe;
+		}
 	}
 	xfer_virt = (uintptr_t)hw->xfer_rdy.virt;
 	xfer_phys = hw->xfer_rdy.phys;
@@ -539,7 +538,8 @@ efct_hw_setup_io(struct efct_hw *hw)
 		wqcb = efct_hw_reqtag_alloc(hw, efct_hw_wq_process_io, io);
 		if (!wqcb) {
 			efc_log_err(hw->os, "can't allocate request tag\n");
-			return -ENOSPC;
+			err = -ENOSPC;
+			goto err_init_io;
 		}
 		io->reqtag = wqcb->instance_index;
 
@@ -553,7 +553,8 @@ efct_hw_setup_io(struct efct_hw *hw)
 				       &io->indicator, &index)) {
 			efc_log_err(hw->os,
 				    "sli_resource_alloc failed @ %d\n", i);
-			return -ENOMEM;
+			efct_hw_reqtag_free(hw, wqcb);
+			goto err_init_io;
 		}
 
 		if (new_alloc) {
@@ -567,7 +568,10 @@ efct_hw_setup_io(struct efct_hw *hw)
 				efc_log_err(hw->os, "dma_alloc fail %d\n", i);
 				memset(&io->def_sgl, 0,
 				       sizeof(struct efc_dma));
-				return -ENOMEM;
+				sli_resource_free(&hw->sli, SLI4_RSRC_XRI,
+						  io->indicator);
+				efct_hw_reqtag_free(hw, wqcb);
+				goto err_init_io;
 			}
 		}
 		io->def_sgl_count = hw->config.n_sgl;
@@ -585,16 +589,40 @@ efct_hw_setup_io(struct efct_hw *hw)
 	}
 
 	return 0;
-error:
-	for (i = 0; i < hw->config.n_io && hw->io[i]; i++) {
-		kfree(hw->io[i]);
-		hw->io[i] = NULL;
+
+err_init_io:
+	for (u32 j = 0; j < i; j++) {
+		struct hw_wq_callback *wqcb;
+
+		io = hw->io[j];
+		wqcb = efct_hw_reqtag_get_instance(hw, io->reqtag);
+
+		if (new_alloc) {
+			dma = &io->def_sgl;
+			dma_free_coherent(&efct->pci->dev, dma->size,
+					  dma->virt, dma->phys);
+			memset(&io->def_sgl, 0, sizeof(struct efc_dma));
+		}
+		sli_resource_free(&hw->sli, SLI4_RSRC_XRI, io->indicator);
+		efct_hw_reqtag_free(hw, wqcb);
 	}
+	if (new_alloc) {
+		dma = &hw->xfer_rdy;
+		dma_free_coherent(&efct->pci->dev, dma->size, dma->virt,
+				  dma->phys);
+		memset(&hw->xfer_rdy, 0, sizeof(struct efc_dma));
+	}
+err_alloc_wqe:
+	kfree(hw->wqe_buffs);
+	hw->wqe_buffs = NULL;
+err_alloc_io:
+	for (i = 0; i < hw->config.n_io && hw->io[i]; i++)
+		kfree(hw->io[i]);
 
 	kfree(hw->io);
 	hw->io = NULL;
 
-	return -ENOMEM;
+	return err;
 }
 
 static int
-- 
2.39.2


