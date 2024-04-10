Return-Path: <linux-kernel+bounces-138181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836DF89EDD1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A283C1C20F92
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56671552FB;
	Wed, 10 Apr 2024 08:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="caVBoCF0"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17BD13D287;
	Wed, 10 Apr 2024 08:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712738547; cv=none; b=HzvLheyPKjE+763ANeDc+iBd9BNXhnYotxoFKJT3W8dk1igTRMWxL7bvXVnyINWhzeyXxoRmLj1LPtIOdSIMbCHthz+z/gxBnaZxfuJiiFnyGjrqkesppR+0IV7d4aqrjka1ARQVVbe8E9p6tQ52y49rt1u0Tna1Uksbi0niUUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712738547; c=relaxed/simple;
	bh=l4zvC8QFebdhJGEcIKYHtXFHbmLIYfu7cHeCiYKIi5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u1C5gJmJjWCMZ5tlBC5xESY8Y3r10Rpm8RB/voTti8+avaBdwgZqFMRmTSVXd0bGaNRWRzYQzfYP/hS5EVXGTEfccSEyhmuVtdtIsBXVTxUvB82UGPHFF1zbTtxyrYDW5/GdwGKShvo+F1Od1TFRLp/hfF+sbDtdWn99mwX/gT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=caVBoCF0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43A8LSPE017830;
	Wed, 10 Apr 2024 08:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wFaV94qLneLT6x9XDlOqxqnyBQ1T6VBdaY+Hz/Zbc4A=;
 b=caVBoCF0L+l30HLLfauMczpzN9REM3U7CaplEbHjCFhMu7wDb61ACo2QmziJHdC8kVLL
 hNVM6D794ZBHauMhJQ0Y404T8svIoEPjQteFPljsle9Gnnu8tbN56s07XedHAiuueFEN
 0RXqRs/Yp+2jU4qsXRQPIqhc3MdvOyEBKj2UEC1yj7nhCMhTOkWkpFqICfmrt+HQbtFf
 oQOo8a/TrL6rV8gUOTI15vRQgRStGP+DicBI5n12BScu8kg98QigQn3ZToZup2QPMKoE
 +EE1gJtQSMegihWRcSqJFWar7YNh4gI++ZngZQZ1UeVwZSFmeqT2rU25RC7RZKxNUw3r Zg== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xdpwc82ta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 08:42:08 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43A5boHR016990;
	Wed, 10 Apr 2024 08:42:07 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xbke2k7mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 08:42:07 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43A8g2Ed39256348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 08:42:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E79D520040;
	Wed, 10 Apr 2024 08:42:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C09762004D;
	Wed, 10 Apr 2024 08:42:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Apr 2024 08:42:01 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH 1/1] watchdog: add HAS_IOPORT dependencies
Date: Wed, 10 Apr 2024 10:42:01 +0200
Message-Id: <20240410084201.1481930-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240410084201.1481930-1-schnelle@linux.ibm.com>
References: <20240410084201.1481930-1-schnelle@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kJajZkTe21yHutPNp20FlKR-zL2BDieU
X-Proofpoint-ORIG-GUID: kJajZkTe21yHutPNp20FlKR-zL2BDieU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_03,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 adultscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404100062

In a future patch HAS_IOPORT=n will disable inb()/outb() and friends at
compile time. We thus need to add HAS_IOPORT as dependency for those
drivers using them.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Note: This patch does not depend any not-yet-mainline HAS_IOPORT changes
and may be merged via subsystem specific trees at your earliest
convenience.

 drivers/watchdog/Kconfig | 58 +++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 28 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 6bee137cfbe0..1904896376b7 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -482,6 +482,7 @@ config 21285_WATCHDOG
 config 977_WATCHDOG
 	tristate "NetWinder WB83C977 watchdog"
 	depends on (FOOTBRIDGE && ARCH_NETWINDER) || (ARM && COMPILE_TEST)
+	depends on HAS_IOPORT
 	help
 	  Say Y here to include support for the WB977 watchdog included in
 	  NetWinder machines. Alternatively say M to compile the driver as
@@ -1075,7 +1076,7 @@ config ACQUIRE_WDT
 
 config ADVANTECH_WDT
 	tristate "Advantech SBC Watchdog Timer"
