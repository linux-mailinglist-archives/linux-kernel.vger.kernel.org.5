Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CAC7BAF3A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 01:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjJEXML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 19:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJEXJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 19:09:55 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FA310C3
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 16:09:40 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f8188b718so22137617b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 16:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696547379; x=1697152179; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wfL4FLU++s9CKjil59t6XdpqiER2jatUC+zl7nbhx6Q=;
        b=aFrkysO+gaNCXmgevliCscZ/ljl+qyLGxh4dkDOE8MXHBtBSjaflkaNqf2jTG4i5MD
         QtJwYlUVzJGLFXYJeZ9yJS3xK449JhO48JT8wJ/tKK35WVBEm7gtvtrRIKJd2rVXJtLO
         g2HLvywtsp55v2tSZ2083iBvgZgZBcwkM6CxQ+xGntrWJifs4LlmqTIWbWxKqY+vj0im
         PAC6FeLuZn6ZHpcRxe1YAlbr+xT9mxYJJZnB4osUIzw90DTyqF8NO9Na5inVskaKuxVs
         JG4gVSQty7O5rVwbeI/Uj4la9jQAU4m5H05vmWXCJnFAHhjRkP88CPBK+X+HW6J/LANl
         Q3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547379; x=1697152179;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wfL4FLU++s9CKjil59t6XdpqiER2jatUC+zl7nbhx6Q=;
        b=OHzSJsatQJ/0NOHQsjn8xlNN6hAH5fCJkw5V2E8IpJAYRahkJkpNAb7u57F7dX3s6B
         r3Vv35mbExcdJx3dD1aN+zaiRgf+f3xof7Iku5DwWv4d2ObyY/GDTVDInGWcaNBwgwqs
         Wdf5f1rtr5p92MrQbrnwcUx78X0Ryr5dFqW7Zrnz2W0HahBJMrDOm+ess51tgYWVXPHE
         OwRPOtKcAtzd6kytAY+eQLaJ5h00szsUkgFLU9UmFhLJmesdN3EtQNEmf3vj66g5VlQ/
         2yDd/GtM9i5ZJKY7osJpTmZlD2BFh60Upp9zb4BHOslngy90ApjLEoJjhc0Yqa1K2+6/
         vcLQ==
X-Gm-Message-State: AOJu0Yy0tDgoNKpPLVdRbT6JhXK/IptsFtoYkgnZ6oJKQZnKYkYZTuC7
        qRG0DBR+3Y4E1kPupvnpvHmscIFXYtCA
X-Google-Smtp-Source: AGHT+IHgsU7WqtGzIXgNXr1P8QSditE9WLikTdLCJCQWnQLq+FpPEmuFYiUkFS5RxrsXiCHqXCKcfq5Bkre2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7449:56a1:2b14:305b])
 (user=irogers job=sendgmr) by 2002:a25:586:0:b0:d7e:dff4:b0fe with SMTP id
 128-20020a250586000000b00d7edff4b0femr96767ybf.7.1696547379763; Thu, 05 Oct
 2023 16:09:39 -0700 (PDT)
Date:   Thu,  5 Oct 2023 16:08:51 -0700
In-Reply-To: <20231005230851.3666908-1-irogers@google.com>
Message-Id: <20231005230851.3666908-19-irogers@google.com>
Mime-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 18/18] perf bpf_counter: Fix a few memory leaks
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
        Yicong Yang <yangyicong@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Yuan Can <yuancan@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        James Clark <james.clark@arm.com>, llvm@lists.linux.dev,
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

Memory leaks were detected by clang-tidy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_counter.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index 6732cbbcf9b3..7f9b0e46e008 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -104,7 +104,7 @@ static int bpf_program_profiler_load_one(struct evsel *evsel, u32 prog_id)
 	struct bpf_prog_profiler_bpf *skel;
 	struct bpf_counter *counter;
 	struct bpf_program *prog;
-	char *prog_name;
+	char *prog_name = NULL;
 	int prog_fd;
 	int err;
 
@@ -155,10 +155,12 @@ static int bpf_program_profiler_load_one(struct evsel *evsel, u32 prog_id)
 	assert(skel != NULL);
 	counter->skel = skel;
 	list_add(&counter->list, &evsel->bpf_counter_list);
+	free(prog_name);
 	close(prog_fd);
 	return 0;
 err_out:
 	bpf_prog_profiler_bpf__destroy(skel);
+	free(prog_name);
 	free(counter);
 	close(prog_fd);
 	return -1;
@@ -180,6 +182,7 @@ static int bpf_program_profiler__load(struct evsel *evsel, struct target *target
 		    (*p != '\0' && *p != ',')) {
 			pr_err("Failed to parse bpf prog ids %s\n",
 			       target->bpf_str);
+			free(bpf_str_);
 			return -1;
 		}
 
-- 
2.42.0.609.gbb76f46606-goog

