Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7127E006D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346442AbjKCIes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 04:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235601AbjKCIeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 04:34:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DCD1BC
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 01:34:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB571C433C7;
        Fri,  3 Nov 2023 08:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699000484;
        bh=sE+MpiHqWgJ5iIw/npYzRDsl6/Gv+LYVgh0WxYn1jWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nXpshMam9XLnIcy9bgwXkkE6rGoW0x477Hcqyz2l524SMDdjizinUd1BnNDHh+nPT
         Zd37Mk7T1KdVVXG9Q0UrCCdAZ2QlWcSpjlRTewSsqLAaf045giyTjiIfZIkyXdWYF0
         nafF8hPZlK95LobtO+FgH5631ypn0hiZET+/GKRBwPJJQMtefPzfh1MGnPUdLxHK4g
         GwvVRKHx3i+2Lti2fcur6Jn6PcBDPwPFIkhL+CtRX5Hm2hNZFyC2fGT0qolgmuF5sS
         JlYTtP63IjQpkImjxAITzg/fHhXZL1IeOGgWpp34KrkfK6pGZsnO+ULdT0soxL/rDl
         W88rmsv0i9FJQ==
Date:   Fri, 3 Nov 2023 08:34:38 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        David Laight <David.Laight@aculab.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] RISC-V: Probe misaligned access speed in parallel
Message-ID: <20231103-uproar-rumbling-0a7a5ecb385e@spud>
References: <20230915184904.1976183-1-evan@rivosinc.com>
 <CALs-Hsu_1x2FpjWXbmioSi6x30NXdNgrQ=t=EBknB0O06DA12A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="G1VAzj1/yjoi+Jgm"
Content-Disposition: inline
In-Reply-To: <CALs-Hsu_1x2FpjWXbmioSi6x30NXdNgrQ=t=EBknB0O06DA12A@mail.gmail.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G1VAzj1/yjoi+Jgm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 02, 2023 at 03:41:58PM -0700, Evan Green wrote:
> On Fri, Sep 15, 2023 at 11:49=E2=80=AFAM Evan Green <evan@rivosinc.com> w=
rote:
> >
> > Probing for misaligned access speed takes about 0.06 seconds. On a
> > system with 64 cores, doing this in smp_callin() means it's done
> > serially, extending boot time by 3.8 seconds. That's a lot of boot time.
> >
> > Instead of measuring each CPU serially, let's do the measurements on
> > all CPUs in parallel. If we disable preemption on all CPUs, the
> > jiffies stop ticking, so we can do this in stages of 1) everybody
> > except core 0, then 2) core 0.
> >
> > The measurement call in smp_callin() stays around, but is now
> > conditionalized to only run if a new CPU shows up after the round of
> > in-parallel measurements has run. The goal is to have the measurement
> > call not run during boot or suspend/resume, but only on a hotplug
> > addition.
> >
> > Signed-off-by: Evan Green <evan@rivosinc.com>
>=20
> Shoot, I saw the other thread [1] where it seems like my use of
> alloc_pages() in this context is improper? I had thought I was
> alright, as Documentation/core-api/memory-allocation.rst says:
>=20
>  > If the allocation is performed from an atomic context, e.g interrupt
>  > handler, use ``GFP_NOWAIT``.
>=20
> Any tips for reproducing that splat? I have CONFIG_DEBUG_ATOMIC_SLEEP
> on (it's in the defconfig), and lockdep, and I'm on Conor's
> linux-6.6.y-rt, but so far I'm not seeing it.

It was originally produced in hardware, but I can also see these issues
in QEMU's emulation of my hardware (although as you may have seen, I get
them both with and without this patch). My qemu incantation was
something like:
	$(qemu) -M microchip-icicle-kit \
		-m 3G -smp 5 \
		-kernel vmlinux.bin \
		-dtb mpfs-icicle.dtb \
		-initrd initramfs \
		-display none -serial null \
		-serial stdio \
		-D qemu.log -d unimp

Where the kernel was built from the .config in that branch in my repo.

Cheers,
Conor.

--G1VAzj1/yjoi+Jgm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUSwngAKCRB4tDGHoIJi
0pnVAQDoGrbuX8WYBNusBkNvYdfa6NNmwBhgyGi8nakTAO0FNwD+I6uqKJlLCnrN
Gas947oBPmncixilSkkp8KNlJBLUlAA=
=BjY9
-----END PGP SIGNATURE-----

--G1VAzj1/yjoi+Jgm--
