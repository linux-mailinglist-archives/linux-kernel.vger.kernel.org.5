Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4A57D5E1F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 00:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344498AbjJXW1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 18:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344499AbjJXW0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 18:26:33 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0071FC9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:24:51 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9cad450d5fso5713242276.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186286; x=1698791086; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WajoJckjAi5zxZaorb4dU2uWdDAXIk6mTnY41FG9EXU=;
        b=JJ9VzC3bW43Azd5O2n6Of+NyrZ7Bb+RhUyU1rR3kznMY8YaBvpibNk77LFITLir0nC
         QUUq2cHXp5lAVByKtm2FPdnS3H61QBYhW3QyrNJkfdBiQtkEhaXZt63lmkiBGCooeq8i
         o6x1PEmm0/0b9AU/IdeQBlUWbT+WI2JtWKjFME+dKrIbYuKDhct8LlAOxzVF/HXP3gqt
         ucgspgiO9BqrQGG2VNBNd8JBohe3YWiLmHRNj8XwIUZ/RAdLVFVwlOFO7Qw70fUEfDT9
         /fvYK0LHOSC9KgQlxb89RDWK+dSRVhlUnCG3OroUqxmEstbXfjhVjRipx2uVt8VwcKbl
         XtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186286; x=1698791086;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WajoJckjAi5zxZaorb4dU2uWdDAXIk6mTnY41FG9EXU=;
        b=Mhq1exi4lRwiBazj6yrqRsGSEzVbs8zZ4OJGYOz/V12imX6xsRrquhP94zz561k40g
         6pyQNLjVcOA9LHje/B1gdUAmoyNZJkkIKhg950J1Y5yO71p1UhIpneuh2zTtnxSmeboW
         tMiGjXmF9GBlfQwCKLvJeEgxGPCcTS8iOar2kc6UnQgX1EdLb55GTC6GFE9zunoWfYvD
         +ZiCAud2TCH58sT7NQuhQdmf/XM51ObzkAKU4xu2TEJCHoeUldFO7TBMrrh4FTN1tz/G
         rEwuBOKJ/7WdsJNPYujjjtG1jGvbKBgnOmOooa+8xw+1+Fc3P9g6mar41P+nXdaDDzVM
         mE7g==
X-Gm-Message-State: AOJu0YxcikDxdsG544pHfZ8V9IfS8U6bYF8y5EufOikQ5DQjp2QAQxka
        M4ba4N5CU+/8KYcm/4+hqSfCzxJcu5xV
X-Google-Smtp-Source: AGHT+IGdsWaxHw9CjDKm+xTm6UJwh6OhSH7496eT1hX0iNXyq3wv5uZFz5DOt5uWHtv4+jubFfcppt830mx9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a05:6902:1083:b0:d9a:47ea:69a5 with SMTP
 id v3-20020a056902108300b00d9a47ea69a5mr366410ybu.1.1698186286686; Tue, 24
 Oct 2023 15:24:46 -0700 (PDT)
Date:   Tue, 24 Oct 2023 15:23:18 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-16-irogers@google.com>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 15/50] perf machine thread: Remove exited threads by default
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

struct thread values hold onto references to mmaps, dsos, etc. When a
thread exits it is necessary to clean all of this memory up by
removing the thread from the machine's threads. Some tools require
this doesn't happen, such as auxtrace events, perf report if offcpu
events exist or if a task list is being generated, so add a
symbol_conf value to make the behavior optional. When an exited thread
is left in the machine's threads, mark it as exited.

This change relates to commit 40826c45eb0b ("perf thread: Remove
notion of dead threads"). Dead threads were removed as they had a
reference count of 0 and were difficult to reason about with the
reference count checker. Here a thread is removed from threads when it
exits, unless via symbol_conf the exited thread isn't remove and is
marked as exited. Reference counting behaves as it normally does.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-report.c   |  7 +++++++
 tools/perf/util/machine.c     | 10 +++++++---
 tools/perf/util/session.c     |  5 +++++
 tools/perf/util/symbol_conf.h |  3 ++-
 tools/perf/util/thread.h      | 14 ++++++++++++++
 5 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index dcedfe00f04d..749246817aed 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1411,6 +1411,13 @@ int cmd_report(int argc, const char **argv)
 	if (ret < 0)
 		goto exit;
 
+	/*
+	 * tasks_mode require access to exited threads to list those that are in
+	 * the data file. Off-cpu events are synthesized after other events and
+	 * reference exited threads.
+	 */
+	symbol_conf.keep_exited_threads = true;
+
 	annotation_options__init(&report.annotation_opts);
 
 	ret = perf_config(report__config, &report);
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 90c750150b19..a985d004aa8d 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2157,9 +2157,13 @@ int machine__process_exit_event(struct machine *machine, union perf_event *event
 	if (dump_trace)
 		perf_event__fprintf_task(event, stdout);
 
-	if (thread != NULL)
-		thread__put(thread);
-
+	if (thread != NULL) {
+		if (symbol_conf.keep_exited_threads)
+			thread__set_exited(thread, /*exited=*/true);
+		else
+			machine__remove_thread(machine, thread);
+	}
+	thread__put(thread);
 	return 0;
 }
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 1e9aa8ed15b6..c6afba7ab1a5 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -115,6 +115,11 @@ static int perf_session__open(struct perf_session *session, int repipe_fd)
 		return -1;
 	}
 
+	if (perf_header__has_feat(&session->header, HEADER_AUXTRACE)) {
+		/* Auxiliary events may reference exited threads, hold onto dead ones. */
+		symbol_conf.keep_exited_threads = true;
+	}
+
 	if (perf_data__is_pipe(data))
 		return 0;
 
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index 2b2fb9e224b0..6040286e07a6 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -43,7 +43,8 @@ struct symbol_conf {
 			disable_add2line_warn,
 			buildid_mmap2,
 			guest_code,
-			lazy_load_kernel_maps;
+			lazy_load_kernel_maps,
+			keep_exited_threads;
 	const char	*vmlinux_name,
 			*kallsyms_name,
 			*source_prefix,
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index e79225a0ea46..0df775b5c110 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -36,13 +36,22 @@ struct thread_rb_node {
 };
 
 DECLARE_RC_STRUCT(thread) {
+	/** @maps: mmaps associated with this thread. */
 	struct maps		*maps;
 	pid_t			pid_; /* Not all tools update this */
+	/** @tid: thread ID number unique to a machine. */
 	pid_t			tid;
+	/** @ppid: parent process of the process this thread belongs to. */
 	pid_t			ppid;
 	int			cpu;
 	int			guest_cpu; /* For QEMU thread */
 	refcount_t		refcnt;
+	/**
+	 * @exited: Has the thread had an exit event. Such threads are usually
+	 * removed from the machine's threads but some events/tools require
+	 * access to dead threads.
+	 */
+	bool			exited;
 	bool			comm_set;
 	int			comm_len;
 	struct list_head	namespaces_list;
@@ -189,6 +198,11 @@ static inline refcount_t *thread__refcnt(struct thread *thread)
 	return &RC_CHK_ACCESS(thread)->refcnt;
 }
 
+static inline void thread__set_exited(struct thread *thread, bool exited)
+{
+	RC_CHK_ACCESS(thread)->exited = exited;
+}
+
 static inline bool thread__comm_set(const struct thread *thread)
 {
 	return RC_CHK_ACCESS(thread)->comm_set;
-- 
2.42.0.758.gaed0368e0e-goog

