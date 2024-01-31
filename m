Return-Path: <linux-kernel+bounces-47053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CA6844887
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900AD284C01
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049523FB28;
	Wed, 31 Jan 2024 20:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uynVu288"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F163EA94
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 20:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732082; cv=none; b=ou2/gCPrwegnGiqF15tMhaUbBZ5YtiXfo6UO4JJk/1j9dyi2vSAaMACViaFf7bXzaA7p0Y22jnLgcrE7TQjQVUa/1m/O33jLYzm2Fx1eKIMNLMHuT+den/b40jujYeDFwQxRKh4E7DaHtIsDzBMCaTS6SDf9vbL6nUub5ncttPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732082; c=relaxed/simple;
	bh=Ax5JEIPjw4jWPtHEm7pQrjMLSrDe/wM672XsGNmMJ/0=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=jDJcWexvJiQaJj8QCigbUmnnEpX8xD1WXa4o3QN48scdx+NUW9CBLU0VYbknVGzXaSRvXCWI73AnHTCPnoWTzXTR6KDcvNhL1pfQATk0JA1peIYVFl+81r7QsjIrco6Czjm58xNkjs6Byf0d0HXFV965M5VuvcOXj/fq59dLUsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uynVu288; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-604000fefccso2791547b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706732078; x=1707336878; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e2rDkqb+E2xnp8mp8D2lOafAWaTbfc+6G88WUXMkCnU=;
        b=uynVu288tuT6FM9IUjM89aS+6yNJbrhQ9ePKfKm2pzhiNhuMjVZU3Dj0CSSCcIiyaO
         HsEDTIc9Q/z9RJgWfz46lEkCcmSx2VmiKNKS+EWZ+9Ttz6NuYBEIAV/30l+89NqQDsHg
         gtI3BBgCMjmfQrKSKYj6OBXlDA+bO1F6xtG9O4pON+68N/326cXIqLfcujK6J/EIF3Wb
         Bn5K0HpOXoYjeua2ET+Us13Yg1c01qFuJDpICEWOXHXJxVuZZ9ruFt9aS68j8FVnbGG1
         jYG4UEepdhyIH8CkOKCdm2Cvxgpyr2ctJgrDBkH3QFI4Oc2s2pDcIl2XJHIKn9Xl/QnL
         68Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706732078; x=1707336878;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e2rDkqb+E2xnp8mp8D2lOafAWaTbfc+6G88WUXMkCnU=;
        b=n7iprYKl0l7fbTDx5z0OKFvJxLWILLmQtO/+QjFZ1cgsA6uxZR7EZgiqTfu88TAgj3
         yrZlhrNkozhqFh5K3UqG/1CMs8rqxshSPZtl1msESyW90JK8WLYlAbKIh4tY6MQb0moU
         RH7UgnO09NI1aZk8GgPArC2UzJLFP3TY3+6O36hNOf88IWT9LnvQLDkrtp7/i7YQa5P5
         L+Hfm0B0qrtaTJXrMFQT8HXBZJUQ3Sw26X2cQl5zO5DAFG6O7yg86yX9L8TyhIx58HZd
         I2D32LK4S0ltD7waaY8lFZolH3Yys0a2SMfw24eXWeJxcQ71i6liE7BdoRTUAxluzWcS
         krsw==
X-Gm-Message-State: AOJu0YySsPcuDhiSoOEU6QchmfWwyCnnoEQo/4Azogab1RiapdXaQBOC
	rNJHV1eXygTsAb6d+GNXteRSfxYMX5b05wT5VIHvhbcIHkTNm8lrsvKeCZ5QQ9zu7polrMPHT3S
	yLGS0sQ==
X-Google-Smtp-Source: AGHT+IFkL/HMYecG4pjlmM4yPPuHGrpUEc/72BDkAeeoCz3jqncXNV5/D+bTqDzVyiVwPgHnDVcvwQwGIfR7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:16c5:1feb:bf99:a5d1])
 (user=irogers job=sendgmr) by 2002:a05:690c:f85:b0:5f9:abfe:243c with SMTP id
 df5-20020a05690c0f8500b005f9abfe243cmr424360ywb.3.1706732078491; Wed, 31 Jan
 2024 12:14:38 -0800 (PST)
Date: Wed, 31 Jan 2024 12:14:29 -0800
Message-Id: <20240131201429.792138-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v1] perf jevents: Drop or simplify small integer values
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Weilin Wang <weilin.wang@intel.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Michael Petlan <mpetlan@redhat.com>, Edward Baker <edward.baker@intel.com>, 
	Perry Taylor <perry.taylor@intel.com>
Content-Type: text/plain; charset="UTF-8"

Prior to this patch '0' would be dropped as the config values default
to 0. Some json values are hex and the string '0' wouldn't match '0x0'
as zero. Add a more robust is_zero test to drop these event terms.

When encoding numbers as hex, if the number is between 0 and 9
inclusive then don't add a 0x prefix.

Update test expectations for these changes.

On x86 this reduces the event/metric C string by 58,411 bytes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 23 ++++++++++++++++++++---
 tools/perf/tests/pmu-events.c    | 22 +++++++++++-----------
 2 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 53ab050c8fa4..2c7e5d61ce92 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -203,7 +203,7 @@ class JsonEvent:
 
     def llx(x: int) -> str:
       """Convert an int to a string similar to a printf modifier of %#llx."""
-      return '0' if x == 0 else hex(x)
+      return str(x) if x >= 0 and x < 10 else hex(x)
 
     def fixdesc(s: str) -> str:
       """Fix formatting issue for the desc string."""
