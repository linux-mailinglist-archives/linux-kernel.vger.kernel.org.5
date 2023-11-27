Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284E47FAD32
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbjK0WQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbjK0WPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:15:54 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAF819AE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:11:18 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da03ef6fc30so5305307276.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701123078; x=1701727878; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=flJ8OPW9OE2duil3g02dC/UcgmQJmqs59NyDpSUdHkc=;
        b=U5TeIf5N9jkAMCJrirM1upd3Fw7vkbp3pjJOg3EwVzuKkQ0goF7hVVyzQImO6Mj8cP
         AF93s8xcDOumgFu7QpMMTEcamXdmwEsX31D6F/+NJ9w6HI5Xw01fT1v8ekDw1mVvksMn
         2QfJ2j64gdJpsnrmbIoL2fJARMdli2Z0Yu+VUOLPCsh6piV9zz33JS7X+nKYnjl3NlB8
         LsBFUbab57NOw9UpS84Kr4Ue+NzvPc8DyoAaFKWKfTgGx5Me2ChDkgOHhy5oN8ZsTqm5
         X7mKlGBvA4A2DIUwm3B5AJltJUgcgoiurLOWQNCzW70HXCK7dPoeTK0cumK/ENxp5zVv
         FKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701123078; x=1701727878;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=flJ8OPW9OE2duil3g02dC/UcgmQJmqs59NyDpSUdHkc=;
        b=nZfY+rzeA9+fgjbCwcN4ifUNglmyBCGlMSzVaG3XtLEoBS50Qm9Edm2KmpDjlY0Uvb
         yQA3lNe9lEkyfUYO7i8VeWRCylL/uTXB9ml8os6pOYMWfT76iOW2DrE5wihJApfX9Dg4
         nXmsmMFlu5ALNJ3Bw9u6kXeZwqoxlYqyjWeuhfDMH+c95+MWuxnEEQlgZogwI8MF1ppl
         IM3tpHif829hGipP59B+Px78djwGw0WxtRWhgwHs9dMYTDUc/2OnXFxzBU1Jj3Lzw8/q
         3FUKzcO56Py7cCSRrbEKc21l/geJTPNe/1CVZrhGR8ix00BEftFO/6JZUa8L3qg0EaFj
         muFA==
X-Gm-Message-State: AOJu0YxAWXFNGf+vncD8QSrq6sVg5Ny2s1hVfYyQbywjHYzfV9XtvMWZ
        3ujrfK8ZpuoQeZVAcavzxWYV+SqfQIA+
X-Google-Smtp-Source: AGHT+IF917qDeFk7djUX+HXuf0gYSxJQuCCeKBfYD1XpapUIcXP3vjyTTu/PWLgcvkYDLcMCgIc+PLwJ+fOD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:829:6e77:9093:f39b])
 (user=irogers job=sendgmr) by 2002:a25:ca50:0:b0:daf:5d6b:ef39 with SMTP id
 a77-20020a25ca50000000b00daf5d6bef39mr427374ybg.12.1701123077964; Mon, 27 Nov
 2023 14:11:17 -0800 (PST)
Date:   Mon, 27 Nov 2023 14:09:02 -0800
In-Reply-To: <20231127220902.1315692-1-irogers@google.com>
Message-Id: <20231127220902.1315692-51-irogers@google.com>
Mime-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v5 50/50] perf env: Avoid recursively taking env->bpf_progs.lock
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

Add variants of perf_env__insert_bpf_prog_info, perf_env__insert_btf
and perf_env__find_btf prefixed with __ to indicate the
env->bpf_progs.lock is assumed held. Call these variants when the lock
is held to avoid recursively taking it and potentially having a thread
deadlock with itself.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf-event.c |  8 +++---
 tools/perf/util/bpf-event.h | 12 ++++-----
 tools/perf/util/env.c       | 53 +++++++++++++++++++++++--------------
 tools/perf/util/env.h       |  4 +++
 tools/perf/util/header.c    |  8 +++---
 5 files changed, 51 insertions(+), 34 deletions(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index b564d6fd078a..827695cd0408 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -546,9 +546,9 @@ int evlist__add_bpf_sb_event(struct evlist *evlist, struct perf_env *env)
 	return evlist__add_sb_event(evlist, &attr, bpf_event__sb_cb, env);
 }
 
