Return-Path: <linux-kernel+bounces-128042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EAC895554
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADAD31F22728
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E01A83CD5;
	Tue,  2 Apr 2024 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WqMow/Sz"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB0383CD8;
	Tue,  2 Apr 2024 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064430; cv=fail; b=WNOqIQJhGACTj3ZC464gpmNb7vPm1+rpW4NKTedduslLwjiFVqHBVUKw8HmZHflshKe4N0Q517GUL4U0BqMl0LxDndSnGLt5Pv2Oe4DGuYZOBF03etQUnQ4QaeaQDFUDtqPYEY1mrnhl1WPR21oOpqBFlwxQwb8Bo8g0HiGO0lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064430; c=relaxed/simple;
	bh=QMQKzCFehsOD10XQhGcRq1hK6JWT9UpiFfXZT3RnkfI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=expIkpw6z9glAm+D9k8uqs1K1IuVXvliYbTvnF0D8T8UKoOpNT/wFM7ZvIfQfPLYUHklFb8O4MZyPb3MmXwJT5tAbYavNMIwraAk0iAhhRyRAIlgSWxoFo9ngHG53Ak8Lv5w4B29LM72sKTK7hDXmI3Jm6SD9HIeuJ9lpID9Q3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WqMow/Sz; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xc9uXHIqwJmotLR18EDPW3EXGJ+R0qXAYiArxYkwILTaoxv6z/iREG41qR7EFx9kDidkDtNGRtisJWqfcElSiFBhkOqrTC3fUeW5sjvLxrh/pVudrDjJk07FwGdjAsvwiDhQck57M5CHLoOcUEmc6cg9+NRbM1QA09wnbujD6Pxj7MPJS11Tq4ta3bWXCgj7nPk3VoHoFn1wxy8kGZEfyfkAqntdC6PWfRelDxyRExabLtvBaHUwjxJujU7ywKSLDi37BhIvJwUUHRhgvTwpVmL7e3BYVENzc3T44Iaz64DRL+FsZxAOCBG6lVuBkvYJPHF3qtzJbRu55bdONp5uzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cvLAK+SPaT42bpp/b+Z2zaLbqrg+dx1sJTHY8vNnWY=;
 b=DQu9UOoPB9CTsa0wVcq+LAolmGX+NwO2vq+qLeCxw1FBjbNheSKCT9HsX3xoq/KKdTf1jOV6TxWylskwwholUUuGFuK19Ng98LU2Z1wsEMKELMPCKkmnI/+iPEuHWovYX+qjLOSRFlChP2x5Rbe9d7b16/xi6Bm1pCIvDqasOOXlUg29aSGKA4p7AEwQkHQSB+V05d2KXsQnmd6TNwG/q8wNaS/Fb53+oUJ+tZUKyzZndIB0zhCYjuuug5kwaZGyiJXShlN8dd5ZEPfXkNLMiM3ZRPP6RvP6IjPTHUKgKfBNXCAN2B8sY5diBjS9Rw5kitd+KVIFm6RxmNC4pOg3qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cvLAK+SPaT42bpp/b+Z2zaLbqrg+dx1sJTHY8vNnWY=;
 b=WqMow/Sz+o+zY3N5bqvB3iCxXMzpiDP8asocKIun3Sc8KvhARBnIWAJ5WTqNsiHmgxI7LnrCMAyq2QIfAlLeqgyiMFXfHW/YUUZR6fap8zIuT5CA9UrdF96zKfFWFND2XZOWN4iYvxv23suLpS+xthNioGIt5Kt8XnxREdY2poQaC9T6kXyhZf9XwtRm+dkyWKQOpZjWN/C8W2NnDimeOSSSP2rn1KEY9cAKunjfLeMUxay38fbwNbryFYzJ0MWS00yDojM/erLbNfGF0kxBHJmYfyqZ/RHm3uXI5y/yOwfiNN1GWiAY8OuaZTJGQU3tp3/vqwf9y94RqE9Jr900mA==
