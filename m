Return-Path: <linux-kernel+bounces-111000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 815608866D5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F501C23716
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6FADF62;
	Fri, 22 Mar 2024 06:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mtYwpPjH"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1674B2900;
	Fri, 22 Mar 2024 06:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711089557; cv=fail; b=WtiTxCILzfruzFxYHcpiVPS7DoOmGlB2NvxZ2O9EE0kI7TUxgByzQmc5eWrV27DwDzaMsKvJHrvQwBPCrxhT9vD0Yfgn2zliAJOesc6Q+eKYn3QuuGFg0XcE5rB32vi1d8Lp9Ht+XkEPzzp8oPQa2ZmNH10I9bMBzIZq75ZwPoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711089557; c=relaxed/simple;
	bh=ZU3bz10Oi+T0PVUlM/ZiOBBv7hQNRzmk9d0DfhqtvA4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kvYzXg6ZNPOeo1owyUZSNTc8DwJ9mT5qwDBayeHEAeQl0O869DM1TEPnuwD5vC8/BwSg56ivWaDRSGY1g+ecPLjHy8dzb7JvMEWfJaWlrqaHhnKhkcSIG+alFNttKdj/YrhkI4pmlCdf9gfhe+BamguhfN1ba1YieEJzuJR+YQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=mtYwpPjH; arc=fail smtp.client-ip=40.107.20.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fra3dtBvbA9Jrn3GiF8p/0tbxMotFp/5ao+J84VURagmsZ/X4N/Q40+d3O2QdjIWlJj1CSkjwztIW5sDgxblVin4izW7T8t0gNkQ2Rw2eiWtcZxW+zM09XBcs2ZEy1/dD8xXvAa47iCW05/d5z8pzhEsAQ1+IrpGTsVRsfdXvTudrGdmZvHzjzcQCAub1E5YopMlzyczEH+ALFRXKZs+nz8c4KaY8vvclZ6MeijFWqjWIsLFfPgLq/K3VGJZWp6/14xQL85iHgPnO0TaUV7WguvS1KG0yhgxVYyHtt3LErlWLno1YCzntr64CxO7k9wW7lDdOvXwPtL5TJ0NvX9aQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kU6ltcEd9/H24mNJfR/tl4910fcrDrrYvk5Br1cYSrI=;
 b=dZFGgJxYwRoULHBKhqPbTaY6TnE+BYyaJflH39djozZmmDM4NNSEbMXSdd5XZVyuWauZ75Ld1TFwlBsYMb1JvNdT9a5Bhu8kCd1DPVEI6zBKJZ87ZuNp2XvrrjypAapoGgrXOiW4IR8F4KWrLdTaVGdY2c2/tlZmkf8cb778dK6rvXIsfRDr31rLEEwjJ6V5TrhxMxP9C/ktgwf6rcePP5sW8mji0RXX1CPMKDfu426BBfyGnM/5UvExDZixhozuJoxrC+SUpDQtQngVd2mcaSxSh+9ezlsNSjGnUIYQkXSRa9HNnQ5YxvS9dMAc1DRUNWF2ZcstLhpTOWB1nbodKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kU6ltcEd9/H24mNJfR/tl4910fcrDrrYvk5Br1cYSrI=;
 b=mtYwpPjHWfvF3fZG5I28DSZYO3rnHUyO3zwdDdyLJGC8O9zKh20/Rp0RV1Qxwfm4aipTu0y/XHfZ0Vut8YrpkQrPGpfe27RW91lcL4JK/vvnOh06cKR/ZgIdrh4wpFK6XLLdcF1e6TpR1gl0aTolNdVIrIcc/+TRPc1QI4dvZLw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17)
 by DB9PR04MB8091.eurprd04.prod.outlook.com (2603:10a6:10:245::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.15; Fri, 22 Mar
 2024 06:39:13 +0000
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::1b13:505:8d50:f4e3]) by PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::1b13:505:8d50:f4e3%4]) with mapi id 15.20.7386.023; Fri, 22 Mar 2024
 06:39:13 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: frank.li@nxp.com,
	will@kernel.org,
	mark.rutland@arm.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	john.g.garry@oracle.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com
