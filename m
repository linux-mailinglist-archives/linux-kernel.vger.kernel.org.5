Return-Path: <linux-kernel+bounces-159425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5185B8B2E70
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 03:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D12E21F23226
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 01:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5309184F;
	Fri, 26 Apr 2024 01:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ni7zqSKJ"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5938617CD
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 01:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714096061; cv=fail; b=Tr7DXxnOQ04zaNATcQ1mrqtTw0rEucKGyHY5gjG7xSAUZsLpzXZF6j9TozBPjvmnvcQqt6ZbiPdKbNZvZWtawetjzYmxv/eExbjNOH3ay/WVOdcBRt5k9w3cdTsC3Ru3BGEA5T2CDvt4IQ+umUeAiHGpZT725XNxjR2/1jR94m8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714096061; c=relaxed/simple;
	bh=1ScXMFbrzXsaUU7R6xq7ZAI5nUlrT6oXg8dzO05c2iI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=qe4itiaLn9qJG/xmgX+cV0TzC9Aid3AtPfOtcWICyc+FmgdeoCUDTk5wq8o7hUiS48KuC1LEg4iM6z8kASpfTIaJ9XwyAhCMPHmVnfV2/fJlzZpBioQy8ryCSN1ZRxbKs/FInA3d+rvIGoFx8RiMD9J3Mx83kbiLYktDA94wYq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ni7zqSKJ; arc=fail smtp.client-ip=40.107.220.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1fXfmMVH+aXDc9RNloF6EkF1b8whp7foAJiPDsIkVeQEGO3e0Mbj4hqmc4lufE8e25ADj0qYfmfswbzTaOBz7TO7ITbAPFHFofLOUjF6qxJ3Pjr1coShy3OGURGgdn7xBPmzzqjZcHiKy7Uvbbf7NY0v5BZKiKitUSwO2CJh34KKLK9D01HN1sv69XmTEDH0co1Ok3Q0NIqQsyUfhr52Aqq791yp0qqwR1avQLs4wSjQCrcWTMY+iePbx8uBU+H/tDM8m48cXn3rNF+BtoDV/DKngrfaMwtv8lQYuLy9aSgU+5ix829Vgb8MOEHbTb5sjBvUiN+0SRYNFVJDy7ltw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOpFOPTHninFD2QHOAhJWWZOgtaK3yAtBrb14JB23Kg=;
 b=eTMUWmde4wakqo38hGdNj3wUT1EWSti2uHpDWac68IEUNE9NOT97pELYFbB57J47czFzYQBOo/LsGOjMBmuM8fdoo8WuNtYEzQ0zJkyAnOopxdH/qsi+S+5sFRzRBnHijjVVS1CoGmD8GSXTU634jMuBhzXlJVpTD5rSQeHdJD0PWl1VtG9VUHW8854Rl7G7x7lL2lYwlkkWNds07vpCfZrR/fSWF5FFPomPLDpbbOUJvLRDMU7zybCa9mSFKW/VoTOZbfiVXBqnQqr0EpDSoFaQLOwDsekcj5lSzqPzvdFcADel2B49qABrRe1tUuhRs4L8mlvNQLS4NEB4T2RnmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOpFOPTHninFD2QHOAhJWWZOgtaK3yAtBrb14JB23Kg=;
 b=Ni7zqSKJvfF+buH6FRCWc6ArTOP5ldr4Dx1eJak8YxDIIKzZ38FkwDJctB9bHmoGRH+nRDpLZq5Uie9P6to/KOB9vpTxA5u+ECpTpvfLNEQ9UHZAQ94bmFVGFHIlucGgY7K+5tWFmoamDM3euN4bguw3jVSHXnzFY44MhecjHUI=
