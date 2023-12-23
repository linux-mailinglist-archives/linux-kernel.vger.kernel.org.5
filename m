Return-Path: <linux-kernel+bounces-10220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BA181D177
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A631E1F23E15
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCBD9440;
	Sat, 23 Dec 2023 02:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WanKfbTQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA79CA72;
	Sat, 23 Dec 2023 02:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703300299; x=1734836299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=46Vvjei49P7oFRMYlPnyxLohII5Trr+LUZK0y4+x0UE=;
  b=WanKfbTQJ/KyzdANvyWKhwRXQRdK9DEf94K0In7HssAhPvgSXR7u85cE
   jxQxDhvQP9Ux8JqvAti6nFVErJpu0T7XoPnSLEk3a8e2zFt7X3O1Rup71
   NYbX83bwxFRpKZ7YnJQ7qJf8YUBwu9Vxreme8+69am28K/g7DRO4MLTOu
   UQAAeofrLw3NihImBK2iT4tV9izWUy4hgy304V4ZY59cIdU8w591qjV52
   pSZp+0RRmV77wI/k3GaxlVv8gNS0Axoz/kHYTh6KOPFJZjE5g7HFsGctm
   pDQ0rzmD8kwcgqK8++UPpswSTCVYyHMV2ThlyS/3gIcrcfuzn7UE1oOZ/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="386610796"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="386610796"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 18:58:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="25537414"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa001.jf.intel.com with ESMTP; 22 Dec 2023 18:58:15 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC net-next 04/34] libie: support different types of buffers for Rx
Date: Sat, 23 Dec 2023 03:55:24 +0100
Message-ID: <20231223025554.2316836-5-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231223025554.2316836-1-aleksander.lobakin@intel.com>
References: <20231223025554.2316836-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike previous generations, idpf requires more buffer types for optimal
performance. This includes: header buffers, short buffers, and
no-overhead buffers (w/o headroom and tailroom, for TCP zerocopy when
the header split is enabled).
Introduce libie Rx buffer type and calculate page_pool params
accordingly. All the HW-related details like buffer alignment are still
accounted. For the header buffers, pick 256 bytes as in most places in
the kernel (have you ever seen frames with bigger headers?).

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/libie/rx.c | 107 +++++++++++++++++++++++---
 include/linux/net/intel/libie/rx.h    |  19 +++++
 2 files changed, 115 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/libie/rx.c b/drivers/net/ethernet/intel/libie/rx.c
index 610f16043bcf..3d3b19d2b40d 100644
--- a/drivers/net/ethernet/intel/libie/rx.c
+++ b/drivers/net/ethernet/intel/libie/rx.c
@@ -6,14 +6,14 @@
 /* Rx buffer management */
 
 /**
- * libie_rx_hw_len - get the actual buffer size to be passed to HW
+ * libie_rx_hw_len_mtu - get the actual buffer size to be passed to HW
  * @pp: &page_pool_params of the netdev to calculate the size for
  *
  * Return: HW-writeable length per one buffer to pass it to the HW accounting:
  * MTU the @dev has, HW required alignment, minimum and maximum allowed values,
  * and system's page size.
  */
-static u32 libie_rx_hw_len(const struct page_pool_params *pp)
+static u32 libie_rx_hw_len_mtu(const struct page_pool_params *pp)
 {
 	u32 len;
 
@@ -24,6 +24,96 @@ static u32 libie_rx_hw_len(const struct page_pool_params *pp)
 	return len;
 }
 
