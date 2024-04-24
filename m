Return-Path: <linux-kernel+bounces-157239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E2F8B0EF4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 248AF1F22A26
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6F015FA80;
	Wed, 24 Apr 2024 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jpp1lLw0"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2068.outbound.protection.outlook.com [40.107.212.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED5C1422AF;
	Wed, 24 Apr 2024 15:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973701; cv=fail; b=aVDBPyIWyps0z0czZHJKf/YsZG7ySdYeZgII5oHDlIjZptGZlvY6wSdz6VoUO9ORy2effJpAgDYuLGDfRl9Nlrh7JiEz7v13rYO8aLyi5chYTBWVOSYo23agrfSfqMNUBy6nP538TRYHDa0HnCMjhErtdgJ97hoT7R0lE8mLUbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973701; c=relaxed/simple;
	bh=uybOIUCxMTlv1e3SKikdRa++RTMCGeweIUNooHSov+o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EMRtFTvdGfpwjMT6swgL9RupuW1xmMzOpVD7z0+AtCpB7EX75EfrdtX35SsG+Ts+AS7rIaCiL/Ht5Yv+HRlDKM/s7e/pzLRgOieZNfR0c9I74VItCQ3toR3MIDVBylOSTkj+PHwtlEJUy0Akdqs35/8pR4LpeDxeNcJEHIMLW/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jpp1lLw0; arc=fail smtp.client-ip=40.107.212.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f++1l4h+9n2/v8L62NYSByou46x4ZAQnQstgQzB0Z6g2X4rNBWY/UFyWbQ7X4hhhGHdbKZzFM2S0z1LS3i7BzpXcoPvxjCktpTikU4voQVo33Zra+N9rDeP9EUjgiF+7Il2bmHen8sP8VHQOOXE3D5gw2PghKMj0c9IrmzFPdX4NfDAukDhJRzUPq66Lq6wZP2dAuMd2RVnFdQmRWwrn+MCUasRI5Pc/GkW7OmxYqpQ7+IiTAkRjr2i+ozPXePGmMCMEVj9nzcEBLDUEtHcVzh5fP7pqgRkXuB1x3HisHwdAFJIzZFpdNzV7ajnUNamWSErs+jxa465VTT3LZmAEuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEC0AQq0/bXKW2JkqhAeSnlczwfQFfyePEJguCmx1CQ=;
 b=AGsplYTgRCz/E4xpDhZtdxF+LBXoDyCzMn3NaPb93FWFP7yr/uBiiv6+5vS2L3YQvvYdpR1IWq2S9IGmrdXNasNWbDvRlt8jBRFriaQ5BIY0/2j7Tk8PbLJ/xr8fnj5zyQmbbFgLfERWHRTSfH3U3Sn64KIqhS/EWrM03qh6PvlyjIAhs8QXJ6V/x/Ft/YEJ/NuwIQtsbIkf/bZYebwhdv3vxbo3EOOwkgQHHpE5pgmlXufl/27m843hrQwFgnMzP/3j/LMycyNF2nIJMBkUYeMWlK8lmXZM7Q9fxsnTRUktlT7jeXg7740lO59dU23wYTWVQMEOIuPVq+dY2Seqgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEC0AQq0/bXKW2JkqhAeSnlczwfQFfyePEJguCmx1CQ=;
 b=jpp1lLw0ToE+4sKMoK2xUJAQIquGwvt8c0NVsEoQa+T/v57/HH4EnuC1JUs/aW1TawId/5XcmJ6zEGkdW8/Sxvl4CuzMtOftd5NFebay+MruZa76+b2DbH1zzvj/Q46bnEF5wkSs41jjZRS2c59WVdy0NOR0WdiEmNXGRiSJ0oc=
