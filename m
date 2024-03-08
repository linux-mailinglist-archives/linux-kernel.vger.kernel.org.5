Return-Path: <linux-kernel+bounces-97458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F889876AC4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E2C282E56
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4057421A1C;
	Fri,  8 Mar 2024 18:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NZ831C9c"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321A07FF
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 18:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709922952; cv=fail; b=aRYWW4NW/K111ZTyjTmHhn5CcHFmoFNX/FD0UPdnpOe+Y4ooyzt+Jyr6ILBAY3BHwpXlIKUF639oeUumpAkwLZtbDQjXklESq0edU9MDVGr7GQnx2Jf2jCeUYHRzvQOky3slFVnH9jhibNJAc8vlucdV7fcu8VEJt9oWmBvrhSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709922952; c=relaxed/simple;
	bh=KErg1nbXzRZN+BzZJT6qWt3DKapT8pfWngWbQ2tVH1c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jFSrFJ6nNYNH/EJcutY5nR5LUCpLFgh7a+21+ohta+xkNJ7yUEsjBKYLkC1nOJIcmumT9DSwEpeF8Ot4XbGtXcqGGSOkFbUkpKH6rMXmEDB21py5zN4TwvNZUuxbjh5ZNhu864DkRr6MABnvXkc5bdZ0ZCyHn4Fw29CkyKPzhQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NZ831C9c; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aio0cFxLcs+tSMmXaYdOl5QcIKO0c33HR5WCCiCarcDUI5XHLmgnLJqMzjli7Yer9QlxWzuVjLIMKTb9IrbjoDpGl7Inlk89mk88CMCs3XwLZCH02ib7vu3Q86JVc+i0b83sqy0VEseCckp9R2NrpZRg7KgRnV+8Fdc/YTocduwu/5ov19/hoED1RGyW7vcx0woTkjSkyplFGEK+yPlhKYdORCegEFTlgubR0TEUD4dZpMB49HV7f97AQetQM2Gom4HjdCuwZPzW2qYPkMC1xr+jhxiLMeJxWcrX3XhWbuvYHx7aSv5n75FsEXaXXikWy2BVUdWG7OYNhy7EGsuMpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1rM+z3f/Zrmk74x7ry/utOL+2QSiN3aLkB42Xeg7gk=;
 b=Ix9iEJyoTFEoK/bsosFGYfq/mTBWPHur3ndaARCQNBfcnyezsO21cvKOVzYxIW0yY6WKbbynuipZQckEVcuHSmGGjC1Ph1brXCxMWqLkkhtMe5Q8YP3670FkLzEAiOyhn/0cm0WwPQQTiQjADAycddh1jRxM4zS9tIhb20+7NVX5lVdMM8GRD+QAB9JkdYHsrMI0bTozh1hQ5B4vDoh3/xzqS/rBtjTa+Ir2SwQCYPBsKPisea71YKxGbXQ7dhAmwTPxYY1eK/HfECWnsmqi0hCa/TESR52QCpx7KObID7xvtJDQV5lHc3IMGEBdXaRhkh1YhImbw9rLFL/HMhe3WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1rM+z3f/Zrmk74x7ry/utOL+2QSiN3aLkB42Xeg7gk=;
 b=NZ831C9cYzksW3zNV2fmwSnxqVBmXlVb4D7UYWkf0RFLmvnZmHCD58yXcUM43Rf+0kZL/ly1kwKSmnXP+Gf0KkH4XdaNe/E5x6/WPSwks0PH4NqYTdKJLOMbIBCKMgOmZoZESlwvup4AU2BLC9BNLNZCG53TxKzwbk4t0oXoG/4=
Received: from BN9PR03CA0276.namprd03.prod.outlook.com (2603:10b6:408:f5::11)
 by DS0PR12MB9445.namprd12.prod.outlook.com (2603:10b6:8:1a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Fri, 8 Mar
 2024 18:35:47 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::1a) by BN9PR03CA0276.outlook.office365.com
 (2603:10b6:408:f5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29 via Frontend
 Transport; Fri, 8 Mar 2024 18:35:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 18:35:46 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 12:35:44 -0600
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 00/14] Provide SEV-SNP support for running under an SVSM
Date: Fri, 8 Mar 2024 12:35:15 -0600
Message-ID: <cover.1709922929.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|DS0PR12MB9445:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a5034cd-efa1-44fc-6231-08dc3f9e91aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RMP0kkKpRAKIEiQ5LLg3dMr6PHh4T/F/coK7xk3tinQgaI+O7eqdVxIeVxKYbCi/TiJeidmWMBTNfCkrD8FDUJhwia9SCQlFPMFl9tYsQEjG8YtcNhJYvxjzZKvJyVGMDZqTXagDq4DveT3ITY8TpCsLjL1DmLM6tvdmjTYpmDp0u5Vzi8VhbPpPFpubkJ+LvBxrjUHzyQnKhiFncY4yGsZnyo1RV21qDCB79wK3U7MzQM10YKaM1pxnkTvvRw9t2eTpQeeNxNcoFhDuqnPhYO8qXtnDyQAYKuClyTGnjIhOegRMnj4bFVfUC0S8hgkg47hjAk8wWP9J+3ZD6pcWxuysStDkRrX/fCouOVQpVmGQiv41wHBnu1qsh0Yy/9K9kJ/yet2C75HhWwOzjJ4Od8tOD/hkhcNbNwKFwHm5eM5QUY1BloUyugBQSiEnx2er3I5O3JZjhM/rAH74xUzuclYw4nrF2YItGQQTV6XvV74FuSDCM18NUFXNH3aKu2o3FoOkCtRO0lLWocSYPrsar5dmc/pUwNVojOiWF2c5miZp7lofELzXEy43YYnP4nhh7dgRXgFgO3yyhl0rAUUtBl7podjolkRPMhViJLaG9+1uWB5c/HEOm+yJ6SwBLHW+Iukr9UabA9+iGpH45cVVXQYJCXqmnQ5j8KqaEWryLmC3Nv162OVh+ceikXB0cqdLnvOCwfeXnwicRko1X+QHbg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 18:35:46.0700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a5034cd-efa1-44fc-6231-08dc3f9e91aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9445

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

  fdd513724225 ("Merge branch into tip/master: 'x86/tdx'")

[1] https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
[2] https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/56421.pdf

Cc: Joel Becker <jlbec@evilplan.org>
Cc: Christoph Hellwig <hch@lst.de>

---

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

 Documentation/ABI/testing/configfs-tsm  |  59 ++++
 arch/x86/boot/compressed/sev.c          | 256 ++++++++------
 arch/x86/coco/core.c                    |   4 +
 arch/x86/include/asm/cpufeatures.h      |   1 +
 arch/x86/include/asm/msr-index.h        |   2 +
 arch/x86/include/asm/sev-common.h       |  18 +
 arch/x86/include/asm/sev.h              | 114 ++++++-
 arch/x86/include/uapi/asm/svm.h         |   1 +
 arch/x86/kernel/sev-shared.c            | 345 ++++++++++++++++++-
 arch/x86/kernel/sev.c                   | 426 +++++++++++++++++++++---
 arch/x86/mm/mem_encrypt_amd.c           |   8 +-
 drivers/virt/coco/sev-guest/sev-guest.c | 162 ++++++++-
 drivers/virt/coco/tsm.c                 | 100 +++++-
 fs/configfs/file.c                      |  13 +
 include/linux/cc_platform.h             |   8 +
 include/linux/configfs.h                | 114 +++++--
 include/linux/tsm.h                     |  13 +-
 17 files changed, 1440 insertions(+), 204 deletions(-)

-- 
2.43.2


