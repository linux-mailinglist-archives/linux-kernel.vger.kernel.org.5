Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC890807FEF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 06:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjLGFEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 00:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjLGFEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 00:04:42 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553DDD44
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 21:04:48 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db53919e062so751910276.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 21:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701925487; x=1702530287; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gJ09ILS0FKw69nllEGHZTddJyQyifMD6obVQZgpi4Qw=;
        b=ljFipjXPu2ocEJjGS5+bo4ZvUR5mU9WkFW6EY0cXddnbdqCN7uxP4VpZYVQaSh+bN2
         CZUTGz6UU5H0lp1cXq91jVlmEXpsne41KYWUCiZDhNp2Mr8XyAxdrUqY8R1lMeOAe6ae
         O+XT+QLgm5NShAQcqAdRq8fhTOrhiDufhvsM7lIfHKdZQ09xG6APHhuyotWzh2SkGZDs
         tonIxluC68vbr8xowwfdA3vDmRmPp9/K/ZOZcFGI6QZnFoqirJdEQQYHb7HEZZxvnT5w
         GIP2XIRqHKCSLDzZDX/8XYAt9pIF+8bLljLI/UmMB0YDm0NZaBbB2tWrtLXzQH9+G475
         vhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701925487; x=1702530287;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gJ09ILS0FKw69nllEGHZTddJyQyifMD6obVQZgpi4Qw=;
        b=KaTFQYLnmngPKuT38q+pCyw4HdE3f3VjyPlIoM0Ya+WZPekSZdQ3m6uZjBrQGLzfP8
         PlIqmPEXgoEgIjG+ER4+o1EItpseZXBnxyaNRZr57xoBuFxng6CtENGqZfd9V5R4QGWV
         vWYWIjuB8SPy0lKlAKX8YM1UoO7Fa+tpr66CFjr3YQYoYZRv9t383NsNvyCrN7Tp5qLJ
         0iPb3EBFm3nKRBt/boq0ouEzrm/9BpjypZRX8s0eGc9LMP7Q+sD/K3f6j0dRTSiVBEe3
         MOG1yEOtdZtH5isG35HQ2uAS6TJ7KxK7jNTuJJbwUG/1TudQwg0QNVR8hHHTgTJDxCdB
         RRuw==
X-Gm-Message-State: AOJu0YwmHGQd5ihdyoBN/JFhHk77dZhvdjU1om1xnttmH1o3oY4qssmV
        IIC7z7TB5aqvBTZe/MdioB1XRfn5hRFW
X-Google-Smtp-Source: AGHT+IE25ICHr+L0rrthsfiMJT9vor7826Id8YRj/BihCnqEuwJ+wuOTJjyX1ATd/qisp8dd7xqJkTPlrH7E
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a25:d144:0:b0:db7:dce9:76cd with SMTP id
 i65-20020a25d144000000b00db7dce976cdmr24086ybg.9.1701925487528; Wed, 06 Dec
 2023 21:04:47 -0800 (PST)
Date:   Wed,  6 Dec 2023 21:04:28 -0800
In-Reply-To: <20231207050433.1426834-1-irogers@google.com>
Message-Id: <20231207050433.1426834-2-irogers@google.com>
Mime-Version: 1.0
References: <20231207050433.1426834-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v1 1/6] tools build: Add a feature test for getdents64
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
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Fangrui Song <maskray@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Artem Savkov <asavkov@redhat.com>,
        James Clark <james.clark@arm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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

getdents64 may be missing from certain libcs, add a feature test to
determine when such a libc is being used.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.feature          |  1 +
 tools/build/feature/Makefile          |  4 ++++
 tools/build/feature/test-all.c        |  5 +++++
 tools/build/feature/test-getdents64.c | 12 ++++++++++++
 4 files changed, 22 insertions(+)
 create mode 100644 tools/build/feature/test-getdents64.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 64df118376df..f051d4d8c71c 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -58,6 +58,7 @@ FEATURE_TESTS_BASIC :=                  \
         pthread-attr-setaffinity-np     \
         pthread-barrier     		\
         reallocarray                    \
+        getdents64                      \
         stackprotector-all              \
         timerfd                         \
         libdw-dwarf-unwind              \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 37722e509eb9..5efe89c3b0a6 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -21,6 +21,7 @@ FILES=                                          \
          test-disassembler-four-args.bin        \
          test-disassembler-init-styled.bin	\
          test-reallocarray.bin			\
+         test-getdents64.bin			\
          test-libbfd-liberty.bin                \
          test-libbfd-liberty-z.bin              \
          test-cplus-demangle.bin                \
@@ -262,6 +263,9 @@ $(OUTPUT)test-disassembler-init-styled.bin:
 $(OUTPUT)test-reallocarray.bin:
 	$(BUILD)
 
+$(OUTPUT)test-getdents64.bin:
+	$(BUILD)
+
 $(OUTPUT)test-libbfd-liberty.bin:
 	$(CC) $(CFLAGS) -Wall -Werror -o $@ test-libbfd.c -DPACKAGE='"perf"' $(LDFLAGS) -lbfd -ldl -liberty
 
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 6f4bf386a3b5..c65096f75032 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -166,6 +166,10 @@
 # include "test-reallocarray.c"
 #undef main
 
+#define main main_test_getdents64
+# include "test-getdents64.c"
+#undef main
+
 #define main main_test_disassembler_four_args
 # include "test-disassembler-four-args.c"
 #undef main
@@ -216,6 +220,7 @@ int main(int argc, char *argv[])
 	main_test_setns();
 	main_test_libaio();
 	main_test_reallocarray();
+	main_test_getdents64();
 	main_test_disassembler_four_args();
 	main_test_libzstd();
 
diff --git a/tools/build/feature/test-getdents64.c b/tools/build/feature/test-getdents64.c
new file mode 100644
index 000000000000..f7c9df1e2f05
--- /dev/null
+++ b/tools/build/feature/test-getdents64.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stddef.h>
+#define _GNU_SOURCE
+#include <dirent.h>
+
+int main(void)
+{
+	char buf[128];
+	return (int)getdents64(0, buf, sizeof(buf));
+}
+
+#undef _GNU_SOURCE
-- 
2.43.0.rc2.451.g8631bc7472-goog

