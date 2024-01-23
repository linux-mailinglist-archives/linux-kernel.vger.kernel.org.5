Return-Path: <linux-kernel+bounces-35439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC347839124
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403B61F24469
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3615F864;
	Tue, 23 Jan 2024 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vKJMwxbA"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838F65F848;
	Tue, 23 Jan 2024 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706019440; cv=fail; b=nQ4ev+iOn9BBJvkDtxQDCvx3fyT+NUrjUSp/FHNvwA0prKnr1cSa21wRUY63RJIdw5YrCVGKZMx60nHmpjDLwrYfCs0XPpP0qqk4U64oiAh6nh7kco6L0XERnK9nsh/dTrlRmxbDTfuW/0rMDKk9n0Wfogswcft6nDjKHgNnHl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706019440; c=relaxed/simple;
	bh=Ij4A4XTbxviHb+2nyaUhIEsXBbobA8Ua3QKMI88j9Bs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AAk+nDbCa8Y9kJbmhC7Rx0+bjsrf0JD2X9xb2ZLi1gDf66oeT8ud4vzD+XD2XuTgXUzdMwfKnqy48SJG1jxlp51NXIf1Eh+hcpo4Cvek9Q4jRNbZ8xdT/Otan+Jzv1FM4X3NVZmnkuPFaSr4Rw3fHcwG9WC62Dr4+/eL8QKno0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vKJMwxbA; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNbibPHIEIfnVaofOFzC5IIBmvrwxCF2faQvMZ5sv4eaHCrO1UUriNESsDHR3YUmSya6Y3iGwfHvp+6uFIwEkwz3m40Bte94O9Oyd2NEnzIDMj05OAzzNzsf6eTFX4+tRBcVH1t8z6YyTj0cPc8CnqLQCZ2RT9ewDMHzTPY1dV7PS+2EB5bpX51BJXuNC3B64vDfVDGMriFrAixpT8RA8/OezUSY0kGJxLC3cv53PhI7aOh8uHSPd0Fc5ueJZNZAMdiguXdkl5prc3JurvEPbrQaS5mGZA2ihV6C0spV+N+e84Ifh0tmaIW3hk37KUdvQ2G0CoWkLm1cFHUgwruZaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DD4Mx1tlASwSWGI/EJpnT38uFe2eE7BDsng0hl407LA=;
 b=S+1qOJoghME0EK94dYoHsyEjpd5w/HIlLfhnKiN/rZlpfocb0FqeFpfeU73Lb48Dmg9MI31iAn3YOy7iAzrJledPGnolK6O0mMxUwisJNbBk1//spe52dMzfS5rcd86ZcdoyIDmQAEKNRe27U31gqtbI0Cjgcjx0JxB7KcN/cYa6AjtTIdk7/YYbctm9VbIkDSD7DhuYFaoTVa5cxYUK2pec5V3oWdUN/1EfDtBLFFTjBnNjSl+dKxA+c69rxuNfy7PWo39YZGDZZ4GEqm6fGj88U1vtluVHpjMFUTFjnlZZHMKRhhku/pxxO+g0aRtgbqo7LEVEMivUQEojUj/VQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DD4Mx1tlASwSWGI/EJpnT38uFe2eE7BDsng0hl407LA=;
 b=vKJMwxbAcfrv4RIwIlcVGuAvQSSLmeNz4jYCKbVsPwYra9EJh+wwIugmNm1iYatR4lbapdOybb+U7tzMZu+37or4GMmzK1KUSOMxHkF1qoO3JU5aJWUzPYCvBo5aH4pzhZx5fSgn0IhMGG5+eElEFMKy9Sibi87adeebGtlAbIs=
Received: from DS7PR03CA0289.namprd03.prod.outlook.com (2603:10b6:5:3ad::24)
 by IA0PR12MB8253.namprd12.prod.outlook.com (2603:10b6:208:402::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Tue, 23 Jan
 2024 14:17:16 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:5:3ad:cafe::91) by DS7PR03CA0289.outlook.office365.com
 (2603:10b6:5:3ad::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Tue, 23 Jan 2024 14:17:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 23 Jan 2024 14:17:15 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 23 Jan
 2024 08:17:13 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3] dt-bindings: soc: xilinx: Add support for K26 rev2 SOMs
