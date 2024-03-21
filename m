Return-Path: <linux-kernel+bounces-109762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FB2885561
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A31771F21B0E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876A76996C;
	Thu, 21 Mar 2024 08:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IXDDjfwA"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2088.outbound.protection.outlook.com [40.107.21.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A458B1DFD2;
	Thu, 21 Mar 2024 08:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711008870; cv=fail; b=bHRSsdi5w2FxOFP7y1wntqlDwGsy83SkXTp1S7sEGhvqnMFv4MMkl8DVNQWVhn4t/e12H93Xur1h7gaYjmdJNZv5t3XUqy5kdjuhhvSZ5V2j1cR1Mrfc2vOb0DA+jowQ5xII4ZlAhSrBWcrqqJdurx7a6bwn7SFePw2gFPP2ScI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711008870; c=relaxed/simple;
	bh=sRGmEeyhKeGWOaf8mTKNraTh5/baJPdYJeqBnIFd9x0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qRzPwdfmUJc/cS9q6EcZifq4moONwoyEZSC0thK0hBX7AH7sY1rCU+pQNPqQX0bkx7HAckG2PK8ryt0UFJ67N2kYp6eqX1WJw/VfJTmNKdK+0RpHo17FhZvFeglf6pNDSSarfhvyncxcUx+LX7+c5Y2fG53JJnDX7m0bBTYhKZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IXDDjfwA; arc=fail smtp.client-ip=40.107.21.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2ttVEeyQUmiRarxNQCk5xyc2C4y/slFonPM7ywpaKeWg3UKhxNosyKPx8cp6lKOIFzct09AltPGaD0BJpLYpK5VjqHquEHsGzGrk6u2yT2+hj5tezNhBf2qxXC8xukjWxcRHTPBI0KzdebbU4V5kF8aPL3xNICQ85bTEO2RU8C1Q8WMZJC+tgGFkmXSzAb9YdrWLqY/EaLc0I2FocDze+tqRhsujdl32q3dQZvMawLLjYuWqMSYhG9gVe+Z8rlWOHgDqPDX04wS7vF2j/XORRUqBJw633ldZNCa8vqB1i8W794eqDejEQ5zhr2n1hdrUWLAvs1SUEiftF3vw3qegg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSHyOddBEJo9ceYWhM5FWULK+mE9tqxnELWq/3vYdVk=;
 b=Bg6l+3isHzCci4UrRUfP/WwzMBK3gAzWXkqdQ6Ic5tbVaXVha0LIisID/mrvXl7XtOkVgMlpuaJDMVT2dGiNKaAdbyYE4YXAgHfu6V4jFUzssCSrkEy9nWvcknzfHGrL4hrykilmkNtUb+xebD1pchxNloQzQl+jaCcS3exdMysSABZwZp7Xu0ZMULmMRuaa9T0CyFAKoZ7r4fJfqgCxCT5IKnPF9ZHXxF1O3uiPNdRWqW3QE0SKWt2D8IoKe4FTbiCYQRr522teNxBnTZjJYCR7ITShnu5WpKx5jDG5z7LQomoyY+tWkQLNfFZOgV47ZclGQccG5jq1HAej7faYPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSHyOddBEJo9ceYWhM5FWULK+mE9tqxnELWq/3vYdVk=;
 b=IXDDjfwAxbBcBX6DDVwl1Q8QfXw+zgPsaw5/deuLZRzuK2mAbfquOYEwmULdC0xCXAmZmS6eQ0bhdpl/mIwDSmHTLv3l8mJnsMxbcE5twbgyAmSxUdrcXne1tnL/MkA+TxfBcMeJjvAnuDp6Pl4DKSL/Myf/L5c9eVx4PEwqSDw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB9191.eurprd04.prod.outlook.com (2603:10a6:20b:44e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Thu, 21 Mar
 2024 08:14:25 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7386.023; Thu, 21 Mar 2024
 08:14:24 +0000
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
Subject: [PATCH v10 01/11] dt-bindings: usb: usbmisc-imx: add fsl,imx8ulp-usbmisc compatible
Date: Thu, 21 Mar 2024 16:14:29 +0800
Message-Id: <20240321081439.541799-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:3:17::34) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS8PR04MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: ba8471af-87dd-43f7-5e09-08dc497eeb83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8XcKpOxUxBrOIV8H+77MX7yhEtWZdEsG2Wca6+it4+NbSlSmBI+J1aP/gCXJ1RdvsU0YBUk4VNauSM6VZzOS6qYNFU9KIXy8Pjzm1Pu2idWAuB8grpwvJtTuGbTofGRFV9rsDCoBbfoBdG4R0DTxC5LeHeev7CbcFIkl1dWiaGRiiSZS/jDz3XGFZEd2aDTdz5Kk+ixnW8FllY1E28iS28N4slFdUhQxUpnNHm/a7dYx0XC6tzJiJnh76vy6NYRvjkvnBUXuPtpcSx6lT2iP4xwtoAjU1hdpcUVMP5EAjYFLJr2crcA7a5JRVFS1JJMUEmBZuQcBMbzjI+O/wgyD6+G3oMxUc/lbhq63OS1YQGkPcYmq2x1c0sOw0m5Dg7FdnGUpIiMbAsO0tVlLPOCqDRzrqEmGg8G5xCC8ostPnlBpiEFNLni288oNl9cgAR5kI1vWJxjhMlriWWzWWiip4fqzTf0faYSZx8b0gNnsZ1/rTagRv4ld+wq5N4uNBapN34Mfb8s/SAKOw4+ezC6yxiVlUogOu+yJdm81a+ZdCXWgc5b7vZPmzWryiGgOEBNvnWOv+Rvzfsp/UtvLvBOhlpdb/kDFF3P5W2I4EsHMqZ57s9Fx5YA0BXOy4jc8hfh8MPzTu+IGex3rCE+1aSVFqMrXoahE+KkVXuWEUnn+pWyao/cqmUtKNi6TeAmbSMuCiu6gz9ZlsaIqNEEqNobk12rgIALNys6LQuG1KLPDQSM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(7416005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tzk+YriZH0DzCdrGwqx6LX3IRWyRb2a7sYz6ngu8Qw1gULAjI6nhPr4lYiqF?=
 =?us-ascii?Q?z73qPZuv37SD45g2//w9PTFjRPuCoQceemBTBM5osJZbUUfV+xNeCgFy8ZlX?=
 =?us-ascii?Q?6e8u47PBpUvrKTPkolrin+mBCKv1gZTj2XzVt9rI2xGmudn98Xao5sfbnd5B?=
 =?us-ascii?Q?YeMM1TEbei7dXM3pL5NgQNRE9bjNcamAbk1VQH7tasniTAqETQjaUgleQWFl?=
 =?us-ascii?Q?0F1b3d6F8vF22D+kzgVSYDuME3iYr/0P7c/7XQJ2k1ujZuYdKgSzm/ndBIg7?=
 =?us-ascii?Q?57kEq1OLMPzeIMOtUWc7A5fZ4U0FgNYfBNvVJeRLSi8C3eaarFtNv5hClRWE?=
 =?us-ascii?Q?xuzzHGzMZUfQyph6RDSb9Lmu8AjZXKr92Oa1Z0AK6QsIeqeNa/aKedohs1NN?=
 =?us-ascii?Q?DEaFTPtokOyQHhr7Ys5eMAvcbqVTLsChe0Ul0xKx2WMAN706gguAhFFhVomw?=
 =?us-ascii?Q?lvHAq8z0dZTyBGgBf+gZ0knh/8yzC5Yb8HKKFgyUSMSwyNrJXofDH00o9vjg?=
 =?us-ascii?Q?i1QHCVhcW+nJsE4uhqokEZ4NNqrE3LjarPqVGPq98Knad0kWpTXrNVjy7ldM?=
 =?us-ascii?Q?K3CiWZ6BLj0VVTwqZCbYEdx5NiJ6r2svoZF3XHusI+ToQw9DWuFRD1IRHxO7?=
 =?us-ascii?Q?Gq+zgp4rSmTKnmYNDyqLdw2bRJp3lNeg1fTeZhMOuUwfCmZXL/dV/VYku6ao?=
 =?us-ascii?Q?JrV7Jdz1BH1VVaPt4noSAhemYLHKNxITOrAlam8yw8AevqKgeinLWmv1zEt4?=
 =?us-ascii?Q?d/QS8CfL1FMEgf/G0MN4qjzWvJD3VqMVJ9csYHshZnMDUikZ8K3I0moOgd/b?=
 =?us-ascii?Q?F9mQCrFV1xSWazvHxD3rhSKI+wE70sM7aajbHrxhOGiyP+XsW123h2CqcYnN?=
 =?us-ascii?Q?8+ZlHLseVY6UPdBnZaN2K6UxNPQw6gtdhf2q8sJKzhgIaM4Pdf1jZGnvbzGb?=
 =?us-ascii?Q?DauTokvuE7fU6ukY6jvnpcmBGtYuEMFtQXSnhvbmSFwg6QS7uJFU9ZIlp8CC?=
 =?us-ascii?Q?UMBfUmkNnEp+de+sJaBpZX8n7Vk9JWWQv8VxdYag1Z4eKO0qoAO0r3qK9GhT?=
 =?us-ascii?Q?CY/BdMh+wcDyiR/PqW0E2mUupZe4GjcrpleuuKGC16YFd38dJ47yUKADThNQ?=
 =?us-ascii?Q?ygay7n3qB4KJGWSYzbETmzadu64J3U9acG21cBZYbl/26+do4xtdmOdfK7OE?=
 =?us-ascii?Q?6qW8YUZvrJrDm9ueygP3ByRArzCO/9ez0gPGFTDy6Fi3BM7BFuXoMzaP1vuI?=
 =?us-ascii?Q?8gL8C+rCShmoQLJ6ZtmBqSYtIIGjSSse/DYCVMV1B2+qwnfVtl4yBB6vzwI7?=
 =?us-ascii?Q?dPeCxIgr4uLadOAQi51tNRqlbfegQYoWNZ18Amii5fzo4n4ApamIj3pXLqSh?=
 =?us-ascii?Q?3SzxU5dEcMW+DACJdmrVYuncEIy5erRodfiayas3b1tpQMKXBqnVjbzrCoO5?=
 =?us-ascii?Q?zlv1BAy/8sS0ywfNKkAAfV9AnUSSrcr/L/VGguSJQeMHSnFzuXooewNtgpv4?=
 =?us-ascii?Q?ZErRWTWC4IaepMO686W6xucchWxd4OBYHohBooFRtQPHMkqpvZeSTccKeE7B?=
 =?us-ascii?Q?LNoRlFAq8kETqE5EfqGOZBlpEfDBEO4mLT6azvHP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8471af-87dd-43f7-5e09-08dc497eeb83
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 08:14:24.9186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ttG0A9kzernkp1Hw3XtvJ1pndmHJm42s68QmNIwru3ByTDbMGHnwJub8a7g879dc3JdRVntQHAexZ1H64lOqTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9191

Add "fsl,imx8ulp-usbmisc" compatible.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v3:
 - new patch due to missed this little one
Changes in v4:
 - no changes
Changes in v5:
 - add Acked-by tag
Changes in v6:
 - no changes
Changes in v7:
 - no changes
Changes in v8:
 - no changes
Changes in v9:
 - no changes
Changes in v10:
 - no changes
---
 Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
index 2d3589d284b2..0a6e7ac1b37e 100644
--- a/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
+++ b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
@@ -33,6 +33,7 @@ properties:
               - fsl,imx7ulp-usbmisc
               - fsl,imx8mm-usbmisc
               - fsl,imx8mn-usbmisc
+              - fsl,imx8ulp-usbmisc
           - const: fsl,imx7d-usbmisc
           - const: fsl,imx6q-usbmisc
       - items:
-- 
2.34.1


