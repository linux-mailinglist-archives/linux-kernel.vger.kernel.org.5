Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2C97B65CB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239787AbjJCJqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239782AbjJCJqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:46:04 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2057.outbound.protection.outlook.com [40.107.22.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DC4A1;
        Tue,  3 Oct 2023 02:46:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0/yl5uDbM/TSBJOLsuJfITvDgLLCEJfoKlgOSXTfQCkJdEFgqrs8d4GedTxQgiVCtUwQ51WweIGVQ8j1PPUN1drfbkHdVrZIKg9W+OjR7Y0sDpljgnRGyEoj3uBatEIbN31+nD6lz/Wdoj6fQLo9BXkJb3h3ZRnGtf508GolbVvVFnQ3ZVWvWJs3uhtY9kSD/ZsxcLRO4bbk2D6qcgCW5B+N6ms8uP2A7mqwizl1Env8eLyNYfXhMbKY8jF94gKxx9Z/NhG6w4j+e2JVIMSYjsh0N8AJVuv6vQ9WfYiPzWpxq7QR3kfUI9uZ2h3Aup2xsPU7Ql26qAO1OnHBy4AsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFUGi7Kq8OpoXHrLwwL5E1PeQdkkxaxvYg8+wapgW6s=;
 b=ALtDa2SCIQy5KhOkDmf3iLorrF8L+eb/MMEWq8tKLLbEQwU0kbzJIuDcdWEhMN4mX/IH5c/3eiLOpkNy1mCwSB79N/SK/GasB686h6nLMIfv5J9K0eGn0Inm+JGlJ/zOJ+mU3dDMB49oqMzIAd+sc6H/Sy02671J9NLONBuUdVQaaqfynZgECNvk0oXgWdzN31GBi4A1M7NeNLrwgDhT1FvIST2r0mfmw3mNX1XPE7ritRR4ZYZ2Ji1WIAmVIXLQoy7nNnIFdp64wqrsnVFc9cfUZ4rK5/hduy7S/9vHUeQWuGC5sOhCOjD8ob5zfGPKqv9olYrqwR6J8sp2x8lWVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFUGi7Kq8OpoXHrLwwL5E1PeQdkkxaxvYg8+wapgW6s=;
 b=B0aooyhfrLr8sKVHwid+MtmJrPkvgY+hOoFM2wxnDqkz9y3Q+/CWKZo+6iS2ApXnOsvV67LW8R4I4MArp8mlJqjThu0FAssNsAb/0Zd2l+kvjHYFwl0EKsVjyrBkWlh6FM2k2/em2GahkebdpiIpg8wNkYaDpAmH+w7guVquSJg=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS1PR04MB9583.eurprd04.prod.outlook.com (2603:10a6:20b:472::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.24; Tue, 3 Oct
 2023 09:45:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.024; Tue, 3 Oct 2023
 09:45:57 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     Sudeep Holla <sudeep.holla@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] clk: scmi: add set/get_parent support
Thread-Topic: [PATCH v3 2/2] clk: scmi: add set/get_parent support
Thread-Index: AQHZ9CCG+e+RtSIUGEOgYwpQRluyfLA2y6qAgAEIDtA=
Date:   Tue, 3 Oct 2023 09:45:57 +0000
Message-ID: <DU0PR04MB94174DDEBBC7C73D3A7B2D8D88C4A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20231001-scmi-clock-v2-v3-0-898bd92d8939@nxp.com>
 <20231001-scmi-clock-v2-v3-2-898bd92d8939@nxp.com> <ZRsEnze1htH_2ORf@pluto>
In-Reply-To: <ZRsEnze1htH_2ORf@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS1PR04MB9583:EE_
x-ms-office365-filtering-correlation-id: 6c9be950-2b89-4819-f31f-08dbc3f58b34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Ta8rlyPqrLfNKhjF6msWjh3bhHSzJr3stHBi7G8D6gXUkhEEgQ9232Lv7JGrpXwM265ML7DeSWl6OkdgkQMfvN+jLIJFsBsGsjGK26CJSQMe5GuiHYXNRs0+6wBsP/8Zp19L7MDImddbcPlAGSaa2oWgEjyhakTrwHE+T3Jg1a7wuUm2sz8b6u7jL8m3B5Osxt+yOxR6Tl9ELRxbSRXfe6nTAMWxy891D2iJKL0HEkSPF+XGOSpcEsLwu/ZiIrc8i+X6T0tp2HUiW/KMjN/tJRRqRfWQcAFd6o85R9zy/rJ6+Lu0LUgEb3J0lQjCi1Bgf3OSe9jTVq654PbeXdAA6dnWqUUvrwogqSUFBncrTIB01gy5+WSuH74hqvyJCJXJbko25NkEnCkZ54R3a9C4bbxTnbEJ/LQJul6kmsF+D0ZuuK2RtioIKkPFZOyZONvK11NYfLC8NeISDoPWwcrXbVBaxzL7BoCsmnIWZA9VHNCYTW/+5UFaj98moitvh1dWqZ7+7+gHZhariY5zyWkRjTNXXbFXiokfHDqWtVA5/alxtIYy6IeyBmu6inn0tttmifaQcfm3YPeVUyJwMX3xglQ5s7QvV/6yFxuQyDg2t2W4xHxGD7/s831DyNKD03w
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(39860400002)(346002)(136003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(8936002)(55016003)(76116006)(7696005)(9686003)(6506007)(478600001)(26005)(38100700002)(38070700005)(122000001)(86362001)(2906002)(110136005)(71200400001)(66476007)(66556008)(66946007)(33656002)(316002)(83380400001)(41300700001)(64756008)(54906003)(44832011)(5660300002)(52536014)(4326008)(66446008)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e4ZRayfoB2LSH9EvFzr/qynXJeRfu9++KWMs59LDUL3MPKrJ84/KLLFgAl5k?=
 =?us-ascii?Q?XzMq6as2D57ciqIotHkdYlvj+T3p6+OO+N7RqAbAj2SUbsrwXzwt9UzQ9RG9?=
 =?us-ascii?Q?YvSinmMrBvMNq561Hwbj9rmwIKwhrRdqohZ+y2rBmWiU66lfyFSKZC1JOPRz?=
 =?us-ascii?Q?Z1np9HHPoaazQUYhu8ig6tlE8CJSvqXWUgL0RG5k2gYcnAOcdGddN8MX4mss?=
 =?us-ascii?Q?GTQfSnQWcaTWfFysvplUoyFWqAEzHsHKH8kF1YP7WcXm3RXXPeOaRcCGba0K?=
 =?us-ascii?Q?9rfa+f44vuhFPGBNx/5EXpTGu6NBRw3k8o8E40oOvvjnparN1b+rHyfm0rg+?=
 =?us-ascii?Q?b3maqzOS8WIR1sKuvClTuNpzSBonpyP7LMI+5+85rovUX0sjPA2qq047EH2h?=
 =?us-ascii?Q?bOX1QmU8zNSeVipVkXc//lVrB7mKoyxyXURYvjxQsFcjIJ8W/WwnmGEklDDl?=
 =?us-ascii?Q?yFXRHREYIlR9sAgmwqmwqykzUclNMn8dbycC4g/zjmgvrVO7jVgyPCL541JP?=
 =?us-ascii?Q?IbE/KqffX13MyXKw8IhcCfH3LAW8F2f0YU4bHKOCu19DZrx/tJ5/ySR5s9++?=
 =?us-ascii?Q?Hgqj7U3VynllE1YeszIPEKooJlSxZahrbcilxQ4FNrfl1LNbBWIh635jJAvf?=
 =?us-ascii?Q?+mVRVv5xhUsSCh3wkB9zFK9C8WjHRTD1nIGVvo3WLPJg6YcYTxwMI4I2hWIY?=
 =?us-ascii?Q?OAb/djXfjzYMwFD7Zi987qbNyPw5qAzKorgzilKybjS5A3W199QaOHkryW1d?=
 =?us-ascii?Q?8+DEjO9aVLYx02TJO1RJmTyA9fE4FBS1/iTXrknTLrpgJQ0Pm+VOWO6A6uge?=
 =?us-ascii?Q?o3+b+3jGHm/vVlJcddAFoh/Sg/quGiY4iSZ6kCGZED4xNFwAGuoeGdjENIiH?=
 =?us-ascii?Q?yVti50dNyovXfJwDBBqmYDpcYSRED/D87X8NcVRHH/Pk/yBigBTJOkEOvjZH?=
 =?us-ascii?Q?HkK4+Cs23DcYqj0MNB3KlWPOyRRfDfed1ntwNgSP6FR4gvdzWV+fNSchVArE?=
 =?us-ascii?Q?G82YSY5fqf7BCbKnp+6wiSUtCKYNLK7lZ1Ma2A1JhFkJb8crVBaOCdYf9DnH?=
 =?us-ascii?Q?wRWRpmDE0xQLM/qMV3c7EfLMrjdocQIM398O61KZla/pD/ei8AIRdyLlPqfn?=
 =?us-ascii?Q?WWNINty+HHtJ6GfHoqcGsIxdhUMzaTcy/ACA2q/rVINlckWBYeFH0RPlQ7yR?=
 =?us-ascii?Q?wSm3Y6NTqdjgTl/Rl1X/lpiwQ5zUsJJEt1ZqxORVge0+6E5vOj41oYC8Ewin?=
 =?us-ascii?Q?zanZwDasjNSoLbqt+qTuUoRi5aL92oydWmcq87oqK1HTPy6QlqA3C7hlSObl?=
 =?us-ascii?Q?XS5KLJX0AqGhPDl+HUugBVR4Ph3XJHMaTLFxXnNFGiy91a8QR7x7I5fobvOd?=
 =?us-ascii?Q?6IVE1Fgbjohiq2zp8FkFSlI4yrsJDoHg2spKsocLkXyVPIWI9Udi9fAIcByK?=
 =?us-ascii?Q?4vUtzkhF7C8u3Yt0RHU3azKGNzkBslrUVRZ48MgTesekp3YKVuMxlry2wRMu?=
 =?us-ascii?Q?tS3OXa0T78NUs7SM4hVNL3zHvaCeucYPm8fxxA+DFYVMTH3RNBIQ8cIwev4G?=
 =?us-ascii?Q?mPnmNu0wsByLmfBP50Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9be950-2b89-4819-f31f-08dbc3f58b34
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 09:45:57.2719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YE+2JRLay8a+8YEUAqYsTTBTW6cT1/xPnMxyt5rEuUvcAZ3oMsqiNWlPL5Tkpj/9FroYvbhXacxcj0kAsgWDOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9583
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristian,

> Subject: Re: [PATCH v3 2/2] clk: scmi: add set/get_parent support
>=20
> On Sun, Oct 01, 2023 at 12:38:44PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > SCMI v3.2 adds set/get parent clock commands, so update the clk driver
> > to support them.
> >
>=20
> Hi,
>=20
> a few notes down below.
>=20
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/clk/clk-scmi.c | 50
> > +++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 49 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c index
> > 2e1337b511eb..5aaca674830f 100644
> > --- a/drivers/clk/clk-scmi.c
> > +++ b/drivers/clk/clk-scmi.c
> > @@ -24,6 +24,7 @@ struct scmi_clk {
> >  	struct clk_hw hw;
> >  	const struct scmi_clock_info *info;
> >  	const struct scmi_protocol_handle *ph;
> > +	struct clk_parent_data *parent_data;
> >  };
> >
> >  #define to_scmi_clk(clk) container_of(clk, struct scmi_clk, hw) @@
> > -78,6 +79,35 @@ static int scmi_clk_set_rate(struct clk_hw *hw, unsigne=
d
> long rate,
> >  	return scmi_proto_clk_ops->rate_set(clk->ph, clk->id, rate);  }
> >
> > +static int scmi_clk_set_parent(struct clk_hw *hw, u8 parent_index) {
> > +	struct scmi_clk *clk =3D to_scmi_clk(hw);
> > +
> > +	return scmi_proto_clk_ops->parent_set(clk->ph, clk->id,
> > +parent_index); }
> > +
> > +static u8 scmi_clk_get_parent(struct clk_hw *hw) {
> > +	struct scmi_clk *clk =3D to_scmi_clk(hw);
> > +	u32 parent_id;
> > +	int ret;
> > +
> > +	ret =3D scmi_proto_clk_ops->parent_get(clk->ph, clk->id, &parent_id);
> > +	if (ret)
> > +		return 0;
> > +
> > +	return parent_id;
> > +}
> > +
>=20
> While testing using CLK Debugfs with CLOCK_ALLOW_WRITE_DEBUGFS 1 I
> noticed that I can correctly change the clk_parent and then read back the
> clk_possible_parents, BUT if I read clk_parent right after boot (OR after
> loading the clk-scmi module) I cannot get back any value from debugfs eve=
n
> though I can see the correct SCMI messages being exchanged from the trace=
s.
>=20
> My guess was that, while scmi_clk_set_parent is invoked by the CLK core w=
ith
> a parent_index that has been remapped by the core to the SCMI clock
> domain ID, this is not done by scmi_clk_get_parent() so you are returning=
 to
> the clock framework as parent_id the raw SCMI clock domain id as returned
> by the platform instead of the clk parent id used by the core.
>=20
> This does not happen after you issue at first a reparent because in that =
case
> on the following read of clk_parent the CLK framework returns the last va=
lue
> you have set that it had cached previously.
>=20
> This fixes for me the issue:
>=20
> ---8<----
>=20
> diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c index
> 5aaca674830f..fd47232d4021 100644
> --- a/drivers/clk/clk-scmi.c
> +++ b/drivers/clk/clk-scmi.c
> @@ -89,14 +89,21 @@ static int scmi_clk_set_parent(struct clk_hw *hw, u8
> parent_index)  static u8 scmi_clk_get_parent(struct clk_hw *hw)  {
>  	struct scmi_clk *clk =3D to_scmi_clk(hw);
> -	u32 parent_id;
> +	u32 parent_id, p_idx;
>  	int ret;
>=20
>  	ret =3D scmi_proto_clk_ops->parent_get(clk->ph, clk->id, &parent_id);
>  	if (ret)
>  		return 0;
>=20
> -	return parent_id;
> +	for (p_idx =3D 0; p_idx < clk->info->num_parents; p_idx++)
> +		if (clk->parent_data[p_idx].index =3D=3D parent_id)
> +			break;
> +
> +	if (p_idx =3D=3D clk->info->num_parents)
> +		return 0;
> +
> +	return p_idx;
>  }
>=20


You are right. Thanks for doing the fix.

>  ----8<-----
>=20
>  Not sure if there is a clever way to do it.
>=20
> Aside from this, another inherent issue is that you cannot really return =
an
> error from .get_parent() so if the SCMI get_parent ops should fail (ex. t=
imeout)
> you return 0... (and me too in the above fix) but this is due to the CLK
> framework callback definition itself.

Yes. Right. I will include your fix and do a test, then out v4, should be s=
oon.

Thanks,
Peng.

>=20
> Thanks,
> Cristian

