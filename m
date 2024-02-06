Return-Path: <linux-kernel+bounces-54311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2574D84AD91
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FC2F1F24B9B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E0F77F23;
	Tue,  6 Feb 2024 04:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VaL7QWev"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36FD79935;
	Tue,  6 Feb 2024 04:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707194101; cv=fail; b=RmCqZZVV8aYUlbLNQtA/58VMdxV0N87NuWgSFM/hSZK6L5Vw6hwYJuhphM5hz5y0T7LmWt5xosl7iXV3uJohRW3aO/9TApdEY93WDnnU71nlYGC/0pSz1V/cFIHIDwqRJvVJ4OPugylMXhcMaWZsFeUycLDTZj9LMfriLxSMgvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707194101; c=relaxed/simple;
	bh=parJunbqZZM7FLADqKwaaiZMdZ97E7FxPQ3zim1LUl0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LM7qzJQJO9cQtCI8Ej+HDL6UlhV8VCcO5NRWkMIOIV6yMFoNF3Bi4iTY8J48BjysMe55HsDuYWT3wG8AZmsiBQMaV1RkZV1DDnJReMxzyGTIMfiFXJRTbO7QnlsHYZsnIyuqYYTbEq2nPbjJ1m10wsatHlzYdQdjZFGFu9Zj3bE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VaL7QWev; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKpApr81BZq/rb6IzTxorzWpNjTBR8c0cmOsABROpxJGa4yAGwV+Dce1rm69puyctCpmsw3q/NQ7rDi5eYipJGKNqyjmGgEfJTCz8i4kEjETBw7XcN2NdOSJF+FWVgkWEWIv4NVPL2pRmjcgLjNKkMLow/omojZMPsJcfHO5Ww93b+JMCjy1fjLsiqP7BQcsKmX1mBe5ZHgkB4mWst7VJEKP1tr3cGa9OmFcRWUVxvFP5+g6eLRDpXQT/YW/WZFqgoT6vup2RAZDzoQfnlCiiS1c626qmKuF/LVahzWMH0MwefEtPDx9S75IBu8hQpFSvcanwI1/qARxinH99hoQlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1QpCmGfGhowPUaMtKNBh5csgXHDS1etmh/Yo0jzAQY=;
 b=mX9/y5Evjv2q8VONKXWO15SEX95AHsjncrqBNnF9IJ6meRdoWMpZnA1Bct40cVfghJJUkJywwbtx77h0WDPpM1ydiQmq7OSlSH8zsk5GEcXNv1Cfl/dmWa+xVC/zXQynlBrzeCozBhALh/VQiXfOE2EWz5//qI0F+KcK+2cRxcScVGJhIbtt9ZsDpUOrli+E0cXpdovXezwkAPPN/K8aGbUG/PBfMlJrWUn+mUeFLBIQw4V2grl5g4b1BmTa4GOiclqxjH1IBHeLvTU6HBLdB3N+Xavozxl2Njhf4S30iZbpgK5NmfFTMS7Zt1KjNIO7XfDKvnacaWNbLvo51toodQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1QpCmGfGhowPUaMtKNBh5csgXHDS1etmh/Yo0jzAQY=;
 b=VaL7QWev5WJr8HlUtHsQfhgQqPDfM2wFuFtF8gGGSQxyieMxxxSg39ceRHmyaMY0EIvnRUBpyoUc4v0hyjb1YxdlzflcBxXlHpXKbQsQUZ0wmKPaoKmbS/Fug8AQFGlRNzZtuWj/montl4QXdz70jZ68y/vflZa2+ylrGeGsvr0=
Received: from BN0PR02CA0022.namprd02.prod.outlook.com (2603:10b6:408:e4::27)
 by MN0PR12MB6246.namprd12.prod.outlook.com (2603:10b6:208:3c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.12; Tue, 6 Feb
 2024 04:34:51 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:e4:cafe::97) by BN0PR02CA0022.outlook.office365.com
 (2603:10b6:408:e4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 04:34:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 04:34:51 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 5 Feb 2024 22:34:46 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/6] ACPI: CPPC: enable AMD CPPC V2 support for family 17h processors
Date: Tue, 6 Feb 2024 12:33:54 +0800
Message-ID: <f6ace4124c45e523e984b4eeab3760b95a70b72d.1707193566.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707193566.git.perry.yuan@amd.com>
References: <cover.1707193566.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|MN0PR12MB6246:EE_
X-MS-Office365-Filtering-Correlation-Id: 26e52835-77d1-49e6-8cd2-08dc26ccf59a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UQfvcweOwcgw+nSCJo5EfVItlQ9EKjeThTRSqX7M/HQqGcWu1pnXImYyboNv3S7U0vwQowtMshnRxWpl66q13Br93bqPMOHedt8Lh4mDE8SjYKjb4s9u1WbztcffNBn74dCPJ/yItZkLcNTEUSaCKvPB44CxCvVcSuyJkNmULIiOenEo4ZNP5ucTqKgQ+LYsGKhe66kxvg+EJaNgO31k47tpd86Yq19Fta66UUtGmccAeGGf1QFIKp3sJ2bI6S+q24JUI8DUxjTBQnzyUYT0Og4Di/bL6OlJ+CFumJaXlWJgur1cB1XmCH1z5HFnQKjfLE+41Xgbfoi2rZtOgZuhrNlVqb366ORFThXNVcKjtKKn5h5jhA9p+wMj/n3Jybolo9uUomGE1UcvElLmnbLpEy0YVB2b7sZIM6EK88qyKcp1s/aaAQCnLpjabgTmnv3SYS6fI/Q0VGKYMm0mdGuVnD7o7jO/HEpY7fHvweEAr8nZ+D8UR+13fzfWN5yXAzwcTogp5+mV/MMOvUYaBZWmAcrRr+L8qedlSOcge5p6bHI6bYT57eV3SugLUb1T50WCnDJC02Zxo3IrEcnSQB+tW0ogqU50AQngMhhtOzP+KRh2KxoyB6PkSZlFDA7VaMVmNX+xKH26O8zwBtOoUuq6eNd9IWTzxkFVdb0MZ8uDtr9bXmqsY9onCzwb409EPYIz/3bniKsESgkNsZUbPo9aFH7091x7EY1FMolQVGuLZ15GOyQwVbdN0rnHUC/m+aG2ryY3KAIe0CaPk06N1P8nEg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(230273577357003)(82310400011)(186009)(1800799012)(451199024)(64100799003)(46966006)(40470700004)(36840700001)(478600001)(41300700001)(966005)(82740400003)(83380400001)(40480700001)(36860700001)(40460700003)(356005)(81166007)(47076005)(7696005)(336012)(16526019)(6636002)(6666004)(86362001)(54906003)(5660300002)(316002)(36756003)(110136005)(8936002)(44832011)(4326008)(26005)(8676002)(426003)(2906002)(70206006)(70586007)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 04:34:51.5029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e52835-77d1-49e6-8cd2-08dc26ccf59a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6246

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


