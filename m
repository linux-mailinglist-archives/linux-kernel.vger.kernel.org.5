Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75C8807E1F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442979AbjLGBq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjLGBqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:46:55 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2D7D44
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 17:46:59 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d340a9cf07so2021857b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 17:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701913619; x=1702518419; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mhFfuQwYJMUx0Y0TtkV7gyw+ZTlie2ofJkVeioffDkg=;
        b=enIuM9wnFydiqseNlpfJiHcPRlrzxC11aWokEvNEvESERTbGwul/A3Am+NRDCHI0Ax
         Zkw3n0zgVc4mAhzKjGjE/iKaDLLB6VHoMMoNkisUxCdW4kdLPyHV+Oi5/KACvCaE4xkF
         6lrpFcYw6Rsyf07tuWsp292nUZPm3mLSn9ZF6mhvfXOwoimO35RuJzpeZRk6Lvw4VgFA
         Rx+W02GCOA8xTf0rcn3oAwk1+h2o8XKPJcEN3o42+EJAMSU2WzrEQGASy4pZmV4NsaKh
         2ibrvMdrrFEi4mCSwTUSAW+58Z+WNqmjfv4/P+9p4Nv65DxGk1yOvunH2NoVdp+CPDVr
         V0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701913619; x=1702518419;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mhFfuQwYJMUx0Y0TtkV7gyw+ZTlie2ofJkVeioffDkg=;
        b=MVykGJkutIKSvhG6hNYKopE++XzZgYSvCKgwpqerypYjjyoKzSBaz2cStPVp3RVVXh
         JxU3JcO4pd1/HoMPuviqWvQhUOQdgD0PZ0DKY4P4yDJ/lLU9cn09HKyM83nlxYwIfcR3
         fGqXXXDov9Kv5jGJblH54lE7dwnBXISjjUtfTUrwMATLrIE/YEIGTThFenmpRvOl+F54
         +oLzl+STPxBqSQAXCTjPPc3Z3MEuLPHqhl+w9PXkS9UKG+h8odWmusxjtxNNqglTPlOF
         TSt8NITduy/qBHwnuFryYsnbP0BCh//XFCP/Mkn/2oMU4Cyv5np17Kq/B/VFDqwXkTeX
         MEjg==
X-Gm-Message-State: AOJu0Yxa0rdncj8zEoYpaI0YpYBeollrczq3eky39sI85usKa2/lNxW6
        tYDbcIyWV4sZSoc60ETWTyUpv/wIVCTU
X-Google-Smtp-Source: AGHT+IG9KpMTYzzaqe/x0vlLtIZT1sWmkKld593a1HFjOVfiTtGjfMw4X66u7MHITkjIAWFRtn8Cxl3zL8Gg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a81:be18:0:b0:5d0:a744:719d with SMTP id
 i24-20020a81be18000000b005d0a744719dmr30456ywn.1.1701913619019; Wed, 06 Dec
 2023 17:46:59 -0800 (PST)
Date:   Wed,  6 Dec 2023 17:46:55 -0800
Message-Id: <20231207014655.1252484-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v1] perf env: Avoid recursively taking env->bpf_progs.lock
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
        Song Liu <song@kernel.org>, Ming Wang <wangming01@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
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

Add variants of perf_env__insert_bpf_prog_info, perf_env__insert_btf
and perf_env__find_btf prefixed with __ to indicate the
env->bpf_progs.lock is assumed held. Call these variants when the lock
is held to avoid recursively taking it and potentially having a thread
deadlock with itself.

Signed-off-by: Ian Rogers <irogers@google.com>
---
Previously this patch was part of a larger set:
https://lore.kernel.org/lkml/20231127220902.1315692-51-irogers@google.com/
---
 tools/perf/util/bpf-event.c |  8 +++---
 tools/perf/util/bpf-event.h | 12 ++++-----
 tools/perf/util/env.c       | 53 +++++++++++++++++++++++--------------
 tools/perf/util/env.h       |  4 +++
 tools/perf/util/header.c    |  8 +++---
 5 files changed, 51 insertions(+), 34 deletions(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 830711cae30d..3573e0b7ef3e 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -545,9 +545,9 @@ int evlist__add_bpf_sb_event(struct evlist *evlist, struct perf_env *env)
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
@@ -563,7 +563,7 @@ void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
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
index c68b7a004f29..cfdacbf29456 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -22,15 +22,20 @@ struct perf_env perf_env;
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
@@ -42,15 +47,13 @@ void perf_env__insert_bpf_prog_info(struct perf_env *env,
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
@@ -79,14 +82,22 @@ struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
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
@@ -98,25 +109,31 @@ bool perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node)
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
@@ -126,13 +143,9 @@ struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id)
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
index bf7e3c4c211f..7c527e65c186 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -175,12 +175,16 @@ const char *perf_env__raw_arch(struct perf_env *env);
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
index 08cc2febabde..02bf9d8b5f74 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1849,8 +1849,8 @@ static void print_bpf_prog_info(struct feat_fd *ff, FILE *fp)
 		node = rb_entry(next, struct bpf_prog_info_node, rb_node);
 		next = rb_next(&node->rb_node);
 
-		bpf_event__print_bpf_prog_info(&node->info_linear->info,
-					       env, fp);
+		__bpf_event__print_bpf_prog_info(&node->info_linear->info,
+						 env, fp);
 	}
 
 	up_read(&env->bpf_progs.lock);
@@ -3188,7 +3188,7 @@ static int process_bpf_prog_info(struct feat_fd *ff, void *data __maybe_unused)
 		/* after reading from file, translate offset to address */
 		bpil_offs_to_addr(info_linear);
 		info_node->info_linear = info_linear;
-		perf_env__insert_bpf_prog_info(env, info_node);
+		__perf_env__insert_bpf_prog_info(env, info_node);
 	}
 
 	up_write(&env->bpf_progs.lock);
@@ -3235,7 +3235,7 @@ static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
 		if (__do_read(ff, node->data, data_size))
 			goto out;
 
-		perf_env__insert_btf(env, node);
+		__perf_env__insert_btf(env, node);
 		node = NULL;
 	}
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

