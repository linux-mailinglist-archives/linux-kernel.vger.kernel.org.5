Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD187B6F32
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 19:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240546AbjJCRAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 13:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjJCRAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 13:00:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0C7A6;
        Tue,  3 Oct 2023 10:00:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258EEC433C8;
        Tue,  3 Oct 2023 17:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696352437;
        bh=EF5z7iSoky2rCRNqzW4HjSV0xBmUsLBH4hB9U/8wd5o=;
        h=From:To:Cc:Subject:Date:From;
        b=Kf8y2Cq+Aa1jNerpxYS+gJ0nbDvEvHGKNuqoQQmtkNWYnT6ebpdsMR2yxvQ9I7Zyl
         yqiY1So9ZMi+Trwo8/OIJ+ohF6PYus4pvOW/jyCDN2ZKU9QqZda7Br7YePs14TyPZw
         6gq69JgySOTUfAymy+pr6gYPiDt5IZoeU8umD2AGg1WUeaGa08/7lVf6A92KwEbsAk
         PKEVph+c+CLNQUDiY/AJqilJTGfyf1D2FJkD8k3MpZbtgAGfNVnZpl0odhVizGPd2l
         EXUHAHC+uG4/s9dZIOkGtq+8vsedqb8G7zGBgMqWRtZGd9BmFeqPqtPU2287MnQPr+
         cZ+r0/gLxtP4Q==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>,
        Fedor Pchelkin <pchelkin@ispras.ru>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com
Subject: [PATCH 1/1] tty: n_gsm: Avoid sleeping during .write() whilst atomic
Date:   Tue,  3 Oct 2023 18:00:20 +0100
Message-ID: <20231003170020.830242-1-lee@kernel.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fundamental issue here is that gsmld_write() uses spin_lock_irqsave()
to ensure mutual exclusion.  spin_lock_irqsave() disables IRQs,
essentially placing the thread of execution into atomic mode and
therefore must not sleep at any point.  Unfortunately, the call chain
eventually ends up in __might_resched() which complains loudly.

The BUG() splat looks like this:

    BUG: sleeping function called from invalid context at kernel/printk/printk.c:2627
    in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 13029, name: (agetty)
    preempt_count: 1, expected: 0
    RCU nest depth: 0, expected: 0
    3 locks held by (agetty)/13029:
     #0: ffff888112fc70a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x21/0x70
     #1: ffff888112fc7130 (&tty->atomic_write_lock){+.+.}-{3:3}, at: file_tty_write+0x1e4/0x9d0
     #2: ffff8881053c73e0 (&gsm->tx_lock){....}-{2:2}, at: gsmld_write+0x5b/0x120
    irq event stamp: 2506
    hardirqs last  enabled at (2505): [<ffffffff8b007b0e>] syscall_enter_from_user_mode+0x2e/0x1a0
    hardirqs last disabled at (2506): [<ffffffff8b0ab5cc>] _raw_spin_lock_irqsave+0xac/0x120
    softirqs last  enabled at (514): [<ffffffff81561c9c>] __irq_exit_rcu+0xec/0x160
    softirqs last disabled at (509): [<ffffffff81561c9c>] __irq_exit_rcu+0xec/0x160
    Preemption disabled at:
    [<0000000000000000>] 0x0
    CPU: 1 PID: 13029 Comm: (agetty) Not tainted 6.6.0-rc3-next-20230929-00002-gcdf323998d5b #17
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
    Call Trace:
     <TASK>
     dump_stack_lvl+0x1e3/0x2d0
     ? nf_tcp_handle_invalid+0x650/0x650
     ? panic+0x8a0/0x8a0
     __might_resched+0x5ce/0x790
     ? __might_sleep+0xc0/0xc0
     ? reacquire_held_locks+0x680/0x680
     console_lock+0x1c/0x1b0
     do_con_write+0x118/0x7410
     ? stack_trace_snprint+0xf0/0xf0
     ? lockdep_unlock+0x163/0x300
     ? lockdep_unlock+0x163/0x300
     ? mark_lock+0x2a0/0x350
     ? __lock_acquire+0x1302/0x2050
     ? vt_resize+0xc0/0xc0
     ? do_raw_spin_lock+0x147/0x3a0
     ? __rwlock_init+0x140/0x140
     ? _raw_spin_lock_irqsave+0xdd/0x120
     ? _raw_spin_lock+0x40/0x40
     con_write+0x29/0x640
     ? check_heap_object+0x249/0x870
     gsmld_write+0xf9/0x120
     ? gsmld_read+0x10/0x10
     file_tty_write+0x57c/0x9d0
     vfs_write+0x77d/0xaf0
     ? file_end_write+0x250/0x250
     ? tty_ioctl+0x8fa/0xbc0
     ? __fdget_pos+0x1d2/0x330
     ksys_write+0x19b/0x2c0
      ? print_irqtrace_events+0x220/0x220
     ? __ia32_sys_read+0x80/0x80
     ? syscall_enter_from_user_mode+0x2e/0x1a0
     ? syscall_enter_from_user_mode+0x2e/0x1a0
     do_syscall_64+0x2b/0x70
     entry_SYSCALL_64_after_hwframe+0x63/0xcd
    RIP: 0033:0x7f76546101b0

The important part of the call stack being:

  gsmld_write()             # Takes a lock and disables IRQs
    con_write()
      console_lock()
        __might_sleep()
          __might_resched() # Complains that IRQs are disabled

To fix this, let's ensure mutual exclusion by using a protected shared
variable (busy) instead.  We'll use the current locking mechanism to
protect it, but ensure that the locks are released and IRQs re-enabled
by the time we transit further down the call chain which may sleep.

Cc: Daniel Starke <daniel.starke@siemens.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Reported-by: syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/tty/n_gsm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 1f3aba607cd51..b83a97d58381f 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -270,6 +270,7 @@ struct gsm_mux {
 	struct tty_struct *tty;		/* The tty our ldisc is bound to */
 	spinlock_t lock;
 	struct mutex mutex;
+	bool busy;
 	unsigned int num;
 	struct kref ref;
 
@@ -3253,6 +3254,7 @@ static struct gsm_mux *gsm_alloc_mux(void)
 	gsm->dead = true;	/* Avoid early tty opens */
 	gsm->wait_config = false; /* Disabled */
 	gsm->keep_alive = 0;	/* Disabled */
+	gsm->busy = false;
 
 	/* Store the instance to the mux array or abort if no space is
 	 * available.
@@ -3718,11 +3720,21 @@ static ssize_t gsmld_write(struct tty_struct *tty, struct file *file,
 
 	ret = -ENOBUFS;
 	spin_lock_irqsave(&gsm->tx_lock, flags);
+	if (gsm->busy) {
+		spin_unlock_irqrestore(&gsm->tx_lock, flags);
+		return -EBUSY;
+	}
+	gsm->busy = true;
+	spin_unlock_irqrestore(&gsm->tx_lock, flags);
+
 	space = tty_write_room(tty);
 	if (space >= nr)
 		ret = tty->ops->write(tty, buf, nr);
 	else
 		set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
+
+	spin_lock_irqsave(&gsm->tx_lock, flags);
+	gsm->busy = false;
 	spin_unlock_irqrestore(&gsm->tx_lock, flags);
 
 	return ret;
-- 
2.42.0.582.g8ccd20d70d-goog

