Return-Path: <linux-kernel+bounces-106123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5160C87E972
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABB80B211C9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C2B38F80;
	Mon, 18 Mar 2024 12:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Sno1AvtY"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2057.outbound.protection.outlook.com [40.107.13.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCCF339BD;
	Mon, 18 Mar 2024 12:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710765460; cv=fail; b=GW+GrmTmoOv0ddKWtir5miYuyfrC6ihCmsueY/1qVJYviKyqzhyIYYvgfs5VVTmZLGaozIqXNWz/Ff1XelRTxNxXUMVlNmaJK0TNHtxZ2oZUvVbjyJuePT15Ikj6ElcYDgvA76UFV7pkymTBv2dEid5dzf8eLZ8WZroLdJXnoIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710765460; c=relaxed/simple;
	bh=sS2JyCte0NlvoBP1TAh8spRBWFIEL2N4/vCN8VREazk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QSZfGXJM9sNZTvaif5BVVo7LQAYQa7aukNWRoIOhLhpU8jK0KB174xMGo5X5TzUyFILBukADCihiTPfBGzeV3rixl2rN2teUz8xI2LIIZ9M2btqwtVI+zSJ6CuKppatkkgbLF1VSiYIT+7zn9ukjWyBI//mFhGQTDnZkJ2xbsKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Sno1AvtY; arc=fail smtp.client-ip=40.107.13.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/xS7kqaOCH7/sFR6zzqmpL6t3fCvpBWtKcgFQPpZ8WFZCkWD0fokekTxZnqAkUHA9Nse7CZ0fiiHRzLZTHW0bhjc9XPSnLWLKmSsJR6JDlTjB0bYQe8LZlM+rR+gowNsSmJOTgq/P2aczyt/K3no7G+2eKVTDglGHCIdfuHt9lYmmrgoKzbKvvGJ+6RuCc2aN4by7sQ11DJaIirl4vTOqXUbgMLFsndDShe1nE3cs0S6hms2L+dv4QxmMFNxVL7sqOA9UW8ojdHhEnf3f41k7kqdRmvWDwKK69f+gOml/5raMqQFMLHyKAaPFdrD8hIAjMc1AoJochCl3tepgk1iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GND6LJZ89OV8bUrixez7KTnV6j2hbEEHD1Puk4R4vqY=;
 b=UnpvI/QH/ddoX4JE7LYS3pEYySeJnRS5/7efNM1imVzeEcEOwC35idWAkurvcAlsXsM5I3NxLs8GlXiYEZ+1+NHyyKftDCtH2R9SUGSsMySeumGgg47H2KOkjIoJ3AZJh+yY1vaxcdE51vu8ngKGhR5Rw1tDSvCX3YgPpLBRO+MATeQzxx9WtOx55bKdeVUc/WH+Rf2wcRTOMaOvmD1/F+37DT+T7His4fuX/vM8E6yjXqd/Ffdh6EdAJKZO2fmUA4ePz9UHFSs1OfnM9QD1Il7PJxsuTkOtjct8lP1pCY4e3lDpaswP8pfDc6/3q7dzrwdkBgOAjm0NYicMoe455Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GND6LJZ89OV8bUrixez7KTnV6j2hbEEHD1Puk4R4vqY=;
 b=Sno1AvtYnj35hs+qJBdKPFqYviWs1PDBLIBhh6nnPMmbxhQwzGTiHavrIbqO/CYPRkaN4q0+CPwPHy974HFD4km4nLwornDwPR5hRsdWWr+kRlxUI7B16flGMcnQa0ePywPdOpgRzjqdFA7rxFx4pBPFcagIwvr3aTMArgrqdaI=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7788.eurprd04.prod.outlook.com (2603:10a6:10:1e4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 12:37:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Mon, 18 Mar 2024
 12:37:35 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, Abel Vesa <abelvesa@kernel.org>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 5/6] dt-bindindgs: clock: nxp: support i.MX95 Display
 CSR module
Thread-Topic: [PATCH v4 5/6] dt-bindindgs: clock: nxp: support i.MX95 Display
 CSR module
Thread-Index: AQHadhIES73tdSfBuESVOYmVZaJAHrE5SHGAgAQrn+A=
Date: Mon, 18 Mar 2024 12:37:34 +0000
Message-ID:
 <DU0PR04MB94170C3364CF2F522C515D00882D2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240314-imx95-blk-ctl-v4-0-d23de23b6ff2@nxp.com>
 <20240314-imx95-blk-ctl-v4-5-d23de23b6ff2@nxp.com>
 <b4fe2ffa-bd36-404a-9441-8781f0a81d26@linaro.org>
