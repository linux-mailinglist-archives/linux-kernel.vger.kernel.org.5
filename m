Return-Path: <linux-kernel+bounces-140369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4B28A1374
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62BA928B090
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DA914600F;
	Thu, 11 Apr 2024 11:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="NGhTb9Nf"
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E5214A094;
	Thu, 11 Apr 2024 11:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712835908; cv=none; b=uraZuBejrgAq4yCvRbR5GwV2y05preUbRPABqAsw6qrioWJVVBRMICIc5/dLM//2xP1HFCAT1wXmfgf5jDfcVjtvGJ0pEFCAjZMOOElt/iRWtKlV4OiotGDXD5gmpHWcNxR+EfnRZ5Qb7DLPjmWdGzDZVtbgpILyIqYtOq6ph3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712835908; c=relaxed/simple;
	bh=qCDSus5YNduz2h1Rhb147hdJTvCGFy6KhUQdb2RuEHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmlXk4MxmfIHuRt9lBAZXlkTMEnzI/63hKZFWaEM751bhFwJVdr3Zj1Y3nZ0pcUPKIKRK6teX8vubiAUN57U0L3fDgHn6OhrSozGGtCoxWcsle7wIuF+VzcuS1A+TtEyGXFKEZ1fPGMgknDWP6I0/xr1uH77mgLgvLBH/OwP/Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=NGhTb9Nf; arc=none smtp.client-ip=212.42.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1712835499; bh=qCDSus5YNduz2h1Rhb147hdJTvCGFy6KhUQdb2RuEHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NGhTb9NfmhdEp+hiJ0aBg4lmaStWiewCFWqExP+W24yvQXsXjNzO6rnCFhvZsKOXM
	 vujFeiQ6Iaw/d4Ylfs8NOieHXz9D8Gzwu7KaRD3ghr/lM+L0tx9eLnGWtQ6f2Uifao
	 ZSHVQZOUIDLsKWwaV37uqwpFrMcBtCabcY0mSkGQ=
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Thu, 11 Apr 2024 13:38:19 +0200 (CEST)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id EEE60803A3;
	Thu, 11 Apr 2024 13:38:20 +0200 (CEST)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
	id E1D5A18AEFF; Thu, 11 Apr 2024 13:38:20 +0200 (CEST)
Date: Thu, 11 Apr 2024 13:38:20 +0200
From: Nicolas Schier <n.schier@avm.de>
To: Valerii Chernous <vchernou@cisco.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, xe-linux-external@cisco.com,
	Jonathan Corbet <corbet@lwn.net>, linux-kbuild@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Add MO(mod objs) variable to process ext modules with
 subdirs
Message-ID: <ZhfLrGrED-ls6i5V@buildd.core.avm.de>
References: <20240405165610.1537698-1-vchernou@cisco.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I/NuHrpz0C8dGhJA"
Content-Disposition: inline
In-Reply-To: <20240405165610.1537698-1-vchernou@cisco.com>
X-purgate-ID: 149429::1712835499-1A7BAE9F-2A5DA3E2/0/0
X-purgate-type: clean
X-purgate-size: 11719
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean


--I/NuHrpz0C8dGhJA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Valerii,

thanks for your patch.  I know several non-upstream kernel developers
that would like to see support for out-of-source builds of external
kmods (and we developed several work-arounds at AVM as well); but please
be aware that patches that don't fix or enhance the in-tree kernel/kmod
build but only add feature for out-of-tree stuff, are rarely accepted.

(Rational: better upstream your kmods to have them in-tree, especially
if they are so complex that they need subdirs.)

That said, I'll try to give some more concrete feedback below.

On Fri, Apr 05, 2024 at 09:56:08AM -0700, Valerii Chernous wrote:
> The change allow to build external modules with nested makefiles.

better use imperative statements to the code itself:  "Allow to build..."

Does "nested makefile" mean that you want to support external kernel
modules with subdirs and Makefiles within?

> With current unofficial way(using "src" variable) it is possible to build
> external(out of tree) kernel module with separate source and build
> artifacts dirs but with nested makefiles it doesn't work properly.
> Build system trap to recursion inside makefiles, artifacts output dir
> path grow with each iteration until exceed max path len and build failed.