Received: from MN2PR15CA0045.namprd15.prod.outlook.com (2603:10b6:208:237::14)
 by IA1PR12MB6209.namprd12.prod.outlook.com (2603:10b6:208:3e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:27:05 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::7f) by MN2PR15CA0045.outlook.office365.com
 (2603:10b6:208:237::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 13:27:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 13:27:05 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 06:26:41 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 2 Apr 2024 06:26:41 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 2 Apr 2024 06:26:38 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <krzysztof.kozlowski@linaro.org>, <robh@kernel.org>,
	<conor+dt@kernel.org>, <maz@kernel.org>, <mark.rutland@arm.com>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <amhetre@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [Patch v2 1/2] dt-bindings: make sid and broadcast reg optional
Date: Tue, 2 Apr 2024 18:56:25 +0530
Message-ID: <20240402132626.24693-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240402132626.24693-1-sumitg@nvidia.com>
References: <20240402132626.24693-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|IA1PR12MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: ca37981e-9fcc-4db2-d245-08dc531896e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/3V8fpASSrY5QI4nk8pd8n+IRFZV9WtNzd+6s/nbpLEUpPeOk6LVtY8euVSDukzIOTE70eQIw5d21t9vPVV/V8CZLM1CsXlgJMXjnQPoXdnFUlZdcAxk7kM9sARvhx1jkFAS3wj/x61guzZVbZooUGe92ba7fXOXpf7RYqYw/Jkm1gpvHtr96l+DkfHn6AruQQbMfU6CguvA5yepwHoZKFmIcDVjLmGtyapMJnJ53OYXZ/aqbnSF/vWSDRiJioyYwB0PO3kDJgWMuXmmmSTp8zdG8m0+oxiveBLxRjpozs6A+AillUz0L5rNVFLYP1XSNOtoG58hK1NXfzGc+ix89IRzltst/ZNftAmOWqhko1v+aSf3Bbn7BtDdV3NUooipYOKwinzD33y4vvj0WN2Qi3GuakXiLDGzoU63mchXS9kZPg2c2g0pNEe5IYKtvjHnWYtcgVbXhXz/81TomzaGIHCQIE3asMtp4ls8inIKQ4t+OLpNPRsoO+c1GWja5wfvVJWr++BIYFuS5vq0UQZ4ZEUWmRLR5ZXEMhvFSgr1fK/OWthXgL4bY5kQPF3SmuBpxKoDvuFNYbCQMY4eky62rUZedFu7jRYkM8y+4JtfOeUlR19R5xMIMAnD+yCh9hfE8PlUx5QG9Icc/HX3t+C4UlIRNnfbQzm3REFsaWi12OmnSloalTw8Ds1KzOMMMb95t2nkIKCdib9KUHjMaWjelzrGm6b8vdBh5UO0rwM000JszZVdAxDnQdPEkgJn4sH2
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:27:05.3438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca37981e-9fcc-4db2-d245-08dc531896e1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6209

MC SID and Broadbast channel register access is restricted for Guest VM.
Make both the regions as optional for SoC's from Tegra186 onwards.
Tegra MC driver will skip access to the restricted registers from Guest
if the respective regions are not present in the memory-controller node
of Guest DT.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 .../memory-controllers/nvidia,tegra186-mc.yaml | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
index 935d63d181d9..c52c259f7ec5 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
@@ -146,17 +146,17 @@ allOf:
     then:
       properties:
         reg:
-          maxItems: 6
+          maxItems: 4
           description: 5 memory controller channels and 1 for stream-id registers
 
         reg-names:
           items:
-            - const: sid
-            - const: broadcast
             - const: ch0
             - const: ch1
             - const: ch2
             - const: ch3
+            - const: sid
+            - const: broadcast
 
   - if:
       properties:
@@ -165,13 +165,11 @@ allOf:
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
             - const: ch0
             - const: ch1
             - const: ch2
@@ -188,6 +186,8 @@ allOf:
             - const: ch13
             - const: ch14
             - const: ch15
+            - const: sid
+            - const: broadcast
 
   - if:
       properties:
@@ -196,13 +196,11 @@ allOf:
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
             - const: ch0
             - const: ch1
             - const: ch2
@@ -219,6 +217,8 @@ allOf:
             - const: ch13
             - const: ch14
             - const: ch15
+            - const: sid
+            - const: broadcast
 
 additionalProperties: false
 
-- 
2.17.1


