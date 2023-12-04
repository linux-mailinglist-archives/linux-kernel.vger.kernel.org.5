Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787F780389C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbjLDPVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbjLDPVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:21:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5BACA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 07:21:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403E4C433C8;
        Mon,  4 Dec 2023 15:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701703288;
        bh=73pAaB3mi7c07UkmN0pF09RndH2hCE1ns/C5OrUjhHE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lDy1RVFrrYKs9mpINAj6ruU5nicvceF9qfesxbreDv5Ot6A8bB6AK6xSR5dYq2e4V
         ryMyekOp1QWlMK+tgSDcGtOzFjHky1bvbW1VptgSzUvhGji5mWOxi1S8YAPoNnFaGr
         21Xv8Qp1rjs/XzgGDfw9BlE5GxAOwjogqRyZ+wHya6eF6X5M84pkRmQoSyfX1i65nP
         7QwKx89Vty9oTA4m9+pi/UBmUQ6dOWgASAwVaxLPpBPBZJ3th+8vTY5q3B3oPkU+yk
         KzBx5WKDx2m1dy5FfO8xIlqkP1XW+XM5uMQDKTkg6hA8RNADLExl7fnrqwTPxXFCri
         boSYoVFptp4cA==
Date:   Mon, 4 Dec 2023 15:21:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 06/12] iio: adc: ad9467: add mutex to struct
 ad9467_state
Message-ID: <20231204152120.71455f40@jic23-huawei>
In-Reply-To: <2343dacb0ec0a4878c8e41748ed6e586ff53ccd4.camel@gmail.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
        <20231121-dev-iio-backend-v1-6-6a3d542eba35@analog.com>
        <CAMknhBHsFS5p-_250WRmkH2za+QPV6WyKNfgD-E1W8=HV3W3fg@mail.gmail.com>
        <2343dacb0ec0a4878c8e41748ed6e586ff53ccd4.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Dec 2023 09:49:38 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2023-11-30 at 15:50 -0600, David Lechner wrote:
> > On Tue, Nov 21, 2023 at 4:17=E2=80=AFAM Nuno Sa via B4 Relay
> > <devnull+nuno.sa.analog.com@kernel.org> wrote: =20
> > >=20
> > > From: Nuno Sa <nuno.sa@analog.com>
> > >=20
> > > When calling ad9467_set_scale(), multiple calls to ad9467_spi_write()
> > > are done which means we need to properly protect the whole operation =
so
> > > we are sure we will be in a sane state if two concurrent calls occur.
> > >=20
> > > Fixes: ad6797120238 ("iio: adc: ad9467: add support AD9467 ADC")
> > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > ---
> > > =C2=A0drivers/iio/adc/ad9467.c | 6 +++++-
> > > =C2=A01 file changed, 5 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> > > index 04474dbfa631..91821dee03b7 100644
> > > --- a/drivers/iio/adc/ad9467.c
> > > +++ b/drivers/iio/adc/ad9467.c
> > > @@ -4,7 +4,7 @@
> > > =C2=A0 *
> > > =C2=A0 * Copyright 2012-2020 Analog Devices Inc.
> > > =C2=A0 */
> > > -
> > > +#include <linux/cleanup.h>
> > > =C2=A0#include <linux/module.h>
> > > =C2=A0#include <linux/mutex.h> =20
> >=20
> > Ah, the case of the misplaced header from the previous patch is solved.=
 :-)
> >  =20
>=20
> Yeps, it needs to be in this patch :)
>=20
> > > =C2=A0#include <linux/device.h>
> > > @@ -122,6 +122,8 @@ struct ad9467_state {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 output_mode;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct gpio_desc=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 *pwrdown_gpio;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* protect against concurrent a=
ccesses to the device */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mutex=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 lock;
> > > =C2=A0};
> > >=20
> > > =C2=A0static int ad9467_spi_read(struct spi_device *spi, unsigned int=
 reg)
> > > @@ -162,6 +164,7 @@ static int ad9467_reg_access(struct adi_axi_adc_c=
onv *conv,
> > > unsigned int reg,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!readval) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 guard(mutex)(&st->lock);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D ad9467_spi_write(spi, reg, writeval);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n ret;
> > > @@ -310,6 +313,7 @@ static int ad9467_set_scale(struct adi_axi_adc_co=
nv *conv,
> > > int val, int val2)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (scale_val[0] !=3D val || scale_val[1] !=3D val2)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conti=
nue;
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 guard(mutex)(&st->lock);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D ad9467_spi_write(st->spi, AN877_ADC_REG_VREF,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 info->scale_table[i][1]);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
> > >=20
> > > --
> > > 2.42.1
> > >=20
> > >  =20
> >=20
> > Alternately, this could probably be solved with spi_bus_lock/unlock
> > and spi_sync_locked rather than introducing a new mutex. =20
>=20
> Hmm, typically you just have your own lock. No reason to lock the spi bus=
. And I also
> have some plans to eventually change this to regmap :)

Bus lock typically implies that we can't let other users grab the bus in be=
tween
for reasons like the chip select needing to be held. I'm not keen on it bei=
ng
used if the locking is just needed for a specific driver to deal with its
associated device and driver state.

Jonathan

>=20
> - Nuno S=C3=A1
>=20

