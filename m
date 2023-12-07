Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16127807DAD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442095AbjLGBRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442019AbjLGBRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:17:32 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C69ED72
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 17:17:37 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d98fde753eso1778947b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 17:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911856; x=1702516656; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SY+VZ2g7Sz9SUrig6hGASQIeGQdVI2UxDJkUdRi/lk4=;
        b=f0LC3uUW/cEQraZC/IobZ9ZkfT2/zJsoAuA/0MNe2oMW01UFK78qQwd4PSU7p0eJRo
         DLx3AAIgMYFN4Yne9xVwhS32HXCV7TedGCVR7O2/2n3XafEL7A6Te0r8Dpct63E5pS3o
         4TWlSzI64OP+0iCt3zQjDrqDVLcCGXtYRztkxKEU6BNtUEa1FyVhmt+95/Tr9A28qIvi
         wTWhQlEd/x+i4Q4znhc4uPbkhBt70B5sgfObCTFoWUID36Ygrd4EbCsIvVdwl6zB6muu
         iKcqm5smsc1UmCVMZA1SyznCIc3UWpoCpl/OWj9HX1LlDuKU5yyhy3vI4Zrc8LWymoqe
         JXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911856; x=1702516656;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SY+VZ2g7Sz9SUrig6hGASQIeGQdVI2UxDJkUdRi/lk4=;
        b=dca6/p8UwpWxllc5i1wNE1QcvA6KNik5CW38C1VAUq3B6+CdFFGa+zp/URW7fuBuhu
         sH4of46hO2MytQwXpRqntNMBrvwXKv4KQOGvmCmUy8qOuCqDEK+UbkKFVaam3sRAF1cC
         oKRnqO5hAATVmyvdnuGaj3xzXMcIytPBZI4OPkjIUzwl6T6sIUS0BUC3N061vovWqKoa
         Woia0CsvWGGT9xnNNngO/0RvW4C8O/sviJsKzqitQ8UNg3IlFuzQmxYDhnkWjZ4t/Dwa
         fTgcGnPR+SLUV3QdbguVBISm/aP7jBri0/+untFGjmE2etjMfipdDdnm8iRwbGoyNs39
         deeA==
X-Gm-Message-State: AOJu0YxAbygKaTMWSrMqKxYRVSsSIFIu/Dl1iT1GVYAR0XMwk3S6t6dN
        u2+Kx0nDwn9MD0VSppm4BqjuEbKJzxB5
X-Google-Smtp-Source: AGHT+IGVWPHm9Dm5cf3RddNOyUG7uObFhuAf0TozauBkiT/nzt0KQG+s2iZOiUNbOR/dOOKeFIx+Rr1RWgkd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a05:690c:2847:b0:5d9:4242:8d21 with SMTP
 id ed7-20020a05690c284700b005d942428d21mr23555ywb.9.1701911856720; Wed, 06
 Dec 2023 17:17:36 -0800 (PST)
Date:   Wed,  6 Dec 2023 17:16:38 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-5-irogers@google.com>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 04/47] perf report: Use function to add missing maps lock
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ming Wang <wangming01@loongson.cn>,
        James Clark <james.clark@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
        Sandipan Das <sandipan.das@amd.com>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch maps__fprintf_task from loop macro maps__for_each_entry to
maps__for_each_map function that takes a callback. The function holds
the maps lock, which should be held during iteration.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-report.c | 54 +++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 17 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 121a2781323c..a5d7bc5b843f 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -859,27 +859,47 @@ static struct task *tasks_list(struct task *task, struct machine *machine)
 	return tasks_list(parent_task, machine);
 }
 
-static size_t maps__fprintf_task(struct maps *maps, int indent, FILE *fp)
+struct maps__fprintf_task_args {
+	int indent;
+	FILE *fp;
+	size_t printed;
+};
+
+static int maps__fprintf_task_cb(struct map *map, void *data)
 {
-	size_t printed = 0;
-	struct map_rb_node *rb_node;
+	struct maps__fprintf_task_args *args = data;
+	const struct dso *dso = map__dso(map);
+	u32 prot = map__prot(map);
+	int ret;
 
-	maps__for_each_entry(maps, rb_node) {
-		struct map *map = rb_node->map;
-		const struct dso *dso = map__dso(map);
-		u32 prot = map__prot(map);
+	ret = fprintf(args->fp,
+		"%*s  %" PRIx64 "-%" PRIx64 " %c%c%c%c %08" PRIx64 " %" PRIu64 " %s\n",
+		args->indent, "", map__start(map), map__end(map),
+		prot & PROT_READ ? 'r' : '-',
+		prot & PROT_WRITE ? 'w' : '-',
+		prot & PROT_EXEC ? 'x' : '-',
+		map__flags(map) ? 's' : 'p',
+		map__pgoff(map),
+		dso->id.ino, dso->name);
 
-		printed += fprintf(fp, "%*s  %" PRIx64 "-%" PRIx64 " %c%c%c%c %08" PRIx64 " %" PRIu64 " %s\n",
-				   indent, "", map__start(map), map__end(map),
-				   prot & PROT_READ ? 'r' : '-',
-				   prot & PROT_WRITE ? 'w' : '-',
-				   prot & PROT_EXEC ? 'x' : '-',
-				   map__flags(map) ? 's' : 'p',
-				   map__pgoff(map),
-				   dso->id.ino, dso->name);
-	}
+	if (ret < 0)
+		return ret;
+
+	args->printed += ret;
+	return 0;
+}
+
+static size_t maps__fprintf_task(struct maps *maps, int indent, FILE *fp)
+{
+	struct maps__fprintf_task_args args = {
+		.indent = indent,
+		.fp = fp,
+		.printed = 0,
+	};
+
+	maps__for_each_map(maps, maps__fprintf_task_cb, &args);
 
-	return printed;
+	return args.printed;
 }
 
 static void task__print_level(struct task *task, FILE *fp, int level)
-- 
2.43.0.rc2.451.g8631bc7472-goog

