Return-Path: <linux-kernel+bounces-47011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C688447E8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3A601F25987
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549313FE31;
	Wed, 31 Jan 2024 19:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jUQD7eAo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D157A3EA9B
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 19:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706728683; cv=none; b=c0YNqnJgyNe0lCS7qWh0GnkzZEhnMQ5abcLd4I/tFIMoGC1KeQ6U/ehq5LZK82B8MHitFUfN547OHwsJI0jYOF7WzLL8QbBL+D3diVYM5ghRVC3GQK5WLkP1M6ksXweAriNhzia5hdP2ts7Y9WPtwDGYaB15mBGdYSX4dbunfnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706728683; c=relaxed/simple;
	bh=JiU/Zj2jN5FGcTJs6+iPLUXDsDn+TM4A60WJFyv8XsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YNbFEmgt++G7mhZBGhQn34VYCS+kRq1aHNx+NgR/L2sf1iSY33spAAIN9tVrNJAAYXbFftiHFM3SvKAm3TavSd/fAtsW0JDW6JUbka06oHeUc7si4tA5FjQpcqFOx116OD+gB/PVJ8WWCi/gQkheyEeEHi391L5hSROGM4H2ciU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jUQD7eAo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706728681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hSVKx6QtgMDEM8LnOwfuT1EuekagUrvnp40Yk/IOnn8=;
	b=jUQD7eAoDdki/a8F4atU3qGOpPftdWlBNMUWOgreab1GNMjzHgaHKbaJWjNbBnKYW0/X11
	Z1ouBRWdjXIhZloohi0mwoQOJTfN+Cat11KUGMrprSNmrvGYULIk/DvHJepNEGcfO99UgH
	ozgLXxvHAj4qE8fcS207asqgXemsfWg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-AUv43VFnM4KSGHJbSMaTyA-1; Wed,
 31 Jan 2024 14:17:56 -0500
X-MC-Unique: AUv43VFnM4KSGHJbSMaTyA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD6E41C0BA49;
	Wed, 31 Jan 2024 19:17:55 +0000 (UTC)
Received: from rhel-developer-toolbox-latest.rmtusor.csb (unknown [10.2.16.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7E63A40C9444;
	Wed, 31 Jan 2024 19:17:54 +0000 (UTC)
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
Subject: [PATCH 2/2] cnic,bnx2,bnx2x: use UIO_MEM_DMA_COHERENT
Date: Wed, 31 Jan 2024 11:17:32 -0800
Message-ID: <20240131191732.3247996-3-cleech@redhat.com>
In-Reply-To: <20240131191732.3247996-1-cleech@redhat.com>
References: <20240131191732.3247996-1-cleech@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

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

Fixes: bb73955c0b1d ("cnic: don't pass bogus GFP_ flags to dma_alloc_coherent")
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Signed-off-by: Chris Leech <cleech@redhat.com>
---
 drivers/net/ethernet/broadcom/bnx2.c             |  1 +
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c |  2 ++
 drivers/net/ethernet/broadcom/cnic.c             | 15 ++++++++++++---
 drivers/net/ethernet/broadcom/cnic.h             |  1 +
 drivers/net/ethernet/broadcom/cnic_if.h          |  1 +
 5 files changed, 17 insertions(+), 3 deletions(-)

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
index 7926aaef8f0c5..cca1e94fc35dc 100644
--- a/drivers/net/ethernet/broadcom/cnic.c
+++ b/drivers/net/ethernet/broadcom/cnic.c
@@ -1107,6 +1107,7 @@ static int cnic_init_uio(struct cnic_dev *dev)
 						     TX_MAX_TSS_RINGS + 1);
 		uinfo->mem[1].addr = (unsigned long) cp->status_blk.gen &
 					CNIC_PAGE_MASK;
+		uinfo->mem[1].dma_addr = cp->status_blk_map;
 		if (cp->ethdev->drv_state & CNIC_DRV_STATE_USING_MSIX)
 			uinfo->mem[1].size = BNX2_SBLK_MSIX_ALIGN_SIZE * 9;
 		else
@@ -1118,20 +1119,26 @@ static int cnic_init_uio(struct cnic_dev *dev)
 
 		uinfo->mem[1].addr = (unsigned long) cp->bnx2x_def_status_blk &
 			CNIC_PAGE_MASK;
+		uinfo->mem[1].dma_addr = cp->status_blk_map;
 		uinfo->mem[1].size = sizeof(*cp->bnx2x_def_status_blk);
 
 		uinfo->name = "bnx2x_cnic";
 	}
 
-	uinfo->mem[1].memtype = UIO_MEM_LOGICAL;
+	uinfo->mem[1].dma_device = &dev->pcidev->dev;
+	uinfo->mem[1].memtype = UIO_MEM_DMA_COHERENT;
 
 	uinfo->mem[2].addr = (unsigned long) udev->l2_ring;
+	uinfo->mem[2].dma_addr = udev->l2_ring_map;
 	uinfo->mem[2].size = udev->l2_ring_size;
-	uinfo->mem[2].memtype = UIO_MEM_LOGICAL;
+	uinfo->mem[2].dma_device = &dev->pcidev->dev;
+	uinfo->mem[2].memtype = UIO_MEM_DMA_COHERENT;
 
 	uinfo->mem[3].addr = (unsigned long) udev->l2_buf;
+	uinfo->mem[3].dma_addr = udev->l2_buf_map;
 	uinfo->mem[3].size = udev->l2_buf_size;
-	uinfo->mem[3].memtype = UIO_MEM_LOGICAL;
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


