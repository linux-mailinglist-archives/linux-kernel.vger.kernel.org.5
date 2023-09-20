Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6737C7A8377
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbjITNde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234646AbjITNdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:33:32 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2135.outbound.protection.outlook.com [40.107.114.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9DB9E;
        Wed, 20 Sep 2023 06:33:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjbjOvREyODCbi8eETgNBHjyliLyzYJNlZ0VZPd/OEkwCrgKl8qvWivRo6yzuJiKe3aHyvT7un7V/imSCxP2uyGxoTMBVIA6h8a0hUOW5l0nkT1SCdG/RFzRWYrazyg9BoplaApgvaiuvcD2ag/jR05MtQWM2DPfAGX/Tmc9JlUsEzMS5Usm3CwC/IrGk4a9GTbaitVXHWI+vJPYLayWFnG/kHGsxVRsCq25I51V/sltdn1bet1GKY/jItOmOamjUacjQxl3HhZE/7zQST4WgGk7WloWYCmKCMLUuriIPfysp/0IuM5GoHha57FOCrhjC5iJZ2hPF6Nl9dBfe5zQ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7HbrAO2tKhQjlUQWQ+4ql1lxSP+dYyZf4RUR0Xy72A=;
 b=I+hiSyHbGWhpdwFnvM3zkUMcnM1dqXlndE7lm13fkaDbiTDS+wQfjAd/P8R990HzocXbYntIvMazTuiz/6mKlprnZmTmkW6sx5ssbuZGsgalewVB+ZZ6NMKZMn5Y0Y+LsEf0RXkrxz8atZLwdq7LWfYvIWdOUBalSczxllSMmnWONcdzksvLIhYQ4BdmarJsH0qKy2HYEqc/+1L7oHlj/rK7bLpi7kh9y/miwSaoXGIyAeP8LFMGBXw8bung4YxfzaUUSAN7lriAyp1KAZ/Cx2bCCPeaFYAAfTW9TdC/VPMX7ejf1Cj33BISTPWerXGd0es9oqF3Z303lTfRuLtmjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7HbrAO2tKhQjlUQWQ+4ql1lxSP+dYyZf4RUR0Xy72A=;
 b=N5T6GGXcQX/u+FZPssgVosSlqO9DHdrrAHM6vb8ACThp7O0+W4wmz666rQ4MgHqstwePLgja0qlM+7A8G4qG/yoB/VJ/HmDf2zZRTaceyp3mexdVG5Ju5v13cNmNCgou/GO5hOaKaoXgsuxsPE8t5ZBgTXjROJSCPJoU4LSsg8w=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB10115.jpnprd01.prod.outlook.com (2603:1096:400:1e7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Wed, 20 Sep
 2023 13:33:23 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6813.017; Wed, 20 Sep 2023
 13:33:23 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
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
Thread-Index: AQHZ67nxDPIpzSJRaUGrxRMZix2AJrAjtMiAgAAA3DCAAAChAA==
Date:   Wed, 20 Sep 2023 13:33:23 +0000
Message-ID: <OS0PR01MB59224AE12B2266CFA4A973E686F9A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230920115935.144391-1-biju.das.jz@bp.renesas.com>
 <2023092013265355e7a02a@mail.local>
 <OS0PR01MB592280D33C80AACADEB5958886F9A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB592280D33C80AACADEB5958886F9A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB10115:EE_
x-ms-office365-filtering-correlation-id: a9566ceb-51b1-4ddb-6647-08dbb9de2989
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JbvAhBuTgHbv1qWnLXHwmLu4UQxsVKu7ckl5dTG2JVfdjmVST8emxoKPB4Gu8Wh/7c7+yockz8/6hje2Brx3D+UMEMsDf9ISB3LT0lhT8wZB9FTiQ6tjVinakWpfLw+WQ3+Glj/foqSIjEIVTfXhou01K+KoR7YwQAYzdLR8l0xQa0B45+Y1GajyFz5U5KlZOqQV5is31PH4j+8vJV7RnSD3C1t+pS97aAoY+l4Q/5fgwN6FOw58xJZXWUroMlcUCBzk5U2KDKz2rmhisLc3lyE9lgNtup9Y+xMoTYCH/4bAxfuK6AGEGY/Cg1BnyHCCHAvt0J8ioeimbC6aXs72wiKVG4TWznE4l7ZkcX5u9ipJUk6kprXBkYg6rd4tyOdbO1657vr+vBJc37aYlbp6PPh/tHjpGzSdYx/PwKpM/igvy+bWoA0TZgeqBV8fRPbpJV4M805W9q+krj0pN+RPszx5GQRzGrPgUuElwcro2KYzfi6kLJwP7o+ExCM/XZSVnNHs8GdeLNcK12ns/MI5XoXBQqjoxYAYhFUGaPLjnX3GirbIDH0Lk8FHOxv5E61E9ZXEgR6GvNakJnID+ekMioEr3vYFG9dqWlkZXKQE9Cqx8T4jGJsZfkzRV6qwmHXH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(136003)(366004)(186009)(1800799009)(451199024)(2940100002)(71200400001)(7696005)(9686003)(6506007)(478600001)(83380400001)(4326008)(7416002)(2906002)(5660300002)(8676002)(66556008)(8936002)(64756008)(76116006)(66946007)(54906003)(66446008)(41300700001)(316002)(66476007)(110136005)(52536014)(86362001)(33656002)(55016003)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w+FLR9Hmk9BSol4ArWxirXkGyIeX0SzHSNz107dXQJvnhOhVds4WJaXVYZTT?=
 =?us-ascii?Q?GDgn8a8TyyEaKRDOKEAXG+4qtPNBsDDDJ0MJCV9GbU+9ogn/YgjtmISsE58g?=
 =?us-ascii?Q?KVONCmHVsaX1AzsLtZd516YdtXLVE08Wvo3CICyN3fU98cA6Y6Olf7k0YnBg?=
 =?us-ascii?Q?D6aQgHgZFsaqcuhKxkkhaMnzjvuKxQaYtYpXvcB/mod5WK3q89zpfjl7r1C/?=
 =?us-ascii?Q?0GLkGd+kjLqBBnIJU/LjJKydlUvQyi432I9JqdmWkyW7zlXZLt+I2iJD1vxG?=
 =?us-ascii?Q?Uw0PQDDWWC7ltleU5gZTsqVQ0un5j6wXPL/mOhWO7DsXoO4p9SHVDYV0v49Q?=
 =?us-ascii?Q?Px0V3x9ELsWVwqPEBfHAO1tkL9FvaOSzXzxSCDtYC9dlN3Q9csO7psIHa4JF?=
 =?us-ascii?Q?UPzEiooXzT9V4oY1vPA3NPwv0PG9FO2Q+ANqffn1ChNHm+VBWJvPcfHXj2f1?=
 =?us-ascii?Q?46LpiRNZYPZ3AaLy15xzOqyQfTRxoAAr8Vkrrm5/qK6yDH/BWmHGVSfCyn4p?=
 =?us-ascii?Q?KBx3R52WUbfBHnaYySxDfvat4MKJwSyJCVRq+UqEaxdrhsvzYlQFT5PkRcYy?=
 =?us-ascii?Q?VegBO04NKB86ZJK2ce7qW9ExPAryF5FA41k2R/fz87GxkiQkSloE3Pa2zcN+?=
 =?us-ascii?Q?/TI1uqVQ/2Dof134ZXRTaJcFE1EvZoUARcdvxbJua6+2sajLTol6lbwnExlr?=
 =?us-ascii?Q?BfBnvQMcimcQoNyG1TUunw2V2M2WdV5gMfA82L2eGrAZLme4bnpAbSdrBBHE?=
 =?us-ascii?Q?LVaHDHCdtapDXBKzkPV8Ne69ENWKinCR+apl0j5B7F+9Mi+w0/VpRaLmFw4W?=
 =?us-ascii?Q?q+QIW+Ff5T1762ltX4RjWZmkJ5H4rqLSSDB+LA/FWEGKzmSeiSoNirmoQLJF?=
 =?us-ascii?Q?TlrND5wMmn0HY8X69JOHDUSrWoYk7O8e51Iekyp3SWYo8lPaED9g2y+4pyAz?=
 =?us-ascii?Q?scnu0a8q2UC+0f2h1lK1Dbxgtg5CvLIxqTQQM30Tx06JOWs39XLczoh+j+L0?=
 =?us-ascii?Q?eR/TgH+84vqnw4u4wb1vd+2vYNAWOP3dDM/r13EtpJ5UZ9+/mB6bOzAJY3J0?=
 =?us-ascii?Q?nx6jIF7XRhoCl9PZbkf0EI6Rak6M2nSYD9OW2ryw8/6YM0R56lM4VJayz1Ti?=
 =?us-ascii?Q?jMr23wkz4ovjyhu9/ZIK6NzsljkVrZj/H62VdXiGs3YU5Cf5B8VxTwu3yLt9?=
 =?us-ascii?Q?wx+HwQJ5utukpFMkAEziB3D8AI0awqNTgHb7EaAfR6nqfKsh1z0k+RevO/t7?=
 =?us-ascii?Q?dALOny6HHAra1/xFR/U8wvKymksdP/ZR9qZYIyhV/o4aOSnbJruYPOJsxWF4?=
 =?us-ascii?Q?QINYeMexOk1dynfzOqwPf3pZg60nVFObdHDcrCfm1F4k9HKi+/jK58Omt05Z?=
 =?us-ascii?Q?1OnW5qE3R8250ocxE0YTnjoW3UrpvsqJDkWc7fc9hwg2N3QKJ1PVQoxdzIOw?=
 =?us-ascii?Q?7fx896/4cVhXYXKeN9o/DlUd9Y5/skX4vcKTb8QzdVWb1VIMbYbx4MU4K/Kw?=
 =?us-ascii?Q?L0BFaXFRmvMhaSEQFRYMbyrJwnhCDC2BZaln3PKIHKZ4+QuPZafl0eLfMVF/?=
 =?us-ascii?Q?jinvn/p4+bZUfTb0M7Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9566ceb-51b1-4ddb-6647-08dbb9de2989
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 13:33:23.3259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1PB+tn1dhlm/S3veRBCzY5bOYSM0WME96/2YG5iPlfIFNDdDwU9lkeMjN7Qqcf0yQ9/5MjSkklK+J6N9wWbzvJvmyAnG4Fil7Rfi+RKOBt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10115
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: RE: [PATCH] alarmtimer: Fix rebind failure
>=20
> Hi Alexandre Belloni,
>=20
> > Subject: Re: [PATCH] alarmtimer: Fix rebind failure
> >
> > On 20/09/2023 12:59:35+0100, Biju Das wrote:
> > > The resources allocated in alarmtimer_rtc_add_device() are not freed
> > > leading to re-bind failure for the endpoint driver. Fix this issue
> > > by adding alarmtimer_rtc_remove_device().
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > ---
> > > This issue is found while adding irq support for built in RTC found
> > > on Renesas PMIC RAA215300 device. This issue should present on all
> > > RTC drivers which calls device_init_wakeup() in probe().
> > > ---
> > >  kernel/time/alarmtimer.c | 20 ++++++++++++++++++++
> > >  1 file changed, 20 insertions(+)
> > >
> > > diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
> > > index
> > > 8d9f13d847f0..592668136bb5 100644
> > > --- a/kernel/time/alarmtimer.c
> > > +++ b/kernel/time/alarmtimer.c
> > > @@ -61,6 +61,7 @@ static DEFINE_SPINLOCK(freezer_delta_lock);
> > >  /* rtc timer and device for setting alarm wakeups at suspend */
> > >  static struct rtc_timer		rtctimer;
> > >  static struct rtc_device	*rtcdev;
> > > +static struct platform_device	*rtc_pdev;
> >
> > This is the alarmtimer pdev, not the RTC one, right?
>=20
> Yes, it is alarmtimer pdev.


OK, I will change it to alarmtimer_pdev to avoid confusion.

Cheers,
Biju

>=20
> >
> > >  static DEFINE_SPINLOCK(rtcdev_lock);
> > >
> > >  /**
> > > @@ -109,6 +110,7 @@ static int alarmtimer_rtc_add_device(struct
> > > device
> > *dev)
> > >  		}
> > >
> > >  		rtcdev =3D rtc;
> > > +		rtc_pdev =3D pdev;
> > >  		/* hold a reference so it doesn't go away */
> > >  		get_device(dev);
> > >  		pdev =3D NULL;
> > > @@ -123,6 +125,23 @@ static int alarmtimer_rtc_add_device(struct
> > > device
> > *dev)
> > >  	return ret;
> > >  }
> > >
> > > +static void alarmtimer_rtc_remove_device(struct device *dev) {
> > > +	struct rtc_device *rtc =3D to_rtc_device(dev);
> > > +
> > > +	if (rtc_pdev) {
> > > +		module_put(rtc->owner);
> > > +		if (device_may_wakeup(rtc->dev.parent))
> > > +			device_init_wakeup(&rtc_pdev->dev, false);
> > > +
> > > +		platform_device_unregister(rtc_pdev);
> > > +		put_device(dev);
> > > +	}
> > > +
> > > +	rtcdev =3D NULL;
> > > +	rtc_pdev =3D NULL;
> > > +}
> > > +
> > >  static inline void alarmtimer_rtc_timer_init(void)  {
> > >  	rtc_timer_init(&rtctimer, NULL, NULL); @@ -130,6 +149,7 @@ static
> > > inline void alarmtimer_rtc_timer_init(void)
> > >
> > >  static struct class_interface alarmtimer_rtc_interface =3D {
> > >  	.add_dev =3D &alarmtimer_rtc_add_device,
> > > +	.remove_dev =3D &alarmtimer_rtc_remove_device,
> > >  };
> > >
> > >  static int alarmtimer_rtc_interface_setup(void)
> > > --
> > > 2.25.1
> > >
> >
> > --
> >
