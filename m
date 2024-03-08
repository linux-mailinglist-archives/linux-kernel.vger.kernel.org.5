Return-Path: <linux-kernel+bounces-97565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC4A876BF7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44A9928271F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1F75E076;
	Fri,  8 Mar 2024 20:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FvV1qjpw"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28E75D8E4
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 20:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709930673; cv=fail; b=NA4ki/XeEIj3cueAS9Aet1ENmR3IA7V5PIwEEamrEfFzU/ny5Oc6Pcoj69qqdUZ1ssBC2OvF+6OF9odPslGQikk1164Dm86Ew9NFk3iwnftmKUnxqVhyKciG3JKE2k3A20WzQspWlmQznLRz/x8r374LYpyy0yAvk5x/nz0gfso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709930673; c=relaxed/simple;
	bh=nHj2m2opRVNeAobmR6+nNo1715YA8MjKW/NbqLqtVp4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URhYk3yIt9V9Ai+OQLiKppsoh5/y5aEYdVeQ/le2tpmGrayYAOvoBKWEBxghPlXwTICemfPyE4DFK7xZKJynN/ONev2CWOe2XQuEOF6Got77baoLJ7FScS+pyMoKfIwV254ZucXEBRvc3a8f2JU/Y5yD+WEmNuAIF8X4VrKn/Wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FvV1qjpw; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdWbR566Ok7MrH3hfRg71g1m3LG5UyAvCyQllH6DTD2RDHdi1COz+YyXHLuLxjt4mkpYvnjG5AvyWrwRV2SDHMot1/kliQjCzUjquvUsLHiEzmOv25lW2CGqQVHvVsO1kzCnncH72S2KyvyR5thQvd+qgOQJVgsanOT+lHkZr1uDwU8x+eW4oceM80kwgfv3HMpa6FnioD/O4M0/VlyphKItwrgnYhTk8V7d6WV08Ihqk5gbL/5qBOV4TV2MN8MGpYusqCh0KPpPza8x82AhwnhZIWyg3aIwK4vIPufoGzNjWDgGFsWyqd1st46o+Yqnc2bySKIi8ZKdGS8TRgYvgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q84WiBnVX0m8ssi69zV4e5R2jL64rxMfG4WQOtCVjaE=;
 b=K3hn2jS3yYFykJuG+F9CGOOw4iEuWLr6YPcZHlXteOKNnid1jtPLOycRMDrO0FzqfKzFKvsn64CWUZoJfJxVMqDTpgBy0v1/1y3avTwUdEeqxcoOHRDrOvKDoq9edz56o+cTZHB7J9ow7OrCPkRu0fM4Rc9Lj+yqqO0f5AKbcSSfV5IxVHkbk1t6j5fA8sab7mTYb+1370pFpyEaN+allm2/l9zHlPpBDGjRjh10FsAPW4F/ykbzsz0GSeoXoYdtCha1BWwVOr24TV67PcxAsaCguW2unVHc2VWqkL4JmgvlKyzQ4G30AtIKnm43y8qgPja8UAvR219IQ+wb9poCAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q84WiBnVX0m8ssi69zV4e5R2jL64rxMfG4WQOtCVjaE=;
 b=FvV1qjpwgH5x7bdHhis2us3AUF1U/aqfOY516cpthSdMq0YxGD82lElrAdJx8mU2+i3D1CylnUqOZmPB58JJZNBxgNwAA0W13Npnho88TkoPfOuTPG4pS2mz4mDeSsw3hFNDCP7cIAPQQDn+P5FWUU03R3PPrDMToppfbsd177c=
