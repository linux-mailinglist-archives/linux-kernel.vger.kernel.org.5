Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301ED75E00E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 08:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjGWGFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 02:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGWGFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 02:05:18 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2137.outbound.protection.outlook.com [40.107.113.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732EA1BD4;
        Sat, 22 Jul 2023 23:05:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2/w4zUYQ3ZExlTp7i6mmiciVnjtyzESMr6mTeZyQHjM4ZGRVh7QHOX1Ax1Lt5apMb7HjZl7uUtJ2MlFn7PQiHJC8nqVjA44BylVAr/F44bYwAAF9P1APwsHe/PgDGGcOqjlHr8cdt+f5vq4YbZOTh7t4uSHARCpJbMzGG4hPZ2gIKGc4DwtrbPXFqmtrrULpRPOZD0gXQA1zhLAYgjB9ohcnk7vaA9lwehrV1rjBMrzarpCQNeqZ7vnwk80w5Z8dJUiZWgFPqVW/K+5Jc4KoIgiNk5FNgVmQQWYADoO+YUQ9jYNx2u9/KJQ49TLk11rW6ibN1OFUTPxxyq3ZlnZrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s17XvGdvK/JhvChvq256W1e68/Md0m8CUIJHWqVfvLI=;
 b=gRBWe/XlBXBZJ40mx+blfgpT9TZlUUFjtpGlX3clnDmLYXCVGtbiRj67LBj1I4quxBCsOxb0NPAMpK1mGOAePqnSVZ7ezHaAGw13mc8whh+xQ+qLtCwTe2giu/O69ffIbyiSlwaiCeh50s6p5zXqRF3Imt/9QGqL2k7QdjhM1Pcy7LzX4Qp4S7MwmpfNkwa6dBwIbDUAbxCUvH1QR/NDuDvGORemUoVmsusOQJC9GEFHQRCg5BbE0AAIsEJK6cyRNhas4ahPyavuGnqbfEco8Um/xsXTh88nT7rY6JFd1dl8Q2V58DMEj2Z2ZbnJpqS8Hxgkt1qm2FES0KipyMMhYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s17XvGdvK/JhvChvq256W1e68/Md0m8CUIJHWqVfvLI=;
 b=kRdkbqTQrFsF5kMJaGfzISB+iYxNoJBeD8kpTE5VsjjghTgY+0/Om1uBoX6/aUBRU+0o3OUUzToPHkq2tDFtEOpc6gdkRzty0oabVKGXiYV3PVVP4YfaIwIVxyX3CyeV8AsT3nzBXEvOvWiA3YJM1HhcRpYrKPLPC72SQelP/VA=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB11973.jpnprd01.prod.outlook.com (2603:1096:400:38c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sun, 23 Jul
 2023 06:05:10 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95%7]) with mapi id 15.20.6609.031; Sun, 23 Jul 2023
 06:05:06 +0000
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
Thread-Index: AQHZuLEfke7PxT5AM0ulEoLw/IRIvq++HaYAgAAHzdCAAB6ZAIAAA3QAgAAChWCAAZImAIAAxbxwgAQs5wCAAUhbgIAAfjkAgABL7XA=
Date:   Sun, 23 Jul 2023 06:05:06 +0000
Message-ID: <OS0PR01MB59222E6CE0EEED3A5FE843C1863DA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
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
In-Reply-To: <CAKdAkRT9tMnLnDLgWAevE_4HQ0wYMPehvsYaAeYrXdGGiyjXRA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB11973:EE_
x-ms-office365-filtering-correlation-id: be3e7d15-ed74-463d-84bb-08db8b42c35d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OVGsQ+erfbHW/K95x7gMy09hWaNBdOwTdP5wSlVgOlWc7r/sR9YRoyslsK3iiiAwh2N0beJqwO4Ewb23uJFPKU0qBGxK6+TnH3rjA+06JpKgrqQlxTeNn7sGFLNXqhQIFixrd4t+RuTyg5J+Dzz4fLkCxG4NGeGkS5NdjX+qwVb71soxPfNyFtj/lKGQwX29p4rMxuIucs36W8H9FJV0Ca6cnY63uz93R8Wv30DN9PTFsUc4dds0xtWBFePP0Y/TWK2RVSrA9tk0GrblDUvFpPKhu8D7tp8WLFSUu+eCaYCB+IsCTQUn7L5xuWpfrKJ6y1OhZqCF4FKuWehvLqhCEGH2EwyZx/gBBhHtf4oyOFKiDhq6uLqtwN9NpWBhVlgSu9i3RmZqaJ9TEN4s4gpf4eMqnaLLNBw2n+cpCt6fRmwKE5MRjh5H9uIrUxdmZ0j5DhUquas4RC5P5K0WJcLVTF7P/vBn29M0XEelsZxi1pR2aaudr70NojxiDA8elHUHdXNr7iooGVdDVr1q33a8iy/p+RrVunCPV5r+29JXMQP/rGoQVLjeJ1nBVJ6z4lXqCGd5hGdOhdKJXSdAVAzWj7tE9d6C2Z4V1aND2STLg8g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199021)(38100700002)(122000001)(55016003)(83380400001)(8936002)(8676002)(7416002)(5660300002)(52536014)(478600001)(54906003)(66556008)(66476007)(66446008)(64756008)(6916009)(4326008)(316002)(76116006)(66946007)(41300700001)(26005)(186003)(6506007)(71200400001)(966005)(7696005)(9686003)(2906002)(33656002)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HjOLTCgL8IftxM6hoopdCwkHwX/VL8cs0sK69rNWeVWdSWnUswk3UzAjjH?=
 =?iso-8859-1?Q?y6SMMICjWN1NikGn9eUnwIIOWQkgZCA5tC7LNOCAAwTxn6/vRyLb7zZVsT?=
 =?iso-8859-1?Q?SwXX5oXAEow2f56JbPVouq3DflDjBnFFcFnUAmvnq+rr7fvZSbj7+Pmxdg?=
 =?iso-8859-1?Q?kyJpSwTDJ9HBnpOIzP1gPsDB4T7Sls3Q0k8vdrENEaEpO6qdKt/GHMpPNm?=
 =?iso-8859-1?Q?NeHuF1mpjJn7ivdLVFvcbEvQLxedlgd8Mq7HrVw2yW0d6yc9usoUSM7tRu?=
 =?iso-8859-1?Q?wEkz3sepUHOucG7rjz955xLbpr6wbXJtp0nhKiTn86UlPKbNV8ufRXFyA2?=
 =?iso-8859-1?Q?/d2R0bmTPLtX8vWxqiwXg6s0wTd1Ekw5IFdQLpGUbqhyN4NwNwy5rFHQI2?=
 =?iso-8859-1?Q?gUTIwt2wF/jHc0BUC6FyJdLlQkQltwmN20xfceFEmkaEi74weqh/Meyzd2?=
 =?iso-8859-1?Q?8dqzsk+HNK2k6A+ML4R+Y5wp0V+x3bnyRH4o0BrsHuebIzHUR4gCF+ccYO?=
 =?iso-8859-1?Q?iGHgWCVLDi2XtNz7IfFbBaMOkt4TcBRLSGLx8WZ77WGt5bzCtLe15G5wyi?=
 =?iso-8859-1?Q?7VQBYsyD5lCI0BUT1nArMnygvGvONbqKnj6aSlgSipn+3OdBAYF/KccBgE?=
 =?iso-8859-1?Q?i7L/Iy6fNPGxYZIwodzYrMwAhuAX8AVsaJRWcGwjoQy9Seq/CGdZRBdD6U?=
 =?iso-8859-1?Q?g+Fpt3f0GaqQkKDVIn0n4LLccgwFt81moz2CYqMycMvQ7GVcHWF5VlOXzH?=
 =?iso-8859-1?Q?TU+jTReBjlKAhoSnbAnyQm74ejuqx8WiAkA4kU0m9NcAg81x9MQGXCLeyb?=
 =?iso-8859-1?Q?cEIuzisoFBHbwRQ8HQ51Afs2mt83VqDvcMvffzfWVr1cQvWP+IETV4kJYe?=
 =?iso-8859-1?Q?2tI+WVLGnLCXTH6W2yTBS3RhwMeCBhsg2UoOYRzHBxB6j0kYJQXqIEeQwT?=
 =?iso-8859-1?Q?blmsXbXnvMoEXqreuJ9xft8wQiLz+r6buU+pM0H9TNxlCB/ESW9+f5htfk?=
 =?iso-8859-1?Q?z/hIYVJjOMtW/5SZemJrPvhiDp3FQR6j7t0bARkCSK/q7p/j8YhakRHoc6?=
 =?iso-8859-1?Q?xMVVpT2Of8yOqccHYMF4OXELWysu1SrQcEWMYYrMLpbO6ZNL0aPNkSJ5FX?=
 =?iso-8859-1?Q?RNtw49WE8U5RRDQRag82FeSjhdsCWQ5oqfwxjWoODx5p5KqmyBlRei8n06?=
 =?iso-8859-1?Q?QvUGncGTf4wtEED5S5X7bPCWmO/p76ISxsQTdzSHif4LMk23XQkbnZnxyo?=
 =?iso-8859-1?Q?6jbGihrutsfimlefIuuVxBknAR42JI4YMGG/vyVPS7C6GwgJz55SQ8d0Zn?=
 =?iso-8859-1?Q?Y0Y75Ru7E9rucNHVLjatxCWZZsG8w1R4GzDChoSZx4Ud8ueVyFoJupw6vR?=
 =?iso-8859-1?Q?JxPB0cMmHyGALMcuwI6wajkk25CN1eWAD5FT1yR+hYFRZJREww9482fvCA?=
 =?iso-8859-1?Q?hK87+NHdno+H8RzCtGJOl5TQCyMazPb57yHyBSBq3nfm9N7re6AyrAu8zN?=
 =?iso-8859-1?Q?GHPVOAYtbiQZjPW83kxD+ZlxJSlmTetn/jMQL5rIfWQh/FdhhrceFs6hvj?=
 =?iso-8859-1?Q?whn3bio54B4gNmjOKDFnbUF4I2JPbIK/oE8OzLkdhM+m4xZokOHhR4DPjb?=
 =?iso-8859-1?Q?qmHUoR7JxAYU7IwvE9oSJL/vVRs+JPsUrO?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be3e7d15-ed74-463d-84bb-08db8b42c35d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2023 06:05:06.4826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 92QFLinrBOyP22wEfLAAhDYyQAYmntbVe1eNCzhf8rzqvuy2e1Wb/5K7+rJgA6jdF+W8gHbLfAfNQFJPNumETHtWk9jSvBeZ7dobgpuC9kw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11973
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Thanks for the feedback.

