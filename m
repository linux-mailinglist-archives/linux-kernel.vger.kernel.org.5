Return-Path: <linux-kernel+bounces-138683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1272589F900
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDB2C2825FC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC2916F0DD;
	Wed, 10 Apr 2024 13:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="mWV5Luvf"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2117.outbound.protection.outlook.com [40.107.114.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62A116EC1A;
	Wed, 10 Apr 2024 13:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757106; cv=fail; b=s7aXWeEbApyvMLsr1Jfu0nM/IuFGn5JVP9DkEjuLXlFL1CksA7Uwc9s6nDe1+koEV0dpGp6JqahX9/nJmj+ZbCsWJsR1TvmQZVAN3hpC0I/8SbIRnso06U8d/oXTanGwhQc2PqA2cjDqdXWetYTI2gaeiQAgZ+AuCtjIZHdI520=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757106; c=relaxed/simple;
	bh=mgjrbLkzWn6Wn045hvjuCNFRNzhu6MrMdIKcxqf3JxA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PmWsIt40InbsYkk5kjlT8mfkttCoJfL37P6F7GXRgQuvKIHaeC2T6yxIajfTOmWl0HbGx8cgFnPJbVzHyhTxfVu5ffWDaNl8tP8c4hzbgF0Mn5dfnYYDyi5ZDLCfGdSBa8SAOIuQ3AFoy9P6ivTCt74wKMLJSB95xOns20oKnQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=mWV5Luvf; arc=fail smtp.client-ip=40.107.114.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyCb7KMlubdpyiQuKAWHBM95jW/qBZGdKMLN4lmJ/n3S4/IzXCRP2CxRlJcdLSFgxGlzj/RVMs42pAEkK5KehYAA3wjKGGg13pL+cJUgzziM9QsWej+oFINbaUKray76qmOoOFTM+ifIy2i90gDqia0U2eJeGkqexQ+oap/VyZWGhrV1gA9KmriOZx4LNlwvVMnCD4tR61KwbBxW39zZCsCE4wKuTyfgYSmB9qUic2SSQxJ+ako7Bg6/0t8x0Tg4Pi62R5olDCJOwrdtNnQONNJ6xuPO8VLS0HYVOCvmkip52dsoqfGvb6lAOTo/t8NJqQRfsX5ro54/Eep+MIhDMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjZTDsORIFZP8YWS4+6tU8kHMSh9VJKvnoEqvM6gwl8=;
 b=hgEblrNn4b5dXMDtKGyjtZSEsB6IeVEaYoB6Otn8t7xIJk/P/oDWYU5DA6DZHDkWb3VdVGAMM4LOonALJrNoh3XQvEBqixGpsoTfF4ECxzFzEoE4B5cJEuZKjmq7/KzUVNzC45TzwfwHzGvuE37+x4KIURbymCxEpZWN1+wKnw9SRjkK6DwSWX+olpadEMFF8sMEd+NeS3vdDEXVyNS44pshiiNj/BgcRisgo4C2GKrjsaF5S6oQctYEP7Vy51NfAG+kp0auYk4MXz3FOZgYkPDqogmi1vKckrMnwMgUCHfZZ7WyMhb6zOhFZfOmG2b2w3LlMq733RUjXlSeRRp+XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjZTDsORIFZP8YWS4+6tU8kHMSh9VJKvnoEqvM6gwl8=;
 b=mWV5Luvf+wjdZ2XGKnvhDgasyfzefFpUDVawkONYmEwUCbtvJcfrwG/xDpBgbAvJtW5OxyGNGH+fIc3tA5++hR0FJ8rtYSCUiyPLS6nxIyuQBZPi0KaMcNlnmve4eGdb+RKiEh2yw94sEh+KNhzCp6xN397F5V7Efb0r93nhsY4=
Received: from OSAPR01MB1587.jpnprd01.prod.outlook.com (2603:1096:603:2e::16)
 by TY3PR01MB11038.jpnprd01.prod.outlook.com (2603:1096:400:3b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.30; Wed, 10 Apr
 2024 13:51:34 +0000
Received: from OSAPR01MB1587.jpnprd01.prod.outlook.com
 ([fe80::fda5:45f9:f1b2:cbce]) by OSAPR01MB1587.jpnprd01.prod.outlook.com
 ([fe80::fda5:45f9:f1b2:cbce%3]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 13:51:27 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "wim@linux-watchdog.org"
	<wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>
CC: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Claudiu.Beznea <claudiu.beznea@tuxon.dev>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH RESEND v8 03/10] watchdog: rzg2l_wdt: Use
 pm_runtime_resume_and_get()
Thread-Topic: [PATCH RESEND v8 03/10] watchdog: rzg2l_wdt: Use
 pm_runtime_resume_and_get()
Thread-Index: AQHai0zBWu2V0gpeGk2Rf6eyLae+ArFhhK+w
Date: Wed, 10 Apr 2024 13:51:27 +0000
Message-ID:
 <OSAPR01MB15874891F67AAFAA955A186886062@OSAPR01MB1587.jpnprd01.prod.outlook.com>
References: <20240410134044.2138310-1-claudiu.beznea.uj@bp.renesas.com>
 <20240410134044.2138310-4-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240410134044.2138310-4-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB1587:EE_|TY3PR01MB11038:EE_
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 cXEsFuuG3ngCtLc5+rwxN5oRGSO1pWMEdN5SqNW7RMcL0gJPDqDhwi9kd69N9HzX8FrY45UXWiBijZRwQJuI5xICvEFRK6TNPgI6pbgbQ9x1GRy1MfvgjGKbAiUy/1tgbz0SyBKzbIKaVRJDAlTEe4UKYFJvQ43ozjfU4ONzBWkL4z2FLZaiNHBm5RI2P/n0amtDFhE+XYVKrSo20cImfJ3pkeEMm0y8aXg8e2d+VlewbgXQon03blKE5BGe+5vlnpCHPzLFSOIxrF/DABiu1fnM0XhcQf45NdEzmP6Q/TRkAsZQKQVQ6Yd7nOfxAb7ACV7wDNFNDEGRoTaFj2fsTmw6GrYj4s6jmBwjUD5vC/D2d5/KUGzbLkdZQwGbx4zUSd1G2qQVYJVFvUo5pgob+j3NTxd2qMH7mcPiZwIRfk68Spd2PsFV39LTuPbqEotYgPI0WTOHpa9YqemYjuQjF/XRSq/vrJ2I9EIkFkl9gY2UlIX0cmP8POn+0aQ8LH2XjK7JCWWTeSFxorNIKlaOqq3KXg13FD45mmvW7gf/oRrOuolqUXXXpTZuxFnrkxkO1n/seIkf/bIhAx5sw5pXxvAGhoE5N/cwVBQhLyhFvCzAEekq5Ymk06i6Vh3p3e5aDga7/nB9PF38k+NaaVHEejWDnDPHeQTUqoC2Gv3zKmI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB1587.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QpKGW91jBbFx/tWLf+ep0D6OYkv3KMWWC40CxReY0c+iNg5mUhHQbjfMn6ne?=
 =?us-ascii?Q?ePQrt9YQA7YYh/70wdwDE/SkEBPyOZvqata/qe09heprFsxq9yA3xzZ+cGjw?=
 =?us-ascii?Q?BN3myMIigI6AbWTxyZtRULZgeizb2NXBDSIn8pLSGGLq2QkFGYyQkVaTSNnb?=
 =?us-ascii?Q?kQQEi+A5UgGTJytn4wO2gX4M55sE0PvCrcuACEdFY3fP29mCuVqR/0OULWma?=
 =?us-ascii?Q?o8HUsVeI98S3ezjin9V/+IrcWGBKT8l6WnoqKQNQfdE1O2VooTAcsYd124A1?=
 =?us-ascii?Q?gjMhh9rdo52NEJH2wNkdEi2LoAdsoo5pSXKjdmdzRaGBQbsSpXKs4Pq3KDN7?=
 =?us-ascii?Q?HiRpnKEsIjCt7NAeETwFVkMYAJGcDwfu+7GwnYj+gOO7rR3WwE1rQ6kRZSSU?=
 =?us-ascii?Q?4ubOr9A2p0ThAhImfZATXhq+1wOmDdtDaQWkfgrw4gdY9FN5zGdNOswZzdKK?=
 =?us-ascii?Q?90AsCMvH5ygUZMTMSgPtqzr/Hr6hF0FosE5Jw2zE4FRzv0WlsjGFAV5Yeq16?=
 =?us-ascii?Q?8peIrRN4Xy9Rj4dt1qJeKq0v8bY0Aesvd/UK10zQuFmQbBjk1Vp1adNF6IEk?=
 =?us-ascii?Q?atB3v8qW3wzndO/OwVnY9PXXXYdW+wa8LGPHAyIVdWaZpV+ieYcnwvfADb4A?=
 =?us-ascii?Q?eHKQmeOHW50/kSGmyxRvcBRYsq8fx4aBxzRMvtm6QyXK15EjCCQ9dAxsXw8r?=
 =?us-ascii?Q?T9Kr0ZHmLhzyMLKSY3y+7n9tEhe7/FVJoE9JaFtkuQcgl5R8zDh13R7HFeO7?=
 =?us-ascii?Q?3Nu+Vkohhg4/3uN5F8IRzzLpgApQR+0Mv9x42Q33bIEjXgigUTuzTXYU7uMU?=
 =?us-ascii?Q?67QbMksvHXMuErX5Qs7MLGbvUWBa7r6JbI2AZvdMzPZ5wUf2PWhxzFYsHvgm?=
 =?us-ascii?Q?CC8tTObQLEfRaAqTIeKLg1S8oT+zUUZ9ocYHYzV35jrWeFu+7RjBB5krGAD2?=
 =?us-ascii?Q?UKMkSNRU/fpOpSq4ariC1RqbJVfB/9pl6067Uqm9P5SlBt6KnEfhCwc39SRc?=
 =?us-ascii?Q?2ZJ3ZkHovolzeDhPDBMoEQDzj49IdmaFdYUbGhLCQ2gj0U9NkcM+ixzaOwfA?=
 =?us-ascii?Q?Ktp/9O92xdIJGFJci/t7RwuQmdhwFzf7xfxenYbNCTjV2XTjJ67/tVEArXYP?=
 =?us-ascii?Q?zr/JgtqBYGH17YHIQ7j+qWXIhFL0tm2fW7n+dmueQoOFfetZlsi+MyqSJ5bS?=
 =?us-ascii?Q?dq2ZY+U8fKAO0GE9gtm5tXgOPHbc9hkkNOXi7ca7ANuxJB7D3jbdZeD5G9Ge?=
 =?us-ascii?Q?p6Me7vyqSwEL5E6IUsyxBY58S6Ot+/FyjfVabUif3Bxs9DiUzwymSLkXIBFx?=
 =?us-ascii?Q?wXVOHVUQOHhW+sylYyIiPOHmH4wciD+5jhX9Y8CCWKb9U9XcZP6xg1qVADOi?=
 =?us-ascii?Q?f/ypJOrZRHE0gBPO/O9CYpUCEwrCk9pqgB7DuTDr+H5xMk8I+7WUmknAVe6P?=
 =?us-ascii?Q?U/cDu+NUtQ8n981CbTgm+YD/rc31bo40poYNeLH8SndHNzyfJ6Xx3Q+NPpK5?=
 =?us-ascii?Q?V0kpODyAD7nEs3QVPVaYrH1S3gAFmnkLaEX9r7HSUsWZT6MoSrKSPK8JaNND?=
 =?us-ascii?Q?LjsgMbcytlBUvjLgG0OLZw7vd9R5GWDYfbpzYFsLByB22t4faO0/ncl61rPq?=
 =?us-ascii?Q?0A=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB1587.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80dcfb81-8639-4a4c-ee6b-08dc5965516a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 13:51:27.2063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PDcZWR/fshYBXWftU1UaisjurtsHaXF3f1aKsiv49YKdOWy7Lv+asIpuzq3DtzVIyfnMFxRq6W76VTzRupiOum4TEuQGoB5QBb6wvZ3cXiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11038

Hi Claudiu,

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: Wednesday, April 10, 2024 2:41 PM
> Subject: [PATCH RESEND v8 03/10] watchdog: rzg2l_wdt: Use pm_runtime_resu=
me_and_get()
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> pm_runtime_get_sync() may return with error. In case it returns with erro=
r
> dev->power.usage_count needs to be decremented.
> dev->pm_runtime_resume_and_get()
> takes care of this. Thus use it.
>=20
> Along with it the rzg2l_wdt_set_timeout() function was updated to propaga=
te the result of
> rzg2l_wdt_start() to its caller.
>=20
> Fixes: 2cbc5cd0b55f ("watchdog: Add Watchdog Timer driver for RZ/G2L")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>=20
> Changes in v8:
> - none
>=20
> Changes in v7:
> - none
>=20
> Changes in v6:
> - none
>=20
> Changes in v5:
> - none
>=20
> Changes in v4:
> - none
>=20
> Changes in v3:
> - none
>=20
> Changes in v2:
> - propagate the return code of rzg2l_wdt_start() to it's callers
>=20
>=20
>  drivers/watchdog/rzg2l_wdt.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c =
index
> 1741f98ca67c..d87d4f50180c 100644
> --- a/drivers/watchdog/rzg2l_wdt.c
> +++ b/drivers/watchdog/rzg2l_wdt.c
> @@ -123,8 +123,11 @@ static void rzg2l_wdt_init_timeout(struct watchdog_d=
evice *wdev)  static int
> rzg2l_wdt_start(struct watchdog_device *wdev)  {
>  	struct rzg2l_wdt_priv *priv =3D watchdog_get_drvdata(wdev);
> +	int ret;
>=20
> -	pm_runtime_get_sync(wdev->parent);
> +	ret =3D pm_runtime_resume_and_get(wdev->parent);
> +	if (ret)
> +		return ret;
>=20
>  	/* Initialize time out */
>  	rzg2l_wdt_init_timeout(wdev);
> @@ -150,6 +153,8 @@ static int rzg2l_wdt_stop(struct watchdog_device *wde=
v)
>=20
>  static int rzg2l_wdt_set_timeout(struct watchdog_device *wdev, unsigned =
int timeout)  {
> +	int ret =3D 0;
> +
>  	wdev->timeout =3D timeout;
>=20
>  	/*
> @@ -159,10 +164,10 @@ static int rzg2l_wdt_set_timeout(struct watchdog_de=
vice *wdev, unsigned int
> time
>  	 */
>  	if (watchdog_active(wdev)) {
>  		rzg2l_wdt_stop(wdev);
> -		rzg2l_wdt_start(wdev);
> +		ret =3D rzg2l_wdt_start(wdev);

This IP won't be able to update WDT settings once you have set it.

But we can update it, if we do a reset assert followed by deassert.
So the previous code looks correct to me.

Current case is if the WDT is active, then start it. Maybe I ma missing som=
ething here.

Cheers,
Biju

>  	}
>=20
> -	return 0;
> +	return ret;
>  }
>=20
>  static int rzg2l_wdt_restart(struct watchdog_device *wdev,
> --
> 2.39.2


