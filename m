Return-Path: <linux-kernel+bounces-10233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B98DC81D19F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70FC6285294
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFA828E34;
	Sat, 23 Dec 2023 02:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OS8gWTJo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310D728DDF;
	Sat, 23 Dec 2023 02:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703300349; x=1734836349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VNPt1nK0AOP2pNwVFe078A89NwhgBYFYVPqNFR4BfTE=;
  b=OS8gWTJoJJ0wBk47XVF5PlPL0QGjq/8FzWdu2YwytECsswF3/zbQ2rlU
   mciXwrChmCprP/re8dk51H6a6di8GEBbBC4uf+Wai4K0Fm2Y3t0/0I//a
   sJ4pgO1QRiio0z/b3uAuynWU4zzjk3WbB5w3bkE8hPiB5bZuyBloMvWdV
   cDH1bqFBIbt2gmPlPAbgbx8RoC4HulcR6XaUXnrnawyexHNSCjX2049eF
   Ua02gX7ROOL5ZpAabD0sKsf2I7eMwXYv+DVDwNW15XVAOcBLulfmf9NH1
   zsCCFXX25ryp2h+XNaBxVM2SvDe/qH2lE0Q9aJiQBSIpTqQS5XmfeoaP2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="386610936"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="386610936"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 18:59:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="25537535"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa001.jf.intel.com with ESMTP; 22 Dec 2023 18:59:05 -0800
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
Subject: [PATCH RFC net-next 17/34] libie: support native XDP and register memory model
Date: Sat, 23 Dec 2023 03:55:37 +0100
Message-ID: <20231223025554.2316836-18-aleksander.lobakin@intel.com>
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

Expand libie's Page Pool functionality by adding native XDP support.
This means picking the appropriate headroom and DMA direction.
Also, register all the created &page_pools as XDP memory models.
A driver then can call xdp_rxq_info_attach_page_pool() when registering
its RxQ info.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/libie/rx.c | 32 ++++++++++++++++++++++-----
 include/linux/net/intel/libie/rx.h    |  6 ++++-
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/libie/rx.c b/drivers/net/ethernet/intel/libie/rx.c
index 3d3b19d2b40d..b4c404958f25 100644
--- a/drivers/net/ethernet/intel/libie/rx.c
+++ b/drivers/net/ethernet/intel/libie/rx.c
@@ -52,7 +52,7 @@ static u32 libie_rx_hw_len_truesize(const struct page_pool_params *pp,
 static void libie_rx_page_pool_params(struct libie_buf_queue *bq,
 				      struct page_pool_params *pp)
 {
-	pp->offset = LIBIE_SKB_HEADROOM;
+	pp->offset = bq->xdp ? LIBIE_XDP_HEADROOM : LIBIE_SKB_HEADROOM;
 	/* HW-writeable / syncable length per one page */
 	pp->max_len = LIBIE_RX_BUF_LEN(pp->offset);
 
@@ -132,17 +132,34 @@ int libie_rx_page_pool_create(struct libie_buf_queue *bq,
 		.dev		= napi->dev->dev.parent,
 		.netdev		= napi->dev,
 		.napi		= napi,
-		.dma_dir	= DMA_FROM_DEVICE,
 	};
+	struct xdp_mem_info mem;
+	struct page_pool *pool;
+	int ret;
+
+	pp.dma_dir = bq->xdp ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE;
 
 	if (!bq->hsplit)
 		libie_rx_page_pool_params(bq, &pp);
 	else if (!libie_rx_page_pool_params_zc(bq, &pp))
 		return -EINVAL;
 
-	bq->pp = page_pool_create(&pp);
+	pool = page_pool_create(&pp);
+	if (IS_ERR(pool))
+		return PTR_ERR(pool);
+
+	ret = xdp_reg_mem_model(&mem, MEM_TYPE_PAGE_POOL, pool);
+	if (ret)
+		goto err_mem;
+
+	bq->pp = pool;
+
+	return 0;
 
-	return PTR_ERR_OR_ZERO(bq->pp);
+err_mem:
+	page_pool_destroy(pool);
+
+	return ret;
 }
 EXPORT_SYMBOL_NS_GPL(libie_rx_page_pool_create, LIBIE);
 
@@ -152,7 +169,12 @@ EXPORT_SYMBOL_NS_GPL(libie_rx_page_pool_create, LIBIE);
  */
 void libie_rx_page_pool_destroy(struct libie_buf_queue *bq)
 {
-	page_pool_destroy(bq->pp);
+	struct xdp_mem_info mem = {
+		.type	= MEM_TYPE_PAGE_POOL,
+		.id	= bq->pp->xdp_mem_id,
+	};
+
+	xdp_unreg_mem_model(&mem);
 	bq->pp = NULL;
 }
 EXPORT_SYMBOL_NS_GPL(libie_rx_page_pool_destroy, LIBIE);
diff --git a/include/linux/net/intel/libie/rx.h b/include/linux/net/intel/libie/rx.h
index 87ad8f9e89c7..8eda4ac8028c 100644
--- a/include/linux/net/intel/libie/rx.h
+++ b/include/linux/net/intel/libie/rx.h
@@ -15,8 +15,10 @@
 
 /* Space reserved in front of each frame */
 #define LIBIE_SKB_HEADROOM	(NET_SKB_PAD + NET_IP_ALIGN)
+#define LIBIE_XDP_HEADROOM	(ALIGN(XDP_PACKET_HEADROOM, NET_SKB_PAD) + \
+				 NET_IP_ALIGN)
 /* Maximum headroom to calculate max MTU below */
-#define LIBIE_MAX_HEADROOM	LIBIE_SKB_HEADROOM
+#define LIBIE_MAX_HEADROOM	LIBIE_XDP_HEADROOM
 /* Link layer / L2 overhead: Ethernet, 2 VLAN tags (C + S), FCS */
 #define LIBIE_RX_LL_LEN		(ETH_HLEN + 2 * VLAN_HLEN + ETH_FCS_LEN)
 /* Maximum supported L2-L4 header length */
@@ -87,6 +89,7 @@ enum libie_rx_buf_type {
  * @rx_buf_len: HW-writeable length per each buffer
  * @type: type of the buffers this queue has
  * @hsplit: flag whether header split is enabled
+ * @xdp: flag indicating whether XDP is enabled
  */
 struct libie_buf_queue {
 	struct page_pool	*pp;
@@ -100,6 +103,7 @@ struct libie_buf_queue {
 	enum libie_rx_buf_type	type:2;
 
 	bool			hsplit:1;
+	bool			xdp:1;
 };
 
 int libie_rx_page_pool_create(struct libie_buf_queue *bq,
-- 
2.43.0


