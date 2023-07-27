Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB54B76564E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 16:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbjG0Oqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 10:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbjG0Oq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 10:46:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBB230DA;
        Thu, 27 Jul 2023 07:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690469158; x=1722005158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KlYBSALGjCnGn6k2NRIvrpGdhSLAEVVLVU2ig0CAvyw=;
  b=E1rw8pp/7blEWzZ30GBezU/a32XZ1bZtX4JhsYd9TC6z0+LkW5HwkN+N
   A0r1ZIDYW7v7OYEriIAzfvItykKq51XJ5dGIdeDx8IjGz6Z9dfUtnYd7p
   bnRwUF0MfiZZ54rcadt5OVV26Wn9NsuqRpEBa07V+ibWpcHWwkWBKhAws
   9rCk502nY6mm5j98ZIbKxwLyaQSS7OWdb6UrAqc9cb4J4jaAMoB4+e8Eb
   n82LFweB6wFPBOMntjWukbjOA4XCTKYA1wH5RWiNgEhIY7YmURFWfGhh2
   gMHutjSJbBaOESLaQMQU6bXLL83AEfCu6Nvm6sx/LNVU1UKp9JaxRAxqT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="432139848"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="432139848"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 07:45:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="817119955"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="817119955"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jul 2023 07:45:54 -0700
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
Subject: [PATCH net-next 8/9] page_pool: add a lockdep check for recycling in hardirq
Date:   Thu, 27 Jul 2023 16:43:35 +0200
Message-ID: <20230727144336.1646454-9-aleksander.lobakin@intel.com>
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

From: Jakub Kicinski <kuba@kernel.org>

Page pool use in hardirq is prohibited, add debug checks
to catch misuses. IIRC we previously discussed using
DEBUG_NET_WARN_ON_ONCE() for this, but there were concerns
that people will have DEBUG_NET enabled in perf testing.
I don't think anyone enables lockdep in perf testing,
so use lockdep to avoid pushback and arguing :)

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/lockdep.h | 7 +++++++
 net/core/page_pool.c    | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 310f85903c91..dc2844b071c2 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -625,6 +625,12 @@ do {									\
 	WARN_ON_ONCE(__lockdep_enabled && !this_cpu_read(hardirq_context)); \
 } while (0)
 
+#define lockdep_assert_no_hardirq()					\
+do {									\
+	WARN_ON_ONCE(__lockdep_enabled && (this_cpu_read(hardirq_context) || \
+					   !this_cpu_read(hardirqs_enabled))); \
+} while (0)
+
 #define lockdep_assert_preemption_enabled()				\
 do {									\
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
@@ -659,6 +665,7 @@ do {									\
 # define lockdep_assert_irqs_enabled() do { } while (0)
 # define lockdep_assert_irqs_disabled() do { } while (0)
 # define lockdep_assert_in_irq() do { } while (0)
+# define lockdep_assert_no_hardirq() do { } while (0)
 
 # define lockdep_assert_preemption_enabled() do { } while (0)
 # define lockdep_assert_preemption_disabled() do { } while (0)
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 529e4b41e9eb..be9371cd9ac7 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -579,6 +579,8 @@ static __always_inline struct page *
 __page_pool_put_page(struct page_pool *pool, struct page *page,
 		     unsigned int dma_sync_size, bool allow_direct)
 {
+	lockdep_assert_no_hardirq();
+
 	/* This allocator is optimized for the XDP mode that uses
 	 * one-frame-per-page, but have fallbacks that act like the
 	 * regular page allocator APIs.
-- 
2.41.0

