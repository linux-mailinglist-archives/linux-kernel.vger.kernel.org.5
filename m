Return-Path: <linux-kernel+bounces-159397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A57C8B2E1C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E60B41F2318B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C2E1C3E;
	Fri, 26 Apr 2024 00:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ibITmCSF"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0012D1849
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 00:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714092221; cv=fail; b=RxCGyXoUdTs5ZRHsGNGqwTIJf+jxrjZkTXRGKaJyP73F5T1ZxjP9Mb/I/NU2RNaHv0PjzE6Tns4OrstBGcG7MK/ipTMwFgnWQ3ygjVtRRGDx3TkAZvv/hsbMu9GC/IZNyiHCrg48aa+aCwGU9RGlemFVTgcLAQUrTq5yaRFaCkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714092221; c=relaxed/simple;
	bh=i4EFzn/xLRHAfn4ezunLiSUtaFRmm4iF/9Pmf8mA3fc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QcRhGX3DIgYISK1rt3ZsHan2CEUvSh4wxSqlTpjpkpaYZ6t+vIL1xakZ3t+avkOFWBy3c+orQzUKu4iiH4vO0lq8KtMNMOWyyMYkD3p8gPyl9A/bfy6oRIKPbc4xVq5i1on9DiUTHGaXUjyfcxbadEuZoFiQSCCx2dqRFXusFQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ibITmCSF; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hp5fqPdJWSfUIqU6+u3B1CPCGjOwZjJD81M1mk7jSwiY5t0g9GlE7ViOwp2LECpPg8/HKEVEu5gjQivy1lF+Yhbyouxio67oiHGPH5YnuyXSbGHeKnO6IchTvM8VbtVekk+dUq9hBGQOuy1gL5KT62nUvGGagv6C5KaYYth4E5L9Mr7oaipA15uFdVeTvsdvkfL9CYHs10+um9SNApciuS1+v2wRMpSybRByrn3vMmom4ofKCwGH7jQawlXVF7xyu9WfXJUdLB6Zqm0fMwu2cL7iKXUfr9hQMMBYznyC70zCKMOEvGlVEkgCEfsQ+WiIQANZgo4y/dAghF+RNAwlXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USJ1ki66vZ9TpK4RSxeLHCiQ7qg0of77UYFjZwKWt4c=;
 b=XmM406psX5kQNAvyDzMef09wiO1qPqs1EQj6qWRFP7usaiEGqRzsgSEICH3ImID/uzjr+/l20Tv+95wbdd+uKLW0LF1vln9cOMKuNfE2bXK9acqiuhSiJKJ+hmWwAuZb0MVlx9C2PTp3hdq+flDELWDwFGL6nJGyAJbmbAqj7GxiJC4MBivuXj+sYJXHwWSC/B4d5L8SVQhHHQTk9rhDvUik3xLIgbxiodz44YV+gRF802vm62+tg+x6HdOdEsbMV+KzxS8KkA4lfTqxOcHcVTdtrH1Hn9QixBY2Bb4wu54KzJ7XadP0dw8w8laVh8LnIteqTWcGSY2UJ5JQpJyjbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USJ1ki66vZ9TpK4RSxeLHCiQ7qg0of77UYFjZwKWt4c=;
 b=ibITmCSF1oKlc4/F0uVw3e2/OzIPznhZMqOaWIwcZ8i7U52hRbAm9vT+dlKPpWyAlSfrQhsNOQCrwY9BCyQgm5LYkzeIPwwOxkFuwGDP+BrU1a7o7GMkQODE6A+nkz4v1BqBx/oTT4lm0+9ySbIjn2B/NHeJpQn21AsNr6tgq2w=
Received: from BY5PR04CA0003.namprd04.prod.outlook.com (2603:10b6:a03:1d0::13)
 by PH0PR12MB7983.namprd12.prod.outlook.com (2603:10b6:510:28e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.46; Fri, 26 Apr
 2024 00:43:34 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::db) by BY5PR04CA0003.outlook.office365.com
 (2603:10b6:a03:1d0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.26 via Frontend
 Transport; Fri, 26 Apr 2024 00:43:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 00:43:34 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 19:43:32 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<jbohac@suse.cz>, <dyoung@redhat.com>, <luto@kernel.org>
CC: <rafael@kernel.org>, <peterz@infradead.org>, <adrian.hunter@intel.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <jun.nakajima@intel.com>,
	<rick.p.edgecombe@intel.com>, <thomas.lendacky@amd.com>,
	<michael.roth@amd.com>, <seanjc@google.com>, <kai.huang@intel.com>,
	<bhe@redhat.com>, <kirill.shutemov@linux.intel.com>, <jroedel@suse.de>,
	<ardb@kernel.org>, <kevinloughlin@google.com>, <kexec@lists.infradead.org>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] x86/sev: Add callback to apply RMP table fixups for kexec
