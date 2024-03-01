Return-Path: <linux-kernel+bounces-88024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0213886DC4F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADA8D28C2E9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1B269DEC;
	Fri,  1 Mar 2024 07:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ecohGLLs"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105FE69D28
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 07:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709279228; cv=none; b=TWGq+6TAaaWmsq042620ervSJooMRVT3VD4KrMnY+RgelO6OM/CDDA18BuLUlUz8aBQzsjBBNCjC8Kx6n1ijIHKiSLefT3LPPv2VBeHd1L0J/TspnshF8MCePsCw1c49nvpA9w0g4EdJAH7jlw5Cy9V+hw+mDXZe608GIORTf/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709279228; c=relaxed/simple;
	bh=wTr8XZF47y1mIM8sF/7w7Q/9jLsnFEsaFsOMi3gXkm0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=s8op6m67UZ8DUukZWgZVgZu1ARgPxeAkNtb71FLSr1WDanKTy8l7TlafX6zDsFyi/iM5GBS2bvy1kRr3igoA1sDvEm/DgyT44rYC4y4oVOdZEEOnGC5X96IpIVNggzBSTmq3yfWvz/l4hVdxbO9O/+84nUXqIUbExxIdrgvTyVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ecohGLLs; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc647f65573so3313819276.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709279226; x=1709884026; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5K+5oMd/UIqBC7bRKcwIBEqT27MHFEvvuXXTUo0sv5w=;
        b=ecohGLLs9wBizFLV4MPPvwm2TPxwM0HJkbZ/kTDh0+jFu59kzp+OvK/BC/FmJwUsdj
         +ePhYw9h7FYBN1+x0itIlkztuqoCRsL1XWjrQdk1JC4MI9ZmAmqpVuOlOR6JEuesc8vZ
         ptvNQXG42cwS8Hz2P39BNk7vvocLUs+I14mqwETrNVTHsuILlHfX4lBd9CZR1i4A6Etd
         RATx3HbL03Ef9YrH7Zc9T3+Ju0jO1YF+rEf8ukZ0tYU56GBAh2M3yrQ+wPW8bSx7eaKR
         GkTX31wwSch7OmQjdaN+OrUDcC6mYAZv8Gu1X/7cRQh+mlb/v6DnaD9GyHm5b/LLnH75
         Obcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709279226; x=1709884026;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5K+5oMd/UIqBC7bRKcwIBEqT27MHFEvvuXXTUo0sv5w=;
        b=Fm1g1MAv8fHE1Dye8V807v6M2tarf8IipZqyNGu49Ed1B72TWNMECz5oXuChPS6G5f
         X41ry0t5oMCvqDXkLJL5kjyavcbSnbKMQs9cewnd5bBChtgvMDI7X4PXHOmNCjZjvEhv
         lUzzgWu34HHIVFmIwKMEdhSoEaXkQpp055i+n+Ql+Nkz+gafEwAqvXun9RVt+D3b/pZQ
         VjSDee+JvQI1cCEUV2r2b3t73jRKvbcrFEgjH8JLGcbTgqX6SF7rUIt/xaBi4VhQ8tab
         L7gPP0f4TFcdqVCAGoC0HeCTqyiYs5OHEVppkMJfd8zFNaIDPSRP3ixVGFdN352s0pCw
         exSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpJxHReWxIk0rRiZ8iGXwWOqZWCwO4vf4E7X4QlxVXOo64KRT1whmh4gwkFmfnsKTMD0jfYoS7UavJvK2v/L8nFCo803OsL1nd1aga
X-Gm-Message-State: AOJu0YxFI9yWeh8QdbZwnJeqtKl2cjD0M38qHn1ERtSmQL/awqNHz7GA
	VlWDCbmtgRL4yZ71pQK1z2h8NsBWgBG53ogpz64LXcD8Y0nGMTCcA6xutaKUF+BKDGyqwNqL09g
	nAU5Ggg==
X-Google-Smtp-Source: AGHT+IHnnjJ/HkjdhIOLTn0brjPQIsb8rznG0WYtYw+2K/eNV8iOBDmIX+HMqsIRSi2MJeWZMo8AmSHlGGNN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a05:6902:1004:b0:dc7:48ce:d17f with SMTP
 id w4-20020a056902100400b00dc748ced17fmr181054ybt.10.1709279226074; Thu, 29
 Feb 2024 23:47:06 -0800 (PST)
