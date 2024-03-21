Return-Path: <linux-kernel+bounces-109767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 181F1885570
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC3B1C212C0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEDA69945;
	Thu, 21 Mar 2024 08:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ApNQ0wpt"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2057.outbound.protection.outlook.com [40.107.8.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C8277F3B;
	Thu, 21 Mar 2024 08:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711008896; cv=fail; b=sqzPabvc7fFO1bx3FdHUKFno4d/HDDJfqtnARytxfzyNal/2krYRu/eyrlCsZoPIgWWfi1MljSYG1t4ibb00K/9TyaBZsYWb8gYipXmHOPWsjfO/nUpG80QcjpVmz2nsNUP4pLw/vO51fnTv2kXUeDzqVWAmJX2GRSrTjbn3QsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711008896; c=relaxed/simple;
	bh=CCPXe444/w1DYYMZ3YyxnbbQDnhjNqNbwibD0+N4oIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nE03FLQX3LPDB73CIo+CWa+Asq8+IGskfHyGuZkJmsK2FEzOt3RJCXLqtu5aHD0dTJRYH01RVb/YEe+nC4atuuxXAHqhlItKBPaI6qrji0oqMtvhw10SlrgdakXelrvX7oTIboqhWrKnildI5+BMMwFztuWurvju8rWyElP5LTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ApNQ0wpt; arc=fail smtp.client-ip=40.107.8.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiHTCZSXsGURnHa+aZuFo3D4832/CklsfaCVIY9NrcAZ3rJVQDs631awvmsipnJVw39kYhiAmPCclEF2zm2r05IiJNAM/Bp77TTAjPK9vnspdWiUmpfJC4mQv5o985ydEhdv8zpAtg7qjB9Kwfl+K6l0WI/Db4YI5W7jSpvY0/EWlzv0nnGtLhGlsHW6w9acEZ4pwyaC+6QgzY2/AK+/7p1iZkQ/+DrIMR7C63/ERkHyLpL6oA7mg1tWgA+VJqO4aSyU9CqHbPYJ7Jr22yaiBgVOto7JQMRCxaPPH63oqDsiMJ0Y7WkwNY92Yacgb+xrzZiyN4fY4SyjW65r4q7kog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeFMEyE63d76LT40ZCRB1CvY+6xkoN9CZD7zDmnFPd4=;
 b=VqD5isvo22bLmFGOHdsScyuWeCiokBlxk0HouiJZVdQrztpa43JZ18Pwex2wXIDPoekoGrKzUhiWG8WDj9jBd3SlnTaMd2P7wyqKEvxLWz2IUuaCdy+vA25ouMbJhAKSJFfXt6oQR5WQYU9AN6naNYeH0UAYwukzrGAPnMN+91rsW6zA6+PBEpX/cgfa2o769H9Q7uzE5DmXEUFPBgi/XQ7nQpa8uvZ6h9DAb8ntHQW2iLODPkQRf//DJVC5mBh3+fW5BCVPG0moE6n9sTZqyVxddTWK2ynD+8i3O35dEqXcasCJanqMYjft2KX/+6VQj/jBUvnJvFJkqJn7HpfQIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeFMEyE63d76LT40ZCRB1CvY+6xkoN9CZD7zDmnFPd4=;
 b=ApNQ0wptWO22q5b7PvzucOM53rjoAKyZ2AdYjCPwWUnx7tfSD84doWxBqgZJiZXOjMlu+TBEWETy4SMzprf5ODonwCs2U4VvYdyt9dVrBeZDlUhn2utN7ukaTvL/TFXuN6Led6/2lseoOouThfop1ROzXZjaqtaRp/xb1lU9dbw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB9191.eurprd04.prod.outlook.com (2603:10a6:20b:44e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Thu, 21 Mar
 2024 08:14:51 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7386.023; Thu, 21 Mar 2024
 08:14:51 +0000
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
Subject: [PATCH v10 06/11] dt-bindings: usb: ci-hdrc-usb2-imx: add compatible and clock-names restriction for imx93
Date: Thu, 21 Mar 2024 16:14:34 +0800
Message-Id: <20240321081439.541799-6-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240321081439.541799-1-xu.yang_2@nxp.com>
References: <20240321081439.541799-1-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9aec85de-9940-4a3e-623e-08dc497efb50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4nOoRrmzNq5pF4Md8pPubRTdirM+AVJ26jnyWEryz2AF5hfgi0s4b/QSEpLjAA30iKA5MBoqmbvbFn31AZpPcguFeZWRKUm1gt/xGLCmcITmOXWe0V+nhoO42saWZsOf7lCYldWJCiCPHDqOIlvmBfq0GHKrWZ1Eetr98cKiHwFIuc3yPNwDmRFESgb2XAmGhrj6F93/njdUmOoggvUUd9zHjVtoxn6trrWcXG+Qvh0zk0aFfeuNA/Ku9R0nUwYcRORDOo1Hrp4It4+yTnpDKlCTPc7K9qz3cZ1IZCUqtH6IvdEvET6IMBomzMu4b92NGyE5O0d0aqhe7mVz1rlTWsPixMB+t8c4SEealRLDseEOm+bXLcMDOuZl8sicBCwJ+LnQjVuacmzIRmY8v/8fwsqa0mXJmdQZ45hUXgCRRg55HacqaXYKvgxM+j1kJTc92bWo0jyK4ABG/bxs3Dy5Mfg1y3J5Wt5TBnOKOy0TXPT5FjEhMRL2cLeVcWcDA3o0E7I3+LcRIyok+zqRPGXUiABWos6a+NoY+9wqtV/YV5CWsyBx+ZsKmvfBTRoIT0988Itc04NcglYn6WMtDoEqysIFRiEzEEe0JnnyeCf0oaWM7I2/FdNFPxMocKYR+fNaEl/KQA1wK2AMgVDrzBndZZeCOYzmhymKMKb7g5OwgbBoJgN/DarMKSShF5V6A2SGdUCQp3gGxE07GWL0X4c7YaoWbjsMLevwOYeLvIsWHb0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(7416005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zu5pF77OapdPFb8/1FTNoAMvW/DpyqHRfdHudmHHseUrWjixocB9rpwvufPs?=
 =?us-ascii?Q?Yk7XhMgqKxRBXar6OHCMCp7ZBqY5syBKXwf25+oStlesf1uvKH8CkoIoCfDm?=
 =?us-ascii?Q?gYLObB4wanyOrsKF+7I/loGQRWya8nxvf7a7Rft9/XAH5/FM+1v1bEBIGnKo?=
 =?us-ascii?Q?oS7qdyh2ehkMertRn7wi7GRjV+udunjNXUKRXhKJ8zGABKEjQqAK5+Dq7wH0?=
 =?us-ascii?Q?NQyJrRjSMEoaas4Ui6FATotN/oD6wYWUsRhsnmjI/B87hltDRLZcuajOTdLc?=
 =?us-ascii?Q?KIQza5jWQSOwtWBK57toH0YQ2vfY4GeRtjbEg6dZQuj0SK/HZqMf+tP7qC0D?=
 =?us-ascii?Q?FIhvn3pyAC5MlaiGb4bbpx+OZhNuASKNs5JSBybhwbC05e+UdePu48wWqq3V?=
 =?us-ascii?Q?fvvsJ7aSalFDjC7GW/KUgapdYEkS6l2dglmcUqzu+nBqXJVfVODLOvC+Q/ii?=
 =?us-ascii?Q?6RDWPfbllBeihGCpH8XanWsExdM2FxdSVQgppVkTOsUVi1Qn/tRx+IXuV1vz?=
 =?us-ascii?Q?YngMI8RD/rGIgMka8nfOcaSzRRMCinhmjwl21o3/onhXW/jbXXfPQ1E86hdb?=
 =?us-ascii?Q?zJ2Y1PqiGrtE3ibQHnxKLAC6i4Q8wL6vLGqtBwmHsXXOhTLHfyPBssee6WjR?=
 =?us-ascii?Q?6yic7bw3Yf1VUZzHM2JYV8NS4QigThU0CzVjn8Jh7qcFgDuQyILrCLUFMun0?=
 =?us-ascii?Q?slbm7bdqAnKHi6wl7CGW8J37cMRfMO95M3S4vKEr2Xp8xLsX6ET0/x0WICH4?=
 =?us-ascii?Q?NJ4+FBY2qtySaULn25t4Hev5DbMdz9LC8TZ7gLqCDDrf1h21kk1NgdBOUMhF?=
 =?us-ascii?Q?bm/tWPl7hATynnNoA57MdlnAM6xoDimwkwOtpmxLx4o+6Xvm32G43O552b7C?=
 =?us-ascii?Q?ozFMKy9mdyd9W9NrgMrz159+DEms6KYyZ437FGoFABmg6pIJe6hI5RaNNMlM?=
 =?us-ascii?Q?8RFDiNyptI8UUcfpTxpqsnMxsUAsYltzTmds+85xWSl6B0wzKcEutPGnSNw3?=
 =?us-ascii?Q?3Ajg1vUH+LNg00fy04KCXuWtt2+OTiCgjPqSFKDuR+u4eODGCOyuwC3YxdTH?=
 =?us-ascii?Q?3RDL4TVamwOlKo/5ugc9MW8Oe/h9cOYpvBL2xA2DNiw6zB8UptF67A10cCuE?=
 =?us-ascii?Q?0ysOwVmUeWzxh8pzUaqHRl5LI9/PhW/F7FHZoze62/0Jh8mAco0+hefGMUkw?=
 =?us-ascii?Q?kTs757xp0YhdxK80Z6U8xm+EjiZgu6xJ/kjnY/uNwDGLKbmLhpLTa+/VTDjM?=
 =?us-ascii?Q?dj27p8MPgF6thS7BMNvAxLaEv9ef34N5Gv66HhkuYyv3jFTIbi84Pko9Rws4?=
 =?us-ascii?Q?6SYZ2yOv/XKPZwnYnEUCUnKwgX+fjoPUS2DqH15gaK0Sd85oLcmKjJVkRO4v?=
 =?us-ascii?Q?x4AJswmflmRaUjGqqsV/FLytksLYpHnpAtZoz3U9lTr9SMpxmyDiwf1j/6sP?=
 =?us-ascii?Q?RdO+GaQCsA0S5RMkytNs7TPH9xcDtLikU2c6wq6ip/6LmiW9vmuS5Sua3u5W?=
 =?us-ascii?Q?ra7AQ6cYz26Q0M7nZ8KafDnI6d3auppESgC2jmj4Fyf4onhb+6/5QCMfO2tD?=
 =?us-ascii?Q?QsOP8rN3Kq6VQmbYRKci9ugRcFPTGvgbiQSBp1+S?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aec85de-9940-4a3e-623e-08dc497efb50
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 08:14:51.3015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EJ2I6wEFISwlKrqSg3SlMLdeOClHlX7Qrb5n8CFLK8ZLiPwbYmyH3rU6JTcylZ8Hf74I23iHZctMW1qGz8rhrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9191

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
Changes in v10:
 - no changes
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


