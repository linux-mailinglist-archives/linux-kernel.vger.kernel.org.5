Return-Path: <linux-kernel+bounces-10234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E128981D1A1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267EA1F24071
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3B928DDF;
	Sat, 23 Dec 2023 02:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mQNloKwP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947EC2C843;
	Sat, 23 Dec 2023 02:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703300354; x=1734836354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8mjt8uDT2YTuKI2B5BvmsRyZnUjtDOJ0AkwsU1g4zI8=;
  b=mQNloKwP/bBj6FV4ITROTJ+QfUZwFzH0Q1hGHkOIZHnrtra+GVlhjvMJ
   /mSEZdTqCzQeFq+ZSIUG8/9tdBmryuF2aNmJa/hVhNQaDmrLngFiXbsgb
   vCkGPWN6tdhxeBUakRjyVF8eG0+togLyYSbHFNEbJAuY8ATIY8NjX/tpO
   Fa5yQ/2mgZ7wKmexnQXOvx/+rNKbHRvF82g0yus70TtH8MPiNUFissdw0
   E0zbszkjDTbd3MrOGPAwWDmdwKOpQYkyiTdzvRFvZ/kZBcWyLmSW+vMLf
   xuMuMN/GaFwwgrRO2Ve+Cl4WOPUW8sq5MuO9/Wln1GTypBILhB2ScDTeG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="386610967"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="386610967"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 18:59:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="25537553"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa001.jf.intel.com with ESMTP; 22 Dec 2023 18:59:10 -0800
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
Subject: [PATCH RFC net-next 18/34] libie: add a couple of XDP helpers
Date: Sat, 23 Dec 2023 03:55:38 +0100
Message-ID: <20231223025554.2316836-19-aleksander.lobakin@intel.com>
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

"Couple" is a bit humbly... Add the following functionality to libie:

* XDP shared queues managing
* XDP_TX bulk sending infra
* .ndo_xdp_xmit() infra
* adding buffers to &xdp_buff
* running XDP prog and managing its verdict
* completing XDP Tx buffers
* ^ repeat everything for XSk

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/libie/Makefile |   3 +
 drivers/net/ethernet/intel/libie/tx.c     |  16 +
 drivers/net/ethernet/intel/libie/xdp.c    |  50 ++
 drivers/net/ethernet/intel/libie/xsk.c    |  49 ++
 include/linux/net/intel/libie/tx.h        |   6 +
 include/linux/net/intel/libie/xdp.h       | 586 ++++++++++++++++++++++
 include/linux/net/intel/libie/xsk.h       | 172 +++++++
 7 files changed, 882 insertions(+)
 create mode 100644 drivers/net/ethernet/intel/libie/tx.c
 create mode 100644 drivers/net/ethernet/intel/libie/xdp.c
 create mode 100644 drivers/net/ethernet/intel/libie/xsk.c
 create mode 100644 include/linux/net/intel/libie/xdp.h
 create mode 100644 include/linux/net/intel/libie/xsk.h

diff --git a/drivers/net/ethernet/intel/libie/Makefile b/drivers/net/ethernet/intel/libie/Makefile
index 76f32253481b..7ca353e4ecdf 100644
--- a/drivers/net/ethernet/intel/libie/Makefile
+++ b/drivers/net/ethernet/intel/libie/Makefile
@@ -5,3 +5,6 @@ obj-$(CONFIG_LIBIE)	+= libie.o
 
 libie-objs		+= rx.o
 libie-objs		+= stats.o
