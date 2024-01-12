Return-Path: <linux-kernel+bounces-24461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C9982BCD7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D721287C85
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8A056B67;
	Fri, 12 Jan 2024 09:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WPUhCUm6"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A84C56B60;
	Fri, 12 Jan 2024 09:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cV/tWTRdGBCwlgpcwwYKLleSxM7+XbEe4HSVTIsS14zue8HL7kSjoyNj2Z3mCVroWdKKDlB8/GSj5vHurZ3G8jskOspzwbtBNBQUtcJpFsKD0qjv828ptKcOBMTCCBOQnJ8z9xciONMvRjnLusxMUKUus5dzcGt1cHjCEaSgzbAeE9pEVToIc20pnvaWIKg/2RhAVk1dZPiJ329rxTW4Q1Vc8Fo6uDlp9cUtJ8ajBcbggiJW4fWZJRC7kbpWk6jq+IO1kmPBIde972p/SGtG0tA704nFYdEdK6Kc//bHfHAOFHQ5vYOWM8JlN9nf+gQJ2LDGm87UHbzgTk2xyeoZoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CD2UN6p5RKi5TeEksZU13jpPnevWU9lRPfZxbUA3xaI=;
 b=f1cxKq6bHF3Rixd7h6Q2aEfwmO1JjP8SCErVGtb64Zlh0tBD1QuOoW9OQLVvNeZpe9+GuUGEMl0pqddhCacgm4E+AsgwQru8NFls11bbnauW465CpzujItIrT2zZjeNG8fi4ny7wV9gew8kwAUafg/Y1WUR3fAf8ftEAxUFHZQ3KvS5+0ds/QpSfhxeUL7l3hU86LbKNo/lUT2t56CubnBSgfhTPAug7K3pNGbTAOFo4ckCaaSVWINbGEZhJyVGPeBdnPxO6Ib/U8McdQTTqryrTJhpSslKhNnHfgGXRF/Jr0TotSS0KgMMTBocQaR4Uqw1z393SHRWuoOqqZhoHZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CD2UN6p5RKi5TeEksZU13jpPnevWU9lRPfZxbUA3xaI=;
 b=WPUhCUm6ZU+GENkjKVKCOFlG/JKsf8vkzyc4+PA5WdKZfZUcL3o/x5JhJMg1TH07AIxiATUtHS+moRpe5dCyohHd8kuzpIluax9AlbgM/AZt0kZRreVMza5PEjr6aZhMHZW0DqvW6ItDGZSkswO5flp3JbQxz78feFx0cOZ1uWc=
Received: from MW4PR04CA0238.namprd04.prod.outlook.com (2603:10b6:303:87::33)
 by DM6PR12MB4076.namprd12.prod.outlook.com (2603:10b6:5:213::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 09:20:35 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:87:cafe::9f) by MW4PR04CA0238.outlook.office365.com
 (2603:10b6:303:87::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21 via Frontend
 Transport; Fri, 12 Jan 2024 09:20:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Fri, 12 Jan 2024 09:20:34 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 12 Jan
 2024 03:20:33 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2] dt-bindings: soc: xilinx: Add support for K26 rev2 SOMs
Date: Fri, 12 Jan 2024 10:20:29 +0100
Message-ID: <3e86244a840a45c970289ba6d2fa700a74f5b259.1705051222.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2940; i=michal.simek@amd.com; h=from:subject:message-id; bh=aQWS2q0gS9teFGJW1a5oMVC06SqN/ebq0z4PxRXh4Ic=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtSFLOGry6qNN65mPcXhsKz2SAnzIXe/iC9LX/uo9Sann zL4stq/I5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAExEfDLDPI2Qf6n6pveXRltk fPjddH91rfPOdoa5Egz9XldqFj33LmXa8jmruDPnWZIwAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|DM6PR12MB4076:EE_
X-MS-Office365-Filtering-Correlation-Id: 15ba630b-c4d6-42e0-bbb9-08dc134fbba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mOy2DYUyFEJQ/87ipCKTrWIUW3IQqApMaNM14PRPV1M62cAm0DSztkzSgTO+i0QksXUW8jbfFRqklEzmei/FFAZ9H4aX4AMyZ0r+oy1llfMntEizQ7RtR6bf7yAHevbHxNwu7GBZK5eBpDetVMQrkBA2LX74Xt8DqXs6z+zjdWJya1f6UFVYrU17Sd3iLZsSEdIxn39mLz7zxWhb8BYXLB2qj7T20B0Bcg5K/xI4zP9MbnrSJVoJeT5Dmhv8MYQxy0lwnnh91WxxWnv+HQ0kQe3plwBl9OspuU/PbDXd6R4lDZ9ZJmpiIXvu+kKqPQgkl2TF3We8TrFqH690M1KCGaX9TfIpZt1JQjKoI+OERdvOPmEOexmf8fQc/bREm9GzNT8pYBvL+ay5GEJ/Hggyn5jxitQIB4gcxcOSwNrqCWcjawb5tDLdD3LWuCGMGavNsqVDIpeYYcQdd82TlHhh2e7QWbrG+RwYu2KPLo49ca9OAl3R068hW/toOwucX8Ostn1KwBUrE2VSxkx3uRupuhEJEuUL+tNuM7puq10tPan0t0TzWhCxkhbKFeMnbpTDVHEURVUtxtQbXKzsNzEjELq0XaOPCgXv+WLWY8vbgT9Fvw5gDhWoU8k71Fej6y7TlYOXhzAvgJczQ5jsiLiPWqDdsrbhVUPUgl0Og/6zE4REWYOVsRnnElE7aUgmcv07OKaX5XjKUrhjD3s3fAD1cnjP8eYk9//fI6aj3qSuPxmzvpl8i6znOfrKSUPT0j3ZwXSgC5lHJhXioEIptq/uJElhcYJ7sOuBgd2aaGcBQao=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799012)(36840700001)(40470700004)(46966006)(6666004)(36756003)(47076005)(478600001)(36860700001)(26005)(16526019)(2616005)(426003)(41300700001)(336012)(83380400001)(40480700001)(40460700003)(82740400003)(5660300002)(110136005)(70586007)(70206006)(44832011)(2906002)(8936002)(356005)(54906003)(81166007)(316002)(4326008)(8676002)(86362001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 09:20:34.9684
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ba630b-c4d6-42e0-bbb9-08dc134fbba4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4076

