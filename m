Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208E6810FE8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbjLMLa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbjLMLaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:30:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E303B0;
        Wed, 13 Dec 2023 03:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702467059; x=1734003059;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ejhuq7rcREiXUDQMM5p6SxYKQOlZ+enzGd8uebPKEaM=;
  b=ceazthkJnUP2uIT088e7hGeD2jKMjCVtwc3dejKcbnHuTrRzgsi3YEtc
   MA82scXc09MN5YkaltgdWG1BJYUb3yebM7gIxPh6vs53HVK3Mm+SBdLCZ
   WyZJf7YgXoqCcyu8zSzBjeMVs/sKOSiVnZGleHlgPKMIpRJ+Pwi5IrK8u
   onh6WBU2TqIW8bWt4FHsO4f7wixpmXlIotodOSuZHQg1YtyvtA2seQUxJ
   rbJFtcR+wQHY6l7XIWGoMrXcrS3GgBw6GIPBEQmxyXC6W4Xb9Wl1XXvQZ
   Lav9juwPP88RDZXuER4o5o30xH3KaTEc6mH6qlW2E8FjWpsOUqiZ8epks
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="375103865"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="375103865"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 03:30:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="844279422"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="844279422"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga004.fm.intel.com with ESMTP; 13 Dec 2023 03:30:40 -0800
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
Subject: [PATCH net-next v7 01/12] page_pool: make sure frag API fields don't span between cachelines
Date:   Wed, 13 Dec 2023 12:28:24 +0100
Message-ID: <20231213112835.2262651-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213112835.2262651-1-aleksander.lobakin@intel.com>
References: <20231213112835.2262651-1-aleksander.lobakin@intel.com>
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

After commit 5027ec19f104 ("net: page_pool: split the page_pool_params
into fast and slow") that made &page_pool contain only "hot" params at
the start, cacheline boundary chops frag API fields group in the middle
again.
To not bother with this each time fast params get expanded or shrunk,
let's just align them to `4 * sizeof(long)`, the closest upper pow-2 to
their actual size (2 longs + 2 ints). This ensures 16-byte alignment for
the 32-bit architectures and 32-byte alignment for the 64-bit ones,
excluding unnecessary false-sharing.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/page_pool/types.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index ac286ea8ce2d..35ab82da7f2a 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -130,7 +130,16 @@ struct page_pool {
 
 	bool has_init_callback;
 
-	long frag_users;
+	/* The following block must stay within one cacheline. On 32-bit
+	 * systems, sizeof(long) == sizeof(int), so that the block size is
+	 * precisely ``4 * sizeof(long)``. On 64-bit systems, the actual size
+	 * is ``2 * sizeof(long) + 2 * sizeof(int)``, i.e. 24 bytes, but the
+	 * closest pow-2 to that is 32 bytes, which also equals to
+	 * ``4 * sizeof(long)``, so just use that one for simplicity.
+	 * Having it aligned to a cacheline boundary may be excessive and
+	 * doesn't bring any good.
+	 */
+	long frag_users __aligned(4 * sizeof(long));
 	struct page *frag_page;
 	unsigned int frag_offset;
 	u32 pages_state_hold_cnt;
-- 
2.43.0

