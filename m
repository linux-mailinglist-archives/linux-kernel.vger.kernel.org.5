Return-Path: <linux-kernel+bounces-43456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5E3841416
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F0DA1C23BA1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949417602C;
	Mon, 29 Jan 2024 20:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nAtHXvRn"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D1976037;
	Mon, 29 Jan 2024 20:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706559415; cv=fail; b=Ed4AoCvUsvyfV8GcGFqr2rvzVsuYZRKbpKBQeRJRqvyZQnZdQJU9/0U5ZNXNUvGoVDEEZl2OMNF5qZufBzAExP8dWz9KNHh1JQSU4xNgHnQ6TpWnxWWLqDjUbtwH34CGpk1sFJLc1d65hp6u3DXxBGPWR+eejMAiHlv5A1jnkeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706559415; c=relaxed/simple;
	bh=IELaxGkuXrA/0CI05EBk10HQDP4csUyqblj9JCSwjss=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OYjjpxZwUB+DuPMo/YODYl156q2FkjiVhBhK1bVruaSWD8iRJPr/3pIAj3X6ruhKNUwZ5e547nv1HR1L/nvotAZ8RlE6ayBz17uRQvvY1SRpCJbEWT4iWwuG/XQ/VLXJ2VduMgh3e+M6124W8cjXWnjLq36Ut1h8DANQFHJeH2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=nAtHXvRn; arc=fail smtp.client-ip=40.107.21.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXfuB0Tj+M8Wnk27IoZm/lko8CicBmwWdxGV70FA2SjwZD7qoBf/8EWzopkzO6gdjmb3YM/eJR3BpEcORSAWk6wWvz/w6AR7LdO8gK6VC0nSq22okOgL3KDE0ehVYl2bRU7OKuH34ghLqIxCpxXapwpUFVHRmLZq6mUoyTvwHze/ZE/WAxSENqLFo8NIW8LIgIpNgSNFf91tcTo1wLFyigqfU+IbrKE+I+/+txPKgPtT6I8cISxk9dowCCewGcqAYRDtJk48rXRRL+JlcYwn8jHw/VCk1L5ztL5KCx4sjcdC5DZrBWADGJPjbvEMEinRZnICkSAe4849f7LpsqiZ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fkg76ojnKnFqPbF14w4K5zInMqYT7yV3UTcezgehYMg=;
 b=jhyK26R+0IrUV3z7L5WDqunCl2INcbOZEz/EKH16j/JD4c0qITYOXA77Bb9TjQdw8uNMVGi6uqXlPZrSis+CuxItT8ScFHmmRGKJG9Ge0ilpThJFqwqEdnciwEY1ncH2PROKnncSjwstp9ilG84ThyHq3dKZMk6B0jd5Y8xB1hXyeObfc4ePKpchKxYDz15pyHFxnV3iupe7mz3nT1cUeVqpwL5vt3FloEw1mCI1hlZX+kkymjobXHQI/SzKj3ZnaK8RpBUK1VsjYdZx8jDWR25ym1khyPey+Lj9emG6HLUSDnBAYu+wlIypYkIKCjDrfFYSQDgn/T5LOMbo3HAI3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fkg76ojnKnFqPbF14w4K5zInMqYT7yV3UTcezgehYMg=;
 b=nAtHXvRnJ5KCq7i38Pzq9b168+2Lw3woSvvxErtH/SkVzBNbFk19O2fUSeh4vDx8KnVnn4M0sos2XBL9ZQuDMmn8nKPYfNjHIJ1Nb9RHpltsSx+HAjj8GuldgQ9KrvYEOHWyT7w+aUoz7TPKB9MlWSp07/tQQHgso1r0Nk6OYQ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7213.eurprd04.prod.outlook.com (2603:10a6:800:1b3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 20:16:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 20:16:50 +0000
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
Subject: [PATCH 1/2] arm64: dts: imx8dxl: add fsl-dma.h dt-binding header file
Date: Mon, 29 Jan 2024 15:16:31 -0500
Message-Id: <20240129201633.234255-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0150.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: 634cdb25-6c82-4aff-2a81-08dc210739cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sRFf1M5e7nLBwTGgP5uIY3H1ljipYqxo159f/e2Ywtq+zEzNTRSKxtvSx+Ybeo9eez1TQsYWQQTmixzV4YybTdLkDzSlf2zZ+BLHWOJbSw+zHGGzozn1eNQWs2nK7BF6Yr++S4vAMaHG9orH96ORtWIw9eihTZSGXvbPq5e+rMdrKUjsfh3ijT+FRLS27BZ5jGDJ/iRrmDoqJMBXDs5dm3jw3kS45wLuRFWc1rcjrcWVmaeBM6i2i3hHEZr93DPTmy/QirG8KDX7KJKgHFR0zlivwYwCnyCbTEarjqKIlD4fuoxqSsOpm2Mt98ZUiJOkwMk4osTDu410QhqKJ4XLht120pL3ccumPVnYlabWdE3tUWb7ooNPOjCZ/Vv5wDSIBbximPmF8GryTgYj5/pG5ZlCuyKZLSoHj2U8Kg/8ekxegU0fCQ8TwVKPVNZKn1znO7lzGq2rWsCK4FiTM6e0N1lfJqIyoU6hQoj53wpP80/1WrbjtwStssacn40gdN3JFWV/9J+oCVCG/4ZsTrSGEx7FqvxV6jscNIDDPvci/K0IE2npAIs3P8FmBV02pBRlowXGnI5iEeKJD3JSSuLpWlXVrbZkVvzw+V+SdPwQFVSnW5I5IthMvL+QpY+HhekPmLVyqVgramvRj9ooL7OeB/bG5OmyAZiA7C1ymGdpIYM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(376002)(39860400002)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(66556008)(5660300002)(8936002)(4326008)(8676002)(7416002)(86362001)(4744005)(110136005)(2906002)(316002)(38350700005)(36756003)(66476007)(66946007)(38100700002)(6506007)(6512007)(478600001)(52116002)(6666004)(83380400001)(6486002)(1076003)(41300700001)(26005)(921011)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0m+7ulGxidi3km4Ywla4vd8yD9iGmAa2m2VuxN/PqU8m0vDflhXmGqzKB8WH?=
 =?us-ascii?Q?a2Gs0BFAdtbpMF7drIpMIpVqbZOjPErbjl7AC6cRXgqzQqx1YJo/c/uEjbbp?=
 =?us-ascii?Q?8C43jDVIMfHyANrsZeNphpZ3KymeO2VcLwfZLwGOCva6MWUKezkVW/tCwq1s?=
 =?us-ascii?Q?J8gns2D6T7pKNo/lR1TEJ54pCsH3my0QU1HuiGbJkNkW88R+orZ1pRr1bSod?=
 =?us-ascii?Q?7cg/ShdGTbjou9pwM5tIWJZ/S3869EikJ70ofzPWpL7zOG49vLRticQLfohG?=
 =?us-ascii?Q?Cl578VfxrCHZy+dnb4o4hJ19/799PcLwi18WvpfzNwM+Xs2gZDY6tRHV4ABs?=
 =?us-ascii?Q?dz/2HOs+4m4yvFtHH5TOcj60jJ9+5N3JGqyLDZxk9QAOFUjgZf1cQ89X01OP?=
 =?us-ascii?Q?BTWw9FTGNiqF8KaSo5NKIGedMTJPaUvaFN+WJZMY5Na61f3ueFqDHEeS1uz1?=
 =?us-ascii?Q?nvDN/FflvzoiCUjofuXMyKsvuPnHL0rQr0/qliMOPyK0HWeqgwqMCjBP76DB?=
 =?us-ascii?Q?dr5An4nBVbDzRI8P5FyZVJNfQrhHWr93w+ZKIM9a2ny4t2DySQKdrTkzptA4?=
 =?us-ascii?Q?AdcUzbtB0ICv/8jpTY/Hn+bmjmJm9KzCq2AIyCsiYiQrmks69PmN2FQcmcqd?=
 =?us-ascii?Q?FbsSc8qnXszJtob3uNKH2tmQ60iwyXO6FsrzviKheDEcvjJ3jib5iLsLrnBX?=
 =?us-ascii?Q?uOLCMAR2C0Nd82LMRs9V+rj2IOfe7gNffSXOqfLD+KZqFmOo+8FlwD2VE22Q?=
 =?us-ascii?Q?7KfwaASTAoNvMsU+VonO2/4Dr1dXV+icJ1L96vjRiVoPdYx3YyemhOqpw34X?=
 =?us-ascii?Q?Z/5z6iRK0QJKem33xyvKD3ia4dfF4p7hsQvhnufEuYTJz+UjMeaf06X8yEoo?=
 =?us-ascii?Q?8BAM4Z5FPSrcNByUI2rJoDY5LL6Oxb+ZYluIOsx0mmvmciTbPiyoNB26VebA?=
 =?us-ascii?Q?31Dafk7i6xRmIZaan17bFVBygB5Nghhgp6PCj1pcgaXWuvZGkAqW7uCnJHsp?=
 =?us-ascii?Q?3ikZ+F80vGbrukZ00vj8k6v6NpFMqDE0u5GK7zwaFBAoMUycQ4NqhWhwKHpf?=
 =?us-ascii?Q?YU8WpV00Usencg0n2Ue6EN3rvMiTCAIOZ+BrMsj6LZORv/fluzIjoGY/ijbE?=
 =?us-ascii?Q?YpB7f+Idh8AIpAIyxfzF/r3pQpA78PRMq0+OnzHVPoyQHxc1KCtM0oYpsMRY?=
 =?us-ascii?Q?TYKwzQS5RvK5nW79us+7+J/SH9Keyvs/LgU0OjNQ1OjaaMnQU9TSAGcLzGoV?=
 =?us-ascii?Q?QCpZdKvPPQC1V4/C9WpwtY1Ji8DqzFUIFvVYmTJxF7Zh4Z2C/C5+biO5P7nG?=
 =?us-ascii?Q?JtYnlwdZIFQwCdg6f3nZgCfT1VNQK7BsXLzgR06JfHagGsLOAjbgZ72RN+gM?=
 =?us-ascii?Q?F05UTcF88ThuUvP7VLfkOPSNgLNgpqzHSoHUuent10/UXhrSef49WZ2lze2C?=
 =?us-ascii?Q?VPhUUqJd6kZynipP3f1Qwffn4/re6WLtw615CdKXXHPX6D2JiTS+XMMS3d37?=
 =?us-ascii?Q?FqgduyxWuOq0WWKzK/K8C5ctVRBYiA7G+GS86d+YrFVNJab43/oi5wOtQ0CQ?=
 =?us-ascii?Q?AazP4dUNuUUL8I9YwJEEPw9uEgVgg+uDscgXHRC9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 634cdb25-6c82-4aff-2a81-08dc210739cb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 20:16:50.0624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wh4EmD0GZJ69ziAYLn2P39TXewz8u2cJwxaLB5c0u59uisBtyeLE2uHhtePWeFOW3mooKnV6bxa5ldD5i53prA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7213

Add fsl-dma.h dt-binding header file in imx8dxl chip dtsi file.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
index f580eb6db9a61..a0674c5c55766 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/clock/imx8-clock.h>
+#include <dt-bindings/dma/fsl-edma.h>
 #include <dt-bindings/firmware/imx/rsrc.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-- 
2.34.1


