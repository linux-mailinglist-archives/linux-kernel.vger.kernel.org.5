Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98227FAD41
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbjK0WRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbjK0WRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:17:08 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640453A9D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:11:14 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5cd1172b815so32108017b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701123073; x=1701727873; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rpLaw8hbZHv7XqyxQ9Py6WtkC7la3Z8RoC95Sww1l2I=;
        b=UXVBl5ndjA5ONhRcW4B1NeeYdMsOYAHUG3eq8tJKR8QLT3M4CJ1WsDFpifm7CWyl+R
         L9dwreoPzxDFUaL9E79IdU3+W2xaqC5vyE11kOq7+aKWu2WpU0NVcq0YV/XRqH4zjWbs
         NrQCxcXhLZwuuTW0cG2ENlSErY5/4ca6NsRnRyfbAtPtI2JqnxPzoswvhGavMYSadnFJ
         1lMWezNp4BiyUUa4Tyxdsaknx25qu1br2DYoj6gVpHyz21W0DF7bhstknoUWawekFJsB
         ing6PB246DvQiQ5Dm6S/85zTq2O0zaMi39pQbkiKeuypeLz9S1S47ux5LxVbG5hbhbux
         haIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701123073; x=1701727873;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rpLaw8hbZHv7XqyxQ9Py6WtkC7la3Z8RoC95Sww1l2I=;
        b=p1oZfrDbWo0LpQX133vtLuwEdgKYullR2APs7tFAo5i7B4prBN2L+UUI/9xZ3PVviE
         Bjefx5vk/6I0accfktE2Q8IdElerDDk9wzocdXtHssgAsqPQGg65FzAX/7ukIAoeI/4b
         O7A5NiSRFUjug6eu7BjjZT+KmZ8RzlJmKnzCxFgHq8y1uiSYLyg2niFU1VGoo/zGqXt5
         W0FNPBA20+pClPcPFr+XtVdJXcaKTqdso2xrVl7VlCfmu5BoYDH0ZWukJm9pth5tBYXp
         3K8t+xIHyWzoWquD0Ua2mq+pZTGWolcsboeEQBEpYq/ePb/0qePwJjHEzcf+/jYUS/IQ
         546Q==
X-Gm-Message-State: AOJu0YyEcn0yqyJUe5TVQAZdnNO9ix/4gTVAo7BtdBovJRYwSt/Tns+r
        vr6nIfKhQ5bw3wcGCBgHu9Y8YLLW/L9Q
X-Google-Smtp-Source: AGHT+IF9K/FWmwNhARnt+v00/5qi9l7thIT8dLqfy7DTS6p3iAY3kTqJO/rkEHiQCl/4vIwzN3KC35Trbn7d
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:829:6e77:9093:f39b])
 (user=irogers job=sendgmr) by 2002:a05:690c:2b82:b0:5cb:ed68:a256 with SMTP
 id en2-20020a05690c2b8200b005cbed68a256mr444784ywb.4.1701123073447; Mon, 27
 Nov 2023 14:11:13 -0800 (PST)
Date:   Mon, 27 Nov 2023 14:09:00 -0800
In-Reply-To: <20231127220902.1315692-1-irogers@google.com>
Message-Id: <20231127220902.1315692-49-irogers@google.com>
Mime-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v5 48/50] perf dso: Reference counting related fixes
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
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure gets and puts are better aligned fixing reference couting
checking problems.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c    |  4 ++--
 tools/perf/util/map.c        |  1 +
 tools/perf/util/symbol-elf.c | 38 +++++++++++++++++-------------------
 3 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index d4534fbc7098..bd1e2da5bb6d 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -683,7 +683,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
 					     struct perf_sample *sample __maybe_unused)
 {
 	struct symbol *sym;
-	struct dso *dso;
+	struct dso *dso = NULL;
 	struct map *map = maps__find(machine__kernel_maps(machine), event->ksymbol.addr);
 	int err = 0;
 
@@ -696,7 +696,6 @@ static int machine__process_ksymbol_register(struct machine *machine,
 		}
 		dso__set_kernel(dso, DSO_SPACE__KERNEL);
 		map = map__new2(0, dso);
-		dso__put(dso);
 		if (!map) {
 			err = -ENOMEM;
 			goto out;
@@ -735,6 +734,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
 	dso__insert_symbol(dso, sym);
 out:
 	map__put(map);
+	dso__put(dso);
 	return err;
 }
 
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 14fb8cf65b13..4480134ef4ea 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -200,6 +200,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 				dso__set_build_id(dso, dso__bid(header_bid_dso));
 				dso__set_header_build_id(dso, 1);
 			}
