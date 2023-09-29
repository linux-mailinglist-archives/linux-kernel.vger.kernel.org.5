Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA947B384C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 19:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbjI2RBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 13:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbjI2RBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:01:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BC61B7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696006852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oxto29hKqmyufLlB0bzOjhUQy61aqcqEMscXuA0JoFY=;
        b=evNVYA2BTZ6Ky4Adu8+hX8LoQZM7AzagdWU8+82glsD3mQyheTWm5ZG7pyk0tI+FR3XxpF
        mp0sd8iCu0pCl/TRRuQlCWveyb1xVa1iIT+RN+NZkgjPdLPvlnps/3Uj2JFA/9ho/SUgCI
        FGtvtHYE4T3ENpMsKh2aJEN53djzddQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-BZcZciWTNUW3fEUxevJ0rA-1; Fri, 29 Sep 2023 13:00:48 -0400
X-MC-Unique: BZcZciWTNUW3fEUxevJ0rA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B06E481652A;
        Fri, 29 Sep 2023 17:00:46 +0000 (UTC)
Received: from rhel-developer-toolbox.redhat.com (unknown [10.2.16.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 00C48C15BB8;
        Fri, 29 Sep 2023 17:00:44 +0000 (UTC)
From:   Chris Leech <cleech@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Rasesh Mody <rmody@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        Manish Chopra <manishc@marvell.com>
Cc:     Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        John Meneghini <jmeneghi@redhat.com>,
        Lee Duncan <lduncan@suse.com>,
        Mike Christie <michael.christie@oracle.com>,
        Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] cnic,bnx2,bnx2x: use UIO_MEM_DMA_COHERENT
Date:   Fri, 29 Sep 2023 10:00:23 -0700
Message-ID: <20230929170023.1020032-4-cleech@redhat.com>
In-Reply-To: <20230929170023.1020032-1-cleech@redhat.com>
References: <20230929170023.1020032-1-cleech@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the new UIO_MEM_DMA_COHERENT type to properly handle mmap
for dma_alloc_coherent buffers.

The cnic l2_ring and l2_buf mmaps have caused page refcount issues since
the misuse of the __GFP_COMP flag was removed from their
dma_alloc_coherent calls. Fix that by having the uio device use
dma_mmap_coherent.

The bnx2 and bnx2x status block allocations are also dma_alloc_coherent,
and should use dma_mmap_coherent. They didn't allocate multiple pages,
but also didn't seem to work correctly with an iommu enabled.

Fixes: bb73955c0b1d ("cnic: don't pass bogus GFP_ flags to dma_alloc_coherent")
Signed-off-by: Chris Leech <cleech@redhat.com>
---
 drivers/net/ethernet/broadcom/bnx2.c          |  1 +
 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  |  2 ++
 drivers/net/ethernet/broadcom/cnic.c          | 25 ++++++++++++-------
 drivers/net/ethernet/broadcom/cnic.h          |  1 +
 drivers/net/ethernet/broadcom/cnic_if.h       |  1 +
 5 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2.c b/drivers/net/ethernet/broadcom/bnx2.c
index 84a04eec654a..490f88ad3bd2 100644
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
index 2fcde42a05c1..dbaa90b7f889 100644
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
index 67ec397bd171..05e28e00e916 100644
--- a/drivers/net/ethernet/broadcom/cnic.c
+++ b/drivers/net/ethernet/broadcom/cnic.c
@@ -1106,8 +1106,8 @@ static int cnic_init_uio(struct cnic_dev *dev)
 	if (test_bit(CNIC_F_BNX2_CLASS, &dev->flags)) {
 		uinfo->mem[0].size = MB_GET_CID_ADDR(TX_TSS_CID +
 						     TX_MAX_TSS_RINGS + 1);
-		uinfo->mem[1].addr = (unsigned long) cp->status_blk.gen &
-					CNIC_PAGE_MASK;
+		uinfo->mem[1].dma_addr = cp->status_blk_map;
+		uinfo->mem[1].virtual_addr = cp->status_blk.gen;
 		if (cp->ethdev->drv_state & CNIC_DRV_STATE_USING_MSIX)
 			uinfo->mem[1].size = PAGE_ALIGN(BNX2_SBLK_MSIX_ALIGN_SIZE * 9);
 		else
@@ -1117,22 +1117,27 @@ static int cnic_init_uio(struct cnic_dev *dev)
 	} else if (test_bit(CNIC_F_BNX2X_CLASS, &dev->flags)) {
 		uinfo->mem[0].size = pci_resource_len(dev->pcidev, 0);
 
-		uinfo->mem[1].addr = (unsigned long) cp->bnx2x_def_status_blk &
-			CNIC_PAGE_MASK;
+		uinfo->mem[1].dma_addr = cp->status_blk_map;
+		uinfo->mem[1].virtual_addr = cp->bnx2x_def_status_blk;
 		uinfo->mem[1].size = PAGE_ALIGN(sizeof(*cp->bnx2x_def_status_blk));
 
 		uinfo->name = "bnx2x_cnic";
 	}
 
-	uinfo->mem[1].memtype = UIO_MEM_LOGICAL;
+	uinfo->mem[1].dma_device = &dev->pcidev->dev;
+	uinfo->mem[1].memtype = UIO_MEM_DMA_COHERENT;
 
-	uinfo->mem[2].addr = (unsigned long) udev->l2_ring;
+	uinfo->mem[2].dma_addr = udev->l2_ring_map;
+	uinfo->mem[2].virtual_addr = udev->l2_ring;
 	uinfo->mem[2].size = udev->l2_ring_size;
-	uinfo->mem[2].memtype = UIO_MEM_LOGICAL;
+	uinfo->mem[2].dma_device = &dev->pcidev->dev;
+	uinfo->mem[2].memtype = UIO_MEM_DMA_COHERENT;
 
-	uinfo->mem[3].addr = (unsigned long) udev->l2_buf;
+	uinfo->mem[3].dma_addr = udev->l2_buf_map;
+	uinfo->mem[3].virtual_addr = udev->l2_buf;
 	uinfo->mem[3].size = udev->l2_buf_size;
-	uinfo->mem[3].memtype = UIO_MEM_LOGICAL;
+	uinfo->mem[3].dma_device = &dev->pcidev->dev;
+	uinfo->mem[3].memtype = UIO_MEM_DMA_COHERENT;
 
 	uinfo->version = CNIC_MODULE_VERSION;
 	uinfo->irq = UIO_IRQ_CUSTOM;
@@ -1314,6 +1319,7 @@ static int cnic_alloc_bnx2x_resc(struct cnic_dev *dev)
 		return 0;
 
 	cp->bnx2x_def_status_blk = cp->ethdev->irq_arr[1].status_blk;
+	cp->status_blk_map = cp->ethdev->irq_arr[1].status_blk_map;
 
 	cp->l2_rx_ring_size = 15;
 
@@ -5324,6 +5330,7 @@ static int cnic_start_hw(struct cnic_dev *dev)
 	pci_dev_get(dev->pcidev);
 	cp->func = PCI_FUNC(dev->pcidev->devfn);
 	cp->status_blk.gen = ethdev->irq_arr[0].status_blk;
+	cp->status_blk_map = ethdev->irq_arr[0].status_blk_map;
 	cp->status_blk_num = ethdev->irq_arr[0].status_blk_num;
 
 	err = cp->alloc_resc(dev);
diff --git a/drivers/net/ethernet/broadcom/cnic.h b/drivers/net/ethernet/broadcom/cnic.h
index 4baea81bae7a..fedc84ada937 100644
--- a/drivers/net/ethernet/broadcom/cnic.h
+++ b/drivers/net/ethernet/broadcom/cnic.h
@@ -260,6 +260,7 @@ struct cnic_local {
 		#define SM_RX_ID		0
 		#define SM_TX_ID		1
 	} status_blk;
+	dma_addr_t status_blk_map;
 
 	struct host_sp_status_block	*bnx2x_def_status_blk;
 
diff --git a/drivers/net/ethernet/broadcom/cnic_if.h b/drivers/net/ethernet/broadcom/cnic_if.h
index 789e5c7e9311..49a11ec80b36 100644
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
2.41.0

