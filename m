Return-Path: <linux-kernel+bounces-57443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DA984D91E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 04:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D4C1F211BA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 03:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F5A2E3F9;
	Thu,  8 Feb 2024 03:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aw2xHJfD"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0372DF7D;
	Thu,  8 Feb 2024 03:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707364261; cv=fail; b=ZkM+jVX5Y5d93LuDKwOGAQtrovU0WTt3W/LO5wt4V10KhyQORMlrobZHMWDyOpP/jyM1qQPJYYTncBtk34TLKy1plrF44Y7uCUsO6bje9IHlzMG80gH+uil0kZdkuonPyp49kM3S25UfCNZBhPXCjWv4u0e43/CGKvIl/onvrGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707364261; c=relaxed/simple;
	bh=parJunbqZZM7FLADqKwaaiZMdZ97E7FxPQ3zim1LUl0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PeOcnFeGIZjvTM1aQCM/Y9kJJRVFnWqq12AX/6wccZL1A+tgq+FKrRhHbyY6j+rrC4UKgZ1k5thi1rZlB4glBE60M20/kp7uG4YtyckYm/oiLre8k+5E70VDjgkEzmcuipZ2SZq8wh8s/4WC0y64lcJgkDlKz/EoeUncTn05czs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aw2xHJfD; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P78X2N9uFCsPnrJjJyEjhE6YkCLTwSkHRp2EJnVcZ/zE3PGzSZEL9yiJ5gz79AWCb4XCug7aCgSzvtsGxpKIjtTyxFt+k5VqxSdOEtuNARKHPWx/+hOw6NqvsSIFFt1gIEEy0iIU0nXmIh7GCRoQImsopUkPQLvRWfgOdJrU7zWqXxGhXnnAj92PvECPhPNxgpsmmDbyNzGZY6FopqUilvSPklK+mEfW0ANaTVW2J/7sbhF+e/NGmVQRpnUiuSvqlqdsoVWvRXz4Rn2dEcNOfvP6lTJBs91BgjHjk1uZik7pXFpPk3GlZ8PAp6ED10HnVHZ4G4xZuPmIvzhb3sS/sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1QpCmGfGhowPUaMtKNBh5csgXHDS1etmh/Yo0jzAQY=;
 b=B2cKdInZr34YoBjoyaIf/SLpDQWRX37N0n7JCmq0/vhYyRq1feWw61BAMRnXcDkSY3AFQZhJHuQWN0NumKDh8O1vJgQ2KCHl1Q2VHF6+lHgvT87ST6TkFbkXYTWOB+fdryJxnEgjnzRkqS1dhZrKVavyrBtODc2+P/C1dnRn52QXYxZ8fNa782+L+GY9oAbielupVSQMiET60AJG6NWcdki6ITPTn9KUNCq/iDrXviGVzw9YBT/A5gLOwL6Ag/exRxdPnKj9R4me4N1g/oOsiHSaf5GhICnLtgseiPLD1p3kP4G9uz6qg2s0tEIRY8NoFT9GyVJgTJDX6vGdw/zA4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1QpCmGfGhowPUaMtKNBh5csgXHDS1etmh/Yo0jzAQY=;
 b=aw2xHJfDfSlyIPHbeHR5ZmPTeLSVt1+otu0JqdS2FL1c+8zI8ruujlvXwTvpGlqV+BDRDavG0ZVF4ckUGlu/f2/TUNwBhxXdAOvTOZyELn3LFZtrqIYsxmgKptrKWszV3GtxU9IwsPovQSKbOSQ/aVd99kPlsEjM0hXJgmF/6Vg=
Received: from MN2PR14CA0022.namprd14.prod.outlook.com (2603:10b6:208:23e::27)
 by CH3PR12MB8725.namprd12.prod.outlook.com (2603:10b6:610:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Thu, 8 Feb
 2024 03:50:53 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::86) by MN2PR14CA0022.outlook.office365.com
 (2603:10b6:208:23e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Thu, 8 Feb 2024 03:50:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Thu, 8 Feb 2024 03:50:52 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 7 Feb 2024 21:50:49 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v6 1/6] ACPI: CPPC: enable AMD CPPC V2 support for family 17h processors
Date: Thu, 8 Feb 2024 11:46:28 +0800
Message-ID: <f6ace4124c45e523e984b4eeab3760b95a70b72d.1707363758.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707363758.git.perry.yuan@amd.com>
References: <cover.1707363758.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|CH3PR12MB8725:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bcf8b26-fa84-4692-7111-08dc285925b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z6KMbRB0I1BVj44YpYD7sgghmEIOdMi+BE6982O0w0Juz1cANS8MsN9YEDlXmq6CcHNVa5QO4SMKcVs7kmioSB5pNyEfe+Qb/EucPr2QkimjdCsYe+z7jWq918vK2HgY6FAX3EFIRo2FGlHgGR1bbkjS8TUrI99y8V/SMvJJkTS1LIJESWghg18LyLgeIaj7ioZ1HYxpeYvq89D3IiXTJc8t3jOqTkE5F0XcSD6mI2z3zznqQ3aphhU+ri8NTb/FVGOap8WC646CccWn464RaHFXgNHec3zLDmxvOQwVHxWdX/P+ADnxxZS3/KDLEwml0/E/UHqVCMv21H7ItbThnM2k07jMGT2uRDBN0UNPbYk9r+Pj9zEHYyr/5L0Xv2yhHZEX6iylaN6JeoZaLCssso3nf9HymfzoLkhcGBKg6xh86DpZcrvMbJuWem6JZHN963j3nSM4WfDpagisvC12PuxdQPb6Bm4ZQl54k7oSBlSNWZftGgJU4L7c3LfeONwqnDF1DXFX7wtJEnYAyplhpWKVxG5bCsh2+lCifT5MnbqudKN6mfDfHuXEf4W4oEtLVE4M2BYV2WYg4wss2iNGKg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230273577357003)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(40470700004)(36840700001)(46966006)(316002)(86362001)(478600001)(16526019)(6636002)(83380400001)(82740400003)(426003)(2616005)(81166007)(2906002)(356005)(26005)(8936002)(6666004)(70586007)(336012)(4326008)(110136005)(5660300002)(8676002)(70206006)(44832011)(54906003)(7696005)(966005)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 03:50:52.8975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bcf8b26-fa84-4692-7111-08dc285925b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8725

As there are some AMD processors which only support CPPC V2 firmware and
BIOS implementation, the amd_pstate driver will be failed to load when
system booting with below kernel warning message:

[    0.477523] amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled

To make the amd_pstate driver can be loaded on those TR40 processors, it
needs to match x86_model from 0x30 to 0x7F for family 17H.
With the change, the system can load amd_pstate driver as expected.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reported-by: Gino Badouri <badouri.g@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218171
Fixes: fbd74d1689 ("ACPI: CPPC: Fix enabling CPPC on AMD systems with shared memory")
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 arch/x86/kernel/acpi/cppc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index 8d8752b44f11..ff8f25faca3d 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -20,7 +20,7 @@ bool cpc_supported_by_cpu(void)
 		    (boot_cpu_data.x86_model >= 0x20 && boot_cpu_data.x86_model <= 0x2f)))
 			return true;
 		else if (boot_cpu_data.x86 == 0x17 &&
-			 boot_cpu_data.x86_model >= 0x70 && boot_cpu_data.x86_model <= 0x7f)
+			 boot_cpu_data.x86_model >= 0x30 && boot_cpu_data.x86_model <= 0x7f)
 			return true;
 		return boot_cpu_has(X86_FEATURE_CPPC);
 	}
-- 
2.34.1


