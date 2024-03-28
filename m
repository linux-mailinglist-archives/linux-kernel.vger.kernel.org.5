Return-Path: <linux-kernel+bounces-122627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D63088FA8C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42FE61C22A12
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE885810A;
	Thu, 28 Mar 2024 09:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VmO4KkI+"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF5A54BDA;
	Thu, 28 Mar 2024 09:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711616438; cv=none; b=AC9F/bAUCyGIJrjyyjaFmjNjoe3U/EBRT/L7PmANNfzhCV4rxKX/H8jz7rFSITmbZy7TdBBpts5SMuga2xg6pyOwOROqbZhhJ7NdXTdDnmuuKenaOSL5dZAjeJ6BRs4eQopWnHSe0mrws+Z85c/GIU+tAzqCsL37Ekw4SPh4tG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711616438; c=relaxed/simple;
	bh=GKIEvQajVEoW3lcq/KMK1mQOWTmIcBZg/Y41L6hdBqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ca72kXE666jhwxD37YPE6tyIsxgLfce5m7tagSwOwMZNWTyv3qzaMu2SdHVs/NaqjxMdlIdKhN0+SNKXaAlS6x2t9showv24W1ZAskQimnF8PQDr6aqIzUUmd1i3x0xgAWHvsB1ETFU7lQUimFGn7LuDbo6ty1qXArc7yJf1S8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VmO4KkI+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42S8xu24021914;
	Thu, 28 Mar 2024 09:00:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=cP1wgP/DVc7Se0b+n2O/NoJFwey3Ye5k1NuTvcEqC7w=;
 b=VmO4KkI+OfRxi5Zf+9LgI0j6yKnQfzgZFfuxrG3oP2FE1Oe1ysCphcaRIXqR2b5YymwS
 t3fYVnllmAvNQqfGlwaT5/Jnm7TSnrnEOAfcTipHYwUIu4u2qP8T+EBTitL8/HZZZakF
 ilNnFsbgjzDk2CFDLXFbQICvXRjCNwxJKTneQ1ZNvnJBEaSTlDUpRoIPpF3Mt85tFj2o
 ToO234oSBcbLMXrpPUzI7oU2RhksGvROYNPopA6OFobe7H5kv+xvPzORxaMM2FiMJVYJ
 yKQuOTdrRNMxYmbq63flJhlf1BFAa4GEq179MF29ksO6PaYYnkGtock0DjS6+EKlcSjI qw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x55hb0021-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 09:00:18 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42S90HAf023260;
	Thu, 28 Mar 2024 09:00:17 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x55hb001w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 09:00:17 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42S63qqu011267;
	Thu, 28 Mar 2024 09:00:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x2bmmc2rq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 09:00:16 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42S90Dsl49414452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 09:00:15 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A3E020063;
	Thu, 28 Mar 2024 09:00:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FC5E2004D;
	Thu, 28 Mar 2024 09:00:08 +0000 (GMT)
Received: from li-fdfde5cc-27d0-11b2-a85c-e224154bf6d4.ibm.com.com (unknown [9.43.87.71])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 Mar 2024 09:00:08 +0000 (GMT)
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: vineethr@linux.ibm.com
Subject: [PATCH] perf sched: Rename switches to count and add usage description, options for latency
Date: Thu, 28 Mar 2024 14:30:05 +0530
Message-ID: <20240328090005.8321-1-vineethr@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iHHZR2THhGI1J9DjZnmLMnLNdI-ypmY5
X-Proofpoint-GUID: sLhF550g9e88-IFxtcEfw5cteEMG7lFy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_07,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403280058

Rename 'Switches' to 'Count' and document metrics shown for perf
sched latency output. Also add options possible with perf sched
latency.

Initially, after seeing the output of 'perf sched latency', the term
'Switches' seemed like it's the number of context switches-in for a
particular task, but upon going through the code, it was observed that
it's actually keeping track of number of times a delay was calculated so
that it is used in calculation of the average delay.

