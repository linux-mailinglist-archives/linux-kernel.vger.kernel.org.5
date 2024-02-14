Return-Path: <linux-kernel+bounces-64635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A277854112
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 323F3B28AD2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAE7C2E9;
	Wed, 14 Feb 2024 01:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dbEKKJhV"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E496B67F
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707873528; cv=none; b=aX8wF+nzfs4HMdAl83cpRg/BwyO8/DABRZNsqwBXIvlsT3JNQVf5omqUkdsfJokXqpP3aP0RenFzwBG7lkg8iQiTQCcuhs577/p6X6qxFohkHYAnK7W/HH4/tj+p1kkpNda0opFvUPBlFA6YdjTPEmapjq2mH/tbjDpzs09aVsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707873528; c=relaxed/simple;
	bh=nltx0ZNGKq2LRa/WV33HGA+n5uua2MUmMdtinvc4nvE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=laB5VpFEd6nGgzhExnHt4YNeeQbK9bsb2TlFAOBnMxgXI07muhTSvgz42Eksl/BsRGR3iFMQ/yOtCvoXybpPXVhVAof3itW2MVIqYIYC3xoFcVIdcgJlBQZuviJ5wD4Y1YB2XnujK+EQ7syMTIO+kX9i/oX58uP9wgRLGg7ZD4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dbEKKJhV; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6047fed0132so79569337b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707873525; x=1708478325; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ygYJgmMpDEHO5OJjBU2OoKhL2Mtay9wnFPAHQl6VX8=;
        b=dbEKKJhVVNE/KTybNHgtWvqEROYBT/6yAekKbDMwiqsRO/7JTB7s2S4Juf+s9H+Knw
         uKWiVQfvpxjXv9+ObJJdlxhevXHpEGKXTH2+F2IgGQABsXg/N6/l9aWcZx5JcmDbEn0h
         9puIE1jbCcnvMPKuVBasu9HPNerZ0UFgxx8LvKXbnaTpC1+XHnL1uxHLrCT7A7xsNgh+
         6wILLVEuYwsRyMnRvx/B4EyP2oI/FZJwbAsEGW25bfDcBgFQ2pQfXaAQVgB2NAx/MDR8
         0Frvkhr9N6r54l7D2ThlucuXbqQtfwtA0DSpde7fNPR1SeL29xDVtGfXRYGIpS7UmFrP
         uyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707873525; x=1708478325;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ygYJgmMpDEHO5OJjBU2OoKhL2Mtay9wnFPAHQl6VX8=;
        b=s5BfethpaXrZ7Dh5KFGmcjYtcvMjJjaEmMy+XHmh/LS2xZNCtLjfR/rkDsj3LJM5+5
         gLSLjHUFr+BsX7JyMXDt+r5r84trxL5irZM+uIyLOZUCc+hYYjVpwdYoi5LlGGfbDFBi
         zBUQ3OFUoOINxg2rECi3ScSxSJY8Nz5heU/BJlaQ/YuNzX9zQdjFJmdIyyTHJpTWard0
         LADGiZxvjwGp9muGOzpE/2nZ1BiDBkymKj7Zq/tqJyFDHB0S2iLmfN6EaoE7H2antKaE
         cjBpygRpaYfTAwPTFH37gV2G6IErmPiigqL1lbMtTVBuM03zV3rfR4JL4vDV+OORX71L
         yZyw==
X-Forwarded-Encrypted: i=1; AJvYcCXMGT7O4jIClEvB75zdl4vmLOF/nI4rt/VewCG04tKsx7nUeap+D1teOsPfB+xOwwUI/lr4/eEz8BRRutsdYc9AwSE2LrViyx6VzCTp
X-Gm-Message-State: AOJu0YygxbJDKbHbTh7zsj+o0sfqPBlVswsHiSiPEwyzlw0hR7GWQp/I
	3OCI6JGPzNWrXeL0v4NntsQsxZWpOidqo9kcUuTeKgdJbdWpwA4zr6+QQHkPRM4B4pJHrN6cWoU
	JNIl7Gw==
X-Google-Smtp-Source: AGHT+IGn9w8o47oKv0PAe9uzZx2I9jU23JD8Mqg5Ps3vgzZMw9x3chSwnuPlnMoZMlbrEzCm6gO0sbntV1Tt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6d92:85eb:9adc:66dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:1029:b0:dcc:79ab:e522 with SMTP
 id x9-20020a056902102900b00dcc79abe522mr52950ybt.11.1707873525462; Tue, 13
 Feb 2024 17:18:45 -0800 (PST)
Date: Tue, 13 Feb 2024 17:17:53 -0800
In-Reply-To: <20240214011820.644458-1-irogers@google.com>
Message-Id: <20240214011820.644458-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214011820.644458-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v1 04/30] perf vendor events intel: Update emeraldrapids
 events to v1.03
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

Update emeraldrapids events to v1.03 released in:
https://github.com/intel/perfmon/commit/c7c6f72dae07fee35d5982232829c0cd37f9e28e

Adds uncore CHA events.

Event json automatically generated by:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/emeraldrapids/uncore-cache.json  | 152 ++++++++++++++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 2 files changed, 153 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-cache.json b/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-cache.json
index bf5a511b99d1..86a8f3b7fe1d 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-cache.json
@@ -3564,6 +3564,15 @@
         "UMask": "0x10c8968201",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_CXL_EXP_LOCAL",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_CXL_EXP_LOCAL",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x20c8968201",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Inserts : DRd_Prefs issued by iA Cores targeting DDR Mem that Missed the LLC",
         "EventCode": "0x35",
