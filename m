Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413E678BE1E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 07:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjH2F66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 01:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjH2F6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 01:58:37 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AE7109;
        Mon, 28 Aug 2023 22:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1693288708;
        bh=18HxPnJLRqLXAf/HDq0Tgm0vwcboajO3NobGWwh33YI=;
        h=Date:From:To:Cc:Subject:From;
        b=kJmNcz7qtycLggFnW5Vzqp2a1uZ80U9zzkYbCTnuyqLhIi0tCNsolxLmBQqjjHcCl
         u28te1FFPyA5nXYscGW3qe8H6r0tUMrgCg7cusnuWAkxe2c479x17ZDcyjQgEx7f7I
         X7EItS0tGTKMojiRiJ0AzJFKHnQbIp1qK1Fr9oXAqqxsieq6L7a11kpqjJBWNj338z
         vKS3KeUY881IRxc10fYiF0M/E/U/z6MXKkkPIa7DfC3icqJyVKd8kWdnUoAzcdps0k
         PQbeJLpCXxjDpYvs5iwVFmCGJUeNc83JNtbC/o8ZMntNoI/uvZoVA4e8FFdaH4KF5k
         e40FVdhWu3eWw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RZcDN5Kk3z4wd0;
        Tue, 29 Aug 2023 15:58:28 +1000 (AEST)
Date:   Tue, 29 Aug 2023 15:58:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: boot failure after merge of the bitmap tree
Message-ID: <20230829155824.062e861f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vWxVTtOxvxUWsB2n0vFTcc_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vWxVTtOxvxUWsB2n0vFTcc_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bitmap tree, today's linux-next boot test (powerpc
pseries_le_defconfig) failed like this:

Running code patching self-tests ...
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at arch/powerpc/sysdev/msi_bitmap.c:260 test_of_node=
+0x234/0x280
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.5.0-13305-g081ae3a78176 #1
Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf0000=
04 of:SLOF,HEAD pSeries
NIP:  c00000000201d6a4 LR: c00000000201d630 CTR: 0000000000000002
REGS: c00000000478b730 TRAP: 0700   Not tainted  (6.5.0-13305-g081ae3a78176)
MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 44000448  XER: 20000=
000
CFAR: c00000000201d674 IRQMASK: 0=20
GPR00: c00000000201d630 c00000000478b9d0 c000000001588a00 0000000000000000=
=20
GPR04: c000000004ef6340 ff03f0f1fffeffff ffffffff0f000000 0000feff0f000000=
=20
GPR08: 0000000000000010 0000000000000001 0000000000000000 0000000000000000=
=20
GPR12: 0000000000000008 c000000002b00000 c000000000011188 0000000000000000=
=20
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR24: 0000000000000000 c00000000200343c cccccccccccccccd c000000002090868=
=20
GPR28: 0000000000000000 c0000000020908a8 c00000000478b9f8 c00000000478bb50=
=20
NIP [c00000000201d6a4] test_of_node+0x234/0x280
LR [c00000000201d630] test_of_node+0x1c0/0x280
Call Trace:
[c00000000478b9d0] [c00000000201d630] test_of_node+0x1c0/0x280 (unreliable)
[c00000000478bbb0] [c00000000201d9c4] msi_bitmap_selftest+0x2d4/0x308
[c00000000478bc50] [c000000000010bc0] do_one_initcall+0x80/0x300
[c00000000478bd20] [c000000002004998] kernel_init_freeable+0x30c/0x3b4
[c00000000478bdf0] [c0000000000111b0] kernel_init+0x30/0x1a0
[c00000000478be50] [c00000000000debc] ret_from_kernel_user_thread+0x14/0x1c
--- interrupt: 0 at 0x0
NIP:  0000000000000000 LR: 0000000000000000 CTR: 0000000000000000
REGS: c00000000478be80 TRAP: 0000   Not tainted  (6.5.0-13305-g081ae3a78176)
MSR:  0000000000000000 <>  CR: 00000000  XER: 00000000
CFAR: 0000000000000000 IRQMASK: 0=20
GPR00: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR04: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR12: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR28: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
NIP [0000000000000000] 0x0
LR [0000000000000000] 0x0
--- interrupt: 0
Code: 40820018 7d273011 4102ffdc 4082000c 39200000 48000010 7d2903f4 7d4a51=
10 7d295378 7d290034 5529d97e 69290001 <0b090000> 38610160 4a0a01dd e861016=
8=20
---[ end trace 0000000000000000 ]---
registered taskstats version 1
	.
	.
	.
