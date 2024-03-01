Return-Path: <linux-kernel+bounces-88864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EAE86E7B4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77742286E5C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E920F39AE8;
	Fri,  1 Mar 2024 17:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x3FWfZBX"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D4939FEB
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 17:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709315280; cv=none; b=guzvElkqeEZO0ylAcym/QgrGzcVZFuU0RZokCxkwPZrFBBiCD9HqxDVrQxPITjcv8XGI70V1IkYJbRTdrqtxCnxMM9XwMGn7RrWIFCBFxIiq689ykU/FhJgCMBlegThngvG1w6OudrcWyclhRDg/xCS2GRR2/1UvfP79JnHk0y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709315280; c=relaxed/simple;
	bh=Vq9zT+y6gZ9b4h7EmmS4QVHvVta5/MOikqgIaakqi+g=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=gW6Dljtava/Ciil408xey/ZQaCHrI7Eg5g5kdomtz7rela50P75BBh7Z9sJ8MFkoZBf1Vlcru8JRTaL2nV3Ln9UNUlJLIJWetMIPD1fkbZcvtVrpUE+jEabVrQtASVbSHpfGtrKoIbk5ch/xBc3nxXD9FSv7yBgVOlKAFWdiV6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x3FWfZBX; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60966f363c1so34185147b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 09:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709315277; x=1709920077; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U18PnMNDf0UkaDQ9M9UQ3swVgmnuLROuEHdrzUL6kPk=;
        b=x3FWfZBX14rOAQf4pGkaNjtg6HtLrybEcRlsLchlBuU3S76W96VkAlKh0EYCo8yxuS
         +EBm5r5CUFm5cLZdkJh7H5XmrPbsUm14aMYtl2hnh2Yfd3ErEgrxhWszZ9XJEnhdsOpE
         NSQR4hIGq51Dnz0kw3dctr5Tjfm52eAaPh++M8RtsouBsfTlLH+23+UIfqtRQDEVIaIb
         G6UIC4o0cpM/icAwlmLG8w2m4/xBjnbpbLATEZEuRBkK6n4LWl5bPElOMHmuHlY2FqFs
         aYKeJ4IwgxUAzqCCPXLgozBwcyExY2h2HMppapweADC3ZpD9GCNPIwuF7fqq0EEPRqfg
         D6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709315277; x=1709920077;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U18PnMNDf0UkaDQ9M9UQ3swVgmnuLROuEHdrzUL6kPk=;
        b=oiJQiR1M83Nxi5bUjtYkP4Fm13pCPkCYXgMRY0NklMA5HHgbYGQ1Bf2MUDH/fp13Bj
         qOa8c11aAqdDb/A1lKQ+KZrvxmPjnYKwCvvnvqz4e3TA0z2zhx5wN5s0kW06PJ0KYpWn
         OOdIFfIctGlb+3838Nb+9HLvH6eaX8Z9BSLfFJQUsPsDnTvbn79r8T7Ctp0Vj+rLa2dG
         2y0+VFsI3tfYyeu4N/8eUsl+/yJzyLytszdDFWzRgypmgogrbd93eRlBQSQGVQNKXqzw
         vk81nG/fVuV9ZhwiVrowD9sDdC7Uw/6/1uwuyJdqYoouhcr1go5nmn4f2qKSgQUSZ55Q
         Rrjg==
X-Forwarded-Encrypted: i=1; AJvYcCW90NEecrTmkXBqPHJKQT0qC4PYa0tmBX7vcECMUbK1ejJy3ixhBaEBtPa2HhD3ANdLiW/hD9CJwazLFjIrfu0eRgDSMCzmeV4IGmof
X-Gm-Message-State: AOJu0YzBkHIHCam2X1YqgvuMVSipgzQEey5IneRroosnh/7YLnlSlCHs
	HZSDInTaJPuVQ6YWV7RZ2Bw1hEETwy/BlhTx/+yNykIu/MFXuFpYkMXLwJgcsjf49VyCGpJPEzr
	yw37QHw==
X-Google-Smtp-Source: AGHT+IHkPZ/lSgcbKn3LOFPALPDm9hx/ZwX+m9eVD+LNZCkHv9byjCXPezI+bD7tBghw8c5JmhLGtWB/wfGb
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a05:690c:fce:b0:608:c5b5:3d37 with SMTP id
 dg14-20020a05690c0fce00b00608c5b53d37mr565342ywb.2.1709315277703; Fri, 01 Mar
 2024 09:47:57 -0800 (PST)
Date: Fri,  1 Mar 2024 09:47:11 -0800
Message-Id: <20240301174711.2646944-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1] perf tests: Run tests in parallel by default
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Switch from running tests sequentially to running in parallel by
default. Change the opt-in '-p' or '--parallel' flag to '-S' or
'--sequential'.

On an 8 core tigerlake an address sanitizer run time changes from:
326.54user 622.73system 6:59.91elapsed 226%CPU
to:
973.02user 583.98system 3:01.17elapsed 859%CPU

So over twice as fast, saving 4 minutes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
This change is on top of the test fixes in:
https://lore.kernel.org/lkml/20240301074639.2260708-1-irogers@google.com/
---
 tools/perf/tests/builtin-test.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index ddb2f4e38ea5..73f53b02f733 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -39,8 +39,8 @@
  * making them easier to debug.
  */
 static bool dont_fork;
-/* Fork the tests in parallel and then wait for their completion. */
-static bool parallel;
+/* Don't fork the tests in parallel and wait for their completion. */
+static bool sequential;
 const char *dso_to_test;
 const char *test_objdump_path = "objdump";
 
@@ -374,7 +374,7 @@ static int start_test(struct test_suite *test, int i, int subi, struct child_tes
 	}
 	(*child)->process.no_exec_cmd = run_test_child;
 	err = start_command(&(*child)->process);
-	if (err || parallel)
+	if (err || !sequential)
 		return  err;
 	return finish_test(*child, width);
 }
@@ -440,7 +440,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 			int err = start_test(t, curr, -1, &child_tests[child_test_num++], width);
 
 			if (err) {
-				/* TODO: if parallel waitpid the already forked children. */
+				/* TODO: if !sequential waitpid the already forked children. */
 				free(child_tests);
 				return err;
 			}
@@ -460,7 +460,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 		}
 	}
 	for (i = 0; i < child_test_num; i++) {
-		if (parallel) {
+		if (!sequential) {
 			int ret  = finish_test(child_tests[i], width);
 
 			if (ret)
@@ -536,8 +536,8 @@ int cmd_test(int argc, const char **argv)
 		    "be more verbose (show symbol address, etc)"),
 	OPT_BOOLEAN('F', "dont-fork", &dont_fork,
 		    "Do not fork for testcase"),
-	OPT_BOOLEAN('p', "parallel", &parallel,
-		    "Run the tests altogether in parallel"),
+	OPT_BOOLEAN('S', "sequential", &sequential,
+		    "Run the tests one after another rather than in parallel"),
 	OPT_STRING('w', "workload", &workload, "work", "workload to run for testing"),
 	OPT_STRING(0, "dso", &dso_to_test, "dso", "dso to test"),
 	OPT_STRING(0, "objdump", &test_objdump_path, "path",
@@ -564,6 +564,9 @@ int cmd_test(int argc, const char **argv)
 	if (workload)
 		return run_workload(workload, argc, argv);
 
+	if (dont_fork)
+		sequential = true;
+
 	symbol_conf.priv_size = sizeof(int);
 	symbol_conf.try_vmlinux_path = true;
 
-- 
2.44.0.278.ge034bb2e1d-goog


