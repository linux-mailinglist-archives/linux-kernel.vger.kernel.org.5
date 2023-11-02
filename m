Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2C77DF962
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345012AbjKBR75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 13:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345505AbjKBR7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:59:07 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332E41728
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 10:58:43 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5afa071d100so25594797b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 10:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947922; x=1699552722; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vTgDtxbYigIx0l7l8yxmVGmQ3YjDCKbQz5YbC6NLkeU=;
        b=x8QRJv9OoUqot16R90umaoBpzuvKCn2FkD3cARBsCcLiL1WeGukknK12Ee9ILa+1qa
         fD2gOwXocsngaNt8Ar77m4vKAHuqY+kkRVrzeK/pR7liiZtSPSTxzHHFCQnYs0/rnzOf
         NMGiYXcyymKbs2WjCWrudMoPGweT1XvyO2y67VOrhqxRXRSBbNHdS/mLMHHGc9O++8jp
         VN5rinyLWaGUE1zoVNAmdFs4D17iNKnfQkm+cly+5hwVHZPPWYCkt4y+MknRFIixVJkN
         AV8Eo4+msRQ58dSJLKSwnkp/Xf9QxJdygn+UDhWzWmwLm1zGdaEGPXF89XPYdpX/vKnT
         jIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947922; x=1699552722;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vTgDtxbYigIx0l7l8yxmVGmQ3YjDCKbQz5YbC6NLkeU=;
        b=L9BlyKDskQMGd/23IjvIVtQEKgNSH4/ReIj8hDLUco01vJoC3amWqwNh2SfHpY9Adb
         yrvVUoPxzxBEE3Lj7sk9MXfIeWwHl/gvoLV5iaWQKN7cshFRH4s1kjxXSgMiObwVZnc4
         uLuRKdgyfNirVCnoFmOIOaNpigdIu5vbLI6/r57zb+dgBdHpKYCZpFaf/FTXi/HIxkSW
         aUOsI1+6G9ZBx19W7sfVu3ixDUpaaWMjnkUwau1DqgTzMCbD7KPu1hY03gIdsnnqcjRB
         LdNwc7BPPItL2JFZFB1CUaxfD4Q3ZWHNT07cdPZPVxT0kC6ftHKk1A6gc13Q0aNTkyjp
         277A==
X-Gm-Message-State: AOJu0Yw3GUV5sMdc4CMoDn6NCFagDzJcj1kIpmCeoZ+V/q5+9uXEp68P
        VgTbgHa1bI3uRJ/Kx1bASe/zWpWDOk1x
X-Google-Smtp-Source: AGHT+IElJYoxV4wiPSAEf9B3GKCjoUIPtcTIo8URJvmYO/lCw9YBmhTHfLckfv7GBhay1M9QvJtxREB9l9fc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a81:4f12:0:b0:59b:ebe0:9fcd with SMTP id
 d18-20020a814f12000000b0059bebe09fcdmr7405ywb.7.1698947922233; Thu, 02 Nov
 2023 10:58:42 -0700 (PDT)
Date:   Thu,  2 Nov 2023 10:57:02 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-21-irogers@google.com>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 20/53] perf debug: Expose debug file
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
2.42.0.869.gea05f2083d-goog

