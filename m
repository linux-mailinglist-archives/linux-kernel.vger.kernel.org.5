Return-Path: <linux-kernel+bounces-160385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B18B28B3CEB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D51CD1C2224B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EC012C493;
	Fri, 26 Apr 2024 16:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qRP3J2Mf"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B54F82872
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 16:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714149247; cv=fail; b=FQgKdUG6+Xkrv7wAr7jRzQhEJEIouoYzWHlS+1tEwBQpVKqNCMofoaUa8WNUNBCmVf5ni7RxSLs5vQaPXs9uFhJeXdDNl5zDlL/7FoLpUBP5T4+aleq+frxMUQt0Osktu7iq4UScT9Wbsd7L2MbceN+vr8DvHpIEEls0QBPRUsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714149247; c=relaxed/simple;
	bh=s/Eo1gvEM/a6WqbbHuEtcUxfoFAB+nJzWWl1vbDbuJY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o6jolVWOhPc+oLLAQs9sTGFnpaMjf9SuufZeQEw/Ag6FhS8zb1tfp6Xem4Y76o9PfEPhI1iMz2lvixaaSQcd5rW37Ve0OFu/ZqokCbWEu6gQkn0DPPr7F9Yy24qZ77Bn+ZdqB3IMTN2pO2XkbWL2BZjqiNa5PlP65r0sWoX3hnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qRP3J2Mf; arc=fail smtp.client-ip=40.107.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=To2lvVV6FlR5CFd82r5daiUROxbRGeQKR9AKwaywC4IFJdxkxKriHYtCgQE3Cr65IRDFpJJNLnT2NPce2tZWJ+Da1WGgK3P1B5RO0Mje6wIMPJfEerhPG7GwISGSCmdtKKDbtpAMxM2VGuxjEu5o8V1fDYotayuLqPgvWodPiLqE6V9evfFBpt/n4oPnoPFoksSWtMv0BQrluo9iqfmsMBC5h4jz9QTOZIAkLhSKy8w8fD+LZuXJlBPsI634stX3nhdgenf4EMS+YYIxajEAV5bforH1wEyc9HbHsy213XYW1lNlCwBsydnXbJ52B4Nbw5o0BKw7Xcg7Xc8H2MyNgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtjo89pLoVRqrR4hjIQOXTpukHLXWVSNk6xg6x4S7hM=;
 b=G9gb1TyD+9faNjJ9O2YAcCtk13+7R1gPsb/KIaqIXlU19OxXQOBbSOok96KH6S5s+X3JLZ0IAI4JqkXNCO9LPuxPr2RPKwF9pBsg2+twrAzHrIdwONbUMLs2snFQSsmcg7CzVCtDvagYlkEpsVU0FcRTaL3mLQI66VuxDE0Zd5GKjduVtEBtrtwRW9qYmlSg8kdfbxMrY6hIrqLOEEIITbULQ39yCTTLF5sTw8AMN7pWnfL4Cvw5BZDy7xcopxkGT0hInbmCFYmctEHCxMKYRsL5+Me6twLAMgQ1Qg58HhYd/4GNMm2uk3t+VqteAgkal2GpzM5rTaZtSo66VBL7Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtjo89pLoVRqrR4hjIQOXTpukHLXWVSNk6xg6x4S7hM=;
 b=qRP3J2MfTXRkFHSz1xetSAKFrRs5pMitJ2FsxltPspMCJmhUO4M7ZHngjcAZ6LXmZ+GIRsEkeTFL5GPriU8tbhXzMdASg8bABu1uXsgS1IsegnWO1OvYlIO1uQ7qNsibeogNFtc0y+k1WCLA6S8Ox14ch0wxSU1zkm7kYSvaTRA=
Received: from BLAPR03CA0098.namprd03.prod.outlook.com (2603:10b6:208:32a::13)
 by CH2PR12MB4151.namprd12.prod.outlook.com (2603:10b6:610:78::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31; Fri, 26 Apr
 2024 16:34:00 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::18) by BLAPR03CA0098.outlook.office365.com
 (2603:10b6:208:32a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Fri, 26 Apr 2024 16:34:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 16:34:00 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 11:33:59 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: <rafael@kernel.org>, <hpa@zytor.com>, <peterz@infradead.org>,
	<adrian.hunter@intel.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<jun.nakajima@intel.com>, <rick.p.edgecombe@intel.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <seanjc@google.com>,
	<kai.huang@intel.com>, <bhe@redhat.com>, <kirill.shutemov@linux.intel.com>,
	<bdas@redhat.com>, <vkuznets@redhat.com>, <dionnaglaze@google.com>,
	<anisinha@redhat.com>, <jroedel@suse.de>, <ardb@kernel.org>,
	<kexec@lists.infradead.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v6 1/3] efi/x86: Fix EFI memory map corruption with kexec
