Return-Path: <linux-kernel+bounces-96650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8182875F80
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED6B2828BF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713F652F6C;
	Fri,  8 Mar 2024 08:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cDmCN3Oa"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2073.outbound.protection.outlook.com [40.107.15.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158935103F;
	Fri,  8 Mar 2024 08:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709886612; cv=fail; b=GD7D9FBH+6AQYBj3h/pW47n3vFTjBT751NnU6vRkU5HpqrloF9NbpYEmEAeq3amNW3puR7l5WNQljl0/24XzyDHD9rfNIqLqj5csZ6a63TJecPYgGPRB91PoZVSNxOj03BSnzvaKWcJia0cb/324WCGP8++DIf897Gni63+1EJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709886612; c=relaxed/simple;
	bh=dnZGj+XOuDp+4xxVtFRbEIS3ecnZUu5ra9lnQRhlJeE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iBB+CXjEMpg008s/mU17qjABVkTupH0LFS6j2zn/btuXfZYd7WzNgUzOG3zB3a7gQm5NUqq336l+M/OWtmwFlSBA/GM7n5q1csXxcHc6+wJ3qofbkHrR608DTkD1x934BiDWcijrRIRn0bCDTb1wLoeFWCnep7Lud9gDq8JQf80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cDmCN3Oa; arc=fail smtp.client-ip=40.107.15.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UALLGM+gjggO/MaPsjdVL2qicOeSTlk3ZWX3gl2mwSIDHtWmw0etj0EmMjJnOQtFPD9SJBWlOJA2MvbpR3F4Qw4WIdns25eqQqQ4HMBrAe4pDYrGHi+JfjchLb7yufy5SU2NcoG1TgyDehGn+clOZEQJQBWwkeX12FmxuGg2UPGdtYj+oX7NCdPmsy1Byek7/jBtscEBFTd7XDB99D59/C26xydHnEEcYXDjQA6YZ/spMq1ZVAiYgmAr8XqMGOwxYa1gWmSVtb4L02KjaZFUPc7GVmLEkJBHixUFMvhek9MOVRcCcIU7zpjt9Cma6+81TU+euccW9JQktp/8cbfJFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLoWB4fBzfzTgYE1tFzLTTkQIIIeSu6Z5oLtsCMBQ2k=;
 b=F3kr8LjcKYh0KiL/rhvwOx0Xd6VrBlkL7uSogpAvYDimaPICIK3ok7PQa21mjEKjFlsoB8+xBy3KrpB5DqE63Nut+sbVkhy6H8LgCFXLh/bcylOE4dveqIS4Eqzl8YV7yXHW/Q6PhL9zJ97VyARi+AtbHDpSmk69MXygTit/xQKpaavz0aKcESk9mdluv+yB0DfWkR5d8oWJ3e5jHGSUF3gbCH9ajQawztDmtDvNgjVCctyudRMlX5TpWdIcmRXZQtFF+JNC4hQf5BLcbnQtOPaFAW+ZOE0fRpiYcwgI0e/qxKubruknygxxqqe6hx81QkaovrlD+/TZgYTxNhhL6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLoWB4fBzfzTgYE1tFzLTTkQIIIeSu6Z5oLtsCMBQ2k=;
 b=cDmCN3OaFJN2DRXWzfLg7GW1Uq6LbUmxlBPZb6jgCsSImcZOsd2Rz566g360VuMVV+KzgMMGHmh+UuxpS3syVsomZzvMUveJHw8ezUhxemOIPC5DXqnb1A6ZeWCe+dW5TdRer+5SnTGyPZPNYRfuojcGBXSjDUh2RjTTUYtP6XE=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AM8PR04MB7890.eurprd04.prod.outlook.com (2603:10a6:20b:24e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 08:30:06 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7339.035; Fri, 8 Mar 2024
 08:30:06 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	dl-linux-imx <linux-imx@nxp.com>, "peter.chen@kernel.org"
	<peter.chen@kernel.org>, Jun Li <jun.li@nxp.com>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v7 04/11] dt-bindings: usb: ci-hdrc-usb2-imx:
 move imx parts to dedicated schema
Thread-Topic: [EXT] Re: [PATCH v7 04/11] dt-bindings: usb: ci-hdrc-usb2-imx:
 move imx parts to dedicated schema
