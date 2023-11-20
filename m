Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF8D7F2176
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 00:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjKTXeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 18:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjKTXeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 18:34:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56CCC3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 15:34:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A18C433C8;
        Mon, 20 Nov 2023 23:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700523253;
        bh=UKOg81H8o/6iLNicPunApOZKAZR/qkOAnT2RKdCcu48=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=JxvM6Mk+ACcUm5jBwk19Mq1N9RK0Xgtb55yN7bVinpHN4eBfKVKxfL7fMBoRnomPu
         fMODuAQWxKAHRrwPqP+cs1TSEMh/hINshQ6Yt5jsPwPHbXb+niJ8CMtDC3Be1l8CcU
         WcZNdpb7Ayj2KspXvkF5W66+rqU7Dp76j4b5cwqTLRq43QYecRelytYWGPqMiANFgZ
         iXfGDSGc8iUmjkTV6IPcHkDvE9OdbOfvWIo1nH6Dx8WeLfa7SWqeEV67yWuLicz7FU
         bZa8b1dzshy7ESBaRX5zzNMNgESe2Qi6Ugc1yNnOf3B0P9dpPpVa9zOzlCsRp487k4
         YOjniDJ6XHNxg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 21 Nov 2023 01:34:10 +0200
Message-Id: <CX416KNURFJD.3OKJBUW8D5O2T@kernel.org>
Cc:     "Lukas Wunner" <lukas@wunner.de>, <linux-kernel@vger.kernel.org>
Subject: Re: tpm_tis_spi_remove() triggers WARN_ON() in __flushwork (RPi3B+
 and SLB9670)
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Lino Sanfilippo" <l.sanfilippo@kunbus.com>,
        <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <CX32RFOMJUQ0.3R4YCL9MDCB96@kernel.org>
 <CX342W32D30U.330BVFC336MA8@kernel.org>
 <8712ccc3-8619-41b8-97d0-d0187c0b59c6@kunbus.com>
