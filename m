Return-Path: <linux-kernel+bounces-58241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D5A84E356
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59FE81F247E0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8EA79DB3;
	Thu,  8 Feb 2024 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="EhyNJaWw"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2062.outbound.protection.outlook.com [40.107.113.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FE576412;
	Thu,  8 Feb 2024 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707403161; cv=fail; b=hmraeW5HmiYu/U2noj0XPxqkeNjKrFoR+slzBPqLJiJXcLJhvyz3LtwLfszOWXoi19h3IYe7f6h8JbUDy1iZSPEr/9hGML1fCEn5p09uEM9snyPNrDBmi3dN7W1Y2/MQAkoEJ6MYT4qBjlurxxlKdUZuqXYGq2GvQPbhV13MLJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707403161; c=relaxed/simple;
	bh=g4otENHbf44YiCpKIBlx42xP0P4+ffeuLUQRL45qagM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rWFOg7ocEKgQZtgZ6RPG0zVykBa4AODnYI4YWOcv2Mvz+/GBXRgi2uqlC3aRGfpxiGq/IU3w0OJWqp3L3HS25T2izAHeOjVZn6bxDKmv///bjcXG+kKtLMewZvhvg466rRR+rMBSl7NDC67zIndHbOyx4Bgyi8JS0lRnnzAenGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=EhyNJaWw; arc=fail smtp.client-ip=40.107.113.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzQH7ZYodKYW7RTkRNjpwM88+SDsk6QjeY/RKIuCdYauXHWOfJDtIORe0hvkWQLpbb4gANZfx9gMV+8QYeuLqBeNgvEs9ZBbE+ZRaM76TU/DU/5ck/JuJDfULr+dWfW6G+ryGgytXZb1CTJEKmn/ke3NaShev1LtF9CEtP5cUnPWwoYAN/c4J5Vz2fzx3Qic6vbGKd3EH/DMXukQ/5ulPdLFQOoYSU2dhNEfV4ZHW1lHpW+0+GeSiJDbZrB/N0kQ9iHlt0QrHk2ol9wK2QyerPA9NnwFf8uu/zGKWz5jKuRJWHW8z8xAiIeDaY6glS//mYZJR3ODJUF+gxiinJkr3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chP7/btw4hKeaelZKzwyYNEdHR8okkV6/hQt8SSrKUk=;
 b=le3icaTdoSpn1Ci6ZvuflpCQ5D5ASf/+sPebUhxsVO/1mpMKVQytKb+LStJ5kM41LeBwB63ODmb/EVDfX1OfkTt/h/X/wCUUfO+oW7Ymeu5c0y4d9l13mWyfbgfhJgcP1Tmp1qiJVRyJ5lUMPpE7ys6xIYj9yHz2iG7K4cO03Cg/pMWgV0ba20KM9u49QRVj1Ug7Lbs1wmAhlJjQQEFJJ4up7pANqU91qexXBESrcIbhBWnFRCALptYcQcMquOfCci4P1SVzsto0Q1yLzqff82qu0o5/J7FEKzzs0Ks3UrwEPy/EP1G8DSSN4EYAA/0hYTdJa+726PNTvF5+9dYWeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chP7/btw4hKeaelZKzwyYNEdHR8okkV6/hQt8SSrKUk=;
 b=EhyNJaWwdXYjQ01esyk/ohtcN9r9WMVyXMdDvfvwrp/47eKiZvbXATuUstT5zX/zqlCcxtnY7c8UCvS0wRuIWeuBy936OlRax5p0XuZJJE28pF6Cu2/T5i9aKGcsppiLv11C4AKGaBPnumAzcvi3Olj1z+XEmVL8Ug1UGVmtfd4=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TY3PR01MB9901.jpnprd01.prod.outlook.com
 (2603:1096:400:22b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Thu, 8 Feb
 2024 14:39:12 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0%3]) with mapi id 15.20.7249.039; Thu, 8 Feb 2024
 14:39:12 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "palmer@dabbelt.com"
	<palmer@dabbelt.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
