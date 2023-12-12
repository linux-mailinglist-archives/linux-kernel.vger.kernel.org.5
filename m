Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1A880E4B1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 08:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjLLHFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 02:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjLLHFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 02:05:46 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC981BF;
        Mon, 11 Dec 2023 23:05:52 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6ceb27ec331so3324591b3a.1;
        Mon, 11 Dec 2023 23:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702364752; x=1702969552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8kfa0OmifAdVx0rewv27+H2zarhfc//r99xaIhf+us=;
        b=apG0nOpa1dn6mITvJwGLe1jul4Av8UsZ7gVUhv8VTitOcyDGL30fOj1LbfvcV7bm9m
         FqBTbcF77KLjzgieYlima95Dtvw81daTuy0QVlwGgUavaOVZGJrA8/TGjB93328Vgwzl
         PiYDrk5YAFqgLIPiqt51yhPdy+M7jM9BrYijp6198TZJS6J8KxvMlxruIRR9yj+9+mKE
         CuCSQnnwUT/yyLzLM0bTI4roDPn9scTecQvIoWUnaDryPx3s1iZw+193vpI0tbGUG2rR
         I+2pM/lxZY4lVXnc6Z9wSHO38VEFCj4zdhEsUw50yc1PsGtyQ61k0MeyWC9CLr71OsNJ
         CEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702364752; x=1702969552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m8kfa0OmifAdVx0rewv27+H2zarhfc//r99xaIhf+us=;
        b=JUx5BjLRZ0eBeTxsSf6xcrNZtHaD2ovbNzujbU5lNOX2ZqiK2MELqrJKlo6Xf+D402
         IzpKdmDubyIK4Gh1OBjHS2bh8F2ip6N9WMnJIk+Kyx2+I02EA7o0aFrpHaGQ+JtqTNhx
         kjq4j/zlSGv6NiMPdHuVu7+AOCUMX44ZSeCrBKrpSL0wDWoaQgnrhbmw87igUORhipIq
         8sygBz1r7VUIC84/gloMdGjTweaLZCu22NNqlQF9e31Z8q9hQA/GCXd2ZJ+Ypn+6gmYr
         sZUU+SAyP++HF+xznhF4NmWxJmJUvPGocFGf+hKohbd1VvbihOVTK+RG7VgcpabahW4x
         0KNg==
X-Gm-Message-State: AOJu0YzAlBIQ3niSmlgTAqNhlUT3h4s0hRNu7gdyBjvJ4jOeN3Rr2Cuv
        xNfb2NPoDDjYYQ/3s+8JxbM=
X-Google-Smtp-Source: AGHT+IGO1gxqJtPsMRhGhpkniGLOsXPTrca+Ix5rWiE+tExABkSHUl4g9pzL2c1aqd8j6Np2Y4e33A==
X-Received: by 2002:a05:6a00:4b42:b0:6ce:3e7a:cfad with SMTP id kr2-20020a056a004b4200b006ce3e7acfadmr3328198pfb.0.1702364752135;
        Mon, 11 Dec 2023 23:05:52 -0800 (PST)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:7da0:5ec4:de63:3cf4])
        by smtp.gmail.com with ESMTPSA id g17-20020a056a0023d100b006cb6e83bf7fsm7397491pfc.192.2023.12.11.23.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 23:05:51 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Milian Wolff <milian.wolff@kdab.com>,
        Pablo Galindo <pablogsal@gmail.com>,
        Fangrui Song <maskray@google.com>
Subject: [PATCH 2/3] perf unwind-libdw: Handle JIT-generated DSOs properly
Date:   Mon, 11 Dec 2023 23:05:45 -0800
Message-ID: <20231212070547.612536-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231212070547.612536-1-namhyung@kernel.org>
References: <20231212070547.612536-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usually DSOs are mapped from the beginning of the file, so the base
address of the DSO can be calculated by map->start - map->pgoff.

However, JIT DSOs which are generated by `perf inject -j`, are mapped
only the code segment.  This makes unwind-libdw code confusing and
rejects processing unwinds in the JIT DSOs.  It should use the map
start address as base for them to fix the confusion.

Fixes: 1fe627da3033 ("perf unwind: Take pgoff into account when reporting elf to libdwfl")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/unwind-libdw.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 8554db3fc0d7..6013335a8dae 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -46,6 +46,7 @@ static int __report_module(struct addr_location *al, u64 ip,
 {
 	Dwfl_Module *mod;
 	struct dso *dso = NULL;
+	Dwarf_Addr base;
 	/*
 	 * Some callers will use al->sym, so we can't just use the
 	 * cheaper thread__find_map() here.
@@ -58,13 +59,25 @@ static int __report_module(struct addr_location *al, u64 ip,
 	if (!dso)
 		return 0;
 
+	/*
+	 * The generated JIT DSO files only map the code segment without
+	 * ELF headers.  Since JIT codes used to be packed in a memory
+	 * segment, calculating the base address using pgoff falls into
+	 * a different code in another DSO.  So just use the map->start
+	 * directly to pick the correct one.
+	 */
+	if (!strncmp(dso->long_name, "/tmp/jitted-", 12))
+		base = map__start(al->map);
+	else
+		base = map__start(al->map) - map__pgoff(al->map);
+
 	mod = dwfl_addrmodule(ui->dwfl, ip);
 	if (mod) {
 		Dwarf_Addr s;
 
 		dwfl_module_info(mod, NULL, &s, NULL, NULL, NULL, NULL, NULL);
-		if (s != map__start(al->map) - map__pgoff(al->map))
-			mod = 0;
+		if (s != base)
+			mod = NULL;
 	}
 
 	if (!mod) {
@@ -72,14 +85,14 @@ static int __report_module(struct addr_location *al, u64 ip,
 
 		__symbol__join_symfs(filename, sizeof(filename), dso->long_name);
 		mod = dwfl_report_elf(ui->dwfl, dso->short_name, filename, -1,
-				      map__start(al->map) - map__pgoff(al->map), false);
+				      base, false);
 	}
 	if (!mod) {
 		char filename[PATH_MAX];
 
 		if (dso__build_id_filename(dso, filename, sizeof(filename), false))
 			mod = dwfl_report_elf(ui->dwfl, dso->short_name, filename, -1,
-					      map__start(al->map) - map__pgoff(al->map), false);
+					      base, false);
 	}
 
 	if (mod) {
-- 
2.43.0.472.g3155946c3a-goog

