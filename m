Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CAF75D22F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 20:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjGUS45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 14:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjGUS44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 14:56:56 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 6C03A35BD
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 11:56:45 -0700 (PDT)
Received: (qmail 1765232 invoked by uid 1000); 21 Jul 2023 14:56:44 -0400
Date:   Fri, 21 Jul 2023 14:56:44 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Khazhy Kumykov <khazhy@google.com>
Cc:     syzbot <syzbot+18996170f8096c6174d0@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] KASAN: slab-out-of-bounds Read in
 read_descriptors (3)
Message-ID: <69cddb70-771c-4ded-a14e-b46ce6413eb4@rowland.harvard.edu>
References: <000000000000c0ffe505fe86c9ca@google.com>
 <CACGdZYJVYXA1gYTx+fvLa6H443+4SXLgG-iJcE7wQYSh+0aOzg@mail.gmail.com>
 <CACGdZYK8FupYqA2CoqoDjS4i=FvG1+ie7fG2MENHtuxspC0-Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGdZYK8FupYqA2CoqoDjS4i=FvG1+ie7fG2MENHtuxspC0-Dg@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 11:23:10AM -0700, Khazhy Kumykov wrote:
> On Fri, Jul 21, 2023 at 11:10 AM Khazhy Kumykov <khazhy@google.com> wrote:
> >
> > On Mon, Jun 19, 2023 at 7:56 PM syzbot
> > <syzbot+18996170f8096c6174d0@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    40f71e7cd3c6 Merge tag 'net-6.4-rc7' of git://git.kernel.o..
> > > git tree:       upstream
> > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=1581445b280000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=ac246111fb601aec
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=18996170f8096c6174d0
> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d23487280000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16613ed3280000
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/30922ad38c58/disk-40f71e7c.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/3bd12e7503b8/vmlinux-40f71e7c.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/1dcd340b18d4/bzImage-40f71e7c.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+18996170f8096c6174d0@syzkaller.appspotmail.com
> > >
> > > ==================================================================
> > > BUG: KASAN: slab-out-of-bounds in read_descriptors+0x263/0x280 drivers/usb/core/sysfs.c:883
> > > Read of size 8 at addr ffff88801e78b8c8 by task udevd/5011
> > >
> > > CPU: 0 PID: 5011 Comm: udevd Not tainted 6.4.0-rc6-syzkaller-00195-g40f71e7cd3c6 #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
> > > Call Trace:
> > >  <TASK>
> > >  __dump_stack lib/dump_stack.c:88 [inline]
> > >  dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
> > >  print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:351
> > >  print_report mm/kasan/report.c:462 [inline]
> > >  kasan_report+0x11c/0x130 mm/kasan/report.c:572
> >
> > "src = udev->rawdescriptors[cfgno]" (so, just reading rawdescriptors)
> >
> > >  read_descriptors+0x263/0x280 drivers/usb/core/sysfs.c:883
> > >  sysfs_kf_bin_read+0x19a/0x270 fs/sysfs/file.c:97
> > >  kernfs_file_read_iter fs/kernfs/file.c:251 [inline]
> > >  kernfs_fop_read_iter+0x387/0x690 fs/kernfs/file.c:280
> > >  call_read_iter include/linux/fs.h:1862 [inline]
> > >  new_sync_read fs/read_write.c:389 [inline]
> > >  vfs_read+0x4b1/0x8a0 fs/read_write.c:470
> > >  ksys_read+0x12b/0x250 fs/read_write.c:613
> > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
> > >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > RIP: 0033:0x7f07c7916b6a
> > > Code: 00 3d 00 00 41 00 75 0d 50 48 8d 3d 2d 08 0a 00 e8 ea 7d 01 00 31 c0 e9 07 ff ff ff 64 8b 04 25 18 00 00 00 85 c0 75 1b 0f 05 <48> 3d 00 f0 ff ff 76 6c 48 8b 15 8f a2 0d 00 f7 d8 64 89 02 48 83
> > > RSP: 002b:00007ffdf34973d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f07c7916b6a
> > > RDX: 0000000000010011 RSI: 00007ffdf3497407 RDI: 0000000000000008
> > > RBP: 0000000000000008 R08: 0000000000000003 R09: f4f13e10193fbafe
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 000055be37470e10
> > > R13: 00007ffdf34a7ae8 R14: 00007ffdf34a8138 R15: 00007ffdf3497407
> > >  </TASK>
> > >
> > > Allocated by task 758:
> > >  kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
> > >  kasan_set_track+0x25/0x30 mm/kasan/common.c:52
> > >  ____kasan_kmalloc mm/kasan/common.c:374 [inline]
> > >  ____kasan_kmalloc mm/kasan/common.c:333 [inline]
> > >  __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
> > >  kasan_kmalloc include/linux/kasan.h:196 [inline]
> > >  __do_kmalloc_node mm/slab_common.c:966 [inline]
> > >  __kmalloc+0x5e/0x190 mm/slab_common.c:979
> > >  kmalloc include/linux/slab.h:563 [inline]
> > >  kzalloc include/linux/slab.h:680 [inline]
> >
> > kzmalloc(length) -> this length derived from dev->descriptor.bNumConfigurations
> >
> > The corresponding kfree is in usb_destroy_configuration (makes sense)
> > - we also set rawdescriptors to NULL here. If this race was happening,
> > I'd also expect some sort of null deref report...
> >
> > Stumbled upon https://lore.kernel.org/all/1599201467-11000-1-git-send-email-prime.zeng@hisilicon.com/T/,
> > which suggests that we can, instead, race with a descriptor change,
> > which sounds plausible - descriptor changes, bNumConfigurations no
> > longer lines up with our kmalloc... so we may run past the end of it.
> Ah yeah, the syzbot C repro does something like this, it has a virtual
> usb and keeps changing the descs -> which may end up calling
> hub_port_connect_change()