Thread-Index: AQHaajmC1tiTIxIjZU6CUY8uClumDLEhbrQAgAwfIPA=
Date: Fri, 8 Mar 2024 08:30:06 +0000
Message-ID:
 <DU2PR04MB88227686B367CAA509EB8D7D8C272@DU2PR04MB8822.eurprd04.prod.outlook.com>
References: <20240228113004.918205-1-xu.yang_2@nxp.com>
 <20240228113004.918205-4-xu.yang_2@nxp.com>
 <1a626f74-4559-4403-9d88-6a9a462b54c1@linaro.org>
In-Reply-To: <1a626f74-4559-4403-9d88-6a9a462b54c1@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8822:EE_|AM8PR04MB7890:EE_
x-ms-office365-filtering-correlation-id: c39e1477-7c88-4c56-bacf-08dc3f49f57a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 4dM81PuQX2KRUrTuWKVDRg9PsEiIF8XBzaTaeyFJ1PpYlucpFWrFY/X9YYlsFO2rWGGb6Ii/xw9eux6FHKtJ9tZlbS6tmtIjfrWEW+Eprus4iENFH79TZ0WOoeyb6ruHIWOTT+hhNLEjGlgXUzNHS9V4wub3iGef1a2k6ybd2NtrEt1BIL/5uLqgHhGO83tWt3iZgora0uFXVhupJG/IKGHIoXGoyPWkXgjx+cVM3BhmNfHLJsLDbDitbZHrNUKS+BnO0elUD+ynpEEKM0+Y61Lzefaw/K5MrRjgkVxp5lUqmGwqCtK+1scUqBiLcl3TwDmAxvgqwCekVyqjNcvvNS7rrNwOPBUQTZpevsmtH+5NZ+G5D8tuiXjJkLSRQNcT8CdtqWFSXkszjAduc1TuigEPGbh/r8Rnd16Sw5MpmTK46LbSq2YBkkJw2G4xkPUmdFMv3YWB+Mvo6WelQ4/+eV/Ed/CG8GZvWZFUHEOUr8C47PHBf1GYILziErSZvlmp79I3S+PKN/YbbqJ81fBBs/eHZPnWw3tmK0conDUwYGSkPwzoBLBXUIAY/4T+PU58/E4ZkBdCbL5P3RCSHCCb02dP0H3FNpcebFQfNJ98zVHJrVe7GiXDiIn0rUQOpUu+RlZuXK0ZkN6jDdglyPomrBWHswcPPxwfVJ93I/ri7pI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Q6Ai9dKlezR9WVdSh1xLs9TTX6Z6vOZDLfrhjz2a/fbvKP08lfaBJpbajrxr?=
 =?us-ascii?Q?D3DdjuspzR0NopWPGDYpKFqWvxsV1j6cGFx7SoCpnKzrAPa/umbE9C8Cz4af?=
 =?us-ascii?Q?cNsG4TRTzOWjvf9fl+fHcGn9NJRdeKTBCYr58gx14JX/NhWuXCldpkG+gmlF?=
 =?us-ascii?Q?u9nOmpxtpCc9ut3NjaEHQKOobRfRgLU4L/mmBnKC7IzdVOLdVtmNnyldShMm?=
 =?us-ascii?Q?Hg2dh0tgkqPLkhF0W04PHN0drwcUJhPMunpeqEs5QxKbe/k89ieicDzgf2YD?=
 =?us-ascii?Q?jcjR4dHLtWcEpO85gYWGiYREmMPcJqgmBveWok0mXENasvyXduOplH6wfpXQ?=
 =?us-ascii?Q?z4Ne2gcL7BwsYrXBHlChWBhOyV46m9UilF5dZDggxOa72+qlcswfTDhc5oz3?=
 =?us-ascii?Q?2YEQcnqA/KovPD4XYwgtdN4t06wxzOAKwYjCFDZWLHOlDFogENQRDC/GijK8?=
 =?us-ascii?Q?aqb7jgvOGtqG6/b0HjKpYzq3WCY3yE/jkCX59yUICYVS90ucPYlbBeosZytn?=
 =?us-ascii?Q?cj5ljVlnnJIwvGHbFYsSAux0gy4udClz5D8rLTKODgEyUvOHy+AhYGfv1WfR?=
 =?us-ascii?Q?ItTsazIJ7vL091EGvTHsxRiCG4PSTl6SagkqOXU/9sFXPGrm/CAHFaAcsSBi?=
 =?us-ascii?Q?dPmahQRU2HKGnI5saPLVHkfwS2R4/CSXS+uNIuj2gESIyZPj7G/BJcYwHeDw?=
 =?us-ascii?Q?uoSpYM9H+u2MTHnxUL5w0K+MwyPadT2KY+C7OLBr1zsmhxRUYi5BiEOf2NcR?=
 =?us-ascii?Q?CN6uQscyK+SNOu3v6S/ovnPOqTZtnVEZtgNEav3fAIpC4Af+Ci0DQLJtqgc1?=
 =?us-ascii?Q?yj/R/IWR7AD0x1w4Ll56RrdVSuQu5k07Thw+aBUbD+sSVW5Ral6aujllSyed?=
 =?us-ascii?Q?9ypXi4nECiCf6EMNLdMv0JwgfWDEc9vvIrrtURSrur9Ggs3TYnC+lICm3S1D?=
 =?us-ascii?Q?9/Kb2Z5J9RNY+ATeegmkKCKa9L4KGfgHLMWT53KjlwR+NIohPEIumuT0Mgch?=
 =?us-ascii?Q?OYuS0GaruEcs7hHqqtxEmmXKd9pg0qDx+rHWXGuun0LlUUOPNMJKzV2tn4X9?=
 =?us-ascii?Q?vDBKtfEUT6rq26YczwydV6G9+iBUNXApiyX+Zzl2TwCbz5/Xpx0IaRMzlZym?=
 =?us-ascii?Q?3LNiSoWQY3SasfS1j/WvhlOFdNTBokuMPAAX7+bPoKRXnvNk2j49vIGOlxfU?=
 =?us-ascii?Q?lAb3mFYraO7qR101VYBBqjODvo45a7VT5Liw4iaVz6G6zGuZan03MCvuaIZz?=
 =?us-ascii?Q?qe+x/yn1cRT+OHt45Zu9jXrPzyUjgNPAxXT8oAmwVqkoooac9cQ6B0Lfv5gk?=
 =?us-ascii?Q?KgOkUCs2/k6O3DgFmOMiMaiRKU8BJU7cQnddJ7G+NNh4b3Rvqt7wNkMkRtH/?=
 =?us-ascii?Q?Kmu8eI/6TwbqrFeTLwrxxL0CzNQPn5CcLucNly5TPWyr9GvHlyuOHz6d/AxF?=
 =?us-ascii?Q?NOpJG25dEduPPESXuli7vssZ1hPNiAIsjX2A/CZJhwexX9cQJwAwE9KVtDVt?=
 =?us-ascii?Q?1LAb0ns0oT51OW2ycEUK6QC4PI0dusqbdLG/USwtfaNl2263V5bXs/mlytsz?=
 =?us-ascii?Q?6Vr4jM6j/sJGUODuV9c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c39e1477-7c88-4c56-bacf-08dc3f49f57a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 08:30:06.3025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tgn5OfsgEauVl2EyqXs3AsOwIqxL9/wPTzYbVpqS5QWYiJrGXZ1APHi8BrXfWwP8OZuHYFukhbM/qx8xKJ9F+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7890