+			dso__put(header_bid_dso);
 		}
 		dso__put(dso);
 	}
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index de73f9fb3fe4..4c00463abb7e 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1366,7 +1366,7 @@ void __weak arch__sym_update(struct symbol *s __maybe_unused,
 static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 				      GElf_Sym *sym, GElf_Shdr *shdr,
 				      struct maps *kmaps, struct kmap *kmap,
-				      struct dso **curr_dsop, struct map **curr_mapp,
+				      struct dso **curr_dsop,
 				      const char *section_name,
 				      bool adjust_kernel_syms, bool kmodule, bool *remap_kernel)
 {
@@ -1416,8 +1416,8 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 			map__set_pgoff(map, shdr->sh_offset);
 		}
 
-		*curr_mapp = map;
-		*curr_dsop = dso;
+		dso__put(*curr_dsop);
+		*curr_dsop = dso__get(dso);
 		return 0;
 	}
 
@@ -1442,10 +1442,10 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 		dso__set_binary_type(curr_dso, dso__binary_type(dso));
 		dso__set_adjust_symbols(curr_dso, dso__adjust_symbols(dso));
 		curr_map = map__new2(start, curr_dso);
-		dso__put(curr_dso);
-		if (curr_map == NULL)
+		if (curr_map == NULL) {
+			dso__put(curr_dso);
 			return -1;
-
+		}
 		if (dso__kernel(curr_dso))
 			map__kmap(curr_map)->kmaps = kmaps;
 
@@ -1459,21 +1459,15 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 		dso__set_symtab_type(curr_dso, dso__symtab_type(dso));
 		if (maps__insert(kmaps, curr_map))
 			return -1;
-		/*
-		 * Add it before we drop the reference to curr_map, i.e. while
-		 * we still are sure to have a reference to this DSO via
-		 * *curr_map->dso.
-		 */
 		dsos__add(&maps__machine(kmaps)->dsos, curr_dso);
-		/* kmaps already got it */
-		map__put(curr_map);
 		dso__set_loaded(curr_dso);
-		*curr_mapp = curr_map;
+		dso__put(*curr_dsop);
 		*curr_dsop = curr_dso;
 	} else {
-		*curr_dsop = map__dso(curr_map);
-		map__put(curr_map);
+		dso__put(*curr_dsop);
+		*curr_dsop = dso__get(map__dso(curr_map));
 	}
+	map__put(curr_map);
 
 	return 0;
 }
@@ -1484,8 +1478,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 {
 	struct kmap *kmap = dso__kernel(dso) ? map__kmap(map) : NULL;
 	struct maps *kmaps = kmap ? map__kmaps(map) : NULL;
-	struct map *curr_map = map;
-	struct dso *curr_dso = dso;
+	struct dso *curr_dso;
 	Elf_Data *symstrs, *secstrs, *secstrs_run, *secstrs_sym;
 	uint32_t nr_syms;
 	int err = -1;
@@ -1586,6 +1579,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		remap_kernel = true;
 		adjust_kernel_syms = dso__adjust_symbols(dso);
 	}
+	curr_dso = dso__get(dso);
 	elf_symtab__for_each_symbol(syms, nr_syms, idx, sym) {
 		struct symbol *f;
 		const char *elf_name = elf_sym__name(&sym, symstrs);
@@ -1674,8 +1668,11 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 			--sym.st_value;
 
 		if (dso__kernel(dso)) {
-			if (dso__process_kernel_symbol(dso, map, &sym, &shdr, kmaps, kmap, &curr_dso, &curr_map,
-						       section_name, adjust_kernel_syms, kmodule, &remap_kernel))
+			if (dso__process_kernel_symbol(dso, map, &sym, &shdr,
+						       kmaps, kmap, &curr_dso,
+						       section_name,
+						       adjust_kernel_syms,
+						       kmodule, &remap_kernel))
 				goto out_elf_end;
 		} else if ((used_opd && runtime_ss->adjust_symbols) ||
 			   (!used_opd && syms_ss->adjust_symbols)) {
@@ -1724,6 +1721,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		__symbols__insert(dso__symbols(curr_dso), f, dso__kernel(dso));
 		nr++;
 	}
+	dso__put(curr_dso);
 
 	/*
 	 * For misannotated, zeroed, ASM function sizes.
-- 
2.43.0.rc1.413.gea7ed67945-goog

