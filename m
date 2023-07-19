Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8EE758E0A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjGSGn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjGSGnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:43:53 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2138.outbound.protection.outlook.com [40.107.113.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CAB119;
        Tue, 18 Jul 2023 23:43:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXj2KdAgvvweotSsq9todfN/7lhQ8A7wAvkW8EOeV5E+ZzF9690oivsuOWcAUc7Igjqgze9UYXKwH/pbVo3sEJ7M0a/1x5mhwMTcoFznHvO+e8DpJrslD4lnSE0SyM6Lg5e9d97aj2eCdhZ4W1HVxgGqSjSp3ydEDHDLRfRSlu/DDcCpcvU6XNIJoUq3YpMVIY01zLA0Y3X5722V8byCmOl4xvj9ZUND3+2rx+yTSlIy7JXO2DGFOBo6vu18UOzhv7WvR3VyJcp3ZbNGpfAgcUhwN2MDek4i3qhhrLMU6tVJT1huHPT0Ysm0XlkI+n2t1vKYOv1P0VHsqfC7vlNW+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fEgbmnMtsSLAhGN9vgThIiH9MErxjU8GaGThItpRsc=;
 b=nXIKoa7ZLeqoQmeLBNrWlprQiZHQU3aMD+iskqYc3NT2SBFpxvWr6d9Wox4+XMmZMC77UXif6SrJpo0e09Nsu207Tt8a/gdDFRaNkGmFmsOiQx61Qwoyy+Tgz4Urr1FJeoWX1DN8ZjtUfK9c4lTgghSIzTannl9Dc3WEP1SeaFi0iU1D3oBFDVyK4ZwcX/vDfEqkOZrF+3dxzy4MNeW76MmUSjheBLRXl3XNMc53vM0Or8jLhoudRFcju6wM4I/QLQlHH34JYnV2gIwpil6bolmSnE5VFdBVDWKH6bVPQZHRX/f+DeQMjt19gxiaOow18nEWBvbIUn/9Bt5ekaYlAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fEgbmnMtsSLAhGN9vgThIiH9MErxjU8GaGThItpRsc=;
 b=nEp+LLmUWtXdt+yzhS07WPBsANo/OCW112uZoahuPcM4iiSQL6Eem/ChiETo8pozXYUgtFjsfBo5IcdASdlWd055rfhf08MtU8TYBA8qeTYuDbPLDmZvpk9rwSHMuJBLNtEbnw71YEL7aLjxJMUJFRQbu75vmUdoytzdD9FqGq4=
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com (2603:1096:400:47::11)
 by TYCPR01MB10414.jpnprd01.prod.outlook.com (2603:1096:400:246::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 06:43:47 +0000
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::ef83:ef86:806d:6558]) by TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::ef83:ef86:806d:6558%7]) with mapi id 15.20.6588.034; Wed, 19 Jul 2023
 06:43:47 +0000
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
Thread-Index: AQHZuLEfke7PxT5AM0ulEoLw/IRIvq++HaYAgAAHzdCAAB6ZAIAAA3QAgAAChWCAAZImAIAAxbxw
Date:   Wed, 19 Jul 2023 06:43:47 +0000
Message-ID: <TYCPR01MB593346FBBA320260A290EAFD8639A@TYCPR01MB5933.jpnprd01.prod.outlook.com>
References: <20230717131756.240645-1-biju.das.jz@bp.renesas.com>
 <20230717131756.240645-2-biju.das.jz@bp.renesas.com>
 <ZLVlIPHdmEGdG5D1@google.com>
 <OS0PR01MB592264ADC86061AB003048DD863BA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <66228ad3-c087-418c-925f-b9fd4a60fb16@sirena.org.uk>
 <ZLWIPPAfeR1+KbeH@google.com>
 <OS0PR01MB59225D8CF3E96808DD776A8E863BA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ZLbbslBiIQXFWpmN@google.com>
