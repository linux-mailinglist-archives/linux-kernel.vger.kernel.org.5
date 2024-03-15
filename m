Return-Path: <linux-kernel+bounces-104111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4E687C915
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C7A4282D09
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8402B17C98;
	Fri, 15 Mar 2024 07:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pmDRodPw"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2054.outbound.protection.outlook.com [40.107.7.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A940C17C9E;
	Fri, 15 Mar 2024 07:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710487513; cv=fail; b=hLBnM/11uFFbYEtKQFOP4c1LdFi+dM9Hax5sf2sULdjCI5djP49B1OW1hwhmty84h3avHefVsfYZbQJQsyGE4mwYyVPDaPvRSZhXS78ssiI9o/rrAVTg4LO5w9Q0XXBL+U5XsuT09thPtwA9DBtcYUOTQ4B2OeGGVFWrzR+v32I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710487513; c=relaxed/simple;
	bh=Jyp2cxDKcdQkoro5NIeATc1XtI79XmdMYDrbyqxHXJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GaGUZBbmngseiRG+88/xba3DHCqTwYX+9T/m4lmlCqgw+3IgmwVLcBrmAFzJ375THICJs8xhC4BMzPpyRC5HxFiSqTlTpNJAWDeb3SRIz244fhFr1CixtmuIHbEJp8/d9Jml+oUKfRdX0PVqd2hXnZAT5j1KhWQaDsDm0nnkgqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=pmDRodPw; arc=fail smtp.client-ip=40.107.7.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOaJ41g4OedxYX2nxIUBn/r0DaKtQWzflsswF3uiSwmfzRybnGWjJ4sSml23aOkNlcrRlLbxp/xJqhUpPvTj6S3RgzqacLq43T5IpFdq3t3iubNXBwJ7eJkQhLujrv3Q1hBFld2AWImLARtojlxHB7txCgZaOaLc6g2/UmKLIQIAO2U9/JczQf9oL8QOJbgLU27VQTxN76IfslMDl2gLr8aeRPbpl32rR4ZTS0ceIdSoyEgYzDYJwSw5o8o27bgqH5mq/UVdFzlzyXrQr06ebiBIyN7lPsXJwPWkRJTz/7zsAvINI+3HBk0f0ORy3J4MLWv1Ff0qhDwOqXnFbWnbNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LzmuZUn3wfVs7+EBkFSeN2WegzeKY0qUXBHUjJwGbc=;
 b=kfcz0TIR4TAcq1BLiBIxyLjFDdx2WK9jMc08H8j43PQwGf1p7EwhDC5ur7/iA2BLNQDclemtGAzxYJvizERQkiJ/CMrYIFC947q7b7bNOCC1nc1QoqyZJVjP2B7T1PT0rPyLqhV8FrSC5OjFIidpXF0BtwN6Sc/9cICNY/YPplQTfKXPTDOcMmSwWn7f0IhVnZ2pAOykjX70MqrF/CVfbAlx9AX+NMG13fKB4g5euyvXEtmao3V9vU0JP8xugHeXvo9QZhBklwHmztoN7JLkij0oq/MfybD7x2XBfP9ytMGHdlkdE4GOkbV977HuaDMzRPkgKF6E985/vEakTqIG3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LzmuZUn3wfVs7+EBkFSeN2WegzeKY0qUXBHUjJwGbc=;
 b=pmDRodPwNrT8eSDNPL/RVS2AEUV9TI+2KOAHqjq/UPA7hwTAtGoeHAyaDHqpbga6cdb6GtVZVJSTbWt1LJQdQPhxvVay70jim3ZeMh7kZUJKm0hZoG4QPGm/avv4pqLFCBstSmnYxWeEH01MpfoHXbugWZs1jwp61vVuogxc7kk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DB9PR04MB8332.eurprd04.prod.outlook.com (2603:10a6:10:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 15 Mar
 2024 07:25:08 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7386.021; Fri, 15 Mar 2024
 07:25:08 +0000
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
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 06/11] dt-bindings: usb: ci-hdrc-usb2-imx: add compatible and clock-names restriction for imx93
Date: Fri, 15 Mar 2024 15:24:50 +0800
Message-Id: <20240315072455.2481613-6-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240315072455.2481613-1-xu.yang_2@nxp.com>
References: <20240315072455.2481613-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0043.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::12)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DB9PR04MB8332:EE_
X-MS-Office365-Filtering-Correlation-Id: e275d3f4-e938-4d36-40b3-08dc44c10adf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NGJl8Q4TaZ6rV/86bLO1aPM0hCneayrM/YHXXIX1fLPJRFTbI7/qpAkHVn+NSNvUcUZVgYDqlaOxKe+sw3GxNQqfvKfzX6eCD1KiGGBs/D45Oeb4amfwTZzoab8gsERGdApxBICVPk2zl6HTiZ5gmg4DOGlmkM9KW256ZmBhCuWtuNEpVBj8gq8gcU1OJjomZ9jGXZdBpWfFodK4SKxKfGEGAG+kumfv1BvJonpR6/i9q31b8vvEfALEeKAGy5M/XN7QT6B32VoTsvSdMrRbpOcAKUsVuI9GziSsGmLNweiocnxDFbOvCOv2oPMgkgMSLpENLRV98+yagizilxhhZWkvMb1Np2jVbGp7KT0CC40D9IT2WYwUk/F+ZCrx+Jc3FfXUHPqWPkU583k2DkGC/KKyeZrDS2w+VisLDqNqWBRK9mDszd3DYddTZlS67FsOK9b2lD4BriTfO2HeE+BnVMxVfNjCy16Iy7eZnk9h6ziOmWztPKuQ/taqI4o5f4tZ+4/5Y8pv/cwd+ttxiVoeqBh25BSbKypGYP/vJ4DWHLTfQqMLA/D6SmWy4Pg2bw2tpebTsmdamSJ2Cle3JyeIqM1FaU2E9oDnnzG7nkR2WDL7ptfWR57VMtODJNZ5sPyIvtx5odvvH3Q7P+JcfoStlZltq33v0zn0I8jOpVBydxaAjcVVIA2TVtqdt13wc13x5Ti0Rfcas1A5RsCou0WnvQ7Rz8j9aCK6Yd18BLZ3Ixs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HvLMszsULjH6oK0LS/HQJ4nXYpG7XT+/VCXKY3pjVr4Tpjyix1GoQQAOhaKa?=
 =?us-ascii?Q?x+4GkuUWuCPJEK5KzuaOlVIST5vhlBvszQzyx8Nm9Af521N+uceeG9yNNCNM?=
 =?us-ascii?Q?m7JLKOUlfn1wrycfhaJ8g60QO+un8Jjqr7p1t6HJUaky+h+TwhDKB4L8TQRb?=
 =?us-ascii?Q?4c1e5pB1noU6NsHu1DSH5yZGZD8x8FY3SYelWrXZyhTgpB9UAguGMOoEoE2L?=
 =?us-ascii?Q?dxNqJXLta9uW722+PTS7Yzn1dmOzpWgc97svaT3u9dFoYw71XJxQcR96hRB2?=
 =?us-ascii?Q?zgdRx3jSNHHQyKJz0bHF+uRQpGUeQFXLS/ojmV17ghzwVI4jYfHkJb0W+vuJ?=
 =?us-ascii?Q?9FEsjEeuvFsVJiWBfWCzsgy46OFRQSbYiDmbBosF+hzuzXsGHA9rb7ILGf8f?=
 =?us-ascii?Q?/7Uksyk+OZ9rJThX58K5QS/OXgzL218D+CLf5Qa8JomMkA+/PtTVtF7NnQ3Y?=
 =?us-ascii?Q?9C6EdtQfrIHsItMDIupf3qlOSM8d+TQnwyj3cnqiy/xYcFHnFFeOpfiaoldx?=
 =?us-ascii?Q?YTUn0wwrPzVAxO/ciJI3j7Bu68K1xDRvGlZe75Vqa6ACDzLVwmnf+Jz/GW5D?=
 =?us-ascii?Q?pHu4RAyIrPD7zYB21OfFeo6F54v8JI+eBcAkrbunuqFz1EmU7XkfQDghRZzG?=
 =?us-ascii?Q?U6fHy2C0UfoPBgGL40wfa4henIXvOjFi05p5W/Cw3SzNAY0MuKXktGougvFg?=
 =?us-ascii?Q?HRMUoXTgvlFhtRNpjUGgqmXJCYTBEFJyBfUhlhcsvbrgig+C96086EEKG2FN?=
 =?us-ascii?Q?nVjbhWvOq4saWA3TV8M5DObNY++sS7qTfCAyqOn7ifKcQQ4M9j8KZAAB0tz7?=
 =?us-ascii?Q?7zD7fgwD19zclKXjfaa0T2gwn77hNkAhe+kvhSZD+iBzODeBOGUmWBgldrh7?=
 =?us-ascii?Q?vBKz5EPO+951Lef6YexyghRk+5r6ONMdfakZ19TT74e7lieeXlzpqYHPKLRz?=
 =?us-ascii?Q?uaRbmV83bsrEi7Y+2RgNYb7oTngRy2zPRCgFfITlsULmwNUjTyBViV742yU6?=
 =?us-ascii?Q?Z8dyNVHpdSjG8yZSz0p9mVx63NDZHi3y5ItUiG5QBZcrRCHDB7bAHvuuNtHx?=
 =?us-ascii?Q?QuSJKWN08xjFkkBkiZVhzbq2IEekweOlvDkX89Gm/csyHPsrHE+U0t4lTOOm?=
 =?us-ascii?Q?ReKdLKf8HYyOmqvuPpF3OjFjf6fbwuZvrjhNm5QXoxQ78Ys6hvkNJcloAefW?=
 =?us-ascii?Q?odbSehXWzPaBDOHZ1NHLVAliW8Dj3vZL3NJRt1yFZI4uXD8iTy33RlGxC/Vk?=
 =?us-ascii?Q?hGI41cyn1+0TpHB8Qz921eCTgvq4wZXSSaz28U8Y7o3UyTP88gXOfebxGxVw?=
 =?us-ascii?Q?vp34Bf8B1+t0UO5V7h1wgxuX0xyelMCD1uThPQ7d0XY3JHrBv3bhFecxY/dk?=
 =?us-ascii?Q?gOfYSwD6EbF6sUERYh9QJdQS1FGxROGgLU8WHslKsvikCrF4jyqbYRVV8gph?=
 =?us-ascii?Q?beT8xlPPSm9SJ1GwOiS16Z/KLzWMsKcjydCoNkKuGXc2VHE3Hvbos7310GqP?=
 =?us-ascii?Q?lwTBrIHc4Z+MiPoWcWFkmVNhum6tvD6x84By3x7Ntdg1bY6cm8wn4PqzD8h3?=
 =?us-ascii?Q?d7pKwKsg2UTOcr8aMMlFqDciNy/J3rVQGi0RaOVj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e275d3f4-e938-4d36-40b3-08dc44c10adf
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 07:25:08.3457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DwtQ8xM6Sj5QzjS2cU1EQhBphkCCvSRIMYr86Eg2ng4HDfLy8ZOdPwFvcIxF129ykq2wKDgZ+ca95qknlyKVVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8332

