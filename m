Return-Path: <linux-kernel+bounces-118095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0037288B3FB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA8CE2E6B6B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1B47580C;
	Mon, 25 Mar 2024 22:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z9IciR6v"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1FB1CAA5
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 22:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405611; cv=fail; b=lKaGGQBxAFo4eAdKxtpGz9b4r28OXhL44/EP9fH0doZznVoRb2QOTVMzEZYuvAUBbwTu5IzOyvIHU3EohWfSAGe1BYFwCBJNJsODQuLx6qSUsOvB6RQMGw6WQjQ1ZFop79+gH/aNMj44L53s27/dgb+gWWtD8KZXoX8RDmD5cmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405611; c=relaxed/simple;
	bh=gT3KbXnjtX6ITV55IP9e4dR8Qg9BldwPnw0WKc7ijd0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QRZS36vT+Vw6X4INtz+gWFqU/ToI94Hnqy/zne5ZaQLS29byhTiKxzWCFSUERVQSnRTAS9PeBoi/W4kc4vxT3irk6mGeQD63cE0tXCY2mCeJ8KTgcp6PtrFWvDPFNonga9plMYMCHEZyjrE1SUY6rzTngmeaQm3McwCRxPoJtaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z9IciR6v; arc=fail smtp.client-ip=40.107.93.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvyOZazuqxIKZ5Po0WkKgWntvWZ/8kvScRJgF24u0oCQCTYwdj1GK9ern+3SEVclpsDxKZCticD2IW7z/5CdNcMIKMSbPGyKj/Z6FuKtYVwNMJTHDXJQFTftiFOkL61F3bkULnp7N4kpkQsbRgWPDqJWfTCj3T+qYRdPOP81XC8LYPJk+XKErhwfyQdeQBGH8Yvatp9ddQAuVR8iWtsQ0m6Jnl4yuPWA+FGp0aFTZTBx77SMmeCiSE6aFsZRxLiKIcvuglIklLZUPYPNz3hc+vI89lHPCMxQMbX6miMBql6pD1QLIq/nKQ2xm/ZrKyD4Dl7QYEi6kRhogfRlW04s3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwWIXREHGcY1lXHm7F6cXK5K+IHL6Jp+VSHGKCm0Lw0=;
 b=U3XTPbE+WB3d0X86ssrPrGLGDENwGaJScuRm8WjrbVC1GxM/K4CHQ/WFIKzV5AM7ltrWb0FAhUoI8DH/QkGYzu5n8PYggW86g4RiEx/NCgWStDtTVGCaxN3llGbKtY4765+4/H7SB6kyZuRcVzn2ytIKoLsy0cCwQmZ6qKfoueXMKhiWtElAnAftJNrcbOGcaEG+ZDrEomXqu5U8jfBqBHopsG4rQOVJUIOIAZRNRvMBaTkKKloKItuIf2kb1DrhuIV8HeRbQWfG9Ugk6qhuNs155w/Jayq1re+P+aoxdTPSqvChfR9A26UaMcDZrWzU8/Vl4EuwxDS5xdBbGSndFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwWIXREHGcY1lXHm7F6cXK5K+IHL6Jp+VSHGKCm0Lw0=;
 b=z9IciR6vtTLW3kabTygOE20VKAwwFP3wnq/90+zMtHCnIP2JQVH8eWgGPs9wT9YgugVra3HMRd4ItpjNf1UYi8qRms6wz0h0BfYPToEiSvowGpft7QBuqw30+4/ymtdIlea7VZAj2Yr7iM1LE5hRbIusluYQ+rTLKBWIb8c9ra0=
Received: from SJ0PR05CA0110.namprd05.prod.outlook.com (2603:10b6:a03:334::25)
 by DM4PR12MB6448.namprd12.prod.outlook.com (2603:10b6:8:8a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.32; Mon, 25 Mar 2024 22:26:44 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::12) by SJ0PR05CA0110.outlook.office365.com
 (2603:10b6:a03:334::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11 via Frontend
 Transport; Mon, 25 Mar 2024 22:26:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 22:26:44 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 17:26:43 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 00/14] Provide SEV-SNP support for running under an SVSM
Date: Mon, 25 Mar 2024 17:26:19 -0500
Message-ID: <cover.1711405593.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|DM4PR12MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: ba27d5fc-a017-40c8-9bbd-08dc4d1aa6e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sGHoXJBS8GUvxX86eKVt+x7kb1ViT14qdwGvMfWqBYaLPdlB0TX8AnFWtOkDmaOGVihZCCk3OJ+4Ma+OqGpZWOU3Ub0zpjl0nvRuB6MRzTMLL95M/hnunTXmgS4HZ1ec8tXfjKa/twsUoEBNPgLmkPjxnfQGbsjV7mIoWeZIbN2cOvrnnHiiciEO6Y8tfHId5gN9KW9xYdbQ4IBPwSatAxG/Da7x3//g9MMb0eEv2uEXob9iozi1cP4vKuI/bFPTtBSHcFQuK5pt/9XzcMDSRpScJOOUBxgQb7rtgLJCYBwHehfB+7asRijo7zPwV4REPsOYKCgvUW6hciEHXhISnEzfbVEyxBeoC8GV3I7aylZ6OnwsL3edh7qs6STzpiTEVNiyAR4fFv+dIBl+B3Q0Ds0kbA192u1nZ0owei4Qplg07tWtgaAtJlcE/4slc03IOgyOVUwdGXxmqZYjiS1bGNjRjbdfAVDX9bVLhDZcg85hSdTdf/sfPFwDrJspN3peDHW5T4IhABL9VqiIwocZVhDa0l8WJwH3vZUhXJ/JjdrG81/iDPAS8tEcRLOMaY/puvglFT0J2aHHn6+9w/hYqwpUxQfzK0LkjY7aAxkDdq8VlF7utBRwWLP2cWNdvRFTxZ0mfKsemslCGovJpCZmFGM6LEr/VFkrEILJ3qhU3BbOqpiSbNP255mmzLg16fJ6/fKRlO8C9/xOsXxnSE5HTQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 22:26:44.3177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba27d5fc-a017-40c8-9bbd-08dc4d1aa6e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6448

