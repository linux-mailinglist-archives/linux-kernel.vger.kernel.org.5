Return-Path: <linux-kernel+bounces-64205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84085853BD3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE666B263A2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0C660B8C;
	Tue, 13 Feb 2024 20:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zhakphtw"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00759608F1
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 20:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707854595; cv=fail; b=nPbz5uC4jZrvR3iJqddv79MqZ/FNf5KrOcgDn3GXe0M4UuZKspg+go1FZfozjIJ2ruUVVdh+sCfnT/z3Krizwczs0CAEgdvps202zLtwN6HnogAYRZtKaQdTOxtHXWM4/B13yV1C/9hUlqZ6e0qy809w7R7YvC2syz3VMh8g17w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707854595; c=relaxed/simple;
	bh=HO2VkY3RuSllHDZnvWEjqDXdkR+F7aIQuuBMNO7vZgA=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:CC:
	 To:Date:Message-ID; b=WrsQooqSgkqnfX1Qb4D5M0UnW9tPomvKHMqtRmekigFSy46zQQKNT9kAIN0CD7o/0P92LvuZ6O693aK3h8QGnKIP30I0+iWPytqhfbt5xWlR8gqZkoLd8YDrXlyNTQCFUdq9xmoGFv4uuJjHAq0azBMwxBKC/ihN0BJ2/MrCNsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zhakphtw; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmRC5RNqRIoHvlSX8wtR2fVk7WI/JQDQ16Lj/Hh71b+RYwmB7z66/NplG/ykiJ5Wi/gkEt27PIli1hrVIHL/8FHR5CrqVnSvExShqEuZQI9u99tfkWPe14FMtBmbA4k28lrKR6Um2s/i1vIagMwE1/25DnICS83ywNzD2y4bt93O967JgR6794H4n96+BDxgN4QiY4+MQLBVZf3fPq56ggjWQZmXrTtKFQWZ9jjmAQP0RucFQFXTAwLcfhvMwrvYdRh9sDojMMZ4dN+pKVCDM5h7HimDt+ej2TUm6wzAn56GTw51QEhMVNexwmc4uICsQ8xDSvPukFg3IB/XZz3Rfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqfSi2BRfWlvtYeUui5vMbp39xTr63c+ZVO5MzDn/i8=;
 b=IhUC8P7499SZv61hdw6zux+BkMtV3cG71fab8fj7YCY6/wzJJea0wQgSZApQ8z+3aT+csnreWMhSIfEZoodbZ1COcMPKMNzovgmyiQBG2otkA/toRhXd0TYrvsUik1yndtCGok8h1BLotAnVd3mWrOCW+4J9sgL4+yYQdm85xfDFdq5sE0yIlP13MybY2pPpOTkkfEeQbYFJDlpKhwY7SMZuOv0b7xULCNxPlMgKCxWiVhwnLn/7q2wzGzs+smK17QFT7fcPe/0/oVoUdTAqETj9jw7d1caxUTCgMyXorn2PtQMTEmMvh7KNPViMqnPnalJ6feyVdkMdk38F9DGPEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqfSi2BRfWlvtYeUui5vMbp39xTr63c+ZVO5MzDn/i8=;
 b=ZhakphtwFUMLzbpj+Ol/hbpxdqkKiwioXVDxEq6hEmMXW55N5sqWarFq3f3Lffhjflvb7jTBE/XEOa/ShCPCwABK5W++GBb/WuSw+faScHDQXxJmcgiRgNy7gok84c1sI+5+DF6XdftvYy7JTh4A46/UA77iUvzk4to0bjBpzGU=
