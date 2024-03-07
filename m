Return-Path: <linux-kernel+bounces-95244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BE4874B2B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEFCD283666
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB8984A41;
	Thu,  7 Mar 2024 09:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KdV2gfn5"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A289D63134;
	Thu,  7 Mar 2024 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709804635; cv=fail; b=KmPhfbOKYU7H73dXLcsUFg55T0WTUvniRBDk870rdEflDgVNo5795pTVOAGZTJXYcJbsDiL0WKAKnT/CR4LpGmE+78QGPIMPwiSxdKx9ereEp+MvKp7wtTkM5sr3p8Xq8bQ46HSApF/kLQaD23nDtw8YNNKhkTpJCqptfjTqmbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709804635; c=relaxed/simple;
	bh=VCwpQeV914poFCeOibTY9jqnrURxoAlotmtTMNKtRjU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BMcP8K+48Ll42R8P0zW6murHySr4w97XG5hEeBoR8+VIt7Sm5Bv1f2yo33LQEfK6GkfdPI4cM6DAo9Zbb5zGdl7Fn3/rPykp6P7bS9W3E9+WGuzN0Xm1pd3vJ7SmsIqXfT1ZeejvQ4aA87bS6TPkJ0ydeiOyPRENrjMyuJkjNFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KdV2gfn5; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrb7lSowDUbOp4UiC8zNLwzUuWe1NCRnzBlhMZbz9R53BSnFrI6vgtXrVFUIcJlcgBBFT8W3ngyi5GgcRgPXi3Iw3p+0Z3BC4EHlw/NfXHsnP4C/8oKdaf4BFlFUTfVqC8QowDT6HrLoBaPvk63rOMsOC+CQ71Vo0Hv8BuBbabfVfPdM2OKtS2h/87D/ubwpELFrTFiLEG+O0iwoFpHtIA7VrYBLr/Wwvr+y7HD4nOAqE3o7GPVHYQpTAc7WEoYPrCpxzSsmBgGrBj+rXiNg8bFtfvOKEe7hLF4G8XRhqExWzBdH7bHUCbWXQkShGXEO4vZ0XCDdbBKihotNDyie4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChoWZXeKHFEsfvonTszI/L3TVDhQVdx8oWMuY5cyFDw=;
 b=TqzBbACM2/nSlPhW/uauky96FP04M2JiAOK3Y1EcjUmAywpdHWPeiksP4VXLkK/KTXrkNNMXJZ7rkbG03hXR70axwfkEh/lJSBaEZavcaEesFz5h6B81qvwzQRGMa+OraonqaQHsvUNtJhDZVh+OENPBoClkn/qY347d35sH/40C7doxTeh5yj77EGP+bV84/BjM5t7wj06H2sSXoy72nrtL+g9Xn+taNf6PIcc1k8g1sDF1Bl8/WeIupjNFXUWfrq7HFysMMxoq/YfSuU9PDeqVelUAwJ/r3lwO+0ybFfY6QEJbogOnf5oykuyncXrm5ljdQQgngELfxjMe20OO3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChoWZXeKHFEsfvonTszI/L3TVDhQVdx8oWMuY5cyFDw=;
 b=KdV2gfn52poSjkHz+m+H7A6ntzynZajJID77/iFW4D4e72NGKSJ+xT344Ekn8n3l64vYOK1TD5uGgCfbV5bfh4TORmDsqiF2sUMbLff/82CSpVgYGtkPDjvSTj0XcRjo7I2BRhTpHE2J5sGpsyNNpv94gVQoC/BAEJnMW0l44VM=
