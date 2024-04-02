Return-Path: <linux-kernel+bounces-128128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18293895681
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B7471C224D3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C4986256;
	Tue,  2 Apr 2024 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="W/tzlu1M"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2091.outbound.protection.outlook.com [40.107.8.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD5084037;
	Tue,  2 Apr 2024 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712067839; cv=fail; b=RsdQ2j0JXZYj3FPA6LzwovPOUdgtLCYoQ6rXMn7zliRHHHI6049Srf80xseEilGruWrz2+hmWW7ZwPeIkuNdRMo+EG6GGnH4PMXbkcn6y+JmxMqHFFLcDyx76o5cBeb9Q7AZBbQ5d6nQv9t3mtCak6g+LGkJ8UXscA5rCPYKyq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712067839; c=relaxed/simple;
	bh=RMhr9dAlrxg1Ls2e5M+uJ6DwVawTUDE5zcWBo0c6kqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eG6rNMZhZTi0TlZw9NWVD3/Rt96RDEgYc33dvxLhiSGIb+CU+f6/OfYamm3YqNmqsLhhdq8cYkWH+H1eM4KvlLsK0MHWcOX0tjJpL0Oh8atBjvNa292ILsqIwPpLBDUcW0UfrCqvl8afb0YNE5nCgjXOeRyZYzvVfK9jF+9J5Hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=W/tzlu1M; arc=fail smtp.client-ip=40.107.8.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGI7e+xNlwj1qsvxwdrP/KWDFsOH5iFDXrkMPnjmPEzwZnYyZtP7WJ3k1Kuw9woHkZ4cWbXygli0qF3ocCPbEcQ5xFGUzWPDfzTI6NAaCpbZN6ndYokMgZI3CMhlIHABay/0k6D4IZaK0VhNt7WivMAnH26APxgqOq2nsjhg5/7WPUb88pHW5H1u3QyKvwFhR8GIXPTNueYnOgxHXW9WW2OjtiFmKEC1YFgbl3Gpj1QXFBMjfwzCCEcRdIWFXNeo/OezXAYqspY3sK+PIhrE6qxehTvKXnL6sfkI7IFvi9t36oKo67g/qCwiDArRaswXMyYKQll44jsowCisdLqhuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0X/tKKJMhY12GVY+5NF5MO/RLy2Lljf3RBiEJH3vPo=;
 b=RP/AXOovvPrEh8KewZT58M7n8sX4X0XDdxrmhmzqlbhpgwOux5CLnsrPnOPd9b/JTcFaALqu9ZNQzLKnSn84Rh/IbHjDP0XT+FfhqnPWcsV5bOwKQ178oAMuhcYD8FEKQSwlO3Gq4rmNiNGd7U2rku63QxEBWod4t4QZ3eqb+Ewzz0a7aqIy2LcLg+X175QTLkIAFW2YT0JBQyvLR6m3b3ca2nlMMfMICX+TTngnUbMMtq8kqjXWfXKtrPWh9rMLuxkBU3XVR7LO73tERjDUV/7ShAeUpTwXLOv2dIKEAAD0ee9EhChxNiLNKw8GF9X766gQcMgAXX1hJdEQpKQYnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0X/tKKJMhY12GVY+5NF5MO/RLy2Lljf3RBiEJH3vPo=;
 b=W/tzlu1MCR4e024NPm1lpAYSYN5l/SrBocrgmQI02NwdQjtgGSTbQMGEvKAWURW+6v1QYvLeG8NXFlKVBKM/wcETWGi/mHf3DtbHJnA5LFX/ODjjWzQkaxoUMfJHfODBtpFLtT4FJi8+ny36KI1rz75X+E44oP2QyjzeBF+lzbg=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8910.eurprd04.prod.outlook.com (2603:10a6:102:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 14:23:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 14:23:53 +0000
Date: Tue, 2 Apr 2024 10:23:45 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, imx@lists.linux.dev
Subject: Re: [PATCH v2 2/3] dt-bindings: phy: Add i.MX8Q HSIO SerDes PHY
 binding
Message-ID: <ZgwU8edE3VFYngWR@lizhi-Precision-Tower-5810>
References: <1712036704-21064-1-git-send-email-hongxing.zhu@nxp.com>
 <1712036704-21064-3-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1712036704-21064-3-git-send-email-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0058.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8910:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Lq95aTG75BgaOiEg9opI29D6GpU/4bmLtURHWw0LKX7anOB24rLEmlKFId63MqLuRdNQqL8jSzaLJ+HhTzXVy2jGBx6O35uquI97pfwqti6JzkqFQzCWWnUaY+UKTRy0bqAO4VH+INa7ytPelgBJx44ye+6haLuxgYO8Dycd4YMj+i/A4c8/iChhk2Cet1k4cNClVutgathK562bTBXbncbq/7R1l7f4CeUu0XIiaMAa4cz4uOBhRXJHYnOojSVMYoI8UweZSiLiNs5HM6oV2fL8L+cX63zkNve8WDMrOfhY/Zxd9z6y3+XKAU4p/12tLd2POiXYQvyGJAPYzjQE8o3Bbj5qZhg9tjD2hAokSWEn4013r+5bHiKrSsjCBj0dMMPwoP+Tz6ut7MdkoqI3wCMHQMQiaja/o38l5SaJofM1pL7S6n3HIdMQCGW5Z/8fFjq+dfkujenpBI1cHHrc+whJv6qDLnHOlkMDtDGCe1K4e3/nIGA73FNBwhBf4LKWMgamQeU9mZCseiS+jJVja2hYMB8U298hbgfHSkUfFAOXl6YvKFNCveTCxB6DtXveyW4gBdn4W4k545sNY1VjPVg9N4mph+mhTDSBG57sHVSlyEq0UqHwDZW6yU4kvkq7CmPJU9HjnV88Mxq0BI+L0r9bY5JKnOBRSXw4U351rPw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hJxfEO4N9WU+aiwhKXp/NLRyolFzLILbCZM0JZASfcpqsr6dS1CYpLVUOhn/?=
 =?us-ascii?Q?Nk8ckfdIvkWHS0sw6Qc4ckUBPQ3F4XEYwJhf9ipOhSQhjpBeaYCGFSQHwnWs?=
 =?us-ascii?Q?dzyKccDYpm4Kqqo+atUo6Z/cQ/A9C2eqQv4pySzyZL0rQTHDlRsbDh259QFU?=
 =?us-ascii?Q?HPUN7RwLtcX1pT7JWZ8E4Srx78SJW0r+JEa+eAP4KVpMB4tkPTJSi93wcAAM?=
 =?us-ascii?Q?sC/xDSFDKL5bvxAeBeNF4/RkM+4+IhmJzLkFGhM9e2MYK0+WMacj3ibeumcf?=
 =?us-ascii?Q?5nbRI3I6phSdZF1hUUprES4S1wOsmNChYIldpi/CsMb5tgiXgd3hmuM3JFai?=
 =?us-ascii?Q?Gy8Fna1ioWplAywo5n2ixd6JHkfQPE/u9n7RbVQZnU8PQo8jzpUblF8WOBpR?=
 =?us-ascii?Q?wNS9cy1pSyIVgF109JIdcuDjZBY6XFouaR7VzxBThm2BvV4KJrE3s0dBaQNC?=
 =?us-ascii?Q?Pqd7V4qLzC2C2dtKMOTSoTv6suar+2AWLov0j3az0Pi8hOR0HvqMukMmnBgu?=
 =?us-ascii?Q?o77W4PPYOsnPTYZT7xRnUFYpW1EWStPD6hKuEqgAbBWoOT89AZd+hPu9SDas?=
 =?us-ascii?Q?iaaws+F0cUoNif68n6IJLAidaYU4WSFsP8e8aP6J747a1yOrc3jqac+rRaF3?=
 =?us-ascii?Q?iP1p1ie/kCdrXkdBMVPVlmegQ/K8cvWWm+08A/2/2PxF0st8+iTQun28KfC0?=
 =?us-ascii?Q?WBDvwEvlFXXhgr0YKVxxbRF9lpZtd6CIPM/JaCEXp8bHHDZhvYxQztAbc985?=
 =?us-ascii?Q?rUfTW45NXq4IipGTtv/pbwTWTLbybZnEoTnxR/syYl+0icWN9Vso0UJ8zScj?=
 =?us-ascii?Q?4vQRYATvVOpWu4nWNXoam09xp50t+Mp1mHdTzHiE+oI1ie+EKrxKqH1Ks2Mm?=
 =?us-ascii?Q?fGbovFLp5gLl8pCVmQUgW2WpJBHBVmGSTYLJcqh4Akqgl4kC9vRx9eloR2s3?=
 =?us-ascii?Q?SgZlKLgBhXxic0ImIWp8STvp805UpL66PM/jO4e8RqTyLRLKL03M2zFxUDkp?=
 =?us-ascii?Q?b9uHmAM0WLmn2V8ZOLWtVaWu2ZurEPUJAqGah002XMZF/pCMFo0JM45XeqHi?=
 =?us-ascii?Q?ASc7wh5P1BZt/5QsXoXHeTlj8Sm6PU15qLgBl9PUQxz/zSb0Oc8ooIeKssTp?=
 =?us-ascii?Q?7uhRNfzlVGkujfHFhKFBsWrHt+hHrSPieWw80OQKwsSkaA2/1+zEppaeQv18?=
 =?us-ascii?Q?u2PLGNtaKsMO/SJ9Via2A9tA4svL+0v4+p/R5wVBs9ROro3SLANcbrOcLGdY?=
 =?us-ascii?Q?1vvEiworlNGKEENXm0T/6Smq7+uXkNPOFRErArQ2YFMomkgriP5JvqlLtn7A?=
 =?us-ascii?Q?OUTstlrIw+2jEEs5a1wFQczV0cc1AQIPhFVoGXPRhYhMoUl49x+aKbgMoyWl?=
 =?us-ascii?Q?24h9JW6GdqO+ZTsm+eFINBLtduQWBnAaSmbkdth66An82aA3RsZVA9pd+0tL?=
 =?us-ascii?Q?CVtvjXVlqzFxvvLGUPyFnoTvcZL19GeEFcnUKXwX6J8pgyPvxv8Gi3fHSHPp?=
 =?us-ascii?Q?uMUKNfLEosbSKt19/jLIN/AHi9RoQsa0E4Gp9E/GyPwr8gKOhHhDLSY9mwOC?=
 =?us-ascii?Q?RIh8BpaPx8D4nLStZyA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be349250-44b6-40e0-cab9-08dc53208637
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 14:23:53.7699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hws+jl9jV1ofjAy4OpzjvenKfbaOxTuHnnepdFVGbOwGfA9lruKKpmVksve8FUAQv7wMIDU4q4HE4ejDTseieQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8910

On Tue, Apr 02, 2024 at 01:45:03PM +0800, Richard Zhu wrote:
> Add i.MX8QM and i.MX8QXP HSIO SerDes PHY binding.
> - Use the controller ID to specify which controller is binded to the
> PHY.
> - Introduce one HSIO configuration, mandatory required to set
> "PCIE_AB_SELECT" and "PHY_X1_EPCS_SEL" during the initialization.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

You missed all conor's comments. 
Please double check v1's comments.

Frank

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

I remember needn't enum because there are header file.

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

No "serdes".

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

needn't status = "disabled".

> +    };
> +...
> -- 
> 2.37.1
> 

