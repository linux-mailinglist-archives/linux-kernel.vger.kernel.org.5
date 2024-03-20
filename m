Return-Path: <linux-kernel+bounces-109163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F231881596
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9299B234EE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B1654FB7;
	Wed, 20 Mar 2024 16:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pGHVAS6p"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E360753E13
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710951986; cv=none; b=gl1VaaltbPN3v5o5qmUq0eA652EmqB2p0mw1YE6TEg9+pHUY9fPBca5kYSQOO/Rnw0TdQkFmpvGnE+0Zz12EqK04VM4Puny+Bi2w8huB5qq0WAL7mYv2VwxjlNtXrXylpeSeEHZloaMRaqqVAYF0Ic15tMoYzCx7/VKCn6E+sLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710951986; c=relaxed/simple;
	bh=+wS+o2Y9kpcSMjVdaZN1AtZmfdNjBWtj59lkeN10uQw=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=kTEelFoL8eDDRFjwsycvd5CFXU4L++3TKPnParTxkZ0NS+q2fsgZDF5QCFF9TRA30gPK/mr9CeSEJAetIYkCyyLurQGR5/L0qZ+LIgYFXAEBbd1P9qKJFRnExUcNJfz0nAPTUOXBwGmlBQBT2TdNo6jTW/fa+AUGLI/pa8eQk08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pGHVAS6p; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608ad239f8fso112595007b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 09:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710951984; x=1711556784; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TpjaWbEXXGPMCnUDGYsVsjoUeJRl4xtMeKFE5VoNlZo=;
        b=pGHVAS6pTj/GG8GLc2T05+PhBj7mQOxIPsjpA7xWBGfp0aT3BOproP81zxg+WR6HM5
         HT8UuypHi1lSnSiEbtpFL98WyDAqaJeTw4agWgkOz01lGBgp1AGtBFVw9wEvwBLp1ZQv
         Rd5L+nCU3NIVbr5/yznCmj12/xt3xbwyQnwfQD0op1A6s3JHyWkE6+uCTFdBn9o7ItTA
         UdrH2QwfmOCyka0WZdZd8upldt7kKOXMCoL+wJ8PEg5u3Zc/k63M+RlPdIsIkQQhBUn6
         H/yC29hg4FumA00Cgq8lFmxB9TFK8s6qelwzWjoPvwU5/C6RHVOFVt3icq5a1sOAJtZ5
         MEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710951984; x=1711556784;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TpjaWbEXXGPMCnUDGYsVsjoUeJRl4xtMeKFE5VoNlZo=;
        b=vn7zArjbTkiKgFoy2+QeXBTJayhSjQ5icxaIxkzCJCINb/szsmGcj8Aiv8uGx/HQVC
         gadafavCUWUqQHagTfXEWnMH12M2JOEiHQu0kY8ZXloG5Vq8i0iBZ/k9IKBDExyod0Iv
         ONTyUULEVCHXMalW6n28QbVsBMPd4AGUakGFqmMT24lyJ+rZFf0kIWNiRBj5efc4KlDU
         qoyhiJQ4X1yO/v4kxkSlNioYeblgAW3ouHpD+UMDNA/4X6zIDJvdTkCJjmdv7q/sbxA5
         i4x2/vZy7c3cVRVYy2r4xV0U2qxu7un1NroaQa6FzBuxlmtAd93gqBhG8hETv+kOtNTf
         enlw==
X-Forwarded-Encrypted: i=1; AJvYcCX0MzCzIJdlt5azTiAfco6HCjosdcDIdE37h92Th0t+AVzbWWNY+1rW7QYsR2Tz+tW8q2QUbjnVeS2jaQuwJsLjtlDLBPBOQEwDX46C
X-Gm-Message-State: AOJu0Yw5pstdWEfaz1b7MVE/o2DmQ033Dmrgqs61xyoXDnAPFox16kNz
	FGi2qJXSXziyd6cm5f8bJeKGbfNNHrNyseTcVqMlDzCN+RaApi1NkR/WnJMErmPg7sO9L2kG7qt
	u9B0LqA==
X-Google-Smtp-Source: AGHT+IFBdqKy9AaBHuJA8oBTGDInO4OP/MmxEhOVgHKwTdC2CpWRoL4O+5eBVeSVUkPiIfGDiAQcgSVTTT+A
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f4f0:8ad8:3c73:cef7])
 (user=irogers job=sendgmr) by 2002:a81:6d52:0:b0:610:f287:93b5 with SMTP id
 i79-20020a816d52000000b00610f28793b5mr681040ywc.7.1710951984025; Wed, 20 Mar
 2024 09:26:24 -0700 (PDT)
Date: Wed, 20 Mar 2024 09:26:19 -0700
Message-Id: <20240320162619.1272015-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Subject: [PATCH v1] perf intel-pt: Fix memory sanitizer use-of-uninitialized-value
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Running the test "Miscellaneous Intel PT testing" with a build with
-fsanitize=memory and -fsanitize-memory-track-origins I saw:

