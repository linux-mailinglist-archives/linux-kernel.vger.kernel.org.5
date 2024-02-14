Return-Path: <linux-kernel+bounces-64643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 715BE854121
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 189C628BACD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0721759E;
	Wed, 14 Feb 2024 01:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="1h+f7mWs"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BD311713
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707873552; cv=none; b=n9jGWyxyGflaczl7PPANogPbrp+iWIltTSfAya7NOaxptBFxYpsK7p4RL4k5DzJcNB9d102g7Zn6Qi/dn4bg4KKPg7Y6GS8NnkSbJrpyQk2iMwVePXQsf0L1xcN3GQIpQu1E7oMm65nywm1N8Jqwg+e00bgpGX8BXS2Zy1qugJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707873552; c=relaxed/simple;
	bh=RJWLoFNic9FFHxX3wclfGELYgA/nzl3Y9/cCtS1AhtU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=TLosxC/ooddfMX37KeIEfh0UnzvkvL7nCn7dBvD2ud5qk7OnUJLAIh46JKVoKQifB6dJ3waja3UVxihQsJUxc3WzjfkCxNffEeJII15PiTZoIbW6Fy/XGG9uSrIly0a9y2+8uVYdDLR/wukAlQXuETYIFUhXXTEXySjpa9EllEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1h+f7mWs; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc746178515so8789707276.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707873539; x=1708478339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCpeUxFgAZY5vjACKxMZsljG8kmmxjZPiP4yYGwqNjU=;
        b=1h+f7mWskuypzmdz8p5wFVsibHB/Vi9e6zL/ynQr3kflhTkd2VY6gV9QseEgZyDJAR
         lL8Ult+11+zKi4I+GPjKLMp0XsleLaEZdOT9HWQRTU4lzKN7uaFZDgLWq5y1m1Ny5w39
         0yqkrQDygvh2fSJNqUhnOzYZjdT+1hppR4zcHtgl2z8RkUOk1kmP0nWAZ+N7XrwFS2+4
         leQDHhgJQFX9UXWieqh+NJxgSz+OIty0KCp/+lCnuiQAupNXfZ1LnCWqdRtFvEUE30GE
         qvTkg+UJQbAA9aXlDhudj6WxDPmV4xpGg+BA+IZVJpBqN7r9SqHD/BiDbKBwyUyTJxqx
         R7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707873539; x=1708478339;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SCpeUxFgAZY5vjACKxMZsljG8kmmxjZPiP4yYGwqNjU=;
        b=H1psRkNT1EvhNp8Pj5Z5Etzc8qh8wp2o3Oj746Yz7+uHw/1gfc5hgZZEIweSaZvU1I
         LQZc941N7CB0KpS+LNvL91YDZfv99PsuHkVU+98oNOUgmDEIiWIvEYE+VNZoFGOZxLwq
         aHE/hA1LAhtbxMbY74ooFONR+Jw4ojOxmbDeUbV3nytPLGCV+FRMkdNHynXtKU7Cl+zs
         TdDdaxNOIGZIIOVBMli093j6U9LoIYORCH9CCMVaDtIkDBBmu15iZ67xbruVkDNti5EM
         Yolds5V4TcJ7oCj901IvNOmNtxmEIYw1iUgIovfkrCUdrM7E5ZF8XZsxSKeRVsM/ApUK
         rm/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbT9HocEU610gHXN9XmtRgHSHdwvMfT3OU31YVgHAlGWFRE5eZx9n4eOjSYMj64V8OAIy+8qC+Iy09UymGthOtEHVmMxWwnP3d0aOY
X-Gm-Message-State: AOJu0YzLh4AgtO/ERk0M/Ml9HgB7A3UvYWiBsf+xHLmxxKOc6DB4hQ4i
	UnECiYU5nOhb52zg3gw7iFQ1iOQBMmJ1laHyoAtwKkmXkYLnRYTkYGs39Y8ArxO7RAjasjix75g
	l0apHyg==
X-Google-Smtp-Source: AGHT+IGH9/bD2vRrxeUAgG6f7OQHTwyP/Ic0t6qh1mjZ/WIdXrAP5f0Z0aSRSwP4iRaRVgHoUM1zCRskMQvW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6d92:85eb:9adc:66dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:1027:b0:dc2:4ab7:3d89 with SMTP
 id x7-20020a056902102700b00dc24ab73d89mr272968ybt.1.1707873539498; Tue, 13
 Feb 2024 17:18:59 -0800 (PST)
Date: Tue, 13 Feb 2024 17:17:59 -0800
In-Reply-To: <20240214011820.644458-1-irogers@google.com>
Message-Id: <20240214011820.644458-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214011820.644458-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v1 10/30] perf vendor events intel: Update sierraforst events
 to v1.01
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
Content-Transfer-Encoding: quoted-printable

Update sierraforest events to v1.01 released in:
https://github.com/intel/perfmon/commit/582bca24aa0d742306cd4697c5bd1b1b529=
aa3ce

Adds the majority of core and uncore events.

Event json automatically generated by:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |    2 +-
 .../arch/x86/sierraforest/cache.json          |  185 ++
 .../arch/x86/sierraforest/floating-point.json |   68 +
 .../arch/x86/sierraforest/frontend.json       |   16 +
 .../arch/x86/sierraforest/memory.json         |   66 +
 .../arch/x86/sierraforest/other.json          |   16 +
 .../arch/x86/sierraforest/pipeline.json       |  360 +++
 .../arch/x86/sierraforest/uncore-cache.json   | 2853 +++++++++++++++++
 .../arch/x86/sierraforest/uncore-cxl.json     |   10 +
 .../x86/sierraforest/uncore-interconnect.json | 1228 +++++++
 .../arch/x86/sierraforest/uncore-io.json      | 1634 ++++++++++
 .../arch/x86/sierraforest/uncore-memory.json  |  385 +++
 .../arch/x86/sierraforest/uncore-power.json   |   10 +
 .../arch/x86/sierraforest/virtual-memory.json |  113 +-
 14 files changed, 6942 insertions(+), 4 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/floating-po=
int.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/uncore-cach=
e.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/uncore-cxl.=
json
 create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/uncore-inte=
rconnect.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/uncore-io.j=
son
 create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/uncore-memo=
ry.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/uncore-powe=
r.json

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index be9f342b3206..e8bb8506c2eb 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -27,7 +27,7 @@ GenuineIntel-6-2E,v4,nehalemex,core
 GenuineIntel-6-A7,v1.02,rocketlake,core
 GenuineIntel-6-2A,v19,sandybridge,core
 GenuineIntel-6-8F,v1.17,sapphirerapids,core
-GenuineIntel-6-AF,v1.00,sierraforest,core
+GenuineIntel-6-AF,v1.01,sierraforest,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v57,skylake,core
 GenuineIntel-6-55-[01234],v1.32,skylakex,core
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/cache.json b/tools=
/perf/pmu-events/arch/x86/sierraforest/cache.json
index 7f0dc65a55d2..f937ba0e50e1 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/cache.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/cache.json
@@ -15,6 +15,148 @@
         "SampleAfterValue": "200003",
         "UMask": "0x4f"
     },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to an instruction cache or TLB miss.",