Date: Tue, 23 Jan 2024 15:16:44 +0100
Message-ID: <90e1a393154c3d87e8ee7dc9eef07fc937c1eaf7.1706019397.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3154; i=michal.simek@amd.com; h=from:subject:message-id; bh=Ij4A4XTbxviHb+2nyaUhIEsXBbobA8Ua3QKMI88j9Bs=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtT1p9xunL11eS7HRtZZS2v+sp0/IT+hXvmE74dvBbHH7 wfG58aqdsSyMAgyMciKKbJI21w5s7dyxhThi4flYOawMoEMYeDiFICJ7NJjmB+/PGtz4NTaTTNm bNkXIb9xku4KC0+GebZbdjZPPO30+ujC2ytTJ5epFZY+DAQA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|IA0PR12MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: d8771385-68f1-4c65-90b5-08dc1c1e0027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XnsUVxGtUtA1JwUFyMJgSsJy3Wxgc1Qv8lEmKO7GfHe6n5il3u9I0dSfr5OWhLgzt+bS63vFMy52OE/lMNzU/UAX94SDHsR4SiijrvtMkW/xaSX5nbG7IsKiDG3I4tx6TcYnrwaxF3Py8eqYo1ayfwFiz3pWHY7F3l5GNWt88ksu7AOYkqdzl8CSmLzhWfG+FvmfQryBEmXwJ/MNPl51b0MILGiGxARUOcdh2mK0I6pR91tNqhC7IbnF9qOHBwS9+rP7bB8ehrG9ItUpPvwbY/3lBq10n/rgf61R5dZQpIW3z/7jRQaIBQ0Y3oBSJuNjBQzQOnFjkil4SpVydX2FBWievBsmvhUR581Ut0ENSBpFFfWysunnp8j9P3yGeg8N+ZZJAu1NkFaXBknqakaC4dbj1OhjshgXDGOmQV7IsUI9fbRpGYpNFKP7b+EebAxm9esE+lYvSFJidFIyTelNo9dwEnzyqM7Bb/G3u8Y16THSzK4jdBLirTBOj/lFR9TiCo/m0tenXgQOfMnRON1fb0vXJQuTKh3QwQ3d1GBqKC1c0wFqW2IN7FTVy8ECySaClGF6+DLVKjN8CC9x037FIfCjwGuEJz3RSxjXPBVgRx3DD4Vx9efMB2qgEu4gadJsjNqrtf3ajWlhmj2/naazN64ga7dqOhuoYWL6T7+WlEBYJP0aBY11XFu03cwL20p5JVb3Vj/z8SIUGDpW7rJ7RMFy1WA801ueB2mdEHOG4s67NFWc9R3uPKZmyjZhyI0cSayv58flCF+g6d8vQBkUdw0Wpgerc/SGNuuCInN3S4w=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(82310400011)(64100799003)(451199024)(1800799012)(186009)(46966006)(40470700004)(36840700001)(16526019)(426003)(2906002)(36860700001)(47076005)(86362001)(36756003)(41300700001)(81166007)(82740400003)(356005)(83380400001)(316002)(478600001)(6666004)(8936002)(4326008)(8676002)(110136005)(54906003)(70586007)(70206006)(5660300002)(26005)(336012)(44832011)(2616005)(40460700003)(40480700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 14:17:15.5863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8771385-68f1-4c65-90b5-08dc1c1e0027
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8253

Revision 2 is SW compatible with revision 1 but it is necessary to reflect
it in model and compatible properties which are parsed by user space.
Rev 2 has improved a power on boot reset and MIO34 shutdown glich
improvement done via an additional filter in the GreenPak chip.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v3:
- use allOf contains structure to avoid random chars caused by
  additionalItems: true

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
 .../bindings/soc/xilinx/xilinx.yaml           | 36 +++++++++++++------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml b/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
index d4c0fe1fe435..7c75dbb4f307 100644
--- a/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
+++ b/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
@@ -117,20 +117,36 @@ properties:
           - const: xlnx,zynqmp
 
       - description: Xilinx Kria SOMs
+        minItems: 3
         items:
-          - const: xlnx,zynqmp-sm-k26-rev1
-          - const: xlnx,zynqmp-sm-k26-revB
-          - const: xlnx,zynqmp-sm-k26-revA
-          - const: xlnx,zynqmp-sm-k26
-          - const: xlnx,zynqmp
+          enum:
+            - xlnx,zynqmp-sm-k26-rev2
+            - xlnx,zynqmp-sm-k26-rev1
+            - xlnx,zynqmp-sm-k26-revB
+            - xlnx,zynqmp-sm-k26-revA
+            - xlnx,zynqmp-sm-k26
+            - xlnx,zynqmp
+        allOf:
+          - contains:
+              const: xlnx,zynqmp
+          - contains:
+              const: xlnx,zynqmp-sm-k26
 
       - description: Xilinx Kria SOMs (starter)
+        minItems: 3
         items:
-          - const: xlnx,zynqmp-smk-k26-rev1
-          - const: xlnx,zynqmp-smk-k26-revB
-          - const: xlnx,zynqmp-smk-k26-revA
-          - const: xlnx,zynqmp-smk-k26
-          - const: xlnx,zynqmp
+          enum:
+            - xlnx,zynqmp-smk-k26-rev2
+            - xlnx,zynqmp-smk-k26-rev1
+            - xlnx,zynqmp-smk-k26-revB
+            - xlnx,zynqmp-smk-k26-revA
+            - xlnx,zynqmp-smk-k26
+            - xlnx,zynqmp
+        allOf:
+          - contains:
+              const: xlnx,zynqmp
+          - contains:
+              const: xlnx,zynqmp-smk-k26
 
       - description: AMD MicroBlaze V (QEMU)
         items:
-- 
2.36.1


