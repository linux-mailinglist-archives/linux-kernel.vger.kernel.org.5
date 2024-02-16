Return-Path: <linux-kernel+bounces-69451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF9485892C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B89761F268DB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360B114830A;
	Fri, 16 Feb 2024 22:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qvjzCSu2"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0682C17BB9
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 22:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708123841; cv=fail; b=KkMX//VdVgpq0x3Ct0tVdRi6oVg3o67kRc2kq7whk19s6YcRxVmN4uPmxQmDlOSDZSzHXQCtzLtJHiv7N38Yah2Q2VKGVtOpJWnTyXWbl2u7Rl0JQzyBFhkEf1U3YwEiLdzjcgeIiHigCSs/yvaDF0QDRl26wfN6deb7bRqLPUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708123841; c=relaxed/simple;
	bh=YPZqx9gAdw12O5MfwcRqF8CsEb4lzZocJQL109OWAMg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQJkTvOvzq7JnD3qAtHkJkHncv3xnPtNT1NmJIiRuRfyjmplk53kWz7zbBIcWB+8uc6G1r3qjb3BZEDBePZkkOcvv+qPoxOnvoS5lUnJHkHqQSWa16hId3iZj2RGBsEz3Qhhlqf/8MLFqD6Wvd3MVHllvIzpLE3P38/lZWsC3OU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qvjzCSu2; arc=fail smtp.client-ip=40.107.220.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmnUoUEf/tsdkc8H056NT/ZhVrM6MhzXGArrz0mU0wfhGZOisMkBr+B2+Pjoh6BWTLhyPeRzBSsxByYubkan85Mkri90nNyInOmwa+/EoY5A/wjoxRe2Zo908W8MAvdQVHUhM5eL4dsnOTnP0ngISLEJP0e89AgbWSXyi84tPdf0fwkNPHdjalGCgUSiA4HOyG0ZqJ4yxRUF3V2CEKgYXaRYpA6tj1Nut83YlxVdgFDWSi98jDJNCdpYXXGpaesYjQ5bAKrbxiUVNe0xEVLx4HiWq7nYZg8W+SRxWqX5cYw3MzYrKpy0EOiRtXvW67I4ywA9dNRvWgANGavpbYGR+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEKcCUqiatmsb/irS+g79TTHuxb9xc7FROSZE8TgoRQ=;
 b=UT4Z1OrZhZp8r6ey1MlvrlblZYKAfo6pSsgI7uJ6MmO/T9jT/1QZc6Mm2Wi6Vy8RrBRFm3hR7sflk0rLbJo0ZcDOPAAwD1Vn/1ffyCATnGUBfig2LImCYpUQBzgYgT1i59pbC5lg0zzTZwcSKiG9fi90QYj9e9uBmP642yLA2B1mD+e0Fi3joPE0iZ5dWbZcm76hpT8negtVEujeQgMubLm6kPjD/Nf8IZvU2ebxHatu271DCPqkfRu+sqs+G5fRL42JLvnjfSvHBe0tIG/J1BWAYVXTbO/J0Jei2tS7P7Rut3+ffG5jgoUBJe8UXHK4UFWSqpqafe4Z/jLeqFm3Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEKcCUqiatmsb/irS+g79TTHuxb9xc7FROSZE8TgoRQ=;
 b=qvjzCSu2xfuIqvVXLyIhqc6tQGrwqgc1cXXqnK0nONJ3wfIAeYZ+mH1kGjjXBEadmURRqFm0YBexTuGcThMkrFxKU9Ln1QlnHWRn5rnskxdddEm9xnquSSBgUYWdL+ElCHnYvsf6jEyWvoOTzAs6HHB4e+IHoAr5EbdVe1OXGoc=
