Return-Path: <linux-kernel+bounces-151519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 693878AB008
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E661628499A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12F712EBE5;
	Fri, 19 Apr 2024 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y/l2iike"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C3112E1D4;
	Fri, 19 Apr 2024 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535311; cv=fail; b=XYU/e3sn/nDDs5evJSCAP+C+QPjRke7fPrX2P21hBn/zYulcNHcVkz6H7n+BXZgNwDsAKFsh2hmPGSTqyq5XKSdHprBWkLN7UTjW675WlthE3Nfj2RFupedBms30UO9Bg1jM+iJ+nixNV70TosjYeaCjp2TLiPAbjg4i0YfwDRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535311; c=relaxed/simple;
	bh=GNKA3A+W/mSEVPUWXNyyEyNjfSpyCV5NgwFYMjW1ceI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QrQVk11sCAatHx/faFa2Dnar9zoaTp0xL501KJgWIZ+Z1GJQGlCeCT9DG4NwuUr/YXCmKCa64w4rn1ayYBmRoStHGKS9/0qi+I8RheIOwgjEl3pdzO5aTN4y6zHa40lTymt3UErO0ir3ksBQmRMQSDxhpSbLfP9OhVawVCDIvCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y/l2iike; arc=fail smtp.client-ip=40.107.236.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fK2ESJ9pz3McGaUVMEaFzxzfhKnbJj8ny6U7ILRoF5BY6Q2MPttm6WUhAjqL/1M6JvnwyaagQKiJ1wvCue+XsxUkq42aYFN+ywuxHcBRi29PvPaPpTx3TUdPFRR/AAII0+D0W9XFxQvhdrBWyUkcPSJcoC2RqHLwlW/qMKLMMeL9MyUhlfNDMmKuUFnx4o0eGnx+y79fqZUovD45NnEwgPMk/SdgCd4wuqSwKz2VT8vyZhjaKIuYhsp9vlIvpnvUaUTvNYZKact9spgnbF/qBh7254KQjBY2u9xhxmPdgwRSYh62Ve53HFCe7Nt1pV/ohR9MsGbTAHIBE5E06JPumQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYVs89ZcQogWMm/vO01v6Pod+WSO+MwQ/DkhPWtiFzw=;
 b=gWZ2SZu2NrNhRGJJS1yCJM1jNp/+rYzam3LAqSX74TgNkWzibBGPtbHu+OHj6jTAUmZwiZizOgHNBQ0MTEYese7nrsIzDcH9plAhkv4zvNJbEj9oL801gQ9QkMveuRbjGcrrzG9MAcC0XtOokiSvvHP8lNObrswGtnbRE6bVsyBQ7m3KXZAP4+xZNu+gFgoJsOKcqdBtkphFK/r8AXzhTpTvVLDj6uFqZrXXBPfNR2ivqIq6opJzFaBwdsL+As+VeS/euWGOzmjIo2sA7NdPPPq19YVtCl9O/2/m+lb7YE4rZyan1p3/gfaYH9Q1Jl9VxSu3c+Tv2sT1/DLQbCAugA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYVs89ZcQogWMm/vO01v6Pod+WSO+MwQ/DkhPWtiFzw=;
 b=Y/l2iike6OtFB1lUQJJvhdPVwBaXa5d4doMHfLkhbGmsNXDN2cRVDi/npfMGb77yiaPAq2PY3VpgOVMhQgDEN68oOqS35CwGFlcNt2oC07tcCJTJhT3mgUOoP8Is9mGHkjS2IVBnvCMaucpeh6VOYm3zKWWNJtMG5TXeDhCBRkY=
Received: from CH5P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::28)
 by BY5PR12MB4146.namprd12.prod.outlook.com (2603:10b6:a03:20d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 14:01:45 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::51) by CH5P220CA0022.outlook.office365.com
 (2603:10b6:610:1ef::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.31 via Frontend
 Transport; Fri, 19 Apr 2024 14:01:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 19 Apr 2024 14:01:45 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 19 Apr
 2024 09:01:40 -0500
From: Robert Richter <rrichter@amd.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Robert Richter <rrichter@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2] cxl: Fix use of phys_to_target_node() for x86
Date: Fri, 19 Apr 2024 16:01:09 +0200
Message-ID: <20240419140109.1996590-1-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|BY5PR12MB4146:EE_
X-MS-Office365-Filtering-Correlation-Id: e7fa1408-88e1-45e0-fcda-08dc60793f84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vmvPWxFNz67oOLswDzAJtrtn3EeS5aZYt5HcggBbxlKmIzzp57Pnb8ovUihv5tb7tQcCnvoIix+NHbWE4hcaomzuHP/8IIbdbpO2KQuGWWoRwS61IArgdC5+F1JuT2ijzDgGlQRmR9UvzzqcOoOwERav+UJMwlWlDebZsE1ScL4SSlzkfQ/0oDZrz26qjSpaJ/XIfxTqHIlBPAlVwak7ejs/fa6s905IPCbiYx9pC9bnF4IopHu8IWO1JOvqPFLT/U+lB6J7OkI4iPBaqCcZi3YSd+p4jgWsY6N8blkwzIrtG2iOO1e9ck2cLnU4zaW3ABuEWB+IS5+5iKgB+EgmCT+d2bWSutayhhaulKuoj5Lkz0QbCdNFK9UTb82S2v1AC1HfFIYqQhzo3Ycc6UB0XmfRblrrEgrXAYnq+1ZQSlEQKqSUCcf554qz/eTZ59ozzzFX9cZunD0gdKR7oJq2kv47iqopkIRp9GZ3LZj3BOgTg59BpV9DHXtm9RA1m2T9yBvGo9K7+hpxVsJvlxAGvao7Dk5gC9x9oAkdojOqoq5hBmZ8Nk2P/IDF3MWMcpepaVryISRVk2uAd/pPKjHoh1at/abeZuOSxPXiOynBw+4cXF7eJmR/nK/J5xcuN84ffLjdHFdej2m5LbKxwU+/G3uSTsdWfcrSgoZu2Cniyx/B5z4FwCIzAztlhNJqhduytheCm1EB72fxXKKjMSX+UXQfNoXPFxO845+/BR5r0NSvr/ORa3qP7EE6kWg+QbCv
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 14:01:45.1350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7fa1408-88e1-45e0-fcda-08dc60793f84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4146

The CXL driver uses both functions phys_to_target_node() and
memory_add_physaddr_to_nid(). The x86 architecture relies on the
NUMA_KEEP_MEMINFO kernel option enabled for both functions to work
correct. Update Kconfig to make sure the option is always enabled for
the driver.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 67998dbd1d46..6140b3529a29 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -6,6 +6,7 @@ menuconfig CXL_BUS
 	select FW_UPLOAD
 	select PCI_DOE
 	select FIRMWARE_TABLE
+	select NUMA_KEEP_MEMINFO if (NUMA && X86)
 	help
 	  CXL is a bus that is electrically compatible with PCI Express, but
 	  layers three protocols on that signalling (CXL.io, CXL.cache, and
-- 
2.39.2


