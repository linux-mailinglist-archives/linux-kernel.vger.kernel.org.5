Return-Path: <linux-kernel+bounces-135536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD3489C74C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B864285A6C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A8B13F00A;
	Mon,  8 Apr 2024 14:43:29 +0000 (UTC)
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5693613E8AB;
	Mon,  8 Apr 2024 14:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712587408; cv=none; b=tM7q/KluX0vkImk++Yy0vvh5FpaOqGiTe7d09QFK1mGdZUG3q2XYBDzqfV4q3H1qOoy7PZmPUwUmZUY0mVwRcoyrcGrD1GZIJdt0F01xWR7xnpPADDkQspevZz1YS24PB6vR287n2O68SMFFVPDbq1WG2OILxt4AZK+D6VPi+Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712587408; c=relaxed/simple;
	bh=PPUcJWvyZ6gsR6o1h3WKypY8GEZc753Ubyqu/GTD68I=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Mj0/Ov8YoqEGeBlw0d252nwNwsn1co1CBV/b3rCoeg98PzztXYCRukyso+LsdmXY6j2IvFOwkYz5YsOS7tvmRd+E6AsIzInFYE0WhRC/TqT0x2j3G7QcpalwC5nUpOwStcg4JXIB4D5D6mnz1CFlV3bMmtm65hQGXJPHLMrtxkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from ubuntu.localdomain (unknown [106.117.100.208])
	by mail-app4 (Coremail) with SMTP id cS_KCgBHVcp2AhRm7dFdAA--.36189S2;
	Mon, 08 Apr 2024 22:43:13 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	johan.hedberg@gmail.com,
	marcel@holtmann.org,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH] Bluetooth: Fix use-after-free bug caused by hci_cmd_timeout
Date: Mon,  8 Apr 2024 22:43:02 +0800
Message-Id: <20240408144302.105777-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:cS_KCgBHVcp2AhRm7dFdAA--.36189S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF1Utw4UtFWfWr4rKFW3Wrg_yoW5CF43pr
	Z0kryfArW8XryYyr4xAa1xtrykuFsIvrZxGr9agr13A39akw4jy3WUCa4jgF47uFyvyFyU
	WF1DXrWDXFn8Gw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1lc2xSY4AK67AK6ry5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73Uj
	IFyTuYvjfUY1v3UUUUU
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwQFAWYT9hoAkQAKsB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

If we send a command and the command is timeout, the hci_cmd_timeout()
will run. Then we use hci_sock_ioctl() to inquiry the command, it will
deallocate the req_skb. But the req_skb could be dereferenced in the
hci_cmd_timeout(). As a result, the use-after-free bug will happen.
The detail is shown below:

     thread 1                       thread2
hci_sock_ioctl()             | hci_sock_sendmsg()
 hci_inquiry()               |  queue_work(...,&hdev->cmd_work)
  hci_req_sync()             |   hci_cmd_work()
   __hci_req_sync()          |    queue_delayed_work(...,&hdev->cmd_timer)
    kfree_skb(hdev->req_skb) |     hci_cmd_timeout()
                             |      hci_skb_opcode(hdev->req_skb)

The KASan report for such a POC is shown below:

 ==================================================================
 BUG: KASAN: slab-use-after-free in hci_cmd_timeout+0x3c/0x110
 Read of size 2 at addr ffff8880087a1c78 by task kworker/u21:0/131
 ...
 Workqueue: hci0 hci_cmd_timeout
 Call Trace:
  <TASK>
  dump_stack_lvl+0x84/0xc0
  print_address_description+0x78/0x440
  print_report+0x11b/0x220
  ? pfn_valid+0xe4/0x140
  ? __virt_addr_valid+0x7c/0x90
  ? hci_cmd_timeout+0x3c/0x110
  kasan_report+0xc7/0x100
  ? hci_cmd_timeout+0x3c/0x110
  hci_cmd_timeout+0x3c/0x110
  process_one_work+0x2df/0x610
  worker_thread+0x72f/0x870
  ? pr_cont_work+0x280/0x280
  kthread+0x18a/0x1b0
  ? kthread_blkcg+0x50/0x50
  ret_from_fork+0x34/0x50
  ? kthread_blkcg+0x50/0x50
  ret_from_fork_asm+0x11/0x20
  </TASK>

 Allocated by task 131 on cpu 1 at 45.611537s:
  kasan_save_track+0x32/0x90
  __kasan_slab_alloc+0x4b/0x60
  kmem_cache_alloc+0xcb/0x240
  skb_clone+0x117/0x170
  hci_cmd_work+0x19c/0x2a0
  process_one_work+0x2df/0x610
  worker_thread+0x72f/0x870
  kthread+0x18a/0x1b0
  ret_from_fork+0x34/0x50
  ret_from_fork_asm+0x11/0x20

 Freed by task 135 on cpu 2 at 47.671850s:
  kasan_save_track+0x32/0x90
  kasan_save_free_info+0x40/0x50
  poison_slab_object+0x118/0x180
  __kasan_slab_free+0x12/0x30
  kmem_cache_free+0x92/0x200
  __hci_req_sync+0x2e2/0x350
  hci_req_sync+0x73/0x90
  hci_inquiry+0x1c1/0x350
  sock_do_ioctl+0x50/0x1a0
  sock_ioctl+0x2ea/0x3b0
  __se_sys_ioctl+0x89/0xd0
  do_syscall_64+0xc4/0x1b0
  entry_SYSCALL_64_after_hwframe+0x62/0x6a
  ...

In order to mitigate the bug, add cancel_delayed_work_sync() in
__hci_req_sync() to cancel the cmd_timer before the req_skb is
deallocated.

Fixes: 9afee94939e3 ("Bluetooth: Fix memory leak at end of hci requests")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 net/bluetooth/hci_request.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 00e02138003..06692c71093 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -179,6 +179,7 @@ int __hci_req_sync(struct hci_dev *hdev, int (*func)(struct hci_request *req,
 		break;
 	}
 
+	cancel_delayed_work_sync(&hdev->cmd_timer);
 	kfree_skb(hdev->req_skb);
 	hdev->req_skb = NULL;
 	hdev->req_status = hdev->req_result = 0;
-- 
2.17.1