Received: from CY5PR15CA0191.namprd15.prod.outlook.com (2603:10b6:930:82::13)
 by SA1PR12MB7127.namprd12.prod.outlook.com (2603:10b6:806:29e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 15:48:17 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:930:82:cafe::ca) by CY5PR15CA0191.outlook.office365.com
 (2603:10b6:930:82::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Wed, 24 Apr 2024 15:48:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 15:48:16 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 10:48:14 -0500
From: Robert Richter <rrichter@amd.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Robert Richter <rrichter@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3] cxl: Fix use of phys_to_target_node() for x86
Date: Wed, 24 Apr 2024 17:47:56 +0200
Message-ID: <20240424154756.2152614-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|SA1PR12MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f890ace-5b2f-4447-f134-08dc6475f55e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jX4Epq35IAMgKMp/1A3XZKmAcChHpLn9XPGEdvMoy9QHTAgifnubx78P4M7E?=
 =?us-ascii?Q?kpjPj5EbI81sVmbjGwjjBM0Ar137VMqeLp0eTQ5wbQFOKR2teTWaVKoTVmFK?=
 =?us-ascii?Q?GN0GpmxP2g8exAEWwhTsINvGk+7B19Yknzijmka7dJU21wq4ykUk6dDgY9Pq?=
 =?us-ascii?Q?lf90Rh+fkVG0vyf7Eh6mNwtVZ4tULnwkPmf54+pJRsxhyM2muZbbrMiuqHpP?=
 =?us-ascii?Q?eyDxNhDyND3tyFrFVxUZbRbxugjovOmUH8WEvK/RayHmHxMOaTBpxfU2lhmV?=
 =?us-ascii?Q?xPlz2VFmkKdIJvQU40KEXr3Z4abiaKlVXTLKCTTpYdu0PBSRx6q4CSChrU+i?=
 =?us-ascii?Q?5AS1YQfA6OjDXEc41J+cckJDkQgAqo9D+2ZCS7nXdmkrCHGnF8q442iF93SW?=
 =?us-ascii?Q?9pG62G5V/ZElNx+iZKSUhph+BHH3VQFJXj4D+l7BF/v+moo9l+KvduQ97qWo?=
 =?us-ascii?Q?BCi9PBwrJIkFvkD6WFf5WerAc6ox2ftuyYpsyyW8cmYAySnIzSFG4oz4Uumm?=
 =?us-ascii?Q?Kda5bnIONGb2ODTdPhtXodUZaJwkRa3cBn6NF3TPAm31IZsDmccUrddyxjgP?=
 =?us-ascii?Q?ncGf90vF6yFNdUnIn6D7S1dBsrcuZrhJmdJ56bnp/iJ1i9gJbf5JwIpX4jPS?=
 =?us-ascii?Q?aUqjaxHsEOrAjw9GIDmD9lZR9m20zI2EXZBVexIruBAwL12R581029mIH2/o?=
 =?us-ascii?Q?lJIvjtfOj6fxGn4sOapKWgZ9rbJJ6MeOeW2sXqMnU2uGyvntkYOzS2qPIxMK?=
 =?us-ascii?Q?DeqWhBqtsIz/sj5fN8F3390iP65vsbNknZaH+g/XkjH8WDK+fn+edo2rZNDx?=
 =?us-ascii?Q?wGWka35afhB/R+bfu6dB8oSVTluMzOiXvetmcvfzP0h/dMQPMB3lwGXJvYQx?=
 =?us-ascii?Q?ObCQg6KBxMMTdGaXjd70xqqhQpvz3xO84+dag6NUrFURt5asXI1GlR+hyuMy?=
 =?us-ascii?Q?mGXfJkEdxUkSjbMX45XgnyIeK04QmmD7KMXjhwDG5bxOQCW/ts19DROg0vfp?=
 =?us-ascii?Q?svbA1J2dd4DSUWWvVSo4klaHzIq2CgnhSG3Kdvk3FXadi+VSYVg01UZ1/yOW?=
 =?us-ascii?Q?57xe4rXnuEgT4hxjIlWsodp7/v86P11xMAQsQGFAYlYf4ZZGpxhyXmgGh6Zx?=
 =?us-ascii?Q?fpwSabLH/l1eNKLQCKRkuTVZ5FZ+lqWs6OjqCu+Kwu4y/B5y1hrD3kjlY/ON?=
 =?us-ascii?Q?MMuq/zqnLNvHNrygnLkDT0Glau5wUOFG4rHTxeIH6wuQIvw+NyTjLxg+JQGO?=
 =?us-ascii?Q?igRxNgx+SUpfbRmMKqb6od7U3LioLiguJQROJqlKiDvWf7n7KV/bW+NnakW3?=
 =?us-ascii?Q?0GxGNWqx2dPDsGzolb7lCtOl?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:48:16.9265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f890ace-5b2f-4447-f134-08dc6475f55e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7127

The CXL driver uses both functions phys_to_target_node() and
memory_add_physaddr_to_nid(). The x86 architecture relies on the
NUMA_KEEP_MEMINFO kernel option enabled for both functions to work
correct. Update Kconfig to make sure the option is always enabled for
the driver.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Link: http://lore.kernel.org/r/65f8b191c0422_aa222941b@dwillia2-mobl3.amr.corp.intel.com.notmuch
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
V3: updated SOB chain
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


