Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A217C9EC4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 07:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjJPFaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 01:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjJPFaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 01:30:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92274E0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 22:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697434227; x=1728970227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Td3CNuYVe/DvxEXYqqfRgCRBE8gOU4QwgmItjh0k3pc=;
  b=Kh1RC1FG0a8m+brU8tGlY3EZmzgU+pWCKmKF3VL0FRWMZ3CKtZ93cVot
   egoDiMIU0+06bBL799dwV1ibMF2dMp/eiSLClpVSfftyd+rYvtsCCfiA8
   /ESAh3hBEaD7yEbv2K7rcSms4EJAEkOP7UI6RZuxbd7wh6TI7GWIq4j7i
   kcrdTcjPcXqLoXk0fBnLo1CeLBJpZVCxzTBq8UjhOtq8wWLr/edLBoFIA
   AcY9BfVbgaSPMHAjjgum0XO7cpgUhObAf7MnByr6R3Wek8YDwskZXtuL6
   jM237bJLtayRe/7y4HkgL3Fn8yr7Q7w7OLC9GYB4GIV6WXgtZSidYdQbf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="389307964"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="389307964"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 22:30:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="899356650"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="899356650"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.6.133])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 22:28:25 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>
Subject: [PATCH -V3 2/9] cacheinfo: calculate size of per-CPU data cache slice
Date:   Mon, 16 Oct 2023 13:29:55 +0800
Message-Id: <20231016053002.756205-3-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016053002.756205-1-ying.huang@intel.com>
References: <20231016053002.756205-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This can be used to estimate the size of the data cache slice that can
be used by one CPU under ideal circumstances.  Both DATA caches and
UNIFIED caches are used in calculation.  So, the users need to consider
the impact of the code cache usage.

Because the cache inclusive/non-inclusive information isn't available
now, we just use the size of the per-CPU slice of LLC to make the
result more predictable across architectures.  This may be improved
when more cache information is available in the future.

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
 drivers/base/cacheinfo.c  | 49 ++++++++++++++++++++++++++++++++++++++-
 include/linux/cacheinfo.h |  1 +
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index cbae8be1fe52..585c66fce9d9 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -898,6 +898,48 @@ static int cache_add_dev(unsigned int cpu)
 	return rc;
 }
 
+/*
+ * Calculate the size of the per-CPU data cache slice.  This can be
+ * used to estimate the size of the data cache slice that can be used
+ * by one CPU under ideal circumstances.  UNIFIED caches are counted
+ * in addition to DATA caches.  So, please consider code cache usage
+ * when use the result.
+ *
+ * Because the cache inclusive/non-inclusive information isn't
+ * available, we just use the size of the per-CPU slice of LLC to make
+ * the result more predictable across architectures.
+ */
+static void update_per_cpu_data_slice_size_cpu(unsigned int cpu)
+{
+	struct cpu_cacheinfo *ci;
+	struct cacheinfo *llc;
+	unsigned int nr_shared;
+
+	if (!last_level_cache_is_valid(cpu))
+		return;
+
+	ci = ci_cacheinfo(cpu);
+	llc = per_cpu_cacheinfo_idx(cpu, cache_leaves(cpu) - 1);
+
+	if (llc->type != CACHE_TYPE_DATA && llc->type != CACHE_TYPE_UNIFIED)
+		return;
+
+	nr_shared = cpumask_weight(&llc->shared_cpu_map);
+	if (nr_shared)
+		ci->per_cpu_data_slice_size = llc->size / nr_shared;
+}
+
+static void update_per_cpu_data_slice_size(bool cpu_online, unsigned int cpu)
+{
+	unsigned int icpu;
+
+	for_each_online_cpu(icpu) {
+		if (!cpu_online && icpu == cpu)
+			continue;
+		update_per_cpu_data_slice_size_cpu(icpu);
+	}
+}
+
 static int cacheinfo_cpu_online(unsigned int cpu)
 {
 	int rc = detect_cache_attributes(cpu);
@@ -906,7 +948,11 @@ static int cacheinfo_cpu_online(unsigned int cpu)
 		return rc;
 	rc = cache_add_dev(cpu);
 	if (rc)
-		free_cache_attributes(cpu);
+		goto err;
+	update_per_cpu_data_slice_size(true, cpu);
+	return 0;
+err:
+	free_cache_attributes(cpu);
 	return rc;
 }
 
@@ -916,6 +962,7 @@ static int cacheinfo_cpu_pre_down(unsigned int cpu)
 		cpu_cache_sysfs_exit(cpu);
 
 	free_cache_attributes(cpu);
+	update_per_cpu_data_slice_size(false, cpu);
 	return 0;
 }
 
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index a5cfd44fab45..d504eb4b49ab 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -73,6 +73,7 @@ struct cacheinfo {
 
 struct cpu_cacheinfo {
 	struct cacheinfo *info_list;
+	unsigned int per_cpu_data_slice_size;
 	unsigned int num_levels;
 	unsigned int num_leaves;
 	bool cpu_map_populated;
-- 
2.39.2