Received: from SJ0PR05CA0166.namprd05.prod.outlook.com (2603:10b6:a03:339::21)
 by DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 09:43:51 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::dc) by SJ0PR05CA0166.outlook.office365.com
 (2603:10b6:a03:339::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.9 via Frontend
 Transport; Thu, 7 Mar 2024 09:43:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Thu, 7 Mar 2024 09:43:50 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 7 Mar
 2024 03:43:49 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>, Conor Dooley
	<conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>, "open list:REAL TIME CLOCK (RTC)
 SUBSYSTEM" <linux-rtc@vger.kernel.org>
Subject: [PATCH v3] dt-bindings: rtc: zynqmp: Add support for Versal/Versal NET SoCs
Date: Thu, 7 Mar 2024 10:43:46 +0100
Message-ID: <5ecd775e6083f86aa744c4e9dfb7f6a13082c78a.1709804617.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1553; i=michal.simek@amd.com; h=from:subject:message-id; bh=VCwpQeV914poFCeOibTY9jqnrURxoAlotmtTMNKtRjU=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtSXPV4+qmYe6gIrGwQeHmN8/7MkKnK6YM+TuZxbfhvO0 Ijd/ta8I5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEzEJJFhrsgN5aiORY+UkxzP vVC+7JMn1HD3M8M8C48Htcs2/qtQ0Gp7Wbb83/NTnu+4AQ==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|DS0PR12MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: c88bfc10-ff8f-4d9c-3bf1-08dc3e8b186f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	H5FQ930bJAWSjHcNWE94s+niqgANZTLKY22b/Ko5QYwuQY9JkYiHoXPrq7iFzkhl0ilnXvKZ4ncLvrV/nCHQhNO7P0CZ44m2garYRp3+361hYLb8raVDGHTi+TpYmwDoFUS+oDPnYteNzFCa9AjvVZvPfj+JVVBZhmhFaAWZ0kAHDAT00PbGxDEetE8CFlDJ9N+kmRRT6E0+EMioakd2EH2f99nEhA9tSJh2IFO6OsiUyujbaNRxGUXag28h/pW7An/VlCks8vkyuxSdFY3xnOAjWC05eURMsvXNy/zgMQ/lL/NmfczKwYmsJ/US0AposMDr1O1HqIM5KiWMc4tDnuGJ8ibVJEutw4B4drAkG6WKZi5WdwJWzczyL6NczCoFKB6nDtx7mWyakyohoa6+CLSydVpZkZK4ePu1lggBCQ0sQ7m6WipWwEFOOC27lSLTepLg3DXDcVf0bjkPMlgtA3mQR/fEK9MU2lcWMa8UnO3QYwrzlxVHYp3vEBaBieDbM0pnwd5wJnRNmHpiMHGS8u+wm+oK2cu97y3MD6D6umtZ/WwtVRKqrTDXUgt76FTcDBIcgkX3ickEqNDJLg4wBFUDucMDVFofQdXI/BUN13O/sn6vmPSfS92DhsdJTLlSP6d0UpcdPpNt1XxeperZBfrKw3B3/GpwmSg0yhpDVHJveyk0fYV4Rg7io0cNH5po7NzNWzkYMVCNj4y/escwbfBY7LlS6EeKhlphoKFEf/UtnnSG3YiC+73kN3keib3h
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 09:43:50.9993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c88bfc10-ff8f-4d9c-3bf1-08dc3e8b186f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6413

Add support for Versal and Versal NET SoCs. Both of them should use the
same IP core but differences can be in integration part that's why create
separate compatible strings.

Also describe optional power-domains property. It is optional because power
domain doesn't need to be onwed by non secure firmware hence no access to
control it via any driver.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v3:
- make versal/versal-net fallback to zynqmp

Changes in v2:
- Change subject
- Add compatible string for versal and versal NET
- Update commit message to reflect why power domain is optional.

 .../devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml      | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml b/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
index d1f5eb996dba..01cc90fee81e 100644
--- a/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
@@ -18,7 +18,13 @@ allOf:
 
 properties:
   compatible:
-    const: xlnx,zynqmp-rtc
+    oneOf:
+      - const: xlnx,zynqmp-rtc
+      - items:
+          - enum:
+              - xlnx,versal-rtc
+              - xlnx,versal-net-rtc
+          - const: xlnx,zynqmp-rtc
 
   reg:
     maxItems: 1
@@ -48,6 +54,9 @@ properties:
     default: 0x198233
     deprecated: true
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.36.1


