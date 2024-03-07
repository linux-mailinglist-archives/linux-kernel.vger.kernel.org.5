Return-Path: <linux-kernel+bounces-95113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBCD87494B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F99D1C2188C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41930657C5;
	Thu,  7 Mar 2024 08:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Ksh8BxJI"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1D7651BA
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 08:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709799272; cv=none; b=Br4yoMyYrc+UpQoH1eyoCdxxd4FDdiRqxkDX8fb0h/qTQSL7rAMApUBmEYrWwIF+a+rHohx8AvsRATKswYlUK7tz5yTWGlXVdJZQPfwJ4xKSFn2HCb236iY5O+Vk1nFJij+odXquwwsAVzZrAStmdaoKL52cOIAS0tEf9alb6Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709799272; c=relaxed/simple;
	bh=cmwdpFX6u7kgML8KCB/AE8a30yd+jOPjm9k9IyM0BB4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=k0AkRT0y+xDCxHVQLSyL5EJHbWh9KbWw+R3TDGdx0y+6iDCY3wlo316lU+sbXHHFG3KGK/nxdMf1XAATuvZafpdhvWj5BvlAygunAU6pGjuM6qw20SDlynLxW1JWyxjNXjQG4NAE6CKzl7DYX0yaqrfUik3u/okWgKbaQ84BBwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ksh8BxJI; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dd0ae66422fso1357931276.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 00:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709799270; x=1710404070; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UMszCQsKnKwqHBaw/VXDFLccaECZInv6bzZZFsySaI8=;
        b=Ksh8BxJIy6gHYUaMYwtUdsIyRXGv/hCo22AfXAiVEBB6R3EO0zlqhNPBDnWYmVRl+h
         ydBTW+69fDv8JycgURP2yoPBzGaUkV9Q7U1f738gNWm1Leomm5DaqVycwFyQjIHiX5IY
         TnJAjUK0riHv+w4jUKXPhbtKY+/SED+rmSBcuOE2fX7Vdv6Lce0O1Bo5dwyWIwH3DwuF
         wpuvUjNFoKzH51p3T3vziNHCe7sTwcFJuA9JwNlvrXCgbr8HONxNaqt6fb+mFozyiC6L
         oJhBnegPksSbWn0HUFtSgks/ryU6EltUo4KhsYoRzXOCTD1VRdqeQ+dscSnZQyv63dH7
         oQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709799270; x=1710404070;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UMszCQsKnKwqHBaw/VXDFLccaECZInv6bzZZFsySaI8=;
        b=lLpz4lPDlWs+/q7TjiTqk9OOTUEew6hUSbCixKlP0ltpqYW8LCBg+lzr+3vnhUEmhX
         O7vsKqYNOd2qBw+VXybbX6X2WEuuJzp8EGYvYm/B9zJuomlcL9MCqg6npU23JUDVfep9
         NDxae72vNbNjFWZYG7VSEievbeeyfZp+b/3By294QjxxU77ganAUMtdPOfANlT8nr7gN
         k08escDOpqnbTg2P0emo7elec5PqcHD5OCjkHDxEWZLmPlCsZi8E1eHJrKl8h6q85YQp
         9wZTd4PfyPRSlF7fXu4ZhKZ5tPndaLHGwGIHCnGCLj51pIzyX5PxJBu2uWRf9Mnzpc+F
         mhiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRv/a7AB29uTYnYasL/0YJoEOy9VPxnV9bupa+qs9muu2g6NssF2lwEZ32qb0Mjbwd1gyu5EeH7k/tHSSebcNRNERHHGLPqU0LaXJ5
X-Gm-Message-State: AOJu0YwDfubzN7klCXiXwYdFmeJM77NdS3SYZhgTKh/lPHvQjdd12lNV
	loPEeDKKwEX1vHLj5YjnB0naxqz3CypAO+xmOuxhS5NgHQTIvoWiyPhM36TQmcHCUWPgqk27dl/
	ZamA0fg==
X-Google-Smtp-Source: AGHT+IG2ESZgtaLDvHRZVWktnAFX8J2Uj9lhk+4DYK4F5tZiS2sgPb8NMyn2lHURVoiKjYBUHOx77iuDtqxZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:47d6:1de1:237a:6728])
 (user=irogers job=sendgmr) by 2002:a25:ab8f:0:b0:dc6:deca:8122 with SMTP id
 v15-20020a25ab8f000000b00dc6deca8122mr3222ybi.5.1709799269914; Thu, 07 Mar
 2024 00:14:29 -0800 (PST)
Date: Thu,  7 Mar 2024 00:14:10 -0800
In-Reply-To: <20240307081412.3933750-1-irogers@google.com>
Message-Id: <20240307081412.3933750-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307081412.3933750-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 5/6] perf tools: Use pmus to describe type from attribute
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
$ perf stat -vv -e cycles true
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


