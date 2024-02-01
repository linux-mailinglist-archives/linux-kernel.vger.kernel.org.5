Return-Path: <linux-kernel+bounces-48999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00711846480
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0EE2B251AC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D0F482D2;
	Thu,  1 Feb 2024 23:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGCrg3qD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB1947F67
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 23:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706830465; cv=none; b=oiKpjeFjolYDurQZSqBD8iBkmY8GeBM110Wfls+D2A+FzAJtD0SaqHBVNSCmzSvyciSWK9ehub2xmzS65BH9gCwA8Y9JjnwYQkLfyEmfAXk+WH/AtRyTRjmtsxSgt5gkGkP2E/VaJXhQRSxK1WegyaHfCzpI8BdcUrMrUmomjXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706830465; c=relaxed/simple;
	bh=Ahlg3vRN5+qaUGPIvlQZECDJaIYDaGE+TjgxiiUe6oA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBxQOp83u8TCpZ03MZkZFHL0dEpKTM/o7XWbyHv2ArC5CIZeMm7GHydHAFbYgKwxmGMgAze7N2iAoR248a6WG2LEbKIoX1P/IpPo9+dP1z9eOyTzu5g+VVoRY4lu1WOLG+bKCKrGZyzT2zsqnd4zTuP9uTiSKZAzivHnlxCdF2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EGCrg3qD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706830463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vW15KnuWbJ1Fv8UDVL9jaY2/JqQeNoawE9G/00qiEXM=;
	b=EGCrg3qDTSutRt46ovfxRStPNuOm68dWHXjVfG+2dt4ByT8S6aFEhhwZN2ynIq4fYeakQl
	rFiToSlW5l1FFZNbAC9M4hsNFOfFS4Nx51/yVK7R8o0PJ1dJeg0Pf6wJgl9MecVUxQd+qV
	GhbXRFhqYyvrTqeNtaRUJCzIjs5rygo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-LKzkquViN8CR3NERUKdAZw-1; Thu,
 01 Feb 2024 18:34:20 -0500
X-MC-Unique: LKzkquViN8CR3NERUKdAZw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9576B3806622;
	Thu,  1 Feb 2024 23:34:19 +0000 (UTC)
