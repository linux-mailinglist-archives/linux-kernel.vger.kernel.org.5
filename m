Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326417BE74B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377742AbjJIRDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377391AbjJIRC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:02:58 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2134.outbound.protection.outlook.com [40.107.114.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AC6B9;
        Mon,  9 Oct 2023 10:02:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9lBQ98rzJ/gp89kLW11WROSM/H/VqbIOVxKnBxdwsFi+7NKYVVUdeoG7G0dABvUEryVEmADfg4dPqBWoJh3fQJoIqaLs/bTNXitRz9z5GC1Gk4Z12rXhFpPLhm9wJ6TW1j4wT1bL66OdXtsh9hiCP50MtF5qaJoQAxb8o7qLr353imCZwKshAuedisd0fT/3LOjMwV9V9Olljwrh2gITc6PLXmjsf6kURDnPHT8Eg+NFBNkcZm0QQr1tFAIFEWi3YXr4EdvljLsURUqtkVQAIzscTGCIN1bBugRhXFrXRnfG6dHl8k0w7Dcr39WGB3OvoKVtNlsRmAixVcDNPeZfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wuGWi0WtXXrtFK2sed1lRbsrm9ByaePpUx6EIj7qLr8=;
 b=U+iLiI1l1MBPYTDfCz0HQA2Xj74FfSikRiL3AXBJ8BesdDaCdvKGaz1leqemnjpB1AG8bha9t8XLR5ewiYMPoJeD5cR0vDicg9mG6/8mv0eqPF17mGk5kwELoBADbNKBfqqJGKvf8jjbuf65wMaRC4Gug8avwWTuPbS15aIewlBpEd+J7cyv35Sz/w9/OCNRFNf0IhrE3iIaWZX7KEnQKG7UBR4ns4tYCCry5LDjGm7HKdYV5cnXEiPCMWl+oRY+jJWHxdUTiP6MTCEpFj18rcyfDJby0UdGV62LeWR2v8B6CcjsZuga0dDICGgQK0EdEYhix4mlg2Rg/Scq/w5n7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuGWi0WtXXrtFK2sed1lRbsrm9ByaePpUx6EIj7qLr8=;
 b=rdrTZGNRZgVM9//V99nLFUZ+8hMX3QhXHdcyLp1+U/uS9BCgFsId956PiLOMzLvuLxt+TGgA6KzlpzCZ8KckhZpQS6CyXTQGS82MeQbwkdzcZ3nYAGoe8yFri5aNUAf+GieqCoM2o5/sDGFQkeWWuP5zuBoQSmcvDeK3YSYGdi0=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYCPR01MB11638.jpnprd01.prod.outlook.com
 (2603:1096:400:378::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 17:02:52 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::db75:e192:bbfa:78a2]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::db75:e192:bbfa:78a2%3]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 17:02:52 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.au@gmail.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2] alarmtimer: Fix rebind failure
Thread-Topic: [PATCH v2] alarmtimer: Fix rebind failure
Thread-Index: AQHZ7SyA4lmrPv0tQ0OIkUBZ8XwsyrBBqzEAgAAC0jCAAAcKAIAAFRag
Date:   Mon, 9 Oct 2023 17:02:51 +0000
Message-ID: <TYCPR01MB11269C6BF3934F9AAC44F855186CEA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20230922081208.26334-1-biju.das.jz@bp.renesas.com>
 <87il7fq1al.ffs@tglx>
 <TYCPR01MB112697A5D4B57101CDE27C88D86CEA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <87fs2jpznr.ffs@tglx>