Date: Fri, 26 Apr 2024 16:33:48 +0000
Message-ID: <6dfe98fb95d7193ba2d692a2b6900a4d5d73db26.1714148366.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1714148366.git.ashish.kalra@amd.com>
References: <cover.1712694667.git.ashish.kalra@amd.com> <cover.1714148366.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|CH2PR12MB4151:EE_
X-MS-Office365-Filtering-Correlation-Id: 44bcffe2-cfd7-423b-3ba2-08dc660ead79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400014|7416005|36860700004|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mlqn7wGSMZrnoCdr0ilZ2puRwF4tAASxz0gkSou5z72dJO+zU2LHG6HMtF7U?=
 =?us-ascii?Q?kKBuBfziSytVkEylGTw45vyvAt/0egGdhDYWpzBwW6E9nlZhvrhCdJRLqKRH?=
 =?us-ascii?Q?Me9bCyNpcoZTQ4PIwrS3Tr+GPqY7BR6PZQ7SJ+2yNHMdcPW9oquoNP/cMi/h?=
 =?us-ascii?Q?6n/Ncj0F8SkHCne+QUCrjeXauXloDUuqamlw90bA6zFML04yqO18j+SG8Vw8?=
 =?us-ascii?Q?EuYWgTptgVmP1oD5QZh5x2FLA8eBVF68jnWhwftJ1UDAj6Isrk2d+K+A5hnA?=
 =?us-ascii?Q?uxBTcqAa2mO5bKeN24ECGntVbb/G5L9a3iVzey75/YmXPKl6b4YYjuIw6jji?=
 =?us-ascii?Q?sMr60c8NsLcZ5TMvlGuakGc5OhZwsE72BERm2EF4fjxQ6IZS8GfmGVVjCjOz?=
 =?us-ascii?Q?v4z7Rv5sxynT7AF065y3lfEcaMp5tNOEGbDChsdfQxMirPc9/Vni95OG12Rc?=
 =?us-ascii?Q?zdmxmSJAPpLJBqWgxVh4uPzrJ48TgWnyykMX516AombTWA4H2+GyjCAu0rQQ?=
 =?us-ascii?Q?XenNUn1W0hlNihw4R+b0WmDQkz9RusJcokyp6FbKSSKPAKxMIOsSHaoVROwX?=
 =?us-ascii?Q?emfY3UKte6JRuawR8bLUnASjjpL3TXFfOuIoK7hjetEQbUERrtyHoA3X/sEc?=
 =?us-ascii?Q?P/szN+yY4VrDutJx157vSnj+KPE/7tzeTTQxQY9lLgWv7wrEwApSfheXTpwO?=
 =?us-ascii?Q?G05jWwX/5q62J2dzcTrfx5g/rp700gvMH3cjEOrLiPVEMCURkfHi93MU2vll?=
 =?us-ascii?Q?Rqhff8el9EkrVM0ZWacblOYlx3gfLGPqaxGkJWK2Sx1cXeOHFA+YmDHEEtGV?=
 =?us-ascii?Q?f7E2XolOBzD4B4SkP6+giCE+9hR/WoKl0DllXn2iFzlV7j2rCAhHjPPwu8JW?=
 =?us-ascii?Q?EyRWn695r6IYXFcoOTQJJsbaS+FoeoP4lFxWd/hdu9JwFrIT85MphMYESPc8?=
 =?us-ascii?Q?F7NpP3lmBuxx4a8mIILFKAci6McNPysu65Z8kks46ZzBk5c2r0Uw7hey/oa1?=
 =?us-ascii?Q?QY+uakBKGL9q6JOQ0XFVRU2ak38FcMVw38shEjW4m1gGL7FebzytI4pAzsCR?=
 =?us-ascii?Q?vC+pZ9Ipp6jNKpMjda84ivWQIlpVav9kDB1TdqLYH8GfOeEYDkymb0tJCB3I?=
 =?us-ascii?Q?8hdgFGzTHPaQEV2Q92GfpSjRtR0VZbyiDBi0otT9wNYLYRiIwC9hLXzzbzYV?=
 =?us-ascii?Q?PWWbPXnti9Rsgvsc1V9gMitYJAWMTKVEh2OeiySBP7wMeBKXLBN7noxyKjwI?=
 =?us-ascii?Q?mIAsNerybIBJZ9IaDE98gnFs8qnAoPIR9l66kKYI35LTp3OgCTYOrczjg9+G?=
 =?us-ascii?Q?I0sp/OjfFUOQq8b18Uwfev8IpdTekxahBC/hKzPIH8k8nF1hEMZOXda8My+w?=
 =?us-ascii?Q?RUJ1kA9zKKf/XWuBUzEoZBgr7dFq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(7416005)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 16:34:00.4652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44bcffe2-cfd7-423b-3ba2-08dc660ead79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4151

