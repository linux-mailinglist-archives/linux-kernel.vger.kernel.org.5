Return-Path: <linux-kernel+bounces-143213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7AE8A35D4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59915B24082
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3117314F9C7;
	Fri, 12 Apr 2024 18:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="baoecNdZ"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC99518B09;
	Fri, 12 Apr 2024 18:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712947039; cv=fail; b=I5x784dRnPslKNsoukZVv4MOqZL022k+ryXjY/aKEBXjLvVp24cuPLVIwh/OlJ/RCLjWOcZQeueVlugrrbLLaiQaY/H/7CGYWPpJ6V1+K7/5UXxilp7vimvvrhhUAevRyB7rK/s+FTOHMFJ3vE2fDFb4QiIhUc/lOWPDptnO2/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712947039; c=relaxed/simple;
	bh=aWU+eaUsX4NaqJQmT206nlZefwEW89oJvKLHZ0b6ouc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BfAIWPaBUJ6DsPm6UQ1m5D1NOroFr6BYZqy0lUURUxMmKheNTeWh8xytRmf17Ef+vYmPanbbVyB5NqjroWME9aDTaibMOgtcb4ZdQCeLmL5LBNPxzTmtVUt5vb7tXuWppk5+aPm6ELjl3YHFUcNwcwMOt7/ZpQ9iBg4sA+otJOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=baoecNdZ; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2kGriWsq2PLXNjjDUpq0Lywtigtb1jICSjHGYFub72MdiPd4FEoWzUc2C4FZfGAxFpbECfSgMbWeMs+fuOXQWVMqd2hb1SLtwI0QG9vSvEWgF/cxjuInmoJOBIoGLo7UO1aTcpmI/oXn0EYFHHkJZh9iONJ+fwBKWpBcFgJn0Bc6mNeDYARFhTz4ykJkwHT/F8qXwFweIiVxsUKlZuSTK2WNoZNMNSahk9wVub83bJuOxu34gbHoFC3bQ6DogUeOKidUCH6J4DgNX2vJ4SHZEt5QeOSApjDlUgELFkhg78tYD+YuNPmNYNFCTVnOc1iqZO6WL8qWJE4FTne2h2hiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Em3AMPLrRQmogaYigSCRxru8w1ew4hUcCKdHRxuB0U0=;
 b=T/gGH5nwIfzLesrjGQbuPycRy+OOl9FlLsRjWCYrIQkHJyeP6AB/ma2MNbafnWIEcyxV76c3PSGnLbjU+J5RA5KRNbnZED/dumHeYoj4QtJvMeX5SCsuq3NtTgdcEdJp+FW7xVPz5n7xAKH75DNf+KGjdmPWQOCHZ5+tR/bky+FIfhyXIHvwczNgSlxWd0DQDJsYZHpne4XsKE9/1L0N+leDIDEKM6dJXPnqx0lTVst4N5muNxv1Yx5+lIbLzLc11dVZgLnQmdbejiqTbRvxs7Kn6Mg7t51ffmoiOKvzMR4Lmtlrw5Dac5Xiam/Qamojr3z4nfhaIwHv1wD4Uh1KmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Em3AMPLrRQmogaYigSCRxru8w1ew4hUcCKdHRxuB0U0=;
 b=baoecNdZv1GCmc7h6B0cG5e2PEVGUHhPJ4bwzx6DIZ0cPGjqUfxTOq+/xs+bMS1C8pGvZmTDokIZuoNPKr3rqrZUFbheN7wr5P+33j3krRU4g9khUYxFhQ0Avx7lS6aqqriEPrIpgPbzl6zBMtuIOZ0K6exMF5vdumvcYh4Mi2c=
Received: from MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20)
 by DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 18:37:14 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:160:cafe::ec) by MN2PR13CA0007.outlook.office365.com
 (2603:10b6:208:160::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.12 via Frontend
 Transport; Fri, 12 Apr 2024 18:37:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 18:37:14 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 12 Apr
 2024 13:37:11 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 12 Apr
 2024 11:37:11 -0700
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 12 Apr 2024 13:37:10 -0500
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>, <robh@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<michal.simek@amd.com>, <ben.levinsky@amd.com>, <tanmay.shah@amd.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v15 0/4] add zynqmp TCM bindings
Date: Fri, 12 Apr 2024 11:37:04 -0700
Message-ID: <20240412183708.4036007-1-tanmay.shah@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|DS0PR12MB6583:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a294f09-1e0f-4ceb-25e4-08dc5b1f92b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NjYzKt44lz6W8Ap3vUhwsQTU/Hy3y/gEmR8Sbd+5a9y+QrV7F99tAG9+YyN9WxeJyUlQnUydY4WYJZ7ewFvjFjQSyybKKwyiujkQ1I/46A+I/zL2xFqngbnb+h84wrrecLoSJIDfvy13bOmQuSopZIYhvWRS1YPfrohsFMmg8rOaHq4JN45eAYMKyUm5FC7YfY7pzmyP17yiSYxeBNpp3p1+d6j58y2DvUqJ9S1jWBFa1Vufm9nbGVLzgoU3ZKW85JikVOzSZ4QOg9frHi+p2TAKjQMqsW7HGyLbdDxejd7HoDCdnIMA8H3pvnv4Q39VQqIGWKgHa0R0/E7HY4ig9fs1aXBLBbcujwbp2qosqUSRILGXhPoGizBdCbN3wsmdy/iBsF0R7JXw5qo/yCv80QQrmj0etefcE8y3nY2lUYbIhFG9ZNt4zjSDDunhrvdmRLIiveHlJ9JtdCovkvBieRuf62vU6RJ1YHnY5D7kubCMpeDxQdTy+LSKSOKBFGVM47pfqsNyYF2lkhQdAwGI9JhClPj00tcMNXjqaNTl+DFEOXsKrROzQ4h163VNkVFreUY3FRuyPmDYTBNUMsSZkIsG5qy2Cc9BEeW9e6N1KN4CxdzBSo82xnVrTsHk4RO3mDo9feDsJDen4fd9VNuyeu1WsTK413m4H2OWSVlTQYXCbrMR37W/US2o+VOCGvWnUW9UpDnTslqyrix9FmnJcj1bKFS/fzNHhUU2/zRh0DR7nkRw118rnxwNPnASHh3hM+87I8DzYB2bDQ8DbHil7w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 18:37:14.3175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a294f09-1e0f-4ceb-25e4-08dc5b1f92b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6583

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

Changes in v15:
  - Use hardcode TCM addresses as fallback method if "reg" unavailable
  - Use new bindings for r5fss subsystem

Changes in v14:
  - Add xlnx,tcm-mode property and use it for TCM configuration
  - Add Versal and Versal-NET platform support
  - Maintain backward compatibility for ZynqMP platform and use hardcode
    TCM addresses

Changes in v13:
  - Have power-domains property for lockstep case instead of
    keeping it flexible.
  - Add "items:" list in power-domains property


Radhey Shyam Pandey (1):
  dt-bindings: remoteproc: add Tightly Coupled Memory (TCM) bindings

Tanmay Shah (3):
  remoteproc: zynqmp: fix lockstep mode memory region
  dts: zynqmp: add properties for TCM in remoteproc
  remoteproc: zynqmp: parse TCM from device tree

 .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 279 ++++++++++++++++--
 .../boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts  |   8 +
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |  67 ++++-
 drivers/remoteproc/xlnx_r5_remoteproc.c       | 273 +++++++++--------
 4 files changed, 459 insertions(+), 168 deletions(-)


base-commit: 4d5aabb6843939fad36912be8bf109adf9af0848
-- 
2.25.1


