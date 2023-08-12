Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A45779E4E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 10:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236816AbjHLIw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 04:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236151AbjHLIwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 04:52:04 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6167D2684;
        Sat, 12 Aug 2023 01:52:07 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RNDs62r94z1GDXR;
        Sat, 12 Aug 2023 16:50:50 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 12 Aug 2023 16:52:04 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <sandipan.das@amd.com>, <ravi.bangoria@amd.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [RFC v1 07/16] perf kwork: Add sched record support
Date:   Sat, 12 Aug 2023 08:49:08 +0000
Message-ID: <20230812084917.169338-8-yangjihong1@huawei.com>
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kwork_class type of sched is added to support recording and parsing of
sched_switch events.

As follows:

  # perf kwork -h

   Usage: perf kwork [<options>] {record|report|latency|timehist}

      -D, --dump-raw-trace  dump raw trace in ASCII
      -f, --force           don't complain, do it
      -k, --kwork <kwork>   list of kwork to profile (irq, softirq, workqueue, sched, etc)
      -v, --verbose         be more verbose (show symbol address, etc)

  # perf kwork -k sched record true
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.083 MB perf.data (47 samples) ]
  # perf evlist
  sched:sched_switch
  dummy:HG
  # Tip: use 'perf evlist --trace-fields' to show fields for tracepoint events

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/Documentation/perf-kwork.txt |  2 +-
 tools/perf/builtin-kwork.c              | 69 ++++++++++++++++++++++++-
 tools/perf/util/kwork.h                 |  5 ++
 3 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-kwork.txt b/tools/perf/Documentation/perf-kwork.txt
index 482d6c52e2ed..2092ab916ea9 100644
--- a/tools/perf/Documentation/perf-kwork.txt
+++ b/tools/perf/Documentation/perf-kwork.txt
@@ -66,7 +66,7 @@ OPTIONS
 
 -k::
 --kwork::
-	List of kwork to profile (irq, softirq, workqueue, etc)
+	List of kwork to profile (irq, softirq, workqueue, sched, etc)
 
 -v::
 --verbose::
diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index e859c34b23f3..4e2b9103b9e0 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -1084,10 +1084,77 @@ static struct kwork_class kwork_workqueue = {
 	.work_name      = workqueue_work_name,
 };
 
+static struct kwork_class kwork_sched;
+static int process_sched_switch_event(struct perf_tool *tool,
+				      struct evsel *evsel,
+				      struct perf_sample *sample,
+				      struct machine *machine)
+{
+	struct perf_kwork *kwork = container_of(tool, struct perf_kwork, tool);
+
+	if (kwork->tp_handler->sched_switch_event)
+		return kwork->tp_handler->sched_switch_event(kwork, &kwork_sched,
+							     evsel, sample, machine);
+	return 0;
+}
+
+const struct evsel_str_handler sched_tp_handlers[] = {
+	{ "sched:sched_switch",  process_sched_switch_event, },
+};
+
+static int sched_class_init(struct kwork_class *class,
+			    struct perf_session *session)
+{
+	if (perf_session__set_tracepoints_handlers(session,
+						   sched_tp_handlers)) {
+		pr_err("Failed to set sched tracepoints handlers\n");
+		return -1;
+	}
+
+	class->work_root = RB_ROOT_CACHED;
+	return 0;
+}
+
+static void sched_work_init(struct perf_kwork *kwork __maybe_unused,
+			    struct kwork_class *class,
+			    struct kwork_work *work,
+			    enum kwork_trace_type src_type,
+			    struct evsel *evsel,
+			    struct perf_sample *sample,
+			    struct machine *machine __maybe_unused)
+{
+	work->class = class;
+	work->cpu = sample->cpu;
+
+	if (src_type == KWORK_TRACE_EXIT) {
+		work->id = evsel__intval(evsel, sample, "prev_pid");
+		work->name = strdup(evsel__strval(evsel, sample, "prev_comm"));
+	} else if (src_type == KWORK_TRACE_ENTRY) {
+		work->id = evsel__intval(evsel, sample, "next_pid");
+		work->name = strdup(evsel__strval(evsel, sample, "next_comm"));
+	}
+}
+
+static void sched_work_name(struct kwork_work *work, char *buf, int len)
+{
+	snprintf(buf, len, "%s", work->name);
+}
+
+static struct kwork_class kwork_sched = {
+	.name		= "sched",
+	.type		= KWORK_CLASS_SCHED,
+	.nr_tracepoints	= ARRAY_SIZE(sched_tp_handlers),
+	.tp_handlers	= sched_tp_handlers,
+	.class_init	= sched_class_init,
+	.work_init	= sched_work_init,
+	.work_name	= sched_work_name,
+};
+
 static struct kwork_class *kwork_class_supported_list[KWORK_CLASS_MAX] = {
 	[KWORK_CLASS_IRQ]       = &kwork_irq,
 	[KWORK_CLASS_SOFTIRQ]   = &kwork_softirq,
 	[KWORK_CLASS_WORKQUEUE] = &kwork_workqueue,
+	[KWORK_CLASS_SCHED]     = &kwork_sched,
 };
 
 static void print_separator(int len)
@@ -1740,7 +1807,7 @@ int cmd_kwork(int argc, const char **argv)
 	OPT_BOOLEAN('D', "dump-raw-trace", &dump_trace,
 		    "dump raw trace in ASCII"),
 	OPT_STRING('k', "kwork", &kwork.event_list_str, "kwork",
-		   "list of kwork to profile (irq, softirq, workqueue, etc)"),
+		   "list of kwork to profile (irq, softirq, workqueue, sched, etc)"),
 	OPT_BOOLEAN('f', "force", &kwork.force, "don't complain, do it"),
 	OPT_END()
 	};
diff --git a/tools/perf/util/kwork.h b/tools/perf/util/kwork.h
index 736c7a08fb19..f8e9cdd1371a 100644
--- a/tools/perf/util/kwork.h
+++ b/tools/perf/util/kwork.h
@@ -16,6 +16,7 @@ enum kwork_class_type {
 	KWORK_CLASS_IRQ,
 	KWORK_CLASS_SOFTIRQ,
 	KWORK_CLASS_WORKQUEUE,
+	KWORK_CLASS_SCHED,
 	KWORK_CLASS_MAX,
 };
 
@@ -167,6 +168,10 @@ struct trace_kwork_handler {
 	int (*exit_event)(struct perf_kwork *kwork,
 			  struct kwork_class *class, struct evsel *evsel,
 			  struct perf_sample *sample, struct machine *machine);
+
+	int (*sched_switch_event)(struct perf_kwork *kwork,
+				  struct kwork_class *class, struct evsel *evsel,
+				  struct perf_sample *sample, struct machine *machine);
 };
 
 struct perf_kwork {
-- 
2.30.GIT

