Return-Path: <linux-kernel+bounces-49241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 341D68467D4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0A231F2519F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFE517559;
	Fri,  2 Feb 2024 06:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MSIZ9SL2"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22601755A
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 06:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706854555; cv=none; b=gLkgwkD0B2eew5QI1/1Uh76V00kcHyEHoaYOeks56z+h1fyn6rdSUjCc/ZlsIutae6roj1bEvNXkXHOR0Z4sUt4fy2bnbsad00oDi3S34dynixyCjc+1x++4oQEmXi3BXiLIwvA08u/qr4kKhCMRhDH6fgSZcgKNxCP3XkxRjj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706854555; c=relaxed/simple;
	bh=Y96V0rvU+Ma2laWtDGnXqBdJjwnDCvtjHq78CaW9p78=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=nNwigpLiZJi4i2fk7jlWJJ1eJ19KFrZVtzwvw5YaRNbxjx0N2G3XCr04QI6/4jnTVEjM38ZT0xRcCNKAw/CKRxzYj54/AtAHgby93tY2r4MOEjfxS0sAPNVQ3w+ZT2qY7o/GZylkkPRk7euRXx8beAZFK73WRqUQEgZ24EPZqCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MSIZ9SL2; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60411f95c44so23825877b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 22:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706854551; x=1707459351; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ns6s7UIGkTM/nycvAWwyFQvgVrl7UVyKC0csznO8c+s=;
        b=MSIZ9SL2BYZSGMeGKbhFO9CTLJRQXzuLvnJ2UW184DJXVDhtOXnZuiE9K71aBpoHIz
         yQtnm/kLzT39fSSZVSps8VpSV/8KWdzETPsoedTyKp9Pc9loQKkzb5hbFQmgdNOCXzXS
         j22KAmVTpbNNJ4ySreMjj7lFr6zl37ZVXcTdACnTEliETRz534ctaZj6BwHU5r5Qkn+X
         4ug7fdzeQYxvLMc9Cgg5WU8bdQQx7k0II/ShTsSTYrr2Om8LJZQGO4WUVk44HPHgi+Hu
         QnzmlkdSzNEqwLrz8aEVwUF2ZEZi0wEAWMSX70BmkqMvKh9IMkzz7nfL7jUQR+yWcPqn
         2sFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706854551; x=1707459351;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ns6s7UIGkTM/nycvAWwyFQvgVrl7UVyKC0csznO8c+s=;
        b=bzZDVlsrV6MxYTnmIlrEgtWS5N8Yuu+57HONUFgMr/rbS9A8C/SGqnlnd7K6BXgKHp
         /9mWqAS74wHEJDbypk35Lvr0+ou6K79LbhRMff04l6E7okAwfmZsjIpK8329zK+pm26o
         uMP+RrW/ryeFF7DLl8G3XQkT+ya7E98AKzXRoHXLOocajmHxL7M8DLRFn4TaKVrDhyzz
         ZQ85iZAqmu0IkTsOwz5Oybu0cJbfpH5E67DpLGbCs3AObLHf1RnxEMbnzWXVzpp6nd0I
         tFNxgan95dcO13bNvyTBS9Ul6XHCrbnaO5MsdsU78QxqqCEG/9YNx7MSqk4zTxmpWHjg
         1gsw==
X-Gm-Message-State: AOJu0YzWyyilGuTvjC4ueMVkoGVGBOP+EexOPHJVnV+C0iVYpFmkx1G8
	pwiwkL5e4s5FdN5Sc2zDkAQQaWODGYivCbDWf8Br2uUIcus+m1DuDq/pvaWI8dUfBB125HIfwPN
	OpJPbNQ==
X-Google-Smtp-Source: AGHT+IFfoyhmAC9YqB8yPX5NVqCQvx3pYH1BNQyUoL4WxFB5pDOFzyLyEMk+FtmmCLRq2CFOC6GcQ0sILBHs
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a85f:db1d:a66b:7f53])
 (user=irogers job=sendgmr) by 2002:a05:690c:19:b0:5ee:d5ed:5f70 with SMTP id
 bc25-20020a05690c001900b005eed5ed5f70mr1172776ywb.9.1706854551036; Thu, 01
 Feb 2024 22:15:51 -0800 (PST)
Date: Thu,  1 Feb 2024 22:15:09 -0800
In-Reply-To: <20240202061532.1939474-1-irogers@google.com>
Message-Id: <20240202061532.1939474-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202061532.1939474-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v8 02/25] perf maps: Get map before returning in maps__find
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	"Steinar H. Gunderson" <sesse@google.com>, Liam Howlett <liam.howlett@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Colin Ian King <colin.i.king@gmail.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Ming Wang <wangming01@loongson.cn>, James Clark <james.clark@arm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"

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
index 3573e0b7ef3e..83709146a48a 100644
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
index b397a769006f..e8eb9f0b073f 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -896,7 +896,6 @@ static int machine__process_ksymbol_register(struct machine *machine,
 	struct symbol *sym;
 	struct dso *dso;
 	struct map *map = maps__find(machine__kernel_maps(machine), event->ksymbol.addr);
-	bool put_map = false;
 	int err = 0;
 
 	if (!map) {
@@ -913,12 +912,6 @@ static int machine__process_ksymbol_register(struct machine *machine,
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
@@ -952,8 +945,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
 	}
 	dso__insert_symbol(dso, sym);
 out:
-	if (put_map)
-		map__put(map);
+	map__put(map);
 	return err;
 }
 
@@ -977,7 +969,7 @@ static int machine__process_ksymbol_unregister(struct machine *machine,
 		if (sym)
 			dso__delete_symbol(dso, sym);
 	}
-
+	map__put(map);
 	return 0;
 }
 
@@ -1005,11 +997,11 @@ int machine__process_text_poke(struct machine *machine, union perf_event *event,
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
@@ -1032,7 +1024,8 @@ int machine__process_text_poke(struct machine *machine, union perf_event *event,
 		pr_debug("Failed to find kernel text poke address map for %#" PRI_lx64 "\n",
 			 event->text_poke.addr);
 	}
-
+out:
+	map__put(map);
 	return 0;
 }
 
@@ -1300,9 +1293,10 @@ static int machine__map_x86_64_entry_trampolines_cb(struct map *map, void *data)
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
index 2fd81e2d622e..252a3b1f8f81 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -500,15 +500,18 @@ void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map, void *data
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
@@ -552,7 +555,7 @@ int maps__find_ams(struct maps *maps, struct addr_map_symbol *ams)
 	if (ams->addr < map__start(ams->ms.map) || ams->addr >= map__end(ams->ms.map)) {
 		if (maps == NULL)
 			return -1;
-		ams->ms.map = maps__find(maps, ams->addr);  // TODO: map_get
+		ams->ms.map = maps__find(maps, ams->addr);
 		if (ams->ms.map == NULL)
 			return -1;
 	}
@@ -862,7 +865,7 @@ struct map *maps__find(struct maps *maps, u64 ip)
 					sizeof(*mapp), map__addr_cmp);
 
 			if (mapp)
-				result = *mapp; // map__get(*mapp);
+				result = map__get(*mapp);
 			done = true;
 		}
 		up_read(maps__lock(maps));
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index be212ba157dc..1710b89e207c 100644
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
2.43.0.594.gd9cf4e227d-goog