Yes, that sounds right.

The problem-causing commit is 45bf39f8df7f ("USB: core: Don't hold 
device lock while reading the "descriptors" sysfs file").  When writing 
the commit message I only considered changes to the rawdescriptors; it 
didn't occur to me that the device descriptor might also change, which 
would be just as dangerous.

> > Looking at hub_port_connect_change(), we seem to read directly into
> > udev->descriptor, check if it changed, and if it did, set
> > udev->descriptor back to the old one...? If we have an ongoing sysfs
> > read, which directly touches udev->descriptor, there might be
> > trouble...
> >
> > I see this is called in both hub_port_connect_change() and
> > usb_reset_and_verify_device()... which both seem to lock the port_dev?
> > ("port_dev->status_lock"). This looks like a different lock than
> > usb_lock_device_interruptible would grab, maybe the code has changed
> > since that was reported in 2020. But it seems to suggest we want to
> > grab this lock in sysfs to safely read from udev->descriptor.
> >
> > (I'm not clear on when the sysfs gets added/removed, since it happens
> > in usb_bus_notify()..., the above two functions that touch
> > udev->descriptor don't look like they send the
> > BUS_NOTIFY_ADD/DEL_DEVICE to me, so the race seems plausible)
> 
> Ah yeah - in hub_port_connect_change() we call hub_port_connect() if
> the descriptor changed, which notifies us of device remove *after* we
> already directly messed with udev->descriptor for a potentially live
> device.
> 
> I do see there's several sysfs files that directly read
> udev->descriptor with no locking - should these all need to grab the
> port_dev->status_lock?

I suppose some of them should.  (For others, the caller will already 
hold the device lock.)

On the other hand, it would almost certainly be simpler if 
hub_port_connect_change() and the other places calling 
usb_get_device_descriptor() would read into a temporary buffer instead 
of directly into udev->descriptor.  Do you think the problem could be 
solved this way?  It would be cleaner in the end.

Alan Stern
