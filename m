Return-Path: <linux-kernel+bounces-41922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7DD83F99D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95654282986
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270A142060;
	Sun, 28 Jan 2024 19:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BJMKk/A8"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF7A3C68C;
	Sun, 28 Jan 2024 19:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706471955; cv=none; b=YU/XKuAPhZJNmjxxg6egJcUFYowu/eLFsSvmQoXYacXgrAz8qhp9Y402tr9z+FeRHewFbZmW6P3q2O3BaQbxixidxJU5EgIPq2BN6/iMrzWMtY4atFkZLPtMtPb+t+9Z6KBpccUjNFGOIZt4YH8zvFycy+2x9ktcNZ38odYyhjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706471955; c=relaxed/simple;
	bh=2SUnMmASJH8Zosdufbfuq/QquqLnb55c0ttzhxwGzF0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YzGB6RfhVNtHNQ0nPJeJcp/3G5WYanXXlor/H+BWZsBLMOiHrWgG2hu2RQ8a8UqI3mjSnN3hdRVWLTl5CSbvhlbzc9TbOyg+BNZHaU6/+mzWeAqHood4g/h1XNqcRUEz+AYVjw1/7GD8gd7udmK+p3S+yHenlWIhUt84cSPNK34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BJMKk/A8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40SHDW0Q002736;
	Sun, 28 Jan 2024 19:59:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=+dcdQLiT/nfsDiyjwPQCWNxl4S7aRhJdMu+54Asw0Gc=;
 b=BJMKk/A8CiaUcu2xRCvYs6nwy0MRd2ZgGOovF4CcM/uAV3SMBdFmV/ggT4BtiQzBjUjv
 AYKWMzP+wWfrMx/egfqJkEWCmT2BKrr8yYp3vgU5IKCk00IvHGdWnWVxeNlWWfD0iuvE
 tn4ve/aDDYuiwx59ZctnYoFc9Xn5S61d6wTehpLDmgNeTZ8/8+ORNNyjaR3vtrRKCkgm
 VI4kRgCxxHy9/AbbSA5kUj/JocwfO4z6sgTGYduGCkVMDctw0DzJVrhbDE0zTxJ42Ymu
 3XH5U7RfJR/RbV+6Tt85RwUTbbw+NrdkjuqDKTJ81tz+yALIrLjGTmaGHjlO6ApujeWR uQ== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vw209y73w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Jan 2024 19:58:59 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40SH0MxN010511;
	Sun, 28 Jan 2024 19:58:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwd5nc6x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Jan 2024 19:58:58 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40SJwtsc57868730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 28 Jan 2024 19:58:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDE8C2004E;
	Sun, 28 Jan 2024 19:58:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD7F22004B;
	Sun, 28 Jan 2024 19:58:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 28 Jan 2024 19:58:54 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id A8968E0499; Sun, 28 Jan 2024 20:58:54 +0100 (CET)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/5] sched/vtime: vtime.h headers cleanup
Date: Sun, 28 Jan 2024 20:58:49 +0100
Message-Id: <cover.1706470223.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3t3W68bBEGZdHty-p09wI73TlhqoZ5Bl
X-Proofpoint-ORIG-GUID: 3t3W68bBEGZdHty-p09wI73TlhqoZ5Bl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0 mlxlogscore=713
 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401280151

Hi all,

Please find a small cleanup to vtime_task_switch() wiring.
I split it into smaller patches to allow separate PowerPC
vs s390 reviews. Otherwise patches 2+3 and 4+5 could have
been merged.

I tested it on s390 and compile-tested it on 32- and 64-bit
PowerPC and few other major architectures only, but it is
only of concern for CONFIG_VIRT_CPU_ACCOUNTING_NATIVE-capable
ones (AFAICT).

Thanks!

Alexander Gordeev (5):
  sched/vtime: remove confusing arch_vtime_task_switch() declaration
  sched/vtime: get rid of generic vtime_task_switch() implementation
  s390/vtime: remove unused __ARCH_HAS_VTIME_TASK_SWITCH leftover
  s390/irq,nmi: do not include <linux/vtime.h> header
  sched/vtime: do not include <asm/vtime.h> header

 arch/powerpc/include/asm/cputime.h | 13 -------------
 arch/powerpc/kernel/time.c         | 22 ++++++++++++++++++++++
 arch/s390/include/asm/vtime.h      |  2 --
 arch/s390/kernel/irq.c             |  1 +
 arch/s390/kernel/nmi.c             |  1 +
 include/asm-generic/vtime.h        |  1 -
 include/linux/vtime.h              |  5 -----
 kernel/sched/cputime.c             | 13 -------------
 8 files changed, 24 insertions(+), 34 deletions(-)
 delete mode 100644 include/asm-generic/vtime.h

-- 
2.40.1


