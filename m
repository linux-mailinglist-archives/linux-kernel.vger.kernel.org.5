Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6CB807DC3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443132AbjLGBT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442957AbjLGBTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:19:09 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6C21990
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 17:18:42 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d340a9cf07so1750087b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 17:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911922; x=1702516722; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OPdxRcwQgxtYBVUuxZI3Rs6EMAh++C462IioMxtmXNk=;
        b=jMrDVgfmdz8cUs/jIwy7W2ngjBeog09RGtnAHduDyCVUwlKTYL6CgdtTncCFxeH5Kk
         jU0V25otZl6oBgUD2xkPCTTtPlx5kweuXSNzMp7tORYfmtyxqXHgazDCkW1PJbYF0FLh
         1uljYIZB+/bUC+JA2PGPOOdNqX7PxRj2Fo8Tn48ZrIstYWTt5l59ljcDuKnCYJFiG1BJ
         t5AhOP3u7VW4XeEvIerk++mNejuK50N9DSfUEPPswemSbBGktYuT6jtIRCxiRusrTIwd
         AprCTIUHhmbXQL3R1cP1wBzLU0+GsA8PvmMKi/dTKoC72XofyCg0xmHYPTBz95CY6Wqe
         nz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911922; x=1702516722;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OPdxRcwQgxtYBVUuxZI3Rs6EMAh++C462IioMxtmXNk=;
        b=l+iGdr0RePoAvFlElbrILI6Ia28iJpMomNn4ha9gIDFkYRVZPTu0KA/CjDqz81c3Ak
         jME9Lrg7XUM1L3sgdAV34ehC+KwmPyW9DLlpZsS3BUpjUU+7GP1ED6cZdiQA+eBX0fts
         QZmz9L8ZmmCflYYOWm9d1iSvvxw2Tk64FRw9DBhAFMu1CXc3+XC66fjVNpOjnofrzJC4
         +u4wSzo3THGDA+IQM6B+WRQwIVlVR8QC9AfVWi3157yljQJbR4KRdo4WxxH6L4o2x/lW
         yTl0YhHAtJs/ylHE0rSxReNizkUfy3+PjRa4dcHMYQRs/57qgIKT0jPgo7R5BMif9yPE
         tWyw==
X-Gm-Message-State: AOJu0YwTmVf7sZmbOZKM2rqUj6NZ+YGPpsRKPtD1IQtgRFgFa+WKi3ii
        fQhLWcmZN8cyQyP5BAvRbORjIAQtqeZo
X-Google-Smtp-Source: AGHT+IGgy5pcaIzmKknpTFKUfF0GgqrV1ZyGLG73kRf+oZnIhoDxY/i/ccTqzFhpzPJiJ7a9QNQvWPc9ywSp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a81:99d0:0:b0:5d4:3013:25d4 with SMTP id
 q199-20020a8199d0000000b005d4301325d4mr31875ywg.5.1701911921468; Wed, 06 Dec
 2023 17:18:41 -0800 (PST)
Date:   Wed,  6 Dec 2023 17:17:06 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-33-irogers@google.com>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 32/47] perf machine: Move fprintf to for_each loop and a callback
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

Avoid exposing the threads data structure by switching to the callback
machine__for_each_thread approach. machine__fprintf is only used in
tests and verbose >3 output so don't turn to list and sort. Add
machine__threads_nr to be refactored later.

Note, all existing *_fprintf routines ignore fprintf errors.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 43 ++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 7872ce92c9fc..e072b2115b64 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1113,29 +1113,40 @@ size_t machine__fprintf_vmlinux_path(struct machine *machine, FILE *fp)
 	return printed;
 }
 
-size_t machine__fprintf(struct machine *machine, FILE *fp)
+struct machine_fprintf_cb_args {
+	FILE *fp;
+	size_t printed;
+};
+
+static int machine_fprintf_cb(struct thread *thread, void *data)
 {
-	struct rb_node *nd;
-	size_t ret;
-	int i;
+	struct machine_fprintf_cb_args *args = data;
 
-	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
-		struct threads *threads = &machine->threads[i];
+	/* TODO: handle fprintf errors. */
+	args->printed += thread__fprintf(thread, args->fp);
+	return 0;
+}
 
-		down_read(&threads->lock);
+static size_t machine__threads_nr(const struct machine *machine)
+{
+	size_t nr = 0;
 
-		ret = fprintf(fp, "Threads: %u\n", threads->nr);
+	for (int i = 0; i < THREADS__TABLE_SIZE; i++)
+		nr += machine->threads[i].nr;
 
-		for (nd = rb_first_cached(&threads->entries); nd;
-		     nd = rb_next(nd)) {
-			struct thread *pos = rb_entry(nd, struct thread_rb_node, rb_node)->thread;
+	return nr;
+}
 
-			ret += thread__fprintf(pos, fp);
-		}
+size_t machine__fprintf(struct machine *machine, FILE *fp)
+{
+	struct machine_fprintf_cb_args args = {
+		.fp = fp,
+		.printed = 0,
+	};
+	size_t ret = fprintf(fp, "Threads: %zu\n", machine__threads_nr(machine));
 
-		up_read(&threads->lock);
-	}
-	return ret;
+	machine__for_each_thread(machine, machine_fprintf_cb, &args);
+	return ret + args.printed;
 }
 
 static struct dso *machine__get_kernel(struct machine *machine)
-- 
2.43.0.rc2.451.g8631bc7472-goog

