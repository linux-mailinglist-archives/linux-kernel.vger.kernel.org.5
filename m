Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E4F75E1E2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 14:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjGWMcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 08:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjGWMcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 08:32:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CCB93;
        Sun, 23 Jul 2023 05:32:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CE3460CA5;
        Sun, 23 Jul 2023 12:32:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7785AC433C7;
        Sun, 23 Jul 2023 12:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690115531;
        bh=qVsp3/Cz0wmxWPsmjNfRwEk+Xza1gHiyT53xB+lRebY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mOHScHD5BqafqjFMApCigARuv03y7eSxS3VK+1b+FoHQ8GAQbQIyuGqyfBFIW/bSv
         FgVgk6ppZqml/GKpJALvnW/urdT6I+LXYE8iO7veeCJqFcqAi0J+05nbmO5a+DX6St
         50Kn9YlCUkujYEW8rV5fkHPTbpYdkVax2hPMi8QCT7QsjDcY/9BvokXd16cunBQZ0J
         xnQPttr/FNN1OsYEmaRiVmCd4LhYwZLX/z4MY/Md4ENiyJJQYGX/sE9+1W7Bujgsan
         z3yo4rrwhpJqxE+rE3z94Cf0pjLSvLOQO8b2D06f/T5IB87b+PAvrco2/l/U1kSDwE
         UsJlfF/cgr92w==
Date:   Sun, 23 Jul 2023 13:32:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Ramona Bolboaca <ramona.bolboaca@analog.com>, nuno.sa@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: imu: adis16475.c: Add delta angle and delta
 velocity channels
Message-ID: <20230723133207.2db71f0f@jic23-huawei>
In-Reply-To: <25680568c9477e8db5cf533ff2a9f117ed8de440.camel@gmail.com>
References: <20230719123152.309624-1-ramona.bolboaca@analog.com>
        <20230719123152.309624-4-ramona.bolboaca@analog.com>
        <25680568c9477e8db5cf533ff2a9f117ed8de440.camel@gmail.com>
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

On Thu, 20 Jul 2023 10:58:51 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, 2023-07-19 at 15:31 +0300, Ramona Bolboaca wrote:
> > Add support for delta angle and delta velocity raw and buffer
> > readings to adis16475 driver.
> >=20
> > Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>
> > ---
Some follow up comments..

> > +
> > +#define ADIS16475_DELTANG_CHAN(_mod) \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_MOD_CHAN_DELTA(IIO=
_ROT, IIO_MOD_ ## _mod, \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ADIS16475_REG_ ## _mod ## _DELTANG_L,
> > ADIS16475_SCAN_DELTANG_ ## _mod, 32, 32)
> > +
> > +#define ADIS16475_DELTVEL_CHAN(_mod) \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_MOD_CHAN_DELTA(IIO=
_VELOCITY, IIO_MOD_ ## _mod, \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ADIS16475_REG_ ## _mod ## _DELTVEL_L,
> > ADIS16475_SCAN_DELTVEL_ ## _mod, 32, 32)
> > +
> > +#define ADIS16475_DELTANG_CHAN_NO_SCAN(_mod) \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_MOD_CHAN_DELTA(IIO=
_ROT, IIO_MOD_ ## _mod, \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ADIS16475_REG_ ## _mod ## _DELTANG_L, -1, 32, 32)
> > +
> > +#define ADIS16475_DELTVEL_CHAN_NO_SCAN(_mod) \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_MOD_CHAN_DELTA(IIO=
_VELOCITY, IIO_MOD_ ## _mod, \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ADIS16475_REG_ ## _mod ## _DELTVEL_L, -1, 32, 32)

I don't think we've come to a conclusion on whether IIO_ROT and IIO_VELOCITY
are valid descriptions of these channels..

