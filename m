Return-Path: <linux-kernel+bounces-63322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA040852D9D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E2BEB2682D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34AA22635;
	Tue, 13 Feb 2024 10:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="SiOYq3o7"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2063.outbound.protection.outlook.com [40.107.113.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3C0225D7;
	Tue, 13 Feb 2024 10:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707819204; cv=fail; b=LI5L/Bg8+6PYwphE2r4s8pE6gZj4O8+hqYRvCFo9aCOeCDnJyFosqYFlyUczQs6+FWOo5jO4ELZy31Wym8NPkQoP8J1sogn0td+4Qrn0i7X8BiRbJFBuTJkfKFsuEDSDplMkTU29oUA11JRpDfenNiG4EgU0pjD29ZPU1WYw2z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707819204; c=relaxed/simple;
	bh=7vkiGZ4Ms/ty9sZA8U15Ca1tc262k7/XEqkt61Cd58U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=chpL1xfwUnDVObI89SDdapAtSbXZmZM5qntpZMLNgWD9p3weT0OlMXL0g2T/WWSksDBekGZwj+yNV4hwEZjHAxe/cP8yGR8uCxy3XD9YX6lCR5aTiFWcq7jPFDPj7f7x1FB58PpH1zTnQrYFLCryAjSG10RrfWrFnDRt4dI1HlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=SiOYq3o7; arc=fail smtp.client-ip=40.107.113.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjjZP9R5//9HKB/V4GrQhR5u4TbcNVC422+4yHK9JfzacDzLDZPVnWHuh+mUKFuDPzUn9l6D1WDVp/J0ZD9EYpTZBTmHoN4mT83eZWHpzHHbo9HZDlmtH0a1wm+KT+SC6VgzbSz1/ZehB0S/30FmbLLnNoJmNpIMp24/lNPqbjbHRrI77W50qBR8bDjCtqzajgfXGC3M0ck+IWJ5xhzN6SzqdfzZ/ymC3yoiphsM5S3Ru77xZVi5n2ShthBxtBwNu5z9FDsi9Md/pCIvMsZYjDUOAqQKdY+FSpetSkpouWfcUlbACuzlsE9uwNvvdJQoJxPbETeKj2VBMPSttzzK9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MI1KmPNd7XUy5BN0sbaYmrl5Boh1Y6/TxKEuO4INW/A=;
 b=h3ksXZ5i8WKgHTGFa9uE1IVww0OJPrNZKQAy62yHL10O1H/ujst3tlA2bEsc6nkVSS+AsrlMICWPPv8WePUnqYq9f55es3aN6x9CNaAUU3x8w+0axXBIfVjPNvK8AJW9mN6AaBB6239z3YWqYVaOa4mLGDas9fG/p6R3WxR0ToB7Ujlxm13zVvCkMQ+40cfqWPCEA1hbHh8J5pKVC6F2xVKYnPUWu5h7bZ60d+2mxQxeHJ6UoVicSRDz83+uGUUb643+DqZN8LJRqpCEy52wM526u06PGJRUvKEKCXq4GaQanLg3RibpxjGboXQxAalFgn6Ux67EA6eJ6htOK4Q5Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MI1KmPNd7XUy5BN0sbaYmrl5Boh1Y6/TxKEuO4INW/A=;
 b=SiOYq3o7pwIqBKbSIrpr4jhXDtla+7/OxFlJPhQi+P099xvFXBw8u+GHkfnvoo+y81STpeimlQ5wUIRBYwFkOzpQft9H85kXL0W9feDYBeEpqSi1PztXDYL6G/nN2ug0uNgeOpPjnDWbZywUsNyAlK/18cTYk9VgqwSx9SpRzBE=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYCPR01MB11988.jpnprd01.prod.outlook.com
 (2603:1096:400:37c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.36; Tue, 13 Feb
 2024 10:13:17 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0%3]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 10:13:16 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "s.shtylyov@omp.ru"
	<s.shtylyov@omp.ru>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Claudiu.Beznea
	<claudiu.beznea@tuxon.dev>, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH net-next v3 5/6] net: ravb: Do not apply features to
 hardware if the interface is down
Thread-Topic: [PATCH net-next v3 5/6] net: ravb: Do not apply features to
 hardware if the interface is down
Thread-Index: AQHaXmDfj3p/d+D+vE6GR/WgPunNWLEICrVg
Date: Tue, 13 Feb 2024 10:13:16 +0000
Message-ID:
 <TYCPR01MB112698DE07AAA9C535776805D864F2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20240213094110.853155-1-claudiu.beznea.uj@bp.renesas.com>
 <20240213094110.853155-6-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240213094110.853155-6-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYCPR01MB11988:EE_
