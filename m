Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9907C7014
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 16:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344026AbjJLOKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 10:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbjJLOKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 10:10:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC787B8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 07:10:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59DCC433C7;
        Thu, 12 Oct 2023 14:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697119837;
        bh=2m3qCjrM+NiNRx2As2rElKCckeox74lUhZInEdqnQCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xe2vfhDWz+FtfxIuna/6YeyyPxTzM2/tPKDtTRM1fFdkXAWFN2+Gm11BeefKmho9X
         pm1y1dW11Xl5W+XOnEbYwzId9b1pRt9mFjgdoObyyxFK5rC4wiWKAgW7TCyOx5kGTS
         DW8HsPurpkvmIPduanNuyfT4kzCeIo4FYbDNEF+4D1NjEQPWA18kZ63Bv5gbLXfh6+
         LUw/tFLAFqlTenKAbBCu0pkETyvBluewhRmu0yHMVkHTZ8LUCV+jrWbsMlNdmDPLbN
         UZVZYNFrjR5QC8gkPlywin7D+4/Sil7ydR/94ihtZmeoOpBOwGIUhM3gy1PkvGtO6b
         dAKEIaqtkhv1Q==
Date:   Thu, 12 Oct 2023 15:10:32 +0100
From:   Conor Dooley <conor@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>
Subject: Re: [PATCH v1 02/13] riscv: add ISA extension probing for Zv*
 extensions
Message-ID: <20231012-darkness-neutron-fc1843ff05ff@spud>
References: <20231011111438.909552-1-cleger@rivosinc.com>
 <20231011111438.909552-3-cleger@rivosinc.com>
 <b157edc4-a21f-40ac-8c9f-e989b34bb872@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b7OVUUsPLQqJTLWk"
Content-Disposition: inline
In-Reply-To: <b157edc4-a21f-40ac-8c9f-e989b34bb872@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b7OVUUsPLQqJTLWk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 03:17:14PM +0200, Cl=E9ment L=E9ger wrote:
>=20
>=20
> On 11/10/2023 13:14, Cl=E9ment L=E9ger wrote:
> > Add probing of some Zv* ISA extensions that are mentioned in "RISC-V
> > Cryptography Extensions Volume II" [1]. These ISA extensions are the
> > following:
> >=20
> > - Zvbb: Vector Basic Bit-manipulation
> > - Zvbc: Vector Carryless Multiplication
> > - Zvkb: Vector Cryptography Bit-manipulation
> > - Zvkg: Vector GCM/GMAC.
> > - Zvkned: NIST Suite: Vector AES Block Cipher
> > - Zvknh[ab]: NIST Suite: Vector SHA-2 Secure Hash
> > - Zvksed: ShangMi Suite: SM4 Block Cipher
> > - Zvksh: ShangMi Suite: SM3 Secure Hash
> > - Zvkn: NIST Algorithm Suite
> > - Zvknc: NIST Algorithm Suite with carryless multiply
> > - Zvkng: NIST Algorithm Suite with GCM.
> > - Zvks: ShangMi Algorithm Suite
> > - Zvksc: ShangMi Algorithm Suite with carryless multiplication
> > - Zvksg: ShangMi Algorithm Suite with GCM.
> > - Zvkt: Vector Data-Independent Execution Latency.
> >=20
> > [1] https://drive.google.com/file/d/1gb9OLH-DhbCgWp7VwpPOVrrY6f3oSJLL/v=
iew
> >=20
> > Signed-off-by: Cl=E9ment L=E9ger <cleger@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/hwcap.h | 16 ++++++++++++++++
> >  arch/riscv/kernel/cpufeature.c | 16 ++++++++++++++++
> >  2 files changed, 32 insertions(+)
> >=20
> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hw=
cap.h
> > index b7b58258f6c7..4e46981ac6c8 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -58,6 +58,22 @@
> >  #define RISCV_ISA_EXT_ZICSR		40
> >  #define RISCV_ISA_EXT_ZIFENCEI		41
> >  #define RISCV_ISA_EXT_ZIHPM		42
> > +#define RISCV_ISA_EXT_ZVBB		43
> > +#define RISCV_ISA_EXT_ZVBC		44
> > +#define RISCV_ISA_EXT_ZVKB		45
> > +#define RISCV_ISA_EXT_ZVKG		46
> > +#define RISCV_ISA_EXT_ZVKN		47
> > +#define RISCV_ISA_EXT_ZVKNC		48
> > +#define RISCV_ISA_EXT_ZVKNED		49
> > +#define RISCV_ISA_EXT_ZVKNG		50
> > +#define RISCV_ISA_EXT_ZVKNHA		51
> > +#define RISCV_ISA_EXT_ZVKNHB		52
> > +#define RISCV_ISA_EXT_ZVKS		53
> > +#define RISCV_ISA_EXT_ZVKSC		54
> > +#define RISCV_ISA_EXT_ZVKSED		55
> > +#define RISCV_ISA_EXT_ZVKSH		56
> > +#define RISCV_ISA_EXT_ZVKSG		57
>=20
> About Zvks/Zvkn, these extensions are actually shorthand for a few other
> sub-extensions, it is still not clear if it should be parsed as is.
> There are multiple solutions:
>=20
> - Handle them as-is, simply enable the extension, if reported through
> hwprobe, userspace will be responsible to detect the sub-extensions
> (current approach)

