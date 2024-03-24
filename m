Return-Path: <linux-kernel+bounces-113556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DFB888545
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0011A1F2337A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3FA1C5228;
	Sun, 24 Mar 2024 22:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrS8rgUB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B895B1C4B11;
	Sun, 24 Mar 2024 22:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320358; cv=none; b=omoltiRaH62cYIbvOkUyRBXSyPLnrw5P0XfAwrXUzm2j9NlNPXkCGQiwRerIJxbHLYLk/aFWTs+VibqEV1OeauURwCpF4s88I2Y1XaP8ICPdU/tpJvUepoI1dnd/e87i6mEdvG5VXGyAQsiUuo0K+o15HDvBi778phk2giqJZNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320358; c=relaxed/simple;
	bh=ElVdjxUV2VcNvyjO2SKyW/p4yoGPYipISTRYJuLUWJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RDYQ5gtaDVuc2Rn3GqcZJVVEEvI9Uzv4D8qaQCgViLF+aojEW99Bwd6Au2kH/qXX6LEsE7sf3FwjNncWdtWvbjAP7Ptt7qPIIe7Xoafq7y7tbWk5tOIErk9ZetBTgwW8I3BIo9tpwSmuUG+6Q3ya/JwDisFMsyG4TJZ76Mxkpxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrS8rgUB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02861C43394;
	Sun, 24 Mar 2024 22:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320358;
	bh=ElVdjxUV2VcNvyjO2SKyW/p4yoGPYipISTRYJuLUWJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jrS8rgUBKuHGtF2omWedh4C82rESa0+lKoK4IPAvmNcMcxgW64M7szRdis95ySimu
	 8LpsnBdp+L7gWsrLug/DfWXc5s7J0JSpRWDq85ENvNT0p8rR//HXeK+lh9RS53coSN
	 DrFYmbVhvOFrvkT8urdybDyeetWnO5tPvjrIcnA3PqL2i2krD1C9C6i4S1HRJl+qkF
	 rzjP1xOOvImHU39y/cD/HnlxzL3A7FC0LlklbK7wmNdVXMW/iNKcYfqY5jEORaUBeh
	 zkvVOaqPje5lnXVy9MDK7/RFlt/M0OEsqXVbCvy9AQve6vLzkubTfvGuDqcnPN+mP7
	 huajjCWPUOwqw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 665/715] io_uring: fix poll_remove stalled req completion
Date: Sun, 24 Mar 2024 18:34:04 -0400
Message-ID: <20240324223455.1342824-666-sashal@kernel.org>
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
index 7513afc7b702e..58b7556f621eb 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -995,7 +995,6 @@ int io_poll_remove(struct io_kiocb *req, unsigned int issue_flags)
 	struct io_hash_bucket *bucket;
 	struct io_kiocb *preq;
 	int ret2, ret = 0;
-	struct io_tw_state ts = { .locked = true };
 
 	io_ring_submit_lock(ctx, issue_flags);
 	preq = io_poll_find(ctx, true, &cd, &ctx->cancel_table, &bucket);
@@ -1044,7 +1043,8 @@ int io_poll_remove(struct io_kiocb *req, unsigned int issue_flags)
 
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


