Return-Path: <linux-kernel+bounces-139276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 082D58A00D8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 753BC1F24CEC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60ECF181BBE;
	Wed, 10 Apr 2024 19:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NDv9o+u8"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9194F18133B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 19:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712778543; cv=fail; b=IXFYmIJDOkFto2fGYF6e97zSg7FDFFNKM4gKFwJd26Yuq1PFXaumwPRvgYL35VxwznhLwAoiQmy501OZsjpVq6UWJJ3bFTiyTLGZ0UI9Q1xzk9Z5lMsluPLerwGPdB56+O7X7K97ZGbdyk0tyUa8h3t1ommFEnfhEIbOq5uXyG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712778543; c=relaxed/simple;
	bh=merVLYCNiPq9p9XmNbliIowK9wIJ5D7VFSVo74JPGs8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=midi+sLKay9gorAoUWQ2aK+AaStPujy8SRDBEreZsXjV8Z5z84MJ/oOsoorCX+cp2tZ1g6qlVI7KIxYE6pAAQO7OmulItpidLS6Ko0lba5dQ/qk38CYJyEiUkMTBDcUc4DGDiCTxsZArX9PxhkBqn+PSczNRojGpW3wi+7mIEIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NDv9o+u8; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+Z7mJeFAYp3UCoF4dVgBenKULB+0ySKxHczpDrZfsbwl3R2pevjUBOGvR19ucImHZT0sKkm9/PTRL8cTtqBGFVVQ4MmJucb6EFHs4Sszdit4dQHUwxLBFt+Th4zqBB+4/21jRpo/re8kojfZwOwgxOXpNP6sxstngFJqsUwUhFoc9k3acKDrPZIjTsareoCvcKu4Ic8X0V1hviiZndFhOpR8slEvs+OIHsTQfnKNTCfL9vl9BHykgptRAW01k64q79PvlbtIxjpl72aqqq0+OrYWi5HFfcwncxk83TEcjMgkIYQDA1s/jZbZyU8PCsc19ORX9HP5qb5v0M0R5SkFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8T+x4jxsg29hp4NrWsDHlq3PgPopfnz5izPwrEU32xo=;
 b=b9tHmcMuIw/doMjqGzYJwNb3VbTHQgnSNvyzp0GA6EXfRCKS+YN1FhWJOvatRHu0Eb75m9oSpgdAIfB7Wp6u3nxjWRdMgagZUKMkLoZLXRYrFxy2VxNj7F0kTIzeAalNOgux4MjYGl3fgs+QPxdoszS2+I6eE5EYXtC2t2NO2livCuqevGgVgAKVVBsTfdqW4Hvncqq8rvJLjdrtVRnNddYzrQJUUWxSwrI/uSfwPrtoGRQbrESoxN0o0Re73FZ2hyQUwRktp8TAnxSYWDRZiHXoW7tQJfa+XinHI5oaX/GcpXgxp0/Rg6fQSHdinDcMMaasFds1L9Xhv7qbhllhmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8T+x4jxsg29hp4NrWsDHlq3PgPopfnz5izPwrEU32xo=;
 b=NDv9o+u8w347Ovn++snfiNVRGoi9kRUZToRc4xCigt9wn4ixF0BEC8vLa5bGNY19yqfuhJ878jas9VCSWzT6rqq+FP79lnqszESsE0He8HKu5XaIVJujv/n+btWu5bX7TTG0eG0znAuv8+4p6vbIH/aTPBt17kSNHo9JAQC2SGc=
