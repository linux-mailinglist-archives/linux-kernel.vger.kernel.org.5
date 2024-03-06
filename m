Return-Path: <linux-kernel+bounces-93902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DD3873695
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 681D81C22D78
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9F486653;
	Wed,  6 Mar 2024 12:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="od99JTtw"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2536E78668;
	Wed,  6 Mar 2024 12:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709728604; cv=fail; b=tM8SZHvJnQvdMhm8FBXtbJOzh5YmpykJJKxKedKIeZ+dK0TcuSv8h7bICfVYhDsIeTIRiKvfc5ljK0AP5U9BrAu1mcTzApQKMXPASCCHphe+6v0/NttZjQN2OeugM0BCXY281oNocU4ZqfYgQEHCd22fNesNHXV7q3UPEhRY3JQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709728604; c=relaxed/simple;
	bh=9rDt8nQ3W5Y4xImUWElwF5DeypMJhLPCykZ/I9I6QH4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DA9rWKZoKMYIkrXzX3xKc+pppbisVHXS3B/5wwBI6eKxTSaX+e8VdpCmZUl2lVNCd7PDaXJvGN7b/YD043ESIUKh1mopAcBv6golZKw1pylvTWjPk+7vM+IXQvHGWf2w0exm+h4d18+Gth7HCfj6HN8LVlBrtqVjVE6qGRHglOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=od99JTtw; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+CwHODgdMn6/JPg6jwt3yz/hD8OReikFjvuGhhVymA4o/FXVWnZFOT8sJql4aulY3OWW5FoyJnXKi1ctFpuEgrdd4BWaKKXVjE0our65zLCQN85XIUxIjrhhXewLnDkBDv2jXTYTbc1AUB6yAQH+Dxj2ZdL6SmSd+39TpTL43NAGwZBeQnP8R+bT1SBfEEj2iROYu/035MLOwjJNtS4tOx+HZlO35FgeYIsG+IuwcFgQPriKGZtNyxWYjdB8nie5+RszPgVWNLmVzTf93/rffss6JSu6PXlBhSBXX9aEpzhEHGVVB+A4m+OyKUy10PvU/4xlksPYynjeYuFy/l5WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVX9fdPoysdSt81EOf5/+5ZZYambiGlESAAXPgHCuzk=;
 b=Qqi0cOvLcKJ7/3svINZQXvzS/OkoTJFUQudhiWT9yONWqX39hO7gO9gz0Fg3omx1OK1I1bxYu/e1bZCdFd3OuMxMfG+tCsU4Yn/BUkNMr9CrxvA2nvmx6/pcd0A+14dxKQMa6B8fx9RzLBRwxMvtXf+jTm8RWxrPdLDeLhccLv0k4LQImhmtdCJVt6fSdNsJysS1wAfzx1Fyta2SbtSye67CRQxYgPCcEPFM3pkDPrfJOCKI6sfJl3zybWnIcJ5YJXu+YWqh0spNAfggEFLUF6x0etfqj1AhuGeLZDUTn+KKwgBRYW5IkDjhLqQ0gfIpuOoYyXsJcy/oQTxgnd/JDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVX9fdPoysdSt81EOf5/+5ZZYambiGlESAAXPgHCuzk=;
 b=od99JTtwYUa51t3+K3gXka9D1NN6U5OO+lthQAbhreOnm6SeRknmIxdV38lL3oKpFzBGZSVAs1l3nZvC7AoFYddzZ0FS292++TJ+r+9YOqDUKxk/2WR08ApWBiZgM2vy+QvWUI17NFWfUmfVj5ZZXDKGhFA3hfI9YHvEowzW++M=
