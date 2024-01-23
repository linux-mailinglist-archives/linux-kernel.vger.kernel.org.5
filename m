Return-Path: <linux-kernel+bounces-35445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1347883914B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91EFCB23BBD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB6F5FBA8;
	Tue, 23 Jan 2024 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2W3ovG/2"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8378C5D754;
	Tue, 23 Jan 2024 14:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706019798; cv=fail; b=L45nR3WGpaA2VFb4r4THuMNNj28ykZiQ36HnEAlgIcjetqA3Df+YE6ylD9sGuYRX45MIxFrDIm/jqCwWFW4DUxMf4DbMht55Tb0faVJgB0ACOmBRLoTwRZstGF012YlD8RnqUqGEM51HMuFWMaj5wp1I1AHYGydiU1YhkMS0Pyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706019798; c=relaxed/simple;
	bh=P07PE+toNdidJQS+gibm3ff5FvuVLac4OV/xkGnYWvE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OPloHXk7CL2NonATd31f3kj9CuJCijUw2MswBFDCsT48LkfiqC9CnVXD3REZQJ7ryQTJyNy3QTVnaSEPkq+gDSYisFzdGq4DDuvw8vkRTxjaysPI+mG17gDvHjv7CCcqmqrjS+Or4hjayjrOdsrmM/XHD8Xdqwa+9kZDeHiS/i0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2W3ovG/2; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTqg+AQjrwEai4dBvB/byJPGb1+MC06D7ufce0gPj+UUSYsAWf4lDN3l3g3DgYwCwhQ0SNL5+Epu0l63xn9NSz0zZcH5YUPp9W3Mta7UDhIIpzQKa+47V8xlZWpFJBVmckvvtcwahzwuTb/cOZ9HzMmGYHgvOG4bnjAnhbyxe9T0YLK9b6B/wKriMX0gIxbn5kaooFYeSCWUKJznc8enOe4GEASKDLUrZrCrg64RnKO+Hes8fWBe1SmYY3p0D6rIPjTn+oJaq7ZpVYjGVG0SAiSHTOq4gTalX7vl8k40mub7VNMJYKt7jgMXaS8TTJ5VLpydYjuLEfh+3GobX2xyPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9P6eM/W78isU0igirvDu2GeAM1fTilXw2YbTVHe0Yz0=;
 b=Xg4ouY6mZsfYM9JgFcsK32jFhU6yM5IJLhnVp/AUsNy05YnpMi0gmD8Axv/q3o+c0+lygrmRskF+6Ea3/iTms7+J4okkkrS6qdfnaqkttVqQkJTNsmrQO3kYlt5FGVgQuZt3Ff9lIQL/TjQM47CVPKj9WYQwLSgJxDTqN0AEqwz4w1dX5L1syFYYzbgcSfENrH93+WMZbSdQgRrYyKesHExjP2vWUT6Yld6qm6K+ILPo5OstL6z86ecoNwWn412FT49l3W6jepKbkP4XQaiklY8l8g46J6ZuiuqfhTQivuJig0Q/hZkmWy25JOw4CRaZx9XE6YP7juw+VAFLdUtBLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9P6eM/W78isU0igirvDu2GeAM1fTilXw2YbTVHe0Yz0=;
 b=2W3ovG/2FG+cY9kr8rFu3enb0Lz066b+u8sA8xfLvn7bmvK7owE2tsaP6VQrE7uS/l6pM4Lvz2YyxaRmAejzS+Laie4336G495tCGplXxMNFBX7Rd/gjGEd9i9Hfo+1WDGzdr7s4zXR6jjtgIOs2ceflHRJ7u0PqaVZSgFiLeJM=
Received: from MW4PR03CA0273.namprd03.prod.outlook.com (2603:10b6:303:b5::8)
 by LV8PR12MB9358.namprd12.prod.outlook.com (2603:10b6:408:201::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Tue, 23 Jan
 2024 14:23:13 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:303:b5:cafe::52) by MW4PR03CA0273.outlook.office365.com
 (2603:10b6:303:b5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Tue, 23 Jan 2024 14:23:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 23 Jan 2024 14:23:12 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 23 Jan
 2024 08:23:10 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] dt-bindings: soc: xilinx: Add support for KV260 CC