Received: from MN2PR20CA0062.namprd20.prod.outlook.com (2603:10b6:208:235::31)
 by SA3PR12MB9157.namprd12.prod.outlook.com (2603:10b6:806:39a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Fri, 8 Mar
 2024 20:44:29 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:235:cafe::b4) by MN2PR20CA0062.outlook.office365.com
 (2603:10b6:208:235::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.31 via Frontend
 Transport; Fri, 8 Mar 2024 20:44:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Fri, 8 Mar 2024 20:44:28 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 8 Mar
 2024 14:44:28 -0600
Date: Fri, 8 Mar 2024 14:41:51 -0600
From: Michael Roth <michael.roth@amd.com>
To: Kevin Loughlin <kevinloughlin@google.com>
CC: Mike Stunes <mike.stunes@broadcom.com>, <acdunlap@google.com>,
	<alexander.shishkin@linux.intel.com>, <andrisaar@google.com>,
	<ardb@kernel.org>, <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>, "Brijesh
 Singh" <brijesh.singh@amd.com>, <dave.hansen@linux.intel.com>, "Dionna Amalie
 Glaze" <dionnaglaze@google.com>, <grobler@google.com>, <hpa@zytor.com>,
	<jacobhxu@google.com>, <jpoimboe@kernel.org>, "Huang, Kai"
	<kai.huang@intel.com>, <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
	<peterz@infradead.org>, Peter Gonda <pgonda@google.com>,
	<ross.lagerwall@citrix.com>, <sidtelang@google.com>, <tglx@linutronix.de>,
	Thomas Lendacky <thomas.lendacky@amd.com>, <x86@kernel.org>,
	<ytcoode@gmail.com>
Subject: Re: [PATCH v2] x86/kernel: skip ROM range scans and validation for
 SEV-SNP guests
Message-ID: <20240308204151.jny3hyo6nyjqk6qt@amd.com>
References: <CAGdbjmK9WoOQSbKUvcTdLJDW-RB=qe2tHFDZ-MeD266xZOxh7w@mail.gmail.com>
 <20240222202404.36206-1-kevinloughlin@google.com>
 <4463AFB9-58AC-4E65-BB04-EB2C9F2D9301@broadcom.com>
 <CAGdbjmJ+xiqycaDU9XMUEj2z70Adx-+ZCOiAFGXoNCojt_X=qA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGdbjmJ+xiqycaDU9XMUEj2z70Adx-+ZCOiAFGXoNCojt_X=qA@mail.gmail.com>
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|SA3PR12MB9157:EE_
X-MS-Office365-Filtering-Correlation-Id: baf3f7ea-1873-4445-9e77-08dc3fb08cda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xAuEeg0HJ6h/T27WaMFOliCRwyx9UntqqnD8i1uLPYVrg266xkEBYAPgrGu3a1Cu+rmHWTXGDMjX/In7IwgPptJQV0M0GioxDuTaeY+fxxtcRNMnzwdMZMP4sWA5QZ7ZhtqJvUc+huh5C3UthRJMiams5kiTt0lqGFuc4CQGg3p4yARY7zYznzVtnonxb10euuEIhrqaQ0xVOiuRqoy9dzn+tG30y7gj3aDdkO7y3XgDAOIIjCRDEUCmeGFwiL5l7wW8pTtmQFQOlFyrqQrzM6REK58dzn9Y0zrMUSYRlSymGiR5rdvr188qspkcHRzznI2wzpVxMoNQzJqTaBS5XZRYwWr0b7lPeLpVnDx/7s88DkjaxjnGva1PUv7e1oUNhg7kIAMdpU5kPVDjY9XqIwIvAlS23CG+YBa8lBmBCl/+6gemU4NZlN37WtWIe/ojXsuliptXUAaWCYbCKj2PPu7doNPECDEe0MPQcxwFyCjLQfPipIj+YrWg2QTh8nBtRRjBMI2aGWNkmS8/x3gpJVLDUUVfrJJR1F7tvnll545dveXbc70VO0mY8PzaePS4m8JZ7mhsBLClfwWPNXWe2Gj0W9M6MBWP3aJVShEOHszTINZBHoSEUeBLY4U0Xetm0vv3PZBK0Gp34MLfBnmu0YQRuEymy9wr3IikSz6zgNKa7hmSq3eXMyNpu2NQYCmeFNLhBgINrSu/t4vsQCIdVQ1ESEHkYyxMps+IdjRUXTYk24jrr++kvDzJBSnRkx2J
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(7416005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 20:44:28.9230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baf3f7ea-1873-4445-9e77-08dc3fb08cda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9157

On Fri, Mar 08, 2024 at 11:10:43AM -0500, Kevin Loughlin wrote:
> On Mon, Feb 26, 2024 at 2:16 PM Mike Stunes <mike.stunes@broadcom.com> wrote:
> >
> > Hi,
> >
> > > On Feb 22, 2024, at 12:24 PM, Kevin Loughlin <kevinloughlin@google.com> wrote:
> > >
> > > SEV-SNP requires encrypted memory to be validated before access.
> > > Because the ROM memory range is not part of the e820 table, it is not
> > > pre-validated by the BIOS. Therefore, if a SEV-SNP guest kernel wishes
> > > to access this range, the guest must first validate the range.
> > >
> > > The current SEV-SNP code does indeed scan the ROM range during early
> > > boot and thus attempts to validate the ROM range in probe_roms().
> > > However, this behavior is neither necessary nor sufficient.
> > >
> > > With regards to sufficiency, if EFI_CONFIG_TABLES are not enabled and
> > > CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK is set, the kernel will
> > > attempt to access the memory at SMBIOS_ENTRY_POINT_SCAN_START (which
> > > falls in the ROM range) prior to validation. The specific problematic
> > > call chain occurs during dmi_setup() -> dmi_scan_machine() and results
> > > in a crash during boot if SEV-SNP is enabled under these conditions.
> > >
> > > With regards to necessity, SEV-SNP guests currently read garbage (which
> > > changes across boots) from the ROM range, meaning these scans are
> > > unnecessary. The guest reads garbage because the legacy ROM range
> > > is unencrypted data but is accessed via an encrypted PMD during early
> > > boot (where the PMD is marked as encrypted due to potentially mapping
> > > actually-encrypted data in other PMD-contained ranges).
> > >
> > > While one solution would be to overhaul the early PMD mapping to treat
> > > the ROM region of the PMD as unencrypted, SEV-SNP guests do not rely on
> > > data from the legacy ROM region during early boot (nor can they
> > > currently, since the data would be garbage that changes across boots).
> > > As such, this patch opts for the simpler approach of skipping the ROM
> > > range scans (and the otherwise-necessary range validation) during
> > > SEV-SNP guest early boot.
> > >
> > > Ultimatly, the potential SEV-SNP guest crash due to lack of ROM range
> > > validation is avoided by simply not accessing the ROM range.
> > >
> > > Fixes: 9704c07bf9f7 ("x86/kernel: Validate ROM memory before accessing when SEV-SNP is active")
> > > Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
> > > ---
> > > arch/x86/include/asm/sev.h   |  2 --
> > > arch/x86/kernel/mpparse.c    |  7 +++++++
> > > arch/x86/kernel/probe_roms.c | 11 ++++-------
> > > arch/x86/kernel/sev.c        | 15 ---------------
> > > drivers/firmware/dmi_scan.c  |  7 ++++++-
> > > 5 files changed, 17 insertions(+), 25 deletions(-)
> > >
> > > diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> > > index 5b4a1ce3d368..474c24ba0f6f 100644
> > > --- a/arch/x86/include/asm/sev.h
> > > +++ b/arch/x86/include/asm/sev.h
> > > @@ -203,7 +203,6 @@ void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
> > > unsigned long npages);
> > > void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
> > > unsigned long npages);
> > > -void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op);
> > > void snp_set_memory_shared(unsigned long vaddr, unsigned long npages);
> > > void snp_set_memory_private(unsigned long vaddr, unsigned long npages);
> > > void snp_set_wakeup_secondary_cpu(void);
> > > @@ -227,7 +226,6 @@ static inline void __init
> > > early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr, unsigned long npages) { }
> > > static inline void __init
> > > early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr, unsigned long npages) { }
> > > -static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op) { }
> > > static inline void snp_set_memory_shared(unsigned long vaddr, unsigned long npages) { }
> > > static inline void snp_set_memory_private(unsigned long vaddr, unsigned long npages) { }
> > > static inline void snp_set_wakeup_secondary_cpu(void) { }
> > > diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
> > > index b223922248e9..39ea771e2d4c 100644
> > > --- a/arch/x86/kernel/mpparse.c
> > > +++ b/arch/x86/kernel/mpparse.c
> > > @@ -553,6 +553,13 @@ static int __init smp_scan_config(unsigned long base, unsigned long length)
> > >    base, base + length - 1);
> > > BUILD_BUG_ON(sizeof(*mpf) != 16);
> > >
> > > + /*
> > > + * Skip scan in SEV-SNP guest if it would touch the legacy ROM region,
> > > + * as this memory is not pre-validated and would thus cause a crash.
> > > + */
> > > + if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP) && base < 0x100000 && base + length >= 0xC0000)
> > > + return 0;
> > > +
> > > while (length > 0) {
> > > bp = early_memremap(base, length);
> > > mpf = (struct mpf_intel *)bp;
> > > diff --git a/arch/x86/kernel/probe_roms.c b/arch/x86/kernel/probe_roms.c
> > > index 319fef37d9dc..84ff4b052fc1 100644
> > > --- a/arch/x86/kernel/probe_roms.c
> > > +++ b/arch/x86/kernel/probe_roms.c
> > > @@ -204,14 +204,11 @@ void __init probe_roms(void)
> > > int i;
> > >
> > > /*
> > > - * The ROM memory range is not part of the e820 table and is therefore not
> > > - * pre-validated by BIOS. The kernel page table maps the ROM region as encrypted
> > > - * memory, and SNP requires encrypted memory to be validated before access.
> > > - * Do that here.
> > > + * These probes are skipped in SEV-SNP guests because the ROM range
> > > + * is not pre-validated, meaning access would cause a crash.
> > > */
> > > - snp_prep_memory(video_rom_resource.start,
> > > - ((system_rom_resource.end + 1) - video_rom_resource.start),
> > > - SNP_PAGE_STATE_PRIVATE);
> > > + if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
> > > + return;
> > >
> > > /* video rom */
> > > upper = adapter_rom_resources[0].start;
> > > diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> > > index c67285824e82..d2362631da91 100644
> > > --- a/arch/x86/kernel/sev.c
> > > +++ b/arch/x86/kernel/sev.c
> > > @@ -774,21 +774,6 @@ void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
> > > early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_SHARED);
> > > }
> > >
> > > -void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op)
> > > -{
> > > - unsigned long vaddr, npages;
> > > -
> > > - vaddr = (unsigned long)__va(paddr);
> > > - npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
> > > -
> > > - if (op == SNP_PAGE_STATE_PRIVATE)
> > > - early_snp_set_memory_private(vaddr, paddr, npages);
> > > - else if (op == SNP_PAGE_STATE_SHARED)
> > > - early_snp_set_memory_shared(vaddr, paddr, npages);
> > > - else
> > > - WARN(1, "invalid memory op %d\n", op);
> > > -}
> > > -
> > > static unsigned long __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
> > >       unsigned long vaddr_end, int op)
> > > {
> > > diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
> > > index 015c95a825d3..22e27087eb5b 100644
> > > --- a/drivers/firmware/dmi_scan.c
> > > +++ b/drivers/firmware/dmi_scan.c
> > > @@ -703,7 +703,12 @@ static void __init dmi_scan_machine(void)
> > > dmi_available = 1;
> > > return;
> > > }
> > > - } else if (IS_ENABLED(CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK)) {
> > > + } else if (IS_ENABLED(CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK) &&
> > > + !cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
> > > + /*
> > > + * This scan is skipped in SEV-SNP guests because the ROM range
> > > + * is not pre-validated, meaning access would cause a crash.
> > > + */
> > > p = dmi_early_remap(SMBIOS_ENTRY_POINT_SCAN_START, 0x10000);
> > > if (p == NULL)
> > > goto error;
> > > --
> > > 2.44.0.rc0.258.g7320e95886-goog
> > >
> > >
> >
> > In addition to these changes, I also had to skip pirq_find_routing_table if SEV-SNP is active.
> 
> Thanks. I will update this in v3.

There's also another access a bit later in boot:

  static __init int eisa_bus_probe(void)
  {
    ...
    ioremap(0x0FFFD9, 4);
  }

This time it's via ioremap() with the encryption bit *unset*, so it
won't necessarily cause a crash but it's inconsistent with the early
page table having that region set as encrypted.

We discussed unsetting the encryption bit in early page table with
security folks and the general consensus was that *if* any VMM/firmware
ever came along that does want to make use of legacy region for any reason
(such as providing DMI/SMBIOS info) it would be safest to require that they
encrypt the data in the region before handing off to guest kernel, so it
makes sense to patch away unecrypted accesses to the legacy region so the
don't cause problems down the road (like causing implicit page state
change from private->shared and throwing away data in the region later
in boot).

-Mike

