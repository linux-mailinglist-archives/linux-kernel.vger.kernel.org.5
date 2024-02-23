Return-Path: <linux-kernel+bounces-77904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FE3860BEA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 486E8B2122F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E53156DD;
	Fri, 23 Feb 2024 08:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q9SfEi6M"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93909168C4;
	Fri, 23 Feb 2024 08:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708676018; cv=fail; b=S0h8cijxQPWbDPoNXXpK0F6tqpgKNHrLjNWBgmhr6/n4oSwnyH2A0epN9ARAH3cdBlsHt5OgorK6hVGH//7MogB1xzvaUFg1mwJn6vAMBj0ABZoDvzLwGtjzweag9CgPM1rD9mGf6hE+nv+jnQU3ETXsHagD5J4AUcC5NP/GLBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708676018; c=relaxed/simple;
	bh=au6YPO6XHN57EG+3THegXJlTSj5RjgBCdO+M65plQu8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QW3DE/Ud+Ijg30a6Z1FgVEGkB+VdDvN5Yv6WKh3WBiUHbuYj2qXQlE7m0TXh2rK6M/mTOWa3j5CTImC9PXX2exCy8ecfoXrLLmzsTUqJdx+iajIrWg3UdetifZCmZRvY3KKTvu2lDxpyxsA6wKCXGGEg8UbnJKlv43dz/l4ysWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q9SfEi6M; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UU/o9wpoIsCVD9S3RtugYgz17osb+iorcsZbVHoJxYMJHVbNMUTD+aTBi2tG2WPax7b7Y31J91aDwr306UmZr/MKyQbbte6xT5xbN5MuqWKqj5LllRghsx2dftuvl84IlZw5klJnWfp/Qmrv8020TYSmYIl7FWc+cRaiUdtAzt6RqteSJMCuZcKbtlJtLNUVRaCmW8CBXV5umSRBqXF/EvkYjGoe6Ahpz9qOMxXWW8axcj6/AfRj3OgVHmRXhUcj9b9a9Ubgco0k3arsavCVVQKXbUhgd/R1Mv5d/+QX+Rr3baOcOz+SjAlY/6uuPS07HUZ0//hKkkKhdj7ABDcTHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZO0BhSAnGpUcyCBbnxZlPGcb7QGoRdRwInqizGzyqJE=;
 b=hPyKtHy36KN9A3U0dpgPurV+RcvM+SK54ScgbYTwj0Hg2lx2VTD5jofm805uJAZueUKrB8I3KV7s+MS8XKdZteQP15est8HZ5+Sl99sFlJtsPq3HuicaOK3JVUqarD0HDeAN7wD0vGPwYkuTGhCPKZRXKNBr+qHF3v/4Z6hGuEww6VZ4136yJE03z1Bf72xvMkmY8GrIng7jZTyrbQAB0DQ7gu87ByEfgYPsqX8tdzqjaS8Y6TdliT2w52ogU9nanK2UXd2fo0drjp+xPJGtYM7R0H38viUmlRod/OPlE0y6ePhQmB//QNDZs73s/uqqvcZJN9T/rcwBwBpCtOBIXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZO0BhSAnGpUcyCBbnxZlPGcb7QGoRdRwInqizGzyqJE=;
 b=q9SfEi6MsBjOxYyd/3H8bwm5uoU2v13HIW6sr560tXHxQzLhEihVvCfMZqtAtCnn3PutLbI8GBr8qysOIq7LoL+Kz1ji5ezDXAHZgWWVNZslGNXDaWTP5eu84gwNfMYj1FASo0Jgl7RzWSaiV17EABhq8TL7mfw7ZaxAN3wTiOpi6m0qHZhJKlLPPfO9/e9iPgw013rIGGaXVvyvO3RO88zOHz03ZP+Cdaw6+D/WSqbxuih4gGbHX03ZPuECToIxqkRNWOuu1VH4LlwbDCAkZ3lyIWnrduBMiOemj78g7f1OCFS8Ow0jKVlDvZ2qHFMOj+Ss6C3jSN+06L8giuaKJg==
