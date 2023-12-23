Return-Path: <linux-kernel+bounces-10231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9474981D19B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29202859A7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D53328367;
	Sat, 23 Dec 2023 02:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l9Ycgs0d"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B52D2577B;
	Sat, 23 Dec 2023 02:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703300342; x=1734836342;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jcsuGPpFSGcZ4sgNc0Vw/DW519NNgEvMXndn/cJUseI=;
  b=l9Ycgs0dFb0PGHHQJXMR1NS5+blXTfGC0esupwQa5nDbovJ6mM8NxeUs
   4Wc9ZXTQpH3TeoUnFlsXRJnP1RCMsFkrgJhpyNZhZld6nJ82CJYEPlZwo
   k/MQmPZeuvX8HXOdbWCiDvH9kfKMLtdmlzj6/ZI+uCz3cgdWGIRXpH1Je
   BBw5NwbFp52YI0nHG9oCiS6ItuZi0TJfzLzz0Gs67XiB1RFAG6e3Yvtw2
   5wyIIUumQW8XCx/wAdLazdfHop+YVopUuYzLg7+IiBR6EGnnsMn/t85H3
   Ze8MTX2AorSP++zuc9ovymJNrQX+02dFU68mB0HKwXddnfYaxlsn0RW/z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="386610891"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="386610891"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 18:59:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="25537505"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa001.jf.intel.com with ESMTP; 22 Dec 2023 18:58:58 -0800
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
Subject: [PATCH RFC net-next 15/34] page_pool: add inline helper to sync VA for device (for XDP_TX)
Date: Sat, 23 Dec 2023 03:55:35 +0100
Message-ID: <20231223025554.2316836-16-aleksander.lobakin@intel.com>
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

Drivers using Page Pool for Rx buffers do the same pattern on XDP_TX:
syncing-DMA-for-device and obtaining DMA address for &xdp_buff they
are sending.
Add a helper for that to be able to do that in one call in the drivers.
I explicitly added `bool compound` argument and set it to false by
default: only a few drivers, if any, uses high-order pages with Page
Pool, so losing cycles on compound_head() looks suboptimal. Drivers
can always call the underscored version if needed (for example, pass
pool->p.order as the last argument -- will always work).

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/page_pool/helpers.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 873631c79ab1..99dc825b03a5 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -397,6 +397,38 @@ static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
 	return false;
 }
 
+static inline dma_addr_t __page_pool_dma_sync_va_for_device(const void *va,
+							    u32 dma_sync_size,
+							    bool compound)
+{
+	const struct page_pool *pool;
+	const struct page *page;
+	dma_addr_t addr;
+	u32 offset;
+
+	if (unlikely(compound)) {
+		page = virt_to_head_page(va);
+		offset = va - page_address(page);
+	} else {
+		page = virt_to_page(va);
+		offset = offset_in_page(va);
+	}
+
+	addr = page_pool_get_dma_addr(page) + offset;
+	pool = page->pp;
+
+	dma_sync_single_for_device(pool->p.dev, addr, dma_sync_size,
+				   page_pool_get_dma_dir(pool));
+
+	return addr;
+}
+
+static inline dma_addr_t page_pool_dma_sync_va_for_device(const void *va,
+							  u32 dma_sync_size)
+{
+	return __page_pool_dma_sync_va_for_device(va, dma_sync_size, false);
+}
+
 /**
  * page_pool_dma_sync_for_cpu - sync Rx page for CPU after it's written by HW
  * @pool: &page_pool the @page belongs to
-- 
2.43.0


