Return-Path: <linux-kernel+bounces-88890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D7D86E80D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C7EC287443
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1BF282F1;
	Fri,  1 Mar 2024 18:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HyU/H9Qu"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6564C9C;
	Fri,  1 Mar 2024 18:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317033; cv=fail; b=GaYj2twvUZhXvs2oAxMzg/BEOdiQE4v02Pdns5KNiBc+eJpApB91GLrAXLJ3SIbJgYgOkGjlRv1lraT2j7nmRtYGo14u9TXlJJ5deYZWb13VWerooPi2rtUN+EY6fQg+1gEsNF5DxwDc6XR9quSQM2zV99dFBXRw1fxAcm6Yntg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317033; c=relaxed/simple;
	bh=e1WdpvvNAZmvMX8854bFJADPv6ULZ1+yOXi5yvTHeO4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qa041Yly5SGCu+cA8MVLFdqYzuFJd6LjRFXsrl9IAZGiw8xIbLw2H6TK/hu5NibAUpuyoKZHiaSMTyuXKZt7dAjBl1YZbW6g15QKrB4S4a4+iKoZDWQjmIARed9liR/WqabFg8+quOzAAL3/IDKpZqrY/ToErbp6R8xznaApWQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HyU/H9Qu; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBkmEMggeKHwWIpzSGOzrG/bMgmwzCrZG0EMVWh1VVcDzvPXYq7U/jhLMbC+ySxbWcUlUoRVb6WdrAOPzwKBJTRuklK4ttU/L8kJf7S0Sq7izLzoCSVqgQ99SiK82yOpgO/4qMrWJm2cMpnRNVGJqJtZH2qVcuPoXSGILm3nNt7q+324qWzeNrxLhx6JoycHN8rvXyuF/Qxyh+QAS9RFoE0fesD7/+o9274Of3xMCO5dKi6s4Vfz11iAoA/eMVmdrZeLpW0xy1iish5epoq29piqEkU+9TeTxczKDYpNJBA6iJJsqzAHPuhpAHUQlo9o1pkJ4d47ydEbeJgMpjDagQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrX3MMPRqQJus5w25I71CgaSCwgpJAonf5T5gWm2orc=;
 b=fKvK797EcbNZwp09nEq56EPj8B7GnW0RvLfN37I6YmwZ7DCiWXgv+zzuvv3XTEI7BGq1RnHlAv1tqi6bmvQc2RXhWMWBqrbsEJ11yuO1WDDbEdFZxwqnEv/bcz2xaSNQyT2fV5iiihZ7AeFanOT0tBzy0qQmOL7UUX9ut3c97ic/UKqVyzB971QsiPET5rkG9BkIFrWX8sxKsmum20982BlOoZQb+3pkFgpxLIoI3wabLzJquX15swORpeqouxVH6HwJyworISoWRS4udIjkemXP8+4HuPfUKyECXfVJSpYR/oJ1cUGCXZi6C94Ui+2NhCXKo7HS+XuiTMduVvSjgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrX3MMPRqQJus5w25I71CgaSCwgpJAonf5T5gWm2orc=;
 b=HyU/H9QuLWKLndm9EaFDCGuOdehaKTz4GsQmT8fS4j8SsxX0zaBnbxXzUj9H1YbHwt71n4q17JBmWgARSLIKu6a/0DOsaJMOYRSqbfp+qzh311+AQPH9HV8aK5hymf5R4Qxf+gCexHDWPBbopGvaWe2B9SbMxvxZZ2A+jGGVpZE=
Received: from BN0PR08CA0023.namprd08.prod.outlook.com (2603:10b6:408:142::17)
 by CY8PR12MB7660.namprd12.prod.outlook.com (2603:10b6:930:84::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34; Fri, 1 Mar
 2024 18:17:05 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:142:cafe::52) by BN0PR08CA0023.outlook.office365.com
 (2603:10b6:408:142::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34 via Frontend
 Transport; Fri, 1 Mar 2024 18:17:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.0 via Frontend Transport; Fri, 1 Mar 2024 18:17:03 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 1 Mar
 2024 12:17:03 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 1 Mar
 2024 12:17:03 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 1 Mar 2024 12:17:02 -0600
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <ben.levinsky@amd.com>,
	<tanmay.shah@amd.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 0/4] add zynqmp TCM bindings
Date: Fri, 1 Mar 2024 10:16:34 -0800
Message-ID: <20240301181638.814215-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: tanmay.shah@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|CY8PR12MB7660:EE_
X-MS-Office365-Filtering-Correlation-Id: dc8db4d9-bc40-4de0-f226-08dc3a1bcbf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4FQ4rrXS9hbdlQqZGdc/jlg8CjnLunNVmk9RdyhoDXrvD1tjkfmHIKZNC0JnoW/DBWzz0wNuCMDv2XTx6dGOb90s4VuDL1GoQ+wk7BjPvpnfIXx84rRUX2Vndhlg3YOvjxl6QFxUbAPNQKFCoOBCOu3mNArB9e49FscPEug7AnKbNGutajG0/VuggQeR58tugYIKEK/RS8EZrEYb19wnD2CL2gyVsz28lbziWN2yQY3qPDFruUiH+wb8fzWKQ2xMo4jY4EXRHYrGitfeAOYNTNvQhn7HuXn66fvwoTxvSS+wjfQxY5gPAwGzKlkqv/wiprhWCfagE07bE+ZQ4ggmTdY96yIkMGwTAo+02O9t6+8sp/XdknJslSOi+fAKkpTMj3OZ83j3lJpPG97p7llpBebPutM9qctfAbnDX7uO+NmfN9B0pRtCASxjHGwbRF8Fi12fNge13c8LXdPbQOVlOnR81mTczgkCXtky9j39c0xkt7vSjUbnAONNrvU6gDfxqYHkOcihbiLk3MLHyW/OSnI9chIGkGbJp+SFiV7H4e5ZpLI7+nIN3gD0fLENc7FQU8D3hhbfgZfORokjBgwbp/emdJuVA+Mc9r74yYiTBVSZQ1qecZ6WNwKJ3MbFgiGM0mQm4cTQDZfQYB07mKJeJWb4DfjRq4MCdz2Hp15dZHsKBdPf4y4qkSp1BV3P7uRrG17DrCv/GeeSMzPkVXKBQQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 18:17:03.9695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8db4d9-bc40-4de0-f226-08dc3a1bcbf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7660

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


Radhey Shyam Pandey (1):
  dt-bindings: remoteproc: add Tightly Coupled Memory (TCM) bindings

Tanmay Shah (3):
  remoteproc: zynqmp: fix lockstep mode memory region
  dts: zynqmp: add properties for TCM in remoteproc
  remoteproc: zynqmp: parse TCM from device tree

 .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 188 +++++++++++--
 .../boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts  |   8 +
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |  65 ++++-
 drivers/remoteproc/xlnx_r5_remoteproc.c       | 257 ++++++++----------
 4 files changed, 355 insertions(+), 163 deletions(-)


base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
-- 
2.25.1


