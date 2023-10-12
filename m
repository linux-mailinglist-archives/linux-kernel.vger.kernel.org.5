Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170D27C728F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379557AbjJLQ3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379548AbjJLQ3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:29:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7A2C6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:29:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF45DC433C8;
        Thu, 12 Oct 2023 16:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697128145;
        bh=xC1mXzF5lAfu+5mYdskcnzIaGOnEiU3VFyASPrevtvM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c8hiXaZkCKatUJz1/0qcqXp9WjyV9gsXMVJhwv86zU3SI6zdV/iMxXdLsKNc9kK3+
         q7X27RY9b7xvJvqs5I0rFU12CvrqqmntOs5YPoK+1ZwJxSKEw9NK5UebFYY2W4FkaX
         i5Q6Km5oF8qcuOE2JyYCGBL7Aa55DtRe4P4m5FgUJrOW3o/XSQvgO6ZFph/Ro7DGFh
         EPsP4boudy0CMEXgfbCw2kchk3MChRJM9MUPpGuBlDccG+23Aggc5I5GMk442yD6/b
         OEWNEhLJ+p0umZHy1lmWDApEM2EaT7w+nz38OxJ5dI5w47HuKm0MiQKr24lpV37q6u
         zuGqqqvg68ReA==
Date:   Thu, 12 Oct 2023 17:29:00 +0100
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
Message-ID: <20231012-acorn-recast-8e6bf08aac2a@spud>
References: <20231011111438.909552-1-cleger@rivosinc.com>
 <20231011111438.909552-3-cleger@rivosinc.com>
 <b157edc4-a21f-40ac-8c9f-e989b34bb872@rivosinc.com>
 <20231012-darkness-neutron-fc1843ff05ff@spud>
 <7b71ff39-bbc0-4ba9-8b98-d36fa127316e@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uhGoIgzh+d9/m8Ni"
