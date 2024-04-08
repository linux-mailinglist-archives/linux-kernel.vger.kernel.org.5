Return-Path: <linux-kernel+bounces-135921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB1E89CD17
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1163FB2422E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064331487E0;
	Mon,  8 Apr 2024 20:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QJfA/wJW"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F8C146D6C;
	Mon,  8 Apr 2024 20:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712609644; cv=fail; b=Ij4BlviMZUBVKsRws+0gtOEO2ahCwhzzGc3ZruzJHLIdhmg8V8DsSmirvKWcKq+vvOZFTDkGegwJ+NeErjVTbbjwU1SUATKHTo4s5qfHloAGoTQDvke4rX1QI1hsLkx04d495287pM53+W/1DKxbI1Z0SYesec7X+h3D1hEbcX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712609644; c=relaxed/simple;
	bh=OLC+2z/Z+vvtCv4Sf8s4ACd79FQrzTfc1qOS59Hhx0w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X9MSsXrO94MLD2r1KPtpXLWS9GiJVMBVgLGr+5TC0vXMPDztaB+klyoukwDe8woooRcmd+8KCCl+NudJg8+ikjhCCQudwyQLaUFFykLH/WxDxMKwhaIM6LMkb++8Dc7lhwavnKEGEhbuZS5HT230n4Xn2hsQO/7mp15sbIWBzwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QJfA/wJW; arc=fail smtp.client-ip=40.107.93.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtYqfFrCdGdC3Mutq2OUeY4+LV7zG7QDbYxqHHdBCWalTMm0L6rZJpMJijXP8BI5ukZsV+GxasuhJf5dhs28kcCKuO6ORChTCHph18Btr7Y43OW03HCbsEMzcqoCitSUCW/UqmWQr9LmCqHW8joflkR+plKHkWPhKbImNT3Lyvj6HKnZ9R9x8ioPxyU50bEXYEIFSgS1MXGHLbRC+4NUE/5+LFZpXLsO9HUzAXnUNVioWDxI8QxWeeMohANrtFsekMg+WDhS+J8h0XNJ0PBXAsLVHrenIv0BfCjy3TX+y9byFsWka85c8NxLNXnPsf6EnoiOL7QhWi7W1+17kGcCCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7TCEu6unqaYt8qGuL7AqumxH8GrgpZGHYbLfA1JYzE=;
 b=YF6hOKzNvnEpwf2w4TdzbmcCwXwcTW3JjqWSTYxvm3wGjycTEM7yhyDx+KrEL9PVZPZggWd8GVfQ7iLT0+A8xI0NUBrXi2GGOXeEphABj4mN8w6eF5cgxnpCZhPbGXsRBZ1XUwu+9t1/YGKzGUCPesJZuD32Zw5HdnTDJncwDbyT1CCV3BpKShGY5zG1tegzNIPtt6qlvZKzWnFRzTog9JHMsUupAU7L+EPLor1OrCiGCcqRITKrD0M3TsLZvV1WNCUN9xD8bI3sGiasKikpIg3Wu7FhoJC4uUG61sO2zBUqoGrjLUZDRLxVmcKiqRmpIvXeJifgehlPCyuajziSpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7TCEu6unqaYt8qGuL7AqumxH8GrgpZGHYbLfA1JYzE=;
 b=QJfA/wJWwpsCbhio24CJ1Z1E76bG+HP+JpNd1dniQCyZJL/9yDrGppHqMoJyuvJEwOTVe5D7AJK97JIG/Qz6VoCD5lgtAdvyAxi272aIBwHiduEUKXvbBHaf4e9gMrai2Uf7mNfWtP8jeE9gaFQpYnC/NJ/i/xmPiVzgIaOQLp4=
