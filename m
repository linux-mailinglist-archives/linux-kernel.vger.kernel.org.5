Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A09A792B92
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343858AbjIEQz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354758AbjIEOHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 10:07:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6DF1A7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 07:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693922856; x=1725458856;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dvT4bjQOLiJP78MPuTog+CQfsmhI/8vfzdHD6sqXSeU=;
  b=n8vuWiACSzfFi0hQCYZnDr/R3KjuzXRMbEFn+f3hyZMu9ttaXnhlVEpo
   d/1MuZJHTZMu3RCAPA09YpwISUmtYdEStx60akGgUz0QWhHLh426szOWh
   y+QxiJg6nNy3oRgQrh4L9yH1+1WlqtgyEv+W5SyDT680I26lBCrbGnHzO
   IqH4m9tsKFvz0Ci/r+deXv3EGHmLE2303ZbLI384UrEB3mu6WZBbbl4Te
   2LVn94LEd7uLzd7MEbe4y95VloGiOXmxvAtwLZ6L4AYAxx9BtR2pLCkoF
   oiUt5HBN6FJiwzdzYXqk32r1TxMjNwijw02n/b2ijwaTu2pOuqL2nVRf6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="380609616"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="380609616"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 07:06:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="811242163"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="811242163"
Received: from shbuild999.sh.intel.com ([10.239.146.107])
  by fmsmga004.fm.intel.com with ESMTP; 05 Sep 2023 07:06:25 -0700
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
Subject: [RFC Patch 3/3] mm/slub: setup maxim per-node partial according to cpu numbers
Date:   Tue,  5 Sep 2023 22:13:48 +0800
Message-Id: <20230905141348.32946-4-feng.tang@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230905141348.32946-1-feng.tang@intel.com>
References: <20230905141348.32946-1-feng.tang@intel.com>
MIME-Version: 1.0
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

Currently most of the slab's min_partial is set to 5 (as MIN_PARTIAL
is 5). This is fine for older or small systesms, and could be too
small for a large system with hundreds of CPUs, when per-node
'list_lock' is contended for allocating from and freeing to per-node
partial list.

So enlarge it based on the CPU numbers per node.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 include/linux/nodemask.h | 1 +
 mm/slub.c                | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 8d07116caaf1..6e22caab186d 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -530,6 +530,7 @@ static inline int node_random(const nodemask_t *maskp)
 
 #define num_online_nodes()	num_node_state(N_ONLINE)
 #define num_possible_nodes()	num_node_state(N_POSSIBLE)
+#define num_cpu_nodes()		num_node_state(N_CPU)
 #define node_online(node)	node_state((node), N_ONLINE)
 #define node_possible(node)	node_state((node), N_POSSIBLE)
 
diff --git a/mm/slub.c b/mm/slub.c
index 09ae1ed642b7..984e012d7bbc 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4533,6 +4533,7 @@ static int calculate_sizes(struct kmem_cache *s)
 
 static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
 {
+	unsigned long min_partial;
 	s->flags = kmem_cache_flags(s->size, flags, s->name);
 #ifdef CONFIG_SLAB_FREELIST_HARDENED
 	s->random = get_random_long();
@@ -4564,8 +4565,12 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
 	 * The larger the object size is, the more slabs we want on the partial
 	 * list to avoid pounding the page allocator excessively.
 	 */
-	s->min_partial = min_t(unsigned long, MAX_PARTIAL, ilog2(s->size) / 2);
-	s->min_partial = max_t(unsigned long, MIN_PARTIAL, s->min_partial);
+
+	min_partial = rounddown_pow_of_two(num_cpus() / num_cpu_nodes());
+	min_partial = max_t(unsigned long, MIN_PARTIAL, min_partial);
+
+	s->min_partial = min_t(unsigned long, min_partial * 2, ilog2(s->size) / 2);
+	s->min_partial = max_t(unsigned long, min_partial, s->min_partial);
 
 	set_cpu_partial(s);
 
-- 
2.27.0

