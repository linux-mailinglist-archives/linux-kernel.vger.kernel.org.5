Return-Path: <linux-kernel+bounces-46248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C541F843D02
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ACB1B249DD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22A269DF1;
	Wed, 31 Jan 2024 10:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="rn0Fwbp5"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2108.outbound.protection.outlook.com [40.107.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1A65EE6D;
	Wed, 31 Jan 2024 10:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706697709; cv=fail; b=ghjroPJl1cnpZAK5XuQ+wuYY4MA/dBqBWugvEY/MnISf8arCKMAkZCZcBrPC5fINNXuL7n3zT/sErTaPmJdSwfu+DmGd7qIjiZkrLjOmbzBP0frsjHRTDuHpf9oRk+MvOXxCk+6/HV/Vz5Hj7vJu836o233s2S5k+90UT4RKTWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706697709; c=relaxed/simple;
	bh=+EpLhvSnJ355EZYmW9iX9PpbtqYeYWVi660cdwtNKMc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VO8pl2OMv349VjaRevwA+7xOJisWNboEnJXblcL8/jdzFUC4Xq4+ODtNmCn4rBWLQZSiTUh70Xu/uC4UueokQ00Qkuw7CaGaV5boFDp8/Jrq8qNwQIPukjP6kfPwdHRbuatr6Isww0VU1LsgNwCDY96I1Dp+y7wOKwTkE08xqJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=rn0Fwbp5; arc=fail smtp.client-ip=40.107.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtkIpR5IkJkCqI4q3PFJ+mkzvr35d3zu15x6CjGxJU8FqtZRQ5wvCjHP/JgtbFGrFLcpn7UGywEM8G82hmhBjmbAR1JRBtSOcF3zf4WfdA3QIEJCzh49Bg1Mx1dY4TqhYkLX5LU0P+Rrp2VQIvUeaU2Wdt8dEa2abQex1bjbEus94h7tCOpQezoYurWe9avS8PtCv55zwSRdHjWqtOihzpXo8Q3o6opVdu4ys89QhvIrA4qVjPk1SQYr+jDMUfx8U3URX36zdIBacM+bpMj7Z5PyengyuQQxjmLHiNfGVN4a0RtUhy7FhUUJ7RrgugQ1lURonw++07J9+GUzULRncA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vNhpp1neul/9kTF1ChWnI2NgR/+zlxqJdyQBrpqNKE=;
 b=f/ir6dzlnStkJM7khyM3ylD+ZFh0BeL/bo/kfEQaEevAKX49Gx7rxuNvzfzOrPCScEmwi71ubugIj7T4uB19ocReST8olWJoWH46+VhP6fs8IDwk4c2El0WOooyggi5v63OyUAcMH0J9q2u0tOX/kAHyEY1hS7+yYKcO3mecAL+iKI6vUMG459r2gYUa5A+QwVCWkb6CdETmx3kuKtku9EhLZT27AJpH7OvtPN1czFgL+YxCfOdsqfTi4Zb+3BmqLqKe5aBBbJYIK9/HFbwLP6I0hEtWuqE0Og6e+9FsOc5E+jw+sIbFGxmLvyUX57q1W9R+HlL/tbPDob+7qm34iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vNhpp1neul/9kTF1ChWnI2NgR/+zlxqJdyQBrpqNKE=;
 b=rn0Fwbp5GZaBm8bN57VT2ei54g3UkuE/9CR1IgphbMGxkjk7uAQ2J60vTAqvw7AwTVytmT5m3EYvA4x5uD1TLt5VPwji9UiVzZn/KNF1jzlU3VNOgSuq8naLxD5H/1l50crlNSqi9qMagJpwa20uctKU38Jno+lljMpZs/4zamc=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYCPR01MB11400.jpnprd01.prod.outlook.com
 (2603:1096:400:388::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Wed, 31 Jan
 2024 10:41:43 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::8d12:a02a:9fdc:9c78]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::8d12:a02a:9fdc:9c78%5]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 10:41:43 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "wim@linux-watchdog.org"
	<wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
CC: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH v2 04/11] watchdog: rzg2l_wdt: Check return status of
 pm_runtime_put()
Thread-Topic: [PATCH v2 04/11] watchdog: rzg2l_wdt: Check return status of
 pm_runtime_put()
Thread-Index: AQHaVC8iXcXSbumPXUOI0ciCmgv5kLDzuJVQgAABkACAAADxcA==
Date: Wed, 31 Jan 2024 10:41:43 +0000
Message-ID:
 <TYCPR01MB11269BFC2DB457049A2B8C0C8867C2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20240131102017.1841495-1-claudiu.beznea.uj@bp.renesas.com>
 <20240131102017.1841495-5-claudiu.beznea.uj@bp.renesas.com>
 <TYCPR01MB11269AD7463C9C7C0A09A43A9867C2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <ddc0b42c-bf88-4c0d-b938-8bd7ff7b329a@tuxon.dev>
