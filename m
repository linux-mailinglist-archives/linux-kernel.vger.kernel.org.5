Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BFC763F3C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 21:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjGZTIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 15:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGZTIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 15:08:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4BC2118;
        Wed, 26 Jul 2023 12:08:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99F2061CAD;
        Wed, 26 Jul 2023 19:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D2EC433C7;
        Wed, 26 Jul 2023 19:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690398515;
        bh=OurcV5HpRVLK1XUrzTmVNWsTbF3nZTOhXhHNtj2lVtE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O4dtxJnzTeEabAkzv9fCJBbjOxlhQov5Thq3LOh6aEaQsEZEEP5rH3b3WaIQSbDsl
         TJnBWUP1sjH5gEeJOXf7UlfZ/4rSKSNkX6E9ymVHJktVf6bKb7mhKmX3hNXXrB4BVx
         bcS2q3gSjD4Wo04uXZqpRanrO82BsmFwzmCPSyzcf8OMd0an9fJaCs3TrAM5zNrRXk
         kyZ1xl/lXlhHbF7emUM0M1rXiGlBSm9Hy4M9XvsqIlFsfBSAnDFW8tIBcLnVOcsyUG
         YYXDc9Zk1Us8EtNDA49za/VlZCtmj6ctETD1rXW5aU99tcDPBQojUZQIolP2ZlJ3gL
         ypri348288mlw==
Date:   Wed, 26 Jul 2023 20:08:28 +0100
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
Message-ID: <e02366cf-4142-45af-a385-5dedf5c7069a@sirena.org.uk>
References: <20230723-thermal-fix-of-memory-corruption-v1-1-ed4fa16d199d@kernel.org>
 <f559a614-93d5-121a-8ff3-0da77bc85f44@linaro.org>
 <ZL054LHAZv8VmIk3@finisterre.sirena.org.uk>
 <CAJZ5v0jJ+YM=7LUEKB_b5GUsGopLTT0eyPmomYV0OcGQp2gvig@mail.gmail.com>
 <a72ca5e0-556a-4d16-9c5e-2b342bb074c1@sirena.org.uk>
 <CAJZ5v0jybAspzV2sWduERaMhBWPSYN_USiUcO_=eRUBB6vB6GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mwtn8GdYlabT5FrF"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jybAspzV2sWduERaMhBWPSYN_USiUcO_=eRUBB6vB6GQ@mail.gmail.com>
X-Cookie: Life is the urge to ecstasy.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mwtn8GdYlabT5FrF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2023 at 08:51:20PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jul 26, 2023 at 8:47=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:

> > > Surely, they are present in my linux-next branch.

> > Are they queued as fixes?

> They are.

> >  It'd be really good to get these into v6.5,
> > they're rendering the Allwinner platforms I have unusable.

> I'm going to send a pull request with them tomorrow or on Friday.

Ah, excellent - thanks!

--mwtn8GdYlabT5FrF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTBbywACgkQJNaLcl1U
h9DJAwf+LOgzoi94SHdFx4hT/g5LVRVy5zrZzmgIKPxiylVL6g6GhbULfxlm5CGM
cUhr0GaUPQAsQ+rmtBQl4vaIVs05TP/O49ONJkprvv65RtFMrlU1KVfSP9T6b+Ar
LB+lg5vj9SARr/wd4r/0uds7p+BV/uBvilr+oBWZKb5iqdnfZ1yoVeL4HziBaDGv
MwT3y4WqdEDsFrhWe1ZS1AHMrn9Yw+/SoDq0GUfFXBscFGHoQ0P1utnwiiswkJG0
t3UFL+iRZkbQrZh2H0VytzaLYgzRobbx9YvOaH2JkpL1/VHRq7E0joS7EEnizceN
axab6/YLMDTlfUrxTENhMl7ZKE0aOQ==
=yTTh
-----END PGP SIGNATURE-----

--mwtn8GdYlabT5FrF--