>
> On 28/02/2024 12:29, Xu Yang wrote:
> > As more and more NXP i.MX chips come out, it becomes harder to maintain
> > ci-hdrc-usb2.yaml if more stuffs like property restrictions are added t=
o
> > this file. This will separate i.MX parts out of ci-hdrc-usb2.yaml and a=
dd
> > a new schema for NXP ChipIdea USB2 Controller, also add a common schema=
.
> >
> > 1. Copy common ci-hdrc-usb2.yaml properties to a new shared
> >    ci-hdrc-usb2-common.yaml schema.
> > 2. Move fsl,* compatible devices and imx spefific properties
> >    to dedicated binding file ci-hdrc-usb2-imx.yaml.
> >
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> >
> > ---
> > Changes in v6:
> >  - new patch
> > Changes in v7:
> >  - not remove ci-hdrc-usb2.yaml and move imx parts to ci-hdrc-usb2-imx.=
yaml
> > ---
> >  .../bindings/usb/ci-hdrc-usb2-common.yaml     | 197 ++++++++++++++++++
> >  .../bindings/usb/ci-hdrc-usb2-imx.yaml        | 197 ++++++++++++++++++
> >  .../devicetree/bindings/usb/ci-hdrc-usb2.yaml | 186 -----------------
> >  3 files changed, 394 insertions(+), 186 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2-=
common.yaml
> >  create mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2-=
imx.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-common.=
yaml
> b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-common.yaml
> > new file mode 100644
> > index 000000000000..9f8f2f343dd3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-common.yaml
>
> Use compatible style for filenames. chipidea,hdrc-usb2-common.yaml
> (assuming that "ci" was a shortcut of chipidea)

