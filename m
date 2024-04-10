Return-Path: <linux-kernel+bounces-138745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 260BB89F9D5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D17BF282B9D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D4E15F3E6;
	Wed, 10 Apr 2024 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rSEmi6Bm"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F7615ADB0;
	Wed, 10 Apr 2024 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712759023; cv=none; b=j95Dboyy9iDYf3CfnjZDq+Op1Lzdsm2PFKgGNM6ZI6Pdystv9e/AkPopuYphfKGtrghCYPB/521r0bzh0XQmMD1mBWozeUu+sr+loAhvkXyWXZVuK9U1v/z/4Z5Jia75uZimJD5DySweTPx4qTbmEZtwwSthuyov3PNohbhLmAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712759023; c=relaxed/simple;
	bh=uPqiNKrSppmNdT022fwWAZXBDuyotNMkKra7ejezYnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P8+nCOBw9oHw5xrCNOPtm6l4MZpE7pBaMmaad9Af+cNG3LyNS9XI4MHgVAX4nNfRfZ4u0vLBK7ai7jM107DjMV6CnpQIooHTF/ZnDhAqXzEt01SLGvcFu/OuNhv0L0hmLPBjoav4CtGgbZzHaQSOWzVNpszovUeioUthWoRrGi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rSEmi6Bm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43AE2Uul016173;
	Wed, 10 Apr 2024 14:23:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VIDq6g8t2PsgBOOBw2sCtSc29sgr6iz62n0v5yKyYj8=;
 b=rSEmi6BmdljzMyYw+d0x3XQm48Q/e2Tn+eUP3WxHXloXGjAeM/+BePPzWjMYD8u/elYc
 ORRk4iomAUyc+chm5wccbaBHHquTGLkAl6/xnLcJz71Yo/6m5p9aYspvUlbMOtLJ3whm
 zbCHe/tzWq9zanM3afU+2y4KSOHuPOrNjtpWdFbijlEI0JuuXZw1rEFnHCtHd0wzh4Pl
 XRIWirtzXaCiQvb34hNlR03nQ2wTevdJkMaHGppJfVMhGbEsf52PuuqsW5AlEPvX34HS
 EvmGejJGDgjAh0Y0MJmSZj7OhsCKvco5I1aeKidGp082WYM3VEA0QT6yOwlz4Y+vEKzH 3Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xdv6001qq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 14:23:36 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43AEN6Uk019780;
	Wed, 10 Apr 2024 14:23:36 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xdv6001qk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 14:23:36 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43ADNLx4013550;
	Wed, 10 Apr 2024 14:23:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xbgqtnepk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 14:23:35 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43AENTdu47645116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 14:23:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0C2120040;
	Wed, 10 Apr 2024 14:23:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D2EE2004E;
	Wed, 10 Apr 2024 14:23:29 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Apr 2024 14:23:29 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Arnd Bergmann <arnd@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH 1/1] video: Handle HAS_IOPORT dependencies
Date: Wed, 10 Apr 2024 16:23:29 +0200
Message-Id: <20240410142329.3567824-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240410142329.3567824-1-schnelle@linux.ibm.com>
References: <20240410142329.3567824-1-schnelle@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: C_Y5CG_tV7DK6EJeucQwwccLPVQr8k0k
X-Proofpoint-ORIG-GUID: nK69QiT2I-XTpMn9zoeQpgEK4sWRpCA3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404100104

In a future patch HAS_IOPORT=n will disable inb()/outb() and friends at
compile time. We thus need to #ifdef functions and their callsites which
unconditionally use these I/O accessors. In the include/video/vga.h
these are conveniently all those functions with the vga_io_* prefix.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Note: This patch does not depend any not-yet-mainline HAS_IOPORT changes
and may be merged via subsystem specific trees at your earliest
convenience.

 include/video/vga.h | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/include/video/vga.h b/include/video/vga.h
index 947c0abd04ef..ed89295941c4 100644
--- a/include/video/vga.h
+++ b/include/video/vga.h
@@ -201,6 +201,7 @@ extern int restore_vga(struct vgastate *state);
  * generic VGA port read/write
  */
 
