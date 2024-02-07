Return-Path: <linux-kernel+bounces-55869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22C584C2AB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C15D01C24C07
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4537CFC02;
	Wed,  7 Feb 2024 02:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M+bvz+ep"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BD11CD22;
	Wed,  7 Feb 2024 02:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707274039; cv=fail; b=SWgChxA+ypDLcJQ9Y4emF+A3e7uzYhG0DUFEUOpeWumsf24c5lFWy6bZWGbn0WxTVosFpsK/o8B20AyjK3StcoJJBowXbImDToAkbhKc9Lc38s+3LZBFyUVLmpPd+O2mZL5AW1Yr2GxGp2GpQPanRbYC5rBH53ZZu0BYpusP/iI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707274039; c=relaxed/simple;
	bh=/faDvRJteyXqZPRAcoZKXoQ2KPMAH3/GzFGupp3EFhk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cZeD4goV8d2y1hi1PlE974dAxXqfebhmanj0iOwlEJFKr8vyHValrAUhuLVEQOcNY4tpOPqwKe9DZB9fu+yNM3wptpTTM2pFXQqq9h6E8MLIfGAGwpllyJC09sDp9LO5ZJSns2G9i8ziUc++E/U9Tfp5gCu2ByfYluHR3c06/Ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M+bvz+ep; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jd7/0Sm8JSXfUBvCovPttIBFBDA3x7qERmoAXbMUXyg7v84G0GRlCBX08bjM7WZr2G52m/68fAEpgsnqYOnyB910yRXGgntPaItBeEBWHZGbtQoyJhWt+fe+WRDv/fJM549WLMEqPGVh3ocxknrMXSx1bq4paNEM2ZpucHYljp2iP88wBZnQqOjp7RTUii+vbe/hEDvSE8bBjk41hOB6Gc/6QIeEC/kGte6Y6z5xZAMN8VAwDcpHs5s5/gclIbAO+aD+mVeIautIZah7Xr6gsrDYPLFK/w9FUS1tP3MaVzR03I9h6lyLtiZ3Kw7BAP4PCjVS7vv9sIZJGZpFR+mG8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gy9SNyIn/2SjYTda9oDK5zWZekhmoOyMuf9jAWZS5R8=;
 b=RzeonIjzXUuB7IKo2MjfE8bq9dZVt9PhXZwfYNdPk6cQm2Yh4i/NfvzIe5FSpzWeVax8EFZS/hgEnUtTJnaXkyC83NKBBhqBCzC3D3onqKodE7HIxuBRELb4mfdLIJaNDRNyhTRgmXzqd3dD5TIKvyxwItb3XEOpoxZ2oaMNTTeZXxJUoEkG0xPqGfp+xhj7Hy/gjtfehLVuBeybFOgNkPv5/SdMsFYuEyV9NPVDEQoCHeBS8y29PjQxF39rAdADWLoSp4kFiBNta5s2teMpraH9z7LEL+ZMqZ6+n1P84tandQpiYaMQivV/XxAjYk0vi+MxfJAUS/mzVIC231JPew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gy9SNyIn/2SjYTda9oDK5zWZekhmoOyMuf9jAWZS5R8=;
 b=M+bvz+epJS9nlisX/LmfhdHQQBMKmHMnVYDMkQxuz81TadTw5O1qCO4RJkSpKjcKjVJyl/3DTsISx7mdk/Z6zBuTUV9MjuJg0CR/95iunzBWbDVFqUmU2w3xJ6SDeCdG+0EWK8KTu7pMwZ2UOXBNME4OX4wmHNsc2RE2kM7Fbg8=
Received: from DS7PR07CA0009.namprd07.prod.outlook.com (2603:10b6:5:3af::9) by
 CH3PR12MB7642.namprd12.prod.outlook.com (2603:10b6:610:14a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Wed, 7 Feb
 2024 02:47:15 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:5:3af:cafe::23) by DS7PR07CA0009.outlook.office365.com
 (2603:10b6:5:3af::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Wed, 7 Feb 2024 02:47:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 02:47:15 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 6 Feb 2024 20:46:54 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v5 5/6] cppc_acpi: print error message if CPPC is unsupported