x-ms-office365-filtering-correlation-id: 884b732c-909e-4e82-3126-08dc2c7c6570
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 BXP3HFkN500avWl2FWINBjdHZLlbosT7VlGg4QQ0RLVdb9jQThIdqQpaz+vAKgNoiGfZ7DSnL+6s0ejtwr6+KdU262uy4PtfmAC/wKNHr9CWGNnedqKkbLrX2GlPEWcj10p7/hm/raJf17P7TyeA4t2LfpMBPDx2CkJlFBBKKfr9ZaXMrSaPuqTHCLwrKEL1UnYlamTikG+L+GlQaqLhK7KIuaQ04p6OHtKVvtjx44sf6+EtgNlfL5QUiU8TdecamaHfGLfCHe/h9T85LG3S/pq0Q7/+zh7pyLb5wOOFb0ObQh6AyxjljJVfTIzoeFGwcyj991lY2k0K6HkuErd3jcA7uuQA/AJHQIcwhdL40ZjcmM+gho85zIAqsgK8GYAHgVJTNgxa2lRKiifMW8XNLbKAiinSbjVV3RfKg4rtCmST/F3mG0E9W+DOhR0t/IvtTUb4ATsh4goOab3s3NGqC75HMqT8F4lexP3Gx9FBkMI2GKxXDA6slwqcvKjD+k/tCIu3rYMiAweKDU4FJBK4wG59HD+uirubNG2EMkOArCR0CWhISiSTz/FK2yOulyQuIINiRDC0wcM0ksiDoDUi0wQnbfQ7GiHgONL8N4LV2jgB8CwfY8WWUi0HQkmRr7Ha
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(2906002)(5660300002)(55016003)(38100700002)(107886003)(41300700001)(26005)(122000001)(86362001)(71200400001)(66476007)(7696005)(55236004)(66556008)(66946007)(8936002)(64756008)(8676002)(110136005)(54906003)(6506007)(66446008)(316002)(53546011)(4326008)(76116006)(52536014)(9686003)(83380400001)(33656002)(38070700009)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?F6EkvkeoCR/NArjYagnS32QVW8sQnpfrnR7k/pV4ZNX6KyHcDVaB30rad+Nm?=
 =?us-ascii?Q?f3nCFaPql8+kgStrtU6WV/835AtGPLOHwgHzl6aDO6dFdrONBqHiTgBmFkqt?=
 =?us-ascii?Q?z1poW9NYGFDmiAdFDfWQJEOzGzMIFTFqzsei989HsKYs8NsruULSJpzJWEdD?=
 =?us-ascii?Q?hLUX/I9Hf8osFrjk138KhUITSWT1wvoUgwrcw12U4nQLSQT0DwdjpMCDgGPc?=
 =?us-ascii?Q?HxsVx0eAPIlXFmP56GB/6gjmMj9yhphyzVA9Iv0bkjOtH+YU9sFr9p+UJIXY?=
 =?us-ascii?Q?hRm1/am3zk3kDNXCwoBgYoxa573j02580nQSio1UoCWOPNbgHkUR1ghXFQdb?=
 =?us-ascii?Q?rCMcOjMBff9h0FlqW4ujknXN8VZaht6tmtxN9wan9UnLo4FiGdCHj8fcnX5n?=
 =?us-ascii?Q?wHCPXfuFvRXU8BXXMVniJkEGqUYBky4auP115H4qY0tWwJhz+vCPvUOk2ZR2?=
 =?us-ascii?Q?/EHggeCsUu2MyA0XwF3O05Bf4nNG3CkTaFmwuovg9K1ym5oH6+QM/FqigngP?=
 =?us-ascii?Q?HUEGSy7lpw7wUzOodYT7eTjS6xAF4QLJdw+1sf37sYPx+0RaI6EOMpO1+Dtl?=
 =?us-ascii?Q?Ea66N3p33b7HvmOzCGDLSD7ecnHd1BiBE5q5SOc3/GVB5sQRsoqIEexfLWbG?=
 =?us-ascii?Q?trQ0OdAcfDBEWXSqI0vOFvnnvnlxW+7+adaaWa1GhajL44FPNPXw7MaYo1Ff?=
 =?us-ascii?Q?+YdHyeFZmHL5kN2MorWbT7lNy1BdSlPTLUixQeJWaJ8aRyOakPOuicwXGECz?=
 =?us-ascii?Q?vqn5szoPareUbRBu3+ayVhl1en/5U5j3ape84ca+NrPJeIf2TANYkGMHJdEo?=
 =?us-ascii?Q?EmXXMT8bsgTpaClmK2pzO0jp2lMYEiHgZywRvwojK7QJYT94Vy67GzfKsCEQ?=
 =?us-ascii?Q?f8X9g1N51SwS8D2lUzjeilPPqI7Qw+48K+qxEc5aXU/fWY+9DJjasEMIAv6A?=
 =?us-ascii?Q?byQkEAiYj1F2mGeacAtTYwizmcPBEPD3pJeWoWU20h4l9meBJIxfIBnwAVPB?=
 =?us-ascii?Q?9zd6wyS7Liiu47nEHh3KnwPEjDr7nV/KwDDnv1bPs1mRG3vjk7zsnH4fGD/W?=
 =?us-ascii?Q?RXzDsxPJQtizDWWRS9GTGI+QaWDHPONOogDUXtcCVH8CrDnDJGAFEB+gOONV?=
 =?us-ascii?Q?kwvaxyy26p/qnMi+b6jPzbbz9tH6xSpZGCBcyPIY8qRHMplJiMljrus+/KWS?=
 =?us-ascii?Q?gVr57mM+qNR2eBfXthA5HCIb3TvVPTE3FXCqd2WQqAqc9oOhL7WC4CVVmFYC?=
 =?us-ascii?Q?tpEVBT1HgeR1HMJ59PM74mX/Y5XJXToCCFHLJTMV8cu9vHRPNqXjVuVlcmBU?=
 =?us-ascii?Q?kTDrdlMOx8bBvukBfq3E08xRX/K/al1OSiXG3r9iTgIivZkRsi/D7oRM2T+R?=
 =?us-ascii?Q?+43WUq2xINPWFNGDkUHpHmQxK6/uJlPa6inbMgjOZC1tOlbOj9k1fGzKDomY?=
 =?us-ascii?Q?ExIZmyiKpksKGYLFl35h07Lt5ww0HNk00a7cKhUAYC0EPE3tGWuLq9XMcsV4?=
 =?us-ascii?Q?fV7KWcUqdWSv408QsomFmtSgQXqm8sQgaDRtljt25qllBghWJaBX7zKBYbko?=
 =?us-ascii?Q?wX/noOMekak5sdgSPUsedRQ423x5QFrd/b8lCzIGjFl1JcEWhRaPdrSVn6rV?=
 =?us-ascii?Q?Sg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 884b732c-909e-4e82-3126-08dc2c7c6570
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2024 10:13:16.8875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FnTeJHU0XKbV+CJy5flGoE6LTel0Gwp0JNsqfZrh3WqeGwDffsV9M0GUe/TDZP+e059XrX2Lrp8XGAR3rMKoB+2GI9of1F2uItDcKNnzdLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11988