Received: from MN2PR20CA0051.namprd20.prod.outlook.com (2603:10b6:208:235::20)
 by CH3PR12MB7667.namprd12.prod.outlook.com (2603:10b6:610:14f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 20:53:59 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::26) by MN2PR20CA0051.outlook.office365.com
 (2603:10b6:208:235::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.35 via Frontend
 Transport; Mon, 8 Apr 2024 20:53:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 8 Apr 2024 20:53:59 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Apr
 2024 15:53:58 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 8 Apr 2024 15:53:57 -0500
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>, <robh@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<michal.simek@amd.com>, <ben.levinsky@amd.com>, <tanmay.shah@amd.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v14 0/4] add zynqmp TCM bindings
Date: Mon, 8 Apr 2024 13:53:10 -0700
Message-ID: <20240408205313.3552165-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: tanmay.shah@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|CH3PR12MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: 939d7948-f3dc-45fc-0702-08dc580e03a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Lw8khwuE3m24TA0nHXwJnH3lpDPRaEgrf/VTJcZTGDcFeSxYsFp7sM4OREM3k5CbMqXY/l2IjI016cLbhQS8Z71vHGPaUc81/DAAKh4ep6FsOGR1XkMn4n/AQ2K+eNybc1Tjpb7JU0r0HmwjR6Ety5+dmRR6tY0T9R/TMa2uNlI9EA4ZsuRmH0bJGzjuY7UhmpP35ZVgKdhY3MnEbWYhTSbs9fgo+u5zBO25fRTRFaIRHZ9o16FISWMXUwm2qs3HGwaDKR+5PgPsFK2rgLR/rZNW2iC9/EQlpnQ7tCSozSoscf3VqIa7HVdXrBT22QCXAZTN52v1lbqDtRK0YDRUTj8UXd1kS6l9JOTMCraxiXe55QfTKaK++SwLs3bGZE3ukA9kV+mWj6gOQEWIkoPmeMTLonQnJSLjzG65+a58v5y6G6hO1fcYmrbU1uUd+aDuHbCx9jjyPPIDJcNWwcDPY5Dg1+7+0d9GHyHFGyeOa+Vl+u1pHIkSmNeRHRHp22eiI/Y6HxQj1ViQtCFnqqRfUnYrXNLgkcJhYXrZkT+BMPkKA1zs15QxKsbxabR0JJvPdafVs/d8cTJLgVlmUA7wy9jS5U/Bq6UtzVDn/lc2sJ4wKqXBWjGaeODixUwHaE7YpAS8pMbevVSBYRV/tKOcS81N3mYlPRznxLKtiuay8JCytim6R7t2TqNzOe5fnpLKQfjNirK/Y6k8DjVLYoE/1g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 20:53:59.2607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 939d7948-f3dc-45fc-0702-08dc580e03a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7667

Tightly-Coupled Memories(TCMs) are low-latency memory that provides
predictable instruction execution and predictable data load/store
timing. Each Cortex-R5F processor contains exclusive two 64 KB memory
banks on the ATCM and BTCM ports, for a total of 128 KB of memory.
In lockstep mode, both 128KB memory is accessible to the cluster.

As per ZynqMP Ultrascale+ Technical Reference Manual UG1085, following
is address space of TCM memory. The bindings in this patch series
introduces properties to accommodate following address space with
address translation between Linux and Cortex-R5 views.

|     |     |     |
| --- | --- | --- |
|      *Mode*        |   *R5 View* | *Linux view* |  Notes               |
| *Split Mode*       | *start addr*| *start addr* |                      |
| R5_0 ATCM (64 KB)  | 0x0000_0000 | 0xFFE0_0000  |                      |
| R5_0 BTCM (64 KB)  | 0x0002_0000 | 0xFFE2_0000  |                      |
| R5_1 ATCM (64 KB)  | 0x0000_0000 | 0xFFE9_0000  | alias of 0xFFE1_0000 |
| R5_1 BTCM (64 KB)  | 0x0002_0000 | 0xFFEB_0000  | alias of 0xFFE3_0000 |
|  ___               |     ___     |    ___       |                      |
| *Lockstep Mode*    |             |              |                      |
| R5_0 ATCM (128 KB) | 0x0000_0000 | 0xFFE0_0000  |                      |
| R5_0 BTCM (128 KB) | 0x0002_0000 | 0xFFE2_0000  |                      |

References:
UG1085 TCM address space:
https://docs.xilinx.com/r/en-US/ug1085-zynq-ultrascale-trm/Tightly-Coupled-Memory-Address-Map

---

prerequisite-patch-link: https://lore.kernel.org/all/d4556268-8274-4089-949f-3b97d67793c7@gmail.com/
Base Branch: 6.9.rc2

Changes in v14:
  - Add xlnx,tcm-mode property and use it for TCM configuration
  - Add Versal and Versal-NET platform support
  - Maintain backward compatibility for ZynqMP platform and use hardcode
    TCM addresses

