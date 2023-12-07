Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292C4807DB6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442991AbjLGBSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442038AbjLGBS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:18:28 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F4519BD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 17:18:02 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db402e6f61dso534596276.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 17:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911877; x=1702516677; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LdvL5AMgGawz38PbKP6bJb9rCM4m4RVHx/ZUCFaT4KI=;
        b=eIalGa6NBwURfR5gfFD2dyslg5agUniNKtTQ8ta8R7nV/ESDmICnC4+fOyBtlZnAU4
         i8UYi6dXHUPHdtz3Zf4+D40x+Wn0piod5nKWjbyYEeo4CsdrEINAGtzSdWpnkXTZewIJ
         jK0moWyDeX0I77URJ8Fi5RXsm6e2e3DhD6rQ1K/z/WMVXGfisKNc9Tzo/iUR4TijTBV5
         qqIzedjic8hvVuPvLW1x94vplPk2o5Tu0+BNQHjBJebe/HDpnBxStBGoLksAZx3pAFzA
         WpLQC0BhtUKlCankJwjT5yIbUA8Me1Y7+w8V3IQvtpJrEKWiBTRVnDlSN2Xecj9nt9hx
         UuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911877; x=1702516677;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LdvL5AMgGawz38PbKP6bJb9rCM4m4RVHx/ZUCFaT4KI=;
        b=ouiMxOgs0+O7Lj/pApt+nfkS/eocTMcqqxYAkzC6zewXAWnZBJZ0r00nUMG4qvs8DA
         xtd4Ds2aTPRLbEo/QJos3huIZ2y3CY+ypW/NI+17RYugWGG6T69KAXUqbr5WY4cgJwim
         4nu5pjbmHIPZ6xc0zfPcrp/c2l6964kTrqWW1NeO8I0BoxtdwpJE9FStFKZsDqj0dej+
         SqsClOQ/j2niVbjdywGf+0sBfWnQeSCb1ieVKTvAerqh9oGjH8pCKrXgURJum42r9hJC
         Uo2YLH1jHWPuRQclZf+XsVpww+Plk/NrolHGYvBOuVbhDK+3b+TYNhai5z1D1R4zZBG0
         68wA==
X-Gm-Message-State: AOJu0Yxj8mZynRO55ub45jIjH36+l3zfp330xNLMmGySfQ+ed6K2zJnN
        LxrhqxkKbaGwHFUfq8pEedUXRYYhpruc
X-Google-Smtp-Source: AGHT+IFwfNkHgIpPgOHFHAls/fybTbtDbjEPoiQ0LnBRzmA0eriNl9OZDpm91G687u7YpRH1FafQtsKGElCY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a25:ccd5:0:b0:daf:6333:17c3 with SMTP id
 l204-20020a25ccd5000000b00daf633317c3mr24166ybf.1.1701911877641; Wed, 06 Dec
 2023 17:17:57 -0800 (PST)
Date:   Wed,  6 Dec 2023 17:16:47 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-14-irogers@google.com>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 13/47] perf maps: Reduce scope of maps__for_each_entry
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

Reduce scope of maps__for_each_entry as maps__for_each_map is a safer
alternative holding the maps lock during iteration.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c | 3 +++
 tools/perf/util/maps.h | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 160a6dce54bb..00e6589bba10 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -10,6 +10,9 @@
 #include "ui/ui.h"
 #include "unwind.h"
 
+#define maps__for_each_entry(maps, map) \
+	for (map = maps__first(maps); map; map = map_rb_node__next(map))
+
 static void maps__init(struct maps *maps, struct machine *machine)
 {
 	refcount_set(maps__refcnt(maps), 1);
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index 14ad95979257..8ac30cdaf5bd 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -36,9 +36,6 @@ struct map_rb_node *map_rb_node__next(struct map_rb_node *node);
 struct map_rb_node *maps__find_node(struct maps *maps, struct map *map);
 struct map *maps__find(struct maps *maps, u64 addr);
 
-#define maps__for_each_entry(maps, map) \
-	for (map = maps__first(maps); map; map = map_rb_node__next(map))
-
 #define maps__for_each_entry_safe(maps, map, next) \
 	for (map = maps__first(maps), next = map_rb_node__next(map); map; \
 	     map = next, next = map_rb_node__next(map))
-- 
2.43.0.rc2.451.g8631bc7472-goog

