Return-Path: <linux-kernel+bounces-95114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 826E587494C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6D4BB21C11
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A5F63401;
	Thu,  7 Mar 2024 08:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="uWe+Rk8U"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27088657D1
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 08:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709799274; cv=none; b=hVwL/Vgx98fNqnERry5++JOnpNxKD/wHQ3Ot9SqaN2XTyvxr+C2a7wyM5QDapwJlUMHTXQEO84o1i0gr99JUvCSciE4auEz18mSn5uddiPXp9eRW4gSaTeCGaJz7/sNUEwyGR/10ZxrBahDrDuQVy2fpxBlBSzB9jGNefwyWVfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709799274; c=relaxed/simple;
	bh=+1cu9dKkJ8vg6JWFPY9f9GjbOG3Y+bB8WG0Z1sbnmSY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=VG+49EgJWzA7Pd2HUYnihHEqDkfKkYe/2Wvuodn12Z1UhOBM0TnxMoS+lA7w3Z31LZTzsQKMy2gqx3ukdfNuaCEpXMH7M0rdqlUPl0k7+ru+j/+Nxmd1fXwHuzr7OqZX0ybPw0A64fq1gFJDcEb6OJf0YKKZzv4SU+Mwu+TDc2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uWe+Rk8U; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-609ea26233dso12882627b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 00:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709799272; x=1710404072; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qJestFEVqFGCX9FS9Jv13Zp7RYO5S1fF+epvUel+hMU=;
        b=uWe+Rk8U7KDFAi9k5HxPbYz3dsCNPQQcGB0zrocandfOjp8fa3F75bdEh4UmkrFo+k
         WT5518DvJ1Y6yD/zg3T67h/5Bd7D4cmUORTeihV7E5oS7PACn1RPe3NUoBJKjag/qj48
         /7JPZbDt1PIv/ybb/fMGF+VLvfap4XC12jUwXO73jJn3o4ByAqpPF9L0E4QHLY82BrKm
         8KYsCuqQJGioxk/7C27hZ9kSWlsmDvYfyl63HiPlukO0/KvkXIn/d7AutKHwt6HKMBHk
         ObSakJtpEa5S/zYMZNDRVqfgsHIG6Af42rrjr44DM6SXux2m7PI9xT6Lb0cC926xGAfR
         9jmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709799272; x=1710404072;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJestFEVqFGCX9FS9Jv13Zp7RYO5S1fF+epvUel+hMU=;
        b=dwT9ZNHKg/nYPwu9hq/tn4fRs3gmLrJPdoAhG09Jy1mKd93ZMxxVPRWkarvR+r9MG4
         e9qK40G9EkXhIBaj52AHRot2HaKFiIOLLQsFJ8RYAtzFW5W/hXEKSvWGgK3a28tMcUeE
         B98mqOqDeG3pvUxZv/LF74dUFQ2V8QCdpJGBsr+M9YHQefq3/5vpD986OCzqIjLlDnxp
         2BrT0ISI5IwkTYD6e9h0zYPHIwuuIBlsJIDes8PguoZg4fM27nX4t8OWgRStAbmIrxkv
         6YzaKtdYIdmk8LUvuqyd7xDJ+JDeyN7BpVSgCIFssf9THhqa4n9vYFqBhM32kXjSuC+g
         BGnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBN4GQ0uU2NS0QQD5jbbO9gg/PdjmYs/AXxeP4SkUu/Q7ojj5cOsZkccbn1xxGSZEF0QSAW2loMvWMArSQJldOt5s4pB3Nt44oXPhB
X-Gm-Message-State: AOJu0Yz38cZn7bnxWh/MiN1nTYmOqJkvY0ot1LIbnTsHFUNeDqV5VHPT
	JZB8VTWtm9ZzWdUM5WMcJlFnG2cZy4ReO1z0OMn81jPXcJeZmlEXQnhRa6O0CoR0VLC1lSeaX8i
	QVYeXGg==