+        "EventCode": "0x35",
+        "EventName": "MEM_BOUND_STALLS_IFETCH.ALL",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x7f"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to an instruction cache or TLB miss which hit in the L2 cache.",
+        "EventCode": "0x35",
+        "EventName": "MEM_BOUND_STALLS_IFETCH.L2_HIT",
+        "PublicDescription": "Counts the number of cycles the core is stal=
led due to an instruction cache or Translation Lookaside Buffer (TLB) miss =
which hit in the L2 cache.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to an icache or itlb miss which hit in the LLC.",
+        "EventCode": "0x35",
+        "EventName": "MEM_BOUND_STALLS_IFETCH.LLC_HIT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x6"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to an icache or itlb miss which missed all the caches.=
",
+        "EventCode": "0x35",
+        "EventName": "MEM_BOUND_STALLS_IFETCH.LLC_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x78"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to an L1 demand load miss.",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS_LOAD.ALL",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x7f"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load which hit in the L2 cache.",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS_LOAD.L2_HIT",
+        "PublicDescription": "Counts the number of cycles a core is stalle=
d due to a demand load which hit in the L2 cache.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to a demand load miss which hit in the LLC.",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS_LOAD.LLC_HIT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x6"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to a demand load miss which missed all the local cache=
s.",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS_LOAD.LLC_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x78"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired that mi=
ss the L3 cache and hit in DRAM",
+        "EventCode": "0xd3",
+        "EventName": "MEM_LOAD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM",
+        "PEBS": "1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired that hi=
t the L1 data cache.",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L1_HIT",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired that mi=
ss in the L1 data cache.",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L1_MISS",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired that hi=
t in the L2 cache.",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L2_HIT",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired that mi=
ss in the L2 cache.",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L2_MISS",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired that hi=
t in the L3 cache.",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L3_HIT",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0x1c"
+    },
+    {
+        "BriefDescription": "Counts the number of loads that hit in a writ=
e combining buffer (WCB), excluding the first load that caused the WCB to a=
llocate.",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.WCB_HIT",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that uops are blo=
cked for any of the following reasons:  load buffer, store buffer or RSV fu=
ll.",
+        "EventCode": "0x04",
+        "EventName": "MEM_SCHEDULER_BLOCK.ALL",
+        "SampleAfterValue": "20003",
+        "UMask": "0x7"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that uops are blo=
cked due to a load buffer full condition.",
+        "EventCode": "0x04",
+        "EventName": "MEM_SCHEDULER_BLOCK.LD_BUF",
+        "SampleAfterValue": "20003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that uops are blo=
cked due to an RSV full condition.",
+        "EventCode": "0x04",
+        "EventName": "MEM_SCHEDULER_BLOCK.RSV",
+        "SampleAfterValue": "20003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that uops are blo=
cked due to a store buffer full condition.",
+        "EventCode": "0x04",
+        "EventName": "MEM_SCHEDULER_BLOCK.ST_BUF",
+        "SampleAfterValue": "20003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts the number of load ops retired.",
         "Data_LA": "1",
@@ -143,6 +285,42 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
+    {
+        "BriefDescription": "Counts the number of load uops retired that p=
erformed one or more locks",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOCK_LOADS",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0x21"
+    },
+    {
+        "BriefDescription": "Counts the number of memory uops retired that=
 were splits.",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.SPLIT",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0x43"
+    },
+    {
+        "BriefDescription": "Counts the number of retired split load uops.=
",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0x41"
+    },
+    {
+        "BriefDescription": "Counts the number of retired split store uops=
",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.SPLIT_STORES",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0x42"
+    },
     {
         "BriefDescription": "Counts the number of  stores uops retired sam=
e as MEM_UOPS_RETIRED.ALL_STORES",
         "Data_LA": "1",
@@ -151,5 +329,12 @@
         "PEBS": "2",
         "SampleAfterValue": "1000003",
         "UMask": "0x6"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to an icache miss",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.ICACHE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/floating-point.jso=
n b/tools/perf/pmu-events/arch/x86/sierraforest/floating-point.json
new file mode 100644
index 000000000000..00c9a8ae0f53
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/floating-point.json
@@ -0,0 +1,68 @@
+[
+    {
+        "BriefDescription": "Counts the number of cycles when any of the f=
loating point dividers are active.",
+        "CounterMask": "1",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.FPDIV_ACTIVE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of all types of floating po=
int operations per uop with all default weighting",
+        "EventCode": "0xc8",
+        "EventName": "FP_FLOPS_RETIRED.ALL",
+        "PEBS": "1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to FP_FLOPS_RETIRED.FP64]",
+        "Deprecated": "1",
+        "EventCode": "0xc8",
+        "EventName": "FP_FLOPS_RETIRED.DP",
+        "PEBS": "1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of floating point operation=
s that produce 32 bit single precision results [This event is alias to FP_F=
LOPS_RETIRED.SP]",
+        "EventCode": "0xc8",
+        "EventName": "FP_FLOPS_RETIRED.FP32",
+        "PEBS": "1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of floating point operation=
s that produce 64 bit double precision results [This event is alias to FP_F=
LOPS_RETIRED.DP]",
+        "EventCode": "0xc8",
+        "EventName": "FP_FLOPS_RETIRED.FP64",
+        "PEBS": "1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to FP_FLOPS_RETIRED.FP32]",
+        "Deprecated": "1",
+        "EventCode": "0xc8",
+        "EventName": "FP_FLOPS_RETIRED.SP",
+        "PEBS": "1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of floating point operation=
s retired that required microcode assist.",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.FP_ASSIST",
+        "PublicDescription": "Counts the number of floating point operatio=
ns retired that required microcode assist, which is not a reflection of the=
 number of FP operations, instructions or uops.",
+        "SampleAfterValue": "20003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the number of floating point divide uo=
ps retired (x87 and sse, including x87 sqrt).",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.FPDIV",
+        "PEBS": "1",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/frontend.json b/to=
ols/perf/pmu-events/arch/x86/sierraforest/frontend.json
index be8f1c7e195c..356d36aecc81 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/frontend.json
@@ -1,4 +1,20 @@
 [
+    {
+        "BriefDescription": "Counts the total number of BACLEARS due to al=
l branch types including conditional and unconditional jumps, returns, and =
indirect branches.",
+        "EventCode": "0xe6",
+        "EventName": "BACLEARS.ANY",
+        "PublicDescription": "Counts the total number of BACLEARS, which o=
ccur when the Branch Target Buffer (BTB) prediction or lack thereof, was co=
rrected by a later branch predictor in the frontend.  Includes BACLEARS due=
 to all branch types including conditional and unconditional jumps, returns=
, and indirect branches.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were tagged because empty issue slots were seen before the uop due to ITL=
B miss",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.ITLB_MISS",
+        "PEBS": "1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
     {
         "BriefDescription": "Counts every time the code stream enters into=
 a new cache line by walking sequential from the previous line or being red=
irected by a jump.",
         "EventCode": "0x80",
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/memory.json b/tool=
s/perf/pmu-events/arch/x86/sierraforest/memory.json
index 79d8af45100c..e0ce2decc805 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/memory.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/memory.json
@@ -1,4 +1,70 @@
 [
+    {
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to any number of reasons, incl=
uding an L1 miss, WCB full, pagewalk, store address block or store data blo=
ck, on a load that retires.",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.ANY_AT_RET",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xff"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to a core bound stall includin=
g a store address match, a DTLB miss or a page walk that detains the load f=
rom retiring.",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.L1_BOUND_AT_RET",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xf4"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to a DL1 =
miss.",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.L1_MISS_AT_RET",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x81"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to other =
block cases.",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.OTHER_AT_RET",
+        "PublicDescription": "Counts the number of cycles that the head (o=
ldest load) of the load buffer and retirement are both stalled due to other=
 block cases such as pipeline conflicts, fences, etc.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xc0"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to a page=
walk.",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.PGWALK_AT_RET",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xa0"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to a stor=
e address match.",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.ST_ADDR_AT_RET",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x84"
+    },
+    {
+        "BriefDescription": "Counts the number of machine clears due to me=
mory ordering caused by a snoop from an external agent. Does not count inte=
rnally generated machine clears such as those due to memory disambiguation.=
",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
+        "SampleAfterValue": "20003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts misaligned loads that are 4K page spli=
ts.",
+        "EventCode": "0x13",
+        "EventName": "MISALIGN_MEM_REF.LOAD_PAGE_SPLIT",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts misaligned stores that are 4K page spl=
its.",
+        "EventCode": "0x13",
+        "EventName": "MISALIGN_MEM_REF.STORE_PAGE_SPLIT",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0x4"
+    },
     {
         "BriefDescription": "Counts demand data reads that were not suppli=
ed by the L3 cache.",
         "EventCode": "0xB7",
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/other.json b/tools=
/perf/pmu-events/arch/x86/sierraforest/other.json
index 2414f6ff53b0..70a9da7e97df 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/other.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/other.json
@@ -1,4 +1,13 @@
 [
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to MISC_RETIRED.LBR_INSERTS]",
+        "Deprecated": "1",
+        "EventCode": "0xe4",
+        "EventName": "LBR_INSERTS.ANY",
+        "PEBS": "1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand data reads that have any type o=
f response.",
         "EventCode": "0xB7",
@@ -16,5 +25,12 @@
         "MSRValue": "0x10002",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots in a UMWAIT =
or TPAUSE instruction where no uop issues due to the instruction putting th=
e CPU into the C0.1 activity state.",
+        "EventCode": "0x75",
+        "EventName": "SERIALIZATION.C01_MS_SCB",
+        "SampleAfterValue": "200003",
+        "UMask": "0x4"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/pipeline.json b/to=
ols/perf/pmu-events/arch/x86/sierraforest/pipeline.json
index 41212957ef21..ba9843110f07 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/pipeline.json
@@ -1,4 +1,12 @@
 [
+    {
+        "BriefDescription": "Counts the number of cycles when any of the d=
ividers are active.",
+        "CounterMask": "1",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.DIV_ACTIVE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3"
+    },
     {
         "BriefDescription": "Counts the total number of branch instruction=
s retired for all branch types.",
         "EventCode": "0xc4",
@@ -7,6 +15,71 @@
         "PublicDescription": "Counts the total number of instructions in w=
hich the instruction pointer (IP) of the processor is resteered due to a br=
anch instruction and the branch instruction successfully retires.  All bran=
ch type instructions are accounted for.",
         "SampleAfterValue": "200003"
     },
+    {
+        "BriefDescription": "Counts the number of retired JCC (Jump on Con=
ditional Code) branch instructions retired, includes both taken and not tak=
en branches.",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0x7e"
+    },
+    {
+        "BriefDescription": "Counts the number of taken JCC (Jump on Condi=
tional Code) branch instructions retired.",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND_TAKEN",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfe"
+    },
+    {
+        "BriefDescription": "Counts the number of far branch instructions =
retired, includes far jump, far call and return, and interrupt call and ret=
urn.",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.FAR_BRANCH",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xbf"
+    },
+    {
+        "BriefDescription": "Counts the number of near indirect JMP and ne=
ar indirect CALL branch instructions retired.",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.INDIRECT",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xeb"
+    },
+    {
+        "BriefDescription": "Counts the number of near indirect CALL branc=
h instructions retired.",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.INDIRECT_CALL",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfb"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.INDIRECT_CALL",
+        "Deprecated": "1",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.IND_CALL",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfb"
+    },
+    {
+        "BriefDescription": "Counts the number of near CALL branch instruc=
tions retired.",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_CALL",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xf9"
+    },
+    {
+        "BriefDescription": "Counts the number of near RET branch instruct=
ions retired.",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_RETURN",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xf7"
+    },
     {
         "BriefDescription": "Counts the total number of mispredicted branc=
h instructions retired for all branch types.",
         "EventCode": "0xc5",
@@ -15,6 +88,54 @@
         "PublicDescription": "Counts the total number of mispredicted bran=
ch instructions retired.  All branch type instructions are accounted for.  =
Prediction of the branch target address enables the processor to begin exec=
uting instructions before the non-speculative execution path is known. The =
branch prediction unit (BPU) predicts the target address based on the instr=
uction pointer (IP) of the branch and on the execution path through which e=
xecution reached this IP.    A branch misprediction occurs when the predict=
ion is wrong, and results in discarding all instructions executed in the sp=
eculative path and re-fetching from the correct path.",
         "SampleAfterValue": "200003"
     },
+    {
+        "BriefDescription": "Counts the number of mispredicted JCC (Jump o=
n Conditional Code) branch instructions retired.",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0x7e"
+    },
+    {
+        "BriefDescription": "Counts the number of mispredicted taken JCC (=
Jump on Conditional Code) branch instructions retired.",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_TAKEN",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfe"
+    },
+    {
+        "BriefDescription": "Counts the number of mispredicted near indire=
ct JMP and near indirect CALL branch instructions retired.",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.INDIRECT",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xeb"
+    },
+    {
+        "BriefDescription": "Counts the number of mispredicted near indire=
ct CALL branch instructions retired.",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.INDIRECT_CALL",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfb"
+    },
+    {
+        "BriefDescription": "Counts the number of mispredicted near taken =
branch instructions retired.",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Counts the number of mispredicted near RET br=
anch instructions retired.",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.RETURN",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xf7"
+    },
     {
         "BriefDescription": "Fixed Counter: Counts the number of unhalted =
core clock cycles",
         "EventName": "CPU_CLK_UNHALTED.CORE",
@@ -67,6 +188,66 @@
         "PEBS": "1",
         "SampleAfterValue": "2000003"
     },
+    {
+        "BriefDescription": "Counts the number of retired loads that are b=
locked because it initially appears to be store forward blocked, but subseq=
uently is shown not to be blocked based on 4K alias check.",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.ADDRESS_ALIAS",
+        "PEBS": "1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the number of retired loads that are b=
locked because its address exactly matches an older store whose data is not=
 ready.",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.DATA_UNKNOWN",
+        "PEBS": "1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of retired loads that are b=
locked because its address partially overlapped with an older store.",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.STORE_FORWARD",
+        "PEBS": "1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of machine clears due to me=
mory ordering in which an internal load passes an older store within the sa=
me CPU.",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.DISAMBIGUATION",
+        "SampleAfterValue": "20003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts the number of machine clears due to a =
page fault.  Counts both I-Side and D-Side (Loads/Stores) page faults.  A p=
age fault occurs when either the page is not present, or an access violatio=
n occurs.",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.PAGE_FAULT",
+        "SampleAfterValue": "20003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Counts the number of machine clears that flus=
h the pipeline and restart the machine with the use of microcode due to SMC=
, MEMORY_ORDERING, FP_ASSISTS, PAGE_FAULT, DISAMBIGUATION, and FPC_VIRTUAL_=
TRAP.",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.SLOW",
+        "SampleAfterValue": "20003",
+        "UMask": "0x6f"
+    },
+    {
+        "BriefDescription": "Counts the number of machine clears due to pr=
ogram modifying data (self modifying code) within 1K of a recently fetched =
code page.",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.SMC",
+        "SampleAfterValue": "20003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of Last Branch Record (LBR)=
 entries. Requires LBRs to be enabled and configured in IA32_LBR_CTL. [This=
 event is alias to LBR_INSERTS.ANY]",
+        "EventCode": "0xe4",
+        "EventName": "MISC_RETIRED.LBR_INSERTS",
+        "PEBS": "1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend because allocation is stalled due to a mispredict=
ed jump or a machine clear.",
         "EventCode": "0x73",
@@ -74,23 +255,202 @@
         "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend because allocation is stalled due to a mis=
predicted jump or a machine clear. Only issue slots wasted due to fast nuke=
s such as memory ordering nukes are counted. Other nukes are not accounted =
for. Counts all issue slots blocked during this recovery window, including =
relevant microcode flows, and while uops are not yet available in the instr=
uction queue (IQ) or until an FE_BOUND event occurs besides OTHER and CISC.=
 Also includes the issue slots that were consumed by the backend but were t=
hrown away because they were younger than the mispredict or machine clear."=
,
         "SampleAfterValue": "1000003"
     },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to Fast Nukes such as  Memory Ord=
ering Machine clears and MRN nukes",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.FASTNUKE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a mach=
ine clear (nuke) of any kind including memory ordering and memory disambigu=
ation.",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to Branch Mispredict",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.MISPREDICT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to a machine clear (nuke).",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.NUKE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts the number of retirement slots not con=
sumed due to backend stalls",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.ALL",
         "SampleAfterValue": "1000003"
     },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to due to certain allocation rest=
rictions",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to memory reservation stall (sche=
duler not being able to accept another uop).  This could be caused by RSV f=
ull or load/store buffer block.",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.MEM_SCHEDULER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to IEC and FPC RAT stalls - which=
 can be due to the FIQ and IEC reservation station stall (integer, FP and S=
IMD scheduler not being able to accept another uop. )",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to mrbl stall.  A 'marble' refers=
 to a physical register file entry, also known as the physical destination =
(PDST).",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.REGISTER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to ROB full",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.REORDER_BUFFER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to iq/jeu scoreboards or ms scb",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.SERIALIZATION",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
     {
         "BriefDescription": "Counts the number of retirement slots not con=
sumed due to front end stalls",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.ALL",
         "SampleAfterValue": "1000003"
     },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to BAClear",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.BRANCH_DETECT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to BTClear",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.BRANCH_RESTEER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to ms",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.CISC",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to decode stall",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.DECODE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to frontend bandwidth restricti=
ons due to decode, predecode, cisc, and other limitations.",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8d"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to latency related stalls inclu=
ding BACLEARs, BTCLEARs, ITLB misses, and ICache misses.",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.FRONTEND_LATENCY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x72"
+    },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to TOPDOWN_FE_BOUND.ITLB_MISS]",
+        "Deprecated": "1",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.ITLB",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to itlb miss [This event is ali=
as to TOPDOWN_FE_BOUND.ITLB]",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.ITLB_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend that do not categorize into any oth=
er common frontend stall",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.OTHER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to predecode wrong",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.PREDECODE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
     {
         "BriefDescription": "Counts the number of consumed retirement slot=
s.  Similar to UOPS_RETIRED.ALL",
         "EventCode": "0x72",
         "EventName": "TOPDOWN_RETIRING.ALL",
         "PEBS": "1",
         "SampleAfterValue": "1000003"
+    },
+    {
+        "BriefDescription": "Counts the number of uops issued by the front=
 end every cycle.",
+        "EventCode": "0x0e",
+        "EventName": "UOPS_ISSUED.ANY",
+        "PublicDescription": "Counts the number of uops issued by the fron=
t end every cycle. When 4-uops are requested and only 2-uops are delivered,=
 the event counts 2.  Uops_issued correlates to the number of ROB entries. =
 If uop takes 2 ROB slots it counts as 2 uops_issued.",
+        "SampleAfterValue": "1000003"
+    },
+    {
+        "BriefDescription": "Counts the total number of uops retired.",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.ALL",
+        "PEBS": "1",
+        "SampleAfterValue": "2000003"
+    },
+    {
+        "BriefDescription": "Counts the number of integer divide uops reti=
red.",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.IDIV",
+        "PEBS": "1",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts the number of uops that are from the c=
omplex flows issued by the micro-sequencer (MS).  This includes uops from f=
lows due to complex instructions, faults, assists, and inserted flows.",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.MS",
+        "PEBS": "1",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of x87 uops retired, includ=
es those in ms flows",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.X87",
+        "PEBS": "1",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-cache.json =
b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-cache.json
new file mode 100644
index 000000000000..a3aafbbc3484
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-cache.json
@@ -0,0 +1,2853 @@
+[
+    {
+        "BriefDescription": "Clockticks for CMS units attached to CHA",
+        "EventCode": "0x01",
+        "EventName": "UNC_CHACMS_CLOCKTICKS",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "PublicDescription": "UNC_CHACMS_CLOCKTICKS",
+        "Unit": "CHACMS"
+    },
+    {
+        "BriefDescription": "Number of CHA clock cycles while the event is=
 enabled",
+        "EventCode": "0x01",
+        "EventName": "UNC_CHA_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "Clockticks of the uncore caching and home ag=
ent (CHA)",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts transactions that looked into the mult=
i-socket cacheline Directory state, and therefore did not send a snoop beca=
use the Directory indicated it was not needed.",
+        "EventCode": "0x53",
+        "EventName": "UNC_CHA_DIR_LOOKUP.NO_SNP",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts  transactions that looked into the mul=
ti-socket cacheline Directory state, and sent one or more snoops, because t=
he Directory indicated it was needed.",
+        "EventCode": "0x53",
+        "EventName": "UNC_CHA_DIR_LOOKUP.SNP",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts only multi-socket cacheline Directory =
state updates memory writes issued from the HA pipe. This does not include =
memory write requests which are for I (Invalid) or E (Exclusive) cachelines=
",
+        "EventCode": "0x54",
+        "EventName": "UNC_CHA_DIR_UPDATE.HA",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts only multi-socket cacheline Directory =
state updates due to memory writes issued from the TOR pipe which are the r=
esult of remote transaction hitting the SF/LLC and returning data Core2Core=
 This does not include memory write requests which are for I (Invalid) or =
E (Exclusive) cachelines.",
+        "EventCode": "0x54",
+        "EventName": "UNC_CHA_DIR_UPDATE.TOR",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Distress signal assertion for dynamic prefetc=
h throttle (DPT).  Threshold for distress signal assertion reached in TOR o=
r IRQ (immediate cause for triggering).",
+        "EventCode": "0x59",
+        "EventName": "UNC_CHA_DISTRESS_ASSERTED.DPT_ANY",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x3",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Distress signal assertion for dynamic prefetc=
h throttle (DPT).  Threshold for distress signal assertion reached in IRQ (=
immediate cause for triggering).",
+        "EventCode": "0x59",
+        "EventName": "UNC_CHA_DISTRESS_ASSERTED.DPT_IRQ",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Distress signal assertion for dynamic prefetc=
h throttle (DPT).  Threshold for distress signal assertion reached in TOR (=
immediate cause for triggering).",
+        "EventCode": "0x59",
+        "EventName": "UNC_CHA_DISTRESS_ASSERTED.DPT_TOR",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts when a normal (Non-Isochronous) full l=
ine write is issued from the CHA to the any of the memory controller channe=
ls.",
+        "EventCode": "0x5b",
+        "EventName": "UNC_CHA_IMC_WRITES_COUNT.FULL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA to iMC Full Line Writes Issued : ISOCH Fu=
ll Line : Counts the total number of full line writes issued from the HA in=
to the memory controller.",
+        "EventCode": "0x5b",
+        "EventName": "UNC_CHA_IMC_WRITES_COUNT.FULL_PRIORITY",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA to iMC Full Line Writes Issued : Partial =
Non-ISOCH : Counts the total number of full line writes issued from the HA =
into the memory controller.",
+        "EventCode": "0x5b",
+        "EventName": "UNC_CHA_IMC_WRITES_COUNT.PARTIAL",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA to iMC Full Line Writes Issued : ISOCH Pa=
rtial : Counts the total number of full line writes issued from the HA into=
 the memory controller.",
+        "EventCode": "0x5b",
+        "EventName": "UNC_CHA_IMC_WRITES_COUNT.PARTIAL_PRIORITY",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: All Requests to Remotely Homed=
 Memory",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.ALL_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : All transactions from Remote=
 Agents",
+        "UMask": "0x17e0ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: CRd Requests",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.CODE",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : CRd Requests",
+        "UMask": "0x1bd0ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Read Requests and Read Prefetc=
hes",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.DATA_RD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CHAFilter0[24:=
21,17] bits correspond to [FMESI] state. Read transactions",
+        "UMask": "0x1bc1ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Read Requests, Read Prefetches=
, and Snoops",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.DATA_READ_ALL",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : Data Reads",
+        "UMask": "0x1fc1ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Read Requests to Locally Homed=
 Memory",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.DATA_READ_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : Demand Data Reads, Core and =
LLC prefetches",
+        "UMask": "0x841ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Read Requests, Read Prefetches=
, and Snoops which miss the Cache",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.DATA_READ_MISS",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : Data Read Misses",
+        "UMask": "0x1fc101",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: All Requests to Locally Homed =
Memory",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.LOCALLY_HOMED_ADDRESS",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : Transactions homed locally",
+        "UMask": "0xbdfff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Code Read Requests and Code Re=
ad Prefetches to Locally Homed Memory",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_CODE",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : CRd Requests",
+        "UMask": "0x19d0ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Read Requests and Read Prefetc=
hes to Locally Homed Memory",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_DATA_RD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CHAFilter0[24:=
21,17] bits correspond to [FMESI] state. Read transactions",
+        "UMask": "0x19c1ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Code Read Requests to Locally =
Homed Memory",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_DMND_CODE",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : CRd Requests",
+        "UMask": "0x1850ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Read Requests to Locally Homed=
 Memory",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_DMND_DATA_RD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CHAFilter0[24:=
21,17] bits correspond to [FMESI] state. Read transactions",
+        "UMask": "0x1841ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: RFO Requests to Locally Homed =
Memory",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_DMND_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : RFO Requests",
+        "UMask": "0x1848ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: LLC Prefetch Requests to Local=
ly Homed Memory",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_LLC_PF",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CHAFilter0[24:=
21,17] bits correspond to [FMESI] state. Read transactions",
+        "UMask": "0x189dff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: All Prefetches to Locally Home=
d Memory",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_PF",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CHAFilter0[24:=
21,17] bits correspond to [FMESI] state. Read transactions",
+        "UMask": "0x199dff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Code Prefetches to Locally Hom=
ed Memory",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_PF_CODE",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : CRd Requests",
+        "UMask": "0x1910ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Read Prefetches to Locally Hom=
ed Memory",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_PF_DATA_RD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CHAFilter0[24:=
21,17] bits correspond to [FMESI] state. Read transactions",
+        "UMask": "0x1981ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: RFO Prefetches to Locally Home=
d Memory",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_PF_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : RFO Requests",
+        "UMask": "0x1908ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: RFO Requests and RFO Prefetche=
s to Locally Homed Memory",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : RFO Requests",
+        "UMask": "0x19c8ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: All Requests to Remotely Homed=
 Memory",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.REMOTELY_HOMED_ADDRESS",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : Transactions homed remotely =
: Counts the number of times the LLC was accessed - this includes code, dat=
a, prefetches and hints coming from L2.  This has numerous filters availabl=
e.  Note the non-standard filtering equation.  This event will count reques=
ts that lookup the cache multiple times with multiple increments.  One must=
 ALWAYS set umask bit 0 and select a state or states to match.  Otherwise, =
the event will count nothing. : Transaction whose address resides in a remo=
te MC",
+        "UMask": "0x15dfff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Code Read/Prefetch Requests fr=
om a Remote Socket",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.REMOTE_CODE",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : CRd Requests",
+        "UMask": "0x1a10ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Data Read/Prefetch Requests fr=
om a Remote Socket",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.REMOTE_DATA_RD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CHAFilter0[24:=
21,17] bits correspond to [FMESI] state. Read transactions",
+        "UMask": "0x1a01ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: RFO Requests/Prefetches from a=
 Remote Socket",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.REMOTE_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : RFO Requests",
+        "UMask": "0x1a08ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Snoop Requests from a Remote S=
ocket",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.REMOTE_SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed",
+        "UMask": "0x1c19ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: All RFO and RFO Prefetches",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.RFO",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : All RFOs - Demand and Prefet=
ches",
+        "UMask": "0x1bc8ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: RFO Requests and RFO Prefetche=
s to Locally Homed Memory",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.RFO_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : Locally HOMed RFOs - Demand =
and Prefetches",
+        "UMask": "0x9c8ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Writes to Locally Homed Memory=
 (includes writebacks from L1/L2)",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.WRITE_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : Writes",
+        "UMask": "0x842ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Writes to Remotely Homed Memor=
y (includes writebacks from L1/L2)",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.WRITE_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : Remote Writes",
+        "UMask": "0x17c2ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of lines that were victimiz=
ed on a fill.  This can be filtered by the state that the line was in.",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : All Lines Victimized",
+        "UMask": "0xf",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized : IA traffic : Counts the nu=
mber of lines that were victimized on a fill.  This can be filtered by the =
state that the line was in.",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.IA",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized : IO traffic : Counts the nu=
mber of lines that were victimized on a fill.  This can be filtered by the =
state that the line was in.",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.IO",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of lines that were victimiz=
ed on a fill.  This can be filtered by the state that the line was in.",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.LOCAL_ALL",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : Local - All Lines",
+        "UMask": "0x200f",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized : Counts the number of lines=
 that were victimized on a fill.  This can be filtered by the state that th=
e line was in.",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.LOCAL_E",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : Local - Lines in E State"=
,
+        "UMask": "0x2002",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized : Counts the number of lines=
 that were victimized on a fill.  This can be filtered by the state that th=
e line was in.",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.LOCAL_F",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : Local - Lines in F State"=
,
+        "UMask": "0x2008",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized : Counts the number of lines=
 that were victimized on a fill.  This can be filtered by the state that th=
e line was in.",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.LOCAL_M",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : Local - Lines in M State"=
,
+        "UMask": "0x2001",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized : Counts the number of lines=
 that were victimized on a fill.  This can be filtered by the state that th=
