Return-Path: <linux-kernel+bounces-105753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A23187E3DB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 918F31C20BAD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607B52233E;
	Mon, 18 Mar 2024 07:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mal7lKZG"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B8C1CA89
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 07:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710745348; cv=fail; b=OeFFwoT6muoxZsvwJYVB1qFjBvEZwnDjNpM6Ob9X3/Phkw1XnoU1lGklOcp2EI2Y8WoYMfRNST5WYLbtagG0uBPhTVlKib1zytg3fLgvjxJzlSF0V0IpnZwzO6vIQ35MZ/hsvvl3dd1fOAaSImQbS5nzUuqWxGKK4xPVdvWDGVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710745348; c=relaxed/simple;
	bh=2SPhm7VQo+GXJ+rrqIgDc+qX8gk/I5Upk0Hs8kGUGS8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E02wf02zInn2T10qhfdhXbUm6Y61dn7fXotDjFQSzZYohQTADTY+wOjZLwxH++NGqQPP02jLoDYyINQ4Nea7oxmks8OjvEzeqFFCWRuzFcbpOTUN+m3v8nZtLAsAm1T6anIzyCejODjgijkp2tiwX6ArL33FXxnj1b9SjcZ9znE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mal7lKZG; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnHIWv4Q6MAH+jhNMJxNDfVz0AAfxPnmTutxaLJtGlVMumabvjER4mGDCayEZ378H9fmw3tgFerFgVTIkQPrUN1UV3O+GpnN+NEPs+6Ca1M/vjc0JZsMPLBpgtASacYaT/JnqZN5/jqEyUgeDv+qkG0il2y4cDoABlcNXOEkBoql3v11a7hs4kdHqBhOx+DQ0pSczt7LXgss8SF6O75P6TKabSZgu6JsIIjIGMt8BxYXLfOAVH4OF17K8OO7ZqFHhZUQWqFyWvEK+YSrChNIPrPFUuqg0+dpQsP9kyfmpSI6vKo4u1TEHtTjN7qhLyDtLq/xlVh+mUSyao9O2dbfww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56mrR3VbKTJ2uuqcYF9oW4yFNxtRQGEaUr2Zmi/zbvs=;
 b=DM8AlKjSQtyWKegFB8vzACgeBY0qGtS2xK6kGCQD4f6ybwFcJxhjNfyx/tlB97ARoRgyBqAGmlpR3MyuESNBLysjt2cQoEIfRKBKAxzvJb0aWC72gH6Ke9We+gZLBR31BjFYf5p3qcs5le2Sx21Og4RPGrL3L1q2Sbzw1UAoy6TsVxL1mp/NXHeS/ImeijAMND2ryU5RiLEL8azo1TrHCVGjJizkUpFOfwkL+HMapdg8UbHGBJzrP9luf/c/9mq0eh1tRcFLkL3uPh1rCNp1VRhFBo2GnewX5IGdWdZRMb6vb7T14DgWiiLqWq3ldkMvD/Nmy3tyk7KJiBDSf1pb3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56mrR3VbKTJ2uuqcYF9oW4yFNxtRQGEaUr2Zmi/zbvs=;
 b=mal7lKZGwzEo0h6NM+/Eu3Mwer0ot2k/4rGLNpaaNg7K2iO7fJsb/Ni8lKgggmpTAv/BeX9Whu0zq8Hevd1b4SEj+xddt9n9uZmPtVr//vQ+PX84nD9fHu8dYm7WgWpau1/jGGywRgwGD0lsrcAG6m/3ED1Q/R1wJz80n3OKfxw=
