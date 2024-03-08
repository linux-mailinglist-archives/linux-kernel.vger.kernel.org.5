Return-Path: <linux-kernel+bounces-96386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7F3875B7B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14FD12831B8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D83B1CD2A;
	Fri,  8 Mar 2024 00:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="nFTx2lMC"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF70D13AF2
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 00:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709857189; cv=none; b=oEbKLPk+Na5DlgqfOLcwjEYJ4XvpWqLilPxMOldcuWpHE2rdoT54rKj+2ID6LGzHt8ivFdPsCthgG8eeG1H+CcUt+fxh42MN2XF4UOKx3c8g26LC797lPcg54sQb9SxO830kYaHNmXurVkK10viIXtAWMhoZielzOzK4VKTK2Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709857189; c=relaxed/simple;
	bh=qRbM4J1nMnCOTtjpsDerekpdTUM2CRL3YgboxCf8VXI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=THcflBY6x+QXh6Zy2ZzCmT3INq1AHYZua0dq30FfBkr7ZVHYRVTjB7a3oR3T05+PxhUtpdKsb8VN2ewtwnus9bFzKdvZsPThouw/g7CUYELhDbLZPHsTQtGruXGX4gGkQw+1WtIAR01iEEiSGYJuXCfcW6PsLDP9eZNy/UStVcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nFTx2lMC; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-609e2b87a6bso25601797b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 16:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709857187; x=1710461987; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WnCRzMIwEmUWcP4taw0TGh+kO0P1YkAyutoR+GaoeIk=;
        b=nFTx2lMCMk0ii5Y9Sv12Do9RxicDmi34+BWvgqM0YHYQQhjS8cXXkeiN0RXQm/xAMx
         WcP1aV/hHjz+7MY5VQHZ4zeA9QDKJHUVoThebsxyC6/uyqHfT68WBU1zEX7R/+vDbp19
         t0aXfNr45ZPMZtgfVLiOFN+/Eyavi1bh/ZbEaQTkFbRUS3LlW8WzcX5gJluS+gbZwa+F
         8i671RQvmhd3nBfaJ8wJjXyg0ZglbaDAx0ev7H55qOOlSSmyKtlE4Nxg8sCuJRssSCB7
         UQEibIvaCnaCV+g3V4BUa+rjqkcscjHBIrSToVwUgLdX9CfZ4q00UQYIB+zdVFnn3MqQ
         wMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709857187; x=1710461987;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WnCRzMIwEmUWcP4taw0TGh+kO0P1YkAyutoR+GaoeIk=;
        b=NtBLgZwgzQoymhn96GCqBOw4hT72oXOcSIZ5Xf+jKGee8O9YJd8uk+mqviMG3dsvl4
         cZAT/ubgatZnoR7KDFX5uVgeJJNZXlGgjCVUYBUUzhO1QePsVvSIiHzMqOO6xs4L1pLF
         jc0yFmgQoeF0CBVF+gLOAfnisTGz9E2diIrlChDXjZXTIY4K7Rud+z4YYBpgZuCAqX92
         3gD4CuUZWJVYPFaBSRmcs6tD/FNGUsuoyDWbbYCvpeo4MJD4G89ObU/lQGxmBnyyRDZc
         /tn0NjTuDjD/OD8jXhl3H/9oeZDwuwhAEde6BX8OuY39yIwmTpu4wnPyH+gOu+3fS/bJ
         +iPg==
X-Forwarded-Encrypted: i=1; AJvYcCWJaOoZ0EUFhYqhCEmfNzrUAj75ok7dv/90S2lpfM2X7r9EzvT8CGomDKx2dB38UUgOgvmrKUKOUmwaKOFjXo4swQUTyyvSRQ2N3tnZ
X-Gm-Message-State: AOJu0Yw/BD0PfWXe5pOt8ekwMs9mtGGQt1cOqpIXe7YF546qIUrKpmvN
	B1gvr8M+fgYacOJHRu/q0tnrKRfUcFCQS3bduCPyjtO37xnXMCQOwIiIwZ9EDStXLsZM4FrZOJG
	P3r3NYw==
X-Google-Smtp-Source: AGHT+IHJCTyaNqBxaTLU14hVtz+CLHQZ93ZrH5zbxunYvvExtWwXEhrwq/UeDgTB3Xlg6ocZjXgQewrFG8Hr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:218f:92ee:d543:c1a2])
 (user=irogers job=sendgmr) by 2002:a0d:e643:0:b0:609:fbb4:3076 with SMTP id
 p64-20020a0de643000000b00609fbb43076mr598138ywe.3.1709857186828; Thu, 07 Mar
 2024 16:19:46 -0800 (PST)
