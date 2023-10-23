Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8540D7D3A8A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjJWPSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjJWPSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:18:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5F893
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:18:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197B9C433C7;
        Mon, 23 Oct 2023 15:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698074300;
        bh=4gDTkvnnBRqSf/jHzY8R1MU1NWwhjhsP2zUpHSJaHOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T13CgJVib3X5lxOC0U+nLeucszLx/a+oOCHdlcHjmI7tqxqj7Ny/iIGlg3FWmjdZ1
         pXgmq3swG48QcCE7laMRAcM7JrDyA7t5j1O1Xf9hzPHAKKi14xQE7Ul035YR0EcE9c
         k09ozI4rf4rhwBh0sumOLuLYZXUK20pegEObZNvdqqMp5hOkFU4/cg1gBkjVB0iVea
         2Q2C5twa5+eThp/8b09Ggm72Y61oySWQ1melUZ2LdKkY/SQRHbNankESb8FpdqV1Y2
         GBdIY1HhueeL/qEWkpiEn7Uz2kj8+cwyNusZ0XzrF2AcG0V3WDVIA2V5xXK18m9AGr
         1LiZ1M3sFc2oA==
Date:   Mon, 23 Oct 2023 16:18:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: qcom: q6apm-lpass-dais: pass max number of
 channels to Audioreach
Message-ID: <673374d2-e8fb-496d-b89d-092df2f1fbc0@sirena.org.uk>
References: <20231017161429.431663-1-krzysztof.kozlowski@linaro.org>
 <2c2941f5-9909-433a-a35e-fbe7611c0ef4@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="364xxEhdSOi/QbR0"
Content-Disposition: inline
In-Reply-To: <2c2941f5-9909-433a-a35e-fbe7611c0ef4@linaro.org>
X-Cookie: Never reveal your best argument.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--364xxEhdSOi/QbR0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 10:14:03AM +0200, Krzysztof Kozlowski wrote:
> On 17/10/2023 18:14, Krzysztof Kozlowski wrote:

> > Using the params_channels() helper when setting hw_params, results in
> > passing to Audioreach minimum number of channels valid for given
> > hardware.  This is not valid for any hardware which sets minimum
> > channels to two and maximum to something bigger, like four channels.
> >=20
> > Instead pass the maximum number of supported channels to allow playback
> > of multi-channel formats.

> I am not sure if this is correct fix. I think sound machine drivers
> should just not override channels like:

You *can* get cases where machine specific wiring or clocking limits
mean that even if both ends of a link are capable of some number of
channels the actual limit is lower.

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/s=
ound/soc/qcom/sm8250.c?h=3Dv6.6-rc6#n44

That's:

| static int sm8250_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
|				     struct snd_pcm_hw_params *params)

=2E..

|	rate->min =3D rate->max =3D 48000;
|	channels->min =3D channels->max =3D 2;

which is DPCM which is it's own special thing - in this case it's saying
that whatever the front end takes in the thing that comes out of the SoC
will have been reformatted to 48kHz stereo (so mono will be turned into
stereo for example) which is a perfectly reasonable thing for a DSP to
do.  See previous discussions of how we should handle this better, DPCM
isn't ideal.

--364xxEhdSOi/QbR0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmU2jrUACgkQJNaLcl1U
h9BlZwf8Daf0x7Ql27BkYOX9pul+TZ7dzsf40sT7NfeZ75WmyRmYVOamtN5MUknr
8I9wOrmwwU/zP6hWoL8DQU6kJyv6jeCnuGOseoIeQHg0o4NUcaXvSvPZn0fTHXOn
JPz+pwnyLGtLQxpcdMOwDEAuihQqXU5+861Cdtp9wBi9IyN3BlfxwpsnJOIwwErp
KK3MFn8124hBmLwFbgI+CaNBZ28RrgGdEGr3q7tnD0S0uSDfeXn9+eCnoWyiVXLg
T8JDDpNoThG45jz7urTBBaumwDLZUiCPATR+KFgPI1URX34pu/drGMVNzIXvjcSU
m1Zn72LpU7RsxuAVlNvMtZjTBUj9Bw==
=2lGy
-----END PGP SIGNATURE-----

--364xxEhdSOi/QbR0--
