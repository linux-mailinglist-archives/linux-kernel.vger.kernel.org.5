Return-Path: <linux-kernel+bounces-10228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1263981D195
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9481F1F219BC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6A6171B1;
	Sat, 23 Dec 2023 02:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jVkDPg5N"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F9B1D696;
	Sat, 23 Dec 2023 02:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703300330; x=1734836330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lwem7QAKrTATP+Ps1asjKzaTx+4QKgH8qLT9fJ4NywM=;
  b=jVkDPg5NTNw/M/bNdjDvryr0p6l7/Rx/CcUtoify5Af/wMpgCON3zmC4
   C9fMrL7mtzbnxknyEVO4eXEM2UH59DH+iQ3P+bweet4fMQ0TxipjneHy7
   /O9kFJViFmCzFdMwuej94EzW2gjgnofkHOLoXDec/MKvfm//DZ0PWzyY0
   xJh7bHsTaTN6VzDi3GvpUSYZQWoCGYcLh7czOalCQ3L+v4LeRbLzRJTLa
   pvccrnBy5U/5s2Ei1YPFXw3pp/1yUga7zDZE7B+aCKZ9A/BczbizMXXyh
   dep+WXZe8pMoC4FEHnMPhYaL9Se/Ho/x77Tgc2ZjqdDZWC/Ni4zsslwn4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="386610865"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="386610865"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 18:58:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="25537492"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa001.jf.intel.com with ESMTP; 22 Dec 2023 18:58:47 -0800
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
Subject: [PATCH RFC net-next 12/34] xdp: add generic xdp_buff_add_frag()
Date: Sat, 23 Dec 2023 03:55:32 +0100
Message-ID: <20231223025554.2316836-13-aleksander.lobakin@intel.com>
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

The code piece which would attach a frag to &xdp_buff is almost
identical across the drivers supporting XDP multi-buffer on Rx.
Make it a generic elegant onelner.
Also, I see lots of drivers calculating frags_truesize as
`xdp->frame_sz * nr_frags`. I can't say this is fully correct, since
frags might be backed by chunks of different sizes, especially with
stuff like the header split. Even page_pool_alloc() can give you two
different truesizes on two subsequent requests to allocate the same
buffer size. Add a field to &skb_shared_info (unionized as there's no
free slot currently on x6_64) to track the "true" truesize. It can be
used later when updating an skb.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/skbuff.h | 14 ++++++++++----
 include/net/xdp.h      | 36 +++++++++++++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index ea5c8ab3ed00..e350efa04070 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -598,11 +598,17 @@ struct skb_shared_info {
 	 * Warning : all fields before dataref are cleared in __alloc_skb()
 	 */
 	atomic_t	dataref;
-	unsigned int	xdp_frags_size;
 
-	/* Intermediate layers must ensure that destructor_arg
-	 * remains valid until skb destructor */
-	void *		destructor_arg;
+	union {
+		struct {
+			unsigned int	xdp_frags_size;
+			u32		xdp_frags_truesize;
+		};
+
+		/* Intermediate layers must ensure that destructor_arg
+		 * remains valid until skb destructor */
+		void *		destructor_arg;
+	};
 
 	/* must be last field, see pskb_expand_head() */
 	skb_frag_t	frags[MAX_SKB_FRAGS];
diff --git a/include/net/xdp.h b/include/net/xdp.h
index 909c0bc50517..a3dc0f39b437 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -165,6 +165,34 @@ xdp_get_buff_len(const struct xdp_buff *xdp)
 	return len;
 }
 
+static inline bool xdp_buff_add_frag(struct xdp_buff *xdp, struct page *page,
+				     u32 offset, u32 size, u32 truesize)
+{
+	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
+
+	if (!xdp_buff_has_frags(xdp)) {
+		sinfo->nr_frags = 0;
+
+		sinfo->xdp_frags_size = 0;
+		sinfo->xdp_frags_truesize = 0;
+
+		xdp_buff_set_frags_flag(xdp);
+	}
+
+	if (unlikely(sinfo->nr_frags == MAX_SKB_FRAGS))
+		return false;
+
+	__skb_fill_page_desc_noacc(sinfo, sinfo->nr_frags++, page, offset,
+				   size);
+	sinfo->xdp_frags_size += size;
+	sinfo->xdp_frags_truesize += truesize;
+
+	if (unlikely(page_is_pfmemalloc(page)))
+		xdp_buff_set_frag_pfmemalloc(xdp);
+
+	return true;
+}
+
 struct xdp_frame {
 	void *data;
 	u16 len;
@@ -230,7 +258,13 @@ xdp_update_skb_shared_info(struct sk_buff *skb, u8 nr_frags,
 			   unsigned int size, unsigned int truesize,
 			   bool pfmemalloc)
 {
-	skb_shinfo(skb)->nr_frags = nr_frags;
+	struct skb_shared_info *sinfo = skb_shinfo(skb);
+
+	sinfo->nr_frags = nr_frags;
+	/* ``destructor_arg`` is unionized with ``xdp_frags_{,true}size``,
+	 * reset it after that these fields aren't used anymore.
+	 */
+	sinfo->destructor_arg = NULL;
 
 	skb->len += size;
 	skb->data_len += size;
-- 
2.43.0


