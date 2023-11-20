Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BD07F1CE9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 19:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjKTSuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 13:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjKTSuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 13:50:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEDEC9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 10:50:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA6BC433C7;
        Mon, 20 Nov 2023 18:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700506204;
        bh=1TngNVj8ZkGMR8ZV60yx8B1afcf0iRoKq32S1Iu6eqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dct1R9Tdc+LxdZbIlIpv1N0yaL2RVyU94IDGeV9TpH4T4794OkTaVpXOSYrjIy8Rg
         AW50QJawX0X5pg0iVEmqgyfGURURTzUgfSbeY6B2r1Rk+bzlRzVaQobg7iPXsdmQrm
         xxWY1r6COF76pskBXsOCEjLSxh49kCL43ZjOEjB2+ZCIvXS30AcuQ264uldF8dojkc
         ySCv3h0fFcJdoelqw5q/Zawv3rGAzePcaw6FqTQCxLbNZ5oZ0t3mn6jEQCbvqBgQej
         mso1PLr66vQSBCH7garkh8poib5/PlOvXyNQTmYHtWDq32qGTdAdu+WGAtashyzbk2
         VdUqIjRgZknug==
Date:   Mon, 20 Nov 2023 18:49:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     chengming.zhou@linux.dev
Cc:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH v5 6/9] slub: Delay freezing of partial slabs
Message-ID: <4f3bc1bd-ea87-465d-b58a-0ed57b15187b@sirena.org.uk>
References: <20231102032330.1036151-1-chengming.zhou@linux.dev>
 <20231102032330.1036151-7-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r03Gj3uw2DPOktWQ"
Content-Disposition: inline
In-Reply-To: <20231102032330.1036151-7-chengming.zhou@linux.dev>
X-Cookie: Baby On Board.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r03Gj3uw2DPOktWQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 02, 2023 at 03:23:27AM +0000, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
>=20
> Now we will freeze slabs when moving them out of node partial list to
> cpu partial list, this method needs two cmpxchg_double operations:
>=20
> 1. freeze slab (acquire_slab()) under the node list_lock
> 2. get_freelist() when pick used in ___slab_alloc()

Recently -next has been failing to boot on a Raspberry Pi 3 with an arm
multi_v7_defconfig and a NFS rootfs, a bisect appears to point to this
patch (in -next as c8d312e039030edab25836a326bcaeb2a3d4db14) as having
introduced the issue.  I've included the full bisect log below.

When we see problems we see RCU stalls while logging in, for example:

debian-testing-armhf login: root (automatic login)
Linux debian-testing-armhf 6.7.0-rc1-00006-gc8d312e03903 #1 SMP @1699864348=
 armv7l
The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.
Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
[   46.453323] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[   46.459361] rcu: 	3-...0: (1 GPs behind) idle=3Ddef4/1/0x40000000 softir=
q=3D1304/1304 fqs=3D951
[   46.467669] rcu: 	(detected by 0, t=3D2103 jiffies, g=3D1161, q=3D499 nc=
pus=3D4)
[   46.474472] Sending NMI from CPU 0 to CPUs 3:
[   56.478894] rcu: rcu_sched kthread timer wakeup didn't happen for 1002 j=
iffies! g1161 f0x0 RCU_GP_WAIT_FQS(5) ->state=3D0x402
[   56.490195] rcu: 	Possible timer handling issue on cpu=3D0 timer-softirq=
=3D1650
[   56.497259] rcu: rcu_sched kthread starved for 1005 jiffies! g1161 f0x0 =
RCU_GP_WAIT_FQS(5) ->state=3D0x402 ->cpu=3D0
[   56.507589] rcu: 	Unless rcu_sched kthread gets sufficient CPU time, OOM=
 is now expected behavior.
[   56.516681] rcu: RCU grace-period kthread stack dump:
[   56.521803] task:rcu_sched       state:I stack:0     pid:13    tgid:13  =
  ppid:2      flags:0x00000000
[   56.531267]  __schedule from schedule+0x20/0xe8
[   56.535883]  schedule from schedule_timeout+0xa0/0x158
[   56.541111]  schedule_timeout from rcu_gp_fqs_loop+0x104/0x594
[   56.547048]  rcu_gp_fqs_loop from rcu_gp_kthread+0x14c/0x1c0
[   56.552801]  rcu_gp_kthread from kthread+0xe0/0xfc
[   56.557674]  kthread from ret_from_fork+0x14/0x28
[   56.562457] Exception stack(0xf084dfb0 to 0xf084dff8)
[   56.567584] dfa0:                                     00000000 00000000 =
00000000 00000000
[   56.575886] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[   56.584191] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   56.590907] rcu: Stack dump where RCU GP kthread last ran:
[   56.596474] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.7.0-rc1-00006-gc=
8d312e03903 #1
[   56.604515] Hardware name: BCM2835
[   56.607965] PC is at default_idle_call+0x1c/0xb0
[   56.612654] LR is at ct_kernel_enter.constprop.0+0x48/0x11c
[   56.618311] pc : [<c1197054>]    lr : [<c1195c98>]    psr: 60010013
[   56.624672] sp : c1b01f70  ip : c1d5af7c  fp : 00000000
[   56.629974] r10: c19cda60  r9 : 00000000  r8 : 00000000
[   56.635277] r7 : c1b04d50  r6 : c1b04d18  r5 : c1d5b684  r4 : c1b09740
[   56.641902] r3 : 00000000  r2 : 00000000  r1 : 00000001  r0 : 002a3114
[   56.648528] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment=
 none
