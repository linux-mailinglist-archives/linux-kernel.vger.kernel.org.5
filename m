Return-Path: <linux-kernel+bounces-58230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBB684E332
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 258471C21FA8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5CE149DFF;
	Thu,  8 Feb 2024 14:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="sLXoQWrI"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2060.outbound.protection.outlook.com [40.107.114.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2205200D2;
	Thu,  8 Feb 2024 14:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707402651; cv=fail; b=B5NRXP8vl97Wngt8kYiWmKl702tFBRdYjHnnoIlsCgV/6Xx/aNgsBZW3drXYFT8B3vRxmJdPIDzgZgcqb6SJlE3ykYP1DvI2Dejim0VTVensK/bchyVCaQdpeRPsygypLdf+0cu2u9dmwBETLtKxW8jv/1phhVbEl/UrTmu6tBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707402651; c=relaxed/simple;
	bh=FO5QzftycPUTlAVb4VOUfPGLfoggq+pFWUY0VLtnJqw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KhZU7j7OXXRxQQVqhGKYsenjO3H++JdvDLDX3/qODn33EBE850mDARc0t2XHx8gLz/l3pBNNSQwBbekCpmuxGivdhGm6POWBIPxpX6bXSeLUTu8IzWjYp3r7TM4rpE60eX7QW+l+bybPzADGTHeUyJbLXPPAVTWAnVOKIH1Kc3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=sLXoQWrI; arc=fail smtp.client-ip=40.107.114.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuDl0jfnBqdUtuAlpgR1VWeJR0UqYfxYNckySAlgUuGVgNg/f+5DRq7lQWQoB7ctolvZlYdrac2dV3oDfAqxKGYYLgq+Eaf/xnA5LbqEC+tGNWLm7X8fZDAYnslX5CwegzLKpQVG3edTo1duHhwlRryldysA/Hy8y7Pfc0sRo8JAEpcc6P+D+6xUvxf8i8o2g9k3emz+vdRnkCD2QHq+nLnDNqvxhsz+MORGSIP70ViqdPnqSJR8pxEG0XOFlie/XIKi9tyfBicWN/rbcIQBBL0otrt45++Kk0we3vnU4KASQgzAkiXytpfq+tGdC6o20ZHwvLJnFuEbtln9pMTc3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1k7cI4SMRfWAYuQl1mbzhIBgxyZ0jBdiZvPDsREblM=;
 b=CoRFlh2pdQWH/c0O/MaPx5PbhVy8AqAwpPGcQvMxJ+t3vHzD3MyVyIHH7+3Lc6z1HojzRXXUpo+P2bTfyi6TuonC9WcJeXa/ckc8JUw5dUft4LLM0Jzo6n2ua9aeLHgbsGy5tn9sMGEGGg7E0obxAgsWHSsK4zlsLmI6kvribL5rWV51FcTsWBWYDm0tJBMBEhbGREgYnQduFuppWtu4dhu3GfHUL/U/9nChFBNjfnkMEN1nJ1J0RG3zEHexCI5nlYZ/QEJr0XtTGiiKqHnImaYgkDtadVelGvPNs3MqABLuhPe+1344PonpUhsgrQ5JqR9pRcpl9jgJbVSncbidlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1k7cI4SMRfWAYuQl1mbzhIBgxyZ0jBdiZvPDsREblM=;
 b=sLXoQWrI6ZWbq0jzGGksf6ApmE970+0nG0Zy+dEkokd03l32Bjl20Ze8yowbRw1bWSp/WKL0QoYa4KGzBQBWhAgU8Nw1/ff+MPaVzwN88QF3ko3IcYKjXDBGodIBp30UGpm/A23aC3aono3sN46M4rP/V2UybeHt2VMBDeq40WE=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYWPR01MB10836.jpnprd01.prod.outlook.com
 (2603:1096:400:2a8::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.31; Thu, 8 Feb
 2024 14:30:42 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0%3]) with mapi id 15.20.7249.039; Thu, 8 Feb 2024
 14:30:42 +0000
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
Subject: RE: [PATCH 01/17] dt-bindings: clock: r9a07g043-cpg: Add power domain
 IDs
