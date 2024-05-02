Return-Path: <linux-kernel+bounces-166476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 785BD8B9B35
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E48AE1F2127E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1BC83CCE;
	Thu,  2 May 2024 12:59:09 +0000 (UTC)
Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFF882498;
	Thu,  2 May 2024 12:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714654749; cv=none; b=tjJh/zaA8YdfseeJa1HShfRaJuxmDIz9KbxIKVx9NCWURvo39A7mLdwynH9jG+9uwbEmzyC3nM7zyfKJHWkDbhNn1feNIgNJkoASrVRoiKYZp5ipb++LoCOZBQdOIueGMh2HzW14BSp0O8oOSWxALRHsOhbIIeERT+g0qrLwIh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714654749; c=relaxed/simple;
	bh=pS/I1kzqFrQdM3EmoRnGcLpZmqdgt3T3j/097XUIV2w=;
	h=From:To:Cc:Subject:Date:Message-Id; b=dEna8y5ymcPRRA3RxHq9PQ9/PCdDNwycOvwypXvkzq4AnWjdzH4a8TB9JF8KL57Y2O+u0zKh95XWV5Fh5GQgtKRyaJo3TvAiQ20aQfg348XcKuDfMzQQ99ss5FqPbTeJugi07IhI2Ek6jJdhyzu3DHrPZTLUOSymKsto8IbPz+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from ubuntu.localdomain (unknown [221.192.181.50])
	by mail-app3 (Coremail) with SMTP id cC_KCgBXCOrDjTNmWJG9AQ--.60971S2;
	Thu, 02 May 2024 20:58:01 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	johan.hedberg@gmail.com,
	marcel@holtmann.org,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH] Bluetooth: l2cap: fix null-ptr-deref in l2cap_chan_timeout
Date: Thu,  2 May 2024 20:57:36 +0800
Message-Id: <20240502125736.28034-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:cC_KCgBXCOrDjTNmWJG9AQ--.60971S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JF15Kr13CF18Jw1ftw17trb_yoWxWFy5pr
	sxKrWSkrs5Jas5JF45Cr17Ja4DZ347AF4DWry8Ar1fJ3W8Xw1DAr1DAryUCrnrGrnrAFy3
	t3s8Xr10kr17Gw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCY02Avz4vE14v_Xr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjfUn_-PUUUUU
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwIJAWYySJ0M6ABBst
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

There is a race condition between l2cap_chan_timeout() and
l2cap_chan_del(). When we use l2cap_chan_del() to delete the
channel, the chan->conn will be set to null. But the conn could
be dereferenced again in the mutex_lock() of l2cap_chan_timeout().
As a result the null pointer dereference bug will happen. The
KASAN report triggered by POC is shown below:

