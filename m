Return-Path: <linux-kernel+bounces-142685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 185278A2ED2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A09C1C22A70
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2045B694;
	Fri, 12 Apr 2024 13:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y5F4UeUU"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95CE5DF0D;
	Fri, 12 Apr 2024 13:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927180; cv=fail; b=cNVZmMogX20NYWcMwOmnt0n9J6NtN035MzzY0blmu3q+8/93aMrGqP+EyZqzMyySui+/WNHuqZtM4EIW/eqRHwQXd1ZiSpXa0CpQzZfgkwYgjaXRw2QEHRdbtWW4zWKJ4QeK5unS+HubnCX/PPOmHJqzfTE5e+hkeZUNauY2yas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927180; c=relaxed/simple;
	bh=NtcTaZY2SS78pLlpMtes0KcjPQuXfcbr8TSu8vl/K0k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HpFvmWF5x0QrrZ8fRpYc3aw54Faz6xusgn0PivuN2FQQruwHW+AwaM/Z/cJMTrYnhya3m488ZN3MbMePq9F3xRbEutLVjNbO72ptdGYsf0r+S/CVbueUfBmhBSIXj+YIO1BohZwcwHA+LGELIR6NvIITMetdaruNzXf0K+AgeDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y5F4UeUU; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWmbm1+iPRfmd/DL4m/WU88pM3sivtqPQ9nHswCVFPnmgBcc6lWEpc9OO88Q8sNlMDmyQn7O8sEmSbSTCaR67vN7BcgG0c8XvWIG+nAqU/aSMyYKcAOWmwvw/YLd62qBirWxF8QlFROlfOhwxgWmGL+2hdmt9C5VzGqYWi8uDw6isJZtTvTQeCyrEfX9L2lNPLkYzoLlHj9jNqhU+1VUHT+7Uh+I+O2EXW9wjd+J9N4AvuYLTzi23JAtPiNLGdb97ivCZKiSh8tUGMLMDvhOwknmBh2pcJcbzLjWf6y62IIRDO3wFIcI3poJYBWnNOo3uVQGfWtusKAptljJ9WzqPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbD8le75MQO1PfYvqQvWlifM04M/XE17vpVJcS96Q+M=;
 b=E2USfaZmkbWBnpzQlGTxPN0W43msM38O+MG+/TujtGH/zrIFh1Mp07JYLtPLAR9pSAn4MBn4C4DjhUcJwNOX75ueskE5Xurzkr4Fz5TM53mjgwkqKXzLZIL+4ytzXoctfXgs2wQ6+8xMsfgiDKvO78mwqJl0g+RpssycGrEe0g8rrltXFvW2tdVrVv2V9YhQ35MaJ3Ww9MU/6ySeOsC69bKjhhBGWIffqxkEuN0CwCWcOZH7FnmZpyFI7AaugwT22XrGNGKi0myyafRqEaEPagSnCii0aWvlJ2RscWh4ippSdteQiZBYnx3SoaWJm1liSFu8ycpkMWG1Mk/6pEG87Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbD8le75MQO1PfYvqQvWlifM04M/XE17vpVJcS96Q+M=;
 b=Y5F4UeUUqJB9pCpkkgxOP/1EWnAzcYV5Ij6PlpMhyyjTzHQGkbXVjOSsaNF6/qaoPTkQz5sn+Zc2Z1m5ZFXMoCrUqh8Ef3QBRUNG7m4159gfpCLCp3bj6rOS8I/5s11Rjd9UArKQRDogD0OoIB4V7rIv4xytZ5BCfXD2NESStg46AP1gnZHvvfTlNAYZcmMwM9TBD7fPSGSdIovP+f9jWpbQmtNqGsKb/bjPmGPIlZQu4aksCpPkdI3jNNwzAzJ5djIM9ZfdO4xUc3Tjma1ZIk9c5NhG2qucv2fVnbUCjwzjfxDJkdzYvrVJFqLktwrRWrVa+3qo6lDP+cvgB+kt7Q==
