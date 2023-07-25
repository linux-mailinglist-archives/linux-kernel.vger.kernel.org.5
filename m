Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF017626BC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 00:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbjGYW1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 18:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjGYW1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 18:27:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC105FD6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 15:20:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1771661935
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 22:17:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518FBC433CC;
        Tue, 25 Jul 2023 22:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690323451;
        bh=9duJYsP4IefPgz7np3nvBZh3XlabkCsEBI1FzTJIOqA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a6rCLQWHSI8YJO2nCtunWOXccQckpKC92s95fp1QXPLzlQA634hst0MGGUUa7VDA0
         pKgzF80ym3NMjqj2i7Hibmooh6hD1v/ZnS7WIpcdf1RMzRQhJUfs7sz/xdvcF3cSXI
         fl1PhOrxRfEcZDun54fqHLmjP3VwKsAMW2+ghei/Ziezs4eYf+tsMmIm86V4jyRH+E
         wXx+6TXj111N23PbWJZc38APh/K3g1APBo03/Nu8mK0rOsUGLpZdmspTPbhiTG4I4X
         KNlzdCZWC/HGWpbJ/e7P4MXVS0iEM474TWIvYMdaVToeZYs6JrWC35K7yMtnwiXzn6
         HnC6qw6sR+d1g==
Date:   Tue, 25 Jul 2023 23:17:26 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Mingzheng Xing <xingmingzheng@iscas.ac.cn>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Bin Meng <bmeng@tinylab.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] riscv: Handle zicsr/zifencei issue between gcc and
 binutils
Message-ID: <20230725-name-aggregate-5de303072c9d@spud>
References: <20230725170405.251011-1-xingmingzheng@iscas.ac.cn>
 <20230725172344.GA1445373@dev-arch.thelio-3990X>
 <20230725-skating-agent-b092f2257ca1@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wbqao3EI+HlRxhpT"
