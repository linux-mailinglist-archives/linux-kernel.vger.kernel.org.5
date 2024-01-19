Return-Path: <linux-kernel+bounces-31533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A72DB832F9A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157011F25307
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12A757876;
	Fri, 19 Jan 2024 20:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PkUHr5u7"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2055.outbound.protection.outlook.com [40.107.249.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0EC5677E;
	Fri, 19 Jan 2024 20:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705695062; cv=fail; b=QXtnGc6S1cHdX2jVTG7H5UzQzaJlWFWOpgKd87TwjoBdF6+N7Q6CDInFt75hFS1LcLah9TupIjo6mg06H8efb/TT5n5XleFK3vP2QI+Qq6HZfkc5991ZxPypkD4pY3M7XLzix0Wg5wqXxcSAFP9jukG+0BjE5J/0fng8TeURh64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705695062; c=relaxed/simple;
	bh=rTCcMFMoC/BDPlxquyZsnIlz6G9e4xLDQ4yXtZ75M0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lgpESJRWDfJ1i/mV753cTW6ZlvxARlN5NEHnaRPJ4BvsJPmE1fD43OBC3Rn8N9tUhKZ4uiiKtkQPhuJkHj+KLklESdsgJ/ubfTleg3UGzfTT9/3YKcPdVbldRK3SFytOpgf8w7HgLni2t1Ll8GEY9+SCI13akjSM9YEVHkK3gCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=PkUHr5u7; arc=fail smtp.client-ip=40.107.249.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UREgwCzmgzXQpJksDlaW19+taE9KzVjjI58/JBZVlrQp2xJrGqF4pDFOHQbz8HDylloZoftYqR2UpQu3Ztwshv2u32xIwNSFpG2lQc0oaQLrDOVuNXcit890bGyPof5oJaXN8Nuv2RZ+my8FmLzPfW/aji06is3Ujs62tRz2UG1yEN3PFQyf+ULJ0pM39Db2U0E6HHYg/nC8aX9AI6RgUP2kpwHcDgThEAfbeHngUplg0jbjYsDpdZEikLPVqSLNfcwvfF48v18uzVqsADwwtIShYHKx2uBbaocEnNhWgzscgu/KQS1MSs+E6lZ9bKzz4lD9uidKHUVPz6AuGya+/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1Hb/sYRRxxBXpw/r2wj4WSZIZiMFXaDWcDVD6w5UMY=;
 b=RA0wmP28uUKAa7p/ohcQMEM46oI/Z8Rm6/Abu8Dy9fbo0IBNGkxKXQUBP+IJOEEFhNOFJ51nbM+lkx6akAdLBfv5aFsLu1mgxp7emFodQXPjMWry1W55Qg9MLN/Hd6z5ccvySdoFJE+BpWJZUsAJ/2zTHGq5JoKmOxdkgtZx/mXubGZImxZw/xROezvihrWqGIOwsSnc0jwRH3iM2DIW2Jk8WiJuOuEnsbRbNh3XdFFTPmdjxuCowEn6TEizx1/+kvdqrDjnp4XUfPlTm6LQ3wDjuZ0MaRxVgwC/01pGFAi9xgLwJYKuiI15FHCmiQokIQjiU97tEpF0RP+Lp/4SqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1Hb/sYRRxxBXpw/r2wj4WSZIZiMFXaDWcDVD6w5UMY=;
 b=PkUHr5u7UozH+UsZpX8+YvI03kY++osSuCIX/9Exiv7zjOc5Y7wILA4h/zJ967WvFzwb09qO8qjjFliCjzcR7Jh58XgpMDJGiffZMVUxRNGspozlVmSJ7LJVqt1MMCtiTvub9ZebdcISY55GVXwqd2fvqL2VcxbqlOfxAbkmyCI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8565.eurprd04.prod.outlook.com (2603:10a6:10:2d4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 20:10:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7202.027; Fri, 19 Jan 2024
 20:10:58 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Li Yang <leoyang.li@nxp.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 3/4] arm64: dts: ls1012a: add gpio for i2c bus recovery
