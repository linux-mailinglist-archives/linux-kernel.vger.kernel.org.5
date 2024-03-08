Return-Path: <linux-kernel+bounces-97157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 929DE87663E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48B54288A42
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA2B5D746;
	Fri,  8 Mar 2024 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cpgY7k9d"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C950E5C917;
	Fri,  8 Mar 2024 14:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709907555; cv=none; b=MlTGjnw5dGsdy913QChQxxWhgPYyUKK0F399/14pR4LNRj5thj6yECq/qFK2fE+jzVf7OqNzXoWb7+CK9LwOwCLdmyvj8pgZrzgQSlYDEPrtNDtjTdXRBVb3asmOLlYMkMsg+GfclHgq0Clk3J40vx90S9rK5z0qyUMLiXFcQwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709907555; c=relaxed/simple;
	bh=kCzqkCvkuWoOSUEAIPTJJg5+Fhvo+GudX2MdqduyuDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NbWGSvso8mdoz5mtAESHdXb3uBPa0AYEIIiG4f0exYCcp5y8TuYJ9jF1Pu8ucliXAngvgjOWZ3UaQtJqsNaN+/OfphL4DCH9izFUnZ04h7NsllSAApEs2yet/aHPJtEMkxvBBWhK1Uih/ecvI6VgU8ZvJR8BcRSc4uRRBaBPAQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cpgY7k9d; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709907554; x=1741443554;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kCzqkCvkuWoOSUEAIPTJJg5+Fhvo+GudX2MdqduyuDk=;
  b=cpgY7k9d/7stnPWXqHvow6vwZWGDANxP3Iro6L1dy0UO0zK6M8Dwj/iL
   cBsXWzV/OIy2rW5W+laGGAUuXnUtwFZ+pDw4i4TEM8z2n1L+13xSeaMul
   cP2U/fdzX/LZMhfZyrIx9PbGsxcztzAycrGc9FAqzhdB7SJ9OPBb9/4Ew
   Ujfa5Wjkczl1ka1PFbZpR57fb2wvacXYBXv+NlhVbEtYH6HK/91g5K5hS
   +fxtOZz0RpzWEhGJFqHkNCuEPx+CAc23dkmiDFCqKGYhrtJu7+P4r5xq+
   Hlm1TmDoi+nrKTj1Jf763XvNqJe7U64bvSy4D8zgcDxT66A47t5fjcfl7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4504640"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="4504640"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 06:19:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15177268"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa005.jf.intel.com with ESMTP; 08 Mar 2024 06:19:10 -0800
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
Subject: [PATCH net-next v8 6/8] libeth: add Rx buffer management
Date: Fri,  8 Mar 2024 15:18:31 +0100
Message-ID: <20240308141833.2966600-7-aleksander.lobakin@intel.com>
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

Add a couple intuitive helpers to hide Rx buffer implementation details
in the library and not multiplicate it between drivers. The settings are
sorta optimized for 100G+ NICs, but nothing really HW-specific here.
Use the new page_pool_dev_alloc() to dynamically switch between
split-page and full-page modes depending on MTU, page size, required
headroom etc. For example, on x86_64 with the default driver settings
each page is shared between 2 buffers. Turning on XDP (not in this
series) -> increasing headroom requirement pushes truesize out of 2048
boundary, leading to that each buffer starts getting a full page.
The "ceiling" limit is %PAGE_SIZE, as only order-0 pages are used to
avoid compound overhead. For the above architecture, this means maximum
linear frame size of 3712 w/o XDP.
Not that &libeth_buf_queue is not a complete queue/ring structure for
now, rather a shim, but eventually the libeth-enabled drivers will move
to it, with iavf being the first one.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/libeth/Kconfig |   1 +
 include/net/libeth/rx.h                   | 115 ++++++++++++++++++++++
 drivers/net/ethernet/intel/libeth/rx.c    |  98 ++++++++++++++++++
 3 files changed, 214 insertions(+)

diff --git a/drivers/net/ethernet/intel/libeth/Kconfig b/drivers/net/ethernet/intel/libeth/Kconfig
index 58caf729ad16..f0f78d42ce48 100644
--- a/drivers/net/ethernet/intel/libeth/Kconfig
+++ b/drivers/net/ethernet/intel/libeth/Kconfig
@@ -3,6 +3,7 @@
 
 config LIBETH
 	tristate
+	select PAGE_POOL
 	help
 	  libeth is a common library containing routines shared between several
 	  drivers, but not yet promoted to the generic kernel API.