Okay.

>
>
> > @@ -0,0 +1,197 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/usb/ci-
> hdrc-usb2-
> common.yaml%23&data=3D05%7C02%7Cxu.yang_2%40nxp.com%7C2c370c9411664be2924=
608dc3938b8ac%7C686ea1d3bc2b4
> c6fa92cd99c5c301635%7C0%7C0%7C638448162982019025%7CUnknown%7CTWFpbGZsb3d8=
eyJWIjoiMC4wLjAwMDAiLCJQIj
> oiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DAez1Kqo7NsY=
agBsrTfjys51HUQit0wbHjYg5WigzfzI
> %3D&reserved=3D0
> > +$schema: http://devicetree.org/meta-
> schemas%2Fcore.yaml%23&data=3D05%7C02%7Cxu.yang_2%40nxp.com%7C2c370c94116=
64be2924608dc3938b8ac%7C686ea1
> d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638448162982031177%7CUnknown%7CTWFpb=
GZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DoXR=
XyhK7NTRb79hXry9qRP14plBJfdApUh
> Z8OHdLB%2FI%3D&reserved=3D0
> > +
> > +title: USB2 ChipIdea USB controller Common Properties
> > +
> > +maintainers:
> > +  - Xu Yang <xu.yang_2@nxp.com>
> > +
> > +properties:
> > +  reg:
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  interrupts:
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  clocks:
> > +    minItems: 1
> > +    maxItems: 3
> > +
> > +  clock-names:
> > +    minItems: 1
> > +    maxItems: 3
> > +
> > +  dr_mode: true
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +  reset-names:
> > +    maxItems: 1
> > +
> > +  "#reset-cells":
> > +    const: 1
> > +
> > +  phy_type: true
> > +
> > +  itc-setting:
> > +    description:
> > +      interrupt threshold control register control, the setting should=
 be