CC: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	Claudiu.Beznea <claudiu.beznea@tuxon.dev>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 02/17] dt-bindings: clock: r9a07g044-cpg: Add power domain
 IDs
Thread-Topic: [PATCH 02/17] dt-bindings: clock: r9a07g044-cpg: Add power
 domain IDs
Thread-Index: AQHaWoyKWs7Fm6mmz0yQXbBEMl7T5LEAg3mw
Date: Thu, 8 Feb 2024 14:39:12 +0000
Message-ID:
 <TYCPR01MB1126925EE70DA30AC2662862686442@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com>
 <20240208124300.2740313-3-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240208124300.2740313-3-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TY3PR01MB9901:EE_
x-ms-office365-filtering-correlation-id: b825e27a-f8ee-4076-66ae-08dc28b3b769
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 23XttjavPcjEtZwoGXDgBVXMOFBxJObD3E/W5U5D5gy3lTX0f9XQ8i4DwziZPICW5aMgnMKl+fC5zv2QHX3HmFmjT9I+ZIG1oU5rFsmvA3VFGtefX2tIpj36ohbHEBEhB9MV7LaENiEhjHfibhLNv6FiQWG1l9Rc6eIsJzQIMcXec63NjeS7EEJuoSBU9goqiv745DMRyPz9krcT/06AP9/tcQtsnDhBrImfV3NssYjLcvNjxAiiijQJQJsO6mPvD1D72UP/vPSqKKWv3umnZdjZpNZp5eft9BZ3x+TgslnwgBuh8VnzcSf4IUWp5W5Tk3E8gLq0D6uBNZiIwJ5Ei6si6oncgffKjHBK5ZbjlNRxl3eb+OeAVNzgA0U1xCKKV13YpotOZBAQFiVE/iBsN+H6wHg+NL9bRWLEMm9nS7Bby7DM3iZ8yDc4+dtFXFMem6qwFdLAJTiX69cRUeQSzbjID7hlzHAIS/83dEfypEJZ69t/JtHEKn9KXLX68xo7LDKrvrFxC9Shs0jj8fldkjJ4frcTGFTt112iyHkdalOzviu5pD4z+gH8kqjLvQ53G7ZeiTfjKFURh4W0LVGA5frHTOQVlDIumryv1LwUIcmym8oEfjUF/hpCezyDW/VR0QDIsZjuPaMSw/rBDL2o6Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(39860400002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(122000001)(38100700002)(83380400001)(26005)(107886003)(55016003)(41300700001)(55236004)(8936002)(316002)(71200400001)(8676002)(53546011)(64756008)(6506007)(76116006)(9686003)(66946007)(66556008)(66446008)(66476007)(110136005)(54906003)(38070700009)(7696005)(478600001)(921011)(33656002)(86362001)(5660300002)(7416002)(4326008)(2906002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Edjbw3QKntkj6jQ4X4wku21b+tEANZWKZ87JgHaOkrnwlYIaI4NiUlxVorw6?=
 =?us-ascii?Q?uViHgdou8hTH47Q/Jpz366HYEH4A9gMnRCXvY1IvQyhBJ6MnbXghTKf8UQm+?=
 =?us-ascii?Q?4sx/k4eJZ5Q+P52SobMJ1ku9sb5ekXfLy5Vridjx6pwsP+3+cW+jo2EH+s1v?=
 =?us-ascii?Q?gb7RmYZ+Nde+MmpbMZMHqLAV7/9zEvruZ3ALTwanxSC8ppEteN6T31jRZFAa?=
 =?us-ascii?Q?0ogZvCw60TjhZZHGAOjqF7PruFxy90/3L8eifM89GerH4I5vhM5jisvMKzgV?=
 =?us-ascii?Q?V+Y8dL/7+rqXojYXpXFsEU8YbiKuC9zWK7jP9T7TJ9yjYmHxUAkS+XsCYHrR?=
 =?us-ascii?Q?vlOsb+eG1SFqKurlLZKhO2nSY6vLSKfAW2UtcSYbNdrZXj9oA8LvdAyd5Uad?=
 =?us-ascii?Q?SzhDgI0DfwtKVOHjHEtVQpLHLgRs9QXAuWpDAfNFkoNPlX4OlaazaPwTOqtq?=
 =?us-ascii?Q?k+M7G3NMg277fobuuYdL52GPycGEEkXM64OjX521+d9f3YQwIe8XZV5ZBH0D?=
 =?us-ascii?Q?440gzcEFOj6x0dnD4OOtViEBzENbQqsTsSGnfacF/zAdXCr3r4ES35VkEPvY?=
 =?us-ascii?Q?fUoT52vOdPjAiO9ra4xKFXkq0GqOxRYYO9Kft/Iu1y1rRfQUu8KfIUnBOlsr?=
 =?us-ascii?Q?2dsOKibEimZqiKx4dFVFI3MnoKJXfi6ltMKKXsZfxqMtmfXU/Sf3MrDfkYRX?=
 =?us-ascii?Q?XS7rq/uIvOTdt4YucOfNuDsxAH6/YDGc2ThLIu4rPKI7+FGm/WvpC07hp7r0?=
 =?us-ascii?Q?Nvuwy51VifKpwx9kPXmy82e7pfcH23522E/dh1NZTJxkorEEZB8fyQMZCtCV?=
 =?us-ascii?Q?tdzj80c/nUF3OEBJ0+Jvat89urWzcMgprHjg1gFLmwYnPRgDEstuduiu5cKF?=
 =?us-ascii?Q?NznXuYwsPLjUo7egYnFUrf6ouG+uyHFRkdgJ2Rz3WumfNmFxV2BvhGn8SaIT?=
 =?us-ascii?Q?sGcdHAOqAcHJ4k7pDjVG3oO4p9xZZQ/iiwd5ycPFB7WBZ86z5yXx893d54F5?=
 =?us-ascii?Q?s+6WR4zLDia0fsZ4gBtP+SyQk5Csc18lqWf0Hl8es5vKVdYW3atpjrCXPVOf?=
 =?us-ascii?Q?b5A+Xp+EDQCqMyAgX68DVa63q1xpcDsbHcPHE82A7JTUffYFl4SItEkhJ7YO?=
 =?us-ascii?Q?/+XUucri3yJ6eeV6YTtZJY1ZvrVmIyegrEr9JC0ECxtTjn29Z6ORSpuy7s3R?=
 =?us-ascii?Q?yl2UfZ/jwKk64cRZl/bIlCcsSJVJIN8kjSYoxsUG8WTHkp7LWu4X5A2rAquI?=
 =?us-ascii?Q?exxOkIrzgGNl4FjapwbRfJkZ/Lo94OiJNSr7UhNgrQB3asCzQOz5PoUAL3Pp?=
 =?us-ascii?Q?J39dhWGb0KYGbitbQNHkT/Qy5MJ9YXfuTZ2fu8n2n3v+stryE2tIQaPqM1YB?=
 =?us-ascii?Q?LisIsiOSV2s0Kf2Bvenw5qJpVGXOfGZ6fgBIdXEqREpo0XZzAXex8S7/ralr?=
 =?us-ascii?Q?MQlNAnTtuvTi3+TufUBotDcdxfRtHcU/TmuZLTU6befNc3o1MZjUI6KinhFZ?=
 =?us-ascii?Q?DTJoz/AAXVV2xIIXBBZWvBwMCL67GgdSRaI1uC3Si4A3ZSie218ak/ybTHwC?=
 =?us-ascii?Q?EqIiFspunDIHn2Zh1CDr88hPu3VJxf+eH1uJ4plBdZLA/6SrWPUsDv3y1w5k?=
 =?us-ascii?Q?YA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b825e27a-f8ee-4076-66ae-08dc28b3b769
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 14:39:12.1061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9EyuxraHTJJExXjFQuyYZPI8MmWVsFLyhZ4yc5a7pkEm0kVAnwhEbOJEWyTMWwN/SUINJ3jV4Zem2bTqMRDQe/F6+0GGcxLYnjOU7StNu8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9901

Hi Claudiu,

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: Thursday, February 8, 2024 12:43 PM
> Subject: [PATCH 02/17] dt-bindings: clock: r9a07g044-cpg: Add power domai=
n
> IDs
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Add power domain IDs for RZ/G2L (R9A07G044) SoC.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  include/dt-bindings/clock/r9a07g044-cpg.h | 58 +++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>=20
> diff --git a/include/dt-bindings/clock/r9a07g044-cpg.h b/include/dt-
> bindings/clock/r9a07g044-cpg.h
> index 0bb17ff1a01a..e209f96f92b7 100644
> --- a/include/dt-bindings/clock/r9a07g044-cpg.h
> +++ b/include/dt-bindings/clock/r9a07g044-cpg.h
> @@ -217,4 +217,62 @@
>  #define R9A07G044_ADC_ADRST_N		82
>  #define R9A07G044_TSU_PRESETN		83
>=20
> +/* Power domain IDs. */
> +#define R9A07G044_PD_ALWAYS_ON		0
> +#define R9A07G044_PD_GIC		1
> +#define R9A07G044_PD_IA55		2
> +#define R9A07G044_PD_MHU		3
> +#define R9A07G044_PD_CORESIGHT		4
> +#define R9A07G044_PD_SYC		5
> +#define R9A07G044_PD_DMAC		6
> +#define R9A07G044_PD_GTM0		7
> +#define R9A07G044_PD_GTM1		8
> +#define R9A07G044_PD_GTM2		9
> +#define R9A07G044_PD_MTU		10
> +#define R9A07G044_PD_POE3		11
> +#define R9A07G044_PD_GPT		12
> +#define R9A07G044_PD_POEGA		13
> +#define R9A07G044_PD_POEGB		14
> +#define R9A07G044_PD_POEGC		15
> +#define R9A07G044_PD_POEGD		16
> +#define R9A07G044_PD_WDT0		17
> +#define R9A07G044_PD_WDT1		18
> +#define R9A07G044_PD_SPI		19
> +#define R9A07G044_PD_SDHI0		20
> +#define R9A07G044_PD_SDHI1		21
> +#define R9A07G044_PD_3DGE		22
> +#define R9A07G044_PD_ISU		23
> +#define R9A07G044_PD_VCPL4		24
> +#define R9A07G044_PD_CRU		25
> +#define R9A07G044_PD_MIPI_DSI		26
> +#define R9A07G044_PD_LCDC		27
> +#define R9A07G044_PD_SSI0		28
> +#define R9A07G044_PD_SSI1		29
> +#define R9A07G044_PD_SSI2		30
> +#define R9A07G044_PD_SSI3		31
> +#define R9A07G044_PD_SRC		32
> +#define R9A07G044_PD_USB0		33
> +#define R9A07G044_PD_USB1		34
> +#define R9A07G044_PD_USB_PHY		35
> +#define R9A07G044_PD_ETHER0		36
> +#define R9A07G044_PD_ETHER1		37
> +#define R9A07G044_PD_I2C0		38
> +#define R9A07G044_PD_I2C1		39
> +#define R9A07G044_PD_I2C2		40
> +#define R9A07G044_PD_I2C3		41
> +#define R9A07G044_PD_SCIF0		42
> +#define R9A07G044_PD_SCIF1		43
> +#define R9A07G044_PD_SCIF2		44
> +#define R9A07G044_PD_SCIF3		45
> +#define R9A07G044_PD_SCIF4		46
> +#define R9A07G044_PD_SCI0		47
> +#define R9A07G044_PD_SCI1		48
> +#define R9A07G044_PD_IRDA		49
> +#define R9A07G044_PD_RSPI0		50
> +#define R9A07G044_PD_RSPI1		51
> +#define R9A07G044_PD_RSPI2		52
> +#define R9A07G044_PD_CANFD		53
> +#define R9A07G044_PD_ADC		54
> +#define R9A07G044_PD_TSU		55

Not sure these PD id's can be generic and used across all RZ/G2L family
devices and RZ/V2M?

Cheers,
Biju

> +
>  #endif /* __DT_BINDINGS_CLOCK_R9A07G044_CPG_H__ */
> --
> 2.39.2
>=20


