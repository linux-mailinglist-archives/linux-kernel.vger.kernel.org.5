Return-Path: <linux-kernel+bounces-138373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA7189F041
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03281F23B66
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FA515ADB4;
	Wed, 10 Apr 2024 10:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s6ZhzPwM"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A6F15A491;
	Wed, 10 Apr 2024 10:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712746601; cv=none; b=Xw7KZlmi450PumnbVWjwds06wXL+3LrGUS2eQ6fxM5dGO/iwiaCvGvcpID4wngNYPk+5O7qwI+HksFtYPmLHaTzBxGyo1UnQAy8EHNtzuL+EgCFlx4jbey7QhdZXgDroG3o81YheYv6chbc9vj3qiQRPBdeW2g1VAYqkrEq9SG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712746601; c=relaxed/simple;
	bh=aMubXWwJQtUUOvZ4Fovzz7ZsADEzMON7kUCfnjy54vE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h2OXJtc8XybIrDW7k3LseMJDjyMhCcZ2aZ0kuy6cKKehOKpM/puazqZxlJcwbMsuEfXVTgpfVcoLw8YE1ZV9fSONP+QoXcunqL/ak2y5CX4KDTA8J6U8YO4wWvs0CWsgpDD/iSzCo/kemaElljRQVKI6bWSewvREXNQQU8IByps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s6ZhzPwM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43AAqsQ0023054;
	Wed, 10 Apr 2024 10:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=cUqfhbJx+4Wg3bxA8zKrjHOA4D9BAigt9Hhl1lEmrQo=;
 b=s6ZhzPwMMajLOcpcH9Vwt7AHRbV7eosB9/J/9PDoE6YzATVC/d8CVBtufufAMjCxp5m0
 oFxstByVx9d9UwbNoMulGRtQaUUPJu3b8pEjhgwXXC+BaL2oSd2qBBg8aFR6zX2XMvET
 kdm6smvecnW/wVGQFQorPzPjfKBCQ+rnPClwpPWr09D+IYPYvkeOFmIjxEuyLLK1YAKr
 9LfoSNoizyNbasmAfXGC+JrMJQQ87P2opvEiR2/GAi+9xNTVNq7NYGaWa1xWTM4TvHVe
 eGxLmXHBeRLnjOKxS/5BYzP/HMwuIycD6PCq9YRBYJksRaa5xG5Zd3SdYUcZX5KEcWj4 CQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xdsd4g08m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 10:56:33 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43AAuXWq027473;
	Wed, 10 Apr 2024 10:56:33 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xdsd4g08g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 10:56:33 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43A8YZlE021511;
	Wed, 10 Apr 2024 10:56:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xbjxkv0jj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 10:56:32 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43AAuRtB46858726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 10:56:29 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26B4A20040;
	Wed, 10 Apr 2024 10:56:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02ECF2004B;
	Wed, 10 Apr 2024 10:56:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Apr 2024 10:56:26 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Arnd Bergmann <arnd@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v2 1/1] fbdev: add HAS_IOPORT dependencies
Date: Wed, 10 Apr 2024 12:56:26 +0200
Message-Id: <20240410105626.2743168-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240410105626.2743168-1-schnelle@linux.ibm.com>
References: <20240410105626.2743168-1-schnelle@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2NC-cVop20iqCSKtOmd0cgs6vR6rfu3R
X-Proofpoint-ORIG-GUID: CkuigeIMlVP2S1dywEOumcAavocQLm1M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404100079

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

v1 -> v2:
- Add dependency for FB_ARC

 drivers/video/fbdev/Kconfig | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 197b6d5268e9..76bbfd3767da 100644
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
@@ -245,7 +245,7 @@ config FB_FM2
 
 config FB_ARC
 	tristate "Arc Monochrome LCD board support"
-	depends on FB && (X86 || COMPILE_TEST)
+	depends on FB && HAS_IOPORT && (X86 || COMPILE_TEST)
 	select FB_SYSMEM_HELPERS_DEFERRED
 	help
 	  This enables support for the Arc Monochrome LCD board. The board
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


