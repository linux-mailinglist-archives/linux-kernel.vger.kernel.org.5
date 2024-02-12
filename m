Return-Path: <linux-kernel+bounces-62316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9476A851E74
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C376B266FB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAF4495E5;
	Mon, 12 Feb 2024 20:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Yf6lvyVy"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2052.outbound.protection.outlook.com [40.107.114.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F7648781;
	Mon, 12 Feb 2024 20:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707768549; cv=fail; b=XQV2IGrOj1KpZLUjPrsyk08FdIDHSiwGBbQyriWESEQgWxyRqakJcOzi8x41PqQI3in4l2Bd2po/btQlpjxJ1iV+A+Vmk1/nytbAlWyemBhD1o1Jxd8XKiCcR2un+IN6Az3eWl8Eb2/Ts5zeFUunYmR7Qv9zF6aFooqlvV/ImD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707768549; c=relaxed/simple;
	bh=+kBsPFZGPIzBzk6351SgiFIwIbzcbQpMKnZDwBSnp/8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VB14Q//Ozkb/7J9Czf5GEMipQvbJSqqEFLnOcDomlTwPXFOh+1Jj/Bw/RPwAUVvG6oXegDAdEK1yWXCsujnhOx+ZjRSinYRfdHsXhit1UlJTVrj6qUc/mWAvJ/w29L+VAeuNATN/x+tFkg/rXFzjUxg6VxLNHMc/jtFTKM+oyd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Yf6lvyVy; arc=fail smtp.client-ip=40.107.114.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1yLWAI+IwF45Dtp/zub8iBwEBkZwRAv64UnQNZV2AWhE0gjTrJ9Wd0wX/oXH9WISWZOKd+Cdeb0I/nYDjBMaZAotX9AjOxIHPCk4B5dWTtd5FK0Kw4KTECKUMZEMADzGDLKwQZa62ajicZAQrX1wCyNf8HnUOpjuLdxp4337ZA6F6MsSMyWyJJNS44AEnSKDo7bDVp/rM1ReY4NQqx/+8vpNjZypHBTbRUjwk0PjbZGr/GMJdUyigt73ZnlF2FjS3gPzcuuFJ7BLYPMG+Gn9F+FVLyH/PSzlabLQ80XXlH3yKpg66dDwF/CPTX5e2vD5qSpgJeCR4JucL9UcnSD4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5n9Jldo+t6z7HIeJbRpnreWGyxxGDEhffmNMfR9w6s=;
 b=c+7F1+gA2FRZx4G83RCwPfyv06HZaz9Dn9TR9gduzMLpVKsI/A5uiTVoU2+eMFGu3JKZlL0IRSvEsItsUXrzq5vvzgLtv+Zdr7lcUa599v5fmIUB+SnZNGJLRp7Flubu0TWhznGn5FAPn9Qy1/K08aPnPqjukNTvTfS0MomGO1+OfjsEnIwH+bWhAeJq2d2KHQ5w7/ZwBU4D86o08RkEEz4rzP8+F23CuKaaRsiTztqchx2Mqu3TYDZiBSKkBBy6NoViYFG3vWZusypwhGcLAaJqRzP6g3xh0UGFWrCzJFgHOFR0XA0otyJJgO/0g3FtFaCRLPETkZkQQJwLD8sbmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5n9Jldo+t6z7HIeJbRpnreWGyxxGDEhffmNMfR9w6s=;
 b=Yf6lvyVyaD942Va2AZdhq9IiOIQEoTOydSorDBGmSk+oAQTqpDFrpGcL5z9Lw9mKIQNMcbuPKgqDHYH5gif46g0HHoQ35gZYUvdPGyLgtu5Ujq/3g/dENsA8pG2y85P2syQRKZGI7jbcfwgKShNRqS7QrBdnAUSSusZ5lVAkqcM=
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com (2603:1096:400:448::7)
 by OS7PR01MB11452.jpnprd01.prod.outlook.com (2603:1096:604:243::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Mon, 12 Feb
 2024 20:09:02 +0000
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::fb0a:e289:43e:1c17]) by TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::fb0a:e289:43e:1c17%6]) with mapi id 15.20.7270.036; Mon, 12 Feb 2024
 20:09:02 +0000
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
CC: Philipp Zabel <p.zabel@pengutronix.de>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Biju Das <biju.das.jz@bp.renesas.com>, Magnus Damm
	<magnus.damm@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v6 2/4] pwm: Add support for RZ/V2M PWM driver
Thread-Topic: [PATCH v6 2/4] pwm: Add support for RZ/V2M PWM driver
Thread-Index: AQHaWuYI/v4KlwHV40Gk2x8URHJzn7ED1uOAgAMC8wA=
Date: Mon, 12 Feb 2024 20:09:02 +0000
Message-ID:
 <TYCPR01MB120934E8A094DD3185573B9C9C2482@TYCPR01MB12093.jpnprd01.prod.outlook.com>
References: <20240208232411.316936-1-fabrizio.castro.jz@renesas.com>
 <20240208232411.316936-3-fabrizio.castro.jz@renesas.com>
 <vovrjoymovpjzz2myx73ns4zvbqyfw6twzvjhuyruogmcqvj4y@g2at4kznmqxh>
