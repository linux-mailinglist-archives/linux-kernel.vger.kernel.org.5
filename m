Return-Path: <linux-kernel+bounces-52946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E8C849EBB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2296283E4A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239643D392;
	Mon,  5 Feb 2024 15:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZJkhX9jj"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F172C6A6;
	Mon,  5 Feb 2024 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707148137; cv=none; b=a7KqOifBLo0Jj1dU2StKhliJ1uEQX/lf1sQbtCifRUMD8QVd/faIYMNh2pLaWVkIkUY2/uRMUAtgIIdq6ycCSIBRwtXLP7LzlsRWk5Jj3pl4RhB+Wi/bVXIPUfXP10TPnmWAA5Hqaakhv2aixck634t8kAD4gwGlMdUuJm6nZow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707148137; c=relaxed/simple;
	bh=WQKDA6ycF9zyAiJKm/9j1u2voHFq4rPW4zGv0elkG0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HHuabQqnKSdjqlDepThpCegGB4pUzzmBc3dv54Xgxvweqr3SL5mxE8LUdOIGdBA7FpYVtNOEPFfahjRMeQiAYTnq8ftWnY3RvQVy7+kNtRdJDd10RlDDGBHE/if7yFPZqIKo5+3bW3zaNMTRSAxqPjmAJpIiFYo8V2xYTVZWcNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZJkhX9jj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415FTKAR029375;
	Mon, 5 Feb 2024 15:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=byL1VZic0PAkagwNpfsFqhW47Ni0iSoIxFYu0LryJo4=;
 b=ZJkhX9jjobfE/sT4cTQNKdqmw+lrIMGT6R3z3d9xu5KsEPKW/g5U4aUUYMp7uL/Gfdbn
 J6m71xm44FAYqRVkxtA4gHFxa/RDzaNwGrcvz8dmup4QA+ZLLNd05LqdhQQ2SOl9gJZE
 STeujizWFLnf2+tkaXV0KIFUsVQVNuwEjVWPHvdR++XaPrFmr3iOhZNWlCP7nMF2S5g5
 mAgo43lW/1Un5t+5HGNdux/6tAC+y1840sOGaEMuxGSnN09iFrlXvBO9Sws1QWcCB0ek
 lWX8e7hNrU5OgxoO+pDyIxW+BSMsjOK7LUwOqadDV+b2AqB3xKfc6Ipe3cK0dmXkgerN MQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w32bx8pf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 15:48:50 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 415FdIsm007223;
	Mon, 5 Feb 2024 15:48:50 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w32bx8pet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 15:48:49 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 415EpLMT008519;
	Mon, 5 Feb 2024 15:48:49 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w221js0k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 15:48:49 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 415Fmj6f19661164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Feb 2024 15:48:46 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC41320043;
	Mon,  5 Feb 2024 15:48:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 969962004D;
	Mon,  5 Feb 2024 15:48:45 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Feb 2024 15:48:45 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Kees Cook <keescook@chromium.org>, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 2/2] s390/fpu: make use of __uninitialized macro
Date: Mon,  5 Feb 2024 16:48:44 +0100
Message-Id: <20240205154844.3757121-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240205154844.3757121-1-hca@linux.ibm.com>
References: <20240205154844.3757121-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sTRo0zi2J2zYRPUPIc8TYQ-XRqG4f-Gh
X-Proofpoint-ORIG-GUID: jgcjCb9p1o1Bo_dS6_KzVs51MqdBDXpP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402050119

Code sections in s390 specific kernel code which use floating point or
vector registers all come with a 520 byte stack variable to save already in
use registers, if required.

With INIT_STACK_ALL_PATTERN or INIT_STACK_ALL_ZERO enabled this variable
will always be initialized on function entry in addition to saving register
contents, which contradicts the intend (performance improvement) of such
code sections.

Therefore provide a DECLARE_KERNEL_FPU_ONSTACK() macro which provides
struct kernel_fpu variables with an __uninitialized attribute, and convert
all existing code to use this.

This way only this specific type of stack variable will not be initialized,
regardless of config options.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/crypto/chacha-glue.c    | 2 +-
 arch/s390/crypto/crc32-vx.c       | 2 +-
 arch/s390/include/asm/fpu/types.h | 3 +++
 arch/s390/kernel/sysinfo.c        | 2 +-
 lib/raid6/s390vx.uc               | 4 ++--
 5 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/s390/crypto/chacha-glue.c b/arch/s390/crypto/chacha-glue.c
