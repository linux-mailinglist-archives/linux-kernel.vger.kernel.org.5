Return-Path: <linux-kernel+bounces-157269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FB08B0F58
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB83FB231DC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324B71607A2;
	Wed, 24 Apr 2024 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qk37VZM+"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B469015F406
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974315; cv=fail; b=rjYJD3pa8CbiC5p5JffAa4OZfv5nj40gBdXhwIXceoV+fScgjTflYxGE0Kx4WbTs+jbEVO81vfqA/zZsZ0dEIhxAs9oWRkUa1SjEdiSezEBKb/ADLG1VfEmKh701X0RKWbr6TYOGz/DamdML0g2Q1dHW/Os207ZmVnVswDWz1B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974315; c=relaxed/simple;
	bh=0skJtVuYgHwMivIdtqu2BTMhvuAH7Z4EE7+0vh1Iibs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I2c4KtGMySO5BI8qgFKlS408WwEqkUJEJJZBQhf/fTXuL/Vn1dTkbnJ3xanGKrfgJfbPgMU0EH+s0g3r+NRUWQd/jXtFDVq/jHDUcvzFR7uNpqmQmnsXjzjrfLf+/Sw8w4yiK/LcXY5GCPE0RKGhmJ9O9BGzfU3HQatnV1DpvM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qk37VZM+; arc=fail smtp.client-ip=40.107.223.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9MeKe4Lsh6yq4OS2j6Tgj7gPv3p+2gvntJQwqNUY9q3FbD6xTpJkgZ46AETAg7u+wBlEG6Nk546GAMIufJqsHZoEhselWaYtoDO7e9DO1M4q4KAhJrCbgnWyl7+3QNoDw/n6JyIX7ePA4YR0PoKk28EUJjIo31AWCV46OFkod0jXZfz7lDaH5PBqqwIiL18QGs1T2a/NFd0FoHxw+Uvd0+jaVB1cBLfCrTm+nHN7y6yCTlyAdWFtAS21V9p9hbnR6l25u3XmdSfKpJRpeMnQ8UZHT0fY43LDugrHEvlpyBk/CUD4G+1nf+QvBFervb5iQNCfZXf42h/lGvMYbt4/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3+IC27TH5ORa8Zf4SF9NM2mgUInEyfUneTApO+k518=;
 b=PRBWk5rOtiOCnEh8Tr1w5LRKQFVviM8E5+weJHhoETx8T5KRhyYvfArFhxFhRbh/nHoC2nKzKGZz5TuYRjdNcZd2DSpLfUMYxCXftDdFY98cwCO48rQhyOjsQctv68TbPdx4sPgBETKJGZ+ZwzGouvz8EokGICplxrGRRElFMDynMXoOx82XUo4WZu29gjCAzaj8pN/nBf3HHyc7oJ0iGji9hIZhA8MZNCilGEUyaSljtgduCkBfAW1xnXnHvngvVcBR4Xbpw4bpmP8fYZkQdC6Hsa/YwoY5TcwxbePA9Vx+2zphwo5sBL9hwzsAj11TJrIPO/NPFa7FuL1ziQcysA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3+IC27TH5ORa8Zf4SF9NM2mgUInEyfUneTApO+k518=;
 b=qk37VZM+gPXSi94cGTeyiEnZctibyLRqPdSUDZFIurRys6JI2XVa9HhMpGKv1OHLEV1SnYQTrWRoXICdxMjYlHO0gfoqV2SkojSm4Mz5tu3MSu6vmiCVR5BwunfVMUs3mBGRypD1AjJjNP+YHsXUlJvyo5Vz+3Z1MNsWWOC9fSY=
Received: from PH7PR17CA0006.namprd17.prod.outlook.com (2603:10b6:510:324::28)
 by SA3PR12MB9091.namprd12.prod.outlook.com (2603:10b6:806:395::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 15:58:30 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:510:324:cafe::74) by PH7PR17CA0006.outlook.office365.com
 (2603:10b6:510:324::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23 via Frontend
 Transport; Wed, 24 Apr 2024 15:58:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 15:58:26 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 10:58:25 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 00/15] Provide SEV-SNP support for running under an SVSM
