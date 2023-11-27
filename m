Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C547FAD3D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbjK0WQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbjK0WKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:10:16 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1805C10F6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:10:04 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5cd2100f467so60730377b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701123003; x=1701727803; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=74QLH4lft9zfzlsPq86t9Qk+/WjoI7cS4MoOjhAmrDw=;
        b=Y/oR5VbWO0lojZUT3goA1EGmqSRbmbnvRdC5dRR4fA2LIeuTr8KZovchCmi8HCXIJG
         p0hOJ4sAmT86IMx0Wh6/nqK0NpjLnSsaqeZ7tEjEuv8CzDkqY7L0wDqgQQfRQ4MDFOlh
         jaVN8i7tqYQ0N5NsPdptlwxzllWDeGAr/Z9d69MoEDAjOs7dW42UahVF/nAKmWKpFEdC
         V7ltwXQQRwlRFGVrzM3rrmk2atXiYJa/xvsOTbnhlPr94u5MmfvXVdQIQMQ1YXvGOrQc
         YmS5nP9DLTwx8VyIKuGQ5xjMq/IQLAVvJNRAgQKM43jPo4EqRAl5ZauN/HgrBpHoWWZg
         +/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701123003; x=1701727803;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=74QLH4lft9zfzlsPq86t9Qk+/WjoI7cS4MoOjhAmrDw=;
        b=hHWwOmCcclyTYKpTVH1tme+emujQq8tfdUF1AHRwBS533chsk9AV5HtveveB0pxBts
         KcdrGwTkoiLQXl+IcEor28IVyiXw4dsLG7WcDT9q4sWNZNpEBWIKqQlxRezpzOPqlu2P
         nYiV6bELkIKW8CMt9d9zOGlLZWgCTyessGcQdUbSvyI6kNlk8GYFN5vIDFjdbnPykjgs
         Ff6FHsu7YkzquLQMcIkzafJeZN54ZUB+AXZM7PCPP67dLUhAklR5i4DTXZDHCWvL/N+i
         vlAKFdmEMWTyl2tIr6QrAwdqK+FckWD9PICSu4m0ezA1IHtcUoxoGCPoy9RK6SEc+IhP
         XbZA==
X-Gm-Message-State: AOJu0YxUVIr8gU5HHmwaT0K+IFJjm68IphMadLVL75PxfQX7izP60xAP
        zkDFNMZarifVADqEx+B5+oILfbcnvha8
X-Google-Smtp-Source: AGHT+IFpLm8wJ88TEpLGjaTEVM0kBmLE+9Aqm8CkqTibxFOq5ZdHR/4ErHO5caCX/uuCebGtpCZvzHcwSbzN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:829:6e77:9093:f39b])
 (user=irogers job=sendgmr) by 2002:a05:690c:fcd:b0:5ca:fef:82a4 with SMTP id
 dg13-20020a05690c0fcd00b005ca0fef82a4mr492696ywb.4.1701123003294; Mon, 27 Nov
 2023 14:10:03 -0800 (PST)
Date:   Mon, 27 Nov 2023 14:08:29 -0800
In-Reply-To: <20231127220902.1315692-1-irogers@google.com>
Message-Id: <20231127220902.1315692-18-irogers@google.com>
Mime-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v5 17/50] perf debug: Expose debug file
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
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
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
2.43.0.rc1.413.gea7ed67945-goog