Date: Tue, 23 Jan 2024 15:23:08 +0100
Message-ID: <14c184225cc4f0a61da5f8c98bc0767f8deba0df.1706019781.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2768; i=michal.simek@amd.com; h=from:subject:message-id; bh=P07PE+toNdidJQS+gibm3ff5FvuVLac4OV/xkGnYWvE=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtT1p4/t1D/uJWF0blnJjDnMdnPunNhTynctjS3Yye7D0 dCsVddaO2JZGASZGGTFFFmkba6c2Vs5Y4rwxcNyMHNYmUCGMHBxCsBE1nUxLOh0PWWsfLL15B7Z DssNt96tuZR3KZFhnubOONlJ1usO/HLUZnbwkbpa+SF8LQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|LV8PR12MB9358:EE_
X-MS-Office365-Filtering-Correlation-Id: 70ec4ea8-ee1d-4dcd-957a-08dc1c1ed4eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TXkBLxKoGIBaGlPzNZlsFHXPzECkIJNUb+9DwpvHXLtnetDplRmcHtf80Vjl5rUDZuybBlAoSKfdbD2cDGGuD+q8fLwKxQO9wgKDO5J3ZymQ4djHOBeJIHos1sydVUYqlvTiApnjyeNFTfPDRa1tr4yM3zoDHvLtJNYCyBdBmqwlbnisQnycnTYogc9oqFNlphqMjP348MGnpF6xyW/YpYo3L4dPEmKVXu6efuVzgkIAnlKwvI/Z9TUi/GLq6NlVn0bzru0PyC/5ZF79Wpzw+NSWuUSl8L+7do/mfAHhmoBxVsTVyFc3PrXyIivDf/xWl2TW7atluG4rUd2B/egvNMJZa0euVhq1ABtjqQ7QhT2OImc4ce81oYT4urWPkhRLqucNBMr4nlfUw5KfvqJbjwprcCkit0jUYIuxrHZXxUvr0NhWa66IXXxsVl/FFNjREgrVJPuofU2IjLscJCNGcahmiOvBHgFT2SfQWS4O1OZpcn+7SvTcQynAhx46rziZrpuCTQX6i8NI+iCb6PzawPGfziyig57YpZX8xaohRQCCEDz/CZ1uIAotZKqiyqXKYmc1Qqr8jev0RnGOX/BoHYZQX59Tih7veD/61dyPQVVs0Sv3mWQ7SyhHekYxP6Oc6tIfe2gib3gQ7sTFUxjqXV0FG4W8X9fcnAGqeFtM4I5ygP6Yvtzc0nyMcvvGTEyktnRDur0eFmx5vHjjMCbhQwY55JQ9x1KJ9xGxeOuyLLph75mzrRtzyVqPLVid4B4UJJUMYulSEJWXcPaOYHWrW7bF8P5Jdmj6kKa3rhZggv0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(451199024)(82310400011)(1800799012)(64100799003)(186009)(36840700001)(46966006)(40470700004)(83380400001)(47076005)(40460700003)(40480700001)(426003)(336012)(26005)(16526019)(356005)(44832011)(4326008)(70206006)(82740400003)(478600001)(110136005)(70586007)(316002)(8936002)(5660300002)(54906003)(81166007)(2906002)(86362001)(966005)(36756003)(36860700001)(2616005)(41300700001)(8676002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 14:23:12.5167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ec4ea8-ee1d-4dcd-957a-08dc1c1ed4eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9358

When DT overlay is applied at run time compatible string or model AFAIK is
not updated. But when fdtoverlay tool is used it actually creates full
description for used SOM and carrier card(CC). That's why there is no
reason to use generic SOM name and its compatible strings because they are
not properly reflected in newly created DT.
Composing dt overlays together was introduced by commit 7a4c31ee877a
("arm64: zynqmp: Add support for Xilinx Kria SOM board") and later renamed
by commit 45fe0dc4ea2e ("arm64: xilinx: Use zynqmp prefix for SOM dt
overlays").
DTB selection is done prior booting OS that's why there is no need to do
run time composition for SOM and CC combination. And user space can use
compatible string and all listed revisions to figured it out which SOM and
CC combinations OS is running at.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

We are using U-Boot DTB reselection feature to identify SOM + CC
combination.

This patch depends on
https://lore.kernel.org/r/90e1a393154c3d87e8ee7dc9eef07fc937c1eaf7.1706019397.git.michal.simek@amd.com

---
 .../bindings/soc/xilinx/xilinx.yaml           | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml b/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
index 7c75dbb4f307..131aba5ed9f4 100644
--- a/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
+++ b/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
@@ -148,6 +148,40 @@ properties:
           - contains:
               const: xlnx,zynqmp-smk-k26
 
+      - description: Xilinx Kria SOM KV260 revA/Y/Z
+        minItems: 3
+        items:
+          enum:
+            - xlnx,zynqmp-sk-kv260-revA
+            - xlnx,zynqmp-sk-kv260-revY
+            - xlnx,zynqmp-sk-kv260-revZ
+            - xlnx,zynqmp-sk-kv260
+            - xlnx,zynqmp
+        allOf:
+          - contains:
+              const: xlnx,zynqmp-sk-kv260-revA
+          - contains:
+              const: xlnx,zynqmp-sk-kv260
+          - contains:
+              const: xlnx,zynqmp
+
+      - description: Xilinx Kria SOM KV260 rev2/1/B
+        minItems: 3
+        items:
+          enum:
+            - xlnx,zynqmp-sk-kv260-rev2
+            - xlnx,zynqmp-sk-kv260-rev1
+            - xlnx,zynqmp-sk-kv260-revB
+            - xlnx,zynqmp-sk-kv260
+            - xlnx,zynqmp
+        allOf:
+          - contains:
+              const: xlnx,zynqmp-sk-kv260-revB
+          - contains:
+              const: xlnx,zynqmp-sk-kv260
+          - contains:
+              const: xlnx,zynqmp
+
       - description: AMD MicroBlaze V (QEMU)
         items:
           - const: qemu,mbv
-- 
2.36.1


