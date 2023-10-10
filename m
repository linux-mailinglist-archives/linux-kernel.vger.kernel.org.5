Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E647BF2D9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 08:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442223AbjJJGSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 02:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442183AbjJJGST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 02:18:19 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2096.outbound.protection.outlook.com [40.107.114.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2B997;
        Mon,  9 Oct 2023 23:18:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEtN8goVohXwwFXx81la/f7/4p1cf+CbG6fV/MVZDeLNXdN7v7/wxLiKHYlwObeg+rWEHJmp5QqO52jDiKf9pxafcR86W/DLFUFJvmYRjEPhimjiCHMA2DBuLeBJXFZZst9/DVZQcXERjudix2aMCybQsibCzLUiHWX99CDfMWBhP4XykCuJdWLB+4jut4vPpbH4B41Fbg2YkLx9Lqgd9d94/P8mBRjkBith/v3zonZ6TxwT08lqplEu207VQRNVb4ueFVLd1b5dEONTELv9ST0mzh1QiGkyotR6C9Nap0aQazc/6pyWTTJYZcafBeGyx/C8x84pOVGQgs9LXqMZ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2gXvniBxRNGTphR47n6qwz3eQFx8UQu1I8oFBAET2I=;
 b=etiOCe8y41VVlH45jEZqffruFK9bFEXpzKG8pac6nmH3yy/Yn2bD02qXY0mgvY5uA03tcNwaVKiujlUb9U1uhgYA6eHbQ6DxA6iFszDzb1STQ23fK2YZLkHEkt7I6aPBwkgzxHS0uFFgVqZQaGc1EZ6dvplxj1IjtDoCT50eH6xzGAB8F2LDgPStZojksDBgYnLPcep2CeqBOjcwQtoJkNTDLrmKMUhushmdzcXu5wn3igBOGZd9JYl232ga/yk6KQ1uVF4YXqIhZFmvwAQpHcI3gpcRL4XwyHGJUGJBGxUW2ujjdHweY97dwPpjuEpbB/sapohXrNYvs4okmgulUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2gXvniBxRNGTphR47n6qwz3eQFx8UQu1I8oFBAET2I=;
 b=Iuk0+fRjkO3jKMl7FmQWVFOFdxI0BXdmwB5ZRWLypj8wqRzC+mm7N0oiai5DcVYCrxhnvD83ohA1RIY6/TFD8UqlfOgHDH3U8fbojLfmrapyWrFaTM7R83wMVC9aGZ/xjPRghkNDbzsuXHw0dVuKuyWks/EcRNNik3h/9EJVqbw=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by OSRPR01MB11458.jpnprd01.prod.outlook.com
 (2603:1096:604:22c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 06:18:14 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::db75:e192:bbfa:78a2]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::db75:e192:bbfa:78a2%3]) with mapi id 15.20.6838.040; Tue, 10 Oct 2023
 06:18:09 +0000
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
Thread-Index: AQHZ7SyA4lmrPv0tQ0OIkUBZ8XwsyrBBqzEAgAAC0jCAAAcKAIAAFRaggABTdwCAAIkS4A==
Date:   Tue, 10 Oct 2023 06:18:09 +0000
Message-ID: <TYCPR01MB11269FF2DBFDC96B9C12D2E5E86CDA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20230922081208.26334-1-biju.das.jz@bp.renesas.com>
 <87il7fq1al.ffs@tglx>
 <TYCPR01MB112697A5D4B57101CDE27C88D86CEA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <87fs2jpznr.ffs@tglx>
 <TYCPR01MB11269C6BF3934F9AAC44F855186CEA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <87bkd7pic3.ffs@tglx>