> > +      aligned with ITC bits at register USBCMD.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  ahb-burst-config:
> > +    description:
> > +      it is vendor dependent, the required value should be aligned wit=
h
> > +      AHBBRST at SBUSCFG, the range is from 0x0 to 0x7. This property =
is
> > +      used to change AHB burst configuration, check the chipidea spec =
for
> > +      meaning of each value. If this property is not existed, it will =
use
> > +      the reset value.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0x0
> > +    maximum: 0x7
> > +
> > +  tx-burst-size-dword:
> > +    description:
> > +      it is vendor dependent, the tx burst size in dword (4 bytes), Th=
is
> > +      register represents the maximum length of a the burst in 32-bit
> > +      words while moving data from system memory to the USB bus, the v=
alue
> > +      of this property will only take effect if property "ahb-burst-co=
nfig"
> > +      is set to 0, if this property is missing the reset default of th=
e
> > +      hardware implementation will be used.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0x0
> > +    maximum: 0x20
> > +
> > +  rx-burst-size-dword:
> > +    description:
> > +      it is vendor dependent, the rx burst size in dword (4 bytes), Th=
is
> > +      register represents the maximum length of a the burst in 32-bit =
words
> > +      while moving data from the USB bus to system memory, the value o=
f
> > +      this property will only take effect if property "ahb-burst-confi=
g"
> > +      is set to 0, if this property is missing the reset default of th=
e
> > +      hardware implementation will be used.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0x0
> > +    maximum: 0x20
> > +
> > +  extcon:
> > +    description:
> > +      Phandles to external connector devices. First phandle should poi=
nt
> > +      to external connector, which provide "USB" cable events, the sec=
ond
> > +      should point to external connector device, which provide "USB-HO=
ST"
> > +      cable events. If one of the external connector devices is not
> > +      required, empty <0> phandle should be specified.
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    minItems: 1
> > +    items:
> > +      - description: vbus extcon
> > +      - description: id extcon
> > +
> > +  phy-clkgate-delay-us:
> > +    description:
> > +      The delay time (us) between putting the PHY into low power mode =
and
> > +      gating the PHY clock.
> > +
> > +  non-zero-ttctrl-ttha:
> > +    description:
> > +      After setting this property, the value of register ttctrl.ttha
> > +      will be 0x7f; if not, the value will be 0x0, this is the default
> > +      value. It needs to be very carefully for setting this property, =
it
> > +      is recommended that consult with your IC engineer before setting
> > +      this value.  On the most of chipidea platforms, the "usage_tt" f=
lag
> > +      at RTL is 0, so this property only affects siTD.
> > +
> > +      If this property is not set, the max packet size is 1023 bytes, =
and
> > +      if the total of packet size for previous transactions are more t=
han
> > +      256 bytes, it can't accept any transactions within this frame. T=
he
> > +      use case is single transaction, but higher frame rate.
> > +
> > +      If this property is set, the max packet size is 188 bytes, it ca=
n
> > +      handle more transactions than above case, it can accept transact=
ions
> > +      until it considers the left room size within frame is less than =
188
> > +      bytes, software needs to make sure it does not send more than 90=
%
> > +      maximum_periodic_data_per_frame. The use case is multiple
> > +      transactions, but less frame rate.
> > +    type: boolean
> > +
> > +  mux-controls:
> > +    description:
> > +      The mux control for toggling host/device output of this controll=
er.
> > +      It's expected that a mux state of 0 indicates device mode and a =
mux
> > +      state of 1 indicates host mode.
> > +    maxItems: 1
> > +
> > +  mux-control-names:
> > +    const: usb_switch
> > +
> > +  pinctrl-names:
> > +    description:
> > +      Names for optional pin modes in "default", "host", "device".
> > +      In case of HSIC-mode, "idle" and "active" pin modes are mandator=
y.
> > +      In this case, the "idle" state needs to pull down the data and
> > +      strobe pin and the "active" state needs to pull up the strobe pi=
n.
> > +    oneOf:
> > +      - items:
> > +          - const: idle
> > +          - const: active
> > +      - items:
> > +          - const: default
> > +          - enum:
> > +              - host
> > +              - device
> > +      - items:
> > +          - const: default
> > +
> > +  pinctrl-0:
> > +    maxItems: 1
> > +
> > +  pinctrl-1:
> > +    maxItems: 1
> > +
> > +  phys:
> > +    maxItems: 1
> > +
> > +  phy-names:
> > +    const: usb-phy
> > +
> > +  vbus-supply:
> > +    description: reference to the VBUS regulator.
> > +
> > +  usb-phy:
> > +    description: phandle for the PHY device. Use "phys" instead.
> > +    maxItems: 1
> > +    deprecated: true
> > +
> > +  port:
> > +    description:
> > +      Any connector to the data bus of this controller should be model=
led
> > +      using the OF graph bindings specified, if the "usb-role-switch"
> > +      property is used.
> > +    $ref: /schemas/graph.yaml#/properties/port
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +
> > +dependencies:
> > +  port: [ usb-role-switch ]
> > +  mux-controls: [ mux-control-names ]
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
>
> I don't see where you remove the properties from the existing schema, so
> you now just duplicated a lot.
>
> So again let me describe the task:
> 1. Create common schema by MOVING the common pieces from the existing
> schema. The common schema MUST be referenced by other existing schemas.

I will remove common parts from old ci-hdrc-usb2.yaml and let ci-hdrc-usb2.=
yaml
refer to the common yaml too.

>
> 2. Create IMX specific schema by moving IMX specific bits. New schema
> references common schema.
>
> 3. The remaining old ci-hdrc-usb2.yaml does not have as a result common
> properties and IMX bits.

Okay.

>
>
> > +
> > +allOf:
> > +  - $ref: usb-hcd.yaml#
> > +  - $ref: usb-drd.yaml#
> > +
> > +additionalProperties: true
> > \ No newline at end of file
>
> You have patch errors, fix them.

