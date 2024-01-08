Return-Path: <linux-kernel+bounces-19780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B6E8273CA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28DF92825B8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC334C3BE;
	Mon,  8 Jan 2024 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M7S/kWUm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2077.outbound.protection.outlook.com [40.107.100.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FC25102D;
	Mon,  8 Jan 2024 15:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtDb1aMps+s3wEdKZfkifY1E1W4rYip/p9eBHPYp3s/M8mzz5LJ2Cp6SB6/YX/57qBN+bxNgW3nslvelMycdapNxqII3LBxeQzCnlDWIs+4bW+sMCF+YgfjfKWwqVm3tQm5QFv84q1xH7+td0e9jIaGacERfg1PzSelSxElfWvEOsiBHuoNO3PMEx3RqhIcRMFTREITkdgF+I1TgIYG7rAH+SCbdeahKdnpivaQ0WJW8f2aO4ABnb2494cVi7oK9Zf7BnhIlRGmKs7FhszkhlnRlv3EjVkXiQEqXzcphAv6yFUhYSbwTyjAgiZNRtz4yVIuji0CVGMd5DPaQPrbHug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ve8SK0Q4sQu+C2Kj4GWYSqGIpqX/1fGSRnw6aeFPNsk=;
 b=jwKyCyRKfL89EijwndzoAxABTx7zlYk5tMj8WdU1gNXVveUkVgJ86NI+djNfK+9uNczMQJSUk66vSCdqQszPR6GCTwg8LfWG5vzwWenSc3lq/erkxpdav2nwBcQcVA0op2XIni0vtQASH1qb0P2Nw2DcznoOeJLoFvRIN5RJoZun2tYWciVWEUgBvh3h+ARGe24X+I9N2ZYhMsQB81wK+hx+PG+lLKUocWb9LjflpmGuzflydw9dt71h59wjdxQ79QKF/t2rWIKxnE3KGuh5l2iKPn9Llbg/0iydYrKzrGeetHyOWgo07+81hSY+WEVYqulkI3T3NlEcGTAtfF2NmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ve8SK0Q4sQu+C2Kj4GWYSqGIpqX/1fGSRnw6aeFPNsk=;
 b=M7S/kWUmONNEdzgnC4ycdxo5xr/aunO2EOlUSHPhkY0mucRLduGDdv0kkY4pg/Svdn2QyI/qkaF8cUINV/V3bTAlu6iODWj66CF7vk0+2eFAH7J8dJVq+Z3egQOOc+og+s3VvLHrspE4mdcnQavnT+/HLItpRovaRRx8UKJWVaw=
Received: from BL1PR13CA0291.namprd13.prod.outlook.com (2603:10b6:208:2bc::26)
 by BN9PR12MB5161.namprd12.prod.outlook.com (2603:10b6:408:11a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 15:39:30 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2bc:cafe::d1) by BL1PR13CA0291.outlook.office365.com
 (2603:10b6:208:2bc::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.14 via Frontend
 Transport; Mon, 8 Jan 2024 15:39:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Mon, 8 Jan 2024 15:39:30 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 8 Jan
 2024 09:39:28 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 00/14] arm64: zynqmp: Some DT alignment
Date: Mon, 8 Jan 2024 16:39:11 +0100
Message-ID: <cover.1704728353.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2289; i=michal.simek@amd.com; h=from:subject:message-id; bh=0zlH9FmNVnMnZu7h5KMSNfTnMKqU6mFEA2G6BvzC1TA=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQ54qq9jzxuKQrI7FdZmsVw70ASy+6f6/KUBDUOHH+39 8ztrsSDHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAiU+UY5pm/L0/8GDqzftHM +FPJVWUab4sexjDM4Z4u9cleinnaJTf3lbHp4ufnac67BQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|BN9PR12MB5161:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b38bf96-7a2a-4516-baec-08dc10600144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BKOOSVqUbblPaMe98g0vEr0wwtSQXWptMWhjs4ZvHQN6ore91E2pyJ0xXTIoOg/vGlR6EgMs7Y8VG5X7pxfodTb3OTUuPm6//q3bbobG8sSyFAbL0R1c6MKGx0+CbAWSUlCYZrL0YxCLgEsaslutiD1d4KU+7MVScbcURIu0HQClF0cNBEqBIk5XMm4tiqvNPcdU9QEu/IVTcYar9xNLS6uxBe+1mIZEHgxzX3MJOu47CWYlbsxkHGk57ow+bHsTdYOFWMaSZ7ehafWWbDzhjOvnrlj4XW9mF+CDFIEGyuhrcz5NJTdy/OCuPWjAToLmrjGY/dpm4+hA0+wtlgknzGwiJmYka953sYr8zuLEVW8VoboqL30Jn0fuYQhhwsCMQ++sY/G4niC6t8maaLGZN3yAJ85h5KSVWFNniEPbYHokXAhqldBIyoYlvaqVAJbYWwB0oF0N4Z1ZwML9DBUhASQtFq9qVSVkhUZOQRIdn1n1k5TbJO3Y/iy4CjtIxgm5MUXXQI2Vr8QgFop38M4ZSbVBJdFpLH66W6wUlgNkPiPSyqUwBXgmrE5hmgnDfN6xOCCAILVfF4YYSLw/nZNzdpDTZ3A5cpZYANUWVi0okeI5TR3FcI1gp+5PeRUaz1PkWaNelLLR31xP1XYwxSnGx5nGokcs/iOGPgGvkbEbq/3hVXjLWkWBEBpORUrl7elFeQpbT6U1k0o69n9mMmxGuPHM1iSDFDUJ50wobF+VfL81md+2JCgg85OtQKUqUlVadGLQCN8XTAzfhN/5vLlB6Ku4x35XfZgqpVHQ8jPoVRY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(186009)(82310400011)(1800799012)(451199024)(64100799003)(46966006)(36840700001)(40470700004)(36756003)(5660300002)(40460700003)(36860700001)(40480700001)(82740400003)(6666004)(478600001)(2906002)(47076005)(44832011)(4326008)(81166007)(356005)(336012)(426003)(16526019)(2616005)(26005)(8676002)(8936002)(316002)(110136005)(54906003)(41300700001)(86362001)(83380400001)(70206006)(70586007)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 15:39:30.3485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b38bf96-7a2a-4516-baec-08dc10600144
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5161

Hi,

I am sending couple of patches to update DTs for current ZynqMP boards.
All should be aligned with the latest DT binding and should also solve all
build issues reported by W=1.

Thanks,
Michal


Ilias Apalodimas (1):
  arm64: zynqmp: Add an OP-TEE node to the device tree

Michal Simek (9):
  arm64: xilinx: Move address/size-cells to proper locations
  arm64: zynqmp: Setup default si570 frequency to 156.25MHz
  arm64: zynqmp: Describe assigned-clocks for uarts
  arm64: zynqmp: Fix comment to be aligned with board name.
  arm64: zynqmp: Introduce u-boot options node with bootscr-address
  arm64: zynqmp: Remove incorrect comment from kv260s
  arm64: zynqmp: Rename i2c?-gpio to i2c?-gpio-grp
  arm64: zynqmp: Comment all smmu entries
  arm64: zynqmp: Align usb clock nodes with binding

Neal Frager (1):
  arm64: zynqmp: Add output-enable pins to SOMs

Srinivas Neeli (1):
  arm64: zynqmp: Add resets property for CAN nodes

Tejas Bhumkar (1):
  arm64: zynqmp: Disable Tri-state for MIO38 Pin

Thippeswamy Havalige (1):
  arm64: zynqmp: Update ECAM size to discover up to 256 buses

 .../arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi | 16 ++-
 .../boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso | 36 ++++++-
 .../boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso | 37 ++++++-
 .../boot/dts/xilinx/zynqmp-sm-k26-revA.dts    |  6 ++
 .../boot/dts/xilinx/zynqmp-zc1232-revA.dts    |  2 +
 .../boot/dts/xilinx/zynqmp-zc1254-revA.dts    |  2 +
 .../dts/xilinx/zynqmp-zc1751-xm015-dc1.dts    |  6 +-
 .../dts/xilinx/zynqmp-zc1751-xm016-dc2.dts    | 10 +-
 .../dts/xilinx/zynqmp-zc1751-xm017-dc3.dts    |  2 +
 .../dts/xilinx/zynqmp-zc1751-xm018-dc4.dts    |  2 +
 .../dts/xilinx/zynqmp-zc1751-xm019-dc5.dts    |  4 +-
 .../boot/dts/xilinx/zynqmp-zcu100-revC.dts    |  4 +-
 .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    | 12 ++-
 .../boot/dts/xilinx/zynqmp-zcu104-revA.dts    |  6 +-
 .../boot/dts/xilinx/zynqmp-zcu104-revC.dts    |  6 +-
 .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    | 12 ++-
 .../boot/dts/xilinx/zynqmp-zcu111-revA.dts    | 10 +-
 .../boot/dts/xilinx/zynqmp-zcu1275-revA.dts   |  4 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 97 ++++++++++---------
 19 files changed, 204 insertions(+), 70 deletions(-)

-- 
2.36.1


