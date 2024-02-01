Return-Path: <linux-kernel+bounces-47417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC99844DB2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECB5A1C25AE2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2650523D;
	Thu,  1 Feb 2024 00:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wFATrE1E"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C163C2C
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 00:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706746533; cv=none; b=MEXwGkwTms9LpexS054QEwVKyY0S5LsFGgcmrMkwgiWlNxBdbe/cIErSGFwePNHw19L1AerVX+HZ4uSOdkPbNUdILBk3DEto6PNT12vNl5wxqzVLui0JU7fLHG4jPvK1+uPhVUihkwByeI7vZbih91aNYRIK9A6q8YEMOUV1Y+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706746533; c=relaxed/simple;
	bh=/UHPRm7mz7k1D9UD2yWSxqPsNm91brhJvaJyQa92m4A=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=RhWaK25SN3DAMtcHAaUM0rY1rW+nCwRxfVNBcNOmmfli9FJV+hzvswu/DaeofFegXtHGlrHahAnMCdRjTvuVTZwP3PHcj+B9/X0uVC1i8aCUQ4xvznEI5QaftTY4UR9br0o4LdTVimZstMkPMcWJ4NZX7uTpIDoeVffSyNADhpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wFATrE1E; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-603c0e020a6so5510857b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 16:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706746530; x=1707351330; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SPL0gfUU+cYNOZ1QSf8+FwFjGRGXN1yT4zzxi+30UPg=;
        b=wFATrE1ErF1NIudqU8oHz+aUz+njs+yfhVyv12p9oksyIEYdwzQcdvFr07xtO6ZbPU
         v71aikpiD6TGYFN4KOmiRZ7cBZyd6564NgYo4x+Za+0KDfIK6aZlssFqoK6u+Cgbi/Q2
         AofAkK/G2ZZmAKLNCSC5b1mD4g2Zx/4il1/ioXN67HdJFVZSrl0/Iw89tGYl9CmmV8lz
         GsXhZxxzUQORvqgFEMDMRHuQQ9xA9OaqRe3p0+ScfT20XeCBR3ZNC2K4SizWRx0ZcBwv
         wfKSmfv1RUG44fSzDFyqfsJxUco7GfyLitwX13TRPhuUNXFWLXDvnQfe9F6Uj0Au0yA3
         F3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706746530; x=1707351330;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SPL0gfUU+cYNOZ1QSf8+FwFjGRGXN1yT4zzxi+30UPg=;
        b=LMKzp4z2jzddVflv45g7yVrX59bJcKhQEn/Ql09mT7LKVr4Sax+MiMhAdIYta9m4QE
         PQlFpL30/t2yfx1czsfRRbA2G6z6I8+ze98oYXacl1xxLKqkKKDP7NgTfPBkF2Ni9jCF
         ZSWf8k0Uq3K42F3pDX+jWnAubg7RFTt3AztYdsVp2TOdf86Qfj9M9+6+lVjHLaWSgaaj
         N+awd/sTjZ/Myhc5ejirNaU5N84bkLUqYfn+EQdpxIo3sn31iEj94Mia6MM4xrUqv8Oi
         gamRDF5htLHmfQWm8JeNv67K5ZKx7bx7UKyKuqktmUUPehc4coXy/WzzuB9xCPPpUDWi
         XyOg==
X-Gm-Message-State: AOJu0Yw1H1YEnO+UBElMuoawQs+5LhQ1V8aqOi7mjww1Md05ejtjvvp1
	fFc5ERyTglT6QBeGxTiFZ421AdZD1JfuKSGOYJTQMr0z8mnhwT+gNfITD+FDETQLYaqTVUXBWwX
	Vl2DAFw==
X-Google-Smtp-Source: AGHT+IFdnxl6xFtWaY//CsRFyPaMrHSaNSu0OxyeCsszx+51OzrDiSM4n2atYHRJV3ofjk3HEqDK22OpWko9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:16c5:1feb:bf99:a5d1])
 (user=irogers job=sendgmr) by 2002:a05:690c:108:b0:602:cb41:99ad with SMTP id
 bd8-20020a05690c010800b00602cb4199admr114151ywb.7.1706746530194; Wed, 31 Jan
 2024 16:15:30 -0800 (PST)
Date: Wed, 31 Jan 2024 16:14:59 -0800
In-Reply-To: <20240201001504.1348511-1-irogers@google.com>
Message-Id: <20240201001504.1348511-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201001504.1348511-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v2 5/9] perf test: Rename builtin-test-list and add missed
 header guard
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
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
2.43.0.429.g432eaa2c6b-goog


