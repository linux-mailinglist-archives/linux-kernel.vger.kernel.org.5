Return-Path: <linux-kernel+bounces-58653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C8684E97C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F361A1F2E1B3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBFC3C48C;
	Thu,  8 Feb 2024 20:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CVSC5H8G"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B818383BA;
	Thu,  8 Feb 2024 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707423367; cv=none; b=p5BJW/ZmkTf2PgOBp6RzVrXL+mK0cbKnxRfHfZPBNKW5fSa9hUfLIjan9uFT2I3Dr2Cpp/W4HxZ1mM05mg/omexcJVi5KFBkc7LPM3dr6n0aQWHM+d+Uc8Y6NxyPQEqEbUhyJRZ8hSXkiNT4Knnpxq6v6kk8xhw5vN1hxYSKKmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707423367; c=relaxed/simple;
	bh=KheXcUzlMOfoXsfF8fLTK+gIOCd+wehX9PQD4vTnt7w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BmyRPRzDmuv6VeInQl+MmwCZ+k8Gnu+wLY4hbAiy49ZqtOSo3QnYRcKMpsUHZIjg8kr8HwK/veycWxmWUwXfKeFBuMV56IxGRi/zVjd4w7XHgBreYNe1QSykx/50s30FjfYGqlsIA+YWM18QhfZpJ0HdmDicJd00n2eiHHN9r60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CVSC5H8G; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418K2Dw7018455;
	Thu, 8 Feb 2024 20:15:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Zow24WyxPBCa3qs5bHb+5ubemW+MG+lG4ez4A7Taqgk=;
 b=CVSC5H8GS2fmMF76PkHCGq/213ANGAUNsHN0LSX9JHjqq8Wk/yeBQxyqeN0VSt6VELTO
 ATtkkIdt9aHKZsY9hl74YuIXO0f0A0VDSeT7mtjDp3k/N9lC38rlAnuElWlTFtc9quHD
 KF2lFIvBQKQNAtDwfA5dOr14EZCsLGdXGl5a2cqK5tjWOvghLL6XXZQNveNUNnaEQeQS
 DcCH0MJc4Oa8TUorCHFwWV7pzstEwb4SqCAaGHUZJjPmupUjf+Gh1/kKEoFHZbT8rGts
 OZDa6HTskpmfzLJfDQE+vIGLMbzEPlOTWY/54thQn42eAJGCgUf0d6Mt6QfeCO0PCq2S fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w55mu8c7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 20:15:55 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 418K2ufF020018;
	Thu, 8 Feb 2024 20:15:54 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w55mu8c6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 20:15:54 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 418IR1GN008494;
	Thu, 8 Feb 2024 20:15:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w221kejv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 20:15:53 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 418KFocK21496320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Feb 2024 20:15:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE8062004B;
	Thu,  8 Feb 2024 20:15:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD48C20040;
	Thu,  8 Feb 2024 20:15:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  8 Feb 2024 20:15:49 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 8119FE1541; Thu,  8 Feb 2024 21:15:49 +0100 (CET)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 5/5] sched/vtime: do not include <asm/vtime.h> header
Date: Thu,  8 Feb 2024 21:15:49 +0100
Message-Id: <e0827ac2f96d87f623575098f9d55e77351b63c6.1707422448.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1707422448.git.agordeev@linux.ibm.com>
References: <cover.1707422448.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cE_iiBipX1nKYHLnLpahvenDMlutxuTG
X-Proofpoint-ORIG-GUID: AAm_5AQcNpyFHo9NGIHcHS2xdJMFOVU-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_08,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=333 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080108

There is no architecture-specific code or data left
that generic <linux/vtime.h> needs to know about.
Thus, avoid the inclusion of <asm/vtime.h> header.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
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


