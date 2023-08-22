Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9837783B69
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbjHVIIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbjHVIIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:08:09 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9234AE9;
        Tue, 22 Aug 2023 01:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692691686;
        bh=9OAl8UNeJmRCk89ZGQRyLugIhvPcIdQswDnXJ0EIDtw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AU2ryrD9D9ZAB9c6jjgMau4MZtS30SP8q7xD+tmRm+6dOR7SAN+0+u6b3BA5TjsoV
         OzLjmGAQqXf3S2foEMwXuiN0XsCsFIV0nCFr8nyq0DklA1FTHG/qM7AHsL5/JTRXG6
         f1Ud4ge8Ug2fcoCYKMLal4onScVmTYlQcsg1LYt2MyTj3KhmGMJdJUiSJL48UjQj5x
         v6ZUzb0DqU51gFcarXFQBeugufXkoFhPRLyjiEvQEdmliO7JMQmL+Gdg5ueEbL0sMQ
         ic6LuEWZKd4fW6Y4J0PhWGXntAfYftD8PHI6fJgx3zlsH19B0r5mzKsIgozUiTckkn
         0zzumdN+AOuQg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RVMRB1x7tz4wZp;
        Tue, 22 Aug 2023 18:08:06 +1000 (AEST)
Date:   Tue, 22 Aug 2023 18:08:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the efi tree
Message-ID: <20230822180805.483c10ee@canb.auug.org.au>
In-Reply-To: <CAMj1kXGKtpGNYx6hqygya+k_gQaMTiwEZnRGk9rZ=hcbcagKXA@mail.gmail.com>
References: <20230822164859.26b0b8f6@canb.auug.org.au>
        <CAMj1kXGKtpGNYx6hqygya+k_gQaMTiwEZnRGk9rZ=hcbcagKXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9/eG_NrfjUci6_wy9/YuMUd";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9/eG_NrfjUci6_wy9/YuMUd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Ard,

On Tue, 22 Aug 2023 09:32:31 +0200 Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Hello Stephen,
>=20
> On Tue, 22 Aug 2023 at 08:49, Stephen Rothwell <sfr@canb.auug.org.au> wro=
te:
> >
> > Hi all,
> >
> > After merging the efi tree, today's linux-next build (x86_64 allmodconf=
ig)
> > failed like this:
> >
> > In file included from drivers/platform/x86/uv_sysfs.c:14:
> > arch/x86/include/asm/uv/bios.h:118:22: error: expected ')' before '*' t=
oken
> >   118 |         u64 (__efiapi *function)(enum uv_bios_cmd, ...);
> >       |                      ^~
> >       |                      )
> >
> > Caused by commit
> >
> >   73632c8c865f ("efi/runtime-wrappers: Remove duplicated macro for serv=
ice returning void")
> > =20
>=20
> Thanks for the report.
>=20
> I cannot reproduce this with Debian's GCC 12.2.0 when building the
> efi/next tree either in isolation, or merged into yesterday's next.
>=20
> Could you please share the compiler version and the .config you used? Tha=
nks.

$ x86_64-linux-gnu-gcc --version
x86_64-linux-gnu-gcc (Debian 12.3.0-4) 12.3.0
(this is Debian's cross compiler that is ppcle64 hosted)

and (see above) it is a x86_64 allmodconfig build.

Maybe there is some interaction with something else in today's
linux-next (just released).
--=20
Cheers,
Stephen Rothwell

--Sig_/9/eG_NrfjUci6_wy9/YuMUd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTkbOUACgkQAVBC80lX
0Gy8yAf7BZfZJMin9PDBt0c7eEZyagCxLBcsnsLdeOutLDY0PCNpgs3dNrolDJke
Zvkdkv4r+KJ8/HzFt9rbyyw9/q55njCUP4IHqgkTYOfDEao1GQJa1X3jJE45Pcuo
sJLixHvv86ELmJEELHsg0oHA+StxK0eeHoPLPVYqXcG0jEDEJut4WhskAh1UXD6h
NTUxH2IwpVd0gEpcCUlJz0eMBkKN+O9KqXAKR3d8Co36qFhc43coR2/oLynnQbJW
nKu+xE4JBiKnxZPS6eD7+CXvtOb0GxIGJrp1ce4D3bgYZZpZ5aHntf0FzSvD/Ziv
aES3SCV3C/+UJIEJ6FJGUTQEZ80ioA==
=xN05
-----END PGP SIGNATURE-----

--Sig_/9/eG_NrfjUci6_wy9/YuMUd--
