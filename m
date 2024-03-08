Return-Path: <linux-kernel+bounces-96387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C7E875B7C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536581C211ED
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B7A1D6A7;
	Fri,  8 Mar 2024 00:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Drj2RPID"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13111CD15
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 00:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709857191; cv=none; b=tcVuTeUhTzYul0SUDPENJ8wM3PmsLh6++GaMGooFFIGlkijkt7zcXR6RAWu6F+Za6O/32K1EV3nKvE4P+7luFe33jWvQIJDakFk4mg8fiYbAn/XrinVeYc7Zll2jSd4ZojOi+3DRTH+QbJpFNr9kqvDU09w0Yr8F+z1M7e+X19I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709857191; c=relaxed/simple;
	bh=elK0Xs+m/oAU3QVrIgg0bRnVn1Wp0yji7Lirhn51ur8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=k8EoyU7QwyyYJbWKzw/hESop9OveGySHjZOeVBmX8D8CaA/f58G/0wrfl8KMLKFN5WA2AdyEt9EX/QchoZFizNg16COQnjCllbTv4MVCbrh2w3TAEVFSmd2qyjQ/nrJjW1mzLC1mC/UJIIBawl4dDREiMd5e3p3b9thbpQEwQkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Drj2RPID; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60987370f06so5712327b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 16:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709857189; x=1710461989; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fHILL1gTCxm4QF9OC7v7hNL2u1lMsUcHDUfAM6Pn4Kw=;
        b=Drj2RPIDd55nY7YDmzY4v+g0n3cWp51aSC4U36n9vzsqC9usS1wvdD9Be1EbHv4udW
         nBWCzBg2p56RArZ3Zahd0HkRc6ZvxhXWQV0lY3RJEOfMY/XMXg6RI+zdplWu6SYbkHwt
         1oYxKE332ndT8qyPtoiNoEqUIV9PviFktYnX/024o4Brh8CxzU3PtIepO2XFMytbnfBd
         qgBnQ/gfjuv2Nt+acrU6qY1IwoJoHLKXIP5bDuMZn6DFCz2Zbg4BFGC76K7bfFN3v0nI
         esS0n0rnrqKJyxudsrH54XlsKo0c1wr9l5SIjNhYx6yipjF/M9foiNV+SIzagqGrfBz8
         1eVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709857189; x=1710461989;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fHILL1gTCxm4QF9OC7v7hNL2u1lMsUcHDUfAM6Pn4Kw=;
        b=gkPF6pjHGyc0l/KYLME5cBByWtbpVfjrnp6h8r7syDl4dB0uKY3jx8auvDbCnr5AY2
         DykhYaWFot6Rd1D8utOB128WOL8dE7pFSJTvRyiG/P+1IRGgN1+Rs8SQjIU21A0v9vah
         LzCtVpeb7KWk6QU75PI1TjoHufAG5jjAE89odVReqSCSNj9e9toEq5s1snp5J9LckBHo
         VtVOp/XRIPvrvMyWEgwXj3Rgwsho14MvD9BLvG1ZnHHa2pDgoCKb6jMRnODrtlHO+9/r
         vg3gXY7+u86AAO0MIdu+URMzMiOhPyQWUv3DFdbxaqp/439XuAk9Pel9nUTXNRGcslaq
         nMKA==
X-Forwarded-Encrypted: i=1; AJvYcCV4lPUZvyPhkofqEW0Xc+1DpuilizThmgs6UbAKf4bFla/nNGyhw4l4KbmT1jxtNWprfJe+rCZqpaq5ntTH8LpnABJ3ICxFZNNULNbb
X-Gm-Message-State: AOJu0YyvkDZBKn5sP4/YPYbNqB9IHcDph7zP6rj4UwL4kzkKwYUR6/kF
	uMrNMvjoRRz7nCK8FHxgScGkhhQ0Y9Imp4L3jbk7uMiPP1l5OgGlQv3bBqf9ebKyIeP2RFweSkO
	Fmh2V6g==
X-Google-Smtp-Source: AGHT+IHfYCLrCxH6IMYKIHQMOCbjZR2PuEAhqv5gdFqF8CzTI7yhvZtUX8woAvon6/3IiKe5aOPZmDaO0xi3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:218f:92ee:d543:c1a2])
 (user=irogers job=sendgmr) by 2002:a81:9b97:0:b0:609:3c53:d489 with SMTP id
 s145-20020a819b97000000b006093c53d489mr4063810ywg.3.1709857189029; Thu, 07
 Mar 2024 16:19:49 -0800 (PST)
Date: Thu,  7 Mar 2024 16:19:15 -0800
In-Reply-To: <20240308001915.4060155-1-irogers@google.com>
Message-Id: <20240308001915.4060155-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240308001915.4060155-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 6/6] perf tools: Add/use PMU reverse lookup from config to name
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
 tools/perf/util/pmu.c                     | 18 ++++++++++++++++++
 tools/perf/util/pmu.h                     |  1 +
 3 files changed, 27 insertions(+), 2 deletions(-)

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
index e24bc3b8f696..97ad299f463f 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2145,3 +2145,21 @@ void perf_pmu__delete(struct perf_pmu *pmu)
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
+	pmu_add_cpu_aliases(pmu);
+	list_for_each_entry(event, &pmu->aliases, list) {
+		struct perf_event_attr attr = {.config = 0,};
+		int ret = perf_pmu__config(pmu, &attr, &event->terms, NULL);
+
+		if (ret == 0 && config == attr.config)
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


