Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599297E76C8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 02:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345654AbjKJBqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 20:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjKJBqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 20:46:13 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8333A44A4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 17:46:11 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d9ad90e1038so1646034276.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 17:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699580770; x=1700185570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hEYn/ShW9PpqZIn2J09Gp11kqZRC5Iqj2RkIc6riOyc=;
        b=iAsOvyXsvbICJQRK66zUOTCoHXxMcH9HTs47zs0K9/mIB6fBZG5SxU/jkyVdtw478t
         d7HIRk78mLGt2gVrkbyzEJSnQ7hdvd87E7yKRMIbTFYJcsyHHjA7nNdzmh4GtJG7eT1f
         5BzVyyOoKBVJgCUgeF+71IasPEIIdpPVdKTow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699580770; x=1700185570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hEYn/ShW9PpqZIn2J09Gp11kqZRC5Iqj2RkIc6riOyc=;
        b=OEptklUPqX+eO8EEk1XMd7xiqJa+RbVKCgZlkdiV1pIkLqiGn6mzQTyD+Ei3mEOVKl
         hieO1xn7irW6xWlYh2lCZT+cVoac5plxKCCBvEHwUGiTY2+QtqBwxh1Pev2yLpiv/cgc
         PhAF7be0w/SGPJOixSFxcv/xP/l9mc8TUsDtoE5Xv1CmUUtCto5ZF0SsGIbOhFmfoKvM
         JFLkZPs7ptqOTnCgnNhFmXPbvUg8mFhV5lnK7qyOWDyt+vWR7m7VHE4gYxE4bhnFxxdf
         /Sr50YC/jhBvQMkxEbhzfLIqX4iAgnSXFtOJmbnxD74ymC2/JdS8HDb754bdFOmGQNFf
         vO1w==
X-Gm-Message-State: AOJu0Yyxp/NbL9aXUKcVR6aZZku9qJK0U/JaNXxsw963Z/GbCXJSgWHC
        7fFeMUaqWR47TaMjQOKamniejz03V8yXKZpyFQk=
X-Google-Smtp-Source: AGHT+IETOziY4omaFEW9L6RWv2QFZg9NAqldv3UKburk1sX+LDl2oQeUHGP5g5Nn9XD6N5+sB+p25A==
X-Received: by 2002:a25:600b:0:b0:d9b:f737:2d2f with SMTP id u11-20020a25600b000000b00d9bf7372d2fmr5730843ybb.45.1699580770723;
        Thu, 09 Nov 2023 17:46:10 -0800 (PST)
Received: from localhost (231.137.80.34.bc.googleusercontent.com. [34.80.137.231])
        by smtp.gmail.com with UTF8SMTPSA id t20-20020aa79394000000b006c0fdc98c89sm11316974pfe.85.2023.11.09.17.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 17:46:10 -0800 (PST)
From:   Ying Hsu <yinghsu@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, linux-kernel@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        arkadiusz.bokowy@gmail.com, johan.hedberg@gmail.com,
        marcel@holtmann.org, Ying Hsu <yinghsu@chromium.org>
