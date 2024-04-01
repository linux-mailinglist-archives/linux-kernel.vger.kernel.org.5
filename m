Return-Path: <linux-kernel+bounces-126501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB1F8938B4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 525BB1C20E60
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 07:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CDFBA41;
	Mon,  1 Apr 2024 07:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hSRXXqxX"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC9F15A4;
	Mon,  1 Apr 2024 07:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711957803; cv=fail; b=lf8wA3l5faOypsGPiEoGvyVXAnLh5Qz6FmOoz0CVE/+mjjufJ1aw10PINvVx9vBjpm+ar4VkZF6NFzGKACnmIRdXW4gesMxoWURtS4U3JVhPU+HhYrZooj6rBNrIk7zze3wMQM0wIE0BHhSJzHCC8KwRZ9sTJQc/1zxyoAGAeN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711957803; c=relaxed/simple;
	bh=MYHm1/Gx7zlAKULH8iZErbJIFQQEM0VLEwc6U3o3Etc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C0gBKpwFWiteJVvvLncp2fvJvDo0mOB1a75J36G0mQ3YAKPuyOATKH/23zC13qGwqKzOLcgUtFFyRgaO8Ncj4UfAWlDATtP+dR2vagI3mw37lWaPcDuUaxrN277TwQbBM32rk8QET4cjipNS2qnPCeAADMEqOZIrYIvn3IHljoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hSRXXqxX; arc=fail smtp.client-ip=40.107.95.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFyKhg+namGjngpQna6eccWB4JH7olQjNFI7seRm7fEMcLRUth/eC+ZtArKLinHezlGBO2r6dwq7Tg+5cj5GkPITNf9XIBlNbPzmnk00bY+2UClriNOzuzkTw6Un9/YfvYTxsXd/Nls76ZagBXOUSDztb4heHCFAqN55e4JuB4H1j131EQ77lrDdqxwhcjwOpvDrEr9sTrUzThBjKynBKkGW1IXCuqkqZ+bx6QeVrz8XQ2N9mBrx4Gs7CBdR3tLaXXdZx/+mogt4TUp6P7AcXq4w0gks9SOgMANRps6v+t2S8ZqmQGvg3ATlBlWA2hmpsJPx4/SrAIw0DEYu/w7Fig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKtSE/GKvERz+toGLJd2SiEd/17Zc2VWVmzGA9r+cgI=;
 b=fnqsu1CPY7/Aj0DC+Smj1YthYZhDinQAxLkkGGyjIMUpynxlKU2chcnXFMYiNc+bFYan5YrOWt32ljT/P1MpEiJcDuSotYP0uXYdqOoDOGaUa9bgQEfm1XMf8+0nUOUGBRXrROzmRgCWLIYFXXz/T93GqPnAT3ARJQANSzdjalp014oj0VQpdh0nQERFNA2lL+JAFpG2r/LOOncD1hOp8/j0NDUMvVyjLqnByqQDtAPfAQ79K3MrA2wRll9xHBsovXqnX/cSJ20FRXrbMzpDJ2IcYC0ho9Or2HQts6r4HQwrWR9TBh3XuBqAc6/NRcoGTfNtLyWVe/eYpHYzSRD2NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKtSE/GKvERz+toGLJd2SiEd/17Zc2VWVmzGA9r+cgI=;
 b=hSRXXqxXFe2FPwSj2yKDNJCO6DCpYdGy9y/GQLBK59lg1vm8ZoPKR0sWk7XDAPY/fOrEhy/XKrlWp2PJyF95gvkPchHw0gdH1y374q/Isf1Oz198B1++4Yr3ja/8fWIgPJcrIWe4Bbfo03Y2eQhDaVZpLuOtoNRKjLJnYqRifz7l519eUEJIMkDDSUQ2HdLMEjzMUeprJ7IX4k+p1kUqqbHd7v7FPFsLumI135SCgfoWr1qdQZ5+MJ55XjGTQIgCEfOikYHdZRYiE4/2pckJLu/AS6Acv0VmdsT0RJ2hLfGLaaFB+4j7riNXRPZAG6zyG6ZVj67aF5Vxbr4zpj7KxA==
