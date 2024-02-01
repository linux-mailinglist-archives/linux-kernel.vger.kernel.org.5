Return-Path: <linux-kernel+bounces-47614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 694D4845041
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C1611F257DB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBCF405D8;
	Thu,  1 Feb 2024 04:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lvZv0WWO"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8CD40BE0
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 04:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706761388; cv=none; b=eMVHAoFdoSXrERxWwt3Ir+VW4loNyq9BwlztWHpSE1cdgTEPNRJCyVQNmMHPi82nF6y3ZrceHIIpKG2Xwpmf315rMfxK7Bpt7iDjlcLXrlY8ganwCznmypURQPjyN1ttVtExCNwgzRI7SDbeFGC9wAHz5TDckYbH8MR9z7QgvzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706761388; c=relaxed/simple;
	bh=F7w78dZ7Yg86YXdfWPcsiQMqcZSTmmSk6fh0dJHNA10=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=UpzlFi5Ql11ZfZ6BE6OMeZ+0lWCwPpfnZ6AI386tg69VCEJo4blXT+D9cM/l7eC23tg181eu+EOOJcDiKLL7nFaOCGhxDEUMR/4wexvvZFC9jLbpY9tTHMjjF53yD+T+j76tt7e3YBiASJtDCFGeZToc2m3h7qmpZDefBVYwXQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lvZv0WWO; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60413725f39so10156827b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 20:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706761386; x=1707366186; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LqZwZ8AsgQZJFdN47MyZTq1RxCf/Pyb95/3gvsK2ot0=;
        b=lvZv0WWOBmGEUwyBMdWVN5cw2Cl/6sUzdgeLEuRQlKL/cDjb62+GvGz3kOu7jAW4yU
         LXeF2y06NZ3+zJOLPg9u9XFB6SjkhrKfppJy0a5cRI6Ra2c6W4vHwhh0hQZvOykTWANR
         AAg4FpIEw4slFQlnub+Kf4xAkWrYPCrPHUEWbob42LqRR+ilpMbdT7+G09sNOQm1+ex/
         5RX2ppkQUgp+1eQFLspevq0S64gqe+IgnIHncGBtaMAvbo75yYnYLDKPGSOZgY9GSEd2
         gW1QSOoFDb22p8ancIQYdn8TcnGmPLkzg4tsdZ7UIY1ekAXO89e3NCKvyAlMcvsi+yoD
         xexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706761386; x=1707366186;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LqZwZ8AsgQZJFdN47MyZTq1RxCf/Pyb95/3gvsK2ot0=;
        b=jNsinOblIF2QO9KVgGTbPSTebeAcsF1/5/pBJRqfrewL+ei/5joLJ9AFM5NkIMbjgU
         T+TqtzEUYGHunZgV1I8blbF2KlRXTZv60NaEDl09hfRHZMSRV7/Og48pOW8pMqOrdTpy
         MAYQ/sjL7gcTaGR02PK57Ms07txvZlsjlVsFZiEh4nItddP043T4S8SoP597rM1W6sq+
         nS+VDYqJOC4tPrbICUQHtg8Erht/7itGQoX8X9GECOkqdrmh6/6h35yvPRS/rG0djPE+
         wlCMpjR7M8f1xA04yZkL4jOKjKcO/DhHIUbuWwH0WsuE56X0c5AA/OMxAtQu85aDs6s9
         Q+Zg==
X-Gm-Message-State: AOJu0YyUySf3/cRIYqEF0DeRh2w3AUNmaSTu0FS05FKG4rS7fWv+KM74
	mVxYXlteadZg6xI1plg/QTAz2yH27v0PkxxhBTHdrFB6dIQCG3pveRlhXS/YNfajkRmfyDi6ekb
	45BHDuA==
X-Google-Smtp-Source: AGHT+IEbBHPoopwAV46hmLodLw8f6XGcENXHUyhMaiQPvtiJ/0/ATGvBJGXoRGEaXvOe810MmKMKo255lWtS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:16c5:1feb:bf99:a5d1])
 (user=irogers job=sendgmr) by 2002:a05:6902:2749:b0:dc6:a29d:e0b7 with SMTP
 id ea9-20020a056902274900b00dc6a29de0b7mr975743ybb.4.1706761385897; Wed, 31
 Jan 2024 20:23:05 -0800 (PST)
Date: Wed, 31 Jan 2024 20:22:35 -0800
In-Reply-To: <20240201042236.1538928-1-irogers@google.com>
Message-Id: <20240201042236.1538928-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201042236.1538928-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v2 7/8] perf stat: Remove duplicate cpus_map_matched function
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

Use libperf's perf_cpu_map__equal that performs the same function.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: James Clark <james.clark@arm.com>
---
 tools/perf/builtin-stat.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 280eb0c99d2b..d80bad7c73e4 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -164,26 +164,6 @@ static struct perf_stat_config stat_config = {
 	.iostat_run		= false,
 };
 
-static bool cpus_map_matched(struct evsel *a, struct evsel *b)
-{
-	if (!a->core.cpus && !b->core.cpus)
-		return true;
-
-	if (!a->core.cpus || !b->core.cpus)
-		return false;
-
-	if (perf_cpu_map__nr(a->core.cpus) != perf_cpu_map__nr(b->core.cpus))
-		return false;
-
-	for (int i = 0; i < perf_cpu_map__nr(a->core.cpus); i++) {
-		if (perf_cpu_map__cpu(a->core.cpus, i).cpu !=
-		    perf_cpu_map__cpu(b->core.cpus, i).cpu)
-			return false;
-	}
-
-	return true;
-}
-
 static void evlist__check_cpu_maps(struct evlist *evlist)
 {
 	struct evsel *evsel, *warned_leader = NULL;
@@ -194,7 +174,7 @@ static void evlist__check_cpu_maps(struct evlist *evlist)
 		/* Check that leader matches cpus with each member. */
 		if (leader == evsel)
 			continue;
-		if (cpus_map_matched(leader, evsel))
+		if (perf_cpu_map__equal(leader->core.cpus, evsel->core.cpus))
 			continue;
 
 		/* If there's mismatch disable the group and warn user. */
-- 
2.43.0.429.g432eaa2c6b-goog


