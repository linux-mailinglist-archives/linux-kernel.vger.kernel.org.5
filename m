Return-Path: <linux-kernel+bounces-125083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7697C891FCF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A4D1F2F45A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79B72904;
	Fri, 29 Mar 2024 14:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="b8LtGqhX"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2130.outbound.protection.outlook.com [40.107.104.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076CB1487EB;
	Fri, 29 Mar 2024 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711721787; cv=fail; b=mS3K7vjK6RrTW0yU2JpA3kTJu0jlctRIvoACbYahnWvQZ9By/Xjd1GNQegNSWdw9AjHxAELKxWnf+pf6+sy11pS7vb+O7Gbc0YaYoJtJOvkJieE3DcHBPxUZOpSF7fpTFYnk6PDEEq+X5K6zWbqBqK94+dfa/ZbmxgOq9Qw4tSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711721787; c=relaxed/simple;
	bh=nWHPPQjZdC35PJ/HWo32Od0q5Vc1KtEYPU9xkjqfJ7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JYeBfrB2iIyhEJv+Mc4RA9wvm8A5SWr6wAmqf+vFDw3xF4+d4j4EuaVIMGOsieeea8ixQfZXhCY46rbjQjBMCrZnzkWvS9n37ruGcSTtIPWnQyNT/WgdG8YKm1aPTL491ddCCKX0KEVvXwKr+r183CgDbrAzD8SNlX+4fyW1zS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=b8LtGqhX; arc=fail smtp.client-ip=40.107.104.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jp9c7GZEX+XQrJBQdlgZtGQYZ+bC9vseY0nbPAkYBQslV7g01JSxGdR486FWLLx15MkBwd+RPHL1T56dNFN/jHKuO6g2KQC2ovGvZDIWiPRw+xzX6B0fZo0FcEQRkhRCbWqTkj8pO2vKsapd3s1wslPPGq8rfS7D7IsfaQtVAoI6x5WzwkrkVRUeiJB6CUji4VXac1Onx1yexZ+dWM6c9qlq+HwZQtxs63x4cdqjoZWgwhaXUSx+I8ddNYJbCQdLuJLThvNGMULHzTGFW8k7v3QPh3PMsUm+HpH3rdQ+1eqPDChRu/wDOWQmeOgvNJO0nhdk8xaNXcqmgPAsFfs+OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mO4u2miKqmAtK5dNZeHu06GoklhirjrvlOFR68X7ADw=;
 b=SSnwdzhTyIflORsGN/TNZeiz0t/yZPs4n6wOoHyYLUo+92exTwZrPRD8CYoyjCKT6JaWQAlvaV67BlADmBLgdN2yBCkIakhcXzqAyNJsXfnRMmRzbXrji9FXYXRcLw1PGHz+TPfIaa1LzUWo2pSLN9WSuZLdtT5uHazJqGNF0yrYMEtyNMIqNNfJ8csfODo0fp505r+ja0C4SlacTxhY781MU/yEv7iQxqGL+wKIyQ+LrPShXS22nMO7CixCIYHkZXw8mem2M3NNUXnu0sLjG+3BoAPSAjfX+ZDLR0yB7X/65FstU1oguyWh3ttdJmDXEaYTIlOnupqUMjAgW9dfkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mO4u2miKqmAtK5dNZeHu06GoklhirjrvlOFR68X7ADw=;
 b=b8LtGqhX7BMCx5KaAxEWIYomoqSboqjlDSrwIwIRgXHh0/6oK93HfbjZUdRhmEySHfmuAUooTBQBBufDk6c4gvLVsf4aJV4pNglaeHADrUEuaWw0r0EXHCzBESqBwtLdnPeF3dksi8OjnQsGdfrjeA2L70pKCYPTfM3oyHlnNyU=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9512.eurprd04.prod.outlook.com (2603:10a6:20b:40f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.39; Fri, 29 Mar
 2024 14:16:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 14:16:22 +0000
Date: Fri, 29 Mar 2024 10:16:07 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [PATCH v1 1/3] dt-bindings: phy: Add i.MX8Q HSIO SerDes PHY
 binding
Message-ID: <ZgbNJ3w6rzi7erNt@lizhi-Precision-Tower-5810>
References: <1711699790-16494-1-git-send-email-hongxing.zhu@nxp.com>
 <1711699790-16494-2-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1711699790-16494-2-git-send-email-hongxing.zhu@nxp.com>
X-ClientProxiedBy: BYAPR05CA0084.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB9512:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ho4Kt2WpSKnL16t9UhZpcKkl/8NKMgSEVkf43s6OkG4nPmVWrR+GZbaJlk+RoZ2vxAkVnMrg9v9aKwtnn8RhNZVrsc7zjQ1uRL+a50f4wGZ40edORAYz3Pv8HG37w2ozO3IFotE9TLws3bRSrO3SX73aS2/Bh2p1fWCWSjkwnxh8FZ+FlgMbdNYafLPjKb8B5SElZEqFUpp+ANkXiGU+nL67cHInJxBZYvdjCUNG4jhWgf5EQf+m5OgJqJaqeI9teYaQUuHvjuZwWR6868MjrIS0Y3iVMEIR6+ZCitgAN8XdfWf8JN4oTCUQpVwdMkvaV38Tfws1qABkaF9RwkOLI7XmBlpWtlJ+NvzTfwrQVdrmZqdU6E/o3U2Kzsch+Ro9x9xfxdf6TjXggiiP56PCw0kUGVJw60PZRMDSzoOptKPqCa+9yx8e7wvnIFl3yP5CePzd7nKcryBOMPTayKdkBQLXQ3VuPOgI4aGerY0Pb2PX3PXutx1/cdXyA7ql1xAov7hpU6qhL4uQiqgnJlO23EcXJtNPlLs5WvVHOU0XyydPrfxpmE2n4xhdApWD5XZKCzOg0Jnjx5Eue+zBqqP8aSswemKS5qApSGz8Q3z6AZ42dBpvRZXeajD638TE7N+EfTOTlypWYXtQ2DH3rCnWp294FaBtdCUqxu9g5jPQ5/U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CHS+j97RRplYIpSG8rGm0kiAHAwxPiOikyHLGVui9BxuWbLR8OyqAJ0TUvz7?=
 =?us-ascii?Q?0HPd3yw5yq0PshsBOHqLOUHZbKndWf09u4w0cQBX87cLD2S3sgLtFJWTFD5K?=
 =?us-ascii?Q?HsdkhTd9pQK0fzg3mp9IDuXLogTJgZjDC1uuOaxLI++LqoP7i1p0aOfSUIoM?=
 =?us-ascii?Q?N7u5vk7sEqa4aBrSoFzTGFw/wHrG+JWCwBTH8uM0eaYma59IV/71qAz7VPSl?=
 =?us-ascii?Q?c238vgAmLU5y8dEFGLum+NmdThP8UQoqirrHiehZU8lR2a5n8fU7Gk+D23JW?=
 =?us-ascii?Q?6mvJZalB3fBtJYK0KsuoL/6BZ6s0/MJgMrtc9MEsQGG+OEPS7IW4YHzJHHYC?=
 =?us-ascii?Q?VbsL0ZsnOc08gj/tJBsXhdQphVTtXHVVXd+KcEEeacboawHWVcn1JFsNtkDm?=
 =?us-ascii?Q?fcuyzeJqPz0Y0FbJgdN+FMG/4IMCNBwTrTNnBQXVKU2ClZzfg6Z910ASEtnE?=
 =?us-ascii?Q?suRfJWWELXqzVo8CM9NgzVS+YyrotcDl82/gyLYQXqnUnT4/RETd70HZ0BCf?=
 =?us-ascii?Q?q6T4BpEO/ptEFpIxs+XQnrcVLvYgijMFQAkXSsSNu+OD6Z63+VEFok28Gi8r?=
 =?us-ascii?Q?XJEcZIxpJb/VfwkgZ1P8rH186zERG4JUMFOvhhAga9LTtruDyV8erWjxRQv1?=
 =?us-ascii?Q?UlynW3oqt7wDxm+5w94kw4uhjrqOQP5H+TMiV1O8PKOivdWxV6GAVxV/KxnH?=
 =?us-ascii?Q?gDBGH3Abn2R7Lckyp6WrqIeZSg8i1EOyRCu360XZC79UDiqJxccTAlhMsrji?=
 =?us-ascii?Q?JoGSB+/5HfNjL+DZ0lYZ6V9siB+F7MMBAFs1rghfeqwgM+OhmQ8yGoHBn3Rf?=
 =?us-ascii?Q?hhoE4b0OrqO7OTxJ8H0ASBeSzLqNzabNmuFOh/Zm+/89vI+yBE7ozPqAn9gM?=
 =?us-ascii?Q?OU2Faossp7zAku4XtEOiZtYVcSnTKRhk6eFR7Xj/pXMycZtQK1FtdV7/89fm?=
 =?us-ascii?Q?feBI/5SWPkTCZD5mLOX4dS2GDg2/rpy5v+YOn+6daZkF1/QpolBeUs1dv2RO?=
 =?us-ascii?Q?3MbiRIHtocBznH4QcFUMCQZqb0/lb3vfaNDSv8jJR8p5hOiDHStg7M86Cs+T?=
 =?us-ascii?Q?j6YuV7ghFb22W7cuEhTBBYOfCsVMla+9WnAoH1EYSOxG9cTdQ7caY5beXmlF?=
 =?us-ascii?Q?ncOmc3wx5q4C3A3eWj4bCVIe08XHTae1+vR3pKJgdTR5Zkwfn9uP4yn3bqfN?=
 =?us-ascii?Q?Ehv8+CvKVJwvfrrBa9B2r2ulQ0TetN7P2D0yNdRS+oKTSocx/vfggJHezJah?=
 =?us-ascii?Q?qcippoBYVeHjv/xhB3UOGNVZqxteTIsks1rBHhmgFGVbvTgx5TVpZWEr1MkJ?=
 =?us-ascii?Q?f2rtV0nvAjYQJXYVFZO3hlj33qhEcTqxo13pJrif4tBlvNUXUAByP0uX4IPR?=
 =?us-ascii?Q?PZmSWhzjpDUyF8Q5HVZR4F4gptIdjxnhthh2DCkmstqKdByGhbWocIy9sxHs?=
 =?us-ascii?Q?r62GWvvDpyx9leFrnkJGTLXdRJScwNDcLLJ7SS5E7w+P2OJrk3Ct3R1o9SZL?=
 =?us-ascii?Q?vSzhJOb/HnMMEYqo1i/hgcgFb5xl9I9Nj6JAqFrQD88TrErWgZ3WHCpb7rQ3?=
 =?us-ascii?Q?GUybuwS/XyltagaCcxoR56NDBF+pp6rH0n6jYEM9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 061d2bff-05d8-4e30-a29b-08dc4ffacf68
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 14:16:22.0763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UKawmL7AwjurCRxEoBZGRjCIIuCTV98FY9XGA0p0bWUgDXsRWOiRs3PRBntcz+lLwxK5FRLTHRO1qGKWtikTrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9512

On Fri, Mar 29, 2024 at 04:09:48PM +0800, Richard Zhu wrote:
> Add i.MX8QM and i.MX8QXP HSIO SerDes PHY binding.
> - Use the controller ID to specify which controller is binded to the
> PHY.
> - Introduce one HSIO configuration, mandatory required to set
> "PCIE_AB_SELECT" and "PHY_X1_EPCS_SEL" during the initialization.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/phy/fsl,imx8q-hsio.yaml          | 143 ++++++++++++++++++
>  1 file changed, 143 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8q-hsio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8q-hsio.yaml b/Documentation/devicetree/bindings/phy/fsl,imx8q-hsio.yaml
> new file mode 100644
> index 000000000000..506551d4d94a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/fsl,imx8q-hsio.yaml
> @@ -0,0 +1,143 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/fsl,imx8q-hsio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX8Q SoC series HSIO SERDES PHY
> +
> +maintainers:
> +  - Richard Zhu <hongxing.zhu@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx8qxp-serdes
> +      - fsl,imx8qm-serdes
> +  reg:
> +    minItems: 4
> +    maxItems: 4
> +
> +  "#phy-cells":
> +    const: 3
> +    description: |
> +      The first number defines the ID of the PHY contained in the HSIO macro.
> +      The second defines controller ID binded to the PHY. The third defines the
> +      HSIO configuratons refer to the different use cases. They are defined in
> +      dt-bindings/phy/phy-imx8-pcie.h
> +
> +  reg-names:
> +    items:
> +      - const: reg
> +      - const: phy
> +      - const: ctrl
> +      - const: misc
> +
> +  clocks:
> +    minItems: 5
> +    maxItems: 14
> +
> +  clock-names:
> +    minItems: 5
> +    maxItems: 14
> +
> +  fsl,refclk-pad-mode:
> +    description: |
> +      Specifies the mode of the refclk pad used. It can be UNUSED(PHY
> +      refclock is derived from SoC internal source), INPUT(PHY refclock
> +      is provided externally via the refclk pad) or OUTPUT(PHY refclock
> +      is derived from SoC internal source and provided on the refclk pad).
> +      Refer include/dt-bindings/phy/phy-imx8-pcie.h for the constants
> +      to be used.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 0, 1, 2 ]
> +
> +  power-domains:
> +    description: |
> +      i.MX8Q HSIO SerDes power domains. i.MX8QXP has one SerDes power domains.
> +      And i.MX8QM has two.
> +    minItems: 1
> +    maxItems: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#phy-cells"
> +  - clocks
> +  - clock-names
> +  - fsl,refclk-pad-mode
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx8qxp-serdes
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: apb_pclk0
> +            - const: pclk0
> +            - const: phy0_crr
> +            - const: ctl0_crr
> +            - const: misc_crr
> +        power-domains:
> +          minItems: 1
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx8qm-serdes
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: pclk0
> +            - const: pclk1
> +            - const: apb_pclk0
> +            - const: apb_pclk1
> +            - const: pclk2
> +            - const: epcs_tx
> +            - const: epcs_rx
> +            - const: apb_pclk2
> +            - const: phy0_crr
> +            - const: phy1_crr
> +            - const: ctl0_crr
> +            - const: ctl1_crr
> +            - const: ctl2_crr
> +            - const: misc_crr
> +        power-domains:
> +          minItems: 2
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8-clock.h>
> +    #include <dt-bindings/clock/imx8-lpcg.h>
> +    #include <dt-bindings/firmware/imx/rsrc.h>
> +    #include <dt-bindings/phy/phy-imx8-pcie.h>
> +
> +    serdes: phy@5f1a0000 {
> +            compatible = "fsl,imx8qxp-serdes";
> +            reg = <0x5f1a0000 0x10000>,
> +                  <0x5f120000 0x10000>,
> +                  <0x5f140000 0x10000>,
> +                  <0x5f160000 0x10000>;
> +            reg-names = "reg", "phy", "ctrl", "misc";
> +            clocks = <&phyx1_lpcg IMX_LPCG_CLK_0>,
> +                     <&phyx1_lpcg IMX_LPCG_CLK_4>,
> +                     <&phyx1_crr1_lpcg IMX_LPCG_CLK_4>,
> +                     <&pcieb_crr3_lpcg IMX_LPCG_CLK_4>,
> +                     <&misc_crr5_lpcg IMX_LPCG_CLK_4>;
> +            clock-names = "apb_pclk0", "pclk0", "phy0_crr", "ctl0_crr",
> +                          "misc_crr";
> +            power-domains = <&pd IMX_SC_R_SERDES_1>;
> +            #phy-cells = <3>;
> +            status = "disabled";
> +    };
> +...
> -- 
> 2.37.1
> 