I think I know what you want to say with this sentence, but I am not
able to parse it correctly.  Might you want to rephrase it a bit?

> Providing "MO" variable and using "override" directive with declaring
> "src" variable solves the problem
> Usage example:
> make -C KERNEL_SOURCE_TREE MO=3DBUILD_OUT_DIR M=3DEXT_MOD_SRC_DIR modules
>=20
> Cc: xe-linux-external@cisco.com
> Cc: Valerii Chernous <vchernou@cisco.com>
> Signed-off-by: Valerii Chernous <vchernou@cisco.com>
> ---
>  Documentation/kbuild/kbuild.rst  | 14 +++++++++++++-
>  Documentation/kbuild/modules.rst | 16 +++++++++++++++-
>  Makefile                         | 17 +++++++++++++++++
>  scripts/Makefile.build           |  7 +++++++
>  4 files changed, 52 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuil=
d.rst
> index 9c8d1d046ea5..81413ddba2ad 100644
> --- a/Documentation/kbuild/kbuild.rst
> +++ b/Documentation/kbuild/kbuild.rst
> @@ -121,10 +121,22 @@ Setting "V=3D..." takes precedence over KBUILD_VERB=
OSE.
>  KBUILD_EXTMOD
>  -------------
>  Set the directory to look for the kernel source when building external
> -modules.
> +modules. In case of using separate sources and module artifacts director=
ies
> +(KBUILD_EXTMOD + KBUILD_EXTMOD_SRC), KBUILD_EXTMOD working as output
> +artifacts directory.

That means, iff you use KBUILD_EXTMOD_SRC and let KBUILD_EXTMOD point to
some other directory, you _have_ to be sure that your kernel supported
KBUILD_EXTMOD_SRC properly or your module will not be build at all,
right?

> =20
>  Setting "M=3D..." takes precedence over KBUILD_EXTMOD.
> =20
> +KBUILD_EXTMOD_SRC
> +-----------------
> +Set the external module source directory in case when separate module
> +sources and build artifacts directories are used. Working in pair with
> +KBUILD_EXTMOD. If KBUILD_EXTMOD_SRC is set then KBUILD_EXTMOD is used as
> +module build artifacts directory.
> +
> +Setting "MO=3D..." takes precedence over KBUILD_EXTMOD.
> +Setting "M=3D..." takes precedence over KBUILD_EXTMOD_SRC.

(Just a note, not a complaint: This confused me while reading it the
first time, but I think it is correct for your patch.  Personally, I do
not like the semantical change of KBUILD_EXTMOD/M and would rather
prefer the introduction of some more explicit names like
KBUILD_EXTMOD_SOURCE and KBUILD_EXTMOD_BUILD instead.)

> +
>  KBUILD_OUTPUT
>  -------------
>  Specify the output directory when building the kernel.
> diff --git a/Documentation/kbuild/modules.rst b/Documentation/kbuild/modu=
les.rst
> index a1f3eb7a43e2..b6c30e76b314 100644
> --- a/Documentation/kbuild/modules.rst
> +++ b/Documentation/kbuild/modules.rst
> @@ -79,6 +79,14 @@ executed to make module versioning work.
>  	The kbuild system knows that an external module is being built
>  	due to the "M=3D<dir>" option given in the command.
> =20
> +	To build an external module with separate src and artifacts dirs use::
> +
> +		$ make -C <path_to_kernel_src> M=3D$PWD MO=3D<output_dir>

Is it really good to evaluate MO relative to the kernel source or build tre=
e?

    make -C /lib/modules/$(uname -r)/build M=3D/somewhere/source MO=3D../bu=
ild

might accidentially lead to ugly inconsistencies in the kernel build
tree (permissions presumed).

