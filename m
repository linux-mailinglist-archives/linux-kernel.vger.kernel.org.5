Return-Path: <linux-kernel+bounces-49405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F547846A12
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C92F1284F4E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3223417C6E;
	Fri,  2 Feb 2024 08:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Xa2oA6Yg"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2119.outbound.protection.outlook.com [40.107.114.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AC318622;
	Fri,  2 Feb 2024 08:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706860994; cv=fail; b=f4YrftCIqiy8SbryxUJE9ipBrPLmuFZsjFUciE81oTwS2EOkZP2K2Oun4rXDSquqmm2lkxCinTZ7N9xV0uHZ9jzaatDfA5LwMcYkJCJx9TY+ochYl2kKo7kTG8Jl37PFPlmmea6OQj/iu+4TDZpPzn7N82kFCKDYX5AkvbFxRwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706860994; c=relaxed/simple;
	bh=UIy3qcadSz+rn2DhJqBd8oZr4DzKRE5GgLrfJqR8wJw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GfENE3hdijwLc7U8rLjG8w/oMsPSdLzqB0iDjOv2xFU+KCmsmysxWURtPZZQ2HoS9iB//UwqPJDil9NgIHbRAqZXJAaZXvJKKpKTzAawvYM8wyBAWgAsKD6KJnYxAjZ58w6UbF2WjnnpqAlU66Cj/fQM/XsdN3G4dbWjsz2frKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Xa2oA6Yg; arc=fail smtp.client-ip=40.107.114.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XS1m1wrxo8jw+Tb1PsIKAlwZZf4/KME0SwZ1xgWeEeVhMkQ2h3QjZ0NEoHwPXNKbAS61sXdVAdE7LH+Z+lDyeByRF2njVGcFMSqMESoPKU9CgppaqQ9QT3KHynIu6lINwCro/Rg8Z6SOoVdxG23oIGgdYa9OS5niaQ89eIBeoTfksGVqTeJqg6iZG3OMS0+V+/Mowx7giyQDpTkmfQp9az1aEgmY3DnJbjRgaE7bNXF/ZQYI6JSCKFCgfv17YfkOen+qoWPlOmdO+Tus8rOEiWJiwwX3JxjvQpoDuoK7DtusTgGiDZegzjj7POwmoC/zbkBMi0QU6zdoLW0AahxZyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMCeIj/IHlVTfmof3vhI5FDazG9+bH9HJE8cDf/n+HU=;
 b=J2oxliAG25PX5j7BnJb8fylrYv8pY43hNvuQtsyBoBV6iey94JgzAuT2xUt9/S70b83WxzpEMUQu9b204KdulgEW6ghHQlSp1XDUpjZ0kEk34eOV4wGhQISqVg6fXRNmGTQdRjJMDk5KjbJYwe5WKwRAnpgxxXmxQ6FcQGZOfDovglT9RAciw0kXfVM5CVCYsS6chSijQKDSWIShTgP183boS1lB48cV4IzZKG0egz2OPRRd5xiSAlsTPMEOb76gHgH9LY9h6qfomuhG19fXBAhUFGJtXcjQEMQYJV1HTRFfhbhgGU8i7j12B4AStYhjsnzCiFCHNwr6h5VKwdUBUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMCeIj/IHlVTfmof3vhI5FDazG9+bH9HJE8cDf/n+HU=;
 b=Xa2oA6YgGQtdt4G4AqH40brKC17Mvi4OSrpL9gcTUUkv5krQ2md2jBSas7JxEhIdIIj/CrU6Ywor3MxCM1YXnSZGdm6Teu953o5Su8X8Go2yCNbzv2xSf2lSW4JSpfE1cUTUrSJJzDyYpUmL0uQwDykNpOC8LRlyv/xGcSldBvc=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYWPR01MB11274.jpnprd01.prod.outlook.com
 (2603:1096:400:3f5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 08:03:06 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0%3]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 08:03:06 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "wim@linux-watchdog.org"
	<wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>,
	"robh@kernel.org" <robh@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>, "magnus.damm@gmail.com"
	<magnus.damm@gmail.com>
CC: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Claudiu.Beznea <claudiu.beznea@tuxon.dev>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH v3 1/8] watchdog: rzg2l_wdt: Select PM
Thread-Topic: [PATCH v3 1/8] watchdog: rzg2l_wdt: Select PM
Thread-Index: AQHaVa2xeucsotW+XUyR5O7FIAVIxLD2sMaA
Date: Fri, 2 Feb 2024 08:03:06 +0000
Message-ID:
 <TYCPR01MB112694BA3A47579AE8BC1752B86422@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20240202075849.3422380-1-claudiu.beznea.uj@bp.renesas.com>
 <20240202075849.3422380-2-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240202075849.3422380-2-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYWPR01MB11274:EE_
