Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFD67DF95E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376705AbjKBR7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 13:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbjKBR6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:58:35 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE887D78
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 10:58:19 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7d261a84bso17649837b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 10:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947899; x=1699552699; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K5PgdsnPH7oI10azUBd0z2aRarT0oGQNjgB7Dvx0Ne0=;
        b=0JC1pR9NC+wjbC7AoiPY/Rd2b0kYe/RInF1IQEjZSYwlobCeoKmMIriyHU/i3D//Ek
         rIqQOyxjbCzCw7duHKXj9bfmlQAsWfoD3pCEE/MX9M95nIaPydlj5xZYHq4tGK59tLdB
         ZoXcb7Z5damA8LnffX8SLcHMD3YFgHnbihXd6VTXcrZI/Rftu0k0ee4n61/B5VaajnCZ
         oSAx8NafXUvkLfe7CiE+R6XQCsxExi4VsgXL+Qqan+NcVR4YppdKvM/5oZr2tRVQAEAl
         1pKg/qpDKSPkYqYM2GLIRJCCadCTmXy6f+cVmZRHQ/LFKyIkzIt4tMxTHCYoPpQoQAEA
         viCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947899; x=1699552699;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K5PgdsnPH7oI10azUBd0z2aRarT0oGQNjgB7Dvx0Ne0=;
        b=GUwCg6vOHERcyL+F7f8nvRODXfPEAQsdJRnyhhe89BkOznuYCAIWwUZA8jR1UNUNFc
         lX0V1YWFIbswkXdaMJQruVMwpIxoJUh98HVK0KWnKc+6n4NjI/w8pjSq9J/LyAwCYxfI
         Z6KstyYOHspc2p7v8Ydb8gqZwZYgsvbznF0lHdUrKzr+gd28icaI+IcUerabaZYdlmxL
         s1wgOS84QoUfu1Qj/LZtYgjdFqBym7M6bK7Dyf6Sc62fCG/bw/lTh9/REvVtRhinXYni
         b8d5er5+kuXWqu1kt4i2wZTZjRBzSXaKH00wk0oKHIDKufZWv58VsjPbGiosCN9OeVo1
         ehPA==
X-Gm-Message-State: AOJu0Yyq4Dh/IsTqJgwq7FElkNqPmrz3xAgv0Q/wHlUTLbFKPURx0rjP
        PZuGVVengPph3qZH0YTN7fjkUdf9O0h1
X-Google-Smtp-Source: AGHT+IE/xmbYEWKH6RBOQRI171I9yC8HUIHsRXQIAw0gBljxL458sfjGnRwpi9ubJuKxlU9ZGOtOe9IETfdR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a81:4ed5:0:b0:59b:c6bb:bab9 with SMTP id
 c204-20020a814ed5000000b0059bc6bbbab9mr8387ywb.3.1698947898905; Thu, 02 Nov
 2023 10:58:18 -0700 (PDT)
Date:   Thu,  2 Nov 2023 10:56:52 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-11-irogers@google.com>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 10/53] perf record: Be lazier in allocating lost samples buffer
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wait until a lost sample occurs to allocate the lost samples buffer,
often the buffer isn't necessary. This saves a 64kb allocation and
5.3kb of peak memory consumption.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 9b4f3805ca92..b6c8c1371b39 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1924,21 +1924,13 @@ static void __record__save_lost_samples(struct record *rec, struct evsel *evsel,
 static void record__read_lost_samples(struct record *rec)
 {
 	struct perf_session *session = rec->session;
-	struct perf_record_lost_samples *lost;
+	struct perf_record_lost_samples *lost = NULL;
 	struct evsel *evsel;
 
 	/* there was an error during record__open */
 	if (session->evlist == NULL)
 		return;
 
-	lost = zalloc(PERF_SAMPLE_MAX_SIZE);
-	if (lost == NULL) {
-		pr_debug("Memory allocation failed\n");
-		return;
-	}
-
-	lost->header.type = PERF_RECORD_LOST_SAMPLES;
-
 	evlist__for_each_entry(session->evlist, evsel) {
 		struct xyarray *xy = evsel->core.sample_id;
 		u64 lost_count;
@@ -1961,6 +1953,14 @@ static void record__read_lost_samples(struct record *rec)
 				}
 
 				if (count.lost) {
+					if (!lost) {
+						lost = zalloc(PERF_SAMPLE_MAX_SIZE);
+						if (!lost) {
+							pr_debug("Memory allocation failed\n");
+							return;
+						}
+						lost->header.type = PERF_RECORD_LOST_SAMPLES;
+					}
 					__record__save_lost_samples(rec, evsel, lost,
 								    x, y, count.lost, 0);
 				}
@@ -1968,9 +1968,18 @@ static void record__read_lost_samples(struct record *rec)
 		}
 
 		lost_count = perf_bpf_filter__lost_count(evsel);
-		if (lost_count)
+		if (lost_count) {
+			if (!lost) {
+				lost = zalloc(PERF_SAMPLE_MAX_SIZE);
+				if (!lost) {
+					pr_debug("Memory allocation failed\n");
+					return;
+				}
+				lost->header.type = PERF_RECORD_LOST_SAMPLES;
+			}
 			__record__save_lost_samples(rec, evsel, lost, 0, 0, lost_count,
 						    PERF_RECORD_MISC_LOST_SAMPLES_BPF);
+		}
 	}
 out:
 	free(lost);
-- 
2.42.0.869.gea05f2083d-goog

