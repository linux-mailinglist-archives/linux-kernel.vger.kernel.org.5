Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C95808ED3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443294AbjLGRWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443192AbjLGRWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:22:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DAE10FC;
        Thu,  7 Dec 2023 09:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701969731; x=1733505731;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ejhuq7rcREiXUDQMM5p6SxYKQOlZ+enzGd8uebPKEaM=;
  b=A9HZeX6qnmj6Wkb7Ib5AQOQK4F0HuJSNI84iSwl1NW4+j0K0Y1gLIz01
   sZMKEYVSMGEm0ohdYdo8MAlaMaD6typ6l+rE55xjk/a105bajeD8QpisT
   7mpnqKMU3yHCg5svOjeqkOGpDzkKmhuNkaVsNJxUJZkF+H6RDgJtJlPhN
   0sWZKQwSSUMvvz3PpKF3pqabprZYsIiOw5y6DKzRYyJMAqF7n69T4ip3G
   lajoA6tVTVPdN9aNFgAuMiBCbzns2bcHr8+BD/fLgh+BaqMOw2ptzZOxi
   pXlE3zZQd3zHtJnvnXTimsqrE1n25k/L+Jt2i1cLIGtWNdTIY7Sk+NbWK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="374434670"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="374434670"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 09:21:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="721548498"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="721548498"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orsmga003.jf.intel.com with ESMTP; 07 Dec 2023 09:21:54 -0800
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
Subject: [PATCH net-next v6 01/12] page_pool: make sure frag API fields don't span between cachelines
Date:   Thu,  7 Dec 2023 18:19:59 +0100
Message-ID: <20231207172010.1441468-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231207172010.1441468-1-aleksander.lobakin@intel.com>
References: <20231207172010.1441468-1-aleksander.lobakin@intel.com>
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

