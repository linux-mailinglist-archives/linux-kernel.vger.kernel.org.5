Return-Path: <linux-kernel+bounces-101312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7F187A570
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E66AD282DF2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208E738FA3;
	Wed, 13 Mar 2024 10:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4Dcgo7pD"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC26F3B789;
	Wed, 13 Mar 2024 10:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710324060; cv=fail; b=kiJe8IbHNgPK8FiWo0etPKvTU/PEuHqPabKDCgTfHnr533N2BaZoSf7Swy/Fxv4TNvK7zVaz6gIedaQ9DVKLIe6OLSyH3ZHNWEZ0G8RQm2oz4bt4zSJd+sVUawdSXwRBExsnWKIZ4EyXqEKXzmpc9jogD83/ofwcTbdeiFjYGCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710324060; c=relaxed/simple;
	bh=9YoPGWYOTq1y6dA1LU0T/TdhYJ48Ig5mU6lWLRZEGb8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kzqW4MdrBOD+QSbZMczONCXbEInVPaNmcbDEN/O93sqhhSUGAnRD2xpyChBil6aDOvZr65SshzGBErfyfPtgz5Drjreynt0WqYz60kQav0cCJ8Ck42aQXENKWdI6Yac5duM4plH6V7nUdjpWUiIDT4zl9O+3dfO49NzGgRsZCk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4Dcgo7pD; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVKjg+t8SAz2MUEo/ghW0YiN6klm4eGCb56WnspI41SzNqpRbq+8wKom8FC8zYySqGjDtW41ZeNlMkyntk3JTA/N3dVeb53b2dbSyolhZWOaeEL0Ea/ZqzC9pUHONk/vQzmBvy7DelRPKnbHBaDoWaJCRX4dMak83J8GLIbB6EF5v17q/VTh830SJEhyjxmyxViPnohciYYmZYVl9c80VZKl1DqoUuluDG5C+ppFznmH2HPVz47QBSxPwX3+XBebUIugft4xDqjG+k30lIHQOFoI4xp5I73oJixdQQuxljkZgjqhKZDAkXtpGfAfetjwa95o2VBPVzmKVNvGkUFfGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TiAzKpGfOKUUmWTICLDcNebWFXhmKkI5ls4Zx1iHmcQ=;
 b=WJdjDXj2GWceFo+N0+dWIvYn7/aP3KrBEzfvU+BR0Y2rGWFHVXhRhHctrvV+Ui4rQ9ZRQA7LwPR6JYBG3jOC4By9Dc/7kWYb4jMhGP8ub5lb39CBMARh/6xaWfOVNxcjjiXOwSwzBqKJC7XlcLiSFQxPZlBpAepOSF4vGhNfIGF4bhuBAW5YA687uPYAewg+PA4AFlIW70kwZ+jG535ZFkYPsIWhyPUuNioun73zh1r07oYVLknKhsOrKRYQCz2BplLyVRu+J3xx8yvKcid1LP2i4oKH5s/T/4pSYnoRUk7pS0CmIu6WMxdiEf/js/vd/429Z8gB846JN7yVPih/VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TiAzKpGfOKUUmWTICLDcNebWFXhmKkI5ls4Zx1iHmcQ=;
 b=4Dcgo7pDutmMFFjfGlMJ7xd7qtmb3jJz/7h/sqLKpvYV9DaRtggpGRR+xM4YXYxbcG+d0LyuyfzBx/YOQGt1dvbLM6YKqbS67Z4WpIiWZXYMzyGvIz1DcZH/flbQ9Ftbq7NRcih8o7IsU4G1w8El+OEJyO1rIkrbHooYSx/mLLg=
Received: from MW4PR04CA0078.namprd04.prod.outlook.com (2603:10b6:303:6b::23)
 by MN2PR12MB4407.namprd12.prod.outlook.com (2603:10b6:208:260::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Wed, 13 Mar
 2024 10:00:53 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:303:6b:cafe::44) by MW4PR04CA0078.outlook.office365.com
 (2603:10b6:303:6b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Wed, 13 Mar 2024 10:00:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 10:00:52 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 05:00:48 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v7 4/6] cppc_acpi: print error message if CPPC is unsupported
Date: Wed, 13 Mar 2024 17:59:16 +0800
Message-ID: <4bb45bd64bfdf3a8f5a3bffdd8b5475474d9609e.1710323410.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710323410.git.perry.yuan@amd.com>
References: <cover.1710323410.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|MN2PR12MB4407:EE_
X-MS-Office365-Filtering-Correlation-Id: d4b20645-7bb6-4cc8-7088-08dc434477ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z7sREojZoxKunMTVilBH5bQPXLErFoUwyn5nxPUR3sVaeS0tLUHlrrKRePDJsWR0zMvG0iVx32ngkL3ms7F3KI5MeICn/cnTNaOdsIto5cHKaAyCN8IfzDPZM+8lKUJak1nlIKtqPFd541KLbiMwNM0yWXM3ItvMT/N+TT6xJqc44ubwQVKNN0HI4UC1l0VGVSGKlrX9kyNU604PPSc3Lq5Bs6RxDQErhUSswJ2QHaineUqqJ38HS1tBa2lF+//nu1AW+FXalgyoaMzQmcKn9hq3bIfyueh1IpVge6GNABDow7cl7UOcaOWzmtlqsYfsb32s/DyvmRUvFsEB/7r9Z/VN96/piAkry2LPrzsXQ9WsVb7dOypSf84bab8cirPPAXdGLHxfGWAb0PV4QWfy//rMyQ/PoqqdybUdDnFqJPeD//uehABNpfa5BXW/t/bi9og5mqP4//gO+OlNrUQworV/9rnYtvgQkcWX6Cyg+aL5joFMlhz8D3aFU+LIYq02GYDNbmlHHqkW6D5XtsL6XVHoEzt+ww5+UaibMBoMzCHsWUjyn3pLN43S8sKf6hlUzDOOZjVu9KgCjjJfh7KwCoZ9nQmlKBkT2EMvEEQLh80x4IDHWTJ1l3Tymu76MSxP6RUGRYbM7v5YGSiboz9A5h7FSJTb5lhkeZS2c7K6ciD/V8NugciyQVr8ivF1cxqY9P72VTJWgZ76Q75N//llxPvAFvAl9lBYjZdBupAOQM/iIAmBP0jxP+Zb1PPuTZtp
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 10:00:52.7313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b20645-7bb6-4cc8-7088-08dc434477ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4407

to be more clear what is wrong with CPPC when pstate driver failed to
load which has dependency on the CPPC capabilities.

Add one more debug message to notify user if CPPC is not supported by
the CPU, then it will be easy to find out what need to fix for pstate
driver loading issue.

[    0.477523] amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled

Above message is not clear enough to verify whether CPPC is not supported.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/acpi/cppc_acpi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 4bfbe55553f4..3134101f31b6 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -686,8 +686,10 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 
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


