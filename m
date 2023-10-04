Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935A87B8AE0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244535AbjJDSlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243780AbjJDSku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:40:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6B9C6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 11:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696444846; x=1727980846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dXb7QKe6eBS32qydfKpLV9J0fiI9elfImuMMvPKmnxA=;
  b=Ril4Qlp3b4awbnLOPv3BrZQbzv/K/Up53x3S8/MtOhMRq8ZV7IvCZ7GV
   lg48U9gBsqaRB/7XYl+SjMq1I/cjmNehzJ/g3EV2uupgdjJDbUXo6VwEq
   597aYitdH6m1jDL/e2Bu+LpC13Bnw1YNA+gxwvR3/Ddee+7W3uK9YZsaM
   PgDYj/3s0rLVKTYmC608Sogs0mMMcvlZ1vwkQeLhJDWZXKNd7wWIGUUGI
   evOo0SHNsr+9BkP93oasdQ1Yb+D7B4xsIXDZno0hC3ZloTzlDb18AcU46
   jCM/e2qkx5V/X8fl6oqI/I8dsOT7x8pg0o3Niqh6Kz2F7tQbg0VMu346q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="469537687"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="469537687"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 11:40:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="786625996"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="786625996"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga001.jf.intel.com with ESMTP; 04 Oct 2023 11:40:42 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 3/7] perf: Add branch_sample_call_stack
Date:   Wed,  4 Oct 2023 11:40:40 -0700
Message-Id: <20231004184044.3062788-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231004184044.3062788-1-kan.liang@linux.intel.com>
References: <20231004184044.3062788-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Add a helper function to check call stack sample type.

The later patch will invoke the function in several places.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V3

 arch/x86/events/core.c     | 2 +-
 include/linux/perf_event.h | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 40c9af124128..09050641ce5d 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -601,7 +601,7 @@ int x86_pmu_hw_config(struct perf_event *event)
 		}
 	}
 
-	if (event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_CALL_STACK)
+	if (branch_sample_call_stack(event))
 		event->attach_state |= PERF_ATTACH_TASK_DATA;
 
 	/*
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 9ad79f8107cb..826d2d632184 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1143,6 +1143,11 @@ static inline bool branch_sample_counters(const struct perf_event *event)
 	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS;
 }
 
+static inline bool branch_sample_call_stack(const struct perf_event *event)
+{
+	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_CALL_STACK;
+}
+
 struct perf_sample_data {
 	/*
 	 * Fields set by perf_sample_data_init() unconditionally,
-- 
2.35.1

