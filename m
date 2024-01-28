Return-Path: <linux-kernel+bounces-41923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D648E83F99E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8481D1F2350D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6364438C;
	Sun, 28 Jan 2024 19:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EmD8AmkF"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3125F3CF44;
	Sun, 28 Jan 2024 19:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706471955; cv=none; b=h7Bhvkf/cN7FqT3McNRiBUS66YPvU0BDse+yZOQnkS6icXESTkdTChSnrXS3YDB30+WR/XsazO6wl2e+Zd/0Pv7ZnX06U9N8j9p4j6+ccIs8u9r/fl2F+CQqsON8WMeqoGZhUNuGeYKuBUADU2qrRJUqBmgChavYp0FopBu4rUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706471955; c=relaxed/simple;
	bh=JSOh7uJNDrp6PVMXwFFyTSGlmh4q/M6AINvsVmt+3oo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ukDd6tAdnBQb2xTeT7FSq8XZBmLyDuPSb/XPCjg/YWMN1z47M635xuopMxW+Y1HlDyFvCWqhQ2vYL85BRygAY6BKodTSsAPOQQqrUstlWKdxg/pXjRYgwzj6TVt+nHZiTQmWuCRlYArD0Z3nPn9rntG5coXV7/fHCPIP3fU80wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EmD8AmkF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40SIOZ3Q026214;
	Sun, 28 Jan 2024 19:58:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=vWUzhYOc7X86FwVTZQTxEXaT99ntUXq8iH3H0R74AWw=;
 b=EmD8AmkFsVGQwvl4g6lRfMoW3XzaaAVg3MA9Y3UHc4V3u5VvkmqNhrwUoSz+MQ7khwF/
 I+UMBrplraS1a9WWSWkHJMbgnwhGf87JipichHMUgxHlfbwQdoZ0SfgckN7N6zzPHZCA
 sFK/2C6OnLIutHmT6vn4IFp7X78OGBkTooQjA6MTAWixUIofymTCdSDynivAE4dcgv7m
 wAlyUpATNdKnZPRYP0/9hKzfQxxdkytDCyiZ43KTJZtmBKZVNfbhOaY/HkQplJlkCART
 g5VThWXWjbFUSuVdeXdyqixL9JRStfP+qlkCpIr1eflRdmiDCqOB32VCO3V77yV9yii0 fQ== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vwu6qhrwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Jan 2024 19:58:59 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40SIHe7v010887;
	Sun, 28 Jan 2024 19:58:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vweck3ve4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Jan 2024 19:58:58 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40SJwtfG12190304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 28 Jan 2024 19:58:55 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 029C22004B;
	Sun, 28 Jan 2024 19:58:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5BFA20040;
	Sun, 28 Jan 2024 19:58:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 28 Jan 2024 19:58:54 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id B0A4CE0827; Sun, 28 Jan 2024 20:58:54 +0100 (CET)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/5] s390/irq,nmi: do not include <linux/vtime.h> header
Date: Sun, 28 Jan 2024 20:58:53 +0100
Message-Id: <966148629217b56139f40c38ffbb45ca229bd489.1706470223.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1706470223.git.agordeev@linux.ibm.com>
References: <cover.1706470223.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZuVfL-7qioT-9fAqTgVQFx1el86fRp9S
X-Proofpoint-GUID: ZuVfL-7qioT-9fAqTgVQFx1el86fRp9S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=726 malwarescore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401280151

update_timer_sys() and update_timer_mcck() are inlines used for
CPU time accounting from the interrupt and machine-check handlers.
These routines are specific to s390 architecture, but declared
via <linux/vtime.h> header, which in turn inludes <asm/vtime.h>.
Avoid the extra loop and include <asm/vtime.h> header directly.

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


