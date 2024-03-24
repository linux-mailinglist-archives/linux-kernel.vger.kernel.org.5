Return-Path: <linux-kernel+bounces-114913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C1A888BF0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEA991F286BF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C481B2D486A;
	Mon, 25 Mar 2024 00:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHaydREE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB373178CE4;
	Sun, 24 Mar 2024 23:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323581; cv=none; b=go9SMRN9Qgt8fjEDonSfzxvBA/fXT29kKw0qq2xfmY5Abch9/9sE/ynR833hyXHH2raGnBaUEXkwp1utwc/jg38TZddcKVH156Oes+m0STkjHhjjKJiTx+QkSMUZGj+CxWMdnJ0A4RZZOwpm5Ho50JlWldFAu9pbOq7i3ALXBd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323581; c=relaxed/simple;
	bh=8sKYSQluEn4/6PGtEguJVZQDs38YzlkO6eJZQg/af0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BHWVuZWxm6+we4gQaW+fv12fnlgD2rkIanH8DSidfnXX/3/bFeWfO/TVJeogRHkkQYmh1PTt5sGJhfEXfqOi0NHOaZmY3G8aIodIY+qjoDfEsCJE9nA46ClByvO9M8paLTdA9X1A1fzlNs3C7KEssokXlXU2U3MpWDmoE/g1/4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHaydREE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2FDC433F1;
	Sun, 24 Mar 2024 23:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323580;
	bh=8sKYSQluEn4/6PGtEguJVZQDs38YzlkO6eJZQg/af0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UHaydREEwD2atOaSHpCTaHZfodCdsj0dNkV62a6m1nBHNfcRbL3/VmJ2/Ki+AYoFF
	 CrUQCMmU9THywIl33G4KoR61mALzZ0gHw3uc/1K0IpQSn6LG55IjNU08t7S/GIxzLA
	 84KelNdKovLabCV2gCE92LENSgqgpE2B29tUckpE0GDQ3FEcinp3hbeVahSWBSlurX
	 0LDU8wuXcuJFyV+3GUHScMzT5a3G0IO/PSq7zCVaI6SE0OSt99lfNE/2EUFMsEl+tK
	 9O5F8mP0ETceOwjbIlbuH71fYajwYebvskeRpNoRj1J7wEl44tUIHYfHa6+T5SDW2c
	 YkMs0sxzgOynw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 287/317] io_uring: don't save/restore iowait state
Date: Sun, 24 Mar 2024 19:34:27 -0400
Message-ID: <20240324233458.1352854-288-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 386b32e6fd9a8..a51429c0342e0 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -7815,7 +7815,7 @@ static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
 					  struct io_wait_queue *iowq,
 					  ktime_t *timeout)
 {
-	int io_wait, ret;
+	int ret;
 
 	/* make sure we run task_work before checking for signals */
 	ret = io_run_task_work_sig();
@@ -7830,13 +7830,12 @@ static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
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


