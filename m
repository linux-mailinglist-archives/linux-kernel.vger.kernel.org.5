Return-Path: <linux-kernel+bounces-36171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B70CD839CFD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43B1F1F25829
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1150153E10;
	Tue, 23 Jan 2024 23:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jLMtZ9lT"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E3C54F80;
	Tue, 23 Jan 2024 23:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706051476; cv=fail; b=jG8NzWRHZ3jWbZ8vtlht2ptIvNZ/8jBm2y7GZegVZw9xs8glsoZabOCMgyDqhLAfOK1WDoXhs80LmxyYlXhvVMctPtFSospjO2Aw2g0c4xM31dMBwaDX5It3NVdxAS4emE8g9uSl+qSy5cGt+lRy8fKr6IbZFxAaTZUTpy4P0LY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706051476; c=relaxed/simple;
	bh=xUss3csYfHdCltrg+pFxqrfdbvboutFgGbf1Juggzig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EYgRW52zY/kxlUtOvbdrpPI8tjDH0ArK3qbajH56saLEensYzAYm3EceG1lXoPA9Kacab1CQ+6fiCD9Xo/Q5/uNQjEEX12YIRsrXiYbJfOTiXGDet04ksLlgY+n+Z3BBpXr3PJl1fgCd52F9qtBrE2kXc3iJqYNs6l33TSxiFxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=jLMtZ9lT; arc=fail smtp.client-ip=40.107.22.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9eiTiYabCr9e4nXRSPtTkYIxacGkq7BRfVGKz9MHRmSr1cM9TaYKB+0KJPHDgaNEWMXg9+LKbsIsr6VUZYnBHLEw1Le7wDfAT2txWi42zI/+HLp8OpqWXpnZHMqp3NJAdVPE0A8UmQw+Sc7V1/h3lFgcoCA96pu3vYSqGFWmPuQX8tFFW8tNDzHKgIMXkjJGRsxDfp02SDusKpbUv2BH1vPP9XCVQ8BA4X64bSsSSuMoHCUlmTsez0AOfvNAUBVUaMnao8NjGhaYxa8o2XlJfTKEVV5GaG3XGecdJW3BtpV1INy2IqybDXiskw4kFZLVHoecJ5L0aO7u/zbkABU0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeFeSa6EDN9RUHWjHYeb4cCKIA0/LO0G9GX7zxcsJ/8=;
 b=DcShAcPA5EHwM/4ezLsCqoGImej+UL8Z3oUDrevGvhXRhAMgLPoJ5X3C4cd/HNlOAJiU+htZZAwhCfLocI9LcfHSrq8GTMHKGMoWWoNON7jFarFvZzRHJTQCLUN7Y5Q397UWQmFgxTto8qLXF9wuE+InhnRKzxuw3uM95S9PK/fCKKp/MvZ039ymb2ymief/0oA6WlCHf0zXhP1p5GZUmg88OWkMDfQ6UcuyDY0eN4aQB9wPE+FJ/cGY0R98j7JcaFwFpzUEpSMmoAlSineApqzlmBoUrhx+oXnvTwZy52t/ocI4W95eIYNUQuY1CBw/oA3r93n7drl7jIKf7Bx6sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeFeSa6EDN9RUHWjHYeb4cCKIA0/LO0G9GX7zxcsJ/8=;
 b=jLMtZ9lTCVgOcN8nZKPzz78nqwo8UgQyrZ9QRKwf9KMrr7wDdXw4s/l2aF+3WoTeJHPBXe1NF1SRpR8hlimuLTevxpGl2o0WDRD+3k7or4Frbpp+kS0ZpjoVvPZJ9tkNNjuAxrIlB2euBKJAnceph7DA87S88oWV8BG0G2R3q5c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9475.eurprd04.prod.outlook.com (2603:10a6:10:367::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Tue, 23 Jan
 2024 23:11:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 23:11:08 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com
Cc: alexandre.belloni@bootlin.com,
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
Subject: [PATCH v4 2/8] dt-bindings: i3c: svc: add proptery mode
Date: Tue, 23 Jan 2024 18:10:37 -0500
Message-Id: <20240123231043.3891847-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123231043.3891847-1-Frank.Li@nxp.com>
References: <20240123231043.3891847-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0371.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9475:EE_
X-MS-Office365-Filtering-Correlation-Id: 1252dd24-90b8-4b3a-a9d7-08dc1c689510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ns39v0odS/zDCsUlxiAFTq3/EJfjA1TZFWRzb7L7wcQdHj6pRsjV7AA7VSmKwvCkMBtqdIGy1IAsnvS22jpRY0KbqoVsSgM8vSsx/UnH5GLz1Q5b00rt4Ni5nVzLjof3mWO4d3Z0o7byqngucfsW80xZeLiCtkeMSqR4sOG9l08w4ztvaQEi78lrqT6nbY4kAupZ+auNFv4voXwLpTaEz2FQ4Irh4/A+eH/NKrGmK/vHFGcpZgHMg7Obfv970WSP8aQ2cIov54JedojpqpATe20fHPhA89KU2tS4fwDI1Ej+XCY1xIoyYnUENJh0hp8BNFUqmK6ZT/6m4mQCyrE5Tg737/systhZP48zdxzEvfPmx1QfzRdDUtL/Ry0wgWOr+UrEfvYpeRJxDw3S7lHME0pwVljmLpdXqMPH/FupRu+1wC5V1qKoDwIWEbFponcqy02FnOGgNAhJSQhJw5oB5XLxJtg2HSWO3qX9U7dOMBOZiqJ8RNnQ6kg8MPHJHEipxdhhjy8kfZ+BuCc4mmOsdA5L9qyA4O7DP9AXO3DHZs6N+5H11iGJrh3pmb2S5LswsuL5FZ5h7G5EDiEjOilXO7y3sErb0nM2mcaBPKmol50=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(366004)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(1076003)(83380400001)(66946007)(2616005)(26005)(6506007)(6512007)(38100700002)(478600001)(2906002)(8676002)(966005)(34206002)(8936002)(4326008)(7416002)(37006003)(52116002)(5660300002)(66476007)(6486002)(66556008)(316002)(6666004)(36756003)(38350700005)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kXPbYnvHlmv7sA/RSTTplPkSY+FhYI+FkI7jObFio8h1v7bhxKcCu0Ix6Cfk?=
 =?us-ascii?Q?Nus4mCIQ9J+u31v0nGwHQ1Md9A5D3R7rfGjpfWQOCXppB6iyTXeQMjm9WNCa?=
 =?us-ascii?Q?jFqcC+KQtA+3F0fXDPaa2YD9GuCb0UVoWXmeDmFRAFCz+6bAHpqAfK+7gSKg?=
 =?us-ascii?Q?bi/Par7siXV38HxVAgK7kH+mpO91wH7Z1qq9c/SxIk32AFCjeSGxnC+osTOB?=
 =?us-ascii?Q?/Jb9uaj37uFsOMXtxzZN+EJXxRdhyO7GRNLwCF831BF26XX7WDq2MLml0vZI?=
 =?us-ascii?Q?TbMiKTtB0ws522NvoYTO+IrbhAXKzku6mR/7fPRAjZGzWbKOUkr2fTFqsIQF?=
 =?us-ascii?Q?MIOCh+U3Y0PD+pNKDcpWO/I1NB/6O3sSDGq6SKBDza74uys2UgZ4HrWzUBQ3?=
 =?us-ascii?Q?0QCXBeqD1LTwoBfWCaTnmGNMSAw4uxx/4o45XlooPyugHxP3nF97JBNZNjTq?=
 =?us-ascii?Q?XHuhBOdkAprrxaGdEciTNyJb3n0L05XHXB/TSXisce1lvo+Upp5BYUYS2VNZ?=
 =?us-ascii?Q?h2n3k+MKJPVYEosbyjeZ1dzcAsaoVAfK5SRtLUmNkWVHGEo26wVq7bAj3hIE?=
 =?us-ascii?Q?F5yljq4rYQv4Ogkut6SEInnSfMMoGjHl+pPG0sJICcGacpsHV4YOBUxlohNA?=
 =?us-ascii?Q?UV1LoU9iTejq2XmfsC2nCf1FMpIHv4TzryRcrK1sN5Z1lTI5radA6KEo4Ijd?=
 =?us-ascii?Q?w03R4EH44hyQU/MAm1NwoeowPDjtWLrH9mHbowQQDE9gXLhWoYc8qdNoE8Ov?=
 =?us-ascii?Q?HDcQqCLAaWoKyJrH+jqjy4yrD0YLDyeDktR6h5VjBe0FkLrQlxe2ds0GbYwM?=
 =?us-ascii?Q?F6qhRNWym6fXAx9oR6iqscb6bjsUkD2gKsH2jKueV8aqTXos2WTZXxHbOYrH?=
 =?us-ascii?Q?LEGCWVhfg0AG8uam+rt929xa5t/JVAm4zMEMSsAo6E06DD1a0WSZxE7qbODo?=
 =?us-ascii?Q?s07aZdLXWKUsRjkgke1KBTjwIpO/F0OM164WrH0eI6u1E6nlG48PjOwShdFb?=
 =?us-ascii?Q?78EkcNFAybjgjMqvXVUFufBtrMo7T3outWh8SvQBcwyyIqfro3b/wX+1a+Wf?=
 =?us-ascii?Q?PsDmCxfDOoGAh0Mq77RwQawoBU+omZXmw6/If3irqv7WLzSFWtPFMRb5F8Fp?=
 =?us-ascii?Q?wPwcOoy2zSrUZrxp88q1ADywgh/XVxgwFdg6X6+zoQiQ6t/s48Ftat7r7jsX?=
 =?us-ascii?Q?ZMYQhTRK2Z4+cpiWc4eFyht9iKmkImJ08m/ald3lZp/trMsPK2aAUFloGZYB?=
 =?us-ascii?Q?ni37AKDPBUdY/yrC+a/GCu9LxdExkppd6XU0hchdEX56EMwT82UVSMM5BIHs?=
 =?us-ascii?Q?DyPG1tCJTYQirCZberpQ+BMPRJcIp5eyFkAovX04wiAWRmXfqH7q7M2z0r1O?=
 =?us-ascii?Q?AYK0JxifzHeNb2p1+rRhtOWezbAD4I35prdkf+sRIRUpkZ9M0WuXyeDY8fQc?=
 =?us-ascii?Q?U9ULyMhkKcQFrrvU0QBsDgO/gsC5NIs/5eufQ3BqtnvaLA+IcgRx3zyZkuT2?=
 =?us-ascii?Q?w3ZBdBzPfCpAh4Xuj8/S6Ot1BDUuNnKc3ZWqyOPRYGCoa2RIYmZTeK29GnBu?=
 =?us-ascii?Q?eMhDeR0uL3sQAdaDfCA9H6F6XZmFpYGdX2AI7AM5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1252dd24-90b8-4b3a-a9d7-08dc1c689510
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 23:11:08.4427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JavVMYcjOsEcTKVTZapuuZrCosPgfe+raMzYrAcabmGkt3VQ+BSpk8g6oEMxa2IiSzIDZ9FXtf7MotxSSPolTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9475

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


