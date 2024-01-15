Return-Path: <linux-kernel+bounces-26135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1B882DBD2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BEFAB224C3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00C61775C;
	Mon, 15 Jan 2024 14:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l0upcauH"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B451418E11;
	Mon, 15 Jan 2024 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40FEGuAu002037;
	Mon, 15 Jan 2024 14:47:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=HC1B7Sgry8D/oATK88PLGkNvCX87AE8cDjUpReT5gtM=;
 b=l0upcauHs+bKefCyhCRNx/qttL5+RTXnnZKzveYAvDRcxHCvxySfZFwucp5cWctcLkMX
 dzgJ6gHb1MhBMZRjM++LGpl7hbAEdbWfZzNN3hw7bajIQ2A4WX4Cg8HgLWzT3xAsK+uv
 JcLJyBaFhFt6uWxNL877DYhhfj+TuThSJLtD6ZUJDtCIN5IijzW9ScMdzAzth2qYsC/K
 zfQ+Y5LzihmmRd/+ivEr8EIqzop8/IcyGUfczxdITxXHJhOP/P6986EC2BGD7tQGX9hx
 ZZwvP0Lj8EdaMqyh8jewX4yyD2TKkmhqgQKmOreOXWBfnFcuNnUV5qQ3DONZN673TU1A zA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vkt87t1be-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jan 2024 14:47:35 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40FDg7qA012504;
	Mon, 15 Jan 2024 14:47:34 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vkt87t1as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jan 2024 14:47:34 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40FBm3Xf008677;
	Mon, 15 Jan 2024 14:47:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vm6bk8pe4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jan 2024 14:47:33 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40FElUba19661528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jan 2024 14:47:30 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11F7320040;
	Mon, 15 Jan 2024 14:47:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6B2D2004F;
	Mon, 15 Jan 2024 14:47:29 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jan 2024 14:47:29 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, irogers@google.com, acme@redhat.com
Cc: svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: Fix test case perf script tests on s390
Date: Mon, 15 Jan 2024 15:47:27 +0100
Message-Id: <20240115144727.499349-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AKromy9oaq5hymYdANGPUbg4p_s5NEbG
X-Proofpoint-GUID: ggsvLmPkuJajJsUv-1KyjghAbmzDqUQZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-15_09,2024-01-15_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1011 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401150108

In linux next repo, test case 'perf script tests' fails on s390.
The root case is a command line invocation of perf record with
call-graph information. On s390 only dwarf formatted call-graphs
are supported and only on software events.

Change the command line parameters fors s390.

Output before:
 # perf test 89
 89: perf script tests              : FAILED!
 #

Output after:
 # perf test 89
 89: perf script tests              : Ok
 #

Fixes: 0dd5041c9a0e ("perf addr_location: Add init/exit/copy functions")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/script.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/script.sh b/tools/perf/tests/shell/script.sh
index 5ae7bd0031a8..a6a09ef16e06 100755
--- a/tools/perf/tests/shell/script.sh
+++ b/tools/perf/tests/shell/script.sh
@@ -54,7 +54,14 @@ def sample_table(*args):
 def call_path_table(*args):
     print(f'call_path_table({args}')
 _end_of_file_
-	perf record -g -o "${perfdatafile}" true
+	case $(uname -m)
+	in s390x)
+		cmd_flags="--call-graph dwarf -e cpu-clock"
+	;; *)
+		cmd_flags="-g"
+	esac
+
+	perf record $cmd_flags -o "${perfdatafile}" true
 	perf script -i "${perfdatafile}" -s "${db_test}"
 	echo "DB test [Success]"
 }
-- 
2.43.0


