Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D33D7DF949
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 18:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345197AbjKBR6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 13:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344990AbjKBR6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:58:13 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4341A6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 10:58:03 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da0cb98f66cso1414569276.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 10:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947883; x=1699552683; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=45fiMNEp9HPngAxEFglGXsIL4df8TDdJeTxUUf03U6k=;
        b=ZDeAbjg7DorUI11gf20wny99hf5XbQfWunnSPi5m2R0HqVc8OL5uP07/PGLYd9Y90a
         f9teeab/1qgusnyL0LPb1etfZ5EWJ5vgf8AukOhCo4nC7hgC2jentTcDzalgx6PvTnEp
         vGt3ocDD6X2AecPEWf9gFIfcMuFiMPzsRLDkIRpZlO1bgeOi+M9bB8r0fqfALrwzzlIy
         jHs7MitmAzVeS9YCcFsnURV/w3ezT2H3wbu15KE0uaiZgY0p5kZ1+UPlBdJGQuBOWjOM
         oBBoK47cgaIC+gvIe9Mub1Q8gaDZIazLl6FnYNBLoxz7OEswjHCYi8xdepODCBzcWmcF
         hYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947883; x=1699552683;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=45fiMNEp9HPngAxEFglGXsIL4df8TDdJeTxUUf03U6k=;
        b=m0bm5QWl3x7GAL0j8InzHUp27xoQty79er1GQqQ0ZMbMS3v6jc4Splc2VHBPMShCrG
         oCdB+uJFl9ve1yAydZV0n1+EGIAME++SPfhpSn/4BScGk9Z61V0qZZTlLem8kjakYkih
         pVAjpadCH9X7f6ol5506ZSlIEejR0L+VeKjL2K5k7tQZiSDpJZZgyKxmQcaeZA86dZj8
         7e9J+dT3p1IQYkrzEJ2typHRjrHkcE/A40f78EvEHgeN10pik1w2HsWbX9qYxFtQvHmX
         Di+n9+IygGCxxZ2e0y9jEdoVRn7SpagUyvUXOg3pqs3NyvWprKs91zMvmkOKTgvPAviX
         5M4w==
X-Gm-Message-State: AOJu0YxpPdSY0hxaKJmhoSQ7/uhTstBvZF1GuzZA2trC7vtEWFmqeTeD
        Onq66fI7xEZoqnQvJza7q1Ek5xqX+3r0
X-Google-Smtp-Source: AGHT+IENFlAyl9vXQBjRtD+XiY/TwACpk+u88teaJTffi2eg0vZX7VYr6cjbiESg5TdIIGwkgX4vSmr4BW8A
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a05:6902:168c:b0:da0:3e46:8ba5 with SMTP
 id bx12-20020a056902168c00b00da03e468ba5mr359884ybb.8.1698947882736; Thu, 02
 Nov 2023 10:58:02 -0700 (PDT)
Date:   Thu,  2 Nov 2023 10:56:45 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-4-irogers@google.com>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 03/53] libperf: Lazily allocate mmap event copy
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
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The event copy in the mmap is used to have storage to a read
event. Not all users of mmaps read the events, such as perf record, so
switch the allocation to being on first read rather than being
embedded within the perf_mmap.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/include/internal/mmap.h | 2 +-
 tools/lib/perf/mmap.c                  | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/include/internal/mmap.h b/tools/lib/perf/include/internal/mmap.h
index 5a062af8e9d8..b11aaf5ed645 100644
--- a/tools/lib/perf/include/internal/mmap.h
+++ b/tools/lib/perf/include/internal/mmap.h
@@ -33,7 +33,7 @@ struct perf_mmap {
 	bool			 overwrite;
 	u64			 flush;
 	libperf_unmap_cb_t	 unmap_cb;
-	char			 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
+	void			*event_copy;
 	struct perf_mmap	*next;
 };
 
diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
index 2184814b37dd..91ae46aac378 100644
--- a/tools/lib/perf/mmap.c
+++ b/tools/lib/perf/mmap.c
@@ -51,6 +51,8 @@ int perf_mmap__mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
 
 void perf_mmap__munmap(struct perf_mmap *map)
 {
+	free(map->event_copy);
+	map->event_copy = NULL;
 	if (map && map->base != NULL) {
 		munmap(map->base, perf_mmap__mmap_len(map));
 		map->base = NULL;
@@ -226,6 +228,13 @@ static union perf_event *perf_mmap__read(struct perf_mmap *map,
 			unsigned int len = min(sizeof(*event), size), cpy;
 			void *dst = map->event_copy;
 
+			if (!dst) {
+				dst = malloc(PERF_SAMPLE_MAX_SIZE);
+				if (!dst)
+					return NULL;
+				map->event_copy = dst;
+			}
+
 			do {
 				cpy = min(map->mask + 1 - (offset & map->mask), len);
 				memcpy(dst, &data[offset & map->mask], cpy);
-- 
2.42.0.869.gea05f2083d-goog

