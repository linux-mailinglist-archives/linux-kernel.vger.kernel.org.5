Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A01A7F784B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbjKXPvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345896AbjKXPud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:50:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032FC1FCA;
        Fri, 24 Nov 2023 07:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700841038; x=1732377038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XDLms+24rkKKggEqOaNesQfSKFp+BzRvfX3rpPYbCcI=;
  b=lR+JH0imIOvHjOz5QmfRM0gp9VzTsLKPKlGkFHeqWJFZz2I8dVuBs3E5
   yuEF+NeIEdDpTj8JSERvMwlC/Iuj9V46bL4mzVFHSytn34w7u7DLLztGH
   nqQdYWBADb7egsKlGs1Uc8B3FGlDcdHw7vX2nO0Q4inpijrR4RJJpULE+
   /HlxZDaEQfJbSzJ/CeuQt4lVA8IsRkoL+/iU2VnaDjvgPPd8B4TzsKPa/
   R3qRmfNKq5NhG9dAriP2/HUE2+oix46FAHiefJ2ipFYop+l6+2Iezt/8B
   qMHMwPCwWUVEGUCvSBaMPYEtyugGHlCS8w6U1CMgk+GTZL3UnNwu9nOIb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="389592578"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="389592578"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 07:50:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="15660196"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa001.jf.intel.com with ESMTP; 24 Nov 2023 07:50:34 -0800
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        David Christensen <drc@linux.vnet.ibm.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 09/14] libie: add Rx buffer management (via Page Pool)
Date:   Fri, 24 Nov 2023 16:47:27 +0100
Message-ID: <20231124154732.1623518-10-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231124154732.1623518-1-aleksander.lobakin@intel.com>
References: <20231124154732.1623518-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a couple intuitive helpers to hide Rx buffer implementation details
in the library and not multiplicate it between drivers. The settings are
optimized for Intel hardware, but nothing really HW-specific here.
Use the new page_pool_dev_alloc() to dynamically switch between
split-page and full-page modes depending on MTU, page size, required
headroom etc. For example, on x86_64 with the default driver settings
each page is shared between 2 buffers. Turning on XDP (not in this
series) -> increasing headroom requirement pushes truesize out of 2048
boundary, leading to that each buffer starts getting a full page.
The "ceiling" limit is %PAGE_SIZE, as only order-0 pages are used to
avoid compound overhead. For the above architecture, this means maximum
linear frame size of 3712 w/o XDP.
Not that &libie_rx_queue is not a complete queue/ring structure for now,
rather a shim, but eventually the libie-enabled drivers will move to it,
with iavf being the first one.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/libie/Kconfig |   1 +
 drivers/net/ethernet/intel/libie/rx.c    |  69 ++++++++++++
 include/linux/net/intel/libie/rx.h       | 132 ++++++++++++++++++++++-
 3 files changed, 201 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/libie/Kconfig b/drivers/net/ethernet/intel/libie/Kconfig
index 1eda4a5faa5a..6e0162fb94d2 100644
--- a/drivers/net/ethernet/intel/libie/Kconfig
+++ b/drivers/net/ethernet/intel/libie/Kconfig
@@ -3,6 +3,7 @@
 
 config LIBIE
 	tristate
+	select PAGE_POOL
 	help
 	  libie (Intel Ethernet library) is a common library containing
 	  routines shared between several Intel Ethernet drivers.
diff --git a/drivers/net/ethernet/intel/libie/rx.c b/drivers/net/ethernet/intel/libie/rx.c
index f503476d8eef..520a269f7d31 100644
--- a/drivers/net/ethernet/intel/libie/rx.c
+++ b/drivers/net/ethernet/intel/libie/rx.c
@@ -3,6 +3,75 @@
 
 #include <linux/net/intel/libie/rx.h>
 
