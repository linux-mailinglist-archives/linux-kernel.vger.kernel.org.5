Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098357A72B7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbjITGT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbjITGTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:19:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D1599
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 23:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695190781; x=1726726781;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lVKcfu7RB9vKN2Hm50wym0zo99YnMLypq+qR+yt7FI8=;
  b=JjzVS/GcIFCb+wgM1BJ+H3FLzEFp5+5xFRNe/q+EottYmRsCWs8d1Aty
   mL9rWfNOJjg1yrrjhnxMG9F/x8Cs4zqr9LqUzdLZiUc6keZE2KiPDNHOP
   N7dtAalDPQnLrJpzV1ORi3roa9MxwkSuF6POwF1MzTjDXnwSWwEg8czLN
   ncJrt3MizNw++vSJm/adsezjJctPwBR5wc6WvqIERr6CWS7SmVH8R3IPt
   uYnKk6AB6zlmCkmjwnXYdhPxXzrVj0fVdIdZKiTbsN4n5kjI8O3bbWUTo
   rUCcD+7FDZsEU77OZY5TG+5FmAoulthw4V4Ud0+KW4I+cAH9qNjwrog+w
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="365187600"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="365187600"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 23:19:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="740060521"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="740060521"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.6.133])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 23:19:37 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>
Subject: [PATCH 02/10] cacheinfo: calculate per-CPU data cache size
Date:   Wed, 20 Sep 2023 14:18:48 +0800
Message-Id: <20230920061856.257597-3-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230920061856.257597-1-ying.huang@intel.com>
References: <20230920061856.257597-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per-CPU data cache size is useful information.  For example, it can be
used to determine per-CPU cache size.  So, in this patch, the data
cache size for each CPU is calculated via data_cache_size /
shared_cpu_weight.

A brute-force algorithm to iterate all online CPUs is used to avoid
to allocate an extra cpumask, especially in offline callback.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: David Hildenbrand <david@redhat.com>
Cc: Johannes Weiner <jweiner@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Lameter <cl@linux.com>
---
 drivers/base/cacheinfo.c  | 42 ++++++++++++++++++++++++++++++++++++++-
 include/linux/cacheinfo.h |  1 +
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index cbae8be1fe52..3e8951a3fbab 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -898,6 +898,41 @@ static int cache_add_dev(unsigned int cpu)
 	return rc;
 }
 
+static void update_data_cache_size_cpu(unsigned int cpu)
+{
+	struct cpu_cacheinfo *ci;
+	struct cacheinfo *leaf;
+	unsigned int i, nr_shared;
+	unsigned int size_data = 0;
+
+	if (!per_cpu_cacheinfo(cpu))
+		return;
+
+	ci = ci_cacheinfo(cpu);
+	for (i = 0; i < cache_leaves(cpu); i++) {
+		leaf = per_cpu_cacheinfo_idx(cpu, i);
+		if (leaf->type != CACHE_TYPE_DATA &&
+		    leaf->type != CACHE_TYPE_UNIFIED)
+			continue;
+		nr_shared = cpumask_weight(&leaf->shared_cpu_map);
+		if (!nr_shared)
+			continue;
+		size_data += leaf->size / nr_shared;
+	}
+	ci->size_data = size_data;
+}
+
+static void update_data_cache_size(bool cpu_online, unsigned int cpu)
+{
+	unsigned int icpu;
+
+	for_each_online_cpu(icpu) {
+		if (!cpu_online && icpu == cpu)
+			continue;
+		update_data_cache_size_cpu(icpu);
+	}
+}
+
 static int cacheinfo_cpu_online(unsigned int cpu)
 {
 	int rc = detect_cache_attributes(cpu);
@@ -906,7 +941,11 @@ static int cacheinfo_cpu_online(unsigned int cpu)
 		return rc;
 	rc = cache_add_dev(cpu);
 	if (rc)
-		free_cache_attributes(cpu);
+		goto err;
+	update_data_cache_size(true, cpu);
+	return 0;
+err:
+	free_cache_attributes(cpu);
 	return rc;
 }
 
@@ -916,6 +955,7 @@ static int cacheinfo_cpu_pre_down(unsigned int cpu)
 		cpu_cache_sysfs_exit(cpu);
 
 	free_cache_attributes(cpu);
+	update_data_cache_size(false, cpu);
 	return 0;
 }
 
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index a5cfd44fab45..4e7ccfa0c36d 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -73,6 +73,7 @@ struct cacheinfo {
 
 struct cpu_cacheinfo {
 	struct cacheinfo *info_list;
+	unsigned int size_data;
 	unsigned int num_levels;
 	unsigned int num_leaves;
 	bool cpu_map_populated;
-- 
2.39.2

