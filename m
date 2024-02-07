Return-Path: <linux-kernel+bounces-55864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC0584C2A2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56E991C2380A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D57FBE5;
	Wed,  7 Feb 2024 02:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DS3OX2lo"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E13F9D6;
	Wed,  7 Feb 2024 02:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707274010; cv=fail; b=B72YbUK6mlCQGfvrdHn2+U/R1pp4J16usKN1Y5sH5DdmzSUJImysdkHcfQjputv9qHtDfZ1gbVy1SoC9k0NsPXUvUqW9kjZ1ng3ITjZqQ1PPAaLYXOuaYUfEI54E3eTzsBbEhcTOBmadzKBdIfjVjgrtrtjJ/asGj0pbxtIk5mA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707274010; c=relaxed/simple;
	bh=parJunbqZZM7FLADqKwaaiZMdZ97E7FxPQ3zim1LUl0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfHdAXXmv0iDsHdQIWpH/T0ni/eZOz2dvONjJ32lXvGscY9yUDFQNGYJemWw24wB9HnSijtWyOKXs6g8hf2Gon/Gr8D4QGXIaOxKQK7Hb7MCNl6kaOXcMl/mi0lmMbE4VEeFsa3J6/IC0EkN7hTSJojQIammzvLG5MEE/PeWiuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DS3OX2lo; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gStXT9MI8tzOMm7SHHenKd/xVuVutGIepo0LCPIGzPiew4+wwDgU1uJ457wm+koqszoUfGVjJYZ60grOXRQBDvNC2iCkOpwDIs7P3R5JV1eNezEp2yTbaq77OJ2zF+u6oldnzJSZy4ClC1IrF5WKBHawoT3oGzH5rpspx1/jWT3E7u+TzvGFfxP0Gvwez/IIRvlK9w6PsC9ZaatpabF5OG9yoUjPBFJfyc5+VcO7CMjVQstzpA2T+gWZqjuc0xDfU+1P8kW6JzULDRNpppvsdiW50v3T02SBXUUBHWjOLGgUMCVC6MK0vStx31ol/TvEWAd18FHXNXLplc9cvJHP5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1QpCmGfGhowPUaMtKNBh5csgXHDS1etmh/Yo0jzAQY=;
 b=IL1uCqyknJ/HaoryPdnEuVdoUoBDQ4jg3HrfRoKRI1XVS6tAO/zTkulnf0mi/MQOCjn3pYHjQ5k0wOmXR8a0an/VRN0yGQnwzdEWoIgb2VpPZc71J0Z4Nn+hGlrls+n2J0uqBvrFsJ60HUfjOg0wxz+DNDTU9BsSRVejZt4hfY5GEDYfA1HW0cipVpE9uIgCzYNyVSMA1fW2Pxw+lGwtYbw3b35zf4JZKCoUs3KbPrQ3jH831j218VtBH06dRc2Adt3k+EJnUxqPR1zCDKpew6lTuM/nhW6sLlKDlXT999f7vH6HuTXy+1W6DR6qsLIfqtKHe9mTs2weRvWepIC4Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1QpCmGfGhowPUaMtKNBh5csgXHDS1etmh/Yo0jzAQY=;
 b=DS3OX2loiOSBzQG/90kMkx0H1L759baf+Ncg9XyVRQiPK5RXsRcatfUMxEuCKuFTJqH+nkfC2x1ypFfboRhst6LtQzAeTf6fvQpmTNe2v5tI75D22THX5n19BuRlYynanFMAes/gBsAT0EZM91SELtAtH1YrUdcBQqeCHIi9tPw=
Received: from DM6PR06CA0067.namprd06.prod.outlook.com (2603:10b6:5:54::44) by
 CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.22; Wed, 7 Feb 2024 02:46:46 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:5:54:cafe::cf) by DM6PR06CA0067.outlook.office365.com
 (2603:10b6:5:54::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Wed, 7 Feb 2024 02:46:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 02:46:46 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 6 Feb 2024 20:46:42 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v5 1/6] ACPI: CPPC: enable AMD CPPC V2 support for family 17h processors
Date: Wed, 7 Feb 2024 10:46:10 +0800
Message-ID: <f6ace4124c45e523e984b4eeab3760b95a70b72d.1707273526.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707273526.git.perry.yuan@amd.com>
References: <cover.1707273526.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|CH2PR12MB4101:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b1d35db-6723-4416-a1d7-08dc2787067f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ap6SRI2sSTOEro9nA9fHPuRa7NvUp/93LZ9xlEhInrJoDD6LFHj747mQ43J+KwErC6nRiZbBWJPMD18IOu2DknZcJnjjfBI3j67zaeFOi4E63vMk310TsK6+vPVhZ7sa8gCHh4vt6H8Y92VVNvvYMhM14v8EL9/FbCc0PavANt4GEwHDJwyf0I556iAc1NBld8ffIpp+OzlaB/adAIYAssd2FmRSaeD88wtdctbLITYAahR6McOojIp/+YaeSlRZ2IuhbCZpcIghuW4/ek6jPpSd+a4dq04ujz3GmY8sVEneoRhmswChBn9/ZFAzBvPMOX5pxB9aJQ7y4nOcVUVSbTGMIgNdwyw3z0E1G2YbuM2XgX/BoDLr5bZGD875gPFje3VQZKsAmg/KmqxXVekpOH486nXH6+R18qqxGsleRmRYp8DRVfwRljDJpx1hCGj4dXZRzn/gobFZ0tn4pb4hbqTQo1iJvjC2OvYUQWQZ+rlSeLztWUhx9jNAvfTB3xhMxoiFWokoN2e9NUIud5PFqrgMg86iiDrHbFrQgDGXytBFlnY4HzEFzF+jIQNrIUYmtv2wJos8Y7wfr4usgSa9LQLM6t3env02PEF+JfWG2QT5cn2PonBqyJqt3GXyhOjs7yQzLswT5Q3fD+gojdWqTTMWpOx1PWYTjOC+gfUSAI/eKjrCFuUMBaeC9aCL/fff3KVID+wTgfWuhFHORjaom9LP8s26En80L/ZxEZH9VlHyLpa7YXZcGlWSPcaoduwwciAuGzknEiUPy08sEHGhBQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(230273577357003)(64100799003)(82310400011)(451199024)(1800799012)(186009)(36840700001)(46966006)(40470700004)(426003)(26005)(36860700001)(81166007)(44832011)(4326008)(2906002)(5660300002)(70586007)(6636002)(86362001)(316002)(54906003)(70206006)(8676002)(110136005)(6666004)(36756003)(966005)(7696005)(356005)(47076005)(8936002)(82740400003)(83380400001)(478600001)(336012)(41300700001)(40460700003)(40480700001)(2616005)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 02:46:46.1926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1d35db-6723-4416-a1d7-08dc2787067f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4101

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


