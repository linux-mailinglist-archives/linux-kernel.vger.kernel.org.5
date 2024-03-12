Return-Path: <linux-kernel+bounces-100002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD81879088
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BECB71C21DB9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798D479DDA;
	Tue, 12 Mar 2024 09:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Db5Wb4+q"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2075.outbound.protection.outlook.com [40.107.6.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7347E77F37;
	Tue, 12 Mar 2024 09:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235046; cv=fail; b=VRUrpCfcAMVlaCAzoa0UR0LLA8IqsJMi4LXf4z4CH82wd1smbIvh+5t6iYBU9p2emX7S18Tm/iLYtVJWtNa2kDNb45xghpRotzmQ5ggI4siRTrQOwrn9f2YNaaj6nn0CvgQlAnH5NeeuR5elMxR+DHJndnRlwmsQrD3LxORtZ2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235046; c=relaxed/simple;
	bh=Z90pANyJHfn8qpFq2AeWqXeklWl6BKp0LujtkGmvvNY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=txE3UPes3TGuw9gW7RhA/WW93cVZC0ZVNhjuAlPqDN/gbURUFWLwMn6S2GeVQuud7Wanv5mTBHr8R2nFNqGiyr1cjo7AlCKdNNcHmEe2xfYRT9Ts1AgWxzJm10sEMIg1xIZH5RAlf9YQdNcX9eEJ/+oOtkPhF4YoD5gPy/xweLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Db5Wb4+q; arc=fail smtp.client-ip=40.107.6.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkUuUW3SsZ1mli0J+La2CZoy+ZHYMWTqqeViVNlLbnvSpMWwkeMP2eu1SH5AY7dSUFFnMNt+gVpSuSVVTxhouFgbXN1uA3QqsNfkWhBnKnJDwcLTuPG1LQ6n0Ua28GnUgKHHPqdNFMcKzRqDBvwaYrEGiH+eARlKYZ0S+vfV/yxMPWtz3uh1otMf5XUAXPrzzSzHIrcUC0VX8M7M/XgilShd/YJfeD1eUL7t7Xfk7K1poDnRpq8VT9XgVVXD6qjaNFsLUZ7CFZc+ATuuQN15MMYCT6S2O/tuyxkZ1k4fFO9QbmhSO6ICNee0NQsY+LjpyYffKaXoUoB9LzMtmnB5+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7n0/2hPJmEhVE7ZVRUpfWrhVZ5B6sF256FXEhVwfPY=;
 b=iPpgGc8BRtHgnQlmZ4qIwmBxbLCk7N8k6j0+J+zHqjAFJaeAvdsg4wC/K4GxLo76UbSKq0OYYHDAOcein9Z+0xLLW4yfk0iPUiVS6jQ3JSE0dpIHFXO404IoRavvXQke4Ta4meVA7gf9JeDBacxOING+LT1pUPFKELkby2aFFpJmFI205mog/nm3vCK/vIbp5Lc5fImLljw/nBgYD/9zvj0nH6MwUw+Tng1YcKyd0Mr/YlSELEFteE67s+zng7WUpOHqH586RApR63kcRINzbrO3GHZL6x9k5pA4YfYkfHh4BG6lOkMhcqmBdNdf9jPwmc8ZIEMpeXexbrtA78k1jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7n0/2hPJmEhVE7ZVRUpfWrhVZ5B6sF256FXEhVwfPY=;
 b=Db5Wb4+qDGCfv3i8U/sce1G6bSNaqAaqzDKYbFp3Wxjmx/yHUZGQRiEl+pXjx85r2dkV23sDNbUAvmA1fg0sfC0pGwswpsT04MLuklwlOsF48OnnqaTh3piK/IgFPnsyNAAf9ezjzUdRd2VFMS2KXmPNcOu3bkFiwzCPOYwmlQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Tue, 12 Mar
 2024 09:17:22 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 09:17:21 +0000
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
Subject: [PATCH v8 06/10] dt-bindings: usb: ci-hdrc-usb2-imx: add compatible and clock-names restriction for imx93
Date: Tue, 12 Mar 2024 17:16:59 +0800
Message-Id: <20240312091703.1220649-6-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312091703.1220649-1-xu.yang_2@nxp.com>
References: <20240312091703.1220649-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AM8PR04MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: cec72a4c-9078-4d91-6256-08dc4275391d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qzgbSfthTfjg+DlAGannF7LvNgbnkAD0kfMiih7WQIM4NkkWGg4KpnvEoy5KOPHGYJitL+gSWjjH/6VL1KeSL0fxyuDjAl/EOmCz5Lk5VIXjnc1R1Z5KwsIxRCSSHxt8OGPasVMGNxiZmMSCl3Cr+p3OXvTbdtY2eAgvIXRwvqejWCPtwf6OHYLEKp5Ge2SMnuBp9+pSE6Jx90L4NHFyS6XKq1bwfB0OT0y5lRzML4ymibzvdoBUETxYRhHDTcFruqkfrcxzz3fB/GssIa+8HEIBGlH7KdTIgbac8ZNMcvRW7Z9aDNEOxmWTpl4I1gGw0PVPuS0uXFtY4BNX3ZD+qef2jYLUEBz2Qyd9yEFmZuzrVTVXV2TMNalduYcR0k770A+/MKG+W/poSNKvfMPA38q5w3IDHWo43s0qHaoLOJNGqOai1fQagGMxgVlGoTV1CBXgBLrkxV3IL7V6ft4kdl3nbnDGtoTuUMKRexdhRiAIW4PXxTalDKP2KNrMaJqBsvJ+SXa452Wyzm8xScl/9Uz9fxH2BjSU5R8c0ijW+/Dd9bA4XvK2yobv9BlMtKJneCx/ctSUQqRSExGjgVaQt7qOk6p8sSO0YBW4frJPJoRg+Hx75f1gohkoSWMHgo2CxU3t/S7/u4QZImG0GOxb/4Kl+/+3yAcmuTDQ/jnjLurLs12UPHEZJwuGmlrDfm8UV+BH15/jMMZWP2W8Ko7atQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3pEdX1Ajh/+Zhx2TALCW+Sv8Cre5btr1znw2Huh8kd4aJJHU1QAopkDOrHPl?=
 =?us-ascii?Q?NYEr75XibncNLWZhhWcjtOkF9E7BgeTwnRqs35UfuWc2y7da3p4rcOohp6wN?=
 =?us-ascii?Q?Gj6mPuK3tp6HmpnObIDrSVAJ69/wnTC4OhmXgI4J1XrGFYFFqI4++9R57lS7?=
 =?us-ascii?Q?GS8JfzREnzSFLiAuX0Ux6a4AJT/tWAsmCAtCWPkJGvZGZCqQq2mrC3OYyteQ?=
 =?us-ascii?Q?PH+H4IiudN2Saf76CHMwwLbVi2oZcQS6hqwWCdDT9SvWY9O4UP7q3a7bKaNZ?=
 =?us-ascii?Q?AgRsryVHXf1cywyACmcaOJ2lbuXnMEC1ISYY1xGgzu54l3HVKZLLm03xE9d5?=
 =?us-ascii?Q?M7k/XiIsLwOndvwxZHCOwwgIUjI2yhuDFnYh48fJSv5v1hlA6rj62Ds/ITQj?=
 =?us-ascii?Q?d6uhPqpjMCJ0FVuUN2p/QGGpj8jMxYxZuk8j2hUnCeEQ+1MdU8f75vWanUPc?=
 =?us-ascii?Q?BP+eVQ1slSbcQpSfpVtesdAgqleIK9XEhej11vwXtH1tcUlQeQB8i1SIxPc3?=
 =?us-ascii?Q?cDNxVNKJoc4lyhBeFSPgFE7C/K0WmziASPh2Q4tckiyvKLGORR1r7Mp1eYLN?=
 =?us-ascii?Q?tmm6pkCzTQXNvdXcjzrT/S9H0105VOufaNAUTOh1rtLgbYu8zdqmWdYemyGV?=
 =?us-ascii?Q?37GuaDcxtdbImbDpsnHoJjLodt7gniq21IxAO2ZpDGnh41IhyAEHqB30Mjx+?=
 =?us-ascii?Q?beZPdAXeGe8E0RABTT1BHeFDZj5Dl0fh4u4itPMRl20f9XGzg0+l6YaEuGWe?=
 =?us-ascii?Q?dWdGTjBE2P7QxqLR/D2jfJiPDvbu9nqO1fcjiKz+OAhLMgmadnyufT6EQYJt?=
 =?us-ascii?Q?MGTlNBB/NLDKesAm5BoUiuPCKS1VnP+BBIrfrk6JwKfUBjLYgYhLpsxgLBf6?=
 =?us-ascii?Q?nNhr5XMnjf9fzrs3W5PmjXSE2o04K2J2bY8RbFTqHTM4H/Eg/r59B2sJDxYx?=
 =?us-ascii?Q?fKRpgnyXD9vrEaq0TfAzq819PwAvu1ZTFZKOU/wldQiwUz5CNxtV8zzuDQBw?=
 =?us-ascii?Q?ztOpgUwxvf9PbRDERlhMKXexpCIBc/RH60ln39N1pocWleHGV/oW4EEkZ2yQ?=
 =?us-ascii?Q?0UqEiXEiOowZfeTMNU+MmpI6YfST2VkivI8jG5YHfMlsV+oYGrguWIFBNSWL?=
 =?us-ascii?Q?bz26asZb2njXBdXzPwU80r8LJzfHGdJs0Mnm3DfArgM3votu0Sl2p+LMWcpu?=
 =?us-ascii?Q?E/Eygi0xpgMXBRk/zRxWJY9DKNdmeFnN8tnUxMeMkg1Ckb43xGFgjc7p1hWo?=
 =?us-ascii?Q?zLSgi9COxYz+7FahYN1cQJQqL7WnPmd9QueamARyLiWTFjf3OVlsUBeWsnxn?=
 =?us-ascii?Q?scGgUdW30My8LSlDnlOKg6YnX4x62nSkDa3qhAPryxtPVDFJLCDQciJgpHmt?=
 =?us-ascii?Q?rqooAQJuSIqWk8xRWMA4NGCFw+jhP6O2spkH33cd7uNf5Eb7YLYSJ2LEprAR?=
 =?us-ascii?Q?SV/qTYfuaoE50Y2zQMYBSNhA7J/vsbh4n3KZf2jc4zDmHQMU0mKeQfv7D6RU?=
 =?us-ascii?Q?Z+jpoJW3Q5vZUmhagJv3gNhUl69SStvMxVxsv8GQkKIDoXj1EukTs63QbdEF?=
 =?us-ascii?Q?ULcUltjfcYE8yONtZN3jpgSrBGD8F7Cacby3Y5aP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cec72a4c-9078-4d91-6256-08dc4275391d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:17:21.8977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zeirhSemGoXRjX9uakNi+iCX9LZuIBy13NYnB+WZPEfV7lMQGCmzfCi7KghvmNTv/M9aip00wvTmV4Tks6YGww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7876

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
Changes in v8:
 - rewrite the restriction
---
 .../bindings/usb/chipidea,usb2-imx.yaml        | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/chipidea,usb2-imx.yaml b/Documentation/devicetree/bindings/usb/chipidea,usb2-imx.yaml
index fb1c378dfe88..fb1270e5c118 100644
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
@@ -185,6 +186,23 @@ allOf:
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