I dislike this, since in-kernel users will have to check for "parent" &
"child" extensions.

> - "Unfold" the extension in order to enable all the sub-extensions and
> keep the main one (for instance for Zvkn, enable Zvkned, Zvknhb, Zvkb,
> Zvkt, Zvkn)

We threw together some code for this a few months ago after some
discussion with some of your Rivos colleagues. The initial version of it
was in this thread with Evan:
https://lore.kernel.org/all/20230703-mangle-panning-75909ebbe30c@spud/
and in a later iteration there was some more done by myself and Drew:
https://lore.kernel.org/all/20230713-bootleg-tray-c5bfe58b5673@wendy/
One of the versions ended up as the riscv-extensions-strings-scalar-crypto
branch in my k.org repo:
https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/log/?h=3Dri=
scv-extensions-strings-scalar-crypto

That crypto stuff has all gone quiet of late unfortunately. I wonder if
Samuel is still working on it.

> - "Unfold" but don't keep the extension "shorthand" in the ISA extension
> list (for instance for Zvkn, enable Zvkned, Zvknhb, Zvkb, Zvkt)

But I would also be fine with this one from a pure in-kernel PoV.
I think it's likely to be annoying for users though, since they won't be
able to poll for the "parent" unless we re-assemble the parents in
hwprobe etc (eugh).

- don't permit passing the "parents" at all, and only deal with the
  "children". We can enforce this for DT, but not for ACPI, so probably
  not a runner.

Thanks,
Conor.

>=20
> Thanks,
>=20
> Cl=E9ment
>=20
> > +#define RISCV_ISA_EXT_ZVKT		58
> > =20
> >  #define RISCV_ISA_EXT_MAX		64
> > =20
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeat=
ure.c
> > index 1cfbba65d11a..859d647f3ced 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -174,6 +174,22 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =
=3D {
> >  	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
> >  	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
> >  	__RISCV_ISA_EXT_DATA(zbs, RISCV_ISA_EXT_ZBS),
> > +	__RISCV_ISA_EXT_DATA(zvbb, RISCV_ISA_EXT_ZVBB),
> > +	__RISCV_ISA_EXT_DATA(zvbc, RISCV_ISA_EXT_ZVBC),
> > +	__RISCV_ISA_EXT_DATA(zvkb, RISCV_ISA_EXT_ZVKB),
> > +	__RISCV_ISA_EXT_DATA(zvkg, RISCV_ISA_EXT_ZVKG),
> > +	__RISCV_ISA_EXT_DATA(zvkn, RISCV_ISA_EXT_ZVKN),
> > +	__RISCV_ISA_EXT_DATA(zvknc, RISCV_ISA_EXT_ZVKNC),
> > +	__RISCV_ISA_EXT_DATA(zvkned, RISCV_ISA_EXT_ZVKNED),
> > +	__RISCV_ISA_EXT_DATA(zvkng, RISCV_ISA_EXT_ZVKNG),
> > +	__RISCV_ISA_EXT_DATA(zvknha, RISCV_ISA_EXT_ZVKNHA),
> > +	__RISCV_ISA_EXT_DATA(zvknhb, RISCV_ISA_EXT_ZVKNHB),
> > +	__RISCV_ISA_EXT_DATA(zvks, RISCV_ISA_EXT_ZVKS),
> > +	__RISCV_ISA_EXT_DATA(zvksc, RISCV_ISA_EXT_ZVKSC),
> > +	__RISCV_ISA_EXT_DATA(zvksed, RISCV_ISA_EXT_ZVKSED),
> > +	__RISCV_ISA_EXT_DATA(zvksh, RISCV_ISA_EXT_ZVKSH),
> > +	__RISCV_ISA_EXT_DATA(zvksg, RISCV_ISA_EXT_ZVKSG),
> > +	__RISCV_ISA_EXT_DATA(zvkt, RISCV_ISA_EXT_ZVKT),
> >  	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
> >  	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
> >  	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),

--b7OVUUsPLQqJTLWk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSf+WAAKCRB4tDGHoIJi
0s0WAQCL8OnA1zlPz9E+NbhDx6Qf17jgLkMjdES0HSwn4DIMWwD/X9Kq36FWP9AH
77SyEtP/g54FdffvkkQbwaUFsjj3Tw8=
=+oZa
-----END PGP SIGNATURE-----

--b7OVUUsPLQqJTLWk--
