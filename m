Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4EC7DF96C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345900AbjKBSAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345959AbjKBR7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:59:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95338D51
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 10:59:03 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da0631f977bso1488433276.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 10:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947943; x=1699552743; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/uke6dz3sLBq95/rU70Wxcl4SlZDeN/n2+8hitECOvo=;
        b=Mb5BKuI0XWCgNBxbPjShHetNd7LYdnc3vKQhlBqVHcs20iGLUmRODSHaLApAUrmAzt
         wnPUkoT8rjCJW6Nw7+e7V/m5y6hVmcT4NaNyRg0PJ/aXT7zvqYIMLkSV23S00GXwBHB7
         Hc5Dq4Frw/x5WsO60emym6jRysfKVVx/rdBxyt1x1NlF+WXJGD0v8ERUlSbv//T9oq6M
         rcLJBhdiYMvATeUccG+p7Vz5/cAlPeuoiVS7Mb4NrOS4ohIo0YLrtFaRuid7r2E80XvZ
         r+2Y/6Cw/5IU0Dptl9fskseELgJzvNdDIyktwd+LYAV8kmLAFzWRnlyjxCjveRliZFz8
         BA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947943; x=1699552743;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/uke6dz3sLBq95/rU70Wxcl4SlZDeN/n2+8hitECOvo=;
        b=GQih7QJRVZzRd8zAVQk2CPRdKdPGX9rlrJnhcofiKW/JD+aR9s7fgP92UmomZ/RiMu
         yDNtP8KDZQDV4ylThK1CYIUEacFRHqego+eRJQ5fxb1KgenefkmVR7h23VC2AGNvkcRY
         p89iRH1Zjwx6zZHBcV1U5PorGh2vo4hTddBbdJJOl2NOz6eSYpzu4iR5ppsGKl40cBO5
         MjaTXyDkoTx3JHPjj0KNvwQKQiGelWk33nL8X6Uwm9t4ZWJtxJ9Cj9q8h0q8lMWdA9Yo
         DhGp7onCpZmrxcDUyqRg7UGSmsqX3LokmpBEzZEVYnU23t+wUsEFZnFlCGu5b/Chce0I
         OYKw==
X-Gm-Message-State: AOJu0YyQf0xHePGm9rh0SlE/kEJfgt7X3LVH/54YtCxSxGZk4FPSHYkm
        1y8VDA50BnUtniQdYarIVmND2T+xLtu6
X-Google-Smtp-Source: AGHT+IFhvleBPR3MXvp+jRIcJindLHAwLW8bfnu6BkmQJIrCUtN9UKutUD9/8CVRafl+Yn2r+NxR3g6J2u3T
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a25:5046:0:b0:da0:433e:871d with SMTP id
 e67-20020a255046000000b00da0433e871dmr325547ybb.7.1698947942693; Thu, 02 Nov
 2023 10:59:02 -0700 (PDT)
Date:   Thu,  2 Nov 2023 10:57:11 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-30-irogers@google.com>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 29/53] perf maps: Get map before returning in maps__find
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Finding a map is done under a lock, returning the map without a
reference count means it can be removed without notice and causing
uses after free. Grab a reference count to the map within the lock
region and return this. Fix up locations that need a map__put
following this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/tests/dwarf-unwind.c |  1 +
 tools/perf/tests/vmlinux-kallsyms.c      |  5 ++---
 tools/perf/util/bpf-event.c              |  1 +
 tools/perf/util/event.c                  |  4 ++--
 tools/perf/util/machine.c                | 22 ++++++++--------------
 tools/perf/util/maps.c                   | 17 ++++++++++-------
 tools/perf/util/symbol.c                 |  3 ++-
 7 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/tools/perf/arch/x86/tests/dwarf-unwind.c b/tools/perf/arch/x86/tests/dwarf-unwind.c
