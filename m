Return-Path: <linux-kernel+bounces-150928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E638AA6D0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 04:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4701F22BE0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 02:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F20522E;
	Fri, 19 Apr 2024 02:05:26 +0000 (UTC)
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBC4137E;
	Fri, 19 Apr 2024 02:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713492326; cv=none; b=LC+LEGEJFwyIxMZYe+3wFzsNLEkHX8ZDHPyd3705OVmlNYW29+B5gfnAa+XQ/tUg/MSe2y8whQBimBJEg6D//qXyMSj8cjZd3K3D7pM8BY0vF7KcWNUUjKxGP3WimKCcQNyovnXGMvuERFg/CXR2JOns21NXZBjHWbCVLi1D7Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713492326; c=relaxed/simple;
	bh=lLaQL2AevUNbrcfqQNQZujhkG4RDyJvjEoqKhxXvtj4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=qApVb3Wbwr7qrk3ZRvBLt199VeTSZVHAF34Ey3kNMBnAJefu6o5Csj5/I0V5UGIh7GGTRSMGWDAh7beMIeB82oOhveKvexYSR6z5N/CjcPqwhXIroV3nW9aNorfsQLsTO/R9xF2EtgpB59ihOMugX5TNwPVICLieajP319a0cho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from ubuntu.localdomain (unknown [221.192.178.244])
	by mail-app2 (Coremail) with SMTP id by_KCgCHE4ZJ0SFmEBonAQ--.54658S2;
	Fri, 19 Apr 2024 10:05:01 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: linux-hams@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jreuter@yaina.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH net] ax25: Fix netdev refcount issue
Date: Fri, 19 Apr 2024 10:04:56 +0800
Message-Id: <20240419020456.29826-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:by_KCgCHE4ZJ0SFmEBonAQ--.54658S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF48AFWktw1kury5ZF1kZrb_yoWrXF4UpF
	y3AFs5GrWvqr1kta18t3Z5GryUCFs8Za4UZr1IvFyvk3W5Jw1Uta40ka1DKFyUWr98JF47
	Xa4q93W8tr9rJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	tVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUU
	U==
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwIQAWYhJRwF-AAbsM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The dev_tracker is added to ax25_cb in ax25_bind(). When the
ax25 device is detaching, the dev_tracker of ax25_cb should be
deallocated in ax25_kill_by_device() instead of the dev_tracker
of ax25_dev. The log reported by ref_tracker is shown below:

[   80.884935] ref_tracker: reference already released.
[   80.885150] ref_tracker: allocated in:
[   80.885349]  ax25_dev_device_up+0x105/0x540
[   80.885730]  ax25_device_event+0xa4/0x420
[   80.885730]  notifier_call_chain+0xc9/0x1e0
[   80.885730]  __dev_notify_flags+0x138/0x280
[   80.885730]  dev_change_flags+0xd7/0x180
[   80.885730]  dev_ifsioc+0x6a9/0xa30
[   80.885730]  dev_ioctl+0x4d8/0xd90
[   80.885730]  sock_do_ioctl+0x1c2/0x2d0
[   80.885730]  sock_ioctl+0x38b/0x4f0
[   80.885730]  __se_sys_ioctl+0xad/0xf0
[   80.885730]  do_syscall_64+0xc4/0x1b0
[   80.885730]  entry_SYSCALL_64_after_hwframe+0x67/0x6f
[   80.885730] ref_tracker: freed in:
[   80.885730]  ax25_device_event+0x272/0x420
[   80.885730]  notifier_call_chain+0xc9/0x1e0
[   80.885730]  dev_close_many+0x272/0x370
[   80.885730]  unregister_netdevice_many_notify+0x3b5/0x1180
[   80.885730]  unregister_netdev+0xcf/0x120
[   80.885730]  sixpack_close+0x11f/0x1b0
[   80.885730]  tty_ldisc_kill+0xcb/0x190
[   80.885730]  tty_ldisc_hangup+0x338/0x3d0
[   80.885730]  __tty_hangup+0x504/0x740
[   80.885730]  tty_release+0x46e/0xd80
[   80.885730]  __fput+0x37f/0x770
[   80.885730]  __x64_sys_close+0x7b/0xb0
[   80.885730]  do_syscall_64+0xc4/0x1b0
[   80.885730]  entry_SYSCALL_64_after_hwframe+0x67/0x6f
[   80.893739] ------------[ cut here ]------------
[   80.894030] WARNING: CPU: 2 PID: 140 at lib/ref_tracker.c:255 ref_tracker_free+0x47b/0x6b0
[   80.894297] Modules linked in:
[   80.894929] CPU: 2 PID: 140 Comm: ax25_conn_rel_6 Not tainted 6.9.0-rc4-g8cd26fd90c1a #11
[   80.895190] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qem4
[   80.895514] RIP: 0010:ref_tracker_free+0x47b/0x6b0
[   80.895808] Code: 83 c5 18 4c 89 eb 48 c1 eb 03 8a 04 13 84 c0 0f 85 df 01 00 00 41 83 7d 00 00 75 4b 4c 89 ff 9
[   80.896171] RSP: 0018:ffff888009edf8c0 EFLAGS: 00000286
[   80.896339] RAX: 1ffff1100141ac00 RBX: 1ffff1100149463b RCX: dffffc0000000000
[   80.896502] RDX: 0000000000000001 RSI: 0000000000000246 RDI: ffff88800a0d6518
[   80.896925] RBP: ffff888009edf9b0 R08: ffff88806d3288d3 R09: 1ffff1100da6511a
[   80.897212] R10: dffffc0000000000 R11: ffffed100da6511b R12: ffff88800a4a31d4
[   80.897859] R13: ffff88800a4a31d8 R14: dffffc0000000000 R15: ffff88800a0d6518
[   80.898279] FS:  00007fd88b7fe700(0000) GS:ffff88806d300000(0000) knlGS:0000000000000000
[   80.899436] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   80.900181] CR2: 00007fd88c001d48 CR3: 000000000993e000 CR4: 00000000000006f0
..
[   80.935774] ref_tracker: sp%d@000000000bb9df3d has 1/1 users at
[   80.935774]      ax25_bind+0x424/0x4e0
[   80.935774]      __sys_bind+0x1d9/0x270
[   80.935774]      __x64_sys_bind+0x75/0x80
[   80.935774]      do_syscall_64+0xc4/0x1b0
[   80.935774]      entry_SYSCALL_64_after_hwframe+0x67/0x6f

Change ax25_dev->dev_tracker to the dev_tracker of ax25_cb
in order to mitigate the bug.

Fixes: feef318c855a ("ax25: fix UAF bugs of net_device caused by rebinding operation")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 net/ax25/af_ax25.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
index 558e158c98d..9169efb2f43 100644
--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -103,7 +103,7 @@ static void ax25_kill_by_device(struct net_device *dev)
 			s->ax25_dev = NULL;
 			if (sk->sk_socket) {
 				netdev_put(ax25_dev->dev,
-					   &ax25_dev->dev_tracker);
+					   &s->dev_tracker);
 				ax25_dev_put(ax25_dev);
 			}
 			ax25_cb_del(s);
-- 
2.17.1


