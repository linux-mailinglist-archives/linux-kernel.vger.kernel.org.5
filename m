Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA574804158
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 23:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbjLDWJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 17:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjLDWJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 17:09:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A073101
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 14:09:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD97C433C8;
        Mon,  4 Dec 2023 22:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701727789;
        bh=PZdKYgteRXQG7u/EvbdA+FWt1apI/KIe+HMcfOKH5vU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mb9PhsVKnePwJFmD2sdP/1C7zlcmt1BjE9MU72qkhHdZlhoVdu2LNwVD1N+MqoLP+
         YCQWe6vfigdh5Zxi1wCYWLLWCE/HsR7ogxOU3MRHTI5/nEvCu11AYoVYPhSe05Yc8F
         BuDAWJtpdkcfFZSclP4ZnexZ3Uy+qCLubUKEQdzJNC2FjDRUteIL3Hzq0/TBCz1ATK
         2wmD7wXSd+hD9GK1eaJC3NNVcGc71lEf5lv0DsHU9DsY6X/Bd2RjjO4c6L+I7FL2qb
         bey/gLhNmEgJHzjP7Vsb/PGWJIjPkrNR5zoa7rT3LBwF3TchfC8356Nafph3aUCVM+
         U+JgpKIJxjPOA==
Date:   Mon, 4 Dec 2023 22:09:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        linux-serial@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: max310x: work around regmap->regcache data
 corruption
Message-ID: <26710a0a-4390-4056-8734-812480346b6c@sirena.org.uk>
References: <20231201171644.6f7ade89d4c2f744fa3556b7@hugovil.com>
 <20231204112905.e58cf1b7bf94440f49188390@hugovil.com>
 <06fa462c-5b48-410e-8656-4d0dbdbfa142@sirena.org.uk>
 <20231204120151.f0afbee2ebc69e93e7977547@hugovil.com>
 <50b24985-cb30-4a75-a15d-9c165a276f1d@sirena.org.uk>
 <20231204135922.0355f030945920086d21b8b6@hugovil.com>
 <66946666-eb33-431d-9870-7046c39ffb4e@sirena.org.uk>
 <20231204144136.89fec6da9be49e3db96994e0@hugovil.com>
 <f6e93e9c-1c7a-424e-afe0-425b24b99e5c@sirena.org.uk>
 <20231204150224.add8b07a59bf737edb0b5c1c@hugovil.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EVdV5P8BE7EA9jWc"
Content-Disposition: inline
In-Reply-To: <20231204150224.add8b07a59bf737edb0b5c1c@hugovil.com>
X-Cookie: For office use only.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EVdV5P8BE7EA9jWc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 04, 2023 at 03:02:24PM -0500, Hugo Villeneuve wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > This is truly innovative hardware,...

> Well, I would not say innovative, but more "crappy" hardware design :)

I didn't say it was *good* innovation.

> >  You'd need to extend the core
> > so that it knows about this quirk, right now that's not possible and
> > we'll just leave the window pointing at whatever was last accessed.

> Ok. I am not sure that adding support for it would make sense, since I
> do not know of other ICs that could reuse this very specific and
> particular method for switching "paged" registers.

Yeah, I'm drawing a blank there.  The thing that springs to mind is
optimisation with wanting to always be on a particular page for fast
interrupt handling or something but that feels rather thin.

--EVdV5P8BE7EA9jWc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVuTigACgkQJNaLcl1U
h9BROAgAhI9t64zxEMrM1wLApkfngKVB6u40SuVQrGZo1euGjw+A325QoAySSJ3O
Ul+YUTbNHN/5cueUh+xfifIe3xbacmc35Ws8X57JnWfXILCUFv1/scl+TLw5kcbr
gNa6f+00BRjLoBKh3yrZ0d3uXTn8ZhFavtEQbhFyPcrnoLbHnp1qC7rWexGVupeB
/ioqukeOySGZbfX55Y4UTuvEA/ok3vWLz9XDIUOLdAbsej0JGkfP/YEmF3/GJpHq
9TuWL5Yo2OTye9bS94iQDUmoDn4U7VwIIAHwJ2WTpvWWJ2WhlEVmevBQz3ED1rqV
AYiE6/aZG5JahtTH4yc51aTAelp3lg==
=4Rkn
-----END PGP SIGNATURE-----

--EVdV5P8BE7EA9jWc--
