Return-Path: <linux-kernel+bounces-129827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7658970DF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18515B27D30
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0108514883B;
	Wed,  3 Apr 2024 13:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FmKvGb8a"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3C5146D4B;
	Wed,  3 Apr 2024 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150700; cv=none; b=NbjBEYfqh5uHNz4fI59wFXQLeaFqEtkWG8qJSnQlkqepxW6771cClfnNMMygwu38RHp2ryp94Gt+kiP3s/u8LNEliwqJ+rOr7hjTGZmvIZAh2jCmnPJa2fa90tmv+x1SNRNHdYAOmg25HgaD22LuRoeDJHtb6ya5zI4L91Mx848=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150700; c=relaxed/simple;
	bh=sG4ZBcx0nL6tsRIBWxpVJVKzWvn4LPKpsx4c7naEXqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rIPiUUhllFSGF9FCzjUEGJc9SGzMtWCAWX7qNrSfltjNw8iYgZ0rGINiPVEPKB6R2seJESXGqs5aiVEOi/OX+G+ji3/N38/Tirw2z7kEvka4lHvDA2TNxAYqCX6pnUSzE/Mmc9jQwzc4HO3GHfUlXRqCA96H5hzAQR/bu28lzCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FmKvGb8a; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 433CqIf2013793;
	Wed, 3 Apr 2024 13:24:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=yrZpHJEKaPlUVuMcwji6u6JJ4veOeL1b0Jghsa6Edw0=;
 b=FmKvGb8aLWvt3ceuVQ8wVUA9bI2uN0dcpVRGTYl/7b3FPusoYM8xYxSzPj7vGjHKLEJM
 hnZY8qdRPpz8hurrRA4LIVj5QyGggkvNEUV6q5o2MgFricXeZs/9cUWYOVSlqX2V+Axc
 tssNvxNKoVWa2acwvkDK0wV+5Ow2IbP+Q3loExf3DEfVKEN8EkTme7udIntjQOHvjcuq
 JHil8d8qxHh2iAYdJXjKtlaUjIxMNjlpH+8h0zO1Idht+S0f8muhGmvS2Lw3qWhP2OFX
 BdHD2PuDQ8QBh7AXOrvQQVivpRAZe0rkWPLbAYoHHdbx+DU7ZCyuwQgfbOSMMsic9ijM jA== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x97gd03as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 13:24:54 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 433AuqVI008468;
	Wed, 3 Apr 2024 13:24:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x6w2u5rf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 13:24:53 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 433DOm6f30278308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Apr 2024 13:24:50 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03E5F20043;
	Wed,  3 Apr 2024 13:24:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCD1D2004F;
	Wed,  3 Apr 2024 13:24:47 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Apr 2024 13:24:47 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Brian Cain <bcain@quicinc.com>
Cc: linux-hexagon@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH 1/1] hexagon: Don't select GENERIC_IOMAP without HAS_IOPORT support
Date: Wed,  3 Apr 2024 15:24:47 +0200
Message-Id: <20240403132447.719833-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240403132447.719833-1-schnelle@linux.ibm.com>
References: <20240403132447.719833-1-schnelle@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rHzvEC_PxiKfMB3xuTNfm_hHIM6VY0s3
X-Proofpoint-GUID: rHzvEC_PxiKfMB3xuTNfm_hHIM6VY0s3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_12,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0 clxscore=1011
 mlxlogscore=634 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2403210000 definitions=main-2404030092

In a future patch HAS_IOPORT=n will disable inb()/outb() and friends at
compile time. As hexagon does not support I/O port access it also
the GENERIC_IOMAP mechanism of dynamically choosing between I/O port and
MMIO access doesn't work so don't select it.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/hexagon/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index e233b5efa276..5ea1bf4b7d4f 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -31,7 +31,6 @@ config HEXAGON
 	select HAVE_ARCH_TRACEHOOK
 	select NEED_SG_DMA_LENGTH
 	select NO_IOPORT_MAP
-	select GENERIC_IOMAP
 	select GENERIC_IOREMAP
 	select GENERIC_SMP_IDLE_THREAD
 	select STACKTRACE_SUPPORT
-- 
2.40.1