Date: Fri, 26 Apr 2024 00:43:18 +0000
Message-ID: <df6e995ff88565262c2c7c69964883ff8aa6fc30.1714090302.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1714090302.git.ashish.kalra@amd.com>
References: <cover.1714090302.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|PH0PR12MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: ef97083d-794d-4c5b-eb8c-08dc6589e726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n7CdzFclEZw6WJo+EVa1t3r1uwBFn057izOvrsaFRx/2zFbd+e82qLQuppgr?=
 =?us-ascii?Q?eg+fuiq6frynPzMjUK9eiO+xsVyEIsa8HAmqhfJB6EwqZdt8KYS+mBzH5bLf?=
 =?us-ascii?Q?jcvhQraswSCM6wtaNr/quZzNg0WZ5EQrlg6HNjXtH6PgLQJRvMIFRO4fy77O?=
 =?us-ascii?Q?eIfbMUlJ2bR7n4SXshWSWhsfwnVtuuSUkA01Ag6Snd34k4pY3FwAUAkciMT0?=
 =?us-ascii?Q?bN6RAxhSGQyzsbDNgiJjg/3nvM+R81cyRjfMgTDgZz4/3xAGe09mT1cnPi/V?=
 =?us-ascii?Q?I45fJnGqY+3GYJTzlTQJC8kPzkrJfdmCEwW9wDZ5UfWJMTl/Gn9ytdoIOBVn?=
 =?us-ascii?Q?4oKrSYbHrGAOnT6d7i4S9yubRrVqwj2FRzJXQLsfF62j27jFSO27Ncz9NtDW?=
 =?us-ascii?Q?OoGKFG4h4Uo/OtixMeCfhX/THDxmspEnhRek2linPOgLOUl40gbl9jN0mOeg?=
 =?us-ascii?Q?GRmSPmodkm3NENCLyyV03GQgIBDap01iBXuUmrLGEaMXt+lPDg5Zd3tXWTYa?=
 =?us-ascii?Q?mccs/1d0c6daPpLA2cyCQPsyHZogYcrVkc8frsFf6Cgf7hoF5d3MGusJvKLW?=
 =?us-ascii?Q?gsfQU6i527CoA0v9mBgWYR3Kduc/FEKpqKrsllLAJ/ra0cvqaQ9TbrB0wldb?=
 =?us-ascii?Q?YtrP4GTAYiUjc/zUL6teunTciWANmTLXVKvO/dQcm7vA7QVNXbeXdJVC2IIl?=
 =?us-ascii?Q?UTRBnAWbSjkb0S/DsqJPAsTU3FuWC9sEc8/dQ3yVZaPC4Datfe5J6HY069VM?=
 =?us-ascii?Q?M9i2JKtPMwgfPNejuzsYW5H1zI0Hl7AK7QhsjLOyTyZ+BY9aPqSEhNQN2L8P?=
 =?us-ascii?Q?TsmGe7bRZ3sdt9hgL6DZuyEw8WtSKA33MmvTH0FEGB7tGRcI13DQhqa1xKcj?=
 =?us-ascii?Q?BCkKO/VF+N2JIjIO5DxlEQxcsk+3UH5QWrkHb8zcv0wbGhEWGfDXi44VrtCu?=
 =?us-ascii?Q?1H1+iCLzRQJDopU4x1+YNEOHZIicDEyGxaWwspiLFHRlCTHFWqggZuxEtxfY?=
 =?us-ascii?Q?ecvx1zAvbmwxNrH2+akQ90kjZKBJjHjzj0C8o6L9A9kjDqThVRelvBM996zj?=
 =?us-ascii?Q?Z95q8N4fScUKc9cikbRzw7QqBE8lCBxlttcX8qblicEEMvi7H5Kn8N7x0lyc?=
 =?us-ascii?Q?yMgDngMgVwN1Px1e5TkydJS/73KiORUEmoKFwYreRntcD63Nns5EbVMLcYJO?=
 =?us-ascii?Q?vkT7XHEMoYTBsoofV1oTIK1PJLENfPHf7iTJApBZRj+fx4MAwkJLsD/P83eM?=
 =?us-ascii?Q?U4gbQj+CL6EW22mRBY9ANdYkBBqQaJS83nHyoEHAOH6IUMf4zW21aHufacXG?=
 =?us-ascii?Q?uLNx344xBpzQPU61nmXJuPGUf48AadDmT1RIbOiGPAEkwLJX0VniFUqXnj8U?=
 =?us-ascii?Q?i2jIZU4knd26lf0R6Pyq71BU4iiJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 00:43:34.1530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef97083d-794d-4c5b-eb8c-08dc6589e726
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7983

