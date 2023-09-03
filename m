Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF6D790EDB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 00:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240826AbjICV76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 17:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjICV75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 17:59:57 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB8AF2
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 14:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1693778390;
        bh=iaEr2Ad1rh5CSPJ4/BZva+k0cXiqW1jY+j/CTCtNrWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZD3lQPSGFYzUeY/cGmQldPyavmcw6zgKbFJt0VL9XqGerRnz5ttLAEerazscIP070
         0qXvqAlrB74/lq28AYuIt6Sp1HVhJFQOok6B6ZJHPpSLAYB5EbOxDw6zUJq+dDHF9H
         mr3pG8JiZFwy/pJ3Ym9+5COWFn0zvUH07tk90pjk=
Date:   Sun, 3 Sep 2023 23:59:48 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     syzbot <syzbot+85792f3143e6271d2c97@syzkaller.appspotmail.com>
Cc:     andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] general protection fault in
 tty_register_device_attr
Message-ID: <1527ac63-85a6-4813-94f2-bb76ed665236@t-8ch.de>
References: <0000000000007b589e0604578e70@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007b589e0604578e70@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-01 20:05:59-0700, syzbot wrote:
> [..]

> general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 1 PID: 5046 Comm: syz-executor362 Not tainted 6.5.0-next-20230828-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
> RIP: 0010:strchr+0x1b/0xb0 lib/string.c:329
> Code: a3 ac f7 48 8b 74 24 08 48 8b 14 24 eb 89 90 f3 0f 1e fa 48 b8 00 00 00 00 00 fc ff df 48 89 fa 55 48 c1 ea 03 53 48 83 ec 10 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 51 0f b6 07 89
> RSP: 0018:ffffc90003a1f800 EFLAGS: 00010286
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000025 RDI: 0000000000000000
> RBP: ffffc90003a1f890 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000000 R12: ffffc90003a1f890
> R13: 0000000000000cc0 R14: ffff888014a96000 R15: 0000000000000001
> FS:  0000555556b43480(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005584fe812978 CR3: 00000000729c5000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  kvasprintf_const+0x25/0x190 lib/kasprintf.c:45
>  kobject_set_name_vargs+0x5a/0x130 lib/kobject.c:272
>  kobject_add_varg lib/kobject.c:366 [inline]
>  kobject_add+0x12a/0x240 lib/kobject.c:424
>  device_add+0x290/0x1ac0 drivers/base/core.c:3560
>  tty_register_device_attr+0x38f/0x7b0 drivers/tty/tty_io.c:3248
>  gsm_register_devices drivers/tty/n_gsm.c:654 [inline]
>  gsm_activate_mux+0x157/0x2d0 drivers/tty/n_gsm.c:3138
>  gsm_config drivers/tty/n_gsm.c:3383 [inline]
>  gsmld_ioctl+0x8cc/0x1550 drivers/tty/n_gsm.c:3786
>  tty_ioctl+0x706/0x1580 drivers/tty/tty_io.c:2785
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:871 [inline]
>  __se_sys_ioctl fs/ioctl.c:857 [inline]
>  __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd

> [..]

#syz dup: general protection fault in netdev_register_kobject

With patch from Andy:

https://lore.kernel.org/all/20230828145824.3895288-1-andriy.shevchenko@linux.intel.com/
