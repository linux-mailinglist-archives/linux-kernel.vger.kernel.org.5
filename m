Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EB1807DCC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443143AbjLGBVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443140AbjLGBUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:20:06 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5463A173B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 17:19:15 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d12853cb89so1992357b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 17:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911954; x=1702516754; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OzW9gw1wLwt1D+Yf5/7QICBkkvIkKtfUPJZy4LZ3/Aw=;
        b=kYujtUvepvrKtjDWwj4pi14RNMa47L/WxdWCTnksmSW5bjc5zsFMgCn9ESEBixsHp8
         Him0g8DqBI96eCCCxAActoiTgyfTSnn0atSTRY9MixLzEEsDAva26Tm07WSgLoBtSnl6
         4p0AD7BUH/SsgTJg0DgFrFTQLH7NBTRzNbqmFQkbNjE+wUSMwvj3NjhFuuT8rURi9QaG
         X0NKNyuMx1accmwQor2ItTF2jC3Zw+1WIp/lX4zlvCJNosl20Ub92fiRCt+CCuHaEMk/
         rL6fsQfueSImikdeSfhnUQWOpi+Ovs36l2AMWRcX6lmb16Y/u6uQGY2j/g2Vk4YV6Z9X
         j8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911954; x=1702516754;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OzW9gw1wLwt1D+Yf5/7QICBkkvIkKtfUPJZy4LZ3/Aw=;
        b=B1WcNtz/Nz6HjcJrgxp2fqv5a40TGN/qYH5Wu7Usu6ZXDnWir9Js9AGwS2GYnqQmHH
         iHDwd/xE3Fm+PLp9OoIW1PWdwfYU9G87MTaoC0RpCCiHUVnpbuawzIkaMYbu58Neb5l+
         l73wwZ8wPYfihgIPHoX5OLEqXmh1ZkknCMobpZO3PKhPTiDsTBpRJPfRj9vjWtuVipWd
         3SxrB0pCzHtpWA2JRaZYQ0jJZfh/Sfl80AjG2kB1ZrYswVDkTZ4lnsdnMtWnm6GBux/0
         bs9k0QWDv6PrZuaBw1OGx16KuDpLPyDAFHb8bvI9jyYGPu5LwF8sEv3KoIPyQ9lRbiLN
         rJ0w==
X-Gm-Message-State: AOJu0YyrNSONPQNxQDcNInCmd8hWlBjgI7oIF5s/8sFRdPhMHX9fhxMw
        pk5ZTaDB2wWYMk4EdJM1/AOpiDUkGZvs
X-Google-Smtp-Source: AGHT+IFiTyQLXULMsZzmut5l0rXn9ARlZ50csNRiNGcXML5avZ1xuvOQfZ6Dgy188NbIrjypRYO6iBJBPNdj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a05:690c:2886:b0:5d3:40f3:56bf with SMTP
 id ee6-20020a05690c288600b005d340f356bfmr27527ywb.1.1701911954096; Wed, 06
 Dec 2023 17:19:14 -0800 (PST)
Date:   Wed,  6 Dec 2023 17:17:20 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-47-irogers@google.com>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 46/47] perf dso: Reference counting related fixes
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

Ensure gets and puts are better aligned fixing reference couting
checking problems.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c    |  4 ++--
 tools/perf/util/map.c        |  1 +
 tools/perf/util/symbol-elf.c | 38 +++++++++++++++++-------------------
 3 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 49b8ccd5affe..2dbb7b06b117 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -682,7 +682,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
 					     struct perf_sample *sample __maybe_unused)
 {
 	struct symbol *sym;
-	struct dso *dso;
+	struct dso *dso = NULL;
 	struct map *map = maps__find(machine__kernel_maps(machine), event->ksymbol.addr);
 	int err = 0;
 
@@ -695,7 +695,6 @@ static int machine__process_ksymbol_register(struct machine *machine,
 		}
 		dso__set_kernel(dso, DSO_SPACE__KERNEL);
 		map = map__new2(0, dso);
-		dso__put(dso);
 		if (!map) {
 			err = -ENOMEM;
 			goto out;
@@ -734,6 +733,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
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
2.43.0.rc2.451.g8631bc7472-goog

