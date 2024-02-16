Return-Path: <linux-kernel+bounces-69513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D14CE858A68
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017891C220FD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CAB153503;
	Fri, 16 Feb 2024 23:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0abjhKbL"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE670153507
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 23:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708127727; cv=none; b=AaRkeD+h8ieOf7MLP0kJpasnc+NlVZ9eFhCKt6G14IxN5m9kkG1bOaN5XcLMqRNcRKD158w7chFrW9WtFJC5aXxd0iLugqLwD+dMxl8dhIFBupRz7oMgnMQHztKXOSLYZyVHeeB+j3cp2ynwR9uvtrkfAYzqoZKndWIMfuECptU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708127727; c=relaxed/simple;
	bh=I+UE93RRTXaqRw/ye3XEqbtXPztsO4QkZJrrM8rzem4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=PEICb1lO4bH7Murr/bMCjjv9Jm4y+5D7mIzobnTRt9xjniQpfRr/qyzCQ97PcUafxAs0qTXzz2yz1HU6Owx6//+B+QLFrrcGBFfDLluyvzVa9qYfvQimzzWxs+cV+0MnOxGOPDfaoiCiyJnpUpdJsYzMv93TNU1jJ+BggvH2xhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0abjhKbL; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ffee6fcdc1so20402607b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 15:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708127724; x=1708732524; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BDoXWFUllq5r9qvxHaqqdOtetQC7wmYhYSm0N03NFTM=;
        b=0abjhKbLH+0b2/hA7gQDVaBkOkI5Oct22+pH28A+PD2G2f/N/kqBwB9BaVgzWabl06
         j5rAY6TOX7i2WGcsMbZlh4ZNH9gifdumlY/oHNCVLxkcbxNunDMqh6kpDkLz996zZCax
         lgq0ULCvYzrJtLylrkwVirTBDCqZc6/CgXQMY+OVCApNYIHFVowUjj/VzuK+o+TJCVXg
         /gB8i71e6Kv6hWADwOUI9Q2k0Ft1UVRdMY8uC7nJZ4otmM4siwR/k1wg+Fl8sAGkKwqc
         R2lXOta0Snn33dttEvEy0wPYRO6yxmtZlEjfOweaYcSm3cFVK3fIJDa838bdIAuC4xwr
         UC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708127724; x=1708732524;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BDoXWFUllq5r9qvxHaqqdOtetQC7wmYhYSm0N03NFTM=;
        b=n74LjTPoMa8InSeyvr477swUu5Scd1ZBrUq+mZQ+6xdz9+M+I1UjbALoOkpRLr0G5s
         x4LXQy05mrw4Rgn7kLF+J2X9K3wW4BHIgUpY7T39aMCzMoMBwDXShdtxEbVtj1IgMDm5
         wt4/Ezcf64VmFk9OgMpe4fojp9Mr2HME/cTMyj0fwfpkXWT9I69PmyxZaLz4WaTwmNC3
         a720CkLygeinyc73CRlSzCbPYaMbivW324PGz0AhHE1Km+clZcLK+C8O9wXMK3/ocYy1
         +OBVtZ75oRJRAew+1K8nJdyTN1bFJwfzh8NIOWJjY7GG3kvf91tlo3lyH8/AxyhtYAM4
         EehQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXZ1lrJJ6nGi9O/qHa5dmEvw2n9BR+DKJJ/6EYfY8HN6u0zH+jL3RbxDNWXXAY6PKdbEvRbCxJciMbL63bB7d+U8gOtrMBOEsVSU52
X-Gm-Message-State: AOJu0YyF02h6OA30greYHWKC+l61zxraqhdsj5UJvvPqGNnQpitdjnx7
	w9hLbdQt+YxYFDYLlu1jLaxdq8d0lDyD5z/37n9HmjIFb32fDzveXTd5xjtziAXIoLpwl+Yih2c
	YDL6r5g==
X-Google-Smtp-Source: AGHT+IHjzJawXDO2AXJXaejQYAiOMaUrWyEtn27ViDkJQiFti66UFA6r7CcCoH/bmb67Eb7eiXG+oRMQM2AD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4b5c:352:4272:e34e])
 (user=irogers job=sendgmr) by 2002:a0d:db4b:0:b0:607:81e1:8b83 with SMTP id
 d72-20020a0ddb4b000000b0060781e18b83mr1157396ywe.8.1708127724036; Fri, 16 Feb
 2024 15:55:24 -0800 (PST)
Date: Fri, 16 Feb 2024 15:51:59 -0800
In-Reply-To: <20240216235203.229256-1-irogers@google.com>
Message-Id: <20240216235203.229256-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240216235203.229256-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Subject: [PATCH v5 5/8] perf test: Rename builtin-test-list and add missed
 header guard
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, James Clark <james.clark@arm.com>, 
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
2.44.0.rc0.258.g7320e95886-goog


