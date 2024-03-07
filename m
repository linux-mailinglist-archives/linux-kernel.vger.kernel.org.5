Return-Path: <linux-kernel+bounces-95963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D46D487555E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635E01F22EAA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC577134723;
	Thu,  7 Mar 2024 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="mUHzOig9"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0A6130E35
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 17:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709833236; cv=none; b=O216XiwJKTLFkCKKx6PuLdjiCqmLrRSqZNQBS/Mvp/WIe0FBHkriHXjb/riD7YugiDln+eg4mZmc0HdErTsapPqAiXC1PPln99NtBY2/tLZw9XldPtE90cj7+WYQU9gpNm7wtRS+8uZAO0E1NIHjD2Yf1BIrT/KYkdY7ROVQsCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709833236; c=relaxed/simple;
	bh=qRbM4J1nMnCOTtjpsDerekpdTUM2CRL3YgboxCf8VXI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=XadTKd5LQ4xPhAJAdgj95kHEECULFwE38HUK8nHM4BEDmUv2dVcaE/YseocfzLGIM3D5yFybbeh2JXA1aiBGL5UUYJ+r4AhT8VgQAEr++euGeiWx13nihe4K/gjG/PBxtUWKGufMJ47gqaDgt3alR28fLDw+hnMz2OXOju2Icyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mUHzOig9; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-609db871b90so673027b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 09:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709833234; x=1710438034; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WnCRzMIwEmUWcP4taw0TGh+kO0P1YkAyutoR+GaoeIk=;
        b=mUHzOig98qznQjWKBadckcenh3qg3aKvQVTDtj/TVY0/C4fjjSlciDtKP8P1qw6l0D
         aoUZZ4R3kzQdlTnxbc32Yts/30FCEeJRV4joc4KGIKXaov/E0noIR7KfR8+FVB7pcx3p
         Ip7v2O3ahgWvzvO5Hd8/acMn80Z1PvM0fKiXcv+hdRke2cyxR8nCP4teH1kU9oZJyd32
         eDSkG6d8Aheu8RJIPuxhTOk0UZ2y8BisL/kLQHgqB4WwSMXXSRorxZaQLNppp/oK6lPi
         McCHTJgMmTnmhhLcm1UYIOPHWZsqlfR0OvJUYQ46R8F9Ng6JkMnHitkoSbcQUvrcE+zD
         CIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709833234; x=1710438034;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WnCRzMIwEmUWcP4taw0TGh+kO0P1YkAyutoR+GaoeIk=;
        b=KrDkcZFPyYD5qjTxzKmudoBDOYEnZVnqWs/fhuxuKbzTI5A7UCrB7FhjE0s4mEk4j0
         al4XOwg+GjPo9D2B9oHsmDRhTDON5mkVUmqm0/EvUsay6nE8u1k63UJ3Wi5xq8VEPtIi
         5wAeGS/hpNKAps8mM5xg5E4P6iMKbilykaK4qs4tQ98VnGVH1hFt1bpx76Lx0RECZwO4
         /57+YqivlTfNu73K+CHAd2NSmGNbiyxRSCpHJ3k20FWqTqsNit/ZB1EC1F9hTgL8WoPg
         xJCiCIAppBVugZbUhhUh+cQLQ9WTA4G8I6ltgavUc9iafIlp9rZ+Ly0l9PaxoXronXtu
         rHFA==
X-Forwarded-Encrypted: i=1; AJvYcCWjBP9haO7si82IP5Kd3EcszxYBPPksYSmGBxlcg6fsrBZ8I3gFQYHPcoWLy3OulXLMwb4GPwnEjx4S6+7gqypE3GoKUX2U05bpTkg+
X-Gm-Message-State: AOJu0Yz5aQnNkx08eT+WfpW2rk5C2Y/eowWR/oRwajPmdyakpfCSdkN8
	BphKO0HcGvzFJMssL1Y3sb9hDm8RNL3NA1tDKuhfPdbWvyS6vRSo6T1txdUqyw0mw63O+hLVqDl
	gXLjRHA==
X-Google-Smtp-Source: AGHT+IEhh6Kp6uBn3S698WNWsAUPCqlRZBKy0FEY2SEfrml6jP5P0/i9mnZTMpgvkkcp7d7UPnOxJpU2jx1u
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:47d6:1de1:237a:6728])
 (user=irogers job=sendgmr) by 2002:a25:abad:0:b0:dcb:abcc:62be with SMTP id
 v42-20020a25abad000000b00dcbabcc62bemr4788790ybi.6.1709833234407; Thu, 07 Mar
 2024 09:40:34 -0800 (PST)
Date: Thu,  7 Mar 2024 09:39:54 -0800
In-Reply-To: <20240307173955.3982040-1-irogers@google.com>
Message-Id: <20240307173955.3982040-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307173955.3982040-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 5/6] perf tools: Use pmus to describe type from attribute
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


