Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0717A61F0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjISMBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjISMBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:01:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCD9E3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:01:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9699C433C8;
        Tue, 19 Sep 2023 12:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695124863;
        bh=OpELln9bev7YvFyQlfCT6PlWHWOFke53iFI6V2uit4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NILdUKDq95qBwAzFcvCQo/LlDkLX7WP8wjcRk5Vjp2ZunhQz5YD8xtbAWekSFOXpF
         oxvo8q4MNu6jEOYdFyaKNJIEIlFYuyQgGcZVtlqPm0GOO/DpxSo7ybjQ4tiLBaF1un
         RZmaVWq1oVx66YZyHsQWPHJprLaRRBWVvFKrzm8q/8IRF3X6dHtKjcitQYnNbytTjR
         z91ws9fOrl6UDtJiISUVjTHipAgdb5mhbAHo5IlMtCGlNYp9uUb9NVb+rSvXQAyLX5
         aUx8wfE46uvzIpeggRvNOE2tdnxFJ0SWE0s6xd/DVY7/5n8ToeKLf9XicUtBUsAgQd
         gPdb3hNdEGhFQ==
Date:   Tue, 19 Sep 2023 13:00:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     cy_huang@richtek.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Allen Lin <allen_lin@richtek.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ASoC: codecs: Add Richtek rtq9128audio amplifier
 support
Message-ID: <87fbcb86-66a2-48e7-91e1-a4d9a6a46114@sirena.org.uk>
References: <1695086301-10376-1-git-send-email-cy_huang@richtek.com>
 <1695086301-10376-3-git-send-email-cy_huang@richtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7Npoeoz3JwMGZ6EV"
Content-Disposition: inline
In-Reply-To: <1695086301-10376-3-git-send-email-cy_huang@richtek.com>
X-Cookie: You buttered your bread, now lie in it.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7Npoeoz3JwMGZ6EV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2023 at 09:18:21AM +0800, cy_huang@richtek.com wrote:

> From: ChiYuan Huang <cy_huang@richtek.com>
>=20
> Add Richtek rtq9128 automotive audio amplifier.

Looks mostly good, a few minor points below:

> --- /dev/null
> +++ b/sound/soc/codecs/rtq9128.c
> @@ -0,0 +1,742 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023 Richtek Technology Corp.

Please make the entire block a C++ comment so things look more
intentional.

> +static const struct regmap_config rtq9128_regmap_config =3D {
> +	.name =3D "rtq9128",
> +	.reg_bits =3D 8,
> +	.val_bits =3D 32,
> +	.val_format_endian =3D REGMAP_ENDIAN_BIG,
> +	.cache_type =3D REGCACHE_RBTREE,

_MAPLE is a better choice for most devices these days.

> +	SOC_ENUM("CH1 SI Select", rtq9128_select_enum[0]),
> +	SOC_ENUM("CH2 SI Select", rtq9128_select_enum[1]),
> +	SOC_ENUM("CH3 SI Select", rtq9128_select_enum[2]),
> +	SOC_ENUM("CH4 SI Select", rtq9128_select_enum[3]),
> +	SOC_ENUM("PWM FREQ Select", rtq9128_select_enum[4]),
> +	SOC_ENUM("OUT2 Phase Select", rtq9128_select_enum[5]),
> +	SOC_ENUM("OUT3 Phase Select", rtq9128_select_enum[6]),
> +	SOC_ENUM("OUT4 Phase Select", rtq9128_select_enum[7]),

Don't use an array of enums with magic numbers like this, it's hard to
read and maintain.  Use individually named variables instead.

> +	/* Turn channel state to Normal or HiZ */
> +	ret =3D snd_soc_component_write_field(comp, RTQ9128_REG_STATE_CTRL, mas=
k,
> +					    event =3D=3D SND_SOC_DAPM_POST_PMU ? 0 : 1);

The ternery operator could just be !=3D here.

--7Npoeoz3JwMGZ6EV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUJjXgACgkQJNaLcl1U
h9Cuugf/eZq0WTD3pnVLm57qMfUiKuc1Ub+ozSYQ1knH23sEnHvjGq663aFhXJVn
DzCojWZ6j9pmMWgT5wTwes5NQD9BoAki95SNcspfNDdFBkPJSCJhxeqkUZyqktio
BrybUk6DnIiMj+NOeMG4tsOw95H2ZKPgoAaRqJ4mNIgR2T6t1uXjw02AObwbBGue
S8pZFoQbVRB3wiM9GAnVE+9gynNc5tyQLaEIuziVmSnS8roIoKdDnoc8G9pAcEfS
sstV2wn2x9pndsxnLPnqeVwShzn2EZyIlSTsKJ4irxZtk1gkPi1iFE/Zu+lR6cAM
V5Axm6nOKlmfOsQ8Bnguf4BanYsP+A==
=C2S8
-----END PGP SIGNATURE-----

--7Npoeoz3JwMGZ6EV--