> +
> +	The kbuild system knows that an external module with separate sources
> +	and build artifacts dirs is being built due to the "M=3D<dir>" and
> +	"MO=3D<output_dir>" options given in the command.
> +
>  	To build against the running kernel use::
> =20
>  		$ make -C /lib/modules/`uname -r`/build M=3D$PWD
> @@ -93,7 +101,7 @@ executed to make module versioning work.
> =20
>  	($KDIR refers to the path of the kernel source directory.)
> =20
> -	make -C $KDIR M=3D$PWD
> +	make -C $KDIR M=3D$PWD MO=3D<module_output_dir>
> =20
>  	-C $KDIR
>  		The directory where the kernel source is located.
> @@ -106,6 +114,12 @@ executed to make module versioning work.
>  		directory where the external module (kbuild file) is
>  		located.
> =20
> +	MO=3D<module_output_dir>
> +		Informs kbuild that external module build artifacts
> +		should be placed into specific dir(<module_output_dir>).

What about "should be placed into the specified directory <module_output_di=
r>." ?

> +		Parameter is optional. Without it "M" works as both
> +		source provider and build output location.
> +
>  2.3 Targets
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> diff --git a/Makefile b/Makefile
> index 4bef6323c47d..3d45a41737a6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -142,6 +142,7 @@ ifeq ("$(origin M)", "command line")
>    KBUILD_EXTMOD :=3D $(M)
>  endif
> =20
> +define kbuild_extmod_check_TEMPLATE
>  $(if $(word 2, $(KBUILD_EXTMOD)), \
>  	$(error building multiple external modules is not supported))
> =20
> @@ -152,9 +153,25 @@ $(foreach x, % :, $(if $(findstring $x, $(KBUILD_EXT=
MOD)), \
>  ifneq ($(filter %/, $(KBUILD_EXTMOD)),)
>  KBUILD_EXTMOD :=3D $(shell dirname $(KBUILD_EXTMOD).)
>  endif
> +endef
> +$(eval $(call kbuild_extmod_check_TEMPLATE))

Same checks make sense for KBUILD_EXTMOD_SRC, also if MO is not set.

> =20
>  export KBUILD_EXTMOD
> =20
> +# Use make M=3Dsrc_dir MO=3Dko_dir or set the environment variables:
> +# KBUILD_EXTMOD_SRC, KBUILD_EXTMOD to specify separate directories of
> +# external module sources and build artifacts.
> +ifeq ("$(origin MO)", "command line")
> +ifeq ($(KBUILD_EXTMOD),)
> +	$(error Ext module objects without module sources is not supported))
> +endif
> +KBUILD_EXTMOD_SRC :=3D $(KBUILD_EXTMOD)
> +KBUILD_EXTMOD :=3D $(MO)
> +$(eval $(call kbuild_extmod_check_TEMPLATE))
> +endif
> +
> +export KBUILD_EXTMOD_SRC
> +
>  # backward compatibility
>  KBUILD_EXTRA_WARN ?=3D $(KBUILD_ENABLE_EXTRA_GCC_CHECKS)
> =20
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index baf86c0880b6..a293950e2e07 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -3,7 +3,14 @@
>  # Building
>  # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> =20
> +ifeq ($(KBUILD_EXTMOD_SRC),)
>  src :=3D $(obj)

I would leave the 'src :=3D $(obj)' stand alone unconditionally, to
clearly separate the oot-oos-kmod support from default in-tree kernel or
kmod builds and in-source but out-of-tree kmod builds.

> +else ifeq ($(KBUILD_EXTMOD),$(obj))
> +override src :=3D $(KBUILD_EXTMOD_SRC)
> +else
> +src_subdir :=3D $(patsubst $(KBUILD_EXTMOD)/%,%,$(obj))
> +override src :=3D $(KBUILD_EXTMOD_SRC)/$(src_subdir)

bike-shedding:  see below

> +endif
> =20
>  PHONY :=3D $(obj)/
>  $(obj)/:
> --=20
> 2.35.6
>=20

Testing with a simple module w/ subdir, compilation fails for me:

    $ make M=3D../stupid-multidir-kmod/source V=3D2 MO=3D/tmp/build
      CC [M]  /tmp/build/subdir/module.o - due to target missing
      CC [M]  /tmp/build/hello.o - due to target missing
    scripts/Makefile.modpost:118: /tmp/build/Makefile: No such file or dire=
ctory
    make[2]: *** No rule to make target '/tmp/build/Makefile'.  Stop.
    make[1]: *** [/data/linux/oot-kmods-MO/Makefile:1897: modpost] Error 2
    make: *** [Makefile:257: __sub-make] Error 2

(similar for 'make clean'.)
The test kbuild files were as simple as:

=2E../source/Kbuild:
    obj-m +=3D subdir/
    obj-m +=3D hello.o

=2E../source/subdir/Kbuild:
    obj-m +=3D module.o

Does something like this work for you?  If I understand your proposed
commit message correctly, you have some working example with subdirs?

---

Bike-shedding for inspiration:

While experimenting with similar solutions at AVM, we did the same src
override but also auto-generated dummy Makefiles in $(obj) with something
like:

    ifneq ($(if $(KBUILD_EXTMOD_SRC),$(filter $(KBUILD_EXTMOD)%,$(obj))),)
    # If KBUILD_EXTMOD_SOURCE is set, enable out-of-source kmod build
    # support, in general.  But do not disturb the kbuild preparing targets
    # that need the original behaviour.
    #
    # Thus, iff also $(obj) is set and points to some path at $(KBUILD_EXTM=
OD) or
    # below, we really want to set (override) $(src).

    override src :=3D $(obj:$(KBUILD_EXTMOD)%=3D$(KBUILD_EXTMOD_SRC)%)

    # Generate or update $(obj)/Makefile to include the original $(src)/Kbu=