Thread-Topic: [PATCH 01/17] dt-bindings: clock: r9a07g043-cpg: Add power
 domain IDs
Thread-Index: AQHaWox93XkHXchpTkaSnTQ6Ok/3vrEAgGfQ
Date: Thu, 8 Feb 2024 14:30:42 +0000
Message-ID:
 <TYCPR01MB11269DEA9261CA594EECC949686442@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com>
 <20240208124300.2740313-2-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240208124300.2740313-2-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYWPR01MB10836:EE_
x-ms-office365-filtering-correlation-id: 8d5ad3db-2cde-4947-bbf0-08dc28b287db
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Clx1e2WfOY9yL4bsQLohBl/+ixhcGTrdZwxioq2ExrmSrRp12USZwce3vpLzEVfQSJMgMUPJuEx1xlye73IAow9PmoJoWlT7Lv7LSewqySejuZwhvE986XJa+97Ynph4oDpTElKfDRuMdo8/RQr4lrRpDzMGs72YlaID5Vfd10J+QuqYHZQQtfDe6MzC7OXFszooCO4ogab5XZ6T46YL+MHWzeibPH7Shnzq6hK6Ty/wmhFcT+iFNgGlgB6XT5RWp6iv095KfH9E3N7OgWSqulDJ2D3ZdnHi1eFQVUI7NnZttLzfcBYaZSc8sQHt5eafVk4FBqZOo4nUMPlYqpMn1M1MUUAUQ+swx07bz7NsJSTaymCfLAKEvYorV0JM3quRoFQ41vSYliJqxDGc/BafzwOErddMiLd3xAB4A+1nIlI5qAs1+wRHShmmPID1w35fBZFirNOKIbIWevv1W9LsGzGMj8MR6hc/i0XsDFkN9T3x1wMRg0vfsmazFvluW2qwTK1rOn2QN5HVua4Ar3D8HXnCgx5wkX8yI3kiueN54Ca8zbyb8Fn10y3JdapnOOREI47pz/Dnd8VtbtfCk048q+SkOZfQkquY7KDtwX5/Y9SjMLZfYDXKzyWXobyAU7p38JZxJzg2X3mCbKQgG3nt+Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(55016003)(9686003)(55236004)(83380400001)(38070700009)(33656002)(86362001)(38100700002)(54906003)(921011)(6506007)(122000001)(8936002)(53546011)(478600001)(26005)(107886003)(52536014)(5660300002)(66556008)(66446008)(4326008)(7416002)(66946007)(64756008)(76116006)(316002)(8676002)(71200400001)(66476007)(7696005)(110136005)(2906002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?l3WysoI/ZxlIEtXFlk2Lu/bSYow0uhFGKm8uyJSVZ/kkOZRAJigU9kvpjclf?=
 =?us-ascii?Q?nGRwE2buHtFaiqAk9pEdAjv/E7ZIeGUmASv0rk7WlbHVSIjjOO4t8gYy3zwR?=
 =?us-ascii?Q?FVrdA3B+eRwH4WDWxzVDH6Ok1UpledJ6nUgy1CFWXM/GhL+Q033Ufizni2Au?=
 =?us-ascii?Q?TuVWcC/LwzBbZnReGE5+0QWon7pCXKmCR2ewN359cZwVZ2gnO0ZvW58zxTMq?=
 =?us-ascii?Q?7wJXMy70Ku+aiTbl7b905+nq/mYWmyotgc1PYa73qdTcDFMPzuR4Hqy7AnEd?=
 =?us-ascii?Q?cuRdTqciABIn70tf3bV+ZZgDLz1VtaI6EzCIhzgFN+bmkmHH+D7Wt0vtduBr?=
 =?us-ascii?Q?4DyvzaTbPltqJZ8rTyFtxAx+32Sm70RY95NILc8CQL7A/9d/kRGfGL38KH6C?=
 =?us-ascii?Q?tPoa4HyKr0g9NmrxPrrsx2sLKsdJADrXCIw0PfB9jPheE78luFCSBpjENwSm?=
 =?us-ascii?Q?xO+U7awnfHfBrrffDxecjO2EYWIgdRf6DCJF5H5CrpXagvUCzmDPt1mlaUUW?=
 =?us-ascii?Q?TUFAlWR/Wt30WmOyGmdl4Ej1OjtqufEBoJvdjeh0x1G7R7VkLl+zgVXFOy9K?=
 =?us-ascii?Q?CzCuE14BMt23t/InXgSlg9DqiyWOTXgd9eVXLzoSDOSqBcawI2UyS8dqNwcO?=
 =?us-ascii?Q?Qcp3HcTYZc6gfG//0TnONaU2WD4d4jRGoT0GYGKh6d1jgsPte9h84wvJbEn5?=
 =?us-ascii?Q?al8RXcBk3jBbvEBQHEZl5DwxpI8aZimr2hSwKbT3ufLm0PPsRBtdAKPxvjQe?=
 =?us-ascii?Q?b/8ysFkfZ4SjoT4tztzZbI9I/wcF05dDVI/AxhvlgEo9Z9+SqXwyChneua3Z?=
 =?us-ascii?Q?nUfk2B+VXYletbDteS0Z0OnUoCImhd0bITHJXEZxVxeRlLwPDQrbOVzooPwh?=
 =?us-ascii?Q?qnUblpv6w7TeLD0R0RccMXYdM0XW2n374oxzjolfh3s51glem66LurS0KSUU?=
 =?us-ascii?Q?bL44p4S6goIou22pBDpOFvovCybLjjoQ8qMXHvSuBHxS5/xelXNNGif0Jr0j?=
 =?us-ascii?Q?H7ceeuJXeVp6Ty6w2EpO2eOkcOk7wj3/XfJNHYa6xcDXb9yS42lgYbnPG+SG?=
 =?us-ascii?Q?ALghf+wKCBFZvKoWxgzQMPSy/FrCOMuv6POuhxUkpeEydw/5qwqh0R9Xtj2w?=
 =?us-ascii?Q?5ev8nIEyUd3vD+HUa+8pe508WfhC2kI2g2kFKRRi4z0STl1CWQicaygaDIlu?=
 =?us-ascii?Q?uMa8shVX644N3W6BE7/rvW6bykneAIsb/AP4CzNjEF1JMQsnoiStCHqJl7Xn?=
 =?us-ascii?Q?uczhVfE25nOBDbuXjG/qTsxvoqpM/CoGgRPHhop095kUI7s5cp4QCZuHfnR5?=
 =?us-ascii?Q?Q2Uj3Fjk8wfzOJzhhA65j7ke1C4ImyelEpR76lNXbo/k47TzUYDGk5FVoO2o?=
 =?us-ascii?Q?IydCfj658ABrkD6JcWyQOKidZp3u0tdpJGVA8/5zfEWIssIPA4IHwPIKAHrr?=
 =?us-ascii?Q?TogLvC20+FsQuZMhOt1bbvNvPSQ8H8FZMAZ5FmQDjztM/iDHCTeMHq2io+PL?=
 =?us-ascii?Q?9TKB4mUxFHMmO1swQNH+f8o4XURJSG00LauwplvsFpMapiTsLsn+oXt0XSXK?=
 =?us-ascii?Q?KYZ4QJqGcVlQWGJnZckkjJpjTFfaAAdCK8Yii8HnIxZePhxkXgmvd3nJ/HwF?=
 =?us-ascii?Q?wg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5ad3db-2cde-4947-bbf0-08dc28b287db
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 14:30:42.7994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4JkkLfg/jqiYJASkWu84y8LgW8u3wmpwCjaMuWV5vVTveLYaK9nJ+pIqP3Th4e8Q162mJteT1vOLMFy32P8h3kqqpVTaDGSNeHdN1nNl4/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10836

Hi Claudiu,

Thanks for the patch.

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: Thursday, February 8, 2024 12:43 PM
> Subject: [PATCH 01/17] dt-bindings: clock: r9a07g043-cpg: Add power domai=
n
> IDs
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Add power domain IDs for RZ/G2UL (R9A07G043) SoC.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  include/dt-bindings/clock/r9a07g043-cpg.h | 48 +++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>=20
> diff --git a/include/dt-bindings/clock/r9a07g043-cpg.h b/include/dt-
> bindings/clock/r9a07g043-cpg.h
> index 77cde8effdc7..eabfeec7ac37 100644
> --- a/include/dt-bindings/clock/r9a07g043-cpg.h
> +++ b/include/dt-bindings/clock/r9a07g043-cpg.h
> @@ -200,5 +200,53 @@
>  #define R9A07G043_AX45MP_CORE0_RESETN	78	/* RZ/Five Only */
>  #define R9A07G043_IAX45_RESETN		79	/* RZ/Five Only */
>=20
> +/* Power domain IDs. */
> +#define R9A07G043_PD_ALWAYS_ON		0
> +#define R9A07G043_PD_GIC		1
> +#define R9A07G043_PD_IA55		2
> +#define R9A07G043_PD_MHU		3
> +#define R9A07G043_PD_CORESIGHT		4
> +#define R9A07G043_PD_SYC		5
> +#define R9A07G043_PD_DMAC		6
> +#define R9A07G043_PD_GTM0		7
> +#define R9A07G043_PD_GTM1		8
> +#define R9A07G043_PD_GTM2		9
> +#define R9A07G043_PD_MTU		10
> +#define R9A07G043_PD_POE3		11
> +#define R9A07G043_PD_WDT0		12
> +#define R9A07G043_PD_SPI		13
> +#define R9A07G043_PD_SDHI0		14
> +#define R9A07G043_PD_SDHI1		15
> +#define R9A07G043_PD_ISU		16
> +#define R9A07G043_PD_CRU		17
> +#define R9A07G043_PD_LCDC		18
> +#define R9A07G043_PD_SSI0		19
> +#define R9A07G043_PD_SSI1		20
> +#define R9A07G043_PD_SSI2		21
> +#define R9A07G043_PD_SSI3		22
> +#define R9A07G043_PD_SRC		23
> +#define R9A07G043_PD_USB0		24
> +#define R9A07G043_PD_USB1		25
> +#define R9A07G043_PD_USB_PHY		26
> +#define R9A07G043_PD_ETHER0		27
> +#define R9A07G043_PD_ETHER1		28
> +#define R9A07G043_PD_I2C0		29
> +#define R9A07G043_PD_I2C1		30
> +#define R9A07G043_PD_I2C2		31
> +#define R9A07G043_PD_I2C3		32
> +#define R9A07G043_PD_SCIF0		33
> +#define R9A07G043_PD_SCIF1		34
> +#define R9A07G043_PD_SCIF2		35
> +#define R9A07G043_PD_SCIF3		36
> +#define R9A07G043_PD_SCIF4		37
> +#define R9A07G043_PD_SCI0		38
> +#define R9A07G043_PD_SCI1		39
> +#define R9A07G043_PD_IRDA		40
> +#define R9A07G043_PD_RSPI0		41
> +#define R9A07G043_PD_RSPI1		42
> +#define R9A07G043_PD_RSPI2		43
> +#define R9A07G043_PD_CANFD		44
> +#define R9A07G043_PD_ADC		45
> +#define R9A07G043_PD_TSU		46

Not sure from "Table 42.3 Registers for Module Standby Mode"

Power domain ID has to be based on CPG_BUS_***_MSTOP or CPG_CLKON_***
As former reduces number of IDs??

Cheers,
Biju

=20


