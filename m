Return-Path: <linux-kernel+bounces-32594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B742835DB3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C34B1F214CA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290EE39852;
	Mon, 22 Jan 2024 09:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HLAz7hUl"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2061.outbound.protection.outlook.com [40.107.249.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D2A3984B;
	Mon, 22 Jan 2024 09:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705914660; cv=fail; b=pUmWPQPuNRkHUGutMI8CtVmHsywozn39aNqlupyRVTyQLsxvlN8c466Djh5+4ypUZFdDBfuF6b6NRrNsdQkZ0b26cXXLdEQhUdOuI6Vy0WzO9EvesiK2k4dESj2+Q7JsKjQ3C0VbeoF7J2r58Ir5Wz/6+Deihc//iXJEC+YyB+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705914660; c=relaxed/simple;
	bh=Kta6K+ng6ErGiE9T73UPHor0RgI0f8l3DrvbeqiB/Rs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=aCSzUe1uo9WbvB5NwiINYp4shtKyObB738sQJVwEfUWi9JAAALY1VhN2f1evvfY3sK6nAiiyLfeuPqVMq+8Qb3VDA4yhek+rdAm40Sc21HUDkep+9lcnHQcYRQ1yXE9kXjP+Tu0Gu1kGMTuLcmIV3Yy9O/Kl56h9jSc/efMLoxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HLAz7hUl; arc=fail smtp.client-ip=40.107.249.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3O2gPxXa0CEtlAnPhBmbPdoWlpGjhPzChSMGsR3OzTjUjgXGIGfbZRao49QXtY+0pARvMjLJ/Pw7yicldopJL79uocj4VgNUjgo02UN7TFtOyINT4g+NQD6TmdQLlllj5c0syrfBJ9YM8d+JVnq3zQO3dLT9GzrS0UKO2PqaxsP4q5PGjxPBfkDq+EuFSF/e/axTWTBx6KWZZOSEC7u+8HC0ODsJryK8rr1jMBOmO/xMysoAZ00Vks3pGl4shaC3/po8LIBIWtMfFaZffNlmKZQh/2e/PJWkFrbPd/cOp/mhkjw83hmbK52BfJane4HBRve/ZQKFrUll0tPny10tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJoNmVKjPkpR7ZS/p5BpevuaTQE3Q/inE4ABfdKwaeY=;
 b=Uk4CTwuKsUvhD4axS1vhoFNEt/wJ/Mm8jbAFP7o25/R16djGRvyzsTCNUlWZl0K2IoxAdn43x9U52SMx2WUeqfYhmHAMGtGjkizS39HJ7Pvqd+MLV/WGmbZmxt61fgBGdDNe58/muQsHMJr3zcf75C6XaZLwn+Jvu+G6mx8feTmdoympmdWayR5aeddXq16FKDHaw3qpyqiAVXHyGQCeokUBbTgD0OuT8+SxIDmlvWX13wCuLakYeperrdGfVxeRd3kUT7DUR9E9S/JRnZ2hZl91XlF8Ejo+WHio3E08zJ/ZiPds/XNfyrn2QBHq92TSbE2aTTMLBVv9L3A0wUy7iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJoNmVKjPkpR7ZS/p5BpevuaTQE3Q/inE4ABfdKwaeY=;
 b=HLAz7hUlo/GuVlYvWtncrtLMVyaiTNTNTbVvVWjXbIL4RpRxo21bQms5+5gMglA5UpZ9FZy5Uk2C0znYx+MNrEh2fD3Cn8xX3rQxGMpqLE+XH43zniX1hBdQOjsgr1IzgYZNSYm2mM8xi2uZeq+NFtVEcil6IXy0Hf71eDuTBGg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8638.eurprd04.prod.outlook.com (2603:10a6:102:21d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.33; Mon, 22 Jan
 2024 09:10:53 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 09:10:53 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: broonie@kernel.org,
	conor+dt@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	han.xu@nxp.com,
	haibo.chen@nxp.com
Cc: yogeshgaur.83@gmail.com,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] dt-bindings: spi: fsl-lpspi: support i.MX95 LPSPI
Date: Mon, 22 Jan 2024 17:15:09 +0800
Message-Id: <20240122091510.2077498-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8638:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d5cc74-1666-45b7-1e28-08dc1b2a08c7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8DB58b6HonR9gHOyAJVAMyNiiwUaX8BwoOkoX+kCETqYdqPDi73mSzvzdGayfpG3rqTl98QUfc2Xv5qx0UPxA1RL1DGhUQou/pz82qNuKbbrqwzwpxmtxqR1sgqQTkagT6j1v/QcpCN8MYy53u/8xrk3xq/k9wve7MgQbut9GzpllSWgalM8RxmqYflyRebWHcLtwSODWH/4cZYUlUCgwcc3PQWZB1uhvAMDFsNsav65l99OH3kC8PIblPv/5+Fs/rJmZseQe6MmtYJXyYVkgPAYMi2JE5yF50sk6peqUQ9ZHtYkrkiZeUw2yk7mv4P9U3FRrbkvL4wgZBHthxXH7PAm1WUIq2w9YQ337PmYi7XVM9YMU4NspUjG7cvgx+sGIQ/XWe6BqxXq4NbCOBcPsb7bfEuXrtYnye90Xaji/kWv3AXBxFY4zadI3maOYq1ud96KZM3gWZxIUjuxP7x1FMBezIbNrbQeJShekOdgIRSBHavTbBucIrXp+iIhNQGGjaAOu5CQ3CInpot4zXh2tqjYfFugMBM/v1TFCSqoN3zMUBUK7luitP1++/QELgk7yEcgJpj1+mzbkcLiDNP0Hk8DZ+Dxqwiy7xoW2qJZ9mkQ90rE3blqeVBnwbAs6tN5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(396003)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(316002)(6506007)(52116002)(66556008)(1076003)(66476007)(66946007)(2616005)(6512007)(5660300002)(26005)(478600001)(6486002)(6666004)(4326008)(41300700001)(38350700005)(4744005)(2906002)(86362001)(38100700002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k/XoEZx3B5+Sk3f6OIDAtkZWc7hiXehHvOcXg6FZbGQ34SHVV7Q7/fqPXVge?=
 =?us-ascii?Q?tm0F2WPtExU3EDaX8LkSbqtc6O8XMR9nL8OedAyNBUEt3a/VnAiXylcTiRwA?=
 =?us-ascii?Q?B3020x8TVOHRrK/BwMGo5Pdfm/+IjZUdO11dBiYO5+aSHD5nrjr6D8RDN0OH?=
 =?us-ascii?Q?TCRal2WbNCBhuVMp9pl46gB3rvuIw4iSFZwCfQvmxZ9xRAPpbAGdjusAhRCh?=
 =?us-ascii?Q?PXMShnPoyP/s4GWDywo/Oca0VkgKLFs9Fl8YTUAhH5QJcakuyPlcv0n9iAqg?=
 =?us-ascii?Q?0cZ6b9efDPTCmRtYSioK5AHqrGaeEBskjFwYABA1evEvPV4NCSm48v266wxJ?=
 =?us-ascii?Q?y8+zKd5e3d4lEaBWGhHRZ6toVNmzrfww0k9AY+pdjyc+Ur1Cmz+y4lMhmaDF?=
 =?us-ascii?Q?/5mLNpMXViIjlNgBuuUB6m3deZucV9d66KJ6GoYbbz1b6dtVHPJfGq8ozeMu?=
 =?us-ascii?Q?Lv+VnWUfRoo/VaPEIDERTQLR8mUQ7zAH9iw2H9953y0CKzC4tHtk8OuOAlFV?=
 =?us-ascii?Q?Zxhq6h1pBjE1DtM/tpxFTjJ/antpZi4GVzXJbAsUc+qjd/39UnCbHKmYxoXR?=
 =?us-ascii?Q?wi47dOzJm8eFFiVCzFXf0Pj7pD9Dtq9hRWy4OJ3hgVsLatRC5Po39CPHKbUN?=
 =?us-ascii?Q?NxysT4j4qAqxRkTGKIp2gzihBdL5z4GiW5QBZMk+XKN4iKC09rtYJWX2eFEY?=
 =?us-ascii?Q?FOcB3CWZZqRsBGXNV+mq/Cxj4GFhMuyqTvIGpxzIPEEXcsV7isMKSq3yI/OL?=
 =?us-ascii?Q?QTcNnZ9MO4JTB2kxVvfvsyJFekJ3XHqdWVPa4YLBAbRFSjNKD9/2AQG3hopJ?=
 =?us-ascii?Q?pjtxSRBMBu6JZN+VMVtCJlcR3flRSaPrHvQZjxKxoAReDm39YViJIRf37qBM?=
 =?us-ascii?Q?l0r+4EyQaOQWqeXwgbK4ugV37Zr214eUjRnlKxCLbp0BFKcSL9VFMULJ5jgQ?=
 =?us-ascii?Q?4HFoK7dlGZ3p2xmeV98D8H25CPvt9PB3T+clzvU37y8kguzuS0V4EGECj+GO?=
 =?us-ascii?Q?RJMICWZvr4FJwqCSMlYxjPTYMpflXnZISccJFLs/ermi6w6S/shccu/VqmsR?=
 =?us-ascii?Q?jaglNzNd4FMf9ms76HvK6v2oueU1oUCjVqW1NevYhv5XOasoNb2irDJaepw3?=
 =?us-ascii?Q?SzVhP4sGuaY/g4r94Pabgz0KC7Ec1SFph2okN0/JiI+BVFrp2qgdlQyCXn4t?=
 =?us-ascii?Q?2ju8qxLQl5usXHnye/WxNhetgDQT8OAQoLfrGGi9rGyp9s0Uktb4TUudwLbg?=
 =?us-ascii?Q?/HqqOZuqmYvkmLlQOS+pSIROAV9+biCvuM6xgDpIF1l39trAAc9p29QD3ruV?=
 =?us-ascii?Q?LF9vi+40QXJizvbLWCh3oSAeDkvoOkaarY4CofjGyeOtPdHE9DZ1sqRkSoLz?=
 =?us-ascii?Q?o/hC5GvuZIzoiAgMR9VlRDP/nOJAeypyPRDTR8gc0KYOH+/0XDhPqObGfb88?=
 =?us-ascii?Q?XmsLuZxDaXzrN1rwCBX526ApU+KQbMeBxprz3SQEJlBkHZcaqZkQK7rajcH2?=
 =?us-ascii?Q?YUamdfJRInUwja060S8eo0FbYoKPFWrmyhjowtJjMd1yreB/KBc6k9S11W7l?=
 =?us-ascii?Q?kSPnYpC1cIiY3JkToh07zMZPOUzV0IM1TOZVMobO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d5cc74-1666-45b7-1e28-08dc1b2a08c7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 09:10:53.2728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xR+YJYC4KKS6alXJGieDycmbE36XA1vJGpSklx0OHxAi2Mox3ZPXEt8BeAozi2D87OslZnQUEhLAXMkLSx6dzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8638

From: Peng Fan <peng.fan@nxp.com>

Add i.MX95 LPSPI compatible string, same as i.MX93 compatible with
i.MX7ULP

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
index 727c5346b8ce..2ff174244795 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
@@ -22,6 +22,7 @@ properties:
           - enum:
               - fsl,imx8ulp-spi
               - fsl,imx93-spi
+              - fsl,imx95-spi
           - const: fsl,imx7ulp-spi
   reg:
     maxItems: 1
-- 
2.37.1


