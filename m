Return-Path: <linux-kernel+bounces-86244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF7E86C2BB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9AB4B24BC9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D5D47F5D;
	Thu, 29 Feb 2024 07:45:45 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2138.outbound.protection.partner.outlook.cn [139.219.146.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0F836123;
	Thu, 29 Feb 2024 07:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709192744; cv=fail; b=h72QSXIZ7zQqQHemDG8AF64ZhM5vyQlvat1vz9sTp6t8VrZxYjqI81cBSJgDCXcELp3Vp3GhRHVHhxDfFUO9+fZnpwb9Iaym6VNuTBFvqaNoQ6b/U0cvb4Drz8DLFeNGmDQgobogmfJBe8UqWyrChQkinrDJxegTNutFP/zUxEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709192744; c=relaxed/simple;
	bh=aNkcCeGeo/I8155uoDm6ePT6azVHAq9sHYa1tPNuOzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SoBogd32qH9dCw6IbYcqvT+ly4YqRFl9ANPQ0n3QdJ4yViBjGdfvk6XcfMLwrHsEWKkxT8XSZOee5puNMjkShTyd+pSFnRtmK7i6f7/b0F6OexvBQmzIeGaGbDmgx09hhT/vo6UF7XUeaJbmouYV/xkhicdzq49hfZha08RSIJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAbOSyL1WcUF5fVbswDKfbudoAktdmj6AJR7Cc8RTCXyT4/6ig1nJxQPTmzO5cAqR90mXdncgLz8IvD6q6Rq1Ydx/Hqjm95qqUu6EbiTvyhpUP1yjg/Vj1kfpcVXxFDAQWNTxkDOIkHXfYSqcigjWwGLUhG6FAugFoMoW4Rse6ZGtUTxo4/xilLmPkymmSDLrFAbg6NZlf4MBvEWW1kvt4FcULu78JfuPQQg6amG1cYP+FpUzVqJmg2BLdQcWJ2C/GWxnJM5pT8EEYsBdmIzeyVE/FGHIwpGqTbQIic4vtz3eEO2vBhf2mOAC5Z3BJJyWUFPRvdYe0uCscu34KFhoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwCfdG7Wqc9JK+/OLoeHcLJKRDhGrHtGeA8TlzrcX8Y=;
 b=CtT6as99qESbFdikn/x3Gti/r0TPeqj4BX61bYpV31NNNfA6MQt1iMlR5tP2BDKCZkytR8XKVdQdJ5nwixxgEj0Ag27iYUW8EKNO4fehT3j3nsjazh6ZCy83uBPNmPNtvZ+bw5qeCgp0ccAh9pStaXqm2fUD/37zVIhsu7CyrLjuI2u5hLECOlsIqWRmg2WCVTUJAHslilhpFwPlCazAgkY8CNVc90hXhvBmQrkiEt/apzTPoAknBBHa5yHdrIHhdnC9/R2UM0aoqRL7mbWR4TXjuaSXYYED8QqKACUKqtY/7DA04zN/A1Lp6Gy4x9Y/DnsCk1Ifb1+mfPHD2UmaDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::6) by ZQ0PR01MB1013.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Thu, 29 Feb
 2024 07:30:16 +0000
