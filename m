Return-Path: <linux-kernel+bounces-44838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 235DF842803
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BCCDB22053
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1D667E75;
	Tue, 30 Jan 2024 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FG0BvUeq"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E378C6E2AE;
	Tue, 30 Jan 2024 15:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706628368; cv=fail; b=bCbcky6qGCVErLb/pj9jqcaPRLbCG9Ja5pmKiu4T59N8Ki7vujXmwX/jFXh9n2E5nHBwkoL5NrR8phADDqk6gLDeQiiFEQQ21V+32AscZ8BHsR8sTAnkgFIt1GD71sA/sl5gCCKxI7JwuCC2UOHTAEZ26pzVfzf/xJcSZYNabKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706628368; c=relaxed/simple;
	bh=p9+HtBlv2Q3QrvvtnG4Cb0pt4SFmo4dLU2X2gYUQIhw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZEVQ1QSBYSjDKia5gFgmsKAmihCqWxQgOLxWBXNqbbO1ArVvM0Pq0FYc+vCub0vAwJkhC72JY9q/iZnEi6McMVRAuA2K43CUuOlizHm2LHpTpOHflGBtDce5nSdJz289XPz9SSXisAJhPqjRgLLEx3cAU+VDeRTSSWe/4i1Uez4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=FG0BvUeq; arc=fail smtp.client-ip=40.107.22.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFARw3rqv3Gbfa3pGNKxsqMghF1oBFAJE79dZDF7hkHZhpuGZ9ZqkchOVhIUR54HcjF1Rj0O1SnSQsNf7eQY549DVPDyWL+JeZ8hvJ95uxEMpUVnF/WWyInS11WbrdMC0htZrieHqIvl8SFFw/xMyf2sUF8ozCr9Rlf1gYKKXN8WF/Jv7ZWKwSOdYpAOtqn4lkxb8iUZrqqbEMOjqENKMUuZYnrD6zaOI1L5/C5ZtSDiJTXg+fd+GESRSvDu1dSe7ySL2SPstBtZsUtWgelUJF2QkSj7gTVldproxwnPAUwqSUXWFwdJxAG+RPypDUILPtNhJJ1x/P3OwwoINYW3eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nVO8ZWJ4c6LyQiCnl5TigprfJbmUdkVrG56RIwXn28=;
 b=i0cA6gXqTFLW2K+e4Bj4nIElyGO83FJrTNBh2+GiS78d/KH3M2uvPKIiJD1N0WrTh9y2pA6IN6NlFiiHwhMGS7OUbT7RYyQ/HGEQqAaq68GEoLQgwGkbe1YJvufgg/2icNH0NC+0ngx/+2zQuXN86LihguLY3xNbat4+QgZtx3sMcV+13U4A7mlNz6FaC5jVsMO+OoLbIrbYD/dGtD5WG1JQ6Oky6hNH6CBFOVxbc7Ku8+0jJaL0mhRznKOFlHAoTJ5FWaCfD189gfXis0W/Z19HJVcjjDgqNw0vJru32GmctLH7cdit7n0EpcbIDTqPz/zZ6GNZNW1DocrYFYKJLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nVO8ZWJ4c6LyQiCnl5TigprfJbmUdkVrG56RIwXn28=;
 b=FG0BvUeqpEDtoJTTStc/IsyfAvfxWhZXNAZcPyzO/HEiqvr7/z/B9kHUSfh2gbKoF+Hs/PwWDXt+AuMMr0uIe+hj9ngH+U+EX8HsnpWTl51OUdkJoRqEM0uxUDGVTXSprA9lHSai0NGkMs3aLZpnnit5VGyggsZmnCNO0zpgDj4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7404.eurprd04.prod.outlook.com (2603:10a6:102:8f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 15:26:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 15:26:04 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 1/3] arm64: dts: imx8dxl: update flexcan[1-3] interrupt number
