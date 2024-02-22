Return-Path: <linux-kernel+bounces-77309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 013FA860398
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58B5B28CBCA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4116E5EC;
	Thu, 22 Feb 2024 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eVZqomII"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730C314B832
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 20:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708633237; cv=fail; b=b9GMvqZ2MntetdsHu15qqGKclhqbgPc+mL0qKFp0OWN+vz3f5FZIfXbDJXG+3QIZAl0WS3BmnLMKU6QFnoukUEE3ARxZuLpiBTRHw3twGENZDwzYmU86gsHlafBj3vi9zr1qIz8I216Ag+bzj3B6PhAcAYvYXD6P9sY8hmruE8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708633237; c=relaxed/simple;
	bh=Ae6O1nqAimJF9PfT5AuhFoRieDIKUGu7zfIwYys8Mh8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0ps80hgtsZaAZ1R4VGM93+O7P5cxiQ1AfgOFGYr41oo65tHZ6fdzVS1deSHUfRZp2ytFng9HJSMpqArjzHPOQa50gaycqSY1at8FiMJcWLSh8Q+QVGpG80yHo89I+16DCy/DCKHW8t4txGfqz5MNxoigijiLiBKwBPjcEulLdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eVZqomII; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cW9IdcNiRfEcHdw6inEhNaKat3/1o2CKqmwBjcYc47xmpa8uEuY9kv4NBeAWeGbYMCIl0NMJl9YGT4X+3nXJAU4e/B+IEH35UgwI92ofjuuTT7fRty46GPfO8dmSlqH3pz6ZFbxd36GrQ97oILlbhgMDxBisONPzyCkF/UigaQpcgktlYLil4yvGQgoZ6D4ZTJ5h9D9qlbDAyGzMKIZlrjN7mQpWuMbQ0PLPom6E16+zU8bpAniYaT1clhZ4/iH4XNMDcLz00yOHUbnBkiibGX+c3qKyCUa/uQbVw75+x37fd0+7AJ0HVwUi4IW3ihd7JRtErYbNlYvmVnz8RvYylA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVQU1LIOm1fxzKDJDtVLUcibm0Ta//YRJnk1ryCWCpo=;
 b=nepG+yayk1j5xavjwvH2GTigBp3EzaLyA49N4a33UeYseiwpA4SFznGSEPl7S8V/LkTzIoUiXwoFDy3oz1w/IyfGNTAOFV/WBkgnWTygkoMh7ZooVmhCPQcWQHfAFZeCqb+nTUfAh7rVfDB6A4n6YbcMZROJsP7MKYiA8ggu2R74zW1GUbz0Th0E8Cm+3jmOonCGS1AoCC2z7v4BB8YBmAIOShFXev+BE3evBPt4xP8i3V4u5PvJSDiggMMBnjBYF99/7pN4LBO1l/qqkn2kVqNF0b0WPwb/T5TotXsi5q6VYVx3Caz/NyXFzowwDZ95QLvyqf63l2pWY4Ii0rkUDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVQU1LIOm1fxzKDJDtVLUcibm0Ta//YRJnk1ryCWCpo=;
 b=eVZqomIIGyCPrDo/ZjwrCpMCrbrNyHBgL1pF5k8CsjHnx8OSTd2AoU1a5zvn66O2w2bLDb5vyJmaWyvR+ooob1oLJn5D8cvB/HxNdovUbdfwQs/+T7dLxt5dYkRFqjg2XD2pawydpklg87UtO+n8WaUM4su3aKbrRlYa6W9OG9Y=
