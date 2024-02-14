Return-Path: <linux-kernel+bounces-64671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED65885414B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D3D28AB47
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99FF17591;
	Wed, 14 Feb 2024 01:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mAd4ZGzl"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2065.outbound.protection.outlook.com [40.92.19.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1530F17580;
	Wed, 14 Feb 2024 01:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707874561; cv=fail; b=NKD0WJAfHHdBerGCaquvDQ7m0kOwqftBBMiSSv65n8whol4Wgt3HbXNn1RK0yVd3HoZ8mfqqQGm/MihdHY6uL63KJmNggx13R3JUnRwxkR8AhBu7T6108IA9+WSlycgEiMwa7zcxqSZZQ5OqFBpO6m5MMlwnecrQqCFSJb6KBOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707874561; c=relaxed/simple;
	bh=dJtDe36olAKC9t9BUKZaQ6uWvyydeIdVI/krUGDwAU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M4wqUrLqMEMUUEYHy1mxTWA4vxg87cT7SCXXMReD3kVvCMTn1AcFsuFEAvf5rBElPDpvbr5NdwLV6rC2lOiqLZL4Zyk/VxOFVmsPR+WR43B0vH12hKYoTH+GmcEgFyojQrbw+ILUF1S5LgnvfvG9yZS+RKeHCQGAJMpz8zyuWIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mAd4ZGzl; arc=fail smtp.client-ip=40.92.19.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgSAkMFQm9iI6K4e6+4h50y+UVs2qd4jBq2/4s10+nRWFTt3SwhQMZXgaooNHwF0VAJQu628aQI1s09TmZlMyLDyZtDQ3aLbXilgdlpYL7VmhC//+TdhKVC17bnDwpAFNeYLyGwXiPl2Z8VWyG7Fxgt0WZKqQkE2GhFEUGjrgUMkWFKrRTjoL4wv5+/Eyh6054Zbq2whI4sUGFKRDFqaBRt9EGKFs8tFukDi1c881GNsnRDtyO3DZAvzGhp7/A6Eqg+31+NtpTrVtDMO5oVFktSn2e70/Dw0YbR6nSbzVA7AgwHqAjoZTPWpaY5WtAxC66XOIo8DkxE87VeZd9yV/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJVEhdsUwzp1Zy893CCZx6d3lVeYt4CWdmPe2c3eCUQ=;
 b=T6r1rcuh2jpZp6qNwH+/E5Ir7GnTu/jkojf7WEicdLZVm+HxdBW/kF6A3m17JfkRgHceUSeZX3NwTWhXvPgr6qTGiTcvNThI+b0o4YXAIUkLwGt490NKmA3fWT/TdfOqQJkAWVT3rYUZB2JfU4n9ZpqkrgoaW+6a6pemz3si0z5Wv93q/fieUBp6UaD/jYmncU3z9JmXG9acEkdXAPrSBi2o7OyuElgWv14SSjwEwDmyrQEgAirbFnCAacJmxHJVJqw8hpDP1vL5aWpjpn1yUerSQaxi3TUXyPru5JZI6g8gUhXhx/uNtlt7kQkwc8GmDoAuF2XkrDdyLoKh5wtrJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJVEhdsUwzp1Zy893CCZx6d3lVeYt4CWdmPe2c3eCUQ=;
 b=mAd4ZGzlf9bcWolDJHdYAGJw6LriOfr2Mxtday30CWQPsWrKtlrpal10LoNAPcGT/BhKN+bRwIMaK/zJzLJeMKqD2FMyok8aZc0Yc8DMV+Oqzbvud2LX3VglpKweJQ5MIQ+UjnGL4luTOfiBKoDXb3A/OyXvlrN6eyc71m88coFbqUAl0j88QtsYBbDOb9uU8ZkVGlD9uwK1pmds7OqFX1hI9/4ilbTCE2dzlJ9jfTfZzaBffJ6Fe99esqkjheR5nGjgn/7TFplNFs1I5ckP3aPXG4utlq29jZ7LmkAFGvaKr8bYiW1OqBmdBtef5Fj8R7tDPQsflWwKGREE3Y/rHA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB4663.namprd20.prod.outlook.com (2603:10b6:510:1d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Wed, 14 Feb
 2024 01:35:57 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b%2]) with mapi id 15.20.7270.036; Wed, 14 Feb 2024
 01:35:57 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chao Wei <chao.wei@sophgo.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: clock: sophgo: Add top misc controller of CV18XX/SG200X series SoC
