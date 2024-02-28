Return-Path: <linux-kernel+bounces-84915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B599286ADA8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D84DD1C22EF0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8413BBF0;
	Wed, 28 Feb 2024 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ipnuz8n7"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2055.outbound.protection.outlook.com [40.107.14.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B89161B7C;
	Wed, 28 Feb 2024 11:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119835; cv=fail; b=b6qbYHq04t8lebcZonO8ReY8ihxdKn/H03wHj2g4YLXJB/LwpZ2mC8vTR9EGcl0SN+PgX90jcNZJMWA90TXrHSXDwEmx6Xm14nBkOjTzrcikHOzdOtlOypHlmJ6lO+knUYwZ5RxUSV7hkNLgv7jjxL6CyKOCeWPljcBV+9/5xus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119835; c=relaxed/simple;
	bh=tLQRU1bSyw4nV4IX+RDL8SxbuBTXal4Fh+/wad+qECc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZvQBw0psT1B8nDU0oTfMq7rDM+IhV3a8sfV5cQHO9aLVXgzwAsRiXh2s0G5A+nm66S9/DczsrEuGbg8RVUSEWVZ8S22KeonysJ8aNjVCcAZxRBGqraYF/L7DRWcuD7wIQVAfGxlLGSaclBfpq4mPMMAoDnzaCcIA7AX6nkhElCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ipnuz8n7; arc=fail smtp.client-ip=40.107.14.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jF3TtIegAP5aFWyF4Llg+Ca1Hgc1tuz/cxy15IhhE727+7ygQhT52/QJ+t9P1jM13xOTmr7m4Z/pMXF7LRH3TgQyW9gH+dOr4Fq1W9r/3kL4mXFk1CZpbyiQ6ytWAcqOgT1Rv/pSkx3Lb+NQGd0VXwy1zKtJFE3fiDt82RqeKnqz1vUDR5OE2y6FXMFhAD6b6CdAF8x8UE4YRXOibYS2wpKEJEJ28tgPu/ESFHDpu75pGiu7tIWnGbRfwLlA8WldQK2lgvKDVThvH15ORyQbpoCLJMM6b1KRrkeZjC1lUCpkr0TH6EBY6vP2hOdyGRv7wCFEbY9mpZsuLPqDZ83nZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNNJmWiQHa8BkKJSogrViSMO5gNi1b/KCAnuWsynFAU=;
 b=H1wLbTEX7BpCZ3/i5N0Qj+d+Zo8tRjDEniXMJnKY3bJhQK4/5eYC9muhb3UDYOkIJ0kd4CTPDp2QFxQzZkCNvTKoBkY9HDyLyop45dJMl4OvTqzz5jIdia0Uuzu3HmoWxXgqIALuMRP8NdGcBGvf88fDpj511QUSeDqweC5fm1cLxYvVJKFbqnWHIOVeKNrWzJY2U1EcCb2lEWC4ysmS9IMpg3reE/yN/TU6jqbEpuXMe06wPiO0rFZwNYUhMmjpQxGMUAZPD7Yynu/3d92UeJqpmdn1W2ELChNw3+y2t+bW0zBUcdjENkNrnnhFCqVOF/nfoZB2360VOM/IxAjqGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNNJmWiQHa8BkKJSogrViSMO5gNi1b/KCAnuWsynFAU=;
 b=ipnuz8n7Ii94vbmYw9O4LFLTJySun9m3BQxCGq1Mb3KRxOPTeVdbSaVk8gOZkQkWwWpE0HZpf7FAU94LOdfe0ZXI7Rk2ryGEhDAChOn6Vp+lOyUuSxKlgDf2/a4lrKV9mSET2/zRvaA4MQi7PDEnOUyKBfnMb1cFawtBLMP4ocU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB8466.eurprd04.prod.outlook.com (2603:10a6:20b:349::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 11:30:29 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 11:30:29 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: gregkh@linuxfoundation.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	shawnguo@kernel.org,
	conor+dt@kernel.org
Cc: s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	peter.chen@kernel.org,
	xu.yang_2@nxp.com,
	jun.li@nxp.com,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 06/11] dt-bindings: usb: ci-hdrc-usb2-imx: add compatible and clock-names restriction for imx93