Date: Tue, 30 Jan 2024 10:25:45 -0500
Message-Id: <20240130152547.272125-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7404:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eb964d1-fba3-4364-71a4-08dc21a7c57f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+cX4Z40zY5208/z7rhvH/tI2W6kt5xh8Kp+NIJ1rDko1RxcMcZQuOjM88OkqKw/ufGnh5B0KQ22d79GJDfZF8zbkwRRtkA1vXXjA0a8Sc3a4dpS3XS1u168DSmoehYD0DhOG/9sIIPKSg7C+se/ycn5OfaiE1bsw5bcwdCfSbPQ2Ro1/qtx+yLHmUfZ5T0S98rM4HNFHBPVetP5EDBtFXTz1x4l60VdPxfszOd4NdeO6BtrUjD66QYUFLptgU6RvZxlanuvqmgZyq/QkNtY8j4tu8z9bCFg4tpi1dWX6Fr1PXeolja6jI9WIRn2OdhQAhLF49+vrR979GkKopmDlMiOz2zPnuJL2ta3hpNc4EYFS8JaQaAIjd26SWV+ccxfo86J0T2NGRVY2T24pojM0go9lHwo+bf/CaRThuxNismyj1OxcRm8xGYlB6r093yg/FPPFTR2drIEEBi3l0a7L3lXo0DLlyeAuBk28nITnpdS5vtGycR0RE5kN/HvWDuaVVM/sQDQJwowSgWxLPAndpRmk9Kif3BwIYSRSPO60nwlHKMZShMvOWm5dEnplfOZYzGTUjsK6moKyA8jtl20osm0niFqpCaKW8SwbJEiSaulwAyxXf/J+WmsPoI5ERVvMr8qH5tx3dHILna8PK37t+CLWF6/tjaC1cREJM7vo2hg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(366004)(136003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(38100700002)(8936002)(8676002)(316002)(7416002)(4744005)(2906002)(36756003)(5660300002)(38350700005)(15650500001)(66556008)(66946007)(66476007)(110136005)(921011)(41300700001)(4326008)(478600001)(6486002)(6666004)(86362001)(83380400001)(26005)(52116002)(6506007)(6512007)(1076003)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qx4VTLM/U7Hb2u7L2mYmTDMwdpmcb/YmITpLCjIJpjnMwoBuZ3xnc1Zov+8W?=
 =?us-ascii?Q?Zhq8YyeHSrnzWFyvkm+QoGZQf/NSmoqnfT42oYuLdE8YNDLi33MO8WDQwXP0?=
 =?us-ascii?Q?AU8A4HEZnntsXQxWYQuv+OoNlC25ROYeuuUBNBnzzOHMFuDlEJUAo2RMvzaO?=
 =?us-ascii?Q?xwvWOPbrwTRKs4Gnktfu4C5vfSDStsI3lvexg78Vv+BzOw7aoN2ALZxiY4j3?=
 =?us-ascii?Q?PkqNlQxSCntL0i8JORuQJNOcjTpsfYm+5QK6oCqVD5jMnFfOLtrSh3sWxYSO?=
 =?us-ascii?Q?JqS+1ZN5JugnOHIWM9fRSm36zSPSZveJiNoW1rhcm0wvdD9jJ6K+D3UPL6jG?=
 =?us-ascii?Q?bVQMvR8TRSwOS4m6S2reQs//GKV6BIqLVBnUe5yUhmbsIdwPayg5PtRM73XE?=
 =?us-ascii?Q?qtJTsU1Tmqy/wMm5k4GorewBpe+GCYTCvmpG/8976bYPz+yabOezKcKzKVej?=
 =?us-ascii?Q?GR4/De5m7/AxWozwV37eqkG2uzqk6kWp0jSz2IOyIcHv72Bh+LsQBMDyqtkd?=
 =?us-ascii?Q?c/Atc/1REBPny5Qe8TrBnVvap6kzYp/BBxogymfq+I5n+kCsvXO5so2sA7JZ?=
 =?us-ascii?Q?CQCiIRPsRV8HegsUz3pN/RqTwzu9ZZ2+Fbqot5W3Ub65ZcciEmpqRRgarZuM?=
 =?us-ascii?Q?JmI/zM7M87yYl4CrOWb/wMNHAy5zDp5E/wBgwidfivrqMCup+EE/F8prgILm?=
 =?us-ascii?Q?CjI7CuZOyM8OdyJgJ7soEhn/eRss0V63T6CfK5DRNnUeRE3Ewj6G8LY2L8fk?=
 =?us-ascii?Q?mbE57i0uZB5oH3StSzdbS0xXpT0sMaZk5pA0kOCGIyTtO8XBMFZQav3CjFii?=
 =?us-ascii?Q?ewNx3SdlspzrKY7PaIqnMzERqU6w2tjBOhSzNQRR+RBxvYwY3P9HeBfgcmFT?=
 =?us-ascii?Q?4kcYhs5RhiTpwVSrdQo0dHTlEbtr1IZUArRD8j9k8cUqeCf1Lh8Hv5szwkW+?=
 =?us-ascii?Q?BKL/QoZhA4+Ljmr0atTRv+gQIdmtN7w9aMUGwCq9SfpBFHIFVnPiv9gnnNtH?=
 =?us-ascii?Q?kpVxPZLKniAkZo7UUy1aF42eYho9urU5BZ62008MzNxuB7BU8tW7FrBGoVvZ?=
 =?us-ascii?Q?PWynAQeAobmAFY6a63zh6y0+YrV/in0d1KJ10UG9fIlhcCk+WIYM8haJIDUa?=
 =?us-ascii?Q?KSeKTiqz6Dp1xwpjvSr2GNiQ/E8xLzVwixcmvx7y1X+9b5zbbVXKoHw/SFh9?=
 =?us-ascii?Q?hE+4IKYgVGzerdYMkhj4Q3FW8/WN++fj3aWeFub98GVAMnSFxZX5CRS8k9T/?=
 =?us-ascii?Q?NMajbAXKntYDPv4ajS628Qm7Uaf1CJt7/8/uC504sf58mOyuAAzMNeYhsJ5l?=
 =?us-ascii?Q?I4l+InftMqjn5YUohJWMoaSdiKN8ov71WyGo9P5kuFWeRmrgjMW4kZJ1qlNH?=
 =?us-ascii?Q?rBLRfZEpdbPHCUvUO3aD7lap+yBGY83yUz2We3T8KxkpQr8Z7KylteMWzB0/?=
 =?us-ascii?Q?V/UYD7Ax8PX26o1Orku3m9NJUv3UC/204EipO/H1RudwQsLIe7ah82GLqM2L?=
 =?us-ascii?Q?NxUTSvwKOjsN8zv2x0sOKE4bacHH76yMvdU5psCt67FDsb2FVeCrfKm9EOXK?=
 =?us-ascii?Q?t0+hXODdDxU3lWULJWTnvOrIrdFgWUHUCgEPsc9g?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb964d1-fba3-4364-71a4-08dc21a7c57f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 15:26:04.0031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7VO5bNI5SqIcJO0bYtyZvydjewRD5eYp3kTUaKR0vHXKbCCOM16IzU6v6YcNHkDcc8r1uJMPI1QeORaofwIMTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7404

Update interrupt number of flexcan[1-3].

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    change from v1 to v2
    - none

 arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
index f8fca86babda7..5d012c95222f5 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
@@ -102,6 +102,18 @@ &edma3 {
 		     <GIC_SPI 303 IRQ_TYPE_LEVEL_HIGH>;
 };
 
+&flexcan1 {
+	interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&flexcan2 {
+	interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&flexcan3 {
+	interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
+};
+
 &i2c0 {
 	compatible = "fsl,imx8dxl-lpi2c", "fsl,imx7ulp-lpi2c";
 	interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.34.1


