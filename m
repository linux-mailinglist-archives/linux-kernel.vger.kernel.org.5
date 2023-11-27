Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49BE7FAD0B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbjK0WKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbjK0WKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:10:03 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F30D1BF7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:09:52 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d032ab478fso22180887b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701122991; x=1701727791; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ay5NC9JiWWqEbT7zvSUX6zhzbJl2dBe2Grrh7oz4jYc=;
        b=eMf8qLFb0n7Leat9STiGpVNY6OpO3dUZqKT3NsG6Y82ghXhgMxnc1dWZ38j3dbFvNH
         qc6blTd7QmSJY/x/DHPK+LIFW9EbLQ+K8isUWlTlTsLN/lgSjMA98d841QtejmP4URjF
         siTVF2wgIyqbzi2rT8UgoJhPLqHYcGorGKu3bXsEf8t2HLUL8Kr5AOto1EHp0rKWB91j
         guxPeHBUi86/AoVBcXigmh/69zSbGuAksCC0zfRWK9gsyXTAcSqdrmJW7iqo5icnuFOW
         B6JgCMvZCpX+uc1fysdB77OwUFlkzeFnDMwjyG+q/N7udOaiCkFWL6hS9QiVzMuTLy7V
         MqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701122991; x=1701727791;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ay5NC9JiWWqEbT7zvSUX6zhzbJl2dBe2Grrh7oz4jYc=;
        b=muXSskRrNp4Vi4eJa5EcyOmJhjCTw3BTNob88Lat2NaeLkaF1D7kU2jfdZpyY4aNp3
         RhIORCbbHUtlFnhm1zPAN9CWDR5NIWZ/PoMjTcNk32/ifZF98zbMRwXdsuj33tBoRjiv
         yedcZ6SYDmuaQVcHYzgrNfSTYcASM0PpYIUs8fQDiSVIdE6yP4QQvJcylhZqZt7A6TBM
         lAYCGi/wQt8vYimN6lxFPiBuT+yT8fK8nSQcOgPaCa+gFFAiJiTqI0wC3B7sLEprl5A1
         KhhcPew20A1Pib0kHKFE+8alEwA7msgi1C9GnzhwmP2uqGghG1YU5tdmDDesI9jrMf0p
         b4Yg==
X-Gm-Message-State: AOJu0Yz8foZj+eYJl3H5zu//4luJJ1Hq5vegHHTu0U0MiN+W+vEhMNqe
        q00wH6JU8bdOIfvgsKkktVYO0x3cN6Uc
X-Google-Smtp-Source: AGHT+IGqLdgpF/k0xb1yVjyApnZFIASJVMsH1Vry0Tm6asEdzLi6gcoIgJWqwvE5dDJ9GPA44xsMSr62+7wh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:829:6e77:9093:f39b])
 (user=irogers job=sendgmr) by 2002:a25:6f09:0:b0:daf:5829:5b68 with SMTP id
 k9-20020a256f09000000b00daf58295b68mr414740ybc.7.1701122991490; Mon, 27 Nov
 2023 14:09:51 -0800 (PST)
Date:   Mon, 27 Nov 2023 14:08:24 -0800
In-Reply-To: <20231127220902.1315692-1-irogers@google.com>
Message-Id: <20231127220902.1315692-13-irogers@google.com>
Mime-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v5 12/50] perf map: Simplify map_ip/unmap_ip and make map size smaller
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

When mapping an IP it is either an identity mapping or a DSO relative
mapping, so a single bit is required in the struct to identify
this. The current code uses function pointers, adding 2 pointers per
map and also pushing the size of a map beyond 1 cache line. Switch to
using a byte to identify the mapping type (as well as priv and
erange_warned), to avoid any masking. Change struct maps's layout to
avoid holes.

Before:
```
struct map {
        u64                        start;                /*     0     8 */
        u64                        end;                  /*     8     8 */
        _Bool                      erange_warned:1;      /*    16: 0  1 */
        _Bool                      priv:1;               /*    16: 1  1 */

        /* XXX 6 bits hole, try to pack */
        /* XXX 3 bytes hole, try to pack */

        u32                        prot;                 /*    20     4 */
        u64                        pgoff;                /*    24     8 */
        u64                        reloc;                /*    32     8 */
        u64                        (*map_ip)(const struct map  *, u64); /*    40     8 */
        u64                        (*unmap_ip)(const struct map  *, u64); /*    48     8 */
        struct dso *               dso;                  /*    56     8 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        refcount_t                 refcnt;               /*    64     4 */
        u32                        flags;                /*    68     4 */

        /* size: 72, cachelines: 2, members: 12 */
        /* sum members: 68, holes: 1, sum holes: 3 */
        /* sum bitfield members: 2 bits, bit holes: 1, sum bit holes: 6 bits */
        /* last cacheline: 8 bytes */
};
```

