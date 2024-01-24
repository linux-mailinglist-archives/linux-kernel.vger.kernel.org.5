Return-Path: <linux-kernel+bounces-36678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728EF83A4E5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0A96B22806
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDF117BC7;
	Wed, 24 Jan 2024 09:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nEA3v2W4"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A96517BB2;
	Wed, 24 Jan 2024 09:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706087291; cv=fail; b=ry6DXXXPw0bpZIWa3vmBnPozprrhghGpKD2XusfmJqRM25c5JvwyqtWRU/NwovZb+dqaRdYK3rKLqmUnkEeo3L7rXIulyTik/TDBm3I6kZa2rW2V5kVb1hiumzkqnVdu4IjCqMV3g1nmJGRvw2uFreKUUEAXQHzhHVyYXBz60B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706087291; c=relaxed/simple;
	bh=OS55WheOhmjTD4ZfpDT1o+7RdfLMX+mHuxjQo/jg23M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=otzmfYsL0y8D6E5UCaF1XIPWRw3Xz5MoNNI2GeupGLX40kvOa5by68ROOIo+mCI0CM9SW8m4D2PDxzQnMoHC13BSD8mlC9ViCnrktZzr2l4nerOMM17N3SNZyGzK5UeMHY6QQOzaczvZetSu+XHQJwpPAfwLecO1SDCbR500pnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nEA3v2W4; arc=fail smtp.client-ip=40.107.92.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQSJMQWugyLKv1oa9iTj5G8O1FKNALeddoq2BrVi8VqFhgOHQOtho7Q0mZP3QAPwsXy5J/0XtXJrkyNCmhwiuGagOBOqtYQSzm7PMf7zncplgDkRqMvljyr8/56qbXmZzHxjRTcbxouXB6QFuExqgtDYwQkv7VdQ1k6SF6ZbleWG0yA0E1WBxWX2OcCEFePt/GpYJ35JLVvMwLxUQgl2QIbUFFZUsouqgyQ2pqLcO8Z+Duero0zZ7yaFINfCVlsVuExuOcmfOvmTHB0AkkKMjpx2Z519D8Q5YE7qTBIhp6AH48aVCtUitowY83JoCCzx2XMpbisSgyM98MqdqlRXMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGF3gQZ3U4yMaIPf+erflPg+igE3eaj/Z/etLkjQu5Q=;
 b=VJXhZ72XBYxUWBqHHgSTnrJ3FYIUi00ilOOpPRxjQr4vJ5sIKSU0FVH1hZazs4A86BXXI/A3AJjViLU+CBd8lSrWQPBhc0XH4boqjLXb7udeBs6viVQv7Jmw6N3Qozp9+3RnDykySSer2ZpyGYrz0vs7YKrJ1+0bSu9mtqjb90ecFPIV89YOjE9jRLERv3d8MRpwVG/QOtP1gUWON6999Yx2hakypt09Tp1oBVe1apfEVmJgSNN4GjLlYJ9Ik4MhHLGdYJd57AfX1xeY/7F/UXTPehdLnhsqJXuPLw8GWZCS4qIIC0aj+UK3dqTJYDAVKtYfSxddtmeTfsG881dn+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGF3gQZ3U4yMaIPf+erflPg+igE3eaj/Z/etLkjQu5Q=;
 b=nEA3v2W4StomDxYCnAF+jiQ3RodOCmbJREd+MrV/UgtwKNyQeN0buTDZ32GVhIbINgKiUW7xARZYo47sroxBUfB7FuH16tY5Ag/mromiVMO2hkTkcCSsuPhD40oEYXAdTVd0d0Oa/rxBil7OIIK+qMmuFPBCo0/iWbSFQVso0no=
