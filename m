Return-Path: <linux-kernel+bounces-121475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A85188E86C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CB891C2F03D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B976131E35;
	Wed, 27 Mar 2024 15:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nfvAjJUA"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD89131BC2;
	Wed, 27 Mar 2024 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711551799; cv=none; b=lmu45PnzsnKOZO00jFChzetzNCsbADpVsXC42vGAgA1p/Bhc+5AJTFT8m23w4F6MEoVEaqd28iUPU+lSagjLerh+2HExJZr2gMyDhVj3czCfahlb5hKI9saNqBnuPkw0uDLLKnTz9m3GRlmzuc496UhrdzPhE8AccjuXj+1OBbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711551799; c=relaxed/simple;
	bh=GIi67p8C/3X4lueH+9eEwIOxgE42+/kcCzd0qYllkJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fYaI6PEB2nVnWAmEBkRaKs+asFhx25Og6TpvRAk1akHSMBHvFy33lwRtXkgnKM4hUB00tBaH/yj5eh9WCLgtX3147ZMcVz8g9toyicIg/HKf7Xr1r6dm3b3+xQkBPeASWYz3peWbFCIqdD71pzKGFIaFH+z/OQlmGTEPpM4DcJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nfvAjJUA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42RF2Whu008778;
	Wed, 27 Mar 2024 15:03:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=c7jxWa9Qsu4QwE5wTmPISMkmIvLKT6/gcFnA/DTvIYA=;
 b=nfvAjJUAnSd9HG/aXmD99KCvsGna6CzsFynoraI/2XaEXChSLqoPTsyHFo++VrIqWmSj
 XIR/Lho95jNoZDvnSBRp04ZQZqUNc++7WK3V1TD8kqo30IeFkUhv6Ans4IpulWctRnGG
 J6a3BzXodQvg90DQaIEnXNoyp208CDSGk6rmE7f02J1FsudfCBVo3veR73Ky/Za71dzZ
 wy1YVCdSXRN7toQHcBZW8vRSg8OMj9lFEyGUFJT3DZaUGcVGgR1bFvr3zTtZhQ3rm//N
 uL71YtecXQOAHJ93ibQLLZ9ru9pzv1ViC98PIcAMbpnCJLURbz3DqyfOYMoAcLwc/Gn8 vg== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x4n9302ds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 15:03:01 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42RC33GR016572;
	Wed, 27 Mar 2024 15:03:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x29du7m11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 15:03:00 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42RF0QLu47841692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 15:00:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCA3B20065;
	Wed, 27 Mar 2024 15:00:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 979382004B;
	Wed, 27 Mar 2024 15:00:24 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com.com (unknown [9.61.61.30])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 Mar 2024 15:00:24 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Mimi Zohar <zohar@linux.ibm.com>, linux-modules@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>, linux-kernel@vger.kernel.org,
        Ken Goldman <kgold@linux.ibm.com>
Subject: [PATCH] ima: define an init_module critical data record
Date: Wed, 27 Mar 2024 11:00:19 -0400
Message-Id: <20240327150019.81477-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TG8PHYNOfciT7uHCEBhS66ZkMf-mtmNl
X-Proofpoint-GUID: TG8PHYNOfciT7uHCEBhS66ZkMf-mtmNl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_12,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 clxscore=1011 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403270101

The init_module syscall loads an ELF image into kernel space without
measuring the buffer containing the ELF image.  To close this kernel
module integrity gap, define a new critical-data record which includes
the hash of the ELF image.

Instead of including the buffer data in the IMA measurement list,
include the hash of the buffer data to avoid large IMA measurement
list records.  The buffer data hash would be the same value as the
finit_module syscall file hash.

To enable measuring the init_module buffer and other critical data from
boot, define "ima_policy=critical_data" on the boot command line.  Since
builtin policies are not persistent, a custom IMA policy must include
the rule as well: measure func=CRITICAL_DATA label=modules

To verify the template data hash value, first convert the buffer data
hash to binary:
grep "init_module" \
	/sys/kernel/security/integrity/ima/ascii_runtime_measurements | \
	tail -1 | cut -d' ' -f 6 | xxd -r -p | sha256sum

Reported-by: Ken Goldman <kgold@linux.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima_main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index c84e8c55333d..4b4348d681a6 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -902,6 +902,13 @@ static int ima_post_load_data(char *buf, loff_t size,
 		return 0;
 	}
 
+	/*
+	 * Measure the init_module syscall buffer containing the ELF image.
+	 */
+	if (load_id == LOADING_MODULE)
+		ima_measure_critical_data("modules", "init_module",
+					  buf, size, true, NULL, 0);
+
 	return 0;
 }
 
-- 
2.39.3


