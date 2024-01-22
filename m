Return-Path: <linux-kernel+bounces-32685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5E7835EE4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7B6BB245D0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E8739FE2;
	Mon, 22 Jan 2024 10:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bg9ZtpNZ"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C9A3A1A6;
	Mon, 22 Jan 2024 10:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705917625; cv=none; b=Z5qyoEXYGPytyTLVNyguX5GGw1gaiEskLkRQvMpN7v1ILS+FgSAS/vzrlTjlubrJEMe5GTdVQx7qF/ftrluz7dTPF6xxmmkkHYtHowJDgbzbiHTMR2FrALoyR6Kv5eQdkso9rDu4Cxz1neeoKPAUL3SaSQYbKFDOcblWamX6+3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705917625; c=relaxed/simple;
	bh=49AJX6VY7FPav/J8GIc6IM811dRWTTUZp5hEb+YsiPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c8pgpwmwEJp/enjgD2xS0VK79w9uNJIQ3YzcUY3RTDBOatERhVlT2rLzoWqx1FeE0+oS66lU5emN3mnWTs8TeaAvZpgf25rrQdruEv2rDZTdhMILpUnEHMVmUU7IiIQG8s+QASKJmfX5jt07jv8ab8ZXPikGQhGyBxcQGSsbuV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bg9ZtpNZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40M9simF002469;
	Mon, 22 Jan 2024 10:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=7kmzkWN5X0l8xbR7Pr6B24aKphmRnA8uemNbAU9NJo0=;
 b=bg9ZtpNZzSbMf+tN/3Lgq9EsHWLE38BsE/7QAote1yCTvLTxGMNfulkY8xRAYwtxv6yQ
 4ommGWgTrDp4A3WQaP3o99ncr5ZnKpx6ramlfySTFOR+lhjMrXIa0OVrQJdFRYQlkA9i
 4JTzq0AkjgMxoyOaerQWdzdKlhxvbVV6OjTzDcvrtMnBp1i9phvg7JaJAROC0P5rjvTX
 d9OrRFV+oBDjoVn15xovDcvjiam20ee09xXzAQrywc7zl1+H72KBZjyBas3l80qD0PgD
 YoCBrUkI9CBSvsRF9hS0Q48F99qKFnpRBf9rEiIGxMcK2/dMdnUitPgU2QjGW3cPDvB1 Iw== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vrj31aa7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 10:00:11 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40M9u550028287;
	Mon, 22 Jan 2024 10:00:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vru7271m5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 10:00:11 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40MA08iW44892604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 10:00:08 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F1292004F;
	Mon, 22 Jan 2024 10:00:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25B7720049;
	Mon, 22 Jan 2024 10:00:08 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Jan 2024 10:00:08 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, namhyung@kernel.org
Cc: svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v2] perf test: Fix test case perf script tests on s390
Date: Mon, 22 Jan 2024 10:59:55 +0100
Message-Id: <20240122095955.2647989-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: T3_BgMBRh7sdgEBunwKuIPBJ57eIwhvi
X-Proofpoint-ORIG-GUID: T3_BgMBRh7sdgEBunwKuIPBJ57eIwhvi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-21_04,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401220070

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


