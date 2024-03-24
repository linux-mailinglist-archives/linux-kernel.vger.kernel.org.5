Return-Path: <linux-kernel+bounces-116053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CCA889534
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61681F30858
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADC82779CB;
	Mon, 25 Mar 2024 03:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cikhaUrj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E50A278991;
	Sun, 24 Mar 2024 23:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323452; cv=none; b=n8wTIdwkk0ppemPAnnwKktEXhwCYq6hScez9xfPVYd6plg9hLB1+hkUxGYXaVsiRr/YZh8mQtOWgIlDJcu4xZ0ydkH/KAt5CLWC0uyM0fN6HnOCCI/ghRc7GL9wunybSp60E2VjRJ2kG5kaBv+CQqg3RZ2HcBN4XKgAsICsvYm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323452; c=relaxed/simple;
	bh=Bm86FRU++3NWujhe4JEoNuuQlX8qKcrsPfa2rG3J7UY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0XFf4shBzSeEh5agIX9cPgpf090QR1oGDUd5NcHZ/fVraietWXa7yhs3nOl1Y5j50LGmdl1hyYv5i2dMgBSn+Hy7GP9MFCyoCIpBGSzKrMOxBg2IIjvnbE2XPXAKOcbM3n8KSGtO+6TryqIKfBozus19YwPsgyY3lbM05d/94U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cikhaUrj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB59C433C7;
	Sun, 24 Mar 2024 23:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323452;
	bh=Bm86FRU++3NWujhe4JEoNuuQlX8qKcrsPfa2rG3J7UY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cikhaUrjPZDH27z6RjVop8CDxFBIe+aIHloOfWt6S644/PYVdeu1gnGZXfROG2IFw
	 4uDoPe4jHchEnde9VbKLTVvuOgBR9LKGword1rEZzS9fc/XNh+jT+qtMEHn8ExTVm6
	 VzQ+iL5rskgqU3zXizhyF64t6x4uICa/dwkEW41vyktpdZ81eupvXEH1LT47bhp2Vo
	 61Vj6stpuLh8Om5YXmO8YEqiArK0Wldv8nknW7f8uFfhH/0srSK7JM96a8adZUvs3Y
	 GpJdvryUtdp8AeeB/HSzGSpvVZCm6oaxBMs79Dg8+LyEwfdqcMvtR+0c9KX/FV1h2v
	 HXUXwyK2Ezcvg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 155/317] dm: call the resume method on internal suspend
Date: Sun, 24 Mar 2024 19:32:15 -0400
Message-ID: <20240324233458.1352854-156-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit 65e8fbde64520001abf1c8d0e573561b4746ef38 ]

There is this reported crash when experimenting with the lvm2 testsuite.
The list corruption is caused by the fact that the postsuspend and resume
methods were not paired correctly; there were two consecutive calls to the
origin_postsuspend function. The second call attempts to remove the
"hash_list" entry from a list, while it was already removed by the first
call.

Fix __dm_internal_resume so that it calls the preresume and resume
methods of the table's targets.

If a preresume method of some target fails, we are in a tricky situation.
We can't return an error because dm_internal_resume isn't supposed to
return errors. We can't return success, because then the "resume" and
"postsuspend" methods would not be paired correctly. So, we set the
DMF_SUSPENDED flag and we fake normal suspend - it may confuse userspace
tools, but it won't cause a kernel crash.

------------[ cut here ]------------
kernel BUG at lib/list_debug.c:56!
invalid opcode: 0000 [#1] PREEMPT SMP
CPU: 1 PID: 8343 Comm: dmsetup Not tainted 6.8.0-rc6 #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
RIP: 0010:__list_del_entry_valid_or_report+0x77/0xc0
<snip>
RSP: 0018:ffff8881b831bcc0 EFLAGS: 00010282
RAX: 000000000000004e RBX: ffff888143b6eb80 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff819053d0 RDI: 00000000ffffffff
RBP: ffff8881b83a3400 R08: 00000000fffeffff R09: 0000000000000058
R10: 0000000000000000 R11: ffffffff81a24080 R12: 0000000000000001
R13: ffff88814538e000 R14: ffff888143bc6dc0 R15: ffffffffa02e4bb0
FS:  00000000f7c0f780(0000) GS:ffff8893f0a40000(0000) knlGS:0000000000000000
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000057fb5000 CR3: 0000000143474000 CR4: 00000000000006b0
Call Trace:
 <TASK>
 ? die+0x2d/0x80
 ? do_trap+0xeb/0xf0
 ? __list_del_entry_valid_or_report+0x77/0xc0
 ? do_error_trap+0x60/0x80
 ? __list_del_entry_valid_or_report+0x77/0xc0
 ? exc_invalid_op+0x49/0x60
 ? __list_del_entry_valid_or_report+0x77/0xc0
 ? asm_exc_invalid_op+0x16/0x20
 ? table_deps+0x1b0/0x1b0 [dm_mod]
 ? __list_del_entry_valid_or_report+0x77/0xc0
 origin_postsuspend+0x1a/0x50 [dm_snapshot]
 dm_table_postsuspend_targets+0x34/0x50 [dm_mod]
 dm_suspend+0xd8/0xf0 [dm_mod]
 dev_suspend+0x1f2/0x2f0 [dm_mod]
 ? table_deps+0x1b0/0x1b0 [dm_mod]
 ctl_ioctl+0x300/0x5f0 [dm_mod]
 dm_compat_ctl_ioctl+0x7/0x10 [dm_mod]
 __x64_compat_sys_ioctl+0x104/0x170
 do_syscall_64+0x184/0x1b0
 entry_SYSCALL_64_after_hwframe+0x46/0x4e
RIP: 0033:0xf7e6aead
<snip>
---[ end trace 0000000000000000 ]---

Fixes: ffcc39364160 ("dm: enhance internal suspend and resume interface")
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index d6285a23dc3ed..fd9bb8b53219a 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2641,6 +2641,9 @@ static void __dm_internal_suspend(struct mapped_device *md, unsigned suspend_fla
 
 static void __dm_internal_resume(struct mapped_device *md)
 {
+	int r;
+	struct dm_table *map;
+
 	BUG_ON(!md->internal_suspend_count);
 
 	if (--md->internal_suspend_count)
@@ -2649,12 +2652,23 @@ static void __dm_internal_resume(struct mapped_device *md)
 	if (dm_suspended_md(md))
 		goto done; /* resume from nested suspend */
 
-	/*
-	 * NOTE: existing callers don't need to call dm_table_resume_targets
-	 * (which may fail -- so best to avoid it for now by passing NULL map)
-	 */
-	(void) __dm_resume(md, NULL);
-
+	map = rcu_dereference_protected(md->map, lockdep_is_held(&md->suspend_lock));
+	r = __dm_resume(md, map);
+	if (r) {
+		/*
+		 * If a preresume method of some target failed, we are in a
+		 * tricky situation. We can't return an error to the caller. We
+		 * can't fake success because then the "resume" and
+		 * "postsuspend" methods would not be paired correctly, and it
+		 * would break various targets, for example it would cause list
+		 * corruption in the "origin" target.
+		 *
+		 * So, we fake normal suspend here, to make sure that the
+		 * "resume" and "postsuspend" methods will be paired correctly.
+		 */
+		DMERR("Preresume method failed: %d", r);
+		set_bit(DMF_SUSPENDED, &md->flags);
+	}
 done:
 	clear_bit(DMF_SUSPENDED_INTERNALLY, &md->flags);
 	smp_mb__after_atomic();
-- 
2.43.0