In-Reply-To: <87fs2jpznr.ffs@tglx>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYCPR01MB11638:EE_
x-ms-office365-filtering-correlation-id: 81b9e6ef-161f-4d3e-a0ef-08dbc8e992e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8BzMp74huB5VOW9ylN+0RDKrebPgPjKU/+2/fsrP/tGWt6btQbAnDTgcatNmPQoYSRzFvsfRQDRMR6WYykkXHTx2+4HyIZHIfpimHLj0GE/EDPlh+foNZ6lkLX/YoC2dRXYDiyFjp/E4vLA7DXNYc5zTwVZj21vn5H1gPs2v2px6YszUvpCw2xj3YMkTpD/dEdkeIKD5WMQbS0b+ttAjBUMIUXoJdGtJgN7k/5CrqabK8K0yY84BsfEWf+pxt0k2bSnsDZez7yr6CYUc418eKaQhCGfdKCfxDLM/D60KARnToaIms8Dpq6eFlxfNVvTZML9H/vapVYGk9lAue3ro7n/VVOQ3JsuAATKBR0RpsL/l+uG/sYHqZOcgHwwDuDIZ7UaTz8DwX0jyimi9/oCNleC0cqZpGEzbXQV74X2FxNJQV0r8IEURBsD54JNWAaedqeW9+mkrZknlhfTFT9tyW9cm5Pcry/Kerl4cblugSguieOE+MVQX0v3NnXoCfxxDrN85Nu9E9o+geNur7RcZw67eJJY/XBYV502fa3GJHeVKu2g1U9EOj7OiQuEFb0Qx4fmPbe4uhGIMSwCZ6KaDy6B31w26lc+ox06aPcnZSRjgpjthI6931AwThTWBXM7/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(7416002)(2906002)(33656002)(86362001)(122000001)(55016003)(38100700002)(38070700005)(26005)(8936002)(8676002)(4326008)(71200400001)(9686003)(7696005)(6506007)(41300700001)(54906003)(316002)(64756008)(110136005)(66446008)(66476007)(66556008)(66946007)(76116006)(5660300002)(83380400001)(52536014)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MqvlUUMP7xIaJsUH52GUGiLezao9JZ5UNItBhiRX5IhZFWNpOZyOA5I+8UDG?=
 =?us-ascii?Q?buiqHq6fMOiidw8IQYrTVLWS2fx8f3nr8h7ViLvvLuT1DkuzQn2dnx26qJ/C?=
 =?us-ascii?Q?XXtrdNzcODPMs/CHjKrfnSJqMy59EDD3//yy98GaaTiF9el/WLKRFdLmMfm/?=
 =?us-ascii?Q?eU2aRaGNsiFkAX6VWLCIhsibUmH2VXLnrq1VYHKnnhkh/JWDPlO3H/nuk3js?=
 =?us-ascii?Q?eSQPHM3EtCDBnzGxcrUD/y7dn+T5eTe3yhwGYWpnJ7PLxIk1oyySyt9/h6/L?=
 =?us-ascii?Q?cShqBlYvanDetF2Z/v3VEELNfqq/MzVDH9Jt6HvVv03T0AjpVvhlcBzEls/P?=
 =?us-ascii?Q?WoD7T9CRvAT2hyA93e9yGaN0LwKYzxSsYPIml8uVPXlm/arm3LZ9nRNj769z?=
 =?us-ascii?Q?ZRymuXLZFfZtTEVDn0+cb+J37L/CHC1VCrf/IZQNT426WbTVWCJn9b40HXfM?=
 =?us-ascii?Q?OrdUTKPUpRTlhnGLWP/6fT2D83NyXMoUxxDD9lkjAFSRNFrMhEZkhF0wOcz3?=
 =?us-ascii?Q?xrpxg/p11LOy8amfhL2Ufal+J38fg4v3LIxtz7GIPi+9LamWNJScXpKZ695Z?=
 =?us-ascii?Q?pQIDfv3fSx4cvnlBWiYbMhMzbrIzmYenzUXjtUfQTIgEmGaXRrtmc5kVofya?=
 =?us-ascii?Q?kw4KWQsqy3OoWQwAoyXw2otM4pEtCFqSoOd/0WpJLh67GfuDf2+UfbbVhDyg?=
 =?us-ascii?Q?crBgm3quhuiFosvrTgjJ7gBgSfDHLm3oUaTkEebTCPeBfKylTdBr41/UJCeZ?=
 =?us-ascii?Q?5McThN8YY/Yk3JwKHdYLAFfwbOmAqkbLNPTXQq0QaDhf5N/PePy6I1HHa9C6?=
 =?us-ascii?Q?0pbW0aMj1QyJD2aoR7odYQOS9HoM4qBpRG0BU8LO5Yhx6AZ8hqbnwsMI3gjJ?=
 =?us-ascii?Q?5KegXiSJqBI9d3hAAdL6QAOzWBIbobyM6KAeMhmXmlrEuLBWUHfkgQR3Nm4n?=
 =?us-ascii?Q?RN9pu19tq0KVAQ9a15GcwQo/4RjbVz6QTtMgODvu4XBEiCb67wslwv/hrrmP?=
 =?us-ascii?Q?LwuYCY7HHs9FLi8djlfi7MjvCnpL0sVWcuGTUAgwByagr33KSbuZxSJ7VXdd?=
 =?us-ascii?Q?VRw9KqlSFuzn0Y/p1NgkR9YzHdT7yZccZZvvoHYT2zdFC/YTZMWKEM+VfWwu?=
 =?us-ascii?Q?Fg8B7NKsVF7ptvi0rkjroI0l/pXYCNa30I1Ysd0bLQGiqbPGAkfODCw7czVt?=
 =?us-ascii?Q?ufgL/GWfiXS2K1ygI9bioesY2dE/+D+bheVGyuouv7hKLFBwtNYLQDSxVdn7?=
 =?us-ascii?Q?Iopxgi7MZNiZJpZ/4t+NL+L473uCBLzSu5xocHseeFzXT98ZS0iU2U0GO9CZ?=
 =?us-ascii?Q?DV0+DZAdnqFIGgIwv5YRsCAZtQii69/YQPNaEz1gwIi1LtygIcoNF3DIZ6CB?=
 =?us-ascii?Q?x1YwOUEeWciUycb0EUY/79LyUnMbRJMiL5/H67cdsaWsO8qEpVnvfkNT3VHw?=
 =?us-ascii?Q?BbAdnYMTZocPuN5lQljwQZuQRzfpQ2qktK1yFczU2CF/WqahE7CqwvpkqgRq?=
 =?us-ascii?Q?ccexzsdGNPqNQZ1uPis9tC+UrTftzxUZDQOYHhU8ljvBT0Yc/+mfbgK/UUJ5?=
 =?us-ascii?Q?zTMWvmSUbNGubFcClWoQMgg2qDl/cZ/xnfTyMjc4YifH5Hk+8qNL+cxanqoI?=
 =?us-ascii?Q?Mw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b9e6ef-161f-4d3e-a0ef-08dbc8e992e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 17:02:51.9741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 70av/RxjLonwRuKIBduMGesnTaeabAyKw1HZs/fKo3D5mKrH7hdd0xwm1U2/rwHF8oBbxtYinDNaGsKKu5ylBCJKz6a1sF3FsS6LJU35koU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11638
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas Gleixner,

