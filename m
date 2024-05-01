Return-Path: <linux-kernel+bounces-165288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C4C8B8AB5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BCB01F22BC4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC83C12E1C2;
	Wed,  1 May 2024 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ipJrZgyT"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2080.outbound.protection.outlook.com [40.107.8.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5A212BE9C;
	Wed,  1 May 2024 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714567984; cv=fail; b=iomQ6wdWQQd/Ga5hLwjHoFeCan3Kb1jT2BYSmAtL0vJSpvm81NS4UgszC/7P0iLxzJqWKD1ptD8o5wcqnZupubJoME6t3lU+MYmp+gST2EGPbB3zTJ56YhIPBbUuOzR1Ca8mI6K3CSQD6fyUZ57oKQZfNa8viSLrNvmAC4c/6YE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714567984; c=relaxed/simple;
	bh=oiqyi62oUkxzQC+bwYoDfd2HahZmL4sSuzeNjNJOLIE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tODAD2yLQvcwjIKyxiMAlU1o3XsS5uIHVJjsvNnF8XxsvecJwHu+0ILmlCGE63N7PBc48wpcDy0bNZxNnLo6LeT0ckbIEG+w6k+txtvnpNQz3TY/mOUJScgQeHuoA7eir58b5xbYIwBZFJt68OCbzdg4OmEQY4HGKefzfkqf+3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ipJrZgyT; arc=fail smtp.client-ip=40.107.8.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbsovGOncO51AwV3pzASMRftcZ/HX4sVd+uYcoi2eqr5boEmqxyUXr1juVE+kLznhTodQeENY0KyKk8E9VTYuElPI5vBlQ+OKtvAXVuUTkw3IFwkI5G9ebaMqUBdbP7EfRB2u8mr/RYLUbY8XB07hFhtGwulb+P4c/U8bFoNtt+zz6RrYf3teNCs/Omy9U8lysKhOcgUFLYvj6EhWy5ZbNX0r/n+gMKFfzPOLeuCVqff+E/STM93f518/OoO3Ijc25VUIOrlLuEI6Ozoym1BmAcpG1RCCd1F6PF+yXgon9VL6x4GyM5OtNaTI4/BMwqeMRdws+zQSERFAjcK19l8Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYq5z6B0nCcL7uvhhisciz6vmKCrNjlth7917gJ/I4c=;
 b=ijS2U8TbUgn1oegVE3rwLNdVcNwFJi6knuzPcnUxOqBxO8qyHj/LEoxd7W9hV8udOaVnzZw0C5mnUJ3CEl9VOxOlmwJy+PVMVJUpiYTEr9o6IGbQer3Bkq7QIBaEkf1eMu5BTIlzb6v0I49mhBw6TIIkNnmxtbxYydd1M73tVyqTRh3EPecTqrz7NJ5VHPK9+vHDfhIC+p7SEJUWnsHCa+EBvWrGSFSGk/Asi8ae8a/2mzGXFtzLO2bKJe/8jweaxrQ8uNeizKneTnic4DOd4ekLrBSE7nIWSNzhL14qYIJV07SsxbW6Iw/TttM8NYXvvq0JEQtkGBWEgi+RMasXlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYq5z6B0nCcL7uvhhisciz6vmKCrNjlth7917gJ/I4c=;
 b=ipJrZgyTXzIChQidmJnBt4o8esmYwm9uia7BinYTSuO9XL4iQ/JVxec8eGphu4TKlIRPID2LDbmHrUYzhmDH0VpMqmXoCV5x3/serC2lMICJ5lquyxrbO/G1840IALND62YA11H7kgSppizr7Ax95dlVHFnmVT5TiTICSA9Rtas=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBAPR04MB7432.eurprd04.prod.outlook.com (2603:10a6:10:1a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Wed, 1 May
 2024 12:52:59 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 12:52:59 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>
CC: Rob Herring <robh@kernel.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] dt-bindings: firmware: arm,scmi: Add properties
 for i.MX95 Pinctrl OEM extensions
Thread-Topic: [PATCH v2 1/2] dt-bindings: firmware: arm,scmi: Add properties
 for i.MX95 Pinctrl OEM extensions
Thread-Index:
 AQHakTp0F0gZzKwEJ0KLehvuXBXWtLF32SuAgADPKOCACauUAIAAClDggAAIwICAAAJ4sA==