From: Ashish Kalra <ashish.kalra@amd.com>

Handle cases where the RMP table placement in the BIOS is
not 2M aligned and then the kexec kernel could try to allocate
from within that chunk and that causes a fatal RMP fault.

The kexec failure is illustrated below from the kernel logs:

[    0.000000] SEV-SNP: RMP table physical range [0x0000007ffe800000 - 0x000000807f0fffff]
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000008efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000008f000-0x000000000008ffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000000090000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000005a14afff] usable
[    0.000000] BIOS-e820: [mem 0x000000005a14b000-0x000000005a34afff] reserved
[    0.000000] BIOS-e820: [mem 0x000000005a34b000-0x0000000067acefff] usable
[    0.000000] BIOS-e820: [mem 0x0000000067acf000-0x000000006dfcefff] reserved
[    0.000000] BIOS-e820: [mem 0x000000006dfcf000-0x000000006edfefff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000006edff000-0x000000006effefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000006efff000-0x000000006effffff] usable
[    0.000000] BIOS-e820: [mem 0x000000006f000000-0x000000006f00afff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000006f00b000-0x000000006fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000070000000-0x000000008fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000aa000000-0x00000000aaffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000c5000000-0x00000000c5ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000e0ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fd000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000407fcfffff] usable
[    0.000000] BIOS-e820: [mem 0x000000407fd00000-0x000000407fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000004080000000-0x0000007ffe7fffff] usable
[    0.000000] BIOS-e820: [mem 0x0000007ffe800000-0x000000807f0fffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000807f100000-0x000000807f1fefff] usable

As seen here in the e820 memory map, the end range of RMP table is not aligned to
2MB and not reserved and usable as RAM.

Subsequently, kexec -s (KEXEC_FILE_LOAD syscall) loads it's purgatory code and
boot_param, command line and other setup data into this RAM region as seen in the
kexec logs below, which leads to fatal RMP fault during kexec boot.

[  173.113085] Loaded purgatory at 0x807f1fa000
[  173.113099] Loaded boot_param, command line and misc at 0x807f1f8000 bufsz=0x1350 memsz=0x2000
[  173.113107] Loaded 64bit kernel at 0x7ffae00000 bufsz=0xd06200 memsz=0x3894000
[  173.113291] Loaded initrd at 0x7ff6c89000 bufsz=0x4176014 memsz=0x4176014
[  173.113296] E820 memmap:
[  173.113298] 0000000000000000-000000000008efff (1)
[  173.113300] 000000000008f000-000000000008ffff (4)
[  173.113302] 0000000000090000-000000000009ffff (1)
[  173.113303] 0000000000100000-000000005a14afff (1)
[  173.113305] 000000005a14b000-000000005a34afff (2)
[  173.113306] 000000005a34b000-0000000067acefff (1)
[  173.113308] 0000000067acf000-000000006dfcefff (2)
[  173.113309] 000000006dfcf000-000000006edfefff (4)
[  173.113311] 000000006edff000-000000006effefff (3)
[  173.113312] 000000006efff000-000000006effffff (1)
[  173.113314] 000000006f000000-000000006f00afff (4)
[  173.113315] 000000006f00b000-000000006fffffff (1)
[  173.113317] 0000000070000000-000000008fffffff (2)
[  173.113318] 00000000aa000000-00000000aaffffff (2)
[  173.113319] 00000000c5000000-00000000c5ffffff (2)
[  173.113321] 00000000e0000000-00000000e0ffffff (2)
[  173.113322] 00000000fd000000-00000000ffffffff (2)
[  173.113324] 0000000100000000-000000407fcfffff (1)
[  173.113325] 000000407fd00000-000000407fffffff (2)
[  173.113327] 0000004080000000-0000007ffe7fffff (1)
[  173.113328] 0000007ffe800000-000000807f0fffff (2)
[  173.113330] 000000807f100000-000000807f1fefff (1)
[  173.113331] 000000807f1ff000-000000807fffffff (2)
[  173.690528] nr_segments = 4
[  173.690533] segment[0]: buf=0x00000000e626d1a2 bufsz=0x4000 mem=0x807f1fa000 memsz=0x5000
[  173.690546] segment[1]: buf=0x0000000029c67bd6 bufsz=0x1350 mem=0x807f1f8000 memsz=0x2000
[  173.690552] segment[2]: buf=0x0000000045c60183 bufsz=0xd06200 mem=0x7ffae00000 memsz=0x3894000
[  173.697994] segment[3]: buf=0x000000006e54f08d bufsz=0x4176014 mem=0x7ff6c89000 memsz=0x4177000
[  173.708672] kexec_file_load: type:0, start:0x807f1fa150 head:0x1184d0002 flags:0x0

