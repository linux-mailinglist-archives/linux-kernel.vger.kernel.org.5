Return-Path: <linux-kernel+bounces-97159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6908876642
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8C11F253EA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B0C54BDA;
	Fri,  8 Mar 2024 14:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IxFypsnY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EF75E071;
	Fri,  8 Mar 2024 14:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709907563; cv=none; b=ox3jS36A9nT2BfVyFuQ1KUFsk3bvdo81ZTe+XH09NfRxfJuaauw8uwwAgNraEh9asqOub8LGLDo3llFLsBebjDxdO2E1xkdhjpbrzdssJdJ9YX4N+kXe3iOE2VXgIH6jxxRjlAWts7yqpVAvHrQPxqZ0rrtZPsqoZNtzgP4/l/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709907563; c=relaxed/simple;
	bh=V1uG4ZaRsdFtcRcZRHCtmmyKH7IgsCXaD+nqrwdd9gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kpEMyweg3SjXv9USMkyf4D4FMomNaOJr2gq6TFKF8x4f/nJJzjpLTwucF4XFNplFnlVtOoBOIdpZ8saGtrn03MzsmkMU+EIzzQST8dmex1R5DPSQYNk78Nw0H0h7w1W5YjQSAxgEHBPcqggtb7HNKK6bSuy/ZBTA6CAPFiHCP38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IxFypsnY; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709907561; x=1741443561;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V1uG4ZaRsdFtcRcZRHCtmmyKH7IgsCXaD+nqrwdd9gs=;
  b=IxFypsnYNaOPyIluK40jQ0/ykquEc4/tli+Cy4N12skXaA2s8UHJ+w06
   aZF7YL5oly68c/XP5iST34duN26YlZMFX2JR5dqclUQUaxoyzlIAzx/Np
   2390Eyfjn5mD77xT5BLnru+MYZrzwQt+MX9ORgJj/PnIKn2rrrT+cdZDw
   LbP1q6oUqXP0x6Ymv/5xDwj46Cfqbo9h3R0xTO0NCQdu2StAObzZcI/se
   6Oxa3re4wgEejAcI4Tuol+PyfvHBioJ0f15+mRinDLddCYiZdkZSHFaWo
   bM6enhWTKOccGV2hBIAUdGFxb7d+rUYAQKa2TgFgqfcACnVrB9mJ8Xbdh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4504686"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="4504686"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 06:19:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15177317"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa005.jf.intel.com with ESMTP; 08 Mar 2024 06:19:17 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	David Christensen <drc@linux.vnet.ibm.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v8 8/8] iavf: switch to Page Pool
Date: Fri,  8 Mar 2024 15:18:33 +0100
Message-ID: <20240308141833.2966600-9-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308141833.2966600-1-aleksander.lobakin@intel.com>
References: <20240308141833.2966600-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the IAVF driver simply uses dev_alloc_page() + free_page() with
no custom recycling logics, it can easily be switched to using Page
Pool / libeth API instead.
This allows to removing the whole dancing around headroom, HW buffer
size, and page order. All DMA-for-device is now done in the PP core,
for-CPU -- in the libeth helper.
Use skb_mark_for_recycle() to bring back the recycling and restore the
performance. Speaking of performance: on par with the baseline and
faster with the PP optimization series applied. But the memory usage for
1500b MTU is now almost 2x lower (x86_64) thanks to allocating a page
every second descriptor.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_txrx.h   |  34 +--
 include/linux/net/intel/libie/rx.h            |  17 ++
 drivers/net/ethernet/intel/iavf/iavf_main.c   |   7 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   | 254 +++++-------------
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  10 +-
 5 files changed, 109 insertions(+), 213 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.h b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
index ed559fa6f214..d7b5587aeb8e 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
@@ -80,18 +80,8 @@ enum iavf_dyn_idx_t {
 	BIT_ULL(IAVF_FILTER_PCTYPE_NONF_UNICAST_IPV6_UDP) | \
 	BIT_ULL(IAVF_FILTER_PCTYPE_NONF_MULTICAST_IPV6_UDP))
 
