Return-Path: <linux-kernel+bounces-76709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C183F85FB58
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF049B2681B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C288D4436C;
	Thu, 22 Feb 2024 14:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SOwJP4Z/"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916FB146900;
	Thu, 22 Feb 2024 14:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708612455; cv=none; b=Y0eLnMHJLav/5TTe/vDXbFVDDYKcjazQE1peHz36pMeb7yFeBBlbsyXPaTTbET+A3edVBkd1grWn/j8fXn1HlRFSAjqo9vVOltXpYjDblE7Y4DGeHtEVAa01Ty1MIkCXArpkAkvC57v3qB7bJQcKvDbf9QBeXyYdDgHAybV+47o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708612455; c=relaxed/simple;
	bh=Aj76EEzynrRxqN+bWAO8uIF2sVR6oRPPVjkDK0POcaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M4jSuGdYJIr1aQFbwrMPv2m5qTuoJoi9N3exViJZaQLNilz8yEfH7y9fiqqwLdr/0gXgUhdeMDZIztTds+eaeixVhHhyFMk9i9a/KvszvPb7ZpNsLsvnrbPNJ+Zt+8VZG+DN741DxOE65Mhsgp4PkJp7qNViH/a+mS9XXDVMvDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SOwJP4Z/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41MEW25j016247;
	Thu, 22 Feb 2024 14:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Z/5bfzM7V7qVpO1EyKZZQnXhM4gz8TxFOwY22JPu/4o=;
 b=SOwJP4Z/abccnlxwk8N8XWwyo+zyXadWJsAhy0IZnTfI0k112a2gdypO9fNSakV4YdMc
 EfIomcyxN0bwyUpJOI1+wMi9M1k+qMSV+PqdfN0X23iT2Lc7ofjuKXmvnfJ4Yh6fLNDz
 aKaGaoOGM22kidrKiQcwxqSCfjp7H4gM6CjulTJik2z9VbRHC84wgRnu7f/irATqEA3m
 O2bvKo1kTNmMuL1lEb9HRMuG/VjFSrSkHhO0WoZFF1V5+vpq0qg2E1SbKvHnw3eClT1K
 EI0kPIM0xeaqHqiSQhmVJ3mYYJVGwo5NWt20VSQd+8gm4Yu9cp2qA5n+2gMiNi/Rfsyg DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3we84582b8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 14:33:49 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41MEW39U016281;
	Thu, 22 Feb 2024 14:33:48 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3we84582a6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 14:33:48 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41ME8RxN003624;
	Thu, 22 Feb 2024 14:33:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb74ty0xn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 14:33:47 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41MEXgqI39125262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 14:33:44 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C0A120067;
	Thu, 22 Feb 2024 14:33:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AC8D20063;
	Thu, 22 Feb 2024 14:33:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 22 Feb 2024 14:33:42 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id DA398E0357; Thu, 22 Feb 2024 15:33:41 +0100 (CET)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH v2 RESEND 3/5] s390/vtime: remove unused __ARCH_HAS_VTIME_TASK_SWITCH leftover
Date: Thu, 22 Feb 2024 15:33:39 +0100
Message-Id: <8122a36afec672967e752716a36c2a31edcc06a9.1708612016.git.agordeev@linux.ibm.com>
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
X-Proofpoint-GUID: fss0KXxMWFdQK_fTeQCeNo_mrOZ-lmWG
X-Proofpoint-ORIG-GUID: 8daskvgbRaMWGOAHe5xQZjyEEU0Kjceo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_11,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=724 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402220116

__ARCH_HAS_VTIME_TASK_SWITCH macro is not used anymore.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Acked-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390/include/asm/vtime.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/s390/include/asm/vtime.h b/arch/s390/include/asm/vtime.h
index fe17e448c0c5..561c91c1a87c 100644
--- a/arch/s390/include/asm/vtime.h
+++ b/arch/s390/include/asm/vtime.h
@@ -2,8 +2,6 @@
 #ifndef _S390_VTIME_H
 #define _S390_VTIME_H
 
-#define __ARCH_HAS_VTIME_TASK_SWITCH
-
 static inline void update_timer_sys(void)
 {
 	S390_lowcore.system_timer += S390_lowcore.last_update_timer - S390_lowcore.exit_timer;
-- 
2.40.1


