Return-Path: <linux-kernel+bounces-126057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56338893186
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 13:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACEF2281E69
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 11:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A40144317;
	Sun, 31 Mar 2024 11:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="a2T3kd+b"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2103.outbound.protection.outlook.com [40.107.20.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FA32A8DD;
	Sun, 31 Mar 2024 11:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711886325; cv=fail; b=ljgM/6n996apQ63wRvmdIcdIOP2yVY6orXFhPoMb+/hyuRgu90TDegcU3kTmH2abNi6Ddr6QGs7L1M+EDanU8RcjQss976oWUf0OJbJeY0xY0+14sxPMlWMghrwfI2zK2TtHvcQDqrtwrPHvfzfvtcb9r9bylACeIHQzJYHUHgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711886325; c=relaxed/simple;
	bh=2ZvypsfVBHm7yo76L0pmSKZWtfPlkvL8iGbSUMuxZx8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n+UyC8woATOBMaAtf0GNjYHZCJRqM1GvhDgfZH9kjLeJeuX2X8/i5sRB1XT5efmHYH6Bh+NZd8yR74VGFCheKjeER29fSkM/Nfvy+31pv68aOOb7Af0Y6awChfcAHN4g+3X2hqRg28V728ebD7kImpUoC3lLx5SECh5gM9NSD0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=a2T3kd+b; arc=fail smtp.client-ip=40.107.20.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZnTOZpZQ+3OH3cG3/4sgABVy8fVLh5/a4P02WOgUFfAcjWIwUJ8+haK+Zh7EOS/BzB3HuYCV5Xh+EO4WmhqtDYWxQJhzXdD1lvi3aG2nfdt5YKLxpUf7qAtc4XfcwaQu0jI/E8jTdrF8scCp5tabLGcKV0K1c4Mf3zJuazcvTQlKXJbWvBqL5gaR8+u/gnbX7XVJiHRAQdHrXY4DOsgFBxss4IRqAEj2YcVF4cuCqfJmUX7YpPjGAlB8g9P/PXFa0kWc2TFKbQIKpC8qSQ4rGugb7YOu4rOqiM5QYaNCEElQfy95XUmfjflh4plbcnZ2Q9U9uFSHUkkN0UGZsDDxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCqiXIztBfdxf6n/bkTaPQejY9zhN4i5hBhf0lBdifk=;
 b=OBRvGmGRIii4+afyNxGWWuVLuIkQm5hRaQDBfJ+vqCR1eBNF67iE8PQXV3m6wlueBOf4wIZ/r6PzilMM0OZ69AtFtf40WAU8xp8JhEqZr7XbyZ4lA9KXneNdagBYmz7tqGYkKjyWt88Jt9v1N+IUIPhaoALabl6eoGUNTJd3LgPFouSMxbxbS5G4tEIAN8ZFgpemp+hTJg/WeYHcCYmT7OyPjMGQOEN0oi0De5+UUsoRMqP2hfhrWSJw5jLhvaGnMPtGtK4nvH/y8PyK9rQH3kwzbQgrhmHKVbL1Ye2eHJyvLLxW7mxWwySW8KL7+N9+LsSniey+Tuh7lvVtcXFJgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCqiXIztBfdxf6n/bkTaPQejY9zhN4i5hBhf0lBdifk=;
 b=a2T3kd+b5k70zHBswpUyBTi0GRXd1spg8SiTOHglek4NC5HxMFn/TghtJfGb5hW+8k+33OkdyxOWOQyIxPrsMbBTVBS4H55Y/WgF+fYe5ige6UoRpmV3dVKw8Snzffc7D6ey6CDPnXp+Nw6GilQ1O/J3nLW75yTtt7Ssh0Jab68=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8322.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.45; Sun, 31 Mar
 2024 11:58:40 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Sun, 31 Mar 2024
 11:58:40 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, Michael Turquette <mturquette@baylibre.com>, Stephen
 Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 1/4] dt-bindings: clock: support i.MX95 BLK CTL module
Thread-Topic: [PATCH v5 1/4] dt-bindings: clock: support i.MX95 BLK CTL module
Thread-Index: AQHafb8GDxUMWtUgX02pRPYg145HHrFI2KIAgAjw2PA=
Date: Sun, 31 Mar 2024 11:58:40 +0000
Message-ID:
 <DU0PR04MB94171DDC725D52E66DF3A77F88382@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240324-imx95-blk-ctl-v5-0-7a706174078a@nxp.com>
 <20240324-imx95-blk-ctl-v5-1-7a706174078a@nxp.com>
 <1709e7df-268b-4da6-a75d-9d7ce80d9a41@linaro.org>