Received: from rhel-developer-toolbox-latest.rmtusor.csb (unknown [10.2.16.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 658D8111F9;
	Thu,  1 Feb 2024 23:34:18 +0000 (UTC)
From: Chris Leech <cleech@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nilesh Javali <njavali@marvell.com>
Cc: Christoph Hellwig <hch@lst.de>,
	John Meneghini <jmeneghi@redhat.com>,
	Lee Duncan <lduncan@suse.com>,
	Mike Christie <michael.christie@oracle.com>,
	Hannes Reinecke <hare@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	GR-QLogic-Storage-Upstream@marvell.com
Subject: [PATCH v5 2/4] cnic,bnx2,bnx2x: use UIO_MEM_DMA_COHERENT
Date: Thu,  1 Feb 2024 15:33:58 -0800
Message-ID: <20240201233400.3394996-3-cleech@redhat.com>
In-Reply-To: <20240201233400.3394996-1-cleech@redhat.com>
References: <20240201233400.3394996-1-cleech@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Use the UIO_MEM_DMA_COHERENT type to properly handle mmap for
dma_alloc_coherent buffers.

The cnic l2_ring and l2_buf mmaps have caused page refcount issues as
the dma_alloc_coherent no longer provide __GFP_COMP allocation as per
commit "dma-mapping: reject __GFP_COMP in dma_alloc_attrs".

Fix this by having the uio device use dma_mmap_coherent.

The bnx2 and bnx2x status block allocations are also dma_alloc_coherent,
and should use dma_mmap_coherent. They don't allocate multiple pages,
but this interface does not work correctly with an iommu enabled unless
dma_mmap_coherent is used.

Signed-off-by: Nilesh Javali <njavali@marvell.com>
Signed-off-by: Chris Leech <cleech@redhat.com>
---
 drivers/net/ethernet/broadcom/bnx2.c          |  1 +
 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  |  2 ++
 drivers/net/ethernet/broadcom/cnic.c          | 25 +++++++++++++------
 drivers/net/ethernet/broadcom/cnic.h          |  1 +
 drivers/net/ethernet/broadcom/cnic_if.h       |  1 +
 5 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2.c b/drivers/net/ethernet/broadcom/bnx2.c
index 0d917a9699c58..b65b8592ad759 100644
--- a/drivers/net/ethernet/broadcom/bnx2.c
+++ b/drivers/net/ethernet/broadcom/bnx2.c
@@ -367,6 +367,7 @@ static void bnx2_setup_cnic_irq_info(struct bnx2 *bp)
 	cp->irq_arr[0].status_blk = (void *)
 		((unsigned long) bnapi->status_blk.msi +
 		(BNX2_SBLK_MSIX_ALIGN_SIZE * sb_id));
+	cp->irq_arr[0].status_blk_map = bp->status_blk_mapping;
 	cp->irq_arr[0].status_blk_num = sb_id;
 	cp->num_irq = 1;
 }
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 0d8e61c63c7c6..678829646cec3 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -14912,9 +14912,11 @@ void bnx2x_setup_cnic_irq_info(struct bnx2x *bp)
 	else
 		cp->irq_arr[0].status_blk = (void *)bp->cnic_sb.e1x_sb;
 
+	cp->irq_arr[0].status_blk_map = bp->cnic_sb_mapping;
 	cp->irq_arr[0].status_blk_num =  bnx2x_cnic_fw_sb_id(bp);
 	cp->irq_arr[0].status_blk_num2 = bnx2x_cnic_igu_sb_id(bp);
 	cp->irq_arr[1].status_blk = bp->def_status_blk;
+	cp->irq_arr[1].status_blk_map = bp->def_status_blk_mapping;
 	cp->irq_arr[1].status_blk_num = DEF_SB_ID;
 	cp->irq_arr[1].status_blk_num2 = DEF_SB_IGU_ID;
 
diff --git a/drivers/net/ethernet/broadcom/cnic.c b/drivers/net/ethernet/broadcom/cnic.c
index 7926aaef8f0c5..3d63177e7e52b 100644
--- a/drivers/net/ethernet/broadcom/cnic.c
+++ b/drivers/net/ethernet/broadcom/cnic.c
@@ -1107,10 +1107,11 @@ static int cnic_init_uio(struct cnic_dev *dev)
 						     TX_MAX_TSS_RINGS + 1);
 		uinfo->mem[1].addr = (unsigned long) cp->status_blk.gen &
 					CNIC_PAGE_MASK;
+		uinfo->mem[1].dma_addr = cp->status_blk_map;
 		if (cp->ethdev->drv_state & CNIC_DRV_STATE_USING_MSIX)
-			uinfo->mem[1].size = BNX2_SBLK_MSIX_ALIGN_SIZE * 9;
+			uinfo->mem[1].size = PAGE_ALIGN(BNX2_SBLK_MSIX_ALIGN_SIZE * 9);
 		else
-			uinfo->mem[1].size = BNX2_SBLK_MSIX_ALIGN_SIZE;
+			uinfo->mem[1].size = PAGE_ALIGN(BNX2_SBLK_MSIX_ALIGN_SIZE);
 
 		uinfo->name = "bnx2_cnic";
 	} else if (test_bit(CNIC_F_BNX2X_CLASS, &dev->flags)) {
@@ -1118,20 +1119,26 @@ static int cnic_init_uio(struct cnic_dev *dev)
 
 		uinfo->mem[1].addr = (unsigned long) cp->bnx2x_def_status_blk &
 			CNIC_PAGE_MASK;
-		uinfo->mem[1].size = sizeof(*cp->bnx2x_def_status_blk);
+		uinfo->mem[1].dma_addr = cp->status_blk_map;
+		uinfo->mem[1].size = PAGE_ALIGN(sizeof(*cp->bnx2x_def_status_blk));
 
 		uinfo->name = "bnx2x_cnic";
 	}
 
