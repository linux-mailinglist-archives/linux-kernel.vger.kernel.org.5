Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6140F7A0BDA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 19:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239596AbjINRgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 13:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239402AbjINRgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:36:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2B81FF0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 10:36:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A87BC433BB;
        Thu, 14 Sep 2023 17:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694713007;
        bh=MfTowFu0cgVxPtElLh6QEI0r8tSGdg78qyoRUAdeEaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nUAFiqE4/C5R84NREb7Doj230NMDGpAT8Ddt2r0Ha6Er2OJJtzjj4h6fi0QVZf1Sp
         Bex4tDKYwdEscrRY8UvrRTIKmsGAo9FTHxqnEwLbZsrb9D1BuGyT3r8i9mTb/4RJ0g
         Qzt35R0HA/rqhO6moslvuC7bbSSQSqXjVM7rwrCr60NHsi4X5/w3/6HooY6YY29ns+
         uFyCLep6/VBZACYKM61/o8uh2Hzos6YSm2J8Fz9YQ8c5uv2QMfgZ2d5JE9TlcqOhMy
         WCsOSWe2+uHxz10ADY9N8g870415uRQtSQajyz5GdJBINMEfQNLIuo94hZov1IZut+
         57p8K1bIwf3tg==
Date:   Thu, 14 Sep 2023 18:36:42 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v4 4/5] riscv: Vector checksum library
Message-ID: <20230914-scrawny-aviation-03ec222a46b2@spud>
References: <20230911-optimize_checksum-v4-0-77cc2ad9e9d7@rivosinc.com>
 <20230911-optimize_checksum-v4-4-77cc2ad9e9d7@rivosinc.com>
 <20230914-pennant-obligate-db3adf056281@wendy>
 <ZQMxWPczYeDMCokP@ghost>
 <20230914-hardiness-uninjured-6818bfb40b4f@spud>
 <ZQNC7mAYKfuWLUVr@ghost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hdzLaaOULK3RtUdD"
Content-Disposition: inline
In-Reply-To: <ZQNC7mAYKfuWLUVr@ghost>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hdzLaaOULK3RtUdD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 01:29:18PM -0400, Charlie Jenkins wrote:
> On Thu, Sep 14, 2023 at 05:29:29PM +0100, Conor Dooley wrote:
> > On Thu, Sep 14, 2023 at 12:14:16PM -0400, Charlie Jenkins wrote:
> > > On Thu, Sep 14, 2023 at 01:46:29PM +0100, Conor Dooley wrote:
> > > > On Mon, Sep 11, 2023 at 03:57:14PM -0700, Charlie Jenkins wrote:
> > > > > This patch is not ready for merge as vector support in the kernel=
 is
> > > > > limited. However, the code has been tested in QEMU so the algorit=
hms
> > > > > do work. This code requires the kernel to be compiled with C vect=
or
> > > > > support, but that is not yet possible. It is written in assembly
> > > > > rather than using the GCC vector instrinsics because they did not
> > > > > provide optimal code.
> > > > >=20
> > > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > > > ---
> > > > >  arch/riscv/lib/csum.c | 92 +++++++++++++++++++++++++++++++++++++=
++++++++++++++
> > > > >  1 file changed, 92 insertions(+)
> > > > >=20
> > > > > diff --git a/arch/riscv/lib/csum.c b/arch/riscv/lib/csum.c
> > > > > index 47d98c51bab2..eb4596fc7f5b 100644
> > > > > --- a/arch/riscv/lib/csum.c
> > > > > +++ b/arch/riscv/lib/csum.c
> > > > > @@ -12,6 +12,10 @@
> > > > > =20
> > > > >  #include <net/checksum.h>
> > > > > =20
> > > > > +#ifdef CONFIG_RISCV_ISA_V
> > > > > +#include <riscv_vector.h>
> > > >=20
> > > > What actually includes this header, I don't see it in either Andy's
> > > > in-kernel vector series or Bjorn's blake2 one.
> > > > Can you link to the pre-requisites in your cover letter please.
> > > >=20
> > > > Thanks,
> > > > Conor.
> > >=20
> > > It is defined here:
> > > https://github.com/riscv-non-isa/rvv-intrinsic-doc/blob/main/doc/rvv-=
intrinsic-spec.adoc.
> > > The header is for the vector intrinsics that are supported by llvm and
> > > gcc.
> >=20
> > Well, whatever you're doing with it does not work, producing 3600 or so
> > fatal errors during compilation, all saying:
> > ../arch/riscv/include/asm/checksum.h:14:10: fatal error: riscv_vector.h=
: No such file or directory
> >=20
> > Do you have some makefile hack somewhere that's not part of this
> > patchset? Also, I'm dumb, but can you show me where are the actual
> > intrinsics are being used in this patch anyway? I just seem some
> > types & asm.
> >=20
> > Thanks,
> > Conor.
> >=20
>=20
> Intrinsics are needed for the vector types. Vector types are needed to
> get the inline asm to select vector registers at compile time. I could
> manually select vector registers to use but that is not ideal. In order
> to get this to work, vector has to be enabled in the compiler. This
> patch will not compile right now, but since people are working on vector
> I was hoping that it would be possible in the future. Palmer recommended
> that I just put up this patch for now since I had the code, but only the
> non-vector versions should be candidates for release for now.

I see. I was pretty unclear to me anyway what the craic was, you should
probably note that the build failures from here onwards are
known-broken. If you want that header, I guess you probably need to
have v set in -march?
If so, the in-kernel vector patches that have been posted do not do that.
Oh-so-far from an expert on what is a safe way to do these kinda things
though, sadly.

--hdzLaaOULK3RtUdD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQNEqgAKCRB4tDGHoIJi
0vGnAQDdLVtUPskYP22nyMgFg01pnHFouvzBVON1b/5dYKCfWgEAhVTJTZTVePAi
YoE3ZHxR2PNtYY+65BhcEqkil9Wg4gE=
=lz5p
-----END PGP SIGNATURE-----

--hdzLaaOULK3RtUdD--