diff --git a/include/net/libeth/rx.h b/include/net/libeth/rx.h
index fb100e3b578a..8814a864ccc9 100644
--- a/include/net/libeth/rx.h
+++ b/include/net/libeth/rx.h
@@ -4,8 +4,123 @@
 #ifndef __LIBETH_RX_H
 #define __LIBETH_RX_H
 
+#include <linux/if_vlan.h>
+
+#include <net/page_pool/helpers.h>
 #include <net/xdp.h>
 
+/* Rx buffer management */
+
+/* Space reserved in front of each frame */
+#define LIBETH_SKB_HEADROOM	(NET_SKB_PAD + NET_IP_ALIGN)
+/* Maximum headroom for worst-case calculations */
+#define LIBETH_MAX_HEADROOM	LIBETH_SKB_HEADROOM
+/* Link layer / L2 overhead: Ethernet, 2 VLAN tags (C + S), FCS */
+#define LIBETH_RX_LL_LEN	(ETH_HLEN + 2 * VLAN_HLEN + ETH_FCS_LEN)
+
+/* Always use order-0 pages */
+#define LIBETH_RX_PAGE_ORDER	0
+/* Pick a sane buffer stride and align to a cacheline boundary */
+#define LIBETH_RX_BUF_STRIDE	SKB_DATA_ALIGN(128)
+/* HW-writeable space in one buffer: truesize - headroom/tailroom, aligned */
+#define LIBETH_RX_PAGE_LEN(hr)						  \
+	ALIGN_DOWN(SKB_MAX_ORDER(hr, LIBETH_RX_PAGE_ORDER),		  \
+		   LIBETH_RX_BUF_STRIDE)
+
+/**
+ * struct libeth_fqe - structure representing an Rx buffer
+ * @page: page holding the buffer
+ * @offset: offset from the page start (to the headroom)
+ * @truesize: total space occupied by the buffer (w/ headroom and tailroom)
+ *
+ * Depending on the MTU, API switches between one-page-per-frame and shared
+ * page model (to conserve memory on bigger-page platforms). In case of the
+ * former, @offset is always 0 and @truesize is always ```PAGE_SIZE```.
+ */
+struct libeth_fqe {
+	struct page		*page;
+	u32			offset;
+	u32			truesize;
+} __aligned_largest;
+
+/**
+ * struct libeth_fq - structure representing a buffer queue
+ * @fp: hotpath part of the structure
+ * @pp: &page_pool for buffer management
+ * @fqes: array of Rx buffers
+ * @truesize: size to allocate per buffer, w/overhead
+ * @count: number of descriptors/buffers the queue has
+ * @rx_buf_len: HW-writeable length per each buffer
+ */
+struct libeth_fq {
+	struct_group_tagged(libeth_fq_fp, fp,
+		struct page_pool	*pp;
+		struct libeth_fqe	*fqes;
+
+		u32			truesize;
+		u32			count;
+	);
+
+	/* Cold fields */
+	u32			buf_len;
+};
+
+int libeth_rx_fq_create(struct libeth_fq *fq, struct napi_struct *napi);
+void libeth_rx_fq_destroy(struct libeth_fq *fq);
+
+/**
+ * libeth_rx_alloc - allocate a new Rx buffer
+ * @fq: buffer queue to allocate for
+ * @i: index of the buffer within the queue
+ *
+ * Return: DMA address to be passed to HW for Rx on successful allocation,
+ * ```DMA_MAPPING_ERROR``` otherwise.
+ */
+static inline dma_addr_t libeth_rx_alloc(const struct libeth_fq_fp *fq, u32 i)
+{
+	struct libeth_fqe *buf = &fq->fqes[i];
+
+	buf->truesize = fq->truesize;
+	buf->page = page_pool_dev_alloc(fq->pp, &buf->offset, &buf->truesize);
+	if (unlikely(!buf->page))
+		return DMA_MAPPING_ERROR;
+
+	return page_pool_get_dma_addr(buf->page) + buf->offset +
+	       fq->pp->p.offset;
+}
+
+void libeth_rx_recycle_slow(struct page *page);
+
+/**
+ * libeth_rx_sync_for_cpu - synchronize or recycle buffer post DMA
+ * @fqe: buffer to process
+ * @len: frame length from the descriptor
+ *
+ * Process the buffer after it's written by HW. The regular path is to
+ * synchronize DMA for CPU, but in case of no data it will be immediately
+ * recycled back to its PP.
+ *
+ * Return: true when there's data to process, false otherwise.
+ */
+static inline bool libeth_rx_sync_for_cpu(const struct libeth_fqe *fqe,
+					  u32 len)
+{
+	struct page *page = fqe->page;
+
+	/* Very rare, but possible case. The most common reason:
+	 * the last fragment contained FCS only, which was then
+	 * stripped by the HW.
+	 */
+	if (unlikely(!len)) {
+		libeth_rx_recycle_slow(page);
+		return false;
+	}
+
+	page_pool_dma_sync_for_cpu(page->pp, page, fqe->offset, len);
+
+	return true;
+}
+
 /* Converting abstract packet type numbers into a software structure with
  * the packet parameters to do O(1) lookup on Rx.
  */
