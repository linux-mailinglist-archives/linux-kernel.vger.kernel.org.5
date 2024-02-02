Return-Path: <linux-kernel+bounces-49521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B40846B65
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7A228B3EF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBED0664C7;
	Fri,  2 Feb 2024 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rehtXhos"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472FE6024B;
	Fri,  2 Feb 2024 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706864215; cv=fail; b=nntxgTAAIqQqydZXa6eewEVjOMyY8MclTbrCRgq8Wql67ini1X7POyHZyOSGh06PSXMoaj7XED9/1gqFM0n9Es03feZzgx/+3mqLPXLE0W5w0jM1zgDIU+Zdu82SRM1bAlI0gPZ/sY4/hv6eFPThxsHUGUaICG6EFirh4rRn8og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706864215; c=relaxed/simple;
	bh=HhWObisBHcP2NziP1iSDlKspiezTgiPufW5TI8yBbCM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ViZVHFGdnNk3UPJVPIQ33SzWuOnYiOL6SXjEMc5RrnbfpXy4hv7cUM9pnEsts6Gko9VwUfiG8S9T2MgCQtOJZJzBZLuT80pbrB1tf1v9XUbbeawquJe3hAENdMxeiQFxSlDUwu/fk7R+nk6pCr8dKWEYAz0PFNarTq+BvX4VDs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rehtXhos; arc=fail smtp.client-ip=40.107.243.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckL+JDlB+l2xaXHyWcyKv4SZVE9QefEh16s+4xZA0PWB/qM6Tp3ATwXc9Go5K88l/5n3wgkTy/vY3z4cnJaCtXs+tlVjspM565GnGJNLVNzm/cX+2aZ/G+WCP0MYEmfPgG7bFb3S50ELVVd3HlLawlQA2/KfJ5PQVHOiT/551/odhQyNKCePXsKprcVMow3gYUmT0tQbrjwsyjXJwW4+og7nb6Iqi7o/OzqMV1P8c9+ARNNWrrfYzzZGIey6H9AHY2bUuPVABTnbfhV5OSbkR4WvjlE8FJR492qjxUs3ONwVcQLL8mVSVQfYretHjKSC2oInwiaTGZBeE7AMecfFLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ey39uR36EU8HB12nz/CKH4I8bpuhnyx536YWca5oaVs=;
 b=FqFUH3GhgW/oqS53TpbHMfMmp8XfLDtMiq1ujEji5KQTdLcBxKRYB6zRsXkkqZwtpt2kdvCvQsE3dh42FHsOAq3VZDAVh6IdbbA+phh2PQfBoS31JfO00wVj27Oj2LyW0gRMkJpIOEpuRFJrBo/x4llRhb1hOjyCSutmOMSfCV3BNxqnFJQzQ9gfY8yAXKASHIUaJqkor477H3hJfYrdEXKDVzf/lhSdBpVsFb034QqA3wseydSidAh6WNnTp1732SK7fcJOsXz+5PWCreb4sGFzJ1B1dSPA62/D6X70iX4RyOqVy8U2EswdeVZiaaePHqnoXUOeIQRoBB10NWhGjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ey39uR36EU8HB12nz/CKH4I8bpuhnyx536YWca5oaVs=;
 b=rehtXhosQlFfovfOa1b2lZvMgqs4a4b5OBcA9lT9i6LKPMYYOQJjErj2BH1YIU3Gf1qm2qK6knI9PGLqEYIVE4dSSETDZg4ad89qQADHm1ZXNRP6H09iZqfqzboDs1CVRC64K5nBEVbnLRXEgvxvYIw3HJquA2GsR4kJsx8i/1g=
Received: from DM6PR11CA0053.namprd11.prod.outlook.com (2603:10b6:5:14c::30)
 by SJ1PR12MB6289.namprd12.prod.outlook.com (2603:10b6:a03:458::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.12; Fri, 2 Feb
 2024 08:56:50 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:5:14c:cafe::b6) by DM6PR11CA0053.outlook.office365.com
 (2603:10b6:5:14c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23 via Frontend
 Transport; Fri, 2 Feb 2024 08:56:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 2 Feb 2024 08:56:49 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 2 Feb 2024 02:56:46 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 5/6] cppc_acpi: print error message if CPPC is unsupported
Date: Fri, 2 Feb 2024 16:55:37 +0800
Message-ID: <7ff16a39e508eeadf26afbffb2f621de180bcde8.1706863981.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706863981.git.perry.yuan@amd.com>
References: <cover.1706863981.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|SJ1PR12MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c63592-7b17-4050-71b8-08dc23cce4ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jgLmfkeI9x78FsRVl/irwIAu3Q1RFBaf+G1eelf2XyDVT/5//VisKa6JSUJhlqCh1Qzu6eeYt963gbYxFH5cG5yRBAqiRmoihMgSk+LLMAHraFjOmNdQ8M/tOPY9bYU/wm5kta3euRZpGL8+I5UFHeNr1MZs0Q+CrNUer1mZcpeLKSMPuoQrKJoxpRtYNOCnv6MR56hkFICMbbZ4SZprC0UnK5zCPZXhEYqJz0pI42cjv7U6FkrY7P2fFIyy1xD/qiWWdiV5E+/PiDf3NgMJOT7qEdlht2371nfZTbcyigGtPm3iFt+wbOEYQYwz7kFD8PQtO83pH6hs/oki8EiMlzBJM3wSqrRi5CbtZ0Q2RZwg1/3tDU9gyOjdN7CmIjdZ0vGLB3cLLqS+P75QkQQHTfZQT/e3bD6ubWd8WoC0zSnEOllORDbY5JYIUiw8nxA1Rd2GBJWlVRsYKj5dBuF41P7FEIrF7DS1XcXBmJptpJUdyraNg9+htgkB62fdlQ6uIsS0KxC2JYzDDBrWYKIpjXgrVPmMnp3rEMdQ/zaruU2PlaUUyQq1kpXZU4i72ZDzZhtPR3Uf5GxEd3WfUrkfNZjc4ssoYkAzz5ROb/b5d1k+l2i28RNGn6Dq5Q3Bu1tprJPN3VfG377w2y+Q7YlnWzMygszTq0ZtE7SObHQY+gJ+r2V2Brfh3KDsLtz+4Z1b8fg+/GDNibTsEFlWQK+uDnXJXbZw9QaWCf5SrIUNuB1NzCo+oNqjGodUYQfFiDUPTOrzbs+twmmg4EKBvNGLzA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(36840700001)(46966006)(40470700004)(40460700003)(40480700001)(41300700001)(86362001)(478600001)(36756003)(426003)(336012)(82740400003)(2616005)(356005)(81166007)(83380400001)(26005)(16526019)(47076005)(2906002)(4326008)(15650500001)(54906003)(5660300002)(6666004)(7696005)(44832011)(8936002)(36860700001)(70206006)(70586007)(110136005)(316002)(6636002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 08:56:49.7865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c63592-7b17-4050-71b8-08dc23cce4ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6289

to be more clear what is wrong with CPPC when pstate driver failed to
load which has dependency on the CPPC capabilities.

Add one more debug message to notify user if CPPC is not supported by
the CPU, then it will be easy to find out what need to fix for pstate
driver loading issue.

[    0.477523] amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled

Above message is not clear enough to verify whether CPPC is not supported.

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


