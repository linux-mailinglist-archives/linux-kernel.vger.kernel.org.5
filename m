Return-Path: <linux-kernel+bounces-5432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3890818AA2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67616288A26
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F2337D31;
	Tue, 19 Dec 2023 14:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V1uT1o/t"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E85637D0A;
	Tue, 19 Dec 2023 14:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6twqPcAyFL5FAYY3jXAbI4KA8z71XAtp20svkhHC9gfOLDsLwlquR3K01zz/6Aey3UlA2kttKvBSakqKYB5T9Mm+F59CV9JfbxquqLuBwEWqeSPCUc7D+plZRb3o0mcgmXVLThzzNofq0WY3rXJjtiEK+IT6KbA0pwZr4d5EfLGOioXygInl1Ky5d7ljSH2wRX5X6jHoRC4bqLfyceFgw3fQyA2Ygktrd88CLu24Z0HdoE7yKzkG2x7pmhbSFzFFTs3uHtJPuKYbE46BqEmiXdsJFhxvT49vbLgSTBLsTbjbI6FKkDx89+sAHTSNUZg1kAg03bRZzKTFRJBkJYYJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqWjwfPVf5bOZ4lEr0On9uodQdZrB4Qh2kl2O8oLQGw=;
 b=MgsMGrf+4ZgzHJ8lUH3+0/9HtQGFSkj0Q4tV/3NXGdQZpi18uQdmd1BE5MK6hWd+P2DI3Tzww/pq60Hh42XsDKhsiTjQLB6aH8hftdpjx6hwaHdloBTL9iPGSK4Jsf8afAP27p4PZCxMRnFag0l+P+1C8HBxNCAW2aJEhGlPBjxBO7OifENMpCvyb46JaPRDnaGVZSEHRYiOc3OUezgFyXY+8TM0Fb3ibJ2GDVIz9Z/i+lRJSbtanyFw23Q/gkFNgJtmDkAMDm2Wv86G+mziSLsFmCJEQ0bQupU+2RcNfiih3wLz/NUR0U2lLPb2Oe0AjKIl1bWkPM7+gv1K7W+YDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqWjwfPVf5bOZ4lEr0On9uodQdZrB4Qh2kl2O8oLQGw=;
 b=V1uT1o/t/HlB7WR4ZkJPpMqWFZMytZmp4jPPP1DXteD82WDmPGhU4BQN4+zNLu0pjvnbyPwlIXakpJA6QrdPgV86iZrMYcuJheM1BkBpmb5no5B49WbRlf1IVnB2TAHutjnYPZ8GVQPanCeotQ8SP8dHJ5wD3pK8sjQX53kCO+I=
Received: from BL1PR13CA0199.namprd13.prod.outlook.com (2603:10b6:208:2be::24)
 by MW3PR12MB4428.namprd12.prod.outlook.com (2603:10b6:303:57::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 14:54:47 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::cc) by BL1PR13CA0199.outlook.office365.com
 (2603:10b6:208:2be::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Tue, 19 Dec 2023 14:54:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 14:54:47 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 19 Dec
 2023 08:54:46 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, "Naman Trivedi
 Manojbhai" <naman.trivedimanojbhai@amd.com>, Rob Herring
	<robh+dt@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.com>,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	<devicetree@vger.kernel.org>, kishore Manne <nava.kishore.manne@amd.com>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] dt-bindings: firmware: xilinx: Describe missing child nodes
