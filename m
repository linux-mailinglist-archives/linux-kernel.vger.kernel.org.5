Return-Path: <linux-kernel+bounces-74282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B418185D208
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CFF61F26958
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FEA3D0A7;
	Wed, 21 Feb 2024 08:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s8qKaBXj"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2079.outbound.protection.outlook.com [40.107.8.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596173B793;
	Wed, 21 Feb 2024 08:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708502590; cv=fail; b=N0DfKZ73qJxATBhgWEQndzdzXFuQ09PzCbv+UWKrlOukpASRYf/IX52Y88Rp93BMkhyPluNM7GCyZSYuW7fX76eBczz96ca9ly9cJVHel6TAjEZIkQyK0mCZeM5zhVuQVU2dWVYr0RJyzcYpsiINgm9XGA4hZTO6shnR+n5R3QI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708502590; c=relaxed/simple;
	bh=WHEn0kFo6K+a/0iGnhQiuooMIGSbmpKtktXaRVHR6xk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CRehwIlG4RBGt82O4eMuX0Ij+nlr+nDpSfpo71Js7ig+SKXZP26IhUyYNaX9NGfbk5yNV2H15nQc02y9XXvuL7Q+wS/dgrgmx9mqi5HAgEt0Y/uNX+MpMK2ZihmtbcQJXbtopdKZ7tREVudE8+6jZ+Z9USHpjfe45Qkfz/CogsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=s8qKaBXj; arc=fail smtp.client-ip=40.107.8.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0l30IB4GJaPiQalQGvcrzJF3h6vHj+G+MJ/w4g1X6ux8zOlXsYkS42wFZ+SbptlBUpnHYlJPkhqHAekKlUix5BIjl4/NuKtK64RfE8s4hBswy0sOiAxbwlOzs3Vth4h1clhlTIjgtVAQJ+djOBIYmh731jkOWhyskAHt971Y9WWk1wH+GJ9Y2QB2actfW2uzvQ2+2C4YwJpwKaDPAfnVi/QyCyO/eBT2xPcCKY4+n3H+LdtZYt1plk9K3oG8k3MinFPVmgy8D/oZOfgzDWaahWtSsVmaK/CSOxwHriZa4+KSdGXV++mNeZvruLz4xvfYJyzjAmRhhqixYbYnRJE1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkKIFr7sFhI248q5m3aGpcxjKLrVv25prkH9EcL/3Fc=;
 b=UStgvY8wsUut33VpAOI7tPIVHL21RoaHKqtxUbKzGhi2FnE+X4MH2yj/FDVVeMhAhOJ61YSJXvUaZ9kZ5ZeC8G37+E30tvWdO6fLaExHy3H8UDuhJVHxbgzfrEtZLWkUyHMNitBDJD59DogsFPIY3eQyjo/+3z06+vtfqzzYZ6Cd5qU29Gwqt3PTdPwP0yTtPM67ddjsQ80shnpZnkmiBVn/SadiGJXirhcTHB6HWArnsNqqcIJ+FjG2jMTChSmwVltqpYawc5svvK6l6snt1sDbV8rSoo7DYda0tjpduIIPzWLD1rgEvsuN5/u+nW5ovciw6otkOD4LYA33d6Lzkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkKIFr7sFhI248q5m3aGpcxjKLrVv25prkH9EcL/3Fc=;
 b=s8qKaBXjrQxMKcHx0U/wSLtjF7aUR1AB5e9uVIrkKHuafRpJzN8Q9sdC96tWHPYRgr04RCZ+4vPRLu1HeVHm4Fkp/qf6Op9iE+jbTa8fwfowWqiZVU1h0/zJYBeM3a43d7CgModaiEau9rqsNrO0RbeZr7nqBEw6GXCmGvmlueE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS5PR04MB9770.eurprd04.prod.outlook.com (2603:10a6:20b:654::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Wed, 21 Feb
 2024 08:03:03 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7292.029; Wed, 21 Feb 2024
 08:03:03 +0000
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
Subject: [RESEND v6 5/9] dt-bindings: usb: ci-hdrc-usb2-imx: add restrictions for reg, interrupts, clock and clock-names properties
Date: Wed, 21 Feb 2024 16:02:34 +0800
Message-Id: <20240221080238.1615536-5-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3ddc5d6f-e85f-45e9-0646-08dc32b38730
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Emaiu/LYiP68Fl+Z7Gwu3TwULSq68qI15EEzCGL31cxpvg73LSYU23kxH+jcd/Go5bL84V4TqAP3zovSWzIYs9w2BE+uyx3fkJh3mtXb8M4/WnmL0Ip4i2opG234C+5eI1Z0kH1k9GKnw5ZhReHuyCiL/ah/+Z9nPGNAE1a8qtoSu87bEksIzORsen1WrSwBCD8YIoMP/9sBgHenjQPwFEle4VKk/HMztOb0cGv/d62OyX4Scbg97IV2FM/S6Ahl3cxQZKsfffO5BGJKm6xgXQVGSZmX49bW6WABQnHgq/ybBWS2VusqEHXIznF2uRNuya1+3OvoFV2ELnjb5ASLL3S/DC8mjM5jz1xMTm8hRDaoATN27EiTJlnSmePwVcW1Wy01CgcMUmf8QK4araZNbiIXz1bQjzM3nAbs4h94WJ3mkIiueV5aGI8EgQzKj4+PJI2zmoSk8yO79Q/PAUsgH8B0lLJZ6zUGlAMNjke8fGbSY/OgNEI4UtvqacKYCK7IIHTryIA6lJveF7fCY5+8obYRo1qS4LWnOsPTKfwmQuISA1uj4c8rk5anflK4GNvDhzg3G+ITYxi4oiaBTXjwnWU2+wQrH2IkFk8+iVkkklY8hE4Rw1u58lAz/ze6EEx7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hzAgKPadv3xBLk3xDT1FLcC3NgVPAq+ZHup8Z/KCrIt3b7inN/MEUBQ0Gc0e?=
 =?us-ascii?Q?omwaWtgNdnXXOFoNr2nwZ8g8tY+QCJ+gQYisdrTmYKf4fFmF/4JbPBqNqbSH?=
 =?us-ascii?Q?dDfzTJiuBhA47UXjs47ufY+IAprB4IA0s50mzcBz3UST6hoLIvkkyAbGjhL/?=
 =?us-ascii?Q?XiUGgHW3/D1YkvSoWBTg/+bwlHfovl/2CwvdQ3kHkxdraUtCXh8tVJNNVNIX?=
 =?us-ascii?Q?huDaufyksi8HJakzrA38slBV3zOcaFukhjOJ9xLD7pl9dWCCIZ0kDWzvVT61?=
 =?us-ascii?Q?ASaPOs9qxN6NZSV03a/1hpTVMWi35RQedIbU602C3hgI51kYSoZU0V8KJMa6?=
 =?us-ascii?Q?3BP6Rx9+3Cbhn7wYyb3XmmNAIDSNF+eyNetA4KsJnm8gV8Up0k8OeEn+CEaU?=
 =?us-ascii?Q?gGyj08JyBpILQ7R3ZGxbjD7CaYYxRzSsExc7WYlWMELknvZQkEvadIFRnMbA?=
 =?us-ascii?Q?kYQh+24z1SJz9FwhEIXG9dz7/IHBdWerN/ZEjhTyrmbuJIYV+d7aRkOnFX3r?=
 =?us-ascii?Q?YUdjjfVuds/flmh/YLjko+81TL///3dkvmscDv6W1NqLKO9uzNnhLe36KzZR?=
 =?us-ascii?Q?Kq6VpkFUt43o27inlqx0xYQYGolJdWSA9UUrkF1lBgVq5LJx5qVMaB28bZ63?=
 =?us-ascii?Q?ImHmkQhtUVy6NGMd9j1fFEb80UfQtFoWxOkj1+YWlAdF+2cJRB1Z8klUBOrq?=
 =?us-ascii?Q?3DzDRW2gDkUmJSiFIVx+SomxqkaTLLlBHiYpMtkcv4a9HU+6wWZgmGB8Bnh1?=
 =?us-ascii?Q?24uVmZ4h1EG1SXs593t3ai6uLDMdptXg9Izt75KbRKJvACxqY1tPzQCR5ba5?=
 =?us-ascii?Q?R/XSCZ+FtVmITD3wO4WzxMalu4RI0dHSRtlsY/VGePsBhbeJmx/Gj4if5dQ8?=
 =?us-ascii?Q?emDNuF/Emjz73MAtmtgdmCqjXj4FS8/XYT8JYI2rLa2VlsYpxbr9tkyoj5Iz?=
 =?us-ascii?Q?6iLehOzQ0xKvGeFVmgwpr6QSLmM8AoMUCZROY1Istr53TsRMDEqVTNWECapi?=
 =?us-ascii?Q?leW4g2HyNZFVZyTLHPJsOGSQOj6H3p88MwqyYluYq0E3UbhNVu4fD67lGOAH?=
 =?us-ascii?Q?C+KrptLBuG7A516MWMsDA3GmL+cVM7Z5VabIA18kRlXa2CwVgErXiM20l9xS?=
 =?us-ascii?Q?L7d1q6hum3DjTkjXc84clTB0Vi0ePkzCnXtMSKM6P2bpkSonVi7n4jU32WkR?=
 =?us-ascii?Q?8Sps2K1VQErbB6lKaOKeXXdWc+aob4DMBtnxhq3eevm2WH/9w7srXEIYwfNT?=
 =?us-ascii?Q?/ayw83VQR+5eabp2k1KAcywr8ARgbM0r0+o0PAulSZwgHyiM5uYtzKEDIcPw?=
 =?us-ascii?Q?Q09gINkRhws+PSfbXdLFC58wJXLtySrCYRk77GPUVVqwvtMR+Wma4ezUOkTP?=
 =?us-ascii?Q?R1ccrkLWu0nKWOzG4xPBIHXixlYaE8UxvBJzefO+OvEi4tBPFCny4rg/f/UQ?=
 =?us-ascii?Q?cnIsz7ZJ4Yy8TYA9ytS/8OXMIDojU7PNhHu+iEG0c/jh8qNl5WlrjHZchzod?=
 =?us-ascii?Q?coPLp5+tYIReeiiiKOEuAWmIOU62sH7Y3S6g56XuhLjxwx9RCaS+ywJD6Jjq?=
 =?us-ascii?Q?a0th/sbQ0lNkgm2BIC1zxP9nKlz/JEhA6AK1jYcS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ddc5d6f-e85f-45e9-0646-08dc32b38730
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 08:03:03.1212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OoOpTj9MFsxJX7mwzpZYwh/VUaoVNuq3Kxvx/f/mj4Esr3WSOyb/OhkDHlQ5xwFpJWS/a/E7MxnMRIMemf+SEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9770

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
---
 .../bindings/usb/ci-hdrc-usb2-imx.yaml        | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
index 2ec62f564bf5..20bb048938ff 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
@@ -49,11 +49,63 @@ properties:
           - const: fsl,imx6ul-usb
           - const: fsl,imx27-usb
 
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
 allOf:
   - $ref: ci-hdrc-usb2.yaml#
 
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
+    else:
+      # imx25 and imx35 Soc need three clocks
+      if:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - fsl,imx25-usb
+                - fsl,imx35-usb
+      then:
+        properties:
+          clocks:
+            minItems: 3
+            maxItems: 3
+          clock-names:
+            items:
+              - const: ipg
+              - const: ahb
+              - const: per
+      else:
+        # other imx Socs only need one clock
+        properties:
+          clocks:
+            minItems: 1
+            maxItems: 1
+          clock-names:
+            minItems: 1
+            maxItems: 1
+
 required:
   - compatible
+  - reg
+  - interrupts
 
 unevaluatedProperties: false
 
-- 
2.34.1