Cc: mike.leach@linaro.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	alexander.shishkin@linux.intel.com,
	adrian.hunter@intel.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v8 1/8] dt-bindings: perf: fsl-imx-ddr: Add i.MX95 compatible
Date: Fri, 22 Mar 2024 14:39:23 +0800
Message-Id: <20240322063930.749126-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0121.apcprd02.prod.outlook.com
 (2603:1096:4:188::21) To PAXPR04MB8829.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8829:EE_|DB9PR04MB8091:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f6906d9-be2e-49f5-5092-08dc4a3ac9ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9lotxkWniJuz5lDIF630K2wuDTsG6gxdCuyUY6GWAmrH0cVnMQgg4xxIbFfWRgt/hxXoniczDdNVpG63508ITCKLveDp+LQGiElhC+DwYbCY54YxXBKxz9QV7grtn8Yrv2FU6IIkz0ZVZYMl4jR2+F1jwWHRW664UxkNMmGO3d/3mBi0UyiPKMAm/MIHvqQ7Pwfz3V9yQKC12mwvRJLv9PhVLkz814bFWf6ixrasDUTMj42pWvmukWN08z4R9GCrmWgCD8RfZkvXZuDWBs0KPr8WulHGb5DgXnKyY65Q5N10b3G+G/kkRolL/RAnJ3IbEEbLpoo6a10WfJl/bf/MjxAsSXW/QjKQm2XqGA/OcaVCZIMhphu4uAOdh7L6oKb9LbC0TxFFL8nnQFfuZUeyseHzH/M+5UAXBIzbTMEqM7jd+sHxxBCJexkY718ShTucR3qcIqBTj3nkRgzN3vz/dtOw467hNHWb+n7fxkwxOpGTha2osG7mVUtEPOdqFtd/eUU2AFaI0J23Tile+ewbiDJKoW8ySrfJHFtX39CnIOxAjBRTXfvBcNNBjrI2z/3Hw0pice3YYBCK7Ebq6V+Loo0ZLHSXKueXWKpK93g+GZtw5fzouTNcFNIrFWdgNwbB7IOP+zRrwq7IwQ1pWMhxkMBjxG0JOCTgTN8VFebhaDFk8fLAZ8nLu+556ovL9LrWn7HbNaPVGoCXAz30WLT6D/Tyn+FD5WPkGZ1CI235ZYk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8829.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(52116005)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gd1EZzLYnE8x7tM3lrBWr6r5gzujIisLXUnb74bXkeL8ZiyRw07udtCJ6f9z?=
 =?us-ascii?Q?5W3HdHxU9LgLyWWa45HiL3XpJGNwyAghaMiskGDMZll4Z27PdeLvVfIXu2QN?=
 =?us-ascii?Q?gDlId16O3eZlT48h7IwffMxrO+oadIgzvjpHVRAWMtJ+aa03+p1U0m3tTUih?=
 =?us-ascii?Q?GVlKKCn1KZiGjlAAV0FFN3Q9kBD5DgER21H4OfW4P9S/1UdIdZQP6W9MBAVF?=
 =?us-ascii?Q?LDTSPfp2koTILrwNH1xRjs0NmzwE1zFqNHT2xEeQKQaDAere0eX0UxttEzN1?=
 =?us-ascii?Q?g0Uofcpx+iN02U4j8F2k9y7Ew1IUa4i4KrUkSC31HsoIVtzGqNXoUvW4LJ3G?=
 =?us-ascii?Q?R1jF6SnDtSjebhUhWogeBACXLjDcPLe6/P/jfSatXVZDCaabi/iu+VKiQsSM?=
 =?us-ascii?Q?pctwsJk4ebfEhPZUAZW2xGrVTDrXIYB5ppowcKiP3IF3zQv4I2TvxbdtD3i2?=
 =?us-ascii?Q?lvP5sFQwVWFXL12f9H7iP8O7AytONFoREJZVKqevrSksGEv4YR1yPzggBdsi?=
 =?us-ascii?Q?4TA2MqCQo0FeMvmiIkzjtvAVmiFF4FpkebSIVlndsblr1uM88xl597+Gx24i?=
 =?us-ascii?Q?NQYC0UYRl3oWfiKEDYJCHH9H9F/OOoELzTBr7EDlRL7x/yyhZM2SxxQVXT/R?=
 =?us-ascii?Q?ZCvJUw+GJV5aq97CBf9xvoqMOKWVvEUmwmky2GESy9QZ54IMY0baVe2VR03t?=
 =?us-ascii?Q?kSbBw3YalgYnFb/AIUBzj2jVPbMPFz3izHmyvdc84uEv1Y5PEcpf9UrO0B6n?=
 =?us-ascii?Q?zbj5SyM8ABUa0nprRqyj+Hd93wOp09MyUCxFRTE4OnTWs4A/W/sH0kCiP0d1?=
 =?us-ascii?Q?8rLWesbJinJYvpaqYb2Un7DZiY3rKKhfL9yTuYX/jDPfjBP61BB7dAgD/bB5?=
 =?us-ascii?Q?ZoH81e0dKoDuMXRk5WRYv0EClucXdLSe/apVMHrnWlwenDNk86Z6I3Wxr7kS?=
 =?us-ascii?Q?Fc/cWHMp4tWn06GDfnrSKKBx3hRwxsHysb55QeLV196+l7p0nF8tI2VJbj7t?=
 =?us-ascii?Q?XywPV49z0sNwLZjoowFb4+JbLaF7Moi9dwCfwaWnre8NXfizqBxP6DZRqQPV?=
 =?us-ascii?Q?kek+VL13cjtu0q7e6SnwigufXl0WJPCoWRgnZWYHCm67Ebb+aaL6dcf8Jv1B?=
 =?us-ascii?Q?IcxUvuor3WSnuk0FHrqbH4FLKtkjKaCuqgo5RlRiOj38Xulvh/ViJr77RmNk?=
 =?us-ascii?Q?xtHLenFAQQjTuT4Rp+GrJ+L2fSEo3t4iR3Z8yKoV2BM8K2qsGeXVRBLvTV9w?=
 =?us-ascii?Q?ASZEjRe/KsilxFni/HVUHirWK287Xc5wXGR62baT8RpoGBRrvXpU6DuSw0VR?=
 =?us-ascii?Q?terrbpWQ9vbfXcSgVefNWYGJwOooGiPm5SspCWViT9R5OXcM+U5CiXLyCZj8?=
 =?us-ascii?Q?C/gpEJkf0cbyQptvKFkaxN1HNObr4LVlJde76VDUJQOR39XsGhT02BEkDlzR?=
 =?us-ascii?Q?iwX06dam9hVjHNRvgw3BjHas3Z+zU4/Ds1zIGMRhO71gmDoU2YHlcOGNcukv?=
 =?us-ascii?Q?Rg6+RkHO5eVkb1QnkKe1ANWLCkWh4zUagliDN/ja3alFeQ49Bd7kP2lEAPHL?=
 =?us-ascii?Q?+C5gXcfZQv8OQZ/xxe+s3iZ4G9KvdW5BNbl0Kb8l?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6906d9-be2e-49f5-5092-08dc4a3ac9ac
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8829.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 06:39:13.5222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2Swl++DtA7afGwgAsePumVglwH3hd7SEbXg2Z/NNsDNPIS6vBJ9t/kKA29/62tnYUfWi/eZAGdgtW/KUMsqUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8091

i.MX95 has a DDR pmu. This will add a compatible for it.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - no changes
Changes in v3:
 - let imx95 compatilbe with imx93
Changes in v4:
 - add Acked-by tag
Changes in v5:
 - no changes
Changes in v6:
 - no changes
Changes in v7:
 - no changes
Changes in v8:
 - no changes
---
 Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
index 6c96a4204e5d..37e8b98f2cdc 100644
--- a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
+++ b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
@@ -30,6 +30,9 @@ properties:
       - items:
           - const: fsl,imx8dxl-ddr-pmu
           - const: fsl,imx8-ddr-pmu
+      - items:
+          - const: fsl,imx95-ddr-pmu
+          - const: fsl,imx93-ddr-pmu
 
   reg:
     maxItems: 1
-- 
2.34.1


