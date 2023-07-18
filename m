Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01CE7584EC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 20:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjGRSi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 14:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjGRSiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 14:38:25 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD480E8;
        Tue, 18 Jul 2023 11:38:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=af1veLXWqx9e1qEFDRpetEu1UVfYokk1Dj2Ww6aYYmE3reC4I7FXcJpOZYRdjEQXhtQ/J063BBmJ+yucL6Lk9ZhaRVUeB+k4LwEZ6FYZUc8HJOm5JXEocMWgOFzBA63uL6purGT2q9t+/MVw0YqQXQYQ/OKyARivHsmXAs6+k+RkgCcethFCpVnpMEOyIQC8viyW6o48PdjNTiIqoiWwPkwo9mZI2AfCnXq2VTjGNqcaqUp9CFakJUvZiM/c5tjIhI0gr30dWkW164IEKNol5tKRG8Id6YK/9VHhUikga77c45pzEpPh2z9sPEpi0gPNLFSoLWPL6XRw+Q1A3lEGlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIQs2AR4jVkWNWgLMqSjFXrFjUSmRYhunFOpUrho57U=;
 b=mrksTKk4CdQ3603uQGm9/2ssA0BGLaOk0vWugdrJMeLVQjRBZTkLtlut/F0jaJiHCVxfIyEa2CX1rSUlYxIuGbhgDlI0gPJ8mz7Btz4Nvj7G9V43DojI/ONHBp0w9S79GHpJoWZhGVdLBKGc8KbPQvBIqRL/9mEBIOXN58G7/BJ6FL1XAaNBvFVYFCRYtlclcx0TWiBoUHvNS5gVhKgrsF57hreg4OQE/qVNWJcr6eAb8n3kIq0+sfKWNrUMiFtwg1g7EQwUzNnPd5H6wprKo9VVntMKjRRAYs7g0IYzJlCjvQm5TPZg4PdsWFkdlh0pCbkbedI3D5Gyoi7YP36/Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIQs2AR4jVkWNWgLMqSjFXrFjUSmRYhunFOpUrho57U=;
 b=eKvJTh8hLvZfyLhn7YHK5z/qBdxChSiqzwm/S8s8zM6QhDOufYuZTuozmtdS0OsS/bEvqT75sHOwv7Uhz1V8mkKkCNqaZVicBSVXEVt4w7tqsywTekxTbbg7AYeouQX2Wx6iPpXQ/rSxvKK3FqhFONUfAJfdTgKor3fG4DsoTRdS/BPz+marWobAlkD4pMwdUjr7tZGIzS0nhg357cMdsJSsdaHycAHBkrD5aU8fppG2uy2Jyt8UNig1uYY6Kjv7intvQxIHwhUqgKkB8F5kVtyyc4cbgnlUwqe2H/h0OOsq4NJFTmZ8YC5Gf0D1QAgfnUSvgJgylotqhTSzw8tawA==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 18 Jul
 2023 18:38:21 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::e3bb:fca5:70a7:9d25]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::e3bb:fca5:70a7:9d25%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 18:38:21 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     David Thompson <davthompson@nvidia.com>
Subject: RE: [PATCH v2 1/1] gpio: mmio: handle "ngpios" properly in
 bgpio_init()
Thread-Topic: [PATCH v2 1/1] gpio: mmio: handle "ngpios" properly in
 bgpio_init()
