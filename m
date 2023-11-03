Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0516B7E053B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 16:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbjKCPEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 11:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbjKCPEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 11:04:45 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 63964D56
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 08:04:38 -0700 (PDT)
Received: (qmail 850690 invoked by uid 1000); 3 Nov 2023 11:04:36 -0400
Date:   Fri, 3 Nov 2023 11:04:36 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     syzbot <syzbot+b6f11035e572f08bc20f@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] INFO: task hung in hub_port_init (3)
Message-ID: <ff0083c2-249e-4c1e-9546-0b81cf2c6e6f@rowland.harvard.edu>
References: <000000000000704d6305fdb75642@google.com>
 <88cc734c-2a88-4495-aa1e-f16294eb6cea@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88cc734c-2a88-4495-aa1e-f16294eb6cea@collabora.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 07:03:20PM +0500, Muhammad Usama Anjum wrote:
> On 6/10/23 12:25 AM, syzbot wrote:
> > syzbot has found a reproducer for the following issue on:
> > 
> > HEAD commit:    33f2b5785a2b Merge tag 'drm-fixes-2023-06-09' of git://ano..
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=1206f143280000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3c980bfe8b399968
> > dashboard link: https://syzkaller.appspot.com/bug?extid=b6f11035e572f08bc20f
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1676f51b280000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=129632fd280000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/a817d99af39d/disk-33f2b578.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/8916e1d053fc/vmlinux-33f2b578.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/e53956f3cfd4/bzImage-33f2b578.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+b6f11035e572f08bc20f@syzkaller.appspotmail.com
> > 
> > INFO: task kworker/0:2:901 blocked for more than 143 seconds.
> >       Not tainted 6.4.0-rc5-syzkaller-00178-g33f2b5785a2b #0
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > task:kworker/0:2     state:D stack:26800 pid:901   ppid:2      flags:0x00004000
> > Workqueue: usb_hub_wq hub_event
> > Call Trace:
> >  <TASK>
> >  context_switch kernel/sched/core.c:5343 [inline]
> >  __schedule+0xc9a/0x5880 kernel/sched/core.c:6669
> >  schedule+0xde/0x1a0 kernel/sched/core.c:6745
> >  usb_kill_urb.part.0+0x19a/0x220 drivers/usb/core/urb.c:728
> >  usb_kill_urb+0x83/0xa0 drivers/usb/core/urb.c:717
> >  usb_start_wait_urb+0x24a/0x4b0 drivers/usb/core/message.c:64
> >  usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
> >  usb_control_msg+0x320/0x4a0 drivers/usb/core/message.c:153
> >  hub_port_init+0x14f3/0x3900 drivers/usb/core/hub.c:4874
> >  hub_port_connect drivers/usb/core/hub.c:5336 [inline]
> >  hub_port_connect_change drivers/usb/core/hub.c:5551 [inline]
> >  port_event drivers/usb/core/hub.c:5711 [inline]
> >  hub_event+0x2b89/0x4e40 drivers/usb/core/hub.c:5793
> >  process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
> >  worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
> >  kthread+0x344/0x440 kernel/kthread.c:379
> >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
> >  </TASK>
> > INFO: task syz-executor104:5004 blocked for more than 143 seconds.
> This is being reproduced on linux-next. The USB IP is being fuzzed. I'd
> modified the reproducer to try to understand the issue. The execution of
> application creates kworkers (can be found in hub->events). One of the usb
> hub kworker gets stuck because of wrong use_count. I don't know USB side of
> logic. But a worker shouldn't go to sleep indefinitely.

I doubt that the problem is a wrong value for use_count.  More likely
it's a bug in the usbip driver.

> My debug logs are as following which can help an expert USB developer to
> pin point the problem:
> 
> [  118.904272][    T9] usb_submit_urb urb->use_count: 0
> [  118.904942][    T9] usb_hcd_submit_urb urb->use_count: 1
> [  118.905715][    T9] usb_submit_urb urb->use_count: 1
> [  118.906428][    T9] usb_start_wait_urb urb->use_count: 1
> [  123.938978][    T9] usb_kill_urb use_count: 1

These don't mean much because they don't give the address of urb, so
we don't know if the various lines all refer to the same URB or to
different ones.

> At this point, wait is being done on usb_kill_urb_queue as use_count isn't
> zero and no event on usb_kill_urb_queue is received.

Right.  The usbip driver is supposed to terminate the URB in a timely
fashion (because usb_kill_urb() calls usb_hcd_unlink_urb()), but it
isn't doing so.  When the URB completes, the event will occur.

> The comment for usb_kill_urb is:
> > * This routine may not be used in an interrupt context (such as a bottom
> > * half or a completion handler), or when holding a spinlock, or in other
> > * situations where the caller can't schedule().
> 
> But several locks are held by this kworker and sleeps indefinitely.

No spinlocks are held, only mutexes.  The difference is that a task is
allowed to sleep while holding a mutex, but it's not allowed to sleep
while holding a spinlock.

If you want to fix this problem (and probably a bunch of other ones in
syzbot's list of pending bugs), figure out what's wrong with the
->urb_dequeue() callback routine in the usbip driver and fix it.

Alan Stern
