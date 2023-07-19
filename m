Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E0475929D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjGSKTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjGSKSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:18:50 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2111.outbound.protection.outlook.com [40.107.113.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6845210E;
        Wed, 19 Jul 2023 03:18:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nE2o5skEjbn1JKEJK4tQfHBa0dWyf5tiDOIVm/TfIZbNfLUi6OVGH0pQtxY56pmzUcI+0NYTW3CNAUWUObqohbuYvHRo7KSnD70bTmdPzpmizdIaZEaYB08XI5AG1WG5sAA+QaBSFOP/Apfe31iJhkcqX3pmU8oW4tgFcWAy+n+oYvMire74/Yl82kzhBTM19uPXBQ1fUIWsCw6CciBPXGyshkRjY7MFjDHdIMegnljTbIiRLAVQzcxpkBGSFefR/BpZYPLkunBTAMWfMgeZPMTh1oI4NGAXrF5V/xpqAeZjt9XYsNgDPqbC5r6hhI+jb27qzyk7m69lqjlnNT56UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmkhU2dfdfNg+AuxiJE2LmtbHpbTNVr1ok8SP8UJqIQ=;
 b=SmO8qmo0yt6IMs9G6T1CEWmL71ENdkylFAFDWd+cRXJUC/Neb4+ifok+/r5Kkh2To+9TVZoZk91clpDSgqPGk3zD4w5ARf++1n3QqW2KaLnCfMsKitkh3x2s4AAFYUmBA+63xzi8sFAD3Z3kgi2Mvo6o5bwddh/TvzsIF3vYyRHabsFUAfbS4fxGJOrR4KtZwuwWTaSD5hjaobQVMtUXbks8NTkHfFb7hP01XltB8IYOAuF7GqpVb5L4l/HH6c4XLZwhaiiwmaMEPmgrDlL68yF1UOCyCZoA+3mHURg53yrcmNMPHbMUv/aXAWbNmAPCq2ihsVxeGYUu08EwUHImAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmkhU2dfdfNg+AuxiJE2LmtbHpbTNVr1ok8SP8UJqIQ=;
 b=BIex4t/AsHIBWPzrQpnwmIEFpBaMF/OJYFNf22upiUyVkigcMwWnz7LKMpGT58+8N/EziGixjYw8AWQueY4o2+4h26/QeOfkH0KVUTx0sEnZfjyFauyGdJzQo5OuBqiwsM3EGdjD7QhwiLK+ZFzRGxlFfjunu3mFFQxFLthTz5g=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB8131.jpnprd01.prod.outlook.com (2603:1096:604:172::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Wed, 19 Jul
 2023 10:18:34 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95%7]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 10:18:30 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Randy Dunlap <rd.dunlab@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: RE: [PATCH v2] pwm: fix pwm-rz-mtu3.c build errors
Thread-Topic: [PATCH v2] pwm: fix pwm-rz-mtu3.c build errors
Thread-Index: AQHZuULWGO/C9BN6KUGGSx2mRQXL7a+/bdMAgAAWJgCAADtRAIAA9rwAgAAq4wCAAADZ0A==
Date:   Wed, 19 Jul 2023 10:18:30 +0000
Message-ID: <OS0PR01MB5922FBECED98089BB36841668639A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <ac8d6190-06ae-b538-1293-07efedbfe94e@gmail.com>
 <CAMuHMdV-wu_XHy_qYGM+_UOAXN8etip731WxmgEmbQdv+SPwbw@mail.gmail.com>
 <ZLaSqhsJr2qH5Y6E@orome> <20230718165716.77hllvxiwia542fu@pengutronix.de>
 <ZLeTZtQ_WVzuUqeM@orome> <20230719101352.qu7az5i5c5lrndwi@pengutronix.de>
In-Reply-To: <20230719101352.qu7az5i5c5lrndwi@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB8131:EE_
x-ms-office365-filtering-correlation-id: 525a8447-f438-4bd8-e5d7-08db88418018
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jkd4nKqahat2Fdc7v6tAUPk2xS2VjKDf8zpNE57VBz4z83+22/Kw2ETF5DKWHE3uS6aA0Z2xvE4/NSc2TzXxtrJq9qcZPyPfvZOZvDiwgcAk6IFguz56yE6wk6m6BzJCRMNuQrNNCwOMrfCuAWzS8bf1JVG3Lx831qvc9Q1/b4+T3Z/dEKqiW7U9Vu7QGnzGVhL2sWEqT/Ub3m6Gx/QD8GlKsDpEd/IQ8DHgpTR8Y/kb5cRmqa39LMEz24pvH2WgJu3mEo7tEX5CGq6+Lu+Ro9WqTexLVIq6J+++Ft1IHs6c19Q7N2W8HUcGKWKlh/wpNOstahX5NLsX8Y+EYKV9b7DTWL4Bc+UqD3WZw1Z9qu4znnfNbBlfZ8FhK9lJy75yq9IlfYite3UaW1+E5gGJCjArO3xBFmtn5Iq99Ri0xKAWioXUmC+GD4OY6ucHNndFPH0rl7za29+1UgEbP9KHsUY4L+uzgGpxn1UiW8uG2oQBjNvmje02CiyBnxk/zqmm6zSnVGXsR4JoylOeeW0VsZvMPuG2/iDDsM14o3RWAad7bw+EFUwzwKpfrZ52RD5opm7K3qeKSTIwTSjTD+ycVVozIz2m5ONB7Oo5WX0wnTU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199021)(8936002)(66446008)(52536014)(8676002)(316002)(4326008)(76116006)(66476007)(66946007)(5660300002)(66556008)(64756008)(55016003)(478600001)(54906003)(2906002)(110136005)(71200400001)(41300700001)(966005)(9686003)(6506007)(7696005)(53546011)(33656002)(186003)(83380400001)(86362001)(122000001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kLJJtV+wjJbHP5irIc7TupNiF8eB0PDKtjE4DLa8BVTd12GQvFHhWjaKzU?=
 =?iso-8859-1?Q?cNQO6MMRPd9jLxJFk0C0nKrwRpumq+h0B9fNaEto7Ctgw0Qv4oPTBm73T4?=
 =?iso-8859-1?Q?P0B8IsxeYqMJp+4/PvxGjheXaZYwszc3Z2UWwI7oFjt9CNLRE/7sd6YAjg?=
 =?iso-8859-1?Q?XClilbpzdUD0D0fy7IJYZlhpmnuoHEvokAnZQg4GAHtYkehAz9FpJP3Ynp?=
 =?iso-8859-1?Q?N/hi1XgjSCj4v7+WBFkIqF1Sq8DQtWgWdW8PyoJQK5oxGK2LykVxQ4LUyj?=
 =?iso-8859-1?Q?nceANMXR9u8ATanDoXZAhgTshwKmv4gr4rnmOrx4AaQmng4ahqgiV4NaeY?=
 =?iso-8859-1?Q?0jWGioP1ZY/4fGrU69G/MxDR0Sdtevx3AVd7YS8jNBDlrMvUOQRDYajjXK?=
 =?iso-8859-1?Q?A1u7q2pcjS0nOjO5Mr8QhJqU1WMB9E7thEJoLmIpbZqIW6Xxu65B0eA/bd?=
 =?iso-8859-1?Q?n4m/oQg/VK5BrwQnY0zvOMRCVQhITQJtH3eo5dQ4FNpA/e1IqYOYEmSdwB?=
 =?iso-8859-1?Q?ppMFbPbgzhfWRU6cTVGmwVo98wAMAE8GJdWNa6O9YvcjpPkcpJ0DwZNgV4?=
 =?iso-8859-1?Q?ZXcXGKwdRhKbmyvf8JTyfh1yHzvW93x5p7CKWpysfzJUu2B06G3IVY9771?=
 =?iso-8859-1?Q?j72hcPGBvUExme32TqGg/Rw8GRh6k/zyoTWWiWBHfik4JrJuxC/cMBNxRK?=
 =?iso-8859-1?Q?YxQFwi6mzjzzqu6krhQc6JIlzt6I/kJmYedDTntz0gL3iBwN6hUa2UG9xL?=
 =?iso-8859-1?Q?TvK57LskcBWH6UEinYNSOpeK8XPO/3x4vAam9RwaqnHs1TJrNqhxzm8QoZ?=
 =?iso-8859-1?Q?bPXvXBL/wnubjNxfd1wO0YVZVx6NQbIAU8qJIATKF3R5CT+tnkOpp5ozW3?=
 =?iso-8859-1?Q?Uom/Bh0COnHCUdZ4gqwLb6Ntt5Xwwo1AyFgMP7QTktwdFDWfsZL7VtBmgO?=
 =?iso-8859-1?Q?QLemtAKO5oNqyBYTejqJm0PCm7fdjJPIi6NQTzHTw6GBLyINVzvL2bYTnv?=
 =?iso-8859-1?Q?nZRDmh1//tOknWhDK6nS9d4qLgY/wt0hdHF8Wn3cWGyoKfX7WzNB0yTHVp?=
 =?iso-8859-1?Q?vBCSNpHLA9IfDxivYvdHbRYEHHJQZCq3Oj0uPtQt0YVSQ23Z/L+5yTXf/H?=
 =?iso-8859-1?Q?4XJzM731o9kASEl088BUCQ/b/6DeWPJ58kQnLd+PaPYd3QQ8IwaOjswF1B?=
 =?iso-8859-1?Q?gilsi1VJEH/nzsVYDGYinAqOV17IzWiGdTPqbWPkTWjdCYLJSKpWkeUZCY?=
 =?iso-8859-1?Q?2XDG59N8R1J+jycIBr7A0fbwSqHcP89tKP3AP9wdBfOGzmMcrtI5wVYIaf?=
 =?iso-8859-1?Q?lCJM7ijxJLEJ+znHVXFUefdD19Be2GwUZ3MdkmSiqVd9UkbiKtvQIs5bI7?=
 =?iso-8859-1?Q?SyGRLzFVGuAR91x8Of6FaMXFalaq5Mz+J4FMrZP8Eb3Rau5B3NaIr0No9q?=
 =?iso-8859-1?Q?lmL+5/v1mPyAIa8uH44DXQMVoA0Sz3asfRKDHbcJsk9R+AFaVK+rW8eMg9?=
 =?iso-8859-1?Q?mqYDUGJJB2nZ17peH05i74w7WO8nxiCUoOsU2aa6KuIIJBpVb0PDAOX9oR?=
 =?iso-8859-1?Q?vZ35b0fu05QsjzCpyaBRksMOxKFEUFI9KmjKP8s8nQ4tWKfT509e+o5L9I?=
 =?iso-8859-1?Q?s4fRcpCLNC1WE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 525a8447-f438-4bd8-e5d7-08db88418018
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 10:18:30.6007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l6G8lsWEu0hogL/LqwR1ZvKJdgqmLEV8P8pTYDyoJAy1iOcoSLWJb6XhuTYmMo79kZfotLp7AKZV8JeHwM2TGvcgOFnattXplUT8IUljyww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8131
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Sent: Wednesday, July 19, 2023 11:14 AM
> To: Thierry Reding <thierry.reding@gmail.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>; Randy Dunlap
> <rd.dunlab@gmail.com>; linux-kernel@vger.kernel.org; linux-
> pwm@vger.kernel.org; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH v2] pwm: fix pwm-rz-mtu3.c build errors
>=20
> Hello,
>=20
> On Wed, Jul 19, 2023 at 09:40:22AM +0200, Thierry Reding wrote:
> > On Tue, Jul 18, 2023 at 06:57:16PM +0200, Uwe Kleine-K=F6nig wrote:
> > > On Tue, Jul 18, 2023 at 03:24:58PM +0200, Thierry Reding wrote:
> > > > Honestly, do we really need all of this complexity? I have
> > > > specific configurations to test all of the PWM drivers to make
> sure they build.
> > > > There's probably edge cases that don't get tested, but sooner or
> > > > later I expect some build bot will encounter those and then we can
> > > > rectify things. But in many cases that I've seen COMPILE_TEST just
> > > > happens to do more harm than good.
> > >
> > > Without COMPILE_TEST you'd need to build at least for the following
> > > archs to build all pwm drivers:
> > >
> > > 	armv4+5
> > > 	armv7
> > > 	armv7m
> > > 	arm64
> > > 	mips
> > > 	riscv
> > > 	shmobile
> >
> > This one is actually ARCH_RENESAS and is armv7.
>=20
> Oh indeed. ARCH_RENESAS exists for both arm and shmobile. TIL

arm64 and risc-v too. This MTU3 driver should work on RISC-V(RZ/Five) as we=
ll(need to test at some point).

Cheers,
Biju

>=20
> > > 	x86
> >
> > But yeah, those are the platforms that I build for. It's not terribly
> > complicated to do since all of the above have publicly available
> > cross- compilers that are easy to install. Also, most of the time I do
> > incremental builds, so these are quite quick.
> >
> > > I personally like COMPILE_TEST as it reduces the number of needed
> > > test builds to 1 (I think).
> >
> > Anyway, I wasn't arguing that we should get rid of COMPILE_TEST
> > altogether, just that for cases like this it doesn't seem worth the
> > extra complexity. RZ_MTU3 is an MFD and already || COMPILE_TEST, so we
> > can easily always enable it.
>=20
> Ah, I got that wrong then. I can life with this one.
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig
> |
> Industrial Linux Solutions                 | https://www.pengutronix.de/
> |