Changes in v13:
  - Have power-domains property for lockstep case instead of
    keeping it flexible.
  - Add "items:" list in power-domains property

Changes in v12:
  - add "reg", "reg-names" and "power-domains" in pattern properties
  - add "reg" and "reg-names" in required list
  - keep "power-domains" in required list as it was before the change

Changes in v11:
  - Fix yamllint warning and reduce indentation as needed
  - Remove redundant initialization of the variable
  - Return correct error code if memory allocation failed

Changs in v10:
  - Add new patch (1/4) to series that changes hardcode TCM addresses in
    lockstep mode and removes separate handling of TCM in lockstep and
    split mode
  - modify number of "reg", "reg-names" and "power-domains" entries
    based on cluster mode
  - Add extra optional atcm and btcm in "reg" property for lockstep mode
  - Add "reg-names" for extra optional atcm and btcm for lockstep mode
  - Drop previous Ack as bindings has new change
  - Add individual tcm regions via "reg" and "reg-names" for lockstep mode
  - Add each tcm's power-domains in lockstep mode
  - Drop previous Ack as new change in dts patchset
  - Remove redundant changes in driver to handle TCM in lockstep mode

Changes in v9:
  - Fix rproc lockstep dts
  - Introduce new API to request and release core1 TCM power-domains in
    lockstep mode. This will be used during prepare -> add_tcm_banks
    callback to enable TCM in lockstep mode.
  - Parse TCM from device-tree in lockstep mode and split mode in
    uniform way.
  - Fix TCM representation in device-tree in lockstep mode.
  - Fix comments as suggested

Changes in v8:
  - Remove use of pm_domains framework
  - Remove checking of pm_domain_id validation to power on/off tcm
  - Remove spurious change
  - parse power-domains property from device-tree and use EEMI calls
    to power on/off TCM instead of using pm domains framework

Changes in v7:
  - %s/pm_dev1/pm_dev_core0/r
  - %s/pm_dev_link1/pm_dev_core0_link/r
  - %s/pm_dev2/pm_dev_core1/r
  - %s/pm_dev_link2/pm_dev_core1_link/r
  - remove pm_domain_id check to move next patch
  - add comment about how 1st entry in pm domain list is used
  - fix loop when jump to fail_add_pm_domains loop
  - move checking of pm_domain_id from previous patch
  - fix mem_bank_data memory allocation

Changes in v6:
  - Introduce new node entry for r5f cluster split mode dts and
    keep it disabled by default.
  - Keep remoteproc lockstep mode enabled by default to maintian
    back compatibility.
  - Enable split mode only for zcu102 board to demo split mode use
  - Remove spurious change
  - Handle errors in add_pm_domains function
  - Remove redundant code to handle errors from remove_pm_domains
  - Missing . at the end of the commit message
  - remove redundant initialization of variables
  - remove fail_tcm label and relevant code to free memory
    acquired using devm_* API. As this will be freed when device free it
  - add extra check to see if "reg" property is supported or not

Changes in v5:
  - maintain Rob's Ack on bindings patch as no changes in bindings
  - split previous patch into multiple patches
  - Use pm domain framework to turn on/off TCM
  - Add support of parsing TCM information from device-tree
  - maintain backward compatibility with previous bindings without
    TCM information available in device-tree

This patch series continues previous effort to upstream ZynqMP
TCM bindings:
Previous v4 version link:
https://lore.kernel.org/all/20230829181900.2561194-1-tanmay.shah@amd.com/

Previous v3 version link:
https://lore.kernel.org/all/1689964908-22371-1-git-send-email-radhey.shyam.pandey@amd.com/

Radhey Shyam Pandey (1):
  dt-bindings: remoteproc: add Tightly Coupled Memory (TCM) bindings

Tanmay Shah (3):
  remoteproc: zynqmp: fix lockstep mode memory region
  dts: zynqmp: add properties for TCM in remoteproc
  remoteproc: zynqmp: parse TCM from device tree

 .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 279 +++++++++++++--
 .../boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts  |   8 +
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |  67 +++-
 drivers/remoteproc/xlnx_r5_remoteproc.c       | 319 ++++++++----------
 4 files changed, 471 insertions(+), 202 deletions(-)


base-commit: 39cd87c4eb2b893354f3b850f916353f2658ae6f
prerequisite-patch-id: f6c4bf78d30a332948d38e5c937f031496cd3b5a
-- 
2.25.1


