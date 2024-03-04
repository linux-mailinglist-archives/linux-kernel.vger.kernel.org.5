Return-Path: <linux-kernel+bounces-91115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A97388709BE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5462B242B1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FDD78B6C;
	Mon,  4 Mar 2024 18:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="24TCzPc5"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16E37C6D4
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 18:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709577371; cv=none; b=g70eTgu/fGaZ1WZzd0xW7zPa0sHb0JmHJaJRusxtM9fzHtNILmi+kDU7chjFXBKCAOd230KZADz7ZrCBsWd6vJpUFxbxxbBVkaTykVH2U5HrVTtX9UDU/jxHTPNz98m3cs/LxdTud1AeLxUJ1tZm5z3zxMTSEOA6uX3D3cmXGf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709577371; c=relaxed/simple;
	bh=RFS4N+aJDP5U6ubQJWOXZxm3XFG5A2Mi2kHnbZ3MV0I=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=B0eEMDMKZCf1owSimb1eSBRdPqGbr2hSMSo8LKphy19T0NEJK/vvEWCgGffSfl81zmFOKY3ES4jCkkVhVjjRVPGv55t2TuQbbi4UHYQBDjlD1G0e8rxkxOT8DssTbmGaBqH0rmffZWqCqyr02LK63P02zngG7MzIPg4P6cbrnjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=24TCzPc5; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc4563611cso7592635276.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 10:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709577369; x=1710182169; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jZeymq/gTiLdY7mNzH/vrzBNKpuWBiKPcdpqr/pTFEg=;
        b=24TCzPc5WHphom4IvezSb2Lks1tgPr+EJ1pdc6F4KyzRzepBPu2S/hhZ1x0DvuxT1n
         71vgsaTXjSoxUP3daIDgyWq83qu3Idh0sTYPrtfkM3mrLbb+3qDUNcvJFp/18ofO8KUR
         F6BtisXEdWHIYRJ5KOkPAjKCF9TH+oCh9/jfQzmqLMW8B15Q3+8DoDxt8bhTUQPP/kE5
         pS4CrU7HNIPVERyW6H65q0HFsEcXEevcu1Xo0YYzAzzxuIDDX1XNt5nRseaqRumbSSbI
         BietgKxDeyq70yz+glLRDvRYxpOaa5dYTEnqvLOz+GOpWDMUWyZzAcSq5Qiq+FbB+ZcM
         T5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709577369; x=1710182169;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jZeymq/gTiLdY7mNzH/vrzBNKpuWBiKPcdpqr/pTFEg=;
        b=wY7VPnXa/BfupUxne6jUhe1Sb0e5r6OIPcpLGKnO80O3tzDuveuaGaZk6koDBjiQoX
         6A+J6Lclq6XAkHbsiaeA8wHX7cxJKPqJzheSTT7no4Q4rNwB5NH3M3Q3MSvFUWoLcVOu
         IrKELEoSgvHYf5ccMZYJ4Er42Z8kIy4SAVQ+tX1h4ehZ05HVwQG+njP9ofizWem7s6hh
         FV48hnVhkTbCBIYyOsOKQVMI3MWy5/BATQ6D9/4oUHWP+zlMLgEkBPj68Sg3946MrsCB
         VjEjggoWU7Gks741M3Xu5R9ApwqYkjT8TkkgghuEFPQMMA+Zfo5iJJbo3euuksUb8l7n
         aAqg==
X-Forwarded-Encrypted: i=1; AJvYcCWupadJ0VPSI19DoamXFU9FYVu0WeDuUQqLoCohpWcnlXgdQrMdR7OIIUh7HujJDZlbuOqTbOFh3u5qYWUPynZ6qidgC81V8L9NW+aq
X-Gm-Message-State: AOJu0Yx/Hw0/0X5Oe5RGRzE8YYX7Um+gxp+EOfWIMix4GJze7O0JAXl/
	0fK8cu7ayLyz38SNWbydvbaAT7K3zzGBjyQnL6VehGcdtOdhomCzfcM6Gb9G21dXVht80fzaXur
	AgmU4Yg==
X-Google-Smtp-Source: AGHT+IFo6Qph/nRTbDcYVOAd1L+oq2jLF3K7+pvMbVg9fSFuin9LYQa4NdfDWWpxT9Ox/Ra/1sx8VTqaAJRp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:38b7:9cbf:f246:dafb])
 (user=irogers job=sendgmr) by 2002:a05:6902:1505:b0:dc6:9e4a:f950 with SMTP
 id q5-20020a056902150500b00dc69e4af950mr2608271ybu.3.1709577369116; Mon, 04
 Mar 2024 10:36:09 -0800 (PST)
Date: Mon,  4 Mar 2024 10:35:23 -0800
In-Reply-To: <20240304183525.3222581-1-irogers@google.com>
Message-Id: <20240304183525.3222581-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304183525.3222581-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 12/13] perf dso: Reference counting related fixes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, 
	"=?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?=" <nabijaczleweli@nabijaczleweli.xyz>, Leo Yan <leo.yan@linaro.org>, 
	Song Liu <song@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ben Gainey <ben.gainey@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kan Liang <kan.liang@linux.intel.com>, German Gomez <german.gomez@arm.com>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, Changbin Du <changbin.du@huawei.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Paran Lee <p4ranlee@gmail.com>, Li Dong <lidong@vivo.com>, linux-perf-users@vger.kernel.org, 
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
index 4153dc92154d..ca8b1d7e4028 100644
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
index 48404ddbee50..9ea85f7dc11a 100644
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
2.44.0.278.ge034bb2e1d-goog