In-Reply-To: <b4fe2ffa-bd36-404a-9441-8781f0a81d26@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DBBPR04MB7788:EE_
x-ms-office365-filtering-correlation-id: 2848fd8e-bf2d-4ae9-de39-08dc4748301e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 zh/L4ev7loPwwAMoRNHvvQ/YJfmodvrzRWZGIsleOhPaF9NnPB+DatCu13xvIltMNKfZYFrbdFLUXYL+nnZ/HC5E3DxYFOWGTWRP3y2anL7ZVpXO7MK+0Ie9eNTYQWAOQn6p/5KiFeIcEbGWw812+9AYM30JrgKisR/rMgbHMNQkd9FNHxeqyWauu6wlVyJ/PaVg4ovQsZvlzEln/DCuYfcPv2+ir+IoKjl387mCSTAXt4tU3y3Ec3DarcuXYKHtQ7eYjETco94pMoWRJvMdnqh7j7yEyNlD73RKWF7q15r3OGKYNEWfL9UNO7WsB++4Wf/xzbqFxiF7pSDOZbX5aiTgDsoL4sIpzCND0c6Xpn0hBxYHTp90gkxTuQJRXnbouNeOowu5N6FTrSChwIEssAOvdwzEcFDRxvzQMoV0h358srWG20qwr0ebHHZ/GSsHpXby1rL2NuSJy7iIytstikmoixGyBOa4MDCtKWouK7YdhfmhB5eOChZJk5TSIEXuXIsiljbvwWqpwwaIWxHt9VmKGOI886B7uItEUU6NTn5n28YIngS+Daxskg09v/K/Hs/1fmwQZqb+twenSYX5ka3kXVGIbJzgUfXqW6yhg9NRQ7nQdPFXBHWuNKk6rrPYwDVLGxdxX6Xyo27xpImMpFpwY29n9Ghtk/u+lavru7fVa5YX9EfHff9ylYgUKq0r/DBc4ZYuAMNqTQq+8sObux7Xgxg1fRF1/gFrbx5hwq0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?E2TQCiJZ15VW88gU0W5QglO0d71X/UAJuINCAI7jMM/wN+Rg5h5L5ntw+RxY?=
 =?us-ascii?Q?WD2BcMwaC4mecbT0oWCW/Bs6kfewh6Qe5EI3fjzkcr7gzQy1ARIuX999reCG?=
 =?us-ascii?Q?BFyp2LtG3U6+fXmn6DBKh6yMyzY1wzF+h8TLZTLV6qC+H2Vpi1yjua5/sjeW?=
 =?us-ascii?Q?6GeczI1qPy1PoM4qQLgb3sA2fRMiUhYyEuttePce79Pec79q9Ep3ku9OyOTB?=
 =?us-ascii?Q?+QgeyOyuJt+3FcyZvi0bFl/P7ByXYG8hjQXYiqWXl4TsYza6LS4m7k0LCSpn?=
 =?us-ascii?Q?pJnOk4zcPEqJOzgPphtV7tqJGxKuWau1ARod1lWCFrnc553tm8vT/Ic5tJ0S?=
 =?us-ascii?Q?TsarTCnVS/BqQM3SBZhaj6YeFAIPxtgqO83sqr4ZR/Px6NzUfSsUufrMbwGH?=
 =?us-ascii?Q?wsAnUxjfKCMSKHXdPhCYEJIvKhnEyg9J+6S2tcrkInki5tnfHlaD/AvXZ8ws?=
 =?us-ascii?Q?rmLnh3wTRpTND7myPz7wlRlh+WNXTE3dKNpSm2MqaAEWgyTgM8GsZAunMOKX?=
 =?us-ascii?Q?Solfog1Ddt8bxHD/2KB7poeOhp8dZJ6TVZ9iWMyDIB5c+zJjT/vDAOm0WKnm?=
 =?us-ascii?Q?RlDYx9ar1LPYCHtYmNPtLZaWPAbbNJQ1Cqd9Fpta1ZY1F0Ff1BVTx4FQ/7qx?=
 =?us-ascii?Q?5f0mo5/MiTWlMXxaVQjlzzhs2Bt8x8Ar8hfMASjXUo/iUVvGFvkwUd9j6g5w?=
 =?us-ascii?Q?hf5Frvw4MaoqF2/kSF/dTA6LyYWCON9sfcj2gcOmXFnzGQiow/HaAtfJ1Z0A?=
 =?us-ascii?Q?rU4fhHyTTgxxvtsdznFaAUSyIV38y+n5raxZqFaD/HV3seB6GUpmyPO0zR+K?=
 =?us-ascii?Q?jgvhBvLBj1cPHIMCgD2b+xo+gvaiaSQdu0p4bvwmqrh4Gq+tndXEg2p7+lEJ?=
 =?us-ascii?Q?EzGIioazWRnQUllfSLw3tv7GAA0fHTirefpaYLnXN/Mlb2b2zJuMGwWwSCph?=
 =?us-ascii?Q?reSSmkI18PbpSvUnOzVb7WvCAywcTThSL0IwHSLs/FzfwQVflOkfbDarq8in?=
 =?us-ascii?Q?z7tfrNXlr34rdeAT2gUz6X1SivBRclf5DPG8KK7RE3pSpMCqewpkDMzvllw9?=
 =?us-ascii?Q?zEmlBZ5rzkz8DO5YO5mG+SirMJmLAR6YPQiA6hff/tDCdhHxDOt0yY6HO8Kr?=
 =?us-ascii?Q?bdEbvz9YBEyCfMnwXz7P0amYCQdkkmkts22rO7DjZpOJXcazionzlXdqNPqP?=
 =?us-ascii?Q?fUcMZnRblA86GqNgTYhyFR/K1EoGJKX/BLOkxxry6Wp5cdyfi770/XSjzTaM?=
 =?us-ascii?Q?sT8X/syKZw8gItVL3ITlg54Na5xR+z57Md7w+mYv4gPoJXKcTXAyaSSmAW+l?=
 =?us-ascii?Q?fVuoOJGqakiNdw1GMrKSrqaOzV3/g2aQcafETNtjMuMSv9+5LYQC7ri3RMMV?=
 =?us-ascii?Q?SRKxISU3pWzBXKqSp7dGBK1PA8yWgVxByqJYdoy7KQCOptooUKTnGvOyY7l4?=
 =?us-ascii?Q?nI8id3ns6C24OW7SufCFy8+vuiGbNe2yTim+I4QlI69HK5CcgJ6Yei8VDsJe?=
 =?us-ascii?Q?muwm/sFNguVJjy7iG1jizx5BwI7Gbo+IoVTnGnDTGLz4uP/t8MlHBW4HAEnP?=
 =?us-ascii?Q?LY1hJEnIjQcLzdpI3tY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2848fd8e-bf2d-4ae9-de39-08dc4748301e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 12:37:34.9563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Z1XIZdgksxSIWngM6aYjgITufRJzHXaqp3g9/aJBsuOvdyLMpausxj3HTLivRbqG2Z7WhYAlQxm9s/3Uw9ctw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7788

