Return-Path: <linux-kernel+bounces-81062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D62E866FA1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DFE91C25C92
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5172E5A787;
	Mon, 26 Feb 2024 09:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TsHTKA2I"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FBE59B70;
	Mon, 26 Feb 2024 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940052; cv=fail; b=PYpW4dIsfE4+Hlz9Z59anjMfdJtDMnGiG9Ihd5ehfkLq2j88k2sCk2VW3zcAawYmeSo74U+eycmmWi7sSbb4LaHBwV/Y9U13FOGYiPLKq9CGyAaKWtakEB7VJBJ45k+jLnhJHO+fB0qJPU2QI/OD1AC6Ggodh9f+Jmhdj9hqcPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940052; c=relaxed/simple;
	bh=n5kdWOGHcqUQi1C01+5xje06SaqcPxfMqLu+q83VKK4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ViAcKJHVKi2sRoGofdJ9QQWWQ32vAL7Q6FMpr+TVSNafMn1YFSzaxEfz8qSp0JnjHQz8gC+EUuVuCdJHOdofxTDzqOpZOWlgJpFKhc/7fFc2QTx978IvX131Q3Z7qI1Zu1AzTYWC7M78dxrwAZHjLA5begoT1K599W/KZeimnaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TsHTKA2I; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqEp6MbfqJw7ez7MHtwL5MqPoUWxKGtlfh/lUIWGXcAPJ+fdCH+nJxiM46CBm5vCg7iBa3FxKTXeGGplTy82b74VFBX/1pNx8jzmpiE3kdQGaEW0D9U4/ZuArC/bKTSpKF3IzRa9WXGAuscZ9T/Zx1ljlgIcWItqWXn+dT44YYKK4HULCfIH1gZKPlPe+10e+7xuUdLENOt0BX3mkqUy8ZtuCYrPzhdbcWFM5HIChU1PygsxhNZcQypQLpPaI666h1/ev2lfzj4N32LIw6kml4jhyj4WK2NZtTAwGTuZ8nubvv2WJ7jc7qbSJmBxOTtzoJR40CnFHS1cdLIV4NZqEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+O5bCVThQKY+yU0HHeTtd7kcs7uNH9IJcrnKxTr0gc=;
 b=iu1Qu8kmg2MKSkqNmBJfub5hkTV/txDxeBf8SvPyRI6OoP0DRLYgvLo5USLv1cQjLzLm9lzjU2DL08r0kGa8Jp6i3UCEmSQRYM6sMFPyENSs3wOO9Ae7efjg11TDFX5tX4Igu6nHdrNs2hO5MZBGM2UxtBe2n1ztYhVZ/TU6q9eAHqpuq9YLob200hUgku78VHZpLZ4dk0MTpU9s3rXmH+iFncaHs+o/fl+UHn1I8XiggZ9w2aa/b/UKt6MvZ1lM+LRJj2ePB9cFbL9SX08sUErPxzI7SUu1RLYt83dH3F5WwttIWbf2zYlDswR3utcnFOwNmyyB5vx+EVIpZIZmfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+O5bCVThQKY+yU0HHeTtd7kcs7uNH9IJcrnKxTr0gc=;
 b=TsHTKA2I/QbuP/gPefJHdkq6xGw8qPls8m27NG4SesyMp1JkWqJYQLaKgK4EgpjYk/4gNX1Ib6DSlY/2dPRAzwfX0eFbwdiB0L3l/xWUhiKmMZOoObp1riAD4bs5Iqqy/7fUqnaxR8adQ5QStLE/TO8VOejDG6zBPssqINVcI/Y=
Received: from SA9PR10CA0024.namprd10.prod.outlook.com (2603:10b6:806:a7::29)
 by PH8PR12MB7136.namprd12.prod.outlook.com (2603:10b6:510:22b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Mon, 26 Feb
 2024 09:34:05 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:806:a7:cafe::1d) by SA9PR10CA0024.outlook.office365.com
 (2603:10b6:806:a7::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Mon, 26 Feb 2024 09:34:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Mon, 26 Feb 2024 09:34:05 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 26 Feb
 2024 03:34:04 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 26 Feb
 2024 03:34:04 -0600
Received: from xhdmubinusm40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 26 Feb 2024 03:34:01 -0600
From: Mubin Sayyed <mubin.sayyed@amd.com>
To: <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>
CC: <daniel.lezcano@linaro.org>, <tglx@linutronix.de>, <michal.simek@amd.com>,
	<linux-kernel@vger.kernel.org>, Mubin Sayyed <mubin.sayyed@amd.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3] dt-bindings: timer: Add support for cadence TTC PWM
