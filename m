Return-Path: <linux-kernel+bounces-148799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F6C8A8790
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38BE81C21B24
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163D4147C61;
	Wed, 17 Apr 2024 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HiAbzuLT"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E547140E29;
	Wed, 17 Apr 2024 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367705; cv=none; b=BOZlH3vSEUeIzinjC0SKypbNpTGaQIY5uORweiITd7pGsyCjXt7/hAyfVIyu8IdReDSD0+A6bEOiJuaauNEsbsGRsWYIMsCO9s8mqurI8cM3dJKjluUEnkSosbT5ORapMs411g3ECHHVvJxwH89V8rVu7DEgCbnU4BJ6bby/EXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367705; c=relaxed/simple;
	bh=DW3I9GoVYzSlEMTLuU0jyORDXqMAP0u2EdSKwSWXNhY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rDBwqOU9+HAZGMzVxERCFbDOMoxynsUU+cIsUgvi1/bBfRxSvmg/ppbLh9yqunR4spWTxJomCr//jP+hlpCNwBV1NXOT/PbebhAMDAeMbyj43azKMQJdAY2hvEG0TAvHjopNaTAnFuh0gMpsf3HXDc0qPPx531ML91StEqaRFao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HiAbzuLT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43HF2XIa022980;
	Wed, 17 Apr 2024 15:28:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=zAU0vRCOwSbovtMECRQap2vSgOqXnbXeo2+zCEfUK+w=;
 b=HiAbzuLT8RE07UGwkIUjqiwKfEE15g75I1zWNU3Wwayj/CMwuiqcB5uCC3PLmUYEmBpE
 AtLQ3FgZNpMnula1CZ8M3oRianvLRktuoq6RGzOlnx8YjownLCFIEudavfiw9cY5A3P1
 kV3BFtc7NOd/tYKe6bFUE6Uc7HN5vi4TlEAy+C3CH7YUUZLtKQhK0xexV3XliA1nl8Vi
 xq3/FbTm1ATInk2hIUXpgr+ImsXoiM4LiiG0irHkpqTpOSLsdLsfA/UI+94r/QXErO7A
 tRagm7woItth5lDkzhfVOYXjV08DGCL5vhjdI8MsljuDZ93312FmhYHMGjAUcqpqkQ9V rA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xjgqd025x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 15:28:08 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43HFS75A000695;
	Wed, 17 Apr 2024 15:28:07 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xjgqd0235-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 15:28:07 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43HEF9F2018212;
	Wed, 17 Apr 2024 15:25:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xg4ctdf4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 15:25:38 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43HFPXew50987316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 15:25:35 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49FE22004B;
	Wed, 17 Apr 2024 15:25:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 600B620043;
	Wed, 17 Apr 2024 15:25:26 +0000 (GMT)
Received: from li-fdfde5cc-27d0-11b2-a85c-e224154bf6d4.ibm.com.com (unknown [9.43.36.38])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Apr 2024 15:25:26 +0000 (GMT)
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
To: acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
        acme@redhat.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: vineethr@linux.ibm.com
Subject: [PATCH] perf sched map: Add command-name option to filter the output map
Date: Wed, 17 Apr 2024 20:55:21 +0530
Message-ID: <20240417152521.80340-1-vineethr@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0hCcYBIlLnzVcwT2slL7yQSC-tRhR0rk
X-Proofpoint-ORIG-GUID: J4fkubprsoucha22FsBHO7ktq7gB7NC5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_12,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 impostorscore=0
 spamscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404170107

By default, perf sched map prints sched-in events for all the tasks
which may not be required all the time as it prints lot of symbols
and rows to the terminal.

With --command-name option, one could specify the specific command
for which the map has to be shown. This would help in analyzing the
CPU usage patterns easier for that specific command. Since multiple
PID's might have the same command name, using command-name filter
would be more useful for debugging.

For other tasks, instead of printing the symbol, ** is printed and
the same . is used to represent idle. ** is used instead of symbol
for other tasks because it helps in clear visualization of command
of interest and secondly the symbol itself doesn't mean anything
because the sched-in of that symbol will not be printed(first sched-in
contains pid and the corresponding symbol).

