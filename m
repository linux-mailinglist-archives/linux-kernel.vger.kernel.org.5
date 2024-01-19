Return-Path: <linux-kernel+bounces-31106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D068328F1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAE8A2811B6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7EC4EB58;
	Fri, 19 Jan 2024 11:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y7pQKDnA"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9633C470;
	Fri, 19 Jan 2024 11:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705664209; cv=fail; b=alI/GNXhzTdvpizFoMZgCg4ENz9Jh9Y9KBfZeY21ll21Y5LRY+5cB3zX8RGk2vqL7CzKht/IWHAzR1Sdcw0SOQZAeDJzlQLqQM9rLCjGzuh7jJwaxIzGSGA0eosap2NpY0RWCa5YlSR8SEsk1KECNPuWGi2xcfWcSWN9ER5T5dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705664209; c=relaxed/simple;
	bh=lLzND4hbyFeh3NgBIp/0dFJh24fSVu4ObGGn9s6kuSo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rIUOCkzalUQSy3AuQ/btASRV8TLitLErs3cBzp4pgPxcs2pNfEcGMM94h2yTK2nDkD84y5vvTvV30xca5zaeL72kAffdNoxyDHECOYJu0rt8gf56b42jS1g7UKj9lEMOsoSghDUFh2Nt1ns1LUerpjcLYELzl3qr/QBABk9LVMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y7pQKDnA; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqLU3FNiY+WhAtQMDNlZO1okAiek1X+CKMnzobMO/ShsEZ3RAIM6IhDAFnTkiWN7tkoUHJxGBibmMGdTrWJT7G56PK/HON95YsNh1NEsLO7kyI4+843wFFoDw5aq7PICrMNPVOgURPph2mvayM3IwowsXoRRdKO2PJoGJE9Y285E7U5wwTlxfc88oqKBwaPNc6hfBGMKZYp2pvCdjPNnAruz9XIf2sLuzoQpvJU0rW9ZXRJ5qJTn7JlCJOOtf9kWOW56Tc/3lKHCTnCcCN9FN3BCS8XBhMuBRI8uEcr7yggYEOG86UWUfcgt5NVkVNN4wjvJ/Cg8SyBIaxUEC3HtMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgIzSTiNQXGeI9RlE397ErPvS4TLChjNgNQP0bOjUfE=;
 b=YM/Qa/vNq649vR4g9APbzrnqYgboZzhNVF7CO/1Q0+BhlmKFMoyZlOa+0BbSGQqagoU4UQ3pbWh8lw2eIr9D4nTaSTnYF6edRncXHSi1U2Jezfl6LBTclWK2e7AD/qdQThCmjL+SfoZYqmlvYppjFAXhQD8VB2/HJUgNATydbnKC7ckTseeNXYx53UeIrCKqXpT6QcdmDrvhmnIt4hKjlQlUWXC248DBaYkxq9tRat3Y1hu4XJV7ir8vWH6gYcUsSSnTK6ITYZcUAonwsTBpFQqQTrIcN4l+nYoNyFa09Q4mGioW3JKvn+M7o+5g+nISiXKBREfhE86jCfOez58s9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgIzSTiNQXGeI9RlE397ErPvS4TLChjNgNQP0bOjUfE=;
 b=Y7pQKDnAORZFaQwDcumssZzOLbY2CQM/6AYolR/xtTsMMqqUXKxZYLDjxl3B9bCTqgoXhHhXfExNu/+kWxcMbXx/fGQqneUgrOwKl7A4+ycJMn9UlTnArRIRe25CVq6dEJcJU3fj4B5fxbPGfk9shN6bV4c+9O+tITFTTBrfqOU=
