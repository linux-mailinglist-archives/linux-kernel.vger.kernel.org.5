Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900817D68D6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343753AbjJYKgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343747AbjJYKfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:35:22 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433A0DD
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 03:35:01 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 768B3C01C; Wed, 25 Oct 2023 12:34:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1698230099; bh=WMmE+1h6Xwn1xLkMKQHwODUtDZc1edPW0I8KanvCU4M=;
        h=From:To:Cc:Subject:Date:From;
        b=n4J43OcjALjXziE7yaAGF03U1OP8mDpOhObvXl36vrglDt92fFWnjRimMkCfpX/0m
         VA9JdAIVhQ19Ty1NF+jbJXquzaYpuNPk3EQdKMoSbafpUFMIeabnd19Q9bTBBe1y0B
         rOpCkUy9ikzRF4+AjJLxBRy5yVYRM24m8C5ks2yYVXfejw/AWmROU0Q8+pS4+l9XxQ
         iYaPoBbrTFOVbzkyljWAG81FgipDBGu82Raj/+fB+pMG6A5baT+R6cnoh3Fb0ffP9k
         swNSZtkJcjmgClH5dcppc9aX2b77677Dgfb2hpvRgDMVGkFSnTMFxlNGRn52pYiTTv
         O5nkYaDay9Pqw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from gaia (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 6DE23C01C;
        Wed, 25 Oct 2023 12:34:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1698230098; bh=WMmE+1h6Xwn1xLkMKQHwODUtDZc1edPW0I8KanvCU4M=;
        h=From:To:Cc:Subject:Date:From;
        b=0UFC36EIExrT623/E5YD4kWC98wdcQIxvuWxRoUMUrtMY+ygAqx4LV/oprP8zC4Br
         cxQz/geWp84quDE4D5GTH+J8nARa7H7Lx/WVHsg5niBF/JMs8pRNI/EWx9qpsg2x/c
         rvLbcwlHjbB52t1y04hVjoltBUres7EGoW6jSxD0UquJnHgC1QHL2px3Dnjhdj+pfk
         boPjSRiQWtQnVNRbf/1as5QVYxEDDoDg0X7vvL0jzbGEecbgPsw4+BsDLvbEkZDNP7
         DTcZb6TUmCtCLAMYdXxctutXwqj3h2qbC4Ytsmv9CfaUEdZfzo6419zGxVIzSckRL9
         U+gJwkfYABf5g==
Received: from gaia.codewreck.org (localhost.lan [::1])
        by gaia (OpenSMTPD) with ESMTP id 2192dabf;
        Wed, 25 Oct 2023 10:34:52 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     v9fs@lists.linux.dev
Cc:     ericvh@kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net,
        linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>,
        syzbot+e441aeeb422763cc5511@syzkaller.appspotmail.com,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH v2 1/3] 9p/trans_fd: Annotate data-racy writes to file::f_flags
Date:   Wed, 25 Oct 2023 19:34:43 +0900
Message-ID: <20231025103445.1248103-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

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
---
v1 -> v2:
 - reworded comment as discussed
 - adjusted commit subject line to match with other trans_fd patch

(there is no change from the one I sent yesterday, I'm just resending
the whole set properly now there's been feedback on other commits)

 net/9p/trans_fd.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index f226953577b2..1a3948b8c493 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -836,14 +836,21 @@ static int p9_fd_open(struct p9_client *client, int rfd, int wfd)
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
2.41.0

