Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326A878DEC2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244257AbjH3TOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243237AbjH3K1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:27:55 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4087F4;
        Wed, 30 Aug 2023 03:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1693391273; x=1724927273;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HP9Iur1Q7Nq1MElrF98R8N/vWYvb9inNU3hcETlvDqs=;
  b=0DEbjVD0Ynwt71Qq4H+p+zLN7MqP6Gw012cGUcOvvvq1GBdBtWoDaTbg
   mcqZY+scVL8v58hXOQlw0rBnXo4k7nis44ak/7TMCSr2YqaUg2/r3RM0h
   u0SS9IVogo6981ypkBsiDpZ+kAvMZwOW08e/7cbUJ9Y62HJg5ZtsGq06T
   JBkqeUM/KzyLUQ8FFle39aBrXp/OkxX+tbOCXtcirKRjxwzP9UqmSueDu
   ddV9//NzgHjHgjlRIlnkQEfyYvJ/cKTYI/x3osDqJQtfbiOiPz6uOlzhv
   cm1JSwCQ0s9tiamQ5qQF3gnZWhcAMUnUz9bfKUOFmrALprIMiYUdvH/cE
   Q==;
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="asc'?scan'208";a="2012796"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2023 03:27:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 30 Aug 2023 03:27:21 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 30 Aug 2023 03:27:19 -0700
Date:   Wed, 30 Aug 2023 11:26:37 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <jiajie.ho@starfivetech.com>, <huan.feng@starfivetech.com>
CC:     <herbert@gondor.apana.org.au>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <conor.dooley@microchip.com>,
        <kernel@esmil.dk>, <linux-riscv@lists.infradead.org>,
        <davidlt@rivosinc.com>
Subject: starfive crypto list_add corruption
Message-ID: <20230830-track-glutinous-39f536b4ced1@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DM+rVJfmyKcOsa+w"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--DM+rVJfmyKcOsa+w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

There's been a report on the irc fedora-riscv irc of list_add corruption
with the starfive crypto stuff:
	list_add corruption. next->prev should be prev (ffffffff02f65320), but was=
 ffffffd8eef15848. (next=3Dffffffd8eef15840).
	------------[ cut here ]------------
	kernel BUG at lib/list_debug.c:29!
	Kernel BUG [#1]
	Modules linked in: jh7110_crypto spidev pcs_xpcs clk_starfive_jh7110_aon p=
inctrl_starfive_jh7110_aon clk_starfive_jh7110_stg crypto_engine phylink dw=
_mmc_starfive dw_mmc_pltfm clk_starfive_jh7110_vout phy_jh7110_pcie spi_
	pl022 clk_starfive_jh7110_isp dw_mmc phy_jh7110_usb i2c_designware_platfor=
m pinctrl_starfive_jh7110_sys i2c_designware_core sunrpc ip6_tables ip_tabl=
es i2c_dev fuse                                                            =
           =20
	CPU: 2 PID: 53 Comm: kworker/u8:2 Not tainted 6.5.0-next-20230829 #13
	Hardware name: StarFive VisionFive 2 v1.3B (DT)
	Workqueue: events_unbound deferred_probe_work_func
	epc : __list_add_valid_or_report+0x82/0x96
	 ra : __list_add_valid_or_report+0x82/0x96
	epc : ffffffff80640808 ra : ffffffff80640808 sp : ffffffc8002dbb10
	 gp : ffffffff81f9ea48 tp : ffffffd8c0ac3a00 t0 : ffffffff80c8f5fc
	 t1 : 0720072007200720 t2 : 206464615f747369 s0 : ffffffc8002dbb20
	 s1 : ffffffd8ecf11040 a0 : 0000000000000075 a1 : ffffffd8fdd71a48
	 a2 : ffffffd8fdd7e728 a3 : 0000000000000000 a4 : 0000000000000000
	 a5 : 0000000000000000 a6 : ffffffff81fc3818 a7 : 0000000000000034
	 s2 : ffffffd8eef15840 s3 : ffffffff02f65320 s4 : ffffffd8c02a3c10
	 s5 : ffffffd8ecf11178 s6 : ffffffd8ecf11150 s7 : ffffffff02f65250
	 s8 : ffffffff823953d8 s9 : ffffffff8109ba08 s10: ffffffd8c0154000
	 s11: ffffffd8c0b1c540 t3 : ffffffd8c0161f00 t4 : ffffffd8c0161f00
	 t5 : ffffffd8c0161000 t6 : ffffffc8002db918
	status: 0000000200000120 badaddr: 0000000000000000 cause: 0000000000000003
	[<ffffffff80640808>] __list_add_valid_or_report+0x82/0x96
	[<ffffffff02df646c>] starfive_cryp_probe+0x1e0/0x4bc [jh7110_crypto]
	[<ffffffff80835062>] platform_probe+0x5e/0xba
	[<ffffffff8083205c>] really_probe+0xa0/0x35a
	[<ffffffff80832398>] __driver_probe_device+0x82/0x140
	[<ffffffff8083248e>] driver_probe_device+0x38/0xb6
	[<ffffffff8083258e>] __device_attach_driver+0x82/0xe4
	[<ffffffff8082fe90>] bus_for_each_drv+0x72/0xc8
	[<ffffffff8083299e>] __device_attach+0x94/0x18a
	[<ffffffff80832c92>] device_initial_probe+0x1a/0x22
	[<ffffffff80830e9a>] bus_probe_device+0x96/0x98
	[<ffffffff80831c6a>] deferred_probe_work_func+0xb2/0x102
	[<ffffffff800542be>] process_one_work+0x18a/0x32a
	[<ffffffff80054fe2>] worker_thread+0x2fc/0x44a
	[<ffffffff8005e3e0>] kthread+0xc4/0xe4
	[<ffffffff80003c12>] ret_from_fork+0xe/0x20
	Code: 9002 86be 1517 0157 0513 b685 1097 0065 80e7 92a0 (9002) 1517=20
	---[ end trace 0000000000000000 ]---
	Kernel panic - not syncing: Fatal exception in interrupt
	SMP: stopping secondary CPUs
	---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

I feel like this isn't the first report I saw, but the other might've
been for the equivalent driver in the vendor tree & I probably didn't
pay any attention to.

Thanks,
Conor.

--DM+rVJfmyKcOsa+w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZO8ZXQAKCRB4tDGHoIJi
0uWyAQDLG+15QTN5S4Z0wIHbcqLoIoh3iffMQHeyCU0L99Wz3gD/Q11hJJkZxo1b
DU0aa6xvaC+lmR5QVnU667BbHAtoew8=
=+fCB
-----END PGP SIGNATURE-----

--DM+rVJfmyKcOsa+w--
