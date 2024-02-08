Return-Path: <linux-kernel+bounces-58649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F046984E976
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D6DEB2B778
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A51D383B9;
	Thu,  8 Feb 2024 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k6MnG6ik"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038093612A;
	Thu,  8 Feb 2024 20:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707423365; cv=none; b=taS7OPqaAt8NlfK2ioB3/VefAHfIOH13kQjpPrFSFGMzeW/OOGlC05WcsO9gBMlg+IKR9dym6i60YWCkiPi+s5TIx7sQEhRymxqDCSIYCM7a+/fWkv3FYDbM/WljZO+kY96q+U2dR/kRzLB9ySElvMkJIwPQrmS5IcBmGS+yWlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707423365; c=relaxed/simple;
	bh=+RTs0tvxM24Ryz5bljNL759ffo+2YNoUxuxyTBXYaGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q5b6bVyftnQSVgtWKUun35m6OHHGxwFlPyQUmRE26CGTtXosQGFu8Ym4vt8HgOl7BZN8qFRIfSe+yuOywRHGteDhdXW1wELyH86HXBciXjzkmqNaAl03nP+sgk/549jfszn27bvhOl+3wtirH+VASqNoh4/iUCC5mhsx3BXuq5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k6MnG6ik; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418Ja6BX021701;
	Thu, 8 Feb 2024 20:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=fCcHbyEAzqbnRluYnPu4Vp7xopD1bdKUBz6WsH9/P5c=;
 b=k6MnG6iktxBaNI3kignFILhQZmVoR3hxjLuK5tOyTKH+L/UMAWsgdFFYxfnTneehIPz+
 eBvM1yE0MqH9xHZz89dMKNbAc3l+WucutMe0nleOlE9qeNPph07VFAVNIq9fP+XK1CXt
 ZhVYmlbHpJBZb4evLsGW5dfLV2nQ0WBBQ7xpjpg8fPrNhujnEaHVmEOsr4yT/vNws/MA
 jwuwy0lJnwJ9KS7vM0gV02DhhMQRNQIGUa0nYDCjHv4BRR/hiw/gpqgxc3Y/ttHaD6To
 WE+MuZD45JUXK/AMITa2P2e5Su4Uhfi3RMRgcbvBVMThNMn+JNlZdW8vX7TyK/YUkmwS 6w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w53ejknrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 20:15:54 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 418K9OuH027077;
	Thu, 8 Feb 2024 20:15:53 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w53ejknrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 20:15:53 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 418IiVpe008487;
	Thu, 8 Feb 2024 20:15:52 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w221kejv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 20:15:52 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 418KFnMs58327306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Feb 2024 20:15:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC1F92006B;
	Thu,  8 Feb 2024 20:15:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7F932005A;
	Thu,  8 Feb 2024 20:15:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  8 Feb 2024 20:15:49 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 7EF41E1515; Thu,  8 Feb 2024 21:15:49 +0100 (CET)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 4/5] s390/irq,nmi: include <asm/vtime.h> header directly
Date: Thu,  8 Feb 2024 21:15:48 +0100
Message-Id: <03bf9f84e54e337fc8ccc75f89aef48a407aad31.1707422448.git.agordeev@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: f6hshjXUo1Xm-7YvHGAfsn2HiYbnU3J4
X-Proofpoint-GUID: lnAKe9dV9bzR3Ss9en7HFNSKr9KwJYoH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_08,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=561 spamscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402080108

update_timer_sys() and update_timer_mcck() are inlines used for
CPU time accounting from the interrupt and machine-check handlers.
These routines are specific to s390 architecture, but included
via <linux/vtime.h> header implicitly. Avoid the extra loop and
include <asm/vtime.h> header directly.

Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390/kernel/irq.c | 1 +
 arch/s390/kernel/nmi.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index 6f71b0ce1068..259496fe0ef9 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -29,6 +29,7 @@
 #include <asm/hw_irq.h>
 #include <asm/stacktrace.h>
 #include <asm/softirq_stack.h>
+#include <asm/vtime.h>
 #include "entry.h"
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct irq_stat, irq_stat);
diff --git a/arch/s390/kernel/nmi.c b/arch/s390/kernel/nmi.c
index 9ad44c26d1a2..4422a27faace 100644
--- a/arch/s390/kernel/nmi.c
+++ b/arch/s390/kernel/nmi.c
@@ -32,6 +32,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/pai.h>
 #include <asm/vx-insn.h>
+#include <asm/vtime.h>
 #include <asm/fpu/api.h>
 
 struct mcck_struct {
-- 
2.40.1


