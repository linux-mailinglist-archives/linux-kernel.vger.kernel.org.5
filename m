Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C1B7B384B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 19:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbjI2RBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 13:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbjI2RBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:01:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189A01A7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696006851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KJIb8l8HiWQLqwHnb+OGG6jBumxqOciHnOCpUxHqes8=;
        b=gOZFD3mvA9P8UG+QXusupF2sbj3IwTufgHBbCWGDtxa1fKUSQ0KzDfrfdWc7aYr/wSPZFU
        645M8t8Kk7hfTjsoAKC2DC8EQHSrPRWU79kZA30p9MwQ1cukzvMCl9lDzvKGfixj8qMp0i
        4QW080Fjrjl5m4lK6I97Dx4reEz4tqU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-373-bhXzHpUdNYKihzMazFXV2A-1; Fri, 29 Sep 2023 13:00:45 -0400
X-MC-Unique: bhXzHpUdNYKihzMazFXV2A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE8E73815F63;
        Fri, 29 Sep 2023 17:00:44 +0000 (UTC)
Received: from rhel-developer-toolbox.redhat.com (unknown [10.2.16.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4506BC15BB8;
        Fri, 29 Sep 2023 17:00:43 +0000 (UTC)
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
Subject: [PATCH 2/3] cnic,bnx2,bnx2x: page align uio mmap allocations
Date:   Fri, 29 Sep 2023 10:00:22 -0700
Message-ID: <20230929170023.1020032-3-cleech@redhat.com>
In-Reply-To: <20230929170023.1020032-1-cleech@redhat.com>
References: <20230929170023.1020032-1-cleech@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocations in these drivers that will be mmaped through a uio device
should be made in multiples of PAGE_SIZE to avoid exposing additional
kernel memory unintentionally.

Signed-off-by: Chris Leech <cleech@redhat.com>
---
 drivers/net/ethernet/broadcom/bnx2.c             | 1 +
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 8 ++++----
 drivers/net/ethernet/broadcom/cnic.c             | 9 +++++----
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2.c b/drivers/net/ethernet/broadcom/bnx2.c
index 0d917a9699c5..84a04eec654a 100644
--- a/drivers/net/ethernet/broadcom/bnx2.c
+++ b/drivers/net/ethernet/broadcom/bnx2.c
@@ -837,6 +837,7 @@ bnx2_alloc_stats_blk(struct net_device *dev)
 						 BNX2_SBLK_MSIX_ALIGN_SIZE);
 	bp->status_stats_size = status_blk_size +
 				sizeof(struct statistics_block);
+	bp->status_stats_size = PAGE_ALIGN(bp->status_stats_size);
 	status_blk = dma_alloc_coherent(&bp->pdev->dev, bp->status_stats_size,
 					&bp->status_blk_mapping, GFP_KERNEL);
 	if (!status_blk)
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 0d8e61c63c7c..2fcde42a05c1 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -8270,10 +8270,10 @@ void bnx2x_free_mem_cnic(struct bnx2x *bp)
 
 	if (!CHIP_IS_E1x(bp))
 		BNX2X_PCI_FREE(bp->cnic_sb.e2_sb, bp->cnic_sb_mapping,
-			       sizeof(struct host_hc_status_block_e2));
+			PAGE_ALIGN(sizeof(struct host_hc_status_block_e2)));
 	else
 		BNX2X_PCI_FREE(bp->cnic_sb.e1x_sb, bp->cnic_sb_mapping,
-			       sizeof(struct host_hc_status_block_e1x));
+			PAGE_ALIGN(sizeof(struct host_hc_status_block_e1x)));
 
 	BNX2X_PCI_FREE(bp->t2, bp->t2_mapping, SRC_T2_SZ);
 }
@@ -8316,12 +8316,12 @@ int bnx2x_alloc_mem_cnic(struct bnx2x *bp)
 	if (!CHIP_IS_E1x(bp)) {
 		/* size = the status block + ramrod buffers */
 		bp->cnic_sb.e2_sb = BNX2X_PCI_ALLOC(&bp->cnic_sb_mapping,
-						    sizeof(struct host_hc_status_block_e2));
+					PAGE_ALIGN(sizeof(struct host_hc_status_block_e2)));
 		if (!bp->cnic_sb.e2_sb)
 			goto alloc_mem_err;
 	} else {
 		bp->cnic_sb.e1x_sb = BNX2X_PCI_ALLOC(&bp->cnic_sb_mapping,
-						     sizeof(struct host_hc_status_block_e1x));
+					PAGE_ALIGN(sizeof(struct host_hc_status_block_e1x)));
 		if (!bp->cnic_sb.e1x_sb)
 			goto alloc_mem_err;
 	}
diff --git a/drivers/net/ethernet/broadcom/cnic.c b/drivers/net/ethernet/broadcom/cnic.c
index 7926aaef8f0c..67ec397bd171 100644
--- a/drivers/net/ethernet/broadcom/cnic.c
+++ b/drivers/net/ethernet/broadcom/cnic.c
@@ -1026,13 +1026,14 @@ static int __cnic_alloc_uio_rings(struct cnic_uio_dev *udev, int pages)
 		return 0;
 
 	udev->l2_ring_size = pages * CNIC_PAGE_SIZE;
+	udev->l2_ring_size = PAGE_ALIGN(udev->l2_ring_size);
 	udev->l2_ring = dma_alloc_coherent(&udev->pdev->dev, udev->l2_ring_size,
 					   &udev->l2_ring_map, GFP_KERNEL);
 	if (!udev->l2_ring)
 		return -ENOMEM;
 
 	udev->l2_buf_size = (cp->l2_rx_ring_size + 1) * cp->l2_single_buf_size;
-	udev->l2_buf_size = CNIC_PAGE_ALIGN(udev->l2_buf_size);
+	udev->l2_buf_size = PAGE_ALIGN(udev->l2_buf_size);
 	udev->l2_buf = dma_alloc_coherent(&udev->pdev->dev, udev->l2_buf_size,
 					  &udev->l2_buf_map, GFP_KERNEL);
 	if (!udev->l2_buf) {
@@ -1108,9 +1109,9 @@ static int cnic_init_uio(struct cnic_dev *dev)
 		uinfo->mem[1].addr = (unsigned long) cp->status_blk.gen &
 					CNIC_PAGE_MASK;
 		if (cp->ethdev->drv_state & CNIC_DRV_STATE_USING_MSIX)
-			uinfo->mem[1].size = BNX2_SBLK_MSIX_ALIGN_SIZE * 9;
+			uinfo->mem[1].size = PAGE_ALIGN(BNX2_SBLK_MSIX_ALIGN_SIZE * 9);
 		else
-			uinfo->mem[1].size = BNX2_SBLK_MSIX_ALIGN_SIZE;
+			uinfo->mem[1].size = PAGE_ALIGN(BNX2_SBLK_MSIX_ALIGN_SIZE);
 
 		uinfo->name = "bnx2_cnic";
 	} else if (test_bit(CNIC_F_BNX2X_CLASS, &dev->flags)) {
@@ -1118,7 +1119,7 @@ static int cnic_init_uio(struct cnic_dev *dev)
 
 		uinfo->mem[1].addr = (unsigned long) cp->bnx2x_def_status_blk &
 			CNIC_PAGE_MASK;
-		uinfo->mem[1].size = sizeof(*cp->bnx2x_def_status_blk);
+		uinfo->mem[1].size = PAGE_ALIGN(sizeof(*cp->bnx2x_def_status_blk));
 
 		uinfo->name = "bnx2x_cnic";
 	}
-- 
2.41.0

