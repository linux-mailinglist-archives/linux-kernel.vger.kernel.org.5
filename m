Return-Path: <linux-kernel+bounces-46239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6D1843CCD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97F4C1F31EC2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2AD69D28;
	Wed, 31 Jan 2024 10:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="gjF2iIng"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2113.outbound.protection.outlook.com [40.107.114.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A5B55785;
	Wed, 31 Jan 2024 10:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706697163; cv=fail; b=sxIMZsVEOpU7zIlefbr2POMZOkdmaewQAM40/qBpCpufIjVHvkbP6Di5DsDlnLhDNBbylCGC/ayDXczg527awyPZ/7G98YDsRX+fhXWmENkCOLfodbRIQ7aP2eiLgOwpARuyKTSd+z1wyH7zpl+KA6cql2BT6K9Csyq3CvrMN0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706697163; c=relaxed/simple;
	bh=lXaaWmSVdC2n7xFiY0OYy6AiDIW9bU4gZTblx70q9TM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sXTMCbG9hHGm08olI4C8xwN+jXJzYjUsu5WApGd1oeG6WhusUqPppfDJJ084LXH/vSH9KPbTqzNNDdC9PhOP9ktUZvD8omZH1xVa5xSlUcRaxSVf9dN3UZa58lvoGAYqRPphEqwSYNyxwKGes3MM1AiCubkPICwRLBR0rRz7meg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=gjF2iIng; arc=fail smtp.client-ip=40.107.114.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7BVdBZ/WiBA7QE//oyMcRl92T+VEljk9BS/mXKGYmb/dIIWQVOHDksJnAtg/uYdkZo0yErGgIF0vykPV6CB11gLjuVW1lX7ScsxWDvbhgKVMeJjef/CLEXS128p6VbqwmAesgGrQaaY/llKlw8y3mrox9zQWv1bdoWlvs4pDjuXG0egpqPqafxkNd7edxynTtusa2hZEuhnnga/NNoCa7OAn+ym/6FxApd7RGrYzm9m/p8dhvhZ3rzRh7heDNFMMZDYaAQtd+igNROJ/vVqgIej6uYJvXaVuaoe+ROgz0/EYmJEiPTSch6M4LZQyGl5IsNUYCd5Fpig1GEcyrmMvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVrHWtTAF4b4ZhQDsOAefrD6HfGEu4JHO732nhYOMTI=;
 b=O5/1bV6CfEQHlq6gpsR/RnonjRyphs96FXi7BVaGd1bxsA+jr+c3oi5RhOP7nPFeWP5+eiYSpZjdyI+SVnYa8oPYGpGnKtoWeBamE1ZmFb+AagU/VYTUQtQS843A8jW1VzOB7EB2OzdcQw0qb7C18JcRvDjabxzifDPzwtv2TJYbJhVDVgaQjXXGULp7iG9wSExzP4qEW/k5UTUcAn0IVOoDymicHGrE8CcpgnBWsQg8g/IIHBJOFEFDTzu33IodWVKCVRxl0qk9AnV2oygl7Zhq4OG8t2+LtEficRgpAyxtLDM5PkExMTtJrF7WW+ecK+JG8HYRI8A5J4MY6WHVHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVrHWtTAF4b4ZhQDsOAefrD6HfGEu4JHO732nhYOMTI=;
 b=gjF2iIngNbGg4qQVGHcaJ4VNq9PWP9neRAZ79s6L9Oqc17xU3nzr0neXyGBRb1D+wSLS8N3Hxqgy40XF0Vo5uZxvO8/JlL46+AoxVlK9mO4agdc/jrezmfmYXTqTX70yS5ZR0i57W5PLIlvaGjmHEpVT/TDjPc66QnH6jcEYs70=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYYPR01MB10595.jpnprd01.prod.outlook.com
 (2603:1096:400:30a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 10:32:37 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::8d12:a02a:9fdc:9c78]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::8d12:a02a:9fdc:9c78%5]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 10:32:37 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "wim@linux-watchdog.org"
	<wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
CC: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Claudiu.Beznea
	<claudiu.beznea@tuxon.dev>, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH v2 04/11] watchdog: rzg2l_wdt: Check return status of
 pm_runtime_put()
Thread-Topic: [PATCH v2 04/11] watchdog: rzg2l_wdt: Check return status of
 pm_runtime_put()
Thread-Index: AQHaVC8iXcXSbumPXUOI0ciCmgv5kLDzuJVQ
Date: Wed, 31 Jan 2024 10:32:37 +0000
Message-ID:
 <TYCPR01MB11269AD7463C9C7C0A09A43A9867C2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20240131102017.1841495-1-claudiu.beznea.uj@bp.renesas.com>
 <20240131102017.1841495-5-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240131102017.1841495-5-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYYPR01MB10595:EE_
