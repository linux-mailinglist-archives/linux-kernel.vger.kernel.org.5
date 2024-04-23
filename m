Return-Path: <linux-kernel+bounces-155736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 357E18AF658
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2D04B28D6E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD3213E418;
	Tue, 23 Apr 2024 18:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Ar4tXe3X"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2079.outbound.protection.outlook.com [40.107.113.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E21C339A8;
	Tue, 23 Apr 2024 18:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895932; cv=fail; b=oP4xerFkxTMJK3toYiVBhnaMVnT4Ql1b2qEf4GsAwpm90QhLqLd7ZE6o2VEvYs/pdfgOmLfdq1TBWQP9ejITEJfakFOLrLcy4jFgHJJ2jVeyx6T2ENa2faiVQ2UTqiN42ENV9Ub7iSLIJvqKjFIWBHpT4g9swz3xmsLlFA27xSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895932; c=relaxed/simple;
	bh=OvEVciFZHCMOheJg4n48POdUNK6osmE3oZShnp38DL4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qQIQk/jkeoMeBvfCHBvn5kvPU+lRyIpa64CX1K3MBwjCGN0x3V5waFV26qkygTRI3xM6Q2vw9St3Shroh38Rnz0nUgZ8aNusChWirfGlJq9JphvztZcUJgS9dDrlrs5cSuqxe3O0MHGh2KXFhfTsoVEAz/ePOijU2FxBkHhomXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Ar4tXe3X; arc=fail smtp.client-ip=40.107.113.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAz/Li8Q6P+RjGJJn6DfikyUVeSeOxKe8BXoaGLEwLB05wS3EcWUmZLaeajAaSS9USfy7KsoeJ7HQj4RlOEGuht9hweruFY1YsGmICG1GZuIm+uqAiuk5BoEGLDEGvKbd/DjJhPmiM4SurDEikocadjCnPJVPzT9r2Y8KNaDjasXbXl4bfGuaqqP/dlpwIbLhEdx1kJ1PhWR/GtJSSu32JPJ7mFt2q1D1e7hztt8jOo9dAzedir2YvaJaR+zSdzNepVG/RSA1mYVmVXPWMf5YU/DBJLe7Th1HTCRdgN0pkCyFlp2CRubdIuFXN4fltsp1jvmcUmjbKBif44PxhF41g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSFyIlWUGQ0awISiZJrv30IST7mCpfqjWqba7JGOiiw=;
 b=dJOs0GrnTtUsJ4wBF6T+Ii6vyeAVDpSE37fx2w4wFgaReTDy+Zjy7B7ykFLxe8deGhgvp12EvCIQ7SLeQAPXrSDgh7ZT6+7TLxaqlsxt2bsGvTEXIphD52VmxOKfReATc5fKl7WairKtMrnrBBc/kwGuvBtHNCWxQTwtXCKMRK98rHwDxeJCjgMSYo3Rty3WfpdipF8drGXD4HRabUiQ9aaisysCiNXt8M0qiDC4M/aBR1oYYCVSrkKypuWjxE7kiL/3vFeHqoioMBvdRPyIzNZOR3gmcJv5OZL50OC8uv/PIKsThOf+m4sECEkA07O8HZtjSsXks8h4rdibe4H8SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSFyIlWUGQ0awISiZJrv30IST7mCpfqjWqba7JGOiiw=;
 b=Ar4tXe3XBsjO/20tn9+sB5WBIC2jb/yS9dwkRSeDZqdmha04jNfqLRILJ/j5mh9kw/9vQ5AsBboyd7X86apxNMM/M2gXSw+jjRan+PLqgw9gR05kNu9fbF6M+qLkLiAFZXZbvNF4wqJ2eKOFAEG4sSxlL++OMuu0u1p24nrhEs8=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYWPR01MB9647.jpnprd01.prod.outlook.com (2603:1096:400:1a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Tue, 23 Apr
 2024 18:12:05 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::500e:ab62:e02b:994e]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::500e:ab62:e02b:994e%4]) with mapi id 15.20.7386.025; Tue, 23 Apr 2024
 18:12:05 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Prabhakar <prabhakar.csengg@gmail.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
