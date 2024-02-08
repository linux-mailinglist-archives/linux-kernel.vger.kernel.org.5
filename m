Return-Path: <linux-kernel+bounces-58651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEA584E977
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B05289D2B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64303BB35;
	Thu,  8 Feb 2024 20:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Lbl9l7ZL"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8937383AC;
	Thu,  8 Feb 2024 20:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707423367; cv=none; b=JrUcdB5UhL57tNPLszSapxjhx7q5q+5ad81QmGitkcDf+yc7B0Dkb71qbW8D9pIqXksPdPbq0FYjRw5O5GbCRXfLHOqu6UTFH0+X59C36idMg/9QX4nGQfZV7By9WazAZOVZTsaSlnC17ftAYfHEhFSD1ahkJmwkiMwUz/oCSVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707423367; c=relaxed/simple;
	bh=Pvxp2QX8WBCjIcQJyKwcXYRUTQsgpjL/Qy4Z6z02JcU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eLZxrAcEFFuqjAyHIqq8LdK2SIv0c//h8RY8mMh76aJ3bov0SGnPu4xOE7tXsryoAvPGxuZLh5cQvx04tqseK8IqZ5Yc6+2iD+iG3IwPM0AxNDbALw+UuIt/tVMg8UnGQGz9MRfyRQ4Tii03PbkOl6HaQ+Uou36sjaA04cd5I98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Lbl9l7ZL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418JYqma013853;
	Thu, 8 Feb 2024 20:15:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=7/WCPTz+SYsbI0BE/Xci4RbfspxHDVvpG2N4ZkvAbp8=;
 b=Lbl9l7ZLynkaJmNowGT2EqjXFviV3SVMReqNmMXqfvWdY1vAYwo1sqs+7v/6bYh+BhrO
 8+Xg48V3Re5I7klP5HY76sawMciq8akzCn6E14Mvcml/C9i6u3BbBmwyXu3+byvwVdI4
 +OUUQ8sLA+wsqNwAaqu5zGiz3zITV/RW1OlkzZqFBiWovVXeip+ThIRfDZj4k7s0X2DY
 mnLAfQPARxao8Ly6liYEMJ8al/BKtOELp0TDd48km2LRWzUnkZB7YdFnpbDiYdpuwA4I
 rtsi5pDMPACfIyUl+icRND5EVCIHJPIAxoGYNES1w9dCoPyOVlyjcuvf0zXupW13s9ed xA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w52n8vxh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 20:15:54 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 418K03R2012748;
	Thu, 8 Feb 2024 20:15:54 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w52n8vxh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 20:15:54 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 418HoVab014837;
	Thu, 8 Feb 2024 20:15:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w20tp6xqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 20:15:53 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 418KFncT63897994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Feb 2024 20:15:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B56F92006A;
	Thu,  8 Feb 2024 20:15:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5BE92004F;
	Thu,  8 Feb 2024 20:15:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  8 Feb 2024 20:15:49 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 7CB83E1506; Thu,  8 Feb 2024 21:15:49 +0100 (CET)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 3/5] s390/vtime: remove unused __ARCH_HAS_VTIME_TASK_SWITCH leftover
Date: Thu,  8 Feb 2024 21:15:47 +0100
Message-Id: <2fcc4503851ef7cbb6106ba6706179605b7449fd.1707422448.git.agordeev@linux.ibm.com>
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
X-Proofpoint-GUID: lYdknQdTuxHJi3DIu_qdhzuqJ0AFDCak
X-Proofpoint-ORIG-GUID: viJi4lte1G6rRyc-3KH12DC1wPw-alKU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_08,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=607
 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 clxscore=1011 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402080108

__ARCH_HAS_VTIME_TASK_SWITCH macro is not used anymore.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
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


