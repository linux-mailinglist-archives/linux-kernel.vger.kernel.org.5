Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C4C77E3C1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343693AbjHPOhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343678AbjHPOgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:36:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585BB2717
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692196606; x=1723732606;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OyKPNhRoXHCMy1Q27SfkblCl7ccMMEKKhLj4ca17UTo=;
  b=mzQzscVJQWucnsBTaCmZKPlsMwfZwUEF+cpp6Lmq3PLWjwcLi7l4g+AO
   oEIsuhJWGHqDr8/cKUHLlD1OqwAlbH424DmsocX/ZHfhQqXZrorG24tXS
   Db5ARBIBW6DfriN25/RHMOGTsbwod168H6vOgPKJ0MoD9KaSFHJ82wm7E
   gJeSI4+ytI1kh3lLb8GObh194tPgOvT4CmPuiZha6xgITku+sw9rxbqkF
   gwedDnZvCjiPOQ/DyUHxKoGG2Es3+6QiG8NS9fKNNdjBHP9agnKSz8HjI
   V6eH8sAY3vKZ7uFmFXWQMQvauMUYeCutKTHEtvGdD2rqoIla3GdOozdZD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="352138643"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="352138643"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 07:36:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="980758848"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="980758848"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga006.fm.intel.com with ESMTP; 16 Aug 2023 07:36:43 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 3/6] perf: Add branch_sample_call_stack
Date:   Wed, 16 Aug 2023 07:36:25 -0700
Message-Id: <20230816143628.1885281-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230816143628.1885281-1-kan.liang@linux.intel.com>
References: <20230816143628.1885281-1-kan.liang@linux.intel.com>
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

New patch

 arch/x86/events/core.c     | 2 +-
 include/linux/perf_event.h | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 2919bb5a53a0..b56e9c3a0cc8 100644
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
index c4877924d43c..58ad6745cdda 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1147,6 +1147,11 @@ static inline bool branch_sample_evt_cntrs(const struct perf_event *event)
 	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_EVT_CNTRS;
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

