Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D1C7BCD07
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 09:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344487AbjJHHgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 03:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJHHgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 03:36:06 -0400
Received: from bues.ch (bues.ch [IPv6:2a01:138:9005::1:4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E712B9;
        Sun,  8 Oct 2023 00:36:01 -0700 (PDT)
Received: by bues.ch with esmtpsa (Exim 4.96)
        (envelope-from <m@bues.ch>)
        id 1qpOKS-0001K9-1j;
        Sun, 08 Oct 2023 09:35:55 +0200
Date:   Sun, 8 Oct 2023 09:35:20 +0200
From:   Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [RFC PATCH] ssb: relax SSB_EMBEDDED dependencies
Message-ID: <20231008093520.42ead15f@barney>
In-Reply-To: <20231007182443.32300-1-rdunlap@infradead.org>
References: <20231007182443.32300-1-rdunlap@infradead.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9PIyIezhhAqouq34xqM7bjm";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9PIyIezhhAqouq34xqM7bjm
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Randy,

thanks for the patch.

On Sat,  7 Oct 2023 11:24:43 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> This is a kconfig warning in a randconfig when CONFIG_PCI is not set:
>=20
> WARNING: unmet direct dependencies detected for SSB_EMBEDDED
>   Depends on [n]: SSB [=3Dy] && SSB_DRIVER_MIPS [=3Dy] &&
> SSB_PCICORE_HOSTMODE [=3Dn] Selected by [y]:
>   - BCM47XX_SSB [=3Dy] && BCM47XX [=3Dy]
>=20
> This is caused by arch/mips/bcm47xx/Kconfig's symbol BCM47XX_SSB
> selecting SSB_EMBEDDED when CONFIG_PCI is not set.
>=20
> This warning can be prevented by having SSB_EMBEDDED not depend on
> SSB_PCICORE_HOSTMODE, although some parts of SSB use PCI.

> diff -- a/drivers/ssb/Kconfig b/drivers/ssb/Kconfig
> --- a/drivers/ssb/Kconfig
> +++ b/drivers/ssb/Kconfig
> @@ -134,7 +134,7 @@ config SSB_SFLASH
>  # Assumption: We are on embedded, if we compile the MIPS core.
>  config SSB_EMBEDDED
>  	bool
> -	depends on SSB_DRIVER_MIPS && SSB_PCICORE_HOSTMODE
> +	depends on SSB_DRIVER_MIPS
>  	default y
> =20
>  config SSB_DRIVER_EXTIF

Could we instead make SSB_EMBEDDED depend on SSB_PCICORE_HOSTMODE if
PCI!=3Dn. Wouldn't that also solve the problem?

I don't fully remember how all this ssb config stuff works, but to
me adding a PCICORE->PCI dependency sounds safer against build
regressions in some other configurations.

What do you think?

--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/9PIyIezhhAqouq34xqM7bjm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmUiW7gACgkQ9TK+HZCN
iw5kThAAzOTfIX882ys2ZC7uP4UJMeszEWOpPQX1XGO4FUkDALJyYIKHEmc3MV9N
/lyLrIeH1X7DSpn8eo1UEQ6+wZYzR0uNUUrRNwponzQrp/TtzyEoW3eR54p/fZjA
Rlc5hSd61FfAwF2rtWjyMuSV1Drsm2rg75I50xU60xL2U9WbkRHNpfI/dTfBiuNB
POWxoCLF/YmsvRbix+CPHzMFO6fggTLLu1UrbnsHZp5PQqWEwxkfeT+UZBMZqjNC
iJVxy0JHaT7Eh8GV1h2xE46+okLdBqTFtJre+Z5oebn7vNOROM6K/B9wGebCKfu4
7huGbxMl0oUr8FhNOgD544arI/l9cC3WmYQ0PXBFrveGdmfukUECOOIcTtRN9TQr
yRhPOZSZNvgUKFZI4lRR8OEtNOcOjsVE2aAGdMgfYbgpSZJDELmwSjkx4yCAgZ7q
GWnHCa6WbW1C9bNcwpt2eV1+Uyy8eU7IoUg5CZCwD6y0UriYD40DGNkpYQLfVwEL
9qc6RJh7ujook92qZlhUkdfUF34WbfGo/GxVgnCvteHwcnG3Ahh2se5T+tyPQm5u
5BIy2pPOGf+9SP0oGKtqrOtyUwdD/11R1q2qx84fhrYdh+FZf/vLVCDZAcMqUzfv
66xUwPleihuTxNxxFYZclRlvq6a48tWQC4kchMXeOMUcjEDv6PA=
=LKqz
-----END PGP SIGNATURE-----

--Sig_/9PIyIezhhAqouq34xqM7bjm--