Date: Mon, 26 Feb 2024 15:03:33 +0530
Message-ID: <20240226093333.2581092-1-mubin.sayyed@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|PH8PR12MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f070777-eeaf-4ae0-178f-08dc36ae131b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b+3GVh9E4He4LKOgIDz3aH4KW5f+yhX2iDS3GlXhYQDqLG5HFs8zYCmUhvAWYgcbcS88S3I0Fgb49wNUN6zYOB+4RizUAM5K2FN81BQsliSjEbMjLFOy49YjvIjYBnzno7bBbLJkxyl+fqv0XQo6IxuzS94BDGtJdQ0a+QycjOWNhMGM3qv6XkNYFTFeIeeHKI1Xt+wnflSYt/x9iWks6E5J2MEnUq+YBAtE1eYRkPl79l70uM9u9tLZ6Rr9cKcIr5I8NWnmaJ/zvDDaVtB8LQb+L+96DZ8lrAKMYqh3mm5i0dPN0cSA0UNFQhl03Au+C/8O2byIM8BxmPNVJit9k0BjQzBiSL+thf769G9+IZtg3q2SAiRCaKn3c4k6WARixCm5PaqLF79KkrWr+tTsYItV4pVNNy+nF1C/gs3Rh7+qi7tP20TVAR2dNfANdUiAWM6qG2t51Ywb34VAQEXiVmi1czKCmtazuT9Rq5dg5ogKcyTvw8yljzNEQL579nbWf24X6Kssvn5WDCo+4gJUY5VcG9g5cMCUsYHFh9jKVWlWBvpj+rwspA7uBHbiqzxdCpnFLKDA/Qwv6Wa3yIlSIdIL/NUJuUFVq4qahC71z4fX5om2i/TNEKOeBRVBlwgRtf3tF1Et36t3nu5muB1ymfyQU6/2vZwOIyFXo4ggb8tn0RUuacVIWEnnRHZ3/P37TBh5H5FtCZKO+GA0tcCLOC4v71LOhzG0Bu82MF3xaCuiOM6e8BGw0nGm4IIy3q09
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 09:34:05.1894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f070777-eeaf-4ae0-178f-08dc36ae131b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7136

Cadence TTC can act as PWM device, it will be supported through
separate PWM framework based driver. Decision to configure
specific TTC device as PWM or clocksource/clockevent would
be done based on presence of "#pwm-cells" property.

Also, interrupt property is not required for TTC PWM driver.
Update bindings to support TTC PWM configuration.

Signed-off-by: Mubin Sayyed <mubin.sayyed@amd.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes for v3:
  Add Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
  tag
  Remove bindings from subject
  1/3 and 3/3 are dropped as of now (WIP).

Changes for v2:
  Update subject
  Modify #pwm-cells to constant 3
  Update example to use generic name

link for v2:
  https://lore.kernel.org/linux-arm-kernel/20231114124748.581850-2-mubin.sayyed@amd.com/T/
---
 .../devicetree/bindings/timer/cdns,ttc.yaml   | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/cdns,ttc.yaml b/Documentation/devicetree/bindings/timer/cdns,ttc.yaml
index dbba780c9b02..da342464d32e 100644
--- a/Documentation/devicetree/bindings/timer/cdns,ttc.yaml
+++ b/Documentation/devicetree/bindings/timer/cdns,ttc.yaml
@@ -32,12 +32,23 @@ properties:
     description: |
       Bit width of the timer, necessary if not 16.
 
+  "#pwm-cells":
+    const: 3
+
 required:
   - compatible
   - reg
-  - interrupts
   - clocks
 
+allOf:
+  - if:
+      not:
+        required:
+          - "#pwm-cells"
+    then:
+      required:
+        - interrupts
+
 additionalProperties: false
 
 examples:
@@ -50,3 +61,12 @@ examples:
         clocks = <&cpu_clk 3>;
         timer-width = <32>;
     };
+
+  - |
+    pwm: pwm@f8002000 {
+        compatible = "cdns,ttc";
+        reg = <0xf8002000 0x1000>;
+        clocks = <&cpu_clk 3>;
+        timer-width = <32>;
+        #pwm-cells = <3>;
+    };
-- 
2.25.1