From: Ashish Kalra <ashish.kalra@amd.com>

With SNP guest kexec observe the following efi memmap corruption :

[    0.000000] efi: EFI v2.7 by EDK II
[    0.000000] efi: SMBIOS=0x7e33f000 SMBIOS 3.0=0x7e33d000 ACPI=0x7e57e000 ACPI 2.0=0x7e57e014 MEMATTR=0x7cc3c018 Unaccepted=0x7c09e018
[    0.000000] efi: [Firmware Bug]: Invalid EFI memory map entries:
[    0.000000] efi: mem03: [type=269370880|attr=0x0e42100e42180e41] range=[0x0486200e41038c18-0x200e898a0eee713ac17] (invalid)
[    0.000000] efi: mem04: [type=12336|attr=0x0e410686300e4105] range=[0x100e420000000176-0x8c290f26248d200e175] (invalid)
[    0.000000] efi: mem06: [type=1124304408|attr=0x000030b400000028] range=[0x0e51300e45280e77-0xb44ed2142f460c1e76] (invalid)
[    0.000000] efi: mem08: [type=68|attr=0x300e540583280e41] range=[0x0000011affff3cd8-0x486200e54b38c0bcd7] (invalid)
[    0.000000] efi: mem10: [type=1107529240|attr=0x0e42280e41300e41] range=[0x300e41058c280e42-0x38010ae54c5c328ee41] (invalid)
[    0.000000] efi: mem11: [type=189335566|attr=0x048d200e42038e18] range=[0x0000318c00000048-0xe42029228ce4200047] (invalid)
[    0.000000] efi: mem12: [type=239142534|attr=0x0000002400000b4b] range=[0x0e41380e0a7d700e-0x80f26238f22bfe500d] (invalid)
[    0.000000] efi: mem14: [type=239207055|attr=0x0e41300e43380e0a] range=[0x8c280e42048d200e-0xc70b028f2f27cc0a00d] (invalid)
[    0.000000] efi: mem15: [type=239210510|attr=0x00080e660b47080e] range=[0x0000324c0000001c-0xa78028634ce490001b] (invalid)
[    0.000000] efi: mem16: [type=4294848528|attr=0x0000329400000014] range=[0x0e410286100e4100-0x80f252036a218f20ff] (invalid)
[    0.000000] efi: mem19: [type=2250772033|attr=0x42180e42200e4328] range=[0x41280e0ab9020683-0xe0e538c28b39e62682] (invalid)
[    0.000000] efi: mem20: [type=16|   |  |  |  |  |  |  |  |  |   |WB|  |WC|  ] range=[0x00000008ffff4438-0xffff44340090333c437] (invalid)
[    0.000000] efi: mem22: [Reserved    |attr=0x000000c1ffff4420] range=[0xffff442400003398-0x1033a04240003f397] (invalid)
[    0.000000] efi: mem23: [type=1141080856|attr=0x080e41100e43180e] range=[0x280e66300e4b280e-0x440dc5ee7141f4c080d] (invalid)
[    0.000000] efi: mem25: [Reserved    |attr=0x0000000affff44a0] range=[0xffff44a400003428-0x1034304a400013427] (invalid)
[    0.000000] efi: mem28: [type=16|   |  |  |  |  |  |  |  |  |   |WB|  |WC|  ] range=[0x0000000affff4488-0xffff448400b034bc487] (invalid)
[    0.000000] efi: mem30: [Reserved    |attr=0x0000000affff4470] range=[0xffff447400003518-0x10352047400013517] (invalid)
[    0.000000] efi: mem33: [type=16|   |  |  |  |  |  |  |  |  |   |WB|  |WC|  ] range=[0x0000000affff4458-0xffff445400b035ac457] (invalid)
[    0.000000] efi: mem35: [type=269372416|attr=0x0e42100e42180e41] range=[0x0486200e44038c18-0x200e8b8a0eee823ac17] (invalid)
[    0.000000] efi: mem37: [type=2351435330|attr=0x0e42100e42180e42] range=[0x470783380e410686-0x2002b2a041c2141e685] (invalid)
[    0.000000] efi: mem38: [type=1093668417|attr=0x100e420000000270] range=[0x42100e42180e4220-0xfff366a4e421b78c21f] (invalid)
[    0.000000] efi: mem39: [type=76357646|attr=0x180e42200e42280e] range=[0x0e410686300e4105-0x4130f251a0710ae5104] (invalid)
[    0.000000] efi: mem40: [type=940444268|attr=0x0e42200e42280e41] range=[0x180e42200e42280e-0x300fc71c300b4f2480d] (invalid)
[    0.000000] efi: mem41: [MMIO        |attr=0x8c280e42048d200e] range=[0xffff479400003728-0x42138e0c87820292727] (invalid)
[    0.000000] efi: mem42: [type=1191674680|attr=0x0000004c0000000b] range=[0x300e41380e0a0246-0x470b0f26238f22b8245] (invalid)
[    0.000000] efi: mem43: [type=2010|attr=0x0301f00e4d078338] range=[0x45038e180e42028f-0xe4556bf118f282528e] (invalid)
[    0.000000] efi: mem44: [type=1109921345|attr=0x300e44000000006c] range=[0x44080e42100e4218-0xfff39254e42138ac217] (invalid)
..

