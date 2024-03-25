Return-Path: <linux-kernel+bounces-116437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BF2889D48
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC0528CEB4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCE8179FBB;
	Mon, 25 Mar 2024 07:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aGobPE2d"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A256222AB83;
	Mon, 25 Mar 2024 03:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711335874; cv=fail; b=HZBU/ruhaPEYvPoF7jut6Pv+OtTURMoJjgcv3caktXI2su0MovRinL/aevneLAJK9jCxS/EwL7vgXTdoaA/rhK55bJxZfjGZg1qiKwlkr1ll+8fL0wZCjCVy7rFn8nam2ENeWzfandxSvm7YsyK3PTGlyFGvX21Jb2ekKdUHrgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711335874; c=relaxed/simple;
	bh=Um0+J0yaMX/a9vnllsb5rMCBX3DIXBTPnJJjMnw/pIg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z8G9x3CiRwVNxcTPhIPjxadXiKQpXg+c9KOTBcGRSrniwHhRkuRIp+xYaiWPiN3dpB/aF99sMT9KQzy1KyeBILlmbqkYGzj9a1UUuC6af/TWip9Ha2D1a3XTSeaU2ohRylmCW3Xwhlliqe2pv5ztL9exzlrnhhnTOCddgVX8IPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aGobPE2d; arc=fail smtp.client-ip=40.107.94.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D20dMr1QzRbf+DFE54ou3qnDBbNnme3LG9IfspIlkyoiRI5aL0vBmQNeC7BzyKVzaxz7D77X0aOxIii+bK0eazFSI2m8LfUGPl8xMHeRUG3iWdpEXrTr3y6TElcl+WS5KFDmy440eE3XBFkp8oyZLq6cG2OxNczqVnOl2zHuireaPs+ZnZHF0dTtxTtoQzqqPOH1/Urpy58p4fY4IlYuLWSA+XbwSRiTE24RzSWq3FsgaQmjPX2cd9ap+kJogTFKUaANR1YtyRkCd/87G9tCieYMKtJsZyZhosWspLcjYh9SpBWn/3W6CmhbKKsZWFmULszDkLVtKPTkAESIYTOgMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdGCKabVOMgWeX9gozE3KU+RrIAHicqm0uU9ff238Uo=;
 b=JvO2M9RH7ZyLKImCAIYE+c0AgsLSKNRyIyWUfQgjYkgZbYE33pBwcaAL9CvMebjmd1PYJKq2a2kvXWvi1+7eveRt8edR4lW6vXvW+Jf0KvQByVqFdzeTVEZLjO2zVgD3fLFe8ORsBxZLXjD0Lv1SYRD3rqUskzW7PTw8m3rhC8kkGvYzxtCLxe5atl5moC3YCcoYT7hNBIA2Pd1Tn6MF+rQBrOjUnMiLB68R/Li2e5GozP+ZE/FaVw7dAkEsDNu7J5uvJMtOtUH6Tdd4rdoeMs43vq2ZHQR1+kKd1eYNB6i/eea45RxvDvTWI6HzcR7NhPkrFvaPV/1coRILqmE2Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdGCKabVOMgWeX9gozE3KU+RrIAHicqm0uU9ff238Uo=;
 b=aGobPE2d8p7D+0VOVDtJEOIeU1AIzVe2Asv6CfT5Cs1tErPb+75IMwHncpG8YBMK1xhaVrbvUkbYL3mqAKxxgThj8UyZvXJCoj6bgs2yj3DsuHOq9Wvo4Ux+EVP90LNQnqPbTIj9opb3LQRN/RDRKi5iqyFaERFNwDPpD4z8hLc=
Received: from CYXPR02CA0091.namprd02.prod.outlook.com (2603:10b6:930:ce::6)
 by CH3PR12MB7522.namprd12.prod.outlook.com (2603:10b6:610:142::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 03:04:28 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:930:ce:cafe::98) by CYXPR02CA0091.outlook.office365.com
 (2603:10b6:930:ce::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 03:04:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 03:04:28 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 24 Mar 2024 22:04:24 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 7/8] cppc_acpi: print error message if CPPC is unsupported
Date: Mon, 25 Mar 2024 11:03:27 +0800
Message-ID: <bb32631f684446ae6380bdac0260ccd66290e222.1711335714.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1711335714.git.perry.yuan@amd.com>
References: <cover.1711335714.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|CH3PR12MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: dbc67aae-c4d8-45ea-d4b5-08dc4c7848fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4v47AhT8o4IciJxaWLAc0B8LWrL2ur3f4VWgM4GGHyZwHMYDAO/Mi27OqUPZy2UGYAM9z0q2h0cOKxQB8KYJ48j0rTTgifKqC5UEreZ6r8eCSBBAjPqIcuUfq37cmWKIMlyOun30Q1SJLRZhZ3+ROCA8P4m/nbqxFudcHuKjYejrA/bfR2LSi1zo/Igysb6m22oZhOEmV7d43rQm3zyGRu20k1LgYX6fFtOOf/coXkyGUmlxeUmag35y/UPtpuZfbMVGrWEeyxFUcfa/GN8oVfKX8cVXrJ7Wih+8/1VAkCvhqfkPNFTPp87jGZO0LaLwX6AU2AIpyzjxJMLa93zKmFev7nkzNFv0lBJose+oaXUBAB1Z0iaqtbL/oFZHpRK9s1f2qSqCCmMAPMj1BLlAZW6NvoKtkzu+sA8jkPa3CVCvXUIyhWyk/4F1IiYz1k930YhfbnoLenJY1P1DdLtNPrRwDlH92TZu3IT44SNDmHoVb/qjVBMcAhDs0lw80k3Lqj5WFQEjOx/xzoQ7ta9DBXZ6JONtLjDZvbXDXij2SJfkdmpp2BLgS+m/Sd/MSNC+331QSzPK3Krq6HJVJh8p4sI7pIxRxF4DHK5tWUhz8jo1xZU9BzjCY1cX0OVY60XrrXgbM5cqbp2mg/M74JbhGZ8yJDXU510R115e+yEfG74hgGVNt02/h/dodOX/7bC7Ajf0HT+zVWkMZ4dX+ctlutGU/ZLU+LJ0TdF08r7ezfh4hgA+JkoHfTmF2tTC24vR
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 03:04:28.3055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc67aae-c4d8-45ea-d4b5-08dc4c7848fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7522

The amd-pstate driver can fail when _CPC objects are not supported by
the CPU. However, the current error message is ambiguous (see below) and
there is no clear way for attributing the failure of the amd-pstate
driver to the lack of CPPC support.

[    0.477523] amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled

Fix this by adding an debug message to notify the user if the amd-pstate
driver failed to load due to CPPC not be supported by the CPU

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
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