X-Google-Smtp-Source: AGHT+IF62rYpy6xSsQVXWRCPb5hibRpnoEJ2h4Jq+ifJXuHBEDTcW2Nt2tXiYyoCck/ZJKxZgDYae1etPY/v
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:47d6:1de1:237a:6728])
 (user=irogers job=sendgmr) by 2002:a05:690c:c17:b0:609:3834:e0f4 with SMTP id
 cl23-20020a05690c0c1700b006093834e0f4mr5271362ywb.7.1709799272283; Thu, 07
 Mar 2024 00:14:32 -0800 (PST)
Date: Thu,  7 Mar 2024 00:14:11 -0800
In-Reply-To: <20240307081412.3933750-1-irogers@google.com>
Message-Id: <20240307081412.3933750-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307081412.3933750-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 6/6] perf tools: Add/use PMU reverse lookup from config to name
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

Add perf_pmu__name_from_config that does a reverse lookup from a
config number to an alias name. The lookup is expensive as the config
is computed for every alias by filling in a perf_event_attr, but this
is only done when verbose output is enabled. The lookup also only
considers config, and not config1, config2 or config3.

An example of the output:
```
$ perf stat -vv -e data_read true
..
perf_event_attr:
  type                             24 (uncore_imc_free_running_0)
  size                             136
  config                           0x20ff (data_read)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  exclude_guest                    1
..
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/perf_event_attr_fprintf.c | 10 ++++++++--
 tools/perf/util/pmu.c                     | 19 +++++++++++++++++++
 tools/perf/util/pmu.h                     |  1 +
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 29e66835da3a..59fbbba79697 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -222,8 +222,14 @@ static void __p_config_tracepoint_id(char *buf, size_t size, u64 value)
 }
 #endif
 
-static void __p_config_id(char *buf, size_t size, u32 type, u64 value)
+static void __p_config_id(struct perf_pmu *pmu, char *buf, size_t size, u32 type, u64 value)
 {
+	const char *name = perf_pmu__name_from_config(pmu, value);
+
+	if (name) {
+		print_id_hex(name);
+		return;
+	}
 	switch (type) {
 	case PERF_TYPE_HARDWARE:
 		return __p_config_hw_id(buf, size, value);
@@ -252,7 +258,7 @@ static void __p_config_id(char *buf, size_t size, u32 type, u64 value)
 #define p_branch_sample_type(val) __p_branch_sample_type(buf, BUF_SIZE, val)
 #define p_read_format(val)	__p_read_format(buf, BUF_SIZE, val)
 #define p_type_id(val)		__p_type_id(pmu, buf, BUF_SIZE, val)
-#define p_config_id(val)	__p_config_id(buf, BUF_SIZE, attr->type, val)
+#define p_config_id(val)	__p_config_id(pmu, buf, BUF_SIZE, attr->type, val)
 
 #define PRINT_ATTRn(_n, _f, _p, _a)			\
 do {							\
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 904725f03d29..f26b06912a8a 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2139,3 +2139,22 @@ void perf_pmu__delete(struct perf_pmu *pmu)
 	zfree(&pmu->id);
 	free(pmu);
 }
+
+const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
+{
+	struct perf_pmu_alias *event;
+
+	if (!pmu)
+		return NULL;
+
+	list_for_each_entry(event, &pmu->aliases, list) {
+		struct perf_event_attr attr = {.config = 0,};
+		int ret = perf_pmu__config(pmu, &attr, &event->terms, NULL);
+
+		if (ret)
+			return NULL;
+		if (config == attr.config)
+			return event->name;
+	}
+	return NULL;
+}
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 9f5284b29ecf..152700f78455 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -276,5 +276,6 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head *core_pmus);
 void perf_pmu__delete(struct perf_pmu *pmu);
 struct perf_pmu *perf_pmus__find_core_pmu(void);
+const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config);
 
 #endif /* __PMU_H */
-- 
2.44.0.278.ge034bb2e1d-goog