After:
```
struct map {
        u64                        start;                /*     0     8 */
        u64                        end;                  /*     8     8 */
        u64                        pgoff;                /*    16     8 */
        u64                        reloc;                /*    24     8 */
        struct dso *               dso;                  /*    32     8 */
        refcount_t                 refcnt;               /*    40     4 */
        u32                        prot;                 /*    44     4 */
        u32                        flags;                /*    48     4 */
        enum mapping_type          mapping_type:8;       /*    52: 0  4 */

        /* Bitfield combined with next fields */

        _Bool                      erange_warned;        /*    53     1 */
        _Bool                      priv;                 /*    54     1 */

        /* size: 56, cachelines: 1, members: 11 */
        /* padding: 1 */
        /* last cacheline: 56 bytes */
};
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c    |  3 +-
 tools/perf/util/map.c        | 20 +--------
 tools/perf/util/map.h        | 83 +++++++++++++++++++-----------------
 tools/perf/util/symbol-elf.c |  6 +--
 tools/perf/util/symbol.c     |  6 +--
 5 files changed, 50 insertions(+), 68 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index be3dab9d5253..b6831a1f909d 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1360,8 +1360,7 @@ __machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
 	if (machine->vmlinux_map == NULL)
 		return -ENOMEM;
 
-	map__set_map_ip(machine->vmlinux_map, identity__map_ip);
-	map__set_unmap_ip(machine->vmlinux_map, identity__map_ip);
+	map__set_mapping_type(machine->vmlinux_map, MAPPING_TYPE__IDENTITY);
 	return maps__insert(machine__kernel_maps(machine), machine->vmlinux_map);
 }
 
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index f64b83004421..54c67cb7ecef 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -109,8 +109,7 @@ void map__init(struct map *map, u64 start, u64 end, u64 pgoff, struct dso *dso)
 	map__set_pgoff(map, pgoff);
 	map__set_reloc(map, 0);
 	map__set_dso(map, dso__get(dso));
-	map__set_map_ip(map, map__dso_map_ip);
-	map__set_unmap_ip(map, map__dso_unmap_ip);
+	map__set_mapping_type(map, MAPPING_TYPE__DSO);
 	map__set_erange_warned(map, false);
 	refcount_set(map__refcnt(map), 1);
 }
@@ -172,7 +171,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 		map__init(result, start, start + len, pgoff, dso);
 
 		if (anon || no_dso) {
-			map->map_ip = map->unmap_ip = identity__map_ip;
+			map->mapping_type = MAPPING_TYPE__IDENTITY;
 
 			/*
 			 * Set memory without DSO as loaded. All map__find_*
@@ -630,18 +629,3 @@ struct maps *map__kmaps(struct map *map)
 	}
 	return kmap->kmaps;
 }
-
-u64 map__dso_map_ip(const struct map *map, u64 ip)
-{
-	return ip - map__start(map) + map__pgoff(map);
-}
-
-u64 map__dso_unmap_ip(const struct map *map, u64 ip)
-{
-	return ip + map__start(map) - map__pgoff(map);
-}
-
-u64 identity__map_ip(const struct map *map __maybe_unused, u64 ip)
-{
-	return ip;
-}
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 1b53d53adc86..3a3b7757da5f 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -16,23 +16,25 @@ struct dso;
 struct maps;
 struct machine;
 
+enum mapping_type {
+	/* map__map_ip/map__unmap_ip are given as offsets in the DSO. */
+	MAPPING_TYPE__DSO,
+	/* map__map_ip/map__unmap_ip are just the given ip value. */
+	MAPPING_TYPE__IDENTITY,
+};
+
 DECLARE_RC_STRUCT(map) {
 	u64			start;
 	u64			end;
-	bool			erange_warned:1;
-	bool			priv:1;
-	u32			prot;
 	u64			pgoff;
 	u64			reloc;
-
-	/* ip -> dso rip */
-	u64			(*map_ip)(const struct map *, u64);
-	/* dso rip -> ip */
-	u64			(*unmap_ip)(const struct map *, u64);
-
 	struct dso		*dso;
 	refcount_t		refcnt;
+	u32			prot;
 	u32			flags;
+	enum mapping_type	mapping_type:8;
+	bool			erange_warned;
+	bool			priv;
 };
 
 struct kmap;
@@ -41,38 +43,11 @@ struct kmap *__map__kmap(struct map *map);
 struct kmap *map__kmap(struct map *map);
 struct maps *map__kmaps(struct map *map);
 
-/* ip -> dso rip */
-u64 map__dso_map_ip(const struct map *map, u64 ip);
-/* dso rip -> ip */
-u64 map__dso_unmap_ip(const struct map *map, u64 ip);
-/* Returns ip */
-u64 identity__map_ip(const struct map *map __maybe_unused, u64 ip);
-
 static inline struct dso *map__dso(const struct map *map)
 {
 	return RC_CHK_ACCESS(map)->dso;
 }
 
-static inline u64 map__map_ip(const struct map *map, u64 ip)
-{
-	return RC_CHK_ACCESS(map)->map_ip(map, ip);
-}
-
-static inline u64 map__unmap_ip(const struct map *map, u64 ip)
-{
-	return RC_CHK_ACCESS(map)->unmap_ip(map, ip);
-}
-
-static inline void *map__map_ip_ptr(struct map *map)
-{
-	return RC_CHK_ACCESS(map)->map_ip;
-}
-
-static inline void* map__unmap_ip_ptr(struct map *map)
-{
-	return RC_CHK_ACCESS(map)->unmap_ip;
-}
-
 static inline u64 map__start(const struct map *map)
 {
 	return RC_CHK_ACCESS(map)->start;
@@ -123,6 +98,34 @@ static inline size_t map__size(const struct map *map)
 	return map__end(map) - map__start(map);
 }
 
+/* ip -> dso rip */
+static inline u64 map__dso_map_ip(const struct map *map, u64 ip)
+{
+	return ip - map__start(map) + map__pgoff(map);
+}
+
+/* dso rip -> ip */
+static inline u64 map__dso_unmap_ip(const struct map *map, u64 ip)
+{
+	return ip + map__start(map) - map__pgoff(map);
+}
+
+static inline u64 map__map_ip(const struct map *map, u64 ip)
+{
+	if ((RC_CHK_ACCESS(map)->mapping_type) == MAPPING_TYPE__DSO)
+		return map__dso_map_ip(map, ip);
+	else
+		return ip;
+}
+
+static inline u64 map__unmap_ip(const struct map *map, u64 ip)
+{
+	if ((RC_CHK_ACCESS(map)->mapping_type) == MAPPING_TYPE__DSO)
+		return map__dso_unmap_ip(map, ip);
+	else
+		return ip;
+}
+
 /* rip/ip <-> addr suitable for passing to `objdump --start-address=` */
 u64 map__rip_2objdump(struct map *map, u64 rip);
 
@@ -294,13 +297,13 @@ static inline void map__set_dso(struct map *map, struct dso *dso)
 	RC_CHK_ACCESS(map)->dso = dso;
 }
 
-static inline void map__set_map_ip(struct map *map, u64 (*map_ip)(const struct map *map, u64 ip))
+static inline void map__set_mapping_type(struct map *map, enum mapping_type type)
 {
-	RC_CHK_ACCESS(map)->map_ip = map_ip;
+	RC_CHK_ACCESS(map)->mapping_type = type;
 }
 
-static inline void map__set_unmap_ip(struct map *map, u64 (*unmap_ip)(const struct map *map, u64 rip))
+static inline enum mapping_type map__mapping_type(struct map *map)
 {
-	RC_CHK_ACCESS(map)->unmap_ip = unmap_ip;
+	return RC_CHK_ACCESS(map)->mapping_type;
 }
 #endif /* __PERF_MAP_H */
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 9e7eeaf616b8..4b934ed3bfd1 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1392,8 +1392,7 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 			map__set_start(map, shdr->sh_addr + ref_reloc(kmap));
 			map__set_end(map, map__start(map) + shdr->sh_size);
 			map__set_pgoff(map, shdr->sh_offset);
-			map__set_map_ip(map, map__dso_map_ip);
-			map__set_unmap_ip(map, map__dso_unmap_ip);
+			map__set_mapping_type(map, MAPPING_TYPE__DSO);
 			/* Ensure maps are correctly ordered */
 			if (kmaps) {
 				int err;
@@ -1455,8 +1454,7 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 			map__set_end(curr_map, map__start(curr_map) + shdr->sh_size);
 			map__set_pgoff(curr_map, shdr->sh_offset);
 		} else {
-			map__set_map_ip(curr_map, identity__map_ip);
-			map__set_unmap_ip(curr_map, identity__map_ip);
+			map__set_mapping_type(curr_map, MAPPING_TYPE__IDENTITY);
 		}
 		curr_dso->symtab_type = dso->symtab_type;
 		if (maps__insert(kmaps, curr_map))
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 82cc74b9358e..314c0263bf3c 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -956,8 +956,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 				return -1;
 			}
 
-			map__set_map_ip(curr_map, identity__map_ip);
-			map__set_unmap_ip(curr_map, identity__map_ip);
+			map__set_mapping_type(curr_map, MAPPING_TYPE__IDENTITY);
 			if (maps__insert(kmaps, curr_map)) {
 				dso__put(ndso);
 				return -1;
@@ -1475,8 +1474,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 			map__set_start(map, map__start(new_map));
 			map__set_end(map, map__end(new_map));
 			map__set_pgoff(map, map__pgoff(new_map));
-			map__set_map_ip(map, map__map_ip_ptr(new_map));
-			map__set_unmap_ip(map, map__unmap_ip_ptr(new_map));
+			map__set_mapping_type(map, map__mapping_type(new_map));
 			/* Ensure maps are correctly ordered */
 			map_ref = map__get(map);
 			maps__remove(kmaps, map_ref);
-- 
2.43.0.rc1.413.gea7ed67945-goog