In-Reply-To: <87bkd7pic3.ffs@tglx>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|OSRPR01MB11458:EE_
x-ms-office365-filtering-correlation-id: 4a3cfba8-1827-4783-24f8-08dbc958acc0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SK25jV0ptRsvXfM89z5xXisftjKIW5p+wJmyRcTdqSRxBkZdSgWxmrWC0AQkg9x0kZs93BNuaS+prVVRIDH/fS92BKSz2XPsJ5xfyl/3J2Outg3y3sEPTfKvfM4KMI2sPzTQJhqQJJUGAcnJPXDIl5m86hzpc57z7oTEjWawBFGJeC2J/Rc+gduPNA4w/OSa6KKxlmLmk5XIrPIyOYFx6o6KAdAb/LSBfGL+8EIyEQxeK9wnRX6ruZGp+icZowZ6+95qjSejjC2d4S3y8qUrAkZFurdyWyWCSy9Fwz4pq/ujhkFttbyJ0hdFxod/TsEYj423lhdJGJRurhY+RltKcs9GvXWCDyJGcHNLtFfPA8/qfjX3Huo2h8UKRspabnTgmnoFP4kQkh9+uTmh65cgzVz9bniacEYyIpqefTBfnuJ/d69YFBM/AncjGPmj6Its1WEryGOo6M0SY7Z2weTxXCrzSNOcH6HcACY3ZlAFzJ+sX9YAnH/oVzHSkAMb2F+g6hRhptUa5HLv4ZJAjtOmdDtYVhlv0xGrGFTDBrSlNTIIHD9bDknwEsDOLPNbPlM/1Okp51PNNPZzAK/DVNy2bLZfytyxKAX44/lM5S9/ZkDtE5MiPyHvZOLWGEUIWZYD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(396003)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(5660300002)(8936002)(52536014)(33656002)(8676002)(4326008)(110136005)(54906003)(316002)(122000001)(38100700002)(64756008)(66556008)(76116006)(66946007)(86362001)(38070700005)(66476007)(41300700001)(7416002)(66446008)(83380400001)(2906002)(26005)(71200400001)(478600001)(55016003)(7696005)(6506007)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TzM7dPAT/OhqEKGbMsRFw8vNVEuvjv1Z5DLo33AIClViAfYgkFCs+2chOWAf?=
 =?us-ascii?Q?ZQKTxBgcvn53YD4pfmPksAWy4jbn+xkpTBDccYIFQI3zzZXueunjOy+2MV1U?=
 =?us-ascii?Q?JAFkCkVJpuSM6cxDErwww0LgOoCMnLK+f8GxAh4Cn6gY/poHui6CRXCN3B04?=
 =?us-ascii?Q?tCC/se/jUIRwgbdV128oR/83hf7OoDqajGNuIDR2okhw5DYueu9h2NPSaIvH?=
 =?us-ascii?Q?Tmg11nRLTF7iTiiN6tXii5tRFtW3c1xl2QmcS1VGxOhQlpB7LT/BoYWV1tyY?=
 =?us-ascii?Q?QGMPo7j+GIga5NNfs4X1JikDkKL3P8DLxPFBWTMRGIUAJGF3wslx9powzZ80?=
 =?us-ascii?Q?5khdIRZWXDD3DlkfbbC3k3NpYbmQ2/WSiPEWMdwYAPWNevMvOnL+U/PzDLoi?=
 =?us-ascii?Q?zrwnytamBftpuh6ea6bVXwbmFO2R5G97hiQtg5FEJNrAep5XNpMMKvaGl2VB?=
 =?us-ascii?Q?r/mubePY0c6Pmwy2sxT2+hfAvr+sWTM0N26pg7gxrbRGDVZGKh1Jn48Dvgcv?=
 =?us-ascii?Q?gF0YmLAfYaO/gKTp/RFkK1tUDs4C7F79KsArus7in9oNylzAILqHBDQIS/36?=
 =?us-ascii?Q?6R5h8PIoDj7XO4LP1I6A/jBMqKohpYTgLuCMAXKJnEOPvDr3xgUvqt8dRVc4?=
 =?us-ascii?Q?6kmEYv8fA578/YGbTZHuMk251daea0opXkrF1BWWBmi9Tbbmxb1pWEFHk/w/?=
 =?us-ascii?Q?nFoILoMRh5SjyoF25yfGmrfN1BGLg3ag5hkZEk+GymQ0Y21zi3R20IaxdKln?=
 =?us-ascii?Q?w9jNRdcsUoMx+mOyiy7dIKgjUNRpAYSiw7ocUKPBd0jwfYw7wSALyzcbcln7?=
 =?us-ascii?Q?KHLgjeTN7vTxjE26vPAZfkjuu55ReG7qlIjRorfxU2PgRr6W3KiTy52Y6BSp?=
 =?us-ascii?Q?o0H8PcxPdOl3EwWMUCZAgiIn9aiDAQceasFWvek59QNJNrUJHRXFcRlJd4j4?=
 =?us-ascii?Q?V31nVz6zZIBoLiqQG7XMuURYsmrHFQ9y7kT+Sj95uBHyvOcuhWzo8Cn7np/T?=
 =?us-ascii?Q?QqDgo/uJSQI9xRYdwPneu2eapjmk0wKoHI4iIqFqWSAS4ObqfG3CE178+Se4?=
 =?us-ascii?Q?ya1Xi3YcY5LOhVOnV63CCOsqiPA6ojfDdfL+WSZdN2915nns8b+k9vrAMLtZ?=
 =?us-ascii?Q?+vR0vXEpCzQ9RPshNsne/9ej+t+APQHWPpp8aU/PQHN79/BJwsTrLe1T8KZX?=
 =?us-ascii?Q?Q52MNMVG9HMfMYuR5le31+f4F3KRoQFeexnpHEkXQE/6cBbcYMy5FbxiyUAi?=
 =?us-ascii?Q?X14BvM7RJwYlpT37HW4pzYleZs4Hkj2KM+EotnbJismM5GQpBNUWY1EyWKXX?=
 =?us-ascii?Q?ARPYjeHiZRonlCo2bTwFIcFbhiXJmZvwdqXdwi6iCOs9ylJLpCgXrabRCFJ3?=
 =?us-ascii?Q?Gif+yqRvfEQyj8I52PGwivqM6PMVm/Gte9KptYsLYhcxKEe9Du2aAkDAhcUn?=
 =?us-ascii?Q?sEIjtU6Xe15uvSlKR9KJ4zfBRd/+VCOUwShyPztNDMrbbeTmRwhMKEjz1EG2?=
 =?us-ascii?Q?FquVLogAJ/6O462XAD+Qw9mW/q3txKcNcQw6q95XSM116hPVJwHLlOjurvio?=
 =?us-ascii?Q?HCfzcAjAy/wrdBzhAF6V2T5h+UKyCYz0mnJPZcMKLUnFq+nGHwGG46W+S8Y2?=
 =?us-ascii?Q?1A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3cfba8-1827-4783-24f8-08dbc958acc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 06:18:09.5191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MKb7BYjb8akUmKOrN/hOFdWsBnj3iMKL9Wi4wpOfgG3380R3w5L/b5muo2jfufBzspuM7cCTQlEHcSrVpprARyP6m6BW9L2jcRqfaBY36o0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11458
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas Gleixner,

