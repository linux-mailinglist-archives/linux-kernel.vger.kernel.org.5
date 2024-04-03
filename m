Return-Path: <linux-kernel+bounces-129728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 475A0896F1A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C99992862DE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6544146A75;
	Wed,  3 Apr 2024 12:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mo1At7Hi"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAE5241E2
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 12:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148211; cv=none; b=SEoVdk1o3kuwWdNBrUlcozyB+JcxZIIpIVGM0AUd67kI1ogteh0enrvWTFQLznRNG1mc0MsJAA7cmQZMR1rep2762DcKdHEHi6R+hfX9Sk6TV8WpoTXWbDFqskTiz7rDF1iyqkQ8lynkkIzLRREfDs4J9cy8ehqquMfuJYvsk8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148211; c=relaxed/simple;
	bh=4TrXlv1v21w1NCqJ0KVePqKfWscKXooLge3QQJ9nOzw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mDkDZD4vAv2xFte0Lf1ZI5MZ/qg+FTnxUi0NiTRlYNf2USdlpFYTf5PIA85mE4VLaLhaOHGBp47JAHdsoNhobFcbR6n+Zzjv4I2toaNdBvNAYrPMqyIBDuOlXBGgxFC2Ml8TZGMelhuCJHmne7ZtS85hnb5ejQw8YsNcNpafKCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mo1At7Hi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 433BmCXf024743;
	Wed, 3 Apr 2024 12:43:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=3DCW58lhecvc9h39XcdmzUDvmZO0DYlk0Q396n3JT88=;
 b=mo1At7HiA/m2VtIXEPmdRksxyyhjZ+35eSSqIxVJdkYYORQhisCTtqpnyBo+9otDcShI
 VCkdqNKG00mSBJD9TRozRfBCS2NVd05egyN+id761oPb2XNKRYs3FDfBuO/vYed4w5qf
 PHa1xv6hmnxCdJ8H+pgR9Guu0dvlqdpas3cZjglmyIjdbfUnWLGfMeKR3I0hVZaESNGO
 Zj1au0fR6706SVRe+t5ug8Jqumrd2fXnO9GfJw3kFjyt2nCBukplzWe4if2DhedXOrSw
 tU8GM1A6v/2xyAX9KEXmFxUrlNqe+CW+AMiBOjS4NvB2w3kbeCWt6D9A0KDAtz/w05HY mw== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x96j2g48f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 12:43:09 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 433CN5EC002189;
	Wed, 3 Apr 2024 12:43:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x6xjmn4bm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 12:43:08 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 433Ch2tW27984544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Apr 2024 12:43:04 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C7432004D;
	Wed,  3 Apr 2024 12:43:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 422462004F;
	Wed,  3 Apr 2024 12:43:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Apr 2024 12:43:02 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Arnd Bergmann <arnd@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH 1/1] um: Select HAS_IOREMAP for UML_IOMEM_EMULATION
Date: Wed,  3 Apr 2024 14:43:00 +0200
Message-Id: <20240403124300.65379-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240403124300.65379-1-schnelle@linux.ibm.com>
References: <20240403124300.65379-1-schnelle@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6PYNeKu-ZMc15mWQZHr-qmzJtAUx0Eki
X-Proofpoint-ORIG-GUID: 6PYNeKu-ZMc15mWQZHr-qmzJtAUx0Eki
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_10,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=796 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404030087

In a future patch HAS_IOPORT=n will disable inb()/outb() and friends at
compile time. UML supports these via its UML_IOMEM_EMULATION so let that
select HAS_IOPORT and also reflect this in NO_IOPORT_MAP.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/um/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 93a5a8999b07..758016731156 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -48,12 +48,13 @@ config NO_IOMEM
 config UML_IOMEM_EMULATION
 	bool
 	select INDIRECT_IOMEM
+	select HAS_IOPORT
 	select GENERIC_PCI_IOMAP
 	select GENERIC_IOMAP
 	select NO_GENERIC_PCI_IOPORT_MAP
 
 config NO_IOPORT_MAP
-	def_bool y
+	def_bool !UML_IOMEM_EMULATION
 
 config ISA
 	bool
-- 
2.40.1


