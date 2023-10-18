Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C548F7CE4BE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjJRRiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjJRRho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:37:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD92122
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:37:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1483BC433C8;
        Wed, 18 Oct 2023 17:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697650624;
        bh=oFj2hOD0FJcu+azHgKmYICzh2htgdd2Wv5h+L8tXxW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PGoxBFH7kFpGXuNXarPS4c99yt2NmcMHGAG61xiXgEWbuhSQUwdufy6ZcWmie//K6
         2jQuz48qza50itX3m+nM3m+zLLxqwx5TNu/1H8FtrTLZESdAtSePpowbxfuT5Som1/
         QPL/LCRRiN+oL3q8cCeBAmbndhX3IOgO4kT4U2yMaWE5XkgV9R+nRpulbZ124R93cJ
         ungaM9yiPw1lhiU37GjtiwsYnLFvTSZ0OBc7Sy8iwKvJ72tQYuRo9EIulRnA6DnKE0
         A219HIJQcfYQmv5RCfbfUtzRYWo0CbTk1gzcwIa6Ca9T1AZrZdCczZZ1/wFytbveoI
         7iGVvpM33p3iQ==
Date:   Wed, 18 Oct 2023 18:36:59 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Samuel Ortiz <sameo@rivosinc.com>
Subject: Re: [PATCH v2 01/19] riscv: hwprobe: factorize hwprobe ISA extension
 reporting
Message-ID: <20231018-flagpole-footpad-07a6228485f3@spud>
References: <20231017131456.2053396-1-cleger@rivosinc.com>
 <20231017131456.2053396-2-cleger@rivosinc.com>
 <CALs-HssL=wNwj9nRuZwpZhy1CB9p9-X=OqgwBw9zvgA7hA4fEg@mail.gmail.com>
 <20231018-scrap-bankable-a0f321d97a46@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cYWeMTHrHEjyZ4VV"
Content-Disposition: inline
In-Reply-To: <20231018-scrap-bankable-a0f321d97a46@spud>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cYWeMTHrHEjyZ4VV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 06:33:34PM +0100, Conor Dooley wrote:
> On Wed, Oct 18, 2023 at 10:24:15AM -0700, Evan Green wrote:
> > On Tue, Oct 17, 2023 at 6:15=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger=
@rivosinc.com> wrote:
> > >
> > > Factorize ISA extension reporting by using a macro rather than
> > > copy/pasting extension names. This will allow adding new extensions m=
ore
> > > easily.
> > >
> > > Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> > > ---
> > >  arch/riscv/kernel/sys_riscv.c | 32 ++++++++++++++++++--------------
> > >  1 file changed, 18 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_ri=
scv.c
> > > index 473159b5f303..e207874e686e 100644
> > > --- a/arch/riscv/kernel/sys_riscv.c
> > > +++ b/arch/riscv/kernel/sys_riscv.c
> > > @@ -145,20 +145,24 @@ static void hwprobe_isa_ext0(struct riscv_hwpro=
be *pair,
> > >         for_each_cpu(cpu, cpus) {
> > >                 struct riscv_isainfo *isainfo =3D &hart_isa[cpu];
> > >
> > > -               if (riscv_isa_extension_available(isainfo->isa, ZBA))
> > > -                       pair->value |=3D RISCV_HWPROBE_EXT_ZBA;
> > > -               else
> > > -                       missing |=3D RISCV_HWPROBE_EXT_ZBA;
> > > -
> > > -               if (riscv_isa_extension_available(isainfo->isa, ZBB))
> > > -                       pair->value |=3D RISCV_HWPROBE_EXT_ZBB;
> > > -               else
> > > -                       missing |=3D RISCV_HWPROBE_EXT_ZBB;
> > > -
> > > -               if (riscv_isa_extension_available(isainfo->isa, ZBS))
> > > -                       pair->value |=3D RISCV_HWPROBE_EXT_ZBS;
> > > -               else
> > > -                       missing |=3D RISCV_HWPROBE_EXT_ZBS;
> > > +#define CHECK_ISA_EXT(__ext)                                        =
           \
> > > +               do {                                                 =
           \
> > > +                       if (riscv_isa_extension_available(isainfo->is=
a, __ext)) \
> > > +                               pair->value |=3D RISCV_HWPROBE_EXT_##=
__ext;       \
> > > +                       else                                         =
           \
> > > +                               missing |=3D RISCV_HWPROBE_EXT_##__ex=
t;           \
> > > +               } while (false)
> > > +
> > > +               /*
> > > +                * Only use CHECK_ISA_EXT() for extensions which can =
be exposed
> > > +                * to userspace, regardless of the kernel's configura=
tion, as no
> > > +                * other checks, besides presence in the hart_isa bit=
map, are
> > > +                * made.
> >=20
> > This comment alludes to a dangerous trap, but I'm having trouble
> > understanding what it is.
>=20
> You cannot, for example, use this for communicating the presence of F or
> D, since they require a config option to be set before their use is
> safe.

Funnily enough, this comment is immediately contradicted by the vector
subset extensions, where these CHECK_ISA_EXT() macros are used wrapped
in has_vector(). The code looks valid to me, since has_vector() contains
the Kconfig check, but does fly in the face of this comment.

>=20
> > Perhaps some rewording to more explicitly
> > state the danger would be appropriate. Other than that:
> >=20
> > Reviewed-by: Evan Green <evan@rivosinc.com>



--cYWeMTHrHEjyZ4VV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTAXuwAKCRB4tDGHoIJi
0ssgAQCFsE/VyWSVFRI6XGd2p+Q+D0bkhT1pEi2sRvGHdVIbwAEAlRpXF0hcPhDv
uK+YFm8QJY4dKBMhZ6EtzbVoIv6ctA8=
=a1cl
-----END PGP SIGNATURE-----

--cYWeMTHrHEjyZ4VV--
