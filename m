Return-Path: <linux-kernel+bounces-38356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D3883BE40
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF061C21D89
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962381C6B8;
	Thu, 25 Jan 2024 10:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H2zNI/fl"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96361CA80;
	Thu, 25 Jan 2024 10:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706177049; cv=none; b=m4rdu9ykWaFPZ9Aq5hbCqjf9fJjsmGBHJ6B65N31wzsnr7vuB1i3ESHRHIFnL1xdZPj6t2lS5j40jYVXrIZpizPOS+xQXUJm8OLHDB0gKLmu+xhrGtLhQjruzW+QS2bwWFyS06wHCq2unxm64SS8aYfyCTuIl9xC2XfiJ8E5Ymo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706177049; c=relaxed/simple;
	bh=7lJZvMAj51BkqXLUovg3jYW19XUo9wOqZUP/JCL4edQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KQXd0BThldChRYaLigwtvaB4yE9GW3R3NfYGX40Xki4uX58Rm4ZGaRqzeGrzQYHBejAGgq70owaAc6Kpl5BgckgLsVw5nwgg1axnqu4CyRTgt/qbp5/Tex3mnEwfmjkMCknRrva6A+ViP21SXpCi0V1YvgojZX9FkEhA8qYe+Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H2zNI/fl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40P87glc011509;
	Thu, 25 Jan 2024 10:04:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=l11VXT8hic+ZuAE/Hw1KQJD9GYpo1tnGYt9Nny3oBB8=;
 b=H2zNI/flARliMyN2bYeK3raO5CzXAviz5DHLtmzlzK5ELqns8blJJl3N9DxOYZhOO2XA
 LAdye91ripcjB4DeN5DsPRs5x4IKi+zr1MbAx5q8rvGxnfbYvz5Ks57mz8sQvo4vbY1k
 Dgv7wJDi1wl7bhC9DrQlB8oTTC0TlU2+V+2qolli3xujf6f4GioKIkStvkamTWsVOhLr
 sBDtdMI589KuGm3ncvA4XV7VSnKfkck16cg06JabX6wybRJVQnMnJ+UPHsL3WJo8X7tD
 xV0Fks8u6tlLVX2LuDe9H57Q585cJJSoLX55gbfmdYNqOUJ4A6/hYOiAsA0IRVUU1Ksr Iw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vukuuapp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 10:04:04 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40PA1pDX028048;
	Thu, 25 Jan 2024 10:04:03 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vukuuapnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 10:04:03 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40P8DVV2010850;
	Thu, 25 Jan 2024 10:04:02 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vrrw03stu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 10:04:02 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40PA3xqN32702798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 10:03:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 150B12004E;
	Thu, 25 Jan 2024 10:03:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB7A92004D;
	Thu, 25 Jan 2024 10:03:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Jan 2024 10:03:58 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, namhyung@kernel.org
Cc: svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>,
        Ian Rogers <irogers@google.com>
Subject: [PING PATCH v2] perf test: Fix test case perf script tests on s390
Date: Thu, 25 Jan 2024 11:03:51 +0100
Message-Id: <20240125100351.936262-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: x4NZDRyOUgZ8vxVhtOO7WKRLNcHIuIE5
X-Proofpoint-GUID: 9EEcyfGOR0vkQQNC3UD39JsX-Flqmc1b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_05,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401250069

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
Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/script.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/script.sh b/tools/perf/tests/shell/script.sh
index 5ae7bd0031a8..2973adab445d 100755
--- a/tools/perf/tests/shell/script.sh
+++ b/tools/perf/tests/shell/script.sh
@@ -54,7 +54,14 @@ def sample_table(*args):
 def call_path_table(*args):
     print(f'call_path_table({args}')
 _end_of_file_
-	perf record -g -o "${perfdatafile}" true
+	case $(uname -m)
+	in s390x)
+		cmd_flags="--call-graph dwarf -e cpu-clock";;
+	*)
+		cmd_flags="-g";;
+	esac
+
+	perf record $cmd_flags -o "${perfdatafile}" true
 	perf script -i "${perfdatafile}" -s "${db_test}"
 	echo "DB test [Success]"
 }
-- 
2.43.0


