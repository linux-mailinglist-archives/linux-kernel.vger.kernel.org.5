Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A19A7BD3F9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 09:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345347AbjJIHAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 03:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345027AbjJIHAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 03:00:43 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2135.outbound.protection.outlook.com [40.107.113.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1BFA4;
        Mon,  9 Oct 2023 00:00:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUUhaYPY/tEC5N46iMK2wa3HlKe0UIFjqG+gVhuRaSfMRp2oUO6VPGWgSfqoAmfvn4Mex+6WNc9gtDtv6yKI6Z//4EVCAVPlaCh/Y+wNvZxJzhgpv4BAazMtrwEY38ASRiQv8VZtBeJRzcrat2bchyRrohkEQ+Lci/FGLbODGVvRM69p2zpR2KuAYnLHCGVRnp9ab3U0fDFqo4LfjxYgKdsGhj9wWTNbQCBmH2H6xWMwxlQhjCgH5WgGz5yixb9o95h7+bIDIQmRz31yS8qJlzXsrBI5m0KAysOlUJpguzn92Z0nwBpHDUGk1pjmti0MIkW0BFsKr16bHPSlveua1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7S5LOR9OxRtjb89f2usEE7baIVFPKqERdYAjAapKr2I=;
 b=NoXC3U+kcTxOU1jK5GrVPfMRzEqwnpUK7ZV0F39GACudMlhE+0QWFF9YE25FH4xgIFl1xRwsCwfUUHPwMenFyr9GHU/mmY0jvMM2zFzHANIpotIc+GT5/06FmQmuQhv+eskmIKUjYt4Gz/N5D0MQuTJUwmtk8TZeRyVZ+3sjG5cVppovqG17OEIaL2osF5a5oOXvA/YuC2nqH690xnzMSpJFoffocpDXjTVdh376gtzeGjWxzTrM/Q6+CV6PjpJFzLBFRBJD5m2G4PS6w0VFAcnGUxUrFp2huvRqLF2n/LMHpHp0WWWXjTuM6/3qo/FHnH3kV6g/CtqLrJouqNlr/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7S5LOR9OxRtjb89f2usEE7baIVFPKqERdYAjAapKr2I=;
 b=n0IalML5QgUVL4bbXDtO/FtQo9DjA9WABFV77pa6XDynCzN87CM72wibajcQpjOtq4blcs1prG1vObHsQVgw25WALchVEVtJ2NIwSEluFGOI73nyiPCxyGY3H0jmlIDdwWB0C8uTfGQWCdrRuA7KdN/cwMfprvWZEVTkh651k2E=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYBPR01MB5502.jpnprd01.prod.outlook.com
 (2603:1096:404:801e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 07:00:34 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::db75:e192:bbfa:78a2]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::db75:e192:bbfa:78a2%3]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 07:00:34 +0000
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
Thread-Index: AQHZ7SyA4lmrPv0tQ0OIkUBZ8XwsyrBBIUcQ
Date:   Mon, 9 Oct 2023 07:00:34 +0000
Message-ID: <TYCPR01MB1126955B887E78829C40224A886CEA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20230922081208.26334-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230922081208.26334-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYBPR01MB5502:EE_
x-ms-office365-filtering-correlation-id: ce7685c9-1c46-42f6-0653-08dbc8956f2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LB6k1BzHPxv3ndkIL3z/FI9mSg3vuKUx/atwfW3I/DN0X6nkzhvSRloTiy+Ojth7qgEBO/CLQOPThVQdP8q7XuYd2ZVFpy/u05fgyZJYMHtZ1+S3Uotso/kQ6GxdGOc7O0XltADBJiCCVay9IZno8YdS+jWUfXqJB148Cs88ecJNC+AGfwXOqMM0XDPPiXt0FuEypEI0I5hylTRc0kIb4tBNJc+iycU7h5ZpHZkzeToucnlQ12gUDU+zuiwc0PIBOQOncrpbKagf0i7YTqaxblCrUVEihOKkv1QWRtcAyn/fnWz0DvVE58FgsfB1I4r+W6uRn8RslFxurxwzKjzt0hxyOkTbUJzwMwFBnd2LkgNLqeKiPAkedJWYaNaUNxu6IXLqwRllPqmUMScXqMMm5t/IO5mggId4Ld9cdxRbugIq+bwFd/RLX99dKzZqXdUom8U6ogB2tPiZxg6KnLalmYIbPvVI3Ymc+o7zRsaGpHFNmYfaceyymmNvrR9LSymq3UXUhZYOSlq2kMzdWggGbDZek3+E5KBSq8kbw+SrdEvTLlhhb0MglxTuGTvMOQlVDagbpixzUTC2X8YOQbC2Zo0ZBmSBFl3hJpZ0fUj9frq1VAdIrtEpVDCUZVEuCCzx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39860400002)(346002)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(55016003)(83380400001)(26005)(64756008)(66476007)(66556008)(110136005)(66446008)(54906003)(76116006)(316002)(66946007)(7416002)(8936002)(8676002)(4326008)(5660300002)(41300700001)(7696005)(52536014)(53546011)(6506007)(71200400001)(2906002)(9686003)(478600001)(33656002)(38070700005)(38100700002)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Fi8stiYHLSET4sUcvCn3xCeyNjEpMHK3I3SWFesblX9zv/gJ4Fj1KQ7DW7Se?=
 =?us-ascii?Q?IgOQkAT72wa70Vuq5tGmJCSd8eB8ZIpqD/kzs7gScQgiC+OCxn7RzcIaI4WX?=
 =?us-ascii?Q?tnL+lcCYAiz0Sj8VLTS50JCwjqps0GhR4wmvqTvdOgF1+Y9Jt2vssKmtGUrx?=
 =?us-ascii?Q?WOPONPDQ88+w1z6S5pfZT4VdK77nGdwNBwFZ2YvtLcyjZBimN53SdMfPWPjS?=
 =?us-ascii?Q?FP4cl18hJBUfU0c/9ivaJWT4boiLWpG0R36H5y8XOtondLi8wJlG+n7J15iX?=
 =?us-ascii?Q?sOJp1485I8GkFK/W17gLgp0peLcM0PaiC1ov8mEB8NOrnbZeSvznlbiH6WND?=
 =?us-ascii?Q?dzCLRL05npl02DjO+s5o25LYxipE0fG3KMwlX9WW9lMzn8GWJ/6ePk61UV5o?=
 =?us-ascii?Q?woLjE16CLacyit1KYbgZBW1tiy80YtX60VZIuyYE0P1Yvkfn6rpkH2fCfuJV?=
 =?us-ascii?Q?luoK4Fu+12tHTc6s1v73q32GLF4ywdpCdog8Gw08isLsQqzUhzY2jzVh5ZLS?=
 =?us-ascii?Q?iR2ajSgBn0grvX5ugSYxiE58tWD4UqMN9f5KgwM62HGCB2jj4m24iIQ7l2KK?=
 =?us-ascii?Q?dvi4r0mV/cFG7qOb+Y+d19hSlJXjONoQuDjJRDw8danTTkA6jlsbrGsR273g?=
 =?us-ascii?Q?muC70QCGq8Bg4GWWVqssDBEllwIzHZogSWIshuIzmflUwpYmERRHY3UHId6f?=
 =?us-ascii?Q?wYpbuA41uskpfmWKPt+VVfUf9rZ5lvYFJQTWXo3cSszWOgGZsPr7FNQ7wABJ?=
 =?us-ascii?Q?HbOqXK/Dyc1CEEad6t+HBvlgUit3KnXZ6Oyi64ZYfkfmjpXi1KqFL/ubz3z5?=
 =?us-ascii?Q?Io3lAYniXOmCZ7RoL8WF5F6EHl+SUz98FAfmRCQYYAs4TnrQENpZXQUjVR9Q?=
 =?us-ascii?Q?s3t4gMhanTcef8L2hI1UHBwT86gVo5G6LEZ65Yai+wSg+hovJcs9wVYenF+/?=
 =?us-ascii?Q?B+yY9sv8B0ApjK9vVUYkbt/sS7SNnlm/vV4VWeB3f8QQzf9QKI3FaSmE/nKI?=
 =?us-ascii?Q?PH5wG1EmpFP/ivIGSPNsxVl2/6/7JAXNQ5p8qDVW82bb01NMZHzk7SnmpNJm?=
 =?us-ascii?Q?pR45vDCQt10Hh1uoHeP1bZwl9ntYXIge3Et7WpzDuu0YEhndJ5SBINAnugEb?=
 =?us-ascii?Q?M/5sdNzgdebYOrXs47LzJY1lAvM3yO4ujHq1vww9bypQvJ0lY4dbe4qVoh8s?=
 =?us-ascii?Q?X3rahiNjrRkBjApe++z09+53/Yer6ZaCfNtU7UbB4cXshtNDt/6gL/vYSEqy?=
 =?us-ascii?Q?DyZvUeCt1P80TgMzEi8Su4ErA1LXoVhRLAsxtSvFPMxEJm2I0ioDe0cxgWWc?=
 =?us-ascii?Q?XYqEmFTFSaM2FLAFI7gPt+kBbxBlseE1jeTnvU62a/Riui9zOrOWraqKOuPY?=
 =?us-ascii?Q?dkHvaGHE3kkRD9Im3nc27cr8HlltXLpLuRxFXfG7p3XGDtJH5qzsCPNFBryL?=
 =?us-ascii?Q?DFPirHeSL8td/7D5qt1/G50YE3pOfX2fmyzGywptSopQL5We6w+FruAGd5xC?=
 =?us-ascii?Q?QXWzGTGtR3FoX1T+DatMx9L7/wAKIduktRcbo1DqlhuJbSCwatfoA2HX7h3o?=
 =?us-ascii?Q?opX7PfR60S8zU39cx4V5RC2fyL/Xl1eBiVd9ViGSVA8qfTO+KRechVaRrDEl?=
 =?us-ascii?Q?PA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7685c9-1c46-42f6-0653-08dbc8956f2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 07:00:34.3174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JL77YYJI7JSW96MzAX1wBMC61It1oAywuLfokFn1eo0j1qpv7lKEC/XeoBkfbDcayr8R6/aulpdHmzqbkoUiJfUnS62pz38+mLbZAiXnnl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5502
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Gentle ping. Are we happy with this patch as it fixes re-bind failure on RT=
C subsystem?