Content-Disposition: inline
In-Reply-To: <7b71ff39-bbc0-4ba9-8b98-d36fa127316e@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uhGoIgzh+d9/m8Ni
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Thu, Oct 12, 2023 at 05:15:45PM +0200, Cl=E9ment L=E9ger wrote:
> On 12/10/2023 16:10, Conor Dooley wrote:
> > On Thu, Oct 12, 2023 at 03:17:14PM +0200, Cl=E9ment L=E9ger wrote:
> >> On 11/10/2023 13:14, Cl=E9ment L=E9ger wrote:
> >>> Add probing of some Zv* ISA extensions that are mentioned in "RISC-V
> >>> Cryptography Extensions Volume II" [1]. These ISA extensions are the
> >>> following:
> >>>
> >>> - Zvbb: Vector Basic Bit-manipulation
> >>> - Zvbc: Vector Carryless Multiplication
> >>> - Zvkb: Vector Cryptography Bit-manipulation
> >>> - Zvkg: Vector GCM/GMAC.
> >>> - Zvkned: NIST Suite: Vector AES Block Cipher
> >>> - Zvknh[ab]: NIST Suite: Vector SHA-2 Secure Hash
> >>> - Zvksed: ShangMi Suite: SM4 Block Cipher
> >>> - Zvksh: ShangMi Suite: SM3 Secure Hash
> >>> - Zvkn: NIST Algorithm Suite
> >>> - Zvknc: NIST Algorithm Suite with carryless multiply
> >>> - Zvkng: NIST Algorithm Suite with GCM.
> >>> - Zvks: ShangMi Algorithm Suite
> >>> - Zvksc: ShangMi Algorithm Suite with carryless multiplication
> >>> - Zvksg: ShangMi Algorithm Suite with GCM.
> >>> - Zvkt: Vector Data-Independent Execution Latency.
> >>>
> >>> [1] https://drive.google.com/file/d/1gb9OLH-DhbCgWp7VwpPOVrrY6f3oSJLL=
/view
> >>>
> >>> Signed-off-by: Cl=E9ment L=E9ger <cleger@rivosinc.com>
> >>> ---
> >>>  arch/riscv/include/asm/hwcap.h | 16 ++++++++++++++++
> >>>  arch/riscv/kernel/cpufeature.c | 16 ++++++++++++++++
> >>>  2 files changed, 32 insertions(+)
> >>>
> >>> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/=
hwcap.h
> >>> index b7b58258f6c7..4e46981ac6c8 100644
> >>> --- a/arch/riscv/include/asm/hwcap.h
> >>> +++ b/arch/riscv/include/asm/hwcap.h
> >>> @@ -58,6 +58,22 @@
> >>>  #define RISCV_ISA_EXT_ZICSR		40
> >>>  #define RISCV_ISA_EXT_ZIFENCEI		41
> >>>  #define RISCV_ISA_EXT_ZIHPM		42
> >>> +#define RISCV_ISA_EXT_ZVBB		43
> >>> +#define RISCV_ISA_EXT_ZVBC		44
> >>> +#define RISCV_ISA_EXT_ZVKB		45
> >>> +#define RISCV_ISA_EXT_ZVKG		46
> >>> +#define RISCV_ISA_EXT_ZVKN		47
> >>> +#define RISCV_ISA_EXT_ZVKNC		48
> >>> +#define RISCV_ISA_EXT_ZVKNED		49
> >>> +#define RISCV_ISA_EXT_ZVKNG		50
> >>> +#define RISCV_ISA_EXT_ZVKNHA		51
> >>> +#define RISCV_ISA_EXT_ZVKNHB		52
> >>> +#define RISCV_ISA_EXT_ZVKS		53
> >>> +#define RISCV_ISA_EXT_ZVKSC		54
> >>> +#define RISCV_ISA_EXT_ZVKSED		55
> >>> +#define RISCV_ISA_EXT_ZVKSH		56
> >>> +#define RISCV_ISA_EXT_ZVKSG		57
> >>
> >> About Zvks/Zvkn, these extensions are actually shorthand for a few oth=
er
> >> sub-extensions, it is still not clear if it should be parsed as is.
> >> There are multiple solutions:
> >>
> >> - Handle them as-is, simply enable the extension, if reported through
> >> hwprobe, userspace will be responsible to detect the sub-extensions
> >> (current approach)
> >=20
> > I dislike this, since in-kernel users will have to check for "parent" &
> > "child" extensions.
> >=20
> >> - "Unfold" the extension in order to enable all the sub-extensions and
> >> keep the main one (for instance for Zvkn, enable Zvkned, Zvknhb, Zvkb,
> >> Zvkt, Zvkn)
> >=20
> > We threw together some code for this a few months ago after some
> > discussion with some of your Rivos colleagues. The initial version of it
> > was in this thread with Evan:
> > https://lore.kernel.org/all/20230703-mangle-panning-75909ebbe30c@spud/
> > and in a later iteration there was some more done by myself and Drew:
> > https://lore.kernel.org/all/20230713-bootleg-tray-c5bfe58b5673@wendy/
> > One of the versions ended up as the riscv-extensions-strings-scalar-cry=
pto
> > branch in my k.org repo:
> > https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/log/?h=
=3Driscv-extensions-strings-scalar-crypto
> >=20
>=20
> Thanks for these information ! I think your version to handle extension
> group is pretty clean. Are you waiting for anything in particular except
> a Signed-off: from Evan to submit that patch ?

Lack of a user. I was hoping that it'd go alongside the crypto extension
stuff that needed it.

> If so, can I backport
> this patch in my branch, gather Evan SoB and rebase my series on top of i=
t ?

For sure.

> > That crypto stuff has all gone quiet of late unfortunately. I wonder if
> > Samuel is still working on it.
>=20
> I talked with Samuel and we agreed on the following plan: I'll actually
> carry on the bitmanip ISA part and he will resubmit the Zkr with
> archrandom part.

:+1:

> >> - "Unfold" but don't keep the extension "shorthand" in the ISA extensi=
on
> >> list (for instance for Zvkn, enable Zvkned, Zvknhb, Zvkb, Zvkt)
> >=20
> > But I would also be fine with this one from a pure in-kernel PoV.
>=20
> Which is the case with your version FWIU (ie, only the child extensions
> are visible).

Yeah, I think I might've done it intentionally so that the same thing
appeared in /proc/cpuinfo whether the "parent" or all the "children"
were provided in DT.

(I wrote that stuff before hwprobe got merge I think)

