Return-Path: <linux-kernel+bounces-113969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB3A8887A4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6651F26219
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA2821E357;
	Sun, 24 Mar 2024 23:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gy/YGP4t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B721F1ACB;
	Sun, 24 Mar 2024 22:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321079; cv=none; b=tT9DWP8ROJzXxhDRALijV6HffliqMZz/yuWkfWNHmxQDJXgm9Y/QH7jo92hhEB4iUUfe146pQs1XlgNJpDN00iZr3+gpvHussQU1cLwNtT+ycFArZUcVeYuz8Pd/RjLyzcPEiI7jespYJnoB3A0M9jLmshgLSzgR3VucqUceY+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321079; c=relaxed/simple;
	bh=9Cy9BYud+K9DSV9BhShG46aYhERuzHE6lvqHDIuFiTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HfljsTkmW5rfDMrVREZzo7au/FSUHotjvcSHDxqvRXe2un7LSPsf9ZQma4yNwn3MDjd1dYPWdEqwula8K3vW+9csoZ2levZ0w2Dg2A4tmlm4ARRKkOoB8a3ExgO8CoMWrWNVkRCcCkIe8PkjpLziULQGo1ujgDe3ZLGICioxRg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gy/YGP4t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6EFC433C7;
	Sun, 24 Mar 2024 22:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321078;
	bh=9Cy9BYud+K9DSV9BhShG46aYhERuzHE6lvqHDIuFiTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gy/YGP4trQXPr0dn6kCqbkUxGUzt8FTKw57YEv/pH68QHqLajrl2xgwhOgn5S5Ttw
	 +ULrnI2oc40TEiDQwIuneFsxFjgi9+Gsw1KwHSz9fuzHbsDfFERGfFcCBabOBLVrT3
	 sbTV44YKYvvACx5LxwJSDezJ1HtxKE/7MSSV9qAHwwfS/KH+umDqcyg4Zau9Fi7TCS
	 +NaT7TLlimgdtCJOCNbOC9u5cues4zwEH0+JXtAxh7J3IpidGmUfJpLcZXo8gayxen
	 ddUo+ZGEATId19WLrwjuX9pmusLrpCzSjQIcUPVh19eYVlQ9aGsoC6NiCiDfIz1sVg
	 oFiOAemM8F8fw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 642/713] io_uring: don't save/restore iowait state
Date: Sun, 24 Mar 2024 18:46:08 -0400
Message-ID: <20240324224720.1345309-643-sashal@kernel.org>
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
index b658ba6703cc2..205dad9603733 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2508,7 +2508,7 @@ static bool current_pending_io(void)
 static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
 					  struct io_wait_queue *iowq)
 {
-	int io_wait, ret;
+	int ret;
 
 	if (unlikely(READ_ONCE(ctx->check_cq)))
 		return 1;
@@ -2526,7 +2526,6 @@ static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
 	 * can take into account that the task is waiting for IO - turns out
 	 * to be important for low QD IO.
 	 */
-	io_wait = current->in_iowait;
 	if (current_pending_io())
 		current->in_iowait = 1;
 	ret = 0;
@@ -2534,7 +2533,7 @@ static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
 		schedule();
 	else if (!schedule_hrtimeout(&iowq->timeout, HRTIMER_MODE_ABS))
 		ret = -ETIME;
-	current->in_iowait = io_wait;
+	current->in_iowait = 0;
 	return ret;
 }
 
-- 
2.43.0


