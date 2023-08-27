Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B38789D4B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 13:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjH0LoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 07:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjH0LoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 07:44:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29F0125;
        Sun, 27 Aug 2023 04:44:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8586B622A8;
        Sun, 27 Aug 2023 11:44:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44ACC433C8;
        Sun, 27 Aug 2023 11:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693136648;
        bh=IcVpAPNpIn17kOmFoY2QEQ5tyz9Ce608Zcrvuu2eoDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BJ2S5Td307+0hg/FuzqdroPc9RdJAq5ugOFbsX/GmGcaNyRZwdwxFgYxTzTAvjkNS
         d7atn6Qw+m2MMNhJ1/o1zKeF/YtXwSsavhcSVz+jSv3as8EmHAj6Dz99nteRwbzPhI
         M2JIPbisa6Yhx3tpRN1pwTnlMlGeJKvYuQFbzkodaRc/wY9oFjHtaNFp1RRXt2aSpR
         uuV070JlcvstONA8dxC9J03aax83uTvK7PD9PXEHsvQwRALmQK6Gw02AJUknKEL9e4
         1O0pgExL7DRTCaP/mVuHI+pj4qYwgQBKeQi965vyJjCco862dYW6uMToHbqtRWDyyF
         W/NJdyDG5SQqA==
Date:   Sun, 27 Aug 2023 12:44:04 +0100
From:   Conor Dooley <conor@kernel.org>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Nam Cao <namcaov@gmail.com>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] riscv: Only consider swbp/ss handlers for correct
 privileged mode
Message-ID: <20230827-dispute-platform-83b494acf090@spud>
References: <20230827114003.224958-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zntgtklq8QDoOTU5"
Content-Disposition: inline
In-Reply-To: <20230827114003.224958-1-bjorn@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zntgtklq8QDoOTU5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 27, 2023 at 01:40:03PM +0200, Bj=F6rn T=F6pel wrote:
> From: Bj=F6rn T=F6pel <bjorn@rivosinc.com>
>=20
> RISC-V software breakpoint trap handlers are used for {k,u}probes.
>=20
> When trapping from kernelmode, only the kernelmode handlers should be
> considered. Vice versa, only usermode handlers for usermode
> traps. This is not the case on RISC-V, which can trigger a bug if a
> userspace process uses uprobes, and a WARN() is triggered from
> kernelmode (which is implemented via {c.,}ebreak).
>=20
> The kernel will trap on the kernelmode {c.,}ebreak, look for uprobes
> handlers, realize incorrectly that uprobes need to be handled, and
> exit the trap handler early. The trap returns to re-executing the
> {c.,}ebreak, and enter an infinite trap-loop.
>=20
> The issue was found running the BPF selftest [1].
>=20
> Fix this issue by only considering the swbp/ss handlers for
> kernel/usermode respectively. Also, move CONFIG ifdeffery from traps.c
> to the asm/{k,u}probes.h headers.
>=20
> Note that linux/uprobes.h only include asm/uprobes.h if CONFIG_UPROBES
> is defined, which is why asm/uprobes.h needs to be unconditionally
> included in traps.c
>=20
> Link: https://lore.kernel.org/linux-riscv/87v8d19aun.fsf@all.your.base.ar=
e.belong.to.us/ # [1]

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202308271841.HlnnHFL7-lkp@i=
ntel.com/

Delete these, LKP did not report the probes issue. The LKP bot says:
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags



--zntgtklq8QDoOTU5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOs27AAKCRB4tDGHoIJi
0uIzAP9VFVImAMhEoiHMLw6VZPzHi34oUeM90dG0Y7fIejzh9wEAgHzA1d7ozX0G
/DMHBJX7ykfHPJlmz6CkOUW7IuMugQo=
=0HR+
-----END PGP SIGNATURE-----

--zntgtklq8QDoOTU5--
