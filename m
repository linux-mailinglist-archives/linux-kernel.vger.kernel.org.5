Return-Path: <linux-kernel+bounces-59709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 021F584FAC2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C611F29103
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AAC7BB18;
	Fri,  9 Feb 2024 17:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="ciyt+FEz"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2055.outbound.protection.outlook.com [40.107.114.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A503174E33;
	Fri,  9 Feb 2024 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498724; cv=fail; b=q2Kw7I4HEYx7nGEPSrgwyksUUo1qV+wG/plLU2L0+GqA+Yhk4k+Lxlql3w3bvMEFGaK6Van06JzqvAyhI8F4g/t43cirom8TvZ4wdvpDa7ALjQroMvaAX5Y1HOaJ2Chf2o0XM61A4SOwx+S2+N32C3gttOysvByANA16BVsnh2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498724; c=relaxed/simple;
	bh=tE0Y1unHfKa4OrOVlvFrTKh+ornweyeHgGmZQ8xH+is=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OAYZNsBeSBAb2a/XUI+DsPfL+yaX8v/VVyhM38B823Hm/MJFkRrCAJZJA0GbHR4g8RTtMDu78Ld9BU4dbSCXd/I+NFdqHJOg2b3XEFpkOMJvKdvO1CqbzZXwuokW1YpMvQoxOfS0/x62eMYKMDCGstVITqNh5SjD0vtP+F+EWhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=ciyt+FEz; arc=fail smtp.client-ip=40.107.114.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7HtSmHuSJZQHTyEBR0RaE7gHNmHKbiHsRvas3X2Ofn9FciSRiOm/HDqiNQGtHsR9wIIPoNDl+z4lFDW34J7G2Po7VjBHxMwjKBBQ0vnuS6UilaCXQMJWX6yVcF019RFANJzRGIdZ8iQOJUHc2ZkGKbu9QnEjDasuvE3utgefSrCXjVk5oaWW0shHO2U+AhZi6HJrxrhIBxbMe2ukXRIJyRr9kyJ6FA0k1xmVTKn5TyRaYS1WlqM0zXujNQRAoi/R+/ptaf9Ebb+WPq0bmtKC0/W/G6NzLI79c6+9sMgqDhTuHs3hG1xumi9Ty5aqQ9dgtWErvNCfx3UUDcfybCMtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+DcnDl2ITo2L4lRFeRI+IZUfCrsq0iWg9E7xLcZYCw=;
 b=dkg8ISm0qkZnofHI5kRrYO3k+m/QerQ5jP5jdhIxQUP0shcWjt2yYSIs0QZTvvvB72jK+GL2SZCvXkOAhfjpZ4cnSB6ZQr/rIl1NPGTI1VQKSGzdp5HHxmJQtgRxaKoqmZcusIAgfTtlyHyZJh/f61k2gCWvyFZ3sktfN0pYZXMUTgtvyllQQOctVX5+BLegnkKbt2xlzsr07LMQG3SoWtys76FlEIHXr8qS6z9qVkpw1xImWe88y7XB2z5gWMti2EUtoes9JvVy9SviFR0sRF8EgncfskmETbM/ZE4ADcwIJEocdL3xPt9pX/TlaY4iFuz5Jno7LAGpcEljPsT6FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+DcnDl2ITo2L4lRFeRI+IZUfCrsq0iWg9E7xLcZYCw=;
 b=ciyt+FEzWtOnoDzY277uGDlJe+sEZM+usXCBBASTAiIGtZA74OwKo/2Nw+mdEvz4bnth2C9gP35g4Yo5KDuvgrhn83684NQXnolFfVqMV6uT98vhCAQaK8kdkOHX8e8WoxzVi9GTRM2r5xRd7jy+wciATmBqiPMdvGcIxxmbEB4=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TY3PR01MB10598.jpnprd01.prod.outlook.com
 (2603:1096:400:313::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.14; Fri, 9 Feb
 2024 17:11:55 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0%3]) with mapi id 15.20.7270.028; Fri, 9 Feb 2024
 17:11:55 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "s.shtylyov@omp.ru"
	<s.shtylyov@omp.ru>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Claudiu.Beznea
	<claudiu.beznea@tuxon.dev>, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH net-next v2 4/5] net: ravb: Do not apply RX checksum
 settings to hardware if the interface is down
