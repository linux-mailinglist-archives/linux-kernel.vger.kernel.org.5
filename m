Return-Path: <linux-kernel+bounces-5464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3BC818AE9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D782889C5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECEB225D2;
	Tue, 19 Dec 2023 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J5oHC+OQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C604C20DD1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 15:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ9x1M3028212;
	Tue, 19 Dec 2023 15:12:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=ddGyKDys05MLGTK4U9g4t4jlQdkek2GlwLVRehG8mj8=;
 b=J5oHC+OQTs9a9BLGGpxLtm9N2WTGasvE18XuWT9zLy58pwGZJ5QYnVT5BpYg7mzMTGV2
 UM34GpctHZyk3rXbuh38WO4sreEZZp6Cm5+SNXsjTs8Z9sBEMoKSONEb+aDKzAbJoYIU
 aLqhMCCJ2QOwki4qKkoJgg765pLkIppkV+KAvIN93yEwvwvsr/fwI9Z0sRvr5l5GydLf
 dUThlBymBXmqUkrhZNJzlcUsSwnH5r+6n3lDeUoydvbV9GQB4oqwQ/1wjPVZJGGDI1AF
 V5tE8vNe5MgpezIAyeUGmC2iVv6LJhUf4iccp28vHtEIcOw/iH95ilwZANIGtO6f7Hg9 TA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v12aee296-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 15:12:20 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJEZpLX029167;
	Tue, 19 Dec 2023 15:12:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b6w7fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 15:12:19 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BJF7SdR008899;
	Tue, 19 Dec 2023 15:12:18 GMT
