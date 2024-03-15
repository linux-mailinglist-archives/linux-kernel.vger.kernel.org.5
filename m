Return-Path: <linux-kernel+bounces-104106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E89B87C906
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56D232819E3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2433513FFC;
	Fri, 15 Mar 2024 07:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ou9A47rA"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2054.outbound.protection.outlook.com [40.107.6.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFDA134A0;
	Fri, 15 Mar 2024 07:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710487492; cv=fail; b=KK+jswYff8DJkzWhVW+EAbmP6IToGYmWmpmVuifhHN+1Y0qLHfvcMUbeKXT9gC2GEoxUR9xPibcYjG+5x1tJLdTERnG5prhJITCuY53OHAmn91LqvLTKzSVm4nwQOHllpve9RWQjvMZ+VKrZMZbQ2v8z4wvDDMQafiW2ZUpWgkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710487492; c=relaxed/simple;
	bh=4BDWgc46QNwGVGXEW2IvM6MuFZg2YrNXrqmg9dtvWgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gCcFOxzz1ps8szLSGdohX3JXHydUzHMEO6zBwXo6uB2c+ogJbgNk5+NpvKfEUlyt6+NGLDvwXOE/YbXBzeGfR3zQTd8WSZrkJzuUk1iqj+NFMBfdqyNOEQv22SRzJJEi0HtfCoNcHTPexn5iW9SMGHsGy4JpPaEnHvKJQNyGqTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ou9A47rA; arc=fail smtp.client-ip=40.107.6.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKRkD8ndW6nqqYQtZLebN49xa80uD86gVcFiut0diaapSAUu8eYtRMASfRgb3Ns7oGyHvKyMGEGo9Q0xvkTbDbWCHS/Zw/UqGegumOvFe39/8cRhUD5os9crfmkw50vQong64gnkGwbydsugwp8dTlWm85YOctRj//E0ANk+XyJewlvn0MdAIXAi0IR+MrXp+SrCfD9qXTbx6NUdSjhryCSefxeayv6yZAun2rZKAem/yOaC4FbzrJ6M/oID8jgiE1CgsL6qNu6mg4x+VTSXu3Ot9WZF9+fthtZVq4BtM+F6oDNStoM/QLEbi4drb0gqMqMq95zsJqiwdX0BEfTiDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdaNkvOWo3Bss7v2jeNy+KNv8SzBQRzk9xob1HyxPqk=;
 b=SlP26lbSA7U0ADTzGxvKHG5D5HH+6e/TLuq8Vrp3nmewlzdOR5Rh+xbuEL1QWmgVJ66tc1LCDrAFOnQ6+SjTH1FHvZpbz3LdqKFGGeXN7kuDGGM+yRGIbXfVcWmJCrhUyUMOo4p3E1Jav2azsX5eNbE3RMnaLrSB2DEsFqGtQfwGLlIeEIs1wuMcqrtsPrqYDpL8RfrG5mvWrYhX+Ah0nDHsvO+UbfOE/Zey1MpckhVOxFwfwe9eUwe+IQr2iJ1RFMO5J9JI6Y+LK9nBOQfAVhwq72z71niDJKTfOLNaUZB9Y7SMJdvl/TENyUTXhTTzs7TMUYhEHd63OnGHYCxi5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdaNkvOWo3Bss7v2jeNy+KNv8SzBQRzk9xob1HyxPqk=;
 b=Ou9A47rAJ8tZobwTsgKBvsiRuLznvnfJ5RtUI+Ddi+i04V0b1i8XbtGV5RJeX2rMKGhCdvPEuT2K+NDVE6P6h5b/YDx5xu25f9QX0dAULzG5+an5whNbLdd8x7YPlwiniVRQvq+fiEDdh3O6hQ66ky0HVLIMJM+jLufjySOk934=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DB9PR04MB8332.eurprd04.prod.outlook.com (2603:10a6:10:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 15 Mar
 2024 07:24:43 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7386.021; Fri, 15 Mar 2024
 07:24:43 +0000
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
Subject: [PATCH v9 01/11] dt-bindings: usb: usbmisc-imx: add fsl,imx8ulp-usbmisc compatible
Date: Fri, 15 Mar 2024 15:24:45 +0800
Message-Id: <20240315072455.2481613-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: 728c03bc-95d8-4b41-7041-08dc44c0fbc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8ivjdbATj3MTm+iE7A7VdymoKvsHKgHmvwCgQOito6eIPa1PK75nIO1laIr/f21lf7XUYsWof8slaEDm6j2y+NJ0uM3m5aDvIBwToVTySysOyzFl8ROJ8+vU8hgI/kyLoeCZQV3h771vPmZMaeBTOTzCAtst2yByIvyqe4xmEYhuecf7EEO500NAoAL2VY4n5P/tJ3lM1hSFWbbbyg6DnRFNO+Sr4euPX+o9ZlSaPX9DQtHhzFKFt9VG9OQ9eD+64D9011DJaxcrbyBlqr88XNruDSbtQnMSjKsVm0v9e/pio/sQxNsk0IonTAfA3BgvME1Jg5NQXSNe7QUA35owc1XIfMDH/gCU6dXPQoBnm5fHLVO+qFyC1yT8QEiMUj1c+csfRpqCmhZ/Whva0UYQHlrv6UsGUoOnNeGFzsPQeiazfPAynhyXYyitd8zeP8nDW8HyV298xJTWTNBhsLIrfGZsMrgrGw4HU7WPGYqtfDanqevwdSqUkQlHA1qj2sG/RPMOVxl5Y3bTTVPpUTMwl6vfIIHy+h7KNVKQolcohsCTeA5Rgr+2uJAA9sLPpeMMsRYYM4JwdMzFOD67YFO/8eLn14RcASXTVHvFV1D8h4wva/WkDcpD3XOZRqmI7bySAbanMaJap7LbktV3Ll8HhzQd7sTNprlJkqAkoPkdT7OMHzdbTRkwQfPMlTyNr7efT0Hri687ZH4dfhFX8R8IcahSZ8RSpiAkM8DMBHq84Og=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y7O+YGUHlosvkqk8d+xcxdMGjet4kF1uTH1Ph7Rt8FL8bNouiZb0NGx+cnZL?=
 =?us-ascii?Q?bxPG+0GAIIkcyMrXuEsDtxDvp0tKOMnfZ0y4v9ad4ecj+Fh9l08lHF/3UEud?=
 =?us-ascii?Q?KfhbIUObqkytKoryEYKF3z+sNtv89ZsFTO7n1wxTBoMcKitQEaivpz0OB28a?=
 =?us-ascii?Q?0b+G7k75baabRbprCLE6etpXHMnsWGIniSvAtPtpHGIfktSPXELkVCl4XcSo?=
 =?us-ascii?Q?RhSGM4W4zH05RfJ89BwYLVSeml6KpBNH8Icueau/5NyDgFIesRYBNhJeVhWz?=
 =?us-ascii?Q?LilX1bESRQlC6s2rtOeqczDCIFTfSggMRsUeVGGrUJmKbrDWhEd+SbIpZ07K?=
 =?us-ascii?Q?csiq2R06H9hcElFChjCa9uzzbviwEf2Yzcp3wkaTF/TM68TiEq8lxagsDQMH?=
 =?us-ascii?Q?IKAzdujvyAd9b25S2sIt6dK3fSYaB1BK00yCOXs6ANDN0SeVY79v8aOykSx1?=
 =?us-ascii?Q?Z8UR3C7k7pSJ/asJ63WnXrshHr9CfQnuQQ/WTolLa7XqAyefMXfhehFERvgu?=
 =?us-ascii?Q?NLOPtX9mF04BwxEy4pCntHlh63gTUgY98NaW1PWdUkzpjtj1ENbiHVcq8l66?=
 =?us-ascii?Q?FTfEn0kfp/LoxzyGPzvLqhlsAiWKyrsNYA8qjnMu4s1sK7X07rZ7JJ3bnBFt?=
 =?us-ascii?Q?buyjuKzDk8I4se1ozTW7PGEA1hFYpIJ3yTUDFvxLg5C2lo9fkZRMfGOcit1M?=
 =?us-ascii?Q?iKjEZsFvjVETE2nHjH8KfDGfw7hyAbBi7BqQFHvKaWLnUwRl639TxW5N91t1?=
 =?us-ascii?Q?kXQa8HxR2nOTc/A37oTSX+voVMQAvOEO4+1jmR5E2JSSV1yRoQvZLHaMC7WX?=
 =?us-ascii?Q?GnkMJEavTzcGqQiWk1slLZzkilpx8/B3nmGgWRxbnxOVXlYqJI9insnRiNIg?=
 =?us-ascii?Q?4VRStlsI2vJkqduz91sMTRDifqa95+W9wXvwXol+TwVRxMVTu2lbzHliNS8Y?=
 =?us-ascii?Q?Crw1hSMG14nrEWbtXTo/DJ2TpMQSA8ycUHMTz4eo61M0cyuWLRsgCuvLok12?=
 =?us-ascii?Q?hVqTsRKryR7qJ023kfhRGy36NcyZGnCEF7EAHoRGHZaOC0DjPb7EGv5RCYl6?=
 =?us-ascii?Q?S4PpfTaa7gwABvc1klc7eYWqlaNwUJZT2JWyjkH/YfY4M+macz5pDa5O0Fe+?=
 =?us-ascii?Q?NwjYmGY1pR02z56DCFlOU9bIk35iyBBbnC1WVqc2qSP3T3Ozrg8b7fMFrDK6?=
 =?us-ascii?Q?Pg7q9/AnitX7SF0u5Jyfsrr3X0XAmyBC1vK/10NFrsjvNt6L1lPOTvgoSGej?=
 =?us-ascii?Q?0n4JM8tl3HNnJ54rMnB66QcGdai3Dq5Ez7cKP6bmcLnKHwrbb/FS1whADLj8?=
 =?us-ascii?Q?d6lMzG6i3mYzLJO25J94yo5advfV9brBGq7INSbWkzMgas3LiGOTxOraJDQL?=
 =?us-ascii?Q?+wWj7BWMQoSd9DhePu1x9QwPmNO/l+c4uzpD9/3S79KiRGcmAYKksX5LhF53?=
 =?us-ascii?Q?Z1favGoeAzkrUQo4mL8Faa+d43s5ykWIOk+wLuGcA4wypzi5+A2k+Xnjq8uc?=
 =?us-ascii?Q?B+eTMyrrf+cRrhy90Y9czq2eMLhiGPg7bJoe2Un2PklzXNSfPuigHNfIqjkf?=
 =?us-ascii?Q?6KbNtp/lQsfCPlx2xSZAMnBPpxQj8W0ci4alA9Wd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 728c03bc-95d8-4b41-7041-08dc44c0fbc0
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 07:24:43.0872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O2eu4bjZH0lZhdNRDlc9/ITurNK84GKhIGu2CvBGuvayNaEySfqnkyk5aZpxyWcHgQPjOO2O1IrBSo7Oa4pkDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8332

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


