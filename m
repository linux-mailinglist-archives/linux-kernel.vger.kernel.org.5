Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D580779E53
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 10:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236604AbjHLIwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 04:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235461AbjHLIwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 04:52:03 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D80D2D44;
        Sat, 12 Aug 2023 01:52:06 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RNDpT48HjzNmnM;
        Sat, 12 Aug 2023 16:48:33 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 12 Aug 2023 16:52:02 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <sandipan.das@amd.com>, <ravi.bangoria@amd.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [RFC v1 04/16] perf kwork: Add `kwork` and `src_type` to work_init() for struct kwork_class
Date:   Sat, 12 Aug 2023 08:49:05 +0000
Message-ID: <20230812084917.169338-5-yangjihong1@huawei.com>
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
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support different types of reports, two parameters
`struct perf_kwork * kwork` and `enum kwork_trace_type src_type` are added
to work_init() of struct kwork_class for initialization in different
scenarios.

No functional change.

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-kwork.c | 16 +++++++++++-----
 tools/perf/util/kwork.h    |  6 ++++--
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index de2fbb7c56c3..42ea59a957ae 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -398,7 +398,7 @@ static int work_push_atom(struct perf_kwork *kwork,
 	struct kwork_work *work, key;
 
 	BUG_ON(class->work_init == NULL);
-	class->work_init(class, &key, evsel, sample, machine);
+	class->work_init(kwork, class, &key, src_type, evsel, sample, machine);
 
 	atom = atom_new(kwork, sample);
 	if (atom == NULL)
@@ -445,7 +445,7 @@ static struct kwork_atom *work_pop_atom(struct perf_kwork *kwork,
 	struct kwork_work *work, key;
 
 	BUG_ON(class->work_init == NULL);
-	class->work_init(class, &key, evsel, sample, machine);
+	class->work_init(kwork, class, &key, src_type, evsel, sample, machine);
 
 	work = work_findnew(&class->work_root, &key, &kwork->cmp_id);
 	if (ret_work != NULL)
@@ -821,8 +821,10 @@ static int irq_class_init(struct kwork_class *class,
 	return 0;
 }
 
-static void irq_work_init(struct kwork_class *class,
+static void irq_work_init(struct perf_kwork *kwork __maybe_unused,
+			  struct kwork_class *class,
 			  struct kwork_work *work,
+			  enum kwork_trace_type src_type __maybe_unused,
 			  struct evsel *evsel,
 			  struct perf_sample *sample,
 			  struct machine *machine __maybe_unused)
@@ -940,8 +942,10 @@ static char *evsel__softirq_name(struct evsel *evsel, u64 num)
 	return name;
 }
 
-static void softirq_work_init(struct kwork_class *class,
+static void softirq_work_init(struct perf_kwork *kwork __maybe_unused,
+			      struct kwork_class *class,
 			      struct kwork_work *work,
+			      enum kwork_trace_type src_type __maybe_unused,
 			      struct evsel *evsel,
 			      struct perf_sample *sample,
 			      struct machine *machine __maybe_unused)
@@ -1031,8 +1035,10 @@ static int workqueue_class_init(struct kwork_class *class,
 	return 0;
 }
 
-static void workqueue_work_init(struct kwork_class *class,
+static void workqueue_work_init(struct perf_kwork *kwork __maybe_unused,
+				struct kwork_class *class,
 				struct kwork_work *work,
+				enum kwork_trace_type src_type __maybe_unused,
 				struct evsel *evsel,
 				struct perf_sample *sample,
 				struct machine *machine)
diff --git a/tools/perf/util/kwork.h b/tools/perf/util/kwork.h
index 53b7327550b8..736c7a08fb19 100644
--- a/tools/perf/util/kwork.h
+++ b/tools/perf/util/kwork.h
@@ -91,6 +91,7 @@ struct kwork_atom_page {
 	DECLARE_BITMAP(bitmap, NR_ATOM_PER_PAGE);
 };
 
+struct perf_kwork;
 struct kwork_class;
 struct kwork_work {
 	/*
@@ -142,8 +143,10 @@ struct kwork_class {
 	int (*class_init)(struct kwork_class *class,
 			  struct perf_session *session);
 
-	void (*work_init)(struct kwork_class *class,
+	void (*work_init)(struct perf_kwork *kwork,
+			  struct kwork_class *class,
 			  struct kwork_work *work,
+			  enum kwork_trace_type src_type,
 			  struct evsel *evsel,
 			  struct perf_sample *sample,
 			  struct machine *machine);
@@ -152,7 +155,6 @@ struct kwork_class {
 			  char *buf, int len);
 };
 
-struct perf_kwork;
 struct trace_kwork_handler {
 	int (*raise_event)(struct perf_kwork *kwork,
 			   struct kwork_class *class, struct evsel *evsel,
-- 
2.30.GIT

