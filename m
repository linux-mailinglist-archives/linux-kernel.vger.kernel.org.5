Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8087FAD04
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbjK0WJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbjK0WJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:09:37 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D96410FB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:09:40 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da07b5e6f75so4393776276.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701122979; x=1701727779; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ojWy9F2KHooGkBXRESL6aoFicBiCSxBaXbQBRQz0etk=;
        b=qmn/TEip73mvx5EYOeHIMFGGxnoHN/gDTliprVJUWH7ti0Kq72uUoooDlbV7YtMTVj
         HugzSWldu4LeG0ow3G1pZHkxLESVDEkOas3F21q06TnAyGZkTOG+KlZPw+EKZd5UicR6
         xHpeRLF/ZI/2nBO6BgnJR+82CiVJBzNwXDQ1MNKvMRfns20p9IRaBjBK60g3OnMGSjTu
         39W+zPP6N309yET+DFlyPAguHGUqzufoQHBSvSUmhjgChdlsUePEqTZ2iAb9KYNZ7EpF
         CIyhdplbpxIb1R9DxaojCHx4gCKo5MaK3i01Ox8dmbye2rj7gWD1bhb35nmX/6WsfliG
         oj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701122979; x=1701727779;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ojWy9F2KHooGkBXRESL6aoFicBiCSxBaXbQBRQz0etk=;
        b=Avpottr522oJDJhKbj5LkDMby7DAmxFFV3kI8iCBXJABWoSA6XlFZLED+stxIDYsuO
         8VEmmCr6QXpgYiTTPaRV5b07IpMnJSbuMBFVbQ0/0S3auvXD5PD6dHvln3dc6kFUd7MA
         D0g0wTnMdZQrZV708RGAGfAcpHOpx19U2V3PilyeqNgbBbzG5XoxT3DHG5zmqofl3g3A
         Zbaj3ay/K8DgYJ48mrjQ7LTQQzo5tlWS8EEs05If+ubtp4cO2uzBShPJRiSEDj8jwNBP
         oluyF0DtlYtCzxR3rxSpcAybEGIvNlWtNh6JBAcMOMJp/mUoWJTeqsh6uYXqPStcR5OE
         Phjw==
X-Gm-Message-State: AOJu0YwGxDHlyXqGOJG7VAdKlPIiB07/o/QwUhjlzsZ3g1nRL34mZMCN
        MXTSo6P9UVRwEWh1lwtAOiVQjlIF43SS
X-Google-Smtp-Source: AGHT+IFZ6v6AkIBcPRNBxkmA7qOayZb3zUcQto6iDIhbSDG4P5BDPGDEKIore9XjAmmIUvfyadeho8WQYl07
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:829:6e77:9093:f39b])
 (user=irogers job=sendgmr) by 2002:a25:d10e:0:b0:d9c:f811:eb9e with SMTP id
 i14-20020a25d10e000000b00d9cf811eb9emr476287ybg.4.1701122979134; Mon, 27 Nov
 2023 14:09:39 -0800 (PST)
Date:   Mon, 27 Nov 2023 14:08:20 -0800
In-Reply-To: <20231127220902.1315692-1-irogers@google.com>
Message-Id: <20231127220902.1315692-9-irogers@google.com>
Mime-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v5 08/50] perf record: Be lazier in allocating lost samples buffer
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
2.43.0.rc1.413.gea7ed67945-goog

