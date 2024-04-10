Return-Path: <linux-kernel+bounces-137869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4F089E89A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F8CF1F25006
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 03:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E04C132;
	Wed, 10 Apr 2024 03:53:25 +0000 (UTC)
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE2520EB;
	Wed, 10 Apr 2024 03:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712721205; cv=none; b=SNn5LraKHAsx5Kk6vHlmgK8SzPttVwl8H5FxcSqaOYBCJucQEP4iCbKJUw/Ruct7oCE0fBqbNMdvZ0ei18I5Lg03Gm45ZEetHbcnH/Kd2FNXPnte7oY0tJdNizVFkvWeTEW0UX4TWZkbK+63ZhnRuSP89m5wJVzynOcTAWvo1gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712721205; c=relaxed/simple;
	bh=VY1r65IiB4CyR69n168a92EjuLdXbUDvXcgwt9yvfQ4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=MzNoqnk44WdFdtB4GJ/xJ79VbpJP2jaxupIYtXj4kUVhXy+Yew3Cd7y+YQCFf9eEGhiBHzxKql1UwaFTVVGY5NMCQvb+N9NWpAh+XKs5Fco0oF1L/JaSkGPTYJsstC6D7G6ryXKGR5BJhIbShAiHxkfJumzjJHq/aRW6dAZnf5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from ubuntu.localdomain (unknown [218.12.17.105])
	by mail-app3 (Coremail) with SMTP id cC_KCgBnOu0dDRZmZEGBAA--.65136S2;
	Wed, 10 Apr 2024 11:53:07 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	johan.hedberg@gmail.com,
	marcel@holtmann.org,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH v2] Bluetooth: Fix use-after-free bug caused by hci_cmd_timeout
Date: Wed, 10 Apr 2024 11:53:00 +0800
Message-Id: <20240410035300.21160-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:cC_KCgBnOu0dDRZmZEGBAA--.65136S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJFy3XF48JF4kuF1DJr13Arb_yoW5tr4Dpr
	Z09ryfArWkXry2yr4xJa18trykuFsIvr9rGrZ2qr1fAwsxK3yjya4jka4jqF17uFyvyFyU
	WF1DXr9rXFs8Kw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUjuHq7UUUU
	U==
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwIGAWYVR5sEWQBQsk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

When the kernel send a command to the hci device, the hdev->cmd_timer
will be scheduled to judge whether is command is timeout.

Meanwhile, the user space program uses ioctl(..., HCI_INQUIRY) to inquiry
the status of the command, it will wait the reply of the command until
the command is timeout. If it is timeout, the req_skb will be deallocated,
but req_skb could be dereferenced in hci_cmd_timeout() as well.

As a result, the use-after-free bug will happen. One of the scenarios
that could trigger the bug is shown below:

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
deallocated when the command is timeout.

Fixes: 9afee94939e3 ("Bluetooth: Fix memory leak at end of hci requests")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
Changes in v2:
  - Call cancel_delayed_work_sync() only if the command is timeout.

 net/bluetooth/hci_request.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 00e02138003..0b002f01816 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -174,6 +174,7 @@ int __hci_req_sync(struct hci_dev *hdev, int (*func)(struct hci_request *req,
 
 	default:
 		err = -ETIMEDOUT;
+		cancel_delayed_work_sync(&hdev->cmd_timer);
 		if (hci_status)
 			*hci_status = HCI_ERROR_UNSPECIFIED;
 		break;
-- 
2.17.1