Received: from CY8PR12CA0025.namprd12.prod.outlook.com (2603:10b6:930:49::14)
 by MN2PR12MB4584.namprd12.prod.outlook.com (2603:10b6:208:24e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14; Fri, 16 Feb
 2024 22:50:34 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:49:cafe::f0) by CY8PR12CA0025.outlook.office365.com
 (2603:10b6:930:49::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Fri, 16 Feb 2024 22:50:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 16 Feb 2024 22:50:33 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 16 Feb
 2024 16:50:33 -0600
Date: Fri, 16 Feb 2024 16:50:19 -0600
From: Michael Roth <michael.roth@amd.com>
To: Kevin Loughlin <kevinloughlin@google.com>
CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ard Biesheuvel
	<ardb@kernel.org>, Baoquan He <bhe@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Brijesh Singh <brijesh.singh@amd.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Dionna Glaze <dionnaglaze@google.com>,
	"H.Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Kai Huang <kai.huang@intel.com>, Peter
 Zijlstra <peterz@infradead.org>, Ross Lagerwall <ross.lagerwall@citrix.com>,
	"Thomas Gleixner" <tglx@linutronix.de>, Tom Lendacky
	<thomas.lendacky@amd.com>, "Yuntao Wang" <ytcoode@gmail.com>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>, Adam Dunlap
	<acdunlap@google.com>, Peter Gonda <pgonda@google.com>, Jacob Xu
	<jacobhxu@google.com>, Sidharth Telang <sidtelang@google.com>, Conrad Grobler
	<grobler@google.com>, Andri Saar <andrisaar@google.com>
Subject: Re: [PATCH] x86/kernel: Validate ROM before DMI scanning when
 SEV-SNP is active
Message-ID: <20240216225019.upcxwd6vkxv5dp4n@amd.com>
References: <20240213040747.1745939-1-kevinloughlin@google.com>
 <170785457569.2934648.10119965441921727215@amd.com>
 <CAGdbjmJAE5Uo5LA=hkMFwp+LdnNxxKgSwgkpdWZ69kwS-tLkFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGdbjmJAE5Uo5LA=hkMFwp+LdnNxxKgSwgkpdWZ69kwS-tLkFw@mail.gmail.com>
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|MN2PR12MB4584:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a993be-7ffa-4546-ce5b-08dc2f41af53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eB0PClyAcvPLptUKKUmNfTIqSfO7mcRVj2oXB6pEpulLTm1UUBZxVgpIU5nClb0P/EngRAddG1vTOI6uP2UDtvbfRObOObWjzVCDf0fSCY4BZxMQohtyGrAICN+PNn4RdwdmVwsqsFy0bZuPpttTi388gnL4PZg4C553uMFrMApUkPlrfM/lc2dKGEMmHXYfko5a4ZMnlGPLQDrO7NWv00I0B1zRGaOninEJqNvQigN5TAkHsldjyCLZ50SEbIG8bCCYlQTzMgIqbSCYe4yYBNQ8wmxPsdRT8ZxwRaVfrsuuJk/9OPJZIAoVKEI0UwhQ8hh1e2yMNhrvNe9Qp5mqzQXpLfB7O21nluBpFBO9UyjiEoCzJ91AH/RULH7NSVDWix83UCMrfGwC5cojuWAfsOl16IIwdbsd1qw4tg7+tviHKbMU0roKHgzODuvb7JuJy0dGowTgnYco3Qf4Gie9VlUbBnh3yefejjJzD3ocs5LhPh1GpMb+z0+5QqtuPREdts4C8Lk9Qj6bBk3Mf9HXoTXs3f6m98feujpYUBLnpGCwkI/UtzDA4yBI3sp3IshFGP//E3FuRt9efd436wW6IPEItZbtUso28LkHfSbIsGFzvjZMB3HD+8QUKwZt4boLKYA22QZeOquI8fS9arE1Ug==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(451199024)(1800799012)(36860700004)(64100799003)(186009)(82310400011)(40470700004)(46966006)(2616005)(36756003)(426003)(336012)(16526019)(83380400001)(26005)(1076003)(70206006)(6916009)(8676002)(4326008)(8936002)(70586007)(41300700001)(478600001)(53546011)(6666004)(966005)(316002)(54906003)(86362001)(356005)(81166007)(82740400003)(15650500001)(5660300002)(7416002)(44832011)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 22:50:33.9558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a993be-7ffa-4546-ce5b-08dc2f41af53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4584

On Tue, Feb 13, 2024 at 03:10:46PM -0800, Kevin Loughlin wrote:
> On Tue, Feb 13, 2024 at 12:03 PM Michael Roth <michael.roth@amd.com> wrote:
> >
> > Quoting Kevin Loughlin (2024-02-12 22:07:46)
> > > SEV-SNP requires encrypted memory to be validated before access. The
> > > kernel is responsible for validating the ROM memory range because the
> > > range is not part of the e820 table and therefore not pre-validated by
> > > the BIOS.
> > >
> > > While the current SEV-SNP code attempts to validate the ROM range in
> > > probe_roms(), this does not suffice for all existing use cases. In
> > > particular, if EFI_CONFIG_TABLES are not enabled and
> > > CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK is set, the kernel will
> > > attempt to access the memory at SMBIOS_ENTRY_POINT_SCAN_START (which
> > > falls in the ROM range) prior to validation. The specific problematic
> > > call chain occurs during dmi_setup() -> dmi_scan_machine() and results
> > > in a crash during boot if SEV-SNP is enabled under these conditions.
> >
> > AFAIK, QEMU doesn't actually include any legacy ROMs as part of the initial
> > encrypted guest image, and I'm not aware of any VMM implementations that
> > do this either.
> 
> I'm using a VMM implementation that uses (non-EFI) Oak stage0 firmware [0].
> 
> [0] https://github.com/project-oak/oak/tree/main/stage0_bin
> 
> > If dmi_setup() similarly scans these ranges, it seems likely the same
> > issue would be present: the validated/private regions would only contain
> > ciphertext rather than the expected ROM data. Does that agree with the
> > behavior you are seeing?
> >
> > If so, maybe instead probe_roms should just be skipped in the case of SNP?
> 
> If probe_roms() is skipped, SEV-SNP guest boot also currently crashes;
> I just quickly tried that (though admittedly haven't looked into why).

default_find_smp_config() will also call smp_scan_config() on
0xF0000-0x10000, so that might be the additional issue you're hitting.
If I skip that for in addition to probe_roms, then boot works for me.

The dmi_setup() case you hit would also need similar handling if taking
this approach.

> Apparently though, the fix for early ROM range accesses is not as
> simple as just skipping probe_roms() if SEV-SNP is enabled.
> Furthermore, skipping probe_roms() was also *not* the route taken in
> the initial attempt that prevents this issue for EFI use cases [1].
> 
> [1] https://lore.kernel.org/lkml/20220307213356.2797205-21-brijesh.singh@amd.com/

It seems the currently handling has a bug that has been in place since the
original SEV guest code was added. If you dump the data that probe_roms()
sees while it is scanning for instances of ROMSIGNATURE (0xaa55) in the
region, you'll see that it is random data that changes on every boot.
The root issue is that this region does not contain encrypted data, and
is only being accessed that way because the early page table has the
encryption bit set for this range.

The effects are subtle: if the code ever sees a pair of bytes that look
like ROMSIGNATURE, it will reserve that memory so it can be accessed
later, generally just 0xc0000-0xc7fff. In extremely rare cases where the
ciphertext's data has a checksum that happens to match the contents, it
will use a random byte, multiple it by 512, and reserve up to 64k for
this bogus ROM region.

For SNP this resulted in a more obvious failure: a #VC exception because
the supposedly encrypted memory was in fact not encrypted, and thus not
PVALIDATED. Unfortunately the fix you linked to involved maintaining the
broken SEV behavior rather than fixing this mismatch.

> 
> > And perhaps dmi_setup() should similarly skip the legacy ROM ranges for
> > the kernel configs in question?
> 
> Given (a) non-EFI firmware is supported in other SME/SEV boot code
> patches [2], (b) this patch does not seem to introduce significant
> complexity (it just moves [1] to earlier in the boot process to
> additionally handle the non-EFI case), and (c) skipping
> probe_roms()+dmi_setup() doesn't work without additional changes, I'm
> currently still inclined to simply validate the legacy ROM ranges
> early enough to prevent this issue (as is already done when using EFI
> firmware).

The 2 options I see are:

  a) Skipping accesses to these regions for SEV. It is vaguely possible
     some implementation out there actually did measure/load the ROM as
     part of the initial guest image for SEV, but for SNP this would
     have been impossible since it would have lead to the guest crashing
     when snp_prep_roms() was called, since RMPUPDATE on the host only
     rescinds the validated bit if there is a change to the RMP entry.
     If it was already assigned/private/validated then the guest code
     would detected that PVALIDATE resulted in no changes, and so it
     would have failed with PVALIDATE_FAIL_NOUPDATE. So if you want to
     be super sure you don't break legacy SEV implementations then you
     could limit the change to SNP guests where it's essentially
     guaranteed these regions are not being utilized in any functional
     way.

  b) Modifying the early page table setup by early_make_pgtable() to
     clear the encrypted bit for 0xC0000-0x100000 legacy region. The
     challenge there is everything is PMD-mapped at that stage of boot
     and there's no infrastructure for splitting page tables to handle
     non-2MB-aligned/sized regions.

But I don't think continuing to propagate the broken SEV behavior is
the right fix. At some point those random scans may trigger something
more problematic than wasted memory reservations. It may even be the
case already since I haven't audited the dmi_setup()/smp_scan_config()
paths yet, but nothing good/useful can come of it.

-Mike

> 
> [2] https://lore.kernel.org/lkml/CAMj1kXFZKM5wU8djcVBxDmnCJwV4Xpest6u1EbE=7wyLUUeUUQ@mail.gmail.com/