index 5bfec3345d59..c05c0a85dad4 100644
--- a/tools/perf/arch/x86/tests/dwarf-unwind.c
+++ b/tools/perf/arch/x86/tests/dwarf-unwind.c
@@ -34,6 +34,7 @@ static int sample_ustack(struct perf_sample *sample,
 	}
 
 	stack_size = map__end(map) - sp;
+	map__put(map);
 	stack_size = stack_size > STACK_SIZE ? STACK_SIZE : stack_size;
 
 	memcpy(buf, (void *) sp, stack_size);
diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 822f893e67d5..e808e6fc8f76 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -151,10 +151,8 @@ static int test__vmlinux_matches_kallsyms_cb2(struct map *map, void *data)
 	u64 mem_end = map__unmap_ip(args->vmlinux_map, map__end(map));
 
 	pair = maps__find(args->kallsyms.kmaps, mem_start);
-	if (pair == NULL || map__priv(pair))
-		return 0;
 
-	if (map__start(pair) == mem_start) {
+	if (pair != NULL && !map__priv(pair) && map__start(pair) == mem_start) {
 		struct dso *dso = map__dso(map);
 
 		if (!args->header_printed) {
@@ -170,6 +168,7 @@ static int test__vmlinux_matches_kallsyms_cb2(struct map *map, void *data)
 		pr_info(" %s\n", dso->name);
 		map__set_priv(pair, 1);
 	}
+	map__put(pair);
 	return 0;
 }
 
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 830711cae30d..d07fd5ffa823 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -63,6 +63,7 @@ static int machine__process_bpf_event_load(struct machine *machine,
 			dso->bpf_prog.id = id;
 			dso->bpf_prog.sub_id = i;
 			dso->bpf_prog.env = env;
+			map__put(map);
 		}
 	}
 	return 0;
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 68f45e9e63b6..198903157f9e 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -511,7 +511,7 @@ size_t perf_event__fprintf_text_poke(union perf_event *event, struct machine *ma
 		struct addr_location al;
 
 		addr_location__init(&al);
-		al.map = map__get(maps__find(machine__kernel_maps(machine), tp->addr));
+		al.map = maps__find(machine__kernel_maps(machine), tp->addr);
 		if (al.map && map__load(al.map) >= 0) {
 			al.addr = map__map_ip(al.map, tp->addr);
 			al.sym = map__find_symbol(al.map, al.addr);
@@ -641,7 +641,7 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 		return NULL;
 	}
 	al->maps = maps__get(maps);
-	al->map = map__get(maps__find(maps, al->addr));
+	al->map = maps__find(maps, al->addr);
 	if (al->map != NULL) {
 		/*
 		 * Kernel maps might be changed when loading symbols so loading
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index ab345604f274..1112a9dbb21a 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -897,7 +897,6 @@ static int machine__process_ksymbol_register(struct machine *machine,
 	struct symbol *sym;
 	struct dso *dso;
 	struct map *map = maps__find(machine__kernel_maps(machine), event->ksymbol.addr);
-	bool put_map = false;
 	int err = 0;
 
 	if (!map) {
@@ -914,12 +913,6 @@ static int machine__process_ksymbol_register(struct machine *machine,
 			err = -ENOMEM;
 			goto out;
 		}
-		/*
-		 * The inserted map has a get on it, we need to put to release
-		 * the reference count here, but do it after all accesses are
-		 * done.
-		 */
-		put_map = true;
 		if (event->ksymbol.ksym_type == PERF_RECORD_KSYMBOL_TYPE_OOL) {
 			dso->binary_type = DSO_BINARY_TYPE__OOL;
 			dso->data.file_size = event->ksymbol.len;
@@ -953,8 +946,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
 	}
 	dso__insert_symbol(dso, sym);
 out:
-	if (put_map)
-		map__put(map);
+	map__put(map);
 	return err;
 }
 
@@ -978,7 +970,7 @@ static int machine__process_ksymbol_unregister(struct machine *machine,
 		if (sym)
 			dso__delete_symbol(dso, sym);
 	}
-
+	map__put(map);
 	return 0;
 }
 
