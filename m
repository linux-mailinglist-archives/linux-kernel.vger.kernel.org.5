Return-Path: <linux-kernel+bounces-88525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BD886E2DE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23B4F1C21128
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913786F507;
	Fri,  1 Mar 2024 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="gNftlhNM"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2074.outbound.protection.outlook.com [40.107.114.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ED56EB7D;
	Fri,  1 Mar 2024 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709301439; cv=fail; b=jm2jdcaviNLd++jbFF0vYtNigcG1kxhnxmQeWvJUYdACiviKWozJP+cbLO5NM5jwZLfRatvuJzL9ZP28/oVQSgVcneaS/C3uNEgTDc8KGRrmnlGammjAyC1Xr5OwKZT7JDsOftw1TwkMljvEyG+Qrm9inLhkzeGfIocD3gRDJjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709301439; c=relaxed/simple;
	bh=JBJQdw/cTHxMrbfMQeahPfMfEcGntXCaF4pXizJbMLU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WjxfPmlyNLaEnoEGHCOdCZ2Sfk1QTHGSvp5MgkWOqCAd7qRZ3dU8GJ+mVQswMg26uNFdWm/UOySPEZ7GE1hDlEA6TPt+i6WIkSjXfhgbyBSV0ee7+hgigvY3RflZkOU2d6zYP74GJhcMjOPBnF4eUHSSPxxPzVGz65eJomGz/e8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=gNftlhNM; arc=fail smtp.client-ip=40.107.114.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/yi4L/WfPMPKKa1PJ+968G3JVVect89HOU7XCVxhnhVZKfLbDLZOj9zita4m8bJ7NgynNyiHlGp8qeQ9rxgtPDq5vkXGuQiNhelfmkcCXTvYwhVGOYevi7R9T4CMFHPVk0WY23OKMgGOurzd5oFlWo29Q1SdIiVSCel5VDsRw49x0jnPlYhV+HSScfbcPQyAyj/AjXsKvUolRjsMmWWLMPlNB/192DJENmGMfblK3dB+9p+hwKmmMS04q0+4fLW5ipQKWLCAvV9D0Vb2Fd5WYorfGx+1a9LyTZYwC8ZqhE0cG98y2OGC0TahP0dcQsITH0VP1MUj8PCKn7jllRDhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWwsdqCNweM105Xy0iggZmidusPHrP0kQolbFHQQbyY=;
 b=HaEnJBiWwbFM0OK8/5E5w2vaP0ZUcqEDHestDs2czWxQ1Lkx+MeRjF3Qi2NsS2TWVAoREKgzNPjI+byyJfEYu3eYYBmTYd/tfv1jqDZysZytEn7TtmGnZBp20WvWE4n9vHTM8LoZMskSxKbXFqA3FdvkFy4mOJxp1zZRPmM+Zp/8BsKKzhxDbqEwNMtX7IqN3Z31/uerHg93uAWtEred9FhKe4NyYotxsrHfREwaS3COTGzgWR0bjccM3ihNDnHiqpqOJZp6yJKNkNvv8B7sRJf7opZIvJY27CKVtgyLiy/ZqDw4qNa6P1Wn/rVapGyqLntp9SMiK63DbGqq84Y/cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWwsdqCNweM105Xy0iggZmidusPHrP0kQolbFHQQbyY=;
 b=gNftlhNMC+EGFwb94bMg28zmhEFKJycxBGMbZ2Gmgi9XqpGNCeJVh4m05o/LlwzAxOZf5h/S4jjt31hjfTTLqaRrBgixGE5n3W004e8cbhJwHiVGeM0RLIjbtmeJrpgA3oaLLE8yVmEu7fnV3Dxni2vGuJKcLu5M+6G2wMmmrbM=
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com (2603:1096:400:448::7)
 by TY3PR01MB10303.jpnprd01.prod.outlook.com (2603:1096:400:1de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 13:57:12 +0000
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::675c:58ac:9054:36c0]) by TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::675c:58ac:9054:36c0%7]) with mapi id 15.20.7339.031; Fri, 1 Mar 2024
 13:57:12 +0000
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
CC: Philipp Zabel <p.zabel@pengutronix.de>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Biju Das <biju.das.jz@bp.renesas.com>, Magnus Damm
	<magnus.damm@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v7 2/4] pwm: Add support for RZ/V2M PWM driver
