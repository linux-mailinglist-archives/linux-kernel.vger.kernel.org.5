Return-Path: <linux-kernel+bounces-152069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2088AB85A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 03:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E9D4281D8C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 01:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0C92CA9;
	Sat, 20 Apr 2024 01:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="oG4Afvyc"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2096.outbound.protection.outlook.com [40.92.21.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC14A7FE;
	Sat, 20 Apr 2024 01:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713577141; cv=fail; b=j7UnUBEUKnKE8jJjjP/m2LuDBEtPPOIwhwsRMBJPTwgKbsKbH/TjpiwRQ1v6Pd5JmF6mLLrf0vy2cCD7+aZVvBLlOU408G8z60qnDbVBXslCZ6bG/FITHepoqMwrITx2qri+AjeoAyWp6i/2Tj0TFyHkpbMpLLebsJMvlG5iWr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713577141; c=relaxed/simple;
	bh=ECiuDu57dqxlX6u/aPhRfZRC0TUVSQS27bVFn5qTySw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kkGMSU8Xn04/aMJT4lj9pdl0qyUNKtLsMF8COIPhYp+ctgAs3SjJXstj6cp2j3uqZXQfcMEyjx8JMVgL+1wFOqJa0s4P/9g3gssSMA+/sioN53C2DW63knii9ckjNMZY7F0nC99ba5IWM8BdcqKBJiVkrmUgHVLaWYjN7YoRWIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=oG4Afvyc; arc=fail smtp.client-ip=40.92.21.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTKyjddHJE6ZEaaVmXflGt2e2zG2bypWkW15U0wI7NVeub5dglY0Lc62J1qJxSUlxuiKOAiARpW7u6xgPdUE8USM9DyNP+6enLrlz23hg6CEbelDBg51IuEdZRAtQxhsc+3FU6DoNqwgRNyVmSHezapLe8rjZtqMZ3hhvwj5d4TsmtWK0WzjqfAfUuQpOFoi3jkqOL2YTJ7uU7rItckab3RMyGN9zVlHzUfqDiGJBNToAJH4qx8xT2Us15gMYEnIDrP84uShQVeRJfoKgbXJRwrA99eaneiYym415bfEaMM402qMIyrcFr3m/Y8v1v9TJMDEFSNPnVswUW4Aq8/5UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TH+jFVGndLy/jj69574EEEQJ6N9YRwpX5qxdWBZNBw=;
 b=K4Qzlr/rEfb2oG1yxC4XzYzOSEKKRN077CJTzQOUIZXTpqbNMEQUx8US+ot0wfigxYDV+4GzdFvvkZRxmHVdFbAM8vg+t+60gHxiChgHWkm4jfSr28+HMMzdeezMb9Sek2tcjvxA9vM+Y8vrd77O+RVBISYf2YrlQPzbZZXCh6xRtLauXIqbLtPBiqsWNtKXH/Ul72GoiAYruKAsQRKDrSnr16jvanOG2Vj6fdBCNb/S3zF4yI96W0qYc2WOAa7Al35xGdqHmXZmoAa+6yjgGSCD6Rin4roF37k4iI3ZHJSoAcCJx5B3VuyGCLLfHw1uQM9txn9kAUYoaBYunhKEcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TH+jFVGndLy/jj69574EEEQJ6N9YRwpX5qxdWBZNBw=;
 b=oG4Afvycj+SwE2zXBHtxg8s+VVw4NNvkie6LKJW5QwZfKsGamF0o61cmiPcc7wMo1z4Zp+ehnxFVz6226dXJQad73TLGAgtmTV9DkjyZna53ccA0i3fp22M9NoFJ1Wy15jRYGlTjFt5UemBqXrHwYmR5FGTVA2jYegFBxLwWJSzzYB0inRegUQvAaaQNSB7AvZcrlvU5Q0EeOkkIgVvPMw+6N1R9qvTpuT7xyu+/7OhlYUwo3+4qXhS8/mLeUmg51wFevIzpLeWz/tU33bbOcxwSW0aCMss1WfyvMxyzsDwmng23CqmvyIU9wpGFcEcdv07JqkeVVCphbiE6RyUukQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DM4PR20MB4967.namprd20.prod.outlook.com (2603:10b6:8:bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Sat, 20 Apr
 2024 01:38:56 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7472.042; Sat, 20 Apr 2024
 01:38:56 +0000
Date: Sat, 20 Apr 2024 09:39:18 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Conor Dooley <conor@kernel.org>, Inochi Amaoto <inochiama@outlook.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>, 
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: Add Sophgo CV1800 USB phy
Message-ID:
 <IA1PR20MB49536E7548B65B41F4F33FDEBB0C2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953780F4617823F7173B6D6BB042@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953040232A4D41E41F2D2A9BB042@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240419-harmful-neutron-d0db367cf659@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419-harmful-neutron-d0db367cf659@spud>
X-TMN: [uTSaPKTSfG/0Cc2+lBHz5bIut5ro49F3tCNfP602gXc=]
X-ClientProxiedBy: PS2PR03CA0001.apcprd03.prod.outlook.com
 (2603:1096:300:5b::13) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <dohjhps2gk7vmdhjxlalpxnkxyvr6ho2ykfdlgwmhktd2a7tmk@upkvvdiy2zgu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DM4PR20MB4967:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f12efef-5274-480d-0114-08dc60daa465
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A5ssivpbUONLCnpnGrdOzdYsKxuEIZ6DaR1iXPTYSpwDWbObzGBc0SvnBu3iTXyFIyMKfU4LvnzN0lVYcBmj1pgZaulgJRXsjIaCv8W2IkGUjBvLVVdoT7rY0J7SLxECYXqBGC1JgFjc9tq/QgN2FEag1hZgn9keovihUvLdKPYZ+0MyS8P4/gkQbkp5+JF9WVCqVOXGi2Vbpyb5vA8V8jaJnPt+SCx6nkaaEz5JnETCx/IpuIn69gm/X5EUTSAeVz8T9BMySrWYNTYCLAn2aLHFPY8MiLNVD6odCTwYOloOCmnMIvt0zOI/sF3UU6PSj6ICEEdYIRvhLJZd/Fa7hEQwI7MMjyclTJHgbFBOoqKWWZr5ZogJncU+QuFUI3cL2eEWmhBZqBrAeg0OtLOXeVpux+7HZ9TFqPfPaS1JaQnVsdx43E4HLXonIe/X90OLoZkU3faptjVMJraxamFYbOD7SmSWxqEjpnLtqiUAemed99ZhSLBQiG22nMnGA1TJlF+Kscy5HLBNw8fz99BdXFJk7Qj0ZEIbolATiRpHdZbUihdX5Si6BH6OuTx+n3SB3JJVAf2bi5HKcMyfd+1nMalePGgmGcQ0/byZGHXAxJFGpm4NFqhU8tBz4pjif6fisb9XyuGhGwADCjDm3qWVtIVDFZ2n+31OuSMVi6/yol6HwpWQUaE5zt/E6x6rnmusr27YOJ6kgkT2EcHpMLX+3Q==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m+gB/jjgxOV60I+UQhWA7JorxWNDaat6h57XAYozAvFnnix/dpjsjgN32ZlV?=
 =?us-ascii?Q?RTrGbV7lBACb/x5v6Jq38Nd6dRL//RUvXbIZLaCq3C1NHQW9xdOj23JVG7Lj?=
 =?us-ascii?Q?/LNt3qiHZO3RHMRgNC4djyZ/j5Vx/VsR+1wilc0ZCB1Qs7LT+JgbCNmhkjNp?=
 =?us-ascii?Q?JIf5MXnwy3iyQG55s2A8U3IFFICRYlic4ZGG26JZsTLz4VcObjvfPknpuY2J?=
 =?us-ascii?Q?+2z46JDx8oAGIeW7cDtLA08jFTC/U6NydHoWCefiL7katLC3Op+Gx17HiQj0?=
 =?us-ascii?Q?iIhJkuOrVZlAdYc2cH/mK+V9Vbt250gjp65i94nWW8H1KPuBBL3f3bXYyw9k?=
 =?us-ascii?Q?/vlB63h6W92JG1Hjl0gQ7o9uA+SvPquHmG49VzxR/5/s+yj48CRx8vj47rqV?=
 =?us-ascii?Q?v1EADXAj8RChn0X6k3z9NGfWnU///YYbYBDVz4/cD1DGcz/lvFiJmbqFx9lX?=
 =?us-ascii?Q?EyINizsj80/xFFqbjJa2BbGd1psIxhurSnoofwBzLn35EKm9frdmc6r9OWTn?=
 =?us-ascii?Q?wXS9h+qdYYqd39/GIjNDc1pgEG6rMB+eOvrM21CZSWQmjcHYGmn1t6uZqrAr?=
 =?us-ascii?Q?459M1QV69DzpTPurx/yxGC8djqzADnTz6C8phvRsW7RKvB6AbMm4NS+EcRRx?=
 =?us-ascii?Q?wpvwtoV8bmoBI0ilroET9HCBwdlgkxGJAlF21aUHtYiPsAQL+msKp4JlHHe3?=
 =?us-ascii?Q?tkETcdh7EP/8D6h8faK6o4PNWExcR+0xiTDkfN26oUbKadSLIdUv7c5wiIUP?=
 =?us-ascii?Q?w6QKh8rdUJ2z3p5eAcPaoP5aXB77XZQbC9DZn4TyeHguTS+wn2h4jX/XYchZ?=
 =?us-ascii?Q?6nGoC4uqPlMmt+LHqb6GqpXh7C0qcMXXXr+yBnozs1+p1waiCrVYLXbS/8fk?=
 =?us-ascii?Q?P9veiItUtMcZaYNPETM92aa0MJnztETkacEHJd/ADPqjSruiv9GYC8Xu/u6h?=
 =?us-ascii?Q?SQtxjm7EfZR8e5awDr1EaQUN+l5h+CnPt4YrRb8NPKIve06ASKLc/xkwqYxy?=
 =?us-ascii?Q?WMYpZA29oEEVCfUXe7cK1aIvFLr3BGdxJsUkOwa0pjldZtod0T+cKgJdPK38?=
 =?us-ascii?Q?XRamy4muuqlgcYHS0P4z/lZot6dsR/agBi5pv0ia6AKfoI//0My/Ol8h25Ha?=
 =?us-ascii?Q?4Zyre/6DGwWpenM8XIZ6yb0+oU01dBLOmm5PBIeUUbOmdYNIg2PBrz4jCiUC?=
 =?us-ascii?Q?MiVKdw5V7TblpjlezUyabEPkuareGssV37qiLn4YBhgmI2RQUSnCmCR7IM91?=
 =?us-ascii?Q?HYb0JYm7yjsXNgph2sEJ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f12efef-5274-480d-0114-08dc60daa465
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2024 01:38:56.0428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR20MB4967

On Fri, Apr 19, 2024 at 03:26:53PM GMT, Conor Dooley wrote:
> On Fri, Apr 12, 2024 at 03:22:24PM +0800, Inochi Amaoto wrote:
> > The USB phy of Sophgo CV18XX series SoC needs to sense a pin called
> > "VBUS_DET" to get the right operation mode. If this pin is not
> > connected, it only supports setting the mode manually.
> > 
> > Add USB phy bindings for Sophgo CV18XX/SG200X series SoC.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > ---
> >  .../bindings/phy/sophgo,cv1800-usb-phy.yaml   | 90 +++++++++++++++++++
> >  1 file changed, 90 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml b/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml
> > new file mode 100644
> > index 000000000000..cb394ac5d8c4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml
> > @@ -0,0 +1,90 @@
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
> > +  dr_mode:
> > +    description: PHY device mode when initing.
> 
> "initing" isn't a word, "initialising" is the correct word. Or
> "initializing" if you speak American. But if it is just the value during
> initialisation, why do we need to know - we can just overwrite it in
> software, right?
> 
> Are you sure that this is limited to initialisation? I would have
> thought that it describes the configuration that the board is in, and is
> a fixed property of the system?
> 
> > +    enum: [host, peripheral, otg]
> 
> Rob, I know this is a phy rather than a controller, so referencing
> usb-drd.yaml doesn't really make sense, but there are several PHYs using
> dr_mode so it feels like there should be something to reference here
> rather than defining the property anew.
> 

Yes, you are right. Using dr_mode in initialisation is not necessary.
We can just let it go and using the default mode. In fact, for most
boards with this SoC, host mode is just enough. And it is just easy 
to overwrite the mode value in the driver if we want another mode. 
For the OTG, it can just check the `vbus_det-gpios`. I will remove 
this property, thanks.

> > +
> > +  vbus_det-gpios:
> > +    description: GPIO to the USB OTG VBUS detect pin. This should not be
> > +      defined if vbus_det gpio and switch gpio are connected.
> 
> I don't understand the second sentence here.
> 
> > +    maxItems: 1
> > +
> > +  sophgo,switch-gpios:
> > +    description: GPIO for the phy to control connected switch.
> > +    maxItems: 2
> 
> You've got two items here, they should be described. /But/ the property
> above says "switch gpio", which is singular. Which is it?
> 

`switch-gpios` is gpios to controll USB switch connected to the
phy. Sophgo recommends that phy use a switch to separate device
port and host port if it supports both. I know this is weird,
but many board follows this design, such as Huashan PI and 
Milkv Duo S. As for item number, it is just an array of gpios
to process one by one, I mark it as two just because Milkv 
Duo S use two gpios to controll the USB switch.

For vbus_det gpio description, There is because the design of 
Milk-v Duo S, which connect the switch gpio and VBUS detect 
gpio. In this case the OTG function is broken and we can just 
change the mode by toggling switch gpios. So I suggest not 
defining this property.

> Cheers,
> Conor.
> 
> > +
> > +required:
> > +  - compatible
> > +  - "#phy-cells"
> > +  - clocks
> > +  - clock-names
> > +  - dr_mode
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        dr_mode:
> > +          const: otg
> > +    then:
> > +      required:
> > +        - vbus_det-gpios
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
> > +      dr_mode = "host";
> > +    };
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    phy@54 {
> > +      compatible = "sophgo,cv1800-usb-phy";
> > +      reg = <0x54 0x4>;
> > +      #phy-cells = <0>;
> > +      clocks = <&clk 92>, <&clk 93>,
> > +               <&clk 94>, <&clk 95>;
> > +      clock-names = "phy", "app", "stb", "lpm";
> > +      dr_mode = "otg";
> > +      vbus_det-gpios = <&portb 6 GPIO_ACTIVE_HIGH>;
> > +    };
> > --
> > 2.44.0
> > 