CC: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Fabrizio
 Castro <fabrizio.castro.jz@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v2 06/13] pinctrl: renesas: pinctrl-rzg2l: Add function
 pointers for locking/unlocking the PFC register
Thread-Topic: [PATCH v2 06/13] pinctrl: renesas: pinctrl-rzg2l: Add function
 pointers for locking/unlocking the PFC register
Thread-Index: AQHalaf6G0YP7y+cRUaeSOrsRROeYLF2Jw2Q
Date: Tue, 23 Apr 2024 18:12:05 +0000
Message-ID:
 <TY3PR01MB113461F28EA97F494D831267C86112@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240423175900.702640-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240423175900.702640-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240423175900.702640-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYWPR01MB9647:EE_
x-ms-office365-filtering-correlation-id: bbb5b7ea-3011-4c72-ff39-08dc63c0e1fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3lWJPRFdohNmQ7YsEhWGCDP7ECJVxqkm/pI5muHIdrU9xkmI+r2uAjQkvjej?=
 =?us-ascii?Q?mbqJ2m7mgZ3ZPzqiPzRwDMGRbMcpa8dsUCoBRX9R9+9o2iamKe/K3MBEAOo/?=
 =?us-ascii?Q?KpYXX32H4RTB3TQJb41b7bd8kfAIdXgFSfo76q8nxKXBJmd/4oTJf905+WKT?=
 =?us-ascii?Q?qpxtGhmvOQIJl4vnQYqR3RSFJFLhecuctNKcfJuI/sKp/4TU4khaWXOZVlW7?=
 =?us-ascii?Q?X8qrfhGfx3MDg/n2uYzMV0/KmlgPJMmhC5MX4kzRFYH5uhwuvo7VyXT2HH44?=
 =?us-ascii?Q?0zWazRcjLViU3nueVsn0RdsSdYlkB/HFUv6sf78yoxo/daY83VUuFuAjZIJ/?=
 =?us-ascii?Q?rKzkXGxYTlHs+OEcFnV82GLVmR4GSigx91c30QBra0UUffNNg7agHxq5osnG?=
 =?us-ascii?Q?I3r4Av5x6znt02A5r0iTgJ+Q67AR7vVS7/4e0sw4cWT0HUgfOQlBJZJ3f3Zt?=
 =?us-ascii?Q?4O5L6sUZhGAciDVDIIYNQM8TBmLw0DoGCmqd0+1vQyXWEPGb9ONAK5K+W81z?=
 =?us-ascii?Q?7q+t79rtAi8V67jnT+htChpEdCRE0c3w2JOwW4WnvwMuQ3sdFW9y670UjHJ+?=
 =?us-ascii?Q?RzQkHc7BCdjaEjt14/JVzw5T7spOZt5KujBtkDCgE7l1gN1ykSdFd7xDiOcD?=
 =?us-ascii?Q?KGJ5/MboO7hVEIW8Ol4dEyO/+FxDm5LxJ4dyX1ofX8BP9lEujeRMQSC3P/sS?=
 =?us-ascii?Q?r9K4JvBV1dunR/+l2pEWBK4HDeF6SnJ9Xt11uKVgG6+mAnbjryavWHTeqMSA?=
 =?us-ascii?Q?Sit0sUOaS/CK2gJuyVHtCczKDBpB3eKRPW0kbEKR0qCmBdWvWZd+7Gjdf06y?=
 =?us-ascii?Q?W6b8ZLg9UDQ6f9scFb8jv9tnr+L+AB0PH68pPPCEOvo8nDG2d8rKv2/FyZGG?=
 =?us-ascii?Q?qvgX3q4vtbZOYKsIqnapKcqcB53SnCP4NQ4QgR3ODkgjfLhrFIkaSynksTAT?=
 =?us-ascii?Q?CXew/DBzeAsxj3px3ajFKawZdMSroAFSC5MBp3o5TfShGMpioMLLXafbPx+3?=
 =?us-ascii?Q?aOVl+pGE0AYQr/5BmDR0nSjs+lmiJmOhdRXhVgAm2hNHl1GcGnFyMz7Qdmvm?=
 =?us-ascii?Q?9HSv8ZzrXyFi059HeZQSWiHUpRCWleJvfm3f2vpzdLXQV5llPuNyyuvefRoz?=
 =?us-ascii?Q?OEPHECSgO55+K1X4WLA/JeI8q986OB3zbDiTsUgVk92hH5jRbeL3EK6lUwiu?=
 =?us-ascii?Q?VyvvfRB3lFJgM8LWYVJKT60kQLWqvl6Lvp1xMSk/MzD6H05evAVaMF7dSALA?=
 =?us-ascii?Q?Sq+bnSCFhMoVC+058eUUiPchYz1Neeupq4HkiC3hnlMZDSw6cdDpTDptgXE8?=
 =?us-ascii?Q?V2LKjrXV0z7Q5BFYY0AfzS9ysI6Aiooxi6QNR5PA+9PnuA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YEamZ/roFgcv6LN8rde+vx9ZAEt4j9MuXc8buNPeJkY+M+6ND0ksgO7krf60?=
 =?us-ascii?Q?gnATyQEVfWVqlsRPXQfUzYTymKytQlN7sfyFARKlwKgQdvg6E3ejgqwsTnzU?=
 =?us-ascii?Q?tlWkB9sAub6lhk18SdTVg3KiCQgquGZ3djy4ZCwGQyqGhnxY5UPXuVVv4WAS?=
 =?us-ascii?Q?7JdSGmsbFjsSqayWktW0N/ftqakVnZFdW4FUT/auxHzaD+id/pkr2KRyvYqx?=
 =?us-ascii?Q?6nouw3OgtVdOV0tquMxTGKQd+NRbMHMcr9FfnXGumwhKOkmWP0Z6+6/6XOKC?=
 =?us-ascii?Q?6dKyt/KCq9l12TkGhNuhIzkIFcURYdhLTAvK6Nlc133jAvBIBi33e/rRNqQz?=
 =?us-ascii?Q?u1wN5tPvEb7AhQwrW1U9R5bHJExRJKzwFBVweciFdt+bXWpDkICw6BSxm7tD?=
 =?us-ascii?Q?vP9sePPuy40ffDYAP3U+1v+QYKgAfL2LffH+ErgUEC/pjTFG//cdUpHQkser?=
 =?us-ascii?Q?eI1Z7xJn4Wu6KFoGTVnHCPZg3/pTEg43ottKxCHGH9GH4wzQgLhuEqLiIXdv?=
 =?us-ascii?Q?lUB0KDRVKO4mT25XWAEGaBPLprsJlSF9IkHCubQzTqdfQ+kOJSYDy8ZjntUC?=
 =?us-ascii?Q?lfWLKblseiw4iaz9nm1ROsA4It8E0GJW/jFV8DDI0Df5OYDm/BCWjWIXnWDt?=
 =?us-ascii?Q?lWV88cMNf+Akl7j9IdCC+RVC9YHF9cbUQsf+81Kd+c8NZ9fPWWdDpbC9ak6X?=
 =?us-ascii?Q?mBiIWNxw0Kx+tEBX6jSNyZntCaUKLzDf3tReC8AkLYyMx1JBv4/WdKaQtNeU?=
 =?us-ascii?Q?7+1iznOG3L8gmB9F6D2W2fpEXl/GjH3Rrykybw/mbDORIp1XtwLMT7+CaChg?=
 =?us-ascii?Q?Mj01zj5/mXWYhbV7BqRqHXk4Xie7fYWITQhEFRcuHPT8DB2wKJmvkqWoTwUz?=
 =?us-ascii?Q?YxDQSrrS2vxB8ycj/ZoZO72vTOsuqZhxT/bejAv8ZxCVbcLUyd1L1mo3cC/T?=
 =?us-ascii?Q?Ov550qhhe7Xxtpf727LbZIPPggMaJxzzisH7G1sgY5SpM2CvRAv8iJOUts64?=
 =?us-ascii?Q?RQIallAXeVnzFWxespD/bQgadNumgThO4OWJtNday9t/ecpeiNm7Eaqdppyc?=
 =?us-ascii?Q?cVqCg4097rWMhkM2LVVyV40VZ7YzOUA5Uf81w0UfXBoj+kpvVKtb+SP/GVw4?=
 =?us-ascii?Q?JovcbVE4VNgR4S+LBxHc9JFWoCcxpOBJ37NOHhJbiDS9rqoAJq4+guHLPYxA?=
 =?us-ascii?Q?N7RhihhTXsNmUqfhmfBrKFmiQ87G/6nmXKTOHdPQW6vEKQBkqPdqfKyOLSIC?=
 =?us-ascii?Q?KBD4WhjvMw3KxSB6HqwN6A8+Qr2UHfWZjayLAPkCX73fnZzES5ttllpohkRU?=
 =?us-ascii?Q?YnioQWwkRuespg/V/vT0mTRPIufnFm+0PWFpeuJ8OflhWIqOfIDwGTOpa8qN?=
 =?us-ascii?Q?EDo6sBJ5ARAg+lzO5dZH/GpxNI6GejKtQlKTGppapHi5B+kcVZgCieHoCCTu?=
 =?us-ascii?Q?ep9fJry93bpXiJSZI/EUgz9BzB5YGeuKibZKnpv/vhI7B/WMKe31/I/Wlo9e?=
 =?us-ascii?Q?UdqVJVpa0VbJblQV8dIKZqGvBi7ATLgP9WAO6uvdq4FOXH8Ar3wZy/6iYXDj?=
 =?us-ascii?Q?ehzZdREkUEr3g4TNP+ELCZN+EiR0pMm4d6Jl2hCFYjNIIhTG2uRmLyPRlFe2?=
 =?us-ascii?Q?aw=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb5b7ea-3011-4c72-ff39-08dc63c0e1fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 18:12:05.5522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Q8oLDJLir1kbOA8IsKrzlW983ZP6ysSs7Ph5m/qOvXZR1hbAwC12rES7rlsNOaV4NHdxP99UXikkahvHisAFGf/PNBIYPUhg6nGSIHU5qw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9647

