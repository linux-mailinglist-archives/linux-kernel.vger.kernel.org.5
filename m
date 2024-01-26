Return-Path: <linux-kernel+bounces-40737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 463E683E502
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B67B0B24A79
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1038925638;
	Fri, 26 Jan 2024 22:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4k8I4DCD"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9092557A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307376; cv=fail; b=q9fZ+F9gb5G4VvWs+Z0sb5L5+l9ueRAwswfYZxPoFL9AbdvtAznvbDXFqFq8FvoxoWaQy+HdNLN846KsS4sNlO21PsADFmSM1WYD8Dt3Mzwjiqe0FSPfcADSoM6C4tUIPllEpogfI9QsV4ZGLE5JYxFmTbCdxOOJZqUPrxvDVWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307376; c=relaxed/simple;
	bh=SX528BthTji01s/dRAEuWglPZlCgXGWeBySGXad3Fek=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CC6JvzKQKcSBmFdn+9sui1bwJoz287uYnX8gUVbwif3flVqqRs4zAxGjQVA9lm6U39QoKpKHTUvyCeTUOEH1gKcVeUfRjLtVj4OREscXHp5Nr+MX7rXadcZo8RhPjEakv8RGWBgjkLqfW/QoPKmJbo9mFN1+E1aVqH6I7JtzCNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4k8I4DCD; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNCLemZwHm7m2ZVt/2FyMVbv4WBZql54Li+/YJ8Ov5O9U6tJkvRxAqRcespoGUDyRO/w5T0KuwwbF726nMI6ZrD8HoOYkL6+utwkX6nUgA83qA2CLcW9jhNX+VBzYzcmtwTjpVbeI+wjgSsqdW+aceizzC8p9r9kZ01enYhZtl7IMYpJVsE7m/aozGwtJ2y5SUg9ZJ1JKUq6kISAfzUlb2gM/xQE7nwiRRtGKIDjReX2rttmHI/zyS7k5qmg3N05704Rg28D/0TmJD5GQ/c1AHpQzoHlMPQIjnrTXmJJXnwM5X8OXMr7xi3LFlUMNWbtvNKoyGNKjXG90rJbV42h/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OV53yi0+S4NN4BwMrjiXLSQ5YsHz5UYSGgsTq38s4fQ=;
 b=e5cXQWl+nlCD60K85wif6KLWAnIL3ecfXV/c9N0/iOgxKS72ispNeSFsXfXanzxVbgOlwfe6jsvRj+TFTc6Bht85A+uNUF5dvxTpa9rkMBKaJh/YzMH1zpPJxR+E9CRY3hs/IXzM5cyr550qvVdVO6Q1gtOfCCtOzLiEWr9RdZHX3qU90nKG61O5jbUvBw79ovof7MgvEJ7/99513g/WfDVl1x0agUFwMVkOf3foh4g4wNh52F+VmLOe6G0cGPrEgs+SZcn2EwnyxG5nZGF6AuYVwQ5oWBrFpS0sY/SXQIfj4CY2EmuW7g063x+RdMy2nUtr5nySXKgLQgW0Mgw+Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OV53yi0+S4NN4BwMrjiXLSQ5YsHz5UYSGgsTq38s4fQ=;
 b=4k8I4DCDJyma2tIS0wVV9Umf40dpBBJMwAFfkwVFRc9q4eSNarBEsgf/cwuRowkVrEl8JG2y63jm1WaCnRNiJNbgqwDbBKEh571qCSKgdCTHFUbz5Ar6YNoE+6SzKPHjwKJ2GMqAZ/WLph0mjLVmRs2AORIMYxwf136cAV0tNkE=
