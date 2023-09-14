Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CD879F68D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 03:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbjINByy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 21:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbjINByw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 21:54:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E271BCB;
        Wed, 13 Sep 2023 18:54:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11370C433C7;
        Thu, 14 Sep 2023 01:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694656488;
        bh=G1EV1d5/fuH1zb/5FxsrxauST3cT3okfTbj6X3rQ55Q=;
        h=From:To:Cc:Subject:Date:From;
        b=JJnp7C+dSP4j2NsSucOVDq+LcB+kOs1pG50D1DxcW8P4DpJlsPrvOFNvnz0+RNO6B
         DESB29LHOUXgGUDNMHM9lbEARi94/DXMBHJzuhgR+0sw+UQQHJPsLB2wqiiY998Yru
         R2lyIF40yRPPjRTaHU0Iv8DzNHjOs3nljjCBn5wOGN2IKieHytXtzZUW0v3XIEu912
         oq/Kpg+bPPecQKlTwhUpOeCuaE9EDbCK35IaqVok34CHmec4c2B7ZoxNCAEjImUOIa
         1COCTt4hfLGvBedU1XlwDDa0mnhmoSjCcxZ0Exy3W1VN1PsdD66vsYH6qlynDtva4t
         sHLdUZhZch5hg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        syzbot+3f6a670108ce43356017@syzkaller.appspotmail.com,
        Sasha Levin <sashal@kernel.org>, rpeterso@redhat.com,
        gfs2@lists.linux.dev
Subject: [PATCH AUTOSEL 6.5] gfs2: Stop using gfs2_make_fs_ro for withdraw
Date:   Wed, 13 Sep 2023 21:54:44 -0400
Message-Id: <20230914015445.51657-1-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.3
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit f66af88e33212b57ea86da2c5d66c0d9d5c46344 ]

[   81.372851][ T5532] CPU: 1 PID: 5532 Comm: syz-executor.0 Not tainted 6.2.0-rc1-syzkaller-dirty #0
[   81.382080][ T5532] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
[   81.392343][ T5532] Call Trace:
[   81.395654][ T5532]  <TASK>
[   81.398603][ T5532]  dump_stack_lvl+0x1b1/0x290
[   81.418421][ T5532]  gfs2_assert_warn_i+0x19a/0x2e0
[   81.423480][ T5532]  gfs2_quota_cleanup+0x4c6/0x6b0
[   81.428611][ T5532]  gfs2_make_fs_ro+0x517/0x610
[   81.457802][ T5532]  gfs2_withdraw+0x609/0x1540
[   81.481452][ T5532]  gfs2_inode_refresh+0xb2d/0xf60
[   81.506658][ T5532]  gfs2_instantiate+0x15e/0x220
[   81.511504][ T5532]  gfs2_glock_wait+0x1d9/0x2a0
[   81.516352][ T5532]  do_sync+0x485/0xc80
[   81.554943][ T5532]  gfs2_quota_sync+0x3da/0x8b0
[   81.559738][ T5532]  gfs2_sync_fs+0x49/0xb0
[   81.564063][ T5532]  sync_filesystem+0xe8/0x220
[   81.568740][ T5532]  generic_shutdown_super+0x6b/0x310
[   81.574112][ T5532]  kill_block_super+0x79/0xd0
[   81.578779][ T5532]  deactivate_locked_super+0xa7/0xf0
[   81.584064][ T5532]  cleanup_mnt+0x494/0x520
[   81.593753][ T5532]  task_work_run+0x243/0x300
[   81.608837][ T5532]  exit_to_user_mode_loop+0x124/0x150
[   81.614232][ T5532]  exit_to_user_mode_prepare+0xb2/0x140
[   81.619820][ T5532]  syscall_exit_to_user_mode+0x26/0x60
[   81.625287][ T5532]  do_syscall_64+0x49/0xb0
[   81.629710][ T5532]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

In this backtrace, gfs2_quota_sync() takes quota data references and
then calls do_sync().  Function do_sync() encounters filesystem
corruption and withdraws the filesystem, which (among other things) calls
gfs2_quota_cleanup().  Function gfs2_quota_cleanup() wrongly assumes
that nobody is holding any quota data references anymore, and destroys
all quota data objects.  When gfs2_quota_sync() then resumes and
dereferences the quota data objects it is holding, those objects are no
longer there.

Function gfs2_quota_cleanup() deals with resource deallocation and can
easily be delayed until gfs2_put_super() in the case of a filesystem
withdraw.  In fact, most of the other work gfs2_make_fs_ro() does is
unnecessary during a withdraw as well, so change signal_our_withdraw()
to skip gfs2_make_fs_ro() and perform the necessary steps directly
instead.

Thanks to Edward Adam Davis <eadavis@sina.com> for the initial patches.

Link: https://lore.kernel.org/all/0000000000002b5e2405f14e860f@google.com
Reported-by: syzbot+3f6a670108ce43356017@syzkaller.appspotmail.com
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/super.c |  9 ++-------
 fs/gfs2/util.c  | 19 ++++++++++++++++++-
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 9f4d5d6549ee6..2382c755362d7 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -580,15 +580,8 @@ void gfs2_make_fs_ro(struct gfs2_sbd *sdp)
 				   gfs2_log_is_empty(sdp),
 				   HZ * 5);
 		gfs2_assert_warn(sdp, gfs2_log_is_empty(sdp));
-	} else {
-		wait_event_timeout(sdp->sd_log_waitq,
-				   gfs2_log_is_empty(sdp),
-				   HZ * 5);
 	}
 	gfs2_quota_cleanup(sdp);
-
-	if (!log_write_allowed)
-		sdp->sd_vfs->s_flags |= SB_RDONLY;
 }
 
 /**
@@ -622,6 +615,8 @@ static void gfs2_put_super(struct super_block *sb)
 	if (!sb_rdonly(sb)) {
 		gfs2_make_fs_ro(sdp);
 	}
+	if (gfs2_withdrawn(sdp))
+		gfs2_quota_cleanup(sdp);
 	WARN_ON(gfs2_withdrawing(sdp));
 
 	/*  At this point, we're through modifying the disk  */
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index dac22b1c1a2e1..b3086a9baf001 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -9,6 +9,7 @@
 #include <linux/spinlock.h>
 #include <linux/completion.h>
 #include <linux/buffer_head.h>
+#include <linux/kthread.h>
 #include <linux/crc32.h>
 #include <linux/gfs2_ondisk.h>
 #include <linux/delay.h>
@@ -150,7 +151,23 @@ static void signal_our_withdraw(struct gfs2_sbd *sdp)
 	if (!sb_rdonly(sdp->sd_vfs)) {
 		bool locked = mutex_trylock(&sdp->sd_freeze_mutex);
 
-		gfs2_make_fs_ro(sdp);
+		if (sdp->sd_quotad_process &&
+		    current != sdp->sd_quotad_process) {
+			kthread_stop(sdp->sd_quotad_process);
+			sdp->sd_quotad_process = NULL;
+		}
+
+		if (sdp->sd_logd_process &&
+		    current != sdp->sd_logd_process) {
+			kthread_stop(sdp->sd_logd_process);
+			sdp->sd_logd_process = NULL;
+		}
+
+		wait_event_timeout(sdp->sd_log_waitq,
+				   gfs2_log_is_empty(sdp),
+				   HZ * 5);
+
+		sdp->sd_vfs->s_flags |= SB_RDONLY;
 
 		if (locked)
 			mutex_unlock(&sdp->sd_freeze_mutex);
-- 
2.40.1

