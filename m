Return-Path: <linux-kernel+bounces-32596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B82835DB9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A4828740E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356F139856;
	Mon, 22 Jan 2024 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="B8tEs1gy"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC7E39840;
	Mon, 22 Jan 2024 09:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705914732; cv=fail; b=qYScOCrV+e9bmY/SA7d8FbOVcxvnxJPmIDiMQG/5lkWAVFqtV0PZAt3r1VavOT7xM22z0vQ1onYaJg1/Oi+TWdzBwJCECu7M6a39vviMhAR8NzNJXth0k3nyUdzJkiZeMkdBD8r66Mw1tgz+my7EVSSfkQ5qfpcrVbmWmlP6khQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705914732; c=relaxed/simple;
	bh=Bwiv8coIO7FMMbRqEfGmDCzwUpR3gkpmTlyS8dvghHk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=cYzQU0pIYcT1br4yn0/bZGiB6oH+Xqi6X5laH3Y7MoN48uazOvCd4myr2v2vtzrU8Bx8lp5N95akeMLxnXoPZVFvqlZBIPBP/zvPjpKkgWvhArpmJb9s7H2fi+BX8OrthiYK1MdmgX+rByH37Qad7LEHDTckFt9YjCzxau5Ktek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=B8tEs1gy; arc=fail smtp.client-ip=40.107.21.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iC/AbNJJzaUoHvFqOgEQLcSB3yOnsxODBR1YbomOAt8UI3b0KkyyjlNbCC2o7DfNel8Pz62cHoCVVpwavd2K4gXVr6JhSeMWuNlxEON3IY4a1Umc4Di8xHQKanWk+pncJ7d5E3idkHU0LcX8brqASwU+KsGfsqEIcNiDN8wWdVHPbwVpnOur0l7ifk0joxu3QGHIgY/7GGyb4RLn/7xKSBZ7tK0KNSi82+oPNioTdnsE/t2+1aJtlGxbpVfruBpmM+NqAnTKZB4yWZNQ/3uNWMBznhQ0F5tT/7+Tvnnn18JwPTiCoc7nzpGbbxGAeRl8vyYmpr1hvQR04sR5Zcr+MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmZ/5DV9ibX9URl8WZpWtNCVlvrbEDYpiZA4VVs/voo=;
 b=YfVmM2bTY0MvgQefZuxlp5tHN81MIqHvWweg7Xf0t4c82xlWt5jccXCcqECcW1UqkI3AIJBOzxr3HW9DNBAiDzWWsVsuXPdarn1rVgBj+mVUSJkQC4pG2dpVSrA+QuIZfq/gFe/4RFJ4OeyadTMMIc1VZxK3gxxl67/nlaoNE8c7lGW79gLHYISgQ1leXvvETkjwzI8Jiv4HLzx35z/zWiCaAqSt5N40MdmW4kGujiJUWM9L4buAjndv7Z1z+H+R7xvv6qH+LjvoqWRFhROnxvnywd/b1OPLWBwhkzf+kGTNpcuuGDYK1Mjyw5SoSr7jH8p35GDbb/TB77NIT8hMuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmZ/5DV9ibX9URl8WZpWtNCVlvrbEDYpiZA4VVs/voo=;
 b=B8tEs1gyXfx0hX0f9lQzF7/nD0HTZ/vSeLsHZR25gv7ft5qepZzk1TZGaP9WSjmToAmbxgmZaoSxH0NMHOE+egRhFBTmiD/FVYzbrL62AJNIqxs10zpn0P8tgjTRdMq8oazONGCaG+1o3vAFok9sGiYwJUp+HJDAnnbW1k8KVwE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAWPR04MB10056.eurprd04.prod.outlook.com (2603:10a6:102:38d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 09:12:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 09:12:07 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: ulf.hansson@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Cc: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: add i.MX95 compatible string
Date: Mon, 22 Jan 2024 17:16:23 +0800
Message-Id: <20240122091623.2078089-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAWPR04MB10056:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b01a4db-77de-4ee6-954b-08dc1b2a34ef
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ik4NCUGwiAu9/nAAdVj2vkhVEAjqAQE/0hvyVaRrgm3kL1urAnKWf2bc3d2MOmOr36Pdb77xoZQ2ydfp+QvvVRP++/JJ9/B7gQkZwG0U2oW5P7mNEB10xLl0nTjnYxRziNXpn+0vx22eV0QzlAoV0fmCguvOBSeGxI6tWvj+ilyr0gGva0DQYvBVT1DZtaILG5vDYt36n6vxSaqHu4IPDtOenZ0lPOxV1NIEEZ3nYEIhRbJYv3loMp/txH/pczXurVljN+yMMY9Y91uVfXdOUwku/vhgCVeKhTPWl1+7B1MIpHKIumYbljpeH26QcvkfcXv+jNp1oUaLVlXPdwS87VaVuiM4244dJyj7kvAmVRdx6A7gvaN1MptWcgRkdUsztZmnEG6uWATeu98TQ+lZE8Di7VFnQnLOdtpEa1rR8yYlTQJ3rdPDnXYAt8KC838MWS0zx3Umj0x6xDAjvN3qlDB/hEp6nPPV73yU/h1/Lmtyg21zE8ASI4GFEkvLcborOeXF21m1wLF/gvvjVO/qmkyUY/6uONP7/Cr2keaoJU9wRxVZ5+tV8wIz0qcoYLUFNA3eloM2LabxbkSsqSBvumhjCKAnDo38p0LT+Nlo4Uh1SMeYG3W5geboWBAWRsml
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(366004)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(6506007)(316002)(6512007)(52116002)(6666004)(8676002)(8936002)(6486002)(66556008)(66476007)(66946007)(2616005)(26005)(1076003)(83380400001)(41300700001)(2906002)(4326008)(5660300002)(7416002)(4744005)(478600001)(86362001)(38350700005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l/2wJ0ga8OsbcSmb98MDCnC55I9IBZrnce9PEtlVVU2U5xnyJWJxExe3e37m?=
 =?us-ascii?Q?hmfKQSElqniu8lnCrHi+r0iv7EVVAlyG9xv061GLkZPlpy5T+jSxPuCBkYMv?=
 =?us-ascii?Q?UIwrStbsyWlk1VF7TBVQ4wx2xYBWPItTfAbOQek7371Ax6q22STFWL2F04Ef?=
 =?us-ascii?Q?OLRcAhcjcfAruD64XngfGjjGMN6dJWxnOY7Rdj/bZl8pHmTYervXd24vXxYR?=
 =?us-ascii?Q?9i2VebfJJDbbg1ATUG1i7kFn/YMC0ZMYuRYZpPXy72uHjQxN5EahgsOr+3cC?=
 =?us-ascii?Q?dXf3m5BdpLUh0m0Q0sXI+RaiNVqjrGKPma3Mq4aW04+1sq3gkKlVaH9d5DeU?=
 =?us-ascii?Q?DQJ3Xnf+lf/ewtwsHYLxG9UJTobzX1FXuUm0YynXJOOAotu6ZDvMIIYHCA/Z?=
 =?us-ascii?Q?xbnUGBaecG8uJl1NCnYk2vc06PJSsPxRnMZtn9uzLrNlKjtGsErCKStC76sO?=
 =?us-ascii?Q?zlvXepLwzXF/TM0oRC+4uTcqMNSoZE0vc8teVMe6fBHqqB3pTKdITey4Of1A?=
 =?us-ascii?Q?1zs6Z/D9r09ntAzfjD/DgxphwhXsgqLmn+81d1wq7wHBW7o6h+i02cCZpQtD?=
 =?us-ascii?Q?CqLHATOOIGaFpudsCe2YOr2ddiW6YT8ukaiz66xvcLcMyM5A6MLxJM1PcF34?=
 =?us-ascii?Q?Rp4TZY1KZtHDBCt8p7LMnbgRoJVyxzDjIWFHqaWrlZ/JTYuYNoPzO5R/wZWh?=
 =?us-ascii?Q?XDmq5JIPpWdDtaISfHard6qTQ8bArotbK9N2qsrDH40Og3lPgB+Tbdjj/4VE?=
 =?us-ascii?Q?7s4XLsBh8G0DC1e8p78YEQgBX2CkwNTq1DVu4+9ywxaC2sLXGh50BIsubtO7?=
 =?us-ascii?Q?TH19fxg3pE3t6wv+bRB893GZw/hvGvOn2kIyagiNo9P4fDGdUAZ/6dfqzwvX?=
 =?us-ascii?Q?w3NjxhOnB/EKW/zZ/upMKSkMY6x0c04Ugz7Kwtz2GzqGKzP6oZB7Yt8Du1lM?=
 =?us-ascii?Q?x8WYFkN2jvHTEnHNN1xyS6x5hgolqWkQiRuRTl8U7vOzxWv6ZZhulv+hFnHC?=
 =?us-ascii?Q?c9bOeHkaMVGvEoTSFmUkBJZLJenuZxY8Z0HDA3fF2aXdZqKZjDFzkjU8r6d5?=
 =?us-ascii?Q?GxtztiAWyQk5O/hYbxEhzgeg3yxhc6x4tYPDPRwWQxi3lbKtY7vUY0dOHjfO?=
 =?us-ascii?Q?PMXtIEVUy81BRwiXDJmZPHCexE3Xyj05GqMRLXoR9k7sBUlCoD7rNm6HiCVd?=
 =?us-ascii?Q?6szvZV7jHBVyJELW0/w60zvLCkM9nPzgZgfP933Ir5tg8Pg2plhiWrDNqpbb?=
 =?us-ascii?Q?gRrF2GWHxSDxbF/KW6zPI/goUa2Z2LjMQ+DR2tDm4m6+vt1uVigtl9UBq5xd?=
 =?us-ascii?Q?iFIKVsUlfedF2oB1+9Chs+dO+uUHqGGjuStaCjd87Z4j60hUd2kGVraDLeVo?=
 =?us-ascii?Q?M92sz5hJeVJssUIOX83JOod9w3aGMnF/sEDM4D5/N0tkzdGCcoxumYOIxCA1?=
 =?us-ascii?Q?QJx0GCRMS1BDP/PYkSPou1M+i4qTSC1mCE6fxE0HCJbEPeN1sU+hSbcpfL4q?=
 =?us-ascii?Q?BBqDxxIsQJvNvLbw4PE+K59BzpcaYTkBEAmePJQjRSXsHo4wcmxwLFLSjO9j?=
 =?us-ascii?Q?8LJ8Xba6ylrLvThyRhDmTu49tFivzzpQCVo412z6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b01a4db-77de-4ee6-954b-08dc1b2a34ef
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 09:12:07.3443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vx6nOQGg1H9Rw+uOt1FInRkMweekVSeFFwTQRh7MxJB40akGvgN9nzzE/5SYaQT/lO4J7RaMc5mEtzVj7nVrog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10056

From: Peng Fan <peng.fan@nxp.com>

Same as i.MX93, add i.MX95 SDHC which is compatible with i.MX8MM USDHC.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index 82eb7a24c857..f3c5aa64affc 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -55,8 +55,9 @@ properties:
           - enum:
               - fsl,imx8mn-usdhc
               - fsl,imx8mp-usdhc
-              - fsl,imx93-usdhc
               - fsl,imx8ulp-usdhc
+              - fsl,imx93-usdhc
+              - fsl,imx95-usdhc
           - const: fsl,imx8mm-usdhc
       - items:
           - enum:
-- 
2.37.1


