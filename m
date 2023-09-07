Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897477978F8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbjIGQ7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbjIGQhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:37:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8C56E8E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:22:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B9DC3278F;
        Thu,  7 Sep 2023 14:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694096471;
        bh=SpgVoXpZ8tTPJGkfU3ecVLROLILLP+Tw7lqoCXII6pc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pzVfDghyPadfvHEaQazjewvNksmHCOeqpcQtRd8NfmTvtgJaEIil6dYLiDDwRBmt8
         I4PAp7Qp9QVzzCF4dJZWLMReBnQbv4uLDnicicGHV1dVh2l7Z+y/L2Yun5UcE3XRqp
         DnINdfmlALickPzVNDSarwzlwJdc0rh4WKt2cQIq64nPNYjKFe76qtZkUdIDQ6voBV
         oC3MX+cdASaWGkV4h+fRDK9CQBJNeWWVFAWDtKHtGloudKltLKBOJKFINtc3mBFq+3
         I/jIwllcIfRLPGanbBTts8/MLJVF4kIVzNiEpJNGosbNRZyAcWOI7GiY3qAySKst1O
         VdkWDT8YlMXew==
Date:   Thu, 7 Sep 2023 15:21:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Joerg Schambacher <joerg.hifiberry@gmail.com>
Cc:     a-krasser@ti.com, joerg@hifiberry.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: Adds support for TAS575x to the pcm512x driver
Message-ID: <a9c3d43a-af26-44a0-9352-4666107f9f56@sirena.org.uk>
References: <20230907161207.14426-1-joerg.hifiberry@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pHp2IBdZnGQB80wz"
Content-Disposition: inline
In-Reply-To: <20230907161207.14426-1-joerg.hifiberry@gmail.com>
X-Cookie: In the next world, you're on your own.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pHp2IBdZnGQB80wz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 07, 2023 at 06:12:05PM +0200, Joerg Schambacher wrote:

> +		if (pcm512x->tas_device) {
> +			/* set necessary PLL coeffs for amp
> +			 * according to spec only 2x and 4x MCLKs
> +			 * possible
> +			 */
> +			ret = regmap_write(pcm512x->regmap,
> +					   PCM512x_PLL_COEFF_0, 0x01);
> +			if (mck_rate > 25000000UL)
> +				ret = regmap_write(pcm512x->regmap,
> +						   PCM512x_PLL_COEFF_1, 0x02);
> +			else
> +				ret = regmap_write(pcm512x->regmap,
> +						   PCM512x_PLL_COEFF_1, 0x04);

I would name this quirk something a bit more specific - it seems likely
that there might be future TASxxxx devices which need different quirks.
If it's a limited range of MCLK multipliers perhaps something about how
the PLL is limited, or just make the quirk data being to specify min/max
for the multiplier?

> +		if (!pcm512x->tas_device) {
> +			ret = regmap_update_bits(pcm512x->regmap,
> +						 PCM512x_PLL_EN, PCM512x_PLLE, 0);
> +		} else {
> +			/* leave PLL enabled for amp clocking */
> +			ret = regmap_write(pcm512x->regmap,
> +					   PCM512x_PLL_EN, 0x01);
> +			dev_dbg(component->dev, "Enabling PLL for TAS575x\n");
> +		}

This is probably a separate quirk?  I'm a bit concerned about what's
turning the PLL off here...

--pHp2IBdZnGQB80wz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmT53E8ACgkQJNaLcl1U
h9DIkAf8DvIkbJTLPPb9WOeICPPEg31V9fX1Gbjibv6WKE3XAX0kQvEVID4XikuC
DMutxl/up7Xepw12fXsRnM6ZM1x24dcJoZHfJTLruL48di2xmfOdPskk70WIpXL+
fF9+GzaQ/7pH0VLSOQ7SK/28BNU7lAhVBhqngemmMKLGf7HJpldwoFdaHs4PYOy+
adM6gpYlOJc4bxd0WJ5ua2KUEHWYhaz7T13GLlxchG7WR1UOjHA39uoL3K0NkRuX
unIygkvTh01GYmpEsW3FEfZiRvLhGlxkW15DbrkALX1Tty5Q1hs4eSsGkiwhzTBk
nR0dMZ1hISOepsmVPvS2cq8hnjHYKQ==
=N6pg
-----END PGP SIGNATURE-----

--pHp2IBdZnGQB80wz--