-/* Supported Rx Buffer Sizes (a multiple of 128) */
-#define IAVF_RXBUFFER_3072  3072  /* Used for large frames w/ padding */
-#define IAVF_MAX_RXBUFFER   9728  /* largest size for single descriptor */
-
-#define IAVF_PACKET_HDR_PAD (ETH_HLEN + ETH_FCS_LEN + (VLAN_HLEN * 2))
 #define iavf_rx_desc iavf_32byte_rx_desc
 
-#define IAVF_RX_DMA_ATTR \
-	(DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING)
-
-#define IAVF_SKB_PAD (NET_SKB_PAD + NET_IP_ALIGN)
-
 /**
  * iavf_test_staterr - tests bits in Rx descriptor status and error fields
  * @rx_desc: pointer to receive descriptor (in le64 format)
@@ -210,12 +200,6 @@ struct iavf_tx_buffer {
 	u32 tx_flags;
 };
 
-struct iavf_rx_buffer {
-	dma_addr_t dma;
-	struct page *page;
-	__u32 page_offset;
-};
-
 struct iavf_queue_stats {
 	u64 packets;
 	u64 bytes;
@@ -251,13 +235,18 @@ struct iavf_rx_queue_stats {
 struct iavf_ring {
 	struct iavf_ring *next;		/* pointer to next ring in q_vector */
 	void *desc;			/* Descriptor ring memory */
-	struct device *dev;		/* Used for DMA mapping */
+	union {
+		struct page_pool *pp;	/* Used on Rx for buffer management */
+		struct device *dev;	/* Used on Tx for DMA mapping */
+	};
 	struct net_device *netdev;	/* netdev ring maps to */
 	union {
+		struct libeth_fqe *rx_fqes;
 		struct iavf_tx_buffer *tx_bi;
-		struct iavf_rx_buffer *rx_bi;
 	};
 	u8 __iomem *tail;
+	u32 truesize;
+
 	u16 queue_index;		/* Queue number of ring */
 
 	/* high bit set means dynamic, use accessors routines to read/write.
@@ -305,6 +294,8 @@ struct iavf_ring {
 					 * iavf_clean_rx_ring_irq() is called
 					 * for this ring.
 					 */
+
+	u32 rx_buf_len;
 } ____cacheline_internodealigned_in_smp;
 
 #define IAVF_ITR_ADAPTIVE_MIN_INC	0x0002
@@ -328,13 +319,6 @@ struct iavf_ring_container {
 #define iavf_for_each_ring(pos, head) \
 	for (pos = (head).ring; pos != NULL; pos = pos->next)
 
-static inline unsigned int iavf_rx_pg_order(struct iavf_ring *ring)
-{
-	return 0;
-}
-
-#define iavf_rx_pg_size(_ring) (PAGE_SIZE << iavf_rx_pg_order(_ring))
-
 bool iavf_alloc_rx_buffers(struct iavf_ring *rxr, u16 cleaned_count);
 netdev_tx_t iavf_xmit_frame(struct sk_buff *skb, struct net_device *netdev);
 int iavf_setup_tx_descriptors(struct iavf_ring *tx_ring);
diff --git a/include/linux/net/intel/libie/rx.h b/include/linux/net/intel/libie/rx.h
index 54269bb8fcf1..733c441350f6 100644
--- a/include/linux/net/intel/libie/rx.h
+++ b/include/linux/net/intel/libie/rx.h
@@ -6,6 +6,23 @@
 
 #include <net/libeth/rx.h>
 
+/* Rx buffer management */
+
+/* The largest size for a single descriptor as per HW */
+#define LIBIE_MAX_RX_BUF_LEN	9728U
+/* "True" HW-writeable space: minimum from SW and HW values */
+#define LIBIE_RX_BUF_LEN(hr)	min_t(u32, LIBETH_RX_PAGE_LEN(hr),	\
+				      LIBIE_MAX_RX_BUF_LEN)
+
+/* The maximum frame size as per HW (S/G) */
+#define __LIBIE_MAX_RX_FRM_LEN	16382U
+/* ATST, HW can chain up to 5 Rx descriptors */
+#define LIBIE_MAX_RX_FRM_LEN(hr)					\
+	min_t(u32, __LIBIE_MAX_RX_FRM_LEN, LIBIE_RX_BUF_LEN(hr) * 5)
+/* Maximum frame size minus LL overhead */
+#define LIBIE_MAX_MTU							\
+	(LIBIE_MAX_RX_FRM_LEN(LIBETH_MAX_HEADROOM) - LIBETH_RX_LL_LEN)
+
 /* O(1) converting i40e/ice/iavf's 8/10-bit hardware packet type to a parsed
  * bitfield struct.
  */
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index e14508bc62e1..af9c87673256 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
+#include <linux/net/intel/libie/rx.h>
+
 #include "iavf.h"
 #include "iavf_prototype.h"
 /* All iavf tracepoints are defined by the include below, which must
@@ -45,6 +47,7 @@ MODULE_DEVICE_TABLE(pci, iavf_pci_tbl);
 MODULE_ALIAS("i40evf");
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
 MODULE_DESCRIPTION("Intel(R) Ethernet Adaptive Virtual Function Network Driver");
+MODULE_IMPORT_NS(LIBETH);
 MODULE_IMPORT_NS(LIBIE);
 MODULE_LICENSE("GPL v2");
 
@@ -1586,7 +1589,6 @@ static int iavf_alloc_queues(struct iavf_adapter *adapter)
 		rx_ring = &adapter->rx_rings[i];
 		rx_ring->queue_index = i;
 		rx_ring->netdev = adapter->netdev;
-		rx_ring->dev = &adapter->pdev->dev;
 		rx_ring->count = adapter->rx_desc_count;
 		rx_ring->itr_setting = IAVF_ITR_RX_DEF;
 	}
@@ -2613,9 +2615,8 @@ static void iavf_init_config_adapter(struct iavf_adapter *adapter)
 	iavf_set_ethtool_ops(netdev);
 	netdev->watchdog_timeo = 5 * HZ;
 
-	/* MTU range: 68 - 9710 */
 	netdev->min_mtu = ETH_MIN_MTU;