Check if RMP table start & end physical range in e820 tables
are not aligned to 2MB and in that case map this range to reserved in all
the three e820 tables.

Fixes: c3b86e61b756 ("x86/cpufeatures: Enable/unmask SEV-SNP CPU feature")
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/include/asm/sev.h |  2 ++
 arch/x86/mm/mem_encrypt.c  | 13 ++++++++++++
 arch/x86/virt/svm/sev.c    | 42 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 7f57382afee4..24300927a476 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -269,6 +269,7 @@ int rmp_make_private(u64 pfn, u64 gpa, enum pg_level level, u32 asid, bool immut
 int rmp_make_shared(u64 pfn, enum pg_level level);
 void snp_leak_pages(u64 pfn, unsigned int npages);
 void kdump_sev_callback(void);
+void snp_rmptable_e820_fixup(void);
 #else
 static inline bool snp_probe_rmptable_info(void) { return false; }
 static inline int snp_lookup_rmpentry(u64 pfn, bool *assigned, int *level) { return -ENODEV; }
@@ -282,6 +283,7 @@ static inline int rmp_make_private(u64 pfn, u64 gpa, enum pg_level level, u32 as
 static inline int rmp_make_shared(u64 pfn, enum pg_level level) { return -ENODEV; }
 static inline void snp_leak_pages(u64 pfn, unsigned int npages) {}
 static inline void kdump_sev_callback(void) { }
+static inline void snp_rmptable_e820_fixup(void) {}
 #endif
 
 #endif
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 6f3b3e028718..d88c942dd311 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -102,6 +102,19 @@ void __init mem_encrypt_setup_arch(void)
 	phys_addr_t total_mem = memblock_phys_mem_size();
 	unsigned long size;
 
+	/*
+	 * Invoke callback to do RMP table fixups which needs to be called
+	 * during setup_arch() after the e820 tables have been setup
+	 * in e820__memory_setup() and this function is appropriate to
+	 * invoke the callback to apply any memory encryption platform specific
+	 * quirks. The callback to do RMP table fixups cannot be invoked from
+	 * snp_init() as snp_init() is called from sme_enable() in
+	 * startup_64() which is before setup_arch() and e820 tables
+	 * have still not been setup.
+	 */
+	if (cc_platform_has(CC_ATTR_HOST_SEV_SNP))
+		snp_rmptable_e820_fixup();
+
 	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
 		return;
 
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index ab0e8448bb6e..1b4b99b26bec 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -163,6 +163,48 @@ bool snp_probe_rmptable_info(void)
 	return true;
 }
 
+static void __init __snp_e820_tables_fixup(u64 pa)
+{
+	if (IS_ALIGNED(pa, PMD_SIZE))
+		return;
+
+	/*
+	 * Check if RMP table start and end physical range
+	 * in e820_tables are not aligned to 2MB and in that case map
+	 * this range in all the three e820 tables to be reserved.
+	 * The e820_table needs to be updated as it is converted to
+	 * kernel memory resources and used by KEXEC_FILE_LOAD syscall
+	 * to load kexec segments. The e820_table_firmware needs to be
+	 * updated as it is exposed to sysfs and used by KEXEC_LOAD
+	 * syscall to load kexec segments and e820_table_kexec needs
+	 * to be updated as it passed to kexec-ed kernel.
+	 */
+	pa = ALIGN_DOWN(pa, PMD_SIZE);
+	if (e820__mapped_any(pa, pa + PMD_SIZE, E820_TYPE_RAM)) {
+		pr_info("Reserving start/end of RMP table on a 2MB boundary [0x%016llx]\n", pa);
+		e820__range_update(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
+		e820__range_update_table(e820_table_kexec, pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
+		e820__range_update_table(e820_table_firmware, pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
+	}
+}
+
+/*
+ * Callback to do any RMP table fixups, needs to be called
+ * after e820__memory_setup(), after the e820 tables are
+ * setup/populated and before e820__reserve_resources(), before
+ * the e820 map has been converted to the standard Linux memory
+ * resources and e820 map is no longer used and modifying it
+ * has no effect. Handle cases where the RMP table placement in
+ * the BIOS is not 2M aligned and then the kexec kernel could
+ * try to allocate from within that chunk and that causes a
+ * fatal RMP fault.
+ */
+void __init snp_rmptable_e820_fixup(void)
+{
+	__snp_e820_tables_fixup(probed_rmp_base);
+	__snp_e820_tables_fixup(probed_rmp_base + probed_rmp_size);
+}
+
 /*
  * Do the necessary preparations which are verified by the firmware as
  * described in the SNP_INIT_EX firmware command description in the SNP
-- 
2.34.1


