Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6BF797DE6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 23:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240140AbjIGVWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 17:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236882AbjIGVWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 17:22:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8113B1BCD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 14:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=140hmqRwpbNsczWdMDyETCxbSX9aZJqKin5rA+N/GPs=; b=N65RrY6zT6k7YnV8HcR57sQGSr
        QWNzwXF0Hq6ax+ByBkEDfx+Arz9Swhz8u46ij/iVFOP66aYePNHvrewkjqyYZOv0xHGITUlN6V2IA
        LMu6aWoSKU3wO7opeyfSVxNVfSGC3UTOVUy/jSVBxmd/5pgtBCyHaP9giRvhv/FytB24yMckBrTZ7
        XfuIS8ktDAwMydfQ00OO3TCYa7bESUa2VfOEah1q91KGS/+rWtg+9im16xgOaqx8e+K0Q6QekVzX9
        YwylgUQj1e3LV0Z2xcTZEDyyQRujKNQ3IgPaurn5+NsKE7GUm0MpKclxmUlld+zErKdfgXwlRnER4
        Onv87eGA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qeMST-00DXQr-Fo; Thu, 07 Sep 2023 21:22:37 +0000
Date:   Thu, 7 Sep 2023 22:22:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sanan Hasanov <Sanan.Hasanov@ucf.edu>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "contact@pgazz.com" <contact@pgazz.com>
Subject: Re: WARNING in vma_merge
Message-ID: <ZPo/Hdan9JaYWor0@casper.infradead.org>
References: <BL0PR11MB3106699B27BB7C5FA07198BFE1EEA@BL0PR11MB3106.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR11MB3106699B27BB7C5FA07198BFE1EEA@BL0PR11MB3106.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 09:21:01PM +0000, Sanan Hasanov wrote:
> Good day, dear maintainers,
> 
> We found a bug using a modified kernel configuration file used by syzbot.
> 
> We enhanced the coverage of the configuration file using our tool, klocalizer.
> 
> Kernel Branch: 6.3.0-next-20230505

Two months ago?  Does it still happen?

> Kernel Config: https://drive.google.com/file/d/1pJaf39GNF64KX1Ac_sCfA89x13-IEGbB/view?usp=sharing
> Reproducer: https://drive.google.com/file/d/12qTKfwYWDB2U3vCJoCIQYZSkmNxgmCWa/view?usp=sharing
> 
> Thank you!
> 
> Best regards,
> Sanan Hasanov
> 
> ------------[ cut here ]------------
> WARNING: CPU: 2 PID: 20500 at mm/mmap.c:965 vma_merge+0x35a/0x1a30 mm/mmap.c:965
> Modules linked in:
> CPU: 2 PID: 20500 Comm: syz-executor.7 Not tainted 6.3.0-next-20230505 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:vma_merge+0x35a/0x1a30 mm/mmap.c:965
> Code: 8b 45 00 48 89 de 48 89 c7 48 89 85 08 ff ff ff e8 cb e1 bd ff 48 8b 85 08 ff ff ff 48 39 d8 0f 84 05 0d 00 00 e8 46 e7 bd ff <0f> 0b e8 3f e7 bd ff 4c 89 fe 48 89 df e8 a4 e1 bd ff 4c 39 fb 0f
> RSP: 0018:ffff88804c517af8 EFLAGS: 00010212
> RAX: 00000000000001d4 RBX: 0000000020ffe000 RCX: ffffc9000eea2000
> RDX: 0000000000040000 RSI: ffffffff81cfd44a RDI: ffffffff81cfd435
> RBP: ffff88804c517c20 R08: 0000000000000006 R09: 0000000020000000
> R10: 0000000020ffe000 R11: 0000000000000001 R12: ffff88807d091dd0
> R13: ffff88807d091ec8 R14: 0000000000000000 R15: 0000000021000000
> FS:  00007f2389746700(0000) GS:ffff888119f00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000000 CR3: 000000004ae38000 CR4: 0000000000350ee0
> Call Trace:
>  <TASK>
>  userfaultfd_register fs/userfaultfd.c:1485 [inline]
>  userfaultfd_ioctl+0x3915/0x4280 fs/userfaultfd.c:2050
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:870 [inline]
>  __se_sys_ioctl fs/ioctl.c:856 [inline]
>  __x64_sys_ioctl+0x1b0/0x220 fs/ioctl.c:856
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3f/0x90 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> RIP: 0033:0x7f238868edcd
> Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f2389745bf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f23887bbf80 RCX: 00007f238868edcd
> RDX: 0000000020000040 RSI: 00000000c020aa00 RDI: 0000000000000003
> RBP: 00007f23886fc59c R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fffc9301f7f R14: 00007fffc9302120 R15: 00007f2389745d80
> netlink: 9764 bytes leftover after parsing attributes in process `syz-executor.0'.
>  </TASK>
> irq event stamp: 603
> hardirqs last  enabled at (613): [<ffffffff816ff504>] __up_console_sem+0xf4/0x180 kernel/printk/printk.c:347
> hardirqs last disabled at (624): [<ffffffff816ff4e9>] __up_console_sem+0xd9/0x180 kernel/printk/printk.c:345
> softirqs last  enabled at (436): [<ffffffff8154f646>] invoke_softirq kernel/softirq.c:445 [inline]
> softirqs last  enabled at (436): [<ffffffff8154f646>] __irq_exit_rcu+0x196/0x230 kernel/softirq.c:650
> softirqs last disabled at (431): [<ffffffff8154f646>] invoke_softirq kernel/softirq.c:445 [inline]
> softirqs last disabled at (431): [<ffffffff8154f646>] __irq_exit_rcu+0x196/0x230 kernel/softirq.c:650
> ---[ end trace 0000000000000000 ]---
> EXT4-fs (loop5): bad geometry: first data block 4294967180 is beyond end of filesystem (512)
> netlink: 9764 bytes leftover after parsing attributes in process `syz-executor.0'.
> 
