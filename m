Return-Path: <linux-kernel+bounces-5466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82345818AED
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8883C1C243BF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9482135298;
	Tue, 19 Dec 2023 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j0HOYbgd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831E535267
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ9xCQo011288;
	Tue, 19 Dec 2023 15:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=FT/BEV8zbVagHwfhVNRfvLlTYXxMfkn+TE+9B5w0U4U=;
 b=j0HOYbgddMBXqkL5cyL52xkypii8uOp/4x56ekP0mMz/WCrL6gzL7duA2OAWTFOg/Wr4
 JmyWk+ayKDTvPQbDjq0IXI/lT961XYQ5IYHbuzBkd3AyTnFwbQOlaMdQ5tKAqHmannC/
 I8q+6obUsN+kdoBEk4FCWQqq5Om2lbpL3gAjdslrfqn66ufUHe7FhtAN0GJZY56KafDo
 biiJOFWjyfjQOC0jDZWqq0/7/IN6QRG9urLlNikD8iuv6C151x5iMtxaIcJFlGAg7frl
 ftguNPa0HqOeE+32X6T3xFxhmt9Dt9cwf+O0+UasInbdZmHAHGyYxsK/K5pCFXyKsrSb xg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v12g2e4ny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 15:12:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJDuAKS028981;
	Tue, 19 Dec 2023 15:12:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b6w7jr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 15:12:22 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BJF7SdT008899;
	Tue, 19 Dec 2023 15:12:22 GMT