Received: from SA9P223CA0027.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::32)
 by SA3PR12MB9225.namprd12.prod.outlook.com (2603:10b6:806:39e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 07:49:59 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:806:26:cafe::3b) by SA9P223CA0027.outlook.office365.com
 (2603:10b6:806:26::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Mon, 1 Apr 2024 07:49:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 1 Apr 2024 07:49:59 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 1 Apr 2024
 00:49:44 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 1 Apr
 2024 00:49:43 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 1 Apr 2024 00:49:40 -0700
From: Vidya Sagar <vidyas@nvidia.com>
To: <robh@kernel.org>, <bhelgaas@google.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V3] schemas: pci: Extend the meaning of 'linux,pci-probe-only'
Date: Mon, 1 Apr 2024 13:19:37 +0530
Message-ID: <20240401074937.3334632-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|SA3PR12MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: b3dbc6cb-9c9a-4fca-9fee-08dc522054a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dmctpe+XeY2d13/R/NPhTZuJ6uZPJJwWn/vAdMpCGlcfq8/614+NLKGj1jFaCWjedXt3rwhQrKw0Co1ACCMKOKG/azN/po/CigzszYTumhSaxLBec1bNePqwc5dU256vW7zqSzsr2EOoUHmtaAsddSLmhH6sGTPTe5Z+NMIgz5PrKYS+Y4leygEMoMU8OohCuIChfPsYFmDamD8O41SyHrel9yisJq+I/onc5A6Zih9lTIzilShLsj+P1f7t2r2f15Oxtz836TmmilWvqWdbRd9z8TRkPlWLgN1WOS+s6bCWqgNWP8aGsnwdrLmp2F1D7jcFmmd1W/cK4bnM0a6sXIANlxDbzmwzl+OGKfVkyaH/CP9XYdaEulnauJEmmDL8R7xiOpw1XNHHkNl6pTjEmngUFQ5B8nqZjyRZhggVe799dqWBl/Ha8N5m/QSjDlO4Sa8K5vvaGYIXV8N7GW6pKvPMOGEV2SRnTyBaUyd4zPf4+a0vPlJLNT9gqfsqy2SWBZpSoqOcjPn3VQxz+bSwWVGm/jzRvq63Bj+ZDymk0rVEfxEarzdHcZbLqORio8a4kL8OxoLps/9YwsZY5IVpXg6W2DZKUS0ySbQguGBsm9SgzbbWP+B/tC5dik8YhuITOqeVwaKsFi7HScCJokcYvAhuKsahr6tNmJTBcUEpwHnH+ErPZU8nSvVjhzPY+F1Tm6s0QfL47liqXz3dYPARHRg3B4YE8tAXktYn4VoPkEH5ek9DJRkKkVK7JBh3nFJq
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 07:49:59.0776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3dbc6cb-9c9a-4fca-9fee-08dc522054a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9225

Extend the meaning of 'linux,pci-probe-only' to cover the cases where
it is applicable only to a specific PCI host bridge if defined in a
PCI node instead of chosen node. Add the documentation for the same
in schemas/pci/pci-host-bridge.yaml

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* Addressed Rob's review comments

V2:
* Addressed Bjorn's review comments
 dtschema/schemas/chosen.yaml              |  7 +++++--
 dtschema/schemas/pci/pci-host-bridge.yaml | 11 +++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/dtschema/schemas/chosen.yaml b/dtschema/schemas/chosen.yaml
index 6d5c3f1..f806646 100644
--- a/dtschema/schemas/chosen.yaml
+++ b/dtschema/schemas/chosen.yaml
@@ -142,8 +142,11 @@ properties:
     enum: [ 0, 1 ]
     description:
       Optional property which takes a single-cell argument. If '0', then Linux
-      will assign devices in its usual manner, otherwise it will not try to
-      assign devices and instead use them as they are configured already.
+      will reassign BARs and bridge windows in its usual manner, otherwise it will
+      not try to reassign BARs and bridge windows, instead use them as they are
+      configured already by the platform firmware.
+      NOTE:- To restrict the applicability of this property to a specific PCI
+             host bridge, please refer to /schemas/pci/pci-host-bridge.yaml
 
   stdout-path:
     $ref: types.yaml#/definitions/string
diff --git a/dtschema/schemas/pci/pci-host-bridge.yaml b/dtschema/schemas/pci/pci-host-bridge.yaml
index fbbb829..e6665e7 100644
--- a/dtschema/schemas/pci/pci-host-bridge.yaml
+++ b/dtschema/schemas/pci/pci-host-bridge.yaml
@@ -31,6 +31,17 @@ properties:
       number for each host bridge in the system must be unique.
     $ref: /schemas/types.yaml#/definitions/uint32
 
+  linux,pci-probe-only:
+    $ref: types.yaml#/definitions/uint32
+    enum: [ 0, 1 ]
+    description:
+      Optional property which takes a single-cell argument. If '0', then Linux
+      will reassign BARs and bridge windows in its usual manner, otherwise it will
+      not try to reassign BARs and bridge windows, instead use them as they are
+      configured already by the platform firmware.
+      NOTE:- If defined in chosen node, this property has system wide applicability.
+             Please refer to /schemas/chosen.yaml for more info.
+
   msi-map:
     $ref: /schemas/types.yaml#/definitions/uint32-matrix
     items:
-- 
2.25.1