-	uinfo->mem[1].memtype = UIO_MEM_LOGICAL;
+	uinfo->mem[1].dma_device = &dev->pcidev->dev;
+	uinfo->mem[1].memtype = UIO_MEM_DMA_COHERENT;
 
 	uinfo->mem[2].addr = (unsigned long) udev->l2_ring;
-	uinfo->mem[2].size = udev->l2_ring_size;
-	uinfo->mem[2].memtype = UIO_MEM_LOGICAL;
+	uinfo->mem[2].dma_addr = udev->l2_ring_map;
+	uinfo->mem[2].size = PAGE_ALIGN(udev->l2_ring_size);
+	uinfo->mem[2].dma_device = &dev->pcidev->dev;
+	uinfo->mem[2].memtype = UIO_MEM_DMA_COHERENT;
 
 	uinfo->mem[3].addr = (unsigned long) udev->l2_buf;
-	uinfo->mem[3].size = udev->l2_buf_size;
-	uinfo->mem[3].memtype = UIO_MEM_LOGICAL;
+	uinfo->mem[3].dma_addr = udev->l2_buf_map;
+	uinfo->mem[3].size = PAGE_ALIGN(udev->l2_buf_size);
+	uinfo->mem[3].dma_device = &dev->pcidev->dev;
+	uinfo->mem[3].memtype = UIO_MEM_DMA_COHERENT;
 
 	uinfo->version = CNIC_MODULE_VERSION;
 	uinfo->irq = UIO_IRQ_CUSTOM;
@@ -1313,6 +1320,7 @@ static int cnic_alloc_bnx2x_resc(struct cnic_dev *dev)
 		return 0;
 
 	cp->bnx2x_def_status_blk = cp->ethdev->irq_arr[1].status_blk;
+	cp->status_blk_map = cp->ethdev->irq_arr[1].status_blk_map;
 
 	cp->l2_rx_ring_size = 15;
 
@@ -5323,6 +5331,7 @@ static int cnic_start_hw(struct cnic_dev *dev)
 	pci_dev_get(dev->pcidev);
 	cp->func = PCI_FUNC(dev->pcidev->devfn);
 	cp->status_blk.gen = ethdev->irq_arr[0].status_blk;
+	cp->status_blk_map = ethdev->irq_arr[0].status_blk_map;
 	cp->status_blk_num = ethdev->irq_arr[0].status_blk_num;
 
 	err = cp->alloc_resc(dev);
diff --git a/drivers/net/ethernet/broadcom/cnic.h b/drivers/net/ethernet/broadcom/cnic.h
index 4baea81bae7a3..fedc84ada937d 100644
--- a/drivers/net/ethernet/broadcom/cnic.h
+++ b/drivers/net/ethernet/broadcom/cnic.h
@@ -260,6 +260,7 @@ struct cnic_local {
 		#define SM_RX_ID		0
 		#define SM_TX_ID		1
 	} status_blk;
+	dma_addr_t status_blk_map;
 
 	struct host_sp_status_block	*bnx2x_def_status_blk;
 
diff --git a/drivers/net/ethernet/broadcom/cnic_if.h b/drivers/net/ethernet/broadcom/cnic_if.h
index 789e5c7e93116..49a11ec80b364 100644
--- a/drivers/net/ethernet/broadcom/cnic_if.h
+++ b/drivers/net/ethernet/broadcom/cnic_if.h
@@ -190,6 +190,7 @@ struct cnic_ops {
 struct cnic_irq {
 	unsigned int	vector;
 	void		*status_blk;
+	dma_addr_t	status_blk_map;
 	u32		status_blk_num;
 	u32		status_blk_num2;
 	u32		irq_flags;
-- 
2.43.0