> Subject: RE: [PATCH v2] alarmtimer: Fix rebind failure
>=20
> On Mon, Oct 09 2023 at 15:30, Biju Das wrote:
> >> Subject: Re: [PATCH v2] alarmtimer: Fix rebind failure
> >>
> >> On Fri, Sep 22 2023 at 09:12, Biju Das wrote:
> >> > +static void alarmtimer_rtc_remove_device(struct device *dev) {
> >> > +	struct rtc_device *rtc =3D to_rtc_device(dev);
> >> > +
> >> > +	if (rtcdev =3D=3D rtc) {
> >> > +		module_put(rtc->owner);
> >> > +		if (device_may_wakeup(rtc->dev.parent))
> >> > +			device_init_wakeup(&alarmtimer_pdev->dev, false);
> >> > +
> >> > +		platform_device_unregister(alarmtimer_pdev);
> >> > +		put_device(dev);
> >> > +		alarmtimer_pdev =3D NULL;
> >> > +		rtcdev =3D NULL;
> >> > +	}
> >>
> >> That's broken versus alarmtimer_get_rtcdev() and any user of it.
> >
> > You mean we should update[1] (charger-manager driver)as it is the one
> > using alarmtimer_get_rtcdev()??
>=20
> # git grep -c alarmtimer_get_rtcdev
> drivers/power/supply/charger-manager.c:1
> include/linux/alarmtimer.h:2
> kernel/time/alarmtimer.c:10

kernel/time/alarmtimer.c has alarmtimer_get_rtcdev()check everywhere, that =
is missing in charger-manager.c. I will add
the same, is it ok?

Cheers,
Biju