@@ -1006,11 +998,11 @@ int machine__process_text_poke(struct machine *machine, union perf_event *event,
 		perf_event__fprintf_text_poke(event, machine, stdout);
 
 	if (!event->text_poke.new_len)
-		return 0;
+		goto out;
 
 	if (cpumode != PERF_RECORD_MISC_KERNEL) {
 		pr_debug("%s: unsupported cpumode - ignoring\n", __func__);
-		return 0;
+		goto out;
 	}
 
 	if (dso) {
@@ -1033,7 +1025,8 @@ int machine__process_text_poke(struct machine *machine, union perf_event *event,
 		pr_debug("Failed to find kernel text poke address map for %#" PRI_lx64 "\n",
 			 event->text_poke.addr);
 	}
-
+out:
+	map__put(map);
 	return 0;
 }
 
@@ -1301,9 +1294,10 @@ static int machine__map_x86_64_entry_trampolines_cb(struct map *map, void *data)
 		return 0;
 
 	dest_map = maps__find(args->kmaps, map__pgoff(map));
-	if (dest_map != map)
+	if (RC_CHK_ACCESS(dest_map) != RC_CHK_ACCESS(map))
 		map__set_pgoff(map, map__map_ip(dest_map, map__pgoff(map)));
 
+	map__put(dest_map);
 	args->found = true;
 	return 0;
 }
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 06fdd8a7c2a2..28facfdac1d7 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -487,15 +487,18 @@ void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map, void *data
 struct symbol *maps__find_symbol(struct maps *maps, u64 addr, struct map **mapp)
 {
 	struct map *map = maps__find(maps, addr);
+	struct symbol *result = NULL;
 
 	/* Ensure map is loaded before using map->map_ip */
 	if (map != NULL && map__load(map) >= 0) {
-		if (mapp != NULL)
-			*mapp = map; // TODO: map_put on else path when find returns a get.
-		return map__find_symbol(map, map__map_ip(map, addr));
-	}
+		if (mapp)
+			*mapp = map;
 
-	return NULL;
+		result = map__find_symbol(map, map__map_ip(map, addr));
+		if (!mapp)
+			map__put(map);
+	}
+	return result;
 }
 
 struct maps__find_symbol_by_name_args {
@@ -539,7 +542,7 @@ int maps__find_ams(struct maps *maps, struct addr_map_symbol *ams)
 	if (ams->addr < map__start(ams->ms.map) || ams->addr >= map__end(ams->ms.map)) {
 		if (maps == NULL)
 			return -1;
-		ams->ms.map = maps__find(maps, ams->addr);  // TODO: map_get
+		ams->ms.map = maps__find(maps, ams->addr);
 		if (ams->ms.map == NULL)
 			return -1;
 	}
@@ -848,7 +851,7 @@ struct map *maps__find(struct maps *maps, u64 ip)
 					sizeof(*mapp), map__addr_cmp);
 
 			if (mapp)
-				result = *mapp; // map__get(*mapp);
+				result = map__get(*mapp);
 			done = true;
 		}
 		up_read(maps__lock(maps));
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 30da8a405d11..ad4819a24320 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -757,7 +757,6 @@ static int dso__load_all_kallsyms(struct dso *dso, const char *filename)
 
 static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 {
-	struct map *curr_map;
 	struct symbol *pos;
 	int count = 0;
 	struct rb_root_cached old_root = dso->symbols;
@@ -770,6 +769,7 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 	*root = RB_ROOT_CACHED;
 
 	while (next) {
+		struct map *curr_map;
 		struct dso *curr_map_dso;
 		char *module;
 
@@ -796,6 +796,7 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 			pos->end -= map__start(curr_map) - map__pgoff(curr_map);
 		symbols__insert(&curr_map_dso->symbols, pos);
 		++count;
+		map__put(curr_map);
 	}
 
 	/* Symbols have been adjusted */
-- 
2.42.0.869.gea05f2083d-goog

