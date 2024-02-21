Return-Path: <linux-kernel+bounces-74283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 343AD85D20B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0DB81F274AE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB0E3D0C9;
	Wed, 21 Feb 2024 08:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eT1Pxt3z"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2079.outbound.protection.outlook.com [40.107.8.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8649F3C06B;
	Wed, 21 Feb 2024 08:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708502592; cv=fail; b=Pqk7aYggt9cXb4Nr1IYxRJ5rpG5vaBHdAZi2R258sNJk0l0xFmNdZRohQRc4N4seTocb1IYPR6vdPi8RiDXKnR1AgCPe0eGHmYqUvftrFGvqJAW3DFM+SDGXXlQK7hTnRt6k53EPrr9AE/D9rH3HM9xpQEsZBDv5zlzqAbYMLKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708502592; c=relaxed/simple;
	bh=84d6R1DjzfEv0mguGzV/HDDHEJJ43Y8IJxivMYmh4z0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CFaY7CgmaPT5nrHofhVkUihUOPUvrPUSE/GoP/iSTFeko5mU3n0eX/0KOCDPpJcIfqojEi8yRUOXPMJHRLWWN2Ff6rDclBcNOOq+wNJPJK1075duPCmf6Y1AaAnn6ZeGSUhzRgL2iKsTRe18xgra1MOm8MfIWnsVw618PF43QlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=eT1Pxt3z; arc=fail smtp.client-ip=40.107.8.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6NRH312Op3+7xOWf9XGASUBzi69ryYCmSThQrtaH/gljpEUWYMynmj6ROQSuRmTMRrGBNAyRS/wqcewEt1/NSqpL9WceZal9ou4fSUhFF6Zm+lTTgZ46DHbDHNNYSkI9YMSbX8YsjrEoojTe+lgysDv8ilhF4YOj+5cPlyvCKry38W8fxIPIi2H+j6kYi/2NIya0dmA389ZT1xDZ3kAqj9RDNmRhoDA3OeAwOmo61diL0nW2LPLkP7ylc6OADIHngr+ozDB8cpAhY5fqZsq9QfhOoCla7zYrRBs8hECKM96Y8GAo9ngF/KGYqP4Q42IFQn39LhnWqw6bFN4rlz7EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9fOD2PdxJFOZn/4B1zkyF7lrQHB0KFowI8W9q8vrZk=;
 b=Ry25lvkibdNr/z2dkSdDOOOrM8UNG46DaU1uC4l5xW8r7dXuz+35voUuuNuX/kzYWl8iAzzSg6qbJbTjz/F0HlJBl9oxSIAt9LrJABgu5H8Ur25192Q5ugBx416HnYrPLKqT28G+V+H3uAE+9GBVdJgR2dwozLI+QEBxrDaBZRnnhpAaOxLHXUItESHhskjkJfo2ZK10B5Fm9crddYLJRyBMFA8Qy/5Q55F6RKg9sWzoaUJdR/+jiLDHGoqKGirrMSX/GGgi98VMwYFebc7kykTeyPUgNI7FdORqV13H16r30WgKIAmaWd2fxVjDurxH7HeX7zogffCKN+h6NNTFMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9fOD2PdxJFOZn/4B1zkyF7lrQHB0KFowI8W9q8vrZk=;
 b=eT1Pxt3zBBn+zgZl3F7t4VuTDbZtVdFAbklyu+29EnKI/87HkQ3Y1n1AqjVV28witlxaVAusNpeJOKPjQIBQNjAsMo38C9oWdQm8vqj/ZAIvws44Mrtg7DNgyot7GeqaRDux59sfGFhj9gzfNKPu9CzjeiWF7EsFaXwW75zEGAw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS5PR04MB9770.eurprd04.prod.outlook.com (2603:10a6:20b:654::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Wed, 21 Feb
 2024 08:03:08 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7292.029; Wed, 21 Feb 2024
 08:03:08 +0000
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
Subject: [RESEND v6 6/9] dt-bindings: usb: ci-hdrc-usb2-imx: add compatible and clock-names restriction for imx93
Date: Wed, 21 Feb 2024 16:02:35 +0800
Message-Id: <20240221080238.1615536-6-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221080238.1615536-1-xu.yang_2@nxp.com>
References: <20240221080238.1615536-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS5PR04MB9770:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d209c9c-79ac-4cfa-8676-08dc32b38a3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QwmLXqHqMpb4prlhf6kmTq68O8FWjugB5WgmF04kjCwh09WHBoPJHNld3Qv8iSwfGyzzaNf7aUJr9bIpc/OUSSEV2A722Yb02fU+7XqCTfJ+mQr9iwOH3285ocf+zHFyPtNjcL1gAAaq4Nf7Gfb0OKoOwvMN1goAgobEUZSRrkkS7m00Ufw3oeqM5qGP3gMC+3zs5utafIb0vkG+Nro+AafNYEHH2MWlLg4xeKXNkH2e4Gml5RvpPZOIbMMbG/U7SuRrDE7fETAK+hkWZRUwY+RPLYQ2Djn24LB6Omz9EdYeiL7Yi24K8oBo45wRMuH/rvyEPg0vl+AEHiGficrRfXRrUCdkZbLqD+1HFGu2mASPKJ3MGF6UbLW+gjo0pyuSLH7uPp0Rbk4McI5yfDfcjXbYLxZ6+XAcpqQtmcIhtAEW5zYe1Clj1h/lfM9nQIgXEcsAiv6DZrnhCgByr3H7HLGigFLDRhgSUwQQdy6601HNqzYGvrAs7zDFYBrxZVqumtlb7MdklJrzg1IlID0kbJM1cuC4JQdF9QV8qlYaKSTWqX0lKtMONG9BUboiV9aEAa4Whs0WZMJrMH9PgjTN5vhLuBNz9pTARq9KXvBIC5RJunP39krC6+BzMxPRI1ga
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hNyGc6RSq4/zDQ195mBzAqdeALIczEyjTe6bhtx07B5RNgEttPyHUHbS9q27?=
 =?us-ascii?Q?ehRFAlreb7E0dem67x5BCXOKgw4dzLlM94/h+UxV18Mgi1riqLy16SO8uEUa?=
 =?us-ascii?Q?ILjXgwigho6hqmnd6k8Km5SCTF4nzsXegXZsstm31AaRk0C2ca5wX/NgOhTs?=
 =?us-ascii?Q?Xw62UyYggYI7niIJ6Mr4bYYbNtVEZETzfwZJDupdMOcSEHGYxSziYzRQXum+?=
 =?us-ascii?Q?7TzaaDeR+DBEeE6LtC1mTo78yVGxS8QuREU2xI3S+yqFFf8Gkk8FBvWigryx?=
 =?us-ascii?Q?29bFIJKsMaZOQWPROKHeQCfQ2Bu4meEod2bpl5Xpq6XxVJims7yJhyG++w4U?=
 =?us-ascii?Q?GcWzMJXGaCqT78sLBETLRPTRwXBiPv55VZ/Ok6SOFZa09t7fudymo9Kkn3D5?=
 =?us-ascii?Q?QP6TZMyT2h0rwvs/0UcNd39CtXxvE/WLT//ynSQC2z1QpVtDkIbFqBsVzexb?=
 =?us-ascii?Q?7PKoeqdTPwCEVh37SDXknozu+05Wc61939TWbAoHS7tiy7MoojAK5cIGgPXu?=
 =?us-ascii?Q?2JjlAdW0fTpXkI4EzmJG4oLoxypVMZsscNCHTLHQBJc8x+Jz6RAGOLh/+xz1?=
 =?us-ascii?Q?NMngKPJQrLPQpOPS3iAi0hnU2mNIY2geyQd6q9aGPjfZL+WYYvb/T8XeUinj?=
 =?us-ascii?Q?rwPWQPy/mTqdU3HywqXABBTXwz7qJphKJzcYooG6tZKTdYYVeqGCQGxO1fDQ?=
 =?us-ascii?Q?iASNHuAf5+pGfZnuy3xR9Y2mSMSJ7ce15pxlJExkpjA1R/jL+gECYdEAZeOX?=
 =?us-ascii?Q?iCcTfN/C2hMPlAK3e7C4EtQnKQAUYdB10+y9OZ9yNL7jLV0e9ZHGXBqjsVAq?=
 =?us-ascii?Q?a7KZZhj/0CoBy6nFmE4ROTwjQOw2DRngePSrW+tfdY09LDrq1upmKKwScu+l?=
 =?us-ascii?Q?qNHF4Ahqi4npm+jH3LAHwnzPB7j79w1piMee+cw6lGC/ExVHS8ZzPRRkpt/k?=
 =?us-ascii?Q?+yA6rJjJGWy/1FmqTx0TGnCbbuEkXYO/A3u8ghPjlQuDsySgwjekem3540m8?=
 =?us-ascii?Q?Pmz8HdqDaoSnm5cM2Ir4cAIEnFGmcDvAXSA2H8wkm3nIb2nA4+62eewIvhSN?=
 =?us-ascii?Q?a7METV3htpdUnZxl63AhHD9NJ6Lu5uEvAWK4IGOyQtpGyEeBYbzbIOIeEJsC?=
 =?us-ascii?Q?fYF1b8YfzsiwDpaWC/BAAFkhxLdyk8sczlc/Cbe9CJ1zxNz7BhOw9Qm6K6fq?=
 =?us-ascii?Q?sWdevuoLR0baH484Ie5wRSy0oZxKBeas8RvLhkazY4fyisyvW3l2EP/2YJjk?=
 =?us-ascii?Q?dGZIY6CzIao7C5djPa6c4fr2Y39ddNERX/hOUyPHx/oF4g6Av0axCfahHa5k?=
 =?us-ascii?Q?6dRurcWT/fcmnKPwrfKYSR0jqnoaDp1WsLo/S5/otskEkGyozDXCC24XbmOi?=
 =?us-ascii?Q?PE4ngHY3Daf7g4YzgOpnbrgBT8SerORQ6DZa84lbfhF/hQqjdahfxuMIFmJn?=
 =?us-ascii?Q?nxfXVCf4YpHX3CvVQv/m831xIJL7qHVSZ4cuWsXgCPXLdseHENhO9E6SDViB?=
 =?us-ascii?Q?hMA+6oFjy0OjshyKCDFrsHwz1IjvN1EMNYB3A11oHuoVNrQ7Ge3QKejw5GQ/?=
 =?us-ascii?Q?0MX742zSDxvDWOTBY9EmqEQeCJzO4w9oQQ8+uGGU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d209c9c-79ac-4cfa-8676-08dc32b38a3b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 08:03:08.1152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pTIEmAfkiPQmBBeajaXXaWao6IX/xqqqpifXmkkT5LNavqDFYWI4/tsyQSNfRlsVNR8W2dKcK1WxaT2SQfCVGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9770

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


