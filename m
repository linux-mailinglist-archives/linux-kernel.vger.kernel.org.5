Return-Path: <linux-kernel+bounces-138165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3ABD89ED91
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A63F284D5B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F5813D88D;
	Wed, 10 Apr 2024 08:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B8sniBbq"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71A213D604;
	Wed, 10 Apr 2024 08:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712737683; cv=none; b=rUx+LjWSUTheAG6wGJIOVPYEFjewmbYgjfOyLUoT9HqFYBxi2vIxHGwsmIfHpUyaV6QhGoOhQ/Rv8Ni97xP9ZpTxj1alk2QXuEJjhKewkjRYSltNIO7CYZGJQIIhuHZx8vX2P393jrGENseMzVx1gTeM+Axu65vsd/A8Wlf9a7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712737683; c=relaxed/simple;
	bh=omFh4qzhdwZU1cLkGreIXKx80Zq6k4zI3cLYlOyDJyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oB77MiM8xlKJAjQr2KbfxVGSbRN29o5BDQAI7ATticGTiQZoB4G/W+SX/hjWKCb6wRhSPyKFBgeOs6gasQqzBjg2codBGVgewkOK2PUcrXmarQouIgcz1Ym3O2sdKLMiTnmh1pf8YKAo1WxseVjgGuojzGhibEBBJobmnZFrBYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B8sniBbq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43A8O3C6021085;
	Wed, 10 Apr 2024 08:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=xaNbWlG6qYeVldFlDRoOSMjexdPkCJ0YQ3Sx/adD8c0=;
 b=B8sniBbqkqbm49IvZksx5Q1rJ5QXMdqvwy+TKJzak3kScFsucWdzyQojVAnxPqp51gJh
 AWRlfcjR6gT+UyfJCRh7kbPJ1kYwEOi07xpihvParT9FQ9vYX108i8dKPSH2aVSMP/Q8
 rS6Ifa2JT0Ab+lLhoYuiagw1DmoqU0T1Erzf/hxIFp0jo7HUawVzyU+HZnoxpRgAPC2v
 nE4NHlUmkya9aLDxwe2uDjQkBVUxSaEBP+HnYIPmiymGpnXTLsfrtmKCGhlInZorvsmw
 bWQomE5o3fWGwsRESeTD0YOvelRPjvTMK6Lf+JBCZ/ZrLAy3pNymkbzpVyZnk6EzukNF jg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xdq7080dh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 08:27:50 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43A8Ro0M025467;
	Wed, 10 Apr 2024 08:27:50 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xdq7080dd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 08:27:49 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43A6aVCc013539;
	Wed, 10 Apr 2024 08:27:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xbgqtkusk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 08:27:49 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43A8RhI848759288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 08:27:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A59C20040;
	Wed, 10 Apr 2024 08:27:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BB642004D;
	Wed, 10 Apr 2024 08:27:43 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Apr 2024 08:27:43 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Arnd Bergmann <arnd@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH 1/1] fbdev: add HAS_IOPORT dependencies
Date: Wed, 10 Apr 2024 10:27:43 +0200
Message-Id: <20240410082743.1425538-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240410082743.1425538-1-schnelle@linux.ibm.com>
References: <20240410082743.1425538-1-schnelle@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZUx_VP4aR74h3K1_zKbhlHzqFdg61SFt
X-Proofpoint-ORIG-GUID: hjhDXytftozQnBMFGWRGQxSskfo3zRha
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_03,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404100061

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

 drivers/video/fbdev/Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 197b6d5268e9..f90b191dc68b 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -157,7 +157,7 @@ config FB_IMX
 
 config FB_CYBER2000
 	tristate "CyberPro 2000/2010/5000 support"
-	depends on FB && PCI && (BROKEN || !SPARC64)
+	depends on FB && PCI && HAS_IOPORT && (BROKEN || !SPARC64)
 	select FB_IOMEM_HELPERS
 	help
 	  This enables support for the Integraphics CyberPro 20x0 and 5000
@@ -1046,7 +1046,7 @@ config FB_ATY_BACKLIGHT
 
 config FB_S3
 	tristate "S3 Trio/Virge support"
-	depends on FB && PCI
+	depends on FB && PCI && HAS_IOPORT
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -1107,7 +1107,7 @@ config FB_SAVAGE_ACCEL
 
 config FB_SIS
 	tristate "SiS/XGI display support"
-	depends on FB && PCI
+	depends on FB && PCI && HAS_IOPORT
 	select BOOT_VESA_SUPPORT if FB_SIS = y
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
@@ -1138,7 +1138,7 @@ config FB_SIS_315
 
 config FB_VIA
 	tristate "VIA UniChrome (Pro) and Chrome9 display support"
-	depends on FB && PCI && GPIOLIB && I2C && (X86 || COMPILE_TEST)
+	depends on FB && PCI && GPIOLIB && I2C && HAS_IOPORT && (X86 || COMPILE_TEST)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -1177,7 +1177,7 @@ endif
 
 config FB_NEOMAGIC
 	tristate "NeoMagic display support"
-	depends on FB && PCI
+	depends on FB && PCI && HAS_IOPORT
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -1204,7 +1204,7 @@ config FB_KYRO
 
 config FB_3DFX
 	tristate "3Dfx Banshee/Voodoo3/Voodoo5 display support"
-	depends on FB && PCI
+	depends on FB && PCI && HAS_IOPORT
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -1252,7 +1252,7 @@ config FB_VOODOO1
 
 config FB_VT8623
 	tristate "VIA VT8623 support"
-	depends on FB && PCI
+	depends on FB && PCI && HAS_IOPORT
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -1267,7 +1267,7 @@ config FB_VT8623
 
 config FB_TRIDENT
 	tristate "Trident/CyberXXX/CyberBlade support"
-	depends on FB && PCI
+	depends on FB && PCI && HAS_IOPORT
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -1290,7 +1290,7 @@ config FB_TRIDENT
 
 config FB_ARK
 	tristate "ARK 2000PV support"
-	depends on FB && PCI
+	depends on FB && PCI && HAS_IOPORT
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -1814,7 +1814,7 @@ config FB_SSD1307
 
 config FB_SM712
 	tristate "Silicon Motion SM712 framebuffer support"
-	depends on FB && PCI
+	depends on FB && PCI && HAS_IOPORT
 	select FB_IOMEM_HELPERS
 	help
 	  Frame buffer driver for the Silicon Motion SM710, SM712, SM721
-- 
2.40.1


