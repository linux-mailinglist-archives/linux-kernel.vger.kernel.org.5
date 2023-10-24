Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6279C7D5E2C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 00:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344518AbjJXW2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 18:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344627AbjJXW2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 18:28:18 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCFC1708
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:25:59 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a909b4e079so58031037b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186359; x=1698791159; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NbxTM76xqJorkOJkA8b8csCodDzMUvbQpbWTOjkDtY8=;
        b=rpYDtR5JPG1CYbQSVc3Eb9sUIcTDJspUBSSZMewAlkB5arZfbDpqaRHs6oQzoNAgrV
         xUqP8OuuDuRIr7wXrw7xfA4ypmlBYjgjIN5aRM2Y22OAd0Bq57s62GdCmRK4yNVQ+wrd
         f48AtAiNsuawowuSE/4fov4a6DmCAogKssgkp9eNQpjPgZkC6u761+mYulbmMpF4dcRE
         GQweSo5W246hfvF2ryMJRdsNh9OL5UxQCRfAINfh9DsQvwGnnR//kl0nRocC7qcJf4uv
         IYGi7ApvaMN+xBxMXKEbH/gFEofhyPEb6RDr9JAj4n4g7F6lIQhKpoa6+jXjhgnwAoXi
         k7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186359; x=1698791159;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NbxTM76xqJorkOJkA8b8csCodDzMUvbQpbWTOjkDtY8=;
        b=ldp2qI4xMkTMJ0QLPWyugcTeNI/hrHdkALfZzglV4VTHBmtWFvcboeOViNdgSMClmj
         pKtO9mw50X7b9Ojs2IJoJA9EPptWJ2+2QOSK9Mgc9R1I6kKrhmuL0PGPAMArkJ8NNzkD
         UHwu6dVmeH528pYAXKQt+kmhnTs4qy/yEFLUHrghoCuUdMi8Km93rg/9T2s/owKMphU6
         blaWkHwHNVLMSVsW7IqNJr8w3m2wmREQWLH0hRoHO9cMBDVsgXzYskb9dr9ZAFeHrBls
         OxG4Qv9+ePTQWJoi2+DzRpdOyqsP2MagIUezZ1gMXtjzrmpoSWRLxsucZ3aJZNuk+XCz
         WHeQ==
X-Gm-Message-State: AOJu0YzLiTyPISrEhuuCfSYbAkWFDJUFsIs6tRTGJdyO8yDVotpl+PE7
        lWISOLnc0Ol4S73cnQ6rgOW+r9wbKHcP
X-Google-Smtp-Source: AGHT+IHz6u4HSsAieNGfWbahI/foiDFtBmaF8ptwxmarWMoc2Wlc0CMbyB0cLowOWqF+wESV11rJKeF4gGQN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a25:c5c1:0:b0:d9a:ce79:6298 with SMTP id
 v184-20020a25c5c1000000b00d9ace796298mr231994ybe.2.1698186358799; Tue, 24 Oct
 2023 15:25:58 -0700 (PDT)
Date:   Tue, 24 Oct 2023 15:23:50 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-48-irogers@google.com>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 47/50] perf machine: Move fprintf to for_each loop and a callback
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
        Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
        Song Liu <song@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index 6d7a505850c8..7e19303d1aa6 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1114,29 +1114,40 @@ size_t machine__fprintf_vmlinux_path(struct machine *machine, FILE *fp)
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
2.42.0.758.gaed0368e0e-goog