Cheers,
Biju

> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Friday, September 22, 2023 9:12 AM
> Subject: [PATCH v2] alarmtimer: Fix rebind failure
>=20
> The resources allocated in alarmtimer_rtc_add_device() are not freed
> leading to re-bind failure for the endpoint driver. Fix this issue by
> adding alarmtimer_rtc_remove_device().
>=20
> Fixes: c79108bd19a8 ("alarmtimer: Make alarmtimer platform device child o=
f
> RTC device")
> Fixes: 7c94caca877b ("alarmtimer: Use wakeup source from alarmtimer
> platform device")
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Add fixes tag.
>  * Replaced the variable rtc_pdev->alarmtimer_pdev
>  * Added the check rtcdev =3D=3D rtc before unregistering the real alarmt=
imer.
> Note:
>  This issue is found while adding irq support for built in RTC  found on
> Renesas PMIC RAA215300 device. This issue should present  on all RTC
> drivers which calls device_init_wakeup() in probe().
> ---
>  kernel/time/alarmtimer.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c index
> 8d9f13d847f0..04d67de8b1fe 100644
> --- a/kernel/time/alarmtimer.c
> +++ b/kernel/time/alarmtimer.c
> @@ -61,6 +61,7 @@ static DEFINE_SPINLOCK(freezer_delta_lock);
>  /* rtc timer and device for setting alarm wakeups at suspend */
>  static struct rtc_timer		rtctimer;
>  static struct rtc_device	*rtcdev;
> +static struct platform_device	*alarmtimer_pdev;
>  static DEFINE_SPINLOCK(rtcdev_lock);
>=20
>  /**
> @@ -109,6 +110,7 @@ static int alarmtimer_rtc_add_device(struct device
> *dev)
>  		}
>=20
>  		rtcdev =3D rtc;
> +		alarmtimer_pdev =3D pdev;
>  		/* hold a reference so it doesn't go away */
>  		get_device(dev);
>  		pdev =3D NULL;
> @@ -123,6 +125,22 @@ static int alarmtimer_rtc_add_device(struct device
> *dev)
>  	return ret;
>  }
>=20
> +static void alarmtimer_rtc_remove_device(struct device *dev) {
> +	struct rtc_device *rtc =3D to_rtc_device(dev);
> +
> +	if (rtcdev =3D=3D rtc) {
> +		module_put(rtc->owner);
> +		if (device_may_wakeup(rtc->dev.parent))
> +			device_init_wakeup(&alarmtimer_pdev->dev, false);
> +
> +		platform_device_unregister(alarmtimer_pdev);
> +		put_device(dev);
> +		alarmtimer_pdev =3D NULL;
> +		rtcdev =3D NULL;
> +	}
> +}
> +
>  static inline void alarmtimer_rtc_timer_init(void)  {
>  	rtc_timer_init(&rtctimer, NULL, NULL); @@ -130,6 +148,7 @@ static
> inline void alarmtimer_rtc_timer_init(void)
>=20
>  static struct class_interface alarmtimer_rtc_interface =3D {
>  	.add_dev =3D &alarmtimer_rtc_add_device,
> +	.remove_dev =3D &alarmtimer_rtc_remove_device,
>  };
>=20
>  static int alarmtimer_rtc_interface_setup(void)
> --
> 2.25.1