Date: Thu,  7 Mar 2024 16:19:14 -0800
In-Reply-To: <20240308001915.4060155-1-irogers@google.com>
Message-Id: <20240308001915.4060155-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240308001915.4060155-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 5/6] perf tools: Use pmus to describe type from attribute
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When dumping a perf_event_attr, use pmus to find the PMU and its name
by the type number. This allows dynamically added PMUs to be described.

Before:
```
$ perf stat -vv -e data_read true
..
perf_event_attr:
  type                             24
  size                             136
  config                           0x20ff
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  exclude_guest                    1
..
```

After:
```
$ perf stat -vv -e data_read true
..
perf_event_attr:
  type                             24 (uncore_imc_free_running_0)
  size                             136
  config                           0x20ff
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  exclude_guest                    1
..
```

However, it also means that when we have a PMU name we prefer it to a
hard coded name:

Before:
```
$ perf stat -vv -e faults true
..
perf_event_attr:
  type                             1 (PERF_TYPE_SOFTWARE)
  size                             136
  config                           0x2 (PERF_COUNT_SW_PAGE_FAULTS)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  exclude_guest                    1
..
```

After:
```
$ perf stat -vv -e faults true
..
perf_event_attr:
  type                             1 (software)
  size                             136
  config                           0x2 (PERF_COUNT_SW_PAGE_FAULTS)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  exclude_guest                    1
..
```

It feels more consistent to do this, rather than only prefer a PMU
name when a hard coded name isn't available.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/perf_event_attr_fprintf.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 8f04d3b7f3ec..29e66835da3a 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -7,6 +7,8 @@
 #include <linux/types.h>
 #include <linux/perf_event.h>
 #include "util/evsel_fprintf.h"
+#include "util/pmu.h"
+#include "util/pmus.h"
 #include "trace-event.h"
 
 struct bit_names {
@@ -75,9 +77,12 @@ static void __p_read_format(char *buf, size_t size, u64 value)
 }
 
 #define ENUM_ID_TO_STR_CASE(x) case x: return (#x);
-static const char *stringify_perf_type_id(u64 value)
+static const char *stringify_perf_type_id(struct perf_pmu *pmu, u32 type)
 {
-	switch (value) {
+	if (pmu)
+		return pmu->name;
+
+	switch (type) {
 	ENUM_ID_TO_STR_CASE(PERF_TYPE_HARDWARE)
 	ENUM_ID_TO_STR_CASE(PERF_TYPE_SOFTWARE)
 	ENUM_ID_TO_STR_CASE(PERF_TYPE_TRACEPOINT)
@@ -175,9 +180,9 @@ do {								\
 #define print_id_unsigned(_s)	PRINT_ID(_s, "%"PRIu64)
 #define print_id_hex(_s)	PRINT_ID(_s, "%#"PRIx64)
 
-static void __p_type_id(char *buf, size_t size, u64 value)
+static void __p_type_id(struct perf_pmu *pmu, char *buf, size_t size, u64 value)
 {
-	print_id_unsigned(stringify_perf_type_id(value));
+	print_id_unsigned(stringify_perf_type_id(pmu, value));
 }
 
 static void __p_config_hw_id(char *buf, size_t size, u64 value)
@@ -246,7 +251,7 @@ static void __p_config_id(char *buf, size_t size, u32 type, u64 value)
 #define p_sample_type(val)	__p_sample_type(buf, BUF_SIZE, val)
 #define p_branch_sample_type(val) __p_branch_sample_type(buf, BUF_SIZE, val)
 #define p_read_format(val)	__p_read_format(buf, BUF_SIZE, val)
-#define p_type_id(val)		__p_type_id(buf, BUF_SIZE, val)
+#define p_type_id(val)		__p_type_id(pmu, buf, BUF_SIZE, val)
 #define p_config_id(val)	__p_config_id(buf, BUF_SIZE, attr->type, val)
 
 #define PRINT_ATTRn(_n, _f, _p, _a)			\
@@ -262,6 +267,7 @@ do {							\
 int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 			     attr__fprintf_f attr__fprintf, void *priv)
 {
+	struct perf_pmu *pmu = perf_pmus__find_by_type(attr->type);
 	char buf[BUF_SIZE];
 	int ret = 0;
 
-- 
2.44.0.278.ge034bb2e1d-goog


