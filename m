Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8457E6FB4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343989AbjKIQwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbjKIQwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:52:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C488F6F9B;
        Thu,  9 Nov 2023 08:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699548073; x=1731084073;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KzH3foBT6935svPDaKLGpoAT5Z4PddTwZ1RPNXFCxow=;
  b=kk/oULXCCUHAByIHMC3ioK0C4IA09eVIH2jeDnm142TA7fQAeYV5gKKy
   40Bki5PjtNRP6NypT1hNClLQbwy+3+60aGXMUA0e+yqr0rI+G48rLHhXu
   062wNfIdYOtvo0cjkPayzTEyD+Hb16A4AY7s+aWAF7UMEAIYyDrl3+6NT
   6mv+Jy8yEwh5ceaEo5idXBj67ReMRQIJis4YQuNhZHxxLLc0Kc6FLxtXl
   rMlfEudU88DOeYSX8kQe6InD6oO6xgV0Qv8cQ1nKlV82uh71NU2EY7ypS
   WeS6PwmgET7IH9ass3DvSnoNYyPkUro/tJUgG9u7YolYcO85/e1/yn3kK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="388879751"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="388879751"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 08:41:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="763462743"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="763462743"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga002.jf.intel.com with ESMTP; 09 Nov 2023 08:41:04 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, irogers@google.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com,
        tinghao.zhang@intel.com, Kan Liang <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH] perf evsel: Ignore the non-group case for branch counters
Date:   Thu,  9 Nov 2023 08:40:07 -0800
Message-Id: <20231109164007.2037721-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The perf test 27: Sample parsing fails with the branch counters support
introduced.

The branch counters feature requires all the events to belong to a
group. There is no problem with the normal perf usage which usually
initializes an evlist even for a single evsel.
But the perf test is special, which may not initialize an evlist. The
Sample parsing test case is one of the examples. The existing code
crashes with the !evsel->evlist.

Non-group means the evsel doesn't have branch counters support.

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Closes: https://lore.kernel.org/lkml/ZUv+G+w5EvJgQS45@kernel.org/
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/evsel.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 58a9b8c82790..7a6a2d1f96db 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2355,6 +2355,10 @@ static inline bool evsel__has_branch_counters(const struct evsel *evsel)
 {
 	struct evsel *cur, *leader = evsel__leader(evsel);
 
+	/* The branch counters feature only supports group */
+	if (!leader || !evsel->evlist)
+		return false;
+
 	evlist__for_each_entry(evsel->evlist, cur) {
 		if ((leader == evsel__leader(cur)) &&
 		    (cur->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS))
-- 
2.35.1