-	depends on X86 || COMPILE_TEST
+	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
 	help
 	  If you are configuring a Linux kernel for the Advantech single-board
 	  computer, say `Y' here to support its built-in watchdog timer
@@ -1084,7 +1085,7 @@ config ADVANTECH_WDT
 
 config ADVANTECH_EC_WDT
 	tristate "Advantech Embedded Controller Watchdog Timer"
-	depends on X86 || COMPILE_TEST
+	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
 	select ISA_BUS_API
 	select WATCHDOG_CORE
 	help
@@ -1117,7 +1118,7 @@ config ALIM7101_WDT
 
 config EBC_C384_WDT
 	tristate "WinSystems EBC-C384 Watchdog Timer"
-	depends on X86 || COMPILE_TEST
+	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
 	select ISA_BUS_API
 	select WATCHDOG_CORE
 	help
@@ -1127,7 +1128,7 @@ config EBC_C384_WDT
 
 config EXAR_WDT
 	tristate "Exar Watchdog Timer"
-	depends on X86 || COMPILE_TEST
+	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
 	select WATCHDOG_CORE
 	help
 	  Enables watchdog timer support for the watchdog timer present
@@ -1138,7 +1139,7 @@ config EXAR_WDT
 
 config F71808E_WDT
 	tristate "Fintek F718xx, F818xx Super I/O Watchdog"
-	depends on X86 || COMPILE_TEST
+	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
 	select WATCHDOG_CORE
 	help
 	  This is the driver for the hardware watchdog on the Fintek F71808E,
@@ -1150,7 +1151,7 @@ config F71808E_WDT
 
 config SP5100_TCO
 	tristate "AMD/ATI SP5100 TCO Timer/Watchdog"
-	depends on (X86 || COMPILE_TEST) && PCI
+	depends on (X86 || COMPILE_TEST) && PCI && HAS_IOPORT
 	select WATCHDOG_CORE
 	help
 	  Hardware watchdog driver for the AMD/ATI SP5100 chipset. The TCO
@@ -1189,7 +1190,7 @@ config SC520_WDT
 
 config SBC_FITPC2_WATCHDOG
 	tristate "Compulab SBC-FITPC2 watchdog"
-	depends on X86 || COMPILE_TEST
+	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
 	help
 	  This is the driver for the built-in watchdog timer on the fit-PC2,
 	  fit-PC2i, CM-iAM single-board computers made by Compulab.
@@ -1214,7 +1215,7 @@ config SBC_FITPC2_WATCHDOG
 
 config EUROTECH_WDT
 	tristate "Eurotech CPU-1220/1410 Watchdog Timer"
-	depends on X86 || COMPILE_TEST
+	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
 	help
 	  Enable support for the watchdog timer on the Eurotech CPU-1220 and
 	  CPU-1410 cards.  These are PC/104 SBCs. Spec sheets and product
@@ -1222,7 +1223,7 @@ config EUROTECH_WDT
 
 config IB700_WDT
 	tristate "IB700 SBC Watchdog Timer"
-	depends on X86 || COMPILE_TEST
+	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
 	help
 	  This is the driver for the hardware watchdog on the IB700 Single
 	  Board Computer produced by TMC Technology (www.tmc-uk.com). This
@@ -1239,7 +1240,7 @@ config IB700_WDT
 
 config IBMASR
 	tristate "IBM Automatic Server Restart"
-	depends on X86 || COMPILE_TEST
+	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
 	help
 	  This is the driver for the IBM Automatic Server Restart watchdog
 	  timer built-in into some eServer xSeries machines.
@@ -1249,7 +1250,7 @@ config IBMASR
 
 config WAFER_WDT
 	tristate "ICP Single Board Computer Watchdog Timer"
-	depends on X86 || COMPILE_TEST
+	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
 	help
 	  This is a driver for the hardware watchdog on the ICP Single
 	  Board Computer. This driver is working on (at least) the following
@@ -1271,7 +1272,7 @@ config I6300ESB_WDT
 
 config IE6XX_WDT
 	tristate "Intel Atom E6xx Watchdog"
-	depends on (X86 || COMPILE_TEST) && PCI
+	depends on (X86 || COMPILE_TEST) && PCI && HAS_IOPORT
 	select WATCHDOG_CORE
 	select MFD_CORE
 	select LPC_SCH
@@ -1301,6 +1302,7 @@ config ITCO_WDT
 	select WATCHDOG_CORE
 	depends on I2C || I2C=n
 	depends on MFD_INTEL_PMC_BXT || !MFD_INTEL_PMC_BXT
+	depends on HAS_IOPORT # for I2C_I801
 	select LPC_ICH if !EXPERT
 	select I2C_I801 if !EXPERT && I2C
 	help
@@ -1331,7 +1333,7 @@ config ITCO_VENDOR_SUPPORT
 
 config IT8712F_WDT
 	tristate "IT8712F (Smart Guardian) Watchdog Timer"
-	depends on X86 || COMPILE_TEST
+	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
 	help
 	  This is the driver for the built-in watchdog timer on the IT8712F
 	  Super I/0 chipset used on many motherboards.
@@ -1344,7 +1346,7 @@ config IT8712F_WDT
 
 config IT87_WDT
 	tristate "IT87 Watchdog Timer"
-	depends on X86 || COMPILE_TEST
+	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
 	select WATCHDOG_CORE
 	help
 	  This is the driver for the hardware watchdog on the ITE IT8607,
@@ -1392,7 +1394,7 @@ config KEMPLD_WDT
 
 config SC1200_WDT
 	tristate "National Semiconductor PC87307/PC97307 (ala SC1200) Watchdog"
-	depends on X86 || COMPILE_TEST
+	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
 	help
 	  This is a driver for National Semiconductor PC87307/PC97307 hardware
 	  watchdog cards as found on the SC1200. This watchdog is mainly used
@@ -1415,7 +1417,7 @@ config SCx200_WDT
 
 config PC87413_WDT
 	tristate "NS PC87413 watchdog"
-	depends on X86 || COMPILE_TEST
+	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
 	help
 	  This is the driver for the hardware watchdog on the PC87413 chipset
 	  This watchdog simply watches your kernel to make sure it doesn't
@@ -1429,7 +1431,7 @@ config PC87413_WDT
 
 config NV_TCO
 	tristate "nVidia TCO Timer/Watchdog"
-	depends on (X86 || COMPILE_TEST) && PCI
+	depends on (X86 || COMPILE_TEST) && PCI && HAS_IOPORT
 	help
 	  Hardware driver for the TCO timer built into the nVidia Hub family
 	  (such as the MCP51).  The TCO (Total Cost of Ownership) timer is a
@@ -1458,7 +1460,7 @@ config RDC321X_WDT
 
 config 60XX_WDT
 	tristate "SBC-60XX Watchdog Timer"
-	depends on X86 || COMPILE_TEST
+	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
 	help
 	  This driver can be used with the watchdog timer found on some
 	  single board computers, namely the 6010 PII based computer.
@@ -1498,7 +1500,7 @@ config SBC7240_WDT
 
 config CPU5_WDT
 	tristate "SMA CPU5 Watchdog"
-	depends on X86 || COMPILE_TEST
+	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
 	help
 	  TBD.
 	  To compile this driver as a module, choose M here: the
@@ -1506,7 +1508,7 @@ config CPU5_WDT
 
 config SMSC_SCH311X_WDT
 	tristate "SMSC SCH311X Watchdog Timer"
-	depends on X86 || COMPILE_TEST
+	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
 	help
 	  This is the driver for the hardware watchdog timer on the
 	  SMSC SCH3112, SCH3114 and SCH3116 Super IO chipset
@@ -1518,7 +1520,7 @@ config SMSC_SCH311X_WDT
 
 config SMSC37B787_WDT
 	tristate "Winbond SMsC37B787 Watchdog Timer"
-	depends on X86 || COMPILE_TEST
+	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
 	help
 	  This is the driver for the hardware watchdog component on the
 	  Winbond SMsC37B787 chipset as used on the NetRunner Mainboard
@@ -1564,7 +1566,7 @@ config VIA_WDT
 
 config W83627HF_WDT
 	tristate "Watchdog timer for W83627HF/W83627DHG and compatibles"
-	depends on X86 || COMPILE_TEST
+	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
 	select WATCHDOG_CORE
 	help
 	  This is the driver for the hardware watchdog on the following
@@ -1594,7 +1596,7 @@ config W83627HF_WDT
 
 config W83877F_WDT
 	tristate "W83877F (EMACS) Watchdog Timer"
-	depends on X86 || COMPILE_TEST
+	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
 	help
 	  This is the driver for the hardware watchdog on the W83877F chipset
 	  as used in EMACS PC-104 motherboards (and likely others).  This
@@ -1609,7 +1611,7 @@ config W83877F_WDT
 
 config W83977F_WDT
 	tristate "W83977F (PCM-5335) Watchdog Timer"
-	depends on X86 || COMPILE_TEST
+	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
 	help
 	  This is the driver for the hardware watchdog on the W83977F I/O chip
 	  as used in AAEON's PCM-5335 SBC (and likely others).  This
@@ -1622,7 +1624,7 @@ config W83977F_WDT
 
 config MACHZ_WDT
 	tristate "ZF MachZ Watchdog"
-	depends on X86 || COMPILE_TEST
+	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
 	help
 	  If you are using a ZF Micro MachZ processor, say Y here, otherwise
 	  N.  This is the driver for the watchdog timer built-in on that
@@ -1635,7 +1637,7 @@ config MACHZ_WDT
 
 config SBC_EPX_C3_WATCHDOG
 	tristate "Winsystems SBC EPX-C3 watchdog"
-	depends on X86 || COMPILE_TEST
+	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
 	help
 	  This is the driver for the built-in watchdog timer on the EPX-C3
 	  Single-board computer made by Winsystems, Inc.
@@ -2197,7 +2199,7 @@ comment "PCI-based Watchdog Cards"
 
 config PCIPCWATCHDOG
 	tristate "Berkshire Products PCI-PC Watchdog"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  This is the driver for the Berkshire Products PCI-PC Watchdog card.
 	  This card simply watches your kernel to make sure it doesn't freeze,
@@ -2212,7 +2214,7 @@ config PCIPCWATCHDOG
 
 config WDTPCI
 	tristate "PCI-WDT500/501 Watchdog timer"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  If you have a PCI-WDT500/501 watchdog board, say Y here, otherwise N.
 
-- 
2.40.1