Okay.

>
> > diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yam=
l
> b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
> > new file mode 100644
> > index 000000000000..50494ce06d07
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
> > @@ -0,0 +1,197 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/usb/ci-
> hdrc-usb2-
> imx.yaml%23&data=3D05%7C02%7Cxu.yang_2%40nxp.com%7C2c370c9411664be2924608=
dc3938b8ac%7C686ea1d3bc2b4c6fa9
> 2cd99c5c301635%7C0%7C0%7C638448162982040409%7CUnknown%7CTWFpbGZsb3d8eyJWI=
joiMC4wLjAwMDAiLCJQIjoiV2l
> uMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3D1MesqU7ed0dAXtua=
r%2BNIyV9tOQFahTaDNLxvhgL02
> bw%3D&reserved=3D0
>
> Filename like compatible.

Okay.

>
> > +$schema: http://devicetree.org/meta-
> schemas%2Fcore.yaml%23&data=3D05%7C02%7Cxu.yang_2%40nxp.com%7C2c370c94116=
64be2924608dc3938b8ac%7C686ea1
> d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638448162982048575%7CUnknown%7CTWFpb=
GZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3D4YG=
0rLj%2B%2FwsNf7koSMOeiy23Bz7Z7S
> f7B9Z3KcNVvUc%3D&reserved=3D0
> > +
> > +title: NXP USB2 ChipIdea USB controller
> > +
> > +maintainers:
> > +  - Xu Yang <xu.yang_2@nxp.com>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - enum:
> > +          - fsl,imx27-usb
> > +      - items:
> > +          - enum:
> > +              - fsl,imx23-usb
> > +              - fsl,imx25-usb
> > +              - fsl,imx28-usb
> > +              - fsl,imx35-usb
> > +              - fsl,imx50-usb
> > +              - fsl,imx51-usb
> > +              - fsl,imx53-usb
> > +              - fsl,imx6q-usb
> > +              - fsl,imx6sl-usb
> > +              - fsl,imx6sx-usb
> > +              - fsl,imx6ul-usb
> > +              - fsl,imx7d-usb
> > +              - fsl,vf610-usb
> > +          - const: fsl,imx27-usb
> > +      - items:
> > +          - enum:
> > +              - fsl,imx8dxl-usb
> > +              - fsl,imx8ulp-usb
> > +          - const: fsl,imx7ulp-usb
> > +          - const: fsl,imx6ul-usb
> > +      - items:
> > +          - enum:
> > +              - fsl,imx8mm-usb
> > +              - fsl,imx8mn-usb
> > +          - const: fsl,imx7d-usb
> > +          - const: fsl,imx27-usb
> > +      - items:
> > +          - enum:
> > +              - fsl,imx6sll-usb
> > +              - fsl,imx7ulp-usb
> > +          - const: fsl,imx6ul-usb
> > +          - const: fsl,imx27-usb
> > +
> > +  clocks:
> > +    minItems: 1
> > +    maxItems: 3
>
>
> No need to, it's already in common. Drop clocks.

No. I cannot remove clocks property in this yaml since the usb node may use=
 assigned-clocks
and assigned-clock-parents. Then dtschema will have warning like below patc=
h:
https://lore.kernel.org/all/20230508071837.68552-1-krzysztof.kozlowski@lina=
ro.org/

Thanks,
Xu Yang