[   56.655774] Control: 10c5383d  Table: 0237406a  DAC: 00000051
[   56.661605]  default_idle_call from do_idle+0x208/0x290
[   56.666920]  do_idle from cpu_startup_entry+0x28/0x2c
[   56.672059]  cpu_startup_entry from rest_init+0xac/0xb0
[   56.677371]  rest_init from arch_post_acpi_subsys_init+0x0/0x8
Login ti

A full log for that run can be seen at:

   https://validation.linaro.org/scheduler/job/4017095

Boots to initramfs with the same kernel image seem fine.  Other systems,
including other 32 bit arm ones, don't seem to be having similar issues
with this userspace.  I've not investigated beyond running the bisect,
the log for which is below:

git bisect start
# good: [64e6d94bfb47ed0732ad06aedf8ec6af5dd2ab84] Merge branch 'for-linux-=
next-fixes' of git://anongit.freedesktop.org/drm/drm-misc
git bisect good 64e6d94bfb47ed0732ad06aedf8ec6af5dd2ab84
# bad: [5a82d69d48c82e89aef44483d2a129f869f3506a] Add linux-next specific f=
iles for 20231120
git bisect bad 5a82d69d48c82e89aef44483d2a129f869f3506a
# good: [ce252a92a867da8a6622463bff637e5f7b904a46] Merge branch 'for-next' =
of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
git bisect good ce252a92a867da8a6622463bff637e5f7b904a46
# good: [c22e026efad504e3b056d4436920d173a09c580e] Merge branch 'for-next' =
of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
git bisect good c22e026efad504e3b056d4436920d173a09c580e
# good: [b7fc58ffb105470cb339163cc2b04e3f59387a45] Merge branch 'for-next' =
of git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga.git
git bisect good b7fc58ffb105470cb339163cc2b04e3f59387a45
# good: [26f89f0614f03e4016578a992fc2e86b048a5cb4] Merge branch 'for-next' =
of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
git bisect good 26f89f0614f03e4016578a992fc2e86b048a5cb4
# good: [602bf18307981f3bfd9ebf19921791a4256d3fd1] Merge branch 'for-6.7' i=
nto for-next
git bisect good 602bf18307981f3bfd9ebf19921791a4256d3fd1
# good: [9f16a68069822b1df6bfb8a9ef7258a1e32b25e7] Merge branch 'for-next' =
of git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching
git bisect good 9f16a68069822b1df6bfb8a9ef7258a1e32b25e7
# good: [3ff57db6f6569ebc2cc333437e7e949749e59424] Merge branch 'for-next' =
of git://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git
git bisect good 3ff57db6f6569ebc2cc333437e7e949749e59424
# bad: [dd374e220ba492f95344a638b1efe5b2744fdd73] slub: Update frozen slabs=
 documentations in the source
git bisect bad dd374e220ba492f95344a638b1efe5b2744fdd73
# good: [a3058965bb35490454953aa2c87ea51004839f2f] slub: Prepare __slab_fre=
e() for unfrozen partial slab out of node partial list
git bisect good a3058965bb35490454953aa2c87ea51004839f2f
# bad: [c8d312e039030edab25836a326bcaeb2a3d4db14] slub: Delay freezing of p=
artial slabs
git bisect bad c8d312e039030edab25836a326bcaeb2a3d4db14
# good: [00b15a19ee543f0117cb217fcbab8b7b3fd50677] slub: Introduce freeze_s=
lab()
git bisect good 00b15a19ee543f0117cb217fcbab8b7b3fd50677
# first bad commit: [c8d312e039030edab25836a326bcaeb2a3d4db14] slub: Delay =
freezing of partial slabs

--r03Gj3uw2DPOktWQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVbqlYACgkQJNaLcl1U
h9As1wf+PoCGkhnrfRDQeigxK+a/XJHAoID1jg3zQtqbZU+emI5HvQYoL3nYZRre
C7UyKPoKbsZF9bFXT59fPB0yyUep6K2BgFeGUO0GO3FxH2YxwxW+qelWCXGsx2rb
eoRGWAzOXFd3mHsI1XiQzLidyoAZJ5Iiyiw9scxkr5LX/4f2eRIpA1uutZntn2EP
a2rc7773k7S6D888v/qTiHKHTRG7Xt/Lqyi8M6q8KbI8OzzfrHgZb7elf2kLkZU4
5pETHKAFVcnm5cQX221J41BsO6I/VkLynWcYclkeONRAFQrLdAIN45XhVyIu/vMT
H8QlLDx1P9FarfaZRDMp2P32/g71DA==
=d4mo
-----END PGP SIGNATURE-----

--r03Gj3uw2DPOktWQ--
