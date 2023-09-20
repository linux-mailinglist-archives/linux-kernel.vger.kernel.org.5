Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8487A8371
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbjITNbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbjITNbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:31:22 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2120.outbound.protection.outlook.com [40.107.114.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5741D6;
        Wed, 20 Sep 2023 06:31:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGQgBrcjHPjPWUU0ykvBy6hu+YUiUGyxh8oammaX+f6jmz1zn/jyxQ8BiGdYLE0n8xduuM37NBJDxsSBY6hXVI19ahzS0NF5xmMp2N6RTng2FT27IhFbZYMj/AEbfJdMZgC9EHS65+Rg5bg+llsoXw5GD1kktS8dJHUr4cZ4G4nT1f27JXleJaxiIckRmzrdbtppPEudRO8szvkMKKc+3WKeVphovti8+HZPoBZtsR0R0mwpMcYM9UBv3Zbl/6/Nn5Euif54SvfFBdQOdH5JdnNThNoO9ulm7bCDE+aAf64IUKanB0OtZiZFyI9MrLuR8QBo1cLUFZ3MgYz50xrKvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48LsA6D/YUeuIaNyRlDbMyjdR2kwgSmm0kc64XXcjd8=;
 b=US+JQWjF7cDoV8EAysfpLgjeLBorbEA4o49oRAjK/VTOZVG46Bwlmf9pf9GPx41j+AgtVCqyhY+QV1Q3SR+8hBqy+cYymNDxj0LMwUGd8h6agyrGN3QCXy1IxI0GLhejIMyXffl/A6+O4ynd6bNsE8L2NGenBv7j4EJ4AiPHEUh+XPwzYOvTIBVeyYOsFuQGw0PeQLdXuab+d1XJVOyf07hOJxb3iDV2MfHv2fUCWa46Xo5tRGko8k2zJasc4tf3nrk4E+5Q/s2GcPKx47NQXzwrqirv1AoS4av9qBa2wk3cBt5+qA6nyW9Wo8+TrXxBxraJTPtWTLFZzgUUNdQi8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48LsA6D/YUeuIaNyRlDbMyjdR2kwgSmm0kc64XXcjd8=;
 b=h5ZzQfcMeAVMDYYn00vqOrDTssVz79THQg6w+NxVNYR7ZcwvJxmwMedw9MPbn4w8J3LoT95ytLe50q9I6sq0RCiiFN5TigJkfa+f41FW4pm6oQ+o+hTThuPEOKa4VY5NXPUl79Mkw42b14ATeUNoeIHmWmue/vATMJqmhLkU5EU=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB10115.jpnprd01.prod.outlook.com (2603:1096:400:1e7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Wed, 20 Sep
 2023 13:31:10 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6813.017; Wed, 20 Sep 2023
 13:31:10 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.au@gmail.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] alarmtimer: Fix rebind failure
Thread-Topic: [PATCH] alarmtimer: Fix rebind failure
Thread-Index: AQHZ67nxDPIpzSJRaUGrxRMZix2AJrAjtMiAgAAA3DA=
Date:   Wed, 20 Sep 2023 13:31:10 +0000
Message-ID: <OS0PR01MB592280D33C80AACADEB5958886F9A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230920115935.144391-1-biju.das.jz@bp.renesas.com>
 <2023092013265355e7a02a@mail.local>
In-Reply-To: <2023092013265355e7a02a@mail.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB10115:EE_
x-ms-office365-filtering-correlation-id: 42a312fb-73d4-433c-f21c-08dbb9ddda78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0bAfmeArEG3KAharyqHF2wUzN/oHrBampxpZ4PTnEDiHN+X46E9QesCqTQ4HvslujWf8Zw2KSPtKreYTIpbFRH7Twbm1WNQMYKJPMk5ZSQNNDILVOW4mrGW3J+Y8pkJXEa+CVEuHTQR4oHeYi/4GilwBxLF2rO5xC885KAGKCpFtjGqxF19nXukQeMITsosYnaHZSulweXh2MDzqr6Jwp20iMrRAFuFigYjqVZ4LuTkwKOx8eUfPloZQB/G1gusYMs7sHyeazb/Ia5xpiD/iVQjG+jmZs+I60AiaZOwSLWW02IuW9IBKyHp9Acictkca6cDq+IUE//UnYG7kZ5B5WlsI8HglBwoYkxY77QDZD4du6u1RdBxMRaCzNpArUOOrlNKkU1B6VlkIZbFiAZbYjw7u+ws0/+Rtk7YSOi6anqTd7MoEPeVTY3rhH6DRSWUSWQ+EAZpmuOBEaJbrtzH2Sy59uCOvUPlVeHE7YJdebzjL368xnlA1Pm8ZIess7hG6bOcqikJd3q+G50ikc9cHGldCYI/RqA2ZIEay9anJk6f2LgGdZr/k9uImyFNfQTn+4hihPgD4CSylgaxfGqUZYLiFcg8CLkoOpQ0bKPu5/P5G13W4Q9NpjxRbDtiNyoMA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(136003)(366004)(186009)(1800799009)(451199024)(71200400001)(7696005)(9686003)(6506007)(478600001)(83380400001)(4326008)(6916009)(7416002)(2906002)(5660300002)(8676002)(66556008)(8936002)(64756008)(76116006)(66946007)(54906003)(66446008)(41300700001)(316002)(66476007)(52536014)(86362001)(33656002)(55016003)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?815g9Z0TpyVuS8cl4Yd42l5B/R59flqZX/Kobn8sQawkHvyilqLU5FK4VCjK?=
 =?us-ascii?Q?FwHH9xlV1mDMnBzVkyChKYOCHwMMrH8Y8LOKj20E9iy6/TOci/mSVYKbscLF?=
 =?us-ascii?Q?9O/3PCMVEhz7ZlERMtfkZP/AJ+4+8xnG4pDeAHtK+KiSC4n/l9ZS1/yiGOHK?=
 =?us-ascii?Q?0VeTVZRW8oSIFjXA2rT7FJDyCQ7/CJZykUJ4FVKJSqLpiveXpiRfdR3XO4PM?=
 =?us-ascii?Q?LtakSZEcp0YI7mOzPWrj7h0hh803KRKHpFUIix9QgS74XcsDYD2kYdcW0dJz?=
 =?us-ascii?Q?wGw5bUEXHyB5/NpyF+wIvIMHlWRtka0dB2QwVe+dorNgdN0OUAOfrP+YU8v3?=
 =?us-ascii?Q?ChyR53mMCCJ4PvhjswuevZKYHqmzWGPkR49M0EWQsWr5KmIiL400DSYZmon6?=
 =?us-ascii?Q?q8VCmxUCxnHGpAm9smPzIuHtDE31+14RZBeTiSaVRCp8kS8LZWVb93lG2Ctx?=
 =?us-ascii?Q?NANy3lsn8ExQssqiuMLcu4RLWCX6tFbGCsbBGjzm8ZyeuXNvnsnkcuHrSOK3?=
 =?us-ascii?Q?ugTy+SxHvaxvGLGIDXRt5QbuBt+gllcvWjpABpf2mccr+fW/jgMuUBqt2cXr?=
 =?us-ascii?Q?Koz9p02K+0JlR/SyhdnXHxqe2gZ7C9xoaY9vVCcs2zqWuhihqpeztXCG/BCn?=
 =?us-ascii?Q?WlIWm4dYSVddr23WMV1e+ypn69Rsjktvj2TU6fPnfaY2CAu/ocLeQTDtPXAH?=
 =?us-ascii?Q?ZafczXuE9Y3M/6HFC/Fs5Rka/gxpmbEgD8CqkLHxWM8jBJli7uXV4m83CU7i?=
 =?us-ascii?Q?uMwq1V+xjaPNgcEa01Tx/Xrm0+sPvPooyEbKUEBRi65bRF0zJelkK9fVTYk8?=
 =?us-ascii?Q?aqxprY7XwrAzlqbT0PDhKAqEkTE/mStup50D1+2djf9FRhNTuCHpChv95QXK?=
 =?us-ascii?Q?tUQCnNxU9zbkI/gqo9HIftAWCHgYlFVXui62DSH6yfE1FF1LVradka8XKMzL?=
 =?us-ascii?Q?oRAv35MXwI3QNkqojppFNdWeaHdAp2sUIv4vdoR1osz6FYZR/PBR2pV0QKKo?=
 =?us-ascii?Q?5I7jRsr/nxebRmesqDWhRMJgIvr/9TxqD3LNQbOP6LCXdYZG1rzeqWYE1De5?=
 =?us-ascii?Q?YY9RpfWRLh9WJlzGgxQ4qHycPmR6KO8Lb9+zGSZ/3P2UpkOHLc/D2fI4DAcz?=
 =?us-ascii?Q?kS9o1XM+FOCSm+xHxUCm96L5Foecc1ZoIlQM8Tg8w28LgKSWN0wulbnAN81h?=
 =?us-ascii?Q?qDpV2kM5QW6tbuLX0NYV0U1zkE2x2mH7ZXCrlQ6/WTpIPd9yNpBeLEi+5ZAR?=
 =?us-ascii?Q?OmT+XkZHQ3tsp6vLigJoDdS0ZykD0nDqgis3oGAleAMkOa8pP/XJIa/omv21?=
 =?us-ascii?Q?8+Q1UWaV93T5YAPTAgO+cXJMq9Jj58Nw4l6xuOH1b4IJTczzodd1AWgy6ZFq?=
 =?us-ascii?Q?aZLF1fzyB4LFKxQmkXJDBQRcn6FGuqm3Wh9Euid9KrmkFGTXY0UoSEwpHlkk?=
 =?us-ascii?Q?OfFUS4gRp6xZoT4XcvR3cTzcay1KH8STNf0/wffnDVGpkALBuRQLLYi+OrrI?=
 =?us-ascii?Q?BXr1q4EuwnlmwRbO7A85oljF/7GVCPDajC0ssyAx6oBlLdj29UNn2mBWjGRN?=
 =?us-ascii?Q?01avUHSk0Js9FWseZhQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a312fb-73d4-433c-f21c-08dbb9ddda78
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 13:31:10.6811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BUifPHQud3o4+uVgr9mxnlHl6YhpcR8D8PSD2/PUkIKSz0AQ+iXe8KPZnrhaMDjv6t8d6KkMrXZY+pOQikx+/mVyCH769s4WlrNhyyMYZy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10115
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre Belloni,

> Subject: Re: [PATCH] alarmtimer: Fix rebind failure
>=20
> On 20/09/2023 12:59:35+0100, Biju Das wrote:
> > The resources allocated in alarmtimer_rtc_add_device() are not freed
> > leading to re-bind failure for the endpoint driver. Fix this issue by
> > adding alarmtimer_rtc_remove_device().
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > This issue is found while adding irq support for built in RTC found on
> > Renesas PMIC RAA215300 device. This issue should present on all RTC
> > drivers which calls device_init_wakeup() in probe().
> > ---
> >  kernel/time/alarmtimer.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c index
> > 8d9f13d847f0..592668136bb5 100644
> > --- a/kernel/time/alarmtimer.c
> > +++ b/kernel/time/alarmtimer.c
> > @@ -61,6 +61,7 @@ static DEFINE_SPINLOCK(freezer_delta_lock);
> >  /* rtc timer and device for setting alarm wakeups at suspend */
> >  static struct rtc_timer		rtctimer;
> >  static struct rtc_device	*rtcdev;
> > +static struct platform_device	*rtc_pdev;
>=20
> This is the alarmtimer pdev, not the RTC one, right?

Yes, it is alarmtimer pdev.

Cheers,
Biju

>=20
> >  static DEFINE_SPINLOCK(rtcdev_lock);
> >
> >  /**
> > @@ -109,6 +110,7 @@ static int alarmtimer_rtc_add_device(struct device
> *dev)
> >  		}
> >
> >  		rtcdev =3D rtc;
> > +		rtc_pdev =3D pdev;
> >  		/* hold a reference so it doesn't go away */
> >  		get_device(dev);
> >  		pdev =3D NULL;
> > @@ -123,6 +125,23 @@ static int alarmtimer_rtc_add_device(struct device
> *dev)
> >  	return ret;
> >  }
> >
> > +static void alarmtimer_rtc_remove_device(struct device *dev) {
> > +	struct rtc_device *rtc =3D to_rtc_device(dev);
> > +
> > +	if (rtc_pdev) {
> > +		module_put(rtc->owner);
> > +		if (device_may_wakeup(rtc->dev.parent))
> > +			device_init_wakeup(&rtc_pdev->dev, false);
> > +
> > +		platform_device_unregister(rtc_pdev);
> > +		put_device(dev);
> > +	}
> > +
> > +	rtcdev =3D NULL;
> > +	rtc_pdev =3D NULL;
> > +}
> > +
> >  static inline void alarmtimer_rtc_timer_init(void)  {
> >  	rtc_timer_init(&rtctimer, NULL, NULL); @@ -130,6 +149,7 @@ static
> > inline void alarmtimer_rtc_timer_init(void)
> >
> >  static struct class_interface alarmtimer_rtc_interface =3D {
> >  	.add_dev =3D &alarmtimer_rtc_add_device,
> > +	.remove_dev =3D &alarmtimer_rtc_remove_device,
> >  };
> >
> >  static int alarmtimer_rtc_interface_setup(void)
> > --
> > 2.25.1
> >
>=20
> --
>=20
