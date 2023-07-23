Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E0575E02F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 08:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjGWGum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 02:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjGWGuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 02:50:40 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2092.outbound.protection.outlook.com [40.107.113.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82372106;
        Sat, 22 Jul 2023 23:50:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gptXPVCGwYvXmo8IJb1ImsCorBhBs1GcsU1p5mRIYvClq39sOpuV6Nq8LwPCBoZ2yIAZTJOiJ84FhdS9XmSoPn6p0Y/6rDy5UJrU2+AAGvpaiX/oh5QQg5UQ+33H96LQoZzNvw/iCwhQo4sGOfBkw5LIHC1WKkUdGgu//FPZ1Ag37XpBQ0yvcTxImXOExfrdB+GIllBgkgt7Ctcwaxlx7HJfeFa2fcT1JUwD6IlMDr0uDxO6MFBlDdbSLIC1ZaM8cKWuRh8ega7cptH7MVUpJk1Ty3L0wHeHtqwySp/KzX77QL/kk+7MH5lye2tKjkcNy5PjwMopJZ+gcAu9ORqSkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Okt9gmjuPrl5FADNYIJ6eWvIGL5x51zGjynMRbFlzt8=;
 b=Cete1u6T/wLjU0aQ1zJ/11+HEqcRysb54YRd6rUWxoi2PwBMPu/s384xGdXZVl9o4SSDXKnLWvtO/5oLxVnYVwy881Gb4N18TM90Gw+PjtxS/XdVUzogW1+iTp74aUZixawCorPfycbmmy8bfu2dXcNnt5DESot4V6EyjQJq/qZ/65Y2YWL8iXLvSrHGZQu/T3pdYwrPTQGKSoHJaXZtWSxcR2uPQxzWMsYJoMlKA7O+tQAIbZBBi5++j1E65EczlH9LKW89LsXbKsdVyj3uSI5rJMiVQFx36dFKNufF48DTZjJETO1z8Z3gyOvmgK8X8hOEAWh55v8Wm6nThy/NEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Okt9gmjuPrl5FADNYIJ6eWvIGL5x51zGjynMRbFlzt8=;
 b=GlDOaTpwMqNquPoCCdhpAEDmPpfW5pEBBFgDLEW/r4CZUPQTDjD0eVkoCP0LwC4cD2Fj+buEB31/Nj6fvk1fsxWKZ1a7ygJUjpC0QPepb3rSdRHrVoF/Eh4yMa8bbyqrO8bFbyT7e4A4uVNuwO7YMzORFxJvOvyhVVKziJxvSY0=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB10383.jpnprd01.prod.outlook.com (2603:1096:400:226::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sun, 23 Jul
 2023 06:50:30 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95%7]) with mapi id 15.20.6609.031; Sun, 23 Jul 2023
 06:50:29 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     Mark Brown <broonie@kernel.org>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Andreas Helbech Kleist <andreaskleist@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] Input: exc3000 - Simplify probe()
Thread-Topic: [PATCH v2 1/2] Input: exc3000 - Simplify probe()
Thread-Index: AQHZuLEfke7PxT5AM0ulEoLw/IRIvq++HaYAgAAHzdCAAB6ZAIAAA3QAgAAChWCAAZImAIAAxbxwgAQs5wCAAUhbgIAAfjkAgABL7XCAABBeMA==
Date:   Sun, 23 Jul 2023 06:50:29 +0000
Message-ID: <OS0PR01MB5922328753110C5C35101357863DA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230717131756.240645-1-biju.das.jz@bp.renesas.com>
 <20230717131756.240645-2-biju.das.jz@bp.renesas.com>
 <ZLVlIPHdmEGdG5D1@google.com>
 <OS0PR01MB592264ADC86061AB003048DD863BA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <66228ad3-c087-418c-925f-b9fd4a60fb16@sirena.org.uk>
 <ZLWIPPAfeR1+KbeH@google.com>
 <OS0PR01MB59225D8CF3E96808DD776A8E863BA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ZLbbslBiIQXFWpmN@google.com>
 <TYCPR01MB593346FBBA320260A290EAFD8639A@TYCPR01MB5933.jpnprd01.prod.outlook.com>
 <ZLsCOj1t4JvG3SEp@google.com>
 <TYCPR01MB5933D4252360AAE57D90FE1C863CA@TYCPR01MB5933.jpnprd01.prod.outlook.com>
 <CAKdAkRT9tMnLnDLgWAevE_4HQ0wYMPehvsYaAeYrXdGGiyjXRA@mail.gmail.com>
 <OS0PR01MB59222E6CE0EEED3A5FE843C1863DA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB59222E6CE0EEED3A5FE843C1863DA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB10383:EE_
