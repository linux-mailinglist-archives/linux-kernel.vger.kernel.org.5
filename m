Return-Path: <linux-kernel+bounces-111712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CD4886FE6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9293F284189
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E8A57864;
	Fri, 22 Mar 2024 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LuS6Nlm1"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812E556B98
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 15:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122091; cv=fail; b=iecUE3P2mPrE3qpuKbhBAZxFao40pLiSl6GYiq4NoMr/LPzIcqeP85PoVdSfhyv5ouf+1mHMk9aUjehjY1Y+aH7iQTTgaJcACLJb7ouGoQVQd6/KrJ/KSP/4CPHJL9XqSrogqnL5I7Kc40864qpukNYvjTc0cO3dBoYtTif6Ha4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122091; c=relaxed/simple;
	bh=xoVafgk3QjQCmht70+kgoFlGDMRnaAmqJDeEx5n4z1I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WIpLR9BIGMuwrsoWe7Ydan0gY9KzYEZh719S1ITzXhxw6HlzCMPi0lkc8XeCtW+3lOXdxrfSUeVkjaGFjOPl9XivFK68q4JPITGYh13pZGJG7uJWTAoK+bFNQ0WsYMDevpNgamV1dcR8WrpJS+RBrNnF5F3OhxU8To7UahR9NsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LuS6Nlm1; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ao0Ig+ABS1nDQYqaG+DWR7beReg9chXXG5VqheGwuNMojd3zIHQ+q7m/SEwNzWtr/+qlhpEquygn9WfSt7RHUrLws1JuvRsPUSp5IIRHHhiUbdtSsoOCR/mSnIlOdsVf5MYKQyOHS+0onvXB4bobB3Wwx/fIB2V2BKsONh7YRigG1nQiDWOBBvTx3MzTokzIFOx8/9PKeAhfT08HxTy5alTrSWBa5znJ9ts4Y+Nj3KWifgOtG5JC3MGNlgRR4ioV3jC423v7mHU1jPc0isbuEWcTeeJRp9zv9caONJv02rpeLzgUfrC7oAps9QsMOYmWo8BJUw6keOMCZQbhJ6+g9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emC17mMzikZi/7/8+40cRDBCjecONATmt1kU8ZxKyzs=;
 b=GY3aUOueyDsBR9J2peoDTAe2vJJEDm8JsLB8PJ7X+JjxXtqGTWJmVaxuFvzhdNYe1exv5Xl0zl7AguvRbprtbLYFslsZTHsCc5KaIXgtbKTHSFzHR7TEURfyw3cQWdLOhw9siL3bfmnpU+RkTZYs74Gog51AzX12YTK4drujJGKU5Dgsuo7u2t+i1WcY/TrofaYzj+yiGyHGKK664MFUiC8TF8Re+wsxKcuiYWnVurfLyu1D+GsScGisvr62jun9HWrgbPpdKc+hK4JkhcKfMm+Q9zxretKsCrDaIBOxrH1pTpZTol5PSd/XnsNdq3RiimZQta5LMgD4Ae2Bkgixig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emC17mMzikZi/7/8+40cRDBCjecONATmt1kU8ZxKyzs=;
 b=LuS6Nlm12mtAnhTPJknWyYOcVJbh+yn03eCB9y4uZdeR0lxAtkfnobz1e/2GK12WbcxE4AaG5LljseEDHoQBZ9rKlGOuTHe1PaqTuhbGlcQWjfhbdevIVRMFIWtJghI6hqLpGzz+EnLiqWVWj9Dh8yc/CcD5NRZpZWqOh43pnPU=
Received: from BYAPR11CA0059.namprd11.prod.outlook.com (2603:10b6:a03:80::36)
 by CH3PR12MB9454.namprd12.prod.outlook.com (2603:10b6:610:1c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 15:41:27 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::9c) by BYAPR11CA0059.outlook.office365.com
 (2603:10b6:a03:80::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26 via Frontend
 Transport; Fri, 22 Mar 2024 15:41:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 22 Mar 2024 15:41:26 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 10:41:24 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Ard
 Biesheuvel <ardb@kernel.org>
Subject: [PATCH 1/2] x86/boot/64: Apply encryption mask to 5-level pagetable update
Date: Fri, 22 Mar 2024 10:41:06 -0500
Message-ID: <8f20345cda7dbba2cf748b286e1bc00816fe649a.1711122067.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1711122067.git.thomas.lendacky@amd.com>
References: <cover.1711122067.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|CH3PR12MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: 979eed5e-bff2-4b32-bf53-08dc4a868927
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RUQUYi0g2ghPzm/rei5K9b2nGGIVxHqwR4JFzj1qzVrdkhBDdgIhSeqZeFAxFdSH+cPIUCnxDvJ2E6l/HKf67ZpU650QphrSpOeATV3iapsAxRvfoBl5MSYT+FFmFMF7EtBUZxw+Ld+PBJAiO2Rok3/0vcjGv6roDpPovp064sCB2OGV8qLmtpMVBkdes0qsath0uKgnBf2S6IR45UWfqm/1ie7NUzfcUasvo+uz8M1WkP0UJmtZVI1IMook4Yd7Ib5T7y4QTsf6S6+EhRUR0yERTsT0rXeKnYK9Iqn5Md3unqB32NoPIyLnkn3trQJZuzvru/ycf09CFBcYcktUIR4a2JR6Ul8+NmZpUOiOknRoeEax6Qg0FSZDB/tE0hOJZI8HYI5iwylqjGNuer36B7r6WqzCrD1aP0s9pqeMaQScwlADvu7rlheECyDg+l7wNFXa8S52CUclvO5DN1x216R9rTkwSaKc7HcTLY3ogshN8GG38jfRa/+PvDKQGFC48qG+uJHKY0JJvrZziPARBFJy7URmiijufzp0Kpz58TcZYltfoFUGc+OrymZ1r+Zz3RfogydzPErde316NHlh8yCQdsc5s7Ge78/rgsBmCDNyMpl7A7L9rWTHiwCYkQVfJSGIG8Ca4YS4hL0XVkvpQUl//DIU7k5sFLIn6uo/gm7VVc9en777RdK7PlAAwzSJ3bIcsZ6Mhzz7WYqQJ1I2l40itRmK8C5/2XHxjZSnTNeHKx1YcWQEa7Whsaq4rDZs
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 15:41:26.4424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 979eed5e-bff2-4b32-bf53-08dc4a868927
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9454

When running with 5-level page tables, the kernel mapping PGD entry is
updated to point to the P4D table. The assignment uses _PAGE_TABLE_NOENC,
which, when SME is active (mem_encrypt=on), results in a page table
entry without the encryption mask set, causing the system to crash on
boot.

Change the assignment to use _PAGE_TABLE instead of _PAGE_TABLE_NOENC so
that the encryption mask is set for the PGD entry.

Fixes: 533568e06b15 ("x86/boot/64: Use RIP_REL_REF() to access early_top_pgt[]")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kernel/head64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 212e8e06aeba..7d2eb035b6a3 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -175,7 +175,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 		p4d = (p4dval_t *)&RIP_REL_REF(level4_kernel_pgt);
 		p4d[MAX_PTRS_PER_P4D - 1] += load_delta;
 
-		pgd[pgd_index(__START_KERNEL_map)] = (pgdval_t)p4d | _PAGE_TABLE_NOENC;
+		pgd[pgd_index(__START_KERNEL_map)] = (pgdval_t)p4d | _PAGE_TABLE;
 	}
 
 	RIP_REL_REF(level3_kernel_pgt)[PTRS_PER_PUD - 2].pud += load_delta;
-- 
2.43.2


