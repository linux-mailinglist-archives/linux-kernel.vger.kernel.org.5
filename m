Return-Path: <linux-kernel+bounces-113397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B60A1888400
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E292528546B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1021A3787;
	Sun, 24 Mar 2024 22:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpP4OYIq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF2A1A379B;
	Sun, 24 Mar 2024 22:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320199; cv=none; b=iKjbJEfcWPaLnY1CWg2EtT2D3w35A88zR7V3G8bxW40JRW2gf4A0nzkTS5z8WiwYTbxtml9/tXI4LEskB00SoCeVIXyUZLrnWR/P5MNhvaUsdKQzj2RObiLVwgbF7Zx+LdYWmxKnVfpuAeCkv3lD9Llic8MuhBMJAsyU33Dgxng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320199; c=relaxed/simple;
	bh=dgPcNLZuZaYRNBaj2vBUMExAJm+g8A7+HV9u2F7EcWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kELG/l41UjYjHqcuvUMykeKV52+eid5NhFyivnQ1WTmHrXW0IiEW9fSvPAOhLxuHSfAYWER4tjkmeB7mAMBmS2Atprfji4wyaJNC4pNWlI9iPwYDYTQ9d7K1nk2bv5NB8zT2uG9rdnBOtIYssDnoHYZ4xiz8sfacHRySNt1ScHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpP4OYIq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091A9C43399;
	Sun, 24 Mar 2024 22:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320199;
	bh=dgPcNLZuZaYRNBaj2vBUMExAJm+g8A7+HV9u2F7EcWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BpP4OYIqmXpuzOzgpZ/UdhrLtpRzDB4mF89pmnBwrLGxgPeyjd5NrgOiTwUNG5KfR
	 lYrx5GAjtwaTopjeL2pnnfx06SnPmN47V7q/5e7r4kHsUcmAkX73TPEGKwQOJAYaJ+
	 F3UzehG8lhUDGy1rLi9Nr4cAdwmlcB2jpS1etkbtYQRJZ3xuN5zCckfO403cbdPqeW
	 qYxNIlMTODvpaMLHKW8uVlrFZYopslqWkbxSwxfxWnmwATDGrx4bVrHzYhZuR0kylh
	 au72vAXFwwGxxiodlGikogps5M8DQX46wpNEXem902bSk0tLJt12U2pWAv2KzS8Wrh
	 IQ6lsrRt2Z0bg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sandipan Das <sandipan.das@amd.com>,
	Ian Rogers <irogers@google.com>,
	ananth.narayan@amd.com,
	ravi.bangoria@amd.com,
	eranian@google.com,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 506/715] perf vendor events amd: Fix Zen 4 cache latency events
Date: Sun, 24 Mar 2024 18:31:25 -0400
Message-ID: <20240324223455.1342824-507-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Sandipan Das <sandipan.das@amd.com>

[ Upstream commit 498d3486376befe4e82b5334d44bbc86b1982ee4 ]

L3PMCx0AC and L3PMCx0AD, used in l3_xi_sampled_latency* events, have a
quirk that requires them to be programmed with SliceId set to 0x3.
Without this, the events do not count at all and affects dependent
metrics such as l3_read_miss_latency.

If ThreadMask is not specified, the amd-uncore driver internally sets
ThreadMask to 0x3, EnAllCores to 0x1 and EnAllSlices to 0x1 but does
not set SliceId. Since SliceId must also be set to 0x3 in this case,
specify all the other fields explicitly.

E.g.

  $ sudo perf stat -e l3_xi_sampled_latency.all,l3_xi_sampled_latency_requests.all -a sleep 1

Before:

   Performance counter stats for 'system wide':

                   0      l3_xi_sampled_latency.all
                   0      l3_xi_sampled_latency_requests.all

         1.005155399 seconds time elapsed

After:

   Performance counter stats for 'system wide':

             921,446      l3_xi_sampled_latency.all
              54,210      l3_xi_sampled_latency_requests.all

         1.005664472 seconds time elapsed

Fixes: 5b2ca349c313 ("perf vendor events amd: Add Zen 4 uncore events")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Cc: ananth.narayan@amd.com
Cc: ravi.bangoria@amd.com
Cc: eranian@google.com
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20240301084431.646221-1-sandipan.das@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../pmu-events/arch/x86/amdzen4/cache.json    | 56 +++++++++++++++++++
 tools/perf/pmu-events/jevents.py              |  4 ++
 2 files changed, 60 insertions(+)

