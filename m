Return-Path: <linux-kernel+bounces-158703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AAD8B2402
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A5471C21F64
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922BB14A4C0;
	Thu, 25 Apr 2024 14:24:07 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.231.56.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587CA149DFF;
	Thu, 25 Apr 2024 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.231.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714055047; cv=none; b=S1ZWv8yOnFQVjg4yuJlnSh6nubr42iyCAVlFJBPn+yssLz8PX5TH3d8b6fz/YmPTS/Flj59v5+qeGf28e9uXhJYUb2EGHF1v1q5Xzk4KNAjegI4SSONntt5BP45eSDtpb/ca1wbqttW/eEguUHQbDU7drnYkDxyAoZkeFWbxiVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714055047; c=relaxed/simple;
	bh=gLNgGHBuQgzzluyMUUJ+Kdz4LOLpi0EuVBnmnLiTLRk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=qL7ziLId2MvILSJA80bOqHFd9QPvN+FILkz9PoyJK420ZyYR+eSSP6r54E+iFdn/DeCMvxyI8PIGUj5yIDAEgnMm6wKdEpb7oCt2jWUvQkVwD/6WEJb6s0SUOCewNTUK9wwRC00ILEutbi0LiTGAdP5uGo20N1hHb8yJETNMs/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=20.231.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from ubuntu.localdomain (unknown [106.117.97.39])
	by mail-app2 (Coremail) with SMTP id by_KCgDnBIhxZypms8KaAQ--.38350S2;
	Thu, 25 Apr 2024 22:23:48 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	johan.hedberg@gmail.com,
	marcel@holtmann.org,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH] Bluetooth: Fix use-after-free bugs caused by sco_sock_timeout
Date: Thu, 25 Apr 2024 22:23:45 +0800
Message-Id: <20240425142345.47229-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:by_KCgDnBIhxZypms8KaAQ--.38350S2
X-Coremail-Antispam: 1UD129KBjvJXoW3ArWfuF4DKr4UCw4kWr1rZwb_yoW7try8pr
	nxCayfWrW8Xry0qr4UZF4UtrW8Gr40y3Z8trs2vwnrJ3W5KF4rtryUCrWqgryUCr1jvFy7
	AFWDAr4j9r1UJw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1lc2xSY4AK67AK6ry5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73Uj
	IFyTuYvjfUnBMKDUUUU
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwQCAWYpDhwZjgAIsG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

When the sco connection is established and then, the sco socket
is releasing, timeout_work will be scheduled to judge whether
the sco disconnection is timeout. The sock will be deallocated
later, but it is dereferenced again in sco_sock_timeout. As a
result, the use-after-free bugs will happen. The root cause is
shown below:

    Cleanup Thread               |      Worker Thread
sco_sock_release                 |
  sco_sock_close                 |
    __sco_sock_close             |
      sco_sock_set_timer         |
        schedule_delayed_work    |
  sco_sock_kill                  |    (wait a time)
    sock_put(sk) //FREE          |  sco_sock_timeout
                                 |    sock_hold(sk) //USE

The KASAN report triggered by POC is shown below:

