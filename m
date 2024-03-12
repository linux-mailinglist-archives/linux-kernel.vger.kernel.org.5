Return-Path: <linux-kernel+bounces-100001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85486879085
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4EF91C21D45
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBE679B7B;
	Tue, 12 Mar 2024 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HZjc6U4G"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2079.outbound.protection.outlook.com [40.107.6.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247D879937;
	Tue, 12 Mar 2024 09:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235039; cv=fail; b=hFuVKA2Egn7GZs8G1qE0yKIjpYdK3EvRpPZ7HhSQRXdBryAK2S4GA9oEQ989ZJ/rKToc1yTBlOVWEwdB+SD/LRKaJ2xKj5HMPvGHtWGVeMAsZwb0sa7R6hREB3ALb0xDs90dYDwqtSGHJ7I7znBO2U2g9FBI4+rtk0wES5asn60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235039; c=relaxed/simple;
	bh=oPsLsi3+nwAnVIyBdzKs+JVN9Rr4L/fBeF8ynnOAMRA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OTfK8smkfc8xp9ROQZ2kB6vPWf1ZpfqFtPure08eGMG1mDBO5E3TpBhFfHUDGzy4GU7hCWKuDnhRt7C6i99yyB/BsFCLDy6TUGWmOW0Yd1Ui5aWtVji2kVWzxnDdvARcPVy06hrd1eVPYp53CRJS1cVZK1Qtb8Rv1+LO4g0YFZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HZjc6U4G; arc=fail smtp.client-ip=40.107.6.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9gSkX6SwLvTEVst0nvhpf37ZcQiE83u6amtv32rsQ81SK9Gq0hnDbTnV5dc11DaLojnNAYGcZgrnPKQDGCDke+jHmS7pXsHB7fsZidlbMtizxECX765/J4BMnv3j8M0cj7Sst0kMOWSpCowY9Ax/SHB+YM4E+hyAwI5pEFMxS/mNga0+mdWAvWZoGtrAKnVERP/l9+gzDshbucvsZorGrhkLptMn3Fo69D1yRXPHbKDS/28ZZSOkT9cT9OPJntTcE4MYfstB/wLs5AqFfjRQWHpo51xC3swH+yB/6yAhsXZP9Zp42+mvpgoATPH+ehmZOF2rYhoByq62xhPecJTEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3zfXPfVk0Khrw22CDgtg9XBBe+Foy/4SHkbnYZQDu0=;
 b=FJPutCYmTaYQjqSHKJWNxQEimRmB5FoFSCMTwwsIxsESHPfWIN1Jnun5jpuOaM76nOJO1BSA36TpHk5aIumlH1j4XA8aTgYtWwQjKT+FlmQ2pSKIZjOtbjphJPG0vGKdhpO3dcdDAgm93vOs+74vbbX0gQAv4l6E9T+ApfcbwSRZZVC1miWYw4tTKTxbMMRWk3rV8oEsJWYUEKagOSh1vXsI4eLzB06yQvQh0TVoCrwvHH+x99oE40XS11LPqjwnOq2/Ul7cf7sEZdOMO0dNsEinsEEWLP5dv7J/C34qHvo8q6VTWlXVt0+s8ein2dnM4yuP8VVZ0DKpnwooIdjnLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3zfXPfVk0Khrw22CDgtg9XBBe+Foy/4SHkbnYZQDu0=;
 b=HZjc6U4GzzMUB23FwYua2VGrPiZsy4e+yI/c+BBdhwjSL+s0u+JiZ/XcvWSkdHpsA6TL7l2HHGX4xjyot9h27Z6/5Y1stUIXcbf/QNmXHVDnUQ3hnyd5HsGY30HrDNsyKDqs5lvBbRly011g/YdmbyedV1DvIsAniMZQcsodx3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Tue, 12 Mar
 2024 09:17:16 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 09:17:16 +0000
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
Subject: [PATCH v8 05/10] dt-bindings: usb: ci-hdrc-usb2-imx: add restrictions for reg, interrupts, clock and clock-names properties
Date: Tue, 12 Mar 2024 17:16:58 +0800
Message-Id: <20240312091703.1220649-5-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: febb59af-774c-4d09-5109-08dc427535b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qbr+kiFUwVdOb7tVf1eibCqT1jS7PbiOTx3eYmOvabptferKAtAYp0SLzDl9hrUxgjDVjvzKs/3XdxU1TkSkOcc1gYNwCDWSUweULTaW9brZib66U75CogVagCvgpuMGsLe3gwuPkD9UkBkmIO1SMMRS4QnAZPPbp5eeAHZk2ysK/3L7v8eAHsKdoqGB9atRCMAdNUw2Da+Ze62FfjZDtgNM9nBkvDpW+xrsW639++oyIXWAWNaKpjW0kwnu+vcWcli5IQcoMIzqRON5NL1/p09sW4hFvLVELOCtRl9IgufPw8fGqwpJ+p01L6yVIVPD1SYMFgCmVhuJCIgvjyf4qVLofi/CWwhdiq9nCiQYxKYbS7vx7j6H1tgLKODS/terKzhRSwMFEF6SRT3DWGm3+aarqnZQUQrFdhqV4TdFfis9kmXDCCI8ubzgCEtWnO9RAQVT3O40isZOmfiz9B7D6Ze4A4ZebmBWRDWs6a8L6PqLKiY2+tO+7RPhfVaRKe1+CP/baay29O74jZotRkpbr0nkhjJZl8+uT4nmoJKuK8u7o7uCfno4r9oYDpdDmd7J8SPEbNjOTv4Z+jcvETMLqOm2iwo778qlFTPtBg9CbgOlxLzWb4v05viAkQ10Vx9IiC4REKq3wRRkSnZnO9Sb0xd0C5uN6O1ouH1GiXVC9wJV1xmAMh4g3GNwRxr1+M/q3oqE+qeSvleNMxHuoxCcD1hPs0fc6/pqVQoceWFXDik=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yT+S7dCaPv3gHZqus+trDBZipTtf7sCEerPFW6+g9+7vk2CUyIh572QUlLf0?=
 =?us-ascii?Q?lEbrYN7xybph+3H+0b0llfl/AXDUMDM03nzDkbFM+jVquIWJjZOxYl2X0y/x?=
 =?us-ascii?Q?WOLKVExnyUZ9uFs9ORx/F5g/kG6+pZQJYWCtxV9Rw7+VNugWocymlpV+1a7z?=
 =?us-ascii?Q?LNw7M6Z5CKNsHCmWQoU7bgujGc4wH+O1VLuEy6vihVYnZzvfdHj7j+UP3frU?=
 =?us-ascii?Q?IE1vo5L3zvcZQENQ/29e/9HJ3z5E6jsSTfaaL1P/E3cTTnCyBygQbqX6QmFQ?=
 =?us-ascii?Q?AGzBB2pPVwcMG6GhAKsTyac/uM28MUzoMIoyEFjtJKpthSLzuopkqkBJqw5W?=
 =?us-ascii?Q?jJBaMamoau2GrEk4dldDeUHnQngYFigKxzYfJdozwQH1ze/JFSgtCHqXxNAQ?=
 =?us-ascii?Q?YCNSwoPUKLJFiaqDkjfwglHV2NPw6xaFFaUOkCkHhCEo24DH2YwsW+vESAx9?=
 =?us-ascii?Q?Lowwh+WTOknP6H+uz3ULoM2kf/NmP8kOqyj0zMicSn7yF4/Zl+DiA2uilfLW?=
 =?us-ascii?Q?TgiOB3t/Mpyhy07ubmnRotk6HORWgCP6W4+iNUpkvhMFfavoWE2CIDighgZS?=
 =?us-ascii?Q?nqoQK4PyGBW7VR7WXuwXeu3yKZk2eo+7i53xvqNj7Ugxcjtwj+9AiOtUNjaZ?=
 =?us-ascii?Q?SMVd69cDX9vJjd5NDhpQjhnemN7prM3k7mrBYrYsUmk2Ch6T3W5E6HcykGEp?=
 =?us-ascii?Q?EZzZ17KAn6b4fuCzWsTKuynv4IgWihtbbOF3kWfSG2HP2T5bPZTq6izT43dg?=
 =?us-ascii?Q?f2GsIN8faicITqw8QzuMSUpcFrpXVmRrYkJoDo3GNz0VV/Ls+IfQRINsGL8T?=
 =?us-ascii?Q?3XcG14b6ArGW/P/u9YyhpCAEzdxBRPF0d1rLjToNhWybxUARtiUBZTu6w6TD?=
 =?us-ascii?Q?yWz89v/wQcobZvVjqEVHEriMAJ6HXlDk3gTgkNRE4vpDeGDGL1ekXn3jD58D?=
 =?us-ascii?Q?8G9mLaHcIWc/zj8jYvFJdBoacEWnODEv9uCeDsBXAcUa31youPWt8KY5TRMG?=
 =?us-ascii?Q?1C40uQNUV20w3k0A4v/U46xFe+VZAnmxBkvBmBm5k59pgY+7LpanbTKqqtCa?=
 =?us-ascii?Q?YGnEcz6+rskUqQpO5inbD23E8xoT1+Aa9Uptj2Uv8Bw6vGTkC81BCtFcjg6s?=
 =?us-ascii?Q?TcggCFwdEBc/GuRpw9V4R/Y9jORbFez+dVRjyetteet/P0kYnHdKERm/1Psb?=
 =?us-ascii?Q?IZ5EObJgpssYfX5AqhOuP1D3ZgVqFfTvLzxZWKjAqnwceSolSTP+NK2LJJNe?=
 =?us-ascii?Q?GPZfIwCgq+Z/Mx35HcMn/ou7xZ9nZs3M/c352QO9SDCIjW6K0KfQS6dUdDzG?=
 =?us-ascii?Q?2K5Fa76ACCbFTkGgm5BQzJSrrE3aNxAp9vO6LZRRlroZfR9le1fgamOjpE/j?=
 =?us-ascii?Q?XfhcHvAQD3BoFRffEIZuEXVi7i7l9uZTlMHAfZoTftVaeTjb3B96NKW7sRBh?=
 =?us-ascii?Q?lWznncsh9sHOvS/oHwuBuVXI87HUxaqZAJ5pvZLz35rHAxIqfeyUuGYNw4gR?=
 =?us-ascii?Q?9fzSs3O7/Mm+5N4mG3F7cZPPtzeCGSX8iZ/UGZ44ACsVE0lh6PjjapVuIyWL?=
 =?us-ascii?Q?yY9CoaTfE3LGk/qWY/OqBXXfERNUA4vbFeWoeq0f?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: febb59af-774c-4d09-5109-08dc427535b1
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:17:16.0875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7U0UW4b/Js3HMeSsI5tNQQpyJP6vI8nKYV7Euo5EZRG2m2Lkd/1A2sw2VS7lJB/em8PVnwLkNLZP8zLhcGdAsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7876

