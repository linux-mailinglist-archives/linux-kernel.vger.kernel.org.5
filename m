Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F7675DB64
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 11:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjGVJfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 05:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjGVJes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 05:34:48 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B4A30EC;
        Sat, 22 Jul 2023 02:34:45 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R7Lnk3nf7zVjHV;
        Sat, 22 Jul 2023 17:33:14 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 22 Jul 2023 17:34:41 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <james.clark@arm.com>, <tmricht@linux.ibm.com>,
        <ak@linux.intel.com>, <anshuman.khandual@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH v3 2/7] perf evlist: Add evlist__findnew_tracking_event() helper
Date:   Sat, 22 Jul 2023 09:32:14 +0000
Message-ID: <20230722093219.174898-3-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
In-Reply-To: <20230722093219.174898-1-yangjihong1@huawei.com>
References: <20230722093219.174898-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.95]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, intel-bts, intel-pt, and arm-spe may add a dummy event for
tracking to the evlist. We may need to search for the dummy event for
some settings. Therefore, add evlist__findnew_tracking_event() helper.

evlist__findnew_tracking_event() also deal with system_wide maps if
system_wide is true.

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-record.c | 11 +++--------
 tools/perf/util/evlist.c    | 18 ++++++++++++++++++
 tools/perf/util/evlist.h    |  1 +
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index aec18db7ff23..ca83599cc50c 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1295,14 +1295,9 @@ static int record__open(struct record *rec)
 	 */
 	if (opts->target.initial_delay || target__has_cpu(&opts->target) ||
 	    perf_pmus__num_core_pmus() > 1) {
-		pos = evlist__get_tracking_event(evlist);
-		if (!evsel__is_dummy_event(pos)) {
-			/* Set up dummy event. */
-			if (evlist__add_dummy(evlist))
-				return -ENOMEM;
-			pos = evlist__last(evlist);
-			evlist__set_tracking_event(evlist, pos);
-		}
+		pos = evlist__findnew_tracking_event(evlist, false);
+		if (!pos)
+			return -ENOMEM;
 
 		/*
 		 * Enable the dummy event when the process is forked for
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 7ef43f72098e..25c3ebe2c2f5 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1694,6 +1694,24 @@ void evlist__set_tracking_event(struct evlist *evlist, struct evsel *tracking_ev
 	tracking_evsel->tracking = true;
 }
 
+struct evsel *evlist__findnew_tracking_event(struct evlist *evlist, bool system_wide)
+{
+	struct evsel *evsel;
+
+	evsel = evlist__get_tracking_event(evlist);
+	if (!evsel__is_dummy_event(evsel)) {
+		evsel = evlist__add_aux_dummy(evlist, system_wide);
+		if (!evsel)
+			return NULL;
+
+		evlist__set_tracking_event(evlist, evsel);
+	} else if (system_wide) {
+		perf_evlist__go_system_wide(&evlist->core, &evsel->core);
+	}
+
+	return evsel;
+}
+
 struct evsel *evlist__find_evsel_by_str(struct evlist *evlist, const char *str)
 {
 	struct evsel *evsel;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 664c6bf7b3e0..98e7ddb2bd30 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -387,6 +387,7 @@ bool evlist_cpu_iterator__end(const struct evlist_cpu_iterator *evlist_cpu_itr);
 
 struct evsel *evlist__get_tracking_event(struct evlist *evlist);
 void evlist__set_tracking_event(struct evlist *evlist, struct evsel *tracking_evsel);
+struct evsel *evlist__findnew_tracking_event(struct evlist *evlist, bool system_wide);
 
 struct evsel *evlist__find_evsel_by_str(struct evlist *evlist, const char *str);
 
-- 
2.30.GIT

