Return-Path: <linux-kernel+bounces-47608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0E8845033
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B743A1C23215
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9147B3CF51;
	Thu,  1 Feb 2024 04:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uoXs6WNQ"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1413BB4E
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 04:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706761374; cv=none; b=PFR9jOHMP+RBGF4pLk1P0Aa4otGQd/wq3LFc2lfW1KdbA2uqM8y1iykuHFEC32xentsWWbZCiXImnhGK9BDTbdHGIhbF3Bzic7a4UCcjAuWQ+MMkBBAHd6DiROM5+iGPcoVs9DaBrJyUqN1Mc58zI5VGv4immS7PAZ27G/aefNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706761374; c=relaxed/simple;
	bh=LEf47llM5ZntjdM1tFx+kv1F7VOaVbLqYPevCFmzKgY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=JiTbIomy4iA/r5HSAnJiihUUWSyTQMUxw5/Kb4NP/o21wdW3vRFJSpcoVWNUxZMeBZ/tb796soVcrBwfWzdgX8zdPEl86PuBRjIqiU+3d5iExsWtRXnd67WAayc1ZR1cwN3U60QvRXBbf2kmzDT8hXxHxiwS8kIg6U5HaRQSi/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uoXs6WNQ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60402c8d651so9322257b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 20:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706761371; x=1707366171; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PeitV0yHOpBere8QJtZH8YRXFmaqbWcfFgW9touiCOY=;
        b=uoXs6WNQULbQNrWWnGVc2G/XXR1mnv8bnYE1QGQF6uO1SIj/i3Nk9ZPoPTBMP2wLQr
         M877Z2m7yRKf8mY1mhjecatsnEjV6jWPankR3vQIU6U/jKGsYv9FM1I0cQbeEeFBge77
         X/AvaRkQmNj9FN03afBInFXFD84ictK1OAdKHLK5odHpYuDIQ2tSmet2ql3uk6locy1G
         USYHMVF3t83n0pMl0pfSLKVZNFDctlb+Mf8ls3ikKfRGeUsKViZjGACN8gXkeqLUNelt
         Ec/UL1j/PX6YNhn7Hvgr1m6anSWSUx2EumcAhaJ/Ie0zW5TZIhM+yLYmzxWXIbGCx7ql
         HUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706761371; x=1707366171;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PeitV0yHOpBere8QJtZH8YRXFmaqbWcfFgW9touiCOY=;
        b=DNYcPabmnVUHg4gFUENwOVXt4PM/z5anoR0/Vk46Z7CG9uXwQw6XfE5LblQTMAyj6h
         G8+wbSKdAzGkKzg/ZiOUgUUqupmSMNJHsjGRiZXikSFxRV5Q58f/t4E8M/6VIXlcfH5W
         OkPgP/adSmq1aBHM23GCH63K93+L1t9sMrtn4ewXbekkgHCNvKMX+eeyEH76ld0fjRzI
         IQVN4yberCb2daF1oWS5zBHhd7dZE+dIveFePH/509CtEnEnUi3UinkMxGuzB39gSYEp
         SSG++1Vy4Mc9XRibBbuUYxFC4C16tYUx6rptCTEeYVn6o/eEJahIHM/TXSI0AwpSquqd
         nn5Q==
X-Gm-Message-State: AOJu0Yyn+XgYDnYELfj/Xx/k7QbEszpUdgXB6HRn3oK/OVi2F0w8eZPr
	sPm5A3Za3tJ1oMkhPFItfWIgs766D2BdtLq8vpjg9VGvmlJYYlZXHZ1jzC6uCF4nPwoY0qp/YWr
	DTfemfw==
X-Google-Smtp-Source: AGHT+IFM/pA3IJeVDmvTvXS5pxixyVYGQ3hKU8vPfyFZQMkJX3zylJwKIgo/7SF5iVC6oDBpHE6QZwLb8rWS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:16c5:1feb:bf99:a5d1])
 (user=irogers job=sendgmr) by 2002:a05:690c:39d:b0:5ff:5135:ffcf with SMTP id
 bh29-20020a05690c039d00b005ff5135ffcfmr196527ywb.4.1706761371160; Wed, 31 Jan
 2024 20:22:51 -0800 (PST)