diff --git a/drivers/net/ethernet/intel/libeth/rx.c b/drivers/net/ethernet/intel/libeth/rx.c
index 3fe14394c848..f7254c3c1834 100644
--- a/drivers/net/ethernet/intel/libeth/rx.c
+++ b/drivers/net/ethernet/intel/libeth/rx.c
@@ -3,6 +3,104 @@
 
 #include <net/libeth/rx.h>
 
+/* Rx buffer management */
+
+/**
+ * libeth_rx_hw_len - get the actual buffer size to be passed to HW
+ * @pp: &page_pool_params of the netdev to calculate the size for
+ * @max_len: maximum buffer size for a single descriptor
+ *
+ * Return: HW-writeable length per one buffer to pass it to the HW accounting:
+ * MTU the @dev has, HW required alignment, minimum and maximum allowed values,
+ * and system's page size.
+ */
+static u32 libeth_rx_hw_len(const struct page_pool_params *pp, u32 max_len)
+{
+	u32 len;
+
+	len = READ_ONCE(pp->netdev->mtu) + LIBETH_RX_LL_LEN;
+	len = ALIGN(len, LIBETH_RX_BUF_STRIDE);
+	len = min3(len, ALIGN_DOWN(max_len ? : U32_MAX, LIBETH_RX_BUF_STRIDE),
+		   pp->max_len);
+
+	return len;
+}
+
+/**
+ * libeth_rx_fqcreate - create a PP with the default libeth settings
+ * @fq: buffer queue struct to fill
+ * @napi: &napi_struct covering this PP (no usage outside its poll loops)
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int libeth_rx_fq_create(struct libeth_fq *fq, struct napi_struct *napi)
+{
+	struct page_pool_params pp = {
+		.flags		= PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
+		.order		= LIBETH_RX_PAGE_ORDER,
+		.pool_size	= fq->count,
+		.nid		= NUMA_NO_NODE,
+		.dev		= napi->dev->dev.parent,
+		.netdev		= napi->dev,
+		.napi		= napi,
+		.dma_dir	= DMA_FROM_DEVICE,
+		.offset		= LIBETH_SKB_HEADROOM,
+	};
+	struct libeth_fqe *fqes;
+	struct page_pool *pool;
+
+	/* HW-writeable / syncable length per one page */
+	pp.max_len = LIBETH_RX_PAGE_LEN(pp.offset);
+
+	/* HW-writeable length per buffer */
+	fq->buf_len = libeth_rx_hw_len(&pp, fq->buf_len);
+	/* Buffer size to allocate */
+	fq->truesize = roundup_pow_of_two(SKB_HEAD_ALIGN(pp.offset +
+							 fq->buf_len));
+
+	pool = page_pool_create(&pp);
+	if (IS_ERR(pool))
+		return PTR_ERR(pool);
+
+	fqes = kcalloc(fq->count, sizeof(*fqes), GFP_KERNEL);
+	if (!fqes)
+		goto err_buf;
+
+	fq->fqes = fqes;
+	fq->pp = pool;
+
+	return 0;
+
+err_buf:
+	page_pool_destroy(pool);
+
+	return -ENOMEM;
+}
+EXPORT_SYMBOL_NS_GPL(libeth_rx_fq_create, LIBETH);
+
+/**
+ * libeth_rx_fq_destroy - destroy a &page_pool created by libeth
+ * @fq: buffer queue to process
+ */
+void libeth_rx_fq_destroy(struct libeth_fq *fq)
+{
+	kfree(fq->fqes);
+	page_pool_destroy(fq->pp);
+}
+EXPORT_SYMBOL_NS_GPL(libeth_rx_fq_destroy, LIBETH);
+
+/**
+ * libeth_rx_recycle_slow - recycle a libeth page from the NAPI context
+ * @page: page to recycle
+ *
+ * To be used on exceptions or rare cases not requiring fast inline recycling.
+ */
+void libeth_rx_recycle_slow(struct page *page)
+{
+	page_pool_recycle_direct(page->pp, page);
+}
+EXPORT_SYMBOL_NS_GPL(libeth_rx_recycle_slow, LIBETH);
+
 /* Converting abstract packet type numbers into a software structure with
  * the packet parameters to do O(1) lookup on Rx.
  */
-- 
2.44.0