In-Reply-To: <1709e7df-268b-4da6-a75d-9d7ce80d9a41@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8322:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 cNB8aiQuHaCBKswW4WD9d6XEcvVVEQlMGWO2dysx44yuJ4obZHLTZADEZgqfc3gARIwDc9VFNJY5lJFcqulXrKpGFeq8tr/l/FwJUr4RUxPWSS1TwD2OUimyKHzKRRhFlzr/Uqtz9hs/qiPHjKgvX+uSMerQ8Rzdvzw1H92VfSy5xwYAcnl8cBUUK5hboyNCPYKOpnConFFmoRtlPG7TvK6tAkuJCbFJtC7AQcPdIIy7NrXjQ3cwJaBnhCzjLyIvJ3UvP9WY6tuxAvcEq6tKL7Tqj6qKk3N1JrOEGw4IPnslbP/YNlOFhle38fZkhQxR7sCB7BGK2oSKZKqUEVmh/Ro+qe56FX5xeTZlSNdGT8WOot9cOo3oQGiASu0lctHzUWDrWnGow0XW2dSyWBFNt+LF0V+tQ+YVzE3UNKyN/1fyIyvq0wXPFt1j5fcDsp6MEtmamPiQ1UUzNBfwkkSST31XnKfbhQel0vlOZg+9qH6CuWyrvVcT4stk7dAMxAcH7MQ0cu2GhmSg7pCdps2M66aSZVFrkqhsUW+t04+4n6ZuIRVxM+ZUUJ4hdS5uWcLLJGPoZVqwVLXM0uCsGrfNmW+6B1ws6G+7BpnoswNgR9c1+lj+iakLP6pBYZdm96fFuRTn+D571IWvhwelbfhBwQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AdohgDMEG9f1przP1XfTGRun48QUqEPLI26PTwef4AonZZS1qtQCm00RbilD?=
 =?us-ascii?Q?iLETHnpyvV9L5yCR50b9HlzEeF9maEzDt+degsFltGPTeoBXPSRh5oArJual?=
 =?us-ascii?Q?XrTT5gELnhtFNRX2QSeOTOLSSnGZ6+C69NtrGdu052zams+q3W8bJiigSYmD?=
 =?us-ascii?Q?x/zgZnjhLgLAVszlrvp2aarE7ijKzAiwJjUv1XO1dc7tq7YTE7X2jXss+gcS?=
 =?us-ascii?Q?Vt59szRfAvOgaEYvvwRVhgWF58EXaL3c3MYNUzZFSrMJU7XPOqY1Nl5yPYjj?=
 =?us-ascii?Q?TXrn06NoZnUaGToeqIaNEwiPcxh/VGW9wfbvWloMmAmXM+Q1LDRWdT/shitD?=
 =?us-ascii?Q?WYe6RlAH/da+yO6znUxMXma5Qry/RuGVCw351F8wAQlcn+e5yfZHnUXJLWza?=
 =?us-ascii?Q?jjrb8EcYqYAcVCRqKPo1I4ahrwhCXWwfzU5SUJHAc2rK2V2spIUPb/XwTBjm?=
 =?us-ascii?Q?md3+id7GdijOyCf+S1LZ7O5KiTTNZP+FupfEJUKufOfh0+oTW8QZW3OLUmcW?=
 =?us-ascii?Q?vLQJck9WfqlTs1kCW8DBSOtbwp2+rU9R5xt87cAmCArTQbS14rpeDt6HMyoS?=
 =?us-ascii?Q?erhz9+qXH0XAxI/QV995S9OcwnnAJH3l/Orr11yfw/PwWb7+HM2mdVdbalpC?=
 =?us-ascii?Q?Nv5fUJNtVQ4Onq0WVezkhaKz2dCqiYcuw53gAUnzIknX8UuV7QMBXwiZc4Rg?=
 =?us-ascii?Q?PZqbro2ZKXGgmJq7u/ATcWU/pfoeI6fj7O4yZu5w0YRPCsfvvh0J8DIjDsJn?=
 =?us-ascii?Q?oEUVpnw0+qBYRn7gUHb02WGqljIwM4F870hB2/H61Ypm+9iuvq972o6jp7NF?=
 =?us-ascii?Q?xK4lQbyVtPo/onXtjx9P48p5J4663edJlWWe0b7At2CDKjf2sV2OqtSUum5o?=
 =?us-ascii?Q?fZcEQptppmSplZv8dGgoIhAvJaQqEa3A+6XbOtIqwejz5ZwKSjbnq+PhNEAg?=
 =?us-ascii?Q?OGIu4HzjgGOs9LaVcCexNAkRLf8cjpr+6h0VnJEUSSUlhS1n5/wTEm6/vAuX?=
 =?us-ascii?Q?3xMSwvHyW8pqLjVvuIK9eBQ/E8q+qVez4cL1Nis44OQ02x3fY/9AWCd4sA08?=
 =?us-ascii?Q?lhKPH4NahX3BJuZh6AENd7XLzDYQTvMEyi4GXUucA8idwrHwGvvvpVvX7k1E?=
 =?us-ascii?Q?uGd2rNAbGpoZvmci2+IhnfMJY8S3ZJZ22UcxvRScxD4OiAqnYG18aaoz6NBA?=
 =?us-ascii?Q?Cv8D4qidWWkpoglMCsNqDVADqp+Kf0sDSpzsCXpUqowtcWWCsgMtwmOviSo9?=
 =?us-ascii?Q?xehb2hj0rkzF7Uopq1/f6x2PFGY/laMsZvZALMI6V8iutcFF9j7xZV1iYbjS?=
 =?us-ascii?Q?y5P7HbLZDGGgtL0onVf2Iqiq3bAhbDnuuKq34AclD4LAKNpOcGFjy3WxevRj?=
 =?us-ascii?Q?e//UoR6EDehRLY7qoS0w3gnWW7Lq25iQaA2yLs3iubtyremJa4QzwOdD5Ny1?=
 =?us-ascii?Q?P73zSKqA03uY6pfhPe9h2YI19G7q7SiR0Y13zU/a9dWlzQ0jd3T9ov52UANm?=
 =?us-ascii?Q?31IprcGfcsZoybJ1e/4ctI8Pg146ZdIuDyTP94izly6nbDLgl4ilnI2F4hV8?=
 =?us-ascii?Q?mOv4bCGMYsN9GYR0RWw=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30686a76-ec23-4be9-4ed2-08dc5179e7f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2024 11:58:40.3975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: paRLRP/wL+otxrT2h8scVrti0ll8sK7IAfNW6ndLYzZL3rJUqPoKMi1/FWl9pp5hHMWang/6Ne3Ajb05R9f4Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8322

