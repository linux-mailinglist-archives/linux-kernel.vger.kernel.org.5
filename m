Return-Path: <linux-kernel+bounces-19783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD248273D4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3DE284A60
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0050952F8B;
	Mon,  8 Jan 2024 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0IR/qDxp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2D5524D9;
	Mon,  8 Jan 2024 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhzxdoL3aY+SoWeyfo5N9Y20oCluZMjGOoxqBB4Ubr3UxQ2HzD+jxlthMpGiUpaE4t1Wbp5MIV29aD7rRzejQyyqyX1oGwfmjYWhGNtAQ7sd9QA/YKEwmcl+ngc12iAxhyY7w+vl1L5C2kELuSjO2TVsiSldFGcD/S8XerZsHGhLVUt51uJ0Qv0wwfiqE3oGWZVuY8jsIQMBPepIhCFXVOPQqCOetN17UDLoARM7AoJ+vYzIMmE7UimJd0Dyf8tdbnpSXbS6GnwVg+vqqyxKTqvWo2W/Cf/a542mtKgEILWENnYvnCWxhy4sKpCxVZkUetHcgVLGHc07Z19iQPNmNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FsSJEqJj23hKZvDHAQf838Q5IhhZWlSfVijudDopMtg=;
 b=mTZhVwvf30BjuWAJ1zsab6OSR5RBJXvrgDwniwEOdMJb+4hKIbT0taVbXCfTpg/pghEgf4VyT/ZHCpbmCgSt5mwSWL/5Lq2sgshzbBsvIyCf4xJfsMQ9vCMW3aDDahXIMX0jeZdeNIsqLVgf8Q/8INFp3eSaZLhAU0BM9AtG2UB5t2xzNeUo2GSBzB6q2vUrwyUU8JujX+yM5Aei2IjZLR4ZKI/ElWi8yer24xfxkx0vdGtheSQ1jo63brnpqWQvlbA+TiaGBF3Bgk24YTqJXLrMSl0fEA9LnZG5S3lhuATNBVLARf14OjvZPDCtNGJMt4gmkofTF0VataxXwgUJnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsSJEqJj23hKZvDHAQf838Q5IhhZWlSfVijudDopMtg=;
 b=0IR/qDxprpV1Ba/aF8KJoFri/p8QK3nBRRlzwKtTOLPtAb1tn/VeOwngylx76shMXNPHkuZKFWB57jKTLrrV/QBqyLQKvwCToeDBxiJWK4RhPqKDQ0vnz9PA3V8qYzddn0iTeICiDzOgpdYWUYyjrnkuNwc2Ch8Mql8CkOMhBPE=
Received: from MN2PR15CA0028.namprd15.prod.outlook.com (2603:10b6:208:1b4::41)
 by SJ0PR12MB6807.namprd12.prod.outlook.com (2603:10b6:a03:479::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 15:39:42 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:1b4:cafe::5e) by MN2PR15CA0028.outlook.office365.com
 (2603:10b6:208:1b4::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21 via Frontend
 Transport; Mon, 8 Jan 2024 15:39:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Mon, 8 Jan 2024 15:39:42 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 8 Jan
 2024 09:39:40 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 03/14] arm64: zynqmp: Add an OP-TEE node to the device tree
Date: Mon, 8 Jan 2024 16:39:14 +0100
Message-ID: <9ee7e8c263c453a8c9e6bc3b91fad78b0f54edc0.1704728353.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1704728353.git.michal.simek@amd.com>
References: <cover.1704728353.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=863; i=michal.simek@amd.com; h=from:subject:message-id; bh=gWExqgkPLlFYJKtW0mMizkmM3/KP/YcnDXnIDtK0Rxw=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQ54mpOhzk0hZTq9E8ev9B4/OyTaG/H8vkTVO+vPq81+ VVTt3B+RywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZiIWiTD/HrLNzdaG2e/SHnu fd3xUN4x3mrrewxz+GddO8f067lM7FbB7S9lO/L3KjA8AAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|SJ0PR12MB6807:EE_
X-MS-Office365-Filtering-Correlation-Id: f49d8aba-a1ac-4c8e-1ab2-08dc10600857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eX0RFh2MSgvW8FFSV/tPD9AisD+UiX2KcHED/sxSoV0YjiqWYNJPtZaky89jAltgef77dodMfR5dBWLGKGTehp4xVucdBeb6WiHLy6Y3ey2/V14lp/Ct/3zYYhWO5c/7PLxiLkDEE1ng7Qrc9vyQFd0vFpcA1BiDDJ83u/o0Hb4PMi50LuDPIXCYevIdnEhAo+Og1RSduLRyAt/Q8kSImPBqcmrjGSbA1MLjEPNb1zk/UZmZTE0O01xG6B3dxjQgSJDRi21bhsmZ/y9pmS6aA2rs/vxdGsR39XtToHhxVBkxP3utroBOMdXPwqo6Kdt/DWtuwuwk79sHF/vl+x6vM3HeX+U37xXHF/VFybcV0NqU2KG5B4L5qXEKceHeSy9pOrEbogYFNwEkjmusSR8LDH09rVYjP7hBv2PCUzWGwo6pBmWNuK8EoJbBTbmBP8gP8GPlDYiySe5GC1rxH4AA8yifl0zKnoN+k978sU+2I7qXaWv8cQGIFbie+c5mgkENaw2W/av6/cItg+QFapnu+TQsATUULrvYaGearHoVn18raHKGVfwk29XvHP7vngnD5DhCIQmTGoANmiO9ARiJShYT9gHmdD6Ctd4KitnSeZHsjNRlOlFya0xUBmcTtxtoX3u4VDaiIKEx/RH0b0SUjWiJLwesZgQBpPHhbsM7PPciO6zElTbDVuR+FBFHKdpfVLHLA1U/kYb8tCEZe1TtvJlL+18ppC2JHB7YkwjTeVDYd+OBd9VWT/zGxldY7ZRHi5CHWwiKV2iDPI0JfOgHXNr9ODaO4DOqyV65rgODiuM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(186009)(82310400011)(1800799012)(451199024)(64100799003)(46966006)(36840700001)(40470700004)(36756003)(5660300002)(40460700003)(36860700001)(40480700001)(4744005)(82740400003)(6666004)(478600001)(2906002)(47076005)(44832011)(4326008)(81166007)(356005)(336012)(426003)(16526019)(2616005)(26005)(8676002)(8936002)(316002)(110136005)(54906003)(41300700001)(86362001)(70206006)(70586007)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 15:39:42.2130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f49d8aba-a1ac-4c8e-1ab2-08dc10600857
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6807

From: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Since the zynqmp boards can run upstream OP-TEE, and having the DT node
present doesn't cause any side effects add it in case someone tries to
load OP-TEE.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index a9a23cf50196..f72fb4ea3e11 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -180,6 +180,11 @@ psci {
 	};
 
 	firmware {
+		optee: optee  {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+
 		zynqmp_firmware: zynqmp-firmware {
 			compatible = "xlnx,zynqmp-firmware";
 			#power-domain-cells = <1>;
-- 
2.36.1