+/* Rx buffer management */
+
+/**
+ * libie_rx_hw_len - get the actual buffer size to be passed to HW
+ * @dev: &net_device to calculate the size for
+ * @max_len: maximum length for the given page size
+ *
+ * Return: HW-writeable length per one buffer to pass it to the HW accounting:
+ * MTU the @dev has, HW required alignment, minimum and maximum allowed values,
+ * and system's page size.
+ */
+static u32 libie_rx_hw_len(const struct net_device *dev, u32 max_len)
+{
+	u32 len;
+
+	len = READ_ONCE(dev->mtu) + LIBIE_RX_LL_LEN;
+	len = ALIGN(len, LIBIE_RX_BUF_LEN_ALIGN);
+	len = clamp(len, LIBIE_MIN_RX_BUF_LEN, max_len);
+
+	return len;
+}
+
+/**
+ * libie_rx_page_pool_create - create a PP with the default libie settings
+ * @rq: Rx queue struct to fill
+ * @napi: &napi_struct covering this PP (no usage outside its poll loops)
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int libie_rx_page_pool_create(struct libie_rx_queue *rq,
+			      struct napi_struct *napi)
+{
+	struct page_pool_params pp = {
+		.flags		= PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
+		.order		= LIBIE_RX_PAGE_ORDER,
+		.pool_size	= rq->count,
+		.nid		= NUMA_NO_NODE,
+		.dev		= napi->dev->dev.parent,
+		.napi		= napi,
+		.dma_dir	= DMA_FROM_DEVICE,
+		.offset		= LIBIE_SKB_HEADROOM,
+	};
+
+	/* HW-writeable / syncable length per one page */
+	pp.max_len = LIBIE_RX_BUF_LEN(pp.offset);
+
+	/* HW-writeable length per buffer */
+	rq->rx_buf_len = libie_rx_hw_len(napi->dev, pp.max_len);
+	/* Buffer size to allocate */
+	rq->truesize = roundup_pow_of_two(SKB_HEAD_ALIGN(pp.offset +
+							 rq->rx_buf_len));
+
+	rq->pp = page_pool_create(&pp);
+
+	return PTR_ERR_OR_ZERO(rq->pp);
+}
+EXPORT_SYMBOL_NS_GPL(libie_rx_page_pool_create, LIBIE);
+
+/**
+ * libie_rx_page_pool_destroy - destroy a &page_pool created by libie
+ * @rq: receive queue to process
+ */
+void libie_rx_page_pool_destroy(struct libie_rx_queue *rq)
+{
+	page_pool_destroy(rq->pp);
+	rq->pp = NULL;
+}
+EXPORT_SYMBOL_NS_GPL(libie_rx_page_pool_destroy, LIBIE);
+
 /* O(1) converting i40e/ice/iavf's 8/10-bit hardware packet type to a parsed
  * bitfield struct.
  */
diff --git a/include/linux/net/intel/libie/rx.h b/include/linux/net/intel/libie/rx.h
index 55263930aa99..06c4f00dad63 100644
--- a/include/linux/net/intel/libie/rx.h
+++ b/include/linux/net/intel/libie/rx.h
@@ -4,7 +4,137 @@
 #ifndef __LIBIE_RX_H
 #define __LIBIE_RX_H
 