Received: from BN0PR04CA0006.namprd04.prod.outlook.com (2603:10b6:408:ee::11)
 by DM3PR12MB9349.namprd12.prod.outlook.com (2603:10b6:0:49::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 12:36:38 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:ee:cafe::d1) by BN0PR04CA0006.outlook.office365.com
 (2603:10b6:408:ee::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Wed, 6 Mar 2024 12:36:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 12:36:38 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 06:36:36 -0600
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
Subject: [PATCH v2] dt-bindings: rtc: zynqmp: Add support for Versal/Versal NET SoCs
Date: Wed, 6 Mar 2024 13:36:34 +0100
Message-ID: <70b646d60f53cccc734afbc7f22245d53394075e.1709728587.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1391; i=michal.simek@amd.com; h=from:subject:message-id; bh=9rDt8nQ3W5Y4xImUWElwF5DeypMJhLPCykZ/I9I6QH4=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQXyT75q2Svi+xxVr/6vZxvQfSE3HUCDzx32wc6995lS wyZ7erQEcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACay9xHDgokvm6fZl/fpbp+e P6/84fE5VysnujLMsylV1Lwtxtx5d5akn9X33U9CZn21BAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|DM3PR12MB9349:EE_
X-MS-Office365-Filtering-Correlation-Id: 54edb976-9a99-4e94-6a04-08dc3dda1165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gXLftvnIPGp9VbrpqaYNCs1gdBmK61suBxk8qzruXkXrAl2rRkcCdVJvFZZMcDQ+WCMrbKxNL4SmH/rE0xToaFbZe9bU4cRr57H3EFUwnUQWAUMcwhCo6DegcgYzo4ItNybsSzWdv1t4oo9Prbs19Sa6i4RTOGPfZ8zKOf1JMyKkuaa/vbJNuUjfwFSvrawq3TxnvPdNVXh4sHzruSBSmJSYiK85ovqIzM4zr8dWTEWhrt9no4zzxJLNQVrHY+N4k96S1aABxJuS07SDStQ004MCJt16wW/qnXsyKpj0hlZmKkbyDbVj9vMlsmeXRTbvO0CcfDTMoLvC0eLzkbgPhqmGTTDCnCdi62Rw6LEtQfBLaOXkBo5ipUrrh7EJ9yrv1EqKoBZv2+wq+vK5eJEx+tcC52cIFmyzrzt4xR9mXDaw5mTPdqb+PYnXWPeZT55DwW+5/bkv6XKxrY6vIjo3EumXpUVFAv5IpMlV9f6DXZc4J1wQ0/P+qgqnfmMd9u0BnxPX1E4n3deXitdo7DZ26YqFdbeE6+EpI5yxvQRE/rUJTEi/LjDDrbYadiSXuxGu1LY07XBQMWMXOfs5w64zjxkCR6cIVoC6GXDxZloB6lCNbjusaGKORJ0gdVnff60ctjPzCSpfoDPV9NEeF7Y6X1LCD4SZNne7qwBOVva7H3KeTEb2zsdBk+iBrT736rTpUiI+nzsAtoYkdR47KhIP0GaTqWAkeWx84dQ0CMvyudW3GGMS9eMrDk5/UwGE6Gqa
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 12:36:38.3322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54edb976-9a99-4e94-6a04-08dc3dda1165
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9349

Add support for Versal and Versal NET SoCs. Both of them should use the
same IP core but differences can be in integration part that's why create
separate compatible strings.

Also describe optional power-domains property. It is optional because power
domain doesn't need to be onwed by non secure firmware hence no access to
control it via any driver.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Change subject
- Add compatible string for versal and versal NET
- Update commit message to reflect why power domain is optional.

 .../devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml          | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml b/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
index d1f5eb996dba..5652df8ec121 100644
--- a/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
@@ -18,7 +18,10 @@ allOf:
 
 properties:
   compatible:
-    const: xlnx,zynqmp-rtc
+    enum:
+      - xlnx,versal-rtc
+      - xlnx,versal-net-rtc
+      - xlnx,zynqmp-rtc
 
   reg:
     maxItems: 1
@@ -48,6 +51,9 @@ properties:
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