printk: console [netcon0] enabled
netconsole: network logging started
BUG: Unable to handle kernel data access at 0xc02a49fa823a5e63
Faulting instruction address: 0xc0000000004ff95c
Oops: Kernel access of bad area, sig: 11 [#1]
LE PAGE_SIZE=3D64K MMU=3DHash SMP NR_CPUS=3D2048 NUMA pSeries
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.5.0-13305-g081=
ae3a78176 #1
Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf0000=
04 of:SLOF,HEAD pSeries
NIP:  c0000000004ff95c LR: c0000000004ff9e8 CTR: c0000000002cdc40
REGS: c00000000478b9a0 TRAP: 0380   Tainted: G        W           (6.5.0-13=
305-g081ae3a78176)
MSR:  8000000002009033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 24008288  XER: 00000=
000
CFAR: c0000000004ff7c8 IRQMASK: 0=20
GPR00: c0000000004ff9e8 c00000000478bc40 c000000001588a00 0000000000000000=
=20
GPR04: 0000000000000cc0 0000000000001be2 0000000000000018 6749a6fe823a5e93=
=20
GPR08: 0000000000001be1 0000000000000010 000000007daa0000 0000000000002000=
=20
GPR12: c0000000002cdc40 c000000002b00000 c000000000011188 0000000000000000=
=20
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR20: 0000000000000000 0000000000000000 c0000000041a1290 c0000000002d9080=
=20
GPR24: ffffffffffffffff c0000000029225a0 0000000000000018 0000000000000cc0=
=20
GPR28: c02a49fa823a5e53 0000000000000000 0000000000000cc0 c000000004010400=
=20
NIP [c0000000004ff95c] __kmem_cache_alloc_node+0x2bc/0x440
LR [c0000000004ff9e8] __kmem_cache_alloc_node+0x348/0x440
Call Trace:
[c00000000478bc40] [c0000000004ff9d8] __kmem_cache_alloc_node+0x338/0x440 (=
unreliable)
[c00000000478bcc0] [c000000000455ce0] kmalloc_trace+0x50/0x150
[c00000000478bd10] [c0000000002d9080] ftrace_free_mem+0x3a0/0x4e0
[c00000000478bdf0] [c0000000000111d0] kernel_init+0x50/0x1a0
[c00000000478be50] [c00000000000debc] ret_from_kernel_user_thread+0x14/0x1c
--- interrupt: 0 at 0x0
NIP:  0000000000000000 LR: 0000000000000000 CTR: 0000000000000000
REGS: c00000000478be80 TRAP: 0000   Tainted: G        W           (6.5.0-13=
305-g081ae3a78176)
MSR:  0000000000000000 <>  CR: 00000000  XER: 00000000
CFAR: 0000000000000000 IRQMASK: 0=20
GPR00: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR04: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR12: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR28: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
NIP [0000000000000000] 0x0
LR [0000000000000000] 0x0
--- interrupt: 0
Code: 60420000 78a50020 7f83e378 38800000 4bbb9e8d 60000000 4bfffee4 600000=
00 60420000 813f0028 e8ff00b8 38a80001 <7fdc482a> 7d3c4a14 79260022 552ac03=
e=20
---[ end trace 0000000000000000 ]---
pstore: backend (nvram) writing error (-1)

note: swapper/0[1] exited with irqs disabled
Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x0000000b

Bisection pointed at commit

  d770ef2c8299 ("bitmap: replace _reg_op(REG_OP_RELEASE) with bitmap_clear(=
)")

I have used the bitmap tree from next-20230828 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/vWxVTtOxvxUWsB2n0vFTcc_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTtiQAACgkQAVBC80lX
0Gz0kgf/b3Vw3BPAzBZbVOAEYh7Ka9kHy9q26O25/TIgkzaR4Ek+fScUFN+KmfJR
QGF6/xDwPH+QnV/VrRgfb5l3D0wiUHJdUuK+nid06uWjUyvgXKqh6e0uppvGKgAg
2+eNuZxcV+Ajy/AycbVXrmGLAeejkT8HoUyfYTRTwnlLH3YjlGfdDt9meemRbKgz
j4BcMJ4vM0FNP/L44bLJ4fGJHeK9Q61N+wlKia51uE8ZJc/bO+T2vmcawmVBfLwN
WmNsw1bk1DSpLlkPicTCtgyfbOu+BP/0XvgDJiQVQdGFDvz/1B3YiiAkep62S37y
kCFvsBEoUmAU3hwPH7eU1GI8rcoUiA==
=zcV6
-----END PGP SIGNATURE-----

--Sig_/vWxVTtOxvxUWsB2n0vFTcc_--
