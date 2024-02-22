Return-Path: <linux-kernel+bounces-76708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A60285FB54
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBA651C2381A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9290E14A08F;
	Thu, 22 Feb 2024 14:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ElTN/Tb6"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CB71474A2;
	Thu, 22 Feb 2024 14:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708612449; cv=none; b=Jz8WpsUQuZIR/HGNf2kipQPsSM4B1/UfOrwcE84gbG9tphtrKX7yNmg4PgwoivePDhMWImgWjJ76rQfNGhjIOK/ZR60UUuEKBZ0v4eMGPg7gkxmbkXUDZ7wSWhZkaXJgkX4ZF8Q30fqrkmA9rSbl5cahVw+Nw04ZhIWPd2Rxq/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708612449; c=relaxed/simple;
	bh=oIQ5ixyZVUtaITgpCYO6cxZijRq/1Oi5Mu9UXRRodeE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YhwbWh4hLWaQrsEBQEuhBkqCQcFD4q7ZxCAnDBsfa0dXEyL2IL+oFKtJmO63KYcuCvw4RNK2jlMXueiWp1tWBmTSVcNcuQAYdRbkaMCOU/DrNhgrZg/FEAma4AVHtbWFb75LxHDgHgJKDEoWt77HWXHOxKy4MbRzagC2wXRkzTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ElTN/Tb6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41MECUQL008624;
	Thu, 22 Feb 2024 14:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=goIiqaO1e1ZadVL5tmtv4UVpZpbODSAt3kyKMNXwyEY=;
 b=ElTN/Tb64gPqiMVuwN9eJtnxQexjb1pU/CZ4uIs88YDsSu+eJ8O5U2ucOfvFHSUSNNE4
 9rsmJyRBGV7dsVSIBvKST4vghO5pNHsMgum1Z3cRzOPWocqPPWvmfPxJpJlFIICz3Hfl
 m8SV8qv+Q4qz10Wvv0H5fmuzqYx7j9cV+ePECmgtiPivUpu111ueQRmAwKZc2i2zWctY
 KNZetsgN+lmNgOJedCQ6MjfNOHQyF16c22usN9o8/V/kiXEp8ZdVdGHiNnkEJcNG3YfH
 omOe9vNCcQXpT+GyQBkCBbXiXCcau7Dc6HyTEeTQ/IH3CPjkRkMpNjFW7E1j2HILSnYi 6A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3we73wsne1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 14:33:49 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41MEWdu5019670;
	Thu, 22 Feb 2024 14:33:48 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3we73wsndk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 14:33:48 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41MDAPHG031187;
	Thu, 22 Feb 2024 14:33:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb9bm6abk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 14:33:47 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41MEXgdY25756394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 14:33:44 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3281A20065;
	Thu, 22 Feb 2024 14:33:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2044E2004E;
	Thu, 22 Feb 2024 14:33:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 22 Feb 2024 14:33:42 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id D53FBE030D; Thu, 22 Feb 2024 15:33:41 +0100 (CET)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH v2 RESEND 1/5] sched/vtime: remove confusing arch_vtime_task_switch() declaration
Date: Thu, 22 Feb 2024 15:33:37 +0100
Message-Id: <5ac8fce79eb47eed86b710babd83af577f166164.1708612016.git.agordeev@linux.ibm.com>
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
X-Proofpoint-GUID: kOAD8-fn0RWz543dlwTCqh0zr5pKOjol
X-Proofpoint-ORIG-GUID: YOi76P0jMPXsyYKWYat_9_kFRAUW-vbL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_11,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015
 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=850 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220116

Callback arch_vtime_task_switch() is only defined when
CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is selected. Yet, the
function prototype forward declaration is present for
CONFIG_VIRT_CPU_ACCOUNTING_GEN variant. Remove it.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 include/linux/vtime.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index 3684487d01e1..593466ceebed 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -18,7 +18,6 @@ extern void vtime_account_idle(struct task_struct *tsk);
 #endif /* !CONFIG_VIRT_CPU_ACCOUNTING */
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
-extern void arch_vtime_task_switch(struct task_struct *tsk);
 extern void vtime_user_enter(struct task_struct *tsk);
 extern void vtime_user_exit(struct task_struct *tsk);
 extern void vtime_guest_enter(struct task_struct *tsk);
-- 
2.40.1