Date: Wed, 28 Feb 2024 19:29:59 +0800
Message-Id: <20240228113004.918205-6-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228113004.918205-1-xu.yang_2@nxp.com>
References: <20240228113004.918205-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0185.apcprd06.prod.outlook.com (2603:1096:4:1::17)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS8PR04MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: 24fa716d-e105-486c-60db-08dc3850aab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OLXdPbVfUGFzOmxPoEYKICq+hlaV72CFxBLh636cd9AlhKgybtFAu+EF/ACfuX6vJOSO26JPP1zRpG0130zSse3IBpwgMlyjq7K4AmDdqqsk/5q1SCA1sDvfxUS3QEIKyAXp3RLrJCzdfdjIpGZ71Q/I4HZgZfTFzwsti0gOX+leEdVvSDwXI0jlbRx7Yxb+EC6C4CMbRT23GkBRWiQDAih1DNwKOR9fe5O62nP50Z5M2bWLPTb9eJC8FGivrODvcEN6aNa9QjFUtS77ZCtTnyHBlEXgQN/ECDIsemiDk7pP4wn2+8DaAa2XQ8uIvlXzk8n/8Jw7Ofm6HmyzsQxDl8sPvypi9SWvkagvF8PeXo1AAMSPtE7p0pLY2FKNXlU2JAKysbvji4DVKPvRBfnyGBI9XUA3tLR/5XX5GeUieuk3qJsOtNfpuc9EWEO2dxMdC5OVkeG69/mVUFVnpx6NMAqGZimdwR/Iic5Pv5WvIvLiHgBRw23hHRCBaZuS4zXJTzdVxMxoLnXDUtF62Lb3bdRUg722guC5yyT9JviqHFJJdmFtDt9uXwGoUWAT3vOi/iR6sl+eozYyuOONdHmVyM+KEefyMxzvt+99beFh/YOCDUezxGrIIKhyzqyOK16AvHCCNEF7QMQB/uAflczFdGyShjM/1wwgjGEClZi7yRjPJz2wmUDl5kcWLRNLgR57uVGa/gD6zpf9qWp9QR/L5aTApMyfQsCjNV/9ZuhtHkI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SYvX5AvZcZEL2l/nT58F4CsB+PdI6gs4PHYXDD4BghAz8ZuP7/j/KaVDbvdr?=
 =?us-ascii?Q?zQ/mumbVxSpN7EcAXM2MGJnzB4UYlRoDUNkZw/ka2VmeWyOS43BDOdoeCJgw?=
 =?us-ascii?Q?hhEmcfobYFRyOnwKT7IqQ4PUmr8sJ/mMgCb0SzAisK5936U8XBMZgborlcYd?=
 =?us-ascii?Q?dm+3O0M8w0LVCdYYhhsHVUiZiPgJ0XLHoWbn9bVKqAXfnTaBvpgBD2cfLtfM?=
 =?us-ascii?Q?jI6uD6LOEC2gdVnOzuG72+qUTcQQFdFhhgqTsz0/b+tnmKxKXtDvFn5bS6TS?=
 =?us-ascii?Q?ESY6Es1O8Nb1fVx9HyzADKDV7aLYIxWynECVyJog9hiCEZEesHbm8Z4dF/4T?=
 =?us-ascii?Q?Amp8GtWMWhaKh7zyHjl2KAQusNKJcre9a7HcoGZkXgtx1s7Nc7pTv+7lJD7c?=
 =?us-ascii?Q?IWW6I48JAYFj9fNO/w0IclFLeZjvkFAipQM787IVSKOqgsCs8qlOFTcaE5ag?=
 =?us-ascii?Q?RQcUbcSbPr5PtSND4TVJZcIdutfk6y6Jtfrul5I7eN5tqAuv75Z3Rd9i9i3Y?=
 =?us-ascii?Q?NlWst5c8F1mAYdrj0IFt2FNO4jLnAZ2eeRzbWMCnXD6zqLVjG1nj7x69mp3I?=
 =?us-ascii?Q?ka6xQyk0TOQJrOpS0WQMTjlLJslgZvzntJIi7q/2oCtixcimCREbfgfAy5hY?=
 =?us-ascii?Q?R1WL1p29d1MKoj1S+en+VXyKpXk1KeyeZr0QdPhlq1X7/fU+J6+vaxa8DeB9?=
 =?us-ascii?Q?/g/hO260lfwkY1984tGNbVYn68t6zHDq7YBItDkD9sRplmpJujlyWLXIUA5J?=
 =?us-ascii?Q?YmYsUOAbjlAGg3UWUUWbGro0V14rwRV04/I0lSyK7wEPKep9DXEW0okIpDL4?=
 =?us-ascii?Q?0MEsoHfp7Wya1jpMeUD/oh/w8h3bdjxDHV3mzrDrtkbfgCgcb91yrhL7352Q?=
 =?us-ascii?Q?F/2YzOeVzNuTnbw1Av60td34C6H1BGqYbiuVajBWvOrZ4RcpGFP51/4Q41ek?=
 =?us-ascii?Q?MDjXBVV4kht/j8mP1G1311d+v1VfVb6ACotFNZ68O8msIwnhC3dyzN89Vpeu?=
 =?us-ascii?Q?+K9GHlQwvYQz5CrsWx9P1u34IHzMMsAwZh90mfM0KBctGXUmMejENluJPOxv?=
 =?us-ascii?Q?ll9DuaoBBlPlFmIJZu8P2TTGLTOWIkKFv5O+1M6lAEIcUIzrQcu7GrGxEB2M?=
 =?us-ascii?Q?tKe5Ka4gPFEd9ZKxabENGFws/qvRDhdpXC0IlJusppq7oLvPoYlkdNbmRJBl?=
 =?us-ascii?Q?1xTTTvDUMnqUZ3XyfMtooDa4blB8wYpbe5At+Tqp1dOu134UwiLT+kQEmuVn?=
 =?us-ascii?Q?XGbtn5D7kMTq4+qV9T0NAiW4mI/axjFKmYx/sarBjEf4yluXnxEwxJ7pKFxQ?=
 =?us-ascii?Q?B4ClyIW/rMedn3lHc2m0Js+7lEZ1/+TLBRnSbdBIgIirKnO4BkiIPI1MwuEP?=
 =?us-ascii?Q?MJGyfhZb6NRjVKKgFZzVXTxGzeb1r9Ugq3OP7OkOy7gXFZTHSBytXPHhwTH+?=
 =?us-ascii?Q?U+Is599Td7Jz4/lB4ZUfVJfzkRPIyKVLoBDSfi5ug9pLCQjPFA+96WzOzSBI?=
 =?us-ascii?Q?S+hOUofLVKPF8+jcGPwzF+92IbfUvN9fxp+WEuuf9/a2GpS1I/tZI1OuXDJh?=
 =?us-ascii?Q?qHn/3kFDPtcLvjImJtR0MXl5tDTHVqqMRLxSrvcZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24fa716d-e105-486c-60db-08dc3850aab3
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 11:30:29.4749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vNHfy19RXW481cNJ2moUX/I/X6RK4vIcFlamCkgfOQ7W4cKnYR2QVP6rEHXYM7k7Nn6zbpsGKDvYYJ6s31l7Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8466

