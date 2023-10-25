Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9D07D7553
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 22:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjJYUQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 16:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjJYUQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 16:16:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A694C12A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698264984; x=1729800984;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9gZSBMskh2hZ8fcjIkrsOhLkgVvk84ph0SNH00MJChU=;
  b=KQNd9ANjtgEbPd+T3BhF6MIcJC17ThUxxp4ixMTNqE38w+LYtrsuDUdv
   Vu9kYPR94samjN4R1yh8aO0xZZ5bcMfxPFs74/2p7xaOblhIav1pVsYxl
   fE+9HDqIZ7taO7+HipHraiWehZGq+oTmNY4sBkDamTpk2GuRt/SzL3QMv
   07bpmSYMcUtFNj8lWhGXz6xu6FRhjyuVvkMRUfcvCQcXXZhFOLg/6AQ7+
   sKXqT8wq2v8OYQt5JgG4uqP9udm9YBoVwNZO5Y9OGQ7mcvny2/VMSKEb3
   LLyqohm/j7VeeEnG1kRbqiGi6CCks+abiCmpJw4NuICWrbH/PPAvAbbMH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="377758207"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="377758207"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 13:16:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="752459068"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="752459068"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga007.jf.intel.com with ESMTP; 25 Oct 2023 13:16:22 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V5 3/8] perf: Add branch_sample_call_stack
Date:   Wed, 25 Oct 2023 13:16:21 -0700
Message-Id: <20231025201626.3000228-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231025201626.3000228-1-kan.liang@linux.intel.com>
References: <20231025201626.3000228-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

No changes since V4

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
index 7897ef066027..ac1a59c1f252 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1144,6 +1144,11 @@ static inline bool branch_sample_counters(const struct perf_event *event)
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

