Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D146F76EFBF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbjHCQk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbjHCQkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:40:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1660F30E2;
        Thu,  3 Aug 2023 09:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691080843; x=1722616843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=31u+MUzH6+dKE9DPXFl5YBb0OxGcml0B6f7mnB7yaio=;
  b=RZa1miCRkApClQ2cdfWeT/SgHBb41vRTe8sNQInMA6Y1PlIMrU1jbNuI
   Tfe8N0C1tk2zvAlk8QZiqjyN3+33P9SvIxevBqIoBH/kmtBR5Rcnq7LtJ
   juyVniH2aSz3uxgVcAM0KqgYsYYiYVcFQFjsbkIDsocqQI3SoFANgmeUF
   Tcxx6h6qbRvgP46G1H174oxHPuS6VM1p/hCsjK9gIJQ1ka/W9QIBcT6DJ
   QAlQCvY8NkKOax/GKY4BTI73Rv5ZckR+iaiuqjelcQGXGhvrnKDQuHzMV
   wTJNVLOCqtmfqLGPKM1OEgjbvIqwh3eEkTtezxpGXCP5w/6J9nOoi0SnN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="350229236"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="350229236"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 09:40:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="723268890"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="723268890"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orsmga007.jf.intel.com with ESMTP; 03 Aug 2023 09:40:39 -0700
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
Subject: [PATCH net-next v2 3/6] page_pool: place frag_* fields in one cacheline
Date:   Thu,  3 Aug 2023 18:40:11 +0200
Message-ID: <20230803164014.993838-4-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803164014.993838-1-aleksander.lobakin@intel.com>
References: <20230803164014.993838-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index c7aef6c75935..664a787948e1 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -94,16 +94,16 @@ struct page_pool_stats {
 struct page_pool {
 	struct page_pool_params p;
 
+	long frag_users;
+	struct page *frag_page;
+	unsigned int frag_offset;
+	u32 pages_state_hold_cnt;
+
 	struct delayed_work release_dw;
 	void (*disconnect)(void *);
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

