Return-Path: <linux-kernel+bounces-153339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0148ACCD2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F7E282654
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D661474D9;
	Mon, 22 Apr 2024 12:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ALq0nZP2"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8D63D3B3;
	Mon, 22 Apr 2024 12:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713789447; cv=none; b=WtbcaKktHavDgUSs0rrn2Mqlfu0YK1MiwLrTvi+PC1ZN+7QL4kNH1nBgUa49FmAbWjqcy6YFtzN8NkGJ4e/+fL25PYQdkQ2eXD4c39BAK4iCQAQS/cf1ZAOcqGiWaXrUWKZsQTJWEqNP/ELm9hFYJO66TSNGx2UrCX8q5412frs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713789447; c=relaxed/simple;
	bh=YXfnY3uXb0kk2ZUXCnaUYrvxflw+efPYVi7JZ98E4+w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KCcco0Rz3kRU5dJENMrnf54X08C49qpOcNkxA+2hkVh+9JSi1L2sxdI2fcbJU/oY6oebPz9X5lfAX2HX5+yHjr7UxMxPIFxwbqBQvmKUEApoHW8g4Bx861nrAXES+5fp5LktT5ZYqrh0hHYXZE+stppN44TPNFKJ32dhW5BxM3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ALq0nZP2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43MBZ7Ee007942;
	Mon, 22 Apr 2024 12:37:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=GxnnFQoz94BKJ9kB/lpuOb10NsdHZD2kbzSsvQhsOYU=;
 b=ALq0nZP2CMCyQWlfGy9HYepQimkgcTwviEsdnS26+Za4VQFJO0VonuCLsIGaRNuqLNiO
 4yCjqrH+rTx7wnDZAgnhhnb2Gmsa6UrCjDvVppQKsFLF9HqkwAspuQdPOYCm9oq2YNSW
 g4C2huMfqbauGE0IWA0QOLIxZCuVswOiiJGcFfUuhF6NbZQEuyUinkUgmfX105Seq2Mc
 w/ClBUAtDbyjOkXawyi31ChYT2QcPqHzYWlYq4ASdrxxSb4PlY2EMtNJe66RWpz8KLrU
 6SJuWsgx9KTEWg/gzP10uO6ZZsXjfQZlzb87k+UCXQ3fvi1DvxEbtwl+s4NPJ7hC5Njc 1w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xnq4sr59a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 12:37:18 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43MCbIDd006776;
	Mon, 22 Apr 2024 12:37:18 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xnq4sr599-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 12:37:18 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43M9RG83020907;
	Mon, 22 Apr 2024 12:37:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xmrdyqshg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 12:37:17 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43MCbCn314025168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 12:37:14 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE2ED2004B;
	Mon, 22 Apr 2024 12:37:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9C6B20040;
	Mon, 22 Apr 2024 12:37:11 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Apr 2024 12:37:11 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH] char: tpm: Keep TPM_INF_IO_PORT define for HAS_IOPORT=n
Date: Mon, 22 Apr 2024 14:37:11 +0200
Message-Id: <20240422123711.1739063-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hcDaol3j_f_7tNnnIzjgAbeHkfE519_I
X-Proofpoint-GUID: 3Am2FGgfmbcM0n005wPIJveUQmJV9aav
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 clxscore=1011 mlxlogscore=999 spamscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404220056

The recent change to handle HAS_IOPORT removed the TPM_INF_IO_PORT
define for the HAS_IOPORT=n case despite the define being used in
sections of code not covered by the same ifdef check. This was missed
because at the moment TCG_INFINEON indirectly depends on HAS_IOPORT via
PNP which depends on ACPI || ISA. As TCG_INFINEON does in principle
support MMIO only use add it for COMPILE_TEST to cover the HAS_IOPORT=n
case.

Link: https://lore.kernel.org/lkml/9d9fa267-067e-421b-9a39-aa178b913298@app.fastmail.com/
Fixes: dab56f80e7f9 ("char: tpm: handle HAS_IOPORT dependencies")
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Note 0: I compile tested this with allyesconfig on s390 using my branch with
        compile-time disabled in*()/out*() and verified that TCG_INFINEON was
        built
Note 1: The SHA of the fixed commit is from linux-next

 drivers/char/tpm/Kconfig        | 2 +-
 drivers/char/tpm/tpm_infineon.c | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 418c9ed59ffd..852bb9344788 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -157,7 +157,7 @@ config TCG_ATMEL
 
 config TCG_INFINEON
 	tristate "Infineon Technologies TPM Interface"
-	depends on PNP
+	depends on PNP || COMPILE_TEST
 	help
 	  If you have a TPM security chip from Infineon Technologies
 	  (either SLD 9630 TT 1.1 or SLB 9635 TT 1.2) say Yes and it
diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
index 99c6e565ec8d..2d2ae37153ba 100644
--- a/drivers/char/tpm/tpm_infineon.c
+++ b/drivers/char/tpm/tpm_infineon.c
@@ -26,9 +26,7 @@
 #define	TPM_MAX_TRIES		5000
 #define	TPM_INFINEON_DEV_VEN_VALUE	0x15D1
 
-#ifdef CONFIG_HAS_IOPORT
 #define TPM_INF_IO_PORT		0x0
-#endif
 #define TPM_INF_IO_MEM		0x1
 
 #define TPM_INF_ADDR		0x0
-- 
2.40.1


