Return-Path: <linux-kernel+bounces-85735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4979F86BA1A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBC93289128
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3AF7004C;
	Wed, 28 Feb 2024 21:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="anSc1ZcB"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2050.outbound.protection.outlook.com [40.107.15.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F2B70038;
	Wed, 28 Feb 2024 21:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709156305; cv=fail; b=PuXWZ0G9byp5Veq0JUepbMrHqBzWX1ak1dArWqJ4tfNAQbwuCyXpgIImV9ViMGk0nfMeB3VeD0oiFHsGmsouSmYQNehErkaYBw7b6tAt2CLFQAn3ZHsGAvJytb3B7sFOdMEa+TAq0xL3m6YWP7qLJvmDsA6hRuiknSz68qx9v1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709156305; c=relaxed/simple;
	bh=bW6cKr6RO+jY+5Dxus8OLWF7c1brkzUcCxS0CFv4wPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Nwk0CkZ3dVYQx4mUQdtWWxfPHbJDCqDgUhXxUjCIrUxIgQEAtASD/mJQLr7NDOUsA7xGTjB7Q9CySl/bbE3tQ75fDJb2blFUsHGAXhGyyt4aB1+/3HzFni86nZXg2bUMnq4Y37KlemSekjfwvz9nPMgUUZRRttuFYPSVZn6vmgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=anSc1ZcB; arc=fail smtp.client-ip=40.107.15.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHP/PM0tSjBW6dAegC2CbtU6kSiPgy0SpDyVBTmdY1OqT7phmKt3c7hoh81XW56poujxso2F+uBwi20JLztaoJ2+rioklcc/MiyM/9jyPR+XCiDSF7A8TruRD3EbKMj1zB/UesmgAPwSa1xHwdO7HlNTscyQDlPdPr6K4cdsbrJ39RyYrNNpR3QVF4UnNy5j7vSFnFOukdu82j1yt5i88CihvR9/8pqo0qbuOn/xgAfwp9fY+hJoVYGsyiopKrtpRWQsXkaFddHxRUGiZtpUuwDioWmNjHgX3fRIlBTmdPXqCsg9iyO5PMWVeH0kd1xEeiSZuuTwm9Uly9zXQ6S5YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBbSjO3NIyjJfuiGUAqT8fyCeNjVD1Xxms/8yQ2zCXY=;
 b=A2hSGZggAAHpQj9kVV+eivB5OSeBerpjMeKrOMN/goY1q6Ney86+25lRTljlCuyPgVXUjoa/PR07z5uToD0W5cJ2GpwCIxZTzJIunC2DHyjhDslaLjryoXTWJ6mDtb+NBmTlCmmGnpmAcfspb9WA/8Q8RDwIHoiPQDW5IzOXUoRnjORc224LfrHS8jSyLF0QeTRIfokViB+FXmVHjdjYcVNimEngUnTYz/LPjRuK36fCYG6NBiZ4R6jPw8kk7x9k2oV9yz7+M8Lkoor/JrAkp7rxBxwmTVkYUVt1639tGgPPDlmdzMxHfRKk5XMoxQA1doxZRLzA9+9VTW2PO7VFwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBbSjO3NIyjJfuiGUAqT8fyCeNjVD1Xxms/8yQ2zCXY=;
 b=anSc1ZcBNOnmY/9nVUJZHi+41n7z/sKE2YjfIw9h6Nq8rFFc802rcAF+TWxEcZ43CLyU6s6GcM6c6LkTJuA1jpoYjiA9Ao8J+KXGB0f+O86DS19lj073m81pzwZpJTSNVxjwcsdZmv5M18/753Mo6rI79BOasvJooVgadm7TFFM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8153.eurprd04.prod.outlook.com (2603:10a6:10:245::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 21:38:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 21:38:21 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Linux Team <linux-imx@nxp.com>,
	linux-kernel@vger.kernel.org (open list:IRQCHIP DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: interrupt-controller: fsl,intmux: add power-domains
Date: Wed, 28 Feb 2024 16:38:08 -0500
Message-Id: <20240228213808.632603-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0067.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: 68fbae78-0a20-41f3-c59d-08dc38a595b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WvKblEDJElTH6+80Zwo9+FMyfA489OZRW2cxCxOswhKiX9m2Z3d/iyaFkWMJZsIxN9L2nf9lV6MOwbX/i+GJTmx0ipo9HPhRx9HIA9f6tRPbgPvNLh23P33rqMzm5HOgCmtJ2Dw/d4+9Eg9ijlpB3+pfHjL+ivH9kf5/K/vOV6FyYxELhWJ2Hh9Zyr5m0c6ujoGOXdmc0/CkmlTizJpbyzqxAsLAWyGIYWcSo63ax3P2jc1/BYoVsptvXFw9tx/d0SB3SAW/cVTGTedN/YxU5k7X9QFMojUmFSMq9cQ/RLB5HY2R1RSHoAC71Al4G2j1L9xLfi4mw4XG0n38BdMwwmQLUb+xxabCKx2l4JPV8libDfFsWRcbpCZTaZKvXTWX3T8r+9k9l5WQSLjk1ScUgPb3DzJxdQRA+6fiPS39Wp0Al30ENmcEujD23NtBYqy/bkalp1cjxeEIe8oiSoGLQc30rwlPxc/pWFBuMeGBHAqJ5YM1gppbzajGYFCBcsbGn8ntydSRQI4PonCoT8zgNrJkh6gogIvWbvyA19IFOQXBOApsXv0DHPnghogi0QWpBODXAbJFAOqzY4NxfwNsqdHNyOn98MpOE7MO4UYp7x3cFryBGZtT6+NqwQt6NDyD4iemUdKxZODk+tNhL4TxLPbriccFeOAGHciJ3nNeMYITAN06HTcvJia56EEJL9hS77rF0UwU7KdCndwjQNiX89aDOXH9hcsTMF6GlHt1NCk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dtZpPClhWMNMztmSwX+p+SZoSk5m4SoQINV7hpuuhzJBnSVkNlF5nvHNhuit?=
 =?us-ascii?Q?lPRgjfQ77XK6X/UXD63PQfq0yMCplSL8H0UsM9NCZhkLafdjXB40K13djtpQ?=
 =?us-ascii?Q?el1lCl8x63Uj2Z8Kd4jjbAOVArNqX6aLaoQWQi9WGeVN1CxnWbsLcdcFQXgC?=
 =?us-ascii?Q?H2pDafLdYK0oqdB6HYKGJzUbkYViwpEIS4vypvVMcDR1L2DIr90qvAG8j11g?=
 =?us-ascii?Q?bEyO0MPvMZujyvylPn2h2D2kH9SKjs5t6mYnVbUX0ewdwnkoGhIayLwOANeI?=
 =?us-ascii?Q?BU+QC9chd3lC4d7Q6d4sOJ9x1WgyEs5wQ5wPC/a/jdz/IP5xHfmBjn5Wimfp?=
 =?us-ascii?Q?Y8thgfw/+MFwCTxH4CWpb+bT1CcAvhr7LrN/DwE+CwwQsBsLOwZCJlSTITUS?=
 =?us-ascii?Q?3lKBAuaPJsS5415JJ8FZphj90kTgCnhAjGgUKRj9TLDXcyedJn6SJOO/ccH7?=
 =?us-ascii?Q?vmIja3H6q5IPmXeZRc5sLpBoGq9djQtRXPjgxA48AwITxoc11MGLF42HRnAp?=
 =?us-ascii?Q?khcKMmNjIDE8XQouRjUJxVNP7gNwtEpbdPVPAZpv2XPbr99Q4zZm7uqOaD9L?=
 =?us-ascii?Q?23475Lguz9nIamVWIfVNg3IB1JLKBphx7EUIuviYcPWwdiiQ+qJQxSeKGVi/?=
 =?us-ascii?Q?5QYdrEzKyKJ0cE/QGhurOZQ6ZcGMXWHXn0XCfjGTMINDp3CVlxJRdPI+rQ/D?=
 =?us-ascii?Q?JyxO7km+cTfj2Fd4c7Le4cvNeVliZTWCfadw1M9Mhb1ttcrClg3G8agzUkkl?=
 =?us-ascii?Q?VpQ0TqkwQQFZCIM/xD7so7oOifKY+AlHpXx7rCCkajKXIiwt5aSAsPTtFLYj?=
 =?us-ascii?Q?fTJ+UyZD15pvIOBISkoW1Rr+1iVXBb7Ag16Nxrn4zFtA1Aa+zvF/1qO1ISdc?=
 =?us-ascii?Q?WKGNoTQHa896+dfaW2PMS9noZ8AZXCHWNljgryXYoeammMZy77AkMaU6FN4d?=
 =?us-ascii?Q?8mSnttbypSw+ciy34j9b+5PvUahT/VOwDQIfXP6WecZozqTfR3Axp4xkSmk/?=
 =?us-ascii?Q?fl9FFfjggaRgPeLbN6kKwU0XOjWk3G3+ExeOsFg5tFp4upOc78MGdbndL/H8?=
 =?us-ascii?Q?ccUyJsrLrcRT4+bbzBOyc94B40+HpJJIX2yE8uRq0/90Qyfy65T6Rh93r6Cl?=
 =?us-ascii?Q?MLXF08mtRTHJZrsR8xp2ufW1xYm9EWEAbaRAqOmKQMFA0rK3nJxcjRr0Bj/b?=
 =?us-ascii?Q?zIB87AvCJXVLiEhKeO/99p8wLiEbG60ciuCfwT5LPT88Nno54uyzzPR3ty2a?=
 =?us-ascii?Q?sIYqcdPH6MvxsyWDLDsgdKjTg3UkvzN1eWy9pPe3dxjl5MHce2ep816/cjAi?=
 =?us-ascii?Q?+kHL/xD+hwvrNTTFqspsjNXQ7CJ3RA8QZs3aWqurfnmed7Rd1DI6350i0zpG?=
 =?us-ascii?Q?m1BJMLy7rNF7pNSvIUWHIvMohE4gcq+ejHJXWFhYFGiqTYtnGullghaUgSVp?=
 =?us-ascii?Q?hW/L59BjOsz5kUucBZShHEjJr3cLTE03dFK3K5rnr2dm5pCpdHcJKc4xW5Yk?=
 =?us-ascii?Q?EUUhOAquOv9m95EtqAdmT6u+5WWOzNH2zYfpmln/8ZlS6XVGEuLAsXGA2nZ9?=
 =?us-ascii?Q?7P15Csf8Oc2sG/VYHDjwPM+8MdUbaJgmYV3kz4Ag?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68fbae78-0a20-41f3-c59d-08dc38a595b9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 21:38:21.5253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2fpp/WZbVReyEgrv9j5QT53Qxa073lq62rgTk/STYBhKotZ2HccuJ9KWTSCrMIo6KnY1tNiVW5CGfLtrBMaMMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8153

Allow power-domains property for fsl,intmux node.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/interrupt-controller/fsl,intmux.yaml    | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml
index 985bfa4f6fda1..d73d9a6c50a69 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml
@@ -37,6 +37,8 @@ properties:
   clock-names:
     const: ipg
 
+  power-domains: true
+
 required:
   - compatible
   - reg
-- 
2.34.1