Received: from DS7PR03CA0071.namprd03.prod.outlook.com (2603:10b6:5:3bb::16)
 by SA1PR12MB5669.namprd12.prod.outlook.com (2603:10b6:806:237::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.21; Tue, 13 Feb
 2024 20:03:10 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3bb:cafe::6c) by DS7PR03CA0071.outlook.office365.com
 (2603:10b6:5:3bb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Tue, 13 Feb 2024 20:03:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 13 Feb 2024 20:03:10 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 14:03:09 -0600
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240213040747.1745939-1-kevinloughlin@google.com>
References: <20240213040747.1745939-1-kevinloughlin@google.com>
Subject: Re: [PATCH] x86/kernel: Validate ROM before DMI scanning when SEV-SNP is active
From: Michael Roth <michael.roth@amd.com>
CC: Adam Dunlap <acdunlap@google.com>, Peter Gonda <pgonda@google.com>, "Jacob
 Xu" <jacobhxu@google.com>, Sidharth Telang <sidtelang@google.com>, "Conrad
 Grobler" <grobler@google.com>, Andri Saar <andrisaar@google.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ard Biesheuvel
	<ardb@kernel.org>, Baoquan He <bhe@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Brijesh Singh <brijesh.singh@amd.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Dionna Glaze <dionnaglaze@google.com>,
	"H.Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Kai Huang <kai.huang@intel.com>, Kevin
 Loughlin <kevinloughlin@google.com>, Peter Zijlstra <peterz@infradead.org>,
	"Ross Lagerwall" <ross.lagerwall@citrix.com>, Thomas Gleixner
	<tglx@linutronix.de>, Tom Lendacky <thomas.lendacky@amd.com>, Yuntao Wang
	<ytcoode@gmail.com>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>
Date: Tue, 13 Feb 2024 14:02:55 -0600
Message-ID: <170785457569.2934648.10119965441921727215@amd.com>
User-Agent: alot/0.9
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|SA1PR12MB5669:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba8ac9c-6cb3-4279-600e-08dc2ccecdd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EEuLvQX4pm8r8FaYR0AMktiaO036NZz3i33dtbndOIIFYX5gVuXyPE6ty38RY0hUY5HplQRdf7M0Lx8lgpFN5up6cVLXZxhQa+nMEJ/gfVXKfWHmKRgA/6MbGl/sqjFjBRoehMH0M+bT1/G6IsU/OfQydMAuddoZCB9/zZkgUp4zz6fyYfKRYBt8bHfkrJW3XQsMeXiatVBvBn+pcIngevijC6CNj2lFO3IF/WS+ZnxY+a9r4R72xDrVFoIn2Sh52hxMLQiLdLwF+N4lqgcCr+HVa6xoeOOJ4A2gHDI9fV7yRHwqRmdKNGHYjvcGDNY9Ggg9lche1x+FaT9HzzwHlQtf5f2oX2C9OAl9TzrBnJ/ljM1YkhOi5j61hGxLpJ4l9sw+45IhV5bi1lYp/Fkcvq+VLIoFipv/l6Fsl3sKFdWFAxiseTaflgKR2bWgvqlcVs4ZTXTdS/doirgPDlebriCVok3f7yWraEdKVWgbqTtADoZkVXuTsJJhDjIqhmxYGGPLgeKvR9kQkRjjIYMjC7GGP5pcX5xOpnUwf+MAn1FS4MrCij04Kh5Z94K2PX925ola7DiqKyCwmPy/q1IJuq4k7isGO/sO06Wxzlb3IHgoIu66ctGs/eqamnQImqnkK+vzeJoTC+8x5sziktQUjQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(186009)(82310400011)(1800799012)(451199024)(64100799003)(46966006)(40470700004)(36840700001)(86362001)(81166007)(356005)(82740400003)(41300700001)(15650500001)(2906002)(478600001)(316002)(83380400001)(16526019)(26005)(336012)(2616005)(6666004)(426003)(921011)(4326008)(70586007)(110136005)(36756003)(44832011)(8676002)(54906003)(8936002)(5660300002)(70206006)(7416002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 20:03:10.7159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba8ac9c-6cb3-4279-600e-08dc2ccecdd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5669

Quoting Kevin Loughlin (2024-02-12 22:07:46)
> SEV-SNP requires encrypted memory to be validated before access. The
> kernel is responsible for validating the ROM memory range because the
> range is not part of the e820 table and therefore not pre-validated by
> the BIOS.
>=20
> While the current SEV-SNP code attempts to validate the ROM range in
> probe_roms(), this does not suffice for all existing use cases. In
> particular, if EFI_CONFIG_TABLES are not enabled and
> CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK is set, the kernel will
> attempt to access the memory at SMBIOS_ENTRY_POINT_SCAN_START (which
> falls in the ROM range) prior to validation. The specific problematic
> call chain occurs during dmi_setup() -> dmi_scan_machine() and results
> in a crash during boot if SEV-SNP is enabled under these conditions.

AFAIK, QEMU doesn't actually include any legacy ROMs as part of the initial
encrypted guest image, and I'm not aware of any VMM implementations that
do this either. As a result, it seems like snp_prep_rom_range() would
only result in the guest seeing ciphertext in these ranges.

If dmi_setup() similarly scans these ranges, it seems likely the same
issue would be present: the validated/private regions would only contain
ciphertext rather than the expected ROM data. Does that agree with the
behavior you are seeing?

If so, maybe instead probe_roms should just be skipped in the case of SNP?
And perhaps dmi_setup() should similarly skip the legacy ROM ranges for
the kernel configs in question?

-Mike

>=20
> This commit thus provides the simple solution of moving the ROM range
> validation from probe_roms() to before dmi_setup(), such that a SEV-SNP
> guest satisfying the above use case now successfully boots.
>=20
> Fixes: 9704c07bf9f7 ("x86/kernel: Validate ROM memory before accessing wh=
en SEV-SNP is active")
> Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
> ---
>  arch/x86/include/asm/setup.h |  6 ++++++
>  arch/x86/kernel/probe_roms.c | 19 +++++++++----------
>  arch/x86/kernel/setup.c      | 10 ++++++++++
>  3 files changed, 25 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
> index 5c83729c8e71..5c8f5b0d0f9f 100644
> --- a/arch/x86/include/asm/setup.h
> +++ b/arch/x86/include/asm/setup.h
> @@ -117,6 +117,12 @@ void *extend_brk(size_t size, size_t align);
>         __section(".bss..brk") __aligned(1) __used      \
>         static char __brk_##name[size]
> =20
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +void snp_prep_rom_range(void);
> +#else
> +static inline void snp_prep_rom_range(void) { }
> +#endif
> +
>  extern void probe_roms(void);
> =20
>  void clear_bss(void);
> diff --git a/arch/x86/kernel/probe_roms.c b/arch/x86/kernel/probe_roms.c
> index 319fef37d9dc..83b192f5e3cc 100644
> --- a/arch/x86/kernel/probe_roms.c
> +++ b/arch/x86/kernel/probe_roms.c
> @@ -196,6 +196,15 @@ static int __init romchecksum(const unsigned char *r=
om, unsigned long length)
>         return !length && !sum;
>  }
> =20
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +void __init snp_prep_rom_range(void)
> +{
> +       snp_prep_memory(video_rom_resource.start,
> +                       ((system_rom_resource.end + 1) - video_rom_resour=
ce.start),
> +                       SNP_PAGE_STATE_PRIVATE);
> +}
> +#endif
> +
>  void __init probe_roms(void)
>  {
>         unsigned long start, length, upper;
> @@ -203,16 +212,6 @@ void __init probe_roms(void)
>         unsigned char c;
>         int i;
> =20
> -       /*
> -        * The ROM memory range is not part of the e820 table and is ther=
efore not
> -        * pre-validated by BIOS. The kernel page table maps the ROM regi=
on as encrypted
> -        * memory, and SNP requires encrypted memory to be validated befo=
re access.
> -        * Do that here.
> -        */
> -       snp_prep_memory(video_rom_resource.start,
> -                       ((system_rom_resource.end + 1) - video_rom_resour=
ce.start),
> -                       SNP_PAGE_STATE_PRIVATE);
> -
>         /* video rom */
>         upper =3D adapter_rom_resources[0].start;
>         for (start =3D video_rom_resource.start; start < upper; start +=
=3D 2048) {
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 84201071dfac..19f870728486 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -902,6 +902,16 @@ void __init setup_arch(char **cmdline_p)
>                 efi_init();
> =20
>         reserve_ibft_region();
> +
> +       /*
> +        * The ROM memory range is not part of the e820 table and is ther=
efore not
> +        * pre-validated by BIOS. The kernel page table maps the ROM regi=
on as encrypted
> +        * memory, and SNP requires encrypted memory to be validated befo=
re access.
> +        * This should be done before dmi_setup(), which may access the R=
OM region
> +        * even before probe_roms() is called.
> +        */
> +       snp_prep_rom_range();
> +
>         dmi_setup();
> =20
>         /*
> --=20
> 2.43.0.687.g38aa6559b0-goog
>=20
>