Received: from BY3PR04CA0021.namprd04.prod.outlook.com (2603:10b6:a03:217::26)
 by LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.26; Fri, 23 Feb
 2024 08:13:34 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:217:cafe::c1) by BY3PR04CA0021.outlook.office365.com
 (2603:10b6:a03:217::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Fri, 23 Feb 2024 08:13:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Fri, 23 Feb 2024 08:13:33 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 23 Feb
 2024 00:13:13 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 23 Feb
 2024 00:13:12 -0800
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 23 Feb 2024 00:13:09 -0800
From: Vidya Sagar <vidyas@nvidia.com>
To: <robh@kernel.org>, <bhelgaas@google.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [DT-SCHEMA PATCH V2] schemas: pci: Extend the meaning of 'linux,pci-probe-only'
Date: Fri, 23 Feb 2024 13:43:07 +0530
Message-ID: <20240223081307.1727191-1-vidyas@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|LV3PR12MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: 801a29d6-9382-46f8-186a-08dc344753f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	354JXQ3KOaUIDoPdErbu9QW4SVmapiMedktdk6yu7bUxgcIOeeRL+pT9W03/AKtwG7XrHO3xajl+1LqudbPY4+sdLxEEh/PwzVaEqgr+MaEMExYf2BQPPc0UwQZ8MOzOfu1IVTYcvi25n/YjB4n4vsuX4Fb9yBlPIJnN2mLrBrXwJyVZuaSXj1fcrz09mOWN10z5YlOfWovAbLLJAtU7Gp5K6nC1PXySpE+uZVyULvQp0zEVPv+IU/dxbjR+OGBwCmvh6opDtzi3Nn48S4JwGPdSj8HFfoX6YOtIZjwDRYLxbMgV/T+pnEISH6LMmTbdgNXjbuOm7dTKrh1aFkmVqz1YrlNO6QzwWR5jH8oWaVZQo5/TcNbPYYxrpWsgLaDFvTNHMGWu83bDyakyni/wTA65AXB22yWLYQyPwwPQAbWwbSkbI6lyL5g0uuvNJ1hWeWy4eeY3XGNnd7wlPHULbdIBP2hEZHXGG5Jv1oIpFs/mJzpgtnk99+vF1wpdeVsmWQcMERF3UyD6IDK0p+IqsFp9348UTKQofh1K5NMnC8zgyv3mSy2xDNX7K6E+amHzQSIglAfZumzOpwMFXd69cgryph5Wl0vP1BU3WVdJP1mGvfkP6gmzp2p7bpZZeTeaWzSqig/KcyuWPqRPPXoMcYlgg1nTpj4x4TM9vIPSLUQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 08:13:33.3111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 801a29d6-9382-46f8-186a-08dc344753f9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9166

Extend the meaning of 'linux,pci-probe-only' to cover the cases where
it is applicable only to a specific PCI host bridge if defined in a
PCI node instead of chosen node. Add the documentation for the same
in schemas/pci/pci-host-bridge.yaml

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* Addressed Bjorn's review comments

 dtschema/schemas/chosen.yaml              | 7 +++++--
 dtschema/schemas/pci/pci-host-bridge.yaml | 8 ++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

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
index fbbb829..e977520 100644
--- a/dtschema/schemas/pci/pci-host-bridge.yaml
+++ b/dtschema/schemas/pci/pci-host-bridge.yaml
@@ -31,6 +31,14 @@ properties:
       number for each host bridge in the system must be unique.
     $ref: /schemas/types.yaml#/definitions/uint32
 
+  linux,pci-probe-only:
+    description: If present, Linux will not try to reassign BARs and bridge windows,
+      instead use them as they are configured already by the platform firmware for
+      this particular host bridge.
+      NOTE:- If defined in chosen node, this property has system wide applicability.
+             Please refer to /schemas/chosen.yaml for more info.
+    type: boolean
+
   msi-map:
     $ref: /schemas/types.yaml#/definitions/uint32-matrix
     items:
-- 
2.25.1


