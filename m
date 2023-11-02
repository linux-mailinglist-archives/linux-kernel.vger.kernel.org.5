Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEFA7DF987
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377143AbjKBSEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235654AbjKBSEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:04:21 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208652D79
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 10:59:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9ab79816a9so1487491276.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 10:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947997; x=1699552797; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W0Aeiri89a2l8MhN1lXBdnG+NxxxLcVo3MoUSdLBJhg=;
        b=JLhPbcEyuZu3OJCCfei9L5cFwBGROU0h+E9NA8vuutUb/pdBFxRi6yLTFlH/ZN2zRU
         pfL/AdrX1AZn5AN5hdP7cN2YHWa38/AMkkNejO5H7gakgvsGLuf42hK+QN5eGSUeaYCn
         SxP7DocfoQMTrm7OSEDU1ChZrpdP/o7GooD9QyhqtEJeAjWTe70UCuwiIvyZ0P81ZBZp
         U1PsC0S8gEou+UHFMsr3EAVMS/vd0SieZdeKZ+TOEmppkPqjz6hmo8g6S8wVcaeVK3F3
         4bHXKWdm8kvlgHk7GgIme5xlQkMWZExsw1ty/UH8kt/yrvXdZnTnzP4BTd/mED0a5GY1
         uKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947997; x=1699552797;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W0Aeiri89a2l8MhN1lXBdnG+NxxxLcVo3MoUSdLBJhg=;
        b=wdH9+nqvwMoFcFJUJQKGBXQWn9SdEibD9sO/XU3lz09H9zSdXP4u013zJgJFSJoprv
         mukDp9uhZTYuliYPoz8VWU1FPOJzceTSs5wE/6LimSaz3wplyiccR9IlE+1qzJA6sdkt
         fffNvU/yqjlUCd/sOeWdsFTcDCZjB6yhSed9pAp++trY6sldpX0WE1yxTAGAMa7Vy2N4
         R4wQ7riLM2J0iT3p3CQTp8JE1zmPjfwuDsAVdbA2Q4maj+SjJrzFpi4Zx3I8KlZXdGbO
         G4UJEHbuyKLrBw5PzAPGTYI1VcFcJNKxI1D9JO/CW+D8GiaBLF2dgb+Yj4vVEoBnkPiM
         qP0w==
X-Gm-Message-State: AOJu0Yzwev96IYUWubVtDlPKViICBDBLb8sJVKtpOcfrSLOe5WkQaQ2X
        Cc5xSJpdSrIHOspykr+K0p+d+Of0Swbm
X-Google-Smtp-Source: AGHT+IEZjGt2xj1Wt/hpK9fUP+0zOzGHtBTt+xYPfFMwR2f47aso0S7tLfEqF0lDl4LJwoR6b2jc1+9ooosx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a25:d7c9:0:b0:da3:b4ef:29fe with SMTP id
 o192-20020a25d7c9000000b00da3b4ef29femr110389ybg.13.1698947997327; Thu, 02
 Nov 2023 10:59:57 -0700 (PDT)
Date:   Thu,  2 Nov 2023 10:57:35 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-54-irogers@google.com>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 53/53] perf env: Avoid recursively taking env->bpf_progs.lock
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
index 44140b7f596a..66ef87176b11 100644
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
index 4566c51f2fd9..359eff51cb85 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -164,12 +164,16 @@ const char *perf_env__raw_arch(struct perf_env *env);
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
index 13e23c386601..310a86c16d88 100644
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
@@ -3179,7 +3179,7 @@ static int process_bpf_prog_info(struct feat_fd *ff, void *data __maybe_unused)
 		/* after reading from file, translate offset to address */
 		bpil_offs_to_addr(info_linear);
 		info_node->info_linear = info_linear;
-		perf_env__insert_bpf_prog_info(env, info_node);
+		__perf_env__insert_bpf_prog_info(env, info_node);
 	}
 
 	up_write(&env->bpf_progs.lock);
@@ -3226,7 +3226,7 @@ static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
 		if (__do_read(ff, node->data, data_size))
 			goto out;
 
-		perf_env__insert_btf(env, node);
+		__perf_env__insert_btf(env, node);
 		node = NULL;
 	}
 
-- 
2.42.0.869.gea05f2083d-goog