Received: from BN9PR03CA0187.namprd03.prod.outlook.com (2603:10b6:408:f9::12)
 by MW5PR12MB5652.namprd12.prod.outlook.com (2603:10b6:303:1a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 20:20:30 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:f9:cafe::7f) by BN9PR03CA0187.outlook.office365.com
 (2603:10b6:408:f9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Thu, 22 Feb 2024 20:20:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7339.0 via Frontend Transport; Thu, 22 Feb 2024 20:20:29 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 22 Feb
 2024 14:20:29 -0600
Date: Thu, 22 Feb 2024 14:20:15 -0600
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
Message-ID: <20240222202015.33zx7t2zgaev7jos@amd.com>
References: <20240213040747.1745939-1-kevinloughlin@google.com>
 <170785457569.2934648.10119965441921727215@amd.com>
 <CAGdbjmJAE5Uo5LA=hkMFwp+LdnNxxKgSwgkpdWZ69kwS-tLkFw@mail.gmail.com>
 <20240216225019.upcxwd6vkxv5dp4n@amd.com>
 <CAGdbjmK9WoOQSbKUvcTdLJDW-RB=qe2tHFDZ-MeD266xZOxh7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGdbjmK9WoOQSbKUvcTdLJDW-RB=qe2tHFDZ-MeD266xZOxh7w@mail.gmail.com>
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|MW5PR12MB5652:EE_
X-MS-Office365-Filtering-Correlation-Id: 58e291e5-a73a-41c1-98f4-08dc33e3b6d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0zUPc5RBkUST5at6XqE/LipsQZWKruzwC0eANpseWFzmGAN6hLW8Qca5xeBIxVzBf9OXz1LA3NB2n7grAKM2SvE3qpM0nIVFU8E4KIcZDLPYv8qNoxILPCALOhV3PToRW2LHoTGuRuNx7TB6fVjbf56ZFSHTdjrZeQnqTa8baIHCaUxYIDxH6UOxnvMwAsVyTpFx+6Z9lFgZnyqP93AotDYxCUrzzY5oODYo/99UMeuoM1BFTL3jTu66ackA424kGfpGYh0KaOvSMAwtyLrldxNriOrzbofQpxda7bS/WIcbvYiIHGQmZ9tGQNCRDDFIjJEOKJ0WbIHfi3CD2OjbukWq+keFeQEod8R4MoMtR58WRXG7PF4zfrFXa5qy468gVaxFuZr/XmSeAmyGK4DZ0Q0Sm3evOT5YzutcCSRrSLUsJyCrl4EPJDKb4ioVOu6LYuM9Ui0CbiF0tUAn2ZNk7HJVDImP0eX86d2Zl9NCRCfcA4i11VCu8F+FXn/lFh1kL/nrPlaDglaVyT+3nVrC06pakvQ4/pRrH9bZAHThCXZI6aFNgI18eaS20YI/whq7ZHp8PyWOM/j3RuPwUcf/+I7Y9T8VpwFEhsVnd82gwPzvPBOfzjKiXr0WStwZLmcjfamzn1jTQNYWKiOz/KbE/Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 20:20:29.6365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e291e5-a73a-41c1-98f4-08dc33e3b6d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5652

On Wed, Feb 21, 2024 at 02:50:00PM -0800, Kevin Loughlin wrote:
> On Fri, Feb 16, 2024 at 2:50 PM Michael Roth <michael.roth@amd.com> wrote:
> >
> > On Tue, Feb 13, 2024 at 03:10:46PM -0800, Kevin Loughlin wrote:
> > > On Tue, Feb 13, 2024 at 12:03 PM Michael Roth <michael.roth@amd.com> wrote:
> > > >
> > > > Quoting Kevin Loughlin (2024-02-12 22:07:46)
> > > > > SEV-SNP requires encrypted memory to be validated before access. The
> > > > > kernel is responsible for validating the ROM memory range because the
> > > > > range is not part of the e820 table and therefore not pre-validated by
> > > > > the BIOS.
> > > > >
> > > > > While the current SEV-SNP code attempts to validate the ROM range in
> > > > > probe_roms(), this does not suffice for all existing use cases. In
> > > > > particular, if EFI_CONFIG_TABLES are not enabled and
> > > > > CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK is set, the kernel will
> > > > > attempt to access the memory at SMBIOS_ENTRY_POINT_SCAN_START (which
> > > > > falls in the ROM range) prior to validation. The specific problematic
> > > > > call chain occurs during dmi_setup() -> dmi_scan_machine() and results
> > > > > in a crash during boot if SEV-SNP is enabled under these conditions.
> > > >
> > > > AFAIK, QEMU doesn't actually include any legacy ROMs as part of the initial
> > > > encrypted guest image, and I'm not aware of any VMM implementations that
> > > > do this either.
> > >
> > > I'm using a VMM implementation that uses (non-EFI) Oak stage0 firmware [0].
> > >
> > > [0] https://github.com/project-oak/oak/tree/main/stage0_bin
> > >
> > > > If dmi_setup() similarly scans these ranges, it seems likely the same
> > > > issue would be present: the validated/private regions would only contain
> > > > ciphertext rather than the expected ROM data. Does that agree with the
> > > > behavior you are seeing?
> > > >
> > > > If so, maybe instead probe_roms should just be skipped in the case of SNP?
> > >
> > > If probe_roms() is skipped, SEV-SNP guest boot also currently crashes;
> > > I just quickly tried that (though admittedly haven't looked into why).
> >
> > default_find_smp_config() will also call smp_scan_config() on
> > 0xF0000-0x10000, so that might be the additional issue you're hitting.
> > If I skip that for in addition to probe_roms, then boot works for me.
> 
> Yeah, smp_scan_config() was the culprit. Thanks.
> 
> > It seems the currently handling has a bug that has been in place since the
> > original SEV guest code was added. If you dump the data that probe_roms()
> > sees while it is scanning for instances of ROMSIGNATURE (0xaa55) in the
> > region, you'll see that it is random data that changes on every boot.
> > The root issue is that this region does not contain encrypted data, and
> > is only being accessed that way because the early page table has the
> > encryption bit set for this range.
> >
> > The effects are subtle: if the code ever sees a pair of bytes that look
> > like ROMSIGNATURE, it will reserve that memory so it can be accessed
> > later, generally just 0xc0000-0xc7fff. In extremely rare cases where the
> > ciphertext's data has a checksum that happens to match the contents, it
> > will use a random byte, multiple it by 512, and reserve up to 64k for
> > this bogus ROM region.
> >
> > For SNP this resulted in a more obvious failure: a #VC exception because
> > the supposedly encrypted memory was in fact not encrypted, and thus not
> > PVALIDATED. Unfortunately the fix you linked to involved maintaining the
> > broken SEV behavior rather than fixing this mismatch.
> >
> > >
> > > > And perhaps dmi_setup() should similarly skip the legacy ROM ranges for
> > > > the kernel configs in question?
> > >
> > > Given (a) non-EFI firmware is supported in other SME/SEV boot code
> > > patches [2], (b) this patch does not seem to introduce significant
> > > complexity (it just moves [1] to earlier in the boot process to
> > > additionally handle the non-EFI case), and (c) skipping
> > > probe_roms()+dmi_setup() doesn't work without additional changes, I'm
> > > currently still inclined to simply validate the legacy ROM ranges
> > > early enough to prevent this issue (as is already done when using EFI
> > > firmware).
> >
> > The 2 options I see are:
> >
> >   a) Skipping accesses to these regions for SEV. It is vaguely possible
> >      some implementation out there actually did measure/load the ROM as
> >      part of the initial guest image for SEV, but for SNP this would
> >      have been impossible since it would have lead to the guest crashing
> >      when snp_prep_roms() was called, since RMPUPDATE on the host only
> >      rescinds the validated bit if there is a change to the RMP entry.
> >      If it was already assigned/private/validated then the guest code
> >      would detected that PVALIDATE resulted in no changes, and so it
> >      would have failed with PVALIDATE_FAIL_NOUPDATE. So if you want to
> >      be super sure you don't break legacy SEV implementations then you
> >      could limit the change to SNP guests where it's essentially
> >      guaranteed these regions are not being utilized in any functional
> >      way.
> 
> Based on your explanation, I agree that (at a minimum) it makes sense
> to rectify the behavior for SEV-SNP guests.
> 
> On that note, as you describe here, I skipped the 3 ROM region scans
> on platforms with CC_ATTR_GUEST_SEV_SNP (and deleted the call to
> snp_prep_memory()) and successfully booted. I can send that as v2.

Sounds good. Please add me to the Cc, happy to test/review.

> 
> Note that I have *not* tried skipping the scans for all SEV guest
> variants (CC_ATTR_GUEST_MEM_ENCRYPT) since those boots appear to be
> functioning without the change (and there is a risk of breaking the
> sorts of implementations that you described); also note that
> clang-built SEV-SNP guests still require [0] and [1] to function.
> 
> [0] https://lore.kernel.org/all/20240206223620.1833276-1-acdunlap@google.com/
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=1c811d403afd73f04bde82b83b24c754011bd0e8
> 
> >   b) Modifying the early page table setup by early_make_pgtable() to
> >      clear the encrypted bit for 0xC0000-0x100000 legacy region. The
> >      challenge there is everything is PMD-mapped at that stage of boot
> >      and there's no infrastructure for splitting page tables to handle
> >      non-2MB-aligned/sized regions.
> 
> If ever needed/desired, a slight variant of this second option might
> also be providing a temporary unencrypted mapping on the fly during
> the few times the regions are scanned during early boot, similar to
> how __sme_early_map_unmap_mem() is already used for sme_map_bootdata()
> in head64.c. I haven't tried it, but I just wanted to note it down in
> case it becomes relevant.

True, that might be another option to consider if needed.

-Mike