Received: from DM6PR02CA0064.namprd02.prod.outlook.com (2603:10b6:5:177::41)
 by MW6PR12MB8950.namprd12.prod.outlook.com (2603:10b6:303:24a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 07:02:24 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:177:cafe::fb) by DM6PR02CA0064.outlook.office365.com
 (2603:10b6:5:177::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Mon, 18 Mar 2024 07:02:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 07:02:24 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 18 Mar
 2024 02:02:23 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>
CC: <rafael@kernel.org>, <peterz@infradead.org>, <adrian.hunter@intel.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <elena.reshetova@intel.com>,
	<jun.nakajima@intel.com>, <rick.p.edgecombe@intel.com>,
	<thomas.lendacky@amd.com>, <seanjc@google.com>, <michael.roth@amd.com>,
	<kai.huang@intel.com>, <bhe@redhat.com>, <kexec@lists.infradead.org>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kirill.shutemov@linux.intel.com>, <bdas@redhat.com>, <vkuznets@redhat.com>,
	<dionnaglaze@google.com>, <anisinha@redhat.com>, <jroedel@suse.de>
Subject: [PATCH v2 0/3] x86/snp: Add kexec support
Date: Mon, 18 Mar 2024 07:02:13 +0000
Message-ID: <cover.1710744412.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227212452.3228893-1-kirill.shutemov@linux.intel.com>
References: <20240227212452.3228893-1-kirill.shutemov@linux.intel.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|MW6PR12MB8950:EE_
X-MS-Office365-Filtering-Correlation-Id: a9a6d0f1-de41-4b9c-a7c1-08dc47195d69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SDttKWe1iHUpuHEM/lKg0XJUNou5k2U2q4qsGmMHPMc5vY8FLBBQ1i3/F19R51/Lhz2KtzYoo37oSjL1788Z+MmshcX9pWz/Qp9B3buMkQ9vHalO02q1lW2NePCR4v5fXsXRcThxR1wZcHZd1XJoYKL9aCVingoCr47omMKhhk3n0ykfwOBxUMaAoccCNReh004likI1wlaDec+s1fqJQZH+uJqKUJBTUDKJ/9iwq2tOhGbVJvOA++Rb1L+yyEROPTprp2/beDBNiTJJI0ZZ+sA276irwCz3Ii0RPfuHk0b/FMr/E+GRmNu6+z96MiXwH+JzYCVzZ4fWhH742YTFyVa5EBwQYmchM8ElrnYhW5zvds7cb9P+Jfx2CKkEw2G/eS8Vs2/zWDzlMnf/wjp2wsD3l3wPEFTiSkau/9INmhRIO0tGN5U2fx43d1WtjieTABb49RBPw5a89PZNZ6oEGApAIlnQflLgXqIDnumky6IYpW4yflG9N1KRaJq0thfelvJgCLZgWVkz8tgeMuxYUxjOTm0Ql7Lfot4SdntclkU7nqabDKEcI+c2uEsUNv4tmCBF2K7KptP//amxGwnKTFVBk0pro+R+gJC+QKljZeL66F1usp2I5soSzv+sU7BlnCqjYieCbUJTr+iFci98jHpFm9ATZMf2p4ieCT9vkNuWS0QH7w8ANbhn2pGSKrFoMF1UA3nYxxamVF3hlVArYlA2ys10mQXC8tYBzRiRhw3GWQ6cdQTKf1rLI6/TD3jP
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 07:02:24.5946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a6d0f1-de41-4b9c-a7c1-08dc47195d69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8950

From: Ashish Kalra <ashish.kalra@amd.com>

The patchset adds bits and pieces to get kexec (and crashkernel) work on
SNP guest.

v2:
- address zeroing of unaccepted memory table mappings at all page table levels
  adding phys_pte_init(), phys_pud_init() and phys_p4d_init().
- include skip efi_arch_mem_reserve() in case of kexec as part of this 
  patch set.
- rename last_address_shd_kexec to a more appropriate 
  kexec_last_address_to_make_private.
- remove duplicate code shared with TDX and use common interfaces
  defined for SNP and TDX for kexec/kdump.
- remove set_pte_enc() dependency on pg_level_to_pfn() and make the 
  function simpler.
- rename unshare_pte() to make_pte_private().
- clarify and make the comment for using kexec_last_address_to_make_private  
  more understandable.
- general cleanup. 

Ashish Kalra (3):
  efi/x86: skip efi_arch_mem_reserve() in case of kexec.
  x86/mm: Do not zap page table entries mapping unaccepted memory table
    during kdump.
  x86/snp: Convert shared memory back to private on kexec

 arch/x86/include/asm/probe_roms.h |   1 +
 arch/x86/include/asm/sev.h        |   4 +
 arch/x86/kernel/probe_roms.c      |  16 +++
 arch/x86/kernel/sev.c             | 169 ++++++++++++++++++++++++++++++
 arch/x86/mm/init_64.c             |  16 ++-
 arch/x86/mm/mem_encrypt_amd.c     |   3 +
 arch/x86/platform/efi/quirks.c    |  10 ++
 7 files changed, 215 insertions(+), 4 deletions(-)

-- 
2.34.1


