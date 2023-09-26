Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FCD7AE48D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 06:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbjIZEaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 00:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbjIZEaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 00:30:08 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDDDE9;
        Mon, 25 Sep 2023 21:30:00 -0700 (PDT)
Received: from kwepemd200002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rvmtl5tMbzrT3Y;
        Tue, 26 Sep 2023 12:27:43 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd200002.china.huawei.com (7.221.188.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.23; Tue, 26 Sep 2023 12:29:56 +0800
From:   Changbin Du <changbin.du@huawei.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <changbin.du@gmail.com>, Changbin Du <changbin.du@huawei.com>
Subject: [PATCH v5 2/5] perf: util: support string type option for perf_parse_sublevel_options
Date:   Tue, 26 Sep 2023 12:29:35 +0800
Message-ID: <20230926042938.509234-3-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230926042938.509234-1-changbin.du@huawei.com>
References: <20230926042938.509234-1-changbin.du@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200002.china.huawei.com (7.221.188.186)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add string type option to get non-int value.

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/util/parse-sublevel-options.c | 12 +++++++++---
 tools/perf/util/parse-sublevel-options.h |  7 +++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/parse-sublevel-options.c b/tools/perf/util/parse-sublevel-options.c
index a841d17ffd57..d08a1ccc9616 100644
--- a/tools/perf/util/parse-sublevel-options.c
+++ b/tools/perf/util/parse-sublevel-options.c
@@ -34,10 +34,16 @@ static int parse_one_sublevel_option(const char *str,
 		return -1;
 	}
 
-	if (vstr)
-		v = atoi(vstr);
+	if (vstr) {
+		/* The value of option either is a integer or string. */
+		if (opt->value_ptr) {
+			v = atoi(vstr);
+			*opt->value_ptr = v;
+		} else {
+			*opt->str_ptr = strdup(vstr);
+		}
+	}
 
-	*opt->value_ptr = v;
 	free(s);
 	return 0;
 }
diff --git a/tools/perf/util/parse-sublevel-options.h b/tools/perf/util/parse-sublevel-options.h
index 578b18ef03bb..d536ebe43b58 100644
--- a/tools/perf/util/parse-sublevel-options.h
+++ b/tools/perf/util/parse-sublevel-options.h
@@ -3,7 +3,14 @@
 
 struct sublevel_option {
 	const char *name;
+
+	/*
+	 * Only one of below can be non-null. So we simply support
+	 * two types: integer and string. For string, the caller is
+	 * responsible for freeing allocated memory after use.
+	 */
 	int *value_ptr;
+	char **str_ptr;
 };
 
 int perf_parse_sublevel_options(const char *str, struct sublevel_option *opts);
-- 
2.25.1

