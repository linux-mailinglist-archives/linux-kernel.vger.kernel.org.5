Return-Path: <linux-kernel+bounces-51402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81580848AD6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 04:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BC9B1F22959
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 03:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C736FD1;
	Sun,  4 Feb 2024 03:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LqlMHrrS"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F6563A1;
	Sun,  4 Feb 2024 03:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707017198; cv=fail; b=uKn1ISM1/lF2mYMhl1d2W5dF9ISXCECYFLF5Ww23lQhq7+HSH+a/3eKX8N82Yl0snSPZr9FWxo1xxkjJpLfScJYMxRqTaxk2m+yDlWW8P5LZBRUwHygf93IbLN8H5Sn4vnGGLYb1Bj3M5vaCyTDBmPaKKac9sibiPLUkw+SUTS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707017198; c=relaxed/simple;
	bh=parJunbqZZM7FLADqKwaaiZMdZ97E7FxPQ3zim1LUl0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B2H18d3+61CUG3bveI3IcCoRinfjJdeqbrvpIee3t2eD99w4i5jRcI7UG3XkHHCayJnnJ8Vnnry3Jr+hPaAluN1SSZ9Tgnme5L1jh1pJe0yr2GM2zWLL/1L6x3qBP6OQnsYrA48gWNidkr9TVNvOiFdi+sBu7mBFqYnFC61Ye1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LqlMHrrS; arc=fail smtp.client-ip=40.107.96.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzYQ8LES+Tt8pFxgAkhtRC/VyFR7w4uTbOh4iwux5TEMz3d6Haugdwc8RPIcmPavC+2kiQpkMBtjbcGt0+atAF73CgujdqwOfuRJ/AJPxMmcruHxCgcwqomZlxfszSxNV3UlqTnu0BJHTwSbf0J/7aaD6/BAbz21iYuoIfjNIwwPkzmX+q2T5SFqHirfOQb8+ds9r/jjyMjWFGC0WiyT6aHqJp6sCNkuFVQpMOrYvghIjbcU2cMNYRWQfjxPjZvscKD9UQfLIACDRCcJ7PyWMrBGN7HC85Fx574EdLSJPKqZCDMzO0yY+j1Oc8fFKyRso0YC7EKU7Saw16iJFmH/+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1QpCmGfGhowPUaMtKNBh5csgXHDS1etmh/Yo0jzAQY=;
 b=XILRG/INGzblWInhyx3PKhMTgK84L/ngXBN6bnW3W/DXTCMvIYdfEqPmfeOaYU2P9ysLqv1QPNDksfgtoItvOnHxDd/Ox8B7pA8S76ndL31wxSvFYDJAEjJxUf9Huji1TSeukypoDatvL8Bwk+4OKoqqm75hqnkSjrY90uRoXoU/P3pyUZ7mJDCduR9SLbFTfCYc96pe+PKprt46DDdLyUSFGsUk4GPWYmubl5ulfsogrDC+F4YujIgt2DeLy5K0GFQcDSTXxRiE8WxGSdUsbPA7JhTgZdJDBwMO6ZKK4cWSnOfmB9hbsrBMvAT80hKSAvawekVaXpzYlwgzpf1X0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1QpCmGfGhowPUaMtKNBh5csgXHDS1etmh/Yo0jzAQY=;
 b=LqlMHrrSVxg+Z9V51CxiXTs1PSBk9/U7ohv/+yaPk1tk5V39g8WijWx+9ZasDxpC8/BsDYj3/XLdZ3c6LSKqFXBSLGYcf6nXfjZNMzNFBl/3CZp5Z2S/zihplVOyPySoh/pYgIFIPaw+KXtSbVlmtZZboh8neRLGO7aVEfb7Nx4=
Received: from CY8PR12CA0020.namprd12.prod.outlook.com (2603:10b6:930:4e::27)
 by IA1PR12MB7592.namprd12.prod.outlook.com (2603:10b6:208:428::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Sun, 4 Feb
 2024 03:26:33 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:930:4e:cafe::37) by CY8PR12CA0020.outlook.office365.com
 (2603:10b6:930:4e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.33 via Frontend
 Transport; Sun, 4 Feb 2024 03:26:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Sun, 4 Feb 2024 03:26:32 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 3 Feb 2024 21:26:29 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/6] ACPI: CPPC: enable AMD CPPC V2 support for family 17h processors
Date: Sun, 4 Feb 2024 11:26:09 +0800
Message-ID: <f6ace4124c45e523e984b4eeab3760b95a70b72d.1707016927.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707016927.git.perry.yuan@amd.com>
References: <cover.1707016927.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|IA1PR12MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a79c22e-6b34-4094-0d18-08dc253115ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	js41+cdrCfHTXHPHlYg/mtvPsDvEA2p+2eCuakaL/OGdi5NY8JHK70dvdoE2FAmgo3RuGKjvLGg3pCMbqFlT/LnOrL+Chh884gkAcura0JEoHicZVRMdrN5p/PgcPBZilLZMgjczzg/C7BC5NYoOaX/h2sidyQcD8nmkmKB7aUP8Gneh51HK6WwaSJJy3CkO6oMSXKJalt9g0F85z7Y1tZXGW29VqJj+Lc+4iyjGSdhhin4Y4RbMYVnK5QEX/Q6Li5zQxq9BXuneUoJe+vbFGDbmTec2KZJ/A5wetq9XS2HhuO99GXB1sqoCY2938QrKHStXikXC35uEzDrB9iqYLVShBcsUr/OLRncoBCLOEzUyOE8a0Qn7OQtpfe7ZHXRsqLpaT+Mx9yeAVsMLCMv18p3ym15DQB1WMooBRI1QCEl6GwkH0VxiJHuwJKo/BeET3gqThufg0MZHvuACSsgRWLfXI96NANuDB4S3lovNJxRBIVGAPNx2+7sqs+fOHcMnsnRS4dAkTMaelf64xRvD0zvZ+4W2/MoeaJXhVEqd65+alvCJQ7zZwwBnswZ7ELqGlMtWtjHKLs4vCVQ5sHQ2dAHcQovFY5GJ/XZbcj5qN9F0GLH9P1wkFD6diekMUap+4BF7muascaOGgmG8/RIa7U+vW4DMQxcMUorGsxNnTCa1jD2Iy4xmwPT4sWJBXnDJ+e6IpsIZnay8hJ6Pn0bbgb6luw/bgTMmr19WTm083aR8Z5IcWtsLxJjCdxzf8nchjIe8+gDImpj3tauIIcJ7hQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230273577357003)(230922051799003)(186009)(82310400011)(451199024)(64100799003)(1800799012)(36840700001)(40470700004)(46966006)(478600001)(86362001)(41300700001)(966005)(356005)(36860700001)(83380400001)(82740400003)(81166007)(40480700001)(40460700003)(26005)(426003)(336012)(47076005)(7696005)(6666004)(316002)(4326008)(36756003)(5660300002)(2906002)(6636002)(8936002)(8676002)(16526019)(70586007)(70206006)(110136005)(54906003)(44832011)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2024 03:26:32.9959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a79c22e-6b34-4094-0d18-08dc253115ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7592

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


