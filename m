Return-Path: <linux-kernel+bounces-53959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71ACD84A875
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96B341C29A4C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AFF14A0A9;
	Mon,  5 Feb 2024 21:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5se1P5TN"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E223314F9E2
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 21:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707167231; cv=fail; b=dmBJR36BYhtsSAmZbyC/94M3sWTjGhW4xcr7ejAebQYu1i+bWIS80/jPoWlG609c1tR9vz37sf326fpswtq+WAUmzeCCPWQ8/B3maLcAhRdf7IpDWqBkX9YJkbnsDFSMmoseUFgUqHD+Qmi9g6terzGjRa/ZtGYsRR2gpObyZYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707167231; c=relaxed/simple;
	bh=CgC6z4TNsDBTLdgQmucSvhktD8R2/G1GQbQUqg54hFM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ix95L9P/5vjO5ISBaOaSWXTCedL53+xZrS7BX+a5rIPWOfVCFX0ks2MpmldT7pP97Zw7rrTf2RT0XQnthnqZDtVxI3rCzgvH4Uzfdd3MUNNyMZmpiFy9SM53Idro4e0SNEz43EpXisJCVH06w0fs5pSG1h+RdjgBQthL/h/yKLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5se1P5TN; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APq+twKoeRWubEziMPOfvaxydcgKpR2wOhl2yq/M7TypFUBGcwydOlcr6QAmlDdcYg7eCZAPKTo1dWSdXtOs97bVGw6imfyjSKcN723lWROuwf+KDfdlAYDfIsun8ruK+hWLI8UIphF1s1kt5uVtvn1iPMe0Qfg7a3pzUZbHKiVQpuk9X05Usc4zrA+irRH8dr0advbqC2JqZrBiXiydC6MQxdszSadBH5EIqY/UUwOSzEdYBSgiIHHiZvTKYxri2dXZu3h0ab1SWeqbr+Alk2BEMqyXUY2yQ2axsUNp035XCV1nQoTLaivC0vIpHm/LJfHKX6iPV2NcTZlF9Qbsnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzEG9xIGV0cX876upWlGMOF0KKvCAw0ojVVI/nngwIA=;
 b=FMn5U5vhWnQ2y8tLMvGRlaCf/TfxR3UJg/psvRCZPnqq+h//vEVs2cS2yAhaaemC782HeASIsqSxBWnLpEXp6KhUKXeucsM1TaHpovDNrWHVXHKER6sQ8BjQ6Xtc/EV+RnFf85YjYb630+JoPjV8i4fSZserUcoYBQTruP8A0eZHuphXT+nBIofXOXocvK3I8ZBgnPYaQ/Un5tXIX8HbhcQHH/7HxOgNMZYA5Mu1lAEy5M6Z66B+VZ7Y0Ac1BU/6k0fhWl2eTifp/MzBkjMa+hM9zQaDy3q1EPZ4NAxn4LOXb272Hd/AQfptI9R8t9S19/AeBOBoWEff50vH0byrZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzEG9xIGV0cX876upWlGMOF0KKvCAw0ojVVI/nngwIA=;
 b=5se1P5TNjKS6EjJeC2H2RyNoEquAy33sxQYv39O6mnqxm9p1SQ8RUoq5gdUYTH3t08Ya9CU2ARFM4C2HkBCoXCh3npUjmPZI1pTn35NGR/QiWqOL4UM14/V3IyyVjKakJJf6cu56USKEh3YnS92tR/BrlMB5HG+gSxzkFgNKdqI=