>
> > +
> > +  clock-names:
> > +    minItems: 1
> > +    maxItems: 3
>
> Drop property.
>
> > +
> > +  fsl,usbmisc:
> > +    description:
> > +      Phandler of non-core register device, with one argument that
> > +      indicate usb controller index
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    items:
> > +      - items:
> > +          - description: phandle to usbmisc node
> > +          - description: index of usb controller
> > +
> > +  fsl,anatop:
> > +    description: phandle for the anatop node.
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +
> > +  disable-over-current:
> > +    type: boolean
> > +    description: disable over current detect
> > +
> > +  over-current-active-low:
> > +    type: boolean
> > +    description: over current signal polarity is active low
> > +
> > +  over-current-active-high:
> > +    type: boolean
> > +    description:
> > +      Over current signal polarity is active high. It's recommended to
> > +      specify the over current polarity.
> > +
> > +  power-active-high:
> > +    type: boolean
> > +    description: power signal polarity is active high
> > +
> > +  external-vbus-divider:
> > +    type: boolean
> > +    description: enables off-chip resistor divider for Vbus
> > +
> > +  samsung,picophy-pre-emp-curr-control:
> > +    description:
> > +      HS Transmitter Pre-Emphasis Current Control. This signal control=
s
> > +      the amount of current sourced to the USB_OTG*_DP and USB_OTG*_DN
> > +      pins after a J-to-K or K-to-J transition. The range is from 0x0 =
to
> > +      0x3, the default value is 0x1. Details can refer to TXPREEMPAMPT=
UNE0
> > +      bits of USBNC_n_PHY_CFG1.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0x0
> > +    maximum: 0x3
> > +
> > +  samsung,picophy-dc-vol-level-adjust:
> > +    description:
> > +      HS DC Voltage Level Adjustment. Adjust the high-speed transmitte=
r DC
> > +      level voltage. The range is from 0x0 to 0xf, the default value i=
s
> > +      0x3. Details can refer to TXVREFTUNE0 bits of USBNC_n_PHY_CFG1.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0x0
> > +    maximum: 0xf
> > +
> > +  fsl,picophy-rise-fall-time-adjust:
> > +    description:
> > +      HS Transmitter Rise/Fall Time Adjustment. Adjust the rise/fall t=
imes
> > +      of the high-speed transmitter waveform. It has no unit. The rise=
/fall
> > +      time will be increased or decreased by a certain percentage rela=
tive
> > +      to design default time. (0:-10%; 1:design default; 2:+15%; 3:+20=
%)
> > +      Details can refer to TXRISETUNE0 bit of USBNC_n_PHY_CFG1.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0
> > +    maximum: 3
> > +    default: 1
> > +
> > +  fsl,usbphy:
> > +    description: phandle of usb phy that connects to the port. Use "ph=
ys" instead.
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    deprecated: true
>
> Missing required: block here.
>
> > +
> > +allOf:
> > +  - $ref: ci-hdrc-usb2-common.yaml#
> > +  - if:
> > +      properties:
> > +        phy_type:
> > +          const: hsic
> > +      required:
> > +        - phy_type
> > +    then:
> > +      properties:
> > +        pinctrl-names:
> > +          items:
> > +            - const: idle
> > +            - const: active
> > +
> > +required:
> > +  - compatible
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/clock/imx7d-clock.h>
> > +
> > +    usb@30b10000 {
> > +        compatible =3D "fsl,imx7d-usb", "fsl,imx27-usb";
> > +        reg =3D <0x30b10000 0x200>;
> > +        interrupts =3D <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
> > +        clocks =3D <&clks IMX7D_USB_CTRL_CLK>;
> > +        fsl,usbphy =3D <&usbphynop1>;
> > +        fsl,usbmisc =3D <&usbmisc1 0>;
> > +        phy-clkgate-delay-us =3D <400>;
> > +    };
> > +
> > +  # Example for HSIC:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/clock/imx6qdl-clock.h>
> > +
> > +    usb@2184400 {
> > +        compatible =3D "fsl,imx6q-usb", "fsl,imx27-usb";
> > +        reg =3D <0x02184400 0x200>;
> > +        interrupts =3D <0 41 IRQ_TYPE_LEVEL_HIGH>;
> > +        clocks =3D <&clks IMX6QDL_CLK_USBOH3>;
> > +        fsl,usbphy =3D <&usbphynop1>;
> > +        fsl,usbmisc =3D <&usbmisc 2>;
> > +        phy_type =3D "hsic";
> > +        dr_mode =3D "host";
> > +        ahb-burst-config =3D <0x0>;
> > +        tx-burst-size-dword =3D <0x10>;
> > +        rx-burst-size-dword =3D <0x10>;
> > +        pinctrl-names =3D "idle", "active";
> > +        pinctrl-0 =3D <&pinctrl_usbh2_idle>;
> > +        pinctrl-1 =3D <&pinctrl_usbh2_active>;
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        ethernet@1 {
> > +            compatible =3D "usb424,9730";
> > +            reg =3D <1>;
> > +        };
> > +    };
> > +
> > +...
>
>
> Best regards,
> Krzysztof


