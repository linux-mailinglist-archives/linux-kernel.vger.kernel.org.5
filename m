Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A144767ED0
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 13:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjG2LqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 07:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjG2LqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 07:46:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182201A4;
        Sat, 29 Jul 2023 04:46:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A909760BEF;
        Sat, 29 Jul 2023 11:46:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88233C433C7;
        Sat, 29 Jul 2023 11:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690631174;
        bh=qKZ3sWBIHKBs/DAR8rZpwGwmQpbFOts/wY4nbkhYDNk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bcRoEGV+C65Hd2muZXqufHEyTml3/5h5ILi44Gjxqxm1MGltzdhXuORMGachPUfDM
         G02sVvmUlSQcp75iyn3zV/DRqwJw1ctytBtwxXpSBDHT6PYh0GRPvn1XzMEFZcvEDy
         8wONH/KLdgSM3LgZV3QgkwHkG8kA5yw6LPye7uw8mQeQgf7kQNR2aDCpZydEb6Hv+U
         Uft2yZl/lJh+ZlE18E0GNV2Fgt32KrN/rs35YRqvlTAAPb0GvQ7/egvF1Fa8nd5kWB
         AcEAJN5r2RcYrrCCfh/Vr33KdabiGCC6a3NCvo1jNEi7pzsjzV5eiel4UMTrTLY17C
         7TgpcB8wlC1KQ==
Date:   Sat, 29 Jul 2023 12:46:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Kees Cook <keescook@chromium.org>, Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v3 2/4] iio: core: Add opaque_struct_size() helper and
 use it
Message-ID: <20230729124618.67e89fff@jic23-huawei>
In-Reply-To: <20230724110204.46285-3-andriy.shevchenko@linux.intel.com>
References: <20230724110204.46285-1-andriy.shevchenko@linux.intel.com>
        <20230724110204.46285-3-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2023 14:02:02 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Introduce opaque_struct_size() helper, which may be moved
> to overflow.h in the future, and use it in the IIO core.
>=20
> Potential users could be (among possible others):
>=20
> 	__spi_alloc_controller() in drivers/spi/spi.c
> 	alloc_netdev_mqs in net/core/dev.c
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Cc: Kees Cook <keescook@chromium.org>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/industrialio-core.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-c=
ore.c
> index b153adc5bc84..118ca6b59504 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1607,6 +1607,24 @@ const struct device_type iio_device_type =3D {
>  	.release =3D iio_dev_release,
>  };
> =20
> +/**
> + * opaque_struct_size() - Calculate size of opaque structure with traili=
ng aligned data.
> + * @p: Pointer to the opaque structure.
> + * @a: Alignment in bytes before trailing data.
> + * @s: Data size in bytes (preferred not to be 0).
> + *
> + * Calculates size of memory needed for structure of @p followed by
> + * the aligned data of size @s.
> + *
> + * Note, when @s is 0, the alignment @a is added to the sizeof(*(@p))
> + * and the result, depending on the @a, may be way off the initial size.

How often is this true?  A quick and dirty grep suggests at least 2 so perh=
aps
worth retaining the old behaviour.

Can we take that into account?  Maybe something like

#define opaque_struct_size(p, a, s) ((s) ? size_add(ALIGN(sizeof(*(p)), (a)=
), (s)): sizeof(*p))=20

Or do it at the call site below.

> + *
> + * Returns: Number of bytes needed or SIZE_MAX on overflow.
> + */
> +#define opaque_struct_size(p, a, s)	size_add(ALIGN(sizeof(*(p)), (a)), (=
s))
> +
> +#define opaque_struct_data(p, a)	PTR_ALIGN((void *)((p) + 1), (a))
> +
>  /**
>   * iio_device_alloc() - allocate an iio_dev from a driver
>   * @parent:		Parent device.
> @@ -1618,19 +1636,13 @@ struct iio_dev *iio_device_alloc(struct device *p=
arent, int sizeof_priv)
>  	struct iio_dev *indio_dev;
>  	size_t alloc_size;
> =20
> -	alloc_size =3D sizeof(struct iio_dev_opaque);
> -	if (sizeof_priv) {
> -		alloc_size =3D ALIGN(alloc_size, IIO_DMA_MINALIGN);
> -		alloc_size +=3D sizeof_priv;
> -	}
> -
	if (sizeof_priv)
		alloc_size =3D opaque_struct_size(iio_dev_opaque, IIO_DMA_MINALIGN, sizeo=
f_priv);
	else
		alloc_size =3D sizeof(struct iio_dev_opaque);


> +	alloc_size =3D opaque_struct_size(iio_dev_opaque, IIO_DMA_MINALIGN, siz=
eof_priv);
>  	iio_dev_opaque =3D kzalloc(alloc_size, GFP_KERNEL);
>  	if (!iio_dev_opaque)
>  		return NULL;
> =20
>  	indio_dev =3D &iio_dev_opaque->indio_dev;
> -	indio_dev->priv =3D (char *)iio_dev_opaque +
> -		ALIGN(sizeof(struct iio_dev_opaque), IIO_DMA_MINALIGN);
> +	indio_dev->priv =3D opaque_struct_data(iio_dev_opaque, IIO_DMA_MINALIGN=
);

Would have been safer if original code set this to NULL if
sizeof_priv =3D=3D 0

A driver doing that should never have used iio_priv() but nicer if it was N=
ULL rather
than off the end of the allocation.

Jonathan

> =20
>  	indio_dev->dev.parent =3D parent;
>  	indio_dev->dev.type =3D &iio_device_type;

