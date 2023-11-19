Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5D97F092A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 22:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjKSVhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 16:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbjKSVhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 16:37:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7DF103
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 13:37:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A925FC433C8;
        Sun, 19 Nov 2023 21:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700429868;
        bh=SOUSzxWFpGvTFg8xsNhCOyw7D4dQ6NcCou4fwO6LN3g=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=egyAyFsF6+WNiGOEYzYL6yiLf3G5YeaGGcMdJwvl4JzxaWfJmnF3TijauX1nA1qIS
         DgBmeX8a2aicHITiOeKeGR/E1lclFH5HoKJKVbS1yqV2eVOlnYaGcjPZNAaxFulL4z
         pDeFYViXzjMuDgc85OngtlX2yDXAXY47MslcdBzvR288w07tALyNKIkSuCuGFIRjUO
         jX/kcbdInI3xRiQT4KDi7ULtz+j7wSRoj57wA6QuuAg1NMoOB2WvyVcz1SRWiZ2Jx+
         VhK/oA/dC9tUSPZ5tgFB+yfioftM/8aUKhxzlTxQEFvI8eXOlDL8AgNCkrrp9u2Eq+
         TVb5QiujghUPA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 19 Nov 2023 23:37:45 +0200
Message-Id: <CX342W32D30U.330BVFC336MA8@kernel.org>
Cc:     "Lukas Wunner" <lukas@wunner.de>, <linux-kernel@vger.kernel.org>
Subject: Re: tpm_tis_spi_remove() triggers WARN_ON() in __flushwork (RPi3B+
 and SLB9670)
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     <linux-integrity@vger.kernel.org>,
        "Lino Sanfilippo" <l.sanfilippo@kunbus.com>
X-Mailer: aerc 0.15.2
References: <CX32RFOMJUQ0.3R4YCL9MDCB96@kernel.org>
In-Reply-To: <CX32RFOMJUQ0.3R4YCL9MDCB96@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Nov 19, 2023 at 10:35 PM EET, Jarkko Sakkinen wrote:
> Captured from serial link with Raspberry Pi 3B+ and Infineon SLB9670 TPM2=
 chip, i.e.