The i.MX93 needs a wakup clock to work properly. This will add compatible
and restriction for i.MX93 platform.

Reviewed-by: Rob Herring <robh@kernel.org>
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
Changes in v8:
 - rewrite the restriction
Changes in v9:
 - add Rb tag
---
 .../bindings/usb/chipidea,usb2-imx.yaml        | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/chipidea,usb2-imx.yaml b/Documentation/devicetree/bindings/usb/chipidea,usb2-imx.yaml
index e2eb60eaf6fe..8f6136f5d72e 100644
--- a/Documentation/devicetree/bindings/usb/chipidea,usb2-imx.yaml
+++ b/Documentation/devicetree/bindings/usb/chipidea,usb2-imx.yaml
@@ -40,6 +40,7 @@ properties:
           - enum:
               - fsl,imx8mm-usb
               - fsl,imx8mn-usb
+              - fsl,imx93-usb
           - const: fsl,imx7d-usb
           - const: fsl,imx27-usb
       - items:
@@ -183,6 +184,23 @@ allOf:
             - const: ahb
             - const: per
 
+  # imx93 Soc needs two clocks
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx93-usb
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: usb_ctrl_root
+            - const: usb_wakeup
+
   # imx7d Soc need one clock
   - if:
       properties:
-- 
2.34.1


