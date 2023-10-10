Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C0B7C02F3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 19:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbjJJRqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 13:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjJJRq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 13:46:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDE994;
        Tue, 10 Oct 2023 10:46:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9F7C433C7;
        Tue, 10 Oct 2023 17:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696959987;
        bh=Ok6QdFgXV8VwzIGuDuVeFecYl4GVKq4SWQnM2gTS24w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s/dpDe3NS6m7E/RlkMu2u7NUrMEIQF8Zl7vGcnbmGaBYAlsdTk0qUP4tMlYjqvKPU
         WROic7BOBvcfI2pPwmUw53B/60UtgM1MjCMjEv53aPnZgOf+ZKu0BB1DhvYGGOD5Sy
         s524FHWR3/eUfDU1mOJxChFL753kxz4hGZ34F08UlxtfIM52q0/jC+zMPE3fzdjS8w
         PzYe4njH3cqoHciBdrJbALkuf8WT1Yh2ns3gj7TruDKDj7zIJuksytYKmVTeUYtt9R
         GU7115au4bNH5IYdTqjnlkkp6ZFG/ER51lVhzW6tte7B6/NwZCwzlWeOdaqxY5R5b+
         nj7NEkEJD7m5A==
Date:   Tue, 10 Oct 2023 18:46:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 17/17] staging: iio: resolver: ad2s1210: simplify
 code with guard(mutex)
Message-ID: <20231010184637.4a8676af@jic23-huawei>
In-Reply-To: <CAMknhBFP1Or+06rAMNOAU1Dc3sx1QgO44-N5xpsE-54DVOHYSQ@mail.gmail.com>
References: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
        <20231005-ad2s1210-mainline-v4-17-ec00746840fc@baylibre.com>
        <20231010171738.5a23e66e@jic23-huawei>
        <CAMknhBFP1Or+06rAMNOAU1Dc3sx1QgO44-N5xpsE-54DVOHYSQ@mail.gmail.com>
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

On Tue, 10 Oct 2023 12:40:03 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On Tue, Oct 10, 2023 at 11:17=E2=80=AFAM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> >
> > On Thu,  5 Oct 2023 19:50:34 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> > =20
> > > We can simplify the code and get rid of most of the gotos by using
> > > guard(mutex) from cleanup.h. =20
> > You could consider scoped_guard() for a few cases in here, but perhaps
> > it's better to be consistent and always use the guard() version. =20
>=20
> Yes, there it doesn't look like there are any cases where there is any
> long-running operation that could be done after unlocking the mutex,
> so I went with the simpler approach everywhere.
>=20
> >
> > There is a small timing question wrt to the gpio manipulation inline.
> > =20
> > >
> > > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > > ---
> > >
> > > v4 changes: New patch in v4.
> > >
> > >  drivers/staging/iio/resolver/ad2s1210.c | 157 ++++++++++------------=
----------
> > >  1 file changed, 50 insertions(+), 107 deletions(-)
> > >
> > > diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/stagin=
g/iio/resolver/ad2s1210.c
> > > index c4e1bc22e8b0..c4e0ffa92dc2 100644
> > > --- a/drivers/staging/iio/resolver/ad2s1210.c
> > > +++ b/drivers/staging/iio/resolver/ad2s1210.c
> > > @@ -47,6 +47,7 @@
> > >
> > >  #include <linux/bitfield.h>
> > >  #include <linux/bits.h>
> > > +#include <linux/cleanup.h>
> > >  #include <linux/clk.h>
> > >  #include <linux/delay.h>
> > >  #include <linux/device.h>
> > > @@ -404,11 +405,13 @@ static int ad2s1210_single_conversion(struct ii=
o_dev *indio_dev,
> > >       s64 timestamp;
> > >       int ret;
> > >
> > > -     mutex_lock(&st->lock);
> > > +     guard(mutex)(&st->lock);
> > > +
> > >       gpiod_set_value(st->sample_gpio, 1);
> > >       timestamp =3D iio_get_time_ns(indio_dev);
> > >       /* delay (6 * tck + 20) nano seconds */
> > >       udelay(1);
> > > +     gpiod_set_value(st->sample_gpio, 0);
> > >
> > >       switch (chan->type) {
> > >       case IIO_ANGL:
> > > @@ -418,14 +421,13 @@ static int ad2s1210_single_conversion(struct ii=
o_dev *indio_dev,
> > >               ret =3D ad2s1210_set_mode(st, MOD_VEL);
> > >               break;
> > >       default:
> > > -             ret =3D -EINVAL;
> > > -             break;
> > > +             return -EINVAL;
> > >       }
> > >       if (ret < 0)
> > > -             goto error_ret;
> > > +             return ret;
> > >       ret =3D spi_read(st->sdev, &st->sample, 3);
> > >       if (ret < 0)
> > > -             goto error_ret;
> > > +             return ret;
> > >
> > >       switch (chan->type) {
> > >       case IIO_ANGL:
> > > @@ -437,17 +439,11 @@ static int ad2s1210_single_conversion(struct ii=
o_dev *indio_dev,
> > >               ret =3D IIO_VAL_INT;
> > >               break;
> > >       default:
> > > -             ret =3D -EINVAL;
> > > -             break;
> > > +             return -EINVAL;
> > >       }
> > >
> > >       ad2s1210_push_events(indio_dev, st->sample.fault, timestamp);
> > >
> > > -error_ret:
> > > -     gpiod_set_value(st->sample_gpio, 0);
> > > -     /* delay (2 * tck + 20) nano seconds */
> > > -     udelay(1); =20
> >
> > Dropping this delay isn't obviously safe (though it probably is given s=
tuff done before we exit).
> > I assume there are no rules on holding the gpio down for the register r=
ead. =20
>=20
> Correct. The SAMPLE gpio only needs to be held for a short time (~350
> nanoseconds) to latch in the current values, then it doesn't matter
> when it is released. (Figure 35 in datasheet)
>=20
> >
> > If nothing else I think the patch description needs to made an argument=
 for why it is fine. =20
>=20
> The longest possible delay needed after releasing the SAMPLE line
> before reasserting is ~350 nanoseconds. Is there a rule of thumb for
> deciding when there are enough instructions that no processor could
> execute them faster than this vs. when we should add an explicit
> delay?
Almost always use an explicit delay as then we don't have to think about it.

>=20
> I think I will consider adding a patch in the next round to refactor
> the SAMPLE toggle to a separate function so we can be sure it is
> handled the same in all cases.
Sounds good.

Jonathan

>=20
> > =20
> > > -     mutex_unlock(&st->lock);
> > >       return ret;
> > >  }
> > > =20

