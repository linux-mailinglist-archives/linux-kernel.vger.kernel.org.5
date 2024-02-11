Return-Path: <linux-kernel+bounces-60878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE028850A81
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 18:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E083F1C21AC9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 17:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02485CDF2;
	Sun, 11 Feb 2024 17:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="byyTNWLT"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B8C5CDC5;
	Sun, 11 Feb 2024 17:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707671895; cv=fail; b=gbcU7okV1kBLnKcXEsgnFkv0n6WYu1LmCeZJQigdZxKP8zJJTk1DeNYQfAkDEG+53zMS8w1zlW4uAUEx8IUAhE9tQE92FK72IkL782EYqJyWEn+d/8El3tsHncRPFCgKqcq744VpBykT7IhBLlBhQi3kxc6M05MucG9Frs60Ko8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707671895; c=relaxed/simple;
	bh=e7CpKIh4/20cmmqME0DTDHDJsRkqkutj25vzZ8BYcCQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PNziYikxtJajS0iR3p1WG2FtRnEY6yKv15AuxzL3soSx6yfsKeX9ZYnYawlAQl1UqoM3PMAdLXvm60pAei3jqy9TNtOIVlYPfaqYb908zwxpVIq8aahn/U4/fUM3nqx1iroIkvsXlARU9pVU2a8QjY83/bpYiXbQ6UEbYo9lixM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=byyTNWLT; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLyjSx7FUEkLIcUuVBQGltcoeK7BtIinPnMpElfAhXPqyl13oXe2uFmMD3LuQhwqsNl8E+fOJcmMydGDJXDoQZEOooqksfoSGU0SWJCPcV9QK1Bmb6fIkc5oNnal0nGmRs+KpVVRIvBzXAPQf/nUuEgGg3DVeMSFbO1FyyD81NRqQozKn1qrfbGIkX+oJASRfmTTeI+pY7h5oKfl10o/jyLYY0bRuWrePazic27oufb9u7ZRKOdApBUSMtHnQrrXl0hr1OaqI7I3omfJ8g189m1XBdEkRmiYPl/1M9TAI4EaM+ZelO+YDqlqcR+2klj+6jHbogfYzNdQQFqyuZvLiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4TsF0HFPxh1xo635dSyHIYGNtze6/P5ziInIApNOGI=;
 b=DApNFYgstSecQ6+9Y9zs/1YDE4gcmYT7tzvJrhRutTmbhn/wCbPHovDa66fvOYkunf2xLgfHxdhrLmXo7J9xybtoY9JHcVgX/4le+50SkRPIexbdBOjS7dLgyxG8l9CVHrQrGrI596jx22Lff5wL/R96nmohPdKrpo2BXud5DCXMxVeJTMH0zWeHO4q6J32lw01YdjqD3bbLaL6ikVcT8SwzC93Xt3EzmPDPB6hqa2MqKSSLV56QrT3zoR0ud0XbhTOfstjglwTHglhl+4LktuHSa9Z9nxM2rDfFAWnQI1qazZgzKydJbO6dDWE2m99qpxmHrsIJHEcIN0pFHpV/Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4TsF0HFPxh1xo635dSyHIYGNtze6/P5ziInIApNOGI=;
 b=byyTNWLTkVp6xioaWxzhJh59h7pWXOWU+hJndy5j7qpq25Cs952x6/aJU5O/dtFwn5uORifzaZ7cB495JCkJRDZb62IaaXbyoKj/wUT7qGrWcCx4s1U151j/8WhYfYSyn6bXMwSPJKeldvANmPUgMVBSX+nW1qyYCn3aTHOYvRUAA4mUqWSB3/qaMIeqZc/TgkCEpri4qaqpj/HihPyfxZBssoQHomXTPKodKauYVgB2tgB/JYyNEgMeetFFGEfZ8x+JebzVcECE9HaxSQmJFLb0TpwNxe45iqub7+5DaUu/+8yo5cY2O/ELvRNOOl2onkqp4voCpO3AIPqjSJjgjQ==
