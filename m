Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B37779E58
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 10:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbjHLIwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 04:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236285AbjHLIwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 04:52:06 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6C12684;
        Sat, 12 Aug 2023 01:52:09 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RNDs73NHFzrS89;
        Sat, 12 Aug 2023 16:50:51 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 12 Aug 2023 16:52:06 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <sandipan.das@amd.com>, <ravi.bangoria@amd.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [RFC v1 10/16] perf evsel: Add evsel__intval_common() helper
Date:   Sat, 12 Aug 2023 08:49:11 +0000
Message-ID: <20230812084917.169338-11-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
In-Reply-To: <20230812084917.169338-1-yangjihong1@huawei.com>
References: <20230812084917.169338-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.95]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add evsel__intval_common() helper to search for common_field in
tracepoint format.

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/util/evsel.c | 13 +++++++++++++
 tools/perf/util/evsel.h |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index e41bc4d9925f..f3ad2fa862bf 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2764,6 +2764,11 @@ struct tep_format_field *evsel__field(struct evsel *evsel, const char *name)
 	return tep_find_field(evsel->tp_format, name);
 }
 
+struct tep_format_field *evsel__common_field(struct evsel *evsel, const char *name)
+{
+	return tep_find_common_field(evsel->tp_format, name);
+}
+
 void *evsel__rawptr(struct evsel *evsel, struct perf_sample *sample, const char *name)
 {
 	struct tep_format_field *field = evsel__field(evsel, name);
@@ -2832,6 +2837,14 @@ u64 evsel__intval(struct evsel *evsel, struct perf_sample *sample, const char *n
 
 	return field ? format_field__intval(field, sample, evsel->needs_swap) : 0;
 }
+
+u64 evsel__intval_common(struct evsel *evsel, struct perf_sample *sample, const char *name)
+{
+	struct tep_format_field *field = evsel__common_field(evsel, name);
+
+	return field ? format_field__intval(field, sample, evsel->needs_swap) : 0;
+}
+
 #endif
 
 bool evsel__fallback(struct evsel *evsel, int err, char *msg, size_t msgsize)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 848534ec74fa..815be2491938 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -340,6 +340,7 @@ struct perf_sample;
 #ifdef HAVE_LIBTRACEEVENT
 void *evsel__rawptr(struct evsel *evsel, struct perf_sample *sample, const char *name);
 u64 evsel__intval(struct evsel *evsel, struct perf_sample *sample, const char *name);
+u64 evsel__intval_common(struct evsel *evsel, struct perf_sample *sample, const char *name);
 
 static inline char *evsel__strval(struct evsel *evsel, struct perf_sample *sample, const char *name)
 {
@@ -352,6 +353,7 @@ struct tep_format_field;
 u64 format_field__intval(struct tep_format_field *field, struct perf_sample *sample, bool needs_swap);
 
 struct tep_format_field *evsel__field(struct evsel *evsel, const char *name);
+struct tep_format_field *evsel__common_field(struct evsel *evsel, const char *name);
 
 static inline bool __evsel__match(const struct evsel *evsel, u32 type, u64 config)
 {
-- 
2.30.GIT

