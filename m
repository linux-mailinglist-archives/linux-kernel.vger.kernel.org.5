Return-Path: <linux-kernel+bounces-1844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FE08154B8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9FDE1C24231
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C76836B18;
	Fri, 15 Dec 2023 23:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CkSTDH+C"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D4A48CD5;
	Fri, 15 Dec 2023 23:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJyg63kRQKq1cawQ/lNtfeSXXoz0Cy2N8k0JlIRfDOAnl1oSStaoulLzQyGopdFm0R2xkw1PxJM/Cd4K19G9flhlmaAvuGIW9ZG9bIYQaA3Gv2tZlHateON7nLGRjQrUV6H+xgJxOYXRt7E1mu6pfC5/gjzjnM9u94RINa6N8Cx5TPeVriOTUsLQsfri/yttrG1L6itwKVZtsgRGbGGagSLhddg12Pbu47asFDTN2rG8xnoDWjrkUOH/kYLUveeG6n7zRPqqFkF8UwNoev06pwaLHJE8G9QSRG6op2WpJb/2NnK5g//SHEtaslSghpXfGS7WNRTc1YPPXwsXkP75lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzHbSLgZpHEa648msyEfpeZNLCu5kvGjaPjh4sNI9Eo=;
 b=IHTBuMRRIBGl3ptrEIFRAs/+yChe9KT+GTEB1k+gA+PjU9hf/E/vyI/SemOO0PKD6hMotaKBtYcSOUjzDb8BuaFTx6Iv5izaDsvLs3IArxqrVb6xyPgQeI4GpWTb3cFpobJATcf9sypRi57iLX8x0UYYdzmPxxEL21Rn5dQxGE9WX4FP3hA5PkposEcVWFlQIyVmLQGUX6v2HByxCEgJhjbhXVlq+0P4LLNOZ4zp8bWhKnhxHBisn441TlHU2PtXZuyFl+JMX4u3AF+2c+yjKVZj2hNSFfLVnToFQXnCQHZGv19ZIZJFhcsKydrl7g2POWvOd8EPrP7DI3C5ogAkfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzHbSLgZpHEa648msyEfpeZNLCu5kvGjaPjh4sNI9Eo=;
 b=CkSTDH+C5Y4NgN7tsMXXbDj+D+fpWcmiW+E5NXDtbPZHrUGLjPS8zYn02ymQ0nN9enb/H9JQlVYOYVtSivsC7TNyx0mjutZAHoDy4vnHsSWbvmGis6tzhU41Nq5+XAx1umz1rbiKoJKfhisNs82h/su2bOGq+VgjsfkaTuUtfhM=
Received: from MN2PR05CA0060.namprd05.prod.outlook.com (2603:10b6:208:236::29)
 by DM4PR12MB5294.namprd12.prod.outlook.com (2603:10b6:5:39e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 23:58:31 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:236:cafe::f0) by MN2PR05CA0060.outlook.office365.com
 (2603:10b6:208:236::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.13 via Frontend
 Transport; Fri, 15 Dec 2023 23:58:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 23:58:31 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 17:58:20 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 17:58:19 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Fri, 15 Dec 2023 17:58:19 -0600
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <ben.levinsky@amd.com>,
	<tanmay.shah@amd.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 0/3] add zynqmp TCM bindings
Date: Fri, 15 Dec 2023 15:57:22 -0800
Message-ID: <20231215235725.1247350-1-tanmay.shah@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|DM4PR12MB5294:EE_
X-MS-Office365-Filtering-Correlation-Id: e1130790-067f-409f-bff8-08dbfdc9bd73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gUtvVOlCYTrgDhizxFGE0Y5xBCd71uJMtPNkRTBicumPjD5pd1Br6W8d55y7bah7bYdQCbvH2mejSiszpLtB7d78m7M90evYcfF/YjyAuOTifnyKMXnBx7Zjqrhdhv7xKlRl/oFXuUM4EAaKLM5GsUhFY5HsWZStJiIJnU9Rx9eO9cTEZq+Krhfeohw+1OEqu6UVSYg3MHhILGd0mUc7+pPL8dllIh+dlvHfhUa+czTxrrMC29yCQsqzWPc62mis5vCDpPkjh8ShnsaUV90IAzRcUuLntC/UJ312H+WdxBgQDCBm6FWnxWHoVpMdTLGTpDFxzYjTBJly/qGDAyzYHowFpBgoh9ho75VQr8SUHnpzjVPjWqiNkxKUIILRfGjv2k373dLKlXOjK6t1TSNCf8f36DScO1rduHSl5k+8ZDTcbhVTDVsFN+RsM/OgGZseqpbhOTRGWUlAduCM/nzwRY0aS1oIkBMbphmR2HGiJW6Fs51K97fsa3WM/L6dsruFlk4bpKSgNIvJugk2IhoeEiVK/gusb17YDrmkJ2+7QcpydxNb800A9OfzBWYwwN/ezSlh2roToBnQgGt8lho78U33WhQMnKdTgV6oJitGd79t/dUv5Mtju3wTgy9L16Az3nALD6DwhEeaN/a1HVGFq6LGg0XuDkdsZrLaIIzVdRnsm5NoOysRGCqQyGSQanA1XWoXnRzGyaJqDQ8bQfFZbhka09ra+Y09qvZxo3GjiRkDtKsh2lkL0ask9yx1FQHib7TkUg2pZ/ivxDZT585VC2t1UCWzlCd6y8dahRyjww4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(82310400011)(1800799012)(64100799003)(451199024)(186009)(40470700004)(46966006)(36840700001)(40480700001)(7049001)(40460700003)(110136005)(316002)(356005)(81166007)(82740400003)(36756003)(86362001)(26005)(47076005)(83380400001)(2616005)(1076003)(336012)(426003)(478600001)(966005)(2906002)(54906003)(70586007)(70206006)(6666004)(5660300002)(8936002)(8676002)(4326008)(41300700001)(44832011)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 23:58:31.1478
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1130790-067f-409f-bff8-08dbfdc9bd73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5294

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

 .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 131 +++++++++++++--
 .../boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts  |   8 +
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |  60 ++++++-
 drivers/remoteproc/xlnx_r5_remoteproc.c       | 154 +++++++++++++++++-
 4 files changed, 324 insertions(+), 29 deletions(-)


base-commit: 7641890179f913ce73d9dae490b8ab74970fc552
-- 
2.25.1


