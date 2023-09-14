Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDDB7A0AC6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbjINQ3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjINQ3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:29:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986C61BE3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 09:29:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C41C433C7;
        Thu, 14 Sep 2023 16:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694708973;
        bh=H33byKpeFMjVP9Sa7iH9ab3sgake7AuLJWHEwU6i/zo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mq92Ma924rZPbjERas1Von9mhS2Qc15dxZ5mE6S3FhJouTcZTuxmUC2EJGYXGUGtM
         8rTu0DKEDtw7xnY9HZt95xIaXGR0FJsXwJOSWowfK0h/t1eNG2h1NThrAR78fy8Sje
         FNxBYyhQ7Xz2WMyO6+9ksnLXb51wvboSwQCZc5yv3HFmluurTXTAkWrG3DIaJ0kzE3
         84WbzKntmWk2j9TjXKKHcjbnEC16zKeZRxLNCgGZ1a8l6BdCszSrr5cHG0mlfNtm5l
         jRxpjTYladGg/UvCBmU4djrfJtUOh99RiMlg5RMY/Mt91HbGOIztX+1YK1jzuc4jAt
         FbEWoOTj3ho3A==
Date:   Thu, 14 Sep 2023 17:29:29 +0100
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
Message-ID: <20230914-hardiness-uninjured-6818bfb40b4f@spud>
References: <20230911-optimize_checksum-v4-0-77cc2ad9e9d7@rivosinc.com>
 <20230911-optimize_checksum-v4-4-77cc2ad9e9d7@rivosinc.com>
 <20230914-pennant-obligate-db3adf056281@wendy>
 <ZQMxWPczYeDMCokP@ghost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vACo4KyzGOkrlLwY"
Content-Disposition: inline
In-Reply-To: <ZQMxWPczYeDMCokP@ghost>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vACo4KyzGOkrlLwY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 12:14:16PM -0400, Charlie Jenkins wrote:
> On Thu, Sep 14, 2023 at 01:46:29PM +0100, Conor Dooley wrote:
> > On Mon, Sep 11, 2023 at 03:57:14PM -0700, Charlie Jenkins wrote:
> > > This patch is not ready for merge as vector support in the kernel is
> > > limited. However, the code has been tested in QEMU so the algorithms
> > > do work. This code requires the kernel to be compiled with C vector
> > > support, but that is not yet possible. It is written in assembly
> > > rather than using the GCC vector instrinsics because they did not
> > > provide optimal code.
> > >=20
> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > ---
> > >  arch/riscv/lib/csum.c | 92 +++++++++++++++++++++++++++++++++++++++++=
++++++++++
> > >  1 file changed, 92 insertions(+)
> > >=20
> > > diff --git a/arch/riscv/lib/csum.c b/arch/riscv/lib/csum.c
> > > index 47d98c51bab2..eb4596fc7f5b 100644
> > > --- a/arch/riscv/lib/csum.c
> > > +++ b/arch/riscv/lib/csum.c
> > > @@ -12,6 +12,10 @@
> > > =20
> > >  #include <net/checksum.h>
> > > =20
> > > +#ifdef CONFIG_RISCV_ISA_V
> > > +#include <riscv_vector.h>
> >=20
> > What actually includes this header, I don't see it in either Andy's
> > in-kernel vector series or Bjorn's blake2 one.
> > Can you link to the pre-requisites in your cover letter please.
> >=20
> > Thanks,
> > Conor.
>=20
> It is defined here:
> https://github.com/riscv-non-isa/rvv-intrinsic-doc/blob/main/doc/rvv-intr=
insic-spec.adoc.
> The header is for the vector intrinsics that are supported by llvm and
> gcc.

Well, whatever you're doing with it does not work, producing 3600 or so
fatal errors during compilation, all saying:
=2E./arch/riscv/include/asm/checksum.h:14:10: fatal error: riscv_vector.h: =
No such file or directory

Do you have some makefile hack somewhere that's not part of this
patchset? Also, I'm dumb, but can you show me where are the actual
intrinsics are being used in this patch anyway? I just seem some
types & asm.

Thanks,
Conor.


--vACo4KyzGOkrlLwY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQM06AAKCRB4tDGHoIJi
0mdwAP40Q0oxsDF3wBoaGgdhytSmQcfrEYVaDIb9xbFef+wnGgD/Xg6SCr64B3S9
O5MiMctRJdwO8l41VhuCdOxSlG7qkgE=
=r45z
-----END PGP SIGNATURE-----

--vACo4KyzGOkrlLwY--