Received: from SJ0PR13CA0002.namprd13.prod.outlook.com (2603:10b6:a03:2c0::7)
 by PH7PR12MB9202.namprd12.prod.outlook.com (2603:10b6:510:2ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 22:16:12 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::3) by SJ0PR13CA0002.outlook.office365.com
 (2603:10b6:a03:2c0::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.21 via Frontend
 Transport; Fri, 26 Jan 2024 22:16:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Fri, 26 Jan 2024 22:16:11 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 26 Jan 2024 16:16:10 -0600
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH 00/11] Provide SEV-SNP support for running under an SVSM
Date: Fri, 26 Jan 2024 16:15:53 -0600
Message-ID: <cover.1706307364.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.42.0
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|PH7PR12MB9202:EE_
X-MS-Office365-Filtering-Correlation-Id: c79c0a0f-fbdb-407e-6afe-08dc1ebc676d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oH717JBN0rbZKPh3VNZ/L9ofMbMfTtLgOWTpofl6Eix2iVP7jh9t5H8x4eGsUomoqtTBpWFgxsntML/vP/kmkPvhNk18WJbPRBTk10OupropeMVwvPpAvZxsi8RrE4DuGP6kEIeRT+RMZJBgsIeO9HcI/yvO1aEK8pd4b1YEBJ2kHGVf+zI2kK+JQVPkY8hxmwQelEumj7bLGH92+xv4Q0/1WkHMhoU5XvaxET7uiQS+8bEvQD3vPBDaOpJBDz8BLW2vm5t+gefx+P97/9+MXSiOSdKVLnQBhmOrj+G3rZmkBO8cnk+J2VBNTHQ36je1x2uOrvwYg0c4Uy2ZnYDRkNoj0/YFU1pqWrpwW5gkVTccvdFBK8ze8TWdkxhzMuu14v+Yy4W5p0Zcw0FagKqAaYr/CRdaMzq60Rngwb92esSnRUaSlQB3obVWaaUsji2X3eSWiF80t1YLfyZvbBkAs1kIFxg1qoYXe6mpTFazIFSmZzI9U+p7eTj1e+CYoIAiwSaLsUFngBW7t1PIO74/uX0cEVQB1WLuUy3ICQczetPV/40zuJ/2YZCQBknBktiJYe+4iqibvjOEBie+D4mOp+yX3q7pqK2IzWLVWifh5TCXtkIE6p5J8yMHObxmiFtfdXKP2khguHlmZK47WKKX9ilPtDapyYIUsD1TyJygsm33bzmcgtC3j3OqoIPrl1Om1/tmMMeZjyOFjqovcWXGWQaf7jGQYEbH4smH3CZBncs3DSsCwasqPF/8rywNP3fNdaMNIBKpN6DrNV6t6IGNSA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(186009)(82310400011)(1800799012)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(2906002)(86362001)(41300700001)(36756003)(356005)(83380400001)(70586007)(316002)(70206006)(54906003)(40480700001)(110136005)(40460700003)(5660300002)(81166007)(6666004)(2616005)(36860700001)(7416002)(478600001)(966005)(426003)(336012)(82740400003)(16526019)(26005)(8936002)(8676002)(4326008)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 22:16:11.6583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c79c0a0f-fbdb-407e-6afe-08dc1ebc676d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9202

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

  b0c57a7002b0 ("Merge branch into tip/master: 'x86/cpu'")

[1] https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
[2] https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/56421.pdf

---

Tom Lendacky (11):
  x86/sev: Rename snp_init() in the boot/compressed/sev.c file
  x86/sev: Make the VMPL0 checking function more generic
  x86/sev: Check for the presence of an SVSM in the SNP Secrets page
  x86/sev: Use kernel provided SVSM Calling Areas
  x86/sev: Perform PVALIDATE using the SVSM when not at VMPL0
  x86/sev: Use the SVSM to create a vCPU when not in VMPL0
  x86/sev: Provide SVSM discovery support
  x86/sev: Provide guest VMPL level to userspace
  virt: sev-guest: Choose the VMPCK key based on executing VMPL
  x86/sev: Extend the config-fs attestation support for an SVSM
  x86/sev: Allow non-VMPL0 execution when an SVSM is present

 Documentation/ABI/testing/configfs-tsm  |  55 +++
 arch/x86/boot/compressed/sev.c          | 253 ++++++++------
 arch/x86/include/asm/msr-index.h        |   2 +
 arch/x86/include/asm/sev-common.h       |  18 +
 arch/x86/include/asm/sev.h              | 114 ++++++-
 arch/x86/include/uapi/asm/svm.h         |   1 +
 arch/x86/kernel/sev-shared.c            | 338 ++++++++++++++++++-
 arch/x86/kernel/sev.c                   | 426 +++++++++++++++++++++---
 arch/x86/mm/mem_encrypt_amd.c           |   8 +-
 drivers/virt/coco/sev-guest/sev-guest.c | 147 +++++++-
 drivers/virt/coco/tsm.c                 |  95 +++++-
 include/linux/tsm.h                     |  11 +
 12 files changed, 1300 insertions(+), 168 deletions(-)

-- 
2.42.0