Received: from ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 ([fe80::2f41:68f:6f07:6c8b]) by ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 ([fe80::2f41:68f:6f07:6c8b%4]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 07:30:16 +0000
From: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v7 2/4] dt-bindings: perf: starfive: Add JH8100 StarLink PMU
Date: Thu, 29 Feb 2024 15:27:18 +0800
Message-ID: <20240229072720.3987876-3-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229072720.3987876-1-jisheng.teoh@starfivetech.com>
References: <20240229072720.3987876-1-jisheng.teoh@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0026.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::21) To ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1160:EE_|ZQ0PR01MB1013:EE_
X-MS-Office365-Filtering-Correlation-Id: e6c5f0a3-3cf5-4164-6a7d-08dc38f84679
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+85/5HHwkmItEotpeMBXHHtJl/rq8Hn/NLk0o9KvPxVh+jnn48dx5r0Tc12VdbVtG4XTVNwAEGHP42AT8RPUCmufBd1DQBgYpd/PH9DdlyaYS0aXu+XmPIVN03d25+8RCQZ7c4zb6lmXHxRVq7fFNaafvWUkgkfc28kDfd8cAQVQm2dl9SxfXn3d9GZlKJ5Fk/MZ+cU1HtO53H/u77pSBdT90OaqPYFPlODRWnUpaULP2yq9R1GPGMPqECoXRBTuU2gEeXRRuNNG4u/66O57IXLyPC5ZoUa6Zq06S08D57W6iqivuYC04upNh2lE8Eh7FbBaTthSq5V6G2rdV1FpEVt+rzAalygpJ+Q7PRd+TNxFuC1ygDT7P87zxQ4l7JkYkl9PHd2nso66YWzzS4rw3nawD/w8uIxTIVKN+GOpVv5K3fGhskDUu8NFr2mMPAPMIYWgF7VbdIDKfmCEZKQqtn/jiM/CnnnsoKt8AYaJ67EcarYXiSBuorC8W3x5SCDaLw+vtJnKC5R034RyYqy8BudvRTCv5jgHMXxqmSTSq45kbUmUCSvFbp6AX6o0YiU25v41fCGMqmrOIPhzNvxCyuisKpDqTBYo8ZAdLiXEdt/fgLzmvIk0ener+TsoNRN6M/6BFGdC4OyIdC/djEvXFQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gdQEkXJPRKxqeI7uufaAj7Yl0mUarVG2IXXG6VsYtGoSoyzbLjLxymS/grvF?=
 =?us-ascii?Q?rlJO39/4dZ2G4qkbzUcickFBELF5kvgVAvCDIPEE07kJAWcejdyAm7XMXb3p?=
 =?us-ascii?Q?bm0yqlJw3mNjBloQcCMlyEeId0C75uZx4LQY7mDlfp+S4cUQMJxwFFBhzsIL?=
 =?us-ascii?Q?VF68VE6EArc0xeZ2h6wInLRmxcqIncmQmNoeRyXoRvB/9yYJ5KVZJYjEq9Jm?=
 =?us-ascii?Q?sNU9ytQvr7qyMMJU7q/gKpeZychnxlgZ+WHUlpe3THAezlQRwwUku9ek/ROc?=
 =?us-ascii?Q?V6qJinUCAEjBBnrzDb6laWkQZcBlX1FpxAk+I9HkUKWX++eQiDRcxvUw0RmA?=
 =?us-ascii?Q?+hMRNu6HoLmPK+0waARG/Msq7zgKZxRptcIy5ajP+HcE4GDpJVHKrI0ScyU/?=
 =?us-ascii?Q?uP3rlv9Z0gVtzTUhv7ma+hn+nB8asLvyztOMhwt3fs/GE0YgXKv0viF9E9Wh?=
 =?us-ascii?Q?8zEkMZ1yTumwZeOyDXD1hTEzJhjwmFyWBZsXuguXSzeIbSIW45+3kzsOH50m?=
 =?us-ascii?Q?amT9mU9dJ1YSARzLNScqKw8lITG8Uy16D8+jnis9xyPvW1qnGhKydt3X573P?=
 =?us-ascii?Q?bm6rxTEKUl3Xt/boSuinP34gIa1VFiIOsEUxrxvDDCAeNbmbAIlZpvFx1f7t?=
 =?us-ascii?Q?yyeoh5pvn3J2iLc4ZOO3PoD/wdJ2Cl+O4miasYGrO1yoqqrSOi5d3+0QQP4g?=
 =?us-ascii?Q?ndIwzlNvL+TBFIfn9W3eJFGBy4e+HQd8c2LLyr/A8Ta5EIYsS3RufKUwh8UY?=
 =?us-ascii?Q?8K8zEOt/qovIYGib8cz04HAHsPynrdPRhU056MoFZuClAKxzKBz6rcfwSABw?=
 =?us-ascii?Q?6nCRCWCzo8uEocvxjcb00oX/B4gVzqdEbjOG89LlKctSVxhXYvhJzN1+R7Lg?=
 =?us-ascii?Q?wu7L89+BhN0fpCzg5mUK73+MYcbWAZtuJIO9cBslqoUcrSka083Crjxb5Nuf?=
 =?us-ascii?Q?2tdQ3eWt+HXLTVHaymA9ZZK4Ce2OewG8qJZyIwlGmI/ZQBpMc+3dcSs8RQen?=
 =?us-ascii?Q?JoX/1lzMkCFQRp5VSjnvnkwchnY1u4IVipz35le6YGL3EF+SAO25AZD83+rx?=
 =?us-ascii?Q?oFJyGdBy09AqPHGQJQPCndQtcZ5a9PFiAk2HPowjA3WrskkRSoDtvqS250Gl?=
 =?us-ascii?Q?ND9p4MVeczc41FS85x49LVRhQzxRLXMvpjIOZ7w/vlu/8huUUeNjxjB6t3md?=
 =?us-ascii?Q?ugWDU9UWxi81AB84+KGZSekSdgiQ3Ng31ONs745kfLThpRdxE4gkNmbHr/FB?=
 =?us-ascii?Q?Pe0DTdDaH0hFunO/MWbdC2fSyMw7xl0ZGoS+UGpVSRjAYUv5JbJ+AKBtoVOr?=
 =?us-ascii?Q?AMmxWpxtSo6M5XeyPhn0xwsZ4wPA6++1SFdpYq89+kQhkJAVxeKwkMigonhi?=
 =?us-ascii?Q?lgyuO4hDjLLH3Q3rVeTcfZs9s/9gzF+40fm5QHMJ4GVBoG/jITLI5NLSsvhS?=
 =?us-ascii?Q?pBD2EmVDXM/3Wpkl3bg0pYbQquLPVQ7mLejSLHeDJwhJCS4fA2jfd8tWw12M?=
 =?us-ascii?Q?ogqFvHh4gH5CXUIvGzv6R6bFGF+Dc8gU2b9jKh1uRltJg5CyxfqO8T6gBZ4d?=
 =?us-ascii?Q?FGierJlFSKiXBYp4p35UJ+xofyiXYDpbRlRN0ZrmJxjsOkvC3cAQ0+tljYtt?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c5f0a3-3cf5-4164-6a7d-08dc38f84679
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 07:30:16.7231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Myzti3vUKwaxIPsFkeYTiV+/9Q5goguMzHgli+FZVwu1ul4dES5PdcjFg0U0KkcyLw0fuhYC3szy9Esc7NpJlZnpCZr0KWX/Dm5+6tYx9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1013

