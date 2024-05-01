Return-Path: <linux-kernel+bounces-164832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 878BF8B83B2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 02:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75E471C22141
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 00:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84B810FD;
	Wed,  1 May 2024 00:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Ry836726"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2082.outbound.protection.outlook.com [40.92.42.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4A47E6;
	Wed,  1 May 2024 00:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714523301; cv=fail; b=KT+pqnlrNdvGdhrdCxpXtlM/tLBwuVQfpxH46nS2/twGff2eHXDdqyhr/O6eMnetuLhSFyT1DWbI0T8N78iOSNUGpjJUIR8VcWmk6fr3HYXVCjR8W2KO3RT9oS9ttJXrgNnCFyd+eGdqNcew/J0oGqIhgkvVW7bR1kH4PjQhaUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714523301; c=relaxed/simple;
	bh=8E+R5eofkOReaVi198L30iJpjtbRq/fVKHnKtWbW7KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bj5PhfCkFXy+Um7iD8uUX6mX1jiw31jd68fN07sxPjSr7a24ElbB6aUrRUJEH1Zln/1peqJKWgrVIqKpFbRrzEeL46xcRJxq69wrwuZavVLwZRlfaqHhBQ/k+sRtJRVcwdHSRpMfA1jVKOCa+UfcY8LBH4hTMHXFX0Ko8zCxOBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Ry836726; arc=fail smtp.client-ip=40.92.42.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJ8vdy9PQ8/PLEGf44Ja76GO5RsYrVSCPS+HQcAsfqXnG05JtillBcVP2zHiV7Jo92mMLRnCbxwaqmsxdMXny+CwKvWbT9qyHqMSSXPfXIo41gHtCgDJK6enVRWZhqLyNT8rmnCyAaRtgnlNyUYmZ1Zpp0wT1wLJv5BxLqhj1RtEFMIEKz+Li4D8Sy9Zhdj0KAy7LkZTDyV6soFK+D2uFb3hjDLG3mfc9RfXdj6gcL1vmZKAcxwSkrvHGUUvXqYMv4PU5a1M5vuA22E453v6+BWYqKVdHQhIoM3K4yyPRtX5KPcuv+LjI27w4yVjCCXFKYba+9hfsqTMh0fJCicL9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epBFYB3Tcv45E6oDutf3k1ew+s8ZesgUmK+L9DQJPoc=;
 b=OxqhW2SsSArIaAzvA4MqHfmzURYOJcmcJWo1z2pk3J0ueV12HjGZ9MkRtKuh1VCEhstIi3scI240DeyNeFvKeo4TzxZEzKXNLzW0R9+5z3xcdtQ6qAy/CefrbsAqDtwonIKN0sZsZ9Gy7uVZhj+jsdPfrYvukj6BRuHKYzJz84dIrqgwj8Bm2Ij6THZd1Iw6+8URl6mqK9heQhlt2x5uqON4PXs5jXOq6Oxw712059vY93A18KgemJA69n9bUmLhZ6NW6LX3VDSZsm1s0MK28HcUB5QKahKbP0JHyOn4Qn3hbnDsM224+DpAZV0ySjELiIinW8TJm5YOPhxrVFVrlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epBFYB3Tcv45E6oDutf3k1ew+s8ZesgUmK+L9DQJPoc=;
 b=Ry836726lzJWNcm+oVL4QnWHXwopIul5aHejk/WB6QHPw3vpl/JCk9iwhLzlwJn024SjzLEK1OIXY+1KDySHesddNNHRgKJbOJRh6eXLK+2/3RJhfNxsgwffZeJroSQmC23J//syZjw97mP693HvlId+FG2sJvVfC+RBZI9QpGDP35CS80ks9jJwCFKEW3uiJKwbw3EJxx01drfVduMMmuF15Ydt9urQymGrEj2FNZtOlV0WMS3HeM8wqXeUHigXPp43pmdSBjmAP8LCJyS2eEODsFYtsknOvCjGkoHKgjhU+V/zQ1CFZAFs89ljug77S4blwH4aJPqeHwpSpMj0/w==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB5549.namprd20.prod.outlook.com (2603:10b6:806:2b9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Wed, 1 May
 2024 00:28:17 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 00:28:17 +0000
Date: Wed, 1 May 2024 08:28:47 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Conor Dooley <conor@kernel.org>, Inochi Amaoto <inochiama@outlook.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Jisheng Zhang <jszhang@kernel.org>, 
	Liu Gui <kenneth.liu@sophgo.com>, Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: Add Sophgo CV1800 USB phy
Message-ID:
 <IA1PR20MB49535665CF1C89FFB4E1E46DBB192@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953182B8EDB465430289400BB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB495355A4186420B78BD78F49BB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240430-crummiest-overnight-0f46dba32bb8@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430-crummiest-overnight-0f46dba32bb8@spud>