Content-Disposition: inline
In-Reply-To: <20230725-skating-agent-b092f2257ca1@spud>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wbqao3EI+HlRxhpT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2023 at 07:57:54PM +0100, Conor Dooley wrote:
> On Tue, Jul 25, 2023 at 10:23:44AM -0700, Nathan Chancellor wrote:
> > On Wed, Jul 26, 2023 at 01:04:05AM +0800, Mingzheng Xing wrote:
> > > When compiling the kernel with the toolchain composed of GCC >=3D 12.=
1.0 and
> > > binutils < 2.38, default ISA spec used when building binutils and GCC=
, the
> > > following build failure will appear because the
> > > CONFIG_TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI is not turned on.
> > > (i.e, gcc-12.1.0 and binutils-2.36, or gcc-12.3.0 and binutils-2.37, =
use
> > > default ISA spec.)
> > >=20
> > >   CC      arch/riscv/kernel/vdso/vgettimeofday.o
> > >   <<BUILDDIR>>/arch/riscv/include/asm/vdso/gettimeofday.h: Assembler =
messages:
> > >   <<BUILDDIR>>/arch/riscv/include/asm/vdso/gettimeofday.h:79: Error: =
unrecognized opcode `csrr a5,0xc01'
> >=20
> > The gift that keeps on giving :/
> >=20
> > > Binutils has updated the default ISA spec version, and the community =
has
> > > responded well to this[1][2][3], but it appears that this is not over=
 yet.

Also, I just noticed this comment. I disagree with the wording "well",
and more like "with weeping and gnashing of teeth" ;) This stuff is a
huge pain in the ass, and mixing toolchains between LLVM & GNU stuff (or
using an older binutils with a newer GCC) really makes it a lot worse.
Thanks for submitting a fix for this so that Nathan or I didn't have to!

> > >=20
> > > We also need to consider the situation of binutils < 2.38 but
> > > GCC >=3D 12.1.0, since the combination between different versions of =
GCC and
> > > binutils is not unique, which is to some extent flexible. GCC release
> > > 12.1.0 updated the default ISA spec version in GCC commit[4].
> >=20
> > I suspect this combination is not too common because binutils 2.38 came
> > out before GCC 12.1.0 but as you note, it is obviously possible. What
> > toolchain has this combination in the wild, which would be helpful for
> > documentation purposes?
>=20
> Yeah, that'd be great to know, at least the other niche stuff that we
> are working around had a clear use-case (testing LLVM in debian container=
s)
> whereas there's no clear user for this.
> That's doubly interesting, as this patch seems to break things for binuti=
ls
> < 2.35, and if we have to make a trade-off between those too, then it'd
> be good to be able to weigh up the options.
> Do we perhaps need the misa-spec workaround instead for this case?
> Haven't tested that though, trying to dig myself out of email backlog.

I don't think the misa-spec stuff is what we need actually. Instead, the
workaround/fix that this patch implements just needs to be constrained to
versions of GAS greater than 2.35.

Thanks,
Conor.

>=20
> > > For more information, please refer to:
> > >=20
> > > commit 6df2a016c0c8 ("riscv: fix build with binutils 2.38")
> > > commit e89c2e815e76 ("riscv: Handle zicsr/zifencei issues between cla=
ng and binutils")
> > >=20
> > > [1]: https://groups.google.com/a/groups.riscv.org/g/sw-dev/c/aE1ZeHHC=
Yf4
> > > [2]: https://lore.kernel.org/all/20230308220842.1231003-1-conor@kerne=
l.org
> > > [3]: https://lore.kernel.org/all/20230223220546.52879-1-conor@kernel.=
org
> > > [4]: https://gcc.gnu.org/git/?p=3Dgcc.git;a=3Dcommit;h=3D98416dbb0a62=
579d4a7a4a76bab51b5b52fec2cd
>=20
> btw, please make these regular Link: tags (with a [N] at EOL) and drop
> the space between them and the sign off. Also, this probably needs to be
> CC: stable@vger.kernel.org too.

> > >=20
> > > Signed-off-by: Mingzheng Xing <xingmingzheng@iscas.ac.cn>
> > > ---
> > >  arch/riscv/Kconfig | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index 4c07b9189c86..b49cea30f6cc 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -570,11 +570,15 @@ config TOOLCHAIN_HAS_ZIHINTPAUSE
> > >  config TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
> > >  	def_bool y
> > >  	# https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dcommit;h=3Da=
ed44286efa8ae8717a77d94b51ac3614e2ca6dc
> > > -	depends on AS_IS_GNU && AS_VERSION >=3D 23800
> > > +	# https://gcc.gnu.org/git/?p=3Dgcc.git;a=3Dcommit;h=3D98416dbb0a625=
79d4a7a4a76bab51b5b52fec2cd
> > > +	depends on CC_IS_GCC && GCC_VERSION >=3D 120100 || \
> > > +		   AS_IS_GNU && AS_VERSION >=3D 23800
> >=20
> > GCC_VERSION will be 0 for clang, so you don't need the CC_IS_GCC check.
> > With that change, this should be able to stay on one line:
> >=20
> >     depends on GCC_VERSION >=3D 120100 || (AS_IS_GNU && AS_VERSION >=3D=
 23800)
> >=20
> > >  	help
> > >  	  Newer binutils versions default to ISA spec version 20191213 which
> > >  	  moves some instructions from the I extension to the Zicsr and Zif=
encei
> > >  	  extensions.
> > > +	  Similarly, GCC release 12.1.0 has changed the default ISA spec ve=
rsion to
> > > +	  20191213, so the above situation requires this option to be enabl=
ed.
> > > =20
> > >  config TOOLCHAIN_NEEDS_OLD_ISA_SPEC
> > >  	def_bool y
> > > --=20
> > > 2.34.1
> > >=20
>=20



--wbqao3EI+HlRxhpT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMBJ9gAKCRB4tDGHoIJi
0qeNAP4mSuiAlr4Pcp2s+H+szGA0GA9tA9eZ/dRHP4a++kKhUgEA8Qao1BY7Wrz7
eFheXgfMBbWuisdUrk9Fs9paJOWyPgI=
=4CKF
-----END PGP SIGNATURE-----

--wbqao3EI+HlRxhpT--