Actually, the switches here is a subset of number of context switches-in
because there are some cases where the count is not incremented in
switch-in handler 'add_sched_in_event'. For example when a task is
switched-in while it's state is not ready to run(!= THREAD_WAIT_CPU).

commit d9340c1db3f5 ("perf sched: Display time in milliseconds, reorganize
output") changed it from the original count to switches.

So, renamed switches to count to make things a bit more clearer and
added the metrics description of latency in the document.

Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
---
 tools/perf/Documentation/perf-sched.txt | 36 +++++++++++++++++++++++++
 tools/perf/builtin-sched.c              |  2 +-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
index 5fbe42bd599b..a216d2991b19 100644
--- a/tools/perf/Documentation/perf-sched.txt
+++ b/tools/perf/Documentation/perf-sched.txt
@@ -20,6 +20,26 @@ There are several variants of 'perf sched':
   'perf sched latency' to report the per task scheduling latencies
   and other scheduling properties of the workload.
 
+   Example usage:
+       perf sched record -- sleep 1
+       perf sched latency
+
+  -------------------------------------------------------------------------------------------------------------------------------------------
+  Task                  |   Runtime ms  |  Count   | Avg delay ms    | Max delay ms    | Max delay start           | Max delay end          |
+  -------------------------------------------------------------------------------------------------------------------------------------------
+  perf:(2)              |      2.804 ms |       66 | avg:   0.524 ms | max:   1.069 ms | max start: 254752.314960 s | max end: 254752.316029 s
+  NetworkManager:1343   |      0.372 ms |       13 | avg:   0.008 ms | max:   0.013 ms | max start: 254751.551153 s | max end: 254751.551166 s
+  kworker/1:2-xfs:4649  |      0.012 ms |        1 | avg:   0.008 ms | max:   0.008 ms | max start: 254751.519807 s | max end: 254751.519815 s
+  kworker/3:1-xfs:388   |      0.011 ms |        1 | avg:   0.006 ms | max:   0.006 ms | max start: 254751.519809 s | max end: 254751.519815 s
+  sleep:147736          |      0.938 ms |        3 | avg:   0.006 ms | max:   0.007 ms | max start: 254751.313817 s | max end: 254751.313824 s
+
+  It shows Runtime(time that a task spent actually running on the CPU),
+  Count(number of times a delay was calculated) and delay(time that a
+  task was ready to run but was kept waiting).
+
+  Tasks with the same command name are merged and the merge count is
+  given within (), However if -p option is used, pid is mentioned.
+
   'perf sched script' to see a detailed trace of the workload that
    was recorded (aliased to 'perf script' for now).
 
@@ -78,6 +98,22 @@ OPTIONS
 --force::
 	Don't complain, do it.
 
+OPTIONS for 'perf sched latency'
+-------------------------------
+
+-C::
+--CPU <n>::
+        CPU to profile on.
+
+-p::
+--pids::
+        latency stats per pid instead of per command name.
+
+-s::
+--sort <key[,key2...]>::
+        sort by key(s): runtime, switch, avg, max
+        by default it's sorted by "avg ,max ,switch ,runtime".
+
 OPTIONS for 'perf sched map'
 ----------------------------
 
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index b248c433529a..e66a935eab6f 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3210,7 +3210,7 @@ static int perf_sched__lat(struct perf_sched *sched)
 	perf_sched__sort_lat(sched);
 
 	printf("\n -------------------------------------------------------------------------------------------------------------------------------------------\n");
-	printf("  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max delay ms    | Max delay start           | Max delay end          |\n");
+	printf("  Task                  |   Runtime ms  |  Count   | Avg delay ms    | Max delay ms    | Max delay start           | Max delay end          |\n");
 	printf(" -------------------------------------------------------------------------------------------------------------------------------------------\n");
 
 	next = rb_first_cached(&sched->sorted_atom_root);
-- 
2.39.1


