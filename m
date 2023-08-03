Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79BA76EFC3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbjHCQlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234990AbjHCQky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:40:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECF53C32;
        Thu,  3 Aug 2023 09:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691080849; x=1722616849;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TRHtHZZsrtKPh46Cyyg2IuliYjMms24MRWRa9oR6poU=;
  b=KQfoX6q8x/M9RwsIOuBP1EMUKYjyKshqxw3DmUrM0kyXhq4BdJxnB/Bv
   edmfSHrOgfSjLgM776Wy1YEl2lHXSwVmBVcwV58/gtnslLOw0T1N9JSRn
   mb3IjIbry2FA6ezVqy2J45inyNqio+o1wbwvTS6m9q1dsLhlKfOjAPo03
   wy/AYekRDfkDpHsX8vX0V+HpKXfB5hboKyEYRYHPYsQaIgZbNG5oswDSc
   QLmhe9y1cZ3HO+s1UaQrk4JxAS4k9yCvKyZ7CsT/x6cT0UGrNM2+qDqxC
   SgiplQg64YRh+ZBL4ySH3P6xEYWOho64q/97ADzjHQ3Ep7Dhr54H4UgHP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="350229256"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="350229256"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 09:40:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="723268900"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="723268900"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orsmga007.jf.intel.com with ESMTP; 03 Aug 2023 09:40:45 -0700
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
Subject: [PATCH net-next v2 5/6] page_pool: add a lockdep check for recycling in hardirq
Date:   Thu,  3 Aug 2023 18:40:13 +0200
Message-ID: <20230803164014.993838-6-aleksander.lobakin@intel.com>
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
index 7a23ca6b1124..9eef9a5489e7 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -572,6 +572,8 @@ static __always_inline struct page *
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

