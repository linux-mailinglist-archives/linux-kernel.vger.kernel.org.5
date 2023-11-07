Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379FD7E4D55
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344421AbjKGX2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344526AbjKGX1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:27:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09B035B7;
        Tue,  7 Nov 2023 15:24:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20546C433C9;
        Tue,  7 Nov 2023 23:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699399497;
        bh=YoEAinzpXVzETYSEib6Djyp53Q1sMfVQG78G4mx3CXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hMWUpHC2D+cgp8mRVqflcWBIpa2aRSyngEzFftdLQd4cscVcDDClGRlPvEhf30WSM
         s4zwM91my0y49UNMLCF+JDiRQuHBgOIOImkKsr+9lqHILhy/Z2sO7YQYOCQrMcSbrh
         AVsrOznfWhsh6p1ZNjdoYMq0hI9Q+mC6mA9lZl06vSZRXFYW2CREpMEhfSm1Dgikcz
         +U8dh/6zVOEoQCak1EMYVMop0qhaBgeKCgNhu71pzHiXtNpDE8JDwjoTieHxAa49kU
         MAKagdmak5X6LVwYpdPQm0/6usSm0EyVOAMwsvY8VOtsiL//geMw+YyA38nKZ/Vqi+
         MeBSxnNii1nXw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marco Elver <elver@google.com>,
        syzbot+e441aeeb422763cc5511@syzkaller.appspotmail.com,
        Dominique Martinet <asmadeus@codewreck.org>,
        Sasha Levin <sashal@kernel.org>, ericvh@kernel.org,
        lucho@ionkov.net, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, v9fs@lists.linux.dev,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 5/6] 9p/trans_fd: Annotate data-racy writes to file::f_flags
Date:   Tue,  7 Nov 2023 18:24:41 -0500
Message-ID: <20231107232446.3776662-5-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107232446.3776662-1-sashal@kernel.org>
References: <20231107232446.3776662-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.137
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

[ Upstream commit 355f074609dbf3042900ea9d30fcd2b0c323a365 ]

syzbot reported:

 | BUG: KCSAN: data-race in p9_fd_create / p9_fd_create
 |
 | read-write to 0xffff888130fb3d48 of 4 bytes by task 15599 on cpu 0:
 |  p9_fd_open net/9p/trans_fd.c:842 [inline]
 |  p9_fd_create+0x210/0x250 net/9p/trans_fd.c:1092
 |  p9_client_create+0x595/0xa70 net/9p/client.c:1010
 |  v9fs_session_init+0xf9/0xd90 fs/9p/v9fs.c:410
 |  v9fs_mount+0x69/0x630 fs/9p/vfs_super.c:123
 |  legacy_get_tree+0x74/0xd0 fs/fs_context.c:611
 |  vfs_get_tree+0x51/0x190 fs/super.c:1519
 |  do_new_mount+0x203/0x660 fs/namespace.c:3335
 |  path_mount+0x496/0xb30 fs/namespace.c:3662
 |  do_mount fs/namespace.c:3675 [inline]
 |  __do_sys_mount fs/namespace.c:3884 [inline]
 |  [...]
 |
 | read-write to 0xffff888130fb3d48 of 4 bytes by task 15563 on cpu 1:
 |  p9_fd_open net/9p/trans_fd.c:842 [inline]
 |  p9_fd_create+0x210/0x250 net/9p/trans_fd.c:1092
 |  p9_client_create+0x595/0xa70 net/9p/client.c:1010
 |  v9fs_session_init+0xf9/0xd90 fs/9p/v9fs.c:410
 |  v9fs_mount+0x69/0x630 fs/9p/vfs_super.c:123
 |  legacy_get_tree+0x74/0xd0 fs/fs_context.c:611
 |  vfs_get_tree+0x51/0x190 fs/super.c:1519
 |  do_new_mount+0x203/0x660 fs/namespace.c:3335
 |  path_mount+0x496/0xb30 fs/namespace.c:3662
 |  do_mount fs/namespace.c:3675 [inline]
 |  __do_sys_mount fs/namespace.c:3884 [inline]
 |  [...]
 |
 | value changed: 0x00008002 -> 0x00008802

Within p9_fd_open(), O_NONBLOCK is added to f_flags of the read and
write files. This may happen concurrently if e.g. mounting process
modifies the fd in another thread.

Mark the plain read-modify-writes as intentional data-races, with the
assumption that the result of executing the accesses concurrently will
always result in the same result despite the accesses themselves not
being atomic.

Reported-by: syzbot+e441aeeb422763cc5511@syzkaller.appspotmail.com
Signed-off-by: Marco Elver <elver@google.com>
Link: https://lore.kernel.org/r/ZO38mqkS0TYUlpFp@elver.google.com
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
Message-ID: <20231025103445.1248103-1-asmadeus@codewreck.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/9p/trans_fd.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index f359cfdc1858f..b44b77d3b35d1 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -835,14 +835,21 @@ static int p9_fd_open(struct p9_client *client, int rfd, int wfd)
 		goto out_free_ts;
 	if (!(ts->rd->f_mode & FMODE_READ))
 		goto out_put_rd;
-	/* prevent workers from hanging on IO when fd is a pipe */
-	ts->rd->f_flags |= O_NONBLOCK;
+	/* Prevent workers from hanging on IO when fd is a pipe.
+	 * It's technically possible for userspace or concurrent mounts to
+	 * modify this flag concurrently, which will likely result in a
+	 * broken filesystem. However, just having bad flags here should
+	 * not crash the kernel or cause any other sort of bug, so mark this
+	 * particular data race as intentional so that tooling (like KCSAN)
+	 * can allow it and detect further problems.
+	 */
+	data_race(ts->rd->f_flags |= O_NONBLOCK);
 	ts->wr = fget(wfd);
 	if (!ts->wr)
 		goto out_put_rd;
 	if (!(ts->wr->f_mode & FMODE_WRITE))
 		goto out_put_wr;
-	ts->wr->f_flags |= O_NONBLOCK;
+	data_race(ts->wr->f_flags |= O_NONBLOCK);
 
 	client->trans = ts;
 	client->status = Connected;
-- 
2.42.0

