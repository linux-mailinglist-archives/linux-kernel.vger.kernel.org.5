Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F67789251
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 01:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjHYX1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 19:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjHYX0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 19:26:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724112135;
        Fri, 25 Aug 2023 16:26:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FB8F60FD3;
        Fri, 25 Aug 2023 23:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09C3C433C8;
        Fri, 25 Aug 2023 23:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693005990;
        bh=7HwZnCsZbl5TQtcjKxpWX5l3vU8EOklS1EaMyIzsa2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ADjKcYdgOJJICMbQ38J4gdCEXO7D9fTWLo7Yytu0be/DKHS6zoDIoRcNrlex4mA4n
         ue773v0DVdcwzCWxxUT86ipjx9PMEgLxh5z18gR2Xs2boFuAhBsozBGE3Dlv7s+8NN
         fyLZBXc7f5UaiekEGraAjBHtxcHkrnaaDHVfcgTUNaG5bXdr2mnNyaIF4nSHM5gwkL
         4nTyMtMiSxlGts5JekpBE2cbZLLUe5pUDsFzO+Xw5nBi6RRnLO6n96ewD5CVsq0WDu
         EqF38PKoRFDGneLMYk/hHsLrv60A1EJWEv73KQokJAFHK68z/sDynqLREn+mQ654uI
         73C0NKKZVZL2w==
Date:   Sat, 26 Aug 2023 00:26:25 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH v5] RISC-V: Show accurate per-hart isa in /proc/cpuinfo
Message-ID: <20230826-anguished-tutu-81d63b3081a7@spud>
References: <20230825231139.1145522-1-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qkfI1VY/b577gx60"
Content-Disposition: inline
In-Reply-To: <20230825231139.1145522-1-evan@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qkfI1VY/b577gx60
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2023 at 04:11:38PM -0700, Evan Green wrote:
> In /proc/cpuinfo, most of the information we show for each processor is
> specific to that hart: marchid, mvendorid, mimpid, processor, hart,
> compatible, and the mmu size. But the ISA string gets filtered through a
> lowest common denominator mask, so that if one CPU is missing an ISA
> extension, no CPUs will show it.
>=20
> Now that we track the ISA extensions for each hart, let's report ISA
> extension info accurately per-hart in /proc/cpuinfo. We cannot change
> the "isa:" line, as usermode may be relying on that line to show only
> the common set of extensions supported across all harts. Add a new "hart
> isa" line instead, which reports the true set of extensions for that
> hart.
>=20
> Signed-off-by: Evan Green <evan@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Can you drop this if you repost?

> +"isa" vs "hart isa" lines in /proc/cpuinfo
> +------------------------------------------
> +
> +The "isa" line in /proc/cpuinfo describes the lowest common denominator =
of
> +RISC-V ISA extensions recognized by the kernel and implemented on all ha=
rts. The
> +"hart isa" line, in contrast, describes the set of extensions recognized=
 by the
> +kernel on the particular hart being described, even if those extensions =
may not
> +be present on all harts in the system.

> In both cases, the presence of a feature
> +in these lines guarantees only that the hardware has the described capab=
ility.
> +Additional kernel support or policy control changes may be required befo=
re a
> +feature is fully usable by userspace programs.

I do not think that "in both cases" matches the expectations of
userspace for the existing line. It's too late at night for me to think
properly, but I think our existing implementation does work like you
have documented for FD/V. I think I previously mentioned that it could
misreport things for vector during the review of the vector series but
forgot about it until now.

--qkfI1VY/b577gx60
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOk4oQAKCRB4tDGHoIJi
0qesAQCAv+Id3VI7GGN4a4k9spLlIS45t6btTV9/aCThf+ubXwEA7IsxmZ2HzEN5
1SDmG7YGFdXLHJD/Lo4RNeQfL85/FAc=
=ZbVo
-----END PGP SIGNATURE-----

--qkfI1VY/b577gx60--
