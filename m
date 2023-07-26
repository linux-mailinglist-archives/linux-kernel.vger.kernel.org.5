Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BFF763EDA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjGZSsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjGZSsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:48:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A0E26B9;
        Wed, 26 Jul 2023 11:47:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F36061C83;
        Wed, 26 Jul 2023 18:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBDAC433C7;
        Wed, 26 Jul 2023 18:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690397264;
        bh=inWMbHQzWvxiDJ0CGStx9C8OQo3bCAYsE5PA+XZ4IG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oS7oQlP+L9Yof7jmcPyN2YuqfNI6hJZehf+6nNrgdcORCUcKRHR7oAUjsL0kPaO7D
         +dby9Kt3uQjlfjBnoa4Yplx3K6d/WIkqG5s5bQF4r36XNKNtY25KKBQa253Twc0kKL
         9o3u2jF5dwZfAwNZU/pdf+7rbC2svHmUlFCUl9fSVZnlQ/GBdij/RppbP5VyVF1+cB
         GsJmPvwyzKXmJQt21oilS6Y0QwooTAyPkBl42cjRweWZ7V4XbRNFMOmGGzM2pf8RRD
         rRVYfzzfq7V4N5cHmOCMPVF6vUFvM7388/UDuerhHbs019LUJuwQWC9sPQibPlgsfV
         dXxlR+RBbbe/w==
Date:   Wed, 26 Jul 2023 19:47:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
        Icenowy Zheng <uwu@icenowy.me>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-sunxi@lists.linux.dev, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] thermal/of: Fix double free of params during
 unregistration
Message-ID: <a72ca5e0-556a-4d16-9c5e-2b342bb074c1@sirena.org.uk>
References: <20230723-thermal-fix-of-memory-corruption-v1-1-ed4fa16d199d@kernel.org>
 <f559a614-93d5-121a-8ff3-0da77bc85f44@linaro.org>
 <ZL054LHAZv8VmIk3@finisterre.sirena.org.uk>
 <CAJZ5v0jJ+YM=7LUEKB_b5GUsGopLTT0eyPmomYV0OcGQp2gvig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ldfM+o0rph9VUc9l"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jJ+YM=7LUEKB_b5GUsGopLTT0eyPmomYV0OcGQp2gvig@mail.gmail.com>
X-Cookie: Life is the urge to ecstasy.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ldfM+o0rph9VUc9l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2023 at 08:42:39PM +0200, Rafael J. Wysocki wrote:
> On Sun, Jul 23, 2023 at 4:32=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:

> > There was a message on the thread saying the patches have been applied
> > for v6.5 but I can't see them in either mainline or -next.

> They should be there in linux-next (as of today).

Yes, they're there now.  They weren't at time of writing the above (on
Sunday).

> Surely, they are present in my linux-next branch.

Are they queued as fixes?  It'd be really good to get these into v6.5,
they're rendering the Allwinner platforms I have unusable.

--ldfM+o0rph9VUc9l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTBakkACgkQJNaLcl1U
h9DThgf/UWuCjWQj8NV+YlBo8o3bd6oPIaqs892ZUtsKAxVagl90Q7/+trEyJiHF
6KH1f3S9D7+8LnQFNL0kOaTdDj6JGETjjUKynkACEfyWm+59iHT/+dege32sIFv6
pV/d4RxifIfp0o2r9jIYTaojaxFRiLZW9nHhRfHaEpx51W25B5xA5XIvXyL7iEvU
hOhw+UI6vtJTQ5GVIRceX2iKjZnBBn225KinUek60omr+6ac3+r9nLLaPSlomTLb
Rx9cQ4D2ZiQSnHMip5HQ/0TsFeie1yJnJrSwU7p0aoDms8mpg7R5OskgyLu2ng3k
xOiWkFDGgZ4drBIhCMDLboe6s+0I/w==
=RKtC
-----END PGP SIGNATURE-----

--ldfM+o0rph9VUc9l--
