Return-Path: <linux-kernel+bounces-64741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5E9854228
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 05:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2AEB1C27059
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 04:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765B8125D8;
	Wed, 14 Feb 2024 04:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OKiYzusp"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4184D11CBD
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 04:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707886485; cv=none; b=AyArDKpLXY7ek2csYA9qof/cRxKJeHMiu3tdk4WIkBFgpuX86BbsFQYELg/ZWRo3Pz8njKuauK+hIvnF8xqzR8tpVXDyOgF7bGBRO52cejPpRnTsd4rh4023UDnSHqRCjqBzN5VRD5zybhBSmP89dMajWtkaiocHjyAk03bFlbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707886485; c=relaxed/simple;
	bh=d/hQVr7HLwaHgpbOrtRFt5ktwlU8Fbwq9EyeSqxfkuQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ZkTNWAW9RrFdFeGKjgAgUjBcJGZah56EPedNLNbUtWXGPbfyxR2uVLmL/1c+LiRhR9XPXQkModbmEYV1n7E03cfllYzLzC/qpT26SdGRsla3lhLn4gyDVzvIpmbonyELMSkMt4RlmY2U1qBlOAj9/nzj8DNB8N1pLHbM4QU/r24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OKiYzusp; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc74ac7d015so7382819276.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 20:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707886483; x=1708491283; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ORLaSbqJ7XxCjGmPCGfASaJCafSHFkQjULJrCBkVFqo=;
        b=OKiYzusp+vQXupBh2m/3KN//hxorBgcscjkzKzQJ5bkmyNZygNryMDqGsJ+i+ju/dd
         wsC71guPBN0S2TyPcpDxqKq8Dq6636tWxTWk+69/yQZ9svs2ey0W9vy+TmVMxLwrIRZ0
         7XE19/ZT1sTF3REKfppx1B17JU5nad5o0g/JlvrUiR/j51h4CsW+a76JCIOlSFeTkVSL
         0D+GdEqq6DwIej/+pxcAgBx4PVmMpjU/AXJuJsjR6hbUVzmzY8z51NGji9G8zbEF5DbJ
         BjlNpH3HdDa0l1rBzkIVauvQqcGwxcj5dUHJbtlT4uSGRR8g/G+/wxyu6xqouJPP3SHV
         Cggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707886483; x=1708491283;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ORLaSbqJ7XxCjGmPCGfASaJCafSHFkQjULJrCBkVFqo=;
        b=ewOqDfIuQa/LEuD1sfR/j5dKxoKCGPpb28n9/rRPZ7luZqWra//dAxPjoL0MRyelzP
         koIq6mhkeJoKRKakQKFDDU5VVp2S0sAmWJMOUr61R/Pn4got/p+1CFF8goDHbh0MKUE2
         NSt6300PUMXlFMXvbfaDFEmZi4vZbIDdphBXTaq2sgo4KYJ1rVoXVVAQ6lDxVZAIIrtx
         FLxb+lqy3sLejf1pf4aVgj+SMd5YhgHPf3FfkwzSWg90bA3yGdyO9G5Q4rMyUppNgsVf
         HUabWbyN4+v9NpRPo5or+vHm9NKp5tgElkdOVF8PcnPxXP3+M1d8EtQeg42yOUIBjYq3
         ckGw==
X-Forwarded-Encrypted: i=1; AJvYcCVlJRQ2yYlOl16YEvYE4y6bQ7JHW87975fXKoN+szNcSmtmbgvAz7Q+JwKgysEHkGZ1mdbRCopopub1tXTRUlXLIMegOV6KONKjunt2
X-Gm-Message-State: AOJu0Yw0QBRAX3MvK2+KqykQRGjiua1Dn3lXbvDOI3BKw7XvGVcZjmwq
	rOorzcyxk/SYTglABbN9gye3pT4/PsiJrGjKWyQcBeZ3VyFE1++sv7ltuH0CWIcwEnZB4MmAtf3
	DYDk2kg==
X-Google-Smtp-Source: AGHT+IHtwgvbCf4Maez+fUH4FaS0TqvACXGv8O6/zRPo17W4j+pBYYEsBChdTYkPGjc1iiVxLuFBwvet1Wli
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6d92:85eb:9adc:66dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:82:b0:dc7:9218:df3b with SMTP id
 h2-20020a056902008200b00dc79218df3bmr61457ybs.10.1707886483182; Tue, 13 Feb
 2024 20:54:43 -0800 (PST)
Date: Tue, 13 Feb 2024 20:53:53 -0800
In-Reply-To: <20240214045356.748330-1-irogers@google.com>
Message-Id: <20240214045356.748330-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214045356.748330-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v4 5/8] perf test: Rename builtin-test-list and add missed
 header guard
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	James Clark <james.clark@arm.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

builtin-test-list is primarily concerned with shell script
tests. Rename the file to better reflect this and add a missed header
guard.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/Build                                    | 2 +-
 tools/perf/tests/builtin-test.c                           | 2 +-
 tools/perf/tests/{builtin-test-list.c => tests-scripts.c} | 2 +-
 tools/perf/tests/{builtin-test-list.h => tests-scripts.h} | 4 ++++
 4 files changed, 7 insertions(+), 3 deletions(-)
 rename tools/perf/tests/{builtin-test-list.c => tests-scripts.c} (99%)
 rename tools/perf/tests/{builtin-test-list.h => tests-scripts.h} (79%)

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 53ba9c3e20e0..c7f9d9676095 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 perf-y += builtin-test.o
-perf-y += builtin-test-list.o
+perf-y += tests-scripts.o
 perf-y += parse-events.o
 perf-y += dso-data.o
 perf-y += attr.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 4a5973f9bb9b..eff3c62e9b47 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -29,7 +29,7 @@
 #include <subcmd/exec-cmd.h>
 #include <linux/zalloc.h>
 
-#include "builtin-test-list.h"
+#include "tests-scripts.h"
 
 static bool dont_fork;
 const char *dso_to_test;
diff --git a/tools/perf/tests/builtin-test-list.c b/tools/perf/tests/tests-scripts.c
similarity index 99%
rename from tools/perf/tests/builtin-test-list.c
rename to tools/perf/tests/tests-scripts.c
index a65b9e547d82..4ebd841da05b 100644
--- a/tools/perf/tests/builtin-test-list.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -15,7 +15,7 @@
 #include <sys/wait.h>
 #include <sys/stat.h>
 #include "builtin.h"
-#include "builtin-test-list.h"
+#include "tests-scripts.h"
 #include "color.h"
 #include "debug.h"
 #include "hist.h"
diff --git a/tools/perf/tests/builtin-test-list.h b/tools/perf/tests/tests-scripts.h
similarity index 79%
rename from tools/perf/tests/builtin-test-list.h
rename to tools/perf/tests/tests-scripts.h
index eb81f3aa6683..3a3ec6191848 100644
--- a/tools/perf/tests/builtin-test-list.h
+++ b/tools/perf/tests/tests-scripts.h
@@ -1,4 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef TESTS_SCRIPTS_H
+#define TESTS_SCRIPTS_H
 
 struct script_file {
 	char *dir;
@@ -10,3 +12,5 @@ struct script_file {
 const struct script_file *list_script_files(void);
 /* Get maximum width of description string */
 int list_script_max_width(void);
+
+#endif /* TESTS_SCRIPTS_H */
-- 
2.43.0.687.g38aa6559b0-goog