Thread-Index: AQHZtAoywWb5HJNqyUC9IpZWu2Qdu6+/5bsA
Date:   Tue, 18 Jul 2023 18:38:20 +0000
Message-ID: <CH2PR12MB389544F08A0A20AAB06123D3D738A@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20230711151248.4750-1-asmaa@nvidia.com>
In-Reply-To: <20230711151248.4750-1-asmaa@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|CH3PR12MB8658:EE_
x-ms-office365-filtering-correlation-id: 09a90a5c-3ae6-484d-3cac-08db87be294e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2TFKmjWMpRuaLKr43VtHoPaMy54Fcj+uq4qo4QcZ1T6Gl9snUgqomBWhsrDshJmQMXuPE6O5OKnHqKMLVfjd48tx4QA3/Dl/2fWBtp8WZKlyMaEaex4J94i37i9PucD5KyJI472VMYjGabprIU0dtxjHjxUHFeKAKy+UDemTzYYOMU2nlt5hfKt0ruQbwHUPLoYPrsAjgnMUzSHvQxe802oR/2qgNF5Mf4gXuQSu8+h9Nlaj8qThvaL8U+6pIOjI7/3mk9QZh/+Zp/FCCwv0PKPK7iZc90Z7Oe2f22JXCsFbXl1zavPxWCAMNCqPuGVEKHMQrikixijQ200MDebhnjgawXgpEXItWD25Lw+GfMmE45J8Tk0ab59vbRcsoWgUQy7xsJBNGs+K/4pXn26byyvBtBY8tzBmSUQBfHCvfpRDyk41nE3dUN/RY+blMnqEIOtHVDma9v9vYgcc2nNVQTCxUKrCj0ugGl9N04TW8kMeUbZWkG0MzK5DjZsvA3WkHm5d2iXFn5OWDk+Mqk3+eTDNy9uHQ3Sz8Bk+JIs0FewuVWiObOdFZNuCdSgNr2L3+aZHKqL88hvjV9zTu+XXEbRGzvNIGnHcljpAyizm9QdolZS8/FHI0rQqnSyHS/Ri
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199021)(55016003)(2906002)(186003)(5660300002)(52536014)(26005)(6506007)(83380400001)(478600001)(107886003)(110136005)(71200400001)(41300700001)(8676002)(316002)(9686003)(66946007)(66476007)(66556008)(4326008)(64756008)(66446008)(76116006)(7696005)(33656002)(38070700005)(86362001)(8936002)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TF+bQ45QCgKWB94+rrThQsq9e5ac4iL/iLAyaNfIVi3VY60cjn0zBYhyAK/8?=
 =?us-ascii?Q?VQBhYaIUNFwQKwaEkibptonbKn5gOuvMlaA+FT4VxqbfifVVI/DsxzEdpfDC?=
 =?us-ascii?Q?1wlP0mBmHit/3SZGyRBsHXiJBIoyfoQYXE5t+Q4XnR1d68dgXn8gghSCjOPZ?=
 =?us-ascii?Q?dwMjsQNX+Ivrkwh/mkBBE7+iFe+bfz9aQKLsMylfWyas2xIfPMencQi8e69e?=
 =?us-ascii?Q?2c0Axekvy7WgGJIxN0Q29vYD4LT4+XkHQFo41BYkLFY7B7ElDEhQjw/Zj31C?=
 =?us-ascii?Q?Dihd5/5Tr+O7DWLwoMfkwBBQmbDDpQpoIrZ60Ob6iJZA1k6GklYfce4aopPS?=
 =?us-ascii?Q?+ozAei821+UrYEVKy4MwL/9sioqNrhSNIL58hwTuM4VoHiy0EzSHtC4rkulA?=
 =?us-ascii?Q?n2SONneNpezogC4I36xmb6MI+SsZBdc8nihVBGXtiuBLVQcz1bMTSFh/zDHR?=
 =?us-ascii?Q?1FZGR9kEKFIG5dkflAUPUrR4e4X3gcatjyAYgKsMc2cFfst/AgCky4klUKec?=
 =?us-ascii?Q?5i3C6fTNP4Da+PtdyoK0kAPehbD29xnNqCQ+7kxTZMfZ6zcXYMRFtf6X1KlN?=
 =?us-ascii?Q?HGI4l6FAyX/mL9MG0iUffVz/jT0SNYedKz4o+m3kOK3w27rAxFRr5aGM40vj?=
 =?us-ascii?Q?r3ACHRhd2JsuDcgqCEVuT8aHqgYKM1D1ckl/WsoemT9htBnWI6fjJYOI6jHd?=
 =?us-ascii?Q?Y8+fue5rXc0AqJuOH6WBSchQPPb6JMFCPrUOOeRujm14poWTWEKpHjAaF9q8?=
 =?us-ascii?Q?/ZbMGFixqSjbG2eleXbK4AMOB3vZ0ir8Ew5QEKh+Rqfe/11i7/ZCP2nv1lNh?=
 =?us-ascii?Q?CPziSBFfCnIoq6w1vKCvuHsu8JKyfbzefrJuv6irWnGENb6+yttiOvp4niiQ?=
 =?us-ascii?Q?0OrSJRiTcxYIEBE8tK9gPsh+bLQg1eUHXWPOhqaD+XEkHwa8CBoSG1YiJegs?=
 =?us-ascii?Q?sV+rGD8FrOQnE6ZEssUwQJ20E4GcZPqqOAvHYI8mK9FMQ4Z0I3EtFke6L/Ob?=
 =?us-ascii?Q?YbMx2Xso8xu3h/DhzUEdDkQoq7/uFJzq+3TPg4XKNLT7YCunE2M0jj5ZXx4d?=
 =?us-ascii?Q?ICQhWY8t5LUhof9BCXy2liavgn8JE2MfEaF6Uu0xJuk1fTbs/bHxbAfWmZiz?=
 =?us-ascii?Q?jEkBU23OTSLRwUxtdKvOEMb468ouuglAfJXfZkry9Uu624TlVzSchht0Y6+o?=
 =?us-ascii?Q?lSI9VXg98zH2kpehAh+Q6jjjqg4InDjYznmQm78AZgcBy0K0o4cRnAtOro2Q?=
 =?us-ascii?Q?vG0MNweCiHy6NhPpjA5r7a1cgin/hfDIBmin0mBEW0C+O89JFY1OFPu57ijz?=
 =?us-ascii?Q?xlMAMCTjTQX9CmaTkVyaZKqaGxY9+sXxNpLDBToD1UyHKM/O8xw8XORC6TrK?=
 =?us-ascii?Q?6tDwPv1ie5Cf7pGRFVHaP6uIVQo+7pePwS6EgP8YcfSKxW/cvs9M9wFnL2Bq?=
 =?us-ascii?Q?soG/Pm7EQR42g5yvUkyyzBCEiZ5On8nqNayXfMIKytKBeghi8DCab6qDI2xi?=
 =?us-ascii?Q?5xlivjzp9/RwIno4dXWeiGZSzBb6XMVW2/Q3ce4SLCYD4Ent3xJYUuorei/5?=
 =?us-ascii?Q?5FNaR4PD1pDVWtOvbGY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a90a5c-3ae6-484d-3cac-08db87be294e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 18:38:20.9357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YIDq9Uj0J2zFwKjgYZEVnOiqNQkF30EsiwMGXT8KVmzoNdTTDG67hqXIeifWulcUJlSWKU/Rt+yR9UsadyHc8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8658
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 > bgpio_init() uses "sz" argument to populate ngpio, which is not accurate=
.
> Instead, read the "ngpios" property from the DT and if it doesn't exist, =
use the
> "sz" argument. With this change, drivers no longer need to overwrite the =
ngpio
> variable after calling bgpio_init().
>=20
> If the "ngpios" property is specified, bgpio_bits is calculated as the ro=
und up
> value of ngpio. At the moment, the only requirement specified is that the=
 round
