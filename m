Return-Path: <linux-kernel+bounces-32613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E53D835DF3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83B86B20F72
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6886339AE2;
	Mon, 22 Jan 2024 09:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ea2XFqNP"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2085.outbound.protection.outlook.com [40.107.7.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36EC39875;
	Mon, 22 Jan 2024 09:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705915099; cv=fail; b=njyyloRcPaowg3JfcYIohqUy8WniOYDVwWKmlKU5kskm3FK8L+Hq2dL1BAnjH9qPX1HFw6LP3AFm58nVd1Kwoj/pPuk/41awGcED8qSInZkOM7WwErksfF1Gtst+qaLzF+ybgDB5Gu7gam2NgUvpbSNl2udQ/XL6nJe91rXVYlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705915099; c=relaxed/simple;
	bh=UPloQvOorZnsiAAUZlAgBda43EgqRwSayb+zyHhfzQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EaNDKESfLE8sh4nGRqjoq/ClvjVUr0zTAS0WlK6ZC5ypEE50NCIDjMWfZqc2+W0yw4BH5fqGN3pE9ODl8V4utubmSCmr7xsSTdyy01zWkiFQkzuW18tlykY6pqKrHti6z9XxUeRxSN2vSQFASMeDXVaV+UNi6Fq0LjDiJ7qbZ2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ea2XFqNP; arc=fail smtp.client-ip=40.107.7.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XljCaCookGXnQjAzJa9uFZzHtcI2mYwtcAR0y5FKSl4E+M8xSElVgB4B7kPFqSVE8NOY7SSm/LxTVvwSn01dkxox0ySnjcZP+GQzNy5XaIaRAonSPfB26Ca6hBjUfV7KDDXLmG0lG9VyxRGcIz4pKJi2SKiAhFNJ9HcFhIBl98relCyaikmikOoWNZlItlj65MC/rIzvdggoT4h++tKZcuZK968OQGnOBXEgfzjS+K2+oBLO5MSOBMS+uG1ljxfEYfHya2aTbi81jSifKCcQmMsFdVfrAtfuB7b0mq+AJ8qm3Gu4Rn7rYS8bdCxoDHU/4qXeUSSTdZF+eJmGq4ZtBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDqPPZ9mgLpyENL59umDrwFTw9fASsT9OOHZ+T6Pj/M=;
 b=mtGoqrwqXCRU6JiO30vpAtouHRjwckaW5U8FTkICC8ViRoEuEunV2lL+bZ3QdlNV4gxa5Hl3bxx5DTm4znwDFl4qMkzu1fx/IolpymY9V5U2sgfMTYkfYa54zN9QTi8BSLUEHMCvnRyw8Ap3nzdDJlGfq3DVHtjgt22PZI7IHDknVxZQtdmXFj4Q5soQVnSmg6cFewzNwOjjho+xZlpB6D3obdjq2oPb4iXb3uVlY/5EdXA0UDbvfRKRmTXvmuU/Q86mKl66Zrn/Ro8oB9TAJPuuLOanhrDkiRbchi0HwU/w1rOPNkgcbfhaUqlqsweMUC7B265uebEnjBQQRwXuyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDqPPZ9mgLpyENL59umDrwFTw9fASsT9OOHZ+T6Pj/M=;
 b=ea2XFqNPFXLbFXT1QYfe2qItQuakqfsG5o/uvKCMFreIEys0XPL54mAvpqlc8PkRjjScVkLR3jAFBY+uboiw0Rm6jHxT6BtHnvMTsGhURd31SZqK4D8NDuuHGz+T/RFmrxe8nhnggIB+L96NDEjcoEPlxKX7+O5bIu2DmBYn+cs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7394.eurprd04.prod.outlook.com (2603:10a6:20b:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 09:18:13 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 09:18:13 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	linux-imx@nxp.com
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] clocksource: timer-imx-sysctr: support i.MX95
Date: Mon, 22 Jan 2024 17:22:25 +0800
Message-Id: <20240122092225.2083191-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240122092225.2083191-1-peng.fan@oss.nxp.com>
References: <20240122092225.2083191-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::23)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM8PR04MB7394:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b958ab8-ac36-4551-ca74-08dc1b2b0f09
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HV+bJCqomzv6KaUd7VRU5nhBozCrewlLbVk8bsk+1mm8+iyI5N+aYKoML6nrRk3Z1w/sjIFiqOw+IOCfe3ebow2V+44fuo4xMUSzw7lX5hlye4zDSQQ/gfhI7Qfd3AHMxFJlmYEGDyeXJjfaVzMW/eDb0t7vp1xBf2CaWJuFirgBkisg6gnQrRNIsJwq0/bgh/AoKMHlY1oDxhKsobkr+5FotML48qeUHBOta82S7MPdp9r9IQK5l2Ljcf78HfgL33Fj2tPtdHMthGVmfWRbL3S160hvK4zL7yby1oZhF//C9AK3LmGMtGcOFwP4RDZNWkX+MgCGxyJRoVb139UF/Qt5EHgsSi6WUfEP/dL5341mNxM5AVXuPgxak5oDexuTlgw6FTkFCo28luNw5gMPl71Xgt+y+XEIirJfjxQbg0+upNsvrqdJpsEQikloeoyONyBMKLnMTyVWuEzlT4WpZjIN830ewNeeff8yiqeOmeCBr+AVWDQRfaJp0GZi/XhYGm8sLcYKHpjXNlJ4kN49aVysyiu75E/nKgUX4n7bRIO55aseQdpHb6YSbOBypCOQMNP0GCifeuGKeSId8TECB0DFz07TNeIcmIqBf6y362YlBhsEgPeOnSWDltctq0Ok
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(366004)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(6506007)(26005)(1076003)(2616005)(6666004)(6512007)(52116002)(83380400001)(7416002)(5660300002)(2906002)(41300700001)(66556008)(6486002)(66476007)(8936002)(8676002)(478600001)(316002)(66946007)(4326008)(86362001)(38100700002)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GvP4pdXv3pI2f8Yv9Cj3sfe8Bel4mLQqCwhwxSwy/v40VmQ4BfXvDrLuXPAJ?=
 =?us-ascii?Q?wMIrmnjc4bjAq+Hb5jKzZoBXo8Q1z6eBeNQMLpnHXhzV75Z/E+HsVgobE513?=
 =?us-ascii?Q?pj7WOU1goo4Q1Zdbx9hckNtvIHCAN0e1MSix5JFcyl56ol9sWLj2gEkFfUt/?=
 =?us-ascii?Q?nSqJxQzRI78S5XVqbJLGE9fvYIRKSfTv+36zhH36R0Iq0x8ebVKBmTSZv7hJ?=
 =?us-ascii?Q?NjPNEYtkYFsexJ1cFscgcHcQt9VCuqZ3UJDtLHa2dlCix2Gl59Hzi5GQwJSG?=
 =?us-ascii?Q?xcce3LHxnfD0tLTQdJ2+5t1XU4eoazbNauYy1sPYZvv8vq4yc0259a3GAByt?=
 =?us-ascii?Q?/8tD0VjhA+yT5dlT/yavgOP7KhZw20Fs3M7W/8V//EaCXUl0T1dD8qjUWONV?=
 =?us-ascii?Q?zTW0OdRgMQ6Pvlew/JTSEHHa8KV5oX3YtJY617AHgc+qSakF5kDhIVsKciFu?=
 =?us-ascii?Q?1frS5ahfAp2dmcr2MUa3iYkqQT1sGRvqUsaZ/eJ0H70y1nDyxz5TONlHZbxP?=
 =?us-ascii?Q?nidpAlmVk5pqmBC72ID1Gt8XP9m3AIyzap+Zpm8bctFsS8N5WBHT+nlE8i94?=
 =?us-ascii?Q?s3h85ZuN4e7WxmQYXHVbp4vPu8usJ4aftAk95OUZtfJDPCvXK63gAKzEonQE?=
 =?us-ascii?Q?lrBmcOF9N5vG0+DdmGz+65gyu4fKiqtx3V30Q75W+kEbXiCFLOcdeQPRYqld?=
 =?us-ascii?Q?oqIwkaZ5/ysnK26RRMsalUv2OGzA/Gy9YIiDnotgloey+7ve0Jgvd61MWlDo?=
 =?us-ascii?Q?azee4jETLuEw20qWoPXdqiloIOWc2nYKFIIDUwVcfAfXK9+ywLID9GT4FY+H?=
 =?us-ascii?Q?d+hWukh+vIaLx2nfVdWcaX8LpbnSHdNq1yraGadu/qxDh7T2b4gU104jh5a7?=
 =?us-ascii?Q?wM2l6nJRBxPsRQNFo7gJAW/3IWcCq7WITFje/+ZY+X0KPydDReCFRxq4Twnd?=
 =?us-ascii?Q?dHjPf3m46LnPO66ruX/aS6rTdWyGJTWYlpOo9r7dP3AsBCVNi2KIsFP/BLmG?=
 =?us-ascii?Q?hVA5U44+tx3jhzONyl+ZotQL6zvun+OyHbHl9Dq0zy6PD5itvlXpz7rWHUTB?=
 =?us-ascii?Q?IQyXYPQIo0yokq1XlcxZvZ/3fbBeMpBSRMw27BEGkF4pBwqxbuf2IHMD1Dt7?=
 =?us-ascii?Q?A2mV7+wOM4BX6fXyBvU/C4FV6OEVShBw95iY0gYSkFdIB7aF3arVwI2WliKj?=
 =?us-ascii?Q?Qna+5yN6+nLavbHZcMQhGFQgVB1n2NbWmwSY/TiiAQeOBrPe7/VMrc4iOXAk?=
 =?us-ascii?Q?KPH0bgXlYsPM3o30+1WbJXAq28QvUHOkQLJslw5LgfH0cKgD850rI6HTx08U?=
 =?us-ascii?Q?QFKzGD0I5sSRQOcr3ENSmeLh+fxTXdBu0FJhjuF/bajjYfJpnaUWVuzexW+o?=
 =?us-ascii?Q?DJb2S3fipRnx59akmWJmqhyuX5i1ykONWTPrl0dlNPaFuSZ2uMSQiHHzW0su?=
 =?us-ascii?Q?egTgyJ/8VdMO4kzhDMuetm45hiqkipv+4m4kfM/e+c8eGlENxgyAulVs/POL?=
 =?us-ascii?Q?7Rl+GRlF7qcNMf8MRJIuVNjV+AnmmuPjcYVSady+IMP1y3LZuZ7aoQvrQrQp?=
 =?us-ascii?Q?f52xqedGGRqNCNpNTCb1Jony/XZeUau0BtlnN0rP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b958ab8-ac36-4551-ca74-08dc1b2b0f09
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 09:18:13.2991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFUeAJBhLjKq8A9/Aeuqer04bV64ZlXu1Melr/7uqVKFDwAsOWeTa35ur9gjAvov70SxTDusPN6mUW3EBLE6fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7394