-	netdev->max_mtu = IAVF_MAX_RXBUFFER - IAVF_PACKET_HDR_PAD;
+	netdev->max_mtu = LIBIE_MAX_MTU;
 
 	if (!is_valid_ether_addr(adapter->hw.mac.addr)) {
 		dev_info(&pdev->dev, "Invalid MAC address %pM, using random\n",
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 1a27fa613f6d..aece2d4cc9c8 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -690,11 +690,8 @@ int iavf_setup_tx_descriptors(struct iavf_ring *tx_ring)
  **/
 static void iavf_clean_rx_ring(struct iavf_ring *rx_ring)
 {
-	unsigned long bi_size;
-	u16 i;
-
 	/* ring already cleared, nothing to do */
-	if (!rx_ring->rx_bi)
+	if (!rx_ring->rx_fqes)
 		return;
 
 	if (rx_ring->skb) {
@@ -702,40 +699,16 @@ static void iavf_clean_rx_ring(struct iavf_ring *rx_ring)
 		rx_ring->skb = NULL;
 	}
 
-	/* Free all the Rx ring sk_buffs */
-	for (i = 0; i < rx_ring->count; i++) {
-		struct iavf_rx_buffer *rx_bi = &rx_ring->rx_bi[i];
+	/* Free all the Rx ring buffers */
+	for (u32 i = rx_ring->next_to_clean; i != rx_ring->next_to_use; ) {
+		const struct libeth_fqe *rx_fqes = &rx_ring->rx_fqes[i];
 
-		if (!rx_bi->page)
-			continue;
+		page_pool_put_full_page(rx_ring->pp, rx_fqes->page, false);
 
-		/* Invalidate cache lines that may have been written to by
-		 * device so that we avoid corrupting memory.
-		 */
-		dma_sync_single_range_for_cpu(rx_ring->dev,
-					      rx_bi->dma,
-					      rx_bi->page_offset,
-					      IAVF_RXBUFFER_3072,
-					      DMA_FROM_DEVICE);
-
-		/* free resources associated with mapping */
-		dma_unmap_page_attrs(rx_ring->dev, rx_bi->dma,
-				     iavf_rx_pg_size(rx_ring),
-				     DMA_FROM_DEVICE,
-				     IAVF_RX_DMA_ATTR);
-
-		__free_page(rx_bi->page);
-
-		rx_bi->page = NULL;
-		rx_bi->page_offset = 0;
+		if (unlikely(++i == rx_ring->count))
+			i = 0;
 	}
 
-	bi_size = sizeof(struct iavf_rx_buffer) * rx_ring->count;
-	memset(rx_ring->rx_bi, 0, bi_size);
-
-	/* Zero out the descriptor ring */
-	memset(rx_ring->desc, 0, rx_ring->size);
-
 	rx_ring->next_to_clean = 0;
 	rx_ring->next_to_use = 0;
 }
@@ -748,15 +721,22 @@ static void iavf_clean_rx_ring(struct iavf_ring *rx_ring)
  **/
 void iavf_free_rx_resources(struct iavf_ring *rx_ring)
 {
+	struct libeth_fq fq = {
+		.fqes	= rx_ring->rx_fqes,
+		.pp	= rx_ring->pp,
+	};
+
 	iavf_clean_rx_ring(rx_ring);
-	kfree(rx_ring->rx_bi);
-	rx_ring->rx_bi = NULL;
 
 	if (rx_ring->desc) {
-		dma_free_coherent(rx_ring->dev, rx_ring->size,
+		dma_free_coherent(rx_ring->pp->p.dev, rx_ring->size,
 				  rx_ring->desc, rx_ring->dma);
 		rx_ring->desc = NULL;
 	}
+
+	libeth_rx_fq_destroy(&fq);
+	rx_ring->rx_fqes = NULL;
+	rx_ring->pp = NULL;
 }
 
 /**
@@ -767,26 +747,31 @@ void iavf_free_rx_resources(struct iavf_ring *rx_ring)
  **/
 int iavf_setup_rx_descriptors(struct iavf_ring *rx_ring)
 {
-	struct device *dev = rx_ring->dev;
-	int bi_size;
+	struct libeth_fq fq = {
+		.count		= rx_ring->count,
+		.buf_len	= LIBIE_MAX_RX_BUF_LEN,
+	};
+	int ret;
 
-	/* warn if we are about to overwrite the pointer */
-	WARN_ON(rx_ring->rx_bi);
-	bi_size = sizeof(struct iavf_rx_buffer) * rx_ring->count;
-	rx_ring->rx_bi = kzalloc(bi_size, GFP_KERNEL);
-	if (!rx_ring->rx_bi)
-		goto err;
+	ret = libeth_rx_fq_create(&fq, &rx_ring->q_vector->napi);
+	if (ret)
+		return ret;
+
+	rx_ring->pp = fq.pp;
+	rx_ring->rx_fqes = fq.fqes;
+	rx_ring->truesize = fq.truesize;
+	rx_ring->rx_buf_len = fq.buf_len;
 
 	u64_stats_init(&rx_ring->syncp);
 
 	/* Round up to nearest 4K */
 	rx_ring->size = rx_ring->count * sizeof(union iavf_32byte_rx_desc);
 	rx_ring->size = ALIGN(rx_ring->size, 4096);
-	rx_ring->desc = dma_alloc_coherent(dev, rx_ring->size,
+	rx_ring->desc = dma_alloc_coherent(fq.pp->p.dev, rx_ring->size,
 					   &rx_ring->dma, GFP_KERNEL);
 
 	if (!rx_ring->desc) {
-		dev_info(dev, "Unable to allocate memory for the Rx descriptor ring, size=%d\n",
+		dev_info(fq.pp->p.dev, "Unable to allocate memory for the Rx descriptor ring, size=%d\n",
 			 rx_ring->size);
 		goto err;
 	}
@@ -795,9 +780,12 @@ int iavf_setup_rx_descriptors(struct iavf_ring *rx_ring)
 	rx_ring->next_to_use = 0;
 
 	return 0;
+
 err:
-	kfree(rx_ring->rx_bi);
-	rx_ring->rx_bi = NULL;
+	libeth_rx_fq_destroy(&fq);
+	rx_ring->rx_fqes = NULL;
+	rx_ring->pp = NULL;
+
 	return -ENOMEM;
 }
 
@@ -819,49 +807,6 @@ static void iavf_release_rx_desc(struct iavf_ring *rx_ring, u32 val)
 	writel(val, rx_ring->tail);
 }
 
-/**
- * iavf_alloc_mapped_page - recycle or make a new page
- * @rx_ring: ring to use
- * @bi: rx_buffer struct to modify
- *
- * Returns true if the page was successfully allocated or
- * reused.
- **/
-static bool iavf_alloc_mapped_page(struct iavf_ring *rx_ring,
-				   struct iavf_rx_buffer *bi)
-{
-	struct page *page = bi->page;
-	dma_addr_t dma;
-
-	/* alloc new page for storage */
-	page = dev_alloc_pages(iavf_rx_pg_order(rx_ring));
-	if (unlikely(!page)) {
-		rx_ring->rx_stats.alloc_page_failed++;
-		return false;
-	}
-
-	/* map page for use */
-	dma = dma_map_page_attrs(rx_ring->dev, page, 0,
-				 iavf_rx_pg_size(rx_ring),
-				 DMA_FROM_DEVICE,
-				 IAVF_RX_DMA_ATTR);
-
-	/* if mapping failed free memory back to system since
-	 * there isn't much point in holding memory we can't use
-	 */
-	if (dma_mapping_error(rx_ring->dev, dma)) {
-		__free_pages(page, iavf_rx_pg_order(rx_ring));
-		rx_ring->rx_stats.alloc_page_failed++;
-		return false;
-	}
-
-	bi->dma = dma;
-	bi->page = page;
-	bi->page_offset = IAVF_SKB_PAD;
-
-	return true;
-}
-
 /**
  * iavf_receive_skb - Send a completed packet up the stack
  * @rx_ring:  rx ring in play
@@ -892,38 +837,37 @@ static void iavf_receive_skb(struct iavf_ring *rx_ring,
  **/
 bool iavf_alloc_rx_buffers(struct iavf_ring *rx_ring, u16 cleaned_count)
 {
+	const struct libeth_fq_fp fq = {
+		.pp		= rx_ring->pp,
+		.fqes		= rx_ring->rx_fqes,
+		.truesize	= rx_ring->truesize,
+		.count		= rx_ring->count,
+	};
 	u16 ntu = rx_ring->next_to_use;
 	union iavf_rx_desc *rx_desc;
-	struct iavf_rx_buffer *bi;
 
 	/* do nothing if no valid netdev defined */
 	if (!rx_ring->netdev || !cleaned_count)
 		return false;
 
 	rx_desc = IAVF_RX_DESC(rx_ring, ntu);
-	bi = &rx_ring->rx_bi[ntu];
 
 	do {
-		if (!iavf_alloc_mapped_page(rx_ring, bi))
-			goto no_buffers;
+		dma_addr_t addr;
 
-		/* sync the buffer for use by the device */
-		dma_sync_single_range_for_device(rx_ring->dev, bi->dma,
-						 bi->page_offset,
-						 IAVF_RXBUFFER_3072,
-						 DMA_FROM_DEVICE);
+		addr = libeth_rx_alloc(&fq, ntu);
+		if (addr == DMA_MAPPING_ERROR)
+			goto no_buffers;
 
 		/* Refresh the desc even if buffer_addrs didn't change
 		 * because each write-back erases this info.
 		 */
-		rx_desc->read.pkt_addr = cpu_to_le64(bi->dma + bi->page_offset);
+		rx_desc->read.pkt_addr = cpu_to_le64(addr);
 
 		rx_desc++;
-		bi++;
 		ntu++;
 		if (unlikely(ntu == rx_ring->count)) {
 			rx_desc = IAVF_RX_DESC(rx_ring, 0);
-			bi = rx_ring->rx_bi;
 			ntu = 0;
 		}
 
@@ -942,6 +886,8 @@ bool iavf_alloc_rx_buffers(struct iavf_ring *rx_ring, u16 cleaned_count)
 	if (rx_ring->next_to_use != ntu)
 		iavf_release_rx_desc(rx_ring, ntu);
 
+	rx_ring->rx_stats.alloc_page_failed++;
+
 	/* make sure to come back via polling to try again after
 	 * allocation failure
 	 */
@@ -1090,9 +1036,8 @@ static bool iavf_cleanup_headers(struct iavf_ring *rx_ring, struct sk_buff *skb)
 
 /**
  * iavf_add_rx_frag - Add contents of Rx buffer to sk_buff
- * @rx_ring: rx descriptor ring to transact packets on
- * @rx_buffer: buffer containing page to add
  * @skb: sk_buff to place the data into
+ * @rx_buffer: buffer containing page to add
  * @size: packet length from rx_desc
  *
  * This function will add the data contained in rx_buffer->page to the skb.
@@ -1100,105 +1045,49 @@ static bool iavf_cleanup_headers(struct iavf_ring *rx_ring, struct sk_buff *skb)
  *
  * The function will then update the page offset.
  **/
-static void iavf_add_rx_frag(struct iavf_ring *rx_ring,
-			     struct iavf_rx_buffer *rx_buffer,
-			     struct sk_buff *skb,
+static void iavf_add_rx_frag(struct sk_buff *skb,
+			     const struct libeth_fqe *rx_buffer,
 			     unsigned int size)
 {
-	unsigned int truesize = SKB_DATA_ALIGN(size + IAVF_SKB_PAD);
-
-	if (!size)
-		return;
+	u32 hr = rx_buffer->page->pp->p.offset;
 
 	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buffer->page,
-			rx_buffer->page_offset, size, truesize);
-}
-
-/**
- * iavf_get_rx_buffer - Fetch Rx buffer and synchronize data for use
- * @rx_ring: rx descriptor ring to transact packets on
- * @size: size of buffer to add to skb
- *
- * This function will pull an Rx buffer from the ring and synchronize it
- * for use by the CPU.
- */
-static struct iavf_rx_buffer *iavf_get_rx_buffer(struct iavf_ring *rx_ring,
-						 const unsigned int size)
-{
-	struct iavf_rx_buffer *rx_buffer;
-
-	rx_buffer = &rx_ring->rx_bi[rx_ring->next_to_clean];
-	prefetchw(rx_buffer->page);
-	if (!size)
-		return rx_buffer;
-
-	/* we are reusing so sync this buffer for CPU use */
-	dma_sync_single_range_for_cpu(rx_ring->dev,
-				      rx_buffer->dma,
-				      rx_buffer->page_offset,
-				      size,
-				      DMA_FROM_DEVICE);
-
-	return rx_buffer;
+			rx_buffer->offset + hr, size, rx_buffer->truesize);
 }
 
 /**
  * iavf_build_skb - Build skb around an existing buffer
- * @rx_ring: Rx descriptor ring to transact packets on
  * @rx_buffer: Rx buffer to pull data from
  * @size: size of buffer to add to skb
  *
  * This function builds an skb around an existing Rx buffer, taking care
  * to set up the skb correctly and avoid any memcpy overhead.
  */
-static struct sk_buff *iavf_build_skb(struct iavf_ring *rx_ring,
-				      struct iavf_rx_buffer *rx_buffer,
+static struct sk_buff *iavf_build_skb(const struct libeth_fqe *rx_buffer,
 				      unsigned int size)
 {
-	void *va;
-	unsigned int truesize = SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) +
-				SKB_DATA_ALIGN(IAVF_SKB_PAD + size);
+	u32 hr = rx_buffer->page->pp->p.offset;
 	struct sk_buff *skb;
+	void *va;
 
-	if (!rx_buffer || !size)
-		return NULL;
 	/* prefetch first cache line of first page */
-	va = page_address(rx_buffer->page) + rx_buffer->page_offset;
-	net_prefetch(va);
+	va = page_address(rx_buffer->page) + rx_buffer->offset;
+	net_prefetch(va + hr);
 
 	/* build an skb around the page buffer */
-	skb = napi_build_skb(va - IAVF_SKB_PAD, truesize);
+	skb = napi_build_skb(va, rx_buffer->truesize);
 	if (unlikely(!skb))
 		return NULL;
 
+	skb_mark_for_recycle(skb);
+
 	/* update pointers within the skb to store the data */
-	skb_reserve(skb, IAVF_SKB_PAD);
+	skb_reserve(skb, hr);
 	__skb_put(skb, size);
 
 	return skb;
 }
 
-/**
- * iavf_put_rx_buffer - Unmap used buffer
- * @rx_ring: rx descriptor ring to transact packets on
- * @rx_buffer: rx buffer to pull data from
- *
- * This function will unmap the buffer after it's written by HW.
- */
-static void iavf_put_rx_buffer(struct iavf_ring *rx_ring,
-			       struct iavf_rx_buffer *rx_buffer)
-{
-	if (!rx_buffer)
-		return;
-
-	/* we are not reusing the buffer so unmap it */
-	dma_unmap_page_attrs(rx_ring->dev, rx_buffer->dma, PAGE_SIZE,
-			     DMA_FROM_DEVICE, IAVF_RX_DMA_ATTR);
-
-	/* clear contents of buffer_info */
-	rx_buffer->page = NULL;
-}
-
 /**
  * iavf_is_non_eop - process handling of non-EOP buffers
  * @rx_ring: Rx ring being processed
@@ -1252,7 +1141,7 @@ static int iavf_clean_rx_irq(struct iavf_ring *rx_ring, int budget)
 	bool failure = false;
 
 	while (likely(total_rx_packets < (unsigned int)budget)) {
-		struct iavf_rx_buffer *rx_buffer;
+		struct libeth_fqe *rx_buffer;
 		union iavf_rx_desc *rx_desc;
 		unsigned int size;
 		u16 vlan_tag = 0;
@@ -1287,13 +1176,16 @@ static int iavf_clean_rx_irq(struct iavf_ring *rx_ring, int budget)
 		size = FIELD_GET(IAVF_RXD_QW1_LENGTH_PBUF_MASK, qword);
 
 		iavf_trace(clean_rx_irq, rx_ring, rx_desc, skb);
-		rx_buffer = iavf_get_rx_buffer(rx_ring, size);
+
+		rx_buffer = &rx_ring->rx_fqes[rx_ring->next_to_clean];
+		if (!libeth_rx_sync_for_cpu(rx_buffer, size))
+			goto skip_data;
 
 		/* retrieve a buffer from the ring */
 		if (skb)
-			iavf_add_rx_frag(rx_ring, rx_buffer, skb, size);
+			iavf_add_rx_frag(skb, rx_buffer, size);
 		else
-			skb = iavf_build_skb(rx_ring, rx_buffer, size);
+			skb = iavf_build_skb(rx_buffer, size);
 
 		/* exit if we failed to retrieve a buffer */
 		if (!skb) {
@@ -1301,10 +1193,10 @@ static int iavf_clean_rx_irq(struct iavf_ring *rx_ring, int budget)
 			break;
 		}
 
-		iavf_put_rx_buffer(rx_ring, rx_buffer);
+skip_data:
 		cleaned_count++;
 
-		if (iavf_is_non_eop(rx_ring, rx_desc, skb))
+		if (iavf_is_non_eop(rx_ring, rx_desc, skb) || unlikely(!skb))
 			continue;
 
 		/* ERR_MASK will only have valid bits if EOP set, and
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index f8e9f859a4f1..1e543f6a7c30 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
+#include <linux/net/intel/libie/rx.h>
+
 #include "iavf.h"
 #include "iavf_prototype.h"
 
@@ -268,13 +270,13 @@ int iavf_get_vf_vlan_v2_caps(struct iavf_adapter *adapter)
 void iavf_configure_queues(struct iavf_adapter *adapter)
 {
 	struct virtchnl_vsi_queue_config_info *vqci;
-	int i, max_frame = adapter->vf_res->max_mtu;
 	int pairs = adapter->num_active_queues;
 	struct virtchnl_queue_pair_info *vqpi;
+	u32 i, max_frame;
 	size_t len;
 
-	if (max_frame > IAVF_MAX_RXBUFFER || !max_frame)
-		max_frame = IAVF_MAX_RXBUFFER;
+	max_frame = LIBIE_MAX_RX_FRM_LEN(adapter->rx_rings->pp->p.offset);
+	max_frame = min_not_zero(adapter->vf_res->max_mtu, max_frame);
 
 	if (adapter->current_op != VIRTCHNL_OP_UNKNOWN) {
 		/* bail because we already have a command pending */
@@ -304,7 +306,7 @@ void iavf_configure_queues(struct iavf_adapter *adapter)
 		vqpi->rxq.ring_len = adapter->rx_rings[i].count;
 		vqpi->rxq.dma_ring_addr = adapter->rx_rings[i].dma;
 		vqpi->rxq.max_pkt_size = max_frame;
-		vqpi->rxq.databuffer_size = IAVF_RXBUFFER_3072;
+		vqpi->rxq.databuffer_size = adapter->rx_rings[i].rx_buf_len;
 		if (CRC_OFFLOAD_ALLOWED(adapter))
 			vqpi->rxq.crc_disable = !!(adapter->netdev->features &
 						   NETIF_F_RXFCS);
-- 
2.44.0