In-Reply-To: <vovrjoymovpjzz2myx73ns4zvbqyfw6twzvjhuyruogmcqvj4y@g2at4kznmqxh>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB12093:EE_|OS7PR01MB11452:EE_
x-ms-office365-filtering-correlation-id: 60a040a3-bcc8-408d-8871-08dc2c0674f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 kEtlk8bOpVzXpmn05NpcIunc+FO0xJxedI8BXitVhMpK6WaJWuIxYCrW67y0M2R3dl6/IJAVwzDt2dehpywfwMmUNiCsVledC/LxHcaAF5UdpE2EJZgxe+/3VbXt4yrV6nrfNEx5c8wtPkh6PJq/tdVH4Rha7Lsjm+hBwmlyC7sTOWPZc8EEhWjSCbXsKq8AYRSfCUVXrjazxsRFTk0iCSFRE8VmudGHEWZXVTrb+A0rP8bK5bVGkwrAzCFEIGNa9FVjV5oLI9S10ys1A6pYdMx8JYx4ZbwWQdaIuTiq+Vj25QIn4sQ3C1NMpCYQ3fYMfJbOG6xajzck3SdjTvyfhM9Im6MGDT2JQ1f+JGY2l9VX93t04nqQVKurZHfk2NsrJLRDOdE/8LSSReckz8KfEXzWeUvwAOlSaVc3MDSJorrgE8M/NG0aKz1eyY7jGmF/iwnhf1kPtDNbTOWI7Klx4wk1rTbBp2wAxfPCTO4sSmS2QmpPYxdvHjU4BVh+p//JnDTC8S1qwDNB8KhV08O8fxKrdo16+gQVjCs2UR0CZK/pUlfGNUyYl3ZA927uAm/XwDlVRx4duzO+xv4YkI//k8IeQk/9zoQt9Kd3lZdU8bM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB12093.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(39860400002)(376002)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(86362001)(33656002)(122000001)(38100700002)(6506007)(966005)(9686003)(7696005)(53546011)(316002)(478600001)(54906003)(71200400001)(66574015)(26005)(83380400001)(41300700001)(38070700009)(4326008)(55016003)(2906002)(8936002)(6916009)(8676002)(66946007)(52536014)(64756008)(66446008)(66476007)(66556008)(5660300002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Q6MQfjyEDPrAnkquwU7GJJCBvz+MEWvlnRacNu5KKcQhNIOrMfAu3VQ2Qf?=
 =?iso-8859-1?Q?AjVxoPO0zdmIrejl5y4Ww3zTUBK00s4P9ACDXN97X0Mtv8406Aa1czJnlC?=
 =?iso-8859-1?Q?ajzBfS3hFmr7sfMyhB89+lpm3rXiL7te9TU/JNEqrH4XIc6eJkTJMOfck8?=
 =?iso-8859-1?Q?iEikDkZR1vV+NibIQMtwFeH/fmuvAj/7bNDXSQ3IzIIKN8Dg+UccNcYFqC?=
 =?iso-8859-1?Q?x2phKAYLKYKu5ww8C0PyoXQx+PNvFVG30ehWKZ8bDgcMBciX/Vpg5ImnKo?=
 =?iso-8859-1?Q?fV6HJysYI8WXLZRWv9qaIaZ1Ijrutv6y823/IjpiwAPxclY8yHdpis6+47?=
 =?iso-8859-1?Q?YJ11AW3Vn5w4/762P81/VgghIP1FRnE5f0xIwFLM3MCiZX77Oiguf1wL8E?=
 =?iso-8859-1?Q?EcRpGvAOxn7Qco4q0ioXGAnCFx9lh2TfhMANMUPGxXg58SIXPdHAy75e0i?=
 =?iso-8859-1?Q?FKLRn9C7Qf18XTsnU4yOwyXoFBZMl7GcxrZyZQg0tWtEthjwX6I5bFCUia?=
 =?iso-8859-1?Q?dmdyWKV4sZdH7L4pcLqG8NinDI10uBTEVX7LTezo0DWavT1wgcp3nuMzl0?=
 =?iso-8859-1?Q?vAjaZtR4ieVunu2R5+pwTE11xmMiTlFIOLx0T37riHfwWVtR3DiCRqOBIp?=
 =?iso-8859-1?Q?D5VLgbBZpTFyCe2x4ov6tiiGdSl2o7NsgSkJO/jREYktXey3j9m0h54EDU?=
 =?iso-8859-1?Q?W9gLdm25tu7y+2/xRvL4kenTOcLjoFuEuMMYnfZ4itQ4S0FjIWlLf4qm1R?=
 =?iso-8859-1?Q?IQ+0qXkztel26qKTMqPYumFi5YzG389H0WKtq4U/yR9Vd47ICE9Tm2+TrM?=
 =?iso-8859-1?Q?wjEVHtY/R+C4Ioc+CqZfFKWWHhHlcBdzcMYT6CpiGHRnSbNNw4MUPW9P7t?=
 =?iso-8859-1?Q?zEKeR6d3FFaJ/4ndZ5m1VTCfHQn42a0ds5pLKbbEISLoGucpDkPgEbBo7w?=
 =?iso-8859-1?Q?ok6u6XFT6hP0a3Cz3BO2p+LKZIzPr6Antc0trxi4u1AVQsF8jo0PnIlkj/?=
 =?iso-8859-1?Q?4hlgzCYJUrIp9Ygtm8NCUZkMTh2UbdeaqH1MIK3g/Nkg1XgvZMy8n/pPAn?=
 =?iso-8859-1?Q?qC3VJ/jGcnXXw8uVqT4URlSMWuA1IATFSKh3U62uvDuOa70ZABE75CBbeH?=
 =?iso-8859-1?Q?KOyNMG787JrGeSTQmXK0QwOo56oeBsxrSqvO7JCmEVAS2ApHZZ0vqKNDP0?=
 =?iso-8859-1?Q?7plH2xhhSA3w/dVOOfK2prX9ReNZmcw/Ivvi7Y/5VvbpovWo54F/U3hvcJ?=
 =?iso-8859-1?Q?wLw+LbSnV/b/lH7+mXdSf5X1mNLrwCnpZ1xiTYd+oSc4dI41xA3ndSpPqT?=
 =?iso-8859-1?Q?RT/pDPGve/LoNbYqq1Y8U0W51ck3HDEkSYOknq1i2hZcL2I7lWvw3Xs6KO?=
 =?iso-8859-1?Q?buB5pygU+a3dnJXmVi3/Ri+RNvS6Qx++beaU2nfEUwUGe6lx//5AEpvosQ?=
 =?iso-8859-1?Q?wSymn5ksCjd6QU94dZMoW0VuORja84r1k2hxo/UoDexYvd+9fgF/1XFYSJ?=
 =?iso-8859-1?Q?h9alwrGx7I1uLBOGceWKhQwBoajawZBnq4BrLC8y9UhqqJ5DNHV5QMmBaa?=
 =?iso-8859-1?Q?L2fhjLZqHTTrP399pujZa6E0ZmExxj2dSqTSpwRfaCa7e3wmndO8DqqCSf?=
 =?iso-8859-1?Q?NRyJScNPt7vguElGeIfiuidJe0rK0bPKmgJSDcqqiBa8VZL7vpUAYSRA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB12093.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a040a3-bcc8-408d-8871-08dc2c0674f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2024 20:09:02.3296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gK+w4dXBTejgI66J1AhZZbEJE/QxYSl0Xca7kk2/GumWJrdnfy/8D3QqOy8lBdj3FgXIdaC9woIr3beIaNCu00o3xHrqOIKXhPVvVeo9s74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11452

