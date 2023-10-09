Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1C57BE9D4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378351AbjJISjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378233AbjJISjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:39:43 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7855FE9
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:39:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a45e7e0f9so427375276.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 11:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696876780; x=1697481580; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MTpWBQgPQVQy0TAZXLEWpBVQQ2YTPMy6ZmoyjFN0GGE=;
        b=qmHE39qmWSQLTvMKSb2BXWkZwWApobrmAKmtm7mq0rdAfERykcCz8xuEv/bWuEJrqR
         tnmKKm+FW/8n87xQW6j46XHC1I69IvsnbrRD+eq7avKDUZjaaLT5NPpL2+QH4kMMJGxF
         oLHBfuj8Ay9PG2bb1Xsvc5TFt1eA6gldWFNmCUu8A+Xmbb9HNYFwanXrIysLcHzqhQng
         xQghqyRJxKTcDczz03ooQZrEV0ZqSOoTmcEDLoIV6iQGziWpRLIGJechrq5dlMksBYPL
         iZL+Iogh3FbQHeZ/KNso2dBNHvlndvgG9Ia5W3q4vZXjUmeOI2uE+gvt5XMCvqQ65947
         T9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876780; x=1697481580;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MTpWBQgPQVQy0TAZXLEWpBVQQ2YTPMy6ZmoyjFN0GGE=;
        b=h4q8ZBNlDZ/rfX1I9bjr2G6cuzsPi01ySZxGsAefV1qt1oBEhKZnR9jvy9ZEwGHeOh
         +YI4VBBUKiZhCpdcvoN9eaYcd0dDsX6/kqtxj9mXts1+2tpsuYDOXyvvZyciQWcd301F
         qEXnF5D1hhEUH4u/UeSbau7F8W+VDsZZLBkwm/LEnYdmrdIkZsDG+XSYkO55M0/recw5
         8fpx/n+S9tEDFa03MVhEYdIJDmbtMaapFxe1aKPndcqXB+uobv7fhbwOQqGSzAUXJw6Q
         P9WhVDLyb2MP88/1XtilA/rXhpkkTCzMZlbSXQSq5g0/A4lIDVvgRIB5/kthyPU5WrSo
         a4Zg==
X-Gm-Message-State: AOJu0YzbzYRycaIdUoQlEBBNGrc4uZ+ixDB7p9MfZF+c1s81ayjNKZIQ
        uqurHWMP8BlESivvYUEm3oAvAwBrj4JM
X-Google-Smtp-Source: AGHT+IHSFLzIMOdZMLClCkJhOThmOClRy30ep3/ZFs+55TAb6kM08lo1dDdwBNKotykaeaR7pVv7k1gDXaCN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ac4a:9b94:7158:3f4e])
 (user=irogers job=sendgmr) by 2002:a05:6902:181a:b0:d89:3ed5:6042 with SMTP
 id cf26-20020a056902181a00b00d893ed56042mr268371ybb.11.1696876780144; Mon, 09
 Oct 2023 11:39:40 -0700 (PDT)
Date:   Mon,  9 Oct 2023 11:39:07 -0700
In-Reply-To: <20231009183920.200859-1-irogers@google.com>
Message-Id: <20231009183920.200859-7-irogers@google.com>
Mime-Version: 1.0
References: <20231009183920.200859-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v3 05/18] perf buildid-cache: Fix use of uninitialized value
From:   Ian Rogers <irogers@google.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ming Wang <wangming01@loongson.cn>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The buildid filename is first determined and then from this the
buildid read. If getting the filename fails then the buildid will be
used for a later memcmp uninitialized. Detected by clang-tidy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-buildid-cache.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index cd381693658b..e2a40f1d9225 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -277,8 +277,10 @@ static bool dso__missing_buildid_cache(struct dso *dso, int parm __maybe_unused)
 	char filename[PATH_MAX];
 	struct build_id bid;
 
-	if (dso__build_id_filename(dso, filename, sizeof(filename), false) &&
-	    filename__read_build_id(filename, &bid) == -1) {
+	if (!dso__build_id_filename(dso, filename, sizeof(filename), false))
+		return true;
+
+	if (filename__read_build_id(filename, &bid) == -1) {
 		if (errno == ENOENT)
 			return false;
 
-- 
2.42.0.609.gbb76f46606-goog

