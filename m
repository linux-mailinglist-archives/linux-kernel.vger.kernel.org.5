Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39D179F1D0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 21:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjIMTRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 15:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjIMTRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 15:17:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9577A170F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 12:17:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BD0C433C9;
        Wed, 13 Sep 2023 19:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694632626;
        bh=KmSqQnNXsxALRlaRnHz5AjP9OJl9ZvKFUtF+EcyvZpA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bWHrMySJj/cAf22OX6GAi/aHI3bRJJgyCRmgpNn875SnAQj0DmoZ0nUA6me9Wyy7v
         AZw/OKmM4p7Q1lCogdaFJbvAnJR2rO9ujc3sNnvgeYL/UsoxAg9tdJYoxud9VeCzFx
         g92xPyGsb1qyUxrguJZ4X9stVeDj7+kHQmcYwB7vihL+5z7PGElmNou80CcmaeQxIN
         fiShbn13TKZQmerf91WxN0Ct81vnQ/WSDcC5w9qhB71xh1jmSbrcR4ikeE4N2LdC/G
         HBkOh4i4izzhLybUfdblMj5La7xShawuh0D0+f07UubYd0wQRMiXDzF+Ln7JxkXiea
         T4Ze6//MH8G3w==
Date:   Wed, 13 Sep 2023 20:17:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sebastian Ott <sebott@redhat.com>
Cc:     Willy Tarreau <w@1wt.eu>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org
Subject: Re: aarch64 binaries using nolibc segfault before reaching the entry
 point
Message-ID: <11356b6c-3f26-411c-a2ce-9cae9dfd3ea5@sirena.org.uk>
References: <5d49767a-fbdc-fbe7-5fb2-d99ece3168cb@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n4GiLnd5p7hfxHZ+"
Content-Disposition: inline
In-Reply-To: <5d49767a-fbdc-fbe7-5fb2-d99ece3168cb@redhat.com>
X-Cookie: Use extra care when cleaning on stairs.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n4GiLnd5p7hfxHZ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 13, 2023 at 08:44:59PM +0200, Sebastian Ott wrote:

> the tpidr2 selftest on an arm box segfaults before reaching the entry point.
> I have no clue what is to blame for this or how to debug it but for a
> statically linked binary there shouldn't be much stuff going on besides the
> elf loader?

I did notice this on some systems but didn't manage to reproduce it
interactively and hence debug it yet :/

> After playing around with linker options I found that using -static-pie
> lets the binaries run successful.

...

> All on aarch64 running fedora37 + upstream kernel. Any hints on what could
> be borken here or how to actually fix it?

That suggests that there's some randomisation of the executable location
going on which is triggering the issue...  TBH it seems sensible to take
a patch that enables that for now, it's clearly better to get the tests
running more reliably even if we don't fully understand the issue.

--n4GiLnd5p7hfxHZ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUCCqwACgkQJNaLcl1U
h9C5fAf7BsLoVGpr1uBHx9v36Im9I9zCB2llfaAaCb3JQ7Sny7QtodS81K++z6Xy
PTZweC924hQiTIjZXxbKQXmkP86w2twNki3MstaXRPQUyoFgATUO+p8MkRJ+htep
G3KqSlRfElkteaF7jgx4FU3sh+oG87pDGrJooER4RL1oV2wuvwJ0Xm9MoRO/oSYF
8t1SYNxRCHkF6KUI5a7wWWUxmVqv7ygz39ot7shEBl5DXfnX1KAdnyxGARBAvslV
7rCGyclJY5puKOni7LyDZkPqiGNCXQDBlX7UTX7MmlFGtlXfLGZqz37euNguxm4d
Xu6tLqbSvemP1hoq+6CrNoCQQyQToQ==
=nFZT
-----END PGP SIGNATURE-----

--n4GiLnd5p7hfxHZ+--
