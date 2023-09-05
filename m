Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C399792986
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243857AbjIEQ1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354755AbjIEOHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 10:07:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4E01A7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 07:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693922854; x=1725458854;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+Yeg+pnZH94x+zS9eiLxzs8MVPwnnUwq2oxNPIF7mVU=;
  b=YqWWmjAWtOZiACePQy4nK4IHYZRlpbzKKKVy81UIkFd05GA+QCZmWYbW
   xLvyHAIYPj3hgaUbukh5In1LkXZn19zcn6JWBtQ1utTIHzFEd8uCqh4Yw
   Me/2StB4gfCzpTJVMUPflRUQQ2Zj2vWiuBs3S1bJS7qlh6mHkyPQBGs0M
   gGIW8Ymu3pOiZpJlsE3Ibto0LqqVdAw6LRh+I5dX/VyCG6om1mLGZnzvk
   jUOwmG3k4WyBkcpBiy1CTzOf0icWv3jfn9rPN54ut86POkdJVM7yYCbji
   N2P4Nnr7QRUzEQsvXP9164JBTDa5Q7hoRt1AjVHoXnsnFDcwRGVw4UZKh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="380609586"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="380609586"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 07:06:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="811242127"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="811242127"
Received: from shbuild999.sh.intel.com ([10.239.146.107])
  by fmsmga004.fm.intel.com with ESMTP; 05 Sep 2023 07:06:20 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>
Subject: [RFC Patch 1/3] mm/slub: increase the maximum slab order to 4 for big systems
Date:   Tue,  5 Sep 2023 22:13:46 +0800
Message-Id: <20230905141348.32946-2-feng.tang@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230905141348.32946-1-feng.tang@intel.com>
References: <20230905141348.32946-1-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are reports about severe lock contention for slub's per-node
'list_lock' in 'hackbench' test, [1][2], on server systems. And
similar contention is also seen when running 'mmap1' case of
will-it-scale on big systems. As the trend is one processor (socket)
will have more and more CPUs (100+, 200+), the contention could be
much more severe and becomes a scalability issue.

One way to help reducing the contention is to increase the maximum
slab order from 3 to 4, for big systems.

Unconditionally increasing the order could  bring trouble to client
devices with very limited size of memory, which may care more about
memory footprint, also allocating order 4 page could be harder under
memory pressure. So the increase will only be done for big systems
like servers, which usually are equipped with plenty of memory and
easier to hit lock contention issues.

Following is some performance data:

will-it-scale/mmap1
-------------------
Run will-it-scale benchmark's 'mmap1' test case on a 2 socket Sapphire
Rapids server (112 cores / 224 threads) with 256 GB DRAM, run 3
configurations with parallel test threads of 25%, 50% and 100% of
number of CPUs, and the data is (base is vanilla v6.5 kernel):

		     base                      base+patch
wis-mmap1-25%	    223670           +33.3%     298205        per_process_ops
wis-mmap1-50%	    186020           +51.8%     282383        per_process_ops
wis-mmap1-100%       89200           +65.0%     147139        per_process_ops

Take the perf-profile comparasion of 50% test case, the lock contention
is greatly reduced:

      43.80           -30.8       13.04       pp.self.native_queued_spin_lock_slowpath
      0.85            -0.2        0.65        pp.self.___slab_alloc
      0.41            -0.1        0.27        pp.self.__unfreeze_partials
      0.20 ±  2%      -0.1        0.12 ±  4%  pp.self.get_any_partial

hackbench
---------

Run same hackbench testcase  mentioned in [1], use same HW/SW as will-it-scale:

		     base                      base+patch
hackbench	    759951           +10.5%     839601        hackbench.throughput

perf-profile diff:
     22.20 ±  3%     -15.2        7.05        pp.self.native_queued_spin_lock_slowpath
      0.82            -0.2        0.59        pp.self.___slab_alloc
      0.33            -0.2        0.13        pp.self.__unfreeze_partials

[1]. https://lore.kernel.org/all/202307172140.3b34825a-oliver.sang@intel.com/
[2]. ttps://lore.kernel.org/lkml/ZORaUsd+So+tnyMV@chenyu5-mobl2/
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/slub.c | 51 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index f7940048138c..09ae1ed642b7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4081,7 +4081,7 @@ EXPORT_SYMBOL(kmem_cache_alloc_bulk);
  */
 static unsigned int slub_min_order;
 static unsigned int slub_max_order =
-	IS_ENABLED(CONFIG_SLUB_TINY) ? 1 : PAGE_ALLOC_COSTLY_ORDER;
+	IS_ENABLED(CONFIG_SLUB_TINY) ? 1 : 4;
 static unsigned int slub_min_objects;
 
 /*
@@ -4134,6 +4134,26 @@ static inline unsigned int calc_slab_order(unsigned int size,
 	return order;
 }
 
+static inline int num_cpus(void)
+{
+	int nr_cpus;
+
+	/*
+	 * Some architectures will only update present cpus when
+	 * onlining them, so don't trust the number if it's just 1. But
+	 * we also don't want to use nr_cpu_ids always, as on some other
+	 * architectures, there can be many possible cpus, but never
+	 * onlined. Here we compromise between trying to avoid too high
+	 * order on systems that appear larger than they are, and too
+	 * low order on systems that appear smaller than they are.
+	 */
+	nr_cpus = num_present_cpus();
+	if (nr_cpus <= 1)
+		nr_cpus = nr_cpu_ids;
+
+	return nr_cpus;
+}
+
 static inline int calculate_order(unsigned int size)
 {
 	unsigned int order;
@@ -4151,19 +4171,17 @@ static inline int calculate_order(unsigned int size)
 	 */
 	min_objects = slub_min_objects;
 	if (!min_objects) {
-		/*
-		 * Some architectures will only update present cpus when
-		 * onlining them, so don't trust the number if it's just 1. But
-		 * we also don't want to use nr_cpu_ids always, as on some other
-		 * architectures, there can be many possible cpus, but never
-		 * onlined. Here we compromise between trying to avoid too high
-		 * order on systems that appear larger than they are, and too
-		 * low order on systems that appear smaller than they are.
-		 */
-		nr_cpus = num_present_cpus();
-		if (nr_cpus <= 1)
-			nr_cpus = nr_cpu_ids;
+		nr_cpus = num_cpus();
 		min_objects = 4 * (fls(nr_cpus) + 1);
+
+		/*
+		 * If nr_cpus >= 32, the platform is likely to be a server
+		 * which usually has much more memory, and is easier to be
+		 * hurt by scalability issue, so enlarge it to reduce the
+		 * possible contention of the per-node 'list_lock'.
+		 */
+		if (nr_cpus >= 32)
+			min_objects *= 2;
 	}
 	max_objects = order_objects(slub_max_order, size);
 	min_objects = min(min_objects, max_objects);
@@ -4361,6 +4379,13 @@ static void set_cpu_partial(struct kmem_cache *s)
 	else
 		nr_objects = 120;
 
+	/*
+	 * Give larger system more buffer to reduce scalability issue, like
+	 * the handling in calculate_order().
+	 */
+	if (num_cpus() >= 32)
+		nr_objects *= 2;
+
 	slub_set_cpu_partial(s, nr_objects);
 #endif
 }
-- 
2.27.0

