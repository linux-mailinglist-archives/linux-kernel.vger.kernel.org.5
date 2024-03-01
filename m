Return-Path: <linux-kernel+bounces-88559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7452C86E36C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9093B1C223A2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF202B9B5;
	Fri,  1 Mar 2024 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CLGjGWMU"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D6A1FBF;
	Fri,  1 Mar 2024 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709303888; cv=fail; b=ZGCnuJ4khP0Wz63aRjHJx/hR0RIZr3rqmQaG7w2Vv77HJen270D/j9XxgLe1aUHyNo583jgmYFhRHjTGgJekX9kY4QDvavytSKMVRRJgNyqYwWtchOnd9j2OcNlqNaPce/CKWFScpBbrKFEYFoKQh4oV6Nd5emfr8dSnbgsXMRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709303888; c=relaxed/simple;
	bh=+n5bJO1kjUsOGUiL5eTpfiBUT4qd9gYcXgiGB3KH2ow=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cAd5k9l+fwcS/gRX67EuFtJ1UZ1zan5JU0YWBoXEwWNhlnrO9WwTP0VWIemUEKK+nMcx4NufUN2Fz/kPgNOS4zTHOI9BNt6j+YWo5Bqk2Xy2fyREI1bkodFuG2zt8JUunQiutBLv56/vpjtOiWVR9IlpO8VqUesPp60Zh1ADAmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CLGjGWMU; arc=fail smtp.client-ip=40.107.100.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8KW+6oMLo9HzwUJCmD223Jn21l41QRfQ11SlIsJdJR04oGSefiqvwRLxszOjBhWHAnJWc7f16BNg34l9FyUVjUz77K9GXz6FEBwNEm8LUAJXbkqw9Eh/blum/NMFru3196XJRvV6qvuna0Me6OamwsK/S+vFtj6zbAgFsuUDsO7Cs3ySHgVGZNE/8hdMtNOvF1twQHPzADZwu/vIqpc/V0PL579n1uEUFB0ajceBH9YZky9bhZHjgVRdskzSs8WcVI8N4YRXONoZRds7MzHHUjY+FzrUuCncTBbRaMJMJQ37cBpL+rlA4WRlBAbOl7lMlj3NznioheMIKoL77ihIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9x2PIE7wx3EAWYqm4nOiur0KKaknJ1/NoQPoMETQ/w0=;
 b=G2z0c0/0crdP4WfAsCgVDcltHDV53TN23dJqjUmrLD/A9cX8215napComg8LhSVC9YYW6RNPufv4ieQan5tJuog7pV3L3Vs2n8uGOUq0OIS0ze5xvG4pMksX/2LKUHKlxriHzX3OGk1uTmxe47/EcsXEXWYC0UhLF+tbCtgaIUH9E3+wpwuT1Dv5m7UykkucnPJ6ydqxBzVWO/GQUl/528TaSRO1YOmovfRmelAEtKO5Jx7ugyh/aC3ExJ6LIrFE6Q2l83I4ka0EZM99nts8F0Ft63pIQk1OCHTBg4uJMnGLKWVbC55qKUS4eMQOw+l+aL0gcQGzb/H3CiX9KXnerQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9x2PIE7wx3EAWYqm4nOiur0KKaknJ1/NoQPoMETQ/w0=;
 b=CLGjGWMUlwAB6NrKZc7fcaIk5Xgfw5pDcoWCOdU2caUWxvvviMbHQSzr0ui/EED+fU+mY59HkhiLjRWGABR7tfu+3Mzh6/LZ5i6kbeYj5GKJYzkpshhC/D+2YZnboFow/2gwLUaXnAqlAhk19w0zvRw4uZbjRnuk1hgBzTRLi/w=
