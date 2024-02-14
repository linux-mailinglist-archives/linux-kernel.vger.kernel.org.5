Return-Path: <linux-kernel+bounces-64641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEABF854117
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8FC528F100
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAF711CBB;
	Wed, 14 Feb 2024 01:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fDtHqmck"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D556111CBD
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707873544; cv=none; b=MtESYeAPC/m82bjVoNYa163ZaYlSco50q9RjiiW9Rv+7KZC0CB34/oH+cI1+lj/Xl/yyCCXaHj16GNSx5mFWgmF3eWzZzvJeAnA2Y4T8PJT+CwaHfKHMp0ixxFp3aguM6mvUI0Tx3L4VA4FkoxrsyK00zDLG8qIaZIRdWydhAK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707873544; c=relaxed/simple;
	bh=V88Gs00+xRh0dnUbiYV4M3zoM8IirkPd0A2eGi2z6Ew=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=nKeiQJduPhKc4zz/13CR9o/lhzxatb6UGrNV5P5OjjOPwllKca7bML7R4DpfolYghrXbmL+KxhD/4NGfl+aH4yuADK1J7rlB7YU4XX3v2Lfs6yPeda+cuKtAcK3b8/eokOj++qyEmJE5YEBsC1Lp9dMgV8U8ek4khrW6jEs8zZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fDtHqmck; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc64f63d768so9276001276.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707873542; x=1708478342; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9SRekdx7zdgvkUXno/rVBUgTAmseVwDBcQ2V8qW4bP4=;
        b=fDtHqmckBnrG10RYyXRKqwWyS2ldT5Ke4aADx8yFoLCnE3XidnUZX5ud5T8DD1aopK
         auqCObQsJyypkmfAsA/q48uZySobqAUMGT7Ow7yZ+a25lD4Z9MpInRaseAViTPg3FgMD
         e+60OOc4GOm1i4HinAgozGHysjXuvI2JiyLMunOXMFHDMbbg9cEpZowDx+iCUYse646g
         JGj5mmfM5PQCRQ6mkqUkTQyKRUUCiUY/w4Ufp+XyJTMbhX6hS1ZCjISZ8MOyMy3rvvfe
         Z7vksRAzuWUh303HuXhkIvysy7z944f8oIZtrjA1Ti/29Bi1hwx3aE4J/EY1nLokpGf9
         /kNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707873542; x=1708478342;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9SRekdx7zdgvkUXno/rVBUgTAmseVwDBcQ2V8qW4bP4=;
        b=bhc3mudGXxKrx4+Lk4Hr0SmxT1vMOh4GbGZ9G71QdqBwDB/ZD1nm3xjQdlpC+CFkKW
         JQmcDUyaU0vx3JOciolwztS64YjSdbojagZ5mjNtPpkfxkTVv+NKY2SF6saIkyRGoC+n
         sjRglDKD2QharHYcM0w9AAJIS/3bxAhGPCet8uWFvKpXwxqY8dW/YOY/SPKVH20/igNX
         Vxb16/kgqtPsmp3EEQidW5/QckKu/HZlSdwfkoAX6fKHutdeRbZZjgjaBnlmCH3kFsk7
         8+CEQasBcpF1Fah2b/2MWyMKOyeVZ4/J5ZBGte3c9mw+kVQLjgjXlZphYh4qtfzvZ51x
         5+4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVaAxBKTNcPVaa8CEj+vF1gniOKaSCS2IexUQReuCKtWcgFQcRtgmztyScAbjDRTU/yN30OWt5ORbUwzrKn09TeHRsn6obNlf3Citej
X-Gm-Message-State: AOJu0YzoUVFrEx9CNuqIYGVWktaZVm1PaB2Ya1Xm5GaNj/11iZaYexIb
	TIarZECY0cuSsSqA0lukr2So09M4BAdCH64f7pjuHynmtplkSiG7bRAPNyyIHZK1ASfR8MUsxvD
	ygRvz5w==