> Subject: Re: [PATCH v2 1/2] Input: exc3000 - Simplify probe()
>=20
> On Sat, Jul 22, 2023 at 05:51:17PM +0000, Biju Das wrote:
> > Hi Dmitry Torokhov,
> >
> > Thanks for the feedback.
> >
> > > Subject: Re: [PATCH v2 1/2] Input: exc3000 - Simplify probe()
> > >
> > > On Wed, Jul 19, 2023 at 06:43:47AM +0000, Biju Das wrote:
> > > > Hi Dmitry Torokhov,
> > > >
> > > > Thanks for the feedback.
> > > >
> > > > > Subject: Re: [PATCH v2 1/2] Input: exc3000 - Simplify probe()
> > > > >
> > > > > On Mon, Jul 17, 2023 at 06:45:27PM +0000, Biju Das wrote:
> > > > > > Hi Dmitry,
> > > > > >
> > > > > > > Subject: Re: [PATCH v2 1/2] Input: exc3000 - Simplify
> > > > > > > probe()
> > > > > > >
> > > > > > > On Mon, Jul 17, 2023 at 07:15:50PM +0100, Mark Brown wrote:
> > > > > > > > On Mon, Jul 17, 2023 at 04:35:02PM +0000, Biju Das wrote:
> > > > > > > >
> > > > > > > > > The .device_get_match_data callbacks are missing for I2C
> > > > > > > > > and SPI bus
> > > > > > > subsystems.
> > > > > > > > > Can you please throw some lights on this?
> > > > > > > >
> > > > > > > > It's the first time I've ever heard of that callback, I
> > > > > > > > don't know why whoever added it wouldn't have done those
> > > > > > > > buses in particular or if it just didn't happen.  Try
> > > > > > > > adding it and if it works send
> > > > > the patches?
> > > > > > >
> > > > > > > I think there is a disconnect. Right now
> > > > > > > device_get_match_data callbacks are part of
> > > > > > > fwnode_operations. I was proposing to add another optional
> > > > > > > device_get_match_data callback to 'struct
> > > bus_type'
> > > > > > > to allow individual buses control how match data is handled,
> > > > > > > before (or after) jumping into the fwnode-backed
> > > > > > > device_get_match_data
> > > > > callbacks.
> > > > > >
> > > > > > That is what implemented here [1] and [2] right?
> > > > > >
> > > > > >
> > > > > > First it check for fwnode-backed device_get_match_data
> > > > > > callbacks and Fallback is bus-type based match.
> > > > > >
> > > > > > Looks like you are proposing to unify [1] and [2] and you want
> > > > > > the logic to be other way around. ie, first bus-type match,
> > > > > > then fwnode-backed callbacks?
> > > > > >
> > > > >
> > > > > I do not have a strong preference for the ordering, i.e. I think
> > > > > it is perfectly fine to do the generic fwnode-based lookup and
> > > > > if there is no match have bus method called as a fallback,
> > > >
> > > > That involves a bit of work.
> > > >
> > > > const void *device_get_match_data(const struct device *dev);
> > > >
> > > > const struct i2c_device_id *i2c_match_id(const struct
> > > > i2c_device_id
> > > *id,
> > > >                                    const struct i2c_client
> > > > *client);
> > > >
> > > > const struct spi_device_id *spi_get_device_id(const struct
> > > > spi_device *sdev);
> > > >
> > > > Basically, the bus-client driver(such as exc3000) needs to pass
> > > > struct device and device_get_match_data after generic fwnode-based
> > > > lookup, needs to find the bus type based on struct device and call
> > > > a new generic
> > > > void* bus_get_match_data(void*) callback, so that each bus
> > > > interface can do a match.
> > >
> > > Yes, something like this (which does not seem that involved to
> me...):
> >
> > Looks it will work.
> >
> > But there is some 2 additional checks in core code, every driver which
> is not bus type need to go through this checks.
> >
> > Also in Bus specific callback, there are 2 additional checks.
> >
> > So, performance wise [1] is better.
>=20
> I do not believe this is a concern whatsoever: majority of
> architectures/boards have been converted to ACPI/DT, which are being
> matched first as they are now, so the fallback to bus-specific matching
> against bus-specific device ID tables will be very infrequent.
> Additionally, device_get_match_data() is predominantly called from
> driver probe paths, so we need not be concerned with it being used with
> class devices or other kinds of devices not associated with a bus.

Looks like most of the i2c client driver uses similar handling for=20
ACPI/DT and ID tables. If that is the case, it is good to have this
proposed change which will simplify most of the drivers listed in [1]

[1] https://elixir.bootlin.com/linux/latest/A/ident/i2c_match_id

Eg: drivers/hwmon/pmbus/ibm-cffps.c

	enum versions vs =3D cffps_unknown;
	const void *md =3D of_device_get_match_data(&client->dev);
	const struct i2c_device_id *id;

	if (md) {
		vs =3D (enum versions)md;
	} else {
		id =3D i2c_match_id(ibm_cffps_id, client);
		if (id)
			vs =3D (enum versions)id->driver_data;
	}

The above code can be converted to=20
     vs =3D (enum versions)device_get_match_data(&client->dev);

>=20
> >
> > Moreover, we need to avoid code duplication with [1]
> >
> > [1]
>=20
> If and when my proposed solution gets into the kernel we can drop
> i2c_get_match_data() altogether.

Agreed. Will wait for other people's view on this topic.

Cheers,
Biju