In-Reply-To: <8712ccc3-8619-41b8-97d0-d0187c0b59c6@kunbus.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Nov 20, 2023 at 10:08 PM EET, Lino Sanfilippo wrote:
> Hi,
>
> On 19.11.23 22:37, Jarkko Sakkinen wrote:
>
> >=20
> > On Sun Nov 19, 2023 at 10:35 PM EET, Jarkko Sakkinen wrote:
> >> Captured from serial link with Raspberry Pi 3B+ and Infineon SLB9670 T=
PM2 chip, i.e.
> >> triggers here:
> >>
> >> static bool __flush_work(struct work_struct *work, bool from_cancel)
> >> {
> >>       struct wq_barrier barr;
> >>
> >>       if (WARN_ON(!wq_online))
> >>               return false;
> >>
> >>       if (WARN_ON(!work->func)) /* <-- */
> >>               return false;
> >>
> >>
> >> # uname -a
> >> Linux buildroot 6.6.1-v8 #1 SMP PREEMPT Sun Nov 19 21:46:00 EET 2023 a=
arch64 GNU/Linux
> >> # poweroff
> >> # Stopping dropbear sshd: OK
> >> Stopping network: [  246.487818] smsc95xx 3-1.1:1.0 eth0: hardware isn=
't capable of remote wakeup
> >> OK
> >> Stopping klogd: OK
> >> Stopping syslogd: OK
> >> Seeding 256 bits and crediting
> >> Saving 256 bits of creditable seed for next boot
> >> umount: devtmpfs busy - remounted read-only
> >> [  246.623163] EXT4-fs (mmcblk0p2): re-mounted c5bb63df-c03e-4e4a-9846=
-0cdf5986edc4 ro. Quota mode: none.
> >> The system is going down NOW!
> >> Sent SIGTERM to all processes
> >> Sent SIGKILL to al[  248.680154] ------------[ cut here ]------------
> >> [  248.684825] WARNING: CPU: 1 PID: 298 at kernel/workqueue.c:3400 __f=
lush_work.isra.0+0x29c/0x2c4
> >> [  248.693582] CPU: 1 PID: 298 Comm: init Tainted: G        W         =
 6.6.1-v8 #1
> >> [  248.700926] Hardware name: Raspberry Pi 3 Model B Rev 1.2 (DT)
> >> [  248.706780] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS B=
TYPE=3D--)
> >> [  248.713774] pc : __flush_work.isra.0+0x29c/0x2c4
> >> [  248.718415] lr : __flush_work.isra.0+0x44/0x2c4
> >> [  248.722970] sp : ffffffc0812fb910
> >> [  248.726299] x29: ffffffc0812fb910 x28: ffffff8003e30e40 x27: 000000=
0000000000
> >> [  248.733481] x26: fffffff0350c9c10 x25: 0000000000000000 x24: ffffff=
f03500c028
> >> [  248.740661] x23: fffffff03500d208 x22: 0000000000000001 x21: ffffff=
f034f37568
> >> [  248.747840] x20: ffffff80064d9ac0 x19: ffffff80064d9a80 x18: ffffff=
ffffffffff
> >> [  248.755019] x17: 0000000000000000 x16: 0000000000000000 x15: ffffff=
c0812fb760
> >> [  248.762197] x14: 0000000000000004 x13: ffffff8002808410 x12: 000000=
0000000000
> >> [  248.769376] x11: 0000000000000040 x10: fffffff034f35a98 x9 : 000000=
0000000004
> >> [  248.776554] x8 : ffffffc0812fb9a8 x7 : 0000000000000000 x6 : 000000=
00000003e8
> >> [  248.783732] x5 : fffffff034e46000 x4 : 0000000000000000 x3 : 000000=
0000000000
> >> [  248.790909] x2 : 0000000000000008 x1 : 0000000000000000 x0 : 000000=
0000000000
> >> [  248.798087] Call trace:
> >> [  248.800546]  __flush_work.isra.0+0x29c/0x2c4
> >> [  248.804841]  flush_work+0x10/0x1c
> >> [  248.808177]  tpm_tis_remove+0x90/0xc8
> >> [  248.811866]  tpm_tis_spi_remove+0x24/0x34
> >> [  248.815901]  spi_remove+0x30/0x4c
> >> [  248.819238]  device_remove+0x4c/0x80
> >> [  248.822836]  device_release_driver_internal+0x1d4/0x228
> >> [  248.828088]  device_release_driver+0x18/0x24
> >> [  248.832381]  bus_remove_device+0xcc/0x10c
> >> [  248.836421]  device_del+0x15c/0x41c
> >> [  248.839934]  spi_unregister_device+0x48/0x98
> >> [  248.844231]  __unregister+0x10/0x20
> >> [  248.847742]  device_for_each_child+0x60/0xb4
> >> [  248.852037]  spi_unregister_controller+0x48/0x15c
> >> [  248.856768]  bcm2835_spi_remove+0x20/0x60
> >> [  248.860804]  platform_shutdown+0x24/0x34
> >> [  248.864751]  device_shutdown+0x150/0x258
> >> [  248.868701]  kernel_power_off+0x38/0x7c
> >> [  248.872563]  __do_sys_reboot+0x200/0x238
> >> [  248.876511]  __arm64_sys_reboot+0x24/0x30
> >> [  248.880546]  invoke_syscall+0x48/0x114
> >> [  248.884324]  el0_svc_common.constprop.0+0x40/0xe0
> >> [  248.889057]  do_el0_svc+0x1c/0x28
> >> [  248.892397]  el0_svc+0x40/0xe8
> >> [  248.895478]  el0t_64_sync_handler+0x100/0x12c
> >> [  248.899864]  el0t_64_sync+0x190/0x194
> >> [  248.903549] ---[ end trace 0000000000000000 ]---
> >> [  248.910555] reboot: Power down
> >>
> >> Just putting out. I was testing https://github.com/jarkkojs/buildroot-=
tpmdd/tree/linux-6.6.y
> >> and this popped up. To build sdcard.img bootable with Raspberry Pi 3:
> >>
> >> make raspberrypi3_tpmdd_64_defconfig && make
> >>
> >> BR, Jarkko
> >=20
> > So I applied [1] and now I get a clean shutdown:
> >=20
>
> AFAIU the warning is shown in case that interrupts are not enabled and th=
us INIT_WORK has not
> been called for free_irq_work. This should not be too hard to fix, so I t=
hink I can provide=20
> a patch for that, soon.

Agreed, and take your time. I just captured without further analysis so
that does not get lost, that's all. Thanks for looking into it.

> BR,
> Lino

BR, Jarkko
