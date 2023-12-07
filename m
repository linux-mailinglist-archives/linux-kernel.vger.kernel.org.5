Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943BB807DAB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442001AbjLGBRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441989AbjLGBR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:17:27 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE5610D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 17:17:32 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db9612b8997so540222276.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 17:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911852; x=1702516652; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8uJ4Fnb6KBcCgmxkcQQeI5pptPcrA/cGJHUyHI7nyas=;
        b=OoCZZncPPQd5kgK1UOCDwoF+/NmySNc8s713ECp1pSEVfB//uQaj7OTBcg+0fto6Bt
         uSDlbi7aC/sA5QxPFJylv7RP/PNWaPDhdfH6HISvd1scfuDBvM7CzZ63JAU0tF1b1Oik
         xOPi6ojQdhezJorS+/uNhcbAsh8MPB1UILsyl6lzywEX0XymaoD9tKhJXC6A7f6jVyUP
         AShSexM6qybIt2VUOWn+MH0CLu0Yhs9RHH7pJlp3W7jvnnCxv8/Bu2iT1pyTtR28j+U9
         fIThd6nJiNQWfxRlTlTeqohN19dOvZe2fq/MeEO3zJwXSr3BBPqruoapZ7w1QSdrUXvG
         +//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911852; x=1702516652;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8uJ4Fnb6KBcCgmxkcQQeI5pptPcrA/cGJHUyHI7nyas=;
        b=U9WF7ZUIhlLOhrVsyYPqre77xsVZZKLckE98eU3bRvMmhutfOwdP6gcVmvssAFbXeQ
         I0YsQcHUEbMFB35KYiFC+l3PLSC8+2Am7XfitrJpkRnwaD50nZiwXYgz5M+N8s5B3z2r
         X6pAruJs80cvGX5mM/wF3t6AualDVqUcUGwGvsFW7FLXzslBG/4b5AhgxCF7DZNU8K74
         2q6hlVChstF6XPK1xnWqX5ycWNG9fVCzpgohEooTxtKXNDtADBjVF7Vmc3wCxz63EmKr
         8AslCCXJqNRR/MksFhvQ/D3pgk/GQdGDYQMZWlqceHb7v/FXHiUyORqNFyTkMkq/zvVY
         9jbw==
X-Gm-Message-State: AOJu0Yzkk9N3FAWcGZWhHiiNC+djxzSd0hOEOxZDT9UHQR11TroYJC5N
        E4GB6hX8fmiq38oFtyt5YmJe4rqGbR2U
X-Google-Smtp-Source: AGHT+IFIkuL6wUfePQicPlMcF3SN1sRC7MNBSNmzlJIyddZLGndwvQqALN4cJkIHxzfWKsH2ocK4YVKbZhl+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a25:cb0a:0:b0:db5:3aa1:827c with SMTP id
 b10-20020a25cb0a000000b00db53aa1827cmr32204ybg.13.1701911851794; Wed, 06 Dec
 2023 17:17:31 -0800 (PST)
Date:   Wed,  6 Dec 2023 17:16:36 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-3-irogers@google.com>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 02/47] perf maps: Add maps__for_each_map to iterate maps
 holding the lock
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

The macro maps__for_each_entry is error prone as it doesn't require
holding the maps lock. Add a new function that iterates the maps
holding the read lock. Convert maps__find_symbol_by_name and
maps__fprintf to use callbacks, the latter being an example of where
the read lock wasn't being held.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c | 99 ++++++++++++++++++++++++++++--------------
 tools/perf/util/maps.h |  3 ++
 2 files changed, 69 insertions(+), 33 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 9a011aed4b75..160a6dce54bb 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -196,6 +196,21 @@ void maps__put(struct maps *maps)
 		RC_CHK_PUT(maps);
 }
 