e line was in.",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.LOCAL_S",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : Local - Lines in S State"=
,
+        "UMask": "0x2004",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of lines that were victimiz=
ed on a fill.  This can be filtered by the state that the line was in.",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.REMOTE_ALL",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : Remote - All Lines",
+        "UMask": "0x800f",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized : Counts the number of lines=
 that were victimized on a fill.  This can be filtered by the state that th=
e line was in.",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.REMOTE_E",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : Remote - Lines in E State=
",
+        "UMask": "0x8002",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized : Counts the number of lines=
 that were victimized on a fill.  This can be filtered by the state that th=
e line was in.",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.REMOTE_M",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : Remote - Lines in M State=
",
+        "UMask": "0x8001",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized : Counts the number of lines=
 that were victimized on a fill.  This can be filtered by the state that th=
e line was in.",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.REMOTE_S",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : Remote - Lines in S State=
",
+        "UMask": "0x8004",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of lines that were victimiz=
ed on a fill.  This can be filtered by the state that the line was in.",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_E",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : Lines in E state",
+        "UMask": "0x2",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of lines that were victimiz=
ed on a fill.  This can be filtered by the state that the line was in.",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_M",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : Lines in M state",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of lines that were victimiz=
ed on a fill.  This can be filtered by the state that the line was in.",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_S",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : Lines in S State",
+        "UMask": "0x4",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts when a RFO (the Read for Ownership iss=
ued before a  write) request hit a cacheline in the S (Shared) state.",
+        "EventCode": "0x39",
+        "EventName": "UNC_CHA_MISC.RFO_HIT_S",
+        "PerPkg": "1",
+        "PublicDescription": "Cbo Misc : RFO HitS",
+        "UMask": "0x8",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "OSB Snoop Broadcast : Local InvItoE : Count o=
f OSB snoop broadcasts. Counts by 1 per request causing OSB snoops to be br=
oadcast. Does not count all the snoops generated by OSB.",
+        "EventCode": "0x55",
+        "EventName": "UNC_CHA_OSB.LOCAL_INVITOE",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "OSB Snoop Broadcast : Local Rd : Count of OSB=
 snoop broadcasts. Counts by 1 per request causing OSB snoops to be broadca=
st. Does not count all the snoops generated by OSB.",
+        "EventCode": "0x55",
+        "EventName": "UNC_CHA_OSB.LOCAL_READ",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "OSB Snoop Broadcast : Off : Count of OSB snoo=
p broadcasts. Counts by 1 per request causing OSB snoops to be broadcast. D=
oes not count all the snoops generated by OSB.",
+        "EventCode": "0x55",
+        "EventName": "UNC_CHA_OSB.OFF_PWRHEURISTIC",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "OSB Snoop Broadcast : Remote Rd : Count of OS=
B snoop broadcasts. Counts by 1 per request causing OSB snoops to be broadc=
ast. Does not count all the snoops generated by OSB.",
+        "EventCode": "0x55",
+        "EventName": "UNC_CHA_OSB.REMOTE_READ",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "OSB Snoop Broadcast : RFO HitS Snoop Broadcas=
t : Count of OSB snoop broadcasts. Counts by 1 per request causing OSB snoo=
ps to be broadcast. Does not count all the snoops generated by OSB.",
+        "EventCode": "0x55",
+        "EventName": "UNC_CHA_OSB.RFO_HITS_SNP_BCAST",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_REMOTE_SF.ALLOC_EXCLUSIVE",
+        "EventCode": "0x69",
+        "EventName": "UNC_CHA_REMOTE_SF.ALLOC_EXCLUSIVE",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_REMOTE_SF.ALLOC_SHARED",
+        "EventCode": "0x69",
+        "EventName": "UNC_CHA_REMOTE_SF.ALLOC_SHARED",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_REMOTE_SF.DEALLOC_EVCTCLN",
+        "EventCode": "0x69",
+        "EventName": "UNC_CHA_REMOTE_SF.DEALLOC_EVCTCLN",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_REMOTE_SF.DIRBACKED_ONLY",
+        "EventCode": "0x69",
+        "EventName": "UNC_CHA_REMOTE_SF.DIRBACKED_ONLY",
+        "PerPkg": "1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_REMOTE_SF.HIT_EXCLUSIVE",
+        "EventCode": "0x69",
+        "EventName": "UNC_CHA_REMOTE_SF.HIT_EXCLUSIVE",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_REMOTE_SF.HIT_SHARED",
+        "EventCode": "0x69",
+        "EventName": "UNC_CHA_REMOTE_SF.HIT_SHARED",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_REMOTE_SF.INCLUSIVE_ONLY",
+        "EventCode": "0x69",
+        "EventName": "UNC_CHA_REMOTE_SF.INCLUSIVE_ONLY",
+        "PerPkg": "1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_REMOTE_SF.MISS",
+        "EventCode": "0x69",
+        "EventName": "UNC_CHA_REMOTE_SF.MISS",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_REMOTE_SF.UPDATE_EXCLUSIVE",
+        "EventCode": "0x69",
+        "EventName": "UNC_CHA_REMOTE_SF.UPDATE_EXCLUSIVE",
+        "PerPkg": "1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_REMOTE_SF.UPDATE_SHARED",
+        "EventCode": "0x69",
+        "EventName": "UNC_CHA_REMOTE_SF.UPDATE_SHARED",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_REMOTE_SF.VICTIM_EXCLUSIVE",
+        "EventCode": "0x69",
+        "EventName": "UNC_CHA_REMOTE_SF.VICTIM_EXCLUSIVE",
+        "PerPkg": "1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_REMOTE_SF.VICTIM_SHARED",
+        "EventCode": "0x69",
+        "EventName": "UNC_CHA_REMOTE_SF.VICTIM_SHARED",
+        "PerPkg": "1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the total number of requests coming fr=
om a unit on this socket for exclusive ownership of a cache line without re=
ceiving data (INVITOE) to the CHA.",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.INVITOE",
+        "PerPkg": "1",
+        "PublicDescription": "HA Read and Write Requests : InvalItoE",
+        "UMask": "0x30",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the total number of requests coming fr=
om a unit on this socket for exclusive ownership of a cache line without re=
ceiving data (INVITOE) to the CHA.",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.INVITOE_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the total number of requests coming fr=
om a remote socket for exclusive ownership of a cache line without receivin=
g data (INVITOE) to the CHA.",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.INVITOE_REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts read requests made into this CHA. Read=
s include all read opcodes (including RFO: the Read for Ownership issued be=
fore a  write) .",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.READS",
+        "PerPkg": "1",
+        "PublicDescription": "HA Read and Write Requests : Reads",
+        "UMask": "0x3",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts read requests coming from a unit on th=
is socket made into this CHA. Reads include all read opcodes (including RFO=
: the Read for Ownership issued before a  write).",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.READS_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts read requests coming from a remote soc=
ket made into the CHA. Reads include all read opcodes (including RFO: the R=
ead for Ownership issued before a  write).",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.READS_REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts write requests made into the CHA, incl=
uding streaming, evictions, HitM (Reads from another core to a Modified cac=
heline), etc.",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.WRITES",
+        "PerPkg": "1",
+        "PublicDescription": "HA Read and Write Requests : Writes",
+        "UMask": "0xc",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts  write requests coming from a unit on =
this socket made into this CHA, including streaming, evictions, HitM (Reads=
 from another core to a Modified cacheline), etc.",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.WRITES_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the total number of read requests made=
 into the Home Agent. Reads include all read opcodes (including RFO).  Writ=
es include all writes (streaming, evictions, HitM, etc).",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.WRITES_REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All TOR Inserts",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : All",
+        "UMask": "0xc001ffff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CLFlush transactions from a CXL device which =
hit in the L3.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_HIT_CLFLUSH",
+        "PerPkg": "1",
+        "UMask": "0x78c8c7fd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "FsRdCur transactions from a CXL device which =
hit in the L3.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_HIT_FSRDCUR",
+        "PerPkg": "1",
+        "UMask": "0x78c8effd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "FsRdCurPtl transactions from a CXL device whi=
ch hit in the L3.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_HIT_FSRDCURPTL",
+        "PerPkg": "1",
+        "UMask": "0x78c9effd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoM transactions from a CXL device which hit=
 in the L3.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_HIT_ITOM",
+        "PerPkg": "1",
+        "UMask": "0x78cc47fd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoMWr transactions from a CXL device which h=
it in the L3.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_HIT_ITOMWR",
+        "PerPkg": "1",
+        "UMask": "0x78cc4ffd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "MemPushWr transactions from a CXL device whic=
h hit in the L3.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_HIT_MEMPUSHWR",
+        "PerPkg": "1",
+        "UMask": "0x78cc6ffd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCiL transactions from a CXL device which hit=
 in the L3.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_HIT_WCIL",
+        "PerPkg": "1",
+        "UMask": "0x78c86ffd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WcilF transactions from a CXL device which hi=
t in the L3.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_HIT_WCILF",
+        "PerPkg": "1",
+        "UMask": "0x78c867fd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WiL transactions from a CXL device which hit =
in the L3.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_HIT_WIL",
+        "PerPkg": "1",
+        "UMask": "0x78c87ffd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CLFlush transactions from a CXL device which =
miss the L3.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_MISS_CLFLUSH",
+        "PerPkg": "1",
+        "UMask": "0x78c8c7fe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "FsRdCur transactions from a CXL device which =
miss the L3.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_MISS_FSRDCUR",
+        "PerPkg": "1",
+        "UMask": "0x78c8effe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "FsRdCurPtl transactions from a CXL device whi=
ch miss the L3.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_MISS_FSRDCURPTL",
+        "PerPkg": "1",
+        "UMask": "0x78c9effe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoM transactions from a CXL device which mis=
s the L3.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_MISS_ITOM",
+        "PerPkg": "1",
+        "UMask": "0x78cc47fe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoMWr transactions from a CXL device which m=
iss the L3.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_MISS_ITOMWR",
+        "PerPkg": "1",
+        "UMask": "0x78cc4ffe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "MemPushWr transactions from a CXL device whic=
h miss the L3.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_MISS_MEMPUSHWR",
+        "PerPkg": "1",
+        "UMask": "0x78cc6ffe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCiL transactions from a CXL device which mis=
s the L3.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_MISS_WCIL",
+        "PerPkg": "1",
+        "UMask": "0x78c86ffe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WcilF transactions from a CXL device which mi=
ss the L3.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_MISS_WCILF",
+        "PerPkg": "1",
+        "UMask": "0x78c867fe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WiL transactions from a CXL device which miss=
 the L3.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_MISS_WIL",
+        "PerPkg": "1",
+        "UMask": "0x78c87ffe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All locally initiated requests from IA Cores"=
,
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : All requests from iA Cores",
+        "UMask": "0xc001ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CLFlush events that are initiated from the Co=
re",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_CLFLUSH",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : CLFlushes issued by iA Cores",
+        "UMask": "0xc8c7ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CLFlushOpt events that are initiated from the=
 Core",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_CLFLUSHOPT",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : CLFlushOpts issued by iA Cores=
",
+        "UMask": "0xc8d7ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Code read from local IA that miss the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_CRD",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : CRDs issued by iA Cores",
+        "UMask": "0xc80fff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Code read prefetch from local IA that miss th=
e cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_CRD_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts; Code read prefetch from local I=
A that misses in the snoop filter",
+        "UMask": "0xc88fff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Data read opt from local IA that miss the cac=
he",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_DRD_OPT",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRd_Opts issued by iA Cores",
+        "UMask": "0xc827ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Data read opt prefetch from local IA that mis=
s the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_DRD_OPT_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRd_Opt_Prefs issued by iA Cor=
es",
+        "UMask": "0xc8a7ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All locally initiated requests from IA Cores =
which hit the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : All requests from iA Cores tha=
t Hit the LLC",
+        "UMask": "0xc001fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Code read from local IA that hit the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CRD",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : CRds issued by iA Cores that H=
it the LLC",
+        "UMask": "0xc80ffd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Code read prefetch from local IA that hit the=
 cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CRD_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : CRd_Prefs issued by iA Cores t=
hat hit the LLC",
+        "UMask": "0xc88ffd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All requests issued from IA cores to CXL acce=
lerator memory regions that hit the LLC.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c0018101",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Data read opt from local IA that hit the cach=
e",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRD_OPT",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRd_Opts issued by iA Cores th=
at hit the LLC",
+        "UMask": "0xc827fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Data read opt prefetch from local IA that hit=
 the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRD_OPT_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRd_Opt_Prefs issued by iA Cor=
es that hit the LLC",
+        "UMask": "0xc8a7fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoM requests from local IA cores that hit th=
e cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_ITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMs issued by iA Cores that =
Hit LLC",
+        "UMask": "0xcc47fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Last level cache prefetch code read from loca=
l IA that hit the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LLCPREFCODE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : LLCPrefCode issued by iA Cores=
 that hit the LLC",
+        "UMask": "0xcccffd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Last level cache prefetch data read from loca=
l IA that hit the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LLCPREFDATA",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : LLCPrefData issued by iA Cores=
 that hit the LLC",
+        "UMask": "0xccd7fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Last level cache prefetch read for ownership =
from local IA that hit the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LLCPREFRFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : LLCPrefRFO issued by iA Cores =
that hit the LLC",
+        "UMask": "0xccc7fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Read for ownership from local IA that hit the=
 cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFOs issued by iA Cores that H=
it the LLC",
+        "UMask": "0xc807fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Read for ownership prefetch from local IA tha=
t hit the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_RFO_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFO_Prefs issued by iA Cores t=
hat Hit the LLC",
+        "UMask": "0xc887fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoM events that are initiated from the Core"=
,
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_ITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMs issued by iA Cores",
+        "UMask": "0xcc47ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoMCacheNear requests from local IA cores",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_ITOMCACHENEAR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMCacheNears issued by iA Co=
res",
+        "UMask": "0xcd47ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Last level cache prefetch code read from loca=
l IA.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_LLCPREFCODE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : LLCPrefCode issued by iA Cores=
",
+        "UMask": "0xcccfff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Last level cache prefetch data read from loca=
l IA.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_LLCPREFDATA",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : LLCPrefData issued by iA Cores=
",
+        "UMask": "0xccd7ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Last level cache prefetch read for ownership =
from local IA that miss the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_LLCPREFRFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : LLCPrefRFO issued by iA Cores"=
,
+        "UMask": "0xccc7ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All locally initiated requests from IA Cores =
which miss the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : All requests from iA Cores tha=
t Missed the LLC",
+        "UMask": "0xc001fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Code read from local IA that miss the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : CRds issued by iA Cores that M=
issed the LLC",
+        "UMask": "0xc80ffe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CRDs from local IA cores to locally homed mem=
ory",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : CRd issued by iA Cores that Mi=
ssed the LLC - HOMed locally",
+        "UMask": "0xc80efe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Code read prefetch from local IA that miss th=
e cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : CRd_Prefs issued by iA Cores t=
hat Missed the LLC",
+        "UMask": "0xc88ffe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CRD Prefetches from local IA cores to locally=
 homed memory",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD_PREF_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : CRd_Prefs issued by iA Cores t=
hat Missed the LLC - HOMed locally",
+        "UMask": "0xc88efe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CRD Prefetches from local IA cores to remotel=
y homed memory",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD_PREF_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : CRd_Prefs issued by iA Cores t=
hat Missed the LLC - HOMed remotely",
+        "UMask": "0xc88f7e01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CRDs from local IA cores to remotely homed me=
mory",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : CRd issued by iA Cores that Mi=
ssed the LLC - HOMed remotely",
+        "UMask": "0xc80f7e01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All requests issued from IA cores to CXL acce=
lerator memory regions that miss the LLC.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c0018201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "DRds and equivalent opcodes issued from an IA=
 core which miss the L3 and target memory in a CXL type 2 memory expander c=
ard.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_CXL_ACC",
+        "PerPkg": "1",
+        "PublicDescription": "DRds issued from an IA core which miss the L=
3 and target memory in a CXL type 2 memory expander card.",
+        "UMask": "0x10c8178201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Data read opt from local IA that miss the cac=
he",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRd_Opt issued by iA Cores tha=
t missed the LLC",
+        "UMask": "0xc827fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Inserts into the TOR from local IA cores whic=
h miss the LLC and snoop filter with the opcode DRd_Opt, and which target l=
ocal memory",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRd_Opt issued by iA Cores tha=
t Missed the LLC - HOMed locally",
+        "UMask": "0xc826fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Data read opt prefetch from local IA that mis=
s the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRd_Opt_Prefs issued by iA Cor=
es that missed the LLC",
+        "UMask": "0xc8a7fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Inserts into the TOR from local IA cores whic=
h miss the LLC and snoop filter with the opcode DRD_PREF_OPT, and target lo=
cal memory",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_PREF_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRd_Opt_Prefs issued by iA Cor=
es that missed the LLC",
+        "UMask": "0xc8a6fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Inserts into the TOR from local IA cores whic=
h miss the LLC and snoop filter with the opcode DRD_PREF_OPT, and target re=
mote memory",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_PREF_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRd_Opt_Prefs issued by iA Cor=
es that missed the LLC",
+        "UMask": "0xc8a77e01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Inserts into the TOR from local IA cores whic=
h miss the LLC and snoop filter with the opcode DRd_Opt, and target remote =
memory",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRd_Opt issued by iA Cores tha=
t missed the LLC",
+        "UMask": "0xc8277e01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "L2 data prefetches issued from an IA core whi=
ch miss the L3 and target memory in a CXL type 2 accelerator.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c8978201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoM requests from local IA cores that miss t=
he cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_ITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMs issued by iA Cores that =
Missed LLC",
+        "UMask": "0xcc47fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Last level cache prefetch code read from loca=
l IA that miss the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFCODE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : LLCPrefCode issued by iA Cores=
 that missed the LLC",
+        "UMask": "0xcccffe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Last level cache prefetch data read from loca=
l IA that miss the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFDATA",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : LLCPrefData issued by iA Cores=
 that missed the LLC",