This series adds SEV-SNP support for running Linux under an Secure VM
Service Module (SVSM) at a less privileged VM Privilege Level (VMPL).
By running at a less priviledged VMPL, the SVSM can be used to provide
services, e.g. a virtual TPM, for Linux within the SEV-SNP confidential
VM (CVM) rather than trust such services from the hypervisor.

Currently, a Linux guest expects to run at the highest VMPL, VMPL0, and
there are certain SNP related operations that require that VMPL level.
Specifically, the PVALIDATE instruction and the RMPADJUST instruction
when setting the VMSA attribute of a page (used when starting APs).

If Linux is to run at a less privileged VMPL, e.g. VMPL2, then it must
use an SVSM (which is running at VMPL0) to perform the operations that
it is no longer able to perform.

How Linux interacts with and uses the SVSM is documented in the SVSM
specification [1] and the GHCB specification [2].

This series introduces support to run Linux under an SVSM. It consists
of:
  - Detecting the presence of an SVSM
  - When not running at VMPL0, invoking the SVSM for page validation and
    VMSA page creation/deletion
  - Adding a sysfs entry that specifies the Linux VMPL
  - Modifying the sev-guest driver to use the VMPCK key associated with
    the Linux VMPL
  - Expanding the config-fs TSM support to request attestation reports
    from the SVSM
  - Detecting and allowing Linux to run in a VMPL other than 0 when an
    SVSM is present

The series is based off of and tested against the tip tree:
  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master

  4e2b6e891aae ("Merge branch into tip/master: 'x86/shstk'")

[1] https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
[2] https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/56421.pdf

Cc: Joel Becker <jlbec@evilplan.org>
Cc: Christoph Hellwig <hch@lst.de>

---

Changes in v3:
- Rename decompresor snp_setup() to early_snp_setup() to better indicate
  when it is called.
- Rename the "svsm" config-fs attribute into the more generic
  "service_provider" attribute that takes a name as input.
- Change config-fs visibility function to be a simple bool return type
  instead of returning the mode.
- Switch to using new RIP_REL_REF() macro and __head notation where
  appropriate.

Changes in v2:
- Define X86_FEATURE_SVSM_PRESENT and set the bit in the CPUID table,
  removing the need to set the CPUID bit in the #VC handler.
- Rename the TSM service_version attribute to service_manifest_version.
- Add support to config-fs to hide attributes and hide the SVSM attributes
  when an SVSM is not present.


Tom Lendacky (14):
  x86/sev: Rename snp_init() in the boot/compressed/sev.c file
  x86/sev: Make the VMPL0 checking function more generic
  x86/sev: Check for the presence of an SVSM in the SNP Secrets page
  x86/sev: Use kernel provided SVSM Calling Areas
  x86/sev: Perform PVALIDATE using the SVSM when not at VMPL0
  x86/sev: Use the SVSM to create a vCPU when not in VMPL0
  x86/sev: Provide SVSM discovery support
  x86/sev: Provide guest VMPL level to userspace
  virt: sev-guest: Choose the VMPCK key based on executing VMPL
  configfs-tsm: Allow the privlevel_floor attribute to be updated
  x86/sev: Extend the config-fs attestation support for an SVSM
  fs/configfs: Add a callback to determine attribute visibility
  x86/sev: Hide SVSM attestation entries if not running under an SVSM
  x86/sev: Allow non-VMPL0 execution when an SVSM is present

 Documentation/ABI/testing/configfs-tsm  |  69 ++++
 arch/x86/boot/compressed/sev.c          | 256 ++++++++------
 arch/x86/coco/core.c                    |   4 +
 arch/x86/include/asm/cpufeatures.h      |   1 +
 arch/x86/include/asm/msr-index.h        |   2 +
 arch/x86/include/asm/sev-common.h       |  18 +
 arch/x86/include/asm/sev.h              | 114 ++++++-
 arch/x86/include/uapi/asm/svm.h         |   1 +
 arch/x86/kernel/sev-shared.c            | 345 ++++++++++++++++++-
 arch/x86/kernel/sev.c                   | 424 +++++++++++++++++++++---
 arch/x86/mm/mem_encrypt_amd.c           |   8 +-
 drivers/virt/coco/sev-guest/sev-guest.c | 166 +++++++++-
 drivers/virt/coco/tsm.c                 |  99 +++++-
 fs/configfs/file.c                      |   7 +
 include/linux/cc_platform.h             |   8 +
 include/linux/configfs.h                | 111 +++++--
 include/linux/tsm.h                     |  13 +-
 17 files changed, 1442 insertions(+), 204 deletions(-)

-- 
2.43.2