In-Reply-To: <ddc0b42c-bf88-4c0d-b938-8bd7ff7b329a@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYCPR01MB11400:EE_
x-ms-office365-filtering-correlation-id: e296a55c-d82a-4394-52fc-08dc22493736
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 MvF6MA6E9j9wia5FLRKPWECuo0KoxFYcjXHEfQaYleyYJU38eA4y7KvLSr6VIdyW5hLwN48d5CiWRLRf8VegUgnkEOBmwduD/ObAdjMLMebdt1kwUnGs60cayMMIldEL08Aj7OCNnykp5MQajoRosC9zrWZX08fxzLLKcR972O6p9XB/wBsLgK6SpsrjWOjE5Rq65MxI9VdwOOWTD4D6hQPD0l5WYIz/cRm9Uk63lZyMxHHlIhdnUw3YUTpL8USxC/EtN2wYl72OAp9TrKqD3fJDCQarl7/+dhqvjvCVJBDPl8J7ZK3iQWMGygJQavLS5gQzVphCLnmnU2j+jN6Mo51d5D6Usun2gEb5/GQ831/bPCGfKpOf7kCZDfwW/y9Xen4p1q3Miz82HeH1HGxyOPSS4HivVXkEuy/mDZ0MEuC5N51Rrpxx6B6B6xU9wO64Ht5rjg3CqqNQqfQbPEW/Y1J+mK1oUlMsIAa68UUbnaBDpK5Pbh52mmFI2l2nDuys4PXk62kL6S7u9SwezuDeDmlYkFN4VTKN4Pz0crqACQFdmaSaOvEJZCGZuL5TW1QT+mKEPhE8pSa1lDNLyx55CNAU1CsFauT+TSf8IzeLD8UicTWjQFKxJtut7y+ns5ExJ3h66v2jX6/Z/FSHUvrw7A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(26005)(55016003)(107886003)(41300700001)(921011)(478600001)(38070700009)(6506007)(7696005)(53546011)(9686003)(71200400001)(83380400001)(38100700002)(122000001)(316002)(2906002)(5660300002)(86362001)(66476007)(7416002)(66946007)(54906003)(76116006)(64756008)(66446008)(66556008)(110136005)(4326008)(8936002)(52536014)(33656002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vt70lzghUul5WdPS9Vav94zEP0xFS/Yf/Lh1FpWFR9T+OKNEg9rM77Ut7tal?=
 =?us-ascii?Q?iyKtlC8KVMomdFx6Ncq+g3NmYsaECPY3WVykIIBa1z7FHhJTqzdf49JOY78V?=
 =?us-ascii?Q?xUhMBq/st4a4ZlMxLyXvyq8RRStBEGqV8x/KtAt+1Mx4P/6aKbLsonIoUBGD?=
 =?us-ascii?Q?QGV29SDXeLpNTmUHYfRP0ND8Nc9D/V1tMgpszo/gZcTe+BAoOYh73Eexm8m6?=
 =?us-ascii?Q?TVimlrMhNEDsGL6A8M+2gjMABLfQShQFhHaArVpL85yZxP4XpNykJAPf1E/L?=
 =?us-ascii?Q?RZQ+4G/FVNoKgspJuzS6GAX6F082KON8PC0lu/cobRA2VHYbaOjkNxy/fY3z?=
 =?us-ascii?Q?GnVdvLPIe9ib5A6p0AIrTHKJVIcJ0X6rhDBXMj63KmXefM12TLFblNTbXhH7?=
 =?us-ascii?Q?KzclXmQrXjlFYGH7MLx4UsAu86eF9QO6E/0gYodD0k7h+pZSqbBCEEA8xHo2?=
 =?us-ascii?Q?sXq3mY5+bNXGzMm4rhOQ5waRt7KKm7/BsAsQPEAbITcEAcMqiCnscbB1xCn0?=
 =?us-ascii?Q?njx2oagC/8iNMNrBIBxB5crXLtXhikVbYqkzwk8nKy1+zKI1DrGG+KR1z7Lq?=
 =?us-ascii?Q?jPfrr1zb7UnRvkw9xdcwrLEGnpTmwaLoPxud5doFY4mJws1m7SKGIZMyRyKN?=
 =?us-ascii?Q?Ec+XcS3QSH7BB4VK7rJNfjP1JC+UdF9XifOmOj73wzW6xoMfRbrkh0AZRJa7?=
 =?us-ascii?Q?ehwUZ81++lb7FafUVElDXDlbg/rpyE/70xyZ8P/4qe7F7Ve1PHRIE/XnfXiR?=
 =?us-ascii?Q?YKiUZIwhB5KOJMLaRRPz7q6Sni/nnd/oEDEIm0q1wkwOfDs7aiGHAOPSzAyK?=
 =?us-ascii?Q?BfV6y6UkpjizDQSYvK6eg1h87OBuLPtMnMPbUvBnUSyVc5i63LYFwGq7DmgH?=
 =?us-ascii?Q?ltOq5xDdkiUAsGLG6yNf7dbK/FL8waOmFXwhAMPbiKHoMKBSk5yfn7BysVe0?=
 =?us-ascii?Q?AaqcT6gz+7V5ac6u8zQiVfXkXltilYHexga6j73ftlTOn5EM/VbuTaL4Bwrs?=
 =?us-ascii?Q?QZ4RYu5odjCDw3V58/pg1ga1KV+/CH9OuUHiPu1nsAGqkfPrdfs6lb2umNfs?=
 =?us-ascii?Q?9IsHTKKDQrJ8+m30kiFdbhAOenKdakfKDTgvCh9orqLd2c1DfOx/mjnz2rWb?=
 =?us-ascii?Q?jhCcD3Ve0jbl9HMXKDtgWIROiUIniNdDRGIaRmTx2De92Fv8k47WZGhhJi17?=
 =?us-ascii?Q?y+G1LbQ+dLHEOPBgQQyhBKWb8jl9YNz5RliKKQYjxZDGxvDg+gNd5iutLZFc?=
 =?us-ascii?Q?7mHBSwuDvyazpRoh1iQCrKpH45cYsdHoqvuoB9HQhklmcgfYpzQ7L2UrTe8r?=
 =?us-ascii?Q?jEFe0A5UM+8YQ0HcvI+QDjJVNnJeii/LvZxHaOp9Vdm5yUMRoxDP9BIYTipT?=
 =?us-ascii?Q?v0Tt3ggvV8j+bLvwZUtudFe9GZ1OY7JkoiFtvgTOdTMOU+L5ZLUEsuhSkMuu?=
 =?us-ascii?Q?ukhUIwBKkpbV2PTMlwhkiZyekVLR0ehdVND0KNgetZcG7PLvEESdg6sqV+99?=
 =?us-ascii?Q?m6WWJERpHWeKFhtOP7JxX9v/bNbnBhDlo4jix8+RUI/imRgeSviMlQbRS0ci?=
 =?us-ascii?Q?BnElVO8RErO2ZVWRNTa46R6tkGQJMWMgCyIsvZPvQzgfxTl0rC2cm/1rw3U/?=
 =?us-ascii?Q?RA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e296a55c-d82a-4394-52fc-08dc22493736
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 10:41:43.3612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dSlkfLDNizOKA/PM+B0R7dxJOaY01z/o2t8EED6+Kms2RXIEzWVQnInArohxITmWwVhWnFVSizWMbOYbN/pjb9Hm1TnSG7Yar3P8Li5cVII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11400

Hi Claudiu,

> -----Original Message-----
> From: claudiu beznea <claudiu.beznea@tuxon.dev>
> Sent: Wednesday, January 31, 2024 10:36 AM
> Subject: Re: [PATCH v2 04/11] watchdog: rzg2l_wdt: Check return status of
> pm_runtime_put()
>=20
> Hi, Biju,
>=20
> On 31.01.2024 12:32, Biju Das wrote:
> > Hi Claudiu,
> >
> > Thanks for the feedback.
> >
> >> -----Original Message-----
> >> From: Claudiu <claudiu.beznea@tuxon.dev>
> >> Sent: Wednesday, January 31, 2024 10:20 AM
> >> Subject: [PATCH v2 04/11] watchdog: rzg2l_wdt: Check return status of
> >> pm_runtime_put()
> >>
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> pm_runtime_put() may return an error code. Check its return status.
> >>
> >> Along with it the rzg2l_wdt_set_timeout() function was updated to
> >> propagate the result of rzg2l_wdt_stop() to its caller.
> >>
> >> Fixes: 2cbc5cd0b55f ("watchdog: Add Watchdog Timer driver for
> >> RZ/G2L")
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >> ---
> >>
> >> Changes in v2:
> >> - propagate the return code of rzg2l_wdt_stop() to it's callers
> >>
> >>  drivers/watchdog/rzg2l_wdt.c | 11 +++++++++--
> >>  1 file changed, 9 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/watchdog/rzg2l_wdt.c
> >> b/drivers/watchdog/rzg2l_wdt.c index d87d4f50180c..7bce093316c4
> >> 100644
> >> --- a/drivers/watchdog/rzg2l_wdt.c
> >> +++ b/drivers/watchdog/rzg2l_wdt.c
> >> @@ -144,9 +144,13 @@ static int rzg2l_wdt_start(struct
> >> watchdog_device
> >> *wdev)  static int rzg2l_wdt_stop(struct watchdog_device *wdev)  {
> >>  	struct rzg2l_wdt_priv *priv =3D watchdog_get_drvdata(wdev);
> >> +	int ret;
> >>
> >>  	rzg2l_wdt_reset(priv);
> >> -	pm_runtime_put(wdev->parent);
> >> +
> >> +	ret =3D pm_runtime_put(wdev->parent);
> >> +	if (ret < 0)
> >> +		return ret;
> >
> > Do we need to check the return code? So far we didn't hit this
> condition.
> > If you are planning to do it, then just
> >
> > return pm_runtime_put(wdev->parent);
>=20
> pm_runtime_put() may return 1 if the device is suspended (which is not
> considered error) as explained here:

Oops, I missed that discussion. Out of curiosity,
What watchdog framework/consumer is going to do with a=20
Non-error return value of 1?

Cheers,
Biju

