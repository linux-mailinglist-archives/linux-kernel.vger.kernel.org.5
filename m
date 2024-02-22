Return-Path: <linux-kernel+bounces-76707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB34785FB52
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59D5C1F24CCF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1C01474D9;
	Thu, 22 Feb 2024 14:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KJ7w91tF"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752A114600E;
	Thu, 22 Feb 2024 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708612447; cv=none; b=pooCPzkafS/pQlFV3SwW92K8Gb+8R3Swa041h2mQb6RRAEDn8Ab9pqec7ggVA0v/nqGo8Ht6WckwmAFNHuWUhKhfXh3nQ61Y0BZgb3lsHufN5gXFVnu7l0FsOL3IVJzm0RvoiQzNEb484FeEMWRSHeUl1N8QtJ9GG1A9wmAJ6Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708612447; c=relaxed/simple;
	bh=p5H3Bv4tVGThtwm8JdlNN4AbejaJjK6u1h3NLZF4mMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fo7CFiBMY5GsAYOrUw3fpPKyGcTi7QDTlZGEakBlsA0W0PmdxSV4Az1WsrxrS6t6ybO6UAsmdEi54VL8YDyTwVeLK4hBwIsKTT5pUo9c/NE+bVdOL2PcG6Q7pAP3dbMJGTZMpJr5CGJb1+gYFLOc3aSbiowvWRByxcVZdfriO8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KJ7w91tF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41MEW6YY022584;
	Thu, 22 Feb 2024 14:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Zx1bK32W6TAbYPYJEc5GfShqv+HBx8ibIf0/tgpNitQ=;
 b=KJ7w91tF+WF6cOE2ntpY8SxVFYRox4aKBTvqaxdwUUyKSMrtQ6k7xYm1rt4OUfYkh8dg
 VEdx6OHn/VOkNErJ2wRRbFe9IS4/O8EvQ/Q/twmIOf790dQlBOtQk4DBYahJ3vwQz6hN
 ebUr/JGQthM6kN39HdwMBG51LSASNxRtScRK+7V2JEeTdfsj+LGlKOIxYS7U7GrT1NY2
 BtNeck+XkgosFLw/UEtWOm2h9LV19VBzX3uN5HzYwRVd/vPG/EZuUJZf06UOnGpb6Abn
 Lh7CPu6yzDG8+gjkdO+gj+d6JQOLvL+wY0X2KRb6nfGSo1h7AWLxwJtnXb3Y9bQqnOnu Gw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3we843r2a0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 14:33:49 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41MEWhrL024669;
	Thu, 22 Feb 2024 14:33:49 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3we843r293-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 14:33:48 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41MEDsxp003623;
	Thu, 22 Feb 2024 14:33:47 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb74ty0xp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 14:33:47 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41MEXgn327132480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 14:33:44 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 787822004F;
	Thu, 22 Feb 2024 14:33:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65B222004B;
	Thu, 22 Feb 2024 14:33:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 22 Feb 2024 14:33:42 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id DED5CE0375; Thu, 22 Feb 2024 15:33:41 +0100 (CET)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH v2 RESEND 5/5] sched/vtime: do not include <asm/vtime.h> header
Date: Thu, 22 Feb 2024 15:33:41 +0100
Message-Id: <a1d6ac49eb8fe5529dee184e8d62da4a7dedc461.1708612016.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708612016.git.agordeev@linux.ibm.com>
References: <cover.1708612016.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aOz7Fjqea4Byyh_gockVFzsERdL-DRGs
X-Proofpoint-ORIG-GUID: BE-CQrDmRMYPIaCK-n7uGJL0aCkmOCUf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_11,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=451 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220116

There is no architecture-specific code or data left
that generic <linux/vtime.h> needs to know about.
Thus, avoid the inclusion of <asm/vtime.h> header.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/powerpc/include/asm/Kbuild | 1 -
 include/asm-generic/vtime.h     | 1 -
 include/linux/vtime.h           | 4 ----
 3 files changed, 6 deletions(-)
 delete mode 100644 include/asm-generic/vtime.h

diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
index 61a8d5555cd7..e5fdc336c9b2 100644
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -6,5 +6,4 @@ generic-y += agp.h
 generic-y += kvm_types.h
 generic-y += mcs_spinlock.h
 generic-y += qrwlock.h
-generic-y += vtime.h
 generic-y += early_ioremap.h
diff --git a/include/asm-generic/vtime.h b/include/asm-generic/vtime.h
deleted file mode 100644
index b1a49677fe25..000000000000
--- a/include/asm-generic/vtime.h
+++ /dev/null
@@ -1 +0,0 @@
-/* no content, but patch(1) dislikes empty files */
diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index 593466ceebed..29dd5b91dd7d 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -5,10 +5,6 @@
 #include <linux/context_tracking_state.h>
 #include <linux/sched.h>
 
-#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
-#include <asm/vtime.h>
-#endif
-
 /*
  * Common vtime APIs
  */
-- 
2.40.1