x-ms-office365-filtering-correlation-id: 980c6869-fa32-413d-0f8f-08dc23c56350
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 bMPhhMNHgpG33teSlu9suBXdHOb0bxyb6QvCo/InPwe9M3ILgy4+oof5WC9JYjdBA46S8g15lhGpxqk+GBAIxxugjATNPDuZ8DoVKpEbhiwRkwlmm7r1ZRH0WsKJnVvHL+yAlQ8iNFLLtnzCnGmLt7qQFgS2OWuICU47ikZ0l9+23wBEUrQeUZPGFaNPnwLvlYB0v9gFgsXScLRMZqVhxzGBQR0kZI3dx81w8fzTEqqjKiX2K9asbGQJriEj421dql9bFBhF0PckeBPGBSVUlq1rST+mQnShe9pTIazNWRh1KuNHxcoDUMtCpWBAEmFVIV6g7DteKGVNib9VsZ165aUPR1HPXaF7HB9lYCtbCxgwZRepyO0q+jlNZ9sH7fI89XfhBIPw+98Nqcq0ipU1qOIhfDHPgSJ6vOt/YacN1YWSjqrtkinyiEQtBg19U676V2QBlTFx9u/fFhOCL2o/qoVBlQINIazTuNjKUeISTqjFrfWiwWfwIHPMGNV3LVF7HNIGuYcIdxZma92LXqOvC1JP9sMLLStU9dKtUdy1g9D40OVw9wRLwX9AVo3kjgMmKDJb9h2IWQv+IsSGImmb0WOnMibuUsCXjmQ3po8N37yvYY9i/PVg1dWnyjZ2W20H
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(366004)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(5660300002)(71200400001)(33656002)(7416002)(83380400001)(2906002)(7696005)(6506007)(53546011)(41300700001)(38100700002)(316002)(54906003)(66446008)(66476007)(122000001)(66946007)(76116006)(64756008)(66556008)(86362001)(55016003)(26005)(110136005)(52536014)(38070700009)(478600001)(107886003)(8936002)(8676002)(4326008)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GEMGXhwxYr5Co+PTUUg1A/WWGkxC617VqtB+wqJXE+PnCOLYdE0BfqYAxjeb?=
 =?us-ascii?Q?TyHjJ1LrVN33+Cy1/JGKh0ESohwPS+QTQPKQLnwgYvXjztztfLyAGhvoSS6x?=
 =?us-ascii?Q?7a+opEeA5G1nvDKjw0n/VAwoXc4Zg/9pVoaSfgaDRQNQecFoXvs2cuAtVWst?=
 =?us-ascii?Q?ZBMpEKxEyafSVVsEFm2wvgcCzf6ewO/nCoXe2dRwPHfUFuHGE3924HzO9FOz?=
 =?us-ascii?Q?Y4FI3udDKhPT+8l2VOhgfSBwr6pH1v7rDxjVRGjB1aHsL+vF0ZI8S1JlAm2j?=
 =?us-ascii?Q?ndXieNw9GKHgFeX8hHdbrL375Rp42JGYWm6RbAen3WXlVtLryw233qmxZ1DI?=
 =?us-ascii?Q?/H557b5XeeHlemwYXsc0a3Om6VSw64LGXnIeIifmHf5/y3jYt8vvDpHQJIOL?=
 =?us-ascii?Q?Isvoazuf5eo7Xib/BhWTIL32mf8LK8BbfxzlCrZ5eez4expE2O4LyNhGl+BF?=
 =?us-ascii?Q?OfbN7MOlWKm7xEW3oUDKrcJtRKUmCIFo3E4k7q0/GNo0OAG0UosxAGM7NY17?=
 =?us-ascii?Q?6ZFzdMFgOHPlMZRLoTd/S3I8ewaKF4iGvE2XPVREoKWT3eh3DyWLh6kMywWP?=
 =?us-ascii?Q?rBkhcphVkXYZsbn4ppsz/pF8dZdtA3Jjbsdj4GrCndc4yowFq4oRFBU6TKFn?=
 =?us-ascii?Q?PsVzPC9H9xReebG2N5ohkFthyR5p3p1x/8KXGAV7mBzoKYZ/DguTmKRcv4Y0?=
 =?us-ascii?Q?pX6Wx68W6sYnwFBxT9LrqQuJfbpLRsp+l0Gyj3qK69lQb+U/5R5tRRRhEZNv?=
 =?us-ascii?Q?2o4EF2K3gVnm2jDiGWhNC6g16t4ZxtFZX7nDYe0d9ywbTF6mDrT9Jh0DWN2M?=
 =?us-ascii?Q?xuobO9/U6lz0Rhw4sFFn1WZpjTge0ePGlX9Dp9kspw8Z9kpjvpZtEpsmTXM5?=
 =?us-ascii?Q?apyeMkYLJJ3kG2RIiuwvvZ4PnPZBpmWi7sCp8bgQHKwCv8sKa+zbPvZUhC/R?=
 =?us-ascii?Q?+iGdmUkJtsF9UGwZaNFeNrYWWi2PO24L+dFrvpFgXbLI5usoqee9ctjQ7eRm?=
 =?us-ascii?Q?9jv3StcWD3VxhUryC8+wWr4PTQrfWVFFHBcLSz56rwddIXRcxxfsyCrCLbD9?=
 =?us-ascii?Q?jBqaWx27zbUyPnocbR3ytjdT9tp5VjA3wS9/4plrw1v9MtIChlK/9d8E2gVv?=
 =?us-ascii?Q?z6vbRqpbyKBihUqVqdJTT5V0sD6GFIC42MP1Zxguggkn/Tu+CEjwd5Tel6YI?=
 =?us-ascii?Q?WKO42b+RJx4QSCfoAul5fHu/SNpjNCvVaBZBsTtORFljcd7xQ1RcH4v/ty+L?=
 =?us-ascii?Q?FYm2JZxU64raknFxnSKhNXiKUNlg6RlZsYQhSLwG4gQ7CemjFt5zNpQssxPi?=
 =?us-ascii?Q?Y2FdiKquQLgdT1pblimcirpu7WV/2Cmgrv7ppAw0si/HDCIb2Aa/r1CsUQyi?=
 =?us-ascii?Q?Mp/oEgAMGKDSRcLqcE18AIVhubFa5zJqY4OT6Q1nmrANv0y+3fokX4XZrC5o?=
 =?us-ascii?Q?ld4hGj7odFVW7dKuaeiIaTkiYcNenwsG6HoW9MV5gJyH688hzlgza6OA4lkJ?=
 =?us-ascii?Q?c7QY+EaELXg4xkVpBIKSaYycdkwMqb4uCg1ek+or7PDJXc9IK5g9WHP+biZy?=
 =?us-ascii?Q?noQ6NnUkPHO8bjkdARLUpAvGwgU+K/wWt9gFr50kKcF2FjPGn8RcrcCj9Usl?=
 =?us-ascii?Q?vw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 980c6869-fa32-413d-0f8f-08dc23c56350
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 08:03:06.1152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C0LrGxqCKBebluOmlrkcTF57QXcC2LBnBc5WrnWN6jfwaDFiRfG5/muwK9F8ihi4pf0AmhLq14Q6VPiayDjjonMFO8hyrADNgMa7Og5L2oo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11274

