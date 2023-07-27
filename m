Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2EF765650
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 16:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbjG0Oqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 10:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbjG0Oq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 10:46:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92473AAA;
        Thu, 27 Jul 2023 07:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690469161; x=1722005161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eYl99+L8eoZb9TdbyaCeQo6lRhwlNSjOXE6qobDW3K0=;
  b=IkgpUQGNIbKtfpljDJGk10+TiBLptw0DunKPCOtyK55fN2OgBAW8gYxh
   eAejiz0Qn+pA/f/3udRKxN9koAJPdaQbkAhqmPLdbMJt3s/TmXZSbgtIu
   GOHKwafQ11X6w1VQcvfY/7h2Iza0yEkwY/OyqxzAYtUjAHtjGE3kR1itl
   nBs0rbe+RYJIKim6+gGQg8LP5VHFJddzobUnjCF58eoRQR0MjE1TctsnU
   AlrcR8gyKvFuD7zLnuxzjq2pZVDI2WY0aa5wy9ocflw5Hr52fnSUMGdLF
   wxASAuNvr3TR5FqIM4P2wuiY3gfWRAGbSvb0902opVK/rHCVxVyP5mfsJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="432139872"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="432139872"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 07:46:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="817119964"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="817119964"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jul 2023 07:45:57 -0700
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
Subject: [PATCH net-next 9/9] net: skbuff: always try to recycle PP pages directly when in softirq
Date:   Thu, 27 Jul 2023 16:43:36 +0200
Message-ID: <20230727144336.1646454-10-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727144336.1646454-1-aleksander.lobakin@intel.com>
References: <20230727144336.1646454-1-aleksander.lobakin@intel.com>
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

Commit 8c48eea3adf3 ("page_pool: allow caching from safely localized
NAPI") allowed direct recycling of skb pages to their PP for some cases,
but unfortunately missed a couple of other majors.
For example, %XDP_DROP in skb mode. The netstack just calls kfree_skb(),
which unconditionally passes `false` as @napi_safe. Thus, all pages go
through ptr_ring and locks, although most of time we're actually inside
the NAPI polling this PP is linked with, so that it would be perfectly
safe to recycle pages directly.
Let's address such. If @napi_safe is true, we're fine, don't change
anything for this path. But if it's false, check whether we are in the
softirq context. It will most likely be so and then if ->list_owner
is our current CPU, we're good to use direct recycling, even though
@napi_safe is false -- concurrent access is excluded. in_softirq()
protection is needed mostly due to we can hit this place in the
process context (not the hardirq though).
For the mentioned xdp-drop-skb-mode case, the improvement I got is
3-4% in Mpps. As for page_pool stats, recycle_ring is now 0 and
alloc_slow counter doesn't change most of time, which means the
MM layer is not even called to allocate any new pages.

Suggested-by: Jakub Kicinski <kuba@kernel.org> # in_softirq()
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 net/core/skbuff.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index e701401092d7..5ba3948cceed 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -901,8 +901,10 @@ bool page_pool_return_skb_page(struct page *page, bool napi_safe)
 	/* Allow direct recycle if we have reasons to believe that we are
 	 * in the same context as the consumer would run, so there's
 	 * no possible race.
+	 * __page_pool_put_page() makes sure we're not in hardirq context
+	 * and interrupts are enabled prior to accessing the cache.
 	 */
-	if (napi_safe) {
+	if (napi_safe || in_softirq()) {
 		const struct napi_struct *napi = READ_ONCE(pp->p.napi);
 
 		allow_direct = napi &&
-- 
2.41.0