Thread-Topic: [PATCH net-next v2 4/5] net: ravb: Do not apply RX checksum
 settings to hardware if the interface is down
Thread-Index: AQHaW3pX9CB/Daj1+EissME+82JRZbECPfNg
Date: Fri, 9 Feb 2024 17:11:54 +0000
Message-ID:
 <TYCPR01MB1126949DF3F7C498956AAB629864B2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20240209170459.4143861-1-claudiu.beznea.uj@bp.renesas.com>
 <20240209170459.4143861-5-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240209170459.4143861-5-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TY3PR01MB10598:EE_
x-ms-office365-filtering-correlation-id: a991c6b7-6440-4c49-6e47-08dc29923752
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 sodAIYjTKVEQTMMcRiGGencxSD8ybcNv3dspFa18MRbSL9E6dAzhhXepAi7tJjrGta65roF6YOIY11kkDvZdn2KfneWhhyZdyCaP0EWAo2O52HEAqgvkazDjxgx3X9QLwqxO8XLw5rgbnyYnS14O9DIvMzkfODkN24YxlGufyU5HG+9g6c8EMZhrcfY66YPw1uLulOC3TLtjsdJO16f30hvkbaT5Wg8MkdW6ipsKPaZdgO7iMWmS2f7HoMWKyBeIpwW6bZfTwOc1ORyVY78UgfnfQZt4uZ7i1CfNIKEAORzS45kOF+PNRU+Tlupk6uf2OeNwt0NmiRPKJOXW4SpfhR32S/1ZUvJIKZjqtMyLknoULXBwCaEp151ZX7g39Sm+Wf8u6cTPL+WfiUW/Nn3E3V+B9Y7fGjIHf7BWsQuyAlRMG+dAarIVCCkYDs9UrCwLEaEWnTXwOZQJCM0lr6xvkyNhrXXpEZSGvAR54LRbwi2Nn84EZjZ53no1N2FagMr2W0SmLX9+Mp8dv5viPsoLpKyObwXoS+BTqVlP+Wax1Yeet+O8SWXFRXJuZs/xY+/716rZSKXlxhqNxrh8YDLAkur++wb7Qpm0/Wag99vgNzaqP+CpRCwcDQ45k8RCzskU
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(366004)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(86362001)(316002)(478600001)(64756008)(66446008)(107886003)(66946007)(7696005)(66556008)(76116006)(83380400001)(8936002)(8676002)(110136005)(53546011)(71200400001)(9686003)(26005)(66476007)(6506007)(33656002)(38070700009)(38100700002)(54906003)(41300700001)(2906002)(122000001)(5660300002)(55016003)(52536014)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qvYWf12eBV8VZ20bmvWb41PjRfZfNNIhTfV69ycJ26lzlSGftq0G8xukx41E?=
 =?us-ascii?Q?UXIDNWOolCTQF2dmfgLKr7Qu65VxjVRba1EMs7OrUjKFQ5MoztbZR2tGwctK?=
 =?us-ascii?Q?OnwQDEsFgCaAxSX24YOmCxPfvza3SFfJEa7jDzzVwuwbP/MS0NoH6KBQW7VB?=
 =?us-ascii?Q?EE7YFFZ6uFgWfDncksHjAk1RtWHnqWmMnzDrb5L2YARG9Nlnmxu5IJQJ+ml6?=
 =?us-ascii?Q?DyQ4qa6edO0A4PBE9Nq0xeMVabVd4/sW0QETM9Ht4BiaQbHOEnRgRa1BKKC4?=
 =?us-ascii?Q?Xghz49NHjAe0ZFtZsP6v6hf2vKmJmfVkJTsTP/7GHXlZRfjIKjOmYLdjmrWX?=
 =?us-ascii?Q?gOGu8SIkwK/ZqlE1+A7XVqkRbrf9TYNN2KxiT7wNYP6lFE4B5gwSCFeXsU0k?=
 =?us-ascii?Q?nYzJ+e2355i/4SzR2PBRvfATTKLJQupITb09/2H+jfKy9oo/IhwvwtifiJOj?=
 =?us-ascii?Q?9A1o9PmWAlNHSZRr//U1OReekmmxkHWiTjFG2KRQq8z06764Dh9wMGJE7jeD?=
 =?us-ascii?Q?VkkbEeWtFz6LzrL5lJQMrf+8OQr66vzPGnFPH6kdF+v5es3nihhep/5W+0sc?=
 =?us-ascii?Q?4fVUo4c7kCgM8NJmcXu0H1XGZhKjIOHDVqoMKnZm1HSPhEVoYb7fR4ljstqa?=
 =?us-ascii?Q?uG/lEUZksPbvMd2R9w2y8Y/d7hAT4wch/Hguy8m2iPCHTHYkqoXbYTTQ165I?=
 =?us-ascii?Q?bFp3TzIi94bWSZx861sdH7mz593ZhBRTS9Lw5OVgoR0ePkDUwkxOyJPlnZbB?=
 =?us-ascii?Q?/D9MiHQRdTNYLSDxHOAoMOwlguML0+1t+pvD2Lj0VoMZWrlW0jYah71WmmiY?=
 =?us-ascii?Q?3URu/Pb+PS63dfk2OiZDmErqwhczdSRUHN5fmxUzqZzej4mCmcFqUK2MQEXt?=
 =?us-ascii?Q?iD9zrDC8N8koConUmpRhYtkI13DipMdUTKqcEx/cv3Rsdn+B5Hb75cAxnp4x?=
 =?us-ascii?Q?fw4moJOQRpbg2jtAfpa/TAE+raNt25reyiYW6DM4tZeZAqo+lnpdtsjMUX/f?=
 =?us-ascii?Q?4Rd+snYSoTK+W++JVXXe6lqVA4bAy3UhLNASuA3yeJmvTl7Cz6vVFWSBqCWN?=
 =?us-ascii?Q?5CCKkZMcJwLuj7kEp7BM//GKZG+wCT4ttUAj63Fu1m6I4FSwOdAokZa3+KoH?=
 =?us-ascii?Q?bTZHAZezs8Tt7wNVa4Km7mQA6vGu95cQyqOnCfWss1KnNm5Ov4Apwj3W6tBB?=
 =?us-ascii?Q?R6f30oYcaxCxNoNsC8lfxYjAeD0gQqSrDA8U6gJ9lQqdeB7XZrPZf8jaYSDN?=
 =?us-ascii?Q?KieJlqI8JdsB+qiC/gWBsmw5iRoBwpmm0w4cDfFhYeW67Pm9m6fBNAbRF0rN?=
 =?us-ascii?Q?6vrdWdIJMf+d//j/RsdkFZ8ewJs3a4tYjJzJXkfWE2zRzDaz6WhM8IbognjO?=
 =?us-ascii?Q?9SVsFBuBvfKtrd2M0vZdWivCTGoCwbX7VRug1pwm/6TfH1DTb7kUgZr9c+Ol?=
 =?us-ascii?Q?pUoBTRjn1QAkDrGd5SIWOhQTEDv++ylFofvmS3GyPEdyiYusi7X3Py2My3z5?=
 =?us-ascii?Q?A4dOAvR4LCoExqzMJySPLC9nBAYAZ47wUd/nPvoppGaDb7eAfHGDAk9HHHBd?=
 =?us-ascii?Q?wN7ucdDI5grq4/r6vo8EK8Dd567T5YxVNdN478PvD98PsQw61AWO+j0scPAS?=
 =?us-ascii?Q?GA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a991c6b7-6440-4c49-6e47-08dc29923752
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 17:11:54.9729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HjupWeFC6bYVH/1JHkpQXaa42KEem1Bril2lMrOJb0qHJC6Nmw03AdRFYUCCCTmeo24GcrlhKxmMwrf7e2P1fzNLEcOzgp604k4h/u+0WAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10598

