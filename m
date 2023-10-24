Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F5C7D5B68
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 21:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344219AbjJXTW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 15:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343612AbjJXTW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 15:22:26 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E531710C3;
        Tue, 24 Oct 2023 12:22:22 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id AF9DD1C007B; Tue, 24 Oct 2023 21:22:20 +0200 (CEST)
Date:   Tue, 24 Oct 2023 21:22:19 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Pavel Machek <pavel@denx.de>,
        niklas.soderlund+renesas@ragnatech.se,
        yoshihiro.shimoda.uh@renesas.com, geert+renesas@glider.be,
        biju.das.jz@bp.renesas.com, Chris.Paterson2@renesas.com,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: renesas_sdhi problems in 5.10-stable was Re: [PATCH 5.10
 000/226] 5.10.198-rc1 review
Message-ID: <ZTgZa1ic1iFbdaTM@duo.ucw.cz>
References: <20231009130126.697995596@linuxfoundation.org>
 <ZSRVgj5AqJbDXqZU@duo.ucw.cz>
 <ZSRe78MAQwbBdyFP@duo.ucw.cz>
 <ZSUy+zA0+Chm6dFb@duo.ucw.cz>
 <ZSU+GHl1q7T/TBp5@duo.ucw.cz>
 <ZSWg1fv3gOyV5t+h@shikoro>
 <2023101057-runny-pellet-8952@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="llYF3KVE0Ra1/NWQ"
Content-Disposition: inline
In-Reply-To: <2023101057-runny-pellet-8952@gregkh>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NEUTRAL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--llYF3KVE0Ra1/NWQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > And testing failed. So
> > >=20
> > > commit f5799b4e142884c2e7aa99f813113af4a3395ffb
> > > Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > Date:   Tue Nov 10 15:20:57 2020 +0100
> > >=20
> > >     mmc: renesas_sdhi: populate SCC pointer at the proper place
> > >    =20
> > >     [ Upstream commit d14ac691bb6f6ebaa7eeec21ca04dd47300ff5b6 ]
> > >=20
> > > seems to be the buggy commit that breaks renesas boards in 5.10.
> >=20
> > This patch was part of a series. Did the other two patches come with it?
> >=20
> > b161d87dfd3d ("mmc: renesas_sdhi: probe into TMIO after SCC parameters =
have been setup")
>=20
> Yes.
>=20
> > 45bffc371fef ("mmc: renesas_sdhi: only reset SCC when its pointer is po=
pulated")
>=20
> No :(
>=20
> > If not, I could imagine that could lead to a crash. No idea why only
> > with 5.10, though.
>=20
> The above commit is only in 5.11, so newer kernels should be fine.
>=20
> I'll go queue up the one missing patch now, thanks.

Thank you. Patch indeed appears to be in 5.10.199.

But we still have failures on Renesas with 5.10.199-rc2:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/1=
047368849

And they still happed during MMC init:

    2.638013] renesas_sdhi_internal_dmac ee100000.mmc: Got CD GPIO
[    2.638846] INFO: trying to register non-static key.
[    2.644192] ledtrig-cpu: registered to indicate activity on CPUs
[    2.649066] The code is fine but needs lockdep annotation, or maybe
[    2.649069] you didn't initialize this object before use?
[    2.649071] turning off the locking correctness validator.
[    2.649080] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.10.199-rc2-arm64=
-renesas-ge31b6513c43d #1
[    2.649082] Hardware name: HopeRun HiHope RZ/G2M with sub board (DT)
[    2.649086] Call trace:
[    2.655106] SMCCC: SOC_ID: ARCH_SOC_ID not implemented, skipping ....
[    2.661354]  dump_backtrace+0x0/0x194
[    2.661361]  show_stack+0x14/0x20
[    2.667430] usbcore: registered new interface driver usbhid
[    2.672230]  dump_stack+0xe8/0x130
[    2.672238]  register_lock_class+0x480/0x514
[    2.672244]  __lock_acquire+0x74/0x20ec
[    2.681113] usbhid: USB HID core driver
[    2.687450]  lock_acquire+0x218/0x350
[    2.687456]  _raw_spin_lock+0x58/0x80
[    2.687464]  tmio_mmc_irq+0x410/0x9ac
[    2.688556] renesas_sdhi_internal_dmac ee160000.mmc: mmc0 base at 0x0000=
0000ee160000, max clock rate 200 MHz
[    2.744936]  __handle_irq_event_percpu+0xbc/0x340
[    2.749635]  handle_irq_event+0x60/0x100
[    2.753553]  handle_fasteoi_irq+0xa0/0x1ec
[    2.757644]  __handle_domain_irq+0x7c/0xdc
[    2.761736]  efi_header_end+0x4c/0xd0
[    2.765393]  el1_irq+0xcc/0x180
[    2.768530]  arch_cpu_idle+0x14/0x2c
[    2.772100]  default_idle_call+0x58/0xe4
[    2.776019]  do_idle+0x244/0x2c0
[    2.779242]  cpu_startup_entry+0x20/0x6c
[    2.783160]  rest_init+0x164/0x28c
[    2.786561]  arch_call_rest_init+0xc/0x14
[    2.790565]  start_kernel+0x4c4/0x4f8
[    2.794233] Unable to handle kernel NULL pointer dereference at virtual =
address 0000000000000014
[    2.803011] Mem abort info:

=66rom https://lava.ciplatform.org/scheduler/job/1025535
=66rom
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/536097=
3735 .

Is there something else missing?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--llYF3KVE0Ra1/NWQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZTgZawAKCRAw5/Bqldv6
8lQ8AKCik1QaBTn5m7YuXb/lLY/car/XYwCgjDo/FjpueiEG4fDOuu7j9yjTttI=
=quL0
-----END PGP SIGNATURE-----

--llYF3KVE0Ra1/NWQ--