Date: Fri, 19 Jan 2024 15:10:34 -0500
Message-Id: <20240119201035.3124007-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119201035.3124007-1-Frank.Li@nxp.com>
References: <20240119201035.3124007-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0380.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8565:EE_
X-MS-Office365-Filtering-Correlation-Id: 292dbe11-953d-43f3-3fa5-08dc192ac068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lS0uh8k6hLhEYvT6PuFO6A08Mn1mc+AGX809KYambBzGYTgBNneU6Q5GRLT+GhZTCncIbbDhp4jrJ3PHWZOZUE2nQsVN5QTrenmmsveAqeWlQMzPC/RdB9DwEJ1SfgWhvLlyYhLgWbA1UDSGgMlS5E2RU/liybm/3wTFAdz9+LF5RbTcM0+3KZuYGUOKEl4rZDRK/RbPm8JMSMXEur7zx1sOPm4uvPdk7h/8sj3Ngxoe5ANkWo1EDGlfIS9kVp0pJnKn5YmdUl3ilDLS8UFE4S224S0KRIhJezrWamMJq2wL3bAV1Dz+pT0WsieVrCwfLTQsM3slAmw1WSpaRRuopfrT4cEiv1vCYPhRm6Ate3cb/2kJQ7ySKbtx86RnLXrf1DhEcxIQjfYA+TN3LOYX6IpI/CL02PS1npGQZDzNrxVXHkUECTDWK8KO2VkinLW4YXBvwA91CJ8BkDg2tgLUKJ4LRC1JtyWVPe70GASEP3IiNPY5iO7xU3obQdocx04KUBfBlD4+7vqJhzdr2rzAx9dF50KUT/9LFN3RYEgf3aU+5z/wgshyEAUuy2d3UioSLg/zR/s8/9wcSQuaHinpBHx4oUlxLfJ1C0OLff46VG+h4NaCz7q7Qb1n9LuItNDe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(8936002)(6666004)(8676002)(52116002)(6506007)(1076003)(41300700001)(26005)(38350700005)(5660300002)(36756003)(2616005)(2906002)(4326008)(38100700002)(86362001)(83380400001)(6512007)(316002)(6486002)(66556008)(66946007)(110136005)(478600001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BeGp6JkkG2jX/FOIYXdWWCf25Cv3gwWl+uydtyEpZifQWeJjk9YOTqwMiUOb?=
 =?us-ascii?Q?/qUgA2OGqg8d1HiHG8ims5ZxrFpC3aaVmy+NKnT7y6omkhsHjlDDj9t1C5L0?=
 =?us-ascii?Q?OYKk1gVmkJa9iP9bn93N8erMxuSxY4m5kswsscWMn2CtV7KAeIPnC6srVcFt?=
 =?us-ascii?Q?v5Pog8sOCM0ECO+7ZQbyF1Eivl6lVFwfftF0gPYariFHP37WTVUvD6RGrN1E?=
 =?us-ascii?Q?TryDRtVlxGq2I5bRML6wqI6aBh7fV5teqGR8C4t7NcPIIIy1too0jjVFl3EN?=
 =?us-ascii?Q?scyys83uwMDFFcprl7WIO61NLzxGio/OwDI+ci+sRnzPSA3J8zlr40HKjwGF?=
 =?us-ascii?Q?6v2D0+X2XzcIlyrj7VOnsXBMEcm7y+ZAN+N5a0FQMygbCHk9xHT844T68LhV?=
 =?us-ascii?Q?h+KsMPEbzw+PKRm0wj3YHpvEbLwjOxXRynBE2AB5Tki2195bJmCZc5bqLKmm?=
 =?us-ascii?Q?5eQOVDr9X+gb03hdNUvng+vEH8sz9MPxFsmfG3wUdQeC2h53ievJZ+nIqJhQ?=
 =?us-ascii?Q?1P4fCDUc/PLXEjVrGeilpx2eCpsVtOp2apMYJ11JNU7jS30Zj7rLnYrbWgao?=
 =?us-ascii?Q?N/kX38/WUPFU/tj5ld5JEMA7Dgl72neBYPW59Qf9lSt11xaS3NU0f4Lyl9hr?=
 =?us-ascii?Q?Zq+y6hBEtqaT3Bt+F7qM40x52jKfa+qsxQ0bt0TISItwYQSQ45aATWtplp3X?=
 =?us-ascii?Q?5G+et4c2oOm6PTLZ7nOBxf+veA8yLYq4RMmZ9MzJO4kQuX/2gm7uKDHKBD2/?=
 =?us-ascii?Q?21qZiHurpmLWmZqugdUroCBI0AnNypnNoEOks+OEeSCq5M5ie24Ck5KWEZ4B?=
 =?us-ascii?Q?9vQN0YgPfWT/1ICybS+Wnb+8VN1/OkUaf8XHjBESfKopjKfXeiED3VpRy0jp?=
 =?us-ascii?Q?ZpPcFIDNXgVa4BC0WH61eJGrUKMjZbIUD1LEJ+wSiYfirdzY+a3zV0pwzhrx?=
 =?us-ascii?Q?v/ZEUV3fI5Xsj05s0oGpwSbW8f0VDyW+929feIMx6hbGOFiD+hGABEALyDXS?=
 =?us-ascii?Q?Joj2yaAZG31SgTjGXv9uTqNpOg5NRButaQlcSEju/tDUsAemRkVm6KTjDhq6?=
 =?us-ascii?Q?Oyzt94ITfHxLHmRHwuLzkSVU3VbAwe5ub3DRN4pjD6x1dJO2QeIjYlgZFHS8?=
 =?us-ascii?Q?9viNvnEx7BQ+MHIT6jvPqk2iFVlyCj1KWYgVgJ5saV4o3XaRqY7GdFfcg4Bj?=
 =?us-ascii?Q?T5oBHyrBVduhhjVGUbQjE7iU3FtddEHc8/kMQCTgFSkemSagWJ2gmc+TTSmc?=
 =?us-ascii?Q?ZDi6wtc8Dc9U4YM86+9JFOuog8EWE5isEHDCx0O91NV8oTy6jUetX5ZVE1MV?=
 =?us-ascii?Q?NLsR8mnqyisUsqAktpGPUoKKIEUUgN143zvjxTaLIT2AFCdfex70saHXmIei?=
 =?us-ascii?Q?uf5Iv7Y6ieNb0Xl7kxZvh0zu/BzhP9xLUWBCasyJDGaTPW4rUnhOS7+mM1WA?=
 =?us-ascii?Q?BJe5WBvcKEmq8bkxMVQ8hqufET67c3m9CmtP+xAO7IgrwhpAHD98cYaTwfjI?=
 =?us-ascii?Q?uZgNaQTRrkIHybdYdrn5okjDnshbznIeh8PzP9lLwv7JbJ5HqlDStxkHTMDq?=
 =?us-ascii?Q?WZYH+Z1pFtZtyVUtSHVz+JUmHm4085t496AaxgeN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 292dbe11-953d-43f3-3fa5-08dc192ac068
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 20:10:58.8823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yMdelM/0taVPh2WJMJARxmtlNcb7gCQwgcVb9fQepIJW15xqtNWD9U4BzNXpFUoHqUBj4G488Os1Ja93+smQ0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8565

From: Li Yang <leoyang.li@nxp.com>

Add compatible string fsl,ls1012a-i2c and scl-gpios to support i2c bus
recovery when I2C bus lock by i2c devices.

[Leo: updated scl-gpios to match RM ]
Signed-off-by: Li Yang <leoyang.li@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 5a6d4848fe485..116fa68e13ac4 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -351,24 +351,26 @@ tmu: tmu@1f00000 {
 		};
 
 		i2c0: i2c@2180000 {
-			compatible = "fsl,vf610-i2c";
+			compatible = "fsl,ls1012a-i2c", "fsl,vf610-i2c";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x2180000 0x0 0x10000>;
 			interrupts = <0 56 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(4)>;
+			scl-gpios = <&gpio0 2 0>;
 			status = "disabled";
 		};
 
 		i2c1: i2c@2190000 {
-			compatible = "fsl,vf610-i2c";
+			compatible = "fsl,ls1012a-i2c", "fsl,vf610-i2c";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x2190000 0x0 0x10000>;
 			interrupts = <0 57 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(4)>;
+			scl-gpios = <&gpio0 13 0>;
 			status = "disabled";
 		};
 
-- 
2.34.1


