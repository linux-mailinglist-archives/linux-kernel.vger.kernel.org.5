Return-Path: <linux-kernel+bounces-113530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77784888511
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E01283C02
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CCF1BF53C;
	Sun, 24 Mar 2024 22:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETs9+QE+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0ED1BF51D;
	Sun, 24 Mar 2024 22:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320332; cv=none; b=SiLax6rxPsR6QsinhhZ7gmz+ZiWeZN8iZptukoZo+MDM17lqcZUL4y3IieMvAXnWWLyRUdxDDk7dTQ+tx4nwLy+8vxlswrCcfarYwe6HcAV8BRWmnRXXkEQt965Dv9MoaXRvNHlyh3q8QGdZrWlfMJoK9NwEY+aXmn+sWzOMLtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320332; c=relaxed/simple;
	bh=oL9bOEKE6eutJbiJSZAloAwLP9RkgyJ8pIjxmXoq7is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GR+HN0r7mIpahuLomuk34hA7SIi7Pj2NT5qS26HVQ1SOkZRXRVpuiWr4xy7OcZVFilWqItL0rHWc6GGtBH69Z9D4lU9eOouDRqgU78qo7ZoWSSfHSCLNFgQE/xJ/Y6vit1rzZWI+ABVX7vzSU250d16AXvoF6CAefP4JYMR7BSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETs9+QE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8CEC433C7;
	Sun, 24 Mar 2024 22:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320331;
	bh=oL9bOEKE6eutJbiJSZAloAwLP9RkgyJ8pIjxmXoq7is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ETs9+QE+fFw2UFXip1KqKAmhOGDEuxqmYnnE3ewa+JFRJkJy7aTwxJUq8gMORpO62
	 PmwrxF5tsevr8HM4/SHDZSwvj2+JJeBoIdbET6ysCThSAes36RijJ8yGmqhH0KJunU
	 RVIL0FvV/I3CS8+ovU53z1oqUppo9RqTv5t+gkDli9viFFPujOBE6GwgxFj4oZ2X+G
	 A2xYNiyKKt+aM+ize/LZmwlcI4kFRe3wjCE5FiK1bCBLN2n4jXwLqNKHoOdTjtyRU+
	 sZgExlmD1IwV9WZh5hMQxMnV5hq8tFLwEMi4gsQXqtACr2kKaxF5c6N+A1LE2TU6B3
	 Ad6levUrjD6og==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 639/715] io_uring: don't save/restore iowait state
Date: Sun, 24 Mar 2024 18:33:38 -0400
Message-ID: <20240324223455.1342824-640-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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

[ Upstream commit 6f0974eccbf78baead1735722c4f1ee3eb9422cd ]

This kind of state is per-syscall, and since we're doing the waiting off
entering the io_uring_enter(2) syscall, there's no way that iowait can
already be set for this case. Simplify it by setting it if we need to,
and always clearing it to 0 when done.

Fixes: 7b72d661f1f2 ("io_uring: gate iowait schedule on having pending requests")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/io_uring.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 39dfb83dc9fc4..030cc930d1c6a 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2527,7 +2527,7 @@ static bool current_pending_io(void)
 static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
 					  struct io_wait_queue *iowq)
 {
-	int io_wait, ret;
+	int ret;
 
 	if (unlikely(READ_ONCE(ctx->check_cq)))
 		return 1;
@@ -2545,7 +2545,6 @@ static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
 	 * can take into account that the task is waiting for IO - turns out
 	 * to be important for low QD IO.
 	 */
-	io_wait = current->in_iowait;
 	if (current_pending_io())
 		current->in_iowait = 1;
 	ret = 0;
@@ -2553,7 +2552,7 @@ static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
 		schedule();
 	else if (!schedule_hrtimeout(&iowq->timeout, HRTIMER_MODE_ABS))
 		ret = -ETIME;
-	current->in_iowait = io_wait;
+	current->in_iowait = 0;
 	return ret;
 }
 
-- 
2.43.0