diff --git a/tools/perf/pmu-events/arch/x86/amdzen4/cache.json b/tools/perf/pmu-events/arch/x86/amdzen4/cache.json
index ecbe9660b2b31..e6d710cf3ce29 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen4/cache.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen4/cache.json
@@ -676,6 +676,10 @@
     "EventCode": "0xac",
     "BriefDescription": "Average sampled latency when data is sourced from DRAM in the same NUMA node.",
     "UMask": "0x01",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
     "Unit": "L3PMC"
   },
   {
@@ -683,6 +687,10 @@
     "EventCode": "0xac",
     "BriefDescription": "Average sampled latency when data is sourced from DRAM in a different NUMA node.",
     "UMask": "0x02",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
     "Unit": "L3PMC"
   },
   {
@@ -690,6 +698,10 @@
     "EventCode": "0xac",
     "BriefDescription": "Average sampled latency when data is sourced from another CCX's cache when the address was in the same NUMA node.",
     "UMask": "0x04",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
     "Unit": "L3PMC"
   },
   {
@@ -697,6 +709,10 @@
     "EventCode": "0xac",
     "BriefDescription": "Average sampled latency when data is sourced from another CCX's cache when the address was in a different NUMA node.",
     "UMask": "0x08",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
     "Unit": "L3PMC"
   },
   {
@@ -704,6 +720,10 @@
     "EventCode": "0xac",
     "BriefDescription": "Average sampled latency when data is sourced from extension memory (CXL) in the same NUMA node.",
     "UMask": "0x10",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
     "Unit": "L3PMC"
   },
   {
@@ -711,6 +731,10 @@
     "EventCode": "0xac",
     "BriefDescription": "Average sampled latency when data is sourced from extension memory (CXL) in a different NUMA node.",
     "UMask": "0x20",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
     "Unit": "L3PMC"
   },
   {
@@ -718,6 +742,10 @@
     "EventCode": "0xac",
     "BriefDescription": "Average sampled latency from all data sources.",
     "UMask": "0x3f",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
     "Unit": "L3PMC"
   },
   {
@@ -725,6 +753,10 @@
     "EventCode": "0xad",
     "BriefDescription": "L3 cache fill requests sourced from DRAM in the same NUMA node.",
     "UMask": "0x01",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
     "Unit": "L3PMC"
   },
   {
@@ -732,6 +764,10 @@
     "EventCode": "0xad",
     "BriefDescription": "L3 cache fill requests sourced from DRAM in a different NUMA node.",
     "UMask": "0x02",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
     "Unit": "L3PMC"
   },
   {
@@ -739,6 +775,10 @@
     "EventCode": "0xad",
     "BriefDescription": "L3 cache fill requests sourced from another CCX's cache when the address was in the same NUMA node.",
     "UMask": "0x04",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
     "Unit": "L3PMC"
   },
   {
@@ -746,6 +786,10 @@
     "EventCode": "0xad",
     "BriefDescription": "L3 cache fill requests sourced from another CCX's cache when the address was in a different NUMA node.",
     "UMask": "0x08",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
     "Unit": "L3PMC"
   },
   {
@@ -753,6 +797,10 @@
     "EventCode": "0xad",
     "BriefDescription": "L3 cache fill requests sourced from extension memory (CXL) in the same NUMA node.",
     "UMask": "0x10",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
     "Unit": "L3PMC"
   },
   {
@@ -760,6 +808,10 @@
     "EventCode": "0xad",
     "BriefDescription": "L3 cache fill requests sourced from extension memory (CXL) in a different NUMA node.",
     "UMask": "0x20",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
     "Unit": "L3PMC"
   },
   {
@@ -767,6 +819,10 @@
     "EventCode": "0xad",
     "BriefDescription": "L3 cache fill requests sourced from all data sources.",
     "UMask": "0x3f",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
     "Unit": "L3PMC"
   }
 ]
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 53ab050c8fa43..ce846f29c08d6 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -356,6 +356,10 @@ class JsonEvent:
         ('UMask', 'umask='),
         ('NodeType', 'type='),
         ('RdWrMask', 'rdwrmask='),
+        ('EnAllCores', 'enallcores='),
+        ('EnAllSlices', 'enallslices='),
+        ('SliceId', 'sliceid='),
+        ('ThreadMask', 'threadmask='),
     ]
     for key, value in event_fields:
       if key in jd and jd[key] != '0':
-- 
2.43.0


