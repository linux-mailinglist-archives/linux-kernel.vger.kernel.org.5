Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04DD782F18
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 19:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236960AbjHURIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 13:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbjHURIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 13:08:19 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 9A3F7101
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 10:08:16 -0700 (PDT)
Received: (qmail 124052 invoked by uid 1000); 21 Aug 2023 13:08:14 -0400
Date:   Mon, 21 Aug 2023 13:08:14 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+f7ac46d91cf13b4591a4@syzkaller.appspotmail.com>
Cc:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] INFO: task hung in get_bMaxPacketSize0
Message-ID: <45312cb5-47c2-44d7-a5ce-0745e878d810@rowland.harvard.edu>
References: <0000000000003d73d3060371a47e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000003d73d3060371a47e@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 09:48:01AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7271b2a53042 Add linux-next specific files for 20230818
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=10e05763a80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1936af09cdef7dd6
> dashboard link: https://syzkaller.appspot.com/bug?extid=f7ac46d91cf13b4591a4
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1085e265a80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14290117a80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/d81109bc02c1/disk-7271b2a5.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/4b3bf8e2a4f7/vmlinux-7271b2a5.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6404cd473c1e/bzImage-7271b2a5.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f7ac46d91cf13b4591a4@syzkaller.appspotmail.com
> 
> INFO: task kworker/0:1:9 blocked for more than 143 seconds.
>       Not tainted 6.5.0-rc6-next-20230818-syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/0:1     state:D stack:26768 pid:9     ppid:2      flags:0x00004000
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5382 [inline]
>  __schedule+0xee1/0x59f0 kernel/sched/core.c:6695
>  schedule+0xe7/0x1b0 kernel/sched/core.c:6771
>  usb_kill_urb.part.0+0x1c6/0x250 drivers/usb/core/urb.c:713
>  usb_kill_urb+0x83/0xa0 drivers/usb/core/urb.c:702
>  usb_start_wait_urb+0x251/0x4c0 drivers/usb/core/message.c:65
>  usb_internal_control_msg drivers/usb/core/message.c:103 [inline]
>  usb_control_msg+0x327/0x4a0 drivers/usb/core/message.c:154
>  get_bMaxPacketSize0.constprop.0+0xa5/0x1c0 drivers/usb/core/hub.c:4725
>  hub_port_init+0x680/0x3850 drivers/usb/core/hub.c:4921
>  hub_port_connect drivers/usb/core/hub.c:5369 [inline]
>  hub_port_connect_change drivers/usb/core/hub.c:5580 [inline]
>  port_event drivers/usb/core/hub.c:5740 [inline]
>  hub_event+0x2b64/0x4e00 drivers/usb/core/hub.c:5822
>  process_one_work+0x887/0x15d0 kernel/workqueue.c:2630
>  process_scheduled_works kernel/workqueue.c:2703 [inline]
>  worker_thread+0x8bb/0x1290 kernel/workqueue.c:2784
>  kthread+0x33a/0x430 kernel/kthread.c:388
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>  </TASK>

Although it's not apparent from the bug report, this bug appears to stem 
from a problem in the usbip drivers, as can be seen in the console 
output URL given above.

Apparently vhci_hcd sometimes fails to dequeue or complete an URB.  As a 
result, a process calling usb_kill_urb() can hang indefinitely.  This 
single issue is behind a bunch of outstanding syzbot bug reports.

Alan Stern
