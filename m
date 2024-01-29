Return-Path: <linux-kernel+bounces-43433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D71D08413D3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450EB1F24182
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2676F08D;
	Mon, 29 Jan 2024 19:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y5odScM4"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2056.outbound.protection.outlook.com [40.107.104.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09967605A;
	Mon, 29 Jan 2024 19:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706558033; cv=fail; b=oBTBGkEkgMRTyQPcZAOaLWO2uyGa65qn4eQUap3YuQNLqymlL+roUVOACjot7MAGpsIDk0oCSDDfT6N0XXi7Onyku8kOqbik4oLpei9TuAPpeHZk5dF6dry8Ifz7r42Dk/G8B2SVYrxXURgrH5c5frXZK0uWmCYSohWSTAo9A98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706558033; c=relaxed/simple;
	bh=xUss3csYfHdCltrg+pFxqrfdbvboutFgGbf1Juggzig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lIa+vx6nqdxXGGy+hbInwbA0FzgQeDKrcbI96srdWQwMnX9MohfAc85qqPOoJ8Vxc2WmSn5RYqaPgKFiamDXrHQYORtDWtJaMrc4adLkVk07YC9/Qfg/bHhprRACJYHUuyJHPsziCcCvkYUJVMkgx6IXvex+mXIGjcB5lkpj7kI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y5odScM4; arc=fail smtp.client-ip=40.107.104.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NP31FGBRw3H7pUsp5h9CRf3SDtT1+HXy8u7GMkTZKxwg659IZ1U3JFW9z38z0CcTTHnCUCUyASyS/Uozc6W4b0Hhk663cA3JHQlGc5V4QN1iqIWR4rGEOO2+6aQLJb6cwQtfsdklpVlUfsVpH74ropt6rJNB5ZrcI7NKs8b8TknQgowBIbELSGWXr4y2IiTJV55CXEJaKfOIexFB6nHCOWUskPhFGZHUcPNMJjNiwta3MWuqiE11OT0Qg5qZNvZruaWBTDKJgwIunft5DVKrASuUM+sg2bwUFUIZOis/XQr/oOxCKVkiZsxu12gILZJ7vbVU2y5G+rfQSGZ1h8lOXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeFeSa6EDN9RUHWjHYeb4cCKIA0/LO0G9GX7zxcsJ/8=;
 b=l/DNqPBr20Dg3ynHEoyaXlgAir2tVTtmWdjt1KWE4ostMFkotEcR7PNntuo7XKIQ1fl3t7fv70DHFHqEoAk9FB/YaIFuAZv5cRGCJdos1UQO3WTxDU/0cWYK9lEjz/HLyt0pfZZPTA4kNZeiQpxqYp2PiM08MW/Vshog28dQ6m2CgxYG0H67LZJcZ520Ev5tQ9B4oyhYXZsX7kur5yqacIdT+oy5o02EZoOOc/3VdjG6BdJjZzTNOxpbmeyPC0yPovqBg0OvifoZfb/HaIZDFv7/TOKaA8rpie6h6ndr+uqDboZZUx/U6DTkMRr/PJT+MHFlvbvL4VWoHU3l3jyyDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeFeSa6EDN9RUHWjHYeb4cCKIA0/LO0G9GX7zxcsJ/8=;
 b=Y5odScM4BgiahqVopNXdqcUq+tT2FNRjNuNdfwW3uR/ec6lj2f2wKk+LWHmnyT8pFmU4IO0jJTuMU5clSvqr4bJX5+tSZRVpJwp2xDFM8NQLsfR3eQ4uzGov3rqla/wVgOh75HAN81TuXAN+KiPC9bTedegLgj8SAclQtrfT0gQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8128.eurprd04.prod.outlook.com (2603:10a6:102:1c8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 19:53:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 19:53:48 +0000
From: Frank Li <Frank.Li@nxp.com>
To: ilpo.jarvinen@linux.intel.com
Cc: Frank.Li@nxp.com,
	alexandre.belloni@bootlin.com,
	conor.culhane@silvaco.com,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	imx@lists.linux.dev,
	jirislaby@kernel.org,
	joe@perches.com,
	krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	miquel.raynal@bootlin.com,
	robh@kernel.org,
	zbigniew.lukwinski@linux.intel.com
Subject: [PATCH v5 2/8] dt-bindings: i3c: svc: add proptery mode
Date: Mon, 29 Jan 2024 14:53:15 -0500
Message-Id: <20240129195321.229867-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129195321.229867-1-Frank.Li@nxp.com>
References: <20240129195321.229867-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0091.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a82e300-5367-4f87-5f68-08dc2104024d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	arPb0NWLbur7M4/ijJRDqbnPr18boJVLBw9VdaqvLycGEKli6vjCN59p5KF3sT+HdXkgl9a2Hvt88jo7ukDMlxlXsz8DsZQl1SEi0d+iZfjzqDmm7bKg3lycDtVs1rUvwq/uQqiCpaRU0EumH8cVqhZ6aRmeB1wKxsnA2PdBMzsZ2sUssb+NH7kCp00GQn6a+f5XU6p10f5df9JnjwYNA6moOKfboqq3yUAf6nnf5DVwQViJfdbg4XV63ZP41hmQrdTHJ8I5AGeXg7sOpq1HSSr+m/jNT8yXHgxcaNlrF7Y3xrD0xzYPppZpQv0mKxCcrbo/wV5WzopuArQnnUs6+LDmSxOseOY5L+T1RUcsOVs5OcKAnWsnHzXsceCYNcrnfChYmouslKQWBQrMVLUdf6fdy3p4kDwCoNvrBPTUtIpHr7XYZTc4DTNN/s+9SAbZOdq+M90JnQoRBUvId5Dk9Bq4sAYgXitTWQP24qIEtUpPLFnokCELT1Hvl3Cy/gB32HBxGFqgciMGCWF8PinAG6HgggqF3MirW3EkW7iQce2q20KjVFTQfRnwzY2rOrgKayqeRSqM9vHVSXAQbyxL1bzZJTxoVMOfm4w5+0/g2Gs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(346002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1076003)(26005)(52116002)(83380400001)(6512007)(6666004)(6506007)(38100700002)(66946007)(4326008)(5660300002)(8936002)(8676002)(7416002)(41300700001)(2616005)(966005)(316002)(478600001)(6916009)(2906002)(66476007)(6486002)(66556008)(86362001)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1MmUk/2gBc2v7nPYPPDPo+fFQReEramfKqmEDROP1MV/qQKBH1HAOQ96kKB5?=
 =?us-ascii?Q?eNIczvu83Gk6svocR3xQoBm9AdDNa7AacWBftsATtt4taBs7ei+iWrmlDcvh?=
 =?us-ascii?Q?l4mgYdR69oUnF9ddYb49sdnVY1K6U0DU4CkC8WzCTjqealkT5nxNdRGRfHN/?=
 =?us-ascii?Q?YgJ2OLSBYW2m+OTwjR8VuNJjCXzbdf4Ov2uaftklwiI3iaiBUNoMsADS+cR2?=
 =?us-ascii?Q?fVdOJV9yhLFuhVlO8gE9UTTUdr5seEJZ/ts3KlxP0yq9ijFlo2NEZCFCVVfM?=
 =?us-ascii?Q?kf6MNBCEEgOTHmBnSmv8259ZlluNaubsBrpnTkgNbKM6dN6eytDx+LEYY2jH?=
 =?us-ascii?Q?0PGalwsaImkqQFQBdamIurfBLup7mjzkMJO1uo00sVCYco+/+uBdqHU5elAf?=
 =?us-ascii?Q?HK/v2r7IV4elaOOcTEth2Ya8h/HUWe7nS0AcVnIUQqd8KuTXyhdlZQFl3Kr0?=
 =?us-ascii?Q?HyBx3o6o7tmdFUXruzO9X540FXmj3Jv2UyjVTtLd/6pPD0f0/R6n3cXF+qYq?=
 =?us-ascii?Q?YmS+C70X2Y5hmHk8B3DQv8FsAIjlkCdzpkkvyY4b4fyOYCM7QSxGNcjU1M6Z?=
 =?us-ascii?Q?4rx5xxp+LNHlsCNs0XpmAe+18MLfYvB2eQ4e3p5dHYqBf6/hMiF2R2Vo+nDB?=
 =?us-ascii?Q?DkkKTWoVVEfYxe4ixgCoSyxL/mXWnBi5TRCD7XOTdHt14t1aV5ZGKy4f7n0o?=
 =?us-ascii?Q?TfnW1ZABS2G78XTP5M6ze6r5BZCRAZbulpWSkqxIBvCXdTQ+fxUOvGvRLfBz?=
 =?us-ascii?Q?ynXth7aHVGXKTM7hnWSibhLuA2m4Q7uXcst7uTHi7Xu2kVwGMU5cibCkaCVZ?=
 =?us-ascii?Q?lupi40SIWQcNQEJiEMfsxQLgL1d28SvowUbL1ScwCkUkz5uSYQ1ARUprJsxV?=
 =?us-ascii?Q?vRYMiUIrwq59zlUPQdhLEYrkdF5qiwp6WBHuZ6dUxgzIuq3CKSPIIlB3WiAJ?=
 =?us-ascii?Q?rRYVcasvzMH8y4EDpCn/371LtBwneVOBAct0H7zPViF8g8FVb5W1ZcwEwsOA?=
 =?us-ascii?Q?5VXMJS/q8Gcq3yyYo/KD8N549pOecypoC85uJFtSt+p81Tn1rOSb+CAs/xYA?=
 =?us-ascii?Q?1rINZ4Oa8qGAeJ4SF8wJQydFdenG/PRiwqLeySdXw8V9n7+kmsI6fkycxDRg?=
 =?us-ascii?Q?OREHeU0rVArMaMBeUypvzVnZVWjCd9oe/sp6R6W46qX0ItG6MKcU3pLsxbhU?=
 =?us-ascii?Q?Nt63heKYAoY9ME3FqbnegslDkJOslEJnh1fz8D8Tl5NUaLij0cTNSo+kS8RC?=
 =?us-ascii?Q?eEGMGas4Y4eU0bI/dcd+C7rLRSZGtZJKj7ShbllXKCtWmAvFKvL1SI3b0CxJ?=
 =?us-ascii?Q?i4jT9evY/kheJwEy1HoA8ZRewIjXd72Uw211kSAwjqVCfUu5PXAVs0ZCGXv6?=
 =?us-ascii?Q?AoJj4qVtFKYWqLY8WX2ki2dfG5sKRSOmnwJn2Hjxa3d3CRHtD7rQnFYkaDjB?=
 =?us-ascii?Q?yYAimW3JPKHUkMzjAL7oqRuRVz07W3xgZjYL0/xxoQ0oCX0pem5gVcH0wcBS?=
 =?us-ascii?Q?wH7Q0bTuidu992c74c3Ip2BqI6V1qIeb+tKUCfBYbJKxG8y4FVgz4Rt47MRZ?=
 =?us-ascii?Q?DM0+JcCUFQSnF5xzmUdv+R5Onbzyk3a84v5tr0xG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a82e300-5367-4f87-5f68-08dc2104024d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 19:53:48.3491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MxeDlddS14rcqBoe8WoKDuOoZcVEej3vVnrrZiAfZiai+ZoEaegP+IOvt3hvkKRBlE8vVO94dw0jKvIH/H7z+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8128

Add 'mode' property to distinguish between 'controller' and 'target' modes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v3 to v4
    -fix dtb check error
    
    Change from v2 to v3
        - using 'mode' distringuish master and target mode

 .../devicetree/bindings/i3c/silvaco,i3c-master.yaml   | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
index 133855f11b4f5..3af77d143f018 100644
--- a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
+++ b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/i3c/silvaco,i3c-master.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Silvaco I3C master
+title: Silvaco I3C master/target
 
 maintainers:
   - Conor Culhane <conor.culhane@silvaco.com>
@@ -22,6 +22,15 @@ properties:
   interrupts:
     maxItems: 1
 
+  mode:
+    description:
+      Tells Dual-Role I3C controllers that we want to work on a particular
+      mode. In case this attribute isn't passed via DT, I3C controllers
+      should default to 'controller'.
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [controller, target]
+    default: controller
+
   clocks:
     items:
       - description: system clock
-- 
2.34.1