Received: from SJ0PR03CA0022.namprd03.prod.outlook.com (2603:10b6:a03:33a::27)
 by PH0PR12MB5434.namprd12.prod.outlook.com (2603:10b6:510:d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 09:08:05 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::8a) by SJ0PR03CA0022.outlook.office365.com
 (2603:10b6:a03:33a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37 via Frontend
 Transport; Wed, 24 Jan 2024 09:08:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Wed, 24 Jan 2024 09:08:04 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 03:07:57 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krishna Potthuri
	<sai.krishna.potthuri@amd.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Linus Walleij
	<linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, "Sai Krishna
 Potthuri" <lakshmi.sai.krishna.potthuri@xilinx.com>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated
 list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "open
 list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: [PATCH] dt-bindings: pinctr: pinctrl-zynq: Fix compatible string
Date: Wed, 24 Jan 2024 10:07:46 +0100
Message-ID: <c1307a4dd5e30290acacc786cb2170deb9eaa539.1706087258.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2197; i=michal.simek@amd.com; h=from:subject:message-id; bh=OS55WheOhmjTD4ZfpDT1o+7RdfLMX+mHuxjQo/jg23M=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQNl6MXux8WaatgU/gpWmrMl3tOo6haXuDb88m5fEkKz XNbJG93xLIwCDIxyIopskjbXDmzt3LGFOGLh+Vg5rAygQxh4OIUgIloX2aY773+ucLxrP/OChX6 +1fNndNRZzQnk2FB47Y5pc5RsTNTWPqOOCuzFWlp5NUDAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|PH0PR12MB5434:EE_
X-MS-Office365-Filtering-Correlation-Id: ac68aa8a-1ed2-4007-8fbc-08dc1cbbf966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zgLxK9ZtzwgAlkWOjnlftbQTxi3xptY7CTSKOEsM5MsAG/wiLIopAzLhfaXVA8Ig7XMWOl3VizOQxr2efK+OG15wCkDUDSAdJ0x/Y7NSPScRXAAfTsBvO8xVZEb5jMEbje1uDCakah9b75+nxeoscuCrjSXIdi4r1NvwMOsXB4gK5ZmLAJNgRd4YLBnIJtKx+/owSjKEEyUNiZEwS5n9gUlo1vPhhOM2zLP1vn4oNaz1/2B8K4VrHO1mam3EoWhT3h37Cb9rWXvFvm6ISFYsisZNvwlLh3bF/I8sic3yojhFBo2fr/8ExuhTzHZoQOB/rICwpR21CEvUo9Rp++3UCVDfeP1rBhmhmTo2CYO1zpQ9hSuwiQLvn1N8TTd0B71waYYj4JsZUUgj3JB1J7gb2ZOr6/fasLPFk7bvMQJW4M6BNHrsxHhkVbS6eEpzDXhf0af31Nf8TCELTYsL/o3F5C0Q46XOU5Kgrixt7Nx797rNcMe6VehqEikGrpOpIjsWR6N5e8QYLQTo7L3ejpaoN0rszib1fmKxkv9CnbZ7m5pvXCKJ85z0LesISgh9CII0BBqqsTpFBZ3JVZ0qpS25uciil1MigE4bL9z1r9UQkKaCLU4pTW/NsB5bwzdybIMZYnylPqvwPl486hH73E4+unmF5+Q3/B23ZXdeHeIl5aIMqjSeLz07IeQnqFHTY6Ve+SHI9NBpgMcImIzZo6RO3hvpPo7SOJ2z4RUDzjOR2kYH9/xYZ8i7lgY0UNyf2/vaVj343FRPxnJMOwWv43zcxMrXA6IjewetAQdBcj95ATGYd85it2HYXusYZaguvQRr
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(451199024)(186009)(1800799012)(82310400011)(64100799003)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(44832011)(2616005)(82740400003)(6666004)(966005)(47076005)(83380400001)(336012)(426003)(36860700001)(16526019)(26005)(478600001)(81166007)(70206006)(110136005)(54906003)(70586007)(316002)(356005)(8936002)(4326008)(8676002)(41300700001)(5660300002)(7416002)(36756003)(2906002)(86362001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 09:08:04.6759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac68aa8a-1ed2-4007-8fbc-08dc1cbbf966
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5434

Compatible string doesn't really match with compatible string listed in the
driver itself. While binding was converted from txt to yaml
xlnx,zynq-pinctrl was listed as compatible string but example was using
xlnx,pinctrl-zynq and also this string is used in all DTSes.
xlnx,zynq-pinctrl is used only in dt binding and not present in any DT
which is stable for quite a long time that's why use old compatible string
and update binding document instead of starting to use unused compatible
string.

Fixes: 153df45acda0 ("dt-bindings: pinctrl: pinctrl-zynq: Convert to yaml")
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 .../{xlnx,zynq-pinctrl.yaml => xlnx,pinctrl-zynq.yaml}      | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
 rename Documentation/devicetree/bindings/pinctrl/{xlnx,zynq-pinctrl.yaml => xlnx,pinctrl-zynq.yaml} (98%)

diff --git a/Documentation/devicetree/bindings/pinctrl/xlnx,zynq-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/xlnx,pinctrl-zynq.yaml
similarity index 98%
rename from Documentation/devicetree/bindings/pinctrl/xlnx,zynq-pinctrl.yaml
rename to Documentation/devicetree/bindings/pinctrl/xlnx,pinctrl-zynq.yaml
index d2676f92ef5b..de6c10ba36c4 100644
--- a/Documentation/devicetree/bindings/pinctrl/xlnx,zynq-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/xlnx,pinctrl-zynq.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/pinctrl/xlnx,zynq-pinctrl.yaml#
+$id: http://devicetree.org/schemas/pinctrl/xlnx,pinctrl-zynq.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Xilinx Zynq Pinctrl
@@ -28,7 +28,7 @@ description: |
 
 properties:
   compatible:
-    const: xlnx,zynq-pinctrl
+    const: xlnx,pinctrl-zynq
 
   reg:
     description: Specifies the base address and size of the SLCR space.
@@ -181,7 +181,7 @@ examples:
   - |
     #include <dt-bindings/pinctrl/pinctrl-zynq.h>
     pinctrl0: pinctrl@700 {
-       compatible = "xlnx,zynq-pinctrl";
+       compatible = "xlnx,pinctrl-zynq";
        reg = <0x700 0x200>;
        syscon = <&slcr>;
 
-- 
2.36.1