From: Peng Fan <peng.fan@nxp.com>

To i.MX95 System counter module, we use Read register space to get
the counter, not the Control register space to get the counter, because
System Manager firmware not allow Linux to read Control register space.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clocksource/timer-imx-sysctr.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-imx-sysctr.c b/drivers/clocksource/timer-imx-sysctr.c
index 5a7a951c4efc..3d3bc16388ed 100644
--- a/drivers/clocksource/timer-imx-sysctr.c
+++ b/drivers/clocksource/timer-imx-sysctr.c
@@ -8,9 +8,12 @@
 #include "timer-of.h"
 
 #define CMP_OFFSET	0x10000
+#define RD_OFFSET	0x20000
 
 #define CNTCV_LO	0x8
 #define CNTCV_HI	0xc
+#define CNTCV_LO_IMX95	(RD_OFFSET + 0x8)
+#define CNTCV_HI_IMX95	(RD_OFFSET + 0xc)
 #define CMPCV_LO	(CMP_OFFSET + 0x20)
 #define CMPCV_HI	(CMP_OFFSET + 0x24)
 #define CMPCR		(CMP_OFFSET + 0x2c)
@@ -22,6 +25,8 @@
 
 static void __iomem *sys_ctr_base __ro_after_init;
 static u32 cmpcr __ro_after_init;
