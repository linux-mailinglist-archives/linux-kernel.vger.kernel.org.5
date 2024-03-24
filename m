Return-Path: <linux-kernel+bounces-113979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED6D8887B7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A2A428A861
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7AE156877;
	Sun, 24 Mar 2024 23:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iofenbaJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAA71F23F0;
	Sun, 24 Mar 2024 22:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321106; cv=none; b=D9fGUvoeJLoTwZc2PoODlb4Kw3k45iaXt8pVDTjVYezxkiFANnXxS9pXvzjT1ju9JyxtMzOBh90rEwF9A3Yktnswsr8ZtqtVHVUAlTeCwskdYmsg+Nsau1iGbm+l3K4d7he9aQVaN8rYiDPt3YsxlFuooD7UwvTLIMTp50ODHcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321106; c=relaxed/simple;
	bh=ElVdjxUV2VcNvyjO2SKyW/p4yoGPYipISTRYJuLUWJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pY+kFgq3qEUqkpR7VXu7zQtmSyn25rTk091NAMTZgUqLrl5ZM4btSlVTVeoCxI+Jd0BesQCT/Syoj3T1V1td6kzlQL0a7YJRa8k/wa/q1z0O2ccmwuoS9lDy7/dUtcCNxWYnJgVVIdEUkxfQyo7WsnND67kDy1GupsTeN0nkzig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iofenbaJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484EDC43390;
	Sun, 24 Mar 2024 22:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321104;
	bh=ElVdjxUV2VcNvyjO2SKyW/p4yoGPYipISTRYJuLUWJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iofenbaJPHcCxfLaGD8QJjDRAYNacBipmf3gPCpjH3it3++3nAtsCpyC/3YjBnqN5
	 6kA7vOQHeIYBEYV35Iq0gckhJ5eUwrTD8nsYk4Dp9pTRQ6XWLEZFyPNQVk1XzXEVna
	 te24Vlck6F1xSCr75gWOZcwQ9DxZM48DAmH4C2KO0ThBCdPZbE+se7N3roSVu9e7Uc
	 W6chGHUZpHBEbhwWFuABBl3+3DruyTQkz6/CwOaPC1Uz1+urhKyw1PMuo1EY0qZSet
	 BSWmxuT6mgOfKTeXzNStUzLS9DYaayt+DTIHKOOt91soV+ki65I0C8kiQWAjW1u2rx
	 JxgyfIPF1RrSA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 667/713] io_uring: fix poll_remove stalled req completion
Date: Sun, 24 Mar 2024 18:46:33 -0400
Message-ID: <20240324224720.1345309-668-sashal@kernel.org>
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