Date: Wed, 7 Feb 2024 10:46:14 +0800
Message-ID: <2343f6c652bbcfad9cb462b5fd05fdb49e833e1f.1707273526.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|CH3PR12MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d129227-649c-46ad-6351-08dc278717f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+5lAthID1do5EgjC7lIJ44UwBqqRrZeIJ/ofUzJrEiOOHjgU3PSGvPKL52xCLBtI1bjR+wpVx+PIwsMl3luEuRZGHAMyJfQ9UFAuNZPR+fQAGKePbDHfKMGi4XrtwFIzL2ikM6k6l/dObGAZCzfVizn3wDo1RpPXr/fFrwLN8fBVUlLpsYMLGUNQ6owHcecsZRDf8LhRY69J74hxeLeiwmcB8tzW8H4J4LanG9tZq2uAHjOKqBHY/Q+R3ymU1YT5GJFHj4dZc0j8QCVXwQSoyjL5LreeNF+5bPIQ1AfPPMsR2BblaEkUJXlsT9c6M6gBUUZhFcdSSbft9R8Qz4kyy2NZSl036xmlOVINnGcAd7UjiJhKc20HaveHdnQ5A/5TQx6QatDNzmstOgOEULhD8riZnEjD63lFQkpDpTO8J97sdr3qT1NM+hM5cqKY36H2290S1aEycNESusYjmU1WZr0zDSX/L6n8jqPf3UDm0udLmZ1SGn6V6JICjh1RgvqYnL5LPSNxe8VKyF/E2fqCgJJsTfQWQael5vYWO4lArQUSCbm/6jKOA1fs8Az6+u9cd6t+Y4aCKj+UTQfIzq6d1sVsdmRxhuVBSVmS/6Hb+4T9n/eKpoybYK3fGI7As50NjUmE0rgs4zSil7e0q+/X9oj63THIpZsdCPJmfd/ZWlxu4bDOtoLpozspktNOvNid802EoqfZxnmwvOaBTMOr5yTlSlKLrgXA9UYEgwQtvWc3JQOax9YBcviaXtp9dR1IKqklUC2DVmDRE3+PTpTTIw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(82310400011)(186009)(64100799003)(451199024)(1800799012)(36840700001)(40470700004)(46966006)(36756003)(40460700003)(40480700001)(41300700001)(86362001)(478600001)(81166007)(44832011)(336012)(2906002)(2616005)(356005)(83380400001)(47076005)(82740400003)(26005)(16526019)(6636002)(36860700001)(5660300002)(70206006)(7696005)(54906003)(426003)(15650500001)(110136005)(70586007)(8676002)(6666004)(316002)(8936002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 02:47:15.4074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d129227-649c-46ad-6351-08dc278717f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7642

to be more clear what is wrong with CPPC when pstate driver failed to
load which has dependency on the CPPC capabilities.

Add one more debug message to notify user if CPPC is not supported by
the CPU, then it will be easy to find out what need to fix for pstate
driver loading issue.

[    0.477523] amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled

Above message is not clear enough to verify whether CPPC is not supported.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/acpi/cppc_acpi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index a50e70abdf19..e23a84f4a50a 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -679,8 +679,10 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 
 	if (!osc_sb_cppc2_support_acked) {
 		pr_debug("CPPC v2 _OSC not acked\n");
-		if (!cpc_supported_by_cpu())
+		if (!cpc_supported_by_cpu()) {
+			pr_debug("CPPC is not supported by the CPU\n");
 			return -ENODEV;
+		}
 	}
 
 	/* Parse the ACPI _CPC table for this CPU. */
-- 
2.34.1