Thread-Topic: [PATCH v7 2/4] pwm: Add support for RZ/V2M PWM driver
Thread-Index: AQHaXfdzv+U6vrQ6NUaz4vTtuVxRF7EhoJIAgABVclCAAMAFgIAAGf/Q
Date: Fri, 1 Mar 2024 13:57:12 +0000
Message-ID:
 <TYCPR01MB1209349189E2F3085F35DBAE6C25E2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
References: <20240212210652.368680-1-fabrizio.castro.jz@renesas.com>
 <20240212210652.368680-3-fabrizio.castro.jz@renesas.com>
 <wwkzprliai3vge53fcveosfkixmri4hoyfjeulbzoezmaayoci@6hor5uwwdag4>
 <TYCPR01MB12093649FED62A25C3504E4D2C25F2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
 <ugotgpnicccowxv4d6wxc57mgznj4vdodvjplfma5mqxojuiyg@p42i56lx2vqr>
In-Reply-To: <ugotgpnicccowxv4d6wxc57mgznj4vdodvjplfma5mqxojuiyg@p42i56lx2vqr>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB12093:EE_|TY3PR01MB10303:EE_
x-ms-office365-filtering-correlation-id: aec0f93a-8928-49db-b591-08dc39f77ea6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 8loNS9ptc5KjtMiwS0Jv92bIbULVh5OcYSIEe4vTkcP3dNj4mV4Dlazjr5eHCJPY5NFWMA2BfFCs1Aq8Y8mmHNNHiJ9m0LORZLOvO9LpIQsKLGUAHICEgfBKQH0RKksofFPsWcsvMKeSxRoGUdoYejHAMlz8SgZ27Z2s0eVf4wXHipnHS2cf86+jZ8Ix9zRAbpVtZx37/71gBUKXC4etv/dhV1E4pLsmTAx1VDBpE0LoYwpCjF0foDqQJyyzMAvMjzYe6VhgH86Pn7n4AHB+x12OfqAEvWGadG1elpyrlYxeXd5Bt2JS8Uj8VVqX3gc9OQlBYG3OSLR51zSC7lW9DcYfMkYLp4g3HzxeGdLIgRlB5TfzE8q5WjDiTtg0u0kyEpqR8YB46CQfXJUn3mUBGV4g6EW0dvVmPpb2A1ZwGP2SF8Mozr0bd34gcyAMHLQ5yfy9rcnOwfLsBwoeuyOJIL0oMpHji74XhYS0MAPqrF2/5AwlW9vfLIVv4JI8kFNJBwXEEBoOzawqSs9GwrxmjEjPge+IgOo3Ih+2D5NvML0MZjn6hFh+xhgyAQ1GFqv2EIhNsuxEnMX41/Aw8hQNYV540XG5OsFskstdcpCAFNSd3PtFEDq382AIrarisF1v2yHdcZsqLcUSOY2fzc5IKpvA2yZFLyDx3u6dMJodKMk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB12093.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Yk5LKvvDuPiE7wBsDaQzCUoZYI2hCyLFPu0Wl4izzLWQj3QzzQAr31epCQ?=
 =?iso-8859-1?Q?g1zf+2e70mBXitsRszuTN09GDfCPxviiL8YEhdXkQstz4pLnPI3/wj7JOM?=
 =?iso-8859-1?Q?3u35M/MW2k0qqv3UqgJ4z/1dAPjywWbavBWXgy+DmhUn5EbCKk6pOFlns8?=
 =?iso-8859-1?Q?8rePrd4CUZVaWP9S9i31cxa+FYoFVAYEK/M+7sWQqAVuxvSg0oB99t5tYh?=
 =?iso-8859-1?Q?UDcLeQhoXZDf/JRXHnjizg65SyGwOeUPW3p7uqH6Yo1rJ3OaAHjra0fsXj?=
 =?iso-8859-1?Q?U7p4M8G9rkqAD3D+ntHaZUfYgxuu3u8AM0qfbjZ5QzbbuRvYpyLGCccxPw?=
 =?iso-8859-1?Q?Gwl3HRRVSNn3VqEdJ67CtpZhz+IfKN5z+zd2u+IaafMSxPWLetqRopnC90?=
 =?iso-8859-1?Q?G4/tBlsSYFKrXmSmuIPBSVQK7iSXh5RV7C0febHNVkhYyPJPOJzrBqRvst?=
 =?iso-8859-1?Q?Ky4lLtzhUptpJTfDyj9a+Vwx9TqDM6pAddiBQvc3YGfYH3VUBwopK7NCPC?=
 =?iso-8859-1?Q?KfLv/jax/VupfJe2SE4185cQVi1uZCMqpwVwl/MaB3aQGG0VolnqMu9mbs?=
 =?iso-8859-1?Q?FtXnT/3UMpb3m0+AD5byYjvfhAqlvpUgc+LgQIxpVSnVEpDdsN6ms5BxeX?=
 =?iso-8859-1?Q?AH14MKkesjtiq+Px7y/YNYYebGVR+ftbGFtYy4CP1zGUSTW1MstgXEiUOZ?=
 =?iso-8859-1?Q?uc3IIpgyLuV/9CK9pU/4o9y9xqGwaBY5I0u3VW3wWbot6zFRCXGRuuj5/N?=
 =?iso-8859-1?Q?o4Hahambpa2k4EiwQ823tdgwBLhUaz2dY+mFR9D1Y9to2DGGnJXe1X5NnZ?=
 =?iso-8859-1?Q?ZVY3E39mmf4y9p5pu6nYMU0eUBW+MykG1niAvwQFlio1AbPlLGDz6jJFyw?=
 =?iso-8859-1?Q?9NB8SseRIxIwFmvDQiPxkFeZltebMuOQjPmXki7X1Qe48xrssRWup/gHe1?=
 =?iso-8859-1?Q?aTKi8Pw55ntXG0d4XTS/Tx05Esf2WYHbZipXUO9aOILy1cD2maicvQyhm/?=
 =?iso-8859-1?Q?bLKZnixelQef+9RCA4XTXQiuegJPA8N5XT8F0H8aA38SZTWRYMpWxEKZsS?=
 =?iso-8859-1?Q?ZFdP2/ISZvgqD2q5hgpdwNKNKjoHPwYB7gPYF7R9onceCxTUMNfiA64NGG?=
 =?iso-8859-1?Q?2YJ4geyNNL6nrLpzy21fH//xSd/QJES/zcGGY9EbR9hY+2QfUp4HvAVODc?=
 =?iso-8859-1?Q?OzI06N+Xqq13aYrBU3UCoDs7ugpkAoAD1wio9bDGXSZYelpT7UPz8uV9KN?=
 =?iso-8859-1?Q?kRxGpJqYctRoriKZbRcWYE+g4NhgdXQfwnWggBpCxHzeVu7os05b2ztG64?=
 =?iso-8859-1?Q?NMw8259wQVan/4hfYkiWaCtYuS9ascUeItE8hib+qOJCDX+tMGnjur5Dmo?=
 =?iso-8859-1?Q?6AXqeo1n4Cqs2/A20tVV0p0ezVOU7XsFRWNZRkSk/Z1je/9ggkxTY4afh4?=
 =?iso-8859-1?Q?87vnFLL7+/orVpighT39bSkh8ZaQGoFioZdvro3dK+J2Qurv0jl84/8faR?=
 =?iso-8859-1?Q?wLTsox0celsjQ8gKxocFwigd76ysvDO6ZtAy8DjsAT8+qN9fTTJ4INRHIZ?=
 =?iso-8859-1?Q?AprnbejSWxuyWOs0HlREy1xcL3fzVf9GYIfT9pyO+/5/4+lTaVVVqoMuXf?=
 =?iso-8859-1?Q?orXuRuV82AGLlnQwOfiz3VN20UhwcRls7Rss1il59cG7lJa1+VTR4CNw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aec0f93a-8928-49db-b591-08dc39f77ea6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 13:57:12.3721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DLtLCGsOS/Kr2wjBfwluk/VxSk5K8jmMvVICvWuL+haTnSRXoGW+edWoAdIMzijHnSFK35JbzYy1yg6i/XoXDfLZ53Q2MPbhy3O85O5+rOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10303