Date: Wed, 1 May 2024 12:52:59 +0000
Message-ID:
 <DU0PR04MB9417FCC7352BC16EA2DF18DD88192@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240418-pinctrl-scmi-oem-v1-v2-0-3a555a3c58c3@nxp.com>
 <20240418-pinctrl-scmi-oem-v1-v2-1-3a555a3c58c3@nxp.com>
 <20240424193007.GA329896-robh@kernel.org>
 <DU0PR04MB9417C67342B1DD6CC299B4CE88172@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ZjIoMJOAxtC-nkZO@pluto>
 <DU0PR04MB9417B9CD74A1E15F2515ECA588192@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ZjI4LQYumNxM_0aL@pluto>
In-Reply-To: <ZjI4LQYumNxM_0aL@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DBAPR04MB7432:EE_
x-ms-office365-filtering-correlation-id: 756942b6-aa98-4b17-0a52-08dc69dda120
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|7416005|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6L6bJ72rDu2wj7R2Zu80ISbt9bDRAU/nNchCa/ALhZMwZa3zwoESeW4fBBT5?=
 =?us-ascii?Q?9jWgmo9Zt2zxnapz8G7lyVhBKpaFd+zx6ECNvFVw0J5Hgzo9iW9W88q3TRQA?=
 =?us-ascii?Q?fm7I8DEViXVXCCJXLEskzVlllI9VDl9vYn4xpRXyBNg0jHIDpTllRCxwQBBm?=
 =?us-ascii?Q?TQg2SFDlSdlR1z/2X+JYjrS6YbCYK93RByPK3StjtOOxIEPBTwaD5huEBpUk?=
 =?us-ascii?Q?xhrMxRHmm/vOgVuEowqOS1C18IzL9ascdpZFkNoFSYoy+ufQAoRHX9jMSDNb?=
 =?us-ascii?Q?2F0BHe5acPVLAUm8Dvpc52D7UVLcaNYqe0+lKxnthfOgRdOTC/N/mA3Phc88?=
 =?us-ascii?Q?n0U+UqfN4ghRcLeo0RIm4rwVMA78j4jb/dqgB5kZJcAOnKkKqoBU5XC1W8zy?=
 =?us-ascii?Q?kbQFTt8CMeI7qv3yFwUHn+NNF4OuyWkIvMeFh9phdg1IHF2Nh29xLax35t8o?=
 =?us-ascii?Q?mZUuL7tF8F1tFVYx3C2e0+vsUSt+u2RaHJWI7ry/L3cAnmz5cjr+KwclMkG3?=
 =?us-ascii?Q?RKQrpFWXLIiePUJmxVoN55du38dyLcQ95kus7XOTiKnjUiMMMUmG7R1W57g5?=
 =?us-ascii?Q?PUaM3L1IA/YM99Gvkq/MxwTyKO8LLMCV2cvnD/VSqh6ndwPEzth3v+/ToseH?=
 =?us-ascii?Q?I37o8Z/en4tUH8DCv4qpqxi20ih7ebIGgtJOpaQj88V0mST45FgOunauFHPU?=
 =?us-ascii?Q?Loa6ufljqEAYinnLYKwnBRdXO2n65OEcbbzWe6dyEXFkvP9szdwwaSIdwhw0?=
 =?us-ascii?Q?NHMcwlpS0EGkK04qeuVgm7rHlxMj9cnurhIUT0Wlp1+XMpY6PDSuT5bBOXpJ?=
 =?us-ascii?Q?EeySW16afv8p9YlL0u72f2qMOsBP52RfEmI1bw5lt9EMKLsnZqaDJBxfQBVA?=
 =?us-ascii?Q?F5jlqUY+6UN2GtbAhUZTHq4xWWw1IzHN6h6DWL/Ia9mQr2fhjHBf0jb3dSRd?=
 =?us-ascii?Q?GfWLAfA0HFKGTStJz4zEY5STYs2pxg4YUtLcLu8V52JUMXwy9HnhGyYKsCHQ?=
 =?us-ascii?Q?g6bUmW3YLoTa7cCMA4tf2H+p1sHeHz6lzuLWJL9GFgxaKi1SeKtkCoK1XQTG?=
 =?us-ascii?Q?4UrwzZeT+RVItFCUyI0UG19sh67aW3fJ6k0+Y8gNoE80+yKtVj43e4RjXp27?=
 =?us-ascii?Q?t25xjlZlUUp4teMP1+s/V5hQzHt7p1tUCnJ4W1L6kaoXjiVnyjdMChQrh8E6?=
 =?us-ascii?Q?MNzxgeB7PM9nYF2PQFJ9ryhCvH67s07POPDAYOuQbVqKblLHABh/Wxds7Yx3?=
 =?us-ascii?Q?56khn1k1ltmrpOK0KU5WWfapJzQti3gJwyslrYKDGBhrkNDR4hyUIi3rmYJu?=
 =?us-ascii?Q?3hQRkwyUjQmy5p1a6TYGEvdojSRW7W6HUbyKSCx1UUsN2w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9WvldHAKYJlC0g4FlLrhJteC0Pf0IV3T1VCozX9U2sxEHTiCpy+DGKRbKT0J?=
 =?us-ascii?Q?FxBchcCGnXhZ2nx8oNLke73D1bGqThv7WKEev2qIVRXenedTbolXN40DbV0g?=
 =?us-ascii?Q?L61o57m469gRkLxKS7hnYNnlnI/yK2wbzBUITbQ1Pehb7eKpA9+TKJN0N8C0?=
 =?us-ascii?Q?Itl+aF/fxKHICCsboJjFo7K0bPJfqZfJCvi6BQTxmnGpC5Gi3LCdqYdaTbTx?=
 =?us-ascii?Q?REkBNB6TxxUy+R9WjQhbeDbhZEEinqfiDGsEpLNKk8m2nuGrX9ArKictSU+0?=
 =?us-ascii?Q?n2tGJBbMAXdHoh0nMYmsC7K9UiH0Jgk23i+ejM522AhpF+S4SQtIPrZRPA7G?=
 =?us-ascii?Q?mA7sUh56D/u/VG7bRvS3DWwKKK6r+DaGF4eR7S6mkYm9UWCmyKIUtHLfHcCC?=
 =?us-ascii?Q?ud1RA4AOfAuBnKuWwFJai4YONvKACHUCxEX3UA4J5j8qXUGp0rU3PgCCjo1o?=
 =?us-ascii?Q?yfrEbSEuehCdQgTzFQMqqV0wdSZmevdcO6ns6c2L6aoyaK2aiIJITbgbigZA?=
 =?us-ascii?Q?2NrCmMTPfqOiwJrQDg9nOv4Lw0xsIbWCNwFV36hN6Zjd9SkAJR0HG8XgNWJT?=
 =?us-ascii?Q?K+x+INu/Okv9jEF/GeJaPl499W+1ijcQjC5ncu8qR0opPpqBtQSYfATzywF0?=
 =?us-ascii?Q?YU0gmBBGY/WrkAz/KbtKxCTpgjkkb07DjTXbWA1Ji9XK+ixo7IyHclDbpeXi?=
 =?us-ascii?Q?TvkIVXsdvdxT9AdlzdPBi5hpV01nAV7EMxpZoH+tnuaTK5cS2LaWbNQGwSQA?=
 =?us-ascii?Q?CMDSM8ZGC66dLYFrAxn8vLVN79LlqQkndA4iaI8WSVNAJbL282m4LWga6z23?=
 =?us-ascii?Q?3AFO/gZcVzEJ+G+Mfa6GzjK+kODcOVNx27RzvsDyyINtV/uhnpp1hbetEflJ?=
 =?us-ascii?Q?H9a6OOp/O8LQ8srsAUBUUY3itXnqD6Pr8cVS+dSu3O1WxbFHg7h4usboEjnc?=
 =?us-ascii?Q?6VSQBPh583v+UF2uo+kHyaxWMDJnduYhINBngHLwUZddj28BxFFYhtRKrzpv?=
 =?us-ascii?Q?9Qv54FperodH7TI09UHK9QjxsMbfkRmU/KbMne/+kpedzvXUpCZMbQ57u4yp?=
 =?us-ascii?Q?4WjXMVeBq2m+TypgluUljUz/BgFbEI0fzXW994lGB4M0qIINpz9ZvDDeovVo?=
 =?us-ascii?Q?DUn66eDgTGncXpO5UoLtXQkSWxXbK+/vUyhvOPAELCZ0XRClvLkkiaHpmqyU?=
 =?us-ascii?Q?BruXq7OfLmqsKRWQR0SEmGcGAgRlm3kR8pgRj4EdUF6n2x3JJDTaih13mThs?=
 =?us-ascii?Q?BVwh02YFDi1/WPxbXD1kcvJ9IxiWWQ3R9hm6JUgJytymzd8laMpwCATgiPrK?=
 =?us-ascii?Q?U/Z/TVUoyrEHy+sFZIHhvd8HjeEr+qG6skXxMvcXa5TcLMYwcedrsHERYyW0?=
 =?us-ascii?Q?5vrK1jSuePx31KRAqm/jfso+fWnDBVeA7H6UqfSwmzJ/JqXHNiTshApXXoNu?=
 =?us-ascii?Q?LWu3cTAURv+3ZtPFx+UslOGcgRfCgpBt8d2ys1e4Zwjn8iIGUyRgMNCtHmXH?=
 =?us-ascii?Q?X4/124ukj0vOypT9qcdw2i/TIlN1evbHvIqDcVv83PviLN0uCNbNQ3jlpC18?=
 =?us-ascii?Q?b9wuiy0oH6uNzi6VpB0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 756942b6-aa98-4b17-0a52-08dc69dda120
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2024 12:52:59.1166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pe5so5768pul7fmY+pek7fmsLmwuYyWjzs6+bm2e6GiDG+mRJGf42dbmXPd5IQNNo54fmp0X4TmrzLIXByYeaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7432