> Subject: Re: [PATCH v4 5/6] dt-bindindgs: clock: nxp: support i.MX95 Disp=
lay
> CSR module
>=20
> On 14/03/2024 14:25, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > The DISPLAY_CSR provides control and status of the following:
> >  Clock selection for the Display Engines  Pixel Interleaver mode
> > selection  Pixel Link enables  QoS settings for the display controller
> > ArCache and AwCache signals  Display Engine plane association
> >
> > This patch is to add the clock features for this module
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../bindings/clock/nxp,imx95-display-csr.yaml      | 50
> ++++++++++++++++++++++
> >  include/dt-bindings/clock/nxp,imx95-clock.h        |  4 ++
> >  2 files changed, 54 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/clock/nxp,imx95-display-csr.yaml
> > b/Documentation/devicetree/bindings/clock/nxp,imx95-display-csr.yaml
> > new file mode 100644
> > index 000000000000..9a5e21346b0d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/nxp,imx95-display-csr.ya
> > +++ ml
> > @@ -0,0 +1,50 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> > +cetree.org%2Fschemas%2Fclock%2Fnxp%2Cimx95-display-
> csr.yaml%23&data=3D0
> >
> +5%7C02%7Cpeng.fan%40nxp.com%7C479f8c47bd4d421a669708dc45316f1
> 2%7C686e
> >
> +a1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638461325839625184%7
> CUnknown%7
> >
> +CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW
> wiLCJX
> >
> +VCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DrntSlDs8ASXSb3L%2F9ZCzgW%2Bzo
> v2LU9vcTD7
> > +SvjE37Nw%3D&reserved=3D0
> > +$schema:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> > +cetree.org%2Fmeta-
> schemas%2Fcore.yaml%23&data=3D05%7C02%7Cpeng.fan%40nx
> >
> +p.com%7C479f8c47bd4d421a669708dc45316f12%7C686ea1d3bc2b4c6fa9
> 2cd99c5c
> >
> +301635%7C0%7C0%7C638461325839637072%7CUnknown%7CTWFpbGZs
> b3d8eyJWIjoiM
> >
> +C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7
> C%7C%7
> >
> +C&sdata=3D%2BjYpR8p7IDjRzV39hJhtv8FozALx9HqqLhoFgwBJCm4%3D&reserv
> ed=3D0
> > +
> > +title: NXP i.MX95 Display Block Control
> > +
> > +maintainers:
> > +  - Peng Fan <peng.fan@nxp.com>
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: nxp,imx95-display-csr
> > +      - const: syscon
>=20
> Why do you create five different bindings with almost the same contents?
> Do you plan to grow on them, like add more compatibles here? Otherwise al=
l
> this could be in one binding.

The blk ctrls are for different functions.

We may expand the bindings to add more properties for the blk ctrls, but I
am not sure as of now. I could merge them into one binding except
the one with mux-controller if you prefer. Or leave them as is, still
separate binding files.

Thanks,
Peng.

>=20
> Best regards,
> Krzysztof


