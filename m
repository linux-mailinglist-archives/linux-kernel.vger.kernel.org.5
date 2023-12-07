Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31AC807E42
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 03:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442017AbjLGCQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 21:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjLGCQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 21:16:25 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992E0181
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 18:16:31 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5ddd64f83a4so386907b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 18:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701915391; x=1702520191; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NsPj5qKC8yO/4S4uTFAVTwLtanN0zO749Ogx8NLNS9w=;
        b=N/6UkiRk3RlTUolRr2U13HbrMbLP6QBYU30cTKCRXAI4Ocat2gS09LcbqVT6mRgBvB
         6lU9Dkd3QOk7YtPtnX192uxmHeBWNSX2QlrfuM+q5eWrgJJtkfvx1a6OAVI6J+dB/kVE
         Q30a9m5s1cWkhMjQbXyCqv+N+0CDaXB6lGVv65oAKbxZiiPLiT0ELxxTNN7fsSAoA82S
         60W2MauRqHl6K996FZNqvwRgkURx8ZzkZkZXymtby186Gi2sMzZUrG/a5Q6Z3sPdla9S
         IrejgCIeRU4erj7B0z6arqj8BYojnf3h0I/EXaAZRGPQgQoIsPEJT30Qg5Wc8SeTGLt8
         nGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701915391; x=1702520191;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NsPj5qKC8yO/4S4uTFAVTwLtanN0zO749Ogx8NLNS9w=;
        b=LE4hv0+2OIAnauY1kn+I9Q7IaUlNOFwKWvWyjHppdK61O5h8GEO1TzLS5gbpTKc2vz
         Z1UvO9CXMiXqRz0YnUec/AMg50GsCHNDRPcQ2ABQekgzfBTnrWyr2zEeggYOiArPAC07
         +kjTrEE3KaTUB5pS61PqEmcptbs/XYce9RIvraMLoJzhGt+MuIp+zNZYjY8ECl+PH57P
         xbyiT33StU5jEQfeacweHz/yzfd/4izmS+BAhd9RmtVj5y9xPLP3VEiJ7jgSXbdVmO55
         GFUsvpBGHoaxGofMbeVtv0dbvDBaRKCzul+w5FnWAezra93sg3+OecuONPzZ3JbZLLWm
         DrDg==
X-Gm-Message-State: AOJu0Yw5eeuPePVfdIrKWZM30kTCcCD4eqMUKlX4f9mapJHaQd8T9b0e
        CTXrZWGEq1+OEsEBCNiltg+G46MTkqs4
X-Google-Smtp-Source: AGHT+IHKrj0RwlDvYvwye9pD9ZReSUK4nwO3Y2DejPuWpye8TRVrJIGwoeP9TIYKuEtMhjsnlPmt8JxE9oN5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a05:690c:2893:b0:5d3:b449:e58e with SMTP
 id ee19-20020a05690c289300b005d3b449e58emr26831ywb.6.1701915390873; Wed, 06
 Dec 2023 18:16:30 -0800 (PST)
Date:   Wed,  6 Dec 2023 18:16:27 -0800
Message-Id: <20231207021627.1322884-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v1] perf record: Reduce memory for recording lost samples event
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce from PERF_SAMPLE_MAX_SIZE to "sizeof(*lost) +
session->machines.host.id_hdr_size".

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
Suggested in:
https://lore.kernel.org/lkml/CAM9d7cjpYHN_Q63sW70vTCisdW=-SzjsrryUUJjgtZ3+9jdxfA@mail.gmail.com/
---
 tools/perf/builtin-record.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index eb5a398ddb1d..206110fc2799 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1954,7 +1954,8 @@ static void record__read_lost_samples(struct record *rec)
 
 				if (count.lost) {
 					if (!lost) {
-						lost = zalloc(PERF_SAMPLE_MAX_SIZE);
+						lost = zalloc(sizeof(*lost) +
+							      session->machines.host.id_hdr_size);
 						if (!lost) {
 							pr_debug("Memory allocation failed\n");
 							return;
@@ -1970,7 +1971,8 @@ static void record__read_lost_samples(struct record *rec)
 		lost_count = perf_bpf_filter__lost_count(evsel);
 		if (lost_count) {
 			if (!lost) {
-				lost = zalloc(PERF_SAMPLE_MAX_SIZE);
+				lost = zalloc(sizeof(*lost) +
+					      session->machines.host.id_hdr_size);
 				if (!lost) {
 					pr_debug("Memory allocation failed\n");
 					return;
-- 
2.43.0.rc2.451.g8631bc7472-goog