Received: from DM6PR06CA0072.namprd06.prod.outlook.com (2603:10b6:5:54::49) by
 CY5PR12MB6576.namprd12.prod.outlook.com (2603:10b6:930:40::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.24; Fri, 19 Jan 2024 11:36:44 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:5:54:cafe::77) by DM6PR06CA0072.outlook.office365.com
 (2603:10b6:5:54::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Fri, 19 Jan 2024 11:36:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Fri, 19 Jan 2024 11:36:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 05:36:39 -0600
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Fri, 19 Jan 2024 05:36:24 -0600
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <dlemoal@kernel.org>, <cassel@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linus.walleij@linaro.org>, <brgl@bgdev.pl>, <michal.simek@amd.com>,
	<p.zabel@pengutronix.de>, <gregkh@linuxfoundation.org>,
	<piyush.mehta@amd.com>, <mubin.sayyed@amd.com>, <radhey.shyam.pandey@amd.com>
CC: <linux-ide@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-usb@vger.kernel.org>,
	<git@amd.com>
Subject: [PATCH] dt-bindings: xilinx: replace Piyush Mehta maintainership
Date: Fri, 19 Jan 2024 17:06:21 +0530
Message-ID: <1705664181-722937-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|CY5PR12MB6576:EE_
X-MS-Office365-Filtering-Correlation-Id: 252f67c2-ed13-4abc-e7be-08dc18e2e945
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mfznvKK7a1E7asVQkydCPxsTyRjr5pCyj6nrz+rXqsx6+rdmQ2h7pcK1VL/ZOqW5Sx82gtARMkY0lMRHiPYuPZTnrR6Uv0hDTJd6C6NAXw1xAbowID4V2gEfdsYE/kuK45vJscW3yZYoKYKsA6JI0zjoYmezPudWOIuItrDLLT6hdbfiBz4/1VMIfF7dXG0Of3Vrk/vR137RidukdovIh+p7olcNeRHtGOJLgxCZKf//zM+2dNUnZdsnHj70TAKwD/aAdr7Aa7C7+U+I1z89NKNiFD0pTL02TPqn+oDMwAxzc9aDlpCd4kppUk3kK4W/49lOSQ3mhpr28wSbnYTpjz74j3iR86Fa26ovnLVnZsGPKRqhaTeMlTE9P/oHXwMtyKdmVVsDfJdbhedXbIHMe59G03pB3AJhSub5T08Zs6DHhbG4lsDmiUxMlLVS6offg6M4o/HXVI+7X4hYf1chOBabsQNnw2riDpGizprlCCiHdSZmCEhDYvBeL+yhuJ5/B1m2lqZYudfZi2MQhuuSjwGsD9EGEBBGlwmpP/0KQ7ccaeIV0G/gRvrjY67x4d77QYMIwwE11Uq1e6aIWKVAf5hMdhy2F6CuuTkFAsPtsNghF0KcHb13fKXYSix3x5VSMpS3EQ+k2RqP+3OW3r2L82vsA57fHrtxYr2Sp47JK4TMgyd3iQh8d2cBZOt7kZfKYen5rcEtnEFJWpekHa97j7jG5aAHPPWPZRk9tKCuqziVIQ41yYUWJDt7fV6j7jc4Mqic/Md0sxwt3uGuvZOoSQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(39860400002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(82310400011)(36840700001)(46966006)(40470700004)(966005)(83380400001)(41300700001)(478600001)(7049001)(82740400003)(40460700003)(40480700001)(81166007)(47076005)(36860700001)(356005)(336012)(426003)(26005)(6666004)(7416002)(86362001)(54906003)(316002)(2906002)(8676002)(4326008)(36756003)(8936002)(110136005)(70586007)(70206006)(5660300002)(2616005)(921011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 11:36:43.4022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 252f67c2-ed13-4abc-e7be-08dc18e2e945
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6576

As Piyush is leaving AMD, he handed over ahci-ceva, ZynqMP Mode Pin GPIO
controller, Zynq UltraScale+ MPSoC and Versal reset, Xilinx SuperSpeed
DWC3 USB SoC controller, Microchip USB5744 4-port Hub Controller and
Xilinx udc controller maintainership duties to Mubin and Radhey.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml      | 3 ++-
 .../devicetree/bindings/gpio/xlnx,zynqmp-gpio-modepin.yaml     | 3 ++-
 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml | 3 ++-
 Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml         | 3 ++-
 Documentation/devicetree/bindings/usb/microchip,usb5744.yaml   | 3 ++-
 Documentation/devicetree/bindings/usb/xlnx,usb2.yaml           | 3 ++-
 6 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml b/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
index b29ce598f9aa..9952e0ef7767 100644
--- a/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
+++ b/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
@@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Ceva AHCI SATA Controller
 
 maintainers:
-  - Piyush Mehta <piyush.mehta@amd.com>
+  - Mubin Sayyed <mubin.sayyed@amd.com>
+  - Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
 
 description: |
   The Ceva SATA controller mostly conforms to the AHCI interface with some
diff --git a/Documentation/devicetree/bindings/gpio/xlnx,zynqmp-gpio-modepin.yaml b/Documentation/devicetree/bindings/gpio/xlnx,zynqmp-gpio-modepin.yaml
index b1fd632718d4..bb93baa88879 100644
--- a/Documentation/devicetree/bindings/gpio/xlnx,zynqmp-gpio-modepin.yaml
+++ b/Documentation/devicetree/bindings/gpio/xlnx,zynqmp-gpio-modepin.yaml
@@ -12,7 +12,8 @@ description:
   PS_MODE). Every pin can be configured as input/output.
 
 maintainers:
-  - Piyush Mehta <piyush.mehta@amd.com>
+  - Mubin Sayyed <mubin.sayyed@amd.com>
+  - Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml
index 49db66801429..1f1b42dde94d 100644
--- a/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml
@@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Zynq UltraScale+ MPSoC and Versal reset
 
 maintainers:
-  - Piyush Mehta <piyush.mehta@amd.com>
+  - Mubin Sayyed <mubin.sayyed@amd.com>
+  - Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
 
 description: |
   The Zynq UltraScale+ MPSoC and Versal has several different resets.
diff --git a/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml b/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
index bb373eb025a5..00f87a558c7d 100644
--- a/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
+++ b/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
@@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Xilinx SuperSpeed DWC3 USB SoC controller
 
 maintainers:
-  - Piyush Mehta <piyush.mehta@amd.com>
+  - Mubin Sayyed <mubin.sayyed@amd.com>
+  - Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
index 6d4cfd943f58..445183d9d6db 100644
--- a/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
+++ b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
@@ -16,8 +16,9 @@ description:
   USB 2.0 traffic.
 
 maintainers:
-  - Piyush Mehta <piyush.mehta@amd.com>
   - Michal Simek <michal.simek@amd.com>
+  - Mubin Sayyed <mubin.sayyed@amd.com>
+  - Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/usb/xlnx,usb2.yaml b/Documentation/devicetree/bindings/usb/xlnx,usb2.yaml
index 868dffe314bc..a7f75fe36665 100644
--- a/Documentation/devicetree/bindings/usb/xlnx,usb2.yaml
+++ b/Documentation/devicetree/bindings/usb/xlnx,usb2.yaml
@@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Xilinx udc controller
 
 maintainers:
-  - Piyush Mehta <piyush.mehta@amd.com>
+  - Mubin Sayyed <mubin.sayyed@amd.com>
+  - Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
 
 properties:
   compatible:
-- 
2.34.1