X-Google-Smtp-Source: AGHT+IHF14DyjdGAXHxjVUt69KeQSk1Hw19Ukn5S7Dfi51/E74dAkCxSGzSUCDCpB15L8ws2Lq/eWInUWayM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6d92:85eb:9adc:66dd])
 (user=irogers job=sendgmr) by 2002:a25:abec:0:b0:dcc:c57c:8873 with SMTP id
 v99-20020a25abec000000b00dccc57c8873mr205275ybi.9.1707873541763; Tue, 13 Feb
 2024 17:19:01 -0800 (PST)
Date: Tue, 13 Feb 2024 17:18:00 -0800
In-Reply-To: <20240214011820.644458-1-irogers@google.com>
Message-Id: <20240214011820.644458-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214011820.644458-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v1 11/30] perf vendor events intel: Update skylake events to v58
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
Cc: Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Update skylake events to v58 released in:
https://github.com/intel/perfmon/commit/625fb7507373fef8297052c5f9af9ffe78d460c0

Improves documentation.

Event json automatically generated by:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv                 | 2 +-
 tools/perf/pmu-events/arch/x86/skylake/memory.json         | 2 +-
 tools/perf/pmu-events/arch/x86/skylake/pipeline.json       | 2 +-
 tools/perf/pmu-events/arch/x86/skylake/virtual-memory.json | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index e8bb8506c2eb..96b86d3b60ce 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -29,7 +29,7 @@ GenuineIntel-6-2A,v19,sandybridge,core
 GenuineIntel-6-8F,v1.17,sapphirerapids,core
 GenuineIntel-6-AF,v1.01,sierraforest,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
-GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v57,skylake,core
+GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v58,skylake,core
 GenuineIntel-6-55-[01234],v1.32,skylakex,core
 GenuineIntel-6-86,v1.21,snowridgex,core
 GenuineIntel-6-8[CD],v1.13,tigerlake,core
diff --git a/tools/perf/pmu-events/arch/x86/skylake/memory.json b/tools/perf/pmu-events/arch/x86/skylake/memory.json
index 588ad6059a13..f047862f9735 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/memory.json
@@ -1008,7 +1008,7 @@
         "BriefDescription": "Number of times an RTM execution aborted due to any reasons (multiple categories may count as one).",
         "EventCode": "0xC9",
         "EventName": "RTM_RETIRED.ABORTED",
-        "PEBS": "1",
+        "PEBS": "2",
         "PublicDescription": "Number of times RTM abort was triggered.",
         "SampleAfterValue": "2000003",
         "UMask": "0x4"
diff --git a/tools/perf/pmu-events/arch/x86/skylake/pipeline.json b/tools/perf/pmu-events/arch/x86/skylake/pipeline.json
index cd3e737bf4a1..fe202d1e368a 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/pipeline.json
@@ -387,7 +387,7 @@
         "Errata": "SKL091, SKL044",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.NOP",
-        "PEBS": "1",
+        "PEBS": "2",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
diff --git a/tools/perf/pmu-events/arch/x86/skylake/virtual-memory.json b/tools/perf/pmu-events/arch/x86/skylake/virtual-memory.json
index f59405877ae8..73feadaf7674 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/virtual-memory.json
@@ -205,7 +205,7 @@
         "BriefDescription": "Counts 1 per cycle for each PMH that is busy with a page walk for an instruction fetch request. EPT page walk duration are excluded in Skylake.",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_PENDING",
-        "PublicDescription": "Counts 1 per cycle for each PMH (Page Miss Handler) that is busy with a page walk for an instruction fetch request. EPT page walk duration are excluded in Skylake michroarchitecture.",
+        "PublicDescription": "Counts 1 per cycle for each PMH (Page Miss Handler) that is busy with a page walk for an instruction fetch request. EPT page walk duration are excluded in Skylake microarchitecture.",
         "SampleAfterValue": "100003",
         "UMask": "0x10"
     },
-- 
2.43.0.687.g38aa6559b0-goog


