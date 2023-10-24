Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C057D5E13
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 00:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344536AbjJXWZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 18:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344566AbjJXWZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 18:25:34 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32C9210B
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:24:59 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da0631f977bso513269276.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186298; x=1698791098; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FTWwQ8YfXPTitLblRQYRVGGgeCbpOK/vEMTFXnHDMuM=;
        b=cw1O5URq2Mma06yy6NvGqZMvJqNIMy+ocLnn9th9g6iBkdDYqrsVIDc9HBx/pQPGKP
         E633Rh4yq9+3JZitBFsb9HDNLyuSD1g2+HM1XPhrDMqcXFDOtG+4dBA/i5tBOMJEw263
         E7lla66VbrGC7vqW0OsakbQmF0i4p4YthUnNWnPna84nFa7fEneIciTQr6YkEXRLYHCj
         Lo03ccU0G4zr18pZqBkSy1/qv+ImmRarxUENWJUT5Vn09JJ8qyl2Spl5S6PPnjDiPds3
         ARsP7u+BdgNKAeFiWlBaIq7327xBKVHTScmsyCWhBT6fMLFHc8gKulzBOgUWn99+Hkcx
         2JIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186298; x=1698791098;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FTWwQ8YfXPTitLblRQYRVGGgeCbpOK/vEMTFXnHDMuM=;
        b=IfY6sQn0K3PBGWN7FndFV+EeBlJF1z/GbUDRccwNmcjlC4ro+EtdSTC0zl2n7F+PMF
         MY/vhHqd8hTb4eZkuHVY6NAbKUA6Kh6/a3oSuuNyrUsEfzjyYTno+5wKyyKvho1RAsNE
         QjjLk9Cs9UTuJ+GG3oeM8ptT7aQSdVG/wb+YZYQ68bbdFcgy67y2A+vgtOlxvKE/6G6e
         3fAvL0IaE93S9zm8JiZ5EZccIS3cjZPIIznim+BQvv+8T6mKqy72apBhENkNtevAja2Y
         2bAnFhSY8A8JUn2Q/4miJUsY63JTV0Qd3iP46baMNSOJlpCsMy7uJZf8nUVLd+5XZIfE
         yNEg==
X-Gm-Message-State: AOJu0YxyHpgiTvk67nMzCGsKtarqeZqepfU1TMldFihurgHlN7RNuDe4
        sIDO1u4JVQRYBWIRiwGRrxzY1JBcASMJ
X-Google-Smtp-Source: AGHT+IFaOqY2yVaizOCYlulJuJEY1d+et6asX7PpUqzve62EmW3QbpYsbLIYzs8QMwOhWhSTrGe+fxfI6ngK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a25:3453:0:b0:d73:bcb7:7282 with SMTP id
 b80-20020a253453000000b00d73bcb77282mr270067yba.8.1698186297774; Tue, 24 Oct
 2023 15:24:57 -0700 (PDT)
Date:   Tue, 24 Oct 2023 15:23:23 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-21-irogers@google.com>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 20/50] perf record: Be lazier in allocating lost samples buffer
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
        Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
        Song Liu <song@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
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
2.42.0.758.gaed0368e0e-goog

