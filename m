Return-Path: <linux-kernel+bounces-104110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1286587C912
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C509C2828EF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6CD17BBA;
	Fri, 15 Mar 2024 07:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AlXrq1Y7"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2042.outbound.protection.outlook.com [40.107.7.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E209512E7C;
	Fri, 15 Mar 2024 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710487506; cv=fail; b=rYSqw2Y2U82ewslgPXU04Jlo8sL4Zo+/3wPuw5U0uu+7weDiUMxk999MCjPqJiRFhSX91gH9XU+nujK2AGQZiHD9iQDJz8HSa6Irp5BjTAd51eWfMjpCkppy4awRXVk2qim33TkMZeMa3BU5DF1MRiTmodNu7IFaVyai0mD5whg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710487506; c=relaxed/simple;
	bh=jWUjkbVPpXyiuIUgK17rG23Qskholwn238TDWK5EhyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MmJY0/i+v9wbqR9Z50LgcQgnwiEtyySdNc8qafzP4aOktWFNsdMUU7X+tDHiDs5RFsDKNkPh9KKabgLgyGbf9SP7nTsbdHwlq+nmQ3l4nCZlP0xgVtUEhE4uLhOvT8K+5s5d2YgxNN0QVGQn/lV10PpOj7sQ0eOGS2GZEs8W2I4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=AlXrq1Y7; arc=fail smtp.client-ip=40.107.7.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPOgMhEWilfa47/UOfaRe5AHPD4V70H5rdLrYYa8bMRyc4WhCaicEx5oRpS/8efVISlvv6jWMRj9Vw/+WgidsCxOZTFriWyV9py81rNcb2aWmJ1ecrk9zXVtm5Rb7J5895+sXKF84yqewHz0+RyKFhV1duALl/tcC4GSdtO5QWm9lcZWVRle5KozlPS3fu8rG2QPYwaohXHv3LxIdaA5i48/kkxmr2UCkrFGUfdEZWHbnQaIzf/TWUZkiFhsNhk8nEpbYxy9+dOg96V67AqfKKP09ITeKgiTBagbWvY+zjgQb8dR2s4d893/Ja7nzUimtG/vGqBhR1cih4dfu4gttw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ceSsEBGoD9/4fEJSFOCyeMAFG/8/IENQriopQczHw+Q=;
 b=BT2UgOqBn/If78bAMKEpv5LavgunIPWGU+6DhuZ+UV2CGM6N9D3yxWegmyZxG+9+6uApHJthf3HQqx2oyM8JgqYu8bll0DKgCJcbpIVGfrh8yKgx+SsuGJuM8QRCLFVlwwkTN9YVqdR6eeWN0RjmhjU1NRlsIw+rTJ3wyZ+07exczrSu9wmph2Ion5XmTFBVL3T09TcXZbzNKzyDO3dtc56gJsK8+64T/Yzl9k4CXEADy1m5ks1aK1F1PwG6/M7qJfNw/aXYcSowolqDDH9dSTWXqEAdlk89uyFt0hNF9+RxuzsEqi7wTrNqOlXmLWIlEJqpiXTwGMAen4NDWvQDRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceSsEBGoD9/4fEJSFOCyeMAFG/8/IENQriopQczHw+Q=;
 b=AlXrq1Y7ih+lVUe1doKK8FueDmmTiBXfWhJRi0vYja2PLiGvhowHUYxZX4ZBfmgmk81edrZ0il2nAe1mjp9LdaISWncwqF/DTkXy05p2Egz1+Moe1w3MsvBHU8/VmS+VrB8ZxhOcASepJnp8xKOOsApo12p8P9ibnrS3rrgUdU4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DB9PR04MB8332.eurprd04.prod.outlook.com (2603:10a6:10:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 15 Mar
 2024 07:25:03 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7386.021; Fri, 15 Mar 2024
 07:25:03 +0000
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
Subject: [PATCH v9 05/11] dt-bindings: usb: ci-hdrc-usb2-imx: add restrictions for reg, interrupts, clock and clock-names properties
Date: Fri, 15 Mar 2024 15:24:49 +0800
Message-Id: <20240315072455.2481613-5-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 51b170a3-6b11-4944-2e35-08dc44c107da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eVnRqYyNKDaeWwAGo/Lspra55RspajOCejbPxhssQHRJzz6zIUaYJdi7XxoEjDd0ZK8inw3azRJHaObpFStuiv0tPHhJpH2swHPZW72IQWV7Ngs9aVxfCcSiTeTik940dn3XJC4bf8+D1BpRo+PCHEvWmdTRtmqXi6iMkpqpq0Cekj49/Dy43LHpU7adYH1Kcx1fQgD2Keb/PZ715WOkErmSYEYazvMwk/iy2TlEa9HL0lc36LcZMHBzaOtmkmeipGceYf4rwI1vk9t+l8B1f0w+Dutbpco9ceGWrKRHvP6eNCFXPljU0BK4RbjumPSqFi0Hp5GtnD/fo1P6YCqyf1plpuKaWOjIeQiHs+kRRK6rpkbNJOdGLQcv9p04RhsHn1+iuNhFxHfVNbgGLfxY8FUHf4JMSnjwFGb9/6/qFN4fyUSqQs4btEOokHbZi/KKpINeS08W7uKjDTGF1c1/kmvA1lt2fS03Wga/6Icic2DXDw3W6QRbTv/ABL8x1R22I6QZz/0hsgoDeguEOYS4FvfDWl4v4w8aqncmXN9d/7M4hTL39oGZwwa360PLNqwqnFeHTN1UdSYUXEcutW2Hj243ahF56RsWQRtQCunXvPB+ez04Qe2ZxItCaWSrTNJBmbLJtpjr3vzNKZGT6ApkIC/VdDFT4vMcEz9mIzJDVyb/fEKWpkz58dfgHS4vQmNVrgYpHiHZ+m33Xch2PeVxnsmLQmsKCQHBoYSxOqw70w8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZlcsgwYAEiPTcVPSeE7qU5ZaRAtGYgJKCRyuw3QRTQJvfNc9FTMbVnfi86fV?=
 =?us-ascii?Q?Cu+a4Gy3il/HdC13ya+eCP31Jc05MiBju6wERWdVqeVAohrtU9aZmi/zvWuh?=
 =?us-ascii?Q?nmZ7yZbG/AVK5IDrSCd//btT3A0rtPUP5WA/vr3biMcWiOtfGP6CGg7W1dbZ?=
 =?us-ascii?Q?2fAZ8EQ79AOb6e0RE8oYiCL9Wx29bXMdownSpS1lEcrg3nqXUGdRLUup0ePV?=
 =?us-ascii?Q?NIMoO2sfoD04edUKkfZ9nSEyUS5hLrzKfeFKOFLIXNL0naCw5g/2wiEbUg6D?=
 =?us-ascii?Q?j9/QyI2bOG8OV6b7eHWZU/HWpYvwRiKL51biDQ60scTKoA9wCNpQ6Cx6BzZS?=
 =?us-ascii?Q?jzEH/w14245pfB2uYXKyMfgedlfXlsQI9vJ+1Owq/X0wPDVm1TbYdGRhIltx?=
 =?us-ascii?Q?30eksdB3eMXOm9wi9ShLBBkEkxJqC1enBNW9vOSOVC5zOgBxw/TLmMvNMbU5?=
 =?us-ascii?Q?Ju5bT7Jns/TJQ0bkhxpwC5bY2L7oXXEtxVj23nLTJBid97wViDLtqTc5igHI?=
 =?us-ascii?Q?bcS0NkfeF+RIW2yAZV9ZQ3HCNxSpZpVlj2hD23jEbax0bQhg4BySTI8QpQAL?=
 =?us-ascii?Q?7C+YJEUMA2qWtJrd68H0f5MKGWgeo/TKY+fFRNyd+/d3pJ83BG/OP2739hvR?=
 =?us-ascii?Q?In62fSewtgxx20eThY6lbvEAZO2mWDpCKZIUyj/zC9btOrgziC+wektEk39v?=
 =?us-ascii?Q?1c+2AncJJ+GRACgpy9htUD2uWGcdEQX6sTlaTcjb1mT2psX6C4BzAfyZQkTm?=
 =?us-ascii?Q?h9dA2liLwHHcxJR9Znsb9ilzcSweMtVH8J6GsdhllltC/rPmwjpVR/0Xcb6X?=
 =?us-ascii?Q?40vpBQA74XILyAoR4XkBi0IIv9H39EQdqe6lVa4iCDdrxkxsaqPN7Z69xEdG?=
 =?us-ascii?Q?/k70bOXNQn0eCHAEnaQer7UEN1+4CeR4g0jSG45DTSIUgn3Qft9KKVOTH8zA?=
 =?us-ascii?Q?XHUCQprVqYDwpXKSz7Fbn56NcNWpx3WybxoCxx+KY+hdBLV3oGnz8jVnaYJX?=
 =?us-ascii?Q?IfF64UhHDZg3yV1xXj3DRbRmrquHY2eiNxbYdpnEJGJAi8J168cvWIvapUEm?=
 =?us-ascii?Q?Y0DWuOIAVmCIbixCazQAtQaTiPJDSXBAlz2y2l6mtrHhjCs42CaWAAQqBcwE?=
 =?us-ascii?Q?Oo8fvJgYK58mned4jcUy5kA39EnF0eqR4jBwMK+GfzPSfR0/3KduBgMWoMhq?=
 =?us-ascii?Q?Vo3kM4QjlX1aLESteUslMwoiRCXYAA5Qutz6ApjCszJDlFJCRhvZAgZJRjTd?=
 =?us-ascii?Q?998bmaKsvCBHUkeGjO2dABSfKmVNRXXp3rqIDCNyUuGGov2TjU+LGvT4nF8z?=
 =?us-ascii?Q?O87nK+sV8Zp2TZfl1tSpv30VaPNeiYcMjINy6sm1dP3sbtqMCthMIOFKUH3O?=
 =?us-ascii?Q?W4oi1dZnnZpj/YLEcigUqlh1/mwqiYwNhQnhuRH/RUW+NjTkMjJR1VePbe+k?=
 =?us-ascii?Q?0KJ+OT7sCORp7f7BfOHQhmgibznmILoe6ES4Y7HbtDuh/x69NQ44SJdtWaUk?=
 =?us-ascii?Q?BF+lDPAqpiAaYVbpzMk2zMuofypGvQHvpBfwlmQcW4/zEoaIhHp0NvbQU5Nv?=
 =?us-ascii?Q?WJLdcd0hVyIiPh8zqs+B0v6zhk7IiiVbvQsX3ShT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b170a3-6b11-4944-2e35-08dc44c107da
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 07:25:03.3458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Qkds8SN13OJI3OtrpUssXGS5/O6slY7hMa6DkVl8nCvco5N+lbPM0Ws03UaPmXQXO1TQpsdIDDVad8XlzqC5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8332

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
Changes in v9:
 - remove maxItems
 - make clock-names if it's not needed
---
 .../bindings/usb/chipidea,usb2-imx.yaml       | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/chipidea,usb2-imx.yaml b/Documentation/devicetree/bindings/usb/chipidea,usb2-imx.yaml
index cdbb224e9f68..e2eb60eaf6fe 100644
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
@@ -144,6 +150,76 @@ allOf:
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
+        clock-names: false
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
+        clock-names: false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1