Date: Wed, 14 Feb 2024 09:35:54 +0800
Message-ID:
 <IA1PR20MB4953DA1000B825CA29E3BD11BB4E2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <IA1PR20MB4953D95E8657A480813767FCBB4E2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953D95E8657A480813767FCBB4E2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [D2U0n48OAF+p2Ka9UZtgQQs3/iNVN8gm4E1gdwM0h5GCxqY1pG10Evj9BTc9yCqt]
X-ClientProxiedBy: SG2PR03CA0125.apcprd03.prod.outlook.com
 (2603:1096:4:91::29) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240214013601.135526-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB4663:EE_
X-MS-Office365-Filtering-Correlation-Id: 12abead4-b56c-4067-02c5-08dc2cfd4a7c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IK5X+addsKz/aXRCBia6Ve7mFt0rcIVeowhGTM7frK4cDSBvUjMpRpYeusjsYHRFiGVTwbjRQRDneb+tJ/VF+PNvkRYZkl8+35CWPOqQM4so/KQ3gW5lAg+4Hs0kjiNkdJeT++LCHF+wOuIIjEG9+rVRyKOyYvCWfMU1UXw91DdXOhgZIdAkAZI6Iyx/89VWrBHjqZV3oS94wv7hOkU/g9h+VlCfhXhG/X9aWSdQfBfIYn6OHK+6Kauji//SM9DVUw9VHlBLneA/lLsmAv5Z7jk/5fp+WkcdE167st61iLEfHoORhQIF6YhNYKf6bhKAwOjCVyi6mA19gklvdN5EoKqGxkjJZowFMCnMrWGPuRT+4b1LkvMmayDO4IX59U1u/XPfjy1jXRGJ1zMOK4sHq4IBLF8RBoDQUqyGP50RD4XxjaTjNuYvLs6Khxjw/hV9O3Etlmo4x90+Z6Y5J2Rjgb3+LdNm8lYlw8IuS82CHKs4f67aGgqz0fEU6s9xG2vYlGiPii2a/W59+O7EYjLBJggN8aXsCK34JsC+8ZG9nJLJIGjdhXRyiTZqe6tpLJoUOxeCLv9RRLadW5G0fpl7qlCdSfgdGu2ZMpo9uufAxxSgA0LFPzzHxJHl7uDej+6gkrbTizLapTVBNqu14OU2oJ948MFhuaHIXXhKcBL1ElY=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CWyRNyKImqZJzuBdMY2vh4tW2WwcdxsyDm5gTr4qJtwzUfz4heoXQCCpUgBO?=
 =?us-ascii?Q?tZ8W6a/xH7ICJMdBfI5QgkeINOlW13QVaF7xb/bAbJdKTIfPxDkLFGd2JepA?=
 =?us-ascii?Q?BP7+f1BMXutQJK+PUrjL5fhivq9+UKl7mkYelFwytqxHeh2UFgW2GE1VEy2I?=
 =?us-ascii?Q?mAXf4aJJFwQSMLBB0M8MOP+fFCwQ+ihturNAyHn9rWaqCtP5G9ZTNiiaqtXY?=
 =?us-ascii?Q?+cbD24kYSqfu/6hLkihNugPKylbgBygOXKZdiVTtYE0GO8aOHkjDDAekjBOS?=
 =?us-ascii?Q?Mp5KRSm/c+B6lf7rPFjc4AntYOCFzN3AO0foR/3YKz3CmFQZ1l6OLAucZpHO?=
 =?us-ascii?Q?iM8cNWzTjg51WRmhyt6e0pzisCXJkbhlU6kk4A9jVS2siC+rmJ5nd8bYeCJE?=
 =?us-ascii?Q?KVyKdsitPvlwgCm5I22c6Cb6HNzfBlyimPNGnS5+Qjw8poueal7ObciVOXo/?=
 =?us-ascii?Q?b483XFfnN3mRJ5zB91sBlxQvjPJ+EOGpNQuT/7hWXEL44jpKBH3D3xShhFld?=
 =?us-ascii?Q?RjA/zDtBl5riRKWk52A7JiUb0eYSBOnCuVs30SUlPNDz5FwBD6+qAcDR+DNU?=
 =?us-ascii?Q?ojcsRMm+BBQQOyGbtJolUMa1eMUKMKfnR5HxBuaEAzXn8emeLa1IN0BHYUba?=
 =?us-ascii?Q?y/TyXc4O7O2a0zWT3dlCHD/ZbcwgnanAtuv0k/gvAkWW4cfera4Es5bWpx/p?=
 =?us-ascii?Q?5leNt9cQJzvDJFW6h4Y43U9eh+s2ds7TwMz6i6FOTIMjFed85b6E9KE0LCGF?=
 =?us-ascii?Q?3SJ16IMfXsaeVRZusQi1wmkQ74kAE8OK7gz4a1xzkY4k5GaXSeUBD07jIx/F?=
 =?us-ascii?Q?MxE3NgLsZiHPGlrYyv9nDr5ZF6hQJSiTf8zWz9LIweCWgK9/2CwQay+4Z3Wp?=
 =?us-ascii?Q?QwG+GDaBT5/qIvCuS8cj7/NHZ7v+wmvEY8vEm3TNiQ3/veOufp4dGC7ExF5k?=
 =?us-ascii?Q?bTCwKBtfJgSvuY8Ww4W4L1Cp3/uTtqqcUtWRnKyp0JvnFgAnGwftJq5X6nG7?=
 =?us-ascii?Q?uL+VDz1bUZt9Jozk3h13BVF35yjd2cFs6J1lswonwSXzas+z/ENGhHnOUih5?=
 =?us-ascii?Q?TO6+Z7+wIaqKSUimMqWkQVHNAKIC8gVKzMI43sC8kzhsAGLp791eJ/41iphe?=
 =?us-ascii?Q?JS5KmbCapH9sMTeByGESpJM3kPrl2/hXJ0hJXFkw/UY/l/f1YXp7WjmFDhO6?=
 =?us-ascii?Q?gqcMktn23NjpdHEvVTBkPNPb7u/ny3ue+kcpU3mMCrUZzF0FeLm5yCd8Dsps?=
 =?us-ascii?Q?Pnt7JEYspFiGWLqu/GoCQC5H+x483HoNWGkfXOXPkaadChxUGGchCrB9+njs?=
 =?us-ascii?Q?TVs=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12abead4-b56c-4067-02c5-08dc2cfd4a7c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 01:35:56.9475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB4663

CV18XX/SG200X series SoCs have a special top misc system controller,
which provides register access for several devices. In addition to
register access, this system controller also contains some subdevices
(such as dmamux).

Add bindings for top misc controller of CV18XX/SG200X series SoC.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 .../soc/sophgo/sophgo,cv1800-top-syscon.yaml  | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml

diff --git a/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml
new file mode 100644
index 000000000000..858f6a2e4c90
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/starfive/starfive,jh7110-syscon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo CV1800/SG2000 SoC top system controller
+
+maintainers:
+  - Inochi Amaoto <inochiama@outlook.com>
+
+description:
+  The Sophgo CV1800/SG2000 SoC top misc system controller provides
+  register access to configure related modules.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: sophgo,cv1800-top-syscon
+          - const: syscon
+          - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+		syscon@3000000 {
+			compatible = "sophgo,cv1800-top-syscon",
+				     "syscon", "simple-mfd";
+			reg = <0x03000000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
+...
--
2.43.1


