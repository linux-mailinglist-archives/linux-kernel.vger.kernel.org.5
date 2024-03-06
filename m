Return-Path: <linux-kernel+bounces-94203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BD9873B4A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A51AC1C22BBA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6FF135415;
	Wed,  6 Mar 2024 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VDW9bItj"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FD1135403;
	Wed,  6 Mar 2024 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740536; cv=none; b=J+4kTqpJ8er1V8F1akKAO/lb5cTcWxWcrdVC22YLw/WOVPEziLFMXkBTmcCCHm/65yweUl380+xwzR3N8QgQCKjnTuCFfbr2vQHhsoYX1soOR6ZGq/MQGR3JOS/88Iw/YerdY65Wy5IfAEkDXW95bcOjSbUxC96FcMbiM/3rmaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740536; c=relaxed/simple;
	bh=ir767ne9JimBjwRrJMhtJ3QBzdqcT/kh4YcW8r9vP5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQEOEned+hKlgt9Je9gD6i8G7XodjI7BbjmUjWmz5+E6lkKo964yZv9BbxErTf0Z/DQHbBFvvxrhZfOTrIcNqBVy4ut3yt1prAL4OzyVWFy3Wr5Hkj4woo414mILULotovTiPLvfCMTHUzSBWd/vs9BaMir/abYAAJ/JRhzsyYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VDW9bItj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426FlLAQ001528;
	Wed, 6 Mar 2024 15:55:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=IXWoups9Y8zF5xwMNKR0a8eJWNTgS5UyW6H40hqExu0=;
 b=VDW9bItjiqLt8+vxG1nJs6T6n240921P63OpU0RCPflxIXsHXQNSjgiPmeQvCXhgwCZU
 +OtCFr14LddHWzKUcP2Ww2P/lmhlUIMjfwC/ztxVUV5tey7Ci5cK0BO+yDrvqLLkGs9/
 yXmQMexWg30Xf0ptoVViBVbvAvvBvrxFWXfFxoKjiZNbNA0C5hNoaq0ikEsGS3B+OGJm
 EjnxKEEI2FBiBokvKW1+pM5i0hwgPDOgidN4o+ljiQoP4saA97tSKSH49k734urX2UTn
 PoD79HBaHb9ud3O25GkhRHaalC5/qzhwN82/euuyOoDGSgQR0/WSqZhoslbtP57YtWZc Jg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wpuecg8sa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 15:55:20 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 426FliFf002449;
	Wed, 6 Mar 2024 15:55:20 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wpuecg8rt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 15:55:19 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 426ErHS6031554;
	Wed, 6 Mar 2024 15:55:19 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmgnk78er-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 15:55:19 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 426FtF3x41419126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 15:55:17 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AD7758056;
	Wed,  6 Mar 2024 15:55:15 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D31D358063;
	Wed,  6 Mar 2024 15:55:14 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Mar 2024 15:55:14 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: mpe@ellerman.id.au, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, jarkko@kernel.org, rnsastry@linux.ibm.com,
        peterhuewe@gmx.de, viparash@in.ibm.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 1/2] powerpc/prom_init: Replace linux,sml-base/sml-size with linux,sml-log
Date: Wed,  6 Mar 2024 10:55:10 -0500
Message-ID: <20240306155511.974517-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306155511.974517-1-stefanb@linux.ibm.com>
References: <20240306155511.974517-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lMomfaZZWQBmqO6Za5IwCMILpz3BqYaW
X-Proofpoint-GUID: zee2mnnQu7lmthaiNx2437zDeQIchGGD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_10,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403060127

linux,sml-base holds the address of a buffer with the TPM log. This
buffer may become invalid after a kexec and therefore embed the whole TPM
log in linux,sml-log. This helps to protect the log since it is properly
carried across a kexec with both of the kexec syscalls.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 arch/powerpc/kernel/prom_init.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index e67effdba85c..41268c30de4c 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -1956,12 +1956,8 @@ static void __init prom_instantiate_sml(void)
 
 	reserve_mem(base, size);
 
-	prom_setprop(ibmvtpm_node, "/vdevice/vtpm", "linux,sml-base",
-		     &base, sizeof(base));
-	prom_setprop(ibmvtpm_node, "/vdevice/vtpm", "linux,sml-size",
-		     &size, sizeof(size));
-
-	prom_debug("sml base     = 0x%llx\n", base);
+	prom_setprop(ibmvtpm_node, "/vdevice/vtpm", "linux,sml-log",
+		     (void *)base, size);
 	prom_debug("sml size     = 0x%x\n", size);
 
 	prom_debug("prom_instantiate_sml: end...\n");
-- 
2.43.0


