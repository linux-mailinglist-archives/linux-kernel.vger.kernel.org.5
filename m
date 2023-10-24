Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361687D5E1B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 00:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344555AbjJXW0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 18:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344520AbjJXWZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 18:25:58 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CDD2706
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:25:22 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a92864859bso45299357b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186321; x=1698791121; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zKJ+MtJQ0m3usmVnmVc1PXHVWWmmWPISerzupGC9o9o=;
        b=WjFIzquiFxSHREY+b5v7HReFVePOCy0rewrxOZVoMVT9dUg5oz4RrLCg4C3GTAf/9M
         1XI2OOtYV8YYuvB9g9K5RrxU60ROgFhyrKCOzhFsrFD5K3U3l4S9J/EXpyWZ4/fYBnIj
         Q0j6kcbPv6Yy1Q6ZoCifsFccsqmhpJmn7CnnZ0G364+ArXWLdw3AXhlyYTFsslDdXovM
         oKZ8IiC7fi/c+RJOBZAhiaA3J+BGVVQ0q8dyIo4a8TwxBw0ouqvzE+Ss5CN5L4s27uUL
         zQZV6QnK2Ik0ronIPg+QwKoG0JWFHy+lMJ7/2sfvFL9TnQB+kC/8ljFqpDyZKbJBdj4G
         qq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186321; x=1698791121;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zKJ+MtJQ0m3usmVnmVc1PXHVWWmmWPISerzupGC9o9o=;
        b=uz9A/qIVYv+aSsSFrlChmlU08NRKjpuOedgZVo4trWnikabkc8nXZnIwgiR81hKC7J
         Eadc9enhJ/p5v/FBjv2wYkiJ5tL37O+ArdeuViOgo1ip7rvm7LF89p2+D8aUkecQcrL8
         rU6CgOURD+YS91MgCeHRZTCIBV2+EIXukefgezanFoSHGcHrvzn6LSmoa9DjZf2I0a6m
         xe64HnQP9RCcXc0vuli2LOZDwP5sovPlnnx0RNXbDMwWygQny3sJDOfGxeSTP3+yj6ea
         HMma53IApBIJRwXCT5Ev9pItVDhYFKUsoW4CqjvRLjV/t21+1KIABCLn4qV09LR+WFyz
         nILw==
X-Gm-Message-State: AOJu0YwKHvh3NWA19ZcXrNlCg8fCogEHZUMglS9ixk/r3+jiT1C/WlAU
        PovqDY5LJJJ4JQ/XZcHZPbEw98Io2fRa
X-Google-Smtp-Source: AGHT+IEGfa+bbgNdmI/PGpBJGaemgihnReGqhdHNeMywurRc5ADtlpQhmpZjpLjYUXu/PpjX9AVsQVzdnU23
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a0d:d644:0:b0:5a7:f73d:e69 with SMTP id
 y65-20020a0dd644000000b005a7f73d0e69mr271131ywd.4.1698186320786; Tue, 24 Oct
 2023 15:25:20 -0700 (PDT)
Date:   Tue, 24 Oct 2023 15:23:33 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-31-irogers@google.com>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 30/50] perf debug: Expose debug file
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

Some dumping call backs need to be passed a FILE*. Expose debug file
via an accessor API for a consistent way to do this. Catch the
unlikely failure of it not being set. Switch two cases where stderr
was being used instead of debug_file.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/debug.c | 22 +++++++++++++++-------
 tools/perf/util/debug.h |  1 +
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index 88378c4c5dd9..e282b4ceb4d2 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -38,12 +38,21 @@ bool dump_trace = false, quiet = false;
 int debug_ordered_events;
 static int redirect_to_stderr;
 int debug_data_convert;
-static FILE *debug_file;
+static FILE *_debug_file;
 bool debug_display_time;
 
+FILE *debug_file(void)
+{
+	if (!_debug_file) {
+		pr_warning_once("debug_file not set");
+		debug_set_file(stderr);
+	}
+	return _debug_file;
+}
+
 void debug_set_file(FILE *file)
 {
-	debug_file = file;
+	_debug_file = file;
 }
 
 void debug_set_display_time(bool set)
@@ -78,8 +87,8 @@ int veprintf(int level, int var, const char *fmt, va_list args)
 		if (use_browser >= 1 && !redirect_to_stderr) {
 			ui_helpline__vshow(fmt, args);
 		} else {
-			ret = fprintf_time(debug_file);
-			ret += vfprintf(debug_file, fmt, args);
+			ret = fprintf_time(debug_file());
+			ret += vfprintf(debug_file(), fmt, args);
 		}
 	}
 
@@ -107,9 +116,8 @@ static int veprintf_time(u64 t, const char *fmt, va_list args)
 	nsecs -= secs  * NSEC_PER_SEC;
 	usecs  = nsecs / NSEC_PER_USEC;
 
-	ret = fprintf(stderr, "[%13" PRIu64 ".%06" PRIu64 "] ",
-		      secs, usecs);
-	ret += vfprintf(stderr, fmt, args);
+	ret = fprintf(debug_file(), "[%13" PRIu64 ".%06" PRIu64 "] ", secs, usecs);
+	ret += vfprintf(debug_file(), fmt, args);
 	return ret;
 }
 
diff --git a/tools/perf/util/debug.h b/tools/perf/util/debug.h
index f99468a7f681..de8870980d44 100644
--- a/tools/perf/util/debug.h
+++ b/tools/perf/util/debug.h
@@ -77,6 +77,7 @@ int eprintf_time(int level, int var, u64 t, const char *fmt, ...) __printf(4, 5)
 int veprintf(int level, int var, const char *fmt, va_list args);
 
 int perf_debug_option(const char *str);
+FILE *debug_file(void);
 void debug_set_file(FILE *file);
 void debug_set_display_time(bool set);
 void perf_debug_setup(void);
-- 
2.42.0.758.gaed0368e0e-goog

