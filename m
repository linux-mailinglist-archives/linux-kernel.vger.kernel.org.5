Return-Path: <linux-kernel+bounces-162852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 789638B6158
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F74E28106E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9FA13C80F;
	Mon, 29 Apr 2024 18:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W6Yh1zpb"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5D013C691
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 18:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714416401; cv=none; b=UnR0g0ztSjIqK2CDU4foFHwc9sPSqWXdnnUjKWLvDfkmXGYZrSHl5M6wJKCY99bfYAXXEcyR+3mMt+TELow6pnxYNJLdDp/3+/MYI2ZFuS6h2BOjXdOEZUPYhtz8DQltPGfHgLmbsMJUuBF3iPCuUi5Kn8MMJrAQN1Un7CQCpcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714416401; c=relaxed/simple;
	bh=UTxelfgn/NP6KqTtuDstAHWAUd3MVs0zQWTjQf9/5To=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=daGGF915fGzk4eoiojGCI9pu/QDkrmik/aaMw+CfeEqtuWlxqOMt1+ZuQ2MIc9M2rC0RLIKqVZtBvZ4mL8IADtREmIED14DOQ2hG6D6aNhk2dvolqxNKFVu1NDyloSbaFmS5YJx2la9YcUeXt4U023H/eudOBg1EIWPYrPZjd3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W6Yh1zpb; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be4601434so9340757b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714416399; x=1715021199; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0GpE3k2HUqwCUngw35FiLfWVB3EVA72rLEwbUIc8rrM=;
        b=W6Yh1zpbWe7wiyVJD7RDhQTNZ7c7s6tlSoa6LUVa5hhA+w5ANpTl0SKyOPYwFUdNQw
         wSZabmUWDKHZBmwrJSD3qFgLyHZaYEf3RlTpS85pNqOkLNH9aL8qU4Ktz+wpgaooa6E2
         ucztLaCew4F3QFxjwC+9424DB6iGrBnriCwrDIt7iTI9t/66hiSBbCd7rl16U//vvhIh
         YnToIq5mYeMCd6vIc7A7ZYmdiAMM3zjGDg8c1Qbi0t8b9XJZZycC2Mb59y2d1XHBVMFA
         bNLbhTsO5IyFj5Zw7719NSl0HMAXL3RvIcSKPQPeSGvYWZ8xfSMBExzHGZUULbyBwjC4
         NvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714416399; x=1715021199;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0GpE3k2HUqwCUngw35FiLfWVB3EVA72rLEwbUIc8rrM=;
        b=gVfss/qaT1LK69uIDmAJegAuIz5eVDvOjGxulbMXqjonOTVzhO7Q/RSzKfWNsi8Wjd
         wm9TEkXh+a+2yxIMy/cbmxb11y835YFfI74lkrtsEqylQdDc2FdryCw4h8LRpnxZRteE
         GRB6RRgJnDVlYbR0KaivIpbEmOFgAgiqCJw/LnrFS6HJSbCeU6Qfk8F+mV6/hl9lL6Q1
         TsbRDnFlBK7k/G3P4AOWrHsQLmNPpxWfttfLCmGuj26KS5NGGeyNLrXdVc9nDmGCMmPn
         Va71Iou2AIOp+BqUodVftL5VQlGN8UTitQz+rq83nSRHEUJIBH1MZ0nRWID6pDLfbjTG
         Gsjw==
X-Forwarded-Encrypted: i=1; AJvYcCVqxly23lVIQ/PNKnUjDMaxvrE5pnOBrrn3axq2p9oFph7Ns/mt2V5vPTD1T7DMdRqnIuLjG0/63fcQu5bQ27WNnFb4uWMDr0vxV4+S
X-Gm-Message-State: AOJu0YyfpIi+a6kguRC23FZhxyWss4n0Vt74sohoQ5PUl0tDqbyuyQZs
	keF8UvDAetYtLJoPkvCphUsypfliCWL7YltG4U8wQsOa+Fq1DGuabV1NEGEjcNp8B0Qwq2gNJ1/
	OqPbjvQ==
X-Google-Smtp-Source: AGHT+IHo/1hbywFnaNu0kit9lPvfHvfFMk/T9EBNJRFe93AGrk/xhnrvJZuRSlqKwUssww5+Za25vVQhUdul
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:c137:aa10:25e1:8f1e])
 (user=irogers job=sendgmr) by 2002:a05:6902:2b0a:b0:dda:c57c:b69b with SMTP
 id fi10-20020a0569022b0a00b00ddac57cb69bmr3773476ybb.0.1714416398942; Mon, 29
 Apr 2024 11:46:38 -0700 (PDT)