Subject: [PATCH RESEND] Bluetooth: Fix deadlock in vhci_send_frame
Date:   Fri, 10 Nov 2023 01:46:05 +0000
Message-ID: <20231110014605.2068231-1-yinghsu@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot found a potential circular dependency leading to a deadlock:
    -> #3 (&hdev->req_lock){+.+.}-{3:3}:
    __mutex_lock_common+0x1b6/0x1bc2 kernel/locking/mutex.c:599
    __mutex_lock kernel/locking/mutex.c:732 [inline]
    mutex_lock_nested+0x17/0x1c kernel/locking/mutex.c:784
    hci_dev_do_close+0x3f/0x9f net/bluetooth/hci_core.c:551
    hci_rfkill_set_block+0x130/0x1ac net/bluetooth/hci_core.c:935
    rfkill_set_block+0x1e6/0x3b8 net/rfkill/core.c:345
    rfkill_fop_write+0x2d8/0x672 net/rfkill/core.c:1274
    vfs_write+0x277/0xcf5 fs/read_write.c:594
    ksys_write+0x19b/0x2bd fs/read_write.c:650
    do_syscall_x64 arch/x86/entry/common.c:55 [inline]
    do_syscall_64+0x51/0xba arch/x86/entry/common.c:93
    entry_SYSCALL_64_after_hwframe+0x61/0xcb

    -> #2 (rfkill_global_mutex){+.+.}-{3:3}:
    __mutex_lock_common+0x1b6/0x1bc2 kernel/locking/mutex.c:599
    __mutex_lock kernel/locking/mutex.c:732 [inline]
    mutex_lock_nested+0x17/0x1c kernel/locking/mutex.c:784
    rfkill_register+0x30/0x7e3 net/rfkill/core.c:1045
    hci_register_dev+0x48f/0x96d net/bluetooth/hci_core.c:2622
    __vhci_create_device drivers/bluetooth/hci_vhci.c:341 [inline]
    vhci_create_device+0x3ad/0x68f drivers/bluetooth/hci_vhci.c:374
    vhci_get_user drivers/bluetooth/hci_vhci.c:431 [inline]
    vhci_write+0x37b/0x429 drivers/bluetooth/hci_vhci.c:511
    call_write_iter include/linux/fs.h:2109 [inline]
    new_sync_write fs/read_write.c:509 [inline]
    vfs_write+0xaa8/0xcf5 fs/read_write.c:596
    ksys_write+0x19b/0x2bd fs/read_write.c:650
    do_syscall_x64 arch/x86/entry/common.c:55 [inline]
    do_syscall_64+0x51/0xba arch/x86/entry/common.c:93
    entry_SYSCALL_64_after_hwframe+0x61/0xcb

    -> #1 (&data->open_mutex){+.+.}-{3:3}:
    __mutex_lock_common+0x1b6/0x1bc2 kernel/locking/mutex.c:599
    __mutex_lock kernel/locking/mutex.c:732 [inline]
    mutex_lock_nested+0x17/0x1c kernel/locking/mutex.c:784
    vhci_send_frame+0x68/0x9c drivers/bluetooth/hci_vhci.c:75
    hci_send_frame+0x1cc/0x2ff net/bluetooth/hci_core.c:2989
    hci_sched_acl_pkt net/bluetooth/hci_core.c:3498 [inline]
    hci_sched_acl net/bluetooth/hci_core.c:3583 [inline]
    hci_tx_work+0xb94/0x1a60 net/bluetooth/hci_core.c:3654
    process_one_work+0x901/0xfb8 kernel/workqueue.c:2310
    worker_thread+0xa67/0x1003 kernel/workqueue.c:2457
    kthread+0x36a/0x430 kernel/kthread.c:319
    ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298

    -> #0 ((work_completion)(&hdev->tx_work)){+.+.}-{0:0}:
    check_prev_add kernel/locking/lockdep.c:3053 [inline]
    check_prevs_add kernel/locking/lockdep.c:3172 [inline]
    validate_chain kernel/locking/lockdep.c:3787 [inline]
    __lock_acquire+0x2d32/0x77fa kernel/locking/lockdep.c:5011
    lock_acquire+0x273/0x4d5 kernel/locking/lockdep.c:5622
    __flush_work+0xee/0x19f kernel/workqueue.c:3090
    hci_dev_close_sync+0x32f/0x1113 net/bluetooth/hci_sync.c:4352
    hci_dev_do_close+0x47/0x9f net/bluetooth/hci_core.c:553
    hci_rfkill_set_block+0x130/0x1ac net/bluetooth/hci_core.c:935
    rfkill_set_block+0x1e6/0x3b8 net/rfkill/core.c:345
    rfkill_fop_write+0x2d8/0x672 net/rfkill/core.c:1274
    vfs_write+0x277/0xcf5 fs/read_write.c:594
    ksys_write+0x19b/0x2bd fs/read_write.c:650
    do_syscall_x64 arch/x86/entry/common.c:55 [inline]
    do_syscall_64+0x51/0xba arch/x86/entry/common.c:93
    entry_SYSCALL_64_after_hwframe+0x61/0xcb

This change removes the need for acquiring the open_mutex in
vhci_send_frame, thus eliminating the potential deadlock while
maintaining the required packet ordering.

Fixes: 92d4abd66f70 ("Bluetooth: vhci: Fix race when opening vhci device")
Signed-off-by: Ying Hsu <yinghsu@chromium.org>
---
Tested this commit using a C reproducer on qemu-x86_64.

 drivers/bluetooth/hci_vhci.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index f3892e9ce800..572d68d52965 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <asm/unaligned.h>
 
+#include <linux/atomic.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -44,6 +45,7 @@ struct vhci_data {
 	bool wakeup;
 	__u16 msft_opcode;
 	bool aosp_capable;
+	atomic_t initialized;
 };
 
 static int vhci_open_dev(struct hci_dev *hdev)
@@ -75,11 +77,10 @@ static int vhci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
 	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
 
-	mutex_lock(&data->open_mutex);
 	skb_queue_tail(&data->readq, skb);
-	mutex_unlock(&data->open_mutex);
 
-	wake_up_interruptible(&data->read_wait);
+	if (atomic_read(&data->initialized))
+		wake_up_interruptible(&data->read_wait);
 	return 0;
 }
 
@@ -464,7 +465,8 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 	skb_put_u8(skb, 0xff);
 	skb_put_u8(skb, opcode);
 	put_unaligned_le16(hdev->id, skb_put(skb, 2));
-	skb_queue_tail(&data->readq, skb);
+	skb_queue_head(&data->readq, skb);
+	atomic_inc(&data->initialized);
 
 	wake_up_interruptible(&data->read_wait);
 	return 0;
-- 
2.43.0.rc0.421.g78406f8d94-goog