Add device tree binding for StarFive's JH8100 StarLink PMU (Performance
Monitor Unit).

Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../perf/starfive,jh8100-starlink-pmu.yaml    | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/starfive,jh8100-starlink-pmu.yaml

diff --git a/Documentation/devicetree/bindings/perf/starfive,jh8100-starlink-pmu.yaml b/Documentation/devicetree/bindings/perf/starfive,jh8100-starlink-pmu.yaml
new file mode 100644
index 000000000000..915c6b814026
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/starfive,jh8100-starlink-pmu.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/perf/starfive,jh8100-starlink-pmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH8100 StarLink PMU
+
+maintainers:
+  - Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
+
+description:
+  StarFive's JH8100 StarLink PMU integrates one or more CPU cores with a
+  shared L3 memory system. The PMU support overflow interrupt, up to
+  16 programmable 64bit event counters, and an independent 64bit cycle
+  counter. StarFive's JH8100 StarLink PMU is accessed via MMIO.
+
+properties:
+  compatible:
+    const: starfive,jh8100-starlink-pmu
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pmu@12900000 {
+            compatible = "starfive,jh8100-starlink-pmu";
+            reg = <0x0 0x12900000 0x0 0x10000>;
+            interrupts = <34>;
+        };
+    };
-- 
2.43.0