[   95.890016] ==================================================================
[   95.890496] BUG: KASAN: slab-use-after-free in sco_sock_timeout+0x5e/0x1c0
[   95.890755] Write of size 4 at addr ffff88800c388080 by task kworker/0:0/7
..
[   95.890755] Workqueue: events sco_sock_timeout
[   95.890755] Call Trace:
[   95.890755]  <TASK>
[   95.890755]  dump_stack_lvl+0x45/0x110
[   95.890755]  print_address_description+0x78/0x390
[   95.890755]  print_report+0x11b/0x250
[   95.890755]  ? __virt_addr_valid+0xbe/0xf0
[   95.890755]  ? sco_sock_timeout+0x5e/0x1c0
[   95.890755]  kasan_report+0x139/0x170
[   95.890755]  ? update_load_avg+0xe5/0x9f0
[   95.890755]  ? sco_sock_timeout+0x5e/0x1c0
[   95.890755]  kasan_check_range+0x2c3/0x2e0
[   95.890755]  sco_sock_timeout+0x5e/0x1c0
[   95.890755]  process_one_work+0x561/0xc50
[   95.890755]  worker_thread+0xab2/0x13c0
[   95.890755]  ? pr_cont_work+0x490/0x490
[   95.890755]  kthread+0x279/0x300
[   95.890755]  ? pr_cont_work+0x490/0x490
[   95.890755]  ? kthread_blkcg+0xa0/0xa0
[   95.890755]  ret_from_fork+0x34/0x60
[   95.890755]  ? kthread_blkcg+0xa0/0xa0
[   95.890755]  ret_from_fork_asm+0x11/0x20
[   95.890755]  </TASK>
[   95.890755]
[   95.890755] Allocated by task 506:
[   95.890755]  kasan_save_track+0x3f/0x70
[   95.890755]  __kasan_kmalloc+0x86/0x90
[   95.890755]  __kmalloc+0x17f/0x360
[   95.890755]  sk_prot_alloc+0xe1/0x1a0
[   95.890755]  sk_alloc+0x31/0x4e0
[   95.890755]  bt_sock_alloc+0x2b/0x2a0
[   95.890755]  sco_sock_create+0xad/0x320
[   95.890755]  bt_sock_create+0x145/0x320
[   95.890755]  __sock_create+0x2e1/0x650
[   95.890755]  __sys_socket+0xd0/0x280
[   95.890755]  __x64_sys_socket+0x75/0x80
[   95.890755]  do_syscall_64+0xc4/0x1b0
[   95.890755]  entry_SYSCALL_64_after_hwframe+0x67/0x6f
[   95.890755]
[   95.890755] Freed by task 506:
[   95.890755]  kasan_save_track+0x3f/0x70
[   95.890755]  kasan_save_free_info+0x40/0x50
[   95.890755]  poison_slab_object+0x118/0x180
[   95.890755]  __kasan_slab_free+0x12/0x30
[   95.890755]  kfree+0xb2/0x240
[   95.890755]  __sk_destruct+0x317/0x410
[   95.890755]  sco_sock_release+0x232/0x280
[   95.890755]  sock_close+0xb2/0x210
[   95.890755]  __fput+0x37f/0x770
[   95.890755]  task_work_run+0x1ae/0x210
[   95.890755]  get_signal+0xe17/0xf70
[   95.890755]  arch_do_signal_or_restart+0x3f/0x520
[   95.890755]  syscall_exit_to_user_mode+0x55/0x120
[   95.890755]  do_syscall_64+0xd1/0x1b0
[   95.890755]  entry_SYSCALL_64_after_hwframe+0x67/0x6f
[   95.890755]
[   95.890755] The buggy address belongs to the object at ffff88800c388000
[   95.890755]  which belongs to the cache kmalloc-1k of size 1024
[   95.890755] The buggy address is located 128 bytes inside of
[   95.890755]  freed 1024-byte region [ffff88800c388000, ffff88800c388400)
[   95.890755]
[   95.890755] The buggy address belongs to the physical page:
[   95.890755] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88800c38a800 pfn:0xc388
[   95.890755] head: order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[   95.890755] anon flags: 0x100000000000840(slab|head|node=0|zone=1)
[   95.890755] page_type: 0xffffffff()
[   95.890755] raw: 0100000000000840 ffff888006842dc0 0000000000000000 0000000000000001
[   95.890755] raw: ffff88800c38a800 000000000010000a 00000001ffffffff 0000000000000000
[   95.890755] head: 0100000000000840 ffff888006842dc0 0000000000000000 0000000000000001
[   95.890755] head: ffff88800c38a800 000000000010000a 00000001ffffffff 0000000000000000
[   95.890755] head: 0100000000000003 ffffea000030e201 ffffea000030e248 00000000ffffffff
[   95.890755] head: 0000000800000000 0000000000000000 00000000ffffffff 0000000000000000
[   95.890755] page dumped because: kasan: bad access detected
[   95.890755]
[   95.890755] Memory state around the buggy address:
[   95.890755]  ffff88800c387f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   95.890755]  ffff88800c388000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   95.890755] >ffff88800c388080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   95.890755]                    ^
[   95.890755]  ffff88800c388100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   95.890755]  ffff88800c388180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   95.890755] ==================================================================

Fix this problem by adding a check protected by sco_conn_lock to judget
whether the conn->hcon is null. Because the conn->hcon will be set to null,
when the sock is releasing.

Fixes: ba316be1b6a0 ("Bluetooth: schedule SCO timeouts with delayed_work")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 net/bluetooth/sco.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 368e026f4d1..b19c9b0bbd8 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -83,6 +83,10 @@ static void sco_sock_timeout(struct work_struct *work)
 	struct sock *sk;
 
 	sco_conn_lock(conn);
+	if (!conn->hcon) {
+		sco_conn_unlock(conn);
+		return;
+	}
 	sk = conn->sk;
 	if (sk)
 		sock_hold(sk);
-- 
2.17.1


