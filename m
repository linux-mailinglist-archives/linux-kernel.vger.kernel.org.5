Return-Path: <linux-kernel+bounces-131169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AE98983FC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 742001C24100
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2FF757EB;
	Thu,  4 Apr 2024 09:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z0qGUI0R"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97F874432;
	Thu,  4 Apr 2024 09:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712222990; cv=none; b=Y7vxmfCLSPOSvl7aABtVTSWwDfJh/cQR9MOcHoENvB4NsWP9/zeKl7Pzu3JdnCVcCWigIHTsxtvfGBJUArh9IkoArrqxbHc9DcWUVsagLpEb4rmbFMSvNUJbUCyshuxSU8nMOilHJ+tUvEYBTCYiPA9iQjIrKORSvBecdw9lOWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712222990; c=relaxed/simple;
	bh=crKetrzwftEYvZYk3NHHekCXOxFZ5yv69ZIA4/ghxm8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HkBUpCPp+DvorC1aL5l3azV/kmb25aGmTC14LNtTx9W/G9WQ54Os63QeHg6T75bZCJZGdsPpsQJWcH3HATlGmEyLEuC2gG5cj7lpmlhMaP6GUc0PvjGXeGp7ppi2vnrhF0DXlFWvZEJmS8UBpQSNsBn9lRi537ENVfOkYA6P1qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z0qGUI0R; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4349NQ06024591;
	Thu, 4 Apr 2024 09:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=zM9i0taT6yWu1D6dyg6BlpyR/Lpy/5SpIJGW4NHA0cU=;
 b=Z0qGUI0RbGL0B8Bynjls8E2oV1Iwdu482qJf4JG3BPEy9dO3QKP/Zbc7WruSzS+V4AOZ
 Kno6evWjo6gA9u4mtmj8h7A9ggT1kTmaeWNQFc3daqMNWropLIani9NamfAqan2nq/bC
 Stf6JIL4zyIYZWgkiAZBzLsYOywiKkOt2NN+m1ytGtEMbgRC0XlkpPzERV6J51nIGmwH
 WggzA40gsvmOKwziTa+X6k796qCdXSa60sGwa3+6ji/SvW2WRA8EdBy0/cGcDnaR7EoQ
 fHmD2pVz7kt+l2meEr7PkamxrpxR+HrhLfsM19EzGW1XC3GgyeKANnStU/RukZCKeH8P PQ== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9sh9g0js-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 09:29:43 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43471CSD008686;
	Thu, 4 Apr 2024 09:29:42 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x9epw39pd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 09:29:42 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4349TaFn51904946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Apr 2024 09:29:38 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6FFF2005A;
	Thu,  4 Apr 2024 09:29:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8882E2004F;
	Thu,  4 Apr 2024 09:29:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Apr 2024 09:29:36 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH 1/1] ata: add HAS_IOPORT dependencies
Date: Thu,  4 Apr 2024 11:29:36 +0200
Message-Id: <20240404092936.3127972-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240404092936.3127972-1-schnelle@linux.ibm.com>
References: <20240404092936.3127972-1-schnelle@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 02_dhOl9RGGogsgVa4VMxn0p19w8Fie0
X-Proofpoint-GUID: 02_dhOl9RGGogsgVa4VMxn0p19w8Fie0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_05,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2404010000 definitions=main-2404040063

In a future patch HAS_IOPORT=n will disable inb()/outb() and friends at
compile time. We thus need to add HAS_IOPORT as dependency for those
drivers using them.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Note: This patch does not depend any not-yet-mainline HAS_IOPORT changes
and may be merged via subsystem specific trees at your earliest
convenience.

 drivers/ata/Kconfig      | 28 ++++++++++++++--------------
 drivers/ata/libata-sff.c |  4 ++++
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 928ec93c6b45..b595494ab9b4 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -556,7 +556,7 @@ comment "PATA SFF controllers with BMDMA"
 
 config PATA_ALI
 	tristate "ALi PATA support"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	select PATA_TIMINGS
 	help
 	  This option enables support for the ALi ATA interfaces
@@ -566,7 +566,7 @@ config PATA_ALI
 
 config PATA_AMD
 	tristate "AMD/NVidia PATA support"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	select PATA_TIMINGS
 	help
 	  This option enables support for the AMD and NVidia PATA
