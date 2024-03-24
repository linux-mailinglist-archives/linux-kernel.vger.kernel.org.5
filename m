Return-Path: <linux-kernel+bounces-116240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F07889DCC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BD3DB2A97C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155C73C2F80;
	Mon, 25 Mar 2024 03:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLjAWsRj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7336D17E3BD;
	Sun, 24 Mar 2024 23:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324003; cv=none; b=iSjXhNNm/YwI83Y2ZhKeDlwZlxzvx0Cw4WJlY5RzyLWouB38wJFwwjnK2oqgY/JZXROdJPyC43bv53jB11TbV3tkAT4Kc75ZRDch/2SWBVkea0PMailxBxERx3eXEZ+ACfbQ3ErLuAj2Qv4HtTOxAr+rLTtHYXU4TuCwAhSr1QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324003; c=relaxed/simple;
	bh=8SlzC+69nG3/1cKu3UH6WI7Twg+uVJqHbd/cBgcKaXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1uwrZh5OxcoHCxcdIPxkDKKKCP5NbCXeYsNV0bH41AWenywE9HTT0hS5PDOFvgsUmyHWr8M9V+Idn4Oh5kNuRu0Iqier5cKG4O8KPG9SNa9WojpaNA32tZs+hlpVlAXjYMikDgwbadyQNEIyYnmvsBwA7vzh4/zRLCSojLbb54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLjAWsRj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A701C43390;
	Sun, 24 Mar 2024 23:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324002;
	bh=8SlzC+69nG3/1cKu3UH6WI7Twg+uVJqHbd/cBgcKaXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oLjAWsRjl6MS63X0bnp1Efu/4hbcyIXpPo1uBF34F8utRkUJek7jqfhUQGWyR7nYJ
	 i+bHg5pmR8Nh3ZkaY8mGcBz3R9ougPUcinK55H/NDI1/hvJL/jtuZRRiJS/mw64ngH
	 aRO/e7XTyijE/7nvBPPZNotmO/V/prUZZXOdOSs9SnxqODQTDslCzJZelJ6HEIwafx
	 +KEvTHVQkeIwML6P4MMaK63Y9V2SLoK4ju4Monn4qWJ3kFCkRIg44xT0Q+qomyVuNV
	 gGuYab4/eIJ7PWLiXPig7ufFpyPSlAYD5IH8NAQODunNRfNviT/fZn9OylRaUk+rfa
	 Tlj835I/KlblA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 002/183] io_uring: drop any code related to SCM_RIGHTS
Date: Sun, 24 Mar 2024 19:43:35 -0400
Message-ID: <20240324234638.1355609-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jens Axboe <axboe@kernel.dk>

Commit 6e5e6d274956305f1fc0340522b38f5f5be74bdb upstream.

This is dead code after we dropped support for passing io_uring fds
over SCM_RIGHTS, get rid of it.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/io_uring.c | 47 +++--------------------------------------------
 1 file changed, 3 insertions(+), 44 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index cd1858cc63206..2c793e4ccf096 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -63,7 +63,6 @@
 #include <linux/net.h>
 #include <net/sock.h>
 #include <net/af_unix.h>
-#include <net/scm.h>
 #include <linux/anon_inodes.h>
 #include <linux/sched/mm.h>
 #include <linux/uaccess.h>
@@ -264,10 +263,6 @@ struct io_ring_ctx {
 
 	struct async_list	pending_async[2];
 
-#if defined(CONFIG_UNIX)
-	struct socket		*ring_sock;
-#endif
-
 	struct list_head	task_list;
 	spinlock_t		task_lock;
 };
@@ -3067,20 +3062,10 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 
 static void __io_sqe_files_unregister(struct io_ring_ctx *ctx)
 {
-#if defined(CONFIG_UNIX)
-	if (ctx->ring_sock) {
-		struct sock *sock = ctx->ring_sock->sk;
-		struct sk_buff *skb;
-
-		while ((skb = skb_dequeue(&sock->sk_receive_queue)) != NULL)
-			kfree_skb(skb);
-	}
-#else
 	int i;
 
 	for (i = 0; i < ctx->nr_user_files; i++)
 		fput(ctx->user_files[i]);
-#endif
 }
 
 static int io_sqe_files_unregister(struct io_ring_ctx *ctx)
@@ -3575,13 +3560,6 @@ static void io_ring_ctx_free(struct io_ring_ctx *ctx)
 	io_sqe_files_unregister(ctx);
 	io_eventfd_unregister(ctx);
 
-#if defined(CONFIG_UNIX)
-	if (ctx->ring_sock) {
-		ctx->ring_sock->file = NULL; /* so that iput() is called */
-		sock_release(ctx->ring_sock);
-	}
-#endif
-
 	io_mem_free(ctx->rings);
 	io_mem_free(ctx->sq_sqes);
 
@@ -3833,45 +3811,26 @@ static int io_allocate_scq_urings(struct io_ring_ctx *ctx,
 /*
  * Allocate an anonymous fd, this is what constitutes the application
  * visible backing of an io_uring instance. The application mmaps this
- * fd to gain access to the SQ/CQ ring details. If UNIX sockets are enabled,
- * we have to tie this fd to a socket for file garbage collection purposes.
+ * fd to gain access to the SQ/CQ ring details.
  */
 static int io_uring_get_fd(struct io_ring_ctx *ctx)
 {
 	struct file *file;
 	int ret;
 
-#if defined(CONFIG_UNIX)
-	ret = sock_create_kern(&init_net, PF_UNIX, SOCK_RAW, IPPROTO_IP,
-				&ctx->ring_sock);
-	if (ret)
-		return ret;
-#endif
-
 	ret = get_unused_fd_flags(O_RDWR | O_CLOEXEC);
 	if (ret < 0)
-		goto err;
+		return ret;
 
 	file = anon_inode_getfile("[io_uring]", &io_uring_fops, ctx,
 					O_RDWR | O_CLOEXEC);
 	if (IS_ERR(file)) {
 		put_unused_fd(ret);
-		ret = PTR_ERR(file);
-		goto err;
+		return PTR_ERR(file);
 	}
 
-#if defined(CONFIG_UNIX)
-	ctx->ring_sock->file = file;
-	ctx->ring_sock->sk->sk_user_data = ctx;
-#endif
 	fd_install(ret, file);
 	return ret;
-err:
-#if defined(CONFIG_UNIX)
-	sock_release(ctx->ring_sock);
-	ctx->ring_sock = NULL;
-#endif
-	return ret;
 }
 
 static int io_uring_create(unsigned entries, struct io_uring_params *p)
-- 
2.43.0


