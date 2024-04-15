Return-Path: <linux-kernel+bounces-145912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AF78A5CB0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4571F23CED
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D258156990;
	Mon, 15 Apr 2024 21:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SluX0aGl"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B4882D93;
	Mon, 15 Apr 2024 21:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713215352; cv=fail; b=hgZml5u8eh32INIkSp6+o0U1804mcZlbffSUvKZFFV2Fj64KO3nuwEaew9prbP3hXJxT4PY2UySn0TOOnjAoXuIqh4Qigx9UidrkZ1ZwHSeMAal9RYrnvFcns5JHTiwE8+BCtGC16lZmkp2LGZO5aZrAxmTrMWrod/MBCUauZj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713215352; c=relaxed/simple;
	bh=Da1JNjQqdVXDpeB8ik5aNzu+LfW527UDOsuhJWx4Wcs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BH0auM+8yLeTBDMoCKLeZ3WLiPm4P5YYHjMVx4GMlOCxIgVr8Wy0HYCJ6RNxWVH28rV3XVMLVomir11oIqqeGZb8EBIQQ1iI4W7GlOOJMbmgskNpOBIiYXfqpuDX0jpncRiu/4yc5ZWLW5YBKKMTdTdUCxc6ReC3dNaiboFfZn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SluX0aGl; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=daAmeHi0oaLFKoKD/Jrd0TBI25e76nTZfEvg6ygdxHtAPXLz8hXlfex9aJJ40eDGTaNP+G87KHvODd3J2+IM8dy2DlC1Huqa4IWLTyqGuD7B+ZC4Iq9WrWVizlpgJ46bDk0O+QipLKoNquVL+kNGvJIeq/ImkF1nHxP3Wx50z1ZOWr4CCRuCbRwMtlT1k0SYq7x6v5V0tbm1LlKvz039j6HgtOxsXMSnTVQsoCrY5kmz9UDF3SlCgu3NKFtHiUHJXnAwPsA0JeNP9DpVzy1oW2MnJxpGzQV5GnmF7mp8q6U3Iz4oBv7feXkhvLLiwSdoF5hEqtf+CRhaUFY6HX4hkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XeyZlK2iuorA5C53O3hcDuqOLI3xYjIKz6oKoOiT9o=;
 b=l8u2X1lEvF9WlKxJ4TsME0wEtQLM1Xv/iGZTCBvaLBjs9IIBGlt+kd9QAS6l/SBk3zWgwmQ91l0Hx2XHx5IscGF7J2Rr/I3Bn3I4uUkWVRy+yzmd4P9XrDzlYa0R+/H1CE/1JJ+kf+GQSXb39X2CIyZ0z9k/tnoSpMtEDJcHqN6NvAEFWTSC1KbMy5nVTE7q2WylL+jsLGFqQAGUV6aDui7mbqzzl9nQ6IUY/BahOF2nKSHJLaCgXnFCFbi21Asabv+w+0pYp1UkhCDZvPM+Sfj5I5N8SqBGySXNjr02CTjxqRKnP8R1swnBOJ0TDBdfUNrw6KfiAL74bzr5fJ9zvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XeyZlK2iuorA5C53O3hcDuqOLI3xYjIKz6oKoOiT9o=;
 b=SluX0aGlJwbYm2aGBRMPOhlOudum/1691Tg4C5ZazKBYtOFRI6+jX6DRAcDBTBqmT3iHHJoW1K+taa9oyPoeY2vyYxPhInhy499gkzETNaH3PYglWOQWyd2LqoMGh2MRrEKjRdhAUWYlr1CeUAwFtZSwbazQPEbM9849FEC1FIU=
