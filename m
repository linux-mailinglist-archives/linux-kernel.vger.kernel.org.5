Return-Path: <linux-kernel+bounces-115741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F61388948E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFF231C2F220
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CDE16D330;
	Mon, 25 Mar 2024 02:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2a8IMwA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587FB21EB90;
	Sun, 24 Mar 2024 23:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321869; cv=none; b=G8H09CeWR/qGXYi3WrdpSBeT5vgcpi7MH8lK9u5T63pvpNXJ22tV/f/HnEDQ84kQbZRprOqw1VKpLrjZfxrVeXaG5Z2HqRUwCtmiBTsTse1ppTNt5c2HE7ynrpkQnq3OYBH5ukLpX6AghEQ8nvmNGMLRq02V6vSBLdhN2whIIdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321869; c=relaxed/simple;
	bh=ZloeDXuNotLauck6uEX90ePi0vwHZyM1N3tt/cTdlZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iMZeqOcluDVyLQyLzVJJBhPs26KYO9yqwlRl5lInCtZjUa/ueA18i62Zh4OjN0saK6l9XxG3jUPayKzIgScILt/iouoR04TrqAUus71abxf5/cBqhglu0T9LkxertD+Z97mbnrF4NvNkOLubpR4x/bsqpl9S43h58lMiH5SHzXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2a8IMwA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5482AC43394;
	Sun, 24 Mar 2024 23:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321867;
	bh=ZloeDXuNotLauck6uEX90ePi0vwHZyM1N3tt/cTdlZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q2a8IMwAziaJpHo4KZd/xTFClPsIjGfGIAT1dib7USzGqODlulYhfYMFw8Qk6kJzB
	 Wju/8LSPC0Qm4BvTWVstCVN8n9yqd/jsXl/715VsaTw2iIeZNHzBg7LzxaraLdob/N
	 enRIlFBjZYsnAtONwoaGLV+ir8Z1kw13+BHQiqtevJBUcPFOJa3KBieVn0HTSfZxPn
	 Xxn4rkOztY6bg0fe4Cc3PT2JmWKh0eScJD5wBMkSi5TFdpex9pHciJZ5dg+2TSHv/M
	 FNW/s/tatf2ymUEOQne062WPSjA9bUgdcjxctWwcbn3utR9oj/r6Q7H9USiAgXV1DJ
	 D2lpt7kYERWmQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 596/638] io_uring: fix poll_remove stalled req completion
Date: Sun, 24 Mar 2024 19:00:33 -0400
Message-ID: <20240324230116.1348576-597-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Pavel Begunkov <asml.silence@gmail.com>

[ Upstream commit 5e3afe580a9f5ca173a6bd55ffe10948796ef7e5 ]

Taking the ctx lock is not enough to use the deferred request completion
infrastructure, it'll get queued into the list but no one would expect
it there, so it will sit there until next io_submit_flush_completions().
It's hard to care about the cancellation path, so complete it via tw.

Fixes: ef7dfac51d8ed ("io_uring/poll: serialize poll linked timer start with poll removal")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/c446740bc16858f8a2a8dcdce899812f21d15f23.1710514702.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/poll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/io_uring/poll.c b/io_uring/poll.c
index 48ca0810a54af..5cf4fffe8b6c8 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -981,7 +981,6 @@ int io_poll_remove(struct io_kiocb *req, unsigned int issue_flags)
 	struct io_hash_bucket *bucket;
 	struct io_kiocb *preq;
 	int ret2, ret = 0;
-	struct io_tw_state ts = { .locked = true };
 
 	io_ring_submit_lock(ctx, issue_flags);
 	preq = io_poll_find(ctx, true, &cd, &ctx->cancel_table, &bucket);
@@ -1030,7 +1029,8 @@ int io_poll_remove(struct io_kiocb *req, unsigned int issue_flags)
 
 	req_set_fail(preq);
 	io_req_set_res(preq, -ECANCELED, 0);
-	io_req_task_complete(preq, &ts);
+	preq->io_task_work.func = io_req_task_complete;
+	io_req_task_work_add(preq);
 out:
 	io_ring_submit_unlock(ctx, issue_flags);
 	if (ret < 0) {
-- 
2.43.0


