Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A9E75DDFD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 19:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjGVRv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 13:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGVRvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 13:51:25 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2122.outbound.protection.outlook.com [40.107.113.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C53A2111;
        Sat, 22 Jul 2023 10:51:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrDhzBArF9a5r0kUUE/rki0d+G8FC81+YzztiFTYeFG3dgjh5r4MzAJmetdRHQo4KqALSfDWFHSUd97HQxJgIpebnKfTOI77EwoEol1ntbLIEUBrVvPlzMVLPaS55XLI49nmgznsByakHXuYKAF6zeGkVAwkXhIfVXvbqDIPp+6R3Pqp4jIaXZezTcvpkrJOsOgJ68U8Frl+GoX0coNfNJfDD97mIXRY5A9U+1EJ+bbbb4i9R8hiSOb9wg/kLQhElswI7IsTxdhFp72Fg6NfVZi2mjwuQ7+trV/MAyRPCnnNLWPgP344G7gpltAZh47Cdc1YQShmkAZL8mAkcnqvuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETBDuLmbduoxPTbm1PS7TvbEhNjdf80njYu7mujFzYk=;
 b=XdH1d524lvzCPRXXINOg/kQjCtU+7sd8A7AWvz+Oq7OeZOa5GersQv0CcbJa7P4G/Mmt+0clPWqy2iNI3GkGFmGHHDZQpno5WObP7gmcKF170zo3zwUERlR9U0EyJ1M0JlOX7L+siqX9O2hgiiVgkmN8VYdSJ8yGeH0lJRmbyjW7Q30sX4irInL4l5t/HmiBaYWOSip2+dAUNLRprLliwkWgDxYsBWozEvwuw97SfrNawJKPVYN8MGbwFTR439MxXdmZHWSwXknAuND8MvpOVeUYoI1axS0KnlIFRfvIsC1SdJ7tZv0oW7h7eOQ3qgvddZMNV32Mvbpq4kGdtR04mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETBDuLmbduoxPTbm1PS7TvbEhNjdf80njYu7mujFzYk=;
 b=jgcRQL2DbuBgOPQNnkLE6J9PP1/G29x+JJiXPdhfNwlr/1sMePvdFbfAC/XjTa/2maw26g7aR+owtXJBr32J7rFliOCpGccKIOq1Dt/U1+K4wtqS5IsOjbhMw7j0R6CC3jn6S1MJbei2o+L9nYANtiGYm2Zv8FqglEHK772eXW4=
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com (2603:1096:400:47::11)
 by TYBPR01MB5358.jpnprd01.prod.outlook.com (2603:1096:404:8025::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30; Sat, 22 Jul
 2023 17:51:19 +0000
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::ef83:ef86:806d:6558]) by TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::ef83:ef86:806d:6558%7]) with mapi id 15.20.6609.030; Sat, 22 Jul 2023
 17:51:17 +0000
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
Thread-Index: AQHZuLEfke7PxT5AM0ulEoLw/IRIvq++HaYAgAAHzdCAAB6ZAIAAA3QAgAAChWCAAZImAIAAxbxwgAQs5wCAAUhbgA==
Date:   Sat, 22 Jul 2023 17:51:17 +0000
Message-ID: <TYCPR01MB5933D4252360AAE57D90FE1C863CA@TYCPR01MB5933.jpnprd01.prod.outlook.com>
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
In-Reply-To: <ZLsCOj1t4JvG3SEp@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB5933:EE_|TYBPR01MB5358:EE_
x-ms-office365-filtering-correlation-id: bd3010e5-e915-40c9-811d-08db8adc400d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mmziAgccfuIbO4fYuLoppe6m3xFKKfYq0wPechVuakOznXROS1ML24+G6m53KKhclqZnkJBWNS8VJqeBML9vo7kkQCcC7KPlQ+/hDIYFwGNh7pSJLaLrqznu/SC0pOgKMTO2aKn+8HPAosR28olwLyRJzw3DHPcDLYE0GbJekSlKuLPYaQZ9KcLLPCHYRXvN7MtUA07X7xQNmDF25OS72pCv/Ut6LTgpgl7uWp5zzDJ/xsLV7pkb9bhme3jsfu4e8pDws+mnph5vcXKSe3/KAQ+/3jLKf17N6d5vLsZtPw5QNIA84qAfHn2LbW7XcZtNZV//mHF/IRqAA8hYBdkm5st1nwu9CJ+yErSjpeFKf/eHt/Fu30+yEDGR5IEL+h2vgDvxvcD5g33gNfg7RAxHzbF1r7ICfovZtr4kzoNG24PIFK5scyZ0xuaaskgbP/vRQZnMCwI5AMAPdd0eJU3VbirhhgWIK3XLUMvyKLI5VemJ+DmW6J0R+NQs/QgWbPPDnwq7prsu02MohKOevAnGlhc+DobH0xAknOLdlHKKuw6jszk7gL5/oYE48hOAC4Qp7FUMVz+6p0f0jSy6SCfO29Byzbl0qoIlBJ6wiCFOAmg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5933.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199021)(2906002)(55016003)(38100700002)(966005)(122000001)(9686003)(83380400001)(186003)(26005)(6506007)(5660300002)(52536014)(86362001)(8936002)(478600001)(8676002)(38070700005)(7416002)(33656002)(71200400001)(7696005)(4326008)(6916009)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(41300700001)(316002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?z7EM010K5yRbuRrIQEC8NVIy2pqvEsn/2O7uI3Jd0+iMe3G5bCfzoAfXMt?=
 =?iso-8859-1?Q?4cnfl0txAOtGCO5rTDKE7FdHil7W7gi6Ssyws0Xzyho6M/6rnMB+OpCuQO?=
 =?iso-8859-1?Q?bBJIB6lZBL5PxQgKAd83nAbLitC86EUQIRtWftQKDjgHsAQKTjPWi8QgrG?=
 =?iso-8859-1?Q?SYbu+lkUBc/FF1tCKNV4TWg8/Z/tDx5DTlRr10TynQGDVOxNnH6BHJvJqN?=
 =?iso-8859-1?Q?ACUjg8209tBXOgA/WBKv1/XzOZgg+NqRUpkDNlrw7GWO7jDNOlsIMmExNy?=
 =?iso-8859-1?Q?JmcYvt2Iuz5GqbWVF/5Nzc73pKYkFOfr9XDI4MB2yeJ/XEcDuSmIPQS1/H?=
 =?iso-8859-1?Q?lWDOKj7nxAFwRJd2UliJgO6UHS9fC+zizeI2rOE7iPYzYqo9dRUjZ+mtJs?=
 =?iso-8859-1?Q?1btU7xGcLt8OfU3YAQZwimWumoJi+KydI8nxWbnfmxA+NmgCyHPtbVrbr4?=
 =?iso-8859-1?Q?uWDs1CAGzFRLZ6KFYqYcOKiFuoa3jynAq5Ohcwb+SQJewmJYKxboFlaRQz?=
 =?iso-8859-1?Q?GvGqAAQ66OeNdGsaxnmVtCa9bc0tPZFe03fK327xV0f9T3Imf2sCQuXdLC?=
 =?iso-8859-1?Q?cGcaqU1qpB7FBFNCsshq9u9wa4djAf95FtFKsRv6iAOy4HI40I95cJxbdp?=
 =?iso-8859-1?Q?jdeDsHptwZK2jlRUHPXsX6XfO6Fc6xOFqHoDyzkON/e72E/aD6/txGyhFc?=
 =?iso-8859-1?Q?daHzQi5yRvVZerLamg4o8R8m5jfLPbkMaecf29O86KglYmsCdwIfVDniGJ?=
 =?iso-8859-1?Q?aaYvI8QhkoiSWDm+lGM08MoD+tNazQIptZ0C+bX9Ax3j5/AFCyMp+WQjie?=
 =?iso-8859-1?Q?n9dHVHs3uEFxZO6kXZHy1fYGdvAD0NHD0dM9qjz8N6OAVPvXN4s7T0lPjv?=
 =?iso-8859-1?Q?/d0+mDij7uAtaMOaNK7NvNOSH4QVSB8SGh7HZWlSe/J9yh6JQZnCYI3L/d?=
 =?iso-8859-1?Q?OW1V6Kq0GdsjQa2aZBhsDkDcXu4RJhJKc/R5Kt0lYLOJleQUEeSsDcMVtB?=
 =?iso-8859-1?Q?GC2L0ZDiAbe9/7dxMEa8VNqK0rqQmghBxzu4wk7mO8eRcM0aaIb7B/XWjv?=
 =?iso-8859-1?Q?ZptTWUj2S9OmDcDKxM1wA/4/QtJXZ/FIg7bWnQCf3rRbtTubp3dDd/q1uZ?=
 =?iso-8859-1?Q?xoVond0phvwX1xqgfpdMMfP9Lxe3cXX/zarJBdlzuAxAkPTzsdwPGE3v9O?=
 =?iso-8859-1?Q?clDvHBor2zhQC/eheHMoahICQkh/YtUcMq+C0l9xKwg9pHdKRP5OEkJVPl?=
 =?iso-8859-1?Q?04UWZGnn+lGKMAjKjS4GPPgmrzmvJ/nWViYgjlJsi37tfJ2q4qr5iidLGN?=
 =?iso-8859-1?Q?1ocXcPw9IXVYUAL32jp/PLCPb6Uf9jOzGttphWTLh27mf3CJx7vT85psWt?=
 =?iso-8859-1?Q?jb3w4QakE1+mT7SBu4X/EI8TQM9czorZVEseYDUuxMOGNMexkZQWJ6y2cB?=
 =?iso-8859-1?Q?BsBaGouj7CbqgwegOCPwD8j5FlR/LOW1PyyGvvb1WpTPQ8F+O2+iiyyMgi?=
 =?iso-8859-1?Q?VkfremVPx/6JZSE65o/JPKKIdkOF2BBR5TK7DpQ24D/JeELpBrDvzlb6Np?=
 =?iso-8859-1?Q?qBlkf9f5inAFJnh4HIfaaJggbi7MEV8hFcoHoS8FzY/FNLJOmcmhV6EGaJ?=
 =?iso-8859-1?Q?J6d7xf3OPBuLKiiJUYuPZUDCyUBN/0VT/3+QOKwxOMTDwWtgvqq1Xitg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5933.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3010e5-e915-40c9-811d-08db8adc400d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2023 17:51:17.4990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XD26G3IBiTeubNTjDVhNjKf7tnO+1R1LYibf+1pFyYf+R95acAh0KlYkgpq1ajmY5MUjxFfE4UF/e4R9P15K2vhBtfSMQZC7Dvnd6VkNJ80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5358
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
> On Wed, Jul 19, 2023 at 06:43:47AM +0000, Biju Das wrote:
> > Hi Dmitry Torokhov,
> >
> > Thanks for the feedback.
> >
> > > Subject: Re: [PATCH v2 1/2] Input: exc3000 - Simplify probe()
> > >
> > > On Mon, Jul 17, 2023 at 06:45:27PM +0000, Biju Das wrote:
> > > > Hi Dmitry,
> > > >
> > > > > Subject: Re: [PATCH v2 1/2] Input: exc3000 - Simplify probe()
> > > > >
> > > > > On Mon, Jul 17, 2023 at 07:15:50PM +0100, Mark Brown wrote:
> > > > > > On Mon, Jul 17, 2023 at 04:35:02PM +0000, Biju Das wrote:
> > > > > >
> > > > > > > The .device_get_match_data callbacks are missing for I2C and
> > > > > > > SPI bus
> > > > > subsystems.
> > > > > > > Can you please throw some lights on this?
> > > > > >
> > > > > > It's the first time I've ever heard of that callback, I don't
> > > > > > know why whoever added it wouldn't have done those buses in
> > > > > > particular or if it just didn't happen.  Try adding it and if
> > > > > > it works send
> > > the patches?
> > > > >
> > > > > I think there is a disconnect. Right now device_get_match_data
> > > > > callbacks are part of fwnode_operations. I was proposing to add
> > > > > another optional device_get_match_data callback to 'struct
> bus_type'
> > > > > to allow individual buses control how match data is handled,
> > > > > before (or after) jumping into the fwnode-backed
> > > > > device_get_match_data
> > > callbacks.
> > > >
> > > > That is what implemented here [1] and [2] right?
> > > >
> > > >
> > > > First it check for fwnode-backed device_get_match_data callbacks
> > > > and Fallback is bus-type based match.
> > > >
> > > > Looks like you are proposing to unify [1] and [2] and you want the
> > > > logic to be other way around. ie, first bus-type match, then
> > > > fwnode-backed callbacks?
> > > >
> > >
> > > I do not have a strong preference for the ordering, i.e. I think it
> > > is perfectly fine to do the generic fwnode-based lookup and if there
> > > is no match have bus method called as a fallback,
> >
> > That involves a bit of work.
> >
> > const void *device_get_match_data(const struct device *dev);
> >
> > const struct i2c_device_id *i2c_match_id(const struct i2c_device_id
> *id,
> > 					 const struct i2c_client *client);
> >
> > const struct spi_device_id *spi_get_device_id(const struct spi_device
> > *sdev);
> >
> > Basically, the bus-client driver(such as exc3000) needs to pass struct
> > device and device_get_match_data after generic fwnode-based lookup,
> > needs to find the bus type based on struct device and call a new
> > generic
> > void* bus_get_match_data(void*) callback, so that each bus interface
> > can do a match.
>=20
> Yes, something like this (which does not seem that involved to me...):