index ed9959e6f714..a823132fc563 100644
--- a/arch/s390/crypto/chacha-glue.c
+++ b/arch/s390/crypto/chacha-glue.c
@@ -22,7 +22,7 @@ static void chacha20_crypt_s390(u32 *state, u8 *dst, const u8 *src,
 				unsigned int nbytes, const u32 *key,
 				u32 *counter)
 {
-	struct kernel_fpu vxstate;
+	DECLARE_KERNEL_FPU_ONSTACK(vxstate);
 
 	kernel_fpu_begin(&vxstate, KERNEL_VXR);
 	chacha20_vx(dst, src, nbytes, key, counter);
diff --git a/arch/s390/crypto/crc32-vx.c b/arch/s390/crypto/crc32-vx.c
index 017143e9cef7..6ae3e3ff5b0a 100644
--- a/arch/s390/crypto/crc32-vx.c
+++ b/arch/s390/crypto/crc32-vx.c
@@ -49,8 +49,8 @@ u32 crc32c_le_vgfm_16(u32 crc, unsigned char const *buf, size_t size);
 	static u32 __pure ___fname(u32 crc,				    \
 				unsigned char const *data, size_t datalen)  \
 	{								    \
-		struct kernel_fpu vxstate;				    \
 		unsigned long prealign, aligned, remaining;		    \
+		DECLARE_KERNEL_FPU_ONSTACK(vxstate);			    \
 									    \
 		if (datalen < VX_MIN_LEN + VX_ALIGN_MASK)		    \
 			return ___crc32_sw(crc, data, datalen);		    \
diff --git a/arch/s390/include/asm/fpu/types.h b/arch/s390/include/asm/fpu/types.h
index d889e9436865..b1afa13c07b7 100644
--- a/arch/s390/include/asm/fpu/types.h
+++ b/arch/s390/include/asm/fpu/types.h
@@ -35,4 +35,7 @@ struct kernel_fpu {
 	};
 };
 
+#define DECLARE_KERNEL_FPU_ONSTACK(name)	\
+	struct kernel_fpu name __uninitialized
+
 #endif /* _ASM_S390_FPU_TYPES_H */
diff --git a/arch/s390/kernel/sysinfo.c b/arch/s390/kernel/sysinfo.c
index f6f8f498c9be..b439f17516eb 100644
--- a/arch/s390/kernel/sysinfo.c
+++ b/arch/s390/kernel/sysinfo.c
@@ -426,9 +426,9 @@ subsys_initcall(create_proc_service_level);
  */
 void s390_adjust_jiffies(void)
 {
+	DECLARE_KERNEL_FPU_ONSTACK(fpu);
 	struct sysinfo_1_2_2 *info;
 	unsigned long capability;
-	struct kernel_fpu fpu;
 
 	info = (void *) get_zeroed_page(GFP_KERNEL);
 	if (!info)
diff --git a/lib/raid6/s390vx.uc b/lib/raid6/s390vx.uc
index cd0b9e95f499..7b0b355e1a26 100644
--- a/lib/raid6/s390vx.uc
+++ b/lib/raid6/s390vx.uc
@@ -81,7 +81,7 @@ static inline void COPY_VEC(int x, int y)
 
 static void raid6_s390vx$#_gen_syndrome(int disks, size_t bytes, void **ptrs)
 {
-	struct kernel_fpu vxstate;
+	DECLARE_KERNEL_FPU_ONSTACK(vxstate);
 	u8 **dptr, *p, *q;
 	int d, z, z0;
 
@@ -114,7 +114,7 @@ static void raid6_s390vx$#_gen_syndrome(int disks, size_t bytes, void **ptrs)
 static void raid6_s390vx$#_xor_syndrome(int disks, int start, int stop,
 					size_t bytes, void **ptrs)
 {
-	struct kernel_fpu vxstate;
+	DECLARE_KERNEL_FPU_ONSTACK(vxstate);
 	u8 **dptr, *p, *q;
 	int d, z, z0;
 
-- 
2.40.1


