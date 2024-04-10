Return-Path: <linux-kernel+bounces-138730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6828789F9A4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5E181F30740
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B0D15FA9F;
	Wed, 10 Apr 2024 14:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="rnrzmenf"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2132.outbound.protection.outlook.com [40.107.114.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63BD15F403;
	Wed, 10 Apr 2024 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712758391; cv=fail; b=BbG0v3ZemSRmv6eicdUw0rkapBzJpB38oDH2eIeLWrnFAba67lqYeYbiQ45+DRSCw2+3AQ6axrcISY5AedKJwZQ8xl13LOncnaDSOAaqgD7Sstld4AJNDImPoW62AUrIKKGiizSPC08NhRWYIWEOL3hEzyxwKx1imEwLP4EB7C8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712758391; c=relaxed/simple;
	bh=FpQSV/XQmEJb6PZTNhkEN1J70tc2CggUnR3NKjYT/ak=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OBLrTDa6TUid17a2lBfWwdpiX9D9xXW2pCxIGPXpgif57kD1LT0o1VMjMCLFmER+PirmeuJg9H5mT3LEFpBXszu6JZk4AGeb/IIIn3WxcJugVnwmu/cn9vwAyieICacURUNJFmfYDn1RZVodJAPvGJjv9/ivEfcSTBHqW8nS+Us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=rnrzmenf; arc=fail smtp.client-ip=40.107.114.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dc6FnpqYvmPXZxNSzhzxa+1bT2R/pcYFu5LCYFhzyEnwtdyKg6ZG3woroBmV/HrfrPg/xwI8UeBM3HFaFSa3QutNELK/ezg6ujCawXATjVuzXwFaDeH7Nba8+dy9qEt5qarTZzQzO6jDSPW2Qfjw46+nstL+Kuy90dIKSBJB6W/TRnt1ojzjaxTDs79OlZEzHZfMVzz64bPtpHDDBedO9ocoZce76iT1sbRZ1UF0IO2mKfI985iCa1IodVHZZXujv4souQncEkHzU9RSy72Fjy60786HnDCHI9Ifr6vvtH16L+FuK08YeZDgV51mvkVu3P6okiJ7iJBEzSB6Xv2SQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtNLIbHuSsCvfBKKJrjoE+nGBsyn2BCeDsmTOYhNLco=;
 b=ay4hHdInxxgk8lDQxFlmIcnnXQElwT8l8vBGZD2D/1xuP7J8t5joiGacQl6kNbi3xj81Pb0GNmWeTck6oFSNZ9hCwQwHTtTD547pfBPv0AsJEo8yi8jK7g2cIGW+xgMKeyzPdekmpVuuNsmPWvarwO2LV/KxpI7FYX2J6JdM3DoJFcyO2QWQBnEIJd6zNKXJMsq/IiwOwls1KJSnUqrJQ31yZod8tAWPWijpX/9B3F/1wNp6NQGROEBq7z5es+UhpT90/ZgeNsJrhOYunu0GG3dHq9LioS2+NkgwGl8lmlpuxzd8ZxYvrgscJmlrQPsSofkTL77szrEdyt47cUJ80A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtNLIbHuSsCvfBKKJrjoE+nGBsyn2BCeDsmTOYhNLco=;
 b=rnrzmenfP8ljw3iDhI19Go+cmp3+EURb0sxiSm/XevH9Ytf8A+v1rraUSW5FmsreyZ4+s4QVCDhT5HEiyk2dxqbDv//MijbLgBFOhaMuEQCTj2ySY2vZjdxopdHuCFnrWZo3KakefX17UC4fNILWm2sWi/BbStEqtxN/44oF+Yw=
Received: from OSAPR01MB1587.jpnprd01.prod.outlook.com (2603:1096:603:2e::16)
 by OS3PR01MB8368.jpnprd01.prod.outlook.com (2603:1096:604:193::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 14:13:03 +0000
Received: from OSAPR01MB1587.jpnprd01.prod.outlook.com
 ([fe80::fda5:45f9:f1b2:cbce]) by OSAPR01MB1587.jpnprd01.prod.outlook.com
 ([fe80::fda5:45f9:f1b2:cbce%3]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 14:13:03 +0000
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
Thread-Index: AQHai0zBWu2V0gpeGk2Rf6eyLae+ArFhiuxg
Date: Wed, 10 Apr 2024 14:13:03 +0000
Message-ID:
 <OSAPR01MB158744E15B527496A8ABA4CE86062@OSAPR01MB1587.jpnprd01.prod.outlook.com>
References: <20240410134044.2138310-1-claudiu.beznea.uj@bp.renesas.com>
 <20240410134044.2138310-4-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240410134044.2138310-4-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB1587:EE_|OS3PR01MB8368:EE_
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Y9jdzQSTLy4+PXBPPNud1GoJMnDfTjCQ0lN06KjiCwzetIOLPRzT9uRSXvrFtOOEjIzrqaZZRlqrEWLffPt8U+UDDv9X8StzFi31WCggafs6wvY5e2/wNi1s52VIKDZxk2a4dmSXyqJwT3ul2kcRGLPRwgWEQC8aRUz4lDj3JQJZbG8QGN3hR1xbw8MXYenOOAsiXt8HD4fG+9dcDJtUCB/msGZR2b2ijDvBjnZMlMu/2oJ6dQHIoGTlvQ/q7DW9+XQjUUwAZTHmXVeAtGd+OsgGVGXxstY0+FdkG+smyqrf4IH0H03rv0pN8b3S633MKk9adyftTjFxjbNy44JMHtBrI+LylHv7BH/oIvuoIuz4VfHwQIbS7zNTWNqWdK0GXM2uLeIQhl4jxebNDwQ4Gm4AAuA6RkElDitnIgSbaa3kw+yA9mYjzTT7mz++HQKinDfoGor8Z1oxa4hFPMdYgcMF9dJzTynN8vu42DaBw2T0Ya2OW2b47lHxLxM5R37EdJ3InEk7pVgnmjNPKbqvyLiKAF/UuE5ZDVzmCfnfLMIYCa4esWpGN/23s2MJ4cCRXNlgY36HnZd9OM/eV2yng3DR7LgGLWRnTQ2Z+vPmd2F3gr1mg7qtAa38pYGwQ9O2SxDpm8DgEa6Z7+zS6S0z5ISfxs44V2ePs0L/LP0GMpA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB1587.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pTIkHJWP87KQD4JrDRFc+ZYSGKZl31B1Ek9lYJSL20dezIu6j/R3Msa/ydKD?=
 =?us-ascii?Q?TYSRt0q08RaQEXk8PLjetMx5TCxenqNY9Ef178YugwE0MV+YU7HMgUQAW6oL?=
 =?us-ascii?Q?MKVyRo70vyaUhPiWd3Lnq/k7jffsDbnpYv/8qouSzUNUTpklNuT90vXmo9Xf?=
 =?us-ascii?Q?HANuwFC+YXmIzFI8EdmlKPF4pUzu/KO6cbq7cOWG8oR8Pl0C3o9ws7LlVAKi?=
 =?us-ascii?Q?jM7g2uUNrwlMjAkCeWB9LuhSqL9S9YktHbiWy/R7Ybqm+9D9B5xf7lER1kRg?=
 =?us-ascii?Q?+Eexc460BCv9/damc3z072wxfxej2R/7GkvIfMIJ0TbWz8Q1WdTLGweefnvs?=
 =?us-ascii?Q?OCICHagLmlhXFb/FhG1Sf2n4tckAEg2KtgXysqCTyewjQTxdEt1j4jh1K0vL?=
 =?us-ascii?Q?UIh+CsrDcnkWDWmap8g2DFD9ZBrMTn6wTiFoTrwGenPH6TC+OSbqHJvij5cb?=
 =?us-ascii?Q?+3opPFxvoIP7NR3LwWpa+ZHlDFwi4JExEbA50jDrougEE6RJjRR9uQZLu962?=
 =?us-ascii?Q?1giJICz6DkJmJgQ2jjJo30jCULDyJip15hpOqqoZcUMUNGQdsPRDJKGgCzQX?=
 =?us-ascii?Q?nVEtXjvfZHaD6fVE5v1hYZa8e09yV+7Ka5rOAIvf8pwJr6xX0DTDDhF3hS6C?=
 =?us-ascii?Q?SZ261d4B00swMf9mIHAVDdxkciU13jq3REKxS3gwrPbK8Ju6wCJE71FA8Av5?=
 =?us-ascii?Q?frWBjQTlE4p5HW0d2A+Dii0nirxQ59RucBR6jhF7WjWm/XEIlAVc3ailoy/9?=
 =?us-ascii?Q?lkPPc+tKgBJEJSH/bt7Uc7g5Ni6wIkP+rrGtWIOZmSmPCQDt1AzNs1o7SgpN?=
 =?us-ascii?Q?QCfEZBrHGVt4GFu7u+mH+9J6VkARBdSk3+92d5RgK2iezJOEDk/xF+XNqDfS?=
 =?us-ascii?Q?RVHfikcV+3JgmTmaSYQ8OTfONahYFABQhp/LhEtirNyvV2AsG5u98IErsE2g?=
 =?us-ascii?Q?lvtIKZdZZaRsbbpAL6Cq1OW1c3DLBG6BNHYQ6UpS1ovCgxBXXBdMGYun+Wrn?=
 =?us-ascii?Q?rCd/Unf8xIz8DSr+V70G92txIGTvVpPP38eLWYPh8rUV6kExvTUF+P9FBg6x?=
 =?us-ascii?Q?SQXlPs4E5tmaNiCALAx7bl00XcmtKMCBpZfQYyfkLr3NW/pISH7wG0tDs7M8?=
 =?us-ascii?Q?/jYwJG7cLwouHl/8V4YL47j2OHdr4H8gm2ZvbBfr3FALsBJp5I74xSvBkj7f?=
 =?us-ascii?Q?rOtwIjQKg1sLbpPx0ut82HPQe+H5humG6aoUAYd2FLkJqASzcw3eZzv1kObc?=
 =?us-ascii?Q?hmPchX0fbSJ+JhZUtIIuvPqdjRmEmjf6XGvIZjJjIEM/p6OnXeiuL8WHv+hI?=
 =?us-ascii?Q?9pCxSyZs8f22Z/eTmzidSm/9h4Ts1vkO1NL20X9RCZvO+DB5/q6oLCAqczCG?=
 =?us-ascii?Q?agiVsyseyeDXOpBSavlAzYVNL6vPo9mpPSitvh9WTMui041nZj4wFZKAPgBt?=
 =?us-ascii?Q?HxY2WQjNMLMm6oxZeDJtE909BIU6qu2Wd7NywM1CwEmzQp80UF2RYNRKUFWq?=
 =?us-ascii?Q?mOuzRuTnTaaSaOrY8/z3Q+xlK2kigwSykimom8P0btWCE06uhKf2dXxhngQX?=
 =?us-ascii?Q?7g7wPOZ9qYrsCM/MGzN3ZBWSBnIZWRsufp+xidyDfmhzIw6rDBDNmsyLEJ5f?=
 =?us-ascii?Q?/g=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3320a258-9fc7-47ae-7d14-08dc596855d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 14:13:03.1155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z4vOBiCEpUS+AqWrBdvfaR+nEA2F/Du41Z+ysLOOW08hiOLEcOqnpSahRa6DiqL3JFTVPNs5jH5tqwWsnipd6y7wWoEE++UFvFaWGYt2kAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8368

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

Do we need this change at all? If we have balanced usage then
this won't be a issue. Did any unbalanced usage count popup
during the testing?

Cheers,
Biju

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
>  	}
>=20
> -	return 0;
> +	return ret;
>  }
>=20
>  static int rzg2l_wdt_restart(struct watchdog_device *wdev,
> --
> 2.39.2