+        "UMask": "0xccd7fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "LLC data prefetches issued from an IA core wh=
ich miss the L3 and target memory in a CXL type 2 accelerator.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFDATA_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10ccd78201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Last level cache prefetch read for ownership =
from local IA that miss the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFRFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : LLCPrefRFO issued by iA Cores =
that missed the LLC",
+        "UMask": "0xccc7fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "L2 RFO prefetches issued from an IA core whic=
h miss the L3 and target memory in a CXL type 2 accelerator.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFRFO_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c8878201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCILF requests from local IA cores to locally=
 homed DDR addresses that miss the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LOCAL_WCILF_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLFs issued by iA Cores targ=
eting DDR that missed the LLC - HOMed locally",
+        "UMask": "0xc8668601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCILF requests from local IA cores to locally=
 homed PMM addresses which miss the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LOCAL_WCILF_PMM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLFs issued by iA Cores targ=
eting PMM that missed the LLC - HOMed locally",
+        "UMask": "0xc8668a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCIL requests from local IA cores to locally =
homed DDR addresses that miss the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LOCAL_WCIL_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLs issued by iA Cores targe=
ting DDR that missed the LLC - HOMed locally",
+        "UMask": "0xc86e8601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCIL requests from local IA cores to locally =
homed PMM addresses which miss the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LOCAL_WCIL_PMM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLs issued by iA Cores targe=
ting PMM that missed the LLC - HOMed locally",
+        "UMask": "0xc86e8a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCILF requests from local IA cores to remotel=
y homed DDR addresses that miss the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_REMOTE_WCILF_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLFs issued by iA Cores targ=
eting DDR that missed the LLC - HOMed remotely",
+        "UMask": "0xc8670601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCILF requests from local IA cores to remotel=
y homed PMM addresses which miss the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_REMOTE_WCILF_PMM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLFs issued by iA Cores targ=
eting PMM that missed the LLC - HOMed remotely",
+        "UMask": "0xc8670a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCIL requests from local IA cores to remotely=
 homed DDR addresses that miss the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_REMOTE_WCIL_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLs issued by iA Cores targe=
ting DDR that missed the LLC - HOMed remotely",
+        "UMask": "0xc86f0601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCIL requests from local IA cores to remotely=
 homed PMM addresses which miss the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_REMOTE_WCIL_PMM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLs issued by iA Cores targe=
ting PMM that missed the LLC - HOMed remotely",
+        "UMask": "0xc86f0a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Read for ownership from local IA that miss th=
e cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFOs issued by iA Cores that M=
issed the LLC",
+        "UMask": "0xc807fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "RFOs issued from an IA core which miss the L3=
 and target memory in a CXL type 2 accelerator.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c8078201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Read for ownership from local IA that miss th=
e cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFOs issued by iA Cores that M=
issed the LLC - HOMed locally",
+        "UMask": "0xc806fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Read for ownership prefetch from local IA tha=
t miss the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFO_Prefs issued by iA Cores t=
hat Missed the LLC",
+        "UMask": "0xc887fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "LLC RFO prefetches issued from an IA core whi=
ch miss the L3 and target memory in a CXL type 2 accelerator.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10ccc78201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Read for ownership prefetch from local IA tha=
t miss the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFO_Prefs issued by iA Cores t=
hat Missed the LLC - HOMed locally",
+        "UMask": "0xc886fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Read for ownership prefetch from local IA tha=
t miss the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFO_Prefs issued by iA Cores t=
hat Missed the LLC - HOMed remotely",
+        "UMask": "0xc8877e01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Read for ownership from local IA that miss th=
e cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFOs issued by iA Cores that M=
issed the LLC - HOMed remotely",
+        "UMask": "0xc8077e01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UCRDF requests from local IA cores that miss =
the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_UCRDF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : UCRdFs issued by iA Cores that=
 Missed LLC",
+        "UMask": "0xc877de01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCIL requests from a local IA core that miss =
the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCIL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLs issued by iA Cores that =
Missed the LLC",
+        "UMask": "0xc86ffe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCILF requests from local IA core that miss t=
he cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCILF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLF issued by iA Cores that =
Missed the LLC",
+        "UMask": "0xc867fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCILF requests from local IA cores to DDR hom=
ed addresses which miss the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCILF_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLFs issued by iA Cores targ=
eting DDR that missed the LLC",
+        "UMask": "0xc8678601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCILF requests from local IA cores to PMM hom=
ed addresses which miss the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCILF_PMM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLFs issued by iA Cores targ=
eting PMM that missed the LLC",
+        "UMask": "0xc8678a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCIL requests from local IA cores to DDR home=
d addresses which miss the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCIL_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLs issued by iA Cores targe=
ting DDR that missed the LLC",
+        "UMask": "0xc86f8601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCIL requests from a local IA core to PMM hom=
ed addresses that miss the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCIL_PMM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLs issued by iA Cores targe=
ting PMM that missed the LLC",
+        "UMask": "0xc86f8a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WIL requests from local IA cores that miss th=
e cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WIL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WiLs issued by iA Cores that M=
issed LLC",
+        "UMask": "0xc87fde01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Read for ownership from local IA that miss th=
e cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFOs issued by iA Cores",
+        "UMask": "0xc807ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Read for ownership prefetch from local IA tha=
t miss the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_RFO_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFO_Prefs issued by iA Cores",
+        "UMask": "0xc887ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "SpecItoM events that are initiated from the C=
ore",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_SPECITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : SpecItoMs issued by iA Cores",
+        "UMask": "0xcc57ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WbEFtoEs issued by iA Cores.  (Non Modified W=
rite Backs)",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_WBEFTOE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMs issued by IO Devices tha=
t Hit the LLC",
+        "UMask": "0xcc3fff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WbEFtoIs issued by iA Cores .  (Non Modified =
Write Backs)",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_WBEFTOI",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMs issued by IO Devices tha=
t Hit the LLC",
+        "UMask": "0xcc37ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WbMtoEs issued by iA Cores .  (Modified Write=
 Backs)",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_WBMTOE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMs issued by IO Devices tha=
t Hit the LLC",
+        "UMask": "0xcc2fff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WbMtoI requests from local IA cores",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_WBMTOI",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WbMtoIs issued by iA Cores",
+        "UMask": "0xcc27ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WbStoIs issued by iA Cores .  (Non Modified W=
rite Backs)",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_WBSTOI",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMs issued by IO Devices tha=
t Hit the LLC",
+        "UMask": "0xcc67ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCIL requests from a local IA core",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_WCIL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLs issued by iA Cores",
+        "UMask": "0xc86fff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCILF requests from local IA core",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_WCILF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLF issued by iA Cores",
+        "UMask": "0xc867ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All TOR inserts from local IO devices",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : All requests from IO Devices",
+        "UMask": "0xc001ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CLFlush requests from IO devices",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_CLFLUSH",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : CLFlushes issued by IO Devices=
",
+        "UMask": "0xc8c3ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All TOR inserts from local IO devices which h=
it the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : All requests from IO Devices t=
hat hit the LLC",
+        "UMask": "0xc001fd04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoMs from local IO devices which hit the cac=
he",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT_ITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMs issued by IO Devices tha=
t Hit the LLC",
+        "UMask": "0xcc43fd04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoMCacheNears, indicating a partial write re=
quest, from IO Devices that hit the LLC",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT_ITOMCACHENEAR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMCacheNears, indicating a p=
artial write request, from IO Devices that hit the LLC",
+        "UMask": "0xcd43fd04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "PCIRDCURs issued by IO devices which hit the =
LLC",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT_PCIRDCUR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : PCIRdCurs issued by IO Devices=
 that hit the LLC",
+        "UMask": "0xc8f3fd04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "RFOs from local IO devices which hit the cach=
e",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFOs issued by IO Devices that=
 hit the LLC",
+        "UMask": "0xc803fd04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All TOR ItoM inserts from local IO devices",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_ITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMs issued by IO Devices",
+        "UMask": "0xcc43ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoMCacheNears, indicating a partial write re=
quest, from IO Devices",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_ITOMCACHENEAR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMCacheNears, indicating a p=
artial write request, from IO Devices",
+        "UMask": "0xcd43ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All TOR inserts from local IO devices which m=
iss the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : All requests from IO Devices t=
hat missed the LLC",
+        "UMask": "0xc001fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All TOR ItoM inserts from local IO devices wh=
ich miss the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_ITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMs issued by IO Devices tha=
t missed the LLC",
+        "UMask": "0xcc43fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoMCacheNears, indicating a partial write re=
quest, from IO Devices that missed the LLC",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_ITOMCACHENEAR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMCacheNears, indicating a p=
artial write request, from IO Devices that missed the LLC",
+        "UMask": "0xcd43fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoMCacheNear transactions from an IO device =
on the local socket that miss the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_ITOMCACHENEAR_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMCacheNears, indicating a p=
artial write request, from IO Devices that missed the LLC",
+        "UMask": "0xcd42fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoMCacheNear transactions from an IO device =
on a remote socket that miss the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_ITOMCACHENEAR_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMCacheNears, indicating a p=
artial write request, from IO Devices that missed the LLC",
+        "UMask": "0xcd437e04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoM transactions from an IO device on the lo=
cal socket that miss the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_ITOM_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMs issued by IO Devices tha=
t missed the LLC",
+        "UMask": "0xcc42fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoM transactions from an IO device on a remo=
te socket that miss the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_ITOM_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMs issued by IO Devices tha=
t missed the LLC",
+        "UMask": "0xcc437e04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "PCIRDCURs issued by IO devices which miss the=
 LLC",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_PCIRDCUR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : PCIRdCurs issued by IO Devices=
 that missed the LLC",
+        "UMask": "0xc8f3fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All TOR RFO inserts from local IO devices whi=
ch miss the cache",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFOs issued by IO Devices that=
 missed the LLC",
+        "UMask": "0xc803fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "PCIRDCURs issued by IO devices",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : PCIRdCurs issued by IO Devices=
",
+        "UMask": "0xc8f3ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "RFOs from local IO devices",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFOs issued by IO Devices",
+        "UMask": "0xc803ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WBMtoI requests from IO devices",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_WBMTOI",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WbMtoIs issued by IO Devices",
+        "UMask": "0xcc23ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts for SF or LLC Evictions",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.LLC_OR_SF_EVICTIONS",
+        "PerPkg": "1",
+        "PublicDescription": "TOR allocation occurred as a result of SF/LL=
C evictions (came from the ISMQ)",
+        "UMask": "0xc001ff02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All locally initiated requests",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.LOC_ALL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : All from Local iA and IO",
+        "UMask": "0xc000ff05",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All from Local iA",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.LOC_IA",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : All from Local iA",
+        "UMask": "0xc000ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All from Local IO",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.LOC_IO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : All from Local IO",
+        "UMask": "0xc000ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All remote requests (e.g. snoops, writebacks)=
 that came from remote sockets",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.REM_ALL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : All Remote Requests",
+        "UMask": "0xc001ffc8",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All snoops to this LLC that came from remote =
sockets",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.REM_SNPS",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : All Snoops from Remote",
+        "UMask": "0xc001ff08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Occupancy for all TOR entries",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All",
+        "UMask": "0xc001ffff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for CLFlush transactions from a=
 CXL device which hit in the L3.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_HIT_CLFLUSH",
+        "PerPkg": "1",
+        "UMask": "0x78c8c7fd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for FsRdCur transactions from a=
 CXL device which hit in the L3.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_HIT_FSRDCUR",
+        "PerPkg": "1",
+        "UMask": "0x78c8effd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for FsRdCurPtl transactions fro=
m a CXL device which hit in the L3.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_HIT_FSRDCURPTL",
+        "PerPkg": "1",
+        "UMask": "0x78c9effd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoM transactions from a CX=
L device which hit in the L3.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_HIT_ITOM",
+        "PerPkg": "1",
+        "UMask": "0x78cc47fd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoMWr transactions from a =
CXL device which hit in the L3.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_HIT_ITOMWR",
+        "PerPkg": "1",
+        "UMask": "0x78cc4ffd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for MemPushWr transactions from=
 a CXL device which hit in the L3.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_HIT_MEMPUSHWR",
+        "PerPkg": "1",
+        "UMask": "0x78cc6ffd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCiL transactions from a CX=
L device which hit in the L3.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_HIT_WCIL",
+        "PerPkg": "1",
+        "UMask": "0x78c86ffd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WcilF transactions from a C=
XL device which hit in the L3.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_HIT_WCILF",
+        "PerPkg": "1",
+        "UMask": "0x78c867fd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WiL transactions from a CXL=
 device which hit in the L3.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_HIT_WIL",
+        "PerPkg": "1",
+        "UMask": "0x78c87ffd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for CLFlush transactions from a=
 CXL device which miss the L3.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_MISS_CLFLUSH",
+        "PerPkg": "1",
+        "UMask": "0x78c8c7fe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for FsRdCur transactions from a=
 CXL device which miss the L3.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_MISS_FSRDCUR",
+        "PerPkg": "1",
+        "UMask": "0x78c8effe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for FsRdCurPtl transactions fro=
m a CXL device which miss the L3.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_MISS_FSRDCURPTL",
+        "PerPkg": "1",
+        "UMask": "0x78c9effe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoM transactions from a CX=
L device which miss the L3.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_MISS_ITOM",
+        "PerPkg": "1",
+        "UMask": "0x78cc47fe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoMWr transactions from a =
CXL device which miss the L3.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_MISS_ITOMWR",
+        "PerPkg": "1",
+        "UMask": "0x78cc4ffe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for MemPushWr transactions from=
 a CXL device which miss the L3.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_MISS_MEMPUSHWR",
+        "PerPkg": "1",
+        "UMask": "0x78cc6ffe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCiL transactions from a CX=
L device which miss the L3.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_MISS_WCIL",
+        "PerPkg": "1",
+        "UMask": "0x78c86ffe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WcilF transactions from a C=
XL device which miss the L3.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_MISS_WCILF",
+        "PerPkg": "1",
+        "UMask": "0x78c867fe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WiL transactions from a CXL=
 device which miss the L3.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_MISS_WIL",
+        "PerPkg": "1",
+        "UMask": "0x78c87ffe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All locally initiated reque=
sts from IA Cores",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All requests from iA Cores",
+        "UMask": "0xc001ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for CLFlush events that are ini=
tiated from the Core",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_CLFLUSH",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : CLFlushes issued by iA Cores=
",
+        "UMask": "0xc8c7ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for CLFlushOpt events that are =
initiated from the Core",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_CLFLUSHOPT",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : CLFlushOpts issued by iA Cor=
es",
+        "UMask": "0xc8d7ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Code read from local IA tha=
t miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_CRD",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : CRDs issued by iA Cores",
+        "UMask": "0xc80fff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Code read prefetch from loc=
al IA that miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_CRD_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy; Code read prefetch from local=
 IA that misses in the snoop filter",
+        "UMask": "0xc88fff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Data read opt from local IA=
 that miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_DRD_OPT",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRd_Opts issued by iA Cores"=
,
+        "UMask": "0xc827ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Data read opt prefetch from=
 local IA that miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_DRD_OPT_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRd_Opt_Prefs issued by iA C=
ores",
+        "UMask": "0xc8a7ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All locally initiated reque=
sts from IA Cores which hit the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All requests from iA Cores t=
hat Hit the LLC",
+        "UMask": "0xc001fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Code read from local IA tha=
t hit the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_CRD",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : CRds issued by iA Cores that=
 Hit the LLC",
+        "UMask": "0xc80ffd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Code read prefetch from loc=
al IA that hit the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_CRD_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : CRd_Prefs issued by iA Cores=
 that hit the LLC",
+        "UMask": "0xc88ffd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All requests issued from IA=
 cores to CXL accelerator memory regions that hit the LLC.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c0018101",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Data read opt from local IA=
 that hit the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD_OPT",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRd_Opts issued by iA Cores =
that hit the LLC",
+        "UMask": "0xc827fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Data read opt prefetch from=
 local IA that hit the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD_OPT_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRd_Opt_Prefs issued by iA C=
ores that hit the LLC",
+        "UMask": "0xc8a7fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoM requests from local IA=
 cores that hit the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_ITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMs issued by iA Cores tha=
t Hit LLC",
+        "UMask": "0xcc47fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Last level cache prefetch c=
ode read from local IA that hit the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LLCPREFCODE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : LLCPrefCode issued by iA Cor=
es that hit the LLC",
+        "UMask": "0xcccffd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Last level cache prefetch d=
ata read from local IA that hit the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LLCPREFDATA",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : LLCPrefData issued by iA Cor=
es that hit the LLC",
+        "UMask": "0xccd7fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Last level cache prefetch r=
ead for ownership from local IA that hit the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LLCPREFRFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : LLCPrefRFO issued by iA Core=
s that hit the LLC",
+        "UMask": "0xccc7fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Read for ownership from loc=
al IA that hit the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFOs issued by iA Cores that=
 Hit the LLC",
+        "UMask": "0xc807fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Read for ownership prefetch=
 from local IA that hit the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_RFO_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFO_Prefs issued by iA Cores=
 that Hit the LLC",
+        "UMask": "0xc887fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoM events that are initia=
ted from the Core",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_ITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMs issued by iA Cores",
+        "UMask": "0xcc47ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoMCacheNear requests from=
 local IA cores",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_ITOMCACHENEAR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMCacheNears issued by iA =
Cores",
+        "UMask": "0xcd47ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Last level cache prefetch c=
ode read from local IA.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_LLCPREFCODE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : LLCPrefCode issued by iA Cor=
es",
+        "UMask": "0xcccfff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Last level cache prefetch d=
ata read from local IA.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_LLCPREFDATA",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : LLCPrefData issued by iA Cor=
es",
+        "UMask": "0xccd7ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Last level cache prefetch r=
ead for ownership from local IA that miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_LLCPREFRFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : LLCPrefRFO issued by iA Core=
s",
+        "UMask": "0xccc7ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All locally initiated reque=
sts from IA Cores which miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All requests from iA Cores t=
hat Missed the LLC",
+        "UMask": "0xc001fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Code read from local IA tha=
t miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : CRds issued by iA Cores that=
 Missed the LLC",