Received: from SA1P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::25)
 by MW4PR12MB5627.namprd12.prod.outlook.com (2603:10b6:303:16a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.47; Wed, 10 Apr
 2024 19:48:59 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:22c:cafe::d3) by SA1P222CA0009.outlook.office365.com
 (2603:10b6:806:22c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Wed, 10 Apr 2024 19:48:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 19:48:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 14:48:58 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 14:48:58 -0500
Received: from fedora.mshome.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 10 Apr 2024 14:48:57 -0500
From: Jason Andryuk <jason.andryuk@amd.com>
To: Juergen Gross <jgross@suse.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Stefano Stabellini <sstabellini@kernel.org>, "Oleksandr
 Tyshchenko" <oleksandr_tyshchenko@epam.com>, Paolo Bonzini
	<pbonzini@redhat.com>
CC: <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>, "Jason
 Andryuk" <jason.andryuk@amd.com>
Subject: [PATCH 1/5] xen: sync elfnote.h from xen tree
Date: Wed, 10 Apr 2024 15:48:46 -0400
Message-ID: <20240410194850.39994-2-jason.andryuk@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240410194850.39994-1-jason.andryuk@amd.com>
References: <20240410194850.39994-1-jason.andryuk@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|MW4PR12MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: 9db9141e-40e4-44bc-d8d5-08dc5997439a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Wu2E9xIhxl/NYeJ1hGTh5Zf3Tf6ycEQKnQpDZ6tcFFrrRz68sqFCBH6S8dmCCw12VvQirhZwT8Cbd3XLOOynDGi7dYsAtrxm180hz5oZfaHN1eR4unrmJ6q1Lj6sl6vkAxoKwIpNOJ4KN8xX1UTxm/FeRRzIynR8eCTrFcBK3e0J0m5L6+3dVtZ5wVJtWzZoIjPwYjK3CxjdJJPVwawk7JEYPIUbY2NKqg+JH8z0lPc89tDF4rRxrVju6ddOHzQ++1sRoIIOORniqaZnr8mAW071PlFuPS4eb+N5ZU9pEeqmqWARTc6Jmi0O+TsehEXv8s0w4k2PXHjYsMjOzK0j/U85hXT7s4k+xP/e+rpwIu1w3XRWZS6CNdlOvLyLDPCwSKWCzjT2oADsOcLwWmiq4UazrL0v3AQh50aBRaerxAVhacosvSvImwxmSFDNzJ/PKd1/rrV7TWEAGPOHFK0eecbLtf8AUyHiuWR5LUnvVgC9beHs2CCp9BAfdgaV4Fkh3lFjYvuA1Hd+Og/hDI/W/YS4kn0sWR4r7Mh7EOYjBTWDyQo9veu00GNJmVF7Guw07DdYws9MuOD8p99ZhcV1OyRUpHyiHryV5LYH3mg0BSuYK+i9KNWMqvO55eZBdFIBUa1zjYtyShk6JRYccD214N8ROgnKrZV5zgZq/B7JuJTFNtZeY7i0Utft4j31V1dbHaU3IGzdHUFCX7I/OrI2j8RXfbiWAFiOT6VaTvyKaKc8FGQRKSqkoUrwxduaDyQ4fBuZwfco7d8J5gCsyK/BMg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(36860700004)(82310400014)(376005)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 19:48:58.8454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db9141e-40e4-44bc-d8d5-08dc5997439a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5627

Sync Xen's elfnote.h header from xen.git to pull in the
XEN_ELFNOTE_PHYS32_RELOC define.

xen commit dfc9fab00378 ("x86/PVH: Support relocatable dom0 kernels")

This is a copy except for the removal of the emacs editor config at the
end of the file.

Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
---
 include/xen/interface/elfnote.h | 93 +++++++++++++++++++++++++++++++--
 1 file changed, 88 insertions(+), 5 deletions(-)

diff --git a/include/xen/interface/elfnote.h b/include/xen/interface/elfnote.h
index 38deb1214613..918f47d87d7a 100644
--- a/include/xen/interface/elfnote.h
+++ b/include/xen/interface/elfnote.h
@@ -11,7 +11,9 @@
 #define __XEN_PUBLIC_ELFNOTE_H__
 
 /*
- * The notes should live in a SHT_NOTE segment and have "Xen" in the
+ * `incontents 200 elfnotes ELF notes
+ *
+ * The notes should live in a PT_NOTE segment and have "Xen" in the
  * name field.
  *
  * Numeric types are either 4 or 8 bytes depending on the content of
@@ -22,6 +24,8 @@
  *
  * String values (for non-legacy) are NULL terminated ASCII, also known
  * as ASCIZ type.
+ *
+ * Xen only uses ELF Notes contained in x86 binaries.
  */
 
 /*
@@ -52,7 +56,7 @@
 #define XEN_ELFNOTE_VIRT_BASE      3
 
 /*
- * The offset of the ELF paddr field from the acutal required
+ * The offset of the ELF paddr field from the actual required
  * pseudo-physical address (numeric).
  *
  * This is used to maintain backwards compatibility with older kernels
@@ -92,7 +96,12 @@
 #define XEN_ELFNOTE_LOADER         8
 
 /*
- * The kernel supports PAE (x86/32 only, string = "yes" or "no").
+ * The kernel supports PAE (x86/32 only, string = "yes", "no" or
+ * "bimodal").
+ *
+ * For compatibility with Xen 3.0.3 and earlier the "bimodal" setting
+ * may be given as "yes,bimodal" which will cause older Xen to treat
+ * this kernel as PAE.
  *
  * LEGACY: PAE (n.b. The legacy interface included a provision to
  * indicate 'extended-cr3' support allowing L3 page tables to be
@@ -149,7 +158,9 @@
  * The (non-default) location the initial phys-to-machine map should be
  * placed at by the hypervisor (Dom0) or the tools (DomU).
  * The kernel must be prepared for this mapping to be established using
- * large pages, despite such otherwise not being available to guests.
+ * large pages, despite such otherwise not being available to guests. Note
+ * that these large pages may be misaligned in PFN space (they'll obviously
+ * be aligned in MFN and virtual address spaces).
  * The kernel must also be able to handle the page table pages used for
  * this mapping not being accessible through the initial mapping.
  * (Only x86-64 supports this at present.)
@@ -185,9 +196,81 @@
  */
 #define XEN_ELFNOTE_PHYS32_ENTRY 18
 
+/*
+ * Physical loading constraints for PVH kernels
+ *
+ * The presence of this note indicates the kernel supports relocating itself.
+ *
+ * The note may include up to three 32bit values to place constraints on the
+ * guest physical loading addresses and alignment for a PVH kernel.  Values
+ * are read in the following order:
+ *  - a required start alignment (default 0x200000)
+ *  - a minimum address for the start of the image (default 0; see below)
+ *  - a maximum address for the last byte of the image (default 0xffffffff)
+ *
+ * When this note specifies an alignment value, it is used.  Otherwise the
+ * maximum p_align value from loadable ELF Program Headers is used, if it is
+ * greater than or equal to 4k (0x1000).  Otherwise, the default is used.
+ */
+#define XEN_ELFNOTE_PHYS32_RELOC 19
+
 /*
  * The number of the highest elfnote defined.
  */
-#define XEN_ELFNOTE_MAX XEN_ELFNOTE_PHYS32_ENTRY
+#define XEN_ELFNOTE_MAX XEN_ELFNOTE_PHYS32_RELOC
+
+/*
+ * System information exported through crash notes.
+ *
+ * The kexec / kdump code will create one XEN_ELFNOTE_CRASH_INFO
+ * note in case of a system crash. This note will contain various
+ * information about the system, see xen/include/xen/elfcore.h.
+ */
+#define XEN_ELFNOTE_CRASH_INFO 0x1000001
+
+/*
+ * System registers exported through crash notes.
+ *
+ * The kexec / kdump code will create one XEN_ELFNOTE_CRASH_REGS
+ * note per cpu in case of a system crash. This note is architecture
+ * specific and will contain registers not saved in the "CORE" note.
+ * See xen/include/xen/elfcore.h for more information.
+ */
+#define XEN_ELFNOTE_CRASH_REGS 0x1000002
+
+
+/*
+ * xen dump-core none note.
+ * xm dump-core code will create one XEN_ELFNOTE_DUMPCORE_NONE
+ * in its dump file to indicate that the file is xen dump-core
+ * file. This note doesn't have any other information.
+ * See tools/libxc/xc_core.h for more information.
+ */
+#define XEN_ELFNOTE_DUMPCORE_NONE               0x2000000
+
+/*
+ * xen dump-core header note.
+ * xm dump-core code will create one XEN_ELFNOTE_DUMPCORE_HEADER
+ * in its dump file.
+ * See tools/libxc/xc_core.h for more information.
+ */
+#define XEN_ELFNOTE_DUMPCORE_HEADER             0x2000001
+
+/*
+ * xen dump-core xen version note.
+ * xm dump-core code will create one XEN_ELFNOTE_DUMPCORE_XEN_VERSION
+ * in its dump file. It contains the xen version obtained via the
+ * XENVER hypercall.
+ * See tools/libxc/xc_core.h for more information.
+ */
+#define XEN_ELFNOTE_DUMPCORE_XEN_VERSION        0x2000002
+
+/*
+ * xen dump-core format version note.
+ * xm dump-core code will create one XEN_ELFNOTE_DUMPCORE_FORMAT_VERSION
+ * in its dump file. It contains a format version identifier.
+ * See tools/libxc/xc_core.h for more information.
+ */
+#define XEN_ELFNOTE_DUMPCORE_FORMAT_VERSION     0x2000003
 
 #endif /* __XEN_PUBLIC_ELFNOTE_H__ */
-- 
2.44.0