In-Reply-To: <ZLbbslBiIQXFWpmN@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB5933:EE_|TYCPR01MB10414:EE_
x-ms-office365-filtering-correlation-id: 6a42c638-69c8-4915-95f5-08db882380e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E23iwrf5mxvAu9PvnKiUMPF01brHaCEO0yHZc8KbJRlryWVqCu2Srqm7DfJPSoyLR5vQCXQs4tuqAVEKUmSqbOEiwdzm3fExxt9Yag0OHNVj0aSZkn4xY9IMNZQhxLytk1UeXLwMUr1etKlJ6xbAdkxhhHMxIgm8xCweecsZvJ8lCPCvfNexaGvizKPg48RQCrvV2kfEd+/boA/qkzO0nOqLb5v/I/1+9JhsUugbl0ju2Rc5KBqyasQFIlOpOWszq5XwhHrbS3JrawljXoXbpvo2sfGi9yjNEV+vfm3BtmC1+1Dn3DQ1eygoM4Cz6D4+nEPT5gAwVzS7imG7Hw2m+lH77au+A8bM5aCC4nBuFf2SLnyaU2Lz8d6l7rNNARCfTDdDZXfuQzjHlUW3moASEEvonA4UM3Hjgt+0DRnc8NtysSLN71idUZrg6U8YDbdnVPHo5LbZOXNw5/NaPupw4lFpSSx9v/UHpzeIDaMTDQKQXq/i+n2xgxaGG4uaQpnuPcS3ZttFgWhr9GL4suCWY93hqiexzyxTZ3fOtvww2ACc9ixRQbI5kqexT04prE4U0oCBIs7ShBXzIl0sSScxMatYAuB2LuTCgZXo74BQ/pmG3nNyISA4OJr/kSrlp3+uXeZn8VrVkwwm9J26PU5S3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5933.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(6916009)(4326008)(64756008)(8676002)(8936002)(7416002)(52536014)(54906003)(41300700001)(66556008)(66446008)(66476007)(316002)(66946007)(76116006)(5660300002)(38070700005)(2906002)(55016003)(122000001)(478600001)(9686003)(966005)(7696005)(33656002)(26005)(6506007)(186003)(71200400001)(86362001)(38100700002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TVqC+gk71RsKpvQbVkKfH1u48BvpUi+qLIVCNhSS+y2UsxMcDrsVr/D47r?=
 =?iso-8859-1?Q?gLaqmz6nd0jr3p/8PC0uOFWerjLUD+ZbQuQjqlyn85rhFG3r9rIZwOsJsb?=
 =?iso-8859-1?Q?dDTAfYCsbB+Mm2vE8cMhmcT9sBiFI6Ov0MrEEgRNrhRXEGPNT24dbeqLYF?=
 =?iso-8859-1?Q?bFBkiWws9WSq1RZghO4PJ88l0MiSwxGdhzkkMyh0R5XL8ioiIV5alTTaiq?=
 =?iso-8859-1?Q?vVnfMznqIPwR96Z6OQfeZpypfNLs21qC5ZF8rnCx3iTUsDFzxB5P4lNuNd?=
 =?iso-8859-1?Q?2ZM2mInzY5bPN705/r8nGImZRL3eHRbYZiyVae7uBcCxz6IsXQwOBA7ma2?=
 =?iso-8859-1?Q?bsJ97j63Xwi1OzMOnxZcnR2y5wxwWL71kXgfpXYAY+d23vNy+ryeuQdLfw?=
 =?iso-8859-1?Q?A7pGzgYHp8DXYydBSBu5v/G1pZ5y1U+/ouT6PT0E3IHkZRPP6QhwHS0YHV?=
 =?iso-8859-1?Q?Z2FdZMcddcPHyH02SRv/vUM4n1vlekz9Ul5DIXDrlyHyj854h4Rv0rXE3E?=
 =?iso-8859-1?Q?rfsiAoj1LQgKDEi7v20IKSzYqFt0ckEt3IgmsFZXWUN8GWzphN/RjlZFL/?=
 =?iso-8859-1?Q?QDRl7h1MT3mFmMTu0rPpR6FgAR7kiJqhKiTW/Nmt4vHvAzHSNCg1NMgDNe?=
 =?iso-8859-1?Q?fdnpNE2L9K4pLNGLGvcWK7M6Eg8Usunx5eL2FWi/CFAMfjRXT9JTHpTlHa?=
 =?iso-8859-1?Q?WSnRQNHdF7FP1xRqwEj5XbwRMTaGAUyVs7DeqUGzAgkkn5Skt0O717+OyN?=
 =?iso-8859-1?Q?OdRWwzZCTq4y734RxiLjYGnBC+p2VylutcWu1/O/jLXZZtm+pKrwnAkLwU?=
 =?iso-8859-1?Q?r5cE/Id/tkpYZq/ccK3A4DcNOIVk3wjudHqBkPLeZL404X1F5ntkA3zM09?=
 =?iso-8859-1?Q?l1KEaG4YwSJm0p6WyD3uBGSvfwvtm3Ffh8YvnyIgRNEYBSFfKGp2tsvuje?=
 =?iso-8859-1?Q?EGMzu1A1y57gKZIDdCckMhPgSHcnHAZTQFDxTrSEZon1FA38uBU/z3BipX?=
 =?iso-8859-1?Q?ouEaF/8thiY1FJygpg9perAQ+YqxV+pUJPi9TRx8rcNrnz3Gah/GwQSOkr?=
 =?iso-8859-1?Q?SLrBY4IGCb6JSwNqOnPzTL9SK2P0A8Hgtcz22UVARoS+svNPx/1Ov2+OmI?=
 =?iso-8859-1?Q?RJ7mAHvg1xMlRW85rYvzeZe+eCyH5OtXvt8SpzZRLnnFCDRVvVZ8zr5i5n?=
 =?iso-8859-1?Q?dt+dcdZMMJ+vc6vVQYZhmV1qdUIyWw4sukrgzcamy+YBCwWD2mv28i+FbB?=
 =?iso-8859-1?Q?EVA57qI9991VAUQHuxfmBnCv0KP6FvLCfoHeJD43AvE+1ZoBTL7EU8mh+K?=
 =?iso-8859-1?Q?G3Bwx2jBUzOuzMIjXgXN2328xDqEvo9zuTH4P5OTkcBfhI4uwYMhwZ9ehS?=
 =?iso-8859-1?Q?vNRMeNgSGqHrg2tok5vP67f5AsATvv/U3qssB8cLIqSHhfT6hWxccOhTUr?=
 =?iso-8859-1?Q?xHqa9llM9HsGubXhL239brqCaJBOQAu6oLF+5Mp4Qv802GOdtB634nnB6x?=
 =?iso-8859-1?Q?ZA095JuYMXgDpwl/BgjJjNzeUxFWvAxfT03XG+irktwQQoLVYAplhhtUj5?=
 =?iso-8859-1?Q?imauFN31hvZ/FcjEuv0SRtbIraHTyl7CMzm42i202WD6UOBeZ+mgKcTD0D?=
 =?iso-8859-1?Q?KdspUp98WjCdg4dYZALErXG3gzEjPL3qtQ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5933.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a42c638-69c8-4915-95f5-08db882380e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 06:43:47.0274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0KIdI6YCFwTHdGyJiQn1RfJYRUjCY4fRQB8TC+h+ME4nLIMHEgPFhoioeruo/42GYAvNV6OUwMpe07qMSYSHItfjsHNHctXUIZBq0PUmOTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10414
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry Torokhov,

Thanks for the feedback.

> Subject: Re: [PATCH v2 1/2] Input: exc3000 - Simplify probe()
>=20
> On Mon, Jul 17, 2023 at 06:45:27PM +0000, Biju Das wrote:
> > Hi Dmitry,
> >
> > > Subject: Re: [PATCH v2 1/2] Input: exc3000 - Simplify probe()
> > >
> > > On Mon, Jul 17, 2023 at 07:15:50PM +0100, Mark Brown wrote:
> > > > On Mon, Jul 17, 2023 at 04:35:02PM +0000, Biju Das wrote:
> > > >
> > > > > The .device_get_match_data callbacks are missing for I2C and SPI
> > > > > bus
> > > subsystems.
> > > > > Can you please throw some lights on this?
> > > >
> > > > It's the first time I've ever heard of that callback, I don't know
> > > > why whoever added it wouldn't have done those buses in particular
> > > > or if it just didn't happen.  Try adding it and if it works send
> the patches?
> > >
> > > I think there is a disconnect. Right now device_get_match_data
> > > callbacks are part of fwnode_operations. I was proposing to add
> > > another optional device_get_match_data callback to 'struct bus_type'
> > > to allow individual buses control how match data is handled, before
> > > (or after) jumping into the fwnode-backed device_get_match_data
> callbacks.
> >
> > That is what implemented here [1] and [2] right?

[1] https://elixir.bootlin.com/linux/v6.5-rc2/source/drivers/spi/spi.c#L364

[2] https://elixir.bootlin.com/linux/v6.5-rc2/source/drivers/i2c/i2c-core-b=
ase.c#L117

> >
> >
> > First it check for fwnode-backed device_get_match_data callbacks and
> > Fallback is bus-type based match.
> >
> > Looks like you are proposing to unify [1] and [2] and you want the
> > logic to be other way around. ie, first bus-type match, then
> > fwnode-backed callbacks?
> >
>=20
> I do not have a strong preference for the ordering, i.e. I think it is
> perfectly fine to do the generic fwnode-based lookup and if there is no
> match have bus method called as a fallback,=20

That involves a bit of work.

const void *device_get_match_data(const struct device *dev);

const struct i2c_device_id *i2c_match_id(const struct i2c_device_id *id,
					 const struct i2c_client *client);

const struct spi_device_id *spi_get_device_id(const struct spi_device *sdev=
);

Basically, the bus-client driver(such as exc3000) needs to pass struct devi=
ce
and device_get_match_data after generic fwnode-based lookup,
needs to find the bus type based on struct device and call a new generic=20
void* bus_get_match_data(void*) callback, so that each bus interface
can do a match.

I am not sure, is this proposal acceptable to wider people??


> but I do not want driver
> writers to learn about multiple <bus-prefix>_get_match_data()
> implementations, I would prefer if they could call
> device_get_match_data() and the right thing happened in all cases.

The driver is bus specific. So I don't know, why you want to
be it generic. If it is i2c client, like other I2C api call the bus-subsyst=
em api for match_data. Similarly, if it is spi client, do the same.

Cheers,
Biju