Received: from CH0PR03CA0073.namprd03.prod.outlook.com (2603:10b6:610:cc::18)
 by SJ2PR12MB8160.namprd12.prod.outlook.com (2603:10b6:a03:4af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.11; Sun, 11 Feb
 2024 17:18:09 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::69) by CH0PR03CA0073.outlook.office365.com
 (2603:10b6:610:cc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.32 via Frontend
 Transport; Sun, 11 Feb 2024 17:18:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Sun, 11 Feb 2024 17:18:09 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 11 Feb
 2024 09:18:04 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Sun, 11 Feb 2024 09:18:04 -0800
Received: from build-petlozup-20240117T042503953.internal (10.127.8.12) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.1258.12
 via Frontend Transport; Sun, 11 Feb 2024 09:18:04 -0800
From: Petlozu Pravareshwar <petlozup@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<p.zabel@pengutronix.de>, <dmitry.osipenko@collabora.com>,
	<ulf.hansson@linaro.org>, <kkartik@nvidia.com>, <cai.huoqing@linux.dev>,
	<spatra@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <petlozup@nvidia.com>
Subject: [PATCH V3 2/3] dt-bindings: tegra: pmc: Update scratch as an optional aperture
Date: Sun, 11 Feb 2024 17:17:26 +0000
Message-ID: <20240211171727.914595-2-petlozup@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240211171727.914595-1-petlozup@nvidia.com>
References: <20240211171727.914595-1-petlozup@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|SJ2PR12MB8160:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ff5e484-0041-4cd3-f0c0-08dc2b256b55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZC3uJxlcqNA2n+8ARqiGVYZI2kfS6K6l1lqPtKa46yYH89KpOr1bWO8W6IG11Apg9tU8VnUiTDr0tHAKlinDsuZQrrsJ0pGWJHCXlkLZHgLgdnr5tH1lyg7W2m5GdOMossGIaDcbXLTPHR8hg1zy1cZFz9fDHFWGDHrvuAgFsdstMhveiI6Ncydks5eSelLR3poABgL9w30ICDM3rgvKz4XPS1uL1HQ5efCqP4bY+ILCTYn3z7KOwtHWXmb+StMJHsxnccnRgOrEKkNsSvqDrGDB4nWQJtPIudfgz0wqb4gm7QtFvaC+02XA73f+kVX/ZgW2vreF/a7iFLPjckNNLTF7DK+5VUjNOYDwvK3da97hyFvtZmffTi1j0DXQ15enppkosYA/Efvfdj05ffoZiRxKCZChvVZq3yZYrrbAQSpiEPns4TrGiVgl/elVZ2jYGCmysl5Pdcdqa5JY5ou3S7f/XXUwIIxoQz62Lcc7ZICWP4AjsQKAnP4kSxWm43m8GLgkvEjST7nOWkH9qr46ES2ogxnSh1VRYsVj2x29GM09ujfp5zFkHuyJn4LiXMn/USZDqLxc8urHscVNXsJO0yywNj0G1RCcAkwNSu+U3PkXLbWe39qzuInpd2RY8a/QlbifUImAYXSoQcp+gO9D9Q==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(82310400011)(186009)(40470700004)(36840700001)(46966006)(86362001)(36756003)(478600001)(6666004)(41300700001)(356005)(7636003)(82740400003)(2906002)(4326008)(7416002)(5660300002)(8676002)(8936002)(110136005)(70206006)(83380400001)(316002)(70586007)(26005)(921011)(107886003)(336012)(2616005)(426003)(15650500001)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2024 17:18:09.2783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff5e484-0041-4cd3-f0c0-08dc2b256b55
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8160

Scratch address space register is used to store reboot reason. For
some Tegra234 systems, the scratch space is not available to store
the reboot reason. This is because scratch region on these systems
is not accessible by the kernel as restricted by the Hypervisor.
Such systems would delist scratch aperture from PMC DT node.

Accordingly, this change makes "scratch" as an optional aperture for
Tegra234 in PMC dt-binding document.

Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
---
Changes in v3:
- Update 'reg-names' property items as per the review comments.

 .../arm/tegra/nvidia,tegra186-pmc.yaml        | 58 ++++++++++++-------
 1 file changed, 38 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.yaml
index 0faa403f68c8..ea4fbf655220 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.yaml
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.yaml
@@ -27,7 +27,7 @@ properties:
       - const: pmc
       - const: wake
       - const: aotag
-      - const: scratch
+      - enum: [ scratch, misc ]
       - const: misc
 
   interrupt-controller: true
@@ -41,25 +41,43 @@ properties:
     description: If present, inverts the PMU interrupt signal.
     $ref: /schemas/types.yaml#/definitions/flag
 
-if:
-  properties:
-    compatible:
-      contains:
-        const: nvidia,tegra186-pmc
-then:
-  properties:
-    reg:
-      maxItems: 4
-
-    reg-names:
-      maxItems: 4
-else:
-  properties:
-    reg:
-      minItems: 5
-
-    reg-names:
-      minItems: 5
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nvidia,tegra186-pmc
+    then:
+      properties:
+        reg:
+          maxItems: 4
+        reg-names:
+          maxItems: 4
+          contains:
+            const: scratch
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nvidia,tegra194-pmc
+    then:
+      properties:
+        reg:
+          minItems: 5
+        reg-names:
+          minItems: 5
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nvidia,tegra234-pmc
+    then:
+      properties:
+        reg-names:
+          contains:
+            const: misc
 
 patternProperties:
   "^[a-z0-9]+-[a-z0-9]+$":
-- 
2.34.1


