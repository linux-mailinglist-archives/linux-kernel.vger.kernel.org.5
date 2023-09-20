Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC587A7BA0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 13:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbjITLyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 07:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbjITLx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:53:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C59BA3;
        Wed, 20 Sep 2023 04:53:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94486C433C7;
        Wed, 20 Sep 2023 11:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210831;
        bh=2Wid6czrTEuk4bdVMbpgvq4dLWr7BlIxoN00MZqYWZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jPJgClVL9u6w90lJs/MYfy2aLeuXUvPwIMSX78QqCnnzKYHxRPy2QE+VujAlxDjIw
         HYRgqeZCGO62FleHRJr9Rjrq2vbMqwtLyDnAIo4GOq+l432xFs27tFj44GYrZ6Xqna
         UFWOlgOpyGCoGqPz9YTARejdNfUbFkOzGsQ6zq34=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+5e53f70e69ff0c0a1c0c@syzkaller.appspotmail.com,
        Takeshi Misawa <jeliantsurux@gmail.com>,
        Fedor Pchelkin <pchelkin@ispras.ru>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Ian Kent <raven@themaw.net>,
        Matthew Wilcox <willy@infradead.org>,
        Andrei Vagin <avagin@gmail.com>, autofs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 001/139] autofs: fix memory leak of waitqueues in autofs_catatonic_mode
Date:   Wed, 20 Sep 2023 13:28:55 +0200
Message-ID: <20230920112835.606672517@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112835.549467415@linuxfoundation.org>
References: <20230920112835.549467415@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fedor Pchelkin <pchelkin@ispras.ru>

[ Upstream commit ccbe77f7e45dfb4420f7f531b650c00c6e9c7507 ]

Syzkaller reports a memory leak:

BUG: memory leak
unreferenced object 0xffff88810b279e00 (size 96):
  comm "syz-executor399", pid 3631, jiffies 4294964921 (age 23.870s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 9e 27 0b 81 88 ff ff  ..........'.....
    08 9e 27 0b 81 88 ff ff 00 00 00 00 00 00 00 00  ..'.............
  backtrace:
    [<ffffffff814cfc90>] kmalloc_trace+0x20/0x90 mm/slab_common.c:1046
    [<ffffffff81bb75ca>] kmalloc include/linux/slab.h:576 [inline]
    [<ffffffff81bb75ca>] autofs_wait+0x3fa/0x9a0 fs/autofs/waitq.c:378
    [<ffffffff81bb88a7>] autofs_do_expire_multi+0xa7/0x3e0 fs/autofs/expire.c:593
    [<ffffffff81bb8c33>] autofs_expire_multi+0x53/0x80 fs/autofs/expire.c:619
    [<ffffffff81bb6972>] autofs_root_ioctl_unlocked+0x322/0x3b0 fs/autofs/root.c:897
    [<ffffffff81bb6a95>] autofs_root_ioctl+0x25/0x30 fs/autofs/root.c:910
    [<ffffffff81602a9c>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff81602a9c>] __do_sys_ioctl fs/ioctl.c:870 [inline]
    [<ffffffff81602a9c>] __se_sys_ioctl fs/ioctl.c:856 [inline]
    [<ffffffff81602a9c>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:856
    [<ffffffff84608225>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84608225>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

autofs_wait_queue structs should be freed if their wait_ctr becomes zero.
Otherwise they will be lost.

In this case an AUTOFS_IOC_EXPIRE_MULTI ioctl is done, then a new
waitqueue struct is allocated in autofs_wait(), its initial wait_ctr
equals 2. After that wait_event_killable() is interrupted (it returns
-ERESTARTSYS), so that 'wq->name.name == NULL' condition may be not
satisfied. Actually, this condition can be satisfied when
autofs_wait_release() or autofs_catatonic_mode() is called and, what is
also important, wait_ctr is decremented in those places. Upon the exit of
autofs_wait(), wait_ctr is decremented to 1. Then the unmounting process
begins: kill_sb calls autofs_catatonic_mode(), which should have freed the
waitqueues, but it only decrements its usage counter to zero which is not
a correct behaviour.

edit:imk
This description is of course not correct. The umount performed as a result
of an expire is a umount of a mount that has been automounted, it's not the
autofs mount itself. They happen independently, usually after everything
mounted within the autofs file system has been expired away. If everything
hasn't been expired away the automount daemon can still exit leaving mounts
in place. But expires done in both cases will result in a notification that
calls autofs_wait_release() with a result status. The problem case is the
summary execution of of the automount daemon. In this case any waiting
processes won't be woken up until either they are terminated or the mount
is umounted.
end edit: imk

So in catatonic mode we should free waitqueues which counter becomes zero.

edit: imk
Initially I was concerned that the calling of autofs_wait_release() and
autofs_catatonic_mode() was not mutually exclusive but that can't be the
case (obviously) because the queue entry (or entries) is removed from the
list when either of these two functions are called. Consequently the wait
entry will be freed by only one of these functions or by the woken process
in autofs_wait() depending on the order of the calls.
end edit: imk

Reported-by: syzbot+5e53f70e69ff0c0a1c0c@syzkaller.appspotmail.com
Suggested-by: Takeshi Misawa <jeliantsurux@gmail.com>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Ian Kent <raven@themaw.net>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: autofs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Message-Id: <169112719161.7590.6700123246297365841.stgit@donald.themaw.net>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/autofs/waitq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/autofs/waitq.c b/fs/autofs/waitq.c
index 54c1f8b8b0757..efdc76732faed 100644
--- a/fs/autofs/waitq.c
+++ b/fs/autofs/waitq.c
@@ -32,8 +32,9 @@ void autofs_catatonic_mode(struct autofs_sb_info *sbi)
 		wq->status = -ENOENT; /* Magic is gone - report failure */
 		kfree(wq->name.name - wq->offset);
 		wq->name.name = NULL;
-		wq->wait_ctr--;
 		wake_up_interruptible(&wq->queue);
+		if (!--wq->wait_ctr)
+			kfree(wq);
 		wq = nwq;
 	}
 	fput(sbi->pipe);	/* Close the pipe */
-- 
2.40.1