x-ms-office365-filtering-correlation-id: ee248fe1-459c-4081-0e76-08dc2247f19f
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 buu0K786TbU/bsHp5Rx7ICxBAIytfhZu6f6adDwK7VNd9JW9oaAbEgFJtNGHBN2+Tqgg2EmX7nIbizsQI5fJzPjAAfg7TFBN1EOb5XdB07nJFSGQOmeDf58WhJ0MuXOZoPZcBjFK677I5z/x+osR2iX2p5DbRMW8CthcFlkyGQE5XR3IKLcuV/b/62Pl+oFVullVeRGYTW/nS9pvJFniBL/9XCk0bG5RqwFXSfno/d3BACP7Fd7TwskC6OQ9zM6MnJ2hCLygJvwjxCjechF01Qa6Zsf9AJrXR5CGk9TmEjxWjfufhp1Hf0OwS0TmyKqspS+405o1w8Lufk89w+tuMp74TTWKy0nA9xiaL2HzqJkLIsQt379YemyerbNQPevk5RutIoVudhNbFi9A8tiP0gpVdyHUoDaQ1vF57aueQHsUQX8D3Nmx+YrAamRJw8RwgoLXWu6Tn1rC3M0hWe3Cz+Dm1Jd627xcnvdKG+cW3FVehDtEqaVrQuIA8a19Bkr5xJt8juiGHzA4Wrf9SRABTUxf2V4l60Yoi8tWe7qLedqguhhuy+YzJspg2MGdVTRinPxMIaTs6BP34AJc/Q87ny4B0gxGzpI6hMTwfwIi3oj3uUzBl45CLU446RdYW68x9VeITo3ggtFWUOkIKOH0XQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(346002)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(8936002)(2906002)(5660300002)(7416002)(26005)(4326008)(33656002)(8676002)(107886003)(55016003)(122000001)(38100700002)(86362001)(41300700001)(83380400001)(7696005)(110136005)(9686003)(66446008)(66946007)(76116006)(38070700009)(66476007)(64756008)(66556008)(54906003)(316002)(53546011)(921011)(52536014)(6506007)(71200400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HaUhnPIPrvWifMn2W8IplW5mCkhT1d04VxhCzHVMfc8I6TDeFcDq5eCGkAT2?=
 =?us-ascii?Q?V9PQLHNlD18gGs10SWqdh1eBiRviJyfucItQEUxwlo+h7ZPYKZ0c00ORbk5E?=
 =?us-ascii?Q?dmJUHgaVN6FXBHAlFnhCW+G0jtavmTpol3M1wS/UYuoRdN8zaRko3holo1pR?=
 =?us-ascii?Q?C0SRnfgd583nTQcUtyUhTzUEsRTzmeEsCn52AXYHQM5axix/glRTo0+3Yov/?=
 =?us-ascii?Q?omlF7dRjQsATZL5J27sI4GI+65qAFj1FiO1OtthfzAgFuufVjIpWl+9RjzGE?=
 =?us-ascii?Q?0ctUkyuIDi3OFCUnwvFoyx0cX2mp6gV+zGsnOmlwW05+meVelwwtCbcgt7EY?=
 =?us-ascii?Q?A2aI66eOGDUYV4HhupJKcEEcUW6VLEJlFyC9ayLYkq3bYGxSF5g6VKpZheYe?=
 =?us-ascii?Q?iqqugJEhw2c8UC9Cv8B/pj02FArMYPuVKvTXgRKTqsASxl5wx1TJmBLqIQvI?=
 =?us-ascii?Q?liBYvagF7VMSWAC3nVRKxLhh4j2TR10y3w7kQ/faXs7G/uGNIqdPoNcgCesn?=
 =?us-ascii?Q?WGUN7J8lL9Xdqz3bpydoGhflYW4hmh7eEtFzwJFVua6LV5b+A7ipNTNiqhFl?=
 =?us-ascii?Q?6ZBuro51W06l2nFnC1Y8edvA0klxU4TK3bcdNjZZmk4VrmMsik/E3Xpkbui1?=
 =?us-ascii?Q?Go/ZKBr851y0HE/2bqLJC2iAiS1rO40wXeVOxB+GeWUaOq6AYTE/AgXGS+MI?=
 =?us-ascii?Q?SX/t8XRw5t2Mgcshyv2irFkhFN9SwWdcQesyca1vLUEaIbUd4HtNJpF4ZdOF?=
 =?us-ascii?Q?AElPfHpD1pgleXrCsuiR2PpyiZYUiQCxDwo6fwzTmKWiwjqXLt1P7dVqcb3W?=
 =?us-ascii?Q?5onlIAvL00eC4oyj0lXCvXZREoR47kxtdNHgU4FUHobw1IEp1InZNS8Um5et?=
 =?us-ascii?Q?qyYmXlQ54RmxAXSwmKFHiNuy6mNwDguf1wk+N1cSCBYu5D422IB04o5nnZ67?=
 =?us-ascii?Q?Srqam2v0yZM8xDk9Q9WxpfQDz1fh2mIuB3QO/MPBXfOM8o8aCYf8rCa7wzi1?=
 =?us-ascii?Q?I0Aj8JlhTCF2lLFh+s+2xxy0/3CFnjrosKMMkeCqhYWGBGYBBMRyMjzbaKOn?=
 =?us-ascii?Q?6hdY29o/dfJqz3+RijsPOl6BgxQP2iTsydouPmoRCtW/Eq8bAgTI3PxRyeq8?=
 =?us-ascii?Q?eh8A9+rI9Q6E+ms5YsySQo2bwcUT40roij2s0YlEzSSCaZ9gKhir1bC2aemU?=
 =?us-ascii?Q?gFDMn133L/H7zu+gkYbqUQk1AqKpyGeQEuyT1HopHfDgAbdvr+HF7F8bRG5U?=
 =?us-ascii?Q?Ng45ADliSfM9TXl8h97jRBFQaqb9HqUTtkwYCBCTZg2dtU6L3IN6HqBbP99N?=
 =?us-ascii?Q?zzgTyBeUphB7/45Ciw6Mmf7Cc8/lQ8zHcffQ1DonpQyRT4h6fgSxqPHDwd4J?=
 =?us-ascii?Q?DQBwJTWUlLxRaxfYcUunvHXWlSlpAwjTUklHrONCJNiV4nV6kF1FOZUkR1e6?=
 =?us-ascii?Q?HQaKqtuQlFr0IXGgbkE4u2G4a3M/ZZ94/5uY5iSG10GbtAFp4mKVZaN9oHRi?=
 =?us-ascii?Q?IJNKPnScG3b0vL84gc/XAjBg+vCpfvzPxG+XQvzmTSlUstaQh6CNR7Nq/2ls?=
 =?us-ascii?Q?dUHl01mWRPUgf2qv0PSy8/SYm/ZRWkiQDKYhANekctQ/C8q7tjOpIMH3oTN9?=
 =?us-ascii?Q?VA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ee248fe1-459c-4081-0e76-08dc2247f19f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 10:32:37.1240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 84JPnMe2MCSMQP6dhlEt5CCkhLJRTmBErtkJXSO39MmJ9C5KKnr73CoRW1/cYNPfUaDxV2I5IMevIiwD7KvhpfNe3M/2Jg2UG1AXEuO/RJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB10595

Hi Claudiu,

Thanks for the feedback.

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: Wednesday, January 31, 2024 10:20 AM
> Subject: [PATCH v2 04/11] watchdog: rzg2l_wdt: Check return status of
> pm_runtime_put()
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> pm_runtime_put() may return an error code. Check its return status.
>=20
> Along with it the rzg2l_wdt_set_timeout() function was updated to
> propagate the result of rzg2l_wdt_stop() to its caller.
>=20
> Fixes: 2cbc5cd0b55f ("watchdog: Add Watchdog Timer driver for RZ/G2L")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>=20
> Changes in v2:
> - propagate the return code of rzg2l_wdt_stop() to it's callers
>=20
>  drivers/watchdog/rzg2l_wdt.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
> index d87d4f50180c..7bce093316c4 100644
> --- a/drivers/watchdog/rzg2l_wdt.c
> +++ b/drivers/watchdog/rzg2l_wdt.c
> @@ -144,9 +144,13 @@ static int rzg2l_wdt_start(struct watchdog_device
> *wdev)  static int rzg2l_wdt_stop(struct watchdog_device *wdev)  {
>  	struct rzg2l_wdt_priv *priv =3D watchdog_get_drvdata(wdev);
> +	int ret;
>=20
>  	rzg2l_wdt_reset(priv);
> -	pm_runtime_put(wdev->parent);
> +
> +	ret =3D pm_runtime_put(wdev->parent);
> +	if (ret < 0)
> +		return ret;

Do we need to check the return code? So far we didn't hit this condition.
If you are planning to do it, then just=20

return pm_runtime_put(wdev->parent);

Cheers,
Biju

>=20
>  	return 0;


>  }
> @@ -163,7 +167,10 @@ static int rzg2l_wdt_set_timeout(struct
> watchdog_device *wdev, unsigned int time
>  	 * to reset the module) so that it is updated with new timeout
> values.
>  	 */
>  	if (watchdog_active(wdev)) {
> -		rzg2l_wdt_stop(wdev);
> +		ret =3D rzg2l_wdt_stop(wdev);
> +		if (ret)
> +			return ret;
> +
>  		ret =3D rzg2l_wdt_start(wdev);
>  	}
>=20
> --
> 2.39.2


