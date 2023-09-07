Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BF5797AB0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245510AbjIGRsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245492AbjIGRrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:47:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C311FD5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:47:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F3FC433C9;
        Thu,  7 Sep 2023 16:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694104122;
        bh=kKCZnmdvlWAjdrTU0JnWgVFWVm2CYeepMuQakkeoZIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=md4gqdddSO75KH0T47TDmNEOdTf41rhUx525zBO7wDx1GSSi0sr7xkqy8MuFHqauP
         nhO2VHtsMeUCqKmw6eisy7vq0/5xR3u8jrC//uvr9EQrNk5kytuUbHUTRUk9ugyxgx
         3gSbAEWD3u0Gyz0dh6NI7flXZNoypzJYi6Gwh5BJytM2We8AibqAKNUG9IW6roAbGo
         0iuC0r5m6jjPnx8Jz0nyh7UBwT6nHV95FkZREvvqPBzaQY9EVBGGqiFE7xX7NryX5W
         gHXkYEawONiYhIBWoTKMA6cRhR+J9S4N6Op3eOlZLgdJnPGnXDWljlFl2qIEwtAXJp
         mYOMEcrY/9RNQ==
Date:   Thu, 7 Sep 2023 17:28:30 +0100
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
Message-ID: <bb3e5ccf-6eb5-4a36-9af0-b33f2db68445@sirena.org.uk>
References: <20230907161207.14426-1-joerg.hifiberry@gmail.com>
 <a9c3d43a-af26-44a0-9352-4666107f9f56@sirena.org.uk>
 <ZPn4nsypsSXdB3J7@ubuntu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hUcgJYAhcs+B7VEy"
Content-Disposition: inline
In-Reply-To: <ZPn4nsypsSXdB3J7@ubuntu>
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


--hUcgJYAhcs+B7VEy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 07, 2023 at 06:21:50PM +0200, Joerg Schambacher wrote:

> And yes, we cannot be sure that future devices may require different
> settings, but I can hardly imagine anything completely different than
> this approach with the usual audio MCLK frequencies.

They may for example be restricted and just not the the incoming MCLK
divider, or require a higher frequency for some fancy processing.  In
any case tas_device is just an obviously bad name here - there should be
a flag per quirk, not a flag per entire class of devices.

> > This is probably a separate quirk?  I'm a bit concerned about what's
> > turning the PLL off here...

> The PLL should not be used in this specific case where all divisions are
> just divide-by-2's. Your original code does reflect that and turns the
> PLL off. It improves jitter and finally audio performance.

> But in the case of the TAS-devices we even then need the PLL to
> drive the AMP clocks.

That's definitely a separate quirk, and does sound like it should be
driven from the bias management or DAPM more than hw_params.

--hUcgJYAhcs+B7VEy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmT5+i4ACgkQJNaLcl1U
h9CZ+Qf+J2f6CIl+3kQOLAmv4SLapcB47o1g840CoC/9/uJ/sk2TlngPfsjmLttb
uW+Sv7yC6pLMtzMHz8kwbnjhapJTJLlrQKhL4u7OPQtX2S5Dm9xbjO3ZXX+MxQX5
wPn/HpF2qDdA/cp/TdBycJcM9zJ+1jjMKBMneCqEPGXJZCRz0mEl9XTaIQLKk9Cq
4fIjWXyyPLf8j+kvqzIBKItMIYkPXABMnjJ7f8jYox9LyigjW306+rCxOJaU1qL5
ZKOiWeZqBWwWI1TEkQQd3i3n6pzmNSAHK0KhlGR1qDaYdjkkyFBhKe5wKsOZeE1w
6WbW/o4djQkLPhrAIoQ7eVyuV0WQuA==
=I+kL
-----END PGP SIGNATURE-----

--hUcgJYAhcs+B7VEy--
