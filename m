Return-Path: <linux-kernel+bounces-74952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CFD85E068
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A117BB291DF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D307FBB6;
	Wed, 21 Feb 2024 14:59:15 +0000 (UTC)
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239837FBC5;
	Wed, 21 Feb 2024 14:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708527555; cv=none; b=IfxdTPJN4yoCaH7OxpE0RdDMjhXzYLXGxWJfdEVGFUEavruucKNR3Mv8wqJuzdBFaSOwmrmHs+Fhl7f6L2OtvL0DiIFmAXZ3+HZi54WidmtRU0hin6pC5fc1P0G1M061RrevMCr825czOTCrDSNen99jD3dnewAvljjjUqPBvik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708527555; c=relaxed/simple;
	bh=rOXs7IK7BPd47XxyU2z2y1odp+Wf1KbCWQduP9pOyt0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CuiCS5ec7ckfYz8Si+26TUHEIhc8RXWS0Fgamh+slhvSfPBGvfefaSGfom3HqkXEkgjHGjYafuoGAlHsRAB0lay8q/MOeiQ2Kf3iytIM0AFbCUlF10b2dfZ6MlGr1u6KgEhIflXvK2hTHhPbdchpfX7sVGeQAce5p+IFJ8GKzrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
From: Daniil Dulov <d.dulov@aladdin.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
CC: Daniil Dulov <d.dulov@aladdin.ru>, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>, Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>,
	<linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, Ying Hsu <yinghsu@chromium.org>, Luiz Augusto
 von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 5.10/5.15 1/1] Bluetooth: Fix deadlock in vhci_send_frame
Date: Wed, 21 Feb 2024 17:57:44 +0300
Message-ID: <20240221145744.27895-2-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240221145744.27895-1-d.dulov@aladdin.ru>
References: <20240221145744.27895-1-d.dulov@aladdin.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-03.aladdin.ru (192.168.1.103) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)

From: Ying Hsu <yinghsu@chromium.org>

commit 769bf60e17ee1a56a81e7c031192c3928312c52e upstream.

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
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[Daniil: In order to adapt this patch to branches 5.10 and 5.15
redundant fields of struct vhci_data were removed as these fields are
not used in 5.10 and 5.15.]
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
 drivers/bluetooth/hci_vhci.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 31d70bad83d2..93773ec90795 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <asm/unaligned.h>
 
+#include <linux/atomic.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -37,6 +38,7 @@ struct vhci_data {
 
 	struct mutex open_mutex;
 	struct delayed_work open_timeout;
+	atomic_t initialized;
 };
 
 static int vhci_open_dev(struct hci_dev *hdev)
@@ -68,11 +70,10 @@ static int vhci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
 	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
 
-	mutex_lock(&data->open_mutex);
 	skb_queue_tail(&data->readq, skb);
-	mutex_unlock(&data->open_mutex);
 
-	wake_up_interruptible(&data->read_wait);
+	if (atomic_read(&data->initialized))
+		wake_up_interruptible(&data->read_wait);
 	return 0;
 }
 
@@ -139,7 +140,8 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 	skb_put_u8(skb, 0xff);
 	skb_put_u8(skb, opcode);
 	put_unaligned_le16(hdev->id, skb_put(skb, 2));
-	skb_queue_tail(&data->readq, skb);
+	skb_queue_head(&data->readq, skb);
+	atomic_inc(&data->initialized);
 
 	wake_up_interruptible(&data->read_wait);
 	return 0;
-- 
2.25.1


