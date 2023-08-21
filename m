Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFEA782134
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 03:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjHUBaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 21:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjHUBad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 21:30:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1C5AB;
        Sun, 20 Aug 2023 18:30:30 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RTZZk2P1XzNmp5;
        Mon, 21 Aug 2023 09:26:54 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 21 Aug 2023 09:30:27 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <james.clark@arm.com>, <tmricht@linux.ibm.com>,
        <ak@linux.intel.com>, <anshuman.khandual@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH v6 1/7] perf evlist: Add perf_evlist__go_system_wide() helper
Date:   Mon, 21 Aug 2023 01:27:28 +0000
Message-ID: <20230821012734.18241-2-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
In-Reply-To: <20230821012734.18241-1-yangjihong1@huawei.com>
References: <20230821012734.18241-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.95]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For dummy events that keep tracking, we may need to modify its cpu_maps.
For example, change the cpu_maps to record sideband events for all CPUS.
Add perf_evlist__go_system_wide() helper to support this scenario.

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/lib/perf/evlist.c                  | 9 +++++++++
 tools/lib/perf/include/internal/evlist.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index b8b066d0dc5e..3acbbccc1901 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -738,3 +738,12 @@ int perf_evlist__nr_groups(struct perf_evlist *evlist)
 	}
 	return nr_groups;
 }
+
+void perf_evlist__go_system_wide(struct perf_evlist *evlist, struct perf_evsel *evsel)
+{
+	if (!evsel->system_wide) {
+		evsel->system_wide = true;
+		if (evlist->needs_map_propagation)
+			__perf_evlist__propagate_maps(evlist, evsel);
+	}
+}
diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
index 3339bc2f1765..d86ffe8ed483 100644
--- a/tools/lib/perf/include/internal/evlist.h
+++ b/tools/lib/perf/include/internal/evlist.h
@@ -135,4 +135,6 @@ int perf_evlist__id_add_fd(struct perf_evlist *evlist,
 void perf_evlist__reset_id_hash(struct perf_evlist *evlist);
 
 void __perf_evlist__set_leader(struct list_head *list, struct perf_evsel *leader);
+
+void perf_evlist__go_system_wide(struct perf_evlist *evlist, struct perf_evsel *evsel);
 #endif /* __LIBPERF_INTERNAL_EVLIST_H */
-- 
2.30.GIT