x-ms-office365-filtering-correlation-id: 39bdf7f7-8ad1-4431-13ea-08db8b491aae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vRdz0ncQfZ/55tre5lL3x0Ltg54n9bFbJOBWlKKFWtMccSZF/uXlOvjEj+ND6zIawveUazv3izAmlfUj9XuA4CYydLPO7g6fJGqKod+HG6EYk+/jqCJCmvEiYa66H22B0LbO1sP0HzDNvo6g4dTsBG3NA7kKHdSEUe5+BSjR/yhB2zVnUntEjCY/gwvTCBOs3QCyHxKSdi6EnZA/XqusEWg7ru2Z9EXecepODcw+RbcwU7Pp8eAbBz67hFawTP/tu0c7DKVLZ9SlGZgDp6udYl8Uu022Y6faFItQ7kuzuOw9BIC749KMjfg8cbfdKgIUTopPbKx+8JN5LESk4n5w8qcAiir4p34YPVUazK1Sz5gxlvoSE/yY7u9dP5ezLzqqd7ZFEPZ9G4OaqQIunM5CuLGvkr0acxpdaCNpVBRvIX07n1VUUnn7X80jyLLC0T6+/1ui8V+aCoFI7N+rGoVmoxVkHtbfk9lqUdsTCjcvdfaqiXn0mmeyhcZIu7/oBfr7VhJf2rL0ND/9idikcgvUH6sGyRD7wDBeJ/uIo8YXrXIwbg+iiexC/VDEeWPMVgFDo4uTkeujaPmg/DPO1tpE2/Pu0pUsWJHE1c4VZ3QHd0PpkBdpniEad9llhGKsZaP0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(451199021)(966005)(7696005)(9686003)(71200400001)(45080400002)(54906003)(478600001)(83380400001)(38070700005)(33656002)(86362001)(55016003)(2906002)(2940100002)(186003)(26005)(6506007)(38100700002)(122000001)(66946007)(66556008)(66476007)(66446008)(64756008)(6916009)(4326008)(76116006)(316002)(41300700001)(8676002)(8936002)(5660300002)(7416002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ygCYZn7krj2RKJNfIP4/z8JktEPpFzD1CsLy1Rxj0CyOGTRgSfUiKlSn3u?=
 =?iso-8859-1?Q?xYhdCnN9fFEy7VLsYVrzE0jvjWmYbrD5eTgZVVFjgOR1eB2AcVxzmZF8pq?=
 =?iso-8859-1?Q?X4P38qrKHRr13fUsKwvFqSyD45Z5UL4BumBI+UInz/FDPojn5QL3CGHSkU?=
 =?iso-8859-1?Q?B+YdDEl01gARwFKmk+Db60hIBQWSPhKWSHueR5O+JRDdM+m4DKDSKAng+Y?=
 =?iso-8859-1?Q?ZTxThufm1VO4lOsIusmfpy8+KOuBiBnbrCmkdvqjpousUN+mhjMGmptt2Z?=
 =?iso-8859-1?Q?jL0cXgf+aPVbKThb7/+vgZEaR7a1fLZjWeAtnLD7UtaJAhct1P4RhlYxy4?=
 =?iso-8859-1?Q?QtsuQc7fmp/BSHq9Quu/dQ42U4MGFDK87zeWSt1VOHr1xu2S6P6qeJJp8P?=
 =?iso-8859-1?Q?kWTMDwimXDOdk0kjRPHdEcYFx1SRNhjHkFbl6Toc2BcCTEgSyeqfwmv6c9?=
 =?iso-8859-1?Q?eb5lTSjm+Khs5+t98Nkl8KhsFj1hhWYoX8ZQ683PjovjQ7Z8JlRwbVE9uL?=
 =?iso-8859-1?Q?3nENy5lCD2B+bd0mqbbiYp7cnxeQ07bKuF1/FW4StVc4Ry9liU6kYPuO0p?=
 =?iso-8859-1?Q?DHfnjHtlImhUOez+b4Z2uhgsvQI1486tWPUbcNfSBwnAfFIcEp9dHNvFao?=
 =?iso-8859-1?Q?msC64Ioc8aDPVJqbqVUQ3Ak6Ogj6CjmmxEkos8HtFcyFMx2E8GlfjWNVsi?=
 =?iso-8859-1?Q?v2Glh3HIYzCAJkp35Uw5w6MXr3rOcGyZHtgPUo2skD7D1JHG121WF2VaJz?=
 =?iso-8859-1?Q?MOHo0qrBjWceYIqVlDIbCWyfcQUieEfBVrC2xLG9erIvK/BrdqNHG6YVur?=
 =?iso-8859-1?Q?7oWiKrx3VmxUUFBQwPwXa4bem2alLV//sLX9VXWnGFprqOEi93svrQ9EFV?=
 =?iso-8859-1?Q?yPcM2TkzRb6jxAdpJCOj2bmbxAOr7b0J7k5mEAHibjL8kfxPC8ueZqb+za?=
 =?iso-8859-1?Q?gv2BKStMNgn3RyjLy5fz62ewqP2hF+qcaKQusxMRlaL0uZ/hiW2wj/P93n?=
 =?iso-8859-1?Q?lgYVbZxzUUOP6ekc7bfhjWUJc+y9mCuZn6kFiX5qdihr+jTzdcx/6EcjBK?=
 =?iso-8859-1?Q?6QOF7Pg5cvD7AbZPUjXs3Ck7wgXvxVpnPUFre/HSZGJ4zsvOyrIlGAjGv3?=
 =?iso-8859-1?Q?2yt6O9ihsV/vmj99hDg2OZClivnKa/ZWXYyhbp+n2whPcrx15Ij9A+7DrN?=
 =?iso-8859-1?Q?MPW1LvKdCXvLZHTfxzeNdTf/Z+Gn6d1nnAcv3C9SMDb5uJJByxzWyitia4?=
 =?iso-8859-1?Q?h4jKRuW8moZ5gLG/T4yd4uN+W5DuMrIATXPkWbleKgKnom2CUhsADrA0Ef?=
 =?iso-8859-1?Q?TE9vgz4owZD956/t6qYEA9yo1R0zT4/5ces8/nMDzcQmAZ2MERtE/u/CjX?=
 =?iso-8859-1?Q?RRsk6gLjXpyGVpFArUol7Z7rDMLZopA26o9/c/LgtEp0CaHo8j9WKuCSXR?=
 =?iso-8859-1?Q?f0ragAAeabzOMhZDQN9vTn+AWBlnUWK7baw7reiNXUCiNkB+i8tv6QFvrt?=
 =?iso-8859-1?Q?7mmYs7WjK1h+uDMwsSlu1XnsIngJa2jBiB2ET3/5A8uiFRy1XIfz1IQwUB?=
 =?iso-8859-1?Q?phOLITA1BYcsHC1Z+OsFRu1iFi3maWAppYezoSbUj5Xh4NpbnQBLJMZZtn?=
 =?iso-8859-1?Q?/rzyZLq3V4HT2ABXS/q4Amf/Pka+avfHPd?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39bdf7f7-8ad1-4431-13ea-08db8b491aae
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2023 06:50:29.9482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cUBnRZOwfa1wnEG1kStUWvls/N9UDhqqCAYp9aJKt5WUMe/NjB7Q9pMPNxC2YfpncogObH8qh2NxNmUbCiXNPaGF5L9FXXVgss8bdA5XCdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10383
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: RE: [PATCH v2 1/2] Input: exc3000 - Simplify probe()
>=20
> Hi Dmitry,
>=20
> Thanks for the feedback.
>=20
> > Subject: Re: [PATCH v2 1/2] Input: exc3000 - Simplify probe()
> >
> > On Sat, Jul 22, 2023 at 05:51:17PM +0000, Biju Das wrote:
> > > Hi Dmitry Torokhov,
> > >
> > > Thanks for the feedback.
> > >
> > > > Subject: Re: [PATCH v2 1/2] Input: exc3000 - Simplify probe()
> > > >
> > > > On Wed, Jul 19, 2023 at 06:43:47AM +0000, Biju Das wrote:
> > > > > Hi Dmitry Torokhov,
> > > > >
> > > > > Thanks for the feedback.
> > > > >
> > > > > > Subject: Re: [PATCH v2 1/2] Input: exc3000 - Simplify probe()
> > > > > >
> > > > > > On Mon, Jul 17, 2023 at 06:45:27PM +0000, Biju Das wrote:
> > > > > > > Hi Dmitry,
> > > > > > >
> > > > > > > > Subject: Re: [PATCH v2 1/2] Input: exc3000 - Simplify
> > > > > > > > probe()
> > > > > > > >
> > > > > > > > On Mon, Jul 17, 2023 at 07:15:50PM +0100, Mark Brown
> wrote:
> > > > > > > > > On Mon, Jul 17, 2023 at 04:35:02PM +0000, Biju Das
> wrote:
> > > > > > > > >
> > > > > > > > > > The .device_get_match_data callbacks are missing for
> > > > > > > > > > I2C and SPI bus
> > > > > > > > subsystems.
> > > > > > > > > > Can you please throw some lights on this?
> > > > > > > > >
> > > > > > > > > It's the first time I've ever heard of that callback, I
> > > > > > > > > don't know why whoever added it wouldn't have done those
> > > > > > > > > buses in particular or if it just didn't happen.  Try
> > > > > > > > > adding it and if it works send
> > > > > > the patches?
> > > > > > > >
> > > > > > > > I think there is a disconnect. Right now
> > > > > > > > device_get_match_data callbacks are part of
> > > > > > > > fwnode_operations. I was proposing to add another optional
> > > > > > > > device_get_match_data callback to 'struct
> > > > bus_type'
> > > > > > > > to allow individual buses control how match data is
> > > > > > > > handled, before (or after) jumping into the fwnode-backed
> > > > > > > > device_get_match_data
> > > > > > callbacks.
> > > > > > >
> > > > > > > That is what implemented here [1] and [2] right?
> > > > > > >
> > > > > > >
> > > > > > > First it check for fwnode-backed device_get_match_data
> > > > > > > callbacks and Fallback is bus-type based match.
> > > > > > >
> > > > > > > Looks like you are proposing to unify [1] and [2] and you
> > > > > > > want the logic to be other way around. ie, first bus-type
> > > > > > > match, then fwnode-backed callbacks?
> > > > > > >
> > > > > >
> > > > > > I do not have a strong preference for the ordering, i.e. I
> > > > > > think it is perfectly fine to do the generic fwnode-based
> > > > > > lookup and if there is no match have bus method called as a
> > > > > > fallback,
> > > > >
> > > > > That involves a bit of work.
> > > > >
> > > > > const void *device_get_match_data(const struct device *dev);
> > > > >
> > > > > const struct i2c_device_id *i2c_match_id(const struct
> > > > > i2c_device_id
> > > > *id,
> > > > >                                    const struct i2c_client
> > > > > *client);
> > > > >
> > > > > const struct spi_device_id *spi_get_device_id(const struct
> > > > > spi_device *sdev);
> > > > >
> > > > > Basically, the bus-client driver(such as exc3000) needs to pass
> > > > > struct device and device_get_match_data after generic
> > > > > fwnode-based lookup, needs to find the bus type based on struct
> > > > > device and call a new generic
> > > > > void* bus_get_match_data(void*) callback, so that each bus
> > > > > interface can do a match.
> > > >
> > > > Yes, something like this (which does not seem that involved to
> > me...):
> > >
> > > Looks it will work.
> > >
> > > But there is some 2 additional checks in core code, every driver
> > > which
> > is not bus type need to go through this checks.
> > >
> > > Also in Bus specific callback, there are 2 additional checks.
> > >
> > > So, performance wise [1] is better.
> >
> > I do not believe this is a concern whatsoever: majority of
> > architectures/boards have been converted to ACPI/DT, which are being
> > matched first as they are now, so the fallback to bus-specific
> > matching against bus-specific device ID tables will be very
> infrequent.
> > Additionally, device_get_match_data() is predominantly called from
> > driver probe paths, so we need not be concerned with it being used
> > with class devices or other kinds of devices not associated with a
> bus.
>=20
> Looks like most of the i2c client driver uses similar handling for
> ACPI/DT and ID tables. If that is the case, it is good to have this
> proposed change which will simplify most of the drivers listed in [1]
>=20
> [1]
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Felixi=
r
> .bootlin.com%2Flinux%2Flatest%2FA%2Fident%2Fi2c_match_id&data=3D05%7C01%7=
C
> biju.das.jz%40bp.renesas.com%7C2a07c353ab7649fdf29a08db8b42cca3%7C53d825
> 71da1947e49cb4625a166a4a2a%7C0%7C0%7C638256891245437404%7CUnknown%7CTWFp
> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
> 3D%7C3000%7C%7C%7C&sdata=3DtOxuTgGKc%2FQYFx94rYUJ8TDTWmGKkETzASV3qUjP2vk%=
3
> D&reserved=3D0
>=20
> Eg: drivers/hwmon/pmbus/ibm-cffps.c
>=20
> 	enum versions vs =3D cffps_unknown;
> 	const void *md =3D of_device_get_match_data(&client->dev);
> 	const struct i2c_device_id *id;
>=20
> 	if (md) {
> 		vs =3D (enum versions)md;
> 	} else {
> 		id =3D i2c_match_id(ibm_cffps_id, client);
> 		if (id)
> 			vs =3D (enum versions)id->driver_data;
> 	}
>=20
> The above code can be converted to
>      vs =3D (enum versions)device_get_match_data(&client->dev);
>=20
> >
> > >
> > > Moreover, we need to avoid code duplication with [1]
> > >
> > > [1]
> >
> > If and when my proposed solution gets into the kernel we can drop
> > i2c_get_match_data() altogether.
>=20
> Agreed. Will wait for other people's view on this topic.

Also remove spi_get_device_match_data and
Make i2c_match_id() and spi_get_device_id() as static and

Replace all these with device_get_natch_data() from all i2c/spi client driv=
ers.

Can you please post a patch based on this?

Cheers,
Biju
