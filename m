Return-Path: <linux-kernel+bounces-84916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D58AC86ADAB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051371C2316B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9899F6CDC1;
	Wed, 28 Feb 2024 11:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="I+UBOYol"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2058.outbound.protection.outlook.com [40.107.6.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31E014AD2E;
	Wed, 28 Feb 2024 11:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119838; cv=fail; b=t739Xh3ndUbTmBgCOM3BMRjTBibPEauxCKHCbCuP3CSRqMTlCmaoexkgqrIXdTLvQq9BAwRQ8u/rkzIQtDjMuKpVO/XGm7M+yQm3afY5489FPFeI207ANma+jpwwYukJ3lyrTsAIQaZzWA3le/7OlYCflAJTZgACYKHGL4gd+gU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119838; c=relaxed/simple;
	bh=fLLhbZyeMtETsXUmy5a2faG5FytdiDIdqo1pUauoO3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YSeFsuiuWFRFvL/0Oq89sdRMc+Kel0DNgH9358XXiyU3BsblrPF3rPrFNM/vgQF+WrhUVIecqjX3rUGeIxl7tm1j8udIhEUPf+Iso2FdPh54GdNrJuTzp4m3zJHsLO2ogAgus8GU0XtfCq4NCuPrKzhEvaSJSX74DagBp5hLXdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=I+UBOYol; arc=fail smtp.client-ip=40.107.6.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyShy4NcWcyczT4DnkS7TwUasmj1yYZYfc9S/Bxid8o1q/qSqz6ZCVbbe+U2i9oeZtEV36jANKCjVmrbn84O7H0pAulqioKQDQrrmrJAYGRh4H+gaeMyd/xyYn08VPAmIxonqpXhjByKBBY+o/Xqz0I+bDa+fvqSjSKdwMjdtouzSLBhIl47nN7pO16SbNOatLXIt9/ufMyLyhF/hv/2B+e8lnUPjU/kBoIIfUlIKHELSqZQmmyMycuOxAbcy874FL1t1JVLtOxbvZdIORg5TsDvqEnkgtJxvJx7sJw1H+XAPudtARLWYvFv1vn5l+2xzUiB6frbBJaeOvVxdYFOyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SbI6v3CNu5UvKAgeNAqKkcIN5+txtheM0kRA9dNIZo4=;
 b=E8rL8B3WpwAQDdg/TJf9LyQW93b5s8H4F/8lVwchEDQtqkSpn3hPeX5XXFXnlDFaLc3frsIocJ/O2/Y3ajpVMj/J+UDrSnPPJQNL/QNDgx3n9iDr3hJvbo/NrDdnvgj58+DXCYmWesNrxnkBL7Ksc/JdCQYhSJROo/uqewKeDnN21Tk5wZF3bxb2wOqvIIIlUVUfpNcmw/0pl5/KXkbREUHfEzrkjw/Kth3waUU2TGB4GWLYKAS3xKUq8b+BCkfq9dmVzw+VkNBgG0KjP/j/fBneg4UX2jWDeb3J+NcHCngM5bdtIm2Hf+tq+WqZJRNwUqHa8Xu5GNnUV+oXGgS4Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbI6v3CNu5UvKAgeNAqKkcIN5+txtheM0kRA9dNIZo4=;
 b=I+UBOYol0HhdLkUk4V5CgPoqCTA+eliMb1kCdeSEIn7iRol6OTYaH+9oKuDVlOIkQ7TJPaueITu+E4TIzlzqtRmhR6FLkXGU6383sHt5lTjSRe452MpCfOfKYN0A198Xt+naf8OLKEgWbdO8cFXe+AvKBfBLPHnhgx31iHZUGrs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB8466.eurprd04.prod.outlook.com (2603:10a6:20b:349::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 11:30:34 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 11:30:34 +0000
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
Subject: [PATCH v7 07/11] dt-bindings: usb: ci-hdrc-usb2-imx: remove fsl,anatop property
Date: Wed, 28 Feb 2024 19:30:00 +0800
Message-Id: <20240228113004.918205-7-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2d5fa3d0-3d8d-47bd-a197-08dc3850ad9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LKamfVEOmt4WqN7fffoAtZMi9SF4Jut03xhSEgfavKYqyvLzbu+crIpYIowyv/ZrqFHW2TqnxBKwKWhODBxTHHE745GJ8ejL0umrmwFPfCuBLXAXPCWb15g4shoYmUqxquzT7hHs9trJP6BAoMN6RROfquzEvbxIJQRsj5A5heAMYoJtzvltS2qIyScRpmaUZ5YG+/kzG4zyVZ1ORsV4FCoz3f//72VGFd1ei/fHVXj7EUdzWrXOKb78TdA9f2B98/ZR4oX8K87/jEBahcdRzLpudHjVlUE4ahE3AWWeiVEZbDkZpW0YJB4LJn9zcRypvoq2dL+fuFVqKwM4m0GjAe1f49aXsyf5HYEJdKoJWo1yH2X1+0PsI+TO6ti/wNGNFlkUXNHh+hto4jpFqCzRq+DHwDfgvCE3w1R8Wv9Ikkar5yZ6mhnpXjrQ0y49QB1uFHWqEhfU5ZkR0ta+pjITxFhNiDioFhkR9rMCMXsKS3qvtULqngRes6UQhtoki2vKkzutXHAm08VA4B6PNnCmdFFxI+5RXeh2fCa3MQvc+sPVHIZ9ixBQkoq/XYCmDuXSDUdDR7LIKxE3aHz96Vthq8Na4xvWKPkYPlAp6loa+ZHX992xdWA2HXoHVHGsEXRGrd8l57rrdbd0ZTh35R/QWSzbcrRd7FyiDnS6SPIAjsuSnO2+NG7euOG7685tqNu80Bk5PO49v0S7omAm6DTo3Lcpbu25x87nieI2NaRpNnE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SOWKRro7hKeMd+GxWculaaMbHJI3UzLUNw7hAcW7+552am8QOMbjZdIUdO85?=
 =?us-ascii?Q?WCcu9/daoQEhqhOg93sBJiQOAnsD4NkECxPwmZDgAdNtTzyDzK2eE57k3qJy?=
 =?us-ascii?Q?76yhIqqOnQRyxdnXulmU+clUdU4lCdqjm6JEwF1sQlSwlWxL4zPx3B9oZo5p?=
 =?us-ascii?Q?fxLy0zAPDlxCG9OXsnlRFg6PKOQ6099fNtqpHX6S6h7MJC7TxjKwOY2cP2GS?=
 =?us-ascii?Q?jPHxYpRHJUAxeZtS9SqcMb/wNoAGkc2EE/3jXwdtGVYLvCrp2a+EH4TFXVAb?=
 =?us-ascii?Q?BCud3MQGPUfT3G03JJjJ5dZslYiwQjButTXDyM4EZ4FjIyH7Aq/rqjk6NbYu?=
 =?us-ascii?Q?GqAmyqq2VIuSMTc1nZBV+oCSYBVXQSqd8OE+uLG7wXlz4GCZ0RGWIdthMRnc?=
 =?us-ascii?Q?nuuAZNUIRJAT4gyu+ZEpvTZDcNTrwx6Sz9GmPJcKPKGZV1ToOZkTpJYGaeBA?=
 =?us-ascii?Q?cdlZfYFWKb9RxZc8TDevmHzCUtocInoaPn8ZHE1GMyB8t/FYTagJrYWCpJHl?=
 =?us-ascii?Q?5HFGEY7UcYumY2fjhXFpXHHuZEC2huR8/bp7b0UxzM+lJkCOHs759kjbQ/+w?=
 =?us-ascii?Q?8brt3qKKeE/4lJcnETIurFybERsvO/r3yH6m22MKcx4yJ/5GBoQ5Xp+ACHIW?=
 =?us-ascii?Q?HZSAJhjmhfkLCUnPtQqgYOjYflToST6cz0F0SKAso7QwbaFw75TSYdoEV+gy?=
 =?us-ascii?Q?O5tyZSf6Y/hRmVeVEQUz9FnEXtGnA9UVc7iHqKvX0DjzwOKWKOzUqcwZC0vR?=
 =?us-ascii?Q?td+QgPJUdm35TR6EnI27Sr/mAvplEHGTu64TVyJSQT4PluALgt3HC4qGZh3/?=
 =?us-ascii?Q?gHUjSHRE57RO+PvvPElqrv2STUq9s6fEyHsHdkwifPYXwyRBmktagACziiZy?=
 =?us-ascii?Q?i+1ZE2TcFBTALzhZfBqguV4wESILEnr2zLpmpmYVKioplQFfMVmOizoRd7WE?=
 =?us-ascii?Q?lRAg2H3TKxnLegslnauhKY3yIGMS3WjUfn89bp8gHf16tx8Fy1JUVCRAIC04?=
 =?us-ascii?Q?SAVVqMYnTRrfrhhW7eQTeqeIuwJXJwt9hvTWxwW9ASo0uQlbSZNRmCeiQHOV?=
 =?us-ascii?Q?+MxYThA2Of3HfyZ5lrqaTm8fePuvVQo+2b7kMDxTDJJz69QYVS4WOTJkWobs?=
 =?us-ascii?Q?wY/PLMWFfSfh5/nMDlJqV/42NBWiOZtxZheCXHdVRHXumbS0vUkF38YvbDau?=
 =?us-ascii?Q?qhh7KqSyVJ29fJBZkGP+K3b9H2THQ/WBS+z5I8Q3Fr2zDdvngdZgTA1jIbZY?=
 =?us-ascii?Q?ofFtEmnfrK2nF1AEviSUIBxCmNooNTmwHc1m/16uDTP+p4TQc8CnNqXZJ6KN?=
 =?us-ascii?Q?K936nyH7UZIJl8O2Gg9NNKpYCpcg+180qVVoVlJy/1/XerrQW93eW5Uy85o2?=
 =?us-ascii?Q?4PNpeApGYhtXzlzmXpJTBexJAblO8QtumkC+ntGTPI1hbuPj+z4U8UlUf5GR?=
 =?us-ascii?Q?/9p7zYu9f3vQPbfV4fwEkzem9DNSA1jXHvOdn3CqYINLG5sZKrBjiMp5m2Td?=
 =?us-ascii?Q?2rIjX1k+H6U0fW3hVkWykijEzs/UrimuCN+WkOy/cqsoRWhLMUSl3uygQ6UP?=
 =?us-ascii?Q?pDWPIgDwtMD4M0AC0ApFzr8RwSjIaWP3+2OWnRS6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d5fa3d0-3d8d-47bd-a197-08dc3850ad9c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 11:30:34.3954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9x21IPVGzdeJdSxIpuImRLjmLE/zKcgN+WLwRFPvLGqY1q/Lj/znEzMseALjn+RLJzHgg6NDZNMep3c4acJd5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8466

Property "fsl,anatop" is needed by usb phy rather usb controller.
This will remove it from ci-hdrc-usb2-imx schema.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v7:
 - new patch
---
 Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
index a2932af2c09b..0a6ebb427130 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
@@ -74,10 +74,6 @@ properties:
           - description: phandle to usbmisc node
           - description: index of usb controller
 
-  fsl,anatop:
-    description: phandle for the anatop node.
-    $ref: /schemas/types.yaml#/definitions/phandle
-
   disable-over-current:
     type: boolean
     description: disable over current detect
-- 
2.34.1