Date: Wed, 24 Apr 2024 10:57:56 -0500
Message-ID: <cover.1713974291.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|SA3PR12MB9091:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eda441f-2c62-4fed-5534-08dc647760aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tb1g+qhlz00S4ThQXHNv8nTYcz9BjzA34BzyYkc4h/NN2VUq3cOOi70qqj2M?=
 =?us-ascii?Q?IDeuNUBruK5uBMYb1QKYpGem/nhbGeSvDpffLY5G1N1uVUDj3Pmrr/19tQlp?=
 =?us-ascii?Q?Fe3JtvTv8UQY486Qg6m3pxBhUlfhq+JmXAXo630bPhV0wWgoOXDDKo+rFgUx?=
 =?us-ascii?Q?j0dL+VzPdDGxzJh8gKSx7wzyeHmbKZvqJm+eldJJD7vv5Qf/IP8Otjd9S9dX?=
 =?us-ascii?Q?fVTYXAP8S+ZOrv10cHCishTjb8q9p+uFa1aCUN1xuXmn8VdfQWsH3WH0pkTT?=
 =?us-ascii?Q?LVxgm8jIf/bKJ8/R0qCj/pufQ0XdS9UjmwAImVRdm0rWPNXR8nNeHgHidCBL?=
 =?us-ascii?Q?ZF/ikQuHtHJZsg9wH4XzkCN2xhVTa53CYoTpdCAyoEkoPCIqfSvYiyMBm8Np?=
 =?us-ascii?Q?uBOQ+I3a8zqFXkEPIEDo4qgtc4A8aevbOE6prZETkF6/PvUfK4/0lIyPSUHs?=
 =?us-ascii?Q?3ha1E/Xg+JTD7VcD6/kaUvcsq/3mS8r6H6HJWfQ/lKEc7B4ZLMlSqsFK6Kn9?=
 =?us-ascii?Q?TOHDSM+9dZSck5CDRlEWmG/T4cx/iI9BqzWrCWiWYCC4E8ndW5rTaE/A5FhK?=
 =?us-ascii?Q?1KX01oeQsu3NLZJnmRQNyd/e14by+q7zrnYE2bmZNhEKnkypzrIzf1IkWfq3?=
 =?us-ascii?Q?sWRNSA4YGTZjt5jFZOMfKrTOa97nenTy17gOsyDQAEgT2akeneXzGN7nNzqJ?=
 =?us-ascii?Q?8J+XRZaLtZQQFypdDrMgF+xg/yWsGiXYl2VDL9BaD54GKpFDgELlS01bVwvw?=
 =?us-ascii?Q?gEU7AC8R3PkXLnQ7Zd9zR6bxj4HCzGvUoHgS/lI3qZC9wWgYvyEpdjU+77J8?=
 =?us-ascii?Q?gy/4NvBg1zpmy9ZsWROPxksiY7a3GZyMBQyT6Akb3UcEj4TYuiyJclXJ1b5w?=
 =?us-ascii?Q?yQKNaA31JRUD8CEg07CoQ0eIUN4mhelKTR8rVdEsd6OD6O5l+0ljDZawacOM?=
 =?us-ascii?Q?hJeZFHrnkvXLG0xKPTh+rgkRq8nS+Z05AYoPlce0Mv8RMpNPhth0HpV7Z7jS?=
 =?us-ascii?Q?xgR9g/kTeBpGIn8BX+bFYYQnvHX6zqdHeI2KqSLRmnR/G01NiT0AFzRYWEmI?=
 =?us-ascii?Q?Qt66jPMMQ9lLOtSXnwLWWjnBQq+ooOQAoxlCvEnOH6CRqWsT7FfdleG5DUjZ?=
 =?us-ascii?Q?PSrUX2cjRNsuN2XAVOq13MxSX3MhRrn/4mYPC41MLARKtVjP+FtJm0d/VRzD?=
 =?us-ascii?Q?jPgbavsCssoep1RW5kniU3H1xZc9rDLfWQeHtVbtrk7OUiOyaMlceg7Y1bjO?=
 =?us-ascii?Q?f4uMxeBBOa4c53ViuVHkwxLX89/8Q+2vXFxziO8/3LaWATcSEZBvtn/mxjQx?=
 =?us-ascii?Q?BFvWtgULDC1VwVCffFEzY1dhFsD0UQJWTrVaykvx+qQjXbU6JuEpoA5EBWqH?=
 =?us-ascii?Q?x/ydz37nnZvKtOStYsG7kkarLHOp?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:58:26.4344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eda441f-2c62-4fed-5534-08dc647760aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9091

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
    from the SVSM and allowing attributes to be hidden
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

Changes in v4:
- Add a pre-patch to rename the struct snp_secrets_page_layout to just
  snp_secrets_page.
- Move the config-fs visibility support to be group based and referenced
  by an index. Remove the macro changes that set the visibility function
  for an entry.
- Make the TSM visibility support vendor specific via an ops callback.
- Use the rmpadjust() function directly and remove the enforce_vmpl0()
  function.
- Consolidate common variables into arch/x86/kernel/sev-shared.c.

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


Tom Lendacky (15):
  x86/sev: Shorten snp_secrets_page_layout to snp_secrets_page
  x86/sev: Rename snp_init() in the boot/compressed/sev.c file
  x86/sev: Make the VMPL0 checking more straight forward
  x86/sev: Check for the presence of an SVSM in the SNP Secrets page
  x86/sev: Use kernel provided SVSM Calling Areas
  x86/sev: Perform PVALIDATE using the SVSM when not at VMPL0
  x86/sev: Use the SVSM to create a vCPU when not in VMPL0
  x86/sev: Provide SVSM discovery support
  x86/sev: Provide guest VMPL level to userspace
  virt: sev-guest: Choose the VMPCK key based on executing VMPL
  configfs-tsm: Allow the privlevel_floor attribute to be updated
  fs/configfs: Add a callback to determine attribute visibility
  x86/sev: Take advantage of configfs visibility support in TSM
  x86/sev: Extend the config-fs attestation support for an SVSM
  x86/sev: Allow non-VMPL0 execution when an SVSM is present

 Documentation/ABI/testing/configfs-tsm        |  63 +++
 .../arch/x86/amd-memory-encryption.rst        |  22 +
 arch/x86/boot/compressed/sev.c                | 258 ++++++-----
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/msr-index.h              |   2 +
 arch/x86/include/asm/sev-common.h             |  18 +
 arch/x86/include/asm/sev.h                    | 116 ++++-
 arch/x86/include/uapi/asm/svm.h               |   1 +
 arch/x86/kernel/sev-shared.c                  | 354 ++++++++++++++-
 arch/x86/kernel/sev.c                         | 421 +++++++++++++++---
 arch/x86/mm/mem_encrypt_amd.c                 |   8 +-
 drivers/virt/coco/sev-guest/sev-guest.c       | 210 ++++++++-
 drivers/virt/coco/tdx-guest/tdx-guest.c       |  29 +-
 drivers/virt/coco/tsm.c                       | 173 +++++--
 fs/configfs/dir.c                             |  20 +
 include/linux/configfs.h                      |   3 +
 include/linux/tsm.h                           |  62 ++-
 17 files changed, 1533 insertions(+), 228 deletions(-)

-- 
2.43.2


