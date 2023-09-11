Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA6C79C040
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjIKUrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243435AbjIKRLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:11:48 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8E41A5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 10:11:39 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qfkRH-0003Ky-31; Mon, 11 Sep 2023 19:11:07 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qfkRD-005bHv-Av; Mon, 11 Sep 2023 19:11:03 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qfkRC-000kQa-Gf; Mon, 11 Sep 2023 19:11:02 +0200
Date:   Mon, 11 Sep 2023 19:11:02 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, kernel@pengutronix.de
Subject: [REGRESSION] [PATCH net-next v5 2/2] net: stmmac: use per-queue 64
 bit statistics where necessary
Message-ID: <20230911171102.cwieugrpthm7ywbm@pengutronix.de>
References: <20230717160630.1892-1-jszhang@kernel.org>
 <20230717160630.1892-3-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="evb7p5evmmj2tflh"
Content-Disposition: inline
In-Reply-To: <20230717160630.1892-3-jszhang@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_TEMPERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--evb7p5evmmj2tflh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

this patch became commit 133466c3bbe171f826294161db203f7670bb30c8 and is
part of v6.6-rc1.

On my arm/stm32mp157 based machine using NFS root this commit makes the
following appear in the kernel log:

	INFO: trying to register non-static key.
	The code is fine but needs lockdep annotation, or maybe
	you didn't initialize this object before use?
	turning off the locking correctness validator.
	CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc1-00449-g133466c3bbe1-di=
rty #21
	Hardware name: STM32 (Device Tree Support)
	 unwind_backtrace from show_stack+0x18/0x1c
	 show_stack from dump_stack_lvl+0x60/0x90
	 dump_stack_lvl from register_lock_class+0x98c/0x99c
	 register_lock_class from __lock_acquire+0x74/0x293c
	 __lock_acquire from lock_acquire+0x134/0x398
	 lock_acquire from stmmac_get_stats64+0x2ac/0x2fc
	 stmmac_get_stats64 from dev_get_stats+0x44/0x130
	 dev_get_stats from rtnl_fill_stats+0x38/0x120
	 rtnl_fill_stats from rtnl_fill_ifinfo+0x834/0x17f4
	 rtnl_fill_ifinfo from rtmsg_ifinfo_build_skb+0xc0/0x144
	 rtmsg_ifinfo_build_skb from rtmsg_ifinfo+0x50/0x88
	 rtmsg_ifinfo from __dev_notify_flags+0xc0/0xec
	 __dev_notify_flags from dev_change_flags+0x50/0x5c
	 dev_change_flags from ip_auto_config+0x2f4/0x1260
	 ip_auto_config from do_one_initcall+0x70/0x35c
	 do_one_initcall from kernel_init_freeable+0x2ac/0x308
	 kernel_init_freeable from kernel_init+0x1c/0x138
	 kernel_init from ret_from_fork+0x14/0x2c
	Exception stack(0xe0815fb0 to 0xe0815ff8)
	5fa0:                                     00000000 00000000 00000000 00000=
000
	5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000=
000
	5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
	dwc2 49000000.usb-otg: new device is high-speed

I didn't try understand this problem, it's too close to quitting time
:-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--evb7p5evmmj2tflh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmT/SiUACgkQj4D7WH0S
/k78iQf9FpYUT9EfyS7lnyhzUcBL/Xc3LHD8G07QANkglzeoMPSsfuql1xkWv+8r
A+OuA6vE48ibhtXi1Pla+3q0omeModLRjte6BkAbQI8dDjetVvUXwOBak9TAaVOS
b1xE9+nmR/xIGE8FOLiNQYqEmNTYN2cM8zxz1gj52zS0GdNe9Lc8f6Yl1Iv5lxo2
xSwSpQgr1wCPP7Fd/Esdi54i3hzx4NbongmBjQPyUiU9Hq5Ej/GDE8F26xH5C1Vg
B3mwCe5pdcUu5Z2u5RKfgTZYhjjRmSMT2LEsPklZ7XQGAjD8ab6lpwHRp6eMzuon
53IvuCgXCMctliVXrpYu8vvrhljHtA==
=2RjK
-----END PGP SIGNATURE-----

--evb7p5evmmj2tflh--