@@ -584,7 +584,7 @@ config PATA_ARASAN_CF
 
 config PATA_ARTOP
 	tristate "ARTOP 6210/6260 PATA support"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  This option enables support for ARTOP PATA controllers.
 
@@ -611,7 +611,7 @@ config PATA_ATP867X
 
 config PATA_CMD64X
 	tristate "CMD64x PATA support"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	select PATA_TIMINGS
 	help
 	  This option enables support for the CMD64x series chips
@@ -658,7 +658,7 @@ config PATA_CS5536
 
 config PATA_CYPRESS
 	tristate "Cypress CY82C693 PATA support (Very Experimental)"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	select PATA_TIMINGS
 	help
 	  This option enables support for the Cypress/Contaq CY82C693
@@ -706,7 +706,7 @@ config PATA_HPT366
 
 config PATA_HPT37X
 	tristate "HPT 370/370A/371/372/374/302 PATA support"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  This option enables support for the majority of the later HPT
 	  PATA controllers via the new ATA layer.
@@ -715,7 +715,7 @@ config PATA_HPT37X
 
 config PATA_HPT3X2N
 	tristate "HPT 371N/372N/302N PATA support"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  This option enables support for the N variant HPT PATA
 	  controllers via the new ATA layer.
@@ -818,7 +818,7 @@ config PATA_MPC52xx
 
 config PATA_NETCELL
 	tristate "NETCELL Revolution RAID support"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  This option enables support for the Netcell Revolution RAID
 	  PATA controller.
@@ -854,7 +854,7 @@ config PATA_OLDPIIX
 
 config PATA_OPTIDMA
 	tristate "OPTI FireStar PATA support (Very Experimental)"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  This option enables DMA/PIO support for the later OPTi
 	  controllers found on some old motherboards and in some
@@ -864,7 +864,7 @@ config PATA_OPTIDMA
 
 config PATA_PDC2027X
 	tristate "Promise PATA 2027x support"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  This option enables support for Promise PATA pdc20268 to pdc20277 host adapters.
 
@@ -872,7 +872,7 @@ config PATA_PDC2027X
 
 config PATA_PDC_OLD
 	tristate "Older Promise PATA controller support"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  This option enables support for the Promise 20246, 20262, 20263,
 	  20265 and 20267 adapters.
@@ -900,7 +900,7 @@ config PATA_RDC
 
 config PATA_SC1200
 	tristate "SC1200 PATA support"
-	depends on PCI && (X86_32 || COMPILE_TEST)
+	depends on PCI && (X86_32 || COMPILE_TEST) && HAS_IOPORT
 	help
 	  This option enables support for the NatSemi/AMD SC1200 SoC
 	  companion chip used with the Geode processor family.
@@ -918,7 +918,7 @@ config PATA_SCH
 
 config PATA_SERVERWORKS
 	tristate "SERVERWORKS OSB4/CSB5/CSB6/HT1000 PATA support"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  This option enables support for the Serverworks OSB4/CSB5/CSB6 and
 	  HT1000 PATA controllers, via the new ATA layer.
@@ -1182,7 +1182,7 @@ config ATA_GENERIC
 
 config PATA_LEGACY
 	tristate "Legacy ISA PATA support (Experimental)"
-	depends on (ISA || PCI)
+	depends on (ISA || PCI) && HAS_IOPORT
 	select PATA_TIMINGS
 	help
 	  This option enables support for ISA/VLB/PCI bus legacy PATA
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 95a19c4ef2a1..250f7dae05fd 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -3032,6 +3032,7 @@ EXPORT_SYMBOL_GPL(ata_bmdma_port_start32);
  */
 int ata_pci_bmdma_clear_simplex(struct pci_dev *pdev)
 {
+#ifdef CONFIG_HAS_IOPORT
 	unsigned long bmdma = pci_resource_start(pdev, 4);
 	u8 simplex;
 
@@ -3044,6 +3045,9 @@ int ata_pci_bmdma_clear_simplex(struct pci_dev *pdev)
 	if (simplex & 0x80)
 		return -EOPNOTSUPP;
 	return 0;
+#else
+	return -ENOENT;
+#endif /* CONFIG_HAS_IOPORT */
 }
 EXPORT_SYMBOL_GPL(ata_pci_bmdma_clear_simplex);
 
-- 
2.40.1