Received: from localhost.localdomain (dhcp-10-175-58-169.vpn.oracle.com [10.175.58.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3v12b6w71u-5;
	Tue, 19 Dec 2023 15:12:22 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Brian Gerst <brgerst@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH 4/5] x86: always set A (accessed) flag in GDT descriptors
Date: Tue, 19 Dec 2023 16:11:59 +0100
Message-Id: <20231219151200.2878271-5-vegard.nossum@oracle.com>
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
X-Proofpoint-GUID: HpLnaHOOCUXrdT9GMDCRfspyGwpFQhaY
X-Proofpoint-ORIG-GUID: HpLnaHOOCUXrdT9GMDCRfspyGwpFQhaY

We have no known use for having the CPU track whether GDT descriptors
have been accessed or not.

Simplify the code by adding the flag to the common flags and removing
it everywhere else.

Link: https://lore.kernel.org/all/CAHk-=wib5XLebuEra7y2YH96wxdk=8vJnA8XoVq0FExpzVvN=Q@mail.gmail.com/
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 arch/x86/boot/pm.c                      |  4 ++--
 arch/x86/include/asm/desc_defs.h        |  4 ++--
 arch/x86/kernel/cpu/common.c            | 12 ++++++------
 arch/x86/kernel/head64.c                |  6 +++---
 arch/x86/realmode/rm/reboot.S           |  2 +-
 drivers/firmware/efi/libstub/x86-5lvl.c |  4 ++--
 6 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/x86/boot/pm.c b/arch/x86/boot/pm.c
index ab35b52d2c4b..5941f930f6c5 100644
--- a/arch/x86/boot/pm.c
+++ b/arch/x86/boot/pm.c
@@ -68,9 +68,9 @@ static void setup_gdt(void)
 	   being 8-byte unaligned.  Intel recommends 16 byte alignment. */
 	static const u64 boot_gdt[] __attribute__((aligned(16))) = {
 		/* CS: code, read/execute, 4 GB, base 0 */
-		[GDT_ENTRY_BOOT_CS] = GDT_ENTRY(DESC_CODE32 | _DESC_ACCESSED, 0, 0xfffff),
+		[GDT_ENTRY_BOOT_CS] = GDT_ENTRY(DESC_CODE32, 0, 0xfffff),
 		/* DS: data, read/write, 4 GB, base 0 */
-		[GDT_ENTRY_BOOT_DS] = GDT_ENTRY(DESC_DATA32 | _DESC_ACCESSED, 0, 0xfffff),
+		[GDT_ENTRY_BOOT_DS] = GDT_ENTRY(DESC_DATA32, 0, 0xfffff),
 		/* TSS: 32-bit tss, 104 bytes, base 4096 */
 		/* We only have a TSS here to keep Intel VT happy;
 		   we don't actually use it for anything. */
diff --git a/arch/x86/include/asm/desc_defs.h b/arch/x86/include/asm/desc_defs.h
index 014878e584fe..f9282bcb0a91 100644
--- a/arch/x86/include/asm/desc_defs.h
+++ b/arch/x86/include/asm/desc_defs.h
@@ -37,9 +37,9 @@
  * of flags
  */
 
-#define _DESC_DATA		(_DESC_S | _DESC_PRESENT | \
+#define _DESC_DATA		(_DESC_S | _DESC_PRESENT | _DESC_ACCESSED | \
 				 _DESC_DATA_WRITABLE)
-#define _DESC_CODE		(_DESC_S | _DESC_PRESENT | \
+#define _DESC_CODE		(_DESC_S | _DESC_PRESENT | _DESC_ACCESSED | \
 				 _DESC_CODE_READABLE | _DESC_CODE_EXECUTABLE)
 
 #define DESC_DATA16		(_DESC_DATA)
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 32934a0656af..6184488a7d77 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -188,12 +188,12 @@ DEFINE_PER_CPU_PAGE_ALIGNED(struct gdt_page, gdt_page) = { .gdt = {
 	 * TLS descriptors are currently at a different place compared to i386.
 	 * Hopefully nobody expects them at a fixed place (Wine?)
 	 */
-	[GDT_ENTRY_KERNEL32_CS]		= GDT_ENTRY_INIT(DESC_CODE32 | _DESC_ACCESSED, 0, 0xfffff),
-	[GDT_ENTRY_KERNEL_CS]		= GDT_ENTRY_INIT(DESC_CODE64 | _DESC_ACCESSED, 0, 0xfffff),
-	[GDT_ENTRY_KERNEL_DS]		= GDT_ENTRY_INIT(DESC_DATA64 | _DESC_ACCESSED, 0, 0xfffff),
-	[GDT_ENTRY_DEFAULT_USER32_CS]	= GDT_ENTRY_INIT(DESC_CODE32 | DESC_USER | _DESC_ACCESSED, 0, 0xfffff),
-	[GDT_ENTRY_DEFAULT_USER_DS]	= GDT_ENTRY_INIT(DESC_DATA64 | DESC_USER | _DESC_ACCESSED, 0, 0xfffff),
-	[GDT_ENTRY_DEFAULT_USER_CS]	= GDT_ENTRY_INIT(DESC_CODE64 | DESC_USER | _DESC_ACCESSED, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL32_CS]		= GDT_ENTRY_INIT(DESC_CODE32, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL_CS]		= GDT_ENTRY_INIT(DESC_CODE64, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL_DS]		= GDT_ENTRY_INIT(DESC_DATA64, 0, 0xfffff),
+	[GDT_ENTRY_DEFAULT_USER32_CS]	= GDT_ENTRY_INIT(DESC_CODE32 | DESC_USER, 0, 0xfffff),
+	[GDT_ENTRY_DEFAULT_USER_DS]	= GDT_ENTRY_INIT(DESC_DATA64 | DESC_USER, 0, 0xfffff),
+	[GDT_ENTRY_DEFAULT_USER_CS]	= GDT_ENTRY_INIT(DESC_CODE64 | DESC_USER, 0, 0xfffff),
 #else
 	[GDT_ENTRY_KERNEL_CS]		= GDT_ENTRY_INIT(DESC_CODE32, 0, 0xfffff),
 	[GDT_ENTRY_KERNEL_DS]		= GDT_ENTRY_INIT(DESC_DATA32, 0, 0xfffff),
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 00dbddfdfece..dc0956067944 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -71,9 +71,9 @@ EXPORT_SYMBOL(vmemmap_base);
  * GDT used on the boot CPU before switching to virtual addresses.
  */
 static struct desc_struct startup_gdt[GDT_ENTRIES] __initdata = {
-	[GDT_ENTRY_KERNEL32_CS]         = GDT_ENTRY_INIT(DESC_CODE32 | _DESC_ACCESSED, 0, 0xfffff),
-	[GDT_ENTRY_KERNEL_CS]           = GDT_ENTRY_INIT(DESC_CODE64 | _DESC_ACCESSED, 0, 0xfffff),
-	[GDT_ENTRY_KERNEL_DS]           = GDT_ENTRY_INIT(DESC_DATA64 | _DESC_ACCESSED, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL32_CS]         = GDT_ENTRY_INIT(DESC_CODE32, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL_CS]           = GDT_ENTRY_INIT(DESC_CODE64, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL_DS]           = GDT_ENTRY_INIT(DESC_DATA64, 0, 0xfffff),
 };
 
 /*
diff --git a/arch/x86/realmode/rm/reboot.S b/arch/x86/realmode/rm/reboot.S
index 5bc068b9acdd..e714b4624e36 100644
--- a/arch/x86/realmode/rm/reboot.S
+++ b/arch/x86/realmode/rm/reboot.S
@@ -154,5 +154,5 @@ SYM_DATA_START(machine_real_restart_gdt)
 	 * base value 0x100; since this is consistent with real mode
 	 * semantics we don't have to reload the segments once CR0.PE = 0.
 	 */
-	.quad	GDT_ENTRY(DESC_DATA16 | _DESC_ACCESSED, 0x100, 0xffff)
+	.quad	GDT_ENTRY(DESC_DATA16, 0x100, 0xffff)
 SYM_DATA_END(machine_real_restart_gdt)
diff --git a/drivers/firmware/efi/libstub/x86-5lvl.c b/drivers/firmware/efi/libstub/x86-5lvl.c
index 005dd9b14f95..77359e802181 100644
--- a/drivers/firmware/efi/libstub/x86-5lvl.c
+++ b/drivers/firmware/efi/libstub/x86-5lvl.c
@@ -13,8 +13,8 @@ bool efi_no5lvl;
 static void (*la57_toggle)(void *cr3);
 
 static const struct desc_struct gdt[] = {
-	[GDT_ENTRY_KERNEL32_CS] = GDT_ENTRY_INIT(DESC_CODE32 | _DESC_ACCESSED, 0, 0xfffff),
-	[GDT_ENTRY_KERNEL_CS]   = GDT_ENTRY_INIT(DESC_CODE64 | _DESC_ACCESSED, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL32_CS] = GDT_ENTRY_INIT(DESC_CODE32, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL_CS]   = GDT_ENTRY_INIT(DESC_CODE64, 0, 0xfffff),
 };
 
 /*
-- 
2.34.1