Received: from SN1PR12CA0075.namprd12.prod.outlook.com (2603:10b6:802:20::46)
 by CY8PR12MB8314.namprd12.prod.outlook.com (2603:10b6:930:7b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 14:38:04 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:802:20:cafe::9a) by SN1PR12CA0075.outlook.office365.com
 (2603:10b6:802:20::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.50 via Frontend
 Transport; Fri, 1 Mar 2024 14:38:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Fri, 1 Mar 2024 14:38:03 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 1 Mar
 2024 08:37:58 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<john.allen@amd.com>, <muralidhara.mk@amd.com>, <sathyapriya.k@amd.com>,
	<naveenkrishna.chatradhi@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 0/3] FMPM Debug Updates
Date: Fri, 1 Mar 2024 08:37:45 -0600
Message-ID: <20240301143748.854090-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|CY8PR12MB8314:EE_
X-MS-Office365-Filtering-Correlation-Id: 98a3ee3b-ed10-4814-a018-08dc39fd33c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rA4fzXDiDmTXiXtRO+J430iARbr/FoYIclqDRt0kGMKAAVhS9E/2Qk/udFDoz1p4KZ12KEOnxT/p5m8iCJJSURPWGEN1i4uEga8ofb4DwYMrt4s5DnSFTTC/SCS2UXyxDuYuoDElwC92vHFs7ozp+WhN3BLdKmckM+XAy3e7fffM9p/TF5j5xVRX7QUEBjD8jxkfFTDZEYu/BD1AY7snheuqUWfCvljPkLqoIUtQEw9cy5Cui/YKLxlPsxkfnCszvGWELws1P+ZyP0UCL46R1u6Gaq2+uT8tkmFrxaviSWy4EfqPRJvP7MNfYUJfkyOwojMoPn+19lMSE5fcmHGXq+Cwmz734twMWg/X3R9wuxPKHND1wUl9UP/GC8AqbWdVKOJ7X13uBcnXUgRHeYTWIa90xQ4eZC1Tv4esU4pGCCN8rMJXiqNpUuYu0Wj7BY0x5iBBJn1D8dQ340SvmFXYbkoR7H5jz5HUG6vzTumeeziwQkpCSWUM0L26TWSJ++aUaDbjUvgTwuu0odnMUED+n3Ut7OCzwfYoT0QzTqWcwajDM8UhkvfBFcIRgxJlhnNvUwWPtsupmtD/4Fu0XDwDJWq26rIZBSJUzeoWhgGe+BQNiRFV+BnnmS2JWRsesGoybyts9iqdmYlp9EeL/ReTtuajwD00fjxovJqMMReitj8OLNZyP/QIJLSgEKxf+KLbK/FIzlVjQPcIqEJquMuJfA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 14:38:03.7438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a3ee3b-ed10-4814-a018-08dc39fd33c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8314

Hi all,

This set adds two pieces of debug functionality.
1) Saving the system physical address of a recorded error.
2) Printing record entries through a debugfs file.

I'd like to include Murali, Naveen, and Sathya as co-developers, since
this is based on their previous work from here:
https://lore.kernel.org/r/20231129075034.2159223-4-muralimk@amd.com

v1 Link:
https://lore.kernel.org/r/20240226152941.2615007-1-yazen.ghannam@amd.com

v1->v2:
* Patch 1 replaced with suggested patch from Boris.
* Patch 2 update variable names and some code flow.
* Patch 3 rebase on changes from 1 and 2.

Thanks,
Yazen

Borislav Petkov (AMD) (1):
  RAS: Export helper to get ras_debugfs_dir

Yazen Ghannam (2):
  RAS/AMD/FMPM: Save SPA values
  RAS/AMD/FMPM: Add debugfs interface to print record entries

 drivers/ras/amd/fmpm.c | 199 +++++++++++++++++++++++++++++++++++++++++
 drivers/ras/cec.c      |  10 ++-
 drivers/ras/debugfs.c  |   8 +-
 drivers/ras/debugfs.h  |   2 +-
 4 files changed, 215 insertions(+), 4 deletions(-)


base-commit: 3513ecaa685c6627a943b1f610421754734301fa
-- 
2.34.1