[  472.074580] ==================================================================
[  472.075284] BUG: KASAN: null-ptr-deref in mutex_lock+0x68/0xc0
[  472.075308] Write of size 8 at addr 0000000000000158 by task kworker/0:0/7
[  472.075308]
[  472.075308] CPU: 0 PID: 7 Comm: kworker/0:0 Not tainted 6.9.0-rc5-00356-g78c0094a146b #36
[  472.075308] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu4
[  472.075308] Workqueue: events l2cap_chan_timeout
[  472.075308] Call Trace:
[  472.075308]  <TASK>
[  472.075308]  dump_stack_lvl+0x137/0x1a0
[  472.075308]  print_report+0x101/0x250
[  472.075308]  ? __virt_addr_valid+0x77/0x160
[  472.075308]  ? mutex_lock+0x68/0xc0
[  472.075308]  kasan_report+0x139/0x170
[  472.075308]  ? mutex_lock+0x68/0xc0
[  472.075308]  kasan_check_range+0x2c3/0x2e0
[  472.075308]  mutex_lock+0x68/0xc0
[  472.075308]  l2cap_chan_timeout+0x181/0x300
[  472.075308]  process_one_work+0x5d2/0xe00
[  472.075308]  worker_thread+0xe1d/0x1660
[  472.075308]  ? pr_cont_work+0x5e0/0x5e0
[  472.075308]  kthread+0x2b7/0x350
[  472.075308]  ? pr_cont_work+0x5e0/0x5e0
[  472.075308]  ? kthread_blkcg+0xd0/0xd0
[  472.075308]  ret_from_fork+0x4d/0x80
[  472.075308]  ? kthread_blkcg+0xd0/0xd0
[  472.075308]  ret_from_fork_asm+0x11/0x20
[  472.075308]  </TASK>
[  472.075308] ==================================================================
[  472.094860] Disabling lock debugging due to kernel taint
[  472.096136] BUG: kernel NULL pointer dereference, address: 0000000000000158
[  472.096136] #PF: supervisor write access in kernel mode
[  472.096136] #PF: error_code(0x0002) - not-present page
[  472.096136] PGD 0 P4D 0
[  472.096136] Oops: 0002 [#1] PREEMPT SMP KASAN NOPTI
[  472.096136] CPU: 0 PID: 7 Comm: kworker/0:0 Tainted: G    B              6.9.0-rc5-00356-g78c0094a146b #36
[  472.096136] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu4
[  472.096136] Workqueue: events l2cap_chan_timeout
[  472.096136] RIP: 0010:mutex_lock+0x88/0xc0
[  472.096136] Code: be 08 00 00 00 e8 f8 23 1f fd 4c 89 f7 be 08 00 00 00 e8 eb 23 1f fd 42 80 3c 23 00 74 08 48 88
[  472.096136] RSP: 0018:ffff88800744fc78 EFLAGS: 00000246
[  472.096136] RAX: 0000000000000000 RBX: 1ffff11000e89f8f RCX: ffffffff8457c865
[  472.096136] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffff88800744fc78
[  472.096136] RBP: 0000000000000158 R08: ffff88800744fc7f R09: 1ffff11000e89f8f
[  472.096136] R10: dffffc0000000000 R11: ffffed1000e89f90 R12: dffffc0000000000
[  472.096136] R13: 0000000000000158 R14: ffff88800744fc78 R15: ffff888007405a00
[  472.096136] FS:  0000000000000000(0000) GS:ffff88806d200000(0000) knlGS:0000000000000000
[  472.096136] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  472.096136] CR2: 0000000000000158 CR3: 000000000da32000 CR4: 00000000000006f0
[  472.096136] Call Trace:
[  472.096136]  <TASK>
[  472.096136]  ? __die_body+0x8d/0xe0
[  472.096136]  ? page_fault_oops+0x6b8/0x9a0
[  472.096136]  ? kernelmode_fixup_or_oops+0x20c/0x2a0
[  472.096136]  ? do_user_addr_fault+0x1027/0x1340
[  472.096136]  ? _printk+0x7a/0xa0
[  472.096136]  ? mutex_lock+0x68/0xc0
[  472.096136]  ? add_taint+0x42/0xd0
[  472.096136]  ? exc_page_fault+0x6a/0x1b0
[  472.096136]  ? asm_exc_page_fault+0x26/0x30
[  472.096136]  ? mutex_lock+0x75/0xc0
[  472.096136]  ? mutex_lock+0x88/0xc0
[  472.096136]  ? mutex_lock+0x75/0xc0
[  472.096136]  l2cap_chan_timeout+0x181/0x300
[  472.096136]  process_one_work+0x5d2/0xe00
[  472.096136]  worker_thread+0xe1d/0x1660
[  472.096136]  ? pr_cont_work+0x5e0/0x5e0
[  472.096136]  kthread+0x2b7/0x350
[  472.096136]  ? pr_cont_work+0x5e0/0x5e0
[  472.096136]  ? kthread_blkcg+0xd0/0xd0
[  472.096136]  ret_from_fork+0x4d/0x80
[  472.096136]  ? kthread_blkcg+0xd0/0xd0
[  472.096136]  ret_from_fork_asm+0x11/0x20
[  472.096136]  </TASK>
[  472.096136] Modules linked in:
[  472.096136] CR2: 0000000000000158
[  472.096136] ---[ end trace 0000000000000000 ]---
[  472.096136] RIP: 0010:mutex_lock+0x88/0xc0
[  472.096136] Code: be 08 00 00 00 e8 f8 23 1f fd 4c 89 f7 be 08 00 00 00 e8 eb 23 1f fd 42 80 3c 23 00 74 08 48 88
[  472.096136] RSP: 0018:ffff88800744fc78 EFLAGS: 00000246
[  472.096136] RAX: 0000000000000000 RBX: 1ffff11000e89f8f RCX: ffffffff8457c865
[  472.096136] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffff88800744fc78
[  472.096136] RBP: 0000000000000158 R08: ffff88800744fc7f R09: 1ffff11000e89f8f
[  472.132932] R10: dffffc0000000000 R11: ffffed1000e89f90 R12: dffffc0000000000
[  472.132932] R13: 0000000000000158 R14: ffff88800744fc78 R15: ffff888007405a00
[  472.132932] FS:  0000000000000000(0000) GS:ffff88806d200000(0000) knlGS:0000000000000000
[  472.132932] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  472.132932] CR2: 0000000000000158 CR3: 000000000da32000 CR4: 00000000000006f0
[  472.132932] Kernel panic - not syncing: Fatal exception
[  472.132932] Kernel Offset: disabled
[  472.132932] ---[ end Kernel panic - not syncing: Fatal exception ]---

Add a check to judge whether the conn is null in l2cap_chan_timeout()
in order to mitigate the bug.

Fixes: 3df91ea20e74 ("Bluetooth: Revert to mutexes from RCU list")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 net/bluetooth/l2cap_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 84fc70862d7..5761d37c553 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -415,6 +415,9 @@ static void l2cap_chan_timeout(struct work_struct *work)
 
 	BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
 
+	if (!conn)
+		return;
+
 	mutex_lock(&conn->chan_lock);
 	/* __set_chan_timer() calls l2cap_chan_hold(chan) while scheduling
 	 * this work. No need to call l2cap_chan_hold(chan) here again.
-- 
2.17.1