+        "UMask": "0xc80ffe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for CRDs from local IA cores to=
 locally homed memory",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : CRd issued by iA Cores that =
Missed the LLC - HOMed locally",
+        "UMask": "0xc80efe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Code read prefetch from loc=
al IA that miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : CRd_Prefs issued by iA Cores=
 that Missed the LLC",
+        "UMask": "0xc88ffe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for CRD Prefetches from local I=
A cores to locally homed memory",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD_PREF_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : CRd_Prefs issued by iA Cores=
 that Missed the LLC - HOMed locally",
+        "UMask": "0xc88efe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for CRD Prefetches from local I=
A cores to remotely homed memory",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD_PREF_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : CRd_Prefs issued by iA Cores=
 that Missed the LLC - HOMed remotely",
+        "UMask": "0xc88f7e01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for CRDs from local IA cores to=
 remotely homed memory",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : CRd issued by iA Cores that =
Missed the LLC - HOMed remotely",
+        "UMask": "0xc80f7e01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All requests issued from IA=
 cores to CXL accelerator memory regions that miss the LLC.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c0018201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for DRds and equivalent opcodes=
 issued from an IA core which miss the L3 and target memory in a CXL type 2=
 memory expander card.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c8178201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Data read opt from local IA=
 that miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_OPT",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRd_Opt issued by iA Cores t=
hat missed the LLC",
+        "UMask": "0xc827fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Data read opt prefetch from=
 local IA that miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_OPT_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRd_Opt_Prefs issued by iA C=
ores that missed the LLC",
+        "UMask": "0xc8a7fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for L2 data prefetches issued f=
rom an IA core which miss the L3 and target memory in a CXL type 2 accelera=
tor.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PREF_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c8978201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoM requests from local IA=
 cores that miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_ITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMs issued by iA Cores tha=
t Missed LLC",
+        "UMask": "0xcc47fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Last level cache prefetch c=
ode read from local IA that miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFCODE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : LLCPrefCode issued by iA Cor=
es that missed the LLC",
+        "UMask": "0xcccffe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Last level cache prefetch d=
ata read from local IA that miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFDATA",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : LLCPrefData issued by iA Cor=
es that missed the LLC",
+        "UMask": "0xccd7fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for LLC data prefetches issued =
from an IA core which miss the L3 and target memory in a CXL type 2 acceler=
ator.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFDATA_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10ccd78201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Last level cache prefetch r=
ead for ownership from local IA that miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFRFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : LLCPrefRFO issued by iA Core=
s that missed the LLC",
+        "UMask": "0xccc7fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for L2 RFO prefetches issued fr=
om an IA core which miss the L3 and target memory in a CXL type 2 accelerat=
or.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFRFO_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c8878201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCILF requests from local I=
A cores to locally homed DDR addresses that miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LOCAL_WCILF_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLFs issued by iA Cores ta=
rgeting DDR that missed the LLC - HOMed locally",
+        "UMask": "0xc8668601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCILF requests from local I=
A cores to locally homed PMM addresses which miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LOCAL_WCILF_PMM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLFs issued by iA Cores ta=
rgeting PMM that missed the LLC - HOMed locally",
+        "UMask": "0xc8668a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCIL requests from local IA=
 cores to locally homed DDR addresses that miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LOCAL_WCIL_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLs issued by iA Cores tar=
geting DDR that missed the LLC - HOMed locally",
+        "UMask": "0xc86e8601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCIL requests from local IA=
 cores to locally homed PMM addresses which miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LOCAL_WCIL_PMM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLs issued by iA Cores tar=
geting PMM that missed the LLC - HOMed locally",
+        "UMask": "0xc86e8a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCILF requests from local I=
A cores to remotely homed DDR addresses that miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_REMOTE_WCILF_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLFs issued by iA Cores ta=
rgeting DDR that missed the LLC - HOMed remotely",
+        "UMask": "0xc8670601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCILF requests from local I=
A cores to remotely homed PMM addresses which miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_REMOTE_WCILF_PMM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLFs issued by iA Cores ta=
rgeting PMM that missed the LLC - HOMed remotely",
+        "UMask": "0xc8670a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCIL requests from local IA=
 cores to remotely homed DDR addresses that miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_REMOTE_WCIL_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLs issued by iA Cores tar=
geting DDR that missed the LLC - HOMed remotely",
+        "UMask": "0xc86f0601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCIL requests from local IA=
 cores to remotely homed PMM addresses which miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_REMOTE_WCIL_PMM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLs issued by iA Cores tar=
geting PMM that missed the LLC - HOMed remotely",
+        "UMask": "0xc86f0a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Read for ownership from loc=
al IA that miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFOs issued by iA Cores that=
 Missed the LLC",
+        "UMask": "0xc807fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for RFOs issued from an IA core=
 which miss the L3 and target memory in a CXL type 2 accelerator.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c8078201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Read for ownership from loc=
al IA that miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFOs issued by iA Cores that=
 Missed the LLC - HOMed locally",
+        "UMask": "0xc806fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Read for ownership prefetch=
 from local IA that miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFO_Prefs issued by iA Cores=
 that Missed the LLC",
+        "UMask": "0xc887fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for LLC RFO prefetches issued f=
rom an IA core which miss the L3 and target memory in a CXL type 2 accelera=
tor.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_PREF_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10ccc78201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Read for ownership prefetch=
 from local IA that miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_PREF_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFO_Prefs issued by iA Cores=
 that Missed the LLC - HOMed locally",
+        "UMask": "0xc886fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Read for ownership prefetch=
 from local IA that miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_PREF_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFO_Prefs issued by iA Cores=
 that Missed the LLC - HOMed remotely",
+        "UMask": "0xc8877e01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Read for ownership from loc=
al IA that miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFOs issued by iA Cores that=
 Missed the LLC - HOMed remotely",
+        "UMask": "0xc8077e01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for UCRDF requests from local I=
A cores that miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_UCRDF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : UCRdFs issued by iA Cores th=
at Missed LLC",
+        "UMask": "0xc877de01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCIL requests from a local =
IA core that miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WCIL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLs issued by iA Cores tha=
t Missed the LLC",
+        "UMask": "0xc86ffe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCILF requests from local I=
A core that miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WCILF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLF issued by iA Cores tha=
t Missed the LLC",
+        "UMask": "0xc867fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCILF requests from local I=
A cores to DDR homed addresses which miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WCILF_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLFs issued by iA Cores ta=
rgeting DDR that missed the LLC",
+        "UMask": "0xc8678601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCILF requests from local I=
A cores to PMM homed addresses which miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WCILF_PMM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLFs issued by iA Cores ta=
rgeting PMM that missed the LLC",
+        "UMask": "0xc8678a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCIL requests from local IA=
 cores to DDR homed addresses which miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WCIL_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLs issued by iA Cores tar=
geting DDR that missed the LLC",
+        "UMask": "0xc86f8601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCIL requests from a local =
IA core to PMM homed addresses that miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WCIL_PMM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLs issued by iA Cores tar=
geting PMM that missed the LLC",
+        "UMask": "0xc86f8a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WIL requests from local IA =
cores that miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WIL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WiLs issued by iA Cores that=
 Missed LLC",
+        "UMask": "0xc87fde01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Read for ownership from loc=
al IA that miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFOs issued by iA Cores",
+        "UMask": "0xc807ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Read for ownership prefetch=
 from local IA that miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_RFO_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFO_Prefs issued by iA Cores=
",
+        "UMask": "0xc887ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for SpecItoM events that are in=
itiated from the Core",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_SPECITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : SpecItoMs issued by iA Cores=
",
+        "UMask": "0xcc57ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WbMtoI requests from local =
IA cores",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_WBMTOI",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WbMtoIs issued by iA Cores",
+        "UMask": "0xcc27ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCIL requests from a local =
IA core",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_WCIL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLs issued by iA Cores",
+        "UMask": "0xc86fff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCILF requests from local I=
A core",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_WCILF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLF issued by iA Cores",
+        "UMask": "0xc867ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All TOR inserts from local =
IO devices",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All requests from IO Devices=
",
+        "UMask": "0xc001ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for CLFlush requests from IO de=
vices",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_CLFLUSH",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : CLFlushes issued by IO Devic=
es",
+        "UMask": "0xc8c3ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All TOR inserts from local =
IO devices which hit the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_HIT",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All requests from IO Devices=
 that hit the LLC",
+        "UMask": "0xc001fd04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoMs from local IO devices=
 which hit the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_HIT_ITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMs issued by IO Devices t=
hat Hit the LLC",
+        "UMask": "0xcc43fd04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoMCacheNears, indicating =
a partial write request, from IO Devices that hit the LLC",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_HIT_ITOMCACHENEAR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMCacheNears, indicating a=
 partial write request, from IO Devices that hit the LLC",
+        "UMask": "0xcd43fd04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for PCIRDCURs issued by IO devi=
ces which hit the LLC",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_HIT_PCIRDCUR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : PCIRdCurs issued by IO Devic=
es that hit the LLC",
+        "UMask": "0xc8f3fd04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for RFOs from local IO devices =
which hit the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_HIT_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFOs issued by IO Devices th=
at hit the LLC",
+        "UMask": "0xc803fd04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All TOR ItoM inserts from l=
ocal IO devices",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_ITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMs issued by IO Devices",
+        "UMask": "0xcc43ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoMCacheNears, indicating =
a partial write request, from IO Devices",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_ITOMCACHENEAR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMCacheNears, indicating a=
 partial write request, from IO Devices",
+        "UMask": "0xcd43ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All TOR inserts from local =
IO devices which miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All requests from IO Devices=
 that missed the LLC",
+        "UMask": "0xc001fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All TOR ItoM inserts from l=
ocal IO devices which miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMs issued by IO Devices t=
hat missed the LLC",
+        "UMask": "0xcc43fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoMCacheNears, indicating =
a partial write request, from IO Devices that missed the LLC",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOMCACHENEAR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMCacheNears, indicating a=
 partial write request, from IO Devices that missed the LLC",
+        "UMask": "0xcd43fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoMCacheNear transactions =
from an IO device on the local socket that miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOMCACHENEAR_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMCacheNears, indicating a=
 partial write request, from IO Devices that missed the LLC",
+        "UMask": "0xcd42fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoMCacheNear transactions =
from an IO device on a remote socket that miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOMCACHENEAR_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMCacheNears, indicating a=
 partial write request, from IO Devices that missed the LLC",
+        "UMask": "0xcd437e04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoM transactions from an I=
O device on the local socket that miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOM_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMs issued by IO Devices t=
hat missed the LLC",
+        "UMask": "0xcc42fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoM transactions from an I=
O device on a remote socket that miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOM_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMs issued by IO Devices t=
hat missed the LLC",
+        "UMask": "0xcc437e04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for PCIRDCURs issued by IO devi=
ces which miss the LLC",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_PCIRDCUR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : PCIRdCurs issued by IO Devic=
es that missed the LLC",
+        "UMask": "0xc8f3fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for PCIRDCUR transactions from =
an IO device on the local socket that miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_PCIRDCUR_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : PCIRdCurs issued by IO Devic=
es that missed the LLC",
+        "UMask": "0xc8f2fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for PCIRDCUR transactions from =
an IO device on a remote socket that miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_PCIRDCUR_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : PCIRdCurs issued by IO Devic=
es that missed the LLC",
+        "UMask": "0xc8f37e04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All TOR RFO inserts from lo=
cal IO devices which miss the cache",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFOs issued by IO Devices th=
at missed the LLC",
+        "UMask": "0xc803fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for PCIRDCURs issued by IO devi=
ces",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_PCIRDCUR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : PCIRdCurs issued by IO Devic=
es",
+        "UMask": "0xc8f3ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for RFOs from local IO devices"=
,
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFOs issued by IO Devices",
+        "UMask": "0xc803ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WBMtoI requests from IO dev=
ices",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_WBMTOI",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WbMtoIs issued by IO Devices=
",
+        "UMask": "0xcc23ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All locally initiated reque=
sts",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.LOC_ALL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All from Local iA and IO",
+        "UMask": "0xc000ff05",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All from Local iA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.LOC_IA",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All from Local iA",
+        "UMask": "0xc000ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All from Local IO",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.LOC_IO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All from Local IO",
+        "UMask": "0xc000ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All remote requests (e.g. s=
noops, writebacks) that came from remote sockets",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.REM_ALL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All Remote Requests",
+        "UMask": "0xc001ffc8",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All snoops to this LLC that=
 came from remote sockets",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.REM_SNPS",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All Snoops from Remote",