> Subject: Re: [PATCH v2 1/2] dt-bindings: firmware: arm,scmi: Add properti=
es
> for i.MX95 Pinctrl OEM extensions
>=20
> On Wed, May 01, 2024 at 12:11:41PM +0000, Peng Fan wrote:
> > > Subject: Re: [PATCH v2 1/2] dt-bindings: firmware: arm,scmi: Add
> > > properties for i.MX95 Pinctrl OEM extensions
> > >
> > > On Thu, Apr 25, 2024 at 09:06:00AM +0000, Peng Fan wrote:
> > > > Hi Rob,
> > > >
> > > > > Subject: Re: [PATCH v2 1/2] dt-bindings: firmware: arm,scmi: Add
> > > > > properties for i.MX95 Pinctrl OEM extensions
> > > > >
> > > > > On Thu, Apr 18, 2024 at 10:53:17AM +0800, Peng Fan (OSS) wrote:
> > > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > > >
> > > > > > i.MX95 Pinctrl is managed by SCMI firmware using OEM extensions=
.
> > > > > > This patch is to add i.MX95 Pinctrl OEM extensions properties.
> > > > > >
> > > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > > > ---
> > > > > >  .../devicetree/bindings/firmware/arm,scmi.yaml     |  9 ++-
> > > > > >  .../bindings/firmware/nxp,imx95-scmi-pinctrl.yaml  | 66
> > > > > > ++++++++++++++++++++++
> > > > > >  2 files changed, 72 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git
> > > > > > a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > > > > b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > >
> > > > ....
> > > >
> > > > > > +
> > > > > > +title: i.MX System Control and Management Interface (SCMI)
> > > > > > +Pinctrl Protocol
> > > > > > +
> > > > > > +maintainers:
> > > > > > +  - Peng Fan <peng.fan@arm.com>
> > > > > > +
> > > > > > +patternProperties:
> > > > > > +  '[a-f0-9]+$':
> > > > > > +    type: object
> > > > > > +    unevaluatedProperties: false
> > > > > > +
> > > > > > +    properties:
> > > > > > +      pins:
> > > > > > +        $ref: /schemas/types.yaml#/definitions/string
> > > > > > +        description: name of the pin
> > > > > > +        items:
> > > > > > +          enum: [ daptdi, daptmsswdio, daptclkswclk, daptdotra=
ceswo,
> > > > > > +                  gpioio00, gpioio01, gpioio02, gpioio03,
> > > > > > + gpioio04,
> > > > >
> > > > > ioio?
> > > >
> > > > Yes. The name is exported from SCMI firmware.
> > > >
> > > > >
> > > > > > +                  gpioio05, gpioio06, gpioio07, gpioio08, gpio=
io09,
> > > > > > +                  gpioio10, gpioio11, gpioio12, gpioio13, gpio=
io14,
> > > > > > +                  gpioio15, gpioio16, gpioio17, gpioio18, gpio=
io19,
> > > > > > +                  gpioio20, gpioio21, gpioio22, gpioio23, gpio=
io24,
> > > > > > +                  gpioio25, gpioio26, gpioio27, gpioio28, gpio=
io29,
> > > > > > +                  gpioio30, gpioio31, gpioio32, gpioio33, gpio=
io34,
> > > > > > +                  gpioio35, gpioio36, gpioio37, ccmclko1, ccmc=
lko2,
> > > > > > +                  ccmclko3, ccmclko4, enet1mdc, enet1mdio, ene=
t1td3,
> > > > > > +                  enet1td2, enet1td1, enet1td0, enet1txctl, en=
et1txc,
> > > > > > +                  enet1rxctl, enet1rxc, enet1rd0, enet1rd1, en=
et1rd2,
> > > > > > +                  enet1rd3, enet2mdc, enet2mdio, enet2td3, ene=
t2td2,
> > > > > > +                  enet2td1, enet2td0, enet2txctl, enet2txc, en=
et2rxctl,
> > > > > > +                  enet2rxc, enet2rd0, enet2rd1, enet2rd2, enet=
2rd3,
> > > > > > +                  sd1clk, sd1cmd, sd1data0, sd1data1, sd1data2=
, sd1data3,
> > > > > > +                  sd1data4, sd1data5, sd1data6, sd1data7, sd1s=
trobe,
> > > > > > +                  sd2vselect, sd3clk, sd3cmd, sd3data0, sd3dat=
a1,
> > > > > > +                  sd3data2, sd3data3, xspi1data0, xspi1data1, =
xspi1data2,
> > > > > > +                  xspi1data3, xspi1data4, xspi1data5, xspi1dat=
a6,
> > > > > > +                  xspi1data7, xspi1dqs, xspi1sclk, xspi1ss0b, =
xspi1ss1b,
> > > > > > +                  sd2cdb, sd2clk, sd2cmd, sd2data0, sd2data1, =
sd2data2,
> > > > > > +                  sd2data3, sd2resetb, i2c1scl, i2c1sda, i2c2s=
cl, i2c2sda,
> > > > > > +                  uart1rxd, uart1txd, uart2rxd, uart2txd, pdmc=
lk,
> > > > > > +                  pdmbitstream0, pdmbitstream1, sai1txfs, sai1=
txc,
> > > > > > +                  sai1txd0, sai1rxd0, wdogany, fccuerr0 ]
> > > > > > +
> > > > > > +      nxp,func-id:
> > > > > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > > > > +        description: Indicates the PAD connections which
> > > > > > + function module
> > > > >
> > > > > The description makes no sense...
> > > >
> > > > I will use below description in v3:
> > > > For each pin, there are up to 8 muxing options (called ALT modes).
> > > > For
> > > example:
> > > > Select 1 of 5 iomux modes to be used for pad: DAP_TCLK_SWCLK.
> > > > 000b - Select mux mode: ALT0 mux port: JTAG_MUX_TCK of instance:
> > > > jtag_mux 010b - Select mux mode: ALT2 mux port: CAN4_RX of instance=
:
> > > > imx95_wakeupmix_top 100b - Select mux mode: ALT4 mux port:
> > > > FLEXIO1_FLEXIO30 of instance: imx95_wakeupmix_top 101b - Select
> > > > mux
> > > > mode: ALT5 mux port: GPIO3_IO30 of instance: imx95_wakeupmix_top
> > > 110b
> > > > - Select mux mode: ALT6 mux port: LPUART5_CTS_B of instance:
> > > imx95_wakeupmix_top The nxp,func-id property is selecting one ALT
> mode.
> > > >
> > > > >
> > > > > > +
> > > > > > +      nxp,pin-conf:
> > > > > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > > > > +        description: The PAD configuration
> > > > >
> > > > > PAD stands for? Or is it pin configuration as the property name s=
ays?
> > > >
> > > > It is pin configuration which includes pull up/down, drive strength=
 and