@@ -3715,6 +3724,15 @@
         "UMask": "0x10ccd68201",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFDATA_CXL_EXP_LOCAL",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFDATA_CXL_EXP_LOCAL",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x20ccd68201",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Inserts; LLCPrefRFO misses from local IA",
         "EventCode": "0x35",
@@ -3741,6 +3759,15 @@
         "UMask": "0x10c8868201",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFRFO_CXL_EXP_LOCAL",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFRFO_CXL_EXP_LOCAL",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x20c8868201",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Inserts : WCiLFs issued by iA Cores targeting DDR that missed the LLC - HOMed locally",
         "EventCode": "0x35",
@@ -3891,6 +3918,15 @@
         "UMask": "0x10ccc68201",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF_CXL_EXP_LOCAL",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF_CXL_EXP_LOCAL",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x20ccc68201",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Inserts; RFO prefetch misses from local IA",
         "EventCode": "0x35",
@@ -4428,6 +4464,46 @@
         "UMask": "0x40",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "TOR Inserts for INVXTOM opcodes received from a remote socket which miss the L3 and target memory in a CXL type 3 memory expander local to this socket.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.RRQ_MISS_INVXTOM_CXL_EXP_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x20e87e8240",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts for RDCODE opcodes received from a remote socket which miss the L3 and target memory in a CXL type 3 memory expander local to this socket.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.RRQ_MISS_RDCODE_CXL_EXP_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x20e80e8240",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts for RDCUR opcodes received from a remote socket which miss the L3 and target memory in a CXL type 3 memory expander local to this socket.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.RRQ_MISS_RDCUR_CXL_EXP_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x20e8068240",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts for RDDATA opcodes received from a remote socket which miss the L3 and target memory in a CXL type 3 memory expander local to this socket.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.RRQ_MISS_RDDATA_CXL_EXP_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x20e8168240",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts for RDINVOWN_OPT opcodes received from a remote socket which miss the L3 and target memory in a CXL type 3 memory expander local to this socket.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.RRQ_MISS_RDINVOWN_OPT_CXL_EXP_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x20e8268240",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Inserts; All Snoops from Remote",
         "EventCode": "0x35",
@@ -5011,6 +5087,15 @@
         "UMask": "0x10c8968201",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PREF_CXL_EXP_LOCAL",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PREF_CXL_EXP_LOCAL",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x20c8968201",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Occupancy : DRd_Prefs issued by iA Cores targeting DDR Mem that Missed the LLC",
         "EventCode": "0x36",
@@ -5162,6 +5247,15 @@
         "UMask": "0x10ccd68201",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFDATA_CXL_EXP_LOCAL",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFDATA_CXL_EXP_LOCAL",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x20ccd68201",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Occupancy; LLCPrefRFO misses from local IA",
         "EventCode": "0x36",
@@ -5188,6 +5282,15 @@
         "UMask": "0x10c8868201",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFRFO_CXL_EXP_LOCAL",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFRFO_CXL_EXP_LOCAL",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x20c8868201",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Occupancy : WCiLFs issued by iA Cores targeting DDR that missed the LLC - HOMed locally",
         "EventCode": "0x36",
@@ -5338,6 +5441,15 @@
         "UMask": "0x10ccc68201",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_PREF_CXL_EXP_LOCAL",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_PREF_CXL_EXP_LOCAL",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x20ccc68201",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Occupancy; RFO prefetch misses from local IA",
         "EventCode": "0x36",
@@ -5841,6 +5953,46 @@
         "UMask": "0x40",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "TOR Occupancy for INVXTOM opcodes received from a remote socket which miss the L3 and target memory in a CXL type 3 memory expander local to this socket.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.RRQ_MISS_INVXTOM_CXL_EXP_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x20e87e8240",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for RDCODE opcodes received from a remote socket which miss the L3 and target memory in a CXL type 3 memory expander local to this socket.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.RRQ_MISS_RDCODE_CXL_EXP_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x20e80e8240",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for RDCUR opcodes received from a remote socket which miss the L3 and target memory in a CXL type 3 memory expander local to this socket.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.RRQ_MISS_RDCUR_CXL_EXP_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x20e8068240",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for RDDATA opcodes received from a remote socket which miss the L3 and target memory in a CXL type 3 memory expander local to this socket.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.RRQ_MISS_RDDATA_CXL_EXP_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x20e8168240",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for RDINVOWN_OPT opcodes received from a remote socket which miss the L3 and target memory in a CXL type 3 memory expander local to this socket.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.RRQ_MISS_RDINVOWN_OPT_CXL_EXP_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x20e8268240",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Occupancy; All Snoops from Remote",
         "EventCode": "0x36",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 7b30c0eb036a..42cbbe35b52e 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -7,7 +7,7 @@ GenuineIntel-6-56,v11,broadwellde,core
 GenuineIntel-6-4F,v22,broadwellx,core
 GenuineIntel-6-55-[56789ABCDEF],v1.20,cascadelakex,core
 GenuineIntel-6-9[6C],v1.04,elkhartlake,core
-GenuineIntel-6-CF,v1.02,emeraldrapids,core
+GenuineIntel-6-CF,v1.03,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-B6,v1.00,grandridge,core
-- 
2.43.0.687.g38aa6559b0-goog