Received: from MW4PR04CA0092.namprd04.prod.outlook.com (2603:10b6:303:83::7)
 by CH3PR12MB9282.namprd12.prod.outlook.com (2603:10b6:610:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Fri, 26 Apr
 2024 01:47:38 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:303:83:cafe::3d) by MW4PR04CA0092.outlook.office365.com
 (2603:10b6:303:83::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23 via Frontend
 Transport; Fri, 26 Apr 2024 01:47:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 01:47:37 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 20:47:28 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 20:47:03 -0500
Received: from xsjanatoliy50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 25 Apr 2024 20:47:02 -0500
From: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
Subject: [PATCH v2 0/2] Fix Kernel CI issues
Date: Thu, 25 Apr 2024 18:46:49 -0700
Message-ID: <20240425-dp-live-fmt-fix-v2-0-6048e81211de@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIkHK2YC/3WNyw6CMBBFf4XM2jF9irDyPwyLSluZRChpSaMh/
 Xcre5fnJPfcHZKL5BL0zQ7RZUoUlgri1MA4meXpkGxlEEwopoRGu+KLskM/b+jpjYazh2+7Vur
 uAnW1Rlf1UbwPlSdKW4if4yDzn/3fyhw5Kqa91MJKddU3M9vzGGYYSilfduBYaawAAAA=
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Michal Simek <michal.simek@amd.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Anatoliy Klymenko
	<anatoliy.klymenko@amd.com>, kernel test robot <lkp@intel.com>
X-Mailer: b4 0.13.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|CH3PR12MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: 60d3f10d-c1a8-47eb-4109-08dc6592d9eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400014|36860700004|7416005|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0UxSTY1eWdqYTBnVm1zZGo3c2JFSXNtL2o3WFU4aW85SGdLSTFzM0NMWkc5?=
 =?utf-8?B?RzY5TDdXNWcrcTdIMXNUSlRwSjIwYTVpN1BqSStaNXYyaXIwaDQ0aUYwWnMx?=
 =?utf-8?B?bGtBcmpCTkF6VFpmckZ3TkpPTEJtU2ZUbmNEU2Z3U2JtcDJzaEM5dTJBWkpD?=
 =?utf-8?B?OGZ5enRuNFJEeUpwQzF5MEhQYzV0TG5aY0QySG9PdlNRR2tJQmg1dUo2QlVH?=
 =?utf-8?B?NDE3c0pNRDFDekNZcHhDS3Z4RGVqQjRQKzN1MHA1WjhDTHA4aWhWZUNFdXd2?=
 =?utf-8?B?T1o5RW9UTG9IMWEwa015QURES3plN3BYNnd2SkpTU3d5bHJoVTZqalA5QUp5?=
 =?utf-8?B?elRSODZFdzZyRzJ6OUNKQStUYUtURldranpweFZQekxNUHdtSEQybmUvZkpq?=
 =?utf-8?B?Qko2WSs3d0luQjRQY1l3dU9hNElxQzluZ3p4b2s2UnFMY3dlSmtkRkt4azhn?=
 =?utf-8?B?VUU3KzUvNTJQTkR5bFNzcGNpMzVkZENXVzFDWG02bmd6eFVGRXFVT05ORmds?=
 =?utf-8?B?bXpqc2xVUG5xM1JtQy91M09aa1NvczkxeEFCdllKbTYycm5MWDhRUnFqUlFX?=
 =?utf-8?B?eitQTCtLMlhlcGhVVjgrQW9xTGRvbm4vWjQyaG5xeng5OHB2SkZ3cytQckl3?=
 =?utf-8?B?MVdOWFJCRlZsSWYwL1luS0xMT0p5OVJxUXJraDQ3MFVVcjZ0UlErSXYzaHB4?=
 =?utf-8?B?VWJZeWxPZ3c1S1dMY3hMNjlpaEZWL1ptQ2tGNWtVd0tWZVAvZjhobUoxbTVr?=
 =?utf-8?B?TktET0ozc3JqNCtiZWpVWTlwV3ZsQ2hPdnNpVXZFanV4MXRvK0x4M0g4UTJy?=
 =?utf-8?B?aGhHNlNqNHFjQVBQakw0R3c5M245N3hMTHY1UE1CSDkvVzdkOTFJbnRsY3RS?=
 =?utf-8?B?eW1oRFRPUE1JMGZ2TTI0Q2RXN2hJOHlRMjFQdGJ5dlJqSzJPZWxOclBMMUNm?=
 =?utf-8?B?Z0sxMy9PWFdpbm1XNVNaMHhPcDV6RDNBWGdMS1NzZktiMVlzaWRRcFBwRFdm?=
 =?utf-8?B?dExoOWlTSlE1bkdKSjNmbU1CeWkyY3NJeWtZcXBZNFNOTC82ZmJGZ2JqbjFP?=
 =?utf-8?B?N1ZYSzFSM053VDF5cDUvdVJYQytwYkJhNVFrZldkUVZJTytEMi9XT2dDdTRG?=
 =?utf-8?B?QjhhUzYyQXZJNUpGL1A3UG9ObUJyTC80cnlYV21VQ0lJS05UQkM1V3laSm81?=
 =?utf-8?B?TzhNOUIxVi9WN1dBb3FxSkdYWWhpRloxbjlBbTRuNDcwVDR5elNKZVkzbVZK?=
 =?utf-8?B?MVdJMU41em40L0tPMGdXSHZ3ZGFjSWprT0duU3M1K1dna1hqQ3B0S1FGV0tp?=
 =?utf-8?B?Z2s5bTZZVWltWEZtbkpoNEFaYk1LdnJjL0hDSGExSk53RDZXVmFndy9EK0Vo?=
 =?utf-8?B?dnA3Q1pRM0ZPK1IvbzhGK3hKVnRXOHUwM0dNSFF5eGZuZENidTR2THAyQ0w4?=
 =?utf-8?B?bG9oMTNLRTlTUE9VRUw5MnpSWUJmdW44UVVNNXE5VG5TeTdzOTRTL2xjWWdz?=
 =?utf-8?B?ZDhOdHdETFZOUjcwb2Q2V3NqWVIvY01KcFhZT2lQazRvV2N5eUVZd0l1L3BD?=
 =?utf-8?B?T0hCK05obi9kejlTcUw3a0ZWTTJUZkdrci9BNnBreE9sNGo2d1lNMWtvWFBs?=
 =?utf-8?B?VVlZVUJJdXJ1ano5VS9YUGllRkJEak5sVGFxdC9XdEx1K1drWXlDZk4zYkxG?=
 =?utf-8?B?VklaMVd3NTI0UmF4TWV5Wmg0V3ZnUkhQL3pBUmdCOEdyUGpKaUFkYW5RRlE2?=
 =?utf-8?Q?GAaZe7UR7wzulzUdtWj3MvnC0oPpNCjbz9jmVPr?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 01:47:37.3753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d3f10d-c1a8-47eb-4109-08dc6592d9eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9282

Fix number of CI reported W=1 build issues.

Patch 1/2: Fix function arguments description.
Closes: https://lore.kernel.org/oe-kbuild-all/202404260616.KFGDpCDN-lkp@intel.com/

Patch 2/2: Fix clang compilation error.
Closes: https://lore.kernel.org/oe-kbuild-all/202404260946.4oZXvHD2-lkp@intel.com/

Signed-off-by: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
---
Changes in v2:
- Compilation error fix added.

- Link to v1: https://lore.kernel.org/r/20240425-dp-live-fmt-fix-v1-1-405f352d3485@amd.com

---
Anatoliy Klymenko (2):
      drm: xlnx: zynqmp_dpsub: Fix few function comments
      drm: xlnx: zynqmp_dpsub: Fix compilation error

 drivers/gpu/drm/xlnx/zynqmp_disp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
---
base-commit: 2bdb481bf7a93c22b9fea8daefa2834aab23a70f
change-id: 20240425-dp-live-fmt-fix-a10bf7973596

Best regards,
-- 
Anatoliy Klymenko <anatoliy.klymenko@amd.com>


