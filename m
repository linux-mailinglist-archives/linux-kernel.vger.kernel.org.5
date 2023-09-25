Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E51E7AD008
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjIYGVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 02:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjIYGUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:20:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13623FC;
        Sun, 24 Sep 2023 23:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695622805; x=1727158805;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HuA4yAmfyh8wdJhemtg1Bqk3t4Ev3a11ADmaGIxjGhc=;
  b=S0Bt7kgzxgRjAWukG23T3Gtngw56boP0aeVIBvuofAWIUF0NExdL8j5w
   eNxXXS1+ktaN5Zs1cz+HIDuk/OftnkWYv8lYyOoy15SIYEuvyUtyl1woN
   mMUTF1Q1W2QytC6uI9Svdk8ftpeLmbjvm0Rh59Ebbo0YYyALORxoQDb6C
   StKohGNjWYdfIp6oYoSkMl6i+ijU97vJ9cIdn/mpak+furRY/FvOWqMDw
   fk2Oiqfd0GyDB7YUk3a2OHVv73zdARVOvoa2lR6cYceh/km0gXdX8Be6j
   6kfoUOJVNvQYcny1cMbCoEk0BUGrwtVyqRWXF5wCFKiu2n4KaY9DY6Bhl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="445279522"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="445279522"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 23:19:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="818494407"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="818494407"
Received: from b49691a75598.jf.intel.com ([10.54.34.22])
  by fmsmga004.fm.intel.com with ESMTP; 24 Sep 2023 23:19:21 -0700
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
Subject: [RFC PATCH 18/25] perf stat: Handle NMI in hardware-grouping
Date:   Sun, 24 Sep 2023 23:18:17 -0700
Message-Id: <20230925061824.3818631-19-weilin.wang@intel.com>
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

Add an easy nmi watchdog support in grouping. When nmi watchdog is enabled,
we reduce the total num of events could be assigned to one group by 1. A
more efficient solution will be added in later.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 020db8e61..1086da84c 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1850,6 +1850,10 @@ static int insert_new_group(struct list_head *head,
 			   size_t fixed_size)
 {
 	INIT_LIST_HEAD(&new_group->event_head);
+	if (sysctl__nmi_watchdog_enabled()) {
+		pr_debug("NMI watchdog is enabled\n");
+		size -= 1;
+	}
 	fill_counter_bitmap(new_group->gp_counters, 0, size);
 	fill_counter_bitmap(new_group->fixed_counters, 0, fixed_size);
 	new_group->taken_alone = false;
-- 
2.39.3