Hi Claudiu Beznea,

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: Friday, February 9, 2024 5:05 PM
> Subject: [PATCH net-next v2 4/5] net: ravb: Do not apply RX checksum
> settings to hardware if the interface is down
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Do not apply the RX checksum settings to hardware if the interface is
> down.
> In case runtime PM is enabled, and while the interface is down, the IP
> will be in reset mode (as for some platforms disabling the clocks will
> switch the IP to reset mode, which will lead to losing register contents)
> and applying settings in reset mode is not an option. Instead, cache the
> RX checksum settings and apply them in ravb_open() through
> ravb_emac_init().
> This has been solved by introducing pm_runtime_active() check. The device
> runtime PM usage counter has been incremented to avoid disabling the
> device clocks while the check is in progress (if any).
>=20
> Commit prepares for the addition of runtime PM.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
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
> [2]
>=20
>  drivers/net/ethernet/renesas/ravb_main.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c
> b/drivers/net/ethernet/renesas/ravb_main.c
> index 7a7f743a1fef..f4be08f0198d 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -2478,8 +2478,14 @@ static int ravb_change_mtu(struct net_device *ndev=
,
> int new_mtu)  static void ravb_set_rx_csum(struct net_device *ndev, bool
> enable)  {
>  	struct ravb_private *priv =3D netdev_priv(ndev);
> +	struct device *dev =3D &priv->pdev->dev;
>  	unsigned long flags;
>=20
> +	pm_runtime_get_noresume(dev);
> +
> +	if (!pm_runtime_active(dev))
> +		goto out_rpm_put;


Thanks for the patch,

Why can't this be handled in ravb_set_features() to avoid code
duplication??

Cheers,
Biju

> +
>  	spin_lock_irqsave(&priv->lock, flags);
>=20
>  	/* Disable TX and RX */
> @@ -2492,6 +2498,9 @@ static void ravb_set_rx_csum(struct net_device
> *ndev, bool enable)
>  	ravb_rcv_snd_enable(ndev);
>=20
>  	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +out_rpm_put:
> +	pm_runtime_put_noidle(dev);
>  }
>=20
>  static int ravb_endisable_csum_gbeth(struct net_device *ndev, enum
> ravb_reg reg, @@ -2515,10 +2524,16 @@ static int
> ravb_set_features_gbeth(struct net_device *ndev,  {
>  	netdev_features_t changed =3D ndev->features ^ features;
>  	struct ravb_private *priv =3D netdev_priv(ndev);
> +	struct device *dev =3D &priv->pdev->dev;
>  	unsigned long flags;
>  	int ret =3D 0;
>  	u32 val;
>=20
> +	pm_runtime_get_noresume(dev);
> +
> +	if (!pm_runtime_active(dev))
> +		goto out_rpm_put;
> +
>  	spin_lock_irqsave(&priv->lock, flags);
>  	if (changed & NETIF_F_RXCSUM) {
>  		if (features & NETIF_F_RXCSUM)
> @@ -2542,9 +2557,12 @@ static int ravb_set_features_gbeth(struct
> net_device *ndev,
>  			goto done;
>  	}
>=20
> -	ndev->features =3D features;
>  done:
>  	spin_unlock_irqrestore(&priv->lock, flags);
> +out_rpm_put:
> +	pm_runtime_put_noidle(dev);
> +	if (!ret)
> +		ndev->features =3D features;
>=20
>  	return ret;
>  }
> --
> 2.39.2
>=20


