Return-Path: <linux-kernel+bounces-115451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 567E1889BA2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 098201F36779
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E73F21732C;
	Mon, 25 Mar 2024 02:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EiLubYF7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8650146D69;
	Sun, 24 Mar 2024 22:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320825; cv=none; b=TjPx3Iy7JyI/ZXf8SZ0HSbqQ0KFCZZDgfoNSiLdYEUMDQg8zGii495C+Yh9N8kGwlUmhZ/CHhzZKeyRW3V7eko9+3vzwrQHu0JnrP5tIT3Aztm+U+2Z7U+9gilH1E519vq1tTLt1s1HqKGDTUd8HvFQVTFDALQt7ROwUbO3aXig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320825; c=relaxed/simple;
	bh=1hojjrskATgievWWd4UEDME6Xz0+KX5VKU0JHzpTgL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6K3uoVhT1E9SyKbS0WFInM9Xrx5i+dwrk+wALxl8O4FrgOKgT3OlDuz6LofACx0G4Bne6cfVxErOSxYl12CdZQOxxr6f/TPyQZp2CV9TFiXy1PirAIpXENQFSOjtmwzf3qlFE/jIEZ5DwVw1N4ocpsRPP0h4doIQeyJUtc/UUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EiLubYF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C64C43390;
	Sun, 24 Mar 2024 22:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320823;
	bh=1hojjrskATgievWWd4UEDME6Xz0+KX5VKU0JHzpTgL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EiLubYF7ktS3spqtmSeAnqgZCGfNHMkY9nHgUb23odf625KLMCVJYipM9Nhz0cd1Z
	 ZB2apiJPaX0eMRfjhesjeX4BP6B1bnnvpLVR+nMAy+hd/Yhv+EvcuPPuX3l4Iw4f8F
	 PCDUiIaEA6vJcvbURETyyptmwOzhp2wXxcLxIue3niCF3FNe2n1IahZNlCCLGJzyUS
	 IEkzJV/FbSEDGlLavVJ+d4BP4HGcV+kDcHxgXpl1bqQhCOwFO2gY4zyOEUldmlCmuG
	 vR5jg404xKuYLX4bo/3JHa2c8Mya46fAHHMWMhJA3kl+hFNRAGwDIIhurRYa91FKew
	 zxyIR1fTeyeCg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 388/713] dm: call the resume method on internal suspend
Date: Sun, 24 Mar 2024 18:41:54 -0400
Message-ID: <20240324224720.1345309-389-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 23c32cd1f1d88..4ff9bebb81ad5 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2945,6 +2945,9 @@ static void __dm_internal_suspend(struct mapped_device *md, unsigned int suspend
 
 static void __dm_internal_resume(struct mapped_device *md)
 {
+	int r;
+	struct dm_table *map;
+
 	BUG_ON(!md->internal_suspend_count);
 
 	if (--md->internal_suspend_count)
@@ -2953,12 +2956,23 @@ static void __dm_internal_resume(struct mapped_device *md)
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