Received: from localhost.localdomain (dhcp-10-175-58-169.vpn.oracle.com [10.175.58.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3v12b6w71u-4;
	Tue, 19 Dec 2023 15:12:18 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Brian Gerst <brgerst@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH 3/5] x86: replace magic numbers in GDT descriptors, part 2
Date: Tue, 19 Dec 2023 16:11:58 +0100
Message-Id: <20231219151200.2878271-4-vegard.nossum@oracle.com>
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
X-Proofpoint-ORIG-GUID: lj19XYphJT7S4FFUGQx6WK2MoL9A9qeq
X-Proofpoint-GUID: lj19XYphJT7S4FFUGQx6WK2MoL9A9qeq

Actually replace the numeric values by the new symbolic values.

I used this to find all the existing users of the GDT_ENTRY*() macros:

  $ git grep -P 'GDT_ENTRY(_INIT)?\('

Some of the lines will exceed 80 characters, but some of them will be
shorter again in the next couple of patches.

Link: https://lore.kernel.org/all/CAHk-=wib5XLebuEra7y2YH96wxdk=8vJnA8XoVq0FExpzVvN=Q@mail.gmail.com/
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 arch/x86/boot/pm.c                      |  6 ++--
 arch/x86/kernel/apm_32.c                |  2 +-
 arch/x86/kernel/cpu/common.c            | 40 ++++++++++++-------------
 arch/x86/kernel/head64.c                |  6 ++--
 arch/x86/kernel/setup_percpu.c          |  4 +--
 arch/x86/platform/pvh/head.S            |  6 ++--
 arch/x86/realmode/rm/reboot.S           |  2 +-
 drivers/firmware/efi/libstub/x86-5lvl.c |  4 +--
 drivers/pnp/pnpbios/bioscalls.c         |  2 +-
 9 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/x86/boot/pm.c b/arch/x86/boot/pm.c
index 0361b5307bd8..ab35b52d2c4b 100644
--- a/arch/x86/boot/pm.c
+++ b/arch/x86/boot/pm.c
@@ -68,13 +68,13 @@ static void setup_gdt(void)
 	   being 8-byte unaligned.  Intel recommends 16 byte alignment. */
 	static const u64 boot_gdt[] __attribute__((aligned(16))) = {
 		/* CS: code, read/execute, 4 GB, base 0 */
-		[GDT_ENTRY_BOOT_CS] = GDT_ENTRY(0xc09b, 0, 0xfffff),
+		[GDT_ENTRY_BOOT_CS] = GDT_ENTRY(DESC_CODE32 | _DESC_ACCESSED, 0, 0xfffff),
 		/* DS: data, read/write, 4 GB, base 0 */
-		[GDT_ENTRY_BOOT_DS] = GDT_ENTRY(0xc093, 0, 0xfffff),
+		[GDT_ENTRY_BOOT_DS] = GDT_ENTRY(DESC_DATA32 | _DESC_ACCESSED, 0, 0xfffff),
 		/* TSS: 32-bit tss, 104 bytes, base 4096 */
 		/* We only have a TSS here to keep Intel VT happy;
 		   we don't actually use it for anything. */
-		[GDT_ENTRY_BOOT_TSS] = GDT_ENTRY(0x0089, 4096, 103),
+		[GDT_ENTRY_BOOT_TSS] = GDT_ENTRY(DESC_TSS32, 4096, 103),
 	};
 	/* Xen HVM incorrectly stores a pointer to the gdt_ptr, instead
 	   of the gdt_ptr contents.  Thus, make it static so it will
diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
index 5934ee5bc087..76a5ced278c2 100644
--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -420,7 +420,7 @@ static DEFINE_MUTEX(apm_mutex);
  * This is for buggy BIOS's that refer to (real mode) segment 0x40
  * even though they are called in protected mode.
  */
-static struct desc_struct bad_bios_desc = GDT_ENTRY_INIT(0x4092,
+static struct desc_struct bad_bios_desc = GDT_ENTRY_INIT(DESC_DATA32_BIOS,
 			(unsigned long)__va(0x400UL), PAGE_SIZE - 0x400 - 1);
 
 static const char driver_version[] = "1.16ac";	/* no spaces */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index ceb6e4b6d57e..32934a0656af 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -188,37 +188,37 @@ DEFINE_PER_CPU_PAGE_ALIGNED(struct gdt_page, gdt_page) = { .gdt = {
 	 * TLS descriptors are currently at a different place compared to i386.
 	 * Hopefully nobody expects them at a fixed place (Wine?)
 	 */
-	[GDT_ENTRY_KERNEL32_CS]		= GDT_ENTRY_INIT(0xc09b, 0, 0xfffff),
-	[GDT_ENTRY_KERNEL_CS]		= GDT_ENTRY_INIT(0xa09b, 0, 0xfffff),
-	[GDT_ENTRY_KERNEL_DS]		= GDT_ENTRY_INIT(0xc093, 0, 0xfffff),
-	[GDT_ENTRY_DEFAULT_USER32_CS]	= GDT_ENTRY_INIT(0xc0fb, 0, 0xfffff),
-	[GDT_ENTRY_DEFAULT_USER_DS]	= GDT_ENTRY_INIT(0xc0f3, 0, 0xfffff),
-	[GDT_ENTRY_DEFAULT_USER_CS]	= GDT_ENTRY_INIT(0xa0fb, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL32_CS]		= GDT_ENTRY_INIT(DESC_CODE32 | _DESC_ACCESSED, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL_CS]		= GDT_ENTRY_INIT(DESC_CODE64 | _DESC_ACCESSED, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL_DS]		= GDT_ENTRY_INIT(DESC_DATA64 | _DESC_ACCESSED, 0, 0xfffff),
+	[GDT_ENTRY_DEFAULT_USER32_CS]	= GDT_ENTRY_INIT(DESC_CODE32 | DESC_USER | _DESC_ACCESSED, 0, 0xfffff),
+	[GDT_ENTRY_DEFAULT_USER_DS]	= GDT_ENTRY_INIT(DESC_DATA64 | DESC_USER | _DESC_ACCESSED, 0, 0xfffff),
+	[GDT_ENTRY_DEFAULT_USER_CS]	= GDT_ENTRY_INIT(DESC_CODE64 | DESC_USER | _DESC_ACCESSED, 0, 0xfffff),
 #else
-	[GDT_ENTRY_KERNEL_CS]		= GDT_ENTRY_INIT(0xc09a, 0, 0xfffff),
-	[GDT_ENTRY_KERNEL_DS]		= GDT_ENTRY_INIT(0xc092, 0, 0xfffff),
-	[GDT_ENTRY_DEFAULT_USER_CS]	= GDT_ENTRY_INIT(0xc0fa, 0, 0xfffff),
-	[GDT_ENTRY_DEFAULT_USER_DS]	= GDT_ENTRY_INIT(0xc0f2, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL_CS]		= GDT_ENTRY_INIT(DESC_CODE32, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL_DS]		= GDT_ENTRY_INIT(DESC_DATA32, 0, 0xfffff),
+	[GDT_ENTRY_DEFAULT_USER_CS]	= GDT_ENTRY_INIT(DESC_CODE32 | DESC_USER, 0, 0xfffff),
+	[GDT_ENTRY_DEFAULT_USER_DS]	= GDT_ENTRY_INIT(DESC_DATA32 | DESC_USER, 0, 0xfffff),
 	/*
 	 * Segments used for calling PnP BIOS have byte granularity.
 	 * They code segments and data segments have fixed 64k limits,
 	 * the transfer segment sizes are set at run time.
 	 */
-	[GDT_ENTRY_PNPBIOS_CS32]	= GDT_ENTRY_INIT(0x409a, 0, 0xffff),
-	[GDT_ENTRY_PNPBIOS_CS16]	= GDT_ENTRY_INIT(0x009a, 0, 0xffff),
-	[GDT_ENTRY_PNPBIOS_DS]		= GDT_ENTRY_INIT(0x0092, 0, 0xffff),
-	[GDT_ENTRY_PNPBIOS_TS1]		= GDT_ENTRY_INIT(0x0092, 0, 0),
-	[GDT_ENTRY_PNPBIOS_TS2]		= GDT_ENTRY_INIT(0x0092, 0, 0),
+	[GDT_ENTRY_PNPBIOS_CS32]	= GDT_ENTRY_INIT(DESC_CODE32_BIOS, 0, 0xffff),
+	[GDT_ENTRY_PNPBIOS_CS16]	= GDT_ENTRY_INIT(DESC_CODE16, 0, 0xffff),
+	[GDT_ENTRY_PNPBIOS_DS]		= GDT_ENTRY_INIT(DESC_DATA16, 0, 0xffff),
+	[GDT_ENTRY_PNPBIOS_TS1]		= GDT_ENTRY_INIT(DESC_DATA16, 0, 0),
+	[GDT_ENTRY_PNPBIOS_TS2]		= GDT_ENTRY_INIT(DESC_DATA16, 0, 0),
 	/*
 	 * The APM segments have byte granularity and their bases
 	 * are set at run time.  All have 64k limits.
 	 */
-	[GDT_ENTRY_APMBIOS_BASE]	= GDT_ENTRY_INIT(0x409a, 0, 0xffff),
-	[GDT_ENTRY_APMBIOS_BASE+1]	= GDT_ENTRY_INIT(0x009a, 0, 0xffff),
-	[GDT_ENTRY_APMBIOS_BASE+2]	= GDT_ENTRY_INIT(0x4092, 0, 0xffff),
+	[GDT_ENTRY_APMBIOS_BASE]	= GDT_ENTRY_INIT(DESC_CODE32_BIOS, 0, 0xffff),
+	[GDT_ENTRY_APMBIOS_BASE+1]	= GDT_ENTRY_INIT(DESC_CODE16, 0, 0xffff),
+	[GDT_ENTRY_APMBIOS_BASE+2]	= GDT_ENTRY_INIT(DESC_DATA32_BIOS, 0, 0xffff),
 
-	[GDT_ENTRY_ESPFIX_SS]		= GDT_ENTRY_INIT(0xc092, 0, 0xfffff),
-	[GDT_ENTRY_PERCPU]		= GDT_ENTRY_INIT(0xc092, 0, 0xfffff),
+	[GDT_ENTRY_ESPFIX_SS]		= GDT_ENTRY_INIT(DESC_DATA32, 0, 0xfffff),
+	[GDT_ENTRY_PERCPU]		= GDT_ENTRY_INIT(DESC_DATA32, 0, 0xfffff),
 #endif
 } };
 EXPORT_PER_CPU_SYMBOL_GPL(gdt_page);
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 05a110c97111..00dbddfdfece 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -71,9 +71,9 @@ EXPORT_SYMBOL(vmemmap_base);
  * GDT used on the boot CPU before switching to virtual addresses.
  */
 static struct desc_struct startup_gdt[GDT_ENTRIES] __initdata = {
-	[GDT_ENTRY_KERNEL32_CS]         = GDT_ENTRY_INIT(0xc09b, 0, 0xfffff),
-	[GDT_ENTRY_KERNEL_CS]           = GDT_ENTRY_INIT(0xa09b, 0, 0xfffff),
-	[GDT_ENTRY_KERNEL_DS]           = GDT_ENTRY_INIT(0xc093, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL32_CS]         = GDT_ENTRY_INIT(DESC_CODE32 | _DESC_ACCESSED, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL_CS]           = GDT_ENTRY_INIT(DESC_CODE64 | _DESC_ACCESSED, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL_DS]           = GDT_ENTRY_INIT(DESC_DATA64 | _DESC_ACCESSED, 0, 0xfffff),
 };
 
 /*
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index 2c97bf7b56ae..f2583de97a64 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -106,8 +106,8 @@ void __init pcpu_populate_pte(unsigned long addr)
 static inline void setup_percpu_segment(int cpu)
 {
 #ifdef CONFIG_X86_32
-	struct desc_struct d = GDT_ENTRY_INIT(0x8092, per_cpu_offset(cpu),
-					      0xFFFFF);
+	struct desc_struct d = GDT_ENTRY_INIT(DESC_DATA32 & ~_DESC_DB,
+					      per_cpu_offset(cpu), 0xFFFFF);
 
 	write_gdt_entry(get_cpu_gdt_rw(cpu), GDT_ENTRY_PERCPU, &d, DESCTYPE_S);
 #endif
diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index 9bcafdded2a1..7c6a1089ce1c 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -149,11 +149,11 @@ SYM_DATA_END(gdt)
 SYM_DATA_START_LOCAL(gdt_start)
 	.quad 0x0000000000000000            /* NULL descriptor */
 #ifdef CONFIG_X86_64
-	.quad GDT_ENTRY(0xa09a, 0, 0xfffff) /* PVH_CS_SEL */
+	.quad GDT_ENTRY(DESC_CODE64, 0, 0xfffff) /* PVH_CS_SEL */
 #else
-	.quad GDT_ENTRY(0xc09a, 0, 0xfffff) /* PVH_CS_SEL */
+	.quad GDT_ENTRY(DESC_CODE32, 0, 0xfffff) /* PVH_CS_SEL */
 #endif
-	.quad GDT_ENTRY(0xc092, 0, 0xfffff) /* PVH_DS_SEL */
+	.quad GDT_ENTRY(DESC_DATA32, 0, 0xfffff) /* PVH_DS_SEL */
 SYM_DATA_END_LABEL(gdt_start, SYM_L_LOCAL, gdt_end)
 
 	.balign 16
diff --git a/arch/x86/realmode/rm/reboot.S b/arch/x86/realmode/rm/reboot.S
index 447641820a8d..5bc068b9acdd 100644
--- a/arch/x86/realmode/rm/reboot.S
+++ b/arch/x86/realmode/rm/reboot.S
@@ -154,5 +154,5 @@ SYM_DATA_START(machine_real_restart_gdt)
 	 * base value 0x100; since this is consistent with real mode
 	 * semantics we don't have to reload the segments once CR0.PE = 0.
 	 */
-	.quad	GDT_ENTRY(0x0093, 0x100, 0xffff)
+	.quad	GDT_ENTRY(DESC_DATA16 | _DESC_ACCESSED, 0x100, 0xffff)
 SYM_DATA_END(machine_real_restart_gdt)
diff --git a/drivers/firmware/efi/libstub/x86-5lvl.c b/drivers/firmware/efi/libstub/x86-5lvl.c
index 479dd445acdc..005dd9b14f95 100644
--- a/drivers/firmware/efi/libstub/x86-5lvl.c
+++ b/drivers/firmware/efi/libstub/x86-5lvl.c
@@ -13,8 +13,8 @@ bool efi_no5lvl;
 static void (*la57_toggle)(void *cr3);
 
 static const struct desc_struct gdt[] = {
-	[GDT_ENTRY_KERNEL32_CS] = GDT_ENTRY_INIT(0xc09b, 0, 0xfffff),
-	[GDT_ENTRY_KERNEL_CS]   = GDT_ENTRY_INIT(0xa09b, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL32_CS] = GDT_ENTRY_INIT(DESC_CODE32 | _DESC_ACCESSED, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL_CS]   = GDT_ENTRY_INIT(DESC_CODE64 | _DESC_ACCESSED, 0, 0xfffff),
 };
 
 /*
diff --git a/drivers/pnp/pnpbios/bioscalls.c b/drivers/pnp/pnpbios/bioscalls.c
index ddc6f2163c8e..1f31dce5835a 100644
--- a/drivers/pnp/pnpbios/bioscalls.c
+++ b/drivers/pnp/pnpbios/bioscalls.c
@@ -60,7 +60,7 @@ do { \
 	set_desc_limit(&gdt[(selname) >> 3], (size) - 1); \
 } while(0)
 
-static struct desc_struct bad_bios_desc = GDT_ENTRY_INIT(0x4092,
+static struct desc_struct bad_bios_desc = GDT_ENTRY_INIT(DESC_DATA32_BIOS,
 			(unsigned long)__va(0x400UL), PAGE_SIZE - 0x400 - 1);
 
 /*
-- 
2.34.1