Revision 2 is SW compatible with revision 1 but it is necessary to reflect
it in model and compatible properties which are parsed by user space.
Rev 2 has improved a power on boot reset and MIO34 shutdown glich
improvement done via an additional filter in the GreenPak chip.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Support older combinations

I want to support all versions we created:
All of them:
-rev2, -rev1, -revB, -revA, "xlnx,zynqmp-smk-k26", "xlnx,zynqmp"

rev1:
-rev1, -revB, -revA, "xlnx,zynqmp-smk-k26", "xlnx,zynqmp"

revB:
-revB, -revA, "xlnx,zynqmp-smk-k26", "xlnx,zynqmp"

revA:
-revA, "xlnx,zynqmp-smk-k26", "xlnx,zynqmp"

And also single one are permitted:
-revB, "xlnx,zynqmp-smk-k26", "xlnx,zynqmp"
-rev1, "xlnx,zynqmp-smk-k26", "xlnx,zynqmp"
-rev2, "xlnx,zynqmp-smk-k26", "xlnx,zynqmp"

I didn't find a way to pretty much all the time force that there must be
both "xlnx,zynqmp-smk-k26", "xlnx,zynqmp" that's why there is only
requested to have xlnx,zynqmp. If you find a way how to encode it please
let me know.

---
 .../bindings/soc/xilinx/xilinx.yaml           | 32 +++++++++++++------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml b/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
index d4c0fe1fe435..39242efeec47 100644
--- a/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
+++ b/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
@@ -117,20 +117,32 @@ properties:
           - const: xlnx,zynqmp
 
       - description: Xilinx Kria SOMs
+        additionalItems: true
+        maxItems: 6
+        minItems: 3
         items:
-          - const: xlnx,zynqmp-sm-k26-rev1
-          - const: xlnx,zynqmp-sm-k26-revB
-          - const: xlnx,zynqmp-sm-k26-revA
-          - const: xlnx,zynqmp-sm-k26
-          - const: xlnx,zynqmp
+          - enum:
+              - xlnx,zynqmp-sm-k26-rev2
+              - xlnx,zynqmp-sm-k26-rev1
+              - xlnx,zynqmp-sm-k26-revB
+              - xlnx,zynqmp-sm-k26-revA
+              - xlnx,zynqmp-sm-k26
+        contains:
+          const: xlnx,zynqmp
 
       - description: Xilinx Kria SOMs (starter)
+        additionalItems: true
+        maxItems: 6
+        minItems: 3
         items:
-          - const: xlnx,zynqmp-smk-k26-rev1
-          - const: xlnx,zynqmp-smk-k26-revB
-          - const: xlnx,zynqmp-smk-k26-revA
-          - const: xlnx,zynqmp-smk-k26
-          - const: xlnx,zynqmp
+          - enum:
+              - xlnx,zynqmp-smk-k26-rev2
+              - xlnx,zynqmp-smk-k26-rev1
+              - xlnx,zynqmp-smk-k26-revB
+              - xlnx,zynqmp-smk-k26-revA
+              - xlnx,zynqmp-smk-k26
+        contains:
+          const: xlnx,zynqmp
 
       - description: AMD MicroBlaze V (QEMU)
         items:
-- 
2.36.1