+#ifdef CONFIG_HAS_IOPORT
 static inline unsigned char vga_io_r (unsigned short port)
 {
 	return inb_p(port);
@@ -210,12 +211,12 @@ static inline void vga_io_w (unsigned short port, unsigned char val)
 {
 	outb_p(val, port);
 }
-
 static inline void vga_io_w_fast (unsigned short port, unsigned char reg,
 				  unsigned char val)
 {
 	outw(VGA_OUT16VAL (val, reg), port);
 }
+#endif /* CONFIG_HAS_IOPORT */
 
 static inline unsigned char vga_mm_r (void __iomem *regbase, unsigned short port)
 {
@@ -235,28 +236,34 @@ static inline void vga_mm_w_fast (void __iomem *regbase, unsigned short port,
 
 static inline unsigned char vga_r (void __iomem *regbase, unsigned short port)
 {
-	if (regbase)
-		return vga_mm_r (regbase, port);
-	else
+#ifdef CONFIG_HAS_IOPORT
+	if (!regbase)
 		return vga_io_r (port);
+	else
+#endif /* CONFIG_HAS_IOPORT */
+		return vga_mm_r (regbase, port);
 }
 
 static inline void vga_w (void __iomem *regbase, unsigned short port, unsigned char val)
 {
-	if (regbase)
-		vga_mm_w (regbase, port, val);
-	else
+#ifdef CONFIG_HAS_IOPORT
+	if (!regbase)
 		vga_io_w (port, val);
+	else
+#endif /* CONFIG_HAS_IOPORT */
+		vga_mm_w (regbase, port, val);
 }
 
 
 static inline void vga_w_fast (void __iomem *regbase, unsigned short port,
 			       unsigned char reg, unsigned char val)
 {
-	if (regbase)
-		vga_mm_w_fast (regbase, port, reg, val);
-	else
+#ifdef CONFIG_HAS_IOPORT
+	if (!regbase)
 		vga_io_w_fast (port, reg, val);
+	else
+#endif /* CONFIG_HAS_IOPORT */
+		vga_mm_w_fast (regbase, port, reg, val);
 }
 
 
@@ -280,6 +287,7 @@ static inline void vga_wcrt (void __iomem *regbase, unsigned char reg, unsigned
 #endif /* VGA_OUTW_WRITE */
 }
 
+#ifdef CONFIG_HAS_IOPORT
 static inline unsigned char vga_io_rcrt (unsigned char reg)
 {
         vga_io_w (VGA_CRT_IC, reg);
@@ -295,6 +303,7 @@ static inline void vga_io_wcrt (unsigned char reg, unsigned char val)
         vga_io_w (VGA_CRT_DC, val);
 #endif /* VGA_OUTW_WRITE */
 }
+#endif /* CONFIG_HAS_IOPORT */
 
 static inline unsigned char vga_mm_rcrt (void __iomem *regbase, unsigned char reg)
 {
@@ -333,6 +342,7 @@ static inline void vga_wseq (void __iomem *regbase, unsigned char reg, unsigned
 #endif /* VGA_OUTW_WRITE */
 }
 
+#ifdef CONFIG_HAS_IOPORT
 static inline unsigned char vga_io_rseq (unsigned char reg)
 {
         vga_io_w (VGA_SEQ_I, reg);
@@ -348,6 +358,7 @@ static inline void vga_io_wseq (unsigned char reg, unsigned char val)
         vga_io_w (VGA_SEQ_D, val);
 #endif /* VGA_OUTW_WRITE */
 }
+#endif /* CONFIG_HAS_IOPORT */
 
 static inline unsigned char vga_mm_rseq (void __iomem *regbase, unsigned char reg)
 {
@@ -385,6 +396,7 @@ static inline void vga_wgfx (void __iomem *regbase, unsigned char reg, unsigned
 #endif /* VGA_OUTW_WRITE */
 }
 
+#ifdef CONFIG_HAS_IOPORT
 static inline unsigned char vga_io_rgfx (unsigned char reg)
 {
         vga_io_w (VGA_GFX_I, reg);
@@ -400,6 +412,7 @@ static inline void vga_io_wgfx (unsigned char reg, unsigned char val)
         vga_io_w (VGA_GFX_D, val);
 #endif /* VGA_OUTW_WRITE */
 }
+#endif /* CONFIG_HAS_IOPORT */
 
 static inline unsigned char vga_mm_rgfx (void __iomem *regbase, unsigned char reg)
 {
@@ -434,6 +447,7 @@ static inline void vga_wattr (void __iomem *regbase, unsigned char reg, unsigned
         vga_w (regbase, VGA_ATT_W, val);
 }
 
+#ifdef CONFIG_HAS_IOPORT
 static inline unsigned char vga_io_rattr (unsigned char reg)
 {
         vga_io_w (VGA_ATT_IW, reg);
@@ -445,6 +459,7 @@ static inline void vga_io_wattr (unsigned char reg, unsigned char val)
         vga_io_w (VGA_ATT_IW, reg);
         vga_io_w (VGA_ATT_W, val);
 }
+#endif /* CONFIG_HAS_IOPORT */
 
 static inline unsigned char vga_mm_rattr (void __iomem *regbase, unsigned char reg)
 {
-- 
2.40.1