+/**
+ * libie_rx_hw_len_truesize - get the short buffer size to be passed to HW
+ * @pp: &page_pool_params of the netdev to calculate the size for
+ * @truesize: desired truesize for the buffers
+ *
+ * Return: HW-writeable length per one buffer to pass it to the HW ignoring the
+ * MTU and closest to the passed truesize. Can be used for "short" buffer
+ * queues to fragment pages more efficiently.
+ */
+static u32 libie_rx_hw_len_truesize(const struct page_pool_params *pp,
+				    u32 truesize)
+{
+	u32 min, len;
+
+	min = SKB_HEAD_ALIGN(pp->offset + LIBIE_RX_BUF_LEN_ALIGN);
+	truesize = clamp(roundup_pow_of_two(truesize), roundup_pow_of_two(min),
+			 PAGE_SIZE << LIBIE_RX_PAGE_ORDER);
+
+	len = SKB_WITH_OVERHEAD(truesize - pp->offset);
+	len = ALIGN_DOWN(len, LIBIE_RX_BUF_LEN_ALIGN);
+	len = clamp(len, LIBIE_MIN_RX_BUF_LEN, pp->max_len);
+
+	return len;
+}
+
+static void libie_rx_page_pool_params(struct libie_buf_queue *bq,
+				      struct page_pool_params *pp)
+{
+	pp->offset = LIBIE_SKB_HEADROOM;
+	/* HW-writeable / syncable length per one page */
+	pp->max_len = LIBIE_RX_BUF_LEN(pp->offset);
+
+	/* HW-writeable length per buffer */
+	switch (bq->type) {
+	case LIBIE_RX_BUF_MTU:
+		bq->rx_buf_len = libie_rx_hw_len_mtu(pp);
+		break;
+	case LIBIE_RX_BUF_SHORT:
+		bq->rx_buf_len = libie_rx_hw_len_truesize(pp, bq->truesize);
+		break;
+	case LIBIE_RX_BUF_HDR:
+		bq->rx_buf_len = ALIGN(LIBIE_MAX_HEAD, LIBIE_RX_BUF_LEN_ALIGN);
+		break;
+	default:
+		break;
+	}
+
+	/* Buffer size to allocate */
+	bq->truesize = roundup_pow_of_two(SKB_HEAD_ALIGN(pp->offset +
+							 bq->rx_buf_len));
+}
+
+/**
+ * libie_rx_page_pool_params_zc - calculate params without the stack overhead
+ * @bq: buffer queue to calculate the size for
+ * @pp: &page_pool_params of the netdev
+ *
+ * Adjusts the PP params to exclude the stack overhead and sets both the buffer
+ * lengh and the truesize, which are equal for the data buffers. Note that this
+ * requires separate header buffers to be always active and account the
+ * overhead.
+ * With the MTU == ``PAGE_SIZE``, this allows the kernel to enable the zerocopy
+ * mode.
+ */
+static bool libie_rx_page_pool_params_zc(struct libie_buf_queue *bq,
+					 struct page_pool_params *pp)
+{
+	u32 mtu;
+
+	pp->offset = 0;
+	pp->max_len = PAGE_SIZE << LIBIE_RX_PAGE_ORDER;
+
+	switch (bq->type) {
+	case LIBIE_RX_BUF_MTU:
+		mtu = READ_ONCE(pp->netdev->mtu);
+		break;
+	case LIBIE_RX_BUF_SHORT:
+		mtu = bq->truesize;
+		break;
+	default:
+		return false;
+	}
+
+	bq->rx_buf_len = clamp(roundup_pow_of_two(mtu), LIBIE_RX_BUF_LEN_ALIGN,
+			       pp->max_len);
+	bq->truesize = bq->rx_buf_len;
+
+	return true;
+}
+
 /**
  * libie_rx_page_pool_create - create a PP with the default libie settings
  * @bq: buffer queue struct to fill
@@ -43,17 +133,12 @@ int libie_rx_page_pool_create(struct libie_buf_queue *bq,
 		.netdev		= napi->dev,
 		.napi		= napi,
 		.dma_dir	= DMA_FROM_DEVICE,
-		.offset		= LIBIE_SKB_HEADROOM,
 	};
 
-	/* HW-writeable / syncable length per one page */
-	pp.max_len = LIBIE_RX_BUF_LEN(pp.offset);
-
-	/* HW-writeable length per buffer */
-	bq->rx_buf_len = libie_rx_hw_len(&pp);
-	/* Buffer size to allocate */
-	bq->truesize = roundup_pow_of_two(SKB_HEAD_ALIGN(pp.offset +
-							 bq->rx_buf_len));
+	if (!bq->hsplit)
+		libie_rx_page_pool_params(bq, &pp);
+	else if (!libie_rx_page_pool_params_zc(bq, &pp))
+		return -EINVAL;
 
 	bq->pp = page_pool_create(&pp);
 
diff --git a/include/linux/net/intel/libie/rx.h b/include/linux/net/intel/libie/rx.h
index 0d6bce19ad6b..87ad8f9e89c7 100644
--- a/include/linux/net/intel/libie/rx.h
+++ b/include/linux/net/intel/libie/rx.h
@@ -19,6 +19,8 @@
 #define LIBIE_MAX_HEADROOM	LIBIE_SKB_HEADROOM
 /* Link layer / L2 overhead: Ethernet, 2 VLAN tags (C + S), FCS */
 #define LIBIE_RX_LL_LEN		(ETH_HLEN + 2 * VLAN_HLEN + ETH_FCS_LEN)
+/* Maximum supported L2-L4 header length */
+#define LIBIE_MAX_HEAD		256
 
 /* Always use order-0 pages */
 #define LIBIE_RX_PAGE_ORDER	0
@@ -64,6 +66,18 @@ struct libie_rx_buffer {
 	u32			truesize;
 };
 
+/**
+ * enum libie_rx_buf_type - enum representing types of Rx buffers
+ * @LIBIE_RX_BUF_MTU: buffer size is determined by MTU
+ * @LIBIE_RX_BUF_SHORT: buffer size is smaller than MTU, for short frames
+ * @LIBIE_RX_BUF_HDR: buffer size is ```LIBIE_MAX_HEAD```-sized, for headers
+ */
+enum libie_rx_buf_type {
+	LIBIE_RX_BUF_MTU	= 0U,
+	LIBIE_RX_BUF_SHORT,
+	LIBIE_RX_BUF_HDR,
+};
+
 /**
  * struct libie_buf_queue - structure representing a buffer queue
  * @pp: &page_pool for buffer management
@@ -71,6 +85,8 @@ struct libie_rx_buffer {
  * @truesize: size to allocate per buffer, w/overhead
  * @count: number of descriptors/buffers the queue has
  * @rx_buf_len: HW-writeable length per each buffer
+ * @type: type of the buffers this queue has
+ * @hsplit: flag whether header split is enabled
  */
 struct libie_buf_queue {
 	struct page_pool	*pp;
@@ -81,6 +97,9 @@ struct libie_buf_queue {
 
 	/* Cold fields */
 	u32			rx_buf_len;
+	enum libie_rx_buf_type	type:2;
+
+	bool			hsplit:1;
 };
 
 int libie_rx_page_pool_create(struct libie_buf_queue *bq,
-- 
2.43.0


