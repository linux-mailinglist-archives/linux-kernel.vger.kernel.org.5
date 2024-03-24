Return-Path: <linux-kernel+bounces-116213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 883F9889D94
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E4CD1F332E9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB763BEA5D;
	Mon, 25 Mar 2024 03:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmgQ1KsC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DD217DC06;
	Sun, 24 Mar 2024 23:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323840; cv=none; b=iMjeQTyX8Ta6ZuCqfhS+ZPbiOqgdHuvNaYPl3ftZL1xV7H7sWmKmahmqpqAi2nPgPAwtSU8XZhozYGTbNfiQY/b7bVwFadCpVd6XuSu6pA5SN6w8jNlJBdCOdPWbznOL+XsMLF7mOnXvnKV3Hvur6+3ynERp7wbY13bEzOHJ3ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323840; c=relaxed/simple;
	bh=c8yoc+gw3+doOP2QyCyd0FANFcQliti7oGbe3TbzbFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cYSWpaPglIwV4MCdbLswnxaeGcxP3PsPEmdcVEbg+3HdGIG6q4JjFtpmz8PAVWMYRd4kPkwNKarZMzZMbzmAPbTp7tWfVybF6arRDx8qqnN2Tvrn8XOFoN2FqFOtK5W80Dzd1ZSFnHJi7x92PCjQX9982QU0NxPM1Fq7Od3eCqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmgQ1KsC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FEF2C433C7;
	Sun, 24 Mar 2024 23:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323840;
	bh=c8yoc+gw3+doOP2QyCyd0FANFcQliti7oGbe3TbzbFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tmgQ1KsCWAvDOfqfttSmMTj8c6PUJj5SeNYT1WIRsf9yKJjxZTfI31diPrdiJY13n
	 4qmZqU3w9lxKO6pLf8VCic+onFdL9b6BELumvN9dHzyBLqxc72Um5E0FTSCl+pIhyd
	 cCJCd0LWLeMsFUqDZ1z8vgFVgefUwHVANpMiNlbpKytTWV9u9jbd9BA1YAl/RGAM9M
	 pp4g5Uro7fttCvqRwtEoJfZav3yhIe3c2Z0F1lTHOeJyayh+AvHD9OViLx05fkyIfa
	 MMCJuFwMdBxqfx04FiwdxYoM5luJDcc8JfpJ36/AYm3//q7RwOaUpAD0d/x28FtlCB
	 nYGpCNV9yGTCA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 218/238] io_uring: don't save/restore iowait state
Date: Sun, 24 Mar 2024 19:40:06 -0400
Message-ID: <20240324234027.1354210-219-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 67a355f27ad80..fc60396c90396 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -7640,7 +7640,7 @@ static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
 					  struct io_wait_queue *iowq,
 					  ktime_t *timeout)
 {
-	int io_wait, ret;
+	int ret;
 
 	/* make sure we run task_work before checking for signals */
 	ret = io_run_task_work_sig();
@@ -7655,13 +7655,12 @@ static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
 	 * can take into account that the task is waiting for IO - turns out
 	 * to be important for low QD IO.
 	 */
-	io_wait = current->in_iowait;
 	if (current_pending_io())
 		current->in_iowait = 1;
 	ret = 1;
 	if (!schedule_hrtimeout(timeout, HRTIMER_MODE_ABS))
 		ret = -ETIME;
-	current->in_iowait = io_wait;
+	current->in_iowait = 0;
 	return ret;
 }
 
-- 
2.43.0