6.8.0
======
  *A0                   213864.670142 secs A0 => migration/0:18
  *.                    213864.670148 secs .  => swapper:0
   .  *B0               213864.670217 secs B0 => migration/1:21
   .  *.                213864.670223 secs
   .   .  *C0           213864.670247 secs C0 => migration/2:26
   .   .  *.            213864.670252 secs

6.8.0 + patch (--command-name = schbench)
=============
   **  .   ** *A0       213864.671055 secs A0 => schbench:104834
  *B0  .   .   A0       213864.671156 secs B0 => schbench:104835
  *C0  .   .   A0       213864.671187 secs C0 => schbench:104836
  *D0  .   .   A0       213864.671219 secs D0 => schbench:104837
  *E0  .   .   A0       213864.671250 secs E0 => schbench:104838
   E0  .  *D0  A0

This helps in visualizing how a benchmark like schbench is spread over
the available cpus while also knowing which cpus are idle(.) and which
are not(**). This will be more useful as number of CPUs increase.

Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
---
 tools/perf/Documentation/perf-sched.txt |  4 ++++
 tools/perf/builtin-sched.c              | 17 ++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
index 5fbe42bd599b..b04a37560935 100644
--- a/tools/perf/Documentation/perf-sched.txt
+++ b/tools/perf/Documentation/perf-sched.txt
@@ -94,6 +94,10 @@ OPTIONS for 'perf sched map'
 --color-pids::
 	Highlight the given pids.
 
+--command-name::
+	Map output only for the given command name.
+	(** indicates other tasks while . is idle).
+
 OPTIONS for 'perf sched timehist'
 ---------------------------------
 -k::
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 0fce7d8986c0..e60836da53e5 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -156,6 +156,7 @@ struct perf_sched_map {
 	const char		*color_pids_str;
 	struct perf_cpu_map	*color_cpus;
 	const char		*color_cpus_str;
+	const char		*command;
 	struct perf_cpu_map	*cpus;
 	const char		*cpus_str;
 };
@@ -1594,8 +1595,6 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 
 	sched->curr_thread[this_cpu.cpu] = thread__get(sched_in);
 
-	printf("  ");
-
 	new_shortname = 0;
 	if (!tr->shortname[0]) {
 		if (!strcmp(thread__comm_str(sched_in), "swapper")) {
@@ -1605,7 +1604,8 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 			 */
 			tr->shortname[0] = '.';
 			tr->shortname[1] = ' ';
-		} else {
+		} else if (!sched->map.command || !strcmp(thread__comm_str(sched_in),
+								sched->map.command)) {
 			tr->shortname[0] = sched->next_shortname1;
 			tr->shortname[1] = sched->next_shortname2;
 
@@ -1618,10 +1618,18 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 				else
 					sched->next_shortname2 = '0';
 			}
+		} else {
+			tr->shortname[0] = '*';
+			tr->shortname[1] = '*';
 		}
 		new_shortname = 1;
 	}
 
+	if (sched->map.command && strcmp(thread__comm_str(sched_in), sched->map.command))
+		goto skip;
+
+	printf("  ");
+
 	for (i = 0; i < cpus_nr; i++) {
 		struct perf_cpu cpu = {
 			.cpu = sched->map.comp ? sched->map.comp_cpus[i].cpu : i,
@@ -1678,6 +1686,7 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 out:
 	color_fprintf(stdout, color, "\n");
 
+skip:
 	thread__put(sched_in);
 
 	return 0;
@@ -3560,6 +3569,8 @@ int cmd_sched(int argc, const char **argv)
                     "highlight given CPUs in map"),
 	OPT_STRING(0, "cpus", &sched.map.cpus_str, "cpus",
                     "display given CPUs in map"),
+	OPT_STRING(0, "command-name", &sched.map.command, "command",
+		"map output only for the given command name"),
 	OPT_PARENT(sched_options)
 	};
 	const struct option timehist_options[] = {
-- 
2.39.1


