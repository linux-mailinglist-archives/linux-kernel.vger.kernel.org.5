Return-Path: <linux-kernel+bounces-97674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2192C876DAD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 00:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D1021F22646
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0D73A1C4;
	Fri,  8 Mar 2024 23:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rpg29kHv"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C791DA52
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 23:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709938886; cv=fail; b=iZlnSJmR6wRpCc3LLKr4RfX1um/j7HevOIbokgbM3G7xUEw1kW+OcDfg+E/fRQ3Nm//2QX3xO4UbYbYm8843PbeDS7r2khpbdIONS5fDRg3seXsd+okF+9w8slj7VPYzaLZFS09HXxArULN5o0eCFY6SmDt1i0ZT9ln7F7NKttY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709938886; c=relaxed/simple;
	bh=1dv6SsZ2CPyPHczQtJDNje4NTvTVTx4WwklmQD5/Cp0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctb/h/5GUGUZU7AE1rvk90bXCSLhabn3O9irPuVA0Bm1Y9SOAcZKS0cW5/51ztMUObHfEeWg/zD8U+YwpT4sbyzVYE/6Nziq/iJJk861mBy80hUCuGi1FxsoWSDxcNv/BpoME+RmZVFK/C0g99my0WM9Z/2Ow95IzuYQuUEmFiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rpg29kHv; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaeDJx4RTfaB4FPrg4+B3p2yPZ3N9IU76U5JO7bT/011vOK3uvpcjUGaqynPKdqutugU17cvUwH8quTAhAx9WmITqpBzWwCcAGcR6mkdQ5w1RxFn/sFdf8WJ0SDtOkk6eBuGUYa5kSKeQerwYxgbIjD++tQudwvDc38wbj5G8Asaj4/RQZypj+JpojWnw5+fmYHt3vxNpecyAtPKqYUn0uYOJyWy/1/RjQao8Nt8mlYq54DrmmKAes8H4lnYkLgoo01SbVyeH3/1g9juf/uGwb57dXk6uk8gIpck4a5h0TnjITa8hyo8KuQw/wyvQ+MS3LCtrKQAp3XRBIAg8v6bWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymVCcEgvcIZILSESMnLJV7GWEOnXNF2iIeoeGOrlx7g=;
 b=Nai2rHNE4XYy2ARYxuU3S3mgk0BRc9bsXv7jc4mf3u0AxHaKWdkbo07AK7xO84L0D0hm/j4Lm3GgRS9lj0NnfohJPi0ey/U6KKzvmtYwdsIRssUBZcmNsH7wLbQdBz4t7pBo75q1PwB+hMm1Eqo4JrYLh3Tmk99geRfhZ9+J9plv5mSfRBszQPbnRdtgozZYFCmozOV+kKOo3pBxVVFY8HAuLCJkek4QC+qM4185E5qxUVsiELkB7KuWXAEtwpWCvffSkcq5QlYLPdZxVEm+VYUM4Gr07gYKTknAyEVm7iruRXVGmC+pZ9eCFMAln/786WUPtJi694Fq44t5bkfOCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymVCcEgvcIZILSESMnLJV7GWEOnXNF2iIeoeGOrlx7g=;
 b=rpg29kHvV8wPXLIPXOlyp3TrcgCPMKx/Ongykc3wBZo0cx7DGjXqpJ3ZnBO8J4X5JdxWGNdfCAo4FLzmZiopvoHU0Oa5fvng4o2XpQ5VE4o6qCi4hxiFrY1LbYixD84rShytxv2fQauzmXrf4pnPHML9bgDZB0Pp2fFSxuszhrA=