-void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
-				    struct perf_env *env,
-				    FILE *fp)
+void __bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
+				      struct perf_env *env,
+				      FILE *fp)
 {
 	__u32 *prog_lens = (__u32 *)(uintptr_t)(info->jited_func_lens);
 	__u64 *prog_addrs = (__u64 *)(uintptr_t)(info->jited_ksyms);
@@ -564,7 +564,7 @@ void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
 	if (info->btf_id) {
 		struct btf_node *node;
 
-		node = perf_env__find_btf(env, info->btf_id);
+		node = __perf_env__find_btf(env, info->btf_id);
 		if (node)
 			btf = btf__new((__u8 *)(node->data),
 				       node->data_size);
diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index 1bcbd4fb6c66..e2f0420905f5 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -33,9 +33,9 @@ struct btf_node {
 int machine__process_bpf(struct machine *machine, union perf_event *event,
 			 struct perf_sample *sample);
 int evlist__add_bpf_sb_event(struct evlist *evlist, struct perf_env *env);
-void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
-				    struct perf_env *env,
-				    FILE *fp);
+void __bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
+				      struct perf_env *env,
+				      FILE *fp);
 #else
 static inline int machine__process_bpf(struct machine *machine __maybe_unused,
 				       union perf_event *event __maybe_unused,
@@ -50,9 +50,9 @@ static inline int evlist__add_bpf_sb_event(struct evlist *evlist __maybe_unused,
 	return 0;
 }
 
-static inline void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info __maybe_unused,
-						  struct perf_env *env __maybe_unused,
-						  FILE *fp __maybe_unused)
+static inline void __bpf_event__print_bpf_prog_info(struct bpf_prog_info *info __maybe_unused,
+						    struct perf_env *env __maybe_unused,
+						    FILE *fp __maybe_unused)
 {
 
 }
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index cbc18b22ace5..cb39886b2e81 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -20,15 +20,20 @@ struct perf_env perf_env;
 #include "bpf-utils.h"
 #include <bpf/libbpf.h>
 
-void perf_env__insert_bpf_prog_info(struct perf_env *env,
-				    struct bpf_prog_info_node *info_node)
+void perf_env__insert_bpf_prog_info(struct perf_env *env, struct bpf_prog_info_node *info_node)
+{
+	down_write(&env->bpf_progs.lock);
+	__perf_env__insert_bpf_prog_info(env, info_node);
+	up_write(&env->bpf_progs.lock);
+}
+
+void __perf_env__insert_bpf_prog_info(struct perf_env *env, struct bpf_prog_info_node *info_node)
 {
 	__u32 prog_id = info_node->info_linear->info.id;
 	struct bpf_prog_info_node *node;
 	struct rb_node *parent = NULL;
 	struct rb_node **p;
 
-	down_write(&env->bpf_progs.lock);
 	p = &env->bpf_progs.infos.rb_node;
 
 	while (*p != NULL) {
@@ -40,15 +45,13 @@ void perf_env__insert_bpf_prog_info(struct perf_env *env,
 			p = &(*p)->rb_right;
 		} else {
 			pr_debug("duplicated bpf prog info %u\n", prog_id);
-			goto out;
+			return;
 		}
 	}
 
 	rb_link_node(&info_node->rb_node, parent, p);
 	rb_insert_color(&info_node->rb_node, &env->bpf_progs.infos);
 	env->bpf_progs.infos_cnt++;
-out:
-	up_write(&env->bpf_progs.lock);
 }
 
 struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
@@ -77,14 +80,22 @@ struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
 }
 
 bool perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node)