Date: Mon, 29 Apr 2024 11:46:13 -0700
In-Reply-To: <20240429184614.1224041-1-irogers@google.com>
Message-Id: <20240429184614.1224041-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240429184614.1224041-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Subject: [PATCH v5 6/7] perf dso: Reference counting related fixes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	nabijaczleweli@nabijaczleweli.xyz, Leo Yan <leo.yan@linux.dev>, 
	Song Liu <song@kernel.org>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ben Gainey <ben.gainey@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Changbin Du <changbin.du@huawei.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Dima Kogan <dima@secretsauce.net>, zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Paran Lee <p4ranlee@gmail.com>, Li Dong <lidong@vivo.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Yang Jihong <yangjihong1@huawei.com>, 
	Chengen Du <chengen.du@canonical.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Ensure gets and puts are better aligned fixing reference couting
checking problems.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c    |  4 +--
 tools/perf/util/map.c        |  1 +
 tools/perf/util/symbol-elf.c | 51 ++++++++++++++++++------------------
 3 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 0b8fb14f5ff6..4a4541a2e887 100644
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
index 117c4bb78b35..e1d14936a60d 100644
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
index 3be5e8d1e278..e398abfd13a0 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1419,7 +1419,7 @@ void __weak arch__sym_update(struct symbol *s __maybe_unused,
 static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 				      GElf_Sym *sym, GElf_Shdr *shdr,
 				      struct maps *kmaps, struct kmap *kmap,
-				      struct dso **curr_dsop, struct map **curr_mapp,
+				      struct dso **curr_dsop,
 				      const char *section_name,
 				      bool adjust_kernel_syms, bool kmodule, bool *remap_kernel,
 				      u64 max_text_sh_offset)
@@ -1470,8 +1470,8 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 			map__set_pgoff(map, shdr->sh_offset);
 		}
 
-		*curr_mapp = map;
-		*curr_dsop = dso;
+		dso__put(*curr_dsop);
+		*curr_dsop = dso__get(dso);
 		return 0;
 	}
 
@@ -1484,8 +1484,8 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 	 */
 	if (kmodule && adjust_kernel_syms && is_exe_text(shdr->sh_flags) &&
 	    shdr->sh_offset <= max_text_sh_offset) {
-		*curr_mapp = map;
-		*curr_dsop = dso;
+		dso__put(*curr_dsop);
+		*curr_dsop = dso__get(dso);
 		return 0;
 	}
 
@@ -1507,10 +1507,10 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
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
 
@@ -1524,21 +1524,15 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
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
@@ -1549,11 +1543,9 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 {
 	struct kmap *kmap = dso__kernel(dso) ? map__kmap(map) : NULL;
 	struct maps *kmaps = kmap ? map__kmaps(map) : NULL;
-	struct map *curr_map = map;
-	struct dso *curr_dso = dso;
+	struct dso *curr_dso = NULL;
 	Elf_Data *symstrs, *secstrs, *secstrs_run, *secstrs_sym;
 	uint32_t nr_syms;
-	int err = -1;
 	uint32_t idx;
 	GElf_Ehdr ehdr;
 	GElf_Shdr shdr;
@@ -1656,6 +1648,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 	if (kmodule && adjust_kernel_syms)
 		max_text_sh_offset = max_text_section(runtime_ss->elf, &runtime_ss->ehdr);
 
+	curr_dso = dso__get(dso);
 	elf_symtab__for_each_symbol(syms, nr_syms, idx, sym) {
 		struct symbol *f;
 		const char *elf_name = elf_sym__name(&sym, symstrs);
@@ -1744,9 +1737,13 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 			--sym.st_value;
 
 		if (dso__kernel(dso)) {
-			if (dso__process_kernel_symbol(dso, map, &sym, &shdr, kmaps, kmap, &curr_dso, &curr_map,
-						       section_name, adjust_kernel_syms, kmodule,
-						       &remap_kernel, max_text_sh_offset))
+			if (dso__process_kernel_symbol(dso, map, &sym, &shdr,
+						       kmaps, kmap, &curr_dso,
+						       section_name,
+						       adjust_kernel_syms,
+						       kmodule,
+						       &remap_kernel,
+						       max_text_sh_offset))
 				goto out_elf_end;
 		} else if ((used_opd && runtime_ss->adjust_symbols) ||
 			   (!used_opd && syms_ss->adjust_symbols)) {
@@ -1795,6 +1792,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		__symbols__insert(dso__symbols(curr_dso), f, dso__kernel(dso));
 		nr++;
 	}
+	dso__put(curr_dso);
 
 	/*
 	 * For misannotated, zeroed, ASM function sizes.
@@ -1810,9 +1808,10 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 			maps__fixup_end(kmaps);
 		}
 	}
-	err = nr;
+	return nr;
 out_elf_end:
-	return err;
+	dso__put(curr_dso);
+	return -1;
 }
 
 int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
-- 
2.44.0.769.g3c40516874-goog