> triggers here:
>
> static bool __flush_work(struct work_struct *work, bool from_cancel)
> {
> 	struct wq_barrier barr;
>
> 	if (WARN_ON(!wq_online))
> 		return false;
>
> 	if (WARN_ON(!work->func)) /* <-- */
> 		return false;
>
>
> # uname -a
> Linux buildroot 6.6.1-v8 #1 SMP PREEMPT Sun Nov 19 21:46:00 EET 2023 aarc=
h64 GNU/Linux
> # poweroff
> # Stopping dropbear sshd: OK
> Stopping network: [  246.487818] smsc95xx 3-1.1:1.0 eth0: hardware isn't =
capable of remote wakeup
> OK
> Stopping klogd: OK
> Stopping syslogd: OK
> Seeding 256 bits and crediting
> Saving 256 bits of creditable seed for next boot
> umount: devtmpfs busy - remounted read-only
> [  246.623163] EXT4-fs (mmcblk0p2): re-mounted c5bb63df-c03e-4e4a-9846-0c=
df5986edc4 ro. Quota mode: none.
> The system is going down NOW!
> Sent SIGTERM to all processes
> Sent SIGKILL to al[  248.680154] ------------[ cut here ]------------
> [  248.684825] WARNING: CPU: 1 PID: 298 at kernel/workqueue.c:3400 __flus=
h_work.isra.0+0x29c/0x2c4
> [  248.693582] CPU: 1 PID: 298 Comm: init Tainted: G        W          6.=
6.1-v8 #1
> [  248.700926] Hardware name: Raspberry Pi 3 Model B Rev 1.2 (DT)
> [  248.706780] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [  248.713774] pc : __flush_work.isra.0+0x29c/0x2c4
> [  248.718415] lr : __flush_work.isra.0+0x44/0x2c4
> [  248.722970] sp : ffffffc0812fb910
> [  248.726299] x29: ffffffc0812fb910 x28: ffffff8003e30e40 x27: 000000000=
0000000
> [  248.733481] x26: fffffff0350c9c10 x25: 0000000000000000 x24: fffffff03=
500c028
> [  248.740661] x23: fffffff03500d208 x22: 0000000000000001 x21: fffffff03=
4f37568
> [  248.747840] x20: ffffff80064d9ac0 x19: ffffff80064d9a80 x18: fffffffff=
fffffff
> [  248.755019] x17: 0000000000000000 x16: 0000000000000000 x15: ffffffc08=
12fb760
> [  248.762197] x14: 0000000000000004 x13: ffffff8002808410 x12: 000000000=
0000000
> [  248.769376] x11: 0000000000000040 x10: fffffff034f35a98 x9 : 000000000=
0000004
> [  248.776554] x8 : ffffffc0812fb9a8 x7 : 0000000000000000 x6 : 000000000=
00003e8
> [  248.783732] x5 : fffffff034e46000 x4 : 0000000000000000 x3 : 000000000=
0000000
> [  248.790909] x2 : 0000000000000008 x1 : 0000000000000000 x0 : 000000000=
0000000
> [  248.798087] Call trace:
> [  248.800546]  __flush_work.isra.0+0x29c/0x2c4
> [  248.804841]  flush_work+0x10/0x1c
> [  248.808177]  tpm_tis_remove+0x90/0xc8
> [  248.811866]  tpm_tis_spi_remove+0x24/0x34
> [  248.815901]  spi_remove+0x30/0x4c
> [  248.819238]  device_remove+0x4c/0x80
> [  248.822836]  device_release_driver_internal+0x1d4/0x228
> [  248.828088]  device_release_driver+0x18/0x24
> [  248.832381]  bus_remove_device+0xcc/0x10c
> [  248.836421]  device_del+0x15c/0x41c
> [  248.839934]  spi_unregister_device+0x48/0x98
> [  248.844231]  __unregister+0x10/0x20
> [  248.847742]  device_for_each_child+0x60/0xb4
> [  248.852037]  spi_unregister_controller+0x48/0x15c
> [  248.856768]  bcm2835_spi_remove+0x20/0x60
> [  248.860804]  platform_shutdown+0x24/0x34
> [  248.864751]  device_shutdown+0x150/0x258
> [  248.868701]  kernel_power_off+0x38/0x7c
> [  248.872563]  __do_sys_reboot+0x200/0x238
> [  248.876511]  __arm64_sys_reboot+0x24/0x30
> [  248.880546]  invoke_syscall+0x48/0x114
> [  248.884324]  el0_svc_common.constprop.0+0x40/0xe0
> [  248.889057]  do_el0_svc+0x1c/0x28
> [  248.892397]  el0_svc+0x40/0xe8
> [  248.895478]  el0t_64_sync_handler+0x100/0x12c
> [  248.899864]  el0t_64_sync+0x190/0x194
> [  248.903549] ---[ end trace 0000000000000000 ]---
> [  248.910555] reboot: Power down
>
> Just putting out. I was testing https://github.com/jarkkojs/buildroot-tpm=
dd/tree/linux-6.6.y
> and this popped up. To build sdcard.img bootable with Raspberry Pi 3:
>
> make raspberrypi3_tpmdd_64_defconfig && make
>
> BR, Jarkko

So I applied [1] and now I get a clean shutdown:

# poweroff
# Stopping dropbear sshd: OK
Stopping network: [   66.189514] smsc95xx 3-1.1:1.0 eth0: hardware isn't ca=
pable of remote wakeup
OK
Stopping klogd: OK
Stopping syslogd: OK
Seeding 256 bits and crediting
Saving 256 bits of creditable seed for next boot
umount: devtmpfs busy - remounted read-only
[   66.353850] EXT4-fs (mmcblk0p2): re-mounted 6accf2b0-3291-4e1e-90e0-1c75=
802d14cd ro. Quota mode: none.
The system is going down NOW!
Sent SIGTERM to all processes
Sent SIGKILL to a[   68.412015] reboot: Power down

[1] https://github.com/jarkkojs/buildroot-tpmdd/blob/linux-6.6.y/patches/li=
nux/0001-Revert-tpm-tpm_tis-Disable-interrupts-after-1000-unh.patch

BR, Jarkko