+        "UMask": "0xc001ff08",
+        "Unit": "CHA"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-cxl.json b/=
tools/perf/pmu-events/arch/x86/sierraforest/uncore-cxl.json
new file mode 100644
index 000000000000..dc676c7aa37f
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-cxl.json
@@ -0,0 +1,10 @@
+[
+    {
+        "BriefDescription": "B2CXL Clockticks",
+        "EventCode": "0x01",
+        "EventName": "UNC_B2CXL_CLOCKTICKS",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "Unit": "B2CXL"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-interconnec=
t.json b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-interconnect.js=
on
new file mode 100644
index 000000000000..6932b2fea3a5
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-interconnect.json
@@ -0,0 +1,1228 @@
+[
+    {
+        "BriefDescription": "Clockticks of the mesh to memory (B2CMI)",
+        "EventCode": "0x01",
+        "EventName": "UNC_B2CMI_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the number of time D2C was not honoure=
d by egress due to directory state constraints",
+        "EventCode": "0x17",
+        "EventName": "UNC_B2CMI_DIRECT2CORE_NOT_TAKEN_DIRSTATE",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the number of times B2CMI egress did D=
2C (direct to core)",
+        "EventCode": "0x16",
+        "EventName": "UNC_B2CMI_DIRECT2CORE_TAKEN",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the number of times D2C wasn't honoure=
d even though the incoming request had d2c set for non cisgress txn",
+        "EventCode": "0x18",
+        "EventName": "UNC_B2CMI_DIRECT2CORE_TXN_OVERRIDE",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the number of d2k wasn't done due to c=
redit constraints",
+        "EventCode": "0x1B",
+        "EventName": "UNC_B2CMI_DIRECT2UPI_NOT_TAKEN_CREDITS",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Direct to UPI Transactions - Ignored due to l=
ack of credits : All : Counts the number of d2k wasn't done due to credit c=
onstraints",
+        "EventCode": "0x1B",
+        "EventName": "UNC_B2CMI_DIRECT2UPI_NOT_TAKEN_CREDITS.EGRESS",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the number of time D2K was not honoure=
d by egress due to directory state constraints",
+        "EventCode": "0x1A",
+        "EventName": "UNC_B2CMI_DIRECT2UPI_NOT_TAKEN_DIRSTATE",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Cycles when Direct2UPI was Disabled : Egress =
Ignored D2U : Counts the number of time D2K was not honoured by egress due =
to directory state constraints",
+        "EventCode": "0x1A",
+        "EventName": "UNC_B2CMI_DIRECT2UPI_NOT_TAKEN_DIRSTATE.EGRESS",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the number of times egress did D2K (Di=
rect to KTI)",
+        "EventCode": "0x19",
+        "EventName": "UNC_B2CMI_DIRECT2UPI_TAKEN",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the number of times D2K wasn't honoure=
d even though the incoming request had d2k set for non cisgress txn",
+        "EventCode": "0x1C",
+        "EventName": "UNC_B2CMI_DIRECT2UPI_TXN_OVERRIDE",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Hit Clean",
+        "EventCode": "0x1D",
+        "EventName": "UNC_B2CMI_DIRECTORY_HIT.CLEAN",
+        "PerPkg": "1",
+        "UMask": "0x38",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Hit : On NonDirty Line in A State",
+        "EventCode": "0x1D",
+        "EventName": "UNC_B2CMI_DIRECTORY_HIT.CLEAN_A",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Hit : On NonDirty Line in I State",
+        "EventCode": "0x1D",
+        "EventName": "UNC_B2CMI_DIRECTORY_HIT.CLEAN_I",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Hit : On NonDirty Line in S State",
+        "EventCode": "0x1D",
+        "EventName": "UNC_B2CMI_DIRECTORY_HIT.CLEAN_S",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Hit Dirty (modified)",
+        "EventCode": "0x1D",
+        "EventName": "UNC_B2CMI_DIRECTORY_HIT.DIRTY",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Hit : On Dirty Line in A State",
+        "EventCode": "0x1D",
+        "EventName": "UNC_B2CMI_DIRECTORY_HIT.DIRTY_A",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Hit : On Dirty Line in I State",
+        "EventCode": "0x1D",
+        "EventName": "UNC_B2CMI_DIRECTORY_HIT.DIRTY_I",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Hit : On Dirty Line in S State",
+        "EventCode": "0x1D",
+        "EventName": "UNC_B2CMI_DIRECTORY_HIT.DIRTY_S",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the number of 1lm or 2lm hit read data=
 returns to egress with any directory to non persistent memory",
+        "EventCode": "0x20",
+        "EventName": "UNC_B2CMI_DIRECTORY_LOOKUP.ANY",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the number of 1lm or 2lm hit read data=
 returns to egress with directory A to non persistent memory",
+        "EventCode": "0x20",
+        "EventName": "UNC_B2CMI_DIRECTORY_LOOKUP.STATE_A",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the number of 1lm or 2lm hit read data=
 returns to egress with directory I to non persistent memory",
+        "EventCode": "0x20",
+        "EventName": "UNC_B2CMI_DIRECTORY_LOOKUP.STATE_I",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the number of 1lm or 2lm hit read data=
 returns to egress with directory S to non persistent memory",
+        "EventCode": "0x20",
+        "EventName": "UNC_B2CMI_DIRECTORY_LOOKUP.STATE_S",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of 1lm or 2lm hit read  da=
ta returns to egress with directory S to non persistent memory",
+        "UMask": "0x4",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Miss Clean",
+        "EventCode": "0x1E",
+        "EventName": "UNC_B2CMI_DIRECTORY_MISS.CLEAN",
+        "PerPkg": "1",
+        "UMask": "0x38",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Miss : On NonDirty Line in A State"=
,
+        "EventCode": "0x1E",
+        "EventName": "UNC_B2CMI_DIRECTORY_MISS.CLEAN_A",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Miss : On NonDirty Line in I State"=
,
+        "EventCode": "0x1E",
+        "EventName": "UNC_B2CMI_DIRECTORY_MISS.CLEAN_I",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Miss : On NonDirty Line in S State"=
,
+        "EventCode": "0x1E",
+        "EventName": "UNC_B2CMI_DIRECTORY_MISS.CLEAN_S",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Miss Dirty (modified)",
+        "EventCode": "0x1E",
+        "EventName": "UNC_B2CMI_DIRECTORY_MISS.DIRTY",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Miss : On Dirty Line in A State",
+        "EventCode": "0x1E",
+        "EventName": "UNC_B2CMI_DIRECTORY_MISS.DIRTY_A",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Miss : On Dirty Line in I State",
+        "EventCode": "0x1E",
+        "EventName": "UNC_B2CMI_DIRECTORY_MISS.DIRTY_I",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Miss : On Dirty Line in S State",
+        "EventCode": "0x1E",
+        "EventName": "UNC_B2CMI_DIRECTORY_MISS.DIRTY_S",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Any A2I Transition",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.A2I",
+        "PerPkg": "1",
+        "UMask": "0x320",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Any A2S Transition",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.A2S",
+        "PerPkg": "1",
+        "UMask": "0x340",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts cisgress directory updates",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.ANY",
+        "PerPkg": "1",
+        "UMask": "0x301",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts any 1lm or 2lm hit data return that wo=
uld result in directory update to non persistent memory (DRAM)",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.HIT_ANY",
+        "PerPkg": "1",
+        "UMask": "0x101",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory update in near memory to the A stat=
e",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.HIT_X2A",
+        "PerPkg": "1",
+        "UMask": "0x114",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory update in near memory to the I stat=
e",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.HIT_X2I",
+        "PerPkg": "1",
+        "UMask": "0x128",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory update in near memory to the S stat=
e",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.HIT_X2S",
+        "PerPkg": "1",
+        "UMask": "0x142",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Any I2A Transition",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.I2A",
+        "PerPkg": "1",
+        "UMask": "0x304",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Any I2S Transition",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.I2S",
+        "PerPkg": "1",
+        "UMask": "0x302",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory update in far memory to the A state=
",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.MISS_X2A",
+        "PerPkg": "1",
+        "UMask": "0x214",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory update in far memory to the I state=
",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.MISS_X2I",
+        "PerPkg": "1",
+        "UMask": "0x228",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory update in far memory to the S state=
",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.MISS_X2S",
+        "PerPkg": "1",
+        "UMask": "0x242",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Any S2A Transition",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.S2A",
+        "PerPkg": "1",
+        "UMask": "0x310",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Any S2I Transition",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.S2I",
+        "PerPkg": "1",
+        "UMask": "0x308",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory update to the A state",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.X2A",
+        "PerPkg": "1",
+        "UMask": "0x314",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory update to the I state",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.X2I",
+        "PerPkg": "1",
+        "UMask": "0x328",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory update to the S state",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.X2S",
+        "PerPkg": "1",
+        "UMask": "0x342",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts any read",
+        "EventCode": "0x24",
+        "EventName": "UNC_B2CMI_IMC_READS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x104",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts normal reads issue to CMI",
+        "EventCode": "0x24",
+        "EventName": "UNC_B2CMI_IMC_READS.NORMAL",
+        "PerPkg": "1",
+        "UMask": "0x101",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Count reads to NM region",
+        "EventCode": "0x24",
+        "EventName": "UNC_B2CMI_IMC_READS.TO_DDR_AS_CACHE",
+        "PerPkg": "1",
+        "UMask": "0x110",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts reads to 1lm non persistent memory reg=
ions",
+        "EventCode": "0x24",
+        "EventName": "UNC_B2CMI_IMC_READS.TO_DDR_AS_MEM",
+        "PerPkg": "1",
+        "UMask": "0x108",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "All Writes - All Channels",
+        "EventCode": "0x25",
+        "EventName": "UNC_B2CMI_IMC_WRITES.ALL",
+        "PerPkg": "1",
+        "UMask": "0x110",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Full Non-ISOCH - All Channels",
+        "EventCode": "0x25",
+        "EventName": "UNC_B2CMI_IMC_WRITES.FULL",
+        "PerPkg": "1",
+        "UMask": "0x101",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Non-Inclusive - All Channels",
+        "EventCode": "0x25",
+        "EventName": "UNC_B2CMI_IMC_WRITES.NI",
+        "PerPkg": "1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Non-Inclusive Miss - All Channels",
+        "EventCode": "0x25",
+        "EventName": "UNC_B2CMI_IMC_WRITES.NI_MISS",
+        "PerPkg": "1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Partial Non-ISOCH - All Channels",
+        "EventCode": "0x25",
+        "EventName": "UNC_B2CMI_IMC_WRITES.PARTIAL",
+        "PerPkg": "1",
+        "UMask": "0x102",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "DDR, acting as Cache - All Channels",
+        "EventCode": "0x25",
+        "EventName": "UNC_B2CMI_IMC_WRITES.TO_DDR_AS_CACHE",
+        "PerPkg": "1",
+        "UMask": "0x140",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "DDR - All Channels",
+        "EventCode": "0x25",
+        "EventName": "UNC_B2CMI_IMC_WRITES.TO_DDR_AS_MEM",
+        "PerPkg": "1",
+        "UMask": "0x120",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Prefetch CAM Inserts : UPI - Ch 0",
+        "EventCode": "0x56",
+        "EventName": "UNC_B2CMI_PREFCAM_INSERTS.CH0_UPI",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Prefetch CAM Inserts : XPT - Ch 0",
+        "EventCode": "0x56",
+        "EventName": "UNC_B2CMI_PREFCAM_INSERTS.CH0_XPT",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Prefetch CAM Inserts : UPI - All Channels",
+        "EventCode": "0x56",
+        "EventName": "UNC_B2CMI_PREFCAM_INSERTS.UPI_ALLCH",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Prefetch CAM Inserts : XPT -All Channels",
+        "EventCode": "0x56",
+        "EventName": "UNC_B2CMI_PREFCAM_INSERTS.XPT_ALLCH",
+        "PerPkg": "1",
+        "PublicDescription": "Prefetch CAM Inserts : XPT - All Channels",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Prefetch CAM Occupancy : Channel 0",
+        "EventCode": "0x54",
+        "EventName": "UNC_B2CMI_PREFCAM_OCCUPANCY.CH0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm reads and WRNI which were a hi=
t",
+        "EventCode": "0x1F",
+        "EventName": "UNC_B2CMI_TAG_HIT.ALL",
+        "PerPkg": "1",
+        "UMask": "0xf",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm reads which were a hit clean",
+        "EventCode": "0x1F",
+        "EventName": "UNC_B2CMI_TAG_HIT.RD_CLEAN",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm reads which were a hit dirty",
+        "EventCode": "0x1F",
+        "EventName": "UNC_B2CMI_TAG_HIT.RD_DIRTY",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm WRNI which were a hit clean",
+        "EventCode": "0x1F",
+        "EventName": "UNC_B2CMI_TAG_HIT.WR_CLEAN",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm WRNI which were a hit dirty",
+        "EventCode": "0x1F",
+        "EventName": "UNC_B2CMI_TAG_HIT.WR_DIRTY",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm second way read miss for a WrN=
I",
+        "EventCode": "0x4B",
+        "EventName": "UNC_B2CMI_TAG_MISS.CLEAN",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm second way read miss for a WrN=
I",
+        "EventCode": "0x4B",
+        "EventName": "UNC_B2CMI_TAG_MISS.DIRTY",
+        "PerPkg": "1",
+        "UMask": "0xa",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm second way read miss for a Rd"=
,
+        "EventCode": "0x4B",
+        "EventName": "UNC_B2CMI_TAG_MISS.RD_2WAY",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm reads which were a miss and th=
e cache line is unmodified",
+        "EventCode": "0x4B",
+        "EventName": "UNC_B2CMI_TAG_MISS.RD_CLEAN",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm reads which were a miss and th=
e cache line is modified",
+        "EventCode": "0x4B",
+        "EventName": "UNC_B2CMI_TAG_MISS.RD_DIRTY",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm second way read miss for a WrN=
I",
+        "EventCode": "0x4B",
+        "EventName": "UNC_B2CMI_TAG_MISS.WR_2WAY",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm WRNI which were a miss and the=
 cache line is unmodified",
+        "EventCode": "0x4B",
+        "EventName": "UNC_B2CMI_TAG_MISS.WR_CLEAN",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm WRNI which were a miss and the=
 cache line is modified",
+        "EventCode": "0x4B",
+        "EventName": "UNC_B2CMI_TAG_MISS.WR_DIRTY",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Tracker Inserts : Channel 0",
+        "EventCode": "0x32",
+        "EventName": "UNC_B2CMI_TRACKER_INSERTS.CH0",
+        "PerPkg": "1",
+        "UMask": "0x104",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Tracker Occupancy : Channel 0",
+        "EventCode": "0x33",
+        "EventName": "UNC_B2CMI_TRACKER_OCCUPANCY.CH0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Write Tracker Inserts : Channel 0",
+        "EventCode": "0x40",
+        "EventName": "UNC_B2CMI_WR_TRACKER_INSERTS.CH0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "UNC_B2HOT_CLOCKTICKS",
+        "EventCode": "0x01",
+        "EventName": "UNC_B2HOT_CLOCKTICKS",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2HOT"
+    },
+    {
+        "BriefDescription": "Number of uclks in domain",
+        "EventCode": "0x01",
+        "EventName": "UNC_B2UPI_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "B2UPI"
+    },
+    {
+        "BriefDescription": "Total Write Cache Occupancy : Mem",
+        "EventCode": "0x0F",
+        "EventName": "UNC_I_CACHE_TOTAL_OCCUPANCY.MEM",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "IRP Clockticks",
+        "EventCode": "0x01",
+        "EventName": "UNC_I_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound read requests received by the IRP and=
 inserted into the FAF queue",
+        "EventCode": "0x18",
+        "EventName": "UNC_I_FAF_INSERTS",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "FAF occupancy",
+        "EventCode": "0x19",
+        "EventName": "UNC_I_FAF_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1 : Lost Forward : Snoop pu=
lled away ownership before a write was committed",
+        "EventCode": "0x1F",
+        "EventName": "UNC_I_MISC1.LOST_FWD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound write (fast path) requests to coheren=
t memory, received by the IRP resulting in write ownership requests issued =
by IRP to the mesh.",
+        "EventCode": "0x11",
+        "EventName": "UNC_I_TRANSACTIONS.WR_PREF",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "MDF Clockticks",
+        "EventCode": "0x01",
+        "EventName": "UNC_MDF_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Number of UPI LL clock cycles while the event=
 is enabled",
+        "EventCode": "0x01",
+        "EventName": "UNC_UPI_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of kfclks",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Cycles in L1 : Number of UPI qfclk cycles spe=
nt in L1 power mode.  L1 is a mode that totally shuts down a UPI link.  Use=
 edge detect to count the number of instances when the UPI link entered L1.=
  Link power states are per link and per direction, so for example the Tx d=
irection could be in one state while Rx was in another. Because L1 totally =
shuts down the link, it takes a good amount of time to exit this mode.",
+        "EventCode": "0x21",
+        "EventName": "UNC_UPI_L1_POWER_CYCLES",
+        "PerPkg": "1",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Non-C=
oherent Bypass",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.NCB",
+        "PerPkg": "1",
+        "UMask": "0xe",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Non-C=
oherent Bypass, Match Opcode",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.NCB_OPC",
+        "PerPkg": "1",
+        "UMask": "0x10e",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Non-C=
oherent Standard",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.NCS",
+        "PerPkg": "1",
+        "UMask": "0xf",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Non-C=
oherent Standard, Match Opcode",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.NCS_OPC",
+        "PerPkg": "1",
+        "UMask": "0x10f",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Reque=
st",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.REQ",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Reque=
st, Match Opcode",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.REQ_OPC",
+        "PerPkg": "1",
+        "UMask": "0x108",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Respo=
nse - Conflict",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.RSPCNFLT",
+        "PerPkg": "1",
+        "UMask": "0x1aa",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Respo=
nse - Invalid",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.RSPI",
+        "PerPkg": "1",
+        "UMask": "0x12a",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Respo=
nse - Data",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.RSP_DATA",
+        "PerPkg": "1",
+        "UMask": "0xc",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Respo=
nse - Data, Match Opcode",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.RSP_DATA_OPC",
+        "PerPkg": "1",
+        "UMask": "0x10c",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Respo=
nse - No Data",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.RSP_NODATA",
+        "PerPkg": "1",
+        "UMask": "0xa",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Respo=
nse - No Data, Match Opcode",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.RSP_NODATA_OPC",
+        "PerPkg": "1",
+        "UMask": "0x10a",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Snoop=
",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.SNP",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Snoop=
, Match Opcode",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.SNP_OPC",
+        "PerPkg": "1",
+        "UMask": "0x109",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Write=
back",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.WB",
+        "PerPkg": "1",
+        "UMask": "0xd",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Write=
back, Match Opcode",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.WB_OPC",
+        "PerPkg": "1",
+        "UMask": "0x10d",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Received : All Data : Shows legal=
 flit time (hides impact of L0p and L0c).",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.ALL_DATA",
+        "PerPkg": "1",
+        "UMask": "0xf",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Null FLITs received from any slot",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.ALL_NULL",
+        "PerPkg": "1",
+        "PublicDescription": "Valid Flits Received : Null FLITs received f=
rom any slot",
+        "UMask": "0x27",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Received : Data : Shows legal fli=
t time (hides impact of L0p and L0c). : Count Data Flits (which consume all=
 slots), but how much to count is based on Slot0-2 mask, so count can be 0-=
3 depending on which slots are enabled for counting..",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.DATA",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Received : Idle : Shows legal fli=
t time (hides impact of L0p and L0c).",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.IDLE",
+        "PerPkg": "1",
+        "UMask": "0x47",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Received : LLCRD Not Empty : Show=
s legal flit time (hides impact of L0p and L0c). : Enables counting of LLCR=
D (with non-zero payload). This only applies to slot 2 since LLCRD is only =
allowed in slot 2",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.LLCRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Received : LLCTRL : Shows legal f=
lit time (hides impact of L0p and L0c). : Equivalent to an idle packet.  En=
ables counting of slot 0 LLCTRL messages.",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.LLCTRL",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Received : All Non Data : Shows l=
egal flit time (hides impact of L0p and L0c).",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.NON_DATA",
+        "PerPkg": "1",
+        "UMask": "0x97",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Received : Slot NULL or LLCRD Emp=
ty : Shows legal flit time (hides impact of L0p and L0c). : LLCRD with all =
zeros is treated as NULL. Slot 1 is not treated as NULL if slot 0 is a dual=
 slot. This can apply to slot 0,1, or 2.",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.NULL",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Received : Protocol Header : Show=
s legal flit time (hides impact of L0p and L0c). : Enables count of protoco=
l headers in slot 0,1,2 (depending on slot uMask bits)",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.PROTHDR",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Received : Slot 0 : Shows legal f=
lit time (hides impact of L0p and L0c). : Count Slot 0 - Other mask bits de=
termine types of headers to count.",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.SLOT0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Received : Slot 1 : Shows legal f=
lit time (hides impact of L0p and L0c). : Count Slot 1 - Other mask bits de=
termine types of headers to count.",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.SLOT1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Received : Slot 2 : Shows legal f=
lit time (hides impact of L0p and L0c). : Count Slot 2 - Other mask bits de=
termine types of headers to count.",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.SLOT2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "RxQ Flit Buffer Allocations : Slot 0 : Number=
 of allocations into the UPI Rx Flit Buffer.  Generally, when data is trans=
mitted across UPI, it will bypass the RxQ and pass directly to the ring int=
erface.  If things back up getting transmitted onto the ring, however, it m=
ay need to allocate into this buffer, thus increasing the latency.  This ev=
ent can be used in conjunction with the Flit Buffer Occupancy event in orde=
r to calculate the average flit buffer lifetime.",
+        "EventCode": "0x30",
+        "EventName": "UNC_UPI_RxL_INSERTS.SLOT0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "RxQ Flit Buffer Allocations : Slot 1 : Number=
 of allocations into the UPI Rx Flit Buffer.  Generally, when data is trans=
mitted across UPI, it will bypass the RxQ and pass directly to the ring int=
erface.  If things back up getting transmitted onto the ring, however, it m=
ay need to allocate into this buffer, thus increasing the latency.  This ev=
ent can be used in conjunction with the Flit Buffer Occupancy event in orde=
r to calculate the average flit buffer lifetime.",
+        "EventCode": "0x30",
+        "EventName": "UNC_UPI_RxL_INSERTS.SLOT1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "RxQ Flit Buffer Allocations : Slot 2 : Number=
 of allocations into the UPI Rx Flit Buffer.  Generally, when data is trans=
mitted across UPI, it will bypass the RxQ and pass directly to the ring int=
erface.  If things back up getting transmitted onto the ring, however, it m=
ay need to allocate into this buffer, thus increasing the latency.  This ev=
ent can be used in conjunction with the Flit Buffer Occupancy event in orde=
r to calculate the average flit buffer lifetime.",
+        "EventCode": "0x30",
+        "EventName": "UNC_UPI_RxL_INSERTS.SLOT2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - All Packets : Slot 0",
+        "EventCode": "0x32",
+        "EventName": "UNC_UPI_RxL_OCCUPANCY.SLOT0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - All Packets : Slot 1",
+        "EventCode": "0x32",
+        "EventName": "UNC_UPI_RxL_OCCUPANCY.SLOT1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - All Packets : Slot 2",
+        "EventCode": "0x32",
+        "EventName": "UNC_UPI_RxL_OCCUPANCY.SLOT2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Non-=
Coherent Bypass",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.NCB",
+        "PerPkg": "1",
+        "UMask": "0xe",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Non-=
Coherent Bypass, Match Opcode",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.NCB_OPC",
+        "PerPkg": "1",
+        "UMask": "0x10e",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Non-=
Coherent Standard",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.NCS",
+        "PerPkg": "1",
+        "UMask": "0xf",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Non-=
Coherent Standard, Match Opcode",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.NCS_OPC",
+        "PerPkg": "1",
+        "UMask": "0x10f",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Requ=
est",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.REQ",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Requ=
est, Match Opcode",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.REQ_OPC",
+        "PerPkg": "1",
+        "UMask": "0x108",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Resp=
onse - Conflict",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.RSPCNFLT",
+        "PerPkg": "1",
+        "UMask": "0x1aa",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Resp=
onse - Invalid",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.RSPI",
+        "PerPkg": "1",
+        "UMask": "0x12a",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Resp=
onse - Data",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.RSP_DATA",
+        "PerPkg": "1",
+        "UMask": "0xc",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Resp=
onse - Data, Match Opcode",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.RSP_DATA_OPC",
+        "PerPkg": "1",
+        "UMask": "0x10c",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Resp=
onse - No Data",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.RSP_NODATA",
+        "PerPkg": "1",
+        "UMask": "0xa",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Resp=
onse - No Data, Match Opcode",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.RSP_NODATA_OPC",
+        "PerPkg": "1",
+        "UMask": "0x10a",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Snoo=
p",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.SNP",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Snoo=
p, Match Opcode",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.SNP_OPC",
+        "PerPkg": "1",
+        "UMask": "0x109",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Writ=
eback",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.WB",
+        "PerPkg": "1",
+        "UMask": "0xd",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Writ=
eback, Match Opcode",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.WB_OPC",
+        "PerPkg": "1",
+        "UMask": "0x10d",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent : All Data : Counts number o=
f data flits across this UPI link.",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.ALL_DATA",
+        "PerPkg": "1",
+        "UMask": "0xf",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "All Null Flits",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.ALL_NULL",
+        "PerPkg": "1",
+        "PublicDescription": "Valid Flits Sent : Idle",
+        "UMask": "0x27",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent : Data : Shows legal flit ti=
me (hides impact of L0p and L0c). : Count Data Flits (which consume all slo=
ts), but how much to count is based on Slot0-2 mask, so count can be 0-3 de=
pending on which slots are enabled for counting..",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.DATA",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent : Idle : Shows legal flit ti=
me (hides impact of L0p and L0c).",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.IDLE",
+        "PerPkg": "1",
+        "UMask": "0x47",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent : LLCRD Not Empty : Shows le=
gal flit time (hides impact of L0p and L0c). : Enables counting of LLCRD (w=
ith non-zero payload). This only applies to slot 2 since LLCRD is only allo=
wed in slot 2",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.LLCRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent : LLCTRL : Shows legal flit =
time (hides impact of L0p and L0c). : Equivalent to an idle packet.  Enable=
s counting of slot 0 LLCTRL messages.",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.LLCTRL",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent : All Non Data : Shows legal=
 flit time (hides impact of L0p and L0c).",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.NON_DATA",
+        "PerPkg": "1",
+        "PublicDescription": "Valid Flits Sent : Null FLITs transmitted to=
 any slot",
+        "UMask": "0x97",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent : Slot NULL or LLCRD Empty :=
 Shows legal flit time (hides impact of L0p and L0c). : LLCRD with all zero=
s is treated as NULL. Slot 1 is not treated as NULL if slot 0 is a dual slo=
t. This can apply to slot 0,1, or 2.",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.NULL",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent : Protocol Header : Shows le=
gal flit time (hides impact of L0p and L0c). : Enables count of protocol he=
aders in slot 0,1,2 (depending on slot uMask bits)",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.PROTHDR",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent : Slot 0 : Shows legal flit =
time (hides impact of L0p and L0c). : Count Slot 0 - Other mask bits determ=
ine types of headers to count.",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.SLOT0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent : Slot 1 : Shows legal flit =
time (hides impact of L0p and L0c). : Count Slot 1 - Other mask bits determ=
ine types of headers to count.",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.SLOT1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent : Slot 2 : Shows legal flit =
time (hides impact of L0p and L0c). : Count Slot 2 - Other mask bits determ=
ine types of headers to count.",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.SLOT2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Tx Flit Buffer Allocations : Number of alloca=
tions into the UPI Tx Flit Buffer.  Generally, when data is transmitted acr=
oss UPI, it will bypass the TxQ and pass directly to the link.  However, th=
e TxQ will be used with L0p and when LLR occurs, increasing latency to tran=
sfer out to the link.  This event can be used in conjunction with the Flit =
Buffer Occupancy event in order to calculate the average flit buffer lifeti=
me.",
+        "EventCode": "0x40",
+        "EventName": "UNC_UPI_TxL_INSERTS",
+        "PerPkg": "1",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Tx Flit Buffer Occupancy : Accumulates the nu=
mber of flits in the TxQ.  Generally, when data is transmitted across UPI, =
it will bypass the TxQ and pass directly to the link.  However, the TxQ wil=
l be used with L0p and when LLR occurs, increasing latency to transfer out =
to the link. This can be used with the cycles not empty event to track aver=
age occupancy, or the allocations event to track average lifetime in the Tx=
Q.",
+        "EventCode": "0x42",
+        "EventName": "UNC_UPI_TxL_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "UPI"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-io.json b/t=
ools/perf/pmu-events/arch/x86/sierraforest/uncore-io.json
new file mode 100644
index 000000000000..9495cb0f68ea
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-io.json
@@ -0,0 +1,1634 @@
+[
+    {
+        "BriefDescription": "IIO Clockticks",
+        "EventCode": "0x01",
+        "EventName": "UNC_IIO_CLOCKTICKS",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIE Completion Buffer Inserts.  Counts once =
per 64 byte read issued from this PCIE device.",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.ALL_PARTS",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIE Completion Buffer Inserts.  Counts once =
per 64 byte read issued from this PCIE device.",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x7001004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIE Completion Buffer Inserts.  Counts once =
per 64 byte read issued from this PCIE device.",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x002",
+        "UMask": "0x7002004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIE Completion Buffer Inserts.  Counts once =
per 64 byte read issued from this PCIE device.",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x004",
+        "UMask": "0x7004004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIE Completion Buffer Inserts.  Counts once =
per 64 byte read issued from this PCIE device.",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x008",
+        "UMask": "0x7008004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIE Completion Buffer Inserts.  Counts once =
per 64 byte read issued from this PCIE device.",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x010",
+        "UMask": "0x7010004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIE Completion Buffer Inserts.  Counts once =
per 64 byte read issued from this PCIE device.",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x020",
+        "UMask": "0x7020004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIE Completion Buffer Inserts.  Counts once =
per 64 byte read issued from this PCIE device.",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x040",
+        "UMask": "0x7040004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIE Completion Buffer Inserts.  Counts once =
per 64 byte read issued from this PCIE device.",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x080",
+        "UMask": "0x7080004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Count of allocations in the completion buffer=
",
+        "EventCode": "0xD5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.ALL_PARTS",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff0ff",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Count of allocations in the completion buffer=
",
+        "EventCode": "0xD5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x7001001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Count of allocations in the completion buffer=
",
+        "EventCode": "0xD5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x002",
+        "UMask": "0x7002002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Count of allocations in the completion buffer=
",
+        "EventCode": "0xD5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x004",
+        "UMask": "0x7004004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Count of allocations in the completion buffer=
",
+        "EventCode": "0xD5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x008",
+        "UMask": "0x7008008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Count of allocations in the completion buffer=
",
+        "EventCode": "0xD5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x010",
+        "UMask": "0x7010010",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Count of allocations in the completion buffer=
",
+        "EventCode": "0xD5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x020",
+        "UMask": "0x7020020",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Count of allocations in the completion buffer=
",
+        "EventCode": "0xD5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x040",
+        "UMask": "0x7040040",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Count of allocations in the completion buffer=
",
+        "EventCode": "0xD5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x080",
+        "UMask": "0x7080080",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.ALL_PARTS",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x7001004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x002",
+        "UMask": "0x7002004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x004",
+        "UMask": "0x7004004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x008",
+        "UMask": "0x7008004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x010",
+        "UMask": "0x7010004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x020",
+        "UMask": "0x7020004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x040",
+        "UMask": "0x7040004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x080",
+        "UMask": "0x7080004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.ALL_PARTS",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x7001001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x002",
+        "UMask": "0x7002001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x004",
+        "UMask": "0x7004001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x008",
+        "UMask": "0x7008001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x010",
+        "UMask": "0x7010001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x020",
+        "UMask": "0x7020001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x040",
+        "UMask": "0x7040001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x080",
+        "UMask": "0x7080001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Another card (dif=
ferent IIO stack) reading from this card.",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.ALL_PARTS",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Another card (dif=
ferent IIO stack) writing to this card.",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.ALL_PARTS",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Counts once for every 4 bytes read from this =
card to memory.  This event does include reads to IO.",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.ALL_PARTS",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x7001004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x7002004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x7004004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x7008004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x7010004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x7020004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "UMask": "0x7040004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "UMask": "0x7080004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Counts once for every 4 bytes written from th=
is card to memory.  This event does include writes to IO.",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.ALL_PARTS",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x7001001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x7002001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x7004001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x7008001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x7010001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x7020001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "UMask": "0x7040001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "UMask": "0x7080001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 another Card (same or different stack)",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x7001008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 another Card (same or different stack)",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x002",
+        "UMask": "0x7002008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 another Card (same or different stack)",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x004",
+        "UMask": "0x7004008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 another Card (same or different stack)",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x008",
+        "UMask": "0x7008008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 another Card (same or different stack)",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x010",
+        "UMask": "0x7010008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 another Card (same or different stack)",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x020",
+        "UMask": "0x7020008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 another Card (same or different stack)",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x040",
+        "UMask": "0x7040008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 another Card (same or different stack)",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x080",
+        "UMask": "0x7080008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Counts once for every 4 bytes written from th=
is card to a peer device's IO space.",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.ALL_PARTS",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x7001002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x002",
+        "UMask": "0x7002002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x004",
+        "UMask": "0x7004002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x008",
+        "UMask": "0x7008002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x010",
+        "UMask": "0x7010002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x020",
+        "UMask": "0x7020002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x040",
+        "UMask": "0x7040002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x080",
+        "UMask": "0x7080002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "IOTLB Hits to a 1G Page",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.1G_HITS",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "IOTLB Hits to a 2M Page",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.2M_HITS",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "IOTLB Hits to a 4K Page",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.4K_HITS",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "IOTLB lookups all",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.ALL_LOOKUPS",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Context cache hits",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.CTXT_CACHE_HITS",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Context cache lookups",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.CTXT_CACHE_LOOKUPS",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "IOTLB lookups first",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.FIRST_LOOKUPS",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "IOTLB Fills (same as IOTLB miss)",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.MISSES",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "IOMMU memory access (both low and high priori=
ty)",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.NUM_MEM_ACCESSES",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0xc0",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "IOMMU high priority memory access",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.NUM_MEM_ACCESSES_HIGH",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "IOMMU low priority memory access",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.NUM_MEM_ACCESSES_LOW",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Second Level Page Walk Cache Hit to a 1G page=
",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.SLPWC_1G_HITS",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Second Level Page Walk Cache Hit to a 256T pa=
ge",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.SLPWC_256T_HITS",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Second Level Page Walk Cache Hit to a 2M page=
",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.SLPWC_2M_HITS",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Second Level Page Walk Cache Hit to a 512G pa=
ge",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.SLPWC_512G_HITS",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Second Level Page Walk Cache fill",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.SLPWC_CACHE_FILLS",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Second Level Page Walk Cache lookup",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.SLPWC_CACHE_LOOKUPS",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Cycles PWT full",
+        "EventCode": "0x43",
+        "EventName": "UNC_IIO_IOMMU3.CYC_PWT_FULL",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Interrupt Entry cache hit",
+        "EventCode": "0x43",
+        "EventName": "UNC_IIO_IOMMU3.INT_CACHE_HITS",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Interrupt Entry cache lookup",
+        "EventCode": "0x43",
+        "EventName": "UNC_IIO_IOMMU3.INT_CACHE_LOOKUPS",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Context Cache invalidation events",
+        "EventCode": "0x43",
+        "EventName": "UNC_IIO_IOMMU3.NUM_INVAL_CTXT_CACHE",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Interrupt Entry Cache invalidation events",
+        "EventCode": "0x43",
+        "EventName": "UNC_IIO_IOMMU3.NUM_INVAL_INT_CACHE",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "IOTLB invalidation events",
+        "EventCode": "0x43",
+        "EventName": "UNC_IIO_IOMMU3.NUM_INVAL_IOTLB",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PASID Cache invalidation events",
+        "EventCode": "0x43",
+        "EventName": "UNC_IIO_IOMMU3.NUM_INVAL_PASID_CACHE",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Occupancy of outbound request queue : To devi=
ce : Counts number of outbound requests/completions IIO is currently proces=
sing",
+        "EventCode": "0xc5",
+        "EventName": "UNC_IIO_NUM_OUSTANDING_REQ_FROM_CPU.TO_IO",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Passing data to be written",
+        "EventCode": "0x88",
+        "EventName": "UNC_IIO_NUM_OUTSTANDING_REQ_OF_CPU.DATA",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x700f020",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Issuing final read or write of line",
+        "EventCode": "0x88",
+        "EventName": "UNC_IIO_NUM_OUTSTANDING_REQ_OF_CPU.FINAL_RD_WR",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x700f008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Processing response from IOMMU",
+        "EventCode": "0x88",
+        "EventName": "UNC_IIO_NUM_OUTSTANDING_REQ_OF_CPU.IOMMU_HIT",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x700f002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Issuing to IOMMU",
+        "EventCode": "0x88",
+        "EventName": "UNC_IIO_NUM_OUTSTANDING_REQ_OF_CPU.IOMMU_REQ",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x700f001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Request Ownership",
+        "EventCode": "0x88",
+        "EventName": "UNC_IIO_NUM_OUTSTANDING_REQ_OF_CPU.REQ_OWN",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x700f004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Writing line",
+        "EventCode": "0x88",
+        "EventName": "UNC_IIO_NUM_OUTSTANDING_REQ_OF_CPU.WR",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x700f010",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "-",
+        "EventCode": "0x8e",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.ABORT",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff080",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "-",
+        "EventCode": "0x8e",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.CONFINED_P2P",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff040",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "-",
+        "EventCode": "0x8e",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.LOC_P2P",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff020",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "-",
+        "EventCode": "0x8e",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.MCAST",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "-",
+        "EventCode": "0x8e",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.MEM",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "-",
+        "EventCode": "0x8e",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.MSGB",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "-",
+        "EventCode": "0x8e",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.REM_P2P",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff010",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "-",
+        "EventCode": "0x8e",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.UBOX",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "All 9 bits of Page Walk Tracker Occupancy",
+        "EventCode": "0x42",
+        "EventName": "UNC_IIO_PWT_OCCUPANCY",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.ALL_PARTS",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x7001004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x002",
+        "UMask": "0x7002004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x004",
+        "UMask": "0x7004004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x008",
+        "UMask": "0x7008004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x010",
+        "UMask": "0x7010004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x020",
+        "UMask": "0x7020004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x040",
+        "UMask": "0x7040004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x080",
+        "UMask": "0x7080004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.ALL_PARTS",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x7001001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x002",
+        "UMask": "0x7002001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x004",
+        "UMask": "0x7004001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x008",
+        "UMask": "0x7008001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x010",
+        "UMask": "0x7010001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x020",
+        "UMask": "0x7020001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x040",
+        "UMask": "0x7040001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x080",
+        "UMask": "0x7080001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : An=
other card (different IIO stack) reading from this card.",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.ALL_PARTS",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : An=
other card (different IIO stack) writing to this card.",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.ALL_PARTS",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x70ff002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x7001004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x002",
+        "UMask": "0x7002004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x004",
+        "UMask": "0x7004004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x008",
+        "UMask": "0x7008004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x010",
+        "UMask": "0x7010004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x020",
+        "UMask": "0x7020004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x040",
+        "UMask": "0x7040004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x080",
+        "UMask": "0x7080004",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x7001001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x002",
+        "UMask": "0x7002001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x004",
+        "UMask": "0x7004001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x008",
+        "UMask": "0x7008001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x010",
+        "UMask": "0x7010001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x020",
+        "UMask": "0x7020001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x040",
+        "UMask": "0x7040001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x080",
+        "UMask": "0x7080001",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from another Card (same or different stack)",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x7001008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from another Card (same or different stack)",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x002",
+        "UMask": "0x7002008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from another Card (same or different stack)",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x004",
+        "UMask": "0x7004008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from another Card (same or different stack)",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x008",
+        "UMask": "0x7008008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from another Card (same or different stack)",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x010",
+        "UMask": "0x7010008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from another Card (same or different stack)",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x020",
+        "UMask": "0x7020008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from another Card (same or different stack)",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x040",
+        "UMask": "0x7040008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from another Card (same or different stack)",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x080",
+        "UMask": "0x7080008",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x7001002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x002",
+        "UMask": "0x7002002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x004",
+        "UMask": "0x7004002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x008",
+        "UMask": "0x7008002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x010",
+        "UMask": "0x7010002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x020",
+        "UMask": "0x7020002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x040",
+        "UMask": "0x7040002",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x080",
+        "UMask": "0x7080002",
+        "Unit": "IIO"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-memory.json=
 b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-memory.json
new file mode 100644
index 000000000000..a2405ed640c9
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-memory.json
@@ -0,0 +1,385 @@
+[
+    {
+        "BriefDescription": "DRAM Activate Count : Counts the number of DR=
AM Activate commands sent on this channel.  Activate commands are issued to=
 open up a page on the DRAM devices so that it can be read or written to wi=
th a CAS.  One can calculate the number of Page Misses by subtracting the n=
umber of Page Miss precharges from the number of Activates.",
+        "EventCode": "0x02",
+        "EventName": "UNC_M_ACT_COUNT.ALL",
+        "PerPkg": "1",
+        "UMask": "0xf7",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "DRAM Activate Count : Read transaction on Pag=
e Empty or Page Miss : Counts the number of DRAM Activate commands sent on =
this channel.  Activate commands are issued to open up a page on the DRAM d=
evices so that it can be read or written to with a CAS.  One can calculate =
the number of Page Misses by subtracting the number of Page Miss precharges=
 from the number of Activates.",
+        "EventCode": "0x02",
+        "EventName": "UNC_M_ACT_COUNT.RD",
+        "PerPkg": "1",
+        "UMask": "0xf1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "DRAM Activate Count : Underfill Read transact=
ion on Page Empty or Page Miss : Counts the number of DRAM Activate command=
s sent on this channel.  Activate commands are issued to open up a page on =
the DRAM devices so that it can be read or written to with a CAS.  One can =
calculate the number of Page Misses by subtracting the number of Page Miss =
precharges from the number of Activates.",
+        "EventCode": "0x02",
+        "EventName": "UNC_M_ACT_COUNT.UFILL",
+        "PerPkg": "1",
+        "UMask": "0xf4",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "DRAM Activate Count : Write transaction on Pa=
ge Empty or Page Miss : Counts the number of DRAM Activate commands sent on=
 this channel.  Activate commands are issued to open up a page on the DRAM =
devices so that it can be read or written to with a CAS.  One can calculate=
 the number of Page Misses by subtracting the number of Page Miss precharge=
s from the number of Activates.",
+        "EventCode": "0x02",
+        "EventName": "UNC_M_ACT_COUNT.WR",
+        "PerPkg": "1",
+        "UMask": "0xf2",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 0, all CAS operation=
s",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT_SCH0.ALL",
+        "PerPkg": "1",
+        "UMask": "0xff",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 0, all reads",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT_SCH0.RD",
+        "PerPkg": "1",
+        "UMask": "0xcf",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 0 regular reads",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT_SCH0.RD_REG",
+        "PerPkg": "1",
+        "UMask": "0xc1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 0 underfill reads",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT_SCH0.RD_UNDERFILL",
+        "PerPkg": "1",
+        "UMask": "0xc4",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 0, all writes",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT_SCH0.WR",
+        "PerPkg": "1",
+        "UMask": "0xf0",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 0 regular writes",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT_SCH0.WR_NONPRE",
+        "PerPkg": "1",
+        "UMask": "0xd0",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 0 auto-precharge wri=
tes",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT_SCH0.WR_PRE",
+        "PerPkg": "1",
+        "UMask": "0xe0",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 1, all CAS operation=
s",
+        "EventCode": "0x06",
+        "EventName": "UNC_M_CAS_COUNT_SCH1.ALL",
+        "PerPkg": "1",
+        "UMask": "0xff",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 1, all reads",
+        "EventCode": "0x06",
+        "EventName": "UNC_M_CAS_COUNT_SCH1.RD",
+        "PerPkg": "1",
+        "UMask": "0xcf",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 1 regular reads",
+        "EventCode": "0x06",
+        "EventName": "UNC_M_CAS_COUNT_SCH1.RD_REG",
+        "PerPkg": "1",
+        "UMask": "0xc1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 1 underfill reads",
+        "EventCode": "0x06",
+        "EventName": "UNC_M_CAS_COUNT_SCH1.RD_UNDERFILL",
+        "PerPkg": "1",
+        "UMask": "0xc4",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 1, all writes",
+        "EventCode": "0x06",
+        "EventName": "UNC_M_CAS_COUNT_SCH1.WR",
+        "PerPkg": "1",
+        "UMask": "0xf0",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 1 regular writes",
+        "EventCode": "0x06",
+        "EventName": "UNC_M_CAS_COUNT_SCH1.WR_NONPRE",
+        "PerPkg": "1",
+        "UMask": "0xd0",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 1 auto-precharge wri=
tes",
+        "EventCode": "0x06",
+        "EventName": "UNC_M_CAS_COUNT_SCH1.WR_PRE",
+        "PerPkg": "1",
+        "UMask": "0xe0",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Number of DRAM DCLK clock cycles while the ev=
ent is enabled",
+        "EventCode": "0x01",
+        "EventName": "UNC_M_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "DRAM Clockticks",
+        "UMask": "0x1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Number of DRAM HCLK clock cycles while the ev=
ent is enabled",
+        "EventCode": "0x01",
+        "EventName": "UNC_M_HCLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "DRAM Clockticks",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "DRAM Precharge commands. : Counts the number =
of DRAM Precharge commands sent on this channel.",
+        "EventCode": "0x03",
+        "EventName": "UNC_M_PRE_COUNT.ALL",
+        "PerPkg": "1",
+        "UMask": "0xff",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "DRAM Precharge commands. : Precharge due to (=
?) : Counts the number of DRAM Precharge commands sent on this channel.",
+        "EventCode": "0x03",
+        "EventName": "UNC_M_PRE_COUNT.PGT",
+        "PerPkg": "1",
+        "UMask": "0xf8",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "DRAM Precharge commands. : Counts the number =
of DRAM Precharge commands sent on this channel.",
+        "EventCode": "0x03",
+        "EventName": "UNC_M_PRE_COUNT.RD",
+        "PerPkg": "1",
+        "UMask": "0xf1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "DRAM Precharge commands. : Counts the number =
of DRAM Precharge commands sent on this channel.",
+        "EventCode": "0x03",
+        "EventName": "UNC_M_PRE_COUNT.UFILL",
+        "PerPkg": "1",
+        "UMask": "0xf4",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "DRAM Precharge commands. : Counts the number =
of DRAM Precharge commands sent on this channel.",
+        "EventCode": "0x03",
+        "EventName": "UNC_M_PRE_COUNT.WR",
+        "PerPkg": "1",
+        "UMask": "0xf2",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read buffer inserts on subchannel 0",
+        "EventCode": "0x17",
+        "EventName": "UNC_M_RDB_INSERTS.SCH0",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read buffer inserts on subchannel 1",
+        "EventCode": "0x17",
+        "EventName": "UNC_M_RDB_INSERTS.SCH1",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read buffer occupancy on subchannel 0",
+        "EventCode": "0x1a",
+        "EventName": "UNC_M_RDB_OCCUPANCY_SCH0",
+        "PerPkg": "1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read buffer occupancy on subchannel 1",
+        "EventCode": "0x1b",
+        "EventName": "UNC_M_RDB_OCCUPANCY_SCH1",
+        "PerPkg": "1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read Pending Queue Allocations : Counts the n=
umber of allocations into the Read Pending Queue.  This queue is used to sc=
hedule reads out to the memory controller and to track the requests.  Reque=
sts allocate into the RPQ soon after they enter the memory controller, and =
need credits for an entry in this buffer before being sent from the HA to t=
he iMC.  They deallocate after the CAS command has been issued to memory.  =
This includes both ISOCH and non-ISOCH requests.",
+        "EventCode": "0x10",
+        "EventName": "UNC_M_RPQ_INSERTS.PCH0",
+        "PerPkg": "1",
+        "UMask": "0x50",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read Pending Queue Allocations : Counts the n=
umber of allocations into the Read Pending Queue.  This queue is used to sc=
hedule reads out to the memory controller and to track the requests.  Reque=
sts allocate into the RPQ soon after they enter the memory controller, and =
need credits for an entry in this buffer before being sent from the HA to t=
he iMC.  They deallocate after the CAS command has been issued to memory.  =
This includes both ISOCH and non-ISOCH requests.",
+        "EventCode": "0x10",
+        "EventName": "UNC_M_RPQ_INSERTS.PCH1",
+        "PerPkg": "1",
+        "UMask": "0xa0",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read Pending Queue inserts for subchannel 0, =
pseudochannel 0",
+        "EventCode": "0x10",
+        "EventName": "UNC_M_RPQ_INSERTS.SCH0_PCH0",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read Pending Queue inserts for subchannel 0, =
pseudochannel 1",
+        "EventCode": "0x10",
+        "EventName": "UNC_M_RPQ_INSERTS.SCH0_PCH1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read Pending Queue inserts for subchannel 1, =
pseudochannel 0",
+        "EventCode": "0x10",
+        "EventName": "UNC_M_RPQ_INSERTS.SCH1_PCH0",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read Pending Queue inserts for subchannel 1, =
pseudochannel 1",
+        "EventCode": "0x10",
+        "EventName": "UNC_M_RPQ_INSERTS.SCH1_PCH1",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read pending queue occupancy for subchannel 0=
, pseudochannel 0",
+        "EventCode": "0x80",
+        "EventName": "UNC_M_RPQ_OCCUPANCY_SCH0_PCH0",
+        "PerPkg": "1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read pending queue occupancy for subchannel 0=
, pseudochannel 1",
+        "EventCode": "0x81",
+        "EventName": "UNC_M_RPQ_OCCUPANCY_SCH0_PCH1",
+        "PerPkg": "1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read pending queue occupancy for subchannel 1=
, pseudochannel 0",
+        "EventCode": "0x82",
+        "EventName": "UNC_M_RPQ_OCCUPANCY_SCH1_PCH0",
+        "PerPkg": "1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read pending queue occupancy for subchannel 1=
, pseudochannel 1",
+        "EventCode": "0x83",
+        "EventName": "UNC_M_RPQ_OCCUPANCY_SCH1_PCH1",
+        "PerPkg": "1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue Allocations",
+        "EventCode": "0x22",
+        "EventName": "UNC_M_WPQ_INSERTS.PCH0",
+        "PerPkg": "1",
+        "UMask": "0x50",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue Allocations",
+        "EventCode": "0x22",
+        "EventName": "UNC_M_WPQ_INSERTS.PCH1",
+        "PerPkg": "1",
+        "UMask": "0xa0",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue inserts for subchannel 0,=
 pseudochannel 0",
+        "EventCode": "0x22",
+        "EventName": "UNC_M_WPQ_INSERTS.SCH0_PCH0",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue inserts for subchannel 0,=
 pseudochannel 1",
+        "EventCode": "0x22",
+        "EventName": "UNC_M_WPQ_INSERTS.SCH0_PCH1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue inserts for subchannel 1,=
 pseudochannel 0",
+        "EventCode": "0x22",
+        "EventName": "UNC_M_WPQ_INSERTS.SCH1_PCH0",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue inserts for subchannel 1,=
 pseudochannel 1",
+        "EventCode": "0x22",
+        "EventName": "UNC_M_WPQ_INSERTS.SCH1_PCH1",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Write pending queue occupancy for subchannel =
0, pseudochannel 0",
+        "EventCode": "0x84",
+        "EventName": "UNC_M_WPQ_OCCUPANCY_SCH0_PCH0",
+        "PerPkg": "1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Write pending queue occupancy for subchannel =
0, pseudochannel 1",
+        "EventCode": "0x85",
+        "EventName": "UNC_M_WPQ_OCCUPANCY_SCH0_PCH1",
+        "PerPkg": "1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Write pending queue occupancy for subchannel =
1, pseudochannel 0",
+        "EventCode": "0x86",
+        "EventName": "UNC_M_WPQ_OCCUPANCY_SCH1_PCH0",
+        "PerPkg": "1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Write pending queue occupancy for subchannel =
1, pseudochannel 1",
+        "EventCode": "0x87",
+        "EventName": "UNC_M_WPQ_OCCUPANCY_SCH1_PCH1",
+        "PerPkg": "1",
+        "Unit": "IMC"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-power.json =
b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-power.json
new file mode 100644
index 000000000000..e3a66166e28c
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-power.json
@@ -0,0 +1,10 @@
+[
+    {
+        "BriefDescription": "PCU Clockticks",
+        "EventCode": "0x01",
+        "EventName": "UNC_P_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "PCU Clockticks:  The PCU runs off a fixed 1 =
GHz clock.  This event counts the number of pclk cycles measured while the =
counter was enabled.  The pclk, like the Memory Controller's dclk, counts a=
t a constant rate making it a good measure of actual wall time.",
+        "Unit": "PCU"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/virtual-memory.jso=
n b/tools/perf/pmu-events/arch/x86/sierraforest/virtual-memory.json
index bd5f2b634c98..371974c6d6c3 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/virtual-memory.json
@@ -1,18 +1,94 @@
 [
     {
-        "BriefDescription": "Counts the number of page walks completed due=
 to load DTLB misses to a 1G page.",
+        "BriefDescription": "Counts the number of first level TLB misses b=
ut second level hits due to a demand load that did not start a page walk. A=
ccounts for all page sizes. Will result in a DTLB write from STLB.",
+        "EventCode": "0x08",
+        "EventName": "DTLB_LOAD_MISSES.STLB_HIT",
+        "SampleAfterValue": "200003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Counts the number of page walks completed due=
 to load DTLB misses.",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
-        "SampleAfterValue": "1000003",
+        "SampleAfterValue": "200003",
         "UMask": "0xe"
     },
+    {
+        "BriefDescription": "Counts the number of page walks completed due=
 to load DTLB misses to a 2M or 4M page.",
+        "EventCode": "0x08",
+        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M",
+        "PublicDescription": "Counts the number of page walks completed du=
e to loads (including SW prefetches) whose address translations missed in a=
ll Translation Lookaside Buffer (TLB) levels and were mapped to 2M or 4M pa=
ges. Includes page walks that page fault.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the number of page walks completed due=
 to load DTLB misses to a 4K page.",
+        "EventCode": "0x08",
+        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_4K",
+        "PublicDescription": "Counts the number of page walks completed du=
e to loads (including SW prefetches) whose address translations missed in a=
ll Translation Lookaside Buffer (TLB) levels and were mapped to 4K pages. I=
ncludes page walks that page fault.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of page walks outstanding f=
or Loads (demand or SW prefetch) in PMH every cycle.",
+        "EventCode": "0x08",
+        "EventName": "DTLB_LOAD_MISSES.WALK_PENDING",
+        "PublicDescription": "Counts the number of page walks outstanding =
for Loads (demand or SW prefetch) in PMH every cycle.  A PMH page walk is o=
utstanding from page walk start till PMH becomes idle again (ready to serve=
 next walk). Includes EPT-walk intervals.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts the number of first level TLB misses b=
ut second level hits due to stores that did not start a page walk. Accounts=
 for all pages sizes. Will result in a DTLB write from STLB.",
+        "EventCode": "0x49",
+        "EventName": "DTLB_STORE_MISSES.STLB_HIT",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x20"
+    },
     {
         "BriefDescription": "Counts the number of page walks completed due=
 to store DTLB misses to a 1G page.",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
-        "SampleAfterValue": "1000003",
+        "SampleAfterValue": "2000003",
         "UMask": "0xe"
     },
+    {
+        "BriefDescription": "Counts the number of page walks completed due=
 to store DTLB misses to a 2M or 4M page.",
+        "EventCode": "0x49",
+        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M",
+        "PublicDescription": "Counts the number of page walks completed du=
e to stores whose address translations missed in all Translation Lookaside =
Buffer (TLB) levels and were mapped to 2M or 4M pages.  Includes page walks=
 that page fault.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the number of page walks completed due=
 to store DTLB misses to a 4K page.",
+        "EventCode": "0x49",
+        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_4K",
+        "PublicDescription": "Counts the number of page walks completed du=
e to stores whose address translations missed in all Translation Lookaside =
Buffer (TLB) levels and were mapped to 4K pages.  Includes page walks that =
page fault.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of page walks outstanding i=
n the page miss handler (PMH) for stores every cycle.",
+        "EventCode": "0x49",
+        "EventName": "DTLB_STORE_MISSES.WALK_PENDING",
+        "PublicDescription": "Counts the number of page walks outstanding =
in the page miss handler (PMH) for stores every cycle. A PMH page walk is o=
utstanding from page walk start till PMH becomes idle again (ready to serve=
 next walk). Includes EPT-walk intervals.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts the number of page walks initiated by =
a instruction fetch that missed the first and second level TLBs.",
+        "EventCode": "0x85",
+        "EventName": "ITLB_MISSES.MISS_CAUSED_WALK",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of first level TLB misses b=
ut second level hits due to an instruction fetch that did not start a page =
walk. Account for all pages sizes. Will result in an ITLB write from STLB."=
,
+        "EventCode": "0x85",
+        "EventName": "ITLB_MISSES.STLB_HIT",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x20"
+    },
     {
         "BriefDescription": "Counts the number of page walks completed due=
 to instruction fetch misses to any page size.",
         "EventCode": "0x85",
@@ -20,5 +96,36 @@
         "PublicDescription": "Counts the number of page walks completed du=
e to instruction fetches whose address translations missed in all Translati=
on Lookaside Buffer (TLB) levels and were mapped to any page size.  Include=
s page walks that page fault.",
         "SampleAfterValue": "200003",
         "UMask": "0xe"
+    },
+    {
+        "BriefDescription": "Counts the number of page walks completed due=
 to instruction fetch misses to a 2M or 4M page.",
+        "EventCode": "0x85",
+        "EventName": "ITLB_MISSES.WALK_COMPLETED_2M_4M",
+        "PublicDescription": "Counts the number of page walks completed du=
e to instruction fetches whose address translations missed in all Translati=
on Lookaside Buffer (TLB) levels and were mapped to 2M or 4M pages.  Includ=
es page walks that page fault.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the number of page walks completed due=
 to instruction fetch misses to a 4K page.",
+        "EventCode": "0x85",
+        "EventName": "ITLB_MISSES.WALK_COMPLETED_4K",
+        "PublicDescription": "Counts the number of page walks completed du=
e to instruction fetches whose address translations missed in all Translati=
on Lookaside Buffer (TLB) levels and were mapped to 4K pages.  Includes pag=
e walks that page fault.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of page walks outstanding f=
or iside in PMH every cycle.",
+        "EventCode": "0x85",
+        "EventName": "ITLB_MISSES.WALK_PENDING",
+        "PublicDescription": "Counts the number of page walks outstanding =
for iside in PMH every cycle.  A PMH page walk is outstanding from page wal=
k start till PMH becomes idle again (ready to serve next walk). Includes EP=
T-walk intervals.  Walks could be counted by edge detecting on this event, =
but would count restarted suspended walks.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to a DTLB=
 miss.",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.DTLB_MISS_AT_RET",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x90"
     }
 ]
--=20
2.43.0.687.g38aa6559b0-goog