This EFI memap corruption is happening with efi_arch_mem_reserve() invocation in case of kexec boot.

( efi_arch_mem_reserve() is invoked with the following call-stack: )

[    0.310010]  efi_arch_mem_reserve+0xb1/0x220
[    0.311382]  efi_mem_reserve+0x36/0x60
[    0.311973]  efi_bgrt_init+0x17d/0x1a0
[    0.313265]  acpi_parse_bgrt+0x12/0x20
[    0.313858]  acpi_table_parse+0x77/0xd0
[    0.314463]  acpi_boot_init+0x362/0x630
[    0.315069]  setup_arch+0xa88/0xf80
[    0.315629]  start_kernel+0x68/0xa90
[    0.316194]  x86_64_start_reservations+0x1c/0x30
[    0.316921]  x86_64_start_kernel+0xbf/0x110
[    0.317582]  common_startup_64+0x13e/0x141

efi_arch_mem_reserve() calls efi_memmap_alloc() to allocate memory for
EFI memory map and due to early allocation it uses memblock allocation.

Later during boot, efi_enter_virtual_mode() calls kexec_enter_virtual_mode()
in case of a kexec-ed kernel boot.

This function kexec_enter_virtual_mode() installs the new EFI memory map by
calling efi_memmap_init_late() which remaps the efi_memmap physically allocated
in efi_arch_mem_reserve(), but this remapping is still using memblock allocation.

Subsequently, when memblock is freed later in boot flow, this remapped
efi_memmap will have random corruption (similar to a use-after-free scenario).

The corrupted EFI memory map is then passed to the next kexec-ed kernel
which causes a panic when trying to use the corrupted EFI memory map.

Fix this EFI memory map corruption by skipping efi_arch_mem_reserve() for kexec.

Additionally, skipping this function for kexec altogther makes sense
as for kexec use case need to use the the EFI memmap passed from first
kernel via setup_data and avoid any additional EFI memory map
additions/updates.

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/platform/efi/quirks.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index f0cc00032751..af7126d9c540 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -258,6 +258,26 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
 	int num_entries;
 	void *new;
 
+	/*
+	 * efi_arch_mem_reserve() calls efi_memmap_alloc() to allocate memory for
+	 * EFI memory map and due to early allocation it uses memblock allocation.
+	 * Later during boot, efi_enter_virtual_mode() calls kexec_enter_virtual_mode()
+	 * in case of a kexec-ed kernel boot. This function kexec_enter_virtual_mode()
+	 * installs the new EFI memory map by calling efi_memmap_init_late() which
+	 * remaps the efi_memmap physically allocated here in efi_arch_mem_reserve(),
+	 * but this remapping is still using memblock allocation.
+	 * Subsequently, when memblock is freed later in boot flow, this remapped
+	 * efi_memmap will have random corruption (similar to a use-after-free scenario).
+	 * The corrupted EFI memory map is then passed to the next kexec-ed kernel
+	 * which causes a panic when trying to use the corrupted EFI memory map.
+	 * Additionally, skipping this function for kexec altogther makes sense
+	 * as for kexec use case need to use the the EFI memmap passed from first
+	 * kernel via setup_data and avoid any additional EFI memory map
+	 * additions/updates.
+	 */
+	if (efi_setup)
+		return;
+
 	if (efi_mem_desc_lookup(addr, &md) ||
 	    md.type != EFI_BOOT_SERVICES_DATA) {
 		pr_err("Failed to lookup EFI memory descriptor for %pa\n", &addr);
-- 
2.34.1