Hello Uwe,

Thanks for your feedback!

> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Sent: Friday, March 1, 2024 9:15 AM
> To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Subject: Re: [PATCH v7 2/4] pwm: Add support for RZ/V2M PWM driver
>=20
> Hello Fabrizio,
>=20
> your MUA introduces strange line breaks. You could do every reader of you=
 mails a favour and fix that.

I think I understand what you mean, long lines would be wrapped onto new
lines, which are then indented incorrectly?
Hopefully it's been fixed now.
Thanks for highlighting this, as it has been going on for some time,
and was never noticed before.

> I fixed it up for my reply.

Thanks for that.

>=20
> On Thu, Feb 29, 2024 at 10:45:01PM +0000, Fabrizio Castro wrote:
> > > From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > Sent: Thursday, February 29, 2024 4:42 PM
> > > To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > > Subject: Re: [PATCH v7 2/4] pwm: Add support for RZ/V2M PWM driver
> > >
> > > On Mon, Feb 12, 2024 at 09:06:50PM +0000, Fabrizio Castro wrote:
> > > > +static inline u64 rzv2m_pwm_mul_u64_u64_div_u64_roundup(u64 a,
> > > > +u64 b,
> > > u64 c)
> > > > +{
> > > > +	u64 ab =3D a * b;
> > >
> > > a * b might overflow?!
> >
> > In the context of this driver, this cannot overflow.
> > The 2 formulas the above is needed for are:
> > 1) period =3D (cyc + 1)*(NSEC_PER_SEC * frequency_divisor)/rate
> > 2) duty_cycle =3D (cyc + 1 - low)*(NSEC_PER_SEC *
> > frequency_divisor)/rate
> >
> > With respect to 1), the dividend overflows when period * rate also
> > overflows (its product is calculated in rzv2m_pwm_config).
> > However, limiting the period to a maximum value of U64_MAX / rate
> > prevents the calculations from overflowing (in both directions, from pe=
riod to cyc, and from cyc to
> period). v6 introduced max_period for this.
> > The situation for 2) is very similar to 1), with duty_cycle<=3Dperiod,
> > therefore limiting period to a max value (and clamping the duty cycle
> > accordingly) will ensure that the calculation for duty_cycle won't
> > overflow, either.
>=20
> OK, so it might be right from a technical POV. From a maintainer POV this=
 is still bad. Authors for
