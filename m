Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716657928E9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350355AbjIEQYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354756AbjIEOHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 10:07:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A291AB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 07:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693922855; x=1725458855;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q95MzduZqjx1H3qSsIIWM/4xzW0Di0Tyl1YsUi4/EEk=;
  b=b9O00clt7a9N6CWPs2n7+O9xNN6xeXOqYRrK1WQPdlGf59URCG9hJ3tT
   IyK4Fu7ZQtmEYMci7EWK2h1MLU7gwUF5LvIQ1FlaYRzFJn95KNZw7VBAd
   RpJXBkLQKSwjlmCkUbfrvg2adCDPOaW8sP/lOl4wu62f1sj6NSXvV/jhc
   zLs4hYmHz3rpHvCiY/o5PXEyV51pOOXM84/W32+tXXQGqQpa7XwdimfyD
   CbyMLJJLeNxiQNDRswdpoFYU7PJueMPTcZIdXgrAdUxHaRPqOLwC2p8rl
   HKRIT0aItSb8Wh3RGf8uc0G5TSwOQ834IyjnmCjd5p8jmTA1gzeOT90Bl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="380609601"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="380609601"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 07:06:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="811242153"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="811242153"
Received: from shbuild999.sh.intel.com ([10.239.146.107])
  by fmsmga004.fm.intel.com with ESMTP; 05 Sep 2023 07:06:23 -0700
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
Subject: [RFC Patch 2/3] mm/slub: double per-cpu partial number for large systems
Date:   Tue,  5 Sep 2023 22:13:47 +0800
Message-Id: <20230905141348.32946-3-feng.tang@intel.com>
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

There are reports about severe lock contention for slub's per-node
'list_lock' in 'hackbench' test, [1][2], on server systems. And
similar contention is also seen when running 'mmap1' case of
will-it-scale on big systems. As the trend is one processor (socket)
will have more and more CPUs (100+, 200+), the contention could be
much more severe and becomes a scalability issue.

One way to help reducing the contention is to double the per-cpu
partial number for large systems.

Following is some performance data, where it shows big improvment
in will-it-scale/mmap1 case, but no ovbious change for the 'hackbench'
test.

The patch itself only makes the per-cpu partial number 2X, and for
better analysis, the 4X case is also profiled

will-it-scale/mmap1
-------------------
Run will-it-scale benchmark's 'mmap1' test case on a 2 socket Sapphire
Rapids server (112 cores / 224 threads) with 256 GB DRAM, run 3
configurations with parallel test threads of 25%, 50% and 100% of
number of CPUs, and the data is (base is vanilla v6.5 kernel):

		  base             base + 2X patch        base + 4X patch
wis-mmap1-25	 223670    +12.7%     251999     +34.9%     301749    per_process_ops
wis-mmap1-50	 186020    +28.0%     238067     +55.6%     289521    per_process_ops
wis-mmap1-100	  89200    +40.7%     125478     +62.4%     144858    per_process_ops

Take the perf-profile comparasion of 50% test case, the lock contention
is greatly reduced:

     43.80           -11.5       32.27           -27.9       15.91   pp.self.native_queued_spin_lock_slowpath

hackbench
---------

Run same hackbench testcase  mentioned in [1], use same HW/SW as will-it-scale:

		  base             base + 2X patch        base + 4X patch
hackbench	759951      +0.2%    761506      +0.5%     763972     hackbench.throughput

[1]. https://lore.kernel.org/all/202307172140.3b34825a-oliver.sang@intel.com/
[2]. ttps://lore.kernel.org/lkml/ZORaUsd+So+tnyMV@chenyu5-mobl2/

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/slub.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index f7940048138c..51ca6dbaad09 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4361,6 +4361,13 @@ static void set_cpu_partial(struct kmem_cache *s)
 	else
 		nr_objects = 120;
 
+	/*
+	 * Give larger system more per-cpu partial slabs to reduce/postpone
+	 * contending per-node partial list.
+	 */
+	if (num_cpus() >= 32)
+		nr_objects *= 2;
+
 	slub_set_cpu_partial(s, nr_objects);
 #endif
 }
-- 
2.27.0