+static u32 cntcv_hi = CNTCV_HI;
+static u32 cntcv_lo = CNTCV_LO;
 
 static void sysctr_timer_enable(bool enable)
 {
@@ -43,9 +48,9 @@ static inline u64 sysctr_read_counter(void)
 	u32 cnt_hi, tmp_hi, cnt_lo;
 
 	do {
-		cnt_hi = readl_relaxed(sys_ctr_base + CNTCV_HI);
-		cnt_lo = readl_relaxed(sys_ctr_base + CNTCV_LO);
-		tmp_hi = readl_relaxed(sys_ctr_base + CNTCV_HI);
+		cnt_hi = readl_relaxed(sys_ctr_base + cntcv_hi);
+		cnt_lo = readl_relaxed(sys_ctr_base + cntcv_lo);
+		tmp_hi = readl_relaxed(sys_ctr_base + cntcv_hi);
 	} while (tmp_hi != cnt_hi);
 
 	return  ((u64) cnt_hi << 32) | cnt_lo;
@@ -139,6 +144,11 @@ static int __init sysctr_timer_init(struct device_node *np)
 		to_sysctr.of_clk.rate /= SYS_CTR_CLK_DIV;
 	}
 
+	if (of_device_is_compatible(np, "nxp,imx95-sysctr-timer")) {
+		cntcv_hi = CNTCV_HI_IMX95;
+		cntcv_lo = CNTCV_LO_IMX95;
+	}
+
 	sys_ctr_base = timer_of_base(&to_sysctr);
 	cmpcr = readl(sys_ctr_base + CMPCR);
 	cmpcr &= ~SYS_CTR_EN;
-- 
2.37.1


