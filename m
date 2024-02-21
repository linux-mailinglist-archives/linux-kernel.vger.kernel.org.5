Return-Path: <linux-kernel+bounces-74171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 823BC85D0B0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F3AD1F23A20
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2783F3BB46;
	Wed, 21 Feb 2024 06:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UQaKSsVG"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C79E3B7AC;
	Wed, 21 Feb 2024 06:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708498324; cv=fail; b=FVfOVCVXuwti0MkAd9pnsfjoWG5e10iFOE9c44OC6xX6s6au/77UpWOw5cUkacuWOC/lIe2JOZWPrMcZCTcGtaQqGhiyFYhn6SThnscLiCH7UOgI3Rov3LsCHnsaFFP8VdQUFv4qPZajmsnko7HKr7suDw/h2TA/JQorMvotfqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708498324; c=relaxed/simple;
	bh=84d6R1DjzfEv0mguGzV/HDDHEJJ43Y8IJxivMYmh4z0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SA1/jyY5nM/XCHuYm1K69Gt7JXtWC1FFc2uXDOiE2tI+nz/DTnzDAZQv2rLczQH8aB3cO21q3w5kouFcifFPXMDU4AfJAcPSVdLpmcbRR9ThHvODwawEjFmmhUd0pi4WmVZ9BXrl5foawcgvXrlkVditLMb0NREAueJXeIMMHQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UQaKSsVG; arc=fail smtp.client-ip=40.107.21.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fB+vMC2eeqogTu02sbal06tw7lv3Z+1C0O+KlplPul1bgcJx2p/AhaMqVR8wj57v2eevEmVVY0xere7HDgCjRT2er51GiCW7RDQGOBNT1g2w+bs62qhifA2Bczt3NOjG6qunW0O8fCZj+XYxcx6EZcF+2yLVosOGMBNt2YGqu5kQwktFr5zLZQZy/8+/sx4pXUr8iCBkesNUpVnXZ66Q6gP9klyB9g7PfYwPiWNMamDeurakk4LHNUsn1N4nR39jsU/x3iTDgmFIZ/wz9LUzalGOwSt+Por509Um5YqwnOZx0D1XjQ32PTNlcOmd9DOhaOh4GPjvEFhJIA+hdxb3PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9fOD2PdxJFOZn/4B1zkyF7lrQHB0KFowI8W9q8vrZk=;
 b=avvCN8VfAQFOK8CLE3+b8DpArvdu3cmPT4MuRVZlcJbbMzWXnaAnzgqyV9ENsdtMazpP6gnSZFsRS1LXtWchbm0pg0hNJ4I19aZsLxp/VTSfMrTCheSpPylDJ3BtcSxFU0HdJcDqQgHohHWAOs03v26HGVA1ErZl5yIk9Q+nrbYmzPhVvqx+beWSh0QW3Ynst8qA0u7bJmW3yS4P8MMdgRkktmkLZ3E20XC3YyoDGDphCaPnpzoOkjIvtoHk93k9JneIKQ+xDYOT8Y+zJ1Sn4NRDUpjBsN2l5I5Ydc/v+alpG1/QayMRZtbPeOonTIBuFnw/RxI17fVIAqWF1KtKwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9fOD2PdxJFOZn/4B1zkyF7lrQHB0KFowI8W9q8vrZk=;
 b=UQaKSsVGchmdS3FgRZPaj9sX0nQw1XhPQwwSlflBjziUylwT7noxt4MrcFW9tir/SJMnls2X73GmiXJCULr1kmQzoaPsVptMu4FIJ4qlXZE3QVe72/3wESKi9fI55S3rdY4M1G0MIFDCvvc5YrztUs7bL22HeZ7qSh2sbUByF8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PAXPR04MB9304.eurprd04.prod.outlook.com (2603:10a6:102:2b6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 06:51:59 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7292.029; Wed, 21 Feb 2024
 06:51:59 +0000
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
Subject: [PATCH v6 6/9] dt-bindings: usb: ci-hdrc-usb2-imx: add compatible and clock-names restriction for imx93
Date: Wed, 21 Feb 2024 22:58:43 +0800
Message-Id: <20240221145846.1611627-6-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221145846.1611627-1-xu.yang_2@nxp.com>
References: <20240221145846.1611627-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|PAXPR04MB9304:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d9702cb-9c6d-44f9-65ab-08dc32a999ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HKIv0g/4CJm7TOpN9wmy5RBEWnkecW3oDSoDQqX5rkMaOzmDKsXDxRMNiUfRk1bIW9L0qgRgFrF0UxlnAdCMMrs1JlkGvo6eR+f++d19lV5pcc1md6eoAMNrsIB+tE3mJc6PnrjywwohW56OLcVd3GCUeH5IA3j1ZJNFBs29zWpa80Iu6cpQxUqLrP4+GFC0SlWBZlcenIML3o4j0N//fs/KOtqht2IWxIre2PEET2IBTL3AFBNfDcKFUumuxzM9Kdm6ZPjEMNaWpu3ns2Mf1Su6lJN9K9EJDGzKqmWPY1AtsK9nQoPY0fdInQhZ1AzuWBz2rEjgsWJphfa0ZR/9YTu2hkMJdG4bB/QKleriVQp4UbwOmmCTsvyobAujvDUcXH9ZKqlf2fUQKDYEReb+Az0jriJU5ZbZjKrZbnsRxgehMaOmz1DDTLxee4tpPh9n9egjuuX9O2tB3nXEfDGld8fTYy50OHtgfnmUOhBGZfRK8Guce4i950MU3KWgBcXYuMOK0uERs0QCGLwPJRCL5cpxjT7F6X1ulyOje+u1rz6evoVScLxfntyQlGAmSHKzY9nS6HZFs8FZoFtkW6bnqEgP/utgmz8OOyKBbSO3vMLbfY0m+VgM3dd6YN9XOxJR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cCIY+C356jxTy747VNs6V6jJXFKhbDXFmhHYhUzW2BGS8jueSiU2xycgaH9L?=
 =?us-ascii?Q?IeRnDAfHQLJkNnKy0aKXaGckbl2X6yvNfGGb46TM35UTql4NIvOS7KXN4nLt?=
 =?us-ascii?Q?jC8hPzzLHh363QZlRYr/YPmg6X9wLJ02gi1V0VDw+bCBAp0MAgww5vFST8NK?=
 =?us-ascii?Q?3vtRqu0fXgDQUfXjgs64Ec32HGgXjPiqR+OsbsSxGHCsFmX26eRWF+bqmyUC?=
 =?us-ascii?Q?RYs4MGz9h1e43U3zKzox6tql6TXii1jQbxkf6qls1gJZpS/Imn1Lm1DWQdX7?=
 =?us-ascii?Q?hmCdyws+DANe7E0kOQAIZKinJbZjbmxF1kYopV5nQKQFrJB0p5wCSmrCi0yK?=
 =?us-ascii?Q?fll85hehjxR6wLmbJwMgY6LlBsnJxFhEF+LyiJ5gNeBqECBwpvDRhbi/J2uL?=
 =?us-ascii?Q?ng/UWFVeJ0Ifi+rbkgdHEKfx709a1xNtC1IT3IiRIYnEmHTNxusbHvFnEYNZ?=
 =?us-ascii?Q?SM2n4j7YGy2169A4CxOPxpo0f1yFeHQKvKUflaM8+Gv1CkMDDrqKFJZub8WC?=
 =?us-ascii?Q?fmYI2YPABQIC4nZlC+uz5y8GTdMZ07tSAWGfit3XGhXU1MeJD/UVolJTPJUv?=
 =?us-ascii?Q?P/KNl/5/jkGe/w4KOa0YpOMMb1vAVA+6usNESoGrlSSa9mr9RlzEiWv09NKE?=
 =?us-ascii?Q?j0ZCobE8mXYVxbKgLYm9zv7+7fmyddQIMgp7xbNfbg3nbWPmRv9yeB6RR65o?=
 =?us-ascii?Q?BUt2p9JoxDHqM8O2+m2Ays2CUGZmRsTAhkCxnxEq3ObWnN9tN7U0vsRLk8Aa?=
 =?us-ascii?Q?Vjsw6tguDBVX8uuYHl2PBv9tRKn7efc1OtujQszsrc5nIYGPskQJ4hZCkiKr?=
 =?us-ascii?Q?uoagCyCvM4ERsl2lohjwECnSNPw0pQkJI11rHS+Npg53UFycI6GH6eQQxlAK?=
 =?us-ascii?Q?iHg63dJaiwr3Qya8IYZ0CpSBurBF6F7OsdHEWcQudeO7eFNZUSm1si0Ql/i9?=
 =?us-ascii?Q?gCge5pKNGh5VCjIwJH8gosEg4nmnB/DBOOPRHCK6i7rCeRSLE0+ePujtUf9Z?=
 =?us-ascii?Q?TkljMMrBw5ir0IWiFmyFKxapPz3y/3vNPqAhyJMDEOvYntoj0niVjgahUF54?=
 =?us-ascii?Q?7FoeF0P15mdh9TDqNUWNE9UWRV3I0bToWXF4xPxcN8aUP8mEdzQPHfzPTkfh?=
 =?us-ascii?Q?YAcRNVIJ1uHgfnrjd2ZT+h6PcTdfEdB8slG1PD/c09LsaaMQe8ynXeYgvAmy?=
 =?us-ascii?Q?4Ap8rbe8PeqLYXKNmBzvl07+xhyEJdkgpGVsCDcImN6EX4afh/P8TztqyqRn?=
 =?us-ascii?Q?xKAg6+7pfWlE9Rs7p9+Y0qax6sxvELogqKFaLJs7Hbj4hlct/NuTKf0Y0y4N?=
 =?us-ascii?Q?vXRDj10sSmKnmpEZ6B2j7V7Y2iOkkqjl/5QqvQTYXWl87IGiWfOqxru0h5CP?=
 =?us-ascii?Q?QwisbUGgZDCxT8j7whhHN3ZUZUM62PfSBPr9TFI8WLnpSZajNbY0mfikoR5a?=
 =?us-ascii?Q?E96KvIgJkotrOhlsG6KeQQggbozB+IBYAstZQFnzGpW/JgnJATvgfRuV20aX?=
 =?us-ascii?Q?ltDkNAcTBLisv3EXoX2uWgR7MnmYMd2T47EMafNLXEj8qP+KZyxG6JUQTiNB?=
 =?us-ascii?Q?EYy4Co39Sk5E9tMGTBNQQRa2+/IgUYn7NRt2vy4+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d9702cb-9c6d-44f9-65ab-08dc32a999ee
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 06:51:59.5750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJDEjuyB3caESfrTajuLBQe0WpusKl2+kuTI5GcU6+s2GC8n347EtuiAxTQD1y5Gvwe1BfZUdQzg8vXd099m+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9304

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
---
 .../bindings/usb/ci-hdrc-usb2-imx.yaml        | 34 ++++++++++++++-----
 .../devicetree/bindings/usb/ci-hdrc-usb2.yaml |  1 +
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
index 20bb048938ff..d509cfbcf0d5 100644
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
@@ -93,14 +94,31 @@ allOf:
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
diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
index 3b56e0edb1c6..ff826414bcb2 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
@@ -57,6 +57,7 @@ properties:
           - enum:
               - fsl,imx8mm-usb
               - fsl,imx8mn-usb
+              - fsl,imx93-usb
           - const: fsl,imx7d-usb
           - const: fsl,imx27-usb
       - items:
-- 
2.34.1


