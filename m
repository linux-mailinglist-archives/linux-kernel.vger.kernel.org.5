Return-Path: <linux-kernel+bounces-50726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF383847D53
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 843C6282D82
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A8F134CD2;
	Fri,  2 Feb 2024 23:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rs1AoA1s"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE4A13329F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 23:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706917287; cv=none; b=u1MK03Mp4v+Ht6Qo3BWw71NxM9RAOFVa5wHAEowuTm+RiFE+6RIshpYdYj9FD8W/tn7ERsvWZ+ueQayUe7jP4Upb2Lg9+AulM7Gn4ke/tgKv2s0dcLE+KJDeb1fqaY0bRr4kmg5jmKWoIHKnEPtGPgx+baY2J9jiqfV2Iavr7Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706917287; c=relaxed/simple;
	bh=ML8a9VBGcxJuZQepK7vQffZ+xRnwx4f8S25ZVo2Pqug=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=g62YuHiUO8hVo1BUpCe+9fV2ZDyT4PLT7znVbKLtS19lvOTwfwuNRiOLTsojJx1iFjZSVVK5w5miAZ8UE0Wshad/1aqyw8V+0TPZFAWevgoNplnWUCmEoQvfpgbryHl37FjSddCy3Shbrq21rf9z4Idi+IgAyjLRxh7coV9xFYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rs1AoA1s; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-603c0e020a6so39111077b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 15:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706917285; x=1707522085; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TiTDOvBVexFioWtZi7idM6N1b6RuopqNxCQfkxi6/RE=;
        b=rs1AoA1sMgUgRfo019U4kngZCVdoq/iho4cU6+aGabvBnBWzaZCvru9y4Sg20/ISzP
         TnyyjgvBkfR5OdtjfFX4pyHoOJKdhORc9lK7iXe1lCr3YyXBEuGxGp3F4tbonGoN5cAA
         NVdq4J73jzcpbC9VzgYZ5sluqWEdZWO5HfVB8aDzjPiBd5uF2+nFYSaABd1ZgCyvFdVD
         42b4EDJW3JKSDfPanU1ZjL6KbjC7hasxHnCKG3elkFUiOkRvhMW60N+Ta4iRJhO9y8fc
         5aGTAlW2H5+469+wYepYDM4j+C+cI6mK3lM5bMH14TXqL4tDITzytRDODjcJFmjs2has
         M3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706917285; x=1707522085;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TiTDOvBVexFioWtZi7idM6N1b6RuopqNxCQfkxi6/RE=;
        b=kB14sIwASZuD5XeGbWBQKcWhHNkwmLT5Kx5GscNSkgdaQY77OOixr9STTt37YyFP1k
         UjH9jwqUNJKwA5jJNyH4lA/zOeTA+k7rh67tHDkmH5nhropfyAClncUyLHZDFRVI3GTH
         MjfSaz+4b5yP8TH/ufrM6NBr92sIvsHK91HtoUM5CyfX+fBGKEw5nhfuEUtP6mQYq6pa
         xfO0nKWivBkZo89zmh52jseDp09YlABI8lJAMGYcNWA22jGF9d8LD/esh17zPjzbar5S
         MfUqbjzZH+Ux676CO55x3WdEVV5YJwOgva6PVNH2pQVf/l5cO62Fa4inuOdxOMEXYCkC
         YvEg==
X-Gm-Message-State: AOJu0Yzeh82uyLVxRRXAoglML0PTZxOzcESomX/uiQPSpekPz5nasuJ2
	Is9WnzKjypHRkVUnGq9JtSRwGntFsOzbNI9QtyS2G4Z6CXOKjG7vEh66nhJJd6l7HxHSK+Z28V1
	vFnTOzQ==
X-Google-Smtp-Source: AGHT+IFC29Z279Ff/N0YDvDBynRGWs9YKG/N71yuGRqZ0vDb73/HoBrgLOta7fz6IgJNl/gCwXQX0m26WJMv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7732:d863:503:f53d])
 (user=irogers job=sendgmr) by 2002:a81:9b4b:0:b0:5ff:6041:c17d with SMTP id
 s72-20020a819b4b000000b005ff6041c17dmr1156128ywg.2.1706917285199; Fri, 02 Feb
 2024 15:41:25 -0800 (PST)
Date: Fri,  2 Feb 2024 15:40:56 -0800
In-Reply-To: <20240202234057.2085863-1-irogers@google.com>
Message-Id: <20240202234057.2085863-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202234057.2085863-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v3 7/8] perf stat: Remove duplicate cpus_map_matched function
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
2.43.0.594.gd9cf4e227d-goog


