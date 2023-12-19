Return-Path: <linux-kernel+bounces-5388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35289818A21
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38AB11C247E7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD651C69E;
	Tue, 19 Dec 2023 14:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M2iJC7QH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34B437D05;
	Tue, 19 Dec 2023 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJEW5Q8000777;
	Tue, 19 Dec 2023 14:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=XZlmoSCZ5b8vB70M4iBRGWgNuAh+UA4p+L7tpdtKask=;
 b=M2iJC7QHVJ3R2paEY/1CYfmpDpr3mn5KC/SXaOZTqqqJYChcRv3TTp55IXwcTKLB8C0q
 T0VIiyFPWaOGW5wQHJfFuDgzl+h61w0d4uGt7TLalg+UNKuSo+lFD4YKiEI7wGKfXzId
 kRH/NafFqu5HJ1RRHmoDrDbdJZ+sx7BWNwPjRwoDA72YtJWlhECiBK03OJ2ffB/6jgqw
 NXa1+g3ew8TkxPKM18QZaEVy7CAY3/oPPSbLr5VKuRb9T3yw+n2UCmOxmVsaZSJiiviZ
 DD8lBQ8Ti61duclJX/BrBQv9qfANPuhRXiSlcOWihxqero1z/97G2AI1h9MelL+SLehC lw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v3d1500e1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 14:32:46 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BJEWkQH001888;
	Tue, 19 Dec 2023 14:32:46 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v3d1500dq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 14:32:46 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJD0reV010870;
	Tue, 19 Dec 2023 14:32:45 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3v1q7ng82f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 14:32:44 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BJEWfWP46727466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 14:32:41 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B17652004E;
	Tue, 19 Dec 2023 14:32:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8629F2005A;
	Tue, 19 Dec 2023 14:32:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Dec 2023 14:32:41 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, irogers@google.com
Cc: svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, agordeev@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: test case 17 fails on s390 on z/vm
Date: Tue, 19 Dec 2023 15:32:35 +0100
Message-Id: <20231219143235.1075522-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4Nozn7tT4YC_p_gsyMNqGjecO6QtGehh
X-Proofpoint-GUID: y0392DA6qR-Qn0NrOdwup2xIE8fbfIDC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-19_08,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0
 clxscore=1011 priorityscore=1501 mlxscore=0 adultscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312190108

perf test 17 'Setup struct perf_event_attr' fails on s390 z/VM guest,
using linux-next kernel.
Root cause is the fall-back from hardware counter cycles

 perf_event_attr:
  type                             0 (PERF_TYPE_HARDWARE)
  size                             136
  config                           0 (PERF_COUNT_HW_CPU_CYCLES)
  { sample_period, sample_freq }   4000
  sample_type                      IP|TID|TIME|ADDR|PERIOD|DATA_SRC
  read_format                      ID|LOST

which returns -ENOENT on s390 z/VM guest. This causes the code to
fall back to software counter task-clock, as can be seen in the
debug output.
------------------------------------------------------------
 perf_event_attr:
  type                             1 (PERF_TYPE_SOFTWARE)
  size                             136
  config                           0x1 (PERF_COUNT_SW_TASK_CLOCK) <-here
  { sample_period, sample_freq }   4000
  sample_type                      IP|TID|TIME|ADDR|PERIOD|DATA_SRC
  read_format                      ID|LOST

This succeeds on s390 z/VM guest.
This successful installation of the counter task-clock is not listed
in the expected results and the test case fails.

This is caused by commit
commit eb2eac0c7b61 ("perf evsel: Fallback to "task-clock" when not system wide")
which introduced fall back from event 'cycles' to event 'task-clock'.

To fix this on s390 allow event number 0 (cycles) and event number 1
(task-clock) as expected result.

Output before:
 # ./perf test -Fv 17
 17: Setup struct perf_event_attr                                    :
 --- start ---
 running './tests/attr/test-stat-group1'
 unsupp  './tests/attr/test-stat-group1'
 running './tests/attr/test-record-graph-default'
 test limitation '!aarch64'
 excluded architecture list ['aarch64']
 expected config=0, got 1
 FAILED './tests/attr/test-record-graph-default' - match failure
 ---- end ----
 Setup struct perf_event_attr: FAILED!
 #

Output after:
 # ./perf test -F 17
 17: Setup struct perf_event_attr               : Ok
 #

Fixes: eb2eac0c7b61 ("perf evsel: Fallback to "task-clock" when not system wide")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/attr/base-record | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/attr/base-record b/tools/perf/tests/attr/base-record
index 27c21271a16c..b44e4e6e4443 100644
--- a/tools/perf/tests/attr/base-record
+++ b/tools/perf/tests/attr/base-record
@@ -6,7 +6,7 @@ flags=0|8
 cpu=*
 type=0|1
 size=136
-config=0
+config=0|1
 sample_period=*
 sample_type=263
 read_format=0|4|20
-- 
2.43.0