X-TMN: [jK8xXiqRyD1Hsu4E7Qx5yNwyeHuKfQtgOOf1lxrSwKg=]
X-ClientProxiedBy: TYCP286CA0175.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::14) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <h3w62i52ioua6u33mxdg6ndmsvodfqj2k2i4r2wewt3yfsweoh@nbtjxis6zvh3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB5549:EE_
X-MS-Office365-Filtering-Correlation-Id: b5f3d48b-4b73-4949-730e-08dc69759884
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1602099003|1710799017;
X-Microsoft-Antispam-Message-Info:
	jITKLcSrRvpaMizkhvksd920dfl1ksdfozpHC8mLmjg/KvIZXRYS+ZY+BAJ89eWVqvg2imTpvoXtD6+GP51FcWv1syEur0v2+jWrHWm1y4JpwaV5qhfckFs9xSsGLRs8Ypc8Um+mbFZdRQAm34gerczznHC+Md+3BADPw/W5dzDsiX6P16cvZ013AKVF3cElEi5Mev0bcu/bD+An+8a3hJwbFOXuPbycuDPdqcu0/h47aiV2exyUQM2GvqDLHDlIE73ArdAj0bMYUf7IOsvtCG0lRvkbIj5ySXR74XXZp15fkMqPaLxEQ5r4HzAdIES4X1vYVIB/7tla7JcA2AGsqKX8wOGbveAn9J8Vv4UONRDe5ObhWPsFUMOAgPzAlq9O9wgF+HLj6gGFklX5D1QttmsXtNlGEyXQycixQ/xisItBIN3vFi2UTZZI7xDn6F+HeHLc8NZEQFSBN9xcKTOofzWNDDxNGTmQVHxRabZ9FJW1AJfGNpydK9xcxK6PCTfqjoOUokMLIRd21c2R/8UQFdF+s3qmQ45qkZeC3h8BChgKerGyy8LUvWWBIPDFl6LtP+dyGmHzv1mY0+oDO6qY/mi+fVSr0VDuZ64ZgD4xuBR5hJEqacJOG3MFTurRIzN2eXFuhLfegymloo+Ir2vKqgL6lecOERxj5r47OyEiKcB3mY04wxeB1hyA7DN9xrO0
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fhmb39a9xOt5mtTSwTaAS7LGxNhMgm8AzQG2iZRlzlqDeYXCrMVJ6lQEXk5U?=
 =?us-ascii?Q?E0mSDPacY9tKkW17SPDBaLb6qNR90Ju2Gv8iZGNXz33FDuVAN/O3I3SP0YDo?=
 =?us-ascii?Q?k3wb7FxVwosV+eRM0vR9LsuqrVhvWUxJnx8S8SuxMFFk1wW54owa8BDkssSq?=
 =?us-ascii?Q?uPyufCHMeOxKdYo9IlLHz+L3k4GOREHDm/N4yMcrt4FwdJDr/j3apDSqglPg?=
 =?us-ascii?Q?ua0o3C9E/tzONaUkSHtLILjSOq1KQfy10SIzsO2Fe8sppX0LA5JVAqGXyfPu?=
 =?us-ascii?Q?t2NFDYTBpBZPSIvC1zIpTyO2TN177eugry5jW9UcpNxEgjAIakv7sgWPLtpl?=
 =?us-ascii?Q?aa+cul9na6DUf/nxM0P1ArQSFheFdmraQzQ2Ave/8oDnVaRQ8WrmVZUxMg7h?=
 =?us-ascii?Q?Zrpd9pzh1fXTZPtoXk8Jwx4YNi0XmFIrzsxNDSWMyMNRoBKi61VvcJ1Gl5FP?=
 =?us-ascii?Q?a/5QMmq0rEJuub/xqN8Rd9lEGZ3H8DLK68wdT8dztzqA4fudjlygNSghSyFp?=
 =?us-ascii?Q?rbgu32FTgrg6FMG8ldqT146bLiSpVNLKwi8Lm8dPyLK0SEc0kITdr0OPEnv8?=
 =?us-ascii?Q?NoWW8ACsrH7GACFAldER2Auc4zSI9gzFhKOobD4J4ExJhcA79Jmzc3+CnEzl?=
 =?us-ascii?Q?IKp8vxSWaOUrOYM9UN4Rv87UUySiuXFtkoJB5l5pzt0hU9dHEanSPrI+SkAs?=
 =?us-ascii?Q?33Mt0YBQTc8+s4X/SV9fpJpKtMAB5MOUqm1QRnqzs9DZbEDDcfoacsINTfj3?=
 =?us-ascii?Q?EEp/FQfygJSkkvva4/YVNttnGHTfnP1sFfdDH2pWyNDqYLoVKakDC7tMUL7U?=
 =?us-ascii?Q?ZsagBDKEUu5xMFgj5o9GUkhRES9ZBPIzimZYg3QtA9KzhhXljaNfeVYRxzP7?=
 =?us-ascii?Q?HCVpTG/wCvDyQ5AxTZNwD5SQbfydiZijq+Kb1oaAB5eHX8vwIq2+KpAOJJqQ?=
 =?us-ascii?Q?36jCejDoJ7Cl25qZuYiH2zmBU47SkgbjE+sRmXvY7CnADg9I/x8oz6zpnwPg?=
 =?us-ascii?Q?KeI5WKZ1Z1bjSG/mv23vqZIu/zTh01+T6Q67hM9JI1WOIvuye4kGgfHa0OI4?=
 =?us-ascii?Q?tkXe4gb7z3Df9UnZiu2tyAr4yV+WoGlj9J80lWSA5vkcakUj8K3PoPfDpM3K?=
 =?us-ascii?Q?OheVpO7UMnOabBc/djy/r1dVLrDhKHt8wadNFg5J/2huPEy71muIUJYy9zFY?=
 =?us-ascii?Q?zS2UKLphE43OgGDYQwYKrjQYar+xa7vF70e+7CGg8itSu50CSkeE22fJho0o?=
 =?us-ascii?Q?M3yEKFmncQnNbOikwo1i?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f3d48b-4b73-4949-730e-08dc69759884
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 00:28:17.4230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB5549

