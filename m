Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D477B416A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 17:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbjI3PAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 11:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbjI3PAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 11:00:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41FFBD;
        Sat, 30 Sep 2023 08:00:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33D1C433C7;
        Sat, 30 Sep 2023 15:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696086048;
        bh=FXz2SREKtf+iI847/DSKV9eCwFUODi1WlM1uajRmxKA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LhtZ3ey+X77bzCBum1Fj6V+3iNyWT6Ts3CN5CvF6Zemop5a6Hmm+giHf9o+0+c932
         qerH2pgVeSyyV0CcVKXPGoDFUKSyhLqir7lCF+wXdGbUq//5AZqkOZpat/ZYkOsiEL
         9uxXJk9gOgRZlcwe9vcy3qI0H0rbnwCKKulZCg0leRQaK4VU73XtY9Yzeqs3pJ9B0Q
         mL+L7Q9JL8gICvUD5nVg1r8oxiTio7G569MwmeTvkJOGXnvzM0FhkRHGY5Xtg4f8N9
         zr0XPcRfYD0aD+nJw/fa8zw78mhFP2fIS8HsQEnL8i0jd3VWLcA+ZaVA089uqEPjuB
         djXsKfOYZD3Ig==
Date:   Sat, 30 Sep 2023 16:00:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev,
        David Lechner <david@lechnology.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 14/27] staging: iio: resolver: ad2s1210: implement
 hysteresis as channel attr
Message-ID: <20230930160047.0c5a5388@jic23-huawei>
In-Reply-To: <CAMknhBGFBwQQouhsPMgCuMn6+eQfDCcSzJvF-DwJAnoEPvMLAA@mail.gmail.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
        <20230929-ad2s1210-mainline-v3-14-fa4364281745@baylibre.com>
        <CAMknhBGFBwQQouhsPMgCuMn6+eQfDCcSzJvF-DwJAnoEPvMLAA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2023 12:53:00 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On Fri, Sep 29, 2023 at 12:25=E2=80=AFPM David Lechner <dlechner@baylibre=
.com> wrote:
> >
> > The AD2S1210 resolver has a hysteresis feature that can be used to
> > prevent flicker in the LSB of the position register. This can be either
> > enabled or disabled. Disabling hysteresis is useful for increasing
> > precision by oversampling.
> >
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > --- =20
>=20
> ...
>=20
> > +static int ad2s1210_read_avail(struct iio_dev *indio_dev,
> > +                              struct iio_chan_spec const *chan,
> > +                              const int **vals, int *type,
> > +                              int *length, long mask)
> > +{
> > +       static const int hysteresis_available[] =3D { 0, 1 }; =20
>=20
> This is basically an enable/disable. Should the 1 value be changed to the
> appropriate radians value since this is hysteresis on the position
> (angle) channel?

Good point. However it should be in the _raw units. The text is
slightly more explicit on this for
the variant of hysteresis applied to threshold events as it's
added or substracted from a threshold (and thresholds are in
_raw readings unless only _processed is available).

Does that make 0, 1 correct as we are talking about LSB only?

Jonathan


>=20
> > +
> > +       switch (mask) {
> > +       case IIO_CHAN_INFO_HYSTERESIS:
> > +               switch (chan->type) {
> > +               case IIO_ANGL:
> > +                       *vals =3D hysteresis_available;
> > +                       *type =3D IIO_VAL_INT;
> > +                       *length =3D ARRAY_SIZE(hysteresis_available);
> > +                       return IIO_AVAIL_LIST;
> > +               default:
> > +                       return -EINVAL;
> > +               }
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +}
> > =20

