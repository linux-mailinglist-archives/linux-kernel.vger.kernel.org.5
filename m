Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD82C779E47
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 10:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbjHLIwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 04:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235796AbjHLIwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 04:52:03 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFF42D52;
        Sat, 12 Aug 2023 01:52:06 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RNDrF20D9zTlp3;
        Sat, 12 Aug 2023 16:50:05 +0800 (CST)
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
Subject: [RFC v1 06/16] perf kwork: Set default events list if not specified in setup_event_list()
Date:   Sat, 12 Aug 2023 08:49:07 +0000
Message-ID: <20230812084917.169338-7-yangjihong1@huawei.com>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when no kwork event is specified, all events are configured by
default. Now set to default event list string, which is more flexible and
supports subsequent function extension.
Also put setup_event_list() into each subcommand for different settings.

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-kwork.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index f620911a26a2..e859c34b23f3 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -1623,8 +1623,11 @@ static void setup_event_list(struct perf_kwork *kwork,
 	struct kwork_class *class;
 	char *tmp, *tok, *str;
 
+	/*
+	 * set default events list if not specified
+	 */
 	if (kwork->event_list_str == NULL)
-		goto null_event_list_str;
+		kwork->event_list_str = "irq, softirq, workqueue";
 
 	str = strdup(kwork->event_list_str);
 	for (tok = strtok_r(str, ", ", &tmp);
@@ -1643,17 +1646,6 @@ static void setup_event_list(struct perf_kwork *kwork,
 	}
 	free(str);
 
-null_event_list_str:
-	/*
-	 * config all kwork events if not specified
-	 */
-	if (list_empty(&kwork->class_list)) {
-		for (i = 0; i < KWORK_CLASS_MAX; i++) {
-			list_add_tail(&kwork_class_supported_list[i]->list,
-				      &kwork->class_list);
-		}
-	}
-
 	pr_debug("Config event list:");
 	list_for_each_entry(class, &kwork->class_list, list)
 		pr_debug(" %s", class->name);
@@ -1835,12 +1827,12 @@ int cmd_kwork(int argc, const char **argv)
 	if (!argc)
 		usage_with_options(kwork_usage, kwork_options);
 
-	setup_event_list(&kwork, kwork_options, kwork_usage);
 	sort_dimension__add(&kwork, "id", &kwork.cmp_id);
 
-	if (strlen(argv[0]) > 2 && strstarts("record", argv[0]))
+	if (strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
+		setup_event_list(&kwork, kwork_options, kwork_usage);
 		return perf_kwork__record(&kwork, argc, argv);
-	else if (strlen(argv[0]) > 2 && strstarts("report", argv[0])) {
+	} else if (strlen(argv[0]) > 2 && strstarts("report", argv[0])) {
 		kwork.sort_order = default_report_sort_order;
 		if (argc > 1) {
 			argc = parse_options(argc, argv, report_options, report_usage, 0);
@@ -1849,6 +1841,7 @@ int cmd_kwork(int argc, const char **argv)
 		}
 		kwork.report = KWORK_REPORT_RUNTIME;
 		setup_sorting(&kwork, report_options, report_usage);
+		setup_event_list(&kwork, kwork_options, kwork_usage);
 		return perf_kwork__report(&kwork);
 	} else if (strlen(argv[0]) > 2 && strstarts("latency", argv[0])) {
 		kwork.sort_order = default_latency_sort_order;
@@ -1859,6 +1852,7 @@ int cmd_kwork(int argc, const char **argv)
 		}
 		kwork.report = KWORK_REPORT_LATENCY;
 		setup_sorting(&kwork, latency_options, latency_usage);
+		setup_event_list(&kwork, kwork_options, kwork_usage);
 		return perf_kwork__report(&kwork);
 	} else if (strlen(argv[0]) > 2 && strstarts("timehist", argv[0])) {
 		if (argc > 1) {
@@ -1867,6 +1861,7 @@ int cmd_kwork(int argc, const char **argv)
 				usage_with_options(timehist_usage, timehist_options);
 		}
 		kwork.report = KWORK_REPORT_TIMEHIST;
+		setup_event_list(&kwork, kwork_options, kwork_usage);
 		return perf_kwork__timehist(&kwork);
 	} else
 		usage_with_options(kwork_usage, kwork_options);
-- 
2.30.GIT

