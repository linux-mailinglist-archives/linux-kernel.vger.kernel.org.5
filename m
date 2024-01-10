Return-Path: <linux-kernel+bounces-22821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B059582A35D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58CE028959C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA844F890;
	Wed, 10 Jan 2024 21:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ruCtjj/k"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44374F5FB;
	Wed, 10 Jan 2024 21:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5RU0AOq4sxD3M26PaU19KFmj8eYSggthMDe/ggZ/P2AGDg0dEXaVH3Iy0kyriMk1corDuWujo5SxB1R6ml8+DUOhiHK9iq2uqQEltnJje2T5CGAN4xPSa4i2OHZk+CgetZtTFe1pfNJJB89/sdOj3r6WpU9CJ55UqOEBTKvAnk3IXFYcfdpQs93KdI+/b8r3IJ1c+M+ECQVpjH4Ud3ph3x9m1mLOUl6SfucXeR2Ev7kKgqF3AilQxo5HgLAQNs0nYJfcK+2nENJSxp7HeTWYrQyKn+DJnakjUFoHqs2jHGUfblOj445zcPpu+OIfcmb5CTVszTPfjqpZcG9VOEeow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JYYhn21JDaO3hTJaZf3xzcNieLB9ZvSzk2qpnlv0k8=;
 b=hqqXk7SAZd9YRNfkusfLXg/WhphBnTGczO323VtL6+pgn1C2AUdpBMqVe+KEkzxjkaYl2IKa7RmbDiY32y4rrbAoFQhrumH5VMgLZ7bBsLl3dkEbyYKX9CIuUMRw25spMI8dvdl9elBr4XyZ6udfKDdj8zt3K0Hq/UUZLp5G7fVmkfVPUkgqSoXUBIgWa91IHULlwmRskTpOnRzZEB2x/uY3ebtGH8pM0EZNjXhHkq6ZY/+H0f6/WeNgk6XhFcUehtB/MitGLCMgETKpqtbkEGURX3YXFoIPM+mWT3U3/eNdUpxqiF7cvSWUsgG6OoqOApkoTFeECtdJW3iNFkFqTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JYYhn21JDaO3hTJaZf3xzcNieLB9ZvSzk2qpnlv0k8=;
 b=ruCtjj/kaEVlLlmqDLlKsJmHzxqosVDN5EA9T2rxDvaVZgcrUsGQCl0HCq/VtOXsS3f9w8ORLkLWc7mxN/5CZHHWzbTbug5G7XhKYnpT62QJ7K9T3msaqgmN00rmxG/acUPiYztQewZ22Z7bc31SM1dPsHlcXHzXfUIWapqp7yM=
Received: from MW2PR16CA0015.namprd16.prod.outlook.com (2603:10b6:907::28) by
 SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 21:35:57 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:907:0:cafe::e1) by MW2PR16CA0015.outlook.office365.com
 (2603:10b6:907::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17 via Frontend
 Transport; Wed, 10 Jan 2024 21:35:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 21:35:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 15:35:56 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 10 Jan 2024 15:35:55 -0600
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <ben.levinsky@amd.com>,
	<tanmay.shah@amd.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 0/3] add zynqmp TCM bindings
Date: Wed, 10 Jan 2024 13:35:02 -0800
Message-ID: <20240110213504.3626468-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|SA1PR12MB8120:EE_
X-MS-Office365-Filtering-Correlation-Id: 46dd5c83-1598-44df-7876-08dc12242178
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ur3iK9KriD/Hhb4zGFne3t4RIOE098dtyko2hjJZ89a2825WCo4INTxLWlaKtsOdodYteBCz1oX8HhIlEeyriPoXXWSTPMKc/aEn7FwDhphn13GRx171SkQWWbF2rI8TDFGo2I/oN0vro8D1YGTppk/Z/wnVxTKmB0cwNZAeksv5NcGiAmWs/xBSACTALMed20vM0XbdwwwDxR57Vzas76fYTJnivvUotgPy7tdoOGnhFXgq2cBh/AWjnztu3CdwprI3zauTIh57JFnb7dVzRJySGYVaHqjataK1Pb7+caT9uHIbKjFaltZqawzp342D4bxATWkOIgQdANAsdkPOhD1XeL7GffZ34Rz7qHknyVIsKdNlajql02Z7/k4hSJ26oUJ2qlXZp4Y8rm9izSU1TKCTkd1Bvpi0jkkPM0crlSHszQXvsLPuTfYAMLJKkKfCblQm5E20d+nZUa1D4PeM3PI2rDma0nyUhKXMT7xd8KibjmSSNofrkUVIHBiJhMO0Q6ywMzx8oR6wk3LTSR5FPu9AQTo74IjjjuGOfkUOfIiwCxeeuYU7jQugDohBD9ntOc7PZz861uWQ4ob0hRvDJLJu4VAejAWHSWXqavY5T8UFHr6s6qoO3TzdXAb4lxkUb1/uc05db7LzCjBQABQStE4dE3tEev1pvASikTaulia/+3lsOcduQEECfBfKubFEeLag71HehzDU08L146wmLeH9MTRMOAgYy7/HxFvkGwYlaDKv/Ggc87xmFsybNFkw3Zl6KqrSEu8B7L+8yh+Qyg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(64100799003)(82310400011)(186009)(1800799012)(451199024)(46966006)(40470700004)(36840700001)(478600001)(6666004)(966005)(4326008)(316002)(8936002)(54906003)(110136005)(70206006)(70586007)(8676002)(47076005)(36860700001)(26005)(336012)(2616005)(426003)(5660300002)(41300700001)(2906002)(44832011)(1076003)(36756003)(83380400001)(82740400003)(356005)(81166007)(86362001)(7049001)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 21:35:56.8027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46dd5c83-1598-44df-7876-08dc12242178
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8120

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

Tanmay Shah (2):
  dts: zynqmp: add properties for TCM in remoteproc
  remoteproc: zynqmp: parse TCM from device tree

 .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 131 ++++++++--
 .../boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts  |   8 +
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |  58 ++++-
 drivers/remoteproc/xlnx_r5_remoteproc.c       | 245 +++++++++++++++++-
 4 files changed, 413 insertions(+), 29 deletions(-)


base-commit: ff9af5732fe761fa8e7aa66cb482f93a37e284ee
-- 
2.25.1


