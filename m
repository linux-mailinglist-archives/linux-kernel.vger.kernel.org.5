Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BC37E2099
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 12:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjKFL7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 06:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjKFL7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 06:59:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0752CFA;
        Mon,  6 Nov 2023 03:59:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C839C433C7;
        Mon,  6 Nov 2023 11:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699271943;
        bh=0/iPB7BGJOOJheSQGLmXtcW0iKZV6qsZ+l3XvUdsfXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FlmsGjPON5hG1J3Oy5ruB9nhNCtxbie/6vZipquhRO95/NGJzGLcgdvIDvfSkaWOW
         N87TIaNrW1H22B+ngSZhdz4hrIYWRfq0Fn007YEyAa3y0TVLukix/kbH5YFqRdZGNB
         gKhYCz+KCd1OT57XsgTuvhYfG8oyS7EmHT0yEM+BwshCqnHw5+G10YPzdVFoAnEauS
         aQhXsae4FL7MGT95WgC1uXI8xt6w1XpUO/eyWepbtIF8uKZOM8M6I6NNgn2KC4n0x2
         bfOI9hF6FN8W+cJDtlnI96QKDy3KNj+Pm0FaId0NB/SLqHvJH4DP22tGHk6jVHVTVr
         67SaE07Zlsb4w==
Date:   Mon, 6 Nov 2023 11:59:00 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Zhang Xiaoxu <zhangxiaoxu@huaweicloud.com>
Cc:     zhangxiaoxu5@huawei.com, weiyongjun1@huawei.com,
        rostedt@goodmis.org, mingo@redhat.com, frowand.list@gmail.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 -next 1/5] spi: mockup: Add SPI controller testing
 driver
Message-ID: <ZUjVBKuviXwM0aiR@finisterre.sirena.org.uk>
References: <20231104064650.972687-1-zhangxiaoxu@huaweicloud.com>
 <20231104064650.972687-2-zhangxiaoxu@huaweicloud.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uGI4JZ0hFxEj7pPT"
Content-Disposition: inline
In-Reply-To: <20231104064650.972687-2-zhangxiaoxu@huaweicloud.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uGI4JZ0hFxEj7pPT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 04, 2023 at 02:46:46PM +0800, Zhang Xiaoxu wrote:

> This is accomplished by executing the following command:
>=20
> $ echo adcxx1s 0 > /sys/class/spi_master/spi0/new_device

That's not a valid sysfs format, sysfs requires one value per file.
configfs might be a better fit?

> +config SPI_MOCKUP
> +	tristate "SPI controller Testing Driver"
> +	depends on OF

Why would this depend on DT?  Given that any test SPI controller is a
virtual device it should never appear in DT and we probably shouldn't
require providing DT for the created devices even if we implement
support for that, only some devices might care.
`
> +++ b/drivers/spi/spi-mockup.c
> @@ -0,0 +1,211 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * SPI controller Testing Driver
> + *
> + * Copyright(c) 2022 Huawei Technologies Co., Ltd.
> + */

Please keep the entire comment a C++ one so things look more
intentional.

> +#define MOCKUP_CHIPSELECT_MAX		8

Why would we have a hard coded limit here?

> +	blank =3D strchr(buf, ' ');
> +	if (!blank) {
> +		dev_err(dev, "%s: Extra parameters\n", "new_device");
> +		return -EINVAL;
> +	}

There is no point in using %s to render a constant string.

> +static const struct of_device_id spi_mockup_match[] =3D {
> +	{ .compatible =3D "spi-mockup", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, spi_mockup_match);

If we were going to instantiate this via DT we'd need a binding, but as
I indicated above since this is purely virtual and not even something
like virtual hardware provided by a VMM but rather just something kernel
internal we should probably not be using DT at all.  Providing a device
facing DT interface might be useful, but that's a second stage thing.

--uGI4JZ0hFxEj7pPT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVI1QEACgkQJNaLcl1U
h9BcjQf+OFqcQORTZmVFQ4Z8rKLWLd8BPf4N5fLNu8+OH3m2IcHHZPMwwSRjzz6b
93S13ZQYssTnOVk8cuCDsPVUVkHpjEElm/uTCkw8GLfaRX/dabrjA7ztGS06/0Ez
QsNHNDJ9LIL+qxnZrPmj8Wbp5j8hRIfnHF2uzWHII71kpn8wMguyvqSZ6x1PtbXG
g6gJGCT3XYDsilQ9wyJphSo3hlPwpjzrexa5nswYzu2T27O6QjDiBp1qc/FqhNbV
Lg0EjOYJvcjJGZ/GodvKmNnTiT84kvfUAo/xU34s1LLsTKboQ/IAAFYaAyYRz6Wu
ntj8Xbwan2uotuQFjUkrEny59cP0wA==
=I7Zx
-----END PGP SIGNATURE-----

--uGI4JZ0hFxEj7pPT--