> Subject: RE: [PATCH v2] alarmtimer: Fix rebind failure
>=20
> On Mon, Oct 09 2023 at 17:02, Biju Das wrote:
> >> On Mon, Oct 09 2023 at 15:30, Biju Das wrote:
> >> > You mean we should update[1] (charger-manager driver)as it is the
> >> > one using alarmtimer_get_rtcdev()??
> >>
> >> # git grep -c alarmtimer_get_rtcdev
> >> drivers/power/supply/charger-manager.c:1
> >> include/linux/alarmtimer.h:2
> >> kernel/time/alarmtimer.c:10
> >
> > kernel/time/alarmtimer.c has alarmtimer_get_rtcdev()check everywhere,
> > that is missing in charger-manager.c. I will add the same, is it ok?
>=20
> The code does in the init function:
>=20
>       if (alarmtimer_get_rtcdev()) {
>          ....
>       }
>=20
> IOW, charger-manager.c expects that alarm is working when
> alarmtimer_get_rtcdev() returns non NULL at init. So ripping the RTC devi=
ce
> out under it is going to result in a disfunctional driver. I'm not
> convinced that you can fix this by sprinkling a ton of checks around the
> code.
>=20
> But that's not the worst of it. The alarmtimer infrastructure is generall=
y
> not designed for device/module removal. Why?
>=20
> The posix timer interface is fundamentally expecting that an armed alarm
> timer is actually functional. The fact that the class interface does not
> have a remove_dev callback is not an oversight and holding a reference on
> the module and a reference on the device is intended to ensure that the
> device cannot vanish.

Thanks for the explanation, I am not aware we should not remove RTC device.=
=20

>=20
> The changelog lacks any form of explanation why this is required and how
> removal of the registered RTC device is actually possible. Neither does i=
t
> provide any analysis why this cannot result in malfunction.

RTC driver is defined as a module, so I was testing
remove/unbind followed by install/bind on RTC driver to check
any resource leakage and found that device is not working properly.

As you mentioned above, we should not remove RTC driver. So I would like to=
 drop this patch.

Is there any place we can document this to avoid another person doing same =
mistake?

Cheers,
Biju