+libie-objs		+= tx.o
+libie-objs		+= xdp.o
+libie-objs		+= xsk.o
diff --git a/drivers/net/ethernet/intel/libie/tx.c b/drivers/net/ethernet/intel/libie/tx.c
new file mode 100644
index 000000000000..9e3b6e3c3c25
--- /dev/null
+++ b/drivers/net/ethernet/intel/libie/tx.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation. */
+
+#include <linux/net/intel/libie/xdp.h>
+
+void libie_tx_complete_any(struct libie_tx_buffer *buf, struct device *dev,
+			   struct xdp_frame_bulk *bq, u32 *xdp_tx_active,
+			   struct libie_sq_onstack_stats *ss)
+{
+	if (buf->type > LIBIE_TX_BUF_SKB)
+		libie_xdp_complete_tx_buf(buf, dev, false, bq, xdp_tx_active,
+					  ss);
+	else
+		libie_tx_complete_buf(buf, dev, false, ss);
+}
+EXPORT_SYMBOL_NS_GPL(libie_tx_complete_any, LIBIE);
diff --git a/drivers/net/ethernet/intel/libie/xdp.c b/drivers/net/ethernet/intel/libie/xdp.c
new file mode 100644
index 000000000000..f47a17ca6e66
--- /dev/null
+++ b/drivers/net/ethernet/intel/libie/xdp.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation. */
+
+#include <linux/net/intel/libie/xdp.h>
+
+/* XDP SQ sharing */
+
+DEFINE_STATIC_KEY_FALSE(libie_xdp_sq_share);
+EXPORT_SYMBOL_NS_GPL(libie_xdp_sq_share, LIBIE);
+
+void __libie_xdp_sq_get(struct libie_xdp_sq_lock *lock,
+			const struct net_device *dev)
+{
+	bool warn;
+
+	spin_lock_init(&lock->lock);
+	lock->share = true;
+
+	warn = !static_key_enabled(&libie_xdp_sq_share);
+	static_branch_inc_cpuslocked(&libie_xdp_sq_share);
+
+	if (warn)
+		netdev_warn(dev, "XDP SQ sharing enabled, possible XDP_TX/XDP_REDIRECT slowdown\n");
+
+}
+EXPORT_SYMBOL_NS_GPL(__libie_xdp_sq_get, LIBIE);
+
+void __libie_xdp_sq_put(struct libie_xdp_sq_lock *lock,
+			const struct net_device *dev)
+{
+	static_branch_dec_cpuslocked(&libie_xdp_sq_share);
+
+	if (!static_key_enabled(&libie_xdp_sq_share))
+		netdev_notice(dev, "XDP SQ sharing disabled\n");
+
+	lock->share = false;
+}
+EXPORT_SYMBOL_NS_GPL(__libie_xdp_sq_put, LIBIE);
+
+/* ``XDP_TX`` bulking */
+
+void libie_xdp_tx_return_bulk(const struct libie_xdp_tx_frame *bq, u32 count)
+{
+	for (u32 i = 0; i < count; i++) {
+		struct page *page = virt_to_page(bq[i].data);
+
+		page_pool_recycle_direct(page->pp, page);
+	}
+}
+EXPORT_SYMBOL_NS_GPL(libie_xdp_tx_return_bulk, LIBIE);
diff --git a/drivers/net/ethernet/intel/libie/xsk.c b/drivers/net/ethernet/intel/libie/xsk.c
new file mode 100644
index 000000000000..ffbdb85586f1
--- /dev/null
+++ b/drivers/net/ethernet/intel/libie/xsk.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation. */
+
+#include <linux/net/intel/libie/xsk.h>
+
+#define LIBIE_XSK_DMA_ATTR	(DMA_ATTR_WEAK_ORDERING |	\
+				 DMA_ATTR_SKIP_CPU_SYNC)
+
+int libie_xsk_enable_pool(struct net_device *dev, u32 qid, unsigned long *map)
+{
+	struct xsk_buff_pool *pool;
+	int ret;
+
+	if (qid >= min(dev->real_num_rx_queues, dev->real_num_tx_queues))
+		return -EINVAL;
+
+	pool = xsk_get_pool_from_qid(dev, qid);
+	if (!pool)
+		return -EINVAL;
+
+	ret = xsk_pool_dma_map(pool, dev->dev.parent, LIBIE_XSK_DMA_ATTR);
+	if (ret)
+		return ret;
+
+	set_bit(qid, map);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(libie_xsk_enable_pool, LIBIE);
+
+int libie_xsk_disable_pool(struct net_device *dev, u32 qid,
+			   unsigned long *map)
+{
+	struct xsk_buff_pool *pool;
+
+	if (qid >= min(dev->real_num_rx_queues, dev->real_num_tx_queues))
+		return -EINVAL;
+
+	pool = xsk_get_pool_from_qid(dev, qid);
+	if (!pool)
+		return -EINVAL;
+
+	xsk_pool_dma_unmap(pool, LIBIE_XSK_DMA_ATTR);
+
+	clear_bit(qid, map);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(libie_xsk_disable_pool, LIBIE);
diff --git a/include/linux/net/intel/libie/tx.h b/include/linux/net/intel/libie/tx.h
index 07a19abb72fd..4d4d85af6f7e 100644
--- a/include/linux/net/intel/libie/tx.h
+++ b/include/linux/net/intel/libie/tx.h
@@ -85,4 +85,10 @@ static inline void libie_tx_complete_buf(struct libie_tx_buffer *buf,
 	buf->type = LIBIE_TX_BUF_EMPTY;
 }
 
+struct xdp_frame_bulk;
+
+void libie_tx_complete_any(struct libie_tx_buffer *buf, struct device *dev,
+			   struct xdp_frame_bulk *bq, u32 *xdp_tx_active,
+			   struct libie_sq_onstack_stats *ss);
+
 #endif /* __LIBIE_TX_H */
diff --git a/include/linux/net/intel/libie/xdp.h b/include/linux/net/intel/libie/xdp.h
new file mode 100644
index 000000000000..087fc075078f
--- /dev/null
+++ b/include/linux/net/intel/libie/xdp.h
@@ -0,0 +1,586 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2023 Intel Corporation. */
+
+#ifndef __LIBIE_XDP_H
+#define __LIBIE_XDP_H
+
+#include <linux/bpf_trace.h>
+#include <linux/net/intel/libie/rx.h>
+#include <linux/net/intel/libie/tx.h>
+
+#include <net/xdp_sock_drv.h>
+
+/* Defined as bits to be able to use them as a mask */
+enum {
+	LIBIE_XDP_PASS			= 0U,
+	LIBIE_XDP_DROP			= BIT(0),
+	LIBIE_XDP_ABORTED		= BIT(1),
+	LIBIE_XDP_TX			= BIT(2),
+	LIBIE_XDP_REDIRECT		= BIT(3),
+};
+
+/* XDP SQ sharing */
+
+struct libie_xdp_sq_lock {
+	spinlock_t			lock;
+	bool				share;
+};
+
+DECLARE_STATIC_KEY_FALSE(libie_xdp_sq_share);
+
+static inline u32 libie_xdp_get_sq_num(u32 rxq, u32 txq, u32 max)
+{
+	return min(max(nr_cpu_ids, rxq), max - txq);
+}
+
+static inline bool libie_xdp_sq_shared(u32 qid)
+{
+	return qid < nr_cpu_ids;
+}
+
+static inline u32 libie_xdp_sq_id(u32 num)
+{
+	u32 ret = smp_processor_id();
+
+	if (static_branch_unlikely(&libie_xdp_sq_share) &&
+	    libie_xdp_sq_shared(num))
+		ret %= num;
+
+	return ret;
+}
+
+void __libie_xdp_sq_get(struct libie_xdp_sq_lock *lock,
+			const struct net_device *dev);
+void __libie_xdp_sq_put(struct libie_xdp_sq_lock *lock,
+			const struct net_device *dev);
+
+static inline void libie_xdp_sq_get(struct libie_xdp_sq_lock *lock,
+				    const struct net_device *dev,
+				    bool share)
+{
+	if (unlikely(share))
+		__libie_xdp_sq_get(lock, dev);
+}
+
+static inline void libie_xdp_sq_put(struct libie_xdp_sq_lock *lock,
+				    const struct net_device *dev)
+{
+	if (static_branch_unlikely(&libie_xdp_sq_share) && lock->share)
+		__libie_xdp_sq_put(lock, dev);
+}
+
+static inline void __acquires(&lock->lock)
+libie_xdp_sq_lock(struct libie_xdp_sq_lock *lock)
+{
+	if (static_branch_unlikely(&libie_xdp_sq_share) && lock->share)
+		spin_lock(&lock->lock);
+}
+
+static inline void __releases(&lock->lock)
+libie_xdp_sq_unlock(struct libie_xdp_sq_lock *lock)
+{
+	if (static_branch_unlikely(&libie_xdp_sq_share) && lock->share)
+		spin_unlock(&lock->lock);
+}
+
+/* ``XDP_TX`` bulking */
+
+#define LIBIE_XDP_TX_BULK		XDP_BULK_QUEUE_SIZE
+#define LIBIE_XDP_TX_BATCH		8
+
+#ifdef __clang__
+#define libie_xdp_tx_for		_Pragma("clang loop unroll_count(8)") for
+#elif __GNUC__ >= 8
+#define libie_xdp_tx_for		_Pragma("GCC unroll (8)") for
+#else
+#define libie_xdp_tx_for		for
+#endif
+
+struct libie_xdp_tx_frame {
+	union {
+		struct {
+			void				*data;
+			u16				len;
+
+			enum xdp_buff_flags		flags:16;
+			u32				soff;
+		};
+		struct {
+			struct xdp_frame		*xdpf;
+			dma_addr_t			dma;
+		};
+
+		struct {
+			struct xdp_buff			*xsk;
+			/* u32				len */
+		};
+		struct xdp_desc				desc;
+	};
+};
+static_assert(sizeof(struct libie_xdp_tx_frame) == sizeof(struct xdp_desc));
+
+struct libie_xdp_tx_bulk {
+	const struct bpf_prog		*prog;
+	struct net_device		*dev;
+	void				*xdpq;
+
+	u32				act_mask;
+	u32				count;
+	struct libie_xdp_tx_frame	bulk[LIBIE_XDP_TX_BULK];
+};
+
+
+struct libie_xdp_tx_queue {
+	union {
+		struct device			*dev;
+		struct xsk_buff_pool		*pool;
+	};
+	struct libie_tx_buffer		*tx_buf;
+	void				*desc_ring;
+
+	struct libie_xdp_sq_lock	*xdp_lock;
+	u16				*next_to_use;
+	u32				desc_count;
+
+	u32				*xdp_tx_active;
+};
+
+struct libie_xdp_tx_desc {
+	dma_addr_t			addr;
+	u32				len;
+};
+
+static inline void __libie_xdp_tx_init_bulk(struct libie_xdp_tx_bulk *bq,
+					    const struct bpf_prog *prog,
+					    struct net_device *dev, void *xdpq)
+{
+	bq->prog = prog;
+	bq->dev = dev;
+	bq->xdpq = xdpq;
+
+	bq->act_mask = 0;
+	bq->count = 0;
+}
+
+#define _libie_xdp_tx_init_bulk(bq, prog, dev, xdpqs, num, uniq) ({	 \
+	const struct bpf_prog *uniq = rcu_dereference(prog);		 \
+									 \
+	if (uniq)							 \
+		__libie_xdp_tx_init_bulk(bq, uniq, dev,			 \
+					 (xdpqs)[libie_xdp_sq_id(num)]); \
+})
+
+#define libie_xdp_tx_init_bulk(bq, prog, dev, xdpqs, num)		 \
+	_libie_xdp_tx_init_bulk(bq, prog, dev, xdpqs, num,		 \
+				__UNIQUE_ID(prog_))
+
+static inline void libie_xdp_tx_queue_bulk(struct libie_xdp_tx_bulk *bq,
+					   const struct xdp_buff *xdp)
+{
+	bq->bulk[bq->count++] = (typeof(*bq->bulk)){
+		.data	= xdp->data,
+		.len	= xdp->data_end - xdp->data,
+		.soff	= xdp_data_hard_end(xdp) - xdp->data,
+		.flags	= xdp->flags,
+	};
+}
+
+static inline struct libie_xdp_tx_desc
+libie_xdp_tx_fill_buf(const struct libie_xdp_tx_frame *frm,
+		      const struct libie_xdp_tx_queue *sq)
+{
+	struct libie_xdp_tx_desc desc = {
+		.len	= frm->len,
+	};
+	struct libie_tx_buffer *tx_buf;
+
+	desc.addr = page_pool_dma_sync_va_for_device(frm->data, desc.len);
+
+	tx_buf = &sq->tx_buf[*sq->next_to_use];
+	tx_buf->type = LIBIE_TX_BUF_XDP_TX;
+	tx_buf->gso_segs = 1;
+	tx_buf->bytecount = desc.len;
+	tx_buf->sinfo = frm->data + frm->soff;
+
+	return desc;
+}
+
+static __always_inline u32
+libie_xdp_tx_xmit_bulk(const struct libie_xdp_tx_bulk *bq,
+		       u32 (*prep)(void *xdpq, struct libie_xdp_tx_queue *sq),
+		       struct libie_xdp_tx_desc
+		       (*fill)(const struct libie_xdp_tx_frame *frm,
+			       const struct libie_xdp_tx_queue *sq),
+		       void (*xmit)(struct libie_xdp_tx_desc desc,
+				    const struct libie_xdp_tx_queue *sq))
+{
+	u32 this, batched, leftover, off = 0;
+	struct libie_xdp_tx_queue sq;
+	u32 free, count, ntu, i = 0;
+
+	free = prep(bq->xdpq, &sq);
+	count = min3(bq->count, free, LIBIE_XDP_TX_BULK);
+	ntu = *sq.next_to_use;
+
+again:
+	this = sq.desc_count - ntu;
+	if (likely(this > count))
+		this = count;
+
+	batched = ALIGN_DOWN(this, LIBIE_XDP_TX_BATCH);
+	leftover = this - batched;
+
+	for ( ; i < off + batched; i += LIBIE_XDP_TX_BATCH) {
+		libie_xdp_tx_for (u32 j = 0; j < LIBIE_XDP_TX_BATCH; j++) {
+			struct libie_xdp_tx_desc desc;
+
+			desc = fill(&bq->bulk[i + j], &sq);
+			xmit(desc, &sq);
+
+			ntu++;
+		}
+	}
+
+	for ( ; i < off + batched + leftover; i++) {
+		struct libie_xdp_tx_desc desc;
+
+		desc = fill(&bq->bulk[i], &sq);
+		xmit(desc, &sq);
+
+		ntu++;
+	}
+
+	if (likely(ntu < sq.desc_count))
+		goto out;
+
+	ntu = 0;
+
+	count -= this;
+	if (count) {
+		off = i;
+		goto again;
+	}
+
+out:
+	*sq.next_to_use = ntu;
+	if (sq.xdp_tx_active)
+		*sq.xdp_tx_active += i;
+
+	libie_xdp_sq_unlock(sq.xdp_lock);
+
+	return i;
+}
+
+void libie_xdp_tx_return_bulk(const struct libie_xdp_tx_frame *bq, u32 count);
+
+static __always_inline bool
+__libie_xdp_tx_flush_bulk(struct libie_xdp_tx_bulk *bq,
+			  u32 (*prep)(void *xdpq,
+			  	      struct libie_xdp_tx_queue *sq),
+			  struct libie_xdp_tx_desc
+			  (*fill)(const struct libie_xdp_tx_frame *frm,
+				  const struct libie_xdp_tx_queue *sq),
+			  void (*xmit)(struct libie_xdp_tx_desc desc,
+				       const struct libie_xdp_tx_queue *sq))
+{
+	u32 sent, drops;
+	int err = 0;
+
+	sent = libie_xdp_tx_xmit_bulk(bq, prep, fill, xmit);
+	drops = bq->count - sent;
+	bq->count = 0;
+
+	if (unlikely(drops)) {
+		trace_xdp_exception(bq->dev, bq->prog, XDP_TX);
+		err = -ENXIO;
+
+		libie_xdp_tx_return_bulk(&bq->bulk[sent], drops);
+	}
+
+	trace_xdp_bulk_tx(bq->dev, sent, drops, err);
+
+	return likely(sent);
+}
+
+#define libie_xdp_tx_flush_bulk(bq, prep, xmit)				 \
+	__libie_xdp_tx_flush_bulk(bq, prep, libie_xdp_tx_fill_buf, xmit)
+
+/* .ndo_xdp_xmit() implementation */
+
+static inline bool libie_xdp_xmit_queue_bulk(struct libie_xdp_tx_bulk *bq,
+					     struct xdp_frame *xdpf)
+{
+	struct device *dev = bq->dev->dev.parent;
+	dma_addr_t dma;
+
+	dma = dma_map_single(dev, xdpf->data, xdpf->len, DMA_TO_DEVICE);
+	if (dma_mapping_error(dev, dma))
+		return false;
+
+	bq->bulk[bq->count++] = (typeof(*bq->bulk)){
+		.xdpf		= xdpf,
+		.dma		= dma,
+	};
+
+	return true;
+}
+
+static inline struct libie_xdp_tx_desc
+libie_xdp_xmit_fill_buf(const struct libie_xdp_tx_frame *frm,
+			const struct libie_xdp_tx_queue *sq)
+{
+	struct xdp_frame *xdpf = frm->xdpf;
+	struct libie_xdp_tx_desc desc = {
+		.addr	= frm->dma,
+		.len	= xdpf->len,
+	};
+	struct libie_tx_buffer *tx_buf;
+
+	tx_buf = &sq->tx_buf[*sq->next_to_use];
+	tx_buf->type = LIBIE_TX_BUF_XDP_XMIT;
+	tx_buf->gso_segs = 1;
+	tx_buf->bytecount = desc.len;
+	tx_buf->xdpf = xdpf;
+
+	dma_unmap_addr_set(tx_buf, dma, frm->dma);
+	dma_unmap_len_set(tx_buf, len, desc.len);
+
+	return desc;
+}
+
+static __always_inline int
+__libie_xdp_xmit_do_bulk(struct libie_xdp_tx_bulk *bq,
+			 struct xdp_frame **frames, u32 n, u32 flags,
+			 u32 (*prep)(void *xdpq,
+				     struct libie_xdp_tx_queue *sq),
+			 void (*xmit)(struct libie_xdp_tx_desc desc,
+				      const struct libie_xdp_tx_queue *sq),
+			 void (*finalize)(void *xdpq, bool tail))
+{
+	int err = -ENXIO;
+	u32 nxmit = 0;
+
+	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
+		return -EINVAL;
+
+	for (u32 i = 0; i < n; i++) {
+		if (!libie_xdp_xmit_queue_bulk(bq, frames[i]))
+			break;
+	}
+
+	if (unlikely(!bq->count))
+		goto out;
+
+	nxmit = libie_xdp_tx_xmit_bulk(bq, prep, libie_xdp_xmit_fill_buf,
+				       xmit);
+	if (unlikely(!nxmit))
+		goto out;
+
+	finalize(bq->xdpq, flags & XDP_XMIT_FLUSH);
+
+	if (likely(nxmit == n))
+		err = 0;
+
+out:
+	trace_xdp_bulk_tx(bq->dev, nxmit, n - nxmit, err);
+
+	return nxmit;
+}
+
+#define libie_xdp_xmit_init_bulk(bq, dev, xdpqs, num)			      \
+	__libie_xdp_tx_init_bulk(bq, NULL, dev,				      \
+				 (xdpqs)[libie_xdp_sq_id(num)])
+
+#define _libie_xdp_xmit_do_bulk(dev, n, fr, fl, xqs, nqs, pr, xm, fin, un) ({ \
+	struct libie_xdp_tx_bulk un;					      \
+									      \
+	libie_xdp_xmit_init_bulk(&un, dev, xqs, nqs);			      \
+	__libie_xdp_xmit_do_bulk(&un, fr, n, fl, pr, xm, fin);		      \
+})
+#define libie_xdp_xmit_do_bulk(dev, n, fr, fl, xqs, nqs, pr, xm, fin)	      \
+	_libie_xdp_xmit_do_bulk(dev, n, fr, fl, xqs, nqs, pr, xm, fin,	      \
+				__UNIQUE_ID(bq_))
+
+/* Rx polling path */
+
+static inline void libie_xdp_init_buff(struct xdp_buff *dst,
+				       const struct xdp_buff *src,
+				       struct xdp_rxq_info *rxq)
+{
+	if (!src->data) {
+		dst->data = NULL;
+		dst->rxq = rxq;
+	} else {
+		*dst = *src;
+	}
+}
+
+#define libie_xdp_save_buff(dst, src)	libie_xdp_init_buff(dst, src, NULL)
+
+/**
+ * libie_xdp_process_buff - process an Rx buffer
+ * @xdp: XDP buffer to attach the buffer to
+ * @buf: Rx buffer to process
+ * @len: received data length from the descriptor
+ *
+ * Return: false if the descriptor must be skipped, true otherwise.
+ */
+static inline bool libie_xdp_process_buff(struct xdp_buff *xdp,
+					  const struct libie_rx_buffer *buf,
+					  u32 len)
+{
+	if (!libie_rx_sync_for_cpu(buf, len))
+		return false;
+
+	if (!xdp->data) {
+		xdp->flags = 0;
+		xdp->frame_sz = buf->truesize;
+
+		xdp_prepare_buff(xdp, page_address(buf->page) + buf->offset,
+				 buf->page->pp->p.offset, len, true);
+	} else if (!xdp_buff_add_frag(xdp, buf->page,
+				      buf->offset + buf->page->pp->p.offset,
+				      len, buf->truesize)) {
+		xdp_return_buff(xdp);
+		xdp->data = NULL;
+
+		return false;
+	}
+
+	return true;
+}
+
+/**
+ * __libie_xdp_run_prog - run XDP program on an XDP buffer
+ * @xdp: XDP buffer to run the prog on
+ * @bq: buffer bulk for ``XDP_TX`` queueing
+ *
+ * Return: LIBIE_XDP_{PASS,DROP,TX,REDIRECT} depending on the prog's verdict.
+ */
+static inline u32 __libie_xdp_run_prog(struct xdp_buff *xdp,
+				       struct libie_xdp_tx_bulk *bq)
+{
+	const struct bpf_prog *prog = bq->prog;
+	u32 act;
+
+	act = bpf_prog_run_xdp(prog, xdp);
+	switch (act) {
+	case XDP_ABORTED:
+err:
+		trace_xdp_exception(bq->dev, prog, act);
+		fallthrough;
+	case XDP_DROP:
+		xdp_return_buff(xdp);
+		xdp->data = NULL;
+
+		return LIBIE_XDP_DROP;
+	case XDP_PASS:
+		return LIBIE_XDP_PASS;
+	case XDP_TX:
+		libie_xdp_tx_queue_bulk(bq, xdp);
+		xdp->data = NULL;
+
+		return LIBIE_XDP_TX;
+	case XDP_REDIRECT:
+		if (unlikely(xdp_do_redirect(bq->dev, xdp, prog)))
+			goto err;
+
+		xdp->data = NULL;
+
+		return LIBIE_XDP_REDIRECT;
+	default:
+		bpf_warn_invalid_xdp_action(bq->dev, prog, act);
+		goto err;
+	}
+}
+
+static __always_inline u32
+__libie_xdp_run_flush(struct xdp_buff *xdp, struct libie_xdp_tx_bulk *bq,
+		      u32 (*run)(struct xdp_buff *xdp,
+				 struct libie_xdp_tx_bulk *bq),
+		      bool (*flush_bulk)(struct libie_xdp_tx_bulk *))
+{
+	u32 act;
+
+	act = run(xdp, bq);
+	if (act == LIBIE_XDP_TX &&
+	    unlikely(bq->count == LIBIE_XDP_TX_BULK && !flush_bulk(bq)))
+		act = LIBIE_XDP_DROP;
+
+	bq->act_mask |= act;
+
+	return act;
+}
+
+#define libie_xdp_run_prog(xdp, bq, fl)					\
+	(__libie_xdp_run_flush(xdp, bq, __libie_xdp_run_prog, fl) ==	\
+	 XDP_PASS)
+
+static __always_inline void
+libie_xdp_finalize_rx(struct libie_xdp_tx_bulk *bq,
+		      bool (*flush_bulk)(struct libie_xdp_tx_bulk *),
+		      void (*finalize)(void *xdpq, bool tail))
+{
+	if (bq->act_mask & LIBIE_XDP_TX) {
+		if (bq->count)
+			flush_bulk(bq);
+		finalize(bq->xdpq, true);
+	}
+	if (bq->act_mask & LIBIE_XDP_REDIRECT)
+		xdp_do_flush();
+}
+
+/* Tx buffer completion */
+
+static inline void libie_xdp_return_sinfo(const struct libie_tx_buffer *buf,
+					  bool napi)
+{
+	const struct skb_shared_info *sinfo = buf->sinfo;
+	struct page *page;
+
+	if (likely(buf->gso_segs == 1))
+		goto return_head;
+
+	for (u32 i = 0; i < sinfo->nr_frags; i++) {
+		page = skb_frag_page(&sinfo->frags[i]);
+		page_pool_put_full_page(page->pp, page, napi);
+	}
+
+return_head:
+	page = virt_to_page(sinfo);
+	page_pool_put_full_page(page->pp, page, napi);
+}
+
+static inline void libie_xdp_complete_tx_buf(struct libie_tx_buffer *buf,
+					     struct device *dev, bool napi,
+					     struct xdp_frame_bulk *bq,
+					     u32 *xdp_tx_active,
+					     struct libie_sq_onstack_stats *ss)
+{
+	switch (buf->type) {
+	case LIBIE_TX_BUF_EMPTY:
+		return;
+	case LIBIE_TX_BUF_XDP_TX:
+		libie_xdp_return_sinfo(buf, napi);
+		break;
+	case LIBIE_TX_BUF_XDP_XMIT:
+		dma_unmap_page(dev, dma_unmap_addr(buf, dma),
+			       dma_unmap_len(buf, len), DMA_TO_DEVICE);
+		xdp_return_frame_bulk(buf->xdpf, bq);
+		break;
+	case LIBIE_TX_BUF_XSK_TX:
+		xsk_buff_free(buf->xdp);
+		break;
+	default:
+		break;
+	}
+
+	(*xdp_tx_active)--;
+
+	ss->packets += buf->gso_segs;
+	ss->bytes += buf->bytecount;
+
+	buf->type = LIBIE_TX_BUF_EMPTY;
+}
+
+#endif /* __LIBIE_XDP_H */
diff --git a/include/linux/net/intel/libie/xsk.h b/include/linux/net/intel/libie/xsk.h
new file mode 100644
index 000000000000..d21fdb69a5e0
--- /dev/null
+++ b/include/linux/net/intel/libie/xsk.h
@@ -0,0 +1,172 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2023 Intel Corporation. */
+
+#ifndef __LIBIE_XSK_H
+#define __LIBIE_XSK_H
+
+#include <linux/net/intel/libie/xdp.h>
+
+/* ``XDP_TX`` bulking */
+
+#define libie_xsk_tx_init_bulk(bq, prog, dev, xdpqs, num)		\
+	__libie_xdp_tx_init_bulk(bq, rcu_dereference(prog), dev,	\
+				 (xdpqs)[libie_xdp_sq_id(num)])
+
+static inline void libie_xsk_tx_queue_bulk(struct libie_xdp_tx_bulk *bq,
+					   struct xdp_buff *xdp)
+{
+	bq->bulk[bq->count++] = (typeof(*bq->bulk)){
+		.xsk	= xdp,
+		.len	= xdp->data_end - xdp->data,
+	};
+}
+
+static inline struct libie_xdp_tx_desc
+libie_xsk_tx_fill_buf(const struct libie_xdp_tx_frame *frm,
+		      const struct libie_xdp_tx_queue *sq)
+{
+	struct libie_xdp_tx_desc desc = {
+		.len	= frm->len,
+	};
+	struct xdp_buff *xdp = frm->xsk;
+	struct libie_tx_buffer *tx_buf;
+
+	desc.addr = xsk_buff_xdp_get_dma(xdp);
+	xsk_buff_raw_dma_sync_for_device(sq->pool, desc.addr, desc.len);
+
+	tx_buf = &sq->tx_buf[*sq->next_to_use];
+	tx_buf->type = LIBIE_TX_BUF_XSK_TX;
+	tx_buf->gso_segs = 1;
+	tx_buf->bytecount = desc.len;
+	tx_buf->xdp = xdp;
+
+	return desc;
+}
+
+#define libie_xsk_tx_flush_bulk(bq, prep, xmit)				 \
+	__libie_xdp_tx_flush_bulk(bq, prep, libie_xsk_tx_fill_buf, xmit)
+
+/* XSk xmit implementation */
+
+#define libie_xsk_xmit_init_bulk(bq, xdpq)				 \
+	__libie_xdp_tx_init_bulk(bq, NULL, NULL, xdpq)
+
+static inline struct libie_xdp_tx_desc
+libie_xsk_xmit_fill_buf(const struct libie_xdp_tx_frame *frm,
+			const struct libie_xdp_tx_queue *sq)
+{
+	struct libie_xdp_tx_desc desc = {
+		.len	= frm->desc.len,
+	};
+
+	desc.addr = xsk_buff_raw_get_dma(sq->pool, frm->desc.addr);
+	xsk_buff_raw_dma_sync_for_device(sq->pool, desc.addr, desc.len);
+
+	return desc;
+}
+
+static __always_inline bool
+libie_xsk_xmit_do_bulk(void *xdpq, struct xsk_buff_pool *pool, u32 budget,
+		       u32 (*prep)(void *xdpq, struct libie_xdp_tx_queue *sq),
+		       void (*xmit)(struct libie_xdp_tx_desc desc,
+				    const struct libie_xdp_tx_queue *sq),
+		       void (*finalize)(void *xdpq, bool tail))
+{
+	struct libie_xdp_tx_bulk bq;
+	u32 n, batched;
+
+	n = xsk_tx_peek_release_desc_batch(pool, budget);
+	if (unlikely(!n))
+		return true;
+
+	batched = ALIGN_DOWN(n, LIBIE_XDP_TX_BULK);
+
+	libie_xsk_xmit_init_bulk(&bq, xdpq);
+	bq.count = LIBIE_XDP_TX_BULK;
+
+	for (u32 i = 0; i < batched; i += LIBIE_XDP_TX_BULK) {
+		memcpy(bq.bulk, &pool->tx_descs[i], sizeof(bq.bulk));
+		libie_xdp_tx_xmit_bulk(&bq, prep, libie_xsk_xmit_fill_buf,
+				       xmit);
+	}
+
+	bq.count = n - batched;
+
+	memcpy(bq.bulk, &pool->tx_descs[batched], bq.count * sizeof(*bq.bulk));
+	libie_xdp_tx_xmit_bulk(&bq, prep, libie_xsk_xmit_fill_buf, xmit);
+
+	finalize(bq.xdpq, true);
+
+	if (xsk_uses_need_wakeup(pool))
+		xsk_set_tx_need_wakeup(pool);
+
+	return n < budget;
+}
+
+/* Rx polling path */
+
+/**
+ * __libie_xsk_run_prog - run XDP program on an XDP buffer
+ * @xdp: XDP buffer to run the prog on
+ * @bq: buffer bulk for ``XDP_TX`` queueing
+ *
+ * Return: LIBIE_XDP_{PASS,DROP,ABORTED,TX,REDIRECT} depending on the prog's
+ * verdict.
+ */
+static inline u32 __libie_xsk_run_prog(struct xdp_buff *xdp,
+				       struct libie_xdp_tx_bulk *bq)
+{
+	const struct bpf_prog *prog = bq->prog;
+	u32 act, drop = LIBIE_XDP_DROP;
+	struct xdp_buff_xsk *xsk;
+	int ret;
+
+	act = bpf_prog_run_xdp(prog, xdp);
+	if (unlikely(act != XDP_REDIRECT))
+		goto rest;
+
+	ret = xdp_do_redirect(bq->dev, xdp, prog);
+	if (unlikely(ret))
+		goto check_err;
+
+	return LIBIE_XDP_REDIRECT;
+
+rest:
+	switch (act) {
+	case XDP_ABORTED:
+err:
+		trace_xdp_exception(bq->dev, prog, act);
+		fallthrough;
+	case XDP_DROP:
+		xsk_buff_free(xdp);
+
+		return drop;
+	case XDP_PASS:
+		return LIBIE_XDP_PASS;
+	case XDP_TX:
+		libie_xsk_tx_queue_bulk(bq, xdp);
+
+		return LIBIE_XDP_TX;
+	default:
+		bpf_warn_invalid_xdp_action(bq->dev, prog, act);
+		goto err;
+	}
+
+check_err:
+	xsk = container_of(xdp, typeof(*xsk), xdp);
+	if (xsk_uses_need_wakeup(xsk->pool) && ret == -ENOBUFS)
+		drop = LIBIE_XDP_ABORTED;
+
+	goto err;
+}
+
+#define libie_xsk_run_prog(xdp, bq, fl)					\
+	__libie_xdp_run_flush(xdp, bq, __libie_xsk_run_prog, fl)
+
+/* Externals */
+
+int libie_xsk_enable_pool(struct net_device *dev, u32 qid, unsigned long *map);
+int libie_xsk_disable_pool(struct net_device *dev, u32 qid,
+			   unsigned long *map);
+
+#endif /* __LIBIE_XSK_H */
-- 
2.43.0


