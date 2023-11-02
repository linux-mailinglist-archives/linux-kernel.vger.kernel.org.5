Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73D37DF94D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 18:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345936AbjKBR61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 13:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345416AbjKBR6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:58:15 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17222D41
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 10:58:08 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a9012ab0adso16607047b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 10:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947887; x=1699552687; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a6Vci0mC9udGUYdKEDx73CiSn3PyEtlzA+5ahyQMAZ4=;
        b=qWsvgZeRlRNWXJmobuMA8ozRIqJP5yfEypLT/BvgSn4T4NLhuMnAH1u1wCgCXM722X
         NMFw7a6XOMHAofd5D3VU2fCG27fU/cPn99EnI6O1svwyYtkknBWj8egFQ1ohOh3DBGLQ
         qDaZryoM4893mfcOThNNrx4R7/SlJ0cIwju7giWiIMBXCk8a+ldBX3/8lpDUz3F6l3qJ
         1bLsVQ6A3csxVGnkJYvMak6oMYg4JQAd8PvUefJPv1aE90k6gBeMC8O/PfRoj1fKsYE4
         UiWp6DBHczlVOeR+P1FVBikMv0NsYmWc61PlPbs3R7ZCG75fBJYHvxmoh8PO0lkARUKA
         bG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947887; x=1699552687;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a6Vci0mC9udGUYdKEDx73CiSn3PyEtlzA+5ahyQMAZ4=;
        b=t1QDKPT3H68FzMes6nUMo1MKayTtUywL9rtQODZVtQwJX5m03xiVox3wnglanSIKEe
         INlO37ZT2IxNP/iQordCgGQmKA/sH1fegKo35gVI+91EFXO6HDO/qMbUUULF90nk+o5K
         9BJuEiaxYfdWx1gnWIAvNqBfEeWi8838Oh44wx9WUYqZGH3ivTuDxHZnjMsdSixVKgBi
         wbZBagKE19cETLn3rLChrzAVNhMFHZO34tDJ2SOfh0+ja+UHq2VWvfQglck0HZRmshJ9
         ugxjT1BrlkCjayHatOLsRumaPoBvLi2HcDwkhY0UmoVgu3ySZ1c5BsN52ywZ84LkMmuA
         1bUg==
X-Gm-Message-State: AOJu0Yyhh6qazMrAdjWz2JXmt5oSmyxaK7Ei0lj6j01K9Rjabf+73v4t
        z6oFiAYJww3B3gOcb+a3Qa5VA54ze2uE
X-Google-Smtp-Source: AGHT+IFVdxlw91qP8b57kxnW7/nVzbvdP5yIx9wN+HMQM3fYfY2qMWgHg8UxgNlfq9Phz416ozPUqLY5wTsM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a81:4855:0:b0:592:83d2:1f86 with SMTP id
 v82-20020a814855000000b0059283d21f86mr8582ywa.4.1698947887136; Thu, 02 Nov
 2023 10:58:07 -0700 (PDT)
Date:   Thu,  2 Nov 2023 10:56:47 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-6-irogers@google.com>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 05/53] perf machine thread: Remove exited threads by default
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
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index 9cb1da2dc0c0..121a2781323c 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1426,6 +1426,13 @@ int cmd_report(int argc, const char **argv)
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
2.42.0.869.gea05f2083d-goog