-#include <linux/netdevice.h>
+#include <linux/if_vlan.h>
+#include <net/page_pool/helpers.h>
+
+/* Rx MTU/buffer/truesize helpers. Mostly pure software-side; HW-defined values
+ * are valid for all Intel HW.
+ */
+
+/* Space reserved in front of each frame */
+#define LIBIE_SKB_HEADROOM	(NET_SKB_PAD + NET_IP_ALIGN)
+/* Maximum headroom to calculate max MTU below */
+#define LIBIE_MAX_HEADROOM	LIBIE_SKB_HEADROOM
+/* Link layer / L2 overhead: Ethernet, 2 VLAN tags (C + S), FCS */
+#define LIBIE_RX_LL_LEN		(ETH_HLEN + 2 * VLAN_HLEN + ETH_FCS_LEN)
+
+/* Always use order-0 pages */
+#define LIBIE_RX_PAGE_ORDER	0
+/* Rx buffer size config is a multiple of 128 */
+#define LIBIE_RX_BUF_LEN_ALIGN	128
+/* HW-writeable space in one buffer: truesize - headroom/tailroom,
+ * HW-aligned
+ */
+#define __LIBIE_RX_BUF_LEN(hr)						\
+	ALIGN_DOWN(SKB_MAX_ORDER(hr, LIBIE_RX_PAGE_ORDER),		\
+		   LIBIE_RX_BUF_LEN_ALIGN)
+/* The smallest and largest size for a single descriptor as per HW */
+#define LIBIE_MIN_RX_BUF_LEN	1024U
+#define LIBIE_MAX_RX_BUF_LEN	9728U
+/* "True" HW-writeable space: minimum from SW and HW values */
+#define LIBIE_RX_BUF_LEN(hr)	min_t(u32, __LIBIE_RX_BUF_LEN(hr),	\
+				      LIBIE_MAX_RX_BUF_LEN)
+
+/* The maximum frame size as per HW (S/G) */
+#define __LIBIE_MAX_RX_FRM_LEN	16382U
+/* ATST, HW can chain up to 5 Rx descriptors */
+#define LIBIE_MAX_RX_FRM_LEN(hr)					\
+	min_t(u32, __LIBIE_MAX_RX_FRM_LEN, LIBIE_RX_BUF_LEN(hr) * 5)
+/* Maximum frame size minus LL overhead */
+#define LIBIE_MAX_MTU							\
+	(LIBIE_MAX_RX_FRM_LEN(LIBIE_MAX_HEADROOM) - LIBIE_RX_LL_LEN)
+
+/* Rx buffer management */
+
+/**
+ * struct libie_rx_buffer - structure representing an Rx buffer
+ * @page: page holding the buffer
+ * @offset: offset from the page start (to the headroom)
+ * @truesize: total space occupied by the buffer (w/ headroom and tailroom)
+ *
+ * Depending on the MTU, API switches between one-page-per-frame and shared
+ * page model (to conserve memory on bigger-page platforms). In case of the
+ * former, @offset is always 0 and @truesize is always ```PAGE_SIZE```.
+ */
+struct libie_rx_buffer {
+	struct page		*page;
+	u32			offset;
+	u32			truesize;
+};
+
+/**
+ * struct libie_rx_queue - structure representing a receive queue
+ * @pp: &page_pool for buffer management
+ * @rx_bi: array of Rx buffers
+ * @truesize: size to allocate per buffer, w/overhead
+ * @count: number of descriptors/buffers the queue has
+ * @rx_buf_len: HW-writeable length per each buffer
+ */
+struct libie_rx_queue {
+	struct page_pool	*pp;
+	struct libie_rx_buffer	*rx_bi;
+
+	u32			truesize;
+	u32			count;
+
+	/* Cold fields */
+	u32			rx_buf_len;
+};
+
+int libie_rx_page_pool_create(struct libie_rx_queue *rq,
+			      struct napi_struct *napi);
+void libie_rx_page_pool_destroy(struct libie_rx_queue *rq);
+
+/**
+ * libie_rx_alloc - allocate a new Rx buffer
+ * @rq: receive queue to allocate for
+ * @i: index of the buffer within the queue
+ *
+ * Return: DMA address to be passed to HW for Rx on successful allocation,
+ * ```DMA_MAPPING_ERROR``` otherwise.
+ */
+static inline dma_addr_t libie_rx_alloc(const struct libie_rx_queue *rq, u32 i)
+{
+	struct libie_rx_buffer *buf = &rq->rx_bi[i];
+
+	buf->truesize = rq->truesize;
+	buf->page = page_pool_dev_alloc(rq->pp, &buf->offset, &buf->truesize);
+	if (unlikely(!buf->page))
+		return DMA_MAPPING_ERROR;
+
+	return page_pool_get_dma_addr(buf->page) + buf->offset +
+	       rq->pp->p.offset;
+}
+
+/**
+ * libie_rx_sync_for_cpu - synchronize or recycle buffer post DMA
+ * @buf: buffer to process
+ * @len: frame length from the descriptor
+ *
+ * Process the buffer after it's written by HW. The regular path is to
+ * synchronize DMA for CPU, but in case of no data it will be immediately
+ * recycled back to its PP.
+ *
+ * Return: true when there's data to process, false otherwise.
+ */
+static inline bool __must_check
+libie_rx_sync_for_cpu(const struct libie_rx_buffer *buf, u32 len)
+{
+	struct page *page = buf->page;
+
+	/* Very rare, but possible case. The most common reason:
+	 * the last fragment contained FCS only, which was then
+	 * stripped by the HW.
+	 */
+	if (unlikely(!len)) {
+		page_pool_recycle_direct(page->pp, page);
+		return false;
+	}
+
+	page_pool_dma_sync_for_cpu(page->pp, page, buf->offset, len);
+
+	return true;
+}
 
 /* O(1) converting i40e/ice/iavf's 8/10-bit hardware packet type to a parsed
  * bitfield struct.
-- 
2.42.0

