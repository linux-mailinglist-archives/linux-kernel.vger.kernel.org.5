Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED9C7AD003
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjIYGUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 02:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjIYGUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:20:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE498CE2;
        Sun, 24 Sep 2023 23:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695622800; x=1727158800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8OgQ64b/TdsjITSk6A0hKAfVN037oU4CWECgJVayCew=;
  b=Dkyf/Uqa19xX9g7pGnKEIOt1J4Q581fqPMZTjNNXmiaI5ndrHLyF828g
   D/Df+qSEFvxIDx77heBQTiW4lnghQwIkdpPoxfPHZOl4nT7wBz7gKARBU
   wqDHdibRrNKibS0y6iC/LP0pCQyv7GwdkFJrwaBTNaDf+oJFUG41bsdq9
   l+E+oQApSMH6b3Mf1QA2I+Pqws7ebDhvcLQ1zHqTJow+sPz+z3J/XUWRk
   Om/30r4GXcDPV+JL0WS0tn8Vv8iNFhU1gBgkE+uhPD/UMufMRaSJDdtuM
   fTqbU7cfOaj75Ine0JqQwEJh4wBC+bkGztJtVZiy+McqG1tYmInCQvc6+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="445279472"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="445279472"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 23:19:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="818494372"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="818494372"
Received: from b49691a75598.jf.intel.com ([10.54.34.22])
  by fmsmga004.fm.intel.com with ESMTP; 24 Sep 2023 23:19:18 -0700
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
Subject: [RFC PATCH 13/25] perf stat: Add functions to hardware-grouping method
Date:   Sun, 24 Sep 2023 23:18:12 -0700
Message-Id: <20230925061824.3818631-14-weilin.wang@intel.com>
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

Add functions to free all the group lists before exit metric grouping

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 39 ++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 8d54e71bf..4b1b0470d 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1528,6 +1528,38 @@ static int parse_counter(const char *counter,
 	return 0;
 }
 
+static void group_event_list_free(struct metricgroup__group *groups)
+{
+	struct metricgroup__group_events *e, *tmp;
+
+	list_for_each_entry_safe (e, tmp, &groups->event_head, nd) {
+		list_del_init(&e->nd);
+		free(e);
+	}
+}
+
+static void group_list_free(struct metricgroup__pmu_group_list *groups)
+{
+	struct metricgroup__group *g, *tmp;
+
+	list_for_each_entry_safe (g, tmp, &groups->group_head, nd) {
+		list_del_init(&g->nd);
+		group_event_list_free(g);
+		free(g);
+	}
+}
+
+static void metricgroup__free_group_list(struct list_head *groups)
+{
+	struct metricgroup__pmu_group_list *g, *tmp;
+
+	list_for_each_entry_safe (g, tmp, groups, nd) {
+		list_del_init(&g->nd);
+		group_list_free(g);
+		free(g);
+	}
+}
+
 static void metricgroup__free_event_info(struct list_head
 					*event_info_list)
 {
@@ -1845,6 +1877,8 @@ static int assign_event_grouping(struct metricgroup__event_info *e,
 		struct metricgroup__pmu_counters *p;
 
 		pmu_group_head = malloc(sizeof(struct metricgroup__pmu_group_list));
+		if (!pmu_group_head)
+			return -ENOMEM;
 		INIT_LIST_HEAD(&pmu_group_head->group_head);
 		pr_debug("create new group for event %s in pmu %s\n", e->name, e->pmu_name);
 		pmu_group_head->pmu_name = e->pmu_name;
@@ -1886,8 +1920,11 @@ static int create_grouping(struct list_head *pmu_info_list,
 		pr_debug("Event name %s, [pmu]=%s, [counters]=%s\n", e->name,
 			e->pmu_name, bit_buf);
 		ret = assign_event_grouping(e, pmu_info_list, &groups);
+		if (ret)
+			goto out;
 	}
-
+out:
+	metricgroup__free_group_list(&groups);
 	return ret;
 };
 
-- 
2.39.3

