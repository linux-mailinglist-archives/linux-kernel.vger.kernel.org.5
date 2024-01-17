Return-Path: <linux-kernel+bounces-28636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4D9830125
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C0071C223F0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943CF11199;
	Wed, 17 Jan 2024 08:19:00 +0000 (UTC)
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8AACA47;
	Wed, 17 Jan 2024 08:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705479540; cv=none; b=er5tm1wUjO8S69L3D94y8XxJCiRK6srMAk3yZWdENbhqOpRhq6uyuzwmbnVpxLtp4ZjSFqQVjjSbkj9prURULbQ8poc776m86xiYCAttMXXRD7jnUAdf4uqviFXYHiufOfKZuHGE78kJegl4xLyx19VxHDRABZfQkdeUI9ugXqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705479540; c=relaxed/simple;
	bh=+NIbRHWYXe1ipquEi/0se7ILPiOmX9vF5XVA/zzn78A=;
	h=Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo; b=VG/L6qE8tUX+wmD8Dg+RW6McHDcyQD8cAZMMeqn+ONdsCNi/8i7LBvsD6oG15IyWffWYH98potl2jucak9XwTeg9lDOIJUbZsS8YwwV5OoKYFcD9D0FnwzEo9Ex1DTSpxDTULbk84ZpUZq8T0zgjmKWqGjEKJKcs67Vh/lt5vI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from luzhipeng.223.5.5.5 (unknown [183.159.170.227])
	by mail-app4 (Coremail) with SMTP id cS_KCgDHBIXmi6dla0suAA--.42587S2;
	Wed, 17 Jan 2024 16:12:23 +0800 (CST)
From: Zhipeng Lu <alexious@zju.edu.cn>
To: alexious@zju.edu.cn
Cc: James Smart <james.smart@broadcom.com>,
	Ram Vegesna <ram.vegesna@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: elx: efec: Fix a memleak in efct_hw_setup_io
Date: Wed, 17 Jan 2024 16:03:42 +0800
Message-Id: <20240117080344.3817969-1-alexious@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cS_KCgDHBIXmi6dla0suAA--.42587S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF4rAFyrKry8WF1kGr47twb_yoW5Zr1fpF
	4xW34ruFW0qr4xCw17Ar40kr1YvanaqryDGay7Xa9ru3s5Kw4rtrs7AryavFn0kr97Wr13
	WFWDKF1fWF4UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/

In the error-handling path of hw->wqe_buffs, not only hw->io, but also
hw->io[i] should be freed. They should also be freed in the following
error-hanlding paths. So as the first dma->virt, which needs to be freed
when efct_hw_reqtag_alloc, sli_resource_alloc and the second
dma_alloc_coherent fails.

Fixes: 4df84e846624 ("scsi: elx: efct: Driver initialization routines")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
---
 drivers/scsi/elx/efct/efct_hw.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/elx/efct/efct_hw.c b/drivers/scsi/elx/efct/efct_hw.c
index 5a5525054d71..62ef741a3ccf 100644
--- a/drivers/scsi/elx/efct/efct_hw.c
+++ b/drivers/scsi/elx/efct/efct_hw.c
@@ -485,6 +485,7 @@ efct_hw_setup_io(struct efct_hw *hw)
 	bool new_alloc = true;
 	struct efc_dma *dma;
 	struct efct *efct = hw->os;
+	int ret;
 
 	if (!hw->io) {
 		hw->io = kmalloc_array(hw->config.n_io, sizeof(io), GFP_KERNEL);
@@ -495,16 +496,18 @@ efct_hw_setup_io(struct efct_hw *hw)
 
 		for (i = 0; i < hw->config.n_io; i++) {
 			hw->io[i] = kzalloc(sizeof(*io), GFP_KERNEL);
-			if (!hw->io[i])
+			if (!hw->io[i]) {
+				ret = -ENOMEM;
 				goto error;
+			}
 		}
 
 		/* Create WQE buffs for IO */
 		hw->wqe_buffs = kzalloc((hw->config.n_io * hw->sli.wqe_size),
 					GFP_KERNEL);
 		if (!hw->wqe_buffs) {
-			kfree(hw->io);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto error;
 		}
 
 	} else {
@@ -517,8 +520,10 @@ efct_hw_setup_io(struct efct_hw *hw)
 		dma->size = sizeof(struct fcp_txrdy) * hw->config.n_io;
 		dma->virt = dma_alloc_coherent(&efct->pci->dev,
 					       dma->size, &dma->phys, GFP_KERNEL);
-		if (!dma->virt)
-			return -ENOMEM;
+		if (!dma->virt) {
+			ret = -ENOMEM;
+			goto free_wqe_buffs;
+		}
 	}
 	xfer_virt = (uintptr_t)hw->xfer_rdy.virt;
 	xfer_phys = hw->xfer_rdy.phys;
@@ -539,7 +544,8 @@ efct_hw_setup_io(struct efct_hw *hw)
 		wqcb = efct_hw_reqtag_alloc(hw, efct_hw_wq_process_io, io);
 		if (!wqcb) {
 			efc_log_err(hw->os, "can't allocate request tag\n");
-			return -ENOSPC;
+			ret = -ENOSPC;
+			goto free_dma_virt;
 		}
 		io->reqtag = wqcb->instance_index;
 
@@ -553,7 +559,8 @@ efct_hw_setup_io(struct efct_hw *hw)
 				       &io->indicator, &index)) {
 			efc_log_err(hw->os,
 				    "sli_resource_alloc failed @ %d\n", i);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto free_dma_virt;
 		}
 
 		if (new_alloc) {
@@ -567,7 +574,8 @@ efct_hw_setup_io(struct efct_hw *hw)
 				efc_log_err(hw->os, "dma_alloc fail %d\n", i);
 				memset(&io->def_sgl, 0,
 				       sizeof(struct efc_dma));
-				return -ENOMEM;
+				ret = -ENOMEM;
+				goto free_dma_virt;
 			}
 		}
 		io->def_sgl_count = hw->config.n_sgl;
@@ -585,6 +593,12 @@ efct_hw_setup_io(struct efct_hw *hw)
 	}
 
 	return 0;
+free_dma_virt:
+	dma = &hw->xfer_rdy;
+	dma_free_coherent(&efct->pci->dev, dma->size, dma->virt, dma->phys);
+	memset(dma, 0, sizeof(struct efc_dma));
+free_wqe_buffs:
+	kfree(hw->wqe_buffs);
 error:
 	for (i = 0; i < hw->config.n_io && hw->io[i]; i++) {
 		kfree(hw->io[i]);
@@ -594,7 +608,7 @@ efct_hw_setup_io(struct efct_hw *hw)
 	kfree(hw->io);
 	hw->io = NULL;
 
-	return -ENOMEM;
+	return ret;
 }
 
 static int
-- 
2.34.1