Looks it will work.

But there is some 2 additional checks in core code, every driver which is n=
ot bus type need to go through this checks.

Also in Bus specific callback, there are 2 additional checks.

So, performance wise [1] is better.

Moreover, we need to avoid code duplication with [1]

[1] https://elixir.bootlin.com/linux/v6.5-rc2/source/drivers/i2c/i2c-core-b=
ase.c#L125

What core people thinking about Dmitry's proposal?

Cheers,
Biju


>=20
> diff --git a/drivers/base/property.c b/drivers/base/property.c index
> 8c40abed7852..cc0bf7bb6f3a 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -1277,7 +1277,13 @@ EXPORT_SYMBOL(fwnode_graph_parse_endpoint);
>=20
>  const void *device_get_match_data(const struct device *dev)  {
> -	return fwnode_call_ptr_op(dev_fwnode(dev), device_get_match_data,
> dev);
> +	const void *data;
> +
> +	data =3D fwnode_call_ptr_op(dev_fwnode(dev), device_get_match_data,
> dev);
> +	if (!data && dev->bus && dev->bus->get_match_data)
> +		data =3D dev->bus->get_match_data(dev);
> +
> +	return data;
>  }
>  EXPORT_SYMBOL_GPL(device_get_match_data);
>=20
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 60746652fd52..5fe47bc491a6 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -114,6 +114,26 @@ const struct i2c_device_id *i2c_match_id(const
> struct i2c_device_id *id,  }  EXPORT_SYMBOL_GPL(i2c_match_id);
>=20
> +static const void *i2c_device_get_match_data(const struct device *dev)
> +{
> +	const struct i2c_client *client =3D to_i2c_client(dev);
> +	const struct i2c_driver *driver;
> +	const struct i2c_device_id *match;
> +
> +	if (!dev->driver)
> +		return NULL;
> +
> +	driver =3D to_i2c_driver(dev->driver);
> +	if (!driver)
> +		return NULL;
> +
> +	match =3D i2c_match_id(driver->id_table, client);
> +	if (!match)
> +		return NULL;
> +
> +	return (const void *)match->driver_data; }
> +
>  const void *i2c_get_match_data(const struct i2c_client *client)  {
>  	struct i2c_driver *driver =3D to_i2c_driver(client->dev.driver);
> @@ -695,6 +715,7 @@ struct bus_type i2c_bus_type =3D {
>  	.probe		=3D i2c_device_probe,
>  	.remove		=3D i2c_device_remove,
>  	.shutdown	=3D i2c_device_shutdown,
> +	.get_match_data	=3D i2c_device_get_match_data,
>  };
>  EXPORT_SYMBOL_GPL(i2c_bus_type);
>=20
> diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> index ae10c4322754..3f2cba28a1af 100644
> --- a/include/linux/device/bus.h
> +++ b/include/linux/device/bus.h
> @@ -102,6 +102,8 @@ struct bus_type {
>  	int (*dma_configure)(struct device *dev);
>  	void (*dma_cleanup)(struct device *dev);
>=20
> +	const void *(*get_match_data)(const struct device *dev);
> +
>  	const struct dev_pm_ops *pm;
>=20
>  	const struct iommu_ops *iommu_ops;
>=20
>=20
> Thanks.
>=20
> --
> Dmitry
