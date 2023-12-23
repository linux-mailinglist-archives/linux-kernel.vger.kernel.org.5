Return-Path: <linux-kernel+bounces-10223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EA581D18A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 583451C229E2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169C5EAD4;
	Sat, 23 Dec 2023 02:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gq0Wq8hP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15448DDDF;
	Sat, 23 Dec 2023 02:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703300311; x=1734836311;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XqjIg2sffZWYlV1QO3+27Gsdtu5ec4rZCM4Z9ujVexM=;
  b=Gq0Wq8hPNwO4dMOr0ywd0Lhmd5AjpYR+AVKnUjIPgSLQL7y7rqgTWtJx
   dpZRmPqXdD6gSmOZtlq98vVJHee05TM6zmIpi/kzthVD5BKGgGD4ooCBz
   LUcPLeFIBuI3KPnKSUHvJlVDka8eokOT+/AbFgLY7D0GOUmbxpyGu0GIs
   X+1++MweMMSuzrlMTlCJZJ17gnPuUFQg8qgmeAQ53j0ilzfT1J1Vs4HbE
   qI/RkZ3XeefoqrVcDRdtDpIg8LQZjNvCdiuDaPUgHMWS11qqFPVcWmK/z
   EqH3GNf8+/yaSslNgZTweWgyNBdSsw+TyVWlzBNPOMm91R/6RIJvz/8mk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="386610822"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="386610822"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 18:58:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="25537443"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa001.jf.intel.com with ESMTP; 22 Dec 2023 18:58:27 -0800
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
Subject: [PATCH RFC net-next 07/34] libie: add Tx buffer completion helpers
Date: Sat, 23 Dec 2023 03:55:27 +0100
Message-ID: <20231223025554.2316836-8-aleksander.lobakin@intel.com>
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

Software-side Tx buffers for storing DMA, frame size, skb pointers etc.
are pretty much generic and every driver defines them the same way. The
same can be said for software Tx completions -- same napi_consume_skb()s
and all that...
Add a couple simple wrappers for doing that to stop repeating the old
tale at least within the Intel code.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/net/intel/libie/tx.h | 88 ++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 include/linux/net/intel/libie/tx.h

diff --git a/include/linux/net/intel/libie/tx.h b/include/linux/net/intel/libie/tx.h
new file mode 100644
index 000000000000..07a19abb72fd
--- /dev/null
+++ b/include/linux/net/intel/libie/tx.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2023 Intel Corporation. */
+
+#ifndef __LIBIE_TX_H
+#define __LIBIE_TX_H
+
+#include <linux/net/intel/libie/stats.h>
+#include <linux/skbuff.h>
+
+/**
+ * enum libie_tx_buf_type - type of &libie_tx_buf to act on Tx completion
+ * @LIBIE_TX_BUF_EMPTY: unused OR XSk frame, no action required
+ * @LIBIE_TX_BUF_SLAB: kmalloc-allocated buffer, unmap and kfree()
+ * @LIBIE_TX_BUF_FRAG: mapped skb OR &xdp_buff frag, only unmap DMA
+ * @LIBIE_TX_BUF_SKB: &sk_buff, unmap and consume_skb(), update stats
+ * @LIBIE_TX_BUF_XDP_TX: &skb_shared_info, page_pool_put_full_page(), stats
+ * @LIBIE_TX_BUF_XDP_XMIT: &xdp_frame, unmap and xdp_return_frame(), stats
+ * @LIBIE_TX_BUF_XSK_TX: &xdp_buff on XSk queue, xsk_buff_free(), stats
+ */
+enum libie_tx_buf_type {
+	LIBIE_TX_BUF_EMPTY	= 0U,
+	LIBIE_TX_BUF_SLAB,
+	LIBIE_TX_BUF_FRAG,
+	LIBIE_TX_BUF_SKB,
+	LIBIE_TX_BUF_XDP_TX,
+	LIBIE_TX_BUF_XDP_XMIT,
+	LIBIE_TX_BUF_XSK_TX,
+};
+
+struct libie_tx_buffer {
+	void			*next_to_watch;
+	union {
+		void			*raw;
+		struct sk_buff		*skb;
+		struct skb_shared_info	*sinfo;
+		struct xdp_frame	*xdpf;
+		struct xdp_buff		*xdp;
+	};
+
+	DEFINE_DMA_UNMAP_ADDR(dma);
+	DEFINE_DMA_UNMAP_LEN(len);
+
+	u32			bytecount;
+	u16			gso_segs;
+	enum libie_tx_buf_type	type:16;
+
+	union {
+		int			compl_tag;
+		bool			ctx_entry;
+	};
+};
+
+static inline void libie_tx_complete_buf(struct libie_tx_buffer *buf,
+					 struct device *dev, bool napi,
+					 struct libie_sq_onstack_stats *ss)
+{
+	switch (buf->type) {
+	case LIBIE_TX_BUF_EMPTY:
+		return;
+	case LIBIE_TX_BUF_SLAB:
+	case LIBIE_TX_BUF_FRAG:
+	case LIBIE_TX_BUF_SKB:
+		dma_unmap_page(dev, dma_unmap_addr(buf, dma),
+			       dma_unmap_len(buf, len),
+			       DMA_TO_DEVICE);
+		break;
+	default:
+		break;
+	}
+
+	switch (buf->type) {
+	case LIBIE_TX_BUF_SLAB:
+		kfree(buf->raw);
+		break;
+	case LIBIE_TX_BUF_SKB:
+		ss->packets += buf->gso_segs;
+		ss->bytes += buf->bytecount;
+
+		napi_consume_skb(buf->skb, napi);
+		break;
+	default:
+		break;
+	}
+
+	buf->type = LIBIE_TX_BUF_EMPTY;
+}
+
+#endif /* __LIBIE_TX_H */
-- 
2.43.0


