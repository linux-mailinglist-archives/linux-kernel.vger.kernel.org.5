Return-Path: <linux-kernel+bounces-126394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7277A8936BB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 03:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23231281E07
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 01:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D004E138A;
	Mon,  1 Apr 2024 01:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ipnNUYDe"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2091.outbound.protection.outlook.com [40.107.249.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645B3623;
	Mon,  1 Apr 2024 01:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711935171; cv=fail; b=Esu1syy35/m+o9FNY0wX12LaNlSFXW3mJMOokUu0I9bHJuu8hPOfWedFBGmxmNDDN7rVrKDtv2isnTjc+z9bOo07BIeKeTnduECA4qwK6Och2C+DpBWXxxkgMoPv/fFFB3uDv8HooSWoZFM7e3VoJJxLf17y2J8NfY5c6GTow7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711935171; c=relaxed/simple;
	bh=gMmWHikCaYYVmeCC1zlyVBA7wbCALliNaYxog7ahgjE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c1PUbP5MESCNsY97ZsgamFpF4KTkyP6HsC7w+uaWQmZrq/M3Yo053Z/JKOAEWPAsQMrVDw9cIVENjq5OZHRgYXioREULC0TveM5sOGYX5AJZgyHPZjpZS5BdGnn41rhnCCiiTmRywz8Cq6pW/c1fmqFc/ZfnpUVOGaOOEJFIPf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ipnNUYDe; arc=fail smtp.client-ip=40.107.249.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDMXlRX9jU7RsyVNKcqlvkvzlCuXYqzsE4SKDZ9GeF4vY1d3jePxrt+xoVurMfCP0pkHXsDxQOEWsO/2tODjZgu2BHkGqHUIeqo88Bk1ktJmKnBgTG19k2dqOI/H6PbW4U7mrbp3cz/eg19eyH3PCL6XHb7xhNSyMiUlRqBqZ0Jx/4HE0g3yy1OK/qaGK4cKE+WmuTqHKLvlEtpWC8IMP+2X4hVx3T2X0Q8xj2SB0si9kD90mXD7SVCVHtDhVJsD0zT3KnhbFFf7RpgGK18UsnrwrF0yMf+vThvVF24EzVSMZz1BbnfJWsWrkrKJhYgdGZuMV3L4g6Bhvg7+cfa3og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMmWHikCaYYVmeCC1zlyVBA7wbCALliNaYxog7ahgjE=;
 b=PtMiwDIsX1BgUWoXFnhPBaYh4RWSBcNZAdOIYyVdAcLXNxugLZ3HgEDK1j75aFo8mpcrs4qIom9etkRyovZo4nq+7Qrn+cTnRDZ64Rc4NVTIE3IjrZkGT32TPJKipKgH1hjAgShOykiAmCoAIVWKs55ACdynz2moMHdKRJfanG/8WQtVe1SiypxafUZeeNc4hlZ+WyTX5lR0BS2yGIvKcLZQBaSXeHCvf33YfmRAPVg9X4u053x8hub/dD3DLDXbOIhgdyi2kCVpCidXSrGwTPFbuVi52oUsi0uFmyJwkkM0tRcXTyeK++ukgfxtwEVVuDYEIQ7eRtZQ/TO/7RbUFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMmWHikCaYYVmeCC1zlyVBA7wbCALliNaYxog7ahgjE=;
 b=ipnNUYDepDLAQLTzI/dspRtf4w5llcXQMfXWuS033+hrFwXyv7vtGp13zSandq4vdkxevN7IxowpAxOtM4GUGLKw24BK7xpCSBccjxKPYQfFPFsHxIABnnH3zuV5sIM5ijUtHxayOY8YRlzhExhWQS/qU+vjMouJZSfHvMTBobg=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8152.eurprd04.prod.outlook.com (2603:10a6:20b:3fb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 01:32:45 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Mon, 1 Apr 2024
 01:32:45 +0000
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
Subject: RE: [PATCH v5 0/4] Add support i.MX95 BLK CTL module clock features
Thread-Topic: [PATCH v5 0/4] Add support i.MX95 BLK CTL module clock features
Thread-Index: AQHafb8D/Pe+n4NV2E+w7m5684C/SbFI1+eAgAjyXbCAAIR9gIAAXjRA
Date: Mon, 1 Apr 2024 01:32:45 +0000
Message-ID:
 <DU0PR04MB94176BF213F73C9B41849019883F2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240324-imx95-blk-ctl-v5-0-7a706174078a@nxp.com>
 <ce1b814a-6b1b-4773-ad29-b572d00f56c9@linaro.org>
 <DU0PR04MB9417426E1F8EA9560213E58488382@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <e9809695-760e-42d2-a79c-bc2d4debdc32@linaro.org>
In-Reply-To: <e9809695-760e-42d2-a79c-bc2d4debdc32@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB8152:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 UB2unewymGvmjLfLOYoriOJdW1KM4B3/njnANjjdH6ZBo9ALvU9S/Z9QOMRjL7ye/VqAIq6YPQQFPX+Aact5IPl8vNteNugYtNIPHwD5mE1uu4hXhPQu0gXCfbAkNKr9eWjzXoeJvXuWA1Aw7xwFXqnYd2vy/uv0Nfg127DNiqTDwHzCCix1uglYtxADGUP/XfqUjI4UQhnjjKxcO76Y0CothEiJJtYUJaWX9H4hfNcqItUu1wViuJurjWYCNecc/RIohmsTm9D+wfCKmXbsbFpwuKjsQCsOwBLkhqB/wDhqMxjtLh/feLpPVKJejUd3LlGRLR6Sp80fQHHXKFvnc+ScLWbilcW9uJVMxg0d5QaIyCS8nMjX0cQwUM+zfjAKSvtUfjImK4yFH97RpiFtY/c6sTDRYhwDv+T07086ng6TjZom/ONbngJuKYJsmX3D/4m5qhDbRhGZ5MZnYY4BTfsY2HO69k97T2LMcYkPjslBb9Z+2+5xFjoGYyiMjwrukEl4lYwso1j3YtMroEr5wsmmCmx4U7DHSE7kFgl98kanDOSxv5qInj5akSuvUc3ROQfLuw+JmctqM4yUqLhZTZjMx1tVtCLQffZkdzFn2A/7sddtwRc63/0PmmeqfYe+1Qu3yqK0EABfaJPdmov0H9945U28CSO7uSBY5PRi+aRDRip/vh6GgZAbqpW6oztF00GYkDwcalWMhuqo6COYYg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?a5aRqVXQDGFZ708b8PQgKMuZ8wVPEPGNeW1MHIcVaZ/7kD8RS/+d8594H0g0?=
 =?us-ascii?Q?6mgJLZvLtxYOlqB112Vt7IjMdeP+4ZIrdea65aANuTOuzXi7oa1npjNzBZK0?=
 =?us-ascii?Q?1l7tC2Y590yUKTTAc7zRKZVMriNB1iCdKNs3ryJImTGY3aPcuuJw/N3nHFw/?=
 =?us-ascii?Q?BOqKz2CrQSkWGmnH8oSKCzycBTlJKPfjbvTNg8prICeolXLU/dIV6UUMRLBa?=
 =?us-ascii?Q?VDJ82Hiln7niH3YJZ2lAbukidRXmkfrgYlqr5FikDDM3Zog5OcrgZ6pxpJrF?=
 =?us-ascii?Q?t22/OCt9nGE0UfO3Z52xqVGmEJF1VaZlB8m5mmENvFse6PT/HLbCZ4QCoMKu?=
 =?us-ascii?Q?E+oaYQjzJmY9BBsjJycqia9QpkD0anu3txU1c/+60jgIsIvtsoGlR2Ofdu/m?=
 =?us-ascii?Q?IJ2taKDg9vlBaJLoWTbc97QEIIG5AelvbKgSatD9Jz4vwMALPsy+t3gN9NrM?=
 =?us-ascii?Q?ADgoX7XQLpE2gfwQH5YGkGxOWWlrw4VfDrRMOXmUhZcjG2VJZ6bKeC4XU79r?=
 =?us-ascii?Q?5oIpfVIQur6atIeYqdlhWA+zcDFQhxDNAWTJyIjhBX9HreWf3h9umtpa2GzJ?=
 =?us-ascii?Q?gmEzTi7DHNThkeGev3Zea4ApX5NGY+YDTYkw7ZUqhXm7MSS1JH9B2KsqQcOz?=
 =?us-ascii?Q?IlSrkHogbD/De86MDudKit6+2H1XU/C0b17WuRLQPIL1Upts4tweqtffsUQL?=
 =?us-ascii?Q?tNUkBbXovFE+wyFXXx8HoGdCTijys+sJclJ0e2Lg3zfqPCzvnrWOzCZ1VCGu?=
 =?us-ascii?Q?qCyP+v7CPso5NrSwCLU9RrvIm/FQfWj6sLQMYYOGBPy11VpmPF2Fj84P9Tkp?=
 =?us-ascii?Q?aHYLSylAJAcMWBtJNXsYo1bIn2UF8N5PELiQKOJWpc5qxAlfePlQwlOp8Phk?=
 =?us-ascii?Q?2/9/MZ8q8lALWKUZM7U4W0JVlbdXNaHoIk4tQvcR4Oro9OsOKUY3e9vf4jMD?=
 =?us-ascii?Q?WdCf279GET6dBQAjBweOIzFpdoUlcykXhV2csh0wWG1qO20lJbCMlVRyWG6Y?=
 =?us-ascii?Q?QIT6wibVx46XRXjNdcr93W1DrRuPXP5Iq52VfuKVJrBmdA0ctiB1gTu8OBpE?=
 =?us-ascii?Q?qkaanmyEhMAMAnnJ9/I8yWkXS2pwtA5LE/x7uwHA0I2r+3NrfezSnzu3xSAV?=
 =?us-ascii?Q?saP3yackwD6HguzYArZD96DOOmsSWZjOaq0e+0rp8k57IwtFQYgY8XhlPacG?=
 =?us-ascii?Q?ooNYoICpLr9r6y70NHOHbNYTWD8ujFrwzDeVQ6O7RNubdPYeRnGVl7ayHXWm?=
 =?us-ascii?Q?MdcRPLeXgzk8J8koeY7GOw4lxuafsXxPdZYaagI6D2BLuIkS801UaAQURY8v?=
 =?us-ascii?Q?6MYarCrPhS2hgDJkcGLswP7+3tOjengsKtmygDDY+f0IJa/LDlGHbTuCduEf?=
 =?us-ascii?Q?Ga1sbRkJ29jZfj7Q1DA6ZLoNqFn59YIVZqybCrVNgmM8EaSkZBFIEQJlk5Ma?=
 =?us-ascii?Q?D4TS2g4mdcVzfjnGVA1DoRZnn1lIIwnVi7gvywNtD3rQnnrKztq/wx0V7O0n?=
 =?us-ascii?Q?XkNETTEa5SN9yM133jCcGYHjNQyHv/Spw7RVL3LoKZeJTeFNbXvrALp4GArY?=
 =?us-ascii?Q?oGI+tpSb9i5C/Nz/9aU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4366a2dc-a3a6-4b70-317f-08dc51eba201
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 01:32:45.6734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WOHgs6PFe4qL2acpxpqh8AX9WWy+xWV4zF9XPoDjn9dyREFSzlI3lLUe1z9p2T+E58KKiugHY08XlnXQA/voAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8152

> Subject: Re: [PATCH v5 0/4] Add support i.MX95 BLK CTL module clock
> features
>=20
> On 31/03/2024 14:00, Peng Fan wrote:
> >> Subject: Re: [PATCH v5 0/4] Add support i.MX95 BLK CTL module clock
> >> features
> >>
> >> On 24/03/2024 08:51, Peng Fan (OSS) wrote:
> >>> i.MX95's several MIXes has BLK CTL module which could be used for
> >>> clk settings, QoS settings, Misc settings for a MIX. This patchset
> >>> is to add the clk feature support, including dt-bindings
> >>>
> >>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >>> ---
> >>> Changes in v5:
> >>> - Merge bindings except the one has mux-controller
> >>> - Separate clock ID headers in a separate patch per Rob's comments
> >>
> >> Where did he suggest it?
> >
> > See
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e
> > .kernel.org%2Fall%2F20240315165422.GA1472059-
> robh%40kernel.org%2F&data
> >
> =3D05%7C02%7Cpeng.fan%40nxp.com%7C95289dc4bed24c3d125808dc51bc4
> 4e0%7C686
> >
> ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638475116243825697%7
> CUnknown%7
> >
> CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi
> LCJXV
> >
> CI6Mn0%3D%7C0%7C%7C%7C&sdata=3DDt6KYhWwp%2B4NSwHJlXwUjyRqYU
> CkN0MvlSOE22w
> > vRE0%3D&reserved=3D0
> >
>=20
> He said under specific line about one specific define. There is absolutel=
y
> nothing about splitting the header into new patch.

I misunderstood your point, I will put the header patch(patch 2/4) as the 1=
st patch
V6.

Thanks,
Peng.
>=20
> NAK
>=20
> Best regards,
> Krzysztof