Received: from MW4PR03CA0057.namprd03.prod.outlook.com (2603:10b6:303:8e::32)
 by IA0PR12MB8375.namprd12.prod.outlook.com (2603:10b6:208:3dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 23:01:20 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:303:8e:cafe::49) by MW4PR03CA0057.outlook.office365.com
 (2603:10b6:303:8e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29 via Frontend
 Transport; Fri, 8 Mar 2024 23:01:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 23:01:19 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 8 Mar
 2024 17:01:15 -0600
Date: Fri, 8 Mar 2024 17:01:00 -0600
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
Message-ID: <20240308230100.unv2t7r6z6nd4bzl@amd.com>
References: <CAGdbjmK9WoOQSbKUvcTdLJDW-RB=qe2tHFDZ-MeD266xZOxh7w@mail.gmail.com>
 <20240222202404.36206-1-kevinloughlin@google.com>
 <4463AFB9-58AC-4E65-BB04-EB2C9F2D9301@broadcom.com>
 <CAGdbjmJ+xiqycaDU9XMUEj2z70Adx-+ZCOiAFGXoNCojt_X=qA@mail.gmail.com>
 <20240308204151.jny3hyo6nyjqk6qt@amd.com>
 <CAGdbjmK=68Gte2MOvstMa_BoKxX2SEhbXeuRYpO_bdd2FY_xxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGdbjmK=68Gte2MOvstMa_BoKxX2SEhbXeuRYpO_bdd2FY_xxw@mail.gmail.com>
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|IA0PR12MB8375:EE_
X-MS-Office365-Filtering-Correlation-Id: a93d65e5-34e2-4987-374f-08dc3fc3aafb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zgY80+pOt1WQXaRDGACq37w2yaklmTMoV7co0J7KrPQByrsw1k3U4CoQXfj6q9mZo8c2WxWvG8uDTHevy0QyP9zRUcB9oj5NjbQctTWNcoxHu4gl5fHSLOHW8Qk7HT8ZRojROV8xHz+IZ5cUr7g1kgXXv3Nv2rs1UGqpJ8g1iZkNTIH3n7gJ5udi74JfMFehuiqASsqEEJrSEMNhhFkOkv642TxByVDgrdscftJZ+wy3Xa3325SVzo+A30Jh90A+FQU4KVBLB+i13C2gzw96K/06y1WwD2OgbseV7DUMfw3otlQeEqVsZWMStpu4km6VXIFwNpBEuySCL+rgSd4NNpAD92f8aZXYJoIMKYJVhRNhJGvHIsoBDRqPPCzYDJ9afhl2IZ30RSvGo0qVrrdgIzq4j4zmBmCyppordPNvxMoIYM0nvpaDiLmysWG8YfQxDz72zx4KGqCzHDo0f4poCRw1IUz3AnhhKOJIOPyDsNiUt0z7FAzLQbkogzZ3g2A4TLZKRG0uzy7917/BZQyRMw+dgAO/PRw3uJksCKXvXZj7V0jpBqem03NUaogtDvwE8bY01yrRn9G8qGhrVm/p5CtV2g3TsppazpovbuewAq8zBil9YUH4VeBSraXIgo4943KZDOTzdtr4brWwB8UKVTgZS/DnWxpajT+rRVgfSE4yaQnEF7odcHL1SKdBln/UpmNeuugd5X9RgGBWfrZ+0u4rE/zUd9BmsFJGLOiKM9UP6Ayo6GsXXtIKbiWIwUJW
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(7416005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 23:01:19.6405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a93d65e5-34e2-4987-374f-08dc3fc3aafb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8375

On Fri, Mar 08, 2024 at 04:30:55PM -0500, Kevin Loughlin wrote:
> On Fri, Mar 8, 2024 at 3:44 PM Michael Roth <michael.roth@amd.com> wrote:
> >
> > On Fri, Mar 08, 2024 at 11:10:43AM -0500, Kevin Loughlin wrote:
> > > On Mon, Feb 26, 2024 at 2:16 PM Mike Stunes <mike.stunes@broadcom.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > > On Feb 22, 2024, at 12:24 PM, Kevin Loughlin <kevinloughlin@google.com> wrote:
> > > > >
> > > > > SEV-SNP requires encrypted memory to be validated before access.
> > > > > Because the ROM memory range is not part of the e820 table, it is not
> > > > > pre-validated by the BIOS. Therefore, if a SEV-SNP guest kernel wishes
> > > > > to access this range, the guest must first validate the range.
> > > > >
> > > > > The current SEV-SNP code does indeed scan the ROM range during early
> > > > > boot and thus attempts to validate the ROM range in probe_roms().
> > > > > However, this behavior is neither necessary nor sufficient.
> > > > >
> > > > > With regards to sufficiency, if EFI_CONFIG_TABLES are not enabled and
> > > > > CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK is set, the kernel will
> > > > > attempt to access the memory at SMBIOS_ENTRY_POINT_SCAN_START (which
> > > > > falls in the ROM range) prior to validation. The specific problematic
> > > > > call chain occurs during dmi_setup() -> dmi_scan_machine() and results
> > > > > in a crash during boot if SEV-SNP is enabled under these conditions.
> > > > >
> > > > > With regards to necessity, SEV-SNP guests currently read garbage (which
> > > > > changes across boots) from the ROM range, meaning these scans are
> > > > > unnecessary. The guest reads garbage because the legacy ROM range
> > > > > is unencrypted data but is accessed via an encrypted PMD during early
> > > > > boot (where the PMD is marked as encrypted due to potentially mapping
> > > > > actually-encrypted data in other PMD-contained ranges).
> > > > >
> > > > > While one solution would be to overhaul the early PMD mapping to treat
> > > > > the ROM region of the PMD as unencrypted, SEV-SNP guests do not rely on
> > > > > data from the legacy ROM region during early boot (nor can they
> > > > > currently, since the data would be garbage that changes across boots).
> > > > > As such, this patch opts for the simpler approach of skipping the ROM
> > > > > range scans (and the otherwise-necessary range validation) during
> > > > > SEV-SNP guest early boot.
> > > > >
> > > > > Ultimatly, the potential SEV-SNP guest crash due to lack of ROM range
> > > > > validation is avoided by simply not accessing the ROM range.
> > > > >
> > > > > Fixes: 9704c07bf9f7 ("x86/kernel: Validate ROM memory before accessing when SEV-SNP is active")
> > > > > Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
> > > > > ---
> > > > > arch/x86/include/asm/sev.h   |  2 --
> > > > > arch/x86/kernel/mpparse.c    |  7 +++++++
> > > > > arch/x86/kernel/probe_roms.c | 11 ++++-------
> > > > > arch/x86/kernel/sev.c        | 15 ---------------
> > > > > drivers/firmware/dmi_scan.c  |  7 ++++++-
> > > > > 5 files changed, 17 insertions(+), 25 deletions(-)
> > > > >
> > > > > diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> > > > > index 5b4a1ce3d368..474c24ba0f6f 100644
> > > > > --- a/arch/x86/include/asm/sev.h
> > > > > +++ b/arch/x86/include/asm/sev.h
> > > > > @@ -203,7 +203,6 @@ void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
> > > > > unsigned long npages);
> > > > > void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
> > > > > unsigned long npages);
> > > > > -void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op);
> > > > > void snp_set_memory_shared(unsigned long vaddr, unsigned long npages);
> > > > > void snp_set_memory_private(unsigned long vaddr, unsigned long npages);
> > > > > void snp_set_wakeup_secondary_cpu(void);
> > > > > @@ -227,7 +226,6 @@ static inline void __init
> > > > > early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr, unsigned long npages) { }
> > > > > static inline void __init
> > > > > early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr, unsigned long npages) { }
> > > > > -static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op) { }
> > > > > static inline void snp_set_memory_shared(unsigned long vaddr, unsigned long npages) { }
> > > > > static inline void snp_set_memory_private(unsigned long vaddr, unsigned long npages) { }
> > > > > static inline void snp_set_wakeup_secondary_cpu(void) { }
> > > > > diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
> > > > > index b223922248e9..39ea771e2d4c 100644
> > > > > --- a/arch/x86/kernel/mpparse.c
> > > > > +++ b/arch/x86/kernel/mpparse.c
> > > > > @@ -553,6 +553,13 @@ static int __init smp_scan_config(unsigned long base, unsigned long length)
> > > > >    base, base + length - 1);
> > > > > BUILD_BUG_ON(sizeof(*mpf) != 16);
> > > > >
> > > > > + /*
> > > > > + * Skip scan in SEV-SNP guest if it would touch the legacy ROM region,
> > > > > + * as this memory is not pre-validated and would thus cause a crash.
> > > > > + */
> > > > > + if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP) && base < 0x100000 && base + length >= 0xC0000)
> > > > > + return 0;
> > > > > +
> > > > > while (length > 0) {
> > > > > bp = early_memremap(base, length);
> > > > > mpf = (struct mpf_intel *)bp;
> > > > > diff --git a/arch/x86/kernel/probe_roms.c b/arch/x86/kernel/probe_roms.c
> > > > > index 319fef37d9dc..84ff4b052fc1 100644
> > > > > --- a/arch/x86/kernel/probe_roms.c
> > > > > +++ b/arch/x86/kernel/probe_roms.c
> > > > > @@ -204,14 +204,11 @@ void __init probe_roms(void)
> > > > > int i;
> > > > >
> > > > > /*
> > > > > - * The ROM memory range is not part of the e820 table and is therefore not
> > > > > - * pre-validated by BIOS. The kernel page table maps the ROM region as encrypted
> > > > > - * memory, and SNP requires encrypted memory to be validated before access.
> > > > > - * Do that here.
> > > > > + * These probes are skipped in SEV-SNP guests because the ROM range
> > > > > + * is not pre-validated, meaning access would cause a crash.
> > > > > */
> > > > > - snp_prep_memory(video_rom_resource.start,
> > > > > - ((system_rom_resource.end + 1) - video_rom_resource.start),
> > > > > - SNP_PAGE_STATE_PRIVATE);
> > > > > + if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
> > > > > + return;
> > > > >
> > > > > /* video rom */
> > > > > upper = adapter_rom_resources[0].start;
> > > > > diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> > > > > index c67285824e82..d2362631da91 100644
> > > > > --- a/arch/x86/kernel/sev.c
> > > > > +++ b/arch/x86/kernel/sev.c
> > > > > @@ -774,21 +774,6 @@ void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
> > > > > early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_SHARED);
> > > > > }
> > > > >
> > > > > -void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op)
> > > > > -{
> > > > > - unsigned long vaddr, npages;
> > > > > -
> > > > > - vaddr = (unsigned long)__va(paddr);
> > > > > - npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
> > > > > -
> > > > > - if (op == SNP_PAGE_STATE_PRIVATE)
> > > > > - early_snp_set_memory_private(vaddr, paddr, npages);
> > > > > - else if (op == SNP_PAGE_STATE_SHARED)
> > > > > - early_snp_set_memory_shared(vaddr, paddr, npages);
> > > > > - else
> > > > > - WARN(1, "invalid memory op %d\n", op);
> > > > > -}
> > > > > -
> > > > > static unsigned long __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
> > > > >       unsigned long vaddr_end, int op)
> > > > > {
> > > > > diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
> > > > > index 015c95a825d3..22e27087eb5b 100644
> > > > > --- a/drivers/firmware/dmi_scan.c
> > > > > +++ b/drivers/firmware/dmi_scan.c
> > > > > @@ -703,7 +703,12 @@ static void __init dmi_scan_machine(void)
> > > > > dmi_available = 1;
> > > > > return;
> > > > > }
> > > > > - } else if (IS_ENABLED(CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK)) {
> > > > > + } else if (IS_ENABLED(CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK) &&
> > > > > + !cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
> > > > > + /*
> > > > > + * This scan is skipped in SEV-SNP guests because the ROM range
> > > > > + * is not pre-validated, meaning access would cause a crash.
> > > > > + */
> > > > > p = dmi_early_remap(SMBIOS_ENTRY_POINT_SCAN_START, 0x10000);
> > > > > if (p == NULL)
> > > > > goto error;
> > > > > --
> > > > > 2.44.0.rc0.258.g7320e95886-goog
> > > > >
> > > > >
> > > >
> > > > In addition to these changes, I also had to skip pirq_find_routing_table if SEV-SNP is active.
> > >
> > > Thanks. I will update this in v3.
> >
> > There's also another access a bit later in boot:
> >
> >   static __init int eisa_bus_probe(void)
> >   {
> >     ...
> >     ioremap(0x0FFFD9, 4);
> >   }
> >
> > This time it's via ioremap() with the encryption bit *unset*, so it
> > won't necessarily cause a crash but it's inconsistent with the early
> > page table having that region set as encrypted.
> >
> > We discussed unsetting the encryption bit in early page table with
> > security folks and the general consensus was that *if* any VMM/firmware
> > ever came along that does want to make use of legacy region for any reason
> > (such as providing DMI/SMBIOS info) it would be safest to require that they
> > encrypt the data in the region before handing off to guest kernel, so it
> > makes sense to patch away unecrypted accesses to the legacy region so the
> > don't cause problems down the road (like causing implicit page state
> > change from private->shared and throwing away data in the region later
> > in boot).
> 
> Sounds good, thanks. Since this one won't cause crashes, I will place
> it in a separate patch in the series to separate (current) functional
> fixes from cleanup, especially since there may be similar legacy
> probes to cleanup in various types of guests. Please let me know if
> you feel differently or have additional thoughts.

I think it could still be argued that it's a fix. It's just that the
main set of fixes avoid reading garbage for VMM/firmwares that *don't*
encrypt these regions, whereas this additional fix handles the case for
VMM/firmwares that *do* encrypt these regions. It's possible they exist
in the case of SEV (though I don't know of any). Might still make sense
to distinguish the 2 cases since latter is more theoretical, but both
still address the kernel modifying its behavior based on scanning random
garbage for strings.

-Mike