Hi Prabhakar,

Thanks for the patch.

> -----Original Message-----
> From: Prabhakar <prabhakar.csengg@gmail.com>
> Sent: Tuesday, April 23, 2024 6:59 PM
> Subject: [PATCH v2 06/13] pinctrl: renesas: pinctrl-rzg2l: Add function p=
ointers for
> locking/unlocking the PFC register
>=20
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> On the RZ/G2L SoC, the PFCWE bit controls writing to PFC registers.
> However, on the RZ/V2H(P) SoC, the PFCWE (REGWE_A on RZ/V2H) bit controls=
 writing to both PFC and
> PMC registers. Additionally, BIT(7) B0WI is undocumented for the PWPR reg=
ister on RZ/V2H(P) SoC. To
> accommodate these differences across SoC variants, introduce the set_pfc_=
mode() and
> pm_set_pfc() function pointers.
>=20
> Note, in rzg2l_pinctrl_set_pfc_mode() the pwpr_pfc_unlock() call is now c=
alled before PMC
> read/write and pwpr_pfc_lock() call is now called after PMC read/write th=
is is to keep changes
> minimal for RZ/V2H(P).
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> RFC->v2
> - Introduced function pointer for (un)lock
> ---
>  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 51 ++++++++++++++++---------
>  1 file changed, 34 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/re=
nesas/pinctrl-rzg2l.c
> index bec4685b4681..0840fda7ca69 100644
> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -246,6 +246,8 @@ struct rzg2l_variable_pin_cfg {
>  	u64 pin:3;
>  };
>=20
> +struct rzg2l_pinctrl;
> +
>  struct rzg2l_pinctrl_data {
>  	const char * const *port_pins;
>  	const u64 *port_pin_configs;
> @@ -256,6 +258,8 @@ struct rzg2l_pinctrl_data {
>  	const struct rzg2l_hwcfg *hwcfg;
>  	const struct rzg2l_variable_pin_cfg *variable_pin_cfg;
>  	unsigned int n_variable_pin_cfg;
> +	void (*pwpr_pfc_unlock)(struct rzg2l_pinctrl *pctrl);
> +	void (*pwpr_pfc_lock)(struct rzg2l_pinctrl *pctrl);
>  };
>=20
>  /**
> @@ -462,7 +466,6 @@ static const struct rzg2l_variable_pin_cfg r9a07g043f=
_variable_pin_cfg[] =3D
> {  static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
>  				       u8 pin, u8 off, u8 func)
>  {
> -	const struct rzg2l_register_offsets *regs =3D &pctrl->data->hwcfg->regs=
;
>  	unsigned long flags;
>  	u32 reg;
>=20
> @@ -473,27 +476,23 @@ static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l=
_pinctrl *pctrl,
>  	reg &=3D ~(PM_MASK << (pin * 2));
>  	writew(reg, pctrl->base + PM(off));
>=20
> +	pctrl->data->pwpr_pfc_unlock(pctrl);
> +
>  	/* Temporarily switch to GPIO mode with PMC register */
>  	reg =3D readb(pctrl->base + PMC(off));
>  	writeb(reg & ~BIT(pin), pctrl->base + PMC(off));
>=20
> -	/* Set the PWPR register to allow PFC register to write */
> -	writel(0x0, pctrl->base + regs->pwpr);		/* B0WI=3D0, PFCWE=3D0 */
> -	writel(PWPR_PFCWE, pctrl->base + regs->pwpr);	/* B0WI=3D0, PFCWE=3D1 */
> -
>  	/* Select Pin function mode with PFC register */
>  	reg =3D readl(pctrl->base + PFC(off));
>  	reg &=3D ~(PFC_MASK << (pin * 4));
>  	writel(reg | (func << (pin * 4)), pctrl->base + PFC(off));
>=20
> -	/* Set the PWPR register to be write-protected */
> -	writel(0x0, pctrl->base + regs->pwpr);		/* B0WI=3D0, PFCWE=3D0 */
> -	writel(PWPR_B0WI, pctrl->base + regs->pwpr);	/* B0WI=3D1, PFCWE=3D0 */
> -
>  	/* Switch to Peripheral pin function with PMC register */
>  	reg =3D readb(pctrl->base + PMC(off));
>  	writeb(reg | BIT(pin), pctrl->base + PMC(off));
>=20
> +	pctrl->data->pwpr_pfc_lock(pctrl);
> +
>  	spin_unlock_irqrestore(&pctrl->lock, flags);  };
>=20
> @@ -2519,12 +2518,8 @@ static void rzg2l_pinctrl_pm_setup_dedicated_regs(=
struct rzg2l_pinctrl
> *pctrl, b  static void rzg2l_pinctrl_pm_setup_pfc(struct rzg2l_pinctrl *p=
ctrl)  {
>  	u32 nports =3D pctrl->data->n_port_pins / RZG2L_PINS_PER_PORT;
> -	const struct rzg2l_hwcfg *hwcfg =3D pctrl->data->hwcfg;
> -	const struct rzg2l_register_offsets *regs =3D &hwcfg->regs;
>=20
> -	/* Set the PWPR register to allow PFC register to write. */
> -	writel(0x0, pctrl->base + regs->pwpr);		/* B0WI=3D0, PFCWE=3D0 */
> -	writel(PWPR_PFCWE, pctrl->base + regs->pwpr);	/* B0WI=3D0, PFCWE=3D1 */
> +	pctrl->data->pwpr_pfc_unlock(pctrl);
>=20
>  	/* Restore port registers. */
>  	for (u32 port =3D 0; port < nports; port++) { @@ -2567,9 +2562,7 @@ sta=
tic void
> rzg2l_pinctrl_pm_setup_pfc(struct rzg2l_pinctrl *pctrl)
>  		}
>  	}
>=20
> -	/* Set the PWPR register to be write-protected. */
> -	writel(0x0, pctrl->base + regs->pwpr);		/* B0WI=3D0, PFCWE=3D0 */
> -	writel(PWPR_B0WI, pctrl->base + regs->pwpr);	/* B0WI=3D1, PFCWE=3D0 */
> +	pctrl->data->pwpr_pfc_lock(pctrl);
>  }
>=20
>  static int rzg2l_pinctrl_suspend_noirq(struct device *dev) @@ -2631,6 +2=
624,24 @@ static int
> rzg2l_pinctrl_resume_noirq(struct device *dev)
>  	return 0;
>  }
>=20
> +static void rzg2l_pwpr_pfc_unlock(struct rzg2l_pinctrl *pctrl) {
> +	const struct rzg2l_register_offsets *regs =3D &pctrl->data->hwcfg->regs=
;
> +
> +	/* Set the PWPR register to allow PFC register to write */
> +	writel(0x0, pctrl->base + regs->pwpr);		/* B0WI=3D0, PFCWE=3D0 */
> +	writel(PWPR_PFCWE, pctrl->base + regs->pwpr);	/* B0WI=3D0, PFCWE=3D1 */
> +}
> +
> +static void rzg2l_pwpr_pfc_lock(struct rzg2l_pinctrl *pctrl) {
> +	const struct rzg2l_register_offsets *regs =3D &pctrl->data->hwcfg->regs=
;
> +
> +	/* Set the PWPR register to be write-protected */
> +	writel(0x0, pctrl->base + regs->pwpr);		/* B0WI=3D0, PFCWE=3D0 */
> +	writel(PWPR_B0WI, pctrl->base + regs->pwpr);	/* B0WI=3D1, PFCWE=3D0 */
> +}
> +
>  static const struct rzg2l_hwcfg rzg2l_hwcfg =3D {
>  	.regs =3D {
>  		.pwpr =3D 0x3014,
> @@ -2688,6 +2699,8 @@ static struct rzg2l_pinctrl_data r9a07g043_data =3D=
 {
>  	.variable_pin_cfg =3D r9a07g043f_variable_pin_cfg,
>  	.n_variable_pin_cfg =3D ARRAY_SIZE(r9a07g043f_variable_pin_cfg),
>  #endif
> +	.pwpr_pfc_unlock =3D &rzg2l_pwpr_pfc_unlock,
> +	.pwpr_pfc_lock =3D &rzg2l_pwpr_pfc_lock,
>  };
>=20
>  static struct rzg2l_pinctrl_data r9a07g044_data =3D { @@ -2699,6 +2712,8=
 @@ static struct
> rzg2l_pinctrl_data r9a07g044_data =3D {
>  	.n_dedicated_pins =3D ARRAY_SIZE(rzg2l_dedicated_pins.common) +
>  		ARRAY_SIZE(rzg2l_dedicated_pins.rzg2l_pins),
>  	.hwcfg =3D &rzg2l_hwcfg,
> +	.pwpr_pfc_unlock =3D &rzg2l_pwpr_pfc_unlock,
> +	.pwpr_pfc_lock =3D &rzg2l_pwpr_pfc_lock,
>  };
>=20
>  static struct rzg2l_pinctrl_data r9a08g045_data =3D { @@ -2709,6 +2724,8=
 @@ static struct
> rzg2l_pinctrl_data r9a08g045_data =3D {
>  	.n_port_pins =3D ARRAY_SIZE(r9a08g045_gpio_configs) * RZG2L_PINS_PER_PO=
RT,
>  	.n_dedicated_pins =3D ARRAY_SIZE(rzg3s_dedicated_pins),
>  	.hwcfg =3D &rzg3s_hwcfg,
> +	.pwpr_pfc_unlock =3D &rzg2l_pwpr_pfc_unlock,
> +	.pwpr_pfc_lock =3D &rzg2l_pwpr_pfc_lock,

Some memory can be saved by avoiding duplication of data by using
a single pointer for structure containing function pointers??

struct rzg2l_pinctrl_fns {
	void (*pwpr_pfc_unlock)(struct rzg2l_pinctrl *pctrl);
	void (*pwpr_pfc_lock)(struct rzg2l_pinctrl *pctrl);
}

Cheers,
Biju

>  };
>=20
>  static const struct of_device_id rzg2l_pinctrl_of_table[] =3D {
> --
> 2.34.1