Date: Thu, 29 Feb 2024 23:46:38 -0800
In-Reply-To: <20240301074639.2260708-1-irogers@google.com>
Message-Id: <20240301074639.2260708-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301074639.2260708-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 3/4] perf test: Use a single fd for the child process out/err
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Christian Brauner <brauner@kernel.org>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Disha Goel <disgoel@linux.ibm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Song Liu <songliubraving@fb.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Switch from dumping err then out, to a single file descriptor for both
of them. This allows the err and output to be correctly interleaved in
verbose output.

Fixes: b482f5f8e016 ("perf tests: Add option to run tests in parallel")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 37 ++++++---------------------------
 1 file changed, 6 insertions(+), 31 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index d13ee7683d9d..e05b370b1e2b 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -274,11 +274,8 @@ static int finish_test(struct child_test *child_test, int width)
 	struct test_suite *t = child_test->test;
 	int i = child_test->test_num;
 	int subi = child_test->subtest;
-	int out = child_test->process.out;
 	int err = child_test->process.err;
-	bool out_done = out <= 0;
 	bool err_done = err <= 0;
-	struct strbuf out_output = STRBUF_INIT;
 	struct strbuf err_output = STRBUF_INIT;
 	int ret;
 
@@ -290,11 +287,9 @@ static int finish_test(struct child_test *child_test, int width)
 		pr_info("%3d: %-*s:\n", i + 1, width, test_description(t, -1));
 
 	/*
-	 * Busy loop reading from the child's stdout and stderr that are set to
-	 * be non-blocking until EOF.
+	 * Busy loop reading from the child's stdout/stderr that are set to be
+	 * non-blocking until EOF.
 	 */
-	if (!out_done)
-		fcntl(out, F_SETFL, O_NONBLOCK);
 	if (!err_done)
 		fcntl(err, F_SETFL, O_NONBLOCK);
 	if (verbose > 1) {
@@ -303,11 +298,8 @@ static int finish_test(struct child_test *child_test, int width)
 		else
 			pr_info("%3d: %s:\n", i + 1, test_description(t, -1));
 	}
-	while (!out_done || !err_done) {
-		struct pollfd pfds[2] = {
-			{ .fd = out,
-			  .events = POLLIN | POLLERR | POLLHUP | POLLNVAL,
-			},
+	while (!err_done) {
+		struct pollfd pfds[1] = {
 			{ .fd = err,
 			  .events = POLLIN | POLLERR | POLLHUP | POLLNVAL,
 			},
@@ -317,21 +309,7 @@ static int finish_test(struct child_test *child_test, int width)
 
 		/* Poll to avoid excessive spinning, timeout set for 1000ms. */
 		poll(pfds, ARRAY_SIZE(pfds), /*timeout=*/1000);
-		if (!out_done && pfds[0].revents) {
-			errno = 0;
-			len = read(out, buf, sizeof(buf) - 1);
-
-			if (len <= 0) {
-				out_done = errno != EAGAIN;
-			} else {
-				buf[len] = '\0';
-				if (verbose > 1)
-					fprintf(stdout, "%s", buf);
-				else
-					strbuf_addstr(&out_output, buf);
-			}
-		}
-		if (!err_done && pfds[1].revents) {
+		if (!err_done && pfds[0].revents) {
 			errno = 0;
 			len = read(err, buf, sizeof(buf) - 1);
 
@@ -354,14 +332,10 @@ static int finish_test(struct child_test *child_test, int width)
 			pr_info("%3d.%1d: %s:\n", i + 1, subi + 1, test_description(t, subi));
 		else
 			pr_info("%3d: %s:\n", i + 1, test_description(t, -1));
-		fprintf(stdout, "%s", out_output.buf);
 		fprintf(stderr, "%s", err_output.buf);
 	}
-	strbuf_release(&out_output);
 	strbuf_release(&err_output);
 	print_test_result(t, i, subi, ret, width);
-	if (out > 0)
-		close(out);
 	if (err > 0)
 		close(err);
 	return 0;
@@ -394,6 +368,7 @@ static int start_test(struct test_suite *test, int i, int subi, struct child_tes
 		(*child)->process.no_stdout = 1;
 		(*child)->process.no_stderr = 1;
 	} else {
+		(*child)->process.stdout_to_stderr = 1;
 		(*child)->process.out = -1;
 		(*child)->process.err = -1;
 	}
-- 
2.44.0.278.ge034bb2e1d-goog