Hello Uwe,

Thanks for your reply!

> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Sent: Saturday, February 10, 2024 5:27 PM
> To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Subject: Re: [PATCH v6 2/4] pwm: Add support for RZ/V2M PWM driver
>=20
> Hello Fabrizio,
>=20
> On Thu, Feb 08, 2024 at 11:24:09PM +0000, Fabrizio Castro wrote:
> > +static inline u64 rzv2m_pwm_mul_u64_u64_div_u64_roundup(u64 a, u64 b,
> u64 c)
> > +{
> > +	u64 ab =3D a * b;
>=20
> This might overflow.

In the context of this driver, this cannot overflow.
The 2 formulas the above is needed for are:
1) period =3D (cyc + 1)*(NSEC_PER_SEC * frequency_divisor)/rate
2) duty_cycle =3D (cyc + 1 - low)*(NSEC_PER_SEC * frequency_divisor)/rate

With respect to 1), the dividend overflows when period * rate also
overflows (its product is calculated in rzv2m_pwm_config).
However, limiting the period to a maximum value of U64_MAX / rate
prevents the calculations from overflowing (in both directions, from period=
 to cyc, and from cyc to period). v6 uses max_period for this.
The situation for 2) is very similar to 1), with duty_cycle<=3Dperiod,
therefore limiting period to a max value (and clamping the duty cycle
accordingly) will ensure that the calculation for duty_cycle won't
overflow, either.

>=20
> > +	return ab / c + (ab % c ? 1 : 0);
>=20
> This division triggered the kernel build bot error. If you want to
> divide a u64, you must not use /.

Right!
I have replicated the problem locally, and confirmed that also other divisi=
ons from the same patch are problematic.
Clearly, % can't work either.

I am going to replace / with div64_u64.
For rounding up, I think I'll go with something like:

u64 ab =3D a * b;
u64 d =3D div64_u64(ab, c);
u64 e =3D d * c;
return d + ((ab - e) ? 1 : 0);

I am aware that I could use DIV64_U64_ROUND_UP instead of the above,
however, the above allows for larger dividends than when using DIV64_U64_RO=
UND_UP.
If I were to use DIV64_U64_ROUND_UP instead, I would have to limit
max_period further to (U64_MAX + 1 - rate)/rate, which I rather avoid.

I'll send v7 to address this build issue for 32 bit platforms.

Cheers,
Fab

>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

