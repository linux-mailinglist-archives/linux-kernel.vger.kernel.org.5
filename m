Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FDA808FE3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443705AbjLGSVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443741AbjLGSUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:20:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A05D199B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 10:20:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40FAC433C8;
        Thu,  7 Dec 2023 18:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701973254;
        bh=AkGup3hcznxKyD5qZYbWXUKeQrXywPgfm2PxkeN+ljQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UGL1d6BE3R6ufSUslO2HlhwFKBs6wMppMCBwaPeb4FwdrkazLQsjoONXUKTvwqja+
         uA9l5dia46T7nQmI7KuGEwanRLoYCiKSpEgh3yeA2FKi1Mup9uadrMnBZ3griSY/51
         ejn3vv1ysc3Ri54FHMTPlnZX/WsHMlU/zNsivz3XjhCQ/X5BgcRfUXAZDxRdSEjGPj
         FhoH9sD53vMhDFjY4KIpMSQ6kdzmNedftxFsWiR0JDuMqJm/7D4bTbCyAxM/ONwHpT
         /CQ4D3rh5i2TGw93hZLaIH0oeqEDlLmPNHi6OWz+jIX+aq2UQV/hk74L45uGQVdAM2
         DPyfao3RO9hwg==
Date:   Thu, 7 Dec 2023 18:20:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Gergo Koteles <soyer@irl.hu>
Cc:     Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
        Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 03/16] ASoC: tas2781: disable regmap regcache
Message-ID: <0b836c10-b21b-4275-8dd0-254dd5467497@sirena.org.uk>
References: <cover.1701906455.git.soyer@irl.hu>
 <21a183b5a08cb23b193af78d4b1114cc59419272.1701906455.git.soyer@irl.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="87ASVyUZXk4suEIf"
Content-Disposition: inline
In-Reply-To: <21a183b5a08cb23b193af78d4b1114cc59419272.1701906455.git.soyer@irl.hu>
X-Cookie: Two is company, three is an orgy.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--87ASVyUZXk4suEIf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2023 at 12:59:44AM +0100, Gergo Koteles wrote:

> The amp has 3 level addressing (BOOK, PAGE, REG).
> The regcache couldn't handle it.

So the books aren't currently used so the driver actually works?

>  static int tas2781_system_suspend(struct device *dev)
> @@ -770,10 +758,7 @@ static int tas2781_system_suspend(struct device *dev)
>  		return ret;
> =20
>  	/* Shutdown chip before system suspend */
> -	regcache_cache_only(tas_priv->regmap, false);
>  	tasdevice_tuning_switch(tas_priv, 1);
> -	regcache_cache_only(tas_priv->regmap, true);
> -	regcache_mark_dirty(tas_priv->regmap);
> =20
>  	/*
>  	 * Reset GPIO may be shared, so cannot reset here.

How can this work over system suspend?  This just removes the cache with
no replacement so if the device looses power over suspend (which seems
likely) then all the register state will be lost.  A similar issue may
potentially exist over runtime suspend on an ACPI system with
sufficiently heavily optimised power management.

--87ASVyUZXk4suEIf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVyDQAACgkQJNaLcl1U
h9A5HAf+Nlxq4xn9n9KdkGpBh57gkb+jV1RuCOHHhqKL7UAdfrt91gUdNVLq1Gvi
ReW5ZeaUE9EjXZo9FGiFaEc6WEP0TzDJi1a7bOyjtR09RU3ec03i8qd32LO7seEd
n/zyRK+X7umxfYsZGTJiXpzLyN9VC96bh6jNkHJmeToQ5LXZsicJ1bolctD6gfXK
8c7YEYL6Jrfx4Q3yfloOfHPHMzFrIrA+08fny0Dx+kaMfsWYGk2VcmaSYUbaP9y4
OhDEOF1sy3RiXsHJxDNIZubb71fuOqSszQQbS2At9b98GwTVTs8xnM61Xx/Yv1gq
8oQk2dsruB2j4P0IeFFcVp3UOQGKiA==
=F7Ae
-----END PGP SIGNATURE-----

--87ASVyUZXk4suEIf--