> > +
> > =C2=A0static const struct iio_chan_spec adis16475_channels[] =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_GYRO_CHANNEL(=
X),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_GYRO_CHANNEL(=
Y),
> > @@ -559,7 +619,30 @@ static const struct iio_chan_spec adis16475_channe=
ls[] =3D
> > {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_ACCEL_CHANNEL=
(Y),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_ACCEL_CHANNEL=
(Z),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_TEMP_CHANNEL(=
),
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0IIO_CHAN_SOFT_TIMESTAMP(7)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0IIO_CHAN_SOFT_TIMESTAMP(7),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_DELTANG_CHAN_NO_SC=
AN(X),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_DELTANG_CHAN_NO_SC=
AN(Y),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_DELTANG_CHAN_NO_SC=
AN(Z),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_DELTVEL_CHAN_NO_SC=
AN(X),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_DELTVEL_CHAN_NO_SC=
AN(Y),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_DELTVEL_CHAN_NO_SC=
AN(Z)
> > +};
> > +
> > +static const struct iio_chan_spec adis16500_channels[] =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_GYRO_CHANNEL(X),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_GYRO_CHANNEL(Y),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_GYRO_CHANNEL(Z),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_ACCEL_CHANNEL(X),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_ACCEL_CHANNEL(Y),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_ACCEL_CHANNEL(Z),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_TEMP_CHANNEL(),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_DELTANG_CHAN(X),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_DELTANG_CHAN(Y),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_DELTANG_CHAN(Z),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_DELTVEL_CHAN(X),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_DELTVEL_CHAN(Y),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_DELTVEL_CHAN(Z),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0IIO_CHAN_SOFT_TIMESTAMP(13)
> > =C2=A0}; =20
>=20
> Hmm, IIRC I suggested this to you so apologizes. But I'm not sure we shou=
ld do
> this. In theory, I think we provide all the interfaces so an userspace ap=
p would
> still work by changing the timestamp index but who knows what apps might =
be
> assuming... So maybe, it's just safer to keep timestamp at index 7.

That stops you using iio_push_to_buffers_with_timestamp()

This is in the category of cross our fingers no one notices the ABI change.
So I'd go ahead with moving the timestamp channel and hope no one has hand =
rolled
code that assume the channel won't change index.

>=20
> I guess it will also make the available scan_masks neater.
>=20

...


> > @@ -972,10 +1095,40 @@ static const struct adis16475_chip_info
> > adis16475_chip_info[] =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> > =C2=A0};
> > =C2=A0
> > +static const unsigned long adis16475_avail_scan_masks[] =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16500_BURST_DATA_SEL_0_C=
HN_MASK,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16500_BURST_DATA_SEL_1_C=
HN_MASK,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > +};
> > + =20
>=20
> Hmm I guess this ok if we don't have strict scan_mask match. AFAICT, that=
's only
> the case for HARDWARE buffering and not likely to change... right? Jonath=
an?

Should be.  The core will deal with demuxing the data otherwise.

>=20
> > +static int adis16475_update_scan_mode(struct iio_dev *indio_dev,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
nst unsigned long *scan_mask)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u16 en;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct adis16475 *st =3D iio=
_priv(indio_dev);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (st->info->has_burst32) {=
 =20
>=20
> Hmm, I get that buffering these channels are only available in devices th=
at have
> burst32. But I would not assume that as there's no guarantee that will al=
ways be
> the case. Given that's straight to just have another flag for the presenc=
e of
> these channels in the burst data, I would prefer to have one right now.

Agreed.

>=20
> As a nit I would flip the logic in here:
>=20
> if (!st->info->has_burst32)
>     return adis_update_scan_mode(indio_dev, scan_mask);
>=20
> Then you could keep indentation and even save some lines of code. Anyways=
, just
> my personal preference.
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (*scan_mask & ADIS16500_BURST_DATA_SEL_0_CHN_MASK)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0en =3D=
 ADIS16500_BURST_DATA_SEL(0);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0else if (*scan_mask & ADIS16500_BURST_DATA_SEL_1_CHN_M=
ASK)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0en =3D=
 ADIS16500_BURST_DATA_SEL(1);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=
 -EINVAL;
> > + =20
>=20
> I don't think the above is ever possible since you're guaranteed that a s=
ubset
> of the available_scan_masks is set.=C2=A0So, if() .. else should be enoug=
h.

I'm not 100% sure you can't just have a software timestamp even with availa=
ble_scan_masks.
Definitely worth checking if you are going to drop the else.

>=20
> Moreover will this actually work with BIT(13) or BIT(6) set? Won't we alw=
ays
> fall in the first case if one of those bits are set even if we want
> ADIS16500_BURST_DATA_SEL(1)? So I guess you should explicitly check again=
st
> GENMASK(5, 0) for normal accel/gyro or GENMASK(13, 8) for delta stuff. Ri=
ght?
>=20
> - Nuno S=C3=A1
>=20

