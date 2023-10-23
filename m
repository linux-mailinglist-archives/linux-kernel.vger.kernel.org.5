Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21A57D4344
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 01:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjJWXhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 19:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjJWXh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 19:37:29 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CE6F9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 16:37:26 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 70795C021; Tue, 24 Oct 2023 01:37:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1698104243; bh=/A34CTskJseJi+dcqA1uEIZC2XG2pVw2hHNklQEakQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2DLrhRRq6njg7SLrk3WbzcM8N/46q79mgTGyaP+Y4UsZA9IAsvLg8UrMUkQDnhLai
         47r5jW+s0LYnQ+kUlpNRGbHdIW6ce4qjFqAWaNZGQb8wrYsLUmyBopuThwZQ4tzVLY
         ns++BcHak+wS9q+Mw+8M8i0lDqOVcr1rjCP1v236lW9x5gQ5pXmEqrhizKiIRIVnCf
         1fT9nYAtamv3TQrZsgIRRhpgBjbiRhU+8KC+8nRYDmzXYaKdh3pWzZnbaT6IwiWe8a
         28u3H1rA0xiZGPPfskQ8D76BQll/+zcjFRXNn8lP5TZktmJhEOLFMr+ojPRiiNtwgj
         iVL1rbm5tnGmw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from gaia (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id B3BC4C009;
        Tue, 24 Oct 2023 01:37:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1698104242; bh=/A34CTskJseJi+dcqA1uEIZC2XG2pVw2hHNklQEakQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H9q202+phVyt45nk/teha6weJN6/png6bkYoZNW6ao1p6BRyO4FgYWMGIk6gSm4yv
         x+Rdsf2lO5NyDeiJocV63AiF77nMyntK2AXb0yjd4QgRJaPRTcnGAizwfR8OFCU3Fh
         XGmc27IUykFBEgB2AYeA47YCFFx3H4+HUc2gTcEebovIS63OVAshRNGQGfhUF9UsAq
         VZKjILf2nDgY/sL0cr0KcwiBiGWQPEdquVObzzsD2EHShTwkze9tF78G9Qeztdu6lN
         OpODxoG+xIiGbgNx9U7Slo+cW1IeCiPRfOKXnae6VxgHyg2KvuSZJ1ZlcmsdakVcxP
         7AD0G8iwggf8Q==
Received: from gaia.codewreck.org (localhost.lan [::1])
        by gaia (OpenSMTPD) with ESMTP id 1bf2bc7c;
        Mon, 23 Oct 2023 23:37:15 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     v9fs@lists.linux.dev, ericvh@kernel.org, linux_oss@crudebyte.com
Cc:     lucho@ionkov.net, linux-kernel@vger.kernel.org,
        Marco Elver <elver@google.com>,
        syzbot+e441aeeb422763cc5511@syzkaller.appspotmail.com,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 1/3] 9p: Annotate data-racy writes to file::f_flags on fd mount
Date:   Tue, 24 Oct 2023 08:37:02 +0900
Message-ID: <20231023233704.1185154-2-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231023233704.1185154-1-asmadeus@codewreck.org>
References: <20231023233704.1185154-1-asmadeus@codewreck.org>
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

Hi Marco, sorry for taking ages to process this patch. I've reworded the
commit message a bit and added a comment, so given this has your name on
it please have a look.
I'm planning to send this to Linus during the merge window next week

 net/9p/trans_fd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index f226953577b2..d89c88986950 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -836,14 +836,16 @@ static int p9_fd_open(struct p9_client *client, int rfd, int wfd)
 		goto out_free_ts;
 	if (!(ts->rd->f_mode & FMODE_READ))
 		goto out_put_rd;
-	/* prevent workers from hanging on IO when fd is a pipe */
-	ts->rd->f_flags |= O_NONBLOCK;
+	/* Prevent workers from hanging on IO when fd is a pipe
+	 * We don't support userspace messing with the fd after passing it
+	 * to mount, so flag possible data race for KCSAN */
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

