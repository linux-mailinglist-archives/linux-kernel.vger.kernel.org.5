Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82E37CD3E6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 08:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344429AbjJRGLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 02:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjJRGLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 02:11:08 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DBDF9;
        Tue, 17 Oct 2023 23:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697609463;
        bh=qB3Ha83vzVs0uN4/XnNQdQVWsHMaULkNTOJrWBasbG4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CiTKe3zMJIOCsRXE8xsQTfjFQAvETHmNaIQJlQ9bB47RZvtUtfPvn81VaNtCe3iBZ
         +mmdPNOIWdIOxBFO6nSF0t1o2U5mxR2OJ0kMDbJSNOtuDQl2sBnR65GahG+8G/ORdP
         qIm40h6NC/ASHKgZVSyLX/RtqZNCMDsDA3HrnMhsRef2cbmXIjT+VdLqJB/02uPdCS
         kbEUgusCPKDp+nonC70XUbABRK+eHW85hZP/GcI384BDMSRCO4g3QnrYaIa8P0Js5H
         vjRvOSagj7IqdVQF16ZiW0CyHYjMimPVA+QRGxJLnBO4MXpUgFfTrHJTjL4+bQdF7j
         XOKre8TtoQU8A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9L7q1zQvz4wbp;
        Wed, 18 Oct 2023 17:11:03 +1100 (AEDT)
Date:   Wed, 18 Oct 2023 17:11:01 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        soc@kernel.org
Subject: Re: Covering DT build in -next merge
Message-ID: <20231018171101.26b8dbcf@canb.auug.org.au>
In-Reply-To: <ZS7rlTZLr0m1OEv8@sirena.org.uk>
References: <ZS7rlTZLr0m1OEv8@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XKZDKnVq=yDSY_XGcsQaGHc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XKZDKnVq=yDSY_XGcsQaGHc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Tue, 17 Oct 2023 21:16:21 +0100 Mark Brown <broonie@kernel.org> wrote:
>
> I was wondering if it might be possible to add DTB builds for relevant
> architecutres to the -next merge checks (everything except x86 AFAIK)?
> Some current experience suggested to me that it might be helpful for
> bisecting problems found in testing, breakage building the DTBs causes
> hassle since where they're used in tree DTs are required to boot the
> kernel.
>=20
> At least for arm and arm64 the DT build is quick enough to be negligable
> in the context of building the kernel itself so hopefully it shouldn't
> add too much load to do this - it's just adding a 'make dtbs' (with
> appropriate cross build options) to the kernel build.

Ummm, arm builds (and many others) select CONFIG_OF_EARLY_FLATTREE (in
the case of arm, only if CONFIG_OF is set), and the top level Makefile
does this:

ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/boot/dts/),)
dtstree :=3D arch/$(SRCARCH)/boot/dts
endif

ifneq ($(dtstree),)
	.
	.
	.
ifdef CONFIG_OF_EARLY_FLATTREE
all: dtbs
endif

endif

So won't this be the same as doing a separate "make dtbs"?
--=20
Cheers,
Stephen Rothwell

--Sig_/XKZDKnVq=yDSY_XGcsQaGHc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUvdvUACgkQAVBC80lX
0GwkKQf+IWyF+mZXfIODoybrGBaxaP/eKxHuTHcfCWlF2bGBlIHVawjjisO7Y7en
XRSHKCHoch/OxrnXrxIj6o+nw0LPnkgwMDujuVrWAtz5dhgKpWpJI0S2WO6bpDj4
I6CBpp+X7Pe6PQ1U00vVkJX5UDCu4NaiUTy9VuoH/DPrTRf9Va9MzE0IetERz7Pt
3boOgJG1MNZMPnqEJY1LuKFdA1lVih6InH1Jc5B1H1hACAdTHOrlYiDdcqgSAFjV
XgbzrvcAedFeBZS/m9cXGDdWWLU8S4Kh9ifmqEeMMFRGMzzC0QQ6G4sNfwg8Ddsb
kandqhOvxPRl723cVC4SYRg5cdYp3w==
=5H1I
-----END PGP SIGNATURE-----

--Sig_/XKZDKnVq=yDSY_XGcsQaGHc--