Received: from BN8PR03CA0004.namprd03.prod.outlook.com (2603:10b6:408:94::17)
 by IA0PR12MB8896.namprd12.prod.outlook.com (2603:10b6:208:493::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.43; Mon, 15 Apr
 2024 21:09:06 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:94:cafe::56) by BN8PR03CA0004.outlook.office365.com
 (2603:10b6:408:94::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Mon, 15 Apr 2024 21:09:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 21:09:06 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 15 Apr
 2024 16:09:05 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <linux-tip-commits@vger.kernel.org>
CC: <bp@alien8.de>, <thomas.lendacky@amd.com>, <michael.roth@amd.com>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] Apply RMP table fixups for kexec.
Date: Mon, 15 Apr 2024 21:08:56 +0000
Message-ID: <cover.1713212104.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|IA0PR12MB8896:EE_
X-MS-Office365-Filtering-Correlation-Id: b52ade3c-d607-444f-c71b-08dc5d904916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6maSCfvt0vpGk7xUT8NUowTcV0sDy4uT0lbQtQkH7oCGM7AioOy0g9cTQ0FlxVyePD8tox06YrPjGae6fdxMvMCKicosexVHyacdNqUVaASouFfN0qthk6E4sYqxAsmzZDdHXelL62ZA+Hg8HIbqzrPYcCJRq2T+zWIYS2xHYPP0CGUll2e/y9chrK899CAuBBOb5FI5wVtiLX5NAjlDcFybM8ghhUbN3awglknYHcpMByoDkHwcfcxea2b1MKhKpCmiqQA4bmDvB9d6jk3FRCCNJGjOn+Lu08RD6hIINPi5hSYANR3csjgG1wQ+Ufvw0xpqJ7LFjwgFADtagneZFtD6TbJacPJhE2TPlSaBCKAl8DRB8Z7BswsUy97v2TYr2OFNflwuHNrRCBROlk65w85UCnBWd/g05qSg/InX1/XZiSmRNnSHd04R6H5zzyA+odC4nvU6pOAz6o6pAxTpalEyv0j419kYIFuCRXFD1q98xCNNcqJj8lBGSjxcddo+KnQoErQLp3o+nLshAduTW4D8VTDJ6lHw6WYXjk/N8LbHRiDBIGYwpaV3IiIZTROCfI6SPmH+0oYhCEhMtHhwV042tzzpcAL4/PkGR0nIfnchchpnnftaxfB5dwqMsp0x9gtDFjX7nsM8Ig39QUK2A94ypDrZ72Cei87zqxzVqQAHlBIF5/tN643lV0IBAnOXqdteK39j+O3UyhoEwCAIkPuwQ6l5JPlTOz03prBKcyz6vqKyyWysqzWy1LuENpmT
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 21:09:06.2358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b52ade3c-d607-444f-c71b-08dc5d904916
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8896

From: Ashish Kalra <ashish.kalra@amd.com>

Handle cases where the RMP table placement in the BIOS is
not 2M aligned and then the kexec kernel could try to allocate
from within that chunk and that causes a fatal RMP fault.
Check if RMP table start & end physical range in e820_table
is not aligned to 2MB and in that case use e820__range_update()
to map this range to reserved.

The callback to apply these RMP table fixups needs to be called
after the e820 tables are setup/populated and before the e820 map
has been converted to the standard Linux memory resources and e820 map
is no longer used and modifying it has no effect.

v2:
- Remove overriding e820__memory_setup_default() to invoke
  snp_rmptable_e820_fixup() to apply the RMP table fixups.
- This callback snp_rmptable_e820_fixup() is now invoked
  after e820__memory_setup() and before e820__reserve_resources().
- Expose e820 API interfaces to update e820_table_kexec and
  e820_table_firmware externally.
- snp_rmptable_e820_fixup() now calls these new external API
  interfaces to update e820_table_kexec and e820_table_firmware.


Ashish Kalra (2):
  x86/e820: Expose API to update e820 kexec and firmware tables
    externally.
  x86/sev: Add callback to apply RMP table fixups for kexec.

 arch/x86/include/asm/e820/api.h |  3 +++
 arch/x86/include/asm/sev.h      |  2 ++
 arch/x86/kernel/e820.c          |  7 +++++-
 arch/x86/mm/mem_encrypt.c       |  3 +++
 arch/x86/virt/svm/sev.c         | 44 +++++++++++++++++++++++++++++++++
 5 files changed, 58 insertions(+), 1 deletion(-)

-- 
2.34.1