> Subject: Re: [PATCH v5 1/4] dt-bindings: clock: support i.MX95 BLK CTL
> module
>=20
> On 24/03/2024 08:52, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > i.MX95 includes BLK CTL module in several MIXes, such as VPU_CSR in
> > VPUMIX, CAMERA_CSR in CAMERAMIX and etc.
> >
> > The BLK CTL module is used for various settings of a specific MIX,
> > such as clock, QoS and etc.
> >
> > This patch is to add some BLK CTL modules that has clock features.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../bindings/clock/nxp,imx95-blk-ctl.yaml          | 56
> ++++++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> > b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> > new file mode 100644
> > index 000000000000..2dffc02dcd8b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> > @@ -0,0 +1,56 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> > +cetree.org%2Fschemas%2Fclock%2Fnxp%2Cimx95-blk-
> ctl.yaml%23&data=3D05%7C
> >
> +02%7Cpeng.fan%40nxp.com%7Cd713a861f155495c922a08dc4d01346d%7
> C686ea1d3
> >
> +bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638469914764776121%7CUnk
> nown%7CTWF
> >
> +pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
> VCI6
> >
> +Mn0%3D%7C0%7C%7C%7C&sdata=3DrW7%2BGedk3bloLsAqBIkMlXQNjDmRd
> Z0cHacQtKxjc
> > +mQ%3D&reserved=3D0
> > +$schema:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> > +cetree.org%2Fmeta-
> schemas%2Fcore.yaml%23&data=3D05%7C02%7Cpeng.fan%40nx
> >
> +p.com%7Cd713a861f155495c922a08dc4d01346d%7C686ea1d3bc2b4c6fa9
> 2cd99c5c
> >
> +301635%7C0%7C0%7C638469914764787067%7CUnknown%7CTWFpbGZs
> b3d8eyJWIjoiM
> >
> +C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7
> C%7C%7
> >
> +C&sdata=3DtFzM3%2BxuQVsit9lCEnNz8kYnZjT%2FXj%2Fdqzk9DB9oy1c%3D&r
> eserved
> > +=3D0
> > +
> > +title: NXP i.MX95 Block Control
> > +
> > +maintainers:
> > +  - Peng Fan <peng.fan@nxp.com>
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - nxp,imx95-lvds-csr
> > +          - nxp,imx95-display-csr
> > +          - nxp,imx95-camera-csr
> > +          - nxp,imx95-vpu-csr
> > +      - const: syscon
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  '#clock-cells':
> > +    const: 1
> > +    description:
> > +      The clock consumer should specify the desired clock by having th=
e
> clock
> > +      ID in its "clocks" phandle cell. See
> > +      include/dt-bindings/clock/nxp,imx95-clock.h
>=20
> In such case, put header as your first patch in the patchset. I don't und=
erstand
> why it was split in the first place...

Rob gave a comment in v4, so I split the headers.
"
If this number can change, then it is not ABI and doesn't go in this=20
header. With that dropped,
"

https://lore.kernel.org/all/20240315165422.GA1472059-robh@kernel.org/

Thanks,
Peng.
>=20
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> Best regards,
> Krzysztof