Add restrictions for reg, interrupts, clock and clock-names properties
for imx Socs.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v4:
 - new patch since v3's discussion
 - split the reg, interrupts, clock and clock-names properties into
   common part and device-specific
Changes in v5:
 - keep common property unchanged
 - make if-then more readable
 - remove non imx part
Changes in v6:
 - new patch based on ci-hdrc-usb2-imx.yaml
Changes in v7:
 - no changes
Changes in v8:
 - remove if:else:if:else:if:else block
---
 .../bindings/usb/chipidea,usb2-imx.yaml       | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/chipidea,usb2-imx.yaml b/Documentation/devicetree/bindings/usb/chipidea,usb2-imx.yaml
index cdbb224e9f68..fb1c378dfe88 100644
--- a/Documentation/devicetree/bindings/usb/chipidea,usb2-imx.yaml
+++ b/Documentation/devicetree/bindings/usb/chipidea,usb2-imx.yaml
@@ -49,6 +49,12 @@ properties:
           - const: fsl,imx6ul-usb
           - const: fsl,imx27-usb
 
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
   clocks:
     minItems: 1
     maxItems: 3
@@ -144,6 +150,80 @@ allOf:
             - const: idle
             - const: active
 
+  # imx27 Soc needs three clocks
+  - if:
+      properties:
+        compatible:
+          const: fsl,imx27-usb
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+        clock-names:
+          items:
+            - const: ipg
+            - const: ahb
+            - const: per
+
+  # imx25 and imx35 Soc need three clocks
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx25-usb
+              - fsl,imx35-usb
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+        clock-names:
+          items:
+            - const: ipg
+            - const: ahb
+            - const: per
+
+  # imx7d Soc need one clock
+  - if:
+      properties:
+        compatible:
+          items:
+            - const: fsl,imx7d-usb
+            - const: fsl,imx27-usb
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names:
+          maxItems: 1
+
+  # other Soc need one clock
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx23-usb
+              - fsl,imx28-usb
+              - fsl,imx50-usb
+              - fsl,imx51-usb
+              - fsl,imx53-usb
+              - fsl,imx6q-usb
+              - fsl,imx6sl-usb
+              - fsl,imx6sx-usb
+              - fsl,imx6ul-usb
+              - fsl,imx8mm-usb
+              - fsl,imx8mn-usb
+              - fsl,vf610-usb
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names:
+          maxItems: 1
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1