Received: from SN6PR01CA0021.prod.exchangelabs.com (2603:10b6:805:b6::34) by
 DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.54; Fri, 12 Apr 2024 13:06:09 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:805:b6:cafe::ce) by SN6PR01CA0021.outlook.office365.com
 (2603:10b6:805:b6::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26 via Frontend
 Transport; Fri, 12 Apr 2024 13:06:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 13:06:09 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 06:05:56 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 12 Apr 2024 06:05:56 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 12 Apr 2024 06:05:53 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <krzysztof.kozlowski@linaro.org>, <robh@kernel.org>,
	<conor+dt@kernel.org>, <maz@kernel.org>, <mark.rutland@arm.com>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <amhetre@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [Patch v3 1/2] dt-bindings: make sid and broadcast reg optional
Date: Fri, 12 Apr 2024 18:35:39 +0530
Message-ID: <20240412130540.28447-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240412130540.28447-1-sumitg@nvidia.com>
References: <20240412130540.28447-1-sumitg@nvidia.com>
X-NVConfidentiality: public
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|DS7PR12MB5933:EE_
X-MS-Office365-Filtering-Correlation-Id: aed766e2-a69f-4ced-bcb3-08dc5af1524b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bYNgGjcQGC9EWYGzwI7O9pERdBo/zoXW+8+VlrE5Q8n5sG/jSEJlCk3PxkOHTaQJ+fjzUqYbsJGxpLnJeuE6haULyfkFc9xteDmnRAPN7xX3iU1McW3P6pznKbqdnFpHQ9DBAQdx+6BmiuIFmbjrw8gpa0+JEhP706aIrpqF4P+OUCVQ4tI97y+B1v8dhjqwR1w0qW56uOASDWzgcFUF1AQpYDgLsuhYVA1O6f/0GsV2Emkflw7NKIr/hqBzVJs+nSv9b6E1k2HGt/z1VmOvBbrYaV2rnGGVKBALqMK9XUaCqGq63BarDDTPqd318aEvz586eq8Ate2GOvLNIKAKSiCLcMshidHk0yvi5a470Sc4heVtmsd57ne1toqBWN/4lb9cIwJkhKseENdDOAP5xCRyU3F3QjYMlsugqn4JgdJgY4Za/WdFGPdewaZ3+ZSkpfIljkyFgEpWOWCMaaZSbxkWM/EEmymbVVMYYs+mDyjH/6dgL6Jqd2K2Asv8SpZyMbyTbiNPFur2Ao5Gq6vIBUieksI/KGHoPyv2h+TKUj5UJfCDH4jHpvt6XoA0ogB3Bds5xCUh9ltprbZneASwZqOlV6hYnJJ9/pwmbqyuCGzC35Du7/7tS84ahQ04rVzeei7FzHqheMfb/iu1wxrJAhJ9yp3Eahjoa75Gri2yxHyJv3f5LYi8qVUDiM/5eG4lhA+uwFxBqWnNqnRKQbEDl/ej+ru1T1igL7Y6O2eG//lDK8AEH1TRjnbfhPr6aspH
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 13:06:09.2831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aed766e2-a69f-4ced-bcb3-08dc5af1524b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5933

MC SID and Broadbast channel register access is restricted for Guest VM.
Make both the regions as optional for SoC's from Tegra186 onwards.
Tegra MC driver will skip access to the restricted registers from Guest
if the respective regions are not present in the memory-controller node
of Guest DT.

Suggested-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 .../nvidia,tegra186-mc.yaml                   | 95 ++++++++++---------
 1 file changed, 49 insertions(+), 46 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
index 935d63d181d9..e0bd013ecca3 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
@@ -34,11 +34,11 @@ properties:
           - nvidia,tegra234-mc
 
   reg:
-    minItems: 6
+    minItems: 4
     maxItems: 18
 
   reg-names:
-    minItems: 6
+    minItems: 4
     maxItems: 18
 
   interrupts:
@@ -151,12 +151,13 @@ allOf:
 
         reg-names:
           items:
-            - const: sid
-            - const: broadcast
-            - const: ch0
-            - const: ch1
-            - const: ch2
-            - const: ch3
+            enum:
+              - sid
+              - broadcast
+              - ch0
+              - ch1
+              - ch2
+              - ch3
 
   - if:
       properties:
@@ -165,29 +166,30 @@ allOf:
     then:
       properties:
         reg:
-          minItems: 18
+          minItems: 16
           description: 17 memory controller channels and 1 for stream-id registers
 
         reg-names:
           items:
-            - const: sid
-            - const: broadcast
-            - const: ch0
-            - const: ch1
-            - const: ch2
-            - const: ch3
-            - const: ch4
-            - const: ch5
-            - const: ch6
-            - const: ch7
-            - const: ch8
-            - const: ch9
-            - const: ch10
-            - const: ch11
-            - const: ch12
-            - const: ch13
-            - const: ch14
-            - const: ch15
+            enum:
+              - sid
+              - broadcast
+              - ch0
+              - ch1
+              - ch2
+              - ch3
+              - ch4
+              - ch5
+              - ch6
+              - ch7
+              - ch8
+              - ch9
+              - ch10
+              - ch11
+              - ch12
+              - ch13
+              - ch14
+              - ch15
 
   - if:
       properties:
@@ -196,29 +198,30 @@ allOf:
     then:
       properties:
         reg:
-          minItems: 18
+          minItems: 16
           description: 17 memory controller channels and 1 for stream-id registers
 
         reg-names:
           items:
-            - const: sid
-            - const: broadcast
-            - const: ch0
-            - const: ch1
-            - const: ch2
-            - const: ch3
-            - const: ch4
-            - const: ch5
-            - const: ch6
-            - const: ch7
-            - const: ch8
-            - const: ch9
-            - const: ch10
-            - const: ch11
-            - const: ch12
-            - const: ch13
-            - const: ch14
-            - const: ch15
+            enum:
+              - sid
+              - broadcast
+              - ch0
+              - ch1
+              - ch2
+              - ch3
+              - ch4
+              - ch5
+              - ch6
+              - ch7
+              - ch8
+              - ch9
+              - ch10
+              - ch11
+              - ch12
+              - ch13
+              - ch14
+              - ch15
 
 additionalProperties: false
 
-- 
2.17.1