Hi Claudiu,

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: Tuesday, February 13, 2024 9:41 AM
> Subject: [PATCH net-next v3 5/6] net: ravb: Do not apply features to
> hardware if the interface is down
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Do not apply features to hardware if the interface is down. In case
> runtime PM is enabled, and while the interface is down, the IP will be in
> reset mode (as for some platforms disabling the clocks will switch the IP
> to reset mode, which will lead to losing register contents) and applying
> settings in reset mode is not an option. Instead, cache the features and
> apply them in ravb_open() through ravb_emac_init().
>=20
> To avoid accessing the hardware while the interface is down
> pm_runtime_active() check was introduced. Along with it the device runtim=
e
> PM usage counter has been incremented to avoid disabling the device clock=
s
> while the check is in progress (if any).
>=20
> Commit prepares for the addition of runtime PM.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>=20
> Changes in v3:
> - updated patch title and description
> - updated patch content due to patch 4/6
>=20
> Changes in v2:
> - fixed typo in patch description
> - adjusted ravb_set_features_gbeth(); didn't collect the Sergey's Rb
>   tag due to this
>=20
> Changes since [2]:
> - use pm_runtime_get_noresume() and pm_runtime_active() and updated the
>   commit message to describe that
> - fixed typos
> - s/CSUM/checksum in patch title and description
>=20
> Changes in v3 of [2]:
> - this was patch 20/21 in v2
> - fixed typos in patch description
> - removed code from ravb_open()
> - use ndev->flags & IFF_UP checks instead of netif_running()
>=20
> Changes in v2 of [2]:
> - none; this patch is new
>=20
>=20
>  drivers/net/ethernet/renesas/ravb_main.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c
> b/drivers/net/ethernet/renesas/ravb_main.c
> index b3b91783bb7a..4dd0520dea90 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -2566,15 +2566,23 @@ static int ravb_set_features(struct net_device
> *ndev,  {
>  	struct ravb_private *priv =3D netdev_priv(ndev);
>  	const struct ravb_hw_info *info =3D priv->info;
> -	int ret;
> +	struct device *dev =3D &priv->pdev->dev;
> +	int ret =3D 0;
> +
> +	pm_runtime_get_noresume(dev);
> +
> +	if (!pm_runtime_active(dev))
> +		goto out_set_features;

This can be simplified, which avoids 1 goto statement and
Unnecessary ret initialization. I am leaving to you and Sergey.

	if (!pm_runtime_active(dev))
		ret =3D 0;
	else
		ret =3D info->set_feature(ndev, features);

	pm_runtime_put_noidle(dev);
	if (ret)
		goto err;

	ndev->features =3D features;

err:
	return ret;

Cheers,
Biju

>=20
>  	ret =3D info->set_feature(ndev, features);
>  	if (ret)
> -		return ret;
> +		goto out_rpm_put;
>=20
> +out_set_features:
>  	ndev->features =3D features;
> -
> -	return 0;
> +out_rpm_put:
> +	pm_runtime_put_noidle(dev);
> +	return ret;
>  }
>=20
>  static const struct net_device_ops ravb_netdev_ops =3D {
> --
> 2.39.2