ild or
    # $(src)/Makefile.
   =20
    _kbuild_extmod_src_makefile =3D $(firstword $(wildcard $(src)/Kbuild $(=
src)/Makefile))
   =20
    $(lastword $(MAKEFILE_LIST)): $(obj)/Makefile
   =20
    $(obj)/Makefile: $(_kbuild_extmod_src_makefile) FORCE
    	$(call filechk,build_makefile)
   =20
    $(eval filechk_build_makefile =3D echo include $(_kbuild_extmod_src_mak=
efile))
   =20
    # Clean-up the variable space
    undefine $(filter _kbuild_extmod_%,$(.VARIABLES))

    endif

but we still had to add a dependency on $(subdir-ym) for all object
files in any kmod subdir to enforce proper dependency handling.
Fortunately, we almost stopped using such "enhanced" oot-oos kmod build
things.

HTH,
kind regards,
Nicolas

--I/NuHrpz0C8dGhJA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEDv+Fiet06YHnC6RpiMa8nIiabbgFAmYXy6oACgkQiMa8nIia
bbjxJA/+N62wUl4lNCKbpN2Psg1rd0R8d/QddpACJ+No2cnkASz2xR/FeTTCws6i
8NJFJbUH/qzNWM1qcX2ksfc/l2w1t6U9LhdQZSJOgu7vnJ6gFIZgO1GFsYLPKmsZ
HYSCEVObwBQ8YRRK9KrN8s+1pzy+PNnGUgACM7cjIAp0UBE7xGiumto1WE59Oa0z
LRaQllafayljG1OglnSI5EIEGNp7e0RUXOR5GSkoaz9nSNm0udvEiJscwbaKDnL0
uwrCNDtQA2da+VY2XgFoIg6uQFmIT+ZqUBf9q9GMx1JZKa6wIEwSp83xbhl5jktS
LPzKIioHxtvYmkEq6FC9xqZ63707czZoTaN+/cpHp6jBeD0kdwYyVfOni8Ll7o8a
V04spksT6kVAbzElprAklo5RECSJLJHt1ofkeNoeZrdBAJbdS9BQIaPTGv43SXBM
VvnlQdj6r4vtd/jEAUicpmtSfKaYl6pu30kJNRLxAwc7EPSzGik9E4Uj/hePAoTy
tCGcpatNYapoeELlnTR+rnl3F61hfpldxyn4LF96W5m8LZ2DeYgym2dPXC0bRZBv
Ps0U8qR+3YAzcMSLvN3B4L+EOMu8LWXwnshXzexRCUUfa08DafNAv8dF5UN6GD73
enZUytr6UeZ/fD/nKkdGc6wBIo2G9aeERnuKJUMePpMf+xVvBgk=
=Dr/I
-----END PGP SIGNATURE-----

--I/NuHrpz0C8dGhJA--

