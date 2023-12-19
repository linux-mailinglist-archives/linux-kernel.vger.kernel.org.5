Return-Path: <linux-kernel+bounces-5465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3849A818AEB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5F5D1F22354
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0808A32C9B;
	Tue, 19 Dec 2023 15:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XAHWTTH3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2D020DC7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ9wuhs017135;
	Tue, 19 Dec 2023 15:12:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=J8ZeLl+PGi8hKGYRJZMnlviIymGZLOM1z26ehHHKW20=;
 b=XAHWTTH3CS1TzVHi6QGwwojDjChn/AhPCQNC9oTwebi2DQkaD41REK2mMm3wQgKMutua
 DQQ3Tajj13wxDkTLugTiyIozgO7xGgn8p2WdOBFJLyrix8YMH3Zd+yBIkBO4aeZJNSFV
 BEYcTUDXGzpyYEIlL0PtTxbqAIrHjWAi/X5vyMS82O5OMjbnmKEKUpzu2Fv/sKHT3P+q
 Kd0lIYQCqMsEyfLzQ0IgEd7IdEtHzcq7fNgG4AVopQZn+NTEV2jHPBs7sIbO2CJOQQma
 1A9/I70RpyWkijGvZfy9Vji3y0WRj3UdnydRHDBMMhClcnVjiea7PqIVtgyG3oFpQICL QQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v12p465pb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 15:12:16 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJEAb9N029105;
	Tue, 19 Dec 2023 15:12:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b6w7c3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 15:12:15 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BJF7SdP008899;
	Tue, 19 Dec 2023 15:12:14 GMT
Received: from localhost.localdomain (dhcp-10-175-58-169.vpn.oracle.com [10.175.58.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3v12b6w71u-3;
	Tue, 19 Dec 2023 15:12:14 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Brian Gerst <brgerst@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH 2/5] x86: replace magic numbers in GDT descriptors, part 1
Date: Tue, 19 Dec 2023 16:11:57 +0100
Message-Id: <20231219151200.2878271-3-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219151200.2878271-1-vegard.nossum@oracle.com>
References: <20231219151200.2878271-1-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-19_08,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312190113
X-Proofpoint-GUID: iC0-4Gw37qFi30fZuKLHZL7xhP7oriIM
X-Proofpoint-ORIG-GUID: iC0-4Gw37qFi30fZuKLHZL7xhP7oriIM

We'd like to replace all the magic numbers in various GDT descriptors
with new, semantically meaningful, symbolic values.

In order to be able to verify that the change doesn't cause any actual
changes to the compiled binary code, I've split the change into two
patches:

Part 1 (this commit): everything _but_ actually replacing the numbers
Part 2 (the following commit): _only_ replacing the numbers

These two commits may be squashed together when merged.

The reason we need this split for verification is that including new
headers causes some spurious changes to the object files, mostly line
number changes in the debug info but occasionally other subtle codegen
changes.

Link: https://lore.kernel.org/all/CAHk-=wib5XLebuEra7y2YH96wxdk=8vJnA8XoVq0FExpzVvN=Q@mail.gmail.com/
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 arch/x86/boot/pm.c               | 1 +
 arch/x86/include/asm/desc_defs.h | 2 ++
 arch/x86/kernel/cpu/common.c     | 8 --------
 arch/x86/platform/pvh/head.S     | 1 +
 arch/x86/realmode/rm/reboot.S    | 1 +
 5 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/x86/boot/pm.c b/arch/x86/boot/pm.c
index 40031a614712..0361b5307bd8 100644
--- a/arch/x86/boot/pm.c
+++ b/arch/x86/boot/pm.c
@@ -11,6 +11,7 @@
  */
 
 #include "boot.h"
+#include <asm/desc_defs.h>
 #include <asm/segment.h>
 
 /*
diff --git a/arch/x86/include/asm/desc_defs.h b/arch/x86/include/asm/desc_defs.h
index b33f5bb240eb..014878e584fe 100644
--- a/arch/x86/include/asm/desc_defs.h
+++ b/arch/x86/include/asm/desc_defs.h
@@ -144,6 +144,7 @@ struct gate_struct {
 
 typedef struct gate_struct gate_desc;
 
+#ifndef _SETUP
 static inline unsigned long gate_offset(const gate_desc *g)
 {
 #ifdef CONFIG_X86_64
@@ -158,6 +159,7 @@ static inline unsigned long gate_segment(const gate_desc *g)
 {
 	return g->segment;
 }
+#endif
 
 struct desc_ptr {
 	unsigned short size;
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index b14fc8c1c953..ceb6e4b6d57e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -204,25 +204,17 @@ DEFINE_PER_CPU_PAGE_ALIGNED(struct gdt_page, gdt_page) = { .gdt = {
 	 * They code segments and data segments have fixed 64k limits,
 	 * the transfer segment sizes are set at run time.
 	 */
-	/* 32-bit code */
 	[GDT_ENTRY_PNPBIOS_CS32]	= GDT_ENTRY_INIT(0x409a, 0, 0xffff),
-	/* 16-bit code */
 	[GDT_ENTRY_PNPBIOS_CS16]	= GDT_ENTRY_INIT(0x009a, 0, 0xffff),
-	/* 16-bit data */
 	[GDT_ENTRY_PNPBIOS_DS]		= GDT_ENTRY_INIT(0x0092, 0, 0xffff),
-	/* 16-bit data */
 	[GDT_ENTRY_PNPBIOS_TS1]		= GDT_ENTRY_INIT(0x0092, 0, 0),
-	/* 16-bit data */
 	[GDT_ENTRY_PNPBIOS_TS2]		= GDT_ENTRY_INIT(0x0092, 0, 0),
 	/*
 	 * The APM segments have byte granularity and their bases
 	 * are set at run time.  All have 64k limits.
 	 */
-	/* 32-bit code */
 	[GDT_ENTRY_APMBIOS_BASE]	= GDT_ENTRY_INIT(0x409a, 0, 0xffff),
-	/* 16-bit code */
 	[GDT_ENTRY_APMBIOS_BASE+1]	= GDT_ENTRY_INIT(0x009a, 0, 0xffff),
-	/* data */
 	[GDT_ENTRY_APMBIOS_BASE+2]	= GDT_ENTRY_INIT(0x4092, 0, 0xffff),
 
 	[GDT_ENTRY_ESPFIX_SS]		= GDT_ENTRY_INIT(0xc092, 0, 0xfffff),
diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index c4365a05ab83..9bcafdded2a1 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -11,6 +11,7 @@
 #include <linux/elfnote.h>
 #include <linux/init.h>
 #include <linux/linkage.h>
+#include <asm/desc_defs.h>
 #include <asm/segment.h>
 #include <asm/asm.h>
 #include <asm/boot.h>
diff --git a/arch/x86/realmode/rm/reboot.S b/arch/x86/realmode/rm/reboot.S
index f10515b10e0a..447641820a8d 100644
--- a/arch/x86/realmode/rm/reboot.S
+++ b/arch/x86/realmode/rm/reboot.S
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/linkage.h>
+#include <asm/desc_defs.h>
 #include <asm/segment.h>
 #include <asm/page_types.h>
 #include <asm/processor-flags.h>
-- 
2.34.1