> other drivers might copy it, or the driver might be changed and there is =
no indication that the the
> function relies on only be called with certain parameters.

I could add comments to clarify this, or checks to make sure the parameters
are passed as expected, or both?

Or if you have a better suggestion?

I would still like to be able to use the below formula if possible, as it
allows for the smallest restriction on the period:
(a * b) / c + ( (a * b) - (((a * b) / c) * c) ? 1 : 0 )

>=20
> > > > +	u64 d =3D div64_u64(ab, c);
> > > > +	u64 e =3D d * c;
> > > > +
> > > > +	return d + ((ab - e) ? 1 : 0);
> > > > +}
> > > > +
> > > > +static inline u64 rzv2m_pwm_mul_u64_u64_div_u64_rounddown(u64 a,
> > > > +u64 b,
> > > u64 c)
> > > > +{
> > > > +	return div64_u64(a * b, c);
> > >
> > > ditto. This is the same function as mul_u64_u64_div_u64() isn't it?
> >
> > Since a * b cannot overflow in the case of this driver, I believe the
> > above to be a better option than mul_u64_u64_div_u64.
>=20
> Same technical POV vs maintainer POV as above. Plus: Even if
> mul_u64_u64_div_u64 is a tad slower, reusing it has some benefits neverth=
eless.

I'll use mul_u64_u64_div_u64 instead.

>=20
> > > > [...]
> > > > +	cyc =3D rzv2m_pwm_read(rzv2m_pwm, RZV2M_PWMCYC);
> > > > +	state->period =3D rzv2m_pwm_mul_u64_u64_div_u64_roundup(cyc + 1,
> > > > +				NSEC_PER_SEC * frequency_divisor,
> > > > +				rzv2m_pwm->rate);
> > > > +
> > > > +	low =3D rzv2m_pwm_read(rzv2m_pwm, RZV2M_PWMLOW);
> > > > +	state->duty_cycle =3D rzv2m_pwm_mul_u64_u64_div_u64_roundup(cyc +=
 1 - low,
> > > > +				NSEC_PER_SEC * frequency_divisor,
> > > > +				rzv2m_pwm->rate);
> > >
> > > The register semantic makes me wonder if each period starts with the
> > > low part. In that case the hardware called "normal" what is called
> > > inverted in the pwm framework?!
> >
> > My understanding is that the PWM framework defines "normal" polarity a
> > signal that starts high (and stays high) for the duration of the duty
> > cycle, and goes low for the remainder of the period. Conversely, a
> > signal with "inversed" polarity starts low (and stays low) for the
> > duration of the duty cycle and goes high for the remainder of the perio=
d.
>=20
> Ack.
>=20
> > This IP _does_ start low, but it _doesn't_ stay low for the duration
> > of the duty cycle, as it then goes high for the duration of the duty
> > cycle, therefore this IP doesn't perfectly fit either ("normal" or
> > "inverted") definitions.
> > I think you can say that the "normal" signal is _shifted_ in phase for
> > this IP, rather than being "inverted".
>=20
> Alternatively (and a better match): What you describe is an inverted wave=
 form with duty_cycle =3D period