The i.MX93 needs a wakup clock to work properly. This will add compatible
and restriction for i.MX93 platform.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - no changes
Changes in v3:
 - add clocks restriction
Changes in v4:
 - use 'contains' rather 'items'
Changes in v5:
 - rename clock name
Changes in v6:
 - new patch based on ci-hdrc-usb2-imx.yaml
Changes in v7:
 - no changes
---
 .../bindings/usb/ci-hdrc-usb2-imx.yaml        | 34 ++++++++++++++-----
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
index a4730a2393e6..a2932af2c09b 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
@@ -40,6 +40,7 @@ properties:
           - enum:
               - fsl,imx8mm-usb
               - fsl,imx8mn-usb
+              - fsl,imx93-usb
           - const: fsl,imx7d-usb
           - const: fsl,imx27-usb
       - items:
@@ -186,14 +187,31 @@ allOf:
               - const: ahb
               - const: per
       else:
-        # other imx Socs only need one clock
-        properties:
-          clocks:
-            minItems: 1
-            maxItems: 1
-          clock-names:
-            minItems: 1
-            maxItems: 1
+        # imx93 Soc needs two clocks
+        if:
+          properties:
+            compatible:
+              contains:
+                enum:
+                  - fsl,imx93-usb
+        then:
+          properties:
+            clocks:
+              minItems: 2
+              maxItems: 2
+            clock-names:
+              items:
+                - const: usb_ctrl_root
+                - const: usb_wakeup
+        else:
+          # other imx Socs only need one clock
+          properties:
+            clocks:
+              minItems: 1
+              maxItems: 1
+            clock-names:
+              minItems: 1
+              maxItems: 1
 
 required:
   - compatible
-- 
2.34.1