> etc.
> > > >
> > > > >
> > > > > This is just a raw register values?
> > > >
> > > > Yes.
> > > >
> > > > Why can't standard pinctrl properties be
> > > > > used here. What's the point of using SCMI pinctrl if you are
> > > > > just shuttling register values to SCMI?
> > > >
> > > > Standard pinctrl properties will need more memory in our SCMI
> > > > firmware design. We have limited on-chip memory for SCMI firmware
> usage.
> > > >
> > >
> > > So you sort of strip-down the server due to hw constraints, but is
> > > it the SCMI server still compliant with the spec ? (as in supporting
> > > all the mandatory commands and features for the protocols you
> > > decided to
> > > support)
> >
> > Yes, the SCMI server is compliant with the spec. It is the SCMI
> > firmware returns num function with value zero, num group with value zer=
o.
> >
> > And only OEM pin configure type supported in our SCMI firmware.
> >
> > I have posted out v3 following Rob's suggestion, using property
> > 'pinmux', but now we could not reuse pinctrl-scmi.c
>=20
> As I wrote in a separated thread (only 5 mins ago), if you have written a
> distinct SCMI driver to use protocol@19 ops to suit your needs after havi=
ng
> parsed your DT...why do you want to re-use pinctrl-scmi.c and so create a
> dependency between the 2 ?
>=20
> The only thing that they have in common is that they are SCMI drivers usi=
ng
> SCMI Pinctrl protocol@19 operations in their own different way.

Yes. I have replied there. I thought to reuse pinctrl-scmi.c with minimal
changes, but since the binding changes in v3, I need to made big changes.

Anyway I agree with your suggestions to decouple the two drivers.
I will do that in v4. Before that, I need wait for dt-maintainers to review
the binding changes in v3.

Thanks,
Peng.

>=20
> Thanks,
> Cristian

