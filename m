Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214197AC92E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjIXN2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjIXN1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:27:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00D6268E;
        Sun, 24 Sep 2023 06:25:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB4EC433C8;
        Sun, 24 Sep 2023 13:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561900;
        bh=5oLEcVgRjoGSpAnaNFw1+VDHe/sxtslMn25RKGtltMM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MzUbWQyjTR4xg/K6i4W+SNlFTwFj0UsKo0GXqSdAU3ggUpgl0MrRs4qtbvJyg/yEk
         t6+s2R435pWFCg5W2JZj/IwmIUQJrRBa5OSTYz6D9+R5EHHHhQWxziSSoke4Qzzxxn
         xOqiPs7WqGQOm4dK5+jUKBxqmJeV3CkKfejL7a+NtvGtQ6W3VO2FSsLOkvqpgUJ+Hg
         4tWvEK68omL0NrxOiNaWYIJqL32d26x2azTWKrj/yRQEPiFTwja6Iay9dFlp4U9/0b
         FX9Rc3oj6+GRGch1m7YqAgsynOiLd8MiWV81jmTd1jWslMHRGYcdWfBIKUVp1aGUXy
         PUGQKhuabDHIQ==
Date:   Sun, 24 Sep 2023 14:24:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     <marius.cristea@microchip.com>
Cc:     <lars@metafoo.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] iio: adc: MCP3564: fix the static checker warning
Message-ID: <20230924142452.6b421893@jic23-huawei>
In-Reply-To: <20230918075633.1884-1-marius.cristea@microchip.com>
References: <20230918075633.1884-1-marius.cristea@microchip.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sep 2023 10:56:33 +0300
<marius.cristea@microchip.com> wrote:

> From: Marius Cristea <marius.cristea@microchip.com>
>=20
> The patch 33ec3e5fc1ea: "iio: adc: adding support for MCP3564 ADC"
> from Aug 29, 2023 (linux-next), leads to the following Smatch static
> checker warning:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drivers/iio/adc/mcp3564.c:1426=
 mcp3564_probe()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 warn: address of NULL pointer =
'indio_dev'
>=20
> drivers/iio/adc/mcp3564.c
>     1421         struct iio_dev *indio_dev;
>     1422         struct mcp3564_state *adc;
>     1423
>     1424         indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*a=
dc));
>     1425         if (!indio_dev) {
> --> 1426                 dev_err_probe(&indio_dev->dev, PTR_ERR(indio_dev=
), =20
>                                        ^^^^^^^^^^^^^^^
>=20
> Fixes: 33ec3e5fc1ea (iio: adc: adding support for MCP3564 ADC)
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
Applied to the togreg branch of iio.git as that's where this driver is at t=
he moment.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/mcp3564.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
> index 64145f4ae55c..9ede1a5d5d7b 100644
> --- a/drivers/iio/adc/mcp3564.c
> +++ b/drivers/iio/adc/mcp3564.c
> @@ -1422,11 +1422,8 @@ static int mcp3564_probe(struct spi_device *spi)
>  	struct mcp3564_state *adc;
> =20
>  	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*adc));
> -	if (!indio_dev) {
> -		dev_err_probe(&indio_dev->dev, PTR_ERR(indio_dev),
> -			      "Can't allocate iio device\n");
> +	if (!indio_dev)
>  		return -ENOMEM;
> -	}
> =20
>  	adc =3D iio_priv(indio_dev);
>  	adc->spi =3D spi;
>=20
> base-commit: 22da192f43f7d302d02644efa192ba5a05d935c9