> up value must be a multiple of 8 but it should also be a power of 2 becau=
se we
> provide accessors based on the bank size in bgpio_setup_accessors().
>=20
> Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> The following 2 patches were approved in March 2023 but didn't make it in=
to
> the tree:
> [PATCH v4] gpio: mmio: handle "ngpios" properly in bgpio_init() [PATCH v1=
]
> gpio: mmio: fix calculation of bgpio_bits
>=20
> They needed a rebase and were combined into a single patch since
> "gpio: mmio: fix calculation of bgpio_bits" fixes a bug in
> "gpio: mmio: handle "ngpios" properly in bgpio_init()"
>=20
> v1->v2:
> - Added the tags
> - Updated the changelog
>=20
>  drivers/gpio/gpio-mmio.c |  9 +++++-
>  drivers/gpio/gpiolib.c   | 68 ++++++++++++++++++++++------------------
>  drivers/gpio/gpiolib.h   |  1 +
>  3 files changed, 46 insertions(+), 32 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-mmio.c b/drivers/gpio/gpio-mmio.c index
> d9dff3dc92ae..74fdf0d87b2c 100644
> --- a/drivers/gpio/gpio-mmio.c
> +++ b/drivers/gpio/gpio-mmio.c
> @@ -60,6 +60,8 @@ o        `                     ~~~~\___/~~~~    ` contr=
oller in FPGA
> is ,.`
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>=20
> +#include "gpiolib.h"
> +
>  static void bgpio_write8(void __iomem *reg, unsigned long data)  {
>  	writeb(data, reg);
> @@ -614,10 +616,15 @@ int bgpio_init(struct gpio_chip *gc, struct device
> *dev,
>  	gc->parent =3D dev;
>  	gc->label =3D dev_name(dev);
>  	gc->base =3D -1;
> -	gc->ngpio =3D gc->bgpio_bits;
>  	gc->request =3D bgpio_request;
>  	gc->be_bits =3D !!(flags & BGPIOF_BIG_ENDIAN);
>=20
> +	ret =3D gpiochip_get_ngpios(gc, dev);
> +	if (ret)
> +		gc->ngpio =3D gc->bgpio_bits;
> +	else
> +		gc->bgpio_bits =3D roundup_pow_of_two(round_up(gc->ngpio,
> 8));
> +
>  	ret =3D bgpio_setup_io(gc, dat, set, clr, flags);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c index
> 251c875b5c34..7dac8bb9905a 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -700,6 +700,40 @@ void *gpiochip_get_data(struct gpio_chip *gc)  }
> EXPORT_SYMBOL_GPL(gpiochip_get_data);
>=20
> +int gpiochip_get_ngpios(struct gpio_chip *gc, struct device *dev) {
> +	u32 ngpios =3D gc->ngpio;
> +	int ret;
> +
> +	if (ngpios =3D=3D 0) {
> +		ret =3D device_property_read_u32(dev, "ngpios", &ngpios);
> +		if (ret =3D=3D -ENODATA)
> +			/*
> +			 * -ENODATA means that there is no property found
> and
> +			 * we want to issue the error message to the user.
> +			 * Besides that, we want to return different error code
> +			 * to state that supplied value is not valid.
> +			 */
> +			ngpios =3D 0;
> +		else if (ret)
> +			return ret;
> +
> +		gc->ngpio =3D ngpios;
> +	}
> +
> +	if (gc->ngpio =3D=3D 0) {
> +		chip_err(gc, "tried to insert a GPIO chip with zero lines\n");
> +		return -EINVAL;
> +	}
> +
> +	if (gc->ngpio > FASTPATH_NGPIO)
> +		chip_warn(gc, "line cnt %u is greater than fast path cnt %u\n",
> +			gc->ngpio, FASTPATH_NGPIO);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(gpiochip_get_ngpios);
> +
>  int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>  			       struct lock_class_key *lock_key,
>  			       struct lock_class_key *request_key) @@ -707,7
> +741,6 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data=
,
>  	struct gpio_device *gdev;
>  	unsigned long flags;
>  	unsigned int i;
> -	u32 ngpios =3D 0;
>  	int base =3D 0;
>  	int ret =3D 0;
>=20
> @@ -753,36 +786,9 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc,
> void *data,
>  	else
>  		gdev->owner =3D THIS_MODULE;
>=20
> -	/*
> -	 * Try the device properties if the driver didn't supply the number
> -	 * of GPIO lines.
> -	 */
> -	ngpios =3D gc->ngpio;
> -	if (ngpios =3D=3D 0) {
> -		ret =3D device_property_read_u32(&gdev->dev, "ngpios",
> &ngpios);
> -		if (ret =3D=3D -ENODATA)
> -			/*
> -			 * -ENODATA means that there is no property found
> and
> -			 * we want to issue the error message to the user.
> -			 * Besides that, we want to return different error code
> -			 * to state that supplied value is not valid.
> -			 */
> -			ngpios =3D 0;
> -		else if (ret)
> -			goto err_free_dev_name;
> -
> -		gc->ngpio =3D ngpios;
> -	}
> -
> -	if (gc->ngpio =3D=3D 0) {
> -		chip_err(gc, "tried to insert a GPIO chip with zero lines\n");
> -		ret =3D -EINVAL;
> +	ret =3D gpiochip_get_ngpios(gc, &gdev->dev);
> +	if (ret)
>  		goto err_free_dev_name;
> -	}
> -
> -	if (gc->ngpio > FASTPATH_NGPIO)
> -		chip_warn(gc, "line cnt %u is greater than fast path cnt %u\n",
> -			  gc->ngpio, FASTPATH_NGPIO);
>=20
>  	gdev->descs =3D kcalloc(gc->ngpio, sizeof(*gdev->descs), GFP_KERNEL);
>  	if (!gdev->descs) {
> @@ -947,7 +953,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc,
> void *data,
>  	/* failures here can mean systems won't boot... */
>  	if (ret !=3D -EPROBE_DEFER) {
>  		pr_err("%s: GPIOs %d..%d (%s) failed to register, %d\n",
> __func__,
> -		       base, base + (int)ngpios - 1,
> +		       base, base + (int)gc->ngpio - 1,
>  		       gc->label ? : "generic", ret);
>  	}
>  	return ret;
> diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h index
> cca81375f127..8de748a16d13 100644
> --- a/drivers/gpio/gpiolib.h
> +++ b/drivers/gpio/gpiolib.h
> @@ -217,6 +217,7 @@ int gpiod_configure_flags(struct gpio_desc *desc, con=
st
> char *con_id,  int gpio_set_debounce_timeout(struct gpio_desc *desc,
> unsigned int debounce);  int gpiod_hog(struct gpio_desc *desc, const char
> *name,
>  		unsigned long lflags, enum gpiod_flags dflags);
> +int gpiochip_get_ngpios(struct gpio_chip *gc, struct device *dev);
>=20
>  /*
>   * Return the GPIO number of the passed descriptor relative to its chip
> --
> 2.30.1

Hi Bart,

This is the final approved patch by both Linus and Andy. Please discard all=
 others.

