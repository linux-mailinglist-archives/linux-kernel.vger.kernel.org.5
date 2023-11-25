Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862D27F8A33
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 12:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjKYLfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 06:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKYLfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 06:35:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6989A10E4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 03:35:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BCEC433C7;
        Sat, 25 Nov 2023 11:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700912138;
        bh=fA5dBqvkCMbY/gU4EAds281Y/nW5/ZDX5cOERLsbkCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qS2NwS0a5ccoxX0CL6+LZ+PU7wiySilJz1iYpjvQ7MXn9ha91eQ4jUjU8OblikCP3
         eU6UaQ7qM/AkRcG6QIkhjUxS9KeKzyQUYDj1cw2ElG3dSWkv+hgtIvufc9iAUKBSoC
         fdVi/E2PYdLubhALFFfI6XzaLgrgRbIlVzgl9fAE1YfKzKT9X3Xs0ipVDub/X0L6XW
         olYogTuAjrGAHJ1Ji04N6iyG1/QRfEJCD5+M8BBAfGNqKAgp7i9a3vONQ2gdUBuQqX
         eFUbz0hBXyRAC/qyr7uN+m8zyu+Dx2KJ/LY6V/gMPrCNChFfpcNX/YkyQw2VXxF7hh
         t1g5CzzKKF7ag==
Date:   Sat, 25 Nov 2023 11:35:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Deepak Gupta <debug@rivosinc.com>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Kito Cheng <kito.cheng@sifive.com>,
        linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: Re: Shadow stack enabling from dynamic loader v/s kernel on exec
Message-ID: <ZWHcBq0bJ+15eeKs@finisterre.sirena.org.uk>
References: <CAKC1njRkpaqbAFWrZpz75u4M-T8mniY2QHVZEENameqnHOOGPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cOFv5Mas7bXm7EYN"
Content-Disposition: inline
In-Reply-To: <CAKC1njRkpaqbAFWrZpz75u4M-T8mniY2QHVZEENameqnHOOGPg@mail.gmail.com>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cOFv5Mas7bXm7EYN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 22, 2023 at 04:19:51PM -0800, Deepak Gupta wrote:

> "Was there any other reason other than supporting ELF binaries that
> went ahead of kernel changes that
> led to decision of delegating of shadow stack enabling in dynamic loader"

> If there are other complications that can happen due to kernel
> enabling of shadow stack based on ELF bits,
> I would like to know about them.

This wouldn't play nicely with security policies that prevent disabling
the shadow stacks - it would be fine with the prctl() based locking but
something imposed externally with seccomp or similar would be there from
process start.

I'll also note that for arm64 BTI where we're less concerned with
compatibility (since the protection is per page we only need to make
sure that each ELF image is BTI enabled when we map it, we don't need to
worry about any further code that might be mapped/loaded) we only
enforce BTI for the dynamic loader, we still leave it to the dynamic
loader to remap the main executable as BTI.  The architecture
maintainers have a strong preference for delegating as much as possible
to userspace in order to reduce the potential for being locked into an
unwanted policy or having difficulty in working around breakage.  The
issues on x86 are an example of the sort of situation people are worried
about seeing in future.  I personally would be OK with directly
interpreting the ELF markings there but it wasn't the consensus.

On arm64 there would be the potential for disrupting some limited and
theoretical use cases where GCS is enabled even though some libraries do
not support it, we don't allow GCS to be reenabled for a thread after it
has been disabled in order to avoid dealing with the issues around
reinitiating the GCS for something that's a corner case.  x86 does allow
reenabling so wouldn't have that issue.

--cOFv5Mas7bXm7EYN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVh3AMACgkQJNaLcl1U
h9B0+wf/ez1q5D2F/q8K/4aw5Tf2OGifwUFS9unYNHBCLooaSWoKmk0gTmuMvWlq
C73e4lqshdfB+NrAAnTfpCNdrAs1am3mtMaxa9C+5I6rGp47y+9xfiI2y/e+6fHL
UfvM9J632yj20O/t8CKCpqKs1eY0yIQLAOcLXdEM8Fyd/w5euTcaexxfd74bnJEu
gIwaokQms3p84h96do8fCCNL/TZEaoHCkGPrPaGb+XRqrY0/tGcYvfhbaaJZbMAB
ToeUwVFDbnZLw/aGycrou7rWnt5F//mSZ6jtyHB0zAaUYM6cIaWcYiYxqfv1/d1a
dFfpGYJLVP4StiKTu8rFdVRJqchAPw==
=/BR4
-----END PGP SIGNATURE-----

--cOFv5Mas7bXm7EYN--
