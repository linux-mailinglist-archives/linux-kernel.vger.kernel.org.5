Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F18177FCA0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353780AbjHQRJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353860AbjHQRJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:09:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6394B2D7D;
        Thu, 17 Aug 2023 10:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692292174; x=1723828174;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZDoG4BC7BU8zigefF8QntKolQiXhY+GRE3lIDVeLi9M=;
  b=R0hvWEhix8E3UjFGqAYdCjp0M3De1yWXsI44xCW8JrZDmJQJNF1CktQS
   prTPcOI7HTTvKVCa/Nqg93IFmrDovoQE0i5CHSnTRnV6BtL5ZztvfjzTV
   96fsQj1UcYDcD9dyF5O08m7mX+52Z54ussRb6ARsH5h7tQnPIw161GGdm
   JaXHw0YVOShWaczuCbRkVppQWAIepWdntfvbKyXO6wyh5jeJMsEeAIw6C
   cAO4tcpkYkjtdL90HUFYjlb72bY0b92aPAtHzcPeMvhsuG5HM8nb2OKXi
   l7V83xsFToHPqqnxYd6Ye738mzXySrZa95FhCCztGkUPxWqIoCFosVXYe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="370340878"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="370340878"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 10:07:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="848944651"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="848944651"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 17 Aug 2023 10:07:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8772EDE4; Thu, 17 Aug 2023 20:06:59 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [rfc, PATCH v1 1/1] min_heap: Make use of cmp_func_t and swap_func_t types
Date:   Thu, 17 Aug 2023 20:06:56 +0300
Message-Id: <20230817170656.731066-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The types.h defines standard types for comparator and swap functions.
Convert min_heap to use it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/min_heap.h | 8 ++++----
 kernel/events/core.c     | 4 ++--
 lib/test_min_heap.c      | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/min_heap.h b/include/linux/min_heap.h
index 44077837385f..14da37caa235 100644
--- a/include/linux/min_heap.h
+++ b/include/linux/min_heap.h
@@ -26,8 +26,8 @@ struct min_heap {
  */
 struct min_heap_callbacks {
 	int elem_size;
-	bool (*less)(const void *lhs, const void *rhs);
-	void (*swp)(void *lhs, void *rhs);
+	cmp_func_t less;
+	swap_func_t swp;
 };
 
 /* Sift the element at pos down the heap. */
@@ -55,7 +55,7 @@ void min_heapify(struct min_heap *heap, int pos,
 		}
 		if (smallest == parent)
 			break;
-		func->swp(smallest, parent);
+		func->swp(smallest, parent, func->elem_size);
 		if (smallest == left)
 			pos = (pos * 2) + 1;
 		else
@@ -127,7 +127,7 @@ void min_heap_push(struct min_heap *heap, const void *element,
 		parent = data + ((pos - 1) / 2) * func->elem_size;
 		if (func->less(parent, child))
 			break;
-		func->swp(parent, child);
+		func->swp(parent, child, func->elem_size);
 	}
 }
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4c72a41f11af..fa344b916290 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3639,7 +3639,7 @@ void __perf_event_task_sched_out(struct task_struct *task,
 	perf_cgroup_switch(next);
 }
 
-static bool perf_less_group_idx(const void *l, const void *r)
+static int perf_less_group_idx(const void *l, const void *r)
 {
 	const struct perf_event *le = *(const struct perf_event **)l;
 	const struct perf_event *re = *(const struct perf_event **)r;
@@ -3647,7 +3647,7 @@ static bool perf_less_group_idx(const void *l, const void *r)
 	return le->group_index < re->group_index;
 }
 
-static void swap_ptr(void *l, void *r)
+static void swap_ptr(void *l, void *r, int size)
 {
 	void **lp = l, **rp = r;
 
diff --git a/lib/test_min_heap.c b/lib/test_min_heap.c
index 7b01b4387cfb..63d0b2f6c060 100644
--- a/lib/test_min_heap.c
+++ b/lib/test_min_heap.c
@@ -11,17 +11,17 @@
 #include <linux/printk.h>
 #include <linux/random.h>
 
-static __init bool less_than(const void *lhs, const void *rhs)
+static __init int less_than(const void *lhs, const void *rhs)
 {
 	return *(int *)lhs < *(int *)rhs;
 }
 
-static __init bool greater_than(const void *lhs, const void *rhs)
+static __init int greater_than(const void *lhs, const void *rhs)
 {
 	return *(int *)lhs > *(int *)rhs;
 }
 
-static __init void swap_ints(void *lhs, void *rhs)
+static __init void swap_ints(void *lhs, void *rhs, int size)
 {
 	int temp = *(int *)lhs;
 
-- 
2.40.0.1.gaa8946217a0b

