Return-Path: <linux-kernel+bounces-99718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 232E3878C2D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA856282C48
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C17A10E3;
	Tue, 12 Mar 2024 01:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="p1nz6o43"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2024.outbound.protection.outlook.com [40.92.42.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472507E2
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 01:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710206223; cv=fail; b=FshvadWeGxEflnfwI9pvrkVei2/dd5PsjGzAa/wpsg3aaYn2OCnn3b/S5v5gvm+15h++dJFoRNEnun0tfRWp5MAbfhF/p6z49KrDoRQiPjErNgkJpwwYjmsJWnTnpQkN2Eooc7r9qzALl5LeEOoec3jB2tPkJum04YTCQu88s4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710206223; c=relaxed/simple;
	bh=ivFC8CF08C3ijyaHphuj2cNHYX+s3+qo3f6JiPE5m+A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FBXmR5QrnPsrnGOEtqzCRsy/PjZtjnDtCDeuGEeS4G4SzCSHzaKufkh0346ol1D9pXIDOYVD7DrRduvs+Oan5UpS5BcoVPcA0dB1nQGC7RsHwUqdQKDyj5/q0gS6X+nkzQaBXLBsPlCjDRbc37jf3bosjzXV/cHUsO4NukLqnDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=p1nz6o43; arc=fail smtp.client-ip=40.92.42.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhOSBpHoPwTseyhsf1X1vPOdTShsNdiBkpwGPwAk+i3288HlmA3WQPlzZkxWTpdA7C+3mxE91dN8rPm0OFHFJrPN8mksrpo+uDKPiF24SQtnz0Kp/m8Ft9lTadJNHXUvLuVsIe6MqqkCg0gTR14FUU5rkZuO/RymZRtniV9MbkDlPWm/AfhiL85pHvfnzK3kYcJkEFznRzCIdV5qNwgAYeQRMKMsMIq33r9HClIu5t8YmcOizGPctLUSqZK2aRzHCiCdSOiUEB36+YInsb4ZEawUxPqdn14vSpLqho4GeuyrVmNa8OIk6AN4tgsOQvrBuhBtFO1Wa2+Ry4/G84w06Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFzTvXIkb+n+2VkwafecplsBMngXgvJibfxvgoo/oiU=;
 b=I9MZH7nhnJ5UG0hDJILSlkYMWPjfJjVmuxwpUYfqqcFtJsrdAs7nZGm7bjfXnZMio9ljNOy94SSqf6PIrjNZSLBDj7XzhH5WaHI4fkk60dbUlIQuwOtTTQffAui3QVgzuM6H5a6eXCyjisfGmhipEty58ftM6o6u05VTZ4B86sjIP4IId4Xm+ylkJXATrzEW9YS+6fL4UrIs/xzYkTLfXt+dBT47swHx4kr+GLcO4mY/d5XgC14O6OLvnT3jtWAkh2Qd07RFsJGpa2MpQkkbihIVs7WzC70rf5dTo+xELvd27xW0p3cbZB9bbnYTrcBnaIOVsb1P7CE7cubK30Mk7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFzTvXIkb+n+2VkwafecplsBMngXgvJibfxvgoo/oiU=;
 b=p1nz6o430/gj+yv8oQs3w0RyWCQCSdK5k/+9klOVxxnM5BPB78qAt1iNHnvCLHQRqTe3pz/wa7wnCt1bl4MoBU8pkVKdJz8Hb5ta60bAreLhg9mVnR3FHfZvNg5T7RGWujCrMhoMO/em91GGr2WykfIrCv0+QMBE6eNt7e6GMWPvVMFcoBWf1WioTIZAUElQG6WrR3tmfSHUG55ztFfAVucNeHKezlrx+v9s71HWr7i1r/mP8+aTVFZmAee3oWzHQE8DIMHr5Sq7K/UPYWFLCiKy45VZI+V5E6y1++ag7n43e6pyisK5ep/eqIvBA9TYT/sOnuuhSmlNDmefsjCOBg==
Received: from MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5)
 by CY8PR12MB7193.namprd12.prod.outlook.com (2603:10b6:930:5b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Tue, 12 Mar
 2024 01:16:59 +0000
Received: from MW4PR12MB6875.namprd12.prod.outlook.com
 ([fe80::f933:4f7d:1a1e:d7c4]) by MW4PR12MB6875.namprd12.prod.outlook.com
 ([fe80::f933:4f7d:1a1e:d7c4%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 01:16:59 +0000
From: Shivansh Vij <shivanshvij@outlook.com>
To:
Cc: shivanshvij@loopholelabs.io,
	Shivansh Vij <shivanshvij@outlook.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	David Hildenbrand <david@redhat.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	James Houghton <jthoughton@google.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Peter Collingbourne <pcc@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: adds soft dirty page tracking
Date: Tue, 12 Mar 2024 01:16:17 +0000
Message-ID:
 <MW4PR12MB687563EFB56373E8D55DDEABB92B2@MW4PR12MB6875.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.34.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [ykubRuz2aK2BAVQ7m8oaYEd/h0rZNVg6]
X-ClientProxiedBy: BYAPR08CA0018.namprd08.prod.outlook.com
 (2603:10b6:a03:100::31) To MW4PR12MB6875.namprd12.prod.outlook.com
 (2603:10b6:303:209::5)
X-Microsoft-Original-Message-ID:
 <20240312011621.92294-1-shivanshvij@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6875:EE_|CY8PR12MB7193:EE_
X-MS-Office365-Filtering-Correlation-Id: 920e50a9-edb0-4177-c38d-08dc42321d63
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DsjcLQiu7RIEoUjQWpFWe5JRLdOPMQaA9R5P+Eyd69AWrqcasKTfhiGivjoDo9kJvP379em4DmaP5eru6TDfqGOEE3X5T4r0YKs6BlqbIr+4guAmkkFAy3HEQMyFTjUn/hXXJ5yR0PV6BxIkzE2BpvWXJE66mD29bpAgpabC5nBL7KwNlIR1YqFlKatsEOM4muT5REq8o2eduJ+1biEmd5mxcxnRTwdn9+Df1Ee3gfDB2je3tiQJvmSXEK7eQl1GmZpGV90rOrT1VK1woa4Hfv6E8qg+53MqRazbTkXlI54oKu7Vi83l33SFIWGivbgi/h83tocTSb0V82zk3SIVyZ49Uh9tDQXAuQM0H2KTxDBA9ZTDUKcHKg5eq5wWFt/lG8MS/9PnjsCmKWUTvBAaE29skq0528DHhyxLhlHYl0OTkebbiM5KB+yJfqN3MmmJWEKKNr33h7aHqOQ5TAAEG2J566Sy+KQr7YZGQdOV9olLU7gSiLG2ZS0ed1CcjvXuIkNhxklhwr5fuUsCVY4oBVALOLLEVkrntXKR9rnPaT0ot6ubLnkLRkpU1iqF5HyrQedwUzWYwH8gdwKrS03Xe27Bl0bZLYdX70uBbCD961/ZfjFJ6RXg9uga5uqKO8XuR7mPY40JQEKrvfwnHOL2bdppBsOcQ6gba/e/CVBSW50Oe/+ZyoV9CvOtHqm1PmHO
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1SSUAfUZKn47r0G0xL4mgcCFLBHSFXuUFzd0XvkzYa/upGgnx7nqUTYOb0Z9?=
 =?us-ascii?Q?lolqx6PSyoyWuCyDur/1JdflMwowbim3AD6tsYwsVHOlyFF4hddtOi4ulZFe?=
 =?us-ascii?Q?Fmv9A9dNTEvrlrP5TGtLKgzEmUeCchUyPz/wVsjycYFU3Fzakf7hTRvgRT/l?=
 =?us-ascii?Q?LkQt8CNSo7+9YkR6u9l3GV3081ZLYqharcR3ZLvgD34zm3cezUvVDnWs2S/Y?=
 =?us-ascii?Q?nSn7oybGpO3UoI5VfMcaVSvKxIMKolk4z9OvH59DyAgtQByJcjF9+wlc2uyn?=
 =?us-ascii?Q?KipRW6F7tTJom+WxVixdcUQkntCX8dhYghnKv6CU1ZXiQZMIRIVqewLHLP8X?=
 =?us-ascii?Q?NHQyIg3tUJCj1+CZBhg3KicxcUoFisdT0EZYr81TQin/ca3nH4hU7HeH7Cyd?=
 =?us-ascii?Q?hlBufl50wfGcgQvnVHigAB2d+6xVtMEUuaNPvv0wRioTb8w0SVpgIjXvUr4r?=
 =?us-ascii?Q?46+oLUB3MnLsFtAmGGX2i++ZljPEYR31BAyjVhvhzcyDCeXkFSg8jEBDmvV8?=
 =?us-ascii?Q?GfNcrdmXZD9heNZ01fmacjdQsE86GgXnckPA0fZsjbHsJChE8EtyNlj6dHnQ?=
 =?us-ascii?Q?i5/CoQpHZoT6i/0hL6efxia52q114l8sovyAi3Pybh/ntTzt9j2NAT3fFWeV?=
 =?us-ascii?Q?1enpn1BpAEnQzjXLlFU36ugwzMh+VWseuPzySGILdiNOEcYsJOJm3Zr1S9+O?=
 =?us-ascii?Q?WDz/YVJBfBSocXeFYiF6+qW5Uxx/NNPM7DUwqyi1mYnG7puZcU3dEtPVazQI?=
 =?us-ascii?Q?SiZ4ZMwL0WOQwPqJZxc6QbkErhka0qHmbdI9T+uQtttfIvuIFbv5bPZk3je3?=
 =?us-ascii?Q?kJ66HirVqcqEpssjDDLCrA0gmNKGK9WT588GhZHEcwrLUpVXK7oBdC0Xngon?=
 =?us-ascii?Q?hlhSFMViml7htazUFxuSk2PGMg3KWSLVpallGU03bGWNAW7/HHSpbykhPdAV?=
 =?us-ascii?Q?Q8b+3CpMLN9aIjuwmP0BH47i9bB7FIHZUV20PVC9Jrw6QPudJgCOvsXvZrJn?=
 =?us-ascii?Q?Q102DY4w5cy5tIyPk1DNebGFG+jwu6dse1ufII5N9/Gwe4Fb916rSLK6Vcq1?=
 =?us-ascii?Q?9XyscAWwj4KM45XM4LeW6OPW11fNPMnFROUqeT5BVUIzd42ZcE9FGCrgWdeo?=
 =?us-ascii?Q?hCD1SSN4jMGPTyn3o2N/r2pTpLJbw1VZ3UTiKha/GqU9P4a2MaPV3BQi981p?=
 =?us-ascii?Q?x8Xw1cya/JMzMugu0s7wYnPRyRRBqTzsAfRdhNQnrIaCk3CbW/AkhBhJQIMm?=
 =?us-ascii?Q?cqRrBD7zs9fDe5NboRl7?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 920e50a9-edb0-4177-c38d-08dc42321d63
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6875.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 01:16:59.0329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7193

Checkpoint-Restore in Userspace (CRIU) needs to be able
to track a memory page's changes if we want to enable
pre-dumping, which is important for live migrations.

The PTE_DIRTY bit (defined in pgtable-prot.h) is already
used to track software dirty pages, and the PTE_WRITE and
PTE_READ bits are used to track hardware dirty pages.

This patch enables full soft dirty page tracking
(including swap PTE support) for arm64 systems, and is
based very closely on the x86 implementation.

It is based on an unfinished patch by
Bin Lu (bin.lu@arm.com) from 2017
(https://patchwork.kernel.org/project/linux-arm-kernel/patch/1512029649-61312-1-git-send-email-bin.lu@arm.com/),
but has been updated for newer 6.x kernels as well as
tested on various 5.x kernels.

The main difference is this attempts to fix the bug
identified in the original patch where calling pte_mkclean()
on a page would result in pte_soft_dirty() == false. This
is invalid behaviour because pte_soft_dirty() should only
return false if the PTE_DIRTY bit is not set and
pte_mksoft_dirty() function has not been called. The x86
implementation expects this behaviour as well.

To achieve this, an additional software dirty bit called
PTE_SOFT_DIRTY is defined (in pgtable-prot.h), which is used
exclusively to track soft dirty pages.

This patch also reuses the _PAGE_SWP_SOFT_DIRTY
bit (defined in pgtable.h) from the original patch to add
support for swapped pages and for THP page MADV_FREE because
pmd_* functions have also been implemented.

This patch has been tested with CRIU's ZDTM test suite on
5.x and 6.x kernels using the following command:
test/zdtm.py run --page-server --remote-lazy-pages --keep-going --pre 3 -a

Signed-off-by: Shivansh Vij <shivanshvij@outlook.com>
---
 arch/arm64/Kconfig                    |  1 +
 arch/arm64/include/asm/pgtable-prot.h |  6 +++
 arch/arm64/include/asm/pgtable.h      | 54 ++++++++++++++++++++++++++-
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index aa7c1d435139..fe73d4809c7e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -178,6 +178,7 @@ config ARM64
 	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_STACKLEAK
+	select HAVE_ARCH_SOFT_DIRTY
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 483dbfa39c4c..1b4119bbdf01 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -27,6 +27,12 @@
  */
 #define PMD_PRESENT_INVALID	(_AT(pteval_t, 1) << 59) /* only when !PMD_SECT_VALID */
 
+#ifdef CONFIG_MEM_SOFT_DIRTY
+#define PTE_SOFT_DIRTY          (_AT(pteval_t, 1) << 60) /* for soft dirty tracking */
+#else
+#define PTE_SOFT_DIRTY          0UL
+#endif /* CONFIG_MEM_SOFT_DIRTY */
+
 #define _PROT_DEFAULT		(PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
 #define _PROT_SECT_DEFAULT	(PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
 
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 79ce70fbb751..0e699e7d96da 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -198,7 +198,7 @@ static inline pte_t pte_mkclean(pte_t pte)
 
 static inline pte_t pte_mkdirty(pte_t pte)
 {
-	pte = set_pte_bit(pte, __pgprot(PTE_DIRTY));
+	pte = set_pte_bit(pte, __pgprot(PTE_DIRTY | PTE_SOFT_DIRTY));
 
 	if (pte_write(pte))
 		pte = clear_pte_bit(pte, __pgprot(PTE_RDONLY));
@@ -443,6 +443,29 @@ static inline pgprot_t pte_pgprot(pte_t pte)
 	return __pgprot(pte_val(pfn_pte(pfn, __pgprot(0))) ^ pte_val(pte));
 }
 
+#ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
+static inline bool pte_soft_dirty(pte_t pte)
+{
+	return pte_sw_dirty(pte) || (!!(pte_val(pte) & PTE_SOFT_DIRTY));
+}
+
+static inline pte_t pte_mksoft_dirty(pte_t pte)
+{
+	pte = set_pte_bit(pte, __pgprot(PTE_SOFT_DIRTY));
+	return pte;
+}
+
+static inline pte_t pte_clear_soft_dirty(pte_t pte)
+{
+	pte = clear_pte_bit(pte, __pgprot(PTE_SOFT_DIRTY));
+	return pte;
+}
+
+#define pmd_soft_dirty(pmd)    pte_soft_dirty(pmd_pte(pmd))
+#define pmd_mksoft_dirty(pmd)  pte_pmd(pte_mksoft_dirty(pmd_pte(pmd)))
+#define pmd_clear_soft_dirty(pmd) pte_pmd(pte_clear_soft_dirty(pmd_pte(pmd)))
+#endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
+
 #ifdef CONFIG_NUMA_BALANCING
 /*
  * See the comment in include/linux/pgtable.h
@@ -1013,10 +1036,12 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
  *	bits 3-7:	swap type
  *	bits 8-57:	swap offset
  *	bit  58:	PTE_PROT_NONE (must be zero)
+ *	bit  59:        swap software dirty tracking
  */
 #define __SWP_TYPE_SHIFT	3
 #define __SWP_TYPE_BITS		5
 #define __SWP_OFFSET_BITS	50
+#define __SWP_PROT_NONE_BITS    1
 #define __SWP_TYPE_MASK		((1 << __SWP_TYPE_BITS) - 1)
 #define __SWP_OFFSET_SHIFT	(__SWP_TYPE_BITS + __SWP_TYPE_SHIFT)
 #define __SWP_OFFSET_MASK	((1UL << __SWP_OFFSET_BITS) - 1)
@@ -1033,6 +1058,33 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 #define __swp_entry_to_pmd(swp)		__pmd((swp).val)
 #endif /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
 
+#ifdef CONFIG_MEM_SOFT_DIRTY
+#define _PAGE_SWP_SOFT_DIRTY   (1UL << (__SWP_OFFSET_SHIFT + __SWP_OFFSET_BITS + __SWP_PROT_NONE_BITS))
+#else
+#define _PAGE_SWP_SOFT_DIRTY    0UL
+#endif /* CONFIG_MEM_SOFT_DIRTY */
+
+#ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
+static inline bool pte_swp_soft_dirty(pte_t pte)
+{
+	return !!(pte_val(pte) & _PAGE_SWP_SOFT_DIRTY);
+}
+
+static inline pte_t pte_swp_mksoft_dirty(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_SWP_SOFT_DIRTY);
+}
+
+static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~_PAGE_SWP_SOFT_DIRTY);
+}
+
+#define pmd_swp_soft_dirty(pmd)        pte_swp_soft_dirty(pmd_pte(pmd))
+#define pmd_swp_mksoft_dirty(pmd)      pte_pmd(pte_swp_mksoft_dirty(pmd_pte(pmd)))
+#define pmd_swp_clear_soft_dirty(pmd)  pte_pmd(pte_swp_clear_soft_dirty(pmd_pte(pmd)))
+#endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
+
 /*
  * Ensure that there are not more swap files than can be encoded in the kernel
  * PTEs.
-- 
2.34.3