On Tue, Apr 30, 2024 at 06:09:20PM GMT, Conor Dooley wrote:
> On Mon, Apr 29, 2024 at 08:31:11AM +0800, Inochi Amaoto wrote:
> > The USB phy of Sophgo CV18XX series SoC needs to sense a pin called
> > "VBUS_DET" to get the right operation mode. If this pin is not
> > connected, it only supports setting the mode manually.
> > 
> > Add USB phy bindings for Sophgo CV18XX/SG200X series SoC.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > ---
> >  .../bindings/phy/sophgo,cv1800-usb-phy.yaml   | 68 +++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml b/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml
> > new file mode 100644
> > index 000000000000..7e3382c18d44
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml
> > @@ -0,0 +1,68 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/phy/sophgo,cv1800-usb-phy.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Sophgo CV18XX/SG200X USB 2.0 PHY
> > +
> > +maintainers:
> > +  - Inochi Amaoto <inochiama@outlook.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: sophgo,cv1800-usb-phy
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#phy-cells":
> > +    const: 0
> > +
> > +  clocks:
> > +    items:
> > +      - description: PHY clock
> > +      - description: PHY app clock
> > +      - description: PHY stb clock
> > +      - description: PHY lpm clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: phy
> > +      - const: app
> > +      - const: stb
> > +      - const: lpm
> > +
> > +  vbus_det-gpios:
> 
> "vbus_det-gpios" isn't a common property AFAICT, why does it not get a
> vendor prefix when the other gpios property does?
> 

I have seen other binding (such as sunxi phy) uses this property without 
vendor prefix. So I think it is a common property and don't add perfix 
for it. But it is OK for me add the vendor prefix, thanks.

> > +    description: GPIO to the USB OTG VBUS detect pin. This should not be
> > +      defined if vbus_det pin and switch pin are connected, which may
> > +      break the VBUS detection.
> > +    maxItems: 1
> > +
> > +  sophgo,switch-gpios:
> > +    description: GPIO array for the phy to control connected switch. For
> > +      host mode, the driver will set these GPIOs to low one by one. For
> > +      device mode, the driver will set these GPIOs to high in reverse
> > +      order.
> > +    maxItems: 2
> 
> You're still missing the itemised description of what each of the gpios
> here are - how would I know which order to put the GPIOs in?
> 
> Cheers,
> Conor.

In most case, the order depends on hardware design. But following the
guide sophgo provides, it does have an common order. Is it good to add
this description as a reference guide? If so, I will add it.

Regards,
Inochi

> 
> > +
> > +required:
> > +  - compatible
> > +  - "#phy-cells"
> > +  - clocks
> > +  - clock-names
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    phy@48 {
> > +      compatible = "sophgo,cv1800-usb-phy";
> > +      reg = <0x48 0x4>;
> > +      #phy-cells = <0>;
> > +      clocks = <&clk 92>, <&clk 93>,
> > +               <&clk 94>, <&clk 95>;
> > +      clock-names = "phy", "app", "stb", "lpm";
> > +    };
> > +
> > +...
> > --
> > 2.44.0
> > 