> - duty_cycle.

That is also true. Also, it'll have the benefit of getting the first
period out of the door without a shift in phase.
I'll adjust accordingly.

>=20
> > > > +	return pm_runtime_put(chip->dev);
> > >
> > > If you evaluate the return value of pm_runtime_put() maybe check
> > > pm_runtime_get_sync() for symmetry, too?
> >
> > Or I could just discard it and return 0?
> > I am fine with either, what's your preference?
>=20
> My preference would be to always check the return value, but given that m=
any drivers don't care for
> that, I agree to accept never checking it.
> So choose one option and do it consistently please.

Thanks.

>=20
> > > > +	if (pwm_cyc && !FIELD_FIT(RZV2M_PWMCYC_PERIOD, pwm_cyc - 1))
> > > > +		pwm_cyc =3D RZV2M_PWMCYC_PERIOD + 1;
> > >
> > > I don't understand the relevance of FIELD_FIT(RZV2M_PWMCYC_PERIOD,
> > > pwm_cyc - 1).
> >
> > CYC is only made of 24 bits, therefore this is to make sure we don't
> > go beyond a 24-bit representation.
>=20
> I would have understood:
>=20
> 	if (FIELD_FIT(RZV2M_PWMCYC_PERIOD, pwm_cyc + 1))
> 		pwm_cyc =3D RZV2M_PWMCYC_PERIOD + 1;

By the time the above test is run, pwm_cyc is incremented by 1, therefore
it needs to be decremented in order to be tested, and incremented when
re-assigned. pwm_cyc was left incremented to simplify the pwm_low calculati=
on,
but I can see it's very confusing, therefore I'll improve this in v8.

Cheers,
Fab

>=20
> Notice there are three changes compared to your variant:
>  - drop pwm_cyc !=3D 0 check
>  - drop ! from FIELD_FIT
>  - pwm_cyc + 1 instead of pwm_cyc - 1
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

