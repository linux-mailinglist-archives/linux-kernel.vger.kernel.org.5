Return-Path: <linux-kernel+bounces-114433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A04888914F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FF21B3887A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622001782E4;
	Sun, 24 Mar 2024 23:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcuJDtRx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0902621D13B;
	Sun, 24 Mar 2024 23:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321850; cv=none; b=mg1bar8CKSNtKMLedWUD3cIm45ALnkc/Wd7G3QjtCZ+dZOLam3R9gAItciY1/xYuzlM4dm39Sl6Z5am59jW6mBSUL2Y/c0E7sPojdqHrjr6FexI8CjnjrbeNf0WZBByjaWh/TNo/zhyHzend3zWX2VhbirkGaRT5fHU2UdNSLcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321850; c=relaxed/simple;
	bh=Rsjng4VZbTEdnLFlvy0VGTDz/Y89/cZBVxyY0nInXLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q44srPwXBvoEOcBHe/3DGtgrV9dgNc9RueFQym/c8bbr3ZikQZ4LOHR9H5otkl8RD7KQWGELhlK0eDBdv6j8bltRpCVU7k1M7D3m09WDAH1kXk1NMHUXGno4kNjPg9Auvi6LOqbUKFn+gT7gxbmsb3p0+5pV5lsYs/I+RbVEakQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcuJDtRx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D15CC43394;
	Sun, 24 Mar 2024 23:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321848;
	bh=Rsjng4VZbTEdnLFlvy0VGTDz/Y89/cZBVxyY0nInXLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NcuJDtRxpykud146VgU0JwuD/tj4gewjTpMABLtjFpWIlyi6bS4PwnhYP8v5A2MRD
	 V4X3wqdsS4OJaZiGGFh3CUimnqRsaKaow0sn6It5DiU/3ea8BZmZy0P93E1OJNFHxC
	 gfHuWTH25OkbRFvY5OEw85t0H4/EEiSUlRclIyQ7nhZGGXSkd6Rp1Fs6pc1Jegl/KC
	 uLZlhzNYgEj3Y58crCYYOvD46KDpBGBXhA4U24gYS0M00pTdSBORdapUKWnyLuYOUv
	 JverENasIglsEsSX8fa530vRlHp3QPo7uTYczyamZKj96gBKvUuB6pv2AxtrO/0uRs
	 21iY6YYsWQeDQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 577/638] io_uring: don't save/restore iowait state
Date: Sun, 24 Mar 2024 19:00:14 -0400
Message-ID: <20240324230116.1348576-578-sashal@kernel.org>
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
index 049a163d0fdd0..25e2893320342 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2501,7 +2501,7 @@ static bool current_pending_io(void)
 static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
 					  struct io_wait_queue *iowq)
 {
-	int io_wait, ret;
+	int ret;
 
 	if (unlikely(READ_ONCE(ctx->check_cq)))
 		return 1;
@@ -2519,7 +2519,6 @@ static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
 	 * can take into account that the task is waiting for IO - turns out
 	 * to be important for low QD IO.
 	 */
-	io_wait = current->in_iowait;
 	if (current_pending_io())
 		current->in_iowait = 1;
 	ret = 0;
@@ -2527,7 +2526,7 @@ static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
 		schedule();
 	else if (!schedule_hrtimeout(&iowq->timeout, HRTIMER_MODE_ABS))
 		ret = -ETIME;
-	current->in_iowait = io_wait;
+	current->in_iowait = 0;
 	return ret;
 }
 
-- 
2.43.0


