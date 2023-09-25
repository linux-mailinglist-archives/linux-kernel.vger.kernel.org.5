Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFF27AD00A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjIYGV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 02:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjIYGUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:20:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AD5126;
        Sun, 24 Sep 2023 23:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695622810; x=1727158810;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9UMN3WZoocsNCZA/WkP90QJko5sdpEGQyaq/bysRWVc=;
  b=ato+KAheI19ZkAGjBsjq2msM6kandZnColS+jjD5WSUNwlOEirb0nkJ5
   8DEhx15n6spgkM/VQUcei469WcYKGWWQq7ZFHHRSU6zVavkOrMi9RQ2Ya
   MkgLH9Hg1K8gLpsh7+vTFkBK/O1hbi6ynNUeCPU7TfZAX1NUUfzlgjvUb
   nm7Tcsj7YGWxNeHO5t6vL4nzFABhcvm/CqmsASVD5OVVz5rNGKjWYtX0D
   cELZJ/3ZTNFJR+3BR0JBdPGs5ih9nKcO1D0XQYU9ekl2FebyDdPZWuADT
   1ZjXXq1qiSAbLZqu9PsUt1UbVd2dZkLADG4HL24dBrBVqAHANZ0+VHLx6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="445279564"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="445279564"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 23:19:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="818494453"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="818494453"
Received: from b49691a75598.jf.intel.com ([10.54.34.22])
  by fmsmga004.fm.intel.com with ESMTP; 24 Sep 2023 23:19:25 -0700
From:   weilin.wang@intel.com
To:     weilin.wang@intel.com, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [RFC PATCH 24/25] perf stat: Add check to ensure correctness in platform that does not support hardware-grouping
Date:   Sun, 24 Sep 2023 23:18:23 -0700
Message-Id: <20230925061824.3818631-25-weilin.wang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230925061824.3818631-1-weilin.wang@intel.com>
References: <20230925061824.3818631-1-weilin.wang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weilin Wang <weilin.wang@intel.com>

Add check and return with -EINVAL when event json files do not support
hardware aware grouping so that the program could successfully fall back to
normal grouping without segfault.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 6a4404226..1c89c9371 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1684,6 +1684,8 @@ static int metricgroup__add_metric_event_callback(const struct pmu_event *pe,
 	struct metricgroup__add_metric_event_data *d = data;
 
 	if (!strcasecmp(pe->name, d->event_name)) {
+		if (!pe->counter)
+			return -EINVAL;
 		event = event_info__new(d->event_id, pe->pmu, pe->counter,
 					pe->taken_alone, /*free_counter=*/false);
 		if (!event)
-- 
2.39.3