Date: Wed, 31 Jan 2024 20:22:29 -0800
In-Reply-To: <20240201042236.1538928-1-irogers@google.com>
Message-Id: <20240201042236.1538928-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201042236.1538928-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v2 1/8] libperf cpumap: Add any, empty and min helpers
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, 
	Leo Yan <leo.yan@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Kan Liang <kan.liang@linux.intel.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Atish Patra <atishp@rivosinc.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, Changbin Du <changbin.du@huawei.com>, 
	Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Paran Lee <p4ranlee@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Additional helpers to better replace
perf_cpu_map__has_any_cpu_or_is_empty.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c              | 27 +++++++++++++++++++++++++++
 tools/lib/perf/include/perf/cpumap.h | 16 ++++++++++++++++
 tools/lib/perf/libperf.map           |  4 ++++
 3 files changed, 47 insertions(+)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 4adcd7920d03..ba49552952c5 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -316,6 +316,19 @@ bool perf_cpu_map__has_any_cpu_or_is_empty(const struct perf_cpu_map *map)
 	return map ? __perf_cpu_map__cpu(map, 0).cpu == -1 : true;
 }
 
+bool perf_cpu_map__is_any_cpu_or_is_empty(const struct perf_cpu_map *map)
+{
+	if (!map)
+		return true;
+
+	return __perf_cpu_map__nr(map) == 1 && __perf_cpu_map__cpu(map, 0).cpu == -1;
+}
+
+bool perf_cpu_map__is_empty(const struct perf_cpu_map *map)
+{
+	return map == NULL;
+}
+
 int perf_cpu_map__idx(const struct perf_cpu_map *cpus, struct perf_cpu cpu)
 {
 	int low, high;
@@ -372,6 +385,20 @@ bool perf_cpu_map__has_any_cpu(const struct perf_cpu_map *map)
 	return map && __perf_cpu_map__cpu(map, 0).cpu == -1;
 }
 
+struct perf_cpu perf_cpu_map__min(const struct perf_cpu_map *map)
+{
+	struct perf_cpu cpu, result = {
+		.cpu = -1
+	};
+	int idx;
+
+	perf_cpu_map__for_each_cpu_skip_any(cpu, idx, map) {
+		result = cpu;
+		break;
+	}
+	return result;
+}
+
 struct perf_cpu perf_cpu_map__max(const struct perf_cpu_map *map)
 {
 	struct perf_cpu result = {
diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index 228c6c629b0c..90457d17fb2f 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -61,6 +61,22 @@ LIBPERF_API int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
  * perf_cpu_map__has_any_cpu_or_is_empty - is map either empty or has the "any CPU"/dummy value.
  */
 LIBPERF_API bool perf_cpu_map__has_any_cpu_or_is_empty(const struct perf_cpu_map *map);
+/**
+ * perf_cpu_map__is_any_cpu_or_is_empty - is map either empty or the "any CPU"/dummy value.
+ */
+LIBPERF_API bool perf_cpu_map__is_any_cpu_or_is_empty(const struct perf_cpu_map *map);
+/**
+ * perf_cpu_map__is_empty - does the map contain no values and it doesn't
+ *                          contain the special "any CPU"/dummy value.
+ */
+LIBPERF_API bool perf_cpu_map__is_empty(const struct perf_cpu_map *map);
+/**
+ * perf_cpu_map__min - the minimum CPU value or -1 if empty or just the "any CPU"/dummy value.
+ */
+LIBPERF_API struct perf_cpu perf_cpu_map__min(const struct perf_cpu_map *map);
+/**
+ * perf_cpu_map__max - the maximum CPU value or -1 if empty or just the "any CPU"/dummy value.
+ */
 LIBPERF_API struct perf_cpu perf_cpu_map__max(const struct perf_cpu_map *map);
 LIBPERF_API bool perf_cpu_map__has(const struct perf_cpu_map *map, struct perf_cpu cpu);
 LIBPERF_API bool perf_cpu_map__equal(const struct perf_cpu_map *lhs,
diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
index 10b3f3722642..2aa79b696032 100644
--- a/tools/lib/perf/libperf.map
+++ b/tools/lib/perf/libperf.map
@@ -10,6 +10,10 @@ LIBPERF_0.0.1 {
 		perf_cpu_map__nr;
 		perf_cpu_map__cpu;
 		perf_cpu_map__has_any_cpu_or_is_empty;
+		perf_cpu_map__is_any_cpu_or_is_empty;
+		perf_cpu_map__is_empty;
+		perf_cpu_map__has_any_cpu;
+		perf_cpu_map__min;
 		perf_cpu_map__max;
 		perf_cpu_map__has;
 		perf_thread_map__new_array;
-- 
2.43.0.429.g432eaa2c6b-goog


