Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F71D77077A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 20:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjHDSG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 14:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjHDSGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 14:06:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCC049F0;
        Fri,  4 Aug 2023 11:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691172377; x=1722708377;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/RvGeZgasgv1mj7dNoL3ueQcvj+u+ttPutxwUs7TTE0=;
  b=JmVFWa6oXC9zl89Dvzna6VxhujROHwdUfPxnyQgOyGiU5QHHX/lCHtVb
   QXdZV3Hix8YqM4PYl+AkvvMQx5/64qBpThB4bh2m5YOK8sCUViFTaaCsq
   aB/ZP9Pjr29vW6/dpZWhtKMas8fMXeSO1jJgpmC7VN8w1R/raz3CeotYP
   t0WeTOfnA79HN4m5iR8C0VijiUWG2UA+mpvtulYkuEB5994UGIqJX6FAB
   XiGulyMlQhBy/FyV3dnHqnoKNSJkMPz7zHFlIcdknA+fd6CfSVa4Zpge7
   syVKY8A1xdYqxSZsYvAVWAyhlkhO1nEfDrMJ7Dh5YqwGtBI41/+TkoD8k
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="434061677"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="434061677"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 11:06:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="759673591"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="759673591"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orsmga008.jf.intel.com with ESMTP; 04 Aug 2023 11:06:12 -0700
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 3/6] page_pool: place frag_* fields in one cacheline
Date:   Fri,  4 Aug 2023 20:05:26 +0200
Message-ID: <20230804180529.2483231-4-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804180529.2483231-1-aleksander.lobakin@intel.com>
References: <20230804180529.2483231-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On x86_64, frag_* fields of struct page_pool are scattered across two
cachelines despite the summary size of 24 bytes. All three fields are
used in pretty much the same places, but the last field, ::frag_users,
is pushed out to the next CL, provoking unwanted false-sharing on
hotpath (frags allocation code).
There are some holes and cold members to move around. Move frag_* one
block up, placing them right after &page_pool_params perfectly at the
beginning of CL2. This doesn't do any meaningful to the second block, as
those are some destroy-path cold structures, and doesn't do anything to
::alloc_stats, which still starts at 200-byte offset, 8 bytes after CL3
(still fitting into 1 cacheline).
On my setup, this yields 1-2% of Mpps when using PP frags actively.
When it comes to 32-bit architectures with 32-byte CL: &page_pool_params
plus ::pad is 44 bytes, the block taken care of is 16 bytes within one
CL, so there should be at least no regressions from the actual change.
::pages_state_hold_cnt is not related directly to that triple, but is
paired currently with ::frags_offset and decoupling them would mean
either two 4-byte holes or more invasive layout changes.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/page_pool/types.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index fcb846523398..887e7946a597 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -123,16 +123,16 @@ struct page_pool_stats {
 struct page_pool {
 	struct page_pool_params p;
 
+	long frag_users;
+	struct page *frag_page;
+	unsigned int frag_offset;
+	u32 pages_state_hold_cnt;
+
 	struct delayed_work release_dw;
 	void (*disconnect)(void *pool);
 	unsigned long defer_start;
 	unsigned long defer_warn;
 
-	u32 pages_state_hold_cnt;
-	unsigned int frag_offset;
-	struct page *frag_page;
-	long frag_users;
-
 #ifdef CONFIG_PAGE_POOL_STATS
 	/* these stats are incremented while in softirq context */
 	struct page_pool_alloc_stats alloc_stats;
-- 
2.41.0

