Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1977B3FAB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 11:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbjI3JYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 05:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjI3JYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 05:24:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0D6B3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 02:24:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDFBBC433C7;
        Sat, 30 Sep 2023 09:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696065843;
        bh=kDNia0WmJ1Icu03VHc1VXn0QbQl9HCIniijZGfUBKUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P58ubrG8nh4/GOZLvc6HMcH8CTfrM2pxRvOY+nOhDCYrFmFFi5eU9rGaBrX6pC8IN
         tiky509onDqrpoR1kbEWD4hJvHlH5fH1BSC5YYngCwEh9KNO22RHDEkw41q0GR4DxO
         LiS7DshG2o6PcDxGYd6U8SssEIUfHD9JvJuodwxYnOgshHxk3DZ0B4nL/mXCgojyZo
         nWH/+ZNpbwRBiGZXG2+LXyOTYOapZMe0tV0jF5M/49wG8Hw8inBr08O4fBrCGo0Mvd
         e741caPlxL6CWf3Oh/q7WFLk3cYKLxQCbkYpCA/QuBtNdR6ISuGChqbkE7GvHNm4ih
         fRKSJhV0YVhoA==
Date:   Sat, 30 Sep 2023 10:23:58 +0100
From:   Conor Dooley <conor@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Topel <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ron Minnich <rminnich@gmail.com>,
        Daniel Maslowski <cyrevolt@googlemail.com>
Subject: Re: [PATCH 0/7] Add support to handle misaligned accesses in S-mode
Message-ID: <20230930-patchy-curdle-ef5ee6e1a17c@spud>
References: <20230926150316.1129648-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PInAC6LI+1uRW4CY"
Content-Disposition: inline
In-Reply-To: <20230926150316.1129648-1-cleger@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PInAC6LI+1uRW4CY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 05:03:09PM +0200, Cl=E9ment L=E9ger wrote:
> Since commit 61cadb9 ("Provide new description of misaligned load/store
> behavior compatible with privileged architecture.") in the RISC-V ISA
> manual, it is stated that misaligned load/store might not be supported.
> However, the RISC-V kernel uABI describes that misaligned accesses are
> supported. In order to support that, this series adds support for S-mode
> handling of misaligned accesses as well support for prctl(PR_UNALIGN).
>=20
> Handling misaligned access in kernel allows for a finer grain control
> of the misaligned accesses behavior, and thanks to the prctl call, can
> allow disabling misaligned access emulation to generate SIGBUS. User
> space can then optimize its software by removing such access based on
> SIGBUS generation.
>=20
> Currently, this series is useful for people that uses a SBI that does
> not handled misaligned traps. In a near future, this series will make
> use a SBI extension [1] allowing to request delegation of the
> misaligned load/store traps to the S-mode software. This extension has
> been submitted for review to the riscv tech-prs group. An OpenSBI
> implementation for this spec is available at [2].
>=20
> This series can be tested using the spike simulator [3] and an openSBI
> version [4] which allows to always delegate misaligned load/store to
> S-mode.

Some patches in this series do not build for any configs, some are
broken for clang builds and others are broken for nommu. Please try to
build test this more thoroughly before you submit the next version.

Also, AIUI, this series should be marked RFC since the SBI extension
this relies on has not been frozen.

Cheers,
Conor.

--PInAC6LI+1uRW4CY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRfpLgAKCRB4tDGHoIJi
0gjVAQC9Fx8Nsb4L0O1OJEH1rh93DACoHcszIy+Nk51MwLmJzwD/efGr2z7a6NM/
JvCBcINOdxE3OTtc4dn2+/DGMu5DUA0=
=wwCm
-----END PGP SIGNATURE-----

--PInAC6LI+1uRW4CY--