Received: from SJ0PR05CA0122.namprd05.prod.outlook.com (2603:10b6:a03:33d::7)
 by CY8PR12MB7172.namprd12.prod.outlook.com (2603:10b6:930:5b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Mon, 5 Feb
 2024 21:07:06 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::32) by SJ0PR05CA0122.outlook.office365.com
 (2603:10b6:a03:33d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23 via Frontend
 Transport; Mon, 5 Feb 2024 21:07:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Mon, 5 Feb 2024 21:07:06 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 5 Feb
 2024 15:07:05 -0600
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <x86@kernel.org>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <dan.carpenter@linaro.org>
Subject: [PATCH] iommu/amd: Fix failure return from snp_lookup_rmpentry().
Date: Mon, 5 Feb 2024 21:06:54 +0000
Message-ID: <20240205210654.219442-1-Ashish.Kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|CY8PR12MB7172:EE_
X-MS-Office365-Filtering-Correlation-Id: f0501ddd-5a8b-4bb7-f20b-08dc268e68bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3y1RI2Z8PjxaKO2zMXn1aR6wlzwLDdMM+bhFhC8lkP6+bbEcnQAGyzhr2OJFdtSaGxTygiObO3XwSITR3SLQJxAglaRlNWX7MFvys5O3jfsbhLMuOJEcwY9kTA4ijrWj9ybw19VCbIguq3zEB6m3bNTp7ITp1OvEhPGeIZDKAHhoDLvUR0XgB8sscIYD3bORUqOj9JH2mlcJSD1cmdhMkNX85+jxAEK1p50n0BXvsGbmeRq66bryi/ORv2HuWtpa079/Pjod5TjjlbcML1DEe3LEHxEjx54LNJ7kIppcO/Hgd6RDfss6m5/tAz6gSb3a35mzsGMQP+PK5zsTrh3Bq6H49Ve47N9+bS6qxAdpeGo2o01I9Nko26F++AeRQK2Zp3PrKILgbJPPrCRjSqJrtnBu11OuQCvS7qpJ7ziUmdVYuCF/EjjeMQMr3x7DNjgByycP7R5dTS8jmD4phEDMbXRW98ygYYh6HYVBNvxAmQI33IMTYtr+Jclwx1fneagmIEHhOn1V75+e42vK3VvmyYPnq7tociJQPibolX8VgnexBK7hI18w9+bGcVVAt+KgeoKHVESRd2tYdWaJ45IoFrRAK2Caftgv0mmlv/SiL2jExKRjtTh/Kp9iwa+sB7Vn0B9fuMaQaP4Jv7cqvg62x1osibS/dYw5dPIP5DeR9rNJC7LpT5zG6x5vsQ49z1dHAnttNABymFbLCR4Dve1rnwGGgQnt/tFDYrWS7Azn9ejPyXnAm2wtQ2URfHbG7mPJA4WbICCdP3jHmnAtov1zXiEc0I2+TGCJenZiNWBlj10=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(230273577357003)(186009)(451199024)(1800799012)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(26005)(356005)(41300700001)(316002)(36860700001)(86362001)(5660300002)(8936002)(4326008)(70206006)(2906002)(8676002)(70586007)(54906003)(83380400001)(36756003)(81166007)(966005)(6666004)(6916009)(82740400003)(7696005)(478600001)(47076005)(426003)(336012)(1076003)(2616005)(16526019)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 21:07:06.2786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0501ddd-5a8b-4bb7-f20b-08dc268e68bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7172

From: Ashish Kalra <ashish.kalra@amd.com>

The patch f366a8dac1b8: "iommu/amd: Clean up RMP entries for IOMMU
pages during SNP shutdown" (linux-next), leads to the following
Smatch static checker warning:

	drivers/iommu/amd/init.c:3820 iommu_page_make_shared()
	error: uninitialized symbol 'assigned'.

Fix it.

Fixes: f366a8dac1b8 ("iommu/amd: Clean up RMP entries for IOMMU pages during SNP shutdown")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-iommu/1be69f6a-e7e1-45f9-9a74-b2550344f3fd@moroto.mountain/
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Link: https://lore.kernel.org/lkml/20240126041126.1927228-20-michael.roth@amd.com/
---
 drivers/iommu/amd/init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 88bb08ae39b2..11340380111d 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3813,9 +3813,11 @@ static int iommu_page_make_shared(void *page)
 		bool assigned;
 
 		ret = snp_lookup_rmpentry(pfn, &assigned, &level);
-		if (ret)
+		if (ret) {
 			pr_warn("IOMMU PFN %lx RMP lookup failed, ret %d\n",
 				pfn, ret);
+			return ret;
+		}
 
 		if (!assigned)
 			pr_warn("IOMMU PFN %lx not assigned in RMP table\n",
-- 
2.34.1


