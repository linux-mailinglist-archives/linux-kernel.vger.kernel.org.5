Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A361D76060A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 04:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjGYCxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 22:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjGYCw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 22:52:57 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9581710B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 19:52:53 -0700 (PDT)
Received: from kwepemm600014.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R91jP4LrrzHqdf;
        Tue, 25 Jul 2023 10:50:17 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.175.28) by
 kwepemm600014.china.huawei.com (7.193.23.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 10:52:50 +0800
From:   Yi Yang <yiyang13@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <jannh@google.com>
CC:     <linux-kernel@vger.kernel.org>, <guozihua@huawei.com>
Subject: [PATCH v3] tty: tty_jobctrl: fix pid memleak in disassociate_ctty()
Date:   Tue, 25 Jul 2023 10:52:02 +0800
Message-ID: <20230725025202.239450-1-yiyang13@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.28]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a pid leakage:
------------------------------
unreferenced object 0xffff88810c181940 (size 224):
  comm "sshd", pid 8191, jiffies 4294946950 (age 524.570s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 ad 4e ad de  .............N..
    ff ff ff ff 6b 6b 6b 6b ff ff ff ff ff ff ff ff  ....kkkk........
  backtrace:
    [<ffffffff814774e6>] kmem_cache_alloc+0x5c6/0x9b0
    [<ffffffff81177342>] alloc_pid+0x72/0x570
    [<ffffffff81140ac4>] copy_process+0x1374/0x2470
    [<ffffffff81141d77>] kernel_clone+0xb7/0x900
    [<ffffffff81142645>] __se_sys_clone+0x85/0xb0
    [<ffffffff8114269b>] __x64_sys_clone+0x2b/0x30
    [<ffffffff83965a72>] do_syscall_64+0x32/0x80
    [<ffffffff83a00085>] entry_SYSCALL_64_after_hwframe+0x61/0xc6

It turns out that there is a race condition between disassociate_ctty() and
tty_signal_session_leader(), which caused this leakage.

The pid memleak is triggered by the following race:
task[sshd]                     task[bash]
-----------------------        -----------------------
                               disassociate_ctty();
                               spin_lock_irq(&current->sighand->siglock);
                               put_pid(current->signal->tty_old_pgrp);
                               current->signal->tty_old_pgrp = NULL;
                               tty = tty_kref_get(current->signal->tty);
                               spin_unlock_irq(&current->sighand->siglock);
tty_vhangup();
tty_lock(tty);
...
tty_signal_session_leader();
spin_lock_irq(&p->sighand->siglock);
...
if (tty->ctrl.pgrp) //tty->ctrl.pgrp is not NULL
p->signal->tty_old_pgrp = get_pid(tty->ctrl.pgrp); //An extra get
spin_unlock_irq(&p->sighand->siglock);
...
tty_unlock(tty);
                               if (tty) {
                                   tty_lock(tty);
                                   ...
                                   put_pid(tty->ctrl.pgrp);
                                   tty->ctrl.pgrp = NULL; //It's too late
                                   ...
                                   tty_unlock(tty);
                               }

The issue is believed to be introduced by commit c8bcd9c5be24 ("tty:
Fix ->session locking") who moves the unlock of siglock in
disassociate_ctty() above "if (tty)", making a small window allowing
tty_signal_session_leader() to kick in. It can be easily reproduced by
adding a delay before "if (tty)" and at the entrance of
tty_signal_session_leader().

To fix this issue, we move "put_pid(current->signal->tty_old_pgrp)" after
"tty->ctrl.pgrp = NULL".

Fixes: c8bcd9c5be24 ("tty: Fix ->session locking")
Signed-off-by: Yi Yang <yiyang13@huawei.com>
Co-developed-by: GUO Zihua <guozihua@huawei.com>
Signed-off-by: GUO Zihua <guozihua@huawei.com>
---
v3:Make the description of the commit message more correct and add comments
   to the code.
v2:Completely refactor the solution, avoid the use of PF_EXITING flag and
   do put_pid() in disassociate_ctty() again instead.
---
 drivers/tty/tty_jobctrl.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
index 0d04287da098..ef8741c3e662 100644
--- a/drivers/tty/tty_jobctrl.c
+++ b/drivers/tty/tty_jobctrl.c
@@ -300,12 +300,7 @@ void disassociate_ctty(int on_exit)
 		return;
 	}
 
-	spin_lock_irq(&current->sighand->siglock);
-	put_pid(current->signal->tty_old_pgrp);
-	current->signal->tty_old_pgrp = NULL;
-	tty = tty_kref_get(current->signal->tty);
-	spin_unlock_irq(&current->sighand->siglock);
-
+	tty = get_current_tty();
 	if (tty) {
 		unsigned long flags;
 
@@ -320,6 +315,16 @@ void disassociate_ctty(int on_exit)
 		tty_kref_put(tty);
 	}
 
+	/* If tty->ctrl.pgrp is not NULL, it may be assigned to
+	 * current->signal->tty_old_pgrp in a race condition, and
+	 * cause pid memleak. Release current->signal->tty_old_pgrp
+	 * after tty->ctrl.pgrp set to NULL.
+	 */
+	spin_lock_irq(&current->sighand->siglock);
+	put_pid(current->signal->tty_old_pgrp);
+	current->signal->tty_old_pgrp = NULL;
+	spin_unlock_irq(&current->sighand->siglock);
+
 	/* Now clear signal->tty under the lock */
 	read_lock(&tasklist_lock);
 	session_clear_tty(task_session(current));
-- 
2.17.1