Hi Claudiu Beznea,

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: Friday, February 2, 2024 7:59 AM
> Subject: [PATCH v3 1/8] watchdog: rzg2l_wdt: Select PM
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> The rzg2l_wdt watchdog driver cannot work w/o CONFIG_PM=3Dy (e.g. the clo=
cks
> are enabled though pm_runtime_* specific APIs). To avoid building a drive=
r
> that doesn't work make it depend on CONFIG_PM.
>=20
> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>=20
> Changes in v3:
> - make driver depend on PM; with that the "unmet direct dependency"
>   Reported-by: kernel test robot <lkp@intel.com>
>   was also fixed
> - adapt commit message
>=20
> Changes in v2:
> - this patch is new
>=20
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig index
> 7d22051b15a2..c9abe8f307bb 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -910,7 +910,7 @@ config RENESAS_RZN1WDT
>=20
>  config RENESAS_RZG2LWDT
>  	tristate "Renesas RZ/G2L WDT Watchdog"
> -	depends on ARCH_RENESAS || COMPILE_TEST
> +	depends on (ARCH_RENESAS && PM) || COMPILE_TEST

Since you are touching here, maybe ARCH_RZG2L?? like other RZ/G2L drivers.

Cheers,
BIju

>  	select WATCHDOG_CORE
>  	help
>  	  This driver adds watchdog support for the integrated watchdogs in
> the
> --
> 2.39.2