I think users would probably appreciate being able to poll for the whole
extension, rather than the component parts. There's probably also some
thoughts expressed in the two threads I linked, IIRC Evan and I did
discuss some of the behaviour there. What to do if an extension later
grows a subset springs to mind.

Conor.

> > I think it's likely to be annoying for users though, since they won't be
> > able to poll for the "parent" unless we re-assemble the parents in
> > hwprobe etc (eugh).
>=20
> Indeed, and re-assembling the parent is IMHO duplication of the existing
> information. Checking that the needed ISA extensions are present will be
> simple enough (simple bitmask) so I'm not sure that re-assembling the
> parents is necessary (But that's a personal statement and I'm pretty
> sure others will like it to be provided directly).
>=20
> Thanks,
>=20
> Cl=E9ment
>=20
> >=20
> > - don't permit passing the "parents" at all, and only deal with the
> >   "children". We can enforce this for DT, but not for ACPI, so probably
> >   not a runner>
> > Thanks,
> > Conor.
> >=20
> >>
> >> Thanks,
> >>
> >> Cl=E9ment
> >>
> >>> +#define RISCV_ISA_EXT_ZVKT		58
> >>> =20
> >>>  #define RISCV_ISA_EXT_MAX		64
> >>> =20
> >>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufe=
ature.c
> >>> index 1cfbba65d11a..859d647f3ced 100644
> >>> --- a/arch/riscv/kernel/cpufeature.c
> >>> +++ b/arch/riscv/kernel/cpufeature.c
> >>> @@ -174,6 +174,22 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =
=3D {
> >>>  	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
> >>>  	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
> >>>  	__RISCV_ISA_EXT_DATA(zbs, RISCV_ISA_EXT_ZBS),
> >>> +	__RISCV_ISA_EXT_DATA(zvbb, RISCV_ISA_EXT_ZVBB),
> >>> +	__RISCV_ISA_EXT_DATA(zvbc, RISCV_ISA_EXT_ZVBC),
> >>> +	__RISCV_ISA_EXT_DATA(zvkb, RISCV_ISA_EXT_ZVKB),
> >>> +	__RISCV_ISA_EXT_DATA(zvkg, RISCV_ISA_EXT_ZVKG),
> >>> +	__RISCV_ISA_EXT_DATA(zvkn, RISCV_ISA_EXT_ZVKN),
> >>> +	__RISCV_ISA_EXT_DATA(zvknc, RISCV_ISA_EXT_ZVKNC),
> >>> +	__RISCV_ISA_EXT_DATA(zvkned, RISCV_ISA_EXT_ZVKNED),
> >>> +	__RISCV_ISA_EXT_DATA(zvkng, RISCV_ISA_EXT_ZVKNG),
> >>> +	__RISCV_ISA_EXT_DATA(zvknha, RISCV_ISA_EXT_ZVKNHA),
> >>> +	__RISCV_ISA_EXT_DATA(zvknhb, RISCV_ISA_EXT_ZVKNHB),
> >>> +	__RISCV_ISA_EXT_DATA(zvks, RISCV_ISA_EXT_ZVKS),
> >>> +	__RISCV_ISA_EXT_DATA(zvksc, RISCV_ISA_EXT_ZVKSC),
> >>> +	__RISCV_ISA_EXT_DATA(zvksed, RISCV_ISA_EXT_ZVKSED),
> >>> +	__RISCV_ISA_EXT_DATA(zvksh, RISCV_ISA_EXT_ZVKSH),
> >>> +	__RISCV_ISA_EXT_DATA(zvksg, RISCV_ISA_EXT_ZVKSG),
> >>> +	__RISCV_ISA_EXT_DATA(zvkt, RISCV_ISA_EXT_ZVKT),
> >>>  	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
> >>>  	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
> >>>  	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),

--uhGoIgzh+d9/m8Ni
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSgezAAKCRB4tDGHoIJi
0ubjAP43eYhqzD82t+pnhUwaKxv5boakeo7y/NYW2K0ObKQgxAEA9V/ihngeUMeC
5NKv42ygzuK0/RP4Kf6+Vm39rMg3YQ0=
=J32f
-----END PGP SIGNATURE-----

--uhGoIgzh+d9/m8Ni--