```
==1257749==WARNING: MemorySanitizer: use-of-uninitialized-value
    #0 0x5581c00a76b3 in intel_pt_sample_flags tools/perf/util/intel-pt.c:1527:17
    #1 0x5581c00c5cf6 in intel_pt_run_decoder tools/perf/util/intel-pt.c:2961:3
    #2 0x5581c00968f8 in intel_pt_process_timeless_queues tools/perf/util/intel-pt.c:3074:4
    #3 0x5581c007cf49 in intel_pt_process_event tools/perf/util/intel-pt.c:3482:10
    #4 0x5581bffa269a in auxtrace__process_event tools/perf/util/auxtrace.c:2830:9
    #5 0x5581bfb826c0 in perf_session__deliver_event tools/perf/util/session.c:1649:8
    #6 0x5581bfba1d7f in perf_session__process_event tools/perf/util/session.c:1891:9
    #7 0x5581bfba82e4 in process_simple tools/perf/util/session.c:2452:9
    #8 0x5581bfbabcc3 in reader__read_event tools/perf/util/session.c:2381:14
    #9 0x5581bfbad942 in reader__process_events tools/perf/util/session.c:2430:8
    #10 0x5581bfb78256 in __perf_session__process_events tools/perf/util/session.c:2477:8
    #11 0x5581bfb702c4 in perf_session__process_events tools/perf/util/session.c:2643:9
    #12 0x5581bf2da266 in __cmd_script tools/perf/builtin-script.c:2855:8
    #13 0x5581bf2bfcdd in cmd_script tools/perf/builtin-script.c:4402:8
    #14 0x5581bf67004b in run_builtin tools/perf/perf.c:350:11
    #15 0x5581bf66b8ea in handle_internal_command tools/perf/perf.c:403:8
    #16 0x5581bf66f527 in run_argv tools/perf/perf.c:447:2
    #17 0x5581bf669d2d in main tools/perf/perf.c:561:3

  Uninitialized value was stored to memory at
    #0 0x5581c005ddf8 in intel_pt_walk_insn tools/perf/util/intel-pt-decoder/intel-pt-decoder.c:1256:25
    #1 0x5581c001a932 in intel_pt_walk_fup tools/perf/util/intel-pt-decoder/intel-pt-decoder.c:1428:9
    #2 0x5581c000f76c in intel_pt_walk_trace tools/perf/util/intel-pt-decoder/intel-pt-decoder.c:3299:10
    #3 0x5581c000899b in intel_pt_decode tools/perf/util/intel-pt-decoder/intel-pt-decoder.c:3988:10
    #4 0x5581c00c5180 in intel_pt_run_decoder tools/perf/util/intel-pt.c:2941:11
    #5 0x5581c00968f8 in intel_pt_process_timeless_queues tools/perf/util/intel-pt.c:3074:4
    #6 0x5581c007cf49 in intel_pt_process_event tools/perf/util/intel-pt.c:3482:10
    #7 0x5581bffa269a in auxtrace__process_event tools/perf/util/auxtrace.c:2830:9
    #8 0x5581bfb826c0 in perf_session__deliver_event tools/perf/util/session.c:1649:8
    #9 0x5581bfba1d7f in perf_session__process_event tools/perf/util/session.c:1891:9
    #10 0x5581bfba82e4 in process_simple tools/perf/util/session.c:2452:9
    #11 0x5581bfbabcc3 in reader__read_event tools/perf/util/session.c:2381:14
    #12 0x5581bfbad942 in reader__process_events tools/perf/util/session.c:2430:8
    #13 0x5581bfb78256 in __perf_session__process_events tools/perf/util/session.c:2477:8
    #14 0x5581bfb702c4 in perf_session__process_events tools/perf/util/session.c:2643:9
    #15 0x5581bf2da266 in __cmd_script tools/perf/builtin-script.c:2855:8
    #16 0x5581bf2bfcdd in cmd_script tools/perf/builtin-script.c:4402:8
    #17 0x5581bf67004b in run_builtin tools/perf/perf.c:350:11
    #18 0x5581bf66b8ea in handle_internal_command tools/perf/perf.c:403:8
    #19 0x5581bf66f527 in run_argv tools/perf/perf.c:447:2
```

Adding a curly brace initializer for the intel_pt_insn in
intel_pt_walk_fup rectifies this, however, there may be other issues
lurking behind this so initialize all similar instances.

Fixes: f4aa081949e7 ("perf tools: Add Intel PT decoder")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index b450178e3420..b4a95af2e4cc 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1115,7 +1115,7 @@ static void intel_pt_sample_insn(struct intel_pt_decoder *decoder)
  */
 static void intel_pt_sample_fup_insn(struct intel_pt_decoder *decoder)
 {
-	struct intel_pt_insn intel_pt_insn;
+	struct intel_pt_insn intel_pt_insn = {};
 	uint64_t max_insn_cnt, insn_cnt = 0;
 	int err;
 
@@ -1418,7 +1418,7 @@ static inline bool intel_pt_fup_with_nlip(struct intel_pt_decoder *decoder,
 
 static int intel_pt_walk_fup(struct intel_pt_decoder *decoder)
 {
-	struct intel_pt_insn intel_pt_insn;
+	struct intel_pt_insn intel_pt_insn = {};
 	uint64_t ip;
 	int err;
 
@@ -1461,7 +1461,7 @@ static int intel_pt_walk_fup(struct intel_pt_decoder *decoder)
 
 static int intel_pt_walk_tip(struct intel_pt_decoder *decoder)
 {
-	struct intel_pt_insn intel_pt_insn;
+	struct intel_pt_insn intel_pt_insn = {};
 	int err;
 
 	err = intel_pt_walk_insn(decoder, &intel_pt_insn, 0);
@@ -1626,7 +1626,7 @@ static int intel_pt_emulated_ptwrite(struct intel_pt_decoder *decoder)
 
 static int intel_pt_walk_tnt(struct intel_pt_decoder *decoder)
 {
-	struct intel_pt_insn intel_pt_insn;
+	struct intel_pt_insn intel_pt_insn = {};
 	int err;
 
 	while (1) {
-- 
2.44.0.291.gc1ea87d7ee-goog


