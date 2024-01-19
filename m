Return-Path: <linux-kernel+bounces-31534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E618832F9C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D390287B2D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947F55811B;
	Fri, 19 Jan 2024 20:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ng45fGla"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2055.outbound.protection.outlook.com [40.107.249.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD2057861;
	Fri, 19 Jan 2024 20:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705695064; cv=fail; b=GQlMTzh/GP57XN3NpfmwhpmdJwh7F/ur9FDYDXw0d28Ycr3zgSXW4+B3Yul114xLcVt1KDjFB4vymz8jnkPjwglObZcIKiDfi/MPN77Tq4UbrlwjRMgVrAVUGfmO82up2RPhN91dSdcCdvhJDQTuV45omsyGjzPHO3Qk3XIZh+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705695064; c=relaxed/simple;
	bh=b2HcQVEMMjP5Q0u2pxBWHG5EW3abAqTx02hn2ypr6vA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HzCRM9cHpwWSFNzhQi6qK0kTa1Js/LSXFZLpPsC8jvdFmo67PqoXsY4lmBGNp/tHth8PkMdhA6R1K+8eh8QIqjG6D4b0oJOPNSIykRF7oNVqMT7wWdvIt+iY59y4TsbusTnQI/3pd786a94v7fZ3m2IakaVSavupH01Ek662Hr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ng45fGla; arc=fail smtp.client-ip=40.107.249.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FV/IWaJRxgvrqj7FJpeAP8HaF2MZ5bMxAKgG0jnOxAgteAuHJWjcyTsKlqzzh6SOJNEHZtUV6zpxxWsH2Df8G7Or6v+FaHUOOyujyuIBePqzV6VZyertY54TLCHyBLOJr55uXYbOKe3pTm4I2zi9zqeOS13fqoevBChQOyK8VLoXG/3SGlPkdqaA3LyJm+2yTZGhWqnu0ubI/MBx6dGtY4gcAdGxuhBA1KskspLR8d0WLQVSR+8W18yNwkY96Ypbpxb5z6ZZhNFJyIsLIQOBXjtt1pdNg1mj/je9+I7YmOHHBFOAenjOt8VEdLoo9VGRZz20CcG3Mb3zwd+zc+TLfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVIjnCAtrbqXo2EZpD4wtqHp+JGEZcBp2Okn3UBL6mQ=;
 b=FpLQMHfhHI/TuCcOyg0fZdIXqufr0Yb36mD2++oxOq7cGE8KhPyHtngMnKdw2GwZVQkbcFaFvrUhbIt9GR4wple4Fbas2ksWKEJBP8St+0sklay6pfJvUI3EgZBxsWRhkNDgA1+q53xy2AG2h4LRJ1TFVo84auxz9yIWxnrM36VFC5sUnC5C+mSYe287Dva07tGKkrKXGCR2B8Ld9tauRItz1kpr7ws5yFKZHenDAuJMFBb8WUWjRwKZ+5VPGws6yGP3dAvDcOMlerFbN+gjLAMUPr1pflkg6jBS23f80nTCZXeAcHB7vHAKVc3l+80oTuXlpUFbrOF1aW6Y3h9wDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVIjnCAtrbqXo2EZpD4wtqHp+JGEZcBp2Okn3UBL6mQ=;
 b=ng45fGlaOEpCcuHYslr8VBY0oNni2nHwGjaA8t4xvcRY7DKw/9l5viKTxtmxk6n/ocxwfW4Z7kvXpAGikvoTHCQQRC+o9j/wx/Wqfrh8xGAbxprEt0KuRx7IQ7HP2F/7MCgGe+CN16Dr/OFmzQ9EdYGhCWjHeNit8roKs9qAqbU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8565.eurprd04.prod.outlook.com (2603:10a6:10:2d4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 20:11:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7202.027; Fri, 19 Jan 2024
 20:11:01 +0000
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
Subject: [PATCH 4/4] arm64: dts: ls1012a: fix DWC3 USB VBUS glitch issue
Date: Fri, 19 Jan 2024 15:10:35 -0500
Message-Id: <20240119201035.3124007-4-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 179a128c-672d-4d9d-2df6-08dc192ac21a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gJUtYi5UtmmNX0jAv+bjwVElELaoC27v8rkcd3Vi5hI6a+JDa9PYx6VWAtJCv9A7rNJLtozwp2HifuXhfmlLK+ccirfImVxUQbLp3x+Sr9KRpfML/1R+r6eKDBLTvvQx0UPHRjnCx73J3QGI5j05ZyPROhRrvCtD7uheJskSPFvHAASssB7eBkNQ/G59MbdGL+YAm/ls4jJGld6UzQuScSaRZPGnH+LbXRJKWYMbfSsoyuHiLeumHlYDICrzFtwh0gF8ZrJwv36voHlmamosOfhKOkcYCxPvEcYkX3+97UO7pVmtBozyO3hFJZp2F73yzANypkk7K11n9LXDoUP66XyfDwuhcvgqLfFULwnEOvV8wZIRHw80aZHHibDareA5TUfY7xUZFGHCKKm1+5/2mHLwZ7ETMih36ru2HESKVVbldrw7fM93pr958RNLK+KTrHUpMfcCZk/yy8jNpxmfcjktQNzZAcOlE3mgej+W82bFGOomRU4R51qXYxZ5I5aAVvmjxj0QUQbIO96eGUpoCj6YKLzmbh8KBEi2z9lsl9ih5WUdQfj0KFHnRKxH7bPFF0oalRhnUH6GuvF643TZgJsp2zTbSSTipbrLd5OZOWpZPAc60rg7FYyDW50Ow5Po
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(8936002)(6666004)(8676002)(52116002)(6506007)(1076003)(41300700001)(26005)(38350700005)(5660300002)(36756003)(2616005)(2906002)(4326008)(38100700002)(86362001)(6512007)(316002)(6486002)(66556008)(66946007)(110136005)(478600001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2PJsGI77fAVHyTPSDZXb1RRdwIA16ZQRIm5GIJqhmtrTmu4gbJtNV4kZqXRv?=
 =?us-ascii?Q?JpkxZMSHuHBK8okU6m0Sn2UAg1ppTpiYBgea3IOA10DVa+hxQd6+74fhtpeU?=
 =?us-ascii?Q?C+Tr3x5YeyrbSmDsUSmRaOmXlNX7xHOeV6F8enxEBb/ZffEMYF9B0Ke1g3AV?=
 =?us-ascii?Q?Ld5HSFH5Kpf++zq3oUgUw3kaw/PCx1ux4ApCqbrJZcel2YLoehBmjK/F1Paj?=
 =?us-ascii?Q?7RTH0WK577aPsJrBwKOQEZ1F66wdSMU/vMeFrPgWJqK+lEh9yU3xMt+Tjf5S?=
 =?us-ascii?Q?lsvLEcJtkzZcGD/bIFVd8E6ezdQSz+QnclEYampPCD9ocV7/VUmJMzPkH0ma?=
 =?us-ascii?Q?bVtKxGj/28JYzrbqeBmzaz/e7LevMp+DwQKKkv8us8Xr/91oBVEmBU0wqROc?=
 =?us-ascii?Q?1/TOlQi5X7p4tMsFHve9ARVurPuQ8ZJ2WD3TsGOKWD2RkUT7OpudynqTMOFK?=
 =?us-ascii?Q?hKrSBDWt3FRlWr4QbEzcPKPNaVzuYM1UFGaK7FiXexCtWk0oO8MGFF3Xqrav?=
 =?us-ascii?Q?eVhLQdSBSpbYK/nOx16ov5kKWzUXmIz5yT6BGqz2CcpWV7XYkv5CiD/9w0ag?=
 =?us-ascii?Q?ouxK2frq/3CwO3cu4SAKgi2Ag3ao2o8jBooGzgOxthiegENbWjENulSpwF9J?=
 =?us-ascii?Q?Rb7Q+m6gfBRjqQGk5y6OFb+ifKpOfzn5XygvRMkBlu5H8N67yFbXtLwlvvx1?=
 =?us-ascii?Q?h2MeXxYMpKi71Z2i1xKKy9n9HkTVpkBW8OPI5FiscYat0yHKQ9ccvWnUChUQ?=
 =?us-ascii?Q?S6neeCBSDoHu/84a1dFUXZl7Ukw1sztBH8HNtbXWQ55f9Zd+0sc0EypKZiDX?=
 =?us-ascii?Q?GK6SaatORPOFUtLxgyHZ6PaKLHy/FYGenqlD70WIe84hyr9pP8wFOnGUHKyl?=
 =?us-ascii?Q?C8GefVbHzZDOtITs4Tscn1dLjXedBA3kiNEveIul1oC1D231kqQPK/ApNeHd?=
 =?us-ascii?Q?zorKAWIOaPmsIgWMsvoLGw5fL6sW6F/3UfOyA3ftChZPNWq576B9oeOQtJGL?=
 =?us-ascii?Q?JM1TElRGtD7DY9kE7yuP/KnPOuzMB3g5+cRCQdMhgS9MVt/CGyod/63b8gp0?=
 =?us-ascii?Q?2mhw++HEAcXJyzE4rJUrOHToSxImX1SH5SCbv2TJ/wIqWulHMKX1Ps1+dOr8?=
 =?us-ascii?Q?62wE3UlQ3WWQnh5E7SrHf7OVNxSTZfanEs9j80qc2bRP8CLl6ybP+Ldoy9dK?=
 =?us-ascii?Q?EEqRUj9Mc6PcRk01AF17N43032lqb8qxUdy35mYpo9C1j0+Op9UXdhw0ZJnp?=
 =?us-ascii?Q?SwUPXLBK3qYuuyOvu/cjKL6V6lVXmLlPRnB3WNKVrM7sBS8Sr4VXgwVRt/f9?=
 =?us-ascii?Q?EzHfcUoUG6gVeOEo1bf7TB4h8/JSV+6Euh5YNYbCMDQTFr2Z3rg2qoR+CXSZ?=
 =?us-ascii?Q?M7qJhG869Qo/M9haY5m4jprDB33N/CzGmO/M9t3kLvLyJoQutGfezGpG+F00?=
 =?us-ascii?Q?+zp1wGTblkW2kLwFDa4shsmB2NQbW8W56qDuDcYa4mLZCT07TeCseuHSdKhD?=
 =?us-ascii?Q?yu7ccJEClFeP9+Suh2Sl73nu1aI/ZbFSD4zuniJV+T3vuS9ZzB4zYPLMonQV?=
 =?us-ascii?Q?lsBveQ46brrXLp3szJZ9ytnbGQ9qaQ/nYCoipD4q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 179a128c-672d-4d9d-2df6-08dc192ac21a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 20:11:01.8505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bOEXf7aRLub+aj0eGKrfMKLmnWCt8JXHXdIMD+tajSZ92pFyNQV67xNa92/qgk/a8NBF5DOiJIx2c35jANMH2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8565

From: Ran Wang <ran.wang_1@nxp.com>

Fix DWC3 USB VBUS glitch issue.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a.dtsi          | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
index d471cc5efa949..95e2057d9213c 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
@@ -809,6 +809,7 @@ usb3: usb@3100000 {
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
+			snps,host-vbus-glitches;
 		};
 
 		pcie@3400000 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 116fa68e13ac4..fe9093b3c02e2 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -501,6 +501,7 @@ usb0: usb@2f00000 {
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
+			snps,host-vbus-glitches;
 		};
 
 		sata: sata@3200000 {
-- 
2.34.1


