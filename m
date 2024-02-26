Return-Path: <linux-kernel+bounces-81169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B59858672E9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E0F3B31754
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795EE5915E;
	Mon, 26 Feb 2024 10:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SzwyDB/r"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA8E5914E
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943498; cv=none; b=hlBxK8Oa2sHgMucsDd/TaPD7kz5jwpK7JG3CJQcwSnWoF4Tz7uLvl/QBvzEmXx6HSLFxnm6ljFzv3Zzds/Icd2r00cnfpxiz8hvF5JZ6Tsqh6XkPj3RCN9wVDl2aIoPhgOMrOhgr3UP+dxqhPyuc+TPGwHZawXli00eWQidVLZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943498; c=relaxed/simple;
	bh=YBmvDMpRGbUssXw57iHLXnbZL+pvLvxeKYGu3bFUqMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ThtoAdJUK9ewW4RxQ7wVQfcaQlbUl4GdEH2JraDL+jqW003Xh+RPkMYCobStLk0Ym8HZwU6FqInU+9Em65oPW/IHAaiRibT5QlYcbomCjCDfGPaLq2lRxH0776AkUCCKxnA7OlGcFS23DvTng8EpzA9H6gWxpYQO2JkTmeUaG1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SzwyDB/r; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41Q9JLf3018413;
	Mon, 26 Feb 2024 10:31:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=le4LCgrgl0rQAQk2X8xwPeGpze2aZA5cLCkLShXKXyo=;
 b=SzwyDB/rjwukVAMs8+qo23oDKO17zsG+Aj96YibLhgzof29rVjCRBwt6wt/RisC44t4A
 e3igHRR12L1uEzq3/yrlNMUoAmVmvOssZGsQR+39SyVZ+DsNcOxJGuLhppZ0OCjdAtoR
 VGkyo6LDfrCfM0CPg8sekNqE6O6mR5/63G4suv8s7BarF0p0r/T0SE6iwvBrlkGF0oHq
 IWv8+HmYnHJKOUfivo5cjxnu8FbsFLJG/2Q8EHiGz+qD5UsafSAmKKGbgZbDVrlD8VNz
 zDC1lrBQsok6scnj3nLW+zEowvVhYhaB626ik4SmDJD7cU11pPGvJ2Gr89DaWEXlD8Ld Jw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wg0bh5atn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 10:31:24 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41QAVEJZ006271;
	Mon, 26 Feb 2024 10:31:20 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wg0bh5adx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 10:31:20 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41Q95gUl008147;
	Mon, 26 Feb 2024 10:30:20 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfv9m08q1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 10:30:20 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41QAUEUr13435474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 10:30:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7746D20063;
	Mon, 26 Feb 2024 10:30:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 061DD20040;
	Mon, 26 Feb 2024 10:30:12 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.in.ibm.com (unknown [9.203.115.195])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Feb 2024 10:30:11 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Kexec-ml <kexec@lists.infradead.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Dave Young <dyoung@redhat.com>
Subject: [PATCH linux-next v2 0/3] powerpc/kexec: split CONFIG_CRASH_DUMP out from CONFIG_KEXEC_CORE
Date: Mon, 26 Feb 2024 16:00:07 +0530
Message-ID: <20240226103010.589537-1-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nTwYa3cQ1v0eiyh8TCyR0naNdMplF2k2
X-Proofpoint-GUID: edVtaD2Y3it8A-0l1Pshl5wXE-nEVdPN
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_07,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402260079

This patch series is a follow-up to [1] based on discussions at [2]
about additional work needed to get it working on powerpc.

The first patch in the series makes struct crash_mem available with or
without CONFIG_CRASH_DUMP enabled. The next patch moves kdump specific
code for kexec_file_load syscall under CONFIG_CRASH_DUMP and the last
patch splits other kdump specific code under CONFIG_CRASH_DUMP and
removes dependency with CONFIG_CRASH_DUMP for CONFIG_KEXEC_CORE.

[1] https://lore.kernel.org/all/20240124051254.67105-1-bhe@redhat.com/
[2] https://lore.kernel.org/all/9101bb07-70f1-476c-bec9-ec67e9899744@linux.ibm.com/

Changes in v2:
* Fixed a compile error for POWERNV build reported by Sourabh.

Hari Bathini (3):
  kexec/kdump: make struct crash_mem available without CONFIG_CRASH_DUMP
  powerpc/kexec: split CONFIG_KEXEC_FILE and CONFIG_CRASH_DUMP
  powerpc/kdump: Split KEXEC_CORE and CRASH_DUMP dependency

 arch/powerpc/Kconfig                 |   9 +-
 arch/powerpc/include/asm/kexec.h     |  98 +++++-----
 arch/powerpc/kernel/prom.c           |   2 +-
 arch/powerpc/kernel/setup-common.c   |   2 +-
 arch/powerpc/kernel/smp.c            |   4 +-
 arch/powerpc/kexec/Makefile          |   3 +-
 arch/powerpc/kexec/core.c            |   4 +
 arch/powerpc/kexec/elf_64.c          |   4 +-
 arch/powerpc/kexec/file_load_64.c    | 269 ++++++++++++++-------------
 arch/powerpc/platforms/powernv/smp.c |   2 +-
 include/linux/crash_core.h           |  12 +-
 11 files changed, 209 insertions(+), 200 deletions(-)

-- 
2.43.2