Date: Tue, 19 Dec 2023 15:54:43 +0100
Message-ID: <5bb16305a05692de29ee2aa2accc793e23b68dec.1702997680.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2169; i=michal.simek@amd.com; h=from:subject:message-id; bh=hZUAhmQCedc4fTurAqQ9hLIWdClc7S8FYQBY63dpPoc=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtTGdRtDtc5ZfWRftjT8t3KrhvUOQYMra3yTMhL2LLeK5 Bc7NnV7RywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZiIwB+GeTbe0Qc3ypwtqOlt z9TPql+XXaJ9imGuRGPDPcdysx05Ul+dPidK8b3Y6HMDAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|MW3PR12MB4428:EE_
X-MS-Office365-Filtering-Correlation-Id: 1544ec7a-1e12-457b-dd2e-08dc00a271cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KUXwBqxUYaHPkD6v0EUByglPNBCQU9fnLt/Z338QorSQUkW+dwfbbNmQKgGmYxvISLe8J66Mzl1Y5HUiVf4OMukhgIu0DdiaxN6nmWCJHYjpNoqEy/XZmAxeAtaNMoalZ30yFm595G5K+M3NiZ04Ox9I1W8O1Xl/sZ7S2E86WPUI8tEwbKGbZk/Af0atFY9NEy3JM0I+k9NoF8hpRuYoJn0Tio4egSyJFyCtr1m4YG7ju0H5BEak1VM+L179eROHZ15lwmyeh2ExOcwFqrNRoiBn9MAiUo+GG2/4Himbnob/Hic99ITkXKbZsf6AvpHT5hzH8EDQqLJloF4QcVZPzE1rn+NpV551DVHnVjdCeZlVF7M3xh5aDT8xQCGH0YEibqkSWn2yIS7iBXOkrv53k+DR+6028aWgVSU8uXo2y2O11mliTf/PGmx3yH6q/Ehst0k5q5wunKL6IVJ3aVgQs3DnkiglJjE7XrnwoQcRJFJ5QukNKelogRtDxYS6qAYc/fd+gKbnysSXi1yxo/VOb6J/MkbQ+YV1YjO1+OCXIwp1NzOx8tAQpxCSSYu6J+g0wyoIG/KUW2XF20qcUC5O269e5l1aO3lI3zfC0BdBY17FS/+M91UL9FZgFxB0g5GT8YmhIHOlxCWkRVuLD3pRPfIyor3gwtuRWwzQMehoqIXrGrUe0/3ZKfZ3EwG2pH8aVgOpxdJSVsAyX333yTem9yAxMHJhR9BSxYpMtSfkLCzn+GQ9FaMrTdAcoYas78HSlYF5UMx4LC2gPAW7NGQm8GTVgcmhwRXD/kQITw29JNo=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(82310400011)(186009)(46966006)(36840700001)(40470700004)(82740400003)(478600001)(36860700001)(40460700003)(47076005)(336012)(426003)(26005)(16526019)(2616005)(41300700001)(83380400001)(36756003)(6666004)(40480700001)(86362001)(2906002)(44832011)(316002)(70206006)(54906003)(7416002)(5660300002)(70586007)(110136005)(4326008)(81166007)(8936002)(8676002)(356005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 14:54:47.3252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1544ec7a-1e12-457b-dd2e-08dc00a271cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4428

Firmware node has more than fpga, aes and clock child nodes but also power,
reset, gpio, pinctrl and pcap which are not described yet.
All of them have binding in separate files but there is missing connection
to firmware node that's why describe it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 .../firmware/xilinx/xlnx,zynqmp-firmware.yaml | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
index 3d578f98ae2c..0662544f86f0 100644
--- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
@@ -53,6 +53,37 @@ properties:
       vector.
     type: object
 
+  zynqmp-power:
+    $ref: /schemas/power/reset/xlnx,zynqmp-power.yaml#
+    description: The zynqmp-power node describes the power management
+      configurations. It will control remote suspend/shutdown interfaces.
+    type: object
+
+  reset-controller:
+    $ref: /schemas/reset/xlnx,zynqmp-reset.yaml#
+    description: The reset-controller node describes connection to the reset
+      functionality via firmware interface.
+    type: object
+
+  gpio:
+    $ref: /schemas/gpio/xlnx,zynqmp-gpio-modepin.yaml#
+    description: The gpio node describes connect to PS_MODE pins via firmware
+      interface.
+    type: object
+
+  pinctrl:
+    $ref: /schemas/pinctrl/xlnx,zynqmp-pinctrl.yaml#
+    description: The pinctrl node provides access to pinconfig and pincontrol
+      functionality available in firmware.
+    type: object
+
+  pcap:
+    $ref: /schemas/fpga/xlnx,zynqmp-pcap-fpga.yaml
+    description: The ZynqMP SoC uses the PCAP (Processor Configuration Port) to
+      configure the Programmable Logic (PL). The configuration uses the
+      firmware interface.
+    type: object
+
   clock-controller:
     $ref: /schemas/clock/xlnx,versal-clk.yaml#
     description: The clock controller is a hardware block of Xilinx versal
-- 
2.36.1