@@ -294,6 +294,23 @@ class JsonEvent:
       }
       return table[unit] if unit in table else f'uncore_{unit.lower()}'
 
+    def is_zero(val: str) -> bool:
+        try:
+            if val.startswith('0x'):
+                return int(val, 16) == 0
+            else:
+                return int(val) == 0
+        except e:
+            return False
+
+    def canonicalize_value(val: str) -> str:
+        try:
+            if val.startswith('0x'):
+                return llx(int(val, 16))
+            return str(int(val))
+        except e:
+            return val
+
     eventcode = 0
     if 'EventCode' in jd:
       eventcode = int(jd['EventCode'].split(',', 1)[0], 0)
@@ -358,8 +375,8 @@ class JsonEvent:
         ('RdWrMask', 'rdwrmask='),
     ]
     for key, value in event_fields:
-      if key in jd and jd[key] != '0':
-        event += ',' + value + jd[key]
+      if key in jd and not is_zero(jd[key]):
+        event += f',{value}{canonicalize_value(jd[key])}'
     if filter:
       event += f',{filter}'
     if msr:
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index a56d32905743..47a7c3277540 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -70,7 +70,7 @@ static const struct perf_pmu_test_event segment_reg_loads_any = {
 	.event = {
 		.pmu = "default_core",
 		.name = "segment_reg_loads.any",
-		.event = "event=0x6,period=200000,umask=0x80",
+		.event = "event=6,period=200000,umask=0x80",
 		.desc = "Number of segment register loads",
 		.topic = "other",
 	},
@@ -82,7 +82,7 @@ static const struct perf_pmu_test_event dispatch_blocked_any = {
 	.event = {
 		.pmu = "default_core",
 		.name = "dispatch_blocked.any",
-		.event = "event=0x9,period=200000,umask=0x20",
+		.event = "event=9,period=200000,umask=0x20",
 		.desc = "Memory cluster signals to block micro-op dispatch for any reason",
 		.topic = "other",
 	},
@@ -94,11 +94,11 @@ static const struct perf_pmu_test_event eist_trans = {
 	.event = {
 		.pmu = "default_core",
 		.name = "eist_trans",
-		.event = "event=0x3a,period=200000,umask=0x0",
+		.event = "event=0x3a,period=200000",
 		.desc = "Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions",
 		.topic = "other",
 	},
-	.alias_str = "event=0x3a,period=0x30d40,umask=0",
+	.alias_str = "event=0x3a,period=0x30d40",
 	.alias_long_desc = "Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions",
 };
 
@@ -128,7 +128,7 @@ static const struct perf_pmu_test_event *core_events[] = {
 static const struct perf_pmu_test_event uncore_hisi_ddrc_flux_wcmd = {
 	.event = {
 		.name = "uncore_hisi_ddrc.flux_wcmd",
-		.event = "event=0x2",
+		.event = "event=2",
 		.desc = "DDRC write commands",
 		.topic = "uncore",
 		.long_desc = "DDRC write commands",
@@ -156,13 +156,13 @@ static const struct perf_pmu_test_event unc_cbo_xsnp_response_miss_eviction = {
 static const struct perf_pmu_test_event uncore_hyphen = {
 	.event = {
 		.name = "event-hyphen",
-		.event = "event=0xe0,umask=0x00",
+		.event = "event=0xe0",
 		.desc = "UNC_CBO_HYPHEN",
 		.topic = "uncore",
 		.long_desc = "UNC_CBO_HYPHEN",
 		.pmu = "uncore_cbox",
 	},
-	.alias_str = "event=0xe0,umask=0",
+	.alias_str = "event=0xe0",
 	.alias_long_desc = "UNC_CBO_HYPHEN",
 	.matching_pmu = "uncore_cbox_0",
 };
@@ -170,13 +170,13 @@ static const struct perf_pmu_test_event uncore_hyphen = {
 static const struct perf_pmu_test_event uncore_two_hyph = {
 	.event = {
 		.name = "event-two-hyph",
-		.event = "event=0xc0,umask=0x00",
+		.event = "event=0xc0",
 		.desc = "UNC_CBO_TWO_HYPH",
 		.topic = "uncore",
 		.long_desc = "UNC_CBO_TWO_HYPH",
 		.pmu = "uncore_cbox",
 	},
-	.alias_str = "event=0xc0,umask=0",
+	.alias_str = "event=0xc0",
 	.alias_long_desc = "UNC_CBO_TWO_HYPH",
 	.matching_pmu = "uncore_cbox_0",
 };
@@ -184,7 +184,7 @@ static const struct perf_pmu_test_event uncore_two_hyph = {
 static const struct perf_pmu_test_event uncore_hisi_l3c_rd_hit_cpipe = {
 	.event = {
 		.name = "uncore_hisi_l3c.rd_hit_cpipe",
-		.event = "event=0x7",
+		.event = "event=7",
 		.desc = "Total read hits",
 		.topic = "uncore",
 		.long_desc = "Total read hits",
@@ -265,7 +265,7 @@ static const struct perf_pmu_test_event sys_ccn_pmu_read_cycles = {
 static const struct perf_pmu_test_event sys_cmn_pmu_hnf_cache_miss = {
 	.event = {
 		.name = "sys_cmn_pmu.hnf_cache_miss",
-		.event = "eventid=0x1,type=0x5",
+		.event = "eventid=1,type=5",
 		.desc = "Counts total cache misses in first lookup result (high priority)",
 		.topic = "uncore",
 		.pmu = "uncore_sys_cmn_pmu",
-- 
2.43.0.429.g432eaa2c6b-goog