+{
+	bool ret;
+
+	down_write(&env->bpf_progs.lock);
+	ret = __perf_env__insert_btf(env, btf_node);
+	up_write(&env->bpf_progs.lock);
+	return ret;
+}
+
+bool __perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node)
 {
 	struct rb_node *parent = NULL;
 	__u32 btf_id = btf_node->id;
 	struct btf_node *node;
 	struct rb_node **p;
-	bool ret = true;
 
-	down_write(&env->bpf_progs.lock);
 	p = &env->bpf_progs.btfs.rb_node;
 
 	while (*p != NULL) {
@@ -96,25 +107,31 @@ bool perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node)
 			p = &(*p)->rb_right;
 		} else {
 			pr_debug("duplicated btf %u\n", btf_id);
-			ret = false;
-			goto out;
+			return false;
 		}
 	}
 
 	rb_link_node(&btf_node->rb_node, parent, p);
 	rb_insert_color(&btf_node->rb_node, &env->bpf_progs.btfs);
 	env->bpf_progs.btfs_cnt++;
-out:
-	up_write(&env->bpf_progs.lock);
-	return ret;
+	return true;
 }
 
 struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id)
+{
+	struct btf_node *res;
+
+	down_read(&env->bpf_progs.lock);
+	res = __perf_env__find_btf(env, btf_id);
+	up_read(&env->bpf_progs.lock);
+	return res;
+}
+
+struct btf_node *__perf_env__find_btf(struct perf_env *env, __u32 btf_id)
 {
 	struct btf_node *node = NULL;
 	struct rb_node *n;
 
-	down_read(&env->bpf_progs.lock);
 	n = env->bpf_progs.btfs.rb_node;
 
 	while (n) {
@@ -124,13 +141,9 @@ struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id)
 		else if (btf_id > node->id)
 			n = n->rb_right;
 		else
-			goto out;
+			return node;
 	}
-	node = NULL;
-
-out:
-	up_read(&env->bpf_progs.lock);
-	return node;
+	return NULL;
 }
 
 /* purge data in bpf_progs.infos tree */
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 94596ff124d5..63a4486187b0 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -169,12 +169,16 @@ const char *perf_env__raw_arch(struct perf_env *env);
 int perf_env__nr_cpus_avail(struct perf_env *env);
 
 void perf_env__init(struct perf_env *env);
+void __perf_env__insert_bpf_prog_info(struct perf_env *env,
+				      struct bpf_prog_info_node *info_node);
 void perf_env__insert_bpf_prog_info(struct perf_env *env,
 				    struct bpf_prog_info_node *info_node);
 struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
 							__u32 prog_id);
 bool perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node);
+bool __perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node);
 struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id);
+struct btf_node *__perf_env__find_btf(struct perf_env *env, __u32 btf_id);
 
 int perf_env__numa_node(struct perf_env *env, struct perf_cpu cpu);
 char *perf_env__find_pmu_cap(struct perf_env *env, const char *pmu_name,
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index da4ddc4bdc84..4fcfd1ace6af 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1848,8 +1848,8 @@ static void print_bpf_prog_info(struct feat_fd *ff, FILE *fp)
 		node = rb_entry(next, struct bpf_prog_info_node, rb_node);
 		next = rb_next(&node->rb_node);
 
-		bpf_event__print_bpf_prog_info(&node->info_linear->info,
-					       env, fp);
+		__bpf_event__print_bpf_prog_info(&node->info_linear->info,
+						 env, fp);
 	}
 
 	up_read(&env->bpf_progs.lock);
@@ -3187,7 +3187,7 @@ static int process_bpf_prog_info(struct feat_fd *ff, void *data __maybe_unused)
 		/* after reading from file, translate offset to address */
 		bpil_offs_to_addr(info_linear);
 		info_node->info_linear = info_linear;
-		perf_env__insert_bpf_prog_info(env, info_node);
+		__perf_env__insert_bpf_prog_info(env, info_node);
 	}
 
 	up_write(&env->bpf_progs.lock);
@@ -3234,7 +3234,7 @@ static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
 		if (__do_read(ff, node->data, data_size))
 			goto out;
 
-		perf_env__insert_btf(env, node);
+		__perf_env__insert_btf(env, node);
 		node = NULL;
 	}
 
-- 
2.43.0.rc1.413.gea7ed67945-goog