+int maps__for_each_map(struct maps *maps, int (*cb)(struct map *map, void *data), void *data)
+{
+	struct map_rb_node *pos;
+	int ret = 0;
+
+	down_read(maps__lock(maps));
+	maps__for_each_entry(maps, pos)	{
+		ret = cb(pos->map, data);
+		if (ret)
+			break;
+	}
+	up_read(maps__lock(maps));
+	return ret;
+}
+
 struct symbol *maps__find_symbol(struct maps *maps, u64 addr, struct map **mapp)
 {
 	struct map *map = maps__find(maps, addr);
@@ -210,31 +225,40 @@ struct symbol *maps__find_symbol(struct maps *maps, u64 addr, struct map **mapp)
 	return NULL;
 }
 
-struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name, struct map **mapp)
-{
+struct maps__find_symbol_by_name_args {
+	struct map **mapp;
+	const char *name;
 	struct symbol *sym;
-	struct map_rb_node *pos;
+};
 
-	down_read(maps__lock(maps));
+static int maps__find_symbol_by_name_cb(struct map *map, void *data)
+{
+	struct maps__find_symbol_by_name_args *args = data;
 
-	maps__for_each_entry(maps, pos) {
-		sym = map__find_symbol_by_name(pos->map, name);
+	args->sym = map__find_symbol_by_name(map, args->name);
+	if (!args->sym)
+		return 0;
 
-		if (sym == NULL)
-			continue;
-		if (!map__contains_symbol(pos->map, sym)) {
-			sym = NULL;
-			continue;
-		}
-		if (mapp != NULL)
-			*mapp = pos->map;
-		goto out;
+	if (!map__contains_symbol(map, args->sym)) {
+		args->sym = NULL;
+		return 0;
 	}
 
-	sym = NULL;
-out:
-	up_read(maps__lock(maps));
-	return sym;
+	if (args->mapp != NULL)
+		*args->mapp = map__get(map);
+	return 1;
+}
+
+struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name, struct map **mapp)
+{
+	struct maps__find_symbol_by_name_args args = {
+		.mapp = mapp,
+		.name = name,
+		.sym = NULL,
+	};
+
+	maps__for_each_map(maps, maps__find_symbol_by_name_cb, &args);
+	return args.sym;
 }
 
 int maps__find_ams(struct maps *maps, struct addr_map_symbol *ams)
@@ -253,25 +277,34 @@ int maps__find_ams(struct maps *maps, struct addr_map_symbol *ams)
 	return ams->ms.sym ? 0 : -1;
 }
 
-size_t maps__fprintf(struct maps *maps, FILE *fp)
-{
-	size_t printed = 0;
-	struct map_rb_node *pos;
+struct maps__fprintf_args {
+	FILE *fp;
+	size_t printed;
+};
 
-	down_read(maps__lock(maps));
+static int maps__fprintf_cb(struct map *map, void *data)
+{
+	struct maps__fprintf_args *args = data;
 
-	maps__for_each_entry(maps, pos) {
-		printed += fprintf(fp, "Map:");
-		printed += map__fprintf(pos->map, fp);
-		if (verbose > 2) {
-			printed += dso__fprintf(map__dso(pos->map), fp);
-			printed += fprintf(fp, "--\n");
-		}
+	args->printed += fprintf(args->fp, "Map:");
+	args->printed += map__fprintf(map, args->fp);
+	if (verbose > 2) {
+		args->printed += dso__fprintf(map__dso(map), args->fp);
+		args->printed += fprintf(args->fp, "--\n");
 	}
+	return 0;
+}
 
-	up_read(maps__lock(maps));
+size_t maps__fprintf(struct maps *maps, FILE *fp)
+{
+	struct maps__fprintf_args args = {
+		.fp = fp,
+		.printed = 0,
+	};
+
+	maps__for_each_map(maps, maps__fprintf_cb, &args);
 
-	return printed;
+	return args.printed;
 }
 
 int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index a689149be8c4..14ad95979257 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -81,6 +81,9 @@ static inline void __maps__zput(struct maps **map)
 
 #define maps__zput(map) __maps__zput(&map)
 
+/* Iterate over map calling cb for each entry. */
+int maps__for_each_map(struct maps *maps, int (*cb)(struct map *map, void *data), void *data);
+
 static inline struct rb_root *maps__entries(struct maps *maps)
 {
 	return &RC_CHK_ACCESS(maps)->entries;
-- 
2.43.0.rc2.451.g8631bc7472-goog

