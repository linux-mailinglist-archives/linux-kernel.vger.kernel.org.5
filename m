Return-Path: <linux-kernel+bounces-152928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A568AC640
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 110961C219AD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7722F4F1E5;
	Mon, 22 Apr 2024 08:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b="qK5UI8z4"
Received: from zg8tmtu5ljy1ljeznc42.icoremail.net (zg8tmtu5ljy1ljeznc42.icoremail.net [159.65.134.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9D04DA11;
	Mon, 22 Apr 2024 08:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.65.134.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713773113; cv=none; b=DaUf4Wj+6WQLgAXg+Vy0Pze+gHFRwh5Ge7TaGn8XjiZpeM7QaK1akPcxsASq73SLzaIKGodTp17O4IU5cUInqqxxyMsB+DtYq85v4qRv2OUVmUgXJz8lIrOL9jxcYmjFz3YmL74zhJjcwPoWUE62hwt1qBAdaQ+lNIHHXM91F08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713773113; c=relaxed/simple;
	bh=SYEGs9jZ5P4cgW1+ep3f+NoBU/Z8Gl0nqwx4n305HY0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=riaaZ26WGfJN/lylMmceW+c2S+bmQjwkiDM8y0jMdElbNLSY9aUNEMevsW4i39bATv5M9tjOaMvgQgk2b/3301EDcMW/aE5+aBGtdhEbV+CBBQSDCD2nYAXZlo8tcbqV1pfGe79aX+BRQP6eU3zCgF2QsfARl93gw/gIcm+ASyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn; spf=pass smtp.mailfrom=buaa.edu.cn; dkim=pass (1024-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b=qK5UI8z4; arc=none smtp.client-ip=159.65.134.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buaa.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=buaa.edu.cn; s=buaa; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=/zsuHTl/et
	TQRPUZY0mAHUYsD3Tqv7TKYKGXjfgTngs=; b=qK5UI8z4l4dMViUjHnTHwNltTq
	/J3KXt5CmjAh49pp2QuhatLErJYuhMFbVvS1N5mYxET4dmooQy5+c6chTMGYvMsP
	Bic1wWSf7crIxjb/MzB2VrzkfvTGkl88xD7JZqMPQR6OujmF1diaeUrL/JvZSjOU
	y6JFY8+IbEhQhH0aU=
Received: from lxy.lan (unknown [106.39.42.164])
	by coremail-app1 (Coremail) with SMTP id OCz+CgD3x9IaGiZmi+EhAA--.18352S2;
	Mon, 22 Apr 2024 16:04:44 +0800 (CST)
From: Yuxuan Hu <20373622@buaa.edu.cn>
To: krzk@kernel.org,
	gregkh@linuxfoundation.org,
	johan@kernel.org,
	davem@davemloft.net,
	u.kleine-koenig@pengutronix.de,
	Jonathan.Cameron@huawei.com,
	francesco.dolcini@toradex.com,
	jirislaby@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	sy2239101@buaa.edu.cn,
	Yuxuan Hu <yuxuanhu@buaa.edu.cn>
Subject: [PATCH] nfc: pn533: Fix null-ptr-deref in pn533_recv_frame()
Date: Mon, 22 Apr 2024 16:04:08 +0800
Message-Id: <20240422080408.1639247-1-20373622@buaa.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:OCz+CgD3x9IaGiZmi+EhAA--.18352S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw48Jw4rAr1xur13WF4fuFg_yoWxGF48p3
	9rtrW5Cr4ktr1UAa1UCw48X345JFsrAFW7JFW29rySq3W5G3WDJrW8KFWUurykXr4qy3W7
	CrWDXr48tFyDtaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBIb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
	0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628v
	n2kIc2xKxwCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8V
	WrXryUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5pnQ5UUUUU==
X-CM-SenderInfo: ysqtljawssquxxddhvlgxou0/

From: Yuxuan Hu <yuxuanhu@buaa.edu.cn>

Our fuzzing tool found a null-ptr-deref in function pn533_recv_frame 
(/drivers/nfc/pn533/pn533.c) in kernel 6.8.

(1.1) When execute the NFC_CMD_START_POLL command via netlink, the 
pn533_send_cmd_async function (/drivers/nfc/pn533/pn533.c: 1714) is 
called, which sends the PN533_CMD_IN_AUTOPOLL command packet.

(2.1) If a pn533 response frame that does not match the command is 
received, the following call sequence is executed:
pn533_recv_frame (/drivers/nfc/pn533/pn533.c: 2165)
    pn533_rx_frame_is_cmd_response (/drivers/nfc/pn533/pn533.c: 2194)
    pn533_wq_cmd_complete (/drivers/nfc/pn533/pn533.c: 2022)
        pn533_send_async_complete (/drivers/nfc/pn533/pn533.c: 547)
            pn533_autopoll_complete (/drivers/nfc/pn533/pn533.c: 414)

(2.2) After completing (2.1), dev->cmd is freed and set to null 
(/drivers/nfc/pn533/pn533.c: 432-433).

(3.1) If another incorrect pn533 response frame is received during 
the above process, (2.1) and (2.2) will be executed concurrently, and 
the initial process setting dev->cmd to null causes the concurrent 
process to trigger a null-ptr-deref in pn533_recv_frame.

Although pn533_recv_frame checks for dev->cmd at the beginning, it is 
possible that dev->cmd is set to null after the check.

Through our verification, this concurrent vulnerability has a high 
probability of occurrence and needs to be fixed.

Kernel print messages when null-ptr-deref is triggered (including PN533 
packets, PN533 module errors, and KASAN reports) are as follows.
We added printk of the data packets, and printk before the relevant steps 
in pn533_send_async_complete and pn533_recv_frame.

  -> 00 00 FF 08 F8 D4 60 FF 03 00 11 12 04 A3 00 
  <- 00 00 FF 00 FF 00 
  <- 00 00 FF 0E F2 D5 86 01 10 09 01 00 20 08 04 9B 2C EE 9F 0A 00 
  tty tty60: NFC: It it not the response to the last command
  arted polling nfc device
  <- 00 00 FF 03 FD D5 41 00 EA 00 
  tty tty60: NFC: pn533_autopoll_complete  autopoll complete error -5
  tty tty60: NFC: It it not the response to the last command
  tty tty60: NFC: Error -5 when running autopoll
  tty tty60: NFC: autopoll operation has been stopped
  pn533_send_async_complete: set dev->cmd to null!!!
  pn533_recv_frame: dev->cmd is null!!!
  BUG: kernel NULL pointer dereference, address: 0000000000000014
  #PF: supervisor write access in kernel mode
  #PF: error_code(0x0002) - not-present page
  PGD 0 P4D 0 
  Oops: 0002 [#1] PREEMPT SMP KASAN PTI
  CPU: 0 PID: 5541 Comm: kworker/0:0 Tainted: G           O       6.8.0 #1
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
  Workqueue: events nfcvirt_recv_work [nfcvirt]
  RIP: 0010:pn533_recv_frame+0x18a/0x1e0 [pn533]
  Code: 43 ff ff ff 48 8b bb 80 02 00 00 48 c7 c6 0b 02 46 c0 31 c0 e8 97 64 4f c4 48 83 bb b0 01 00 00 00 74 3f 48 8b 83 b0 01 00 00 <c7> 40 14 fb ff ff ff 48 8b 83 b0 01 00 00 48 85 c0 0f 85 3b ff ff
  RSP: 0018:ffff88802665fc68 EFLAGS: 00010246
  RAX: 0000000000000000 RBX: ffff88804a13b800 RCX: ad381de3b3cd5e00
  RDX: 1ffff11004ccbf38 RSI: 0000000000000008 RDI: ffff88802665f9e0
  RBP: ffff88804fb25000 R08: ffff88802665f9e7 R09: 1ffff11004ccbf3c
  R10: dffffc0000000000 R11: ffffed1004ccbf3d R12: 0000000000001950
  R13: ffff88804ab80000 R14: ffff888021d22640 R15: ffff88802665fcb0
  FS:  0000000000000000(0000) GS:ffff88806d200000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000014 CR3: 0000000004ebc000 CR4: 00000000000006f0
  Call Trace:
   <TASK>
   ? __die_body+0x62/0xb0
   ? page_fault_oops+0x421/0x740
   ? kernelmode_fixup_or_oops+0x1d0/0x1d0
   ? asan.module_ctor+0x10/0x10
   ? vprintk_emit+0x3f0/0x3f0
   ? kernelmode_fixup_or_oops+0x163/0x1d0
   ? do_user_addr_fault+0xb6c/0xde0
   ? irq_work_queue+0x54/0xa0
   ? do_kern_addr_fault+0x160/0x160
   ? __call_rcu_common+0x518/0xc30
   ? _dev_err+0x106/0x150
   ? exc_page_fault+0x66/0x1a0
   ? asm_exc_page_fault+0x22/0x30
   ? pn533_recv_frame+0x18a/0x1e0 [pn533]
   ? pn533_recv_frame+0x1d7/0x1e0 [pn533]
   nfcvirt_recv_work+0x24e/0x320 [nfcvirt]
   ? wake_bit_function+0x230/0x230
   process_one_work+0x4f0/0xab0
   worker_thread+0x8af/0xee0
   ? process_one_work+0xab0/0xab0
   kthread+0x275/0x300
   ? process_one_work+0xab0/0xab0
   ? kthread_blkcg+0xa0/0xa0
   ret_from_fork+0x30/0x60
   ? kthread_blkcg+0xa0/0xa0
   ret_from_fork_asm+0x11/0x20
   </TASK>
  Modules linked in: nfcvirt(O) pn533(O) nfc(O) ki_coverage(O) [last unloaded: pn533(O)]
  CR2: 0000000000000014
  ---[ end trace 0000000000000000 ]---
  RIP: 0010:pn533_recv_frame+0x18a/0x1e0 [pn533]
  Code: 43 ff ff ff 48 8b bb 80 02 00 00 48 c7 c6 0b 02 46 c0 31 c0 e8 97 64 4f c4 48 83 bb b0 01 00 00 00 74 3f 48 8b 83 b0 01 00 00 <c7> 40 14 fb ff ff ff 48 8b 83 b0 01 00 00 48 85 c0 0f 85 3b ff ff
  RSP: 0018:ffff88802665fc68 EFLAGS: 00010246
  RAX: 0000000000000000 RBX: ffff88804a13b800 RCX: ad381de3b3cd5e00
  RDX: 1ffff11004ccbf38 RSI: 0000000000000008 RDI: ffff88802665f9e0
  RBP: ffff88804fb25000 R08: ffff88802665f9e7 R09: 1ffff11004ccbf3c
  R10: dffffc0000000000 R11: ffffed1004ccbf3d R12: 0000000000001950
  R13: ffff88804ab80000 R14: ffff888021d22640 R15: ffff88802665fcb0
  FS:  0000000000000000(0000) GS:ffff88806d200000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000014 CR3: 0000000004ebc000 CR4: 00000000000006f0

Signed-off-by: Yuxuan Hu <yuxuanhu@buaa.edu.cn>
---
 drivers/nfc/pn533/pn533.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
index b19c39dcfbd9..a80a23332f59 100644
--- a/drivers/nfc/pn533/pn533.c
+++ b/drivers/nfc/pn533/pn533.c
@@ -2190,9 +2190,13 @@ void pn533_recv_frame(struct pn533 *dev, struct sk_buff *skb, int status)
 
 	if (!dev->ops->rx_is_frame_valid(skb->data, dev)) {
 		nfc_err(dev->dev, "Received an invalid frame\n");
+		if (!dev->cmd)
+			goto sched_wq;
 		dev->cmd->status = -EIO;
 	} else if (!pn533_rx_frame_is_cmd_response(dev, skb->data)) {
 		nfc_err(dev->dev, "It it not the response to the last command\n");
+		if (!dev->cmd)
+			goto sched_wq;
 		dev->cmd->status = -EIO;
 	}
 
-- 
2.25.1


