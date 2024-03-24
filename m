Return-Path: <linux-kernel+bounces-114962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B03888C36
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59FEB1C29CA6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B51281C04;
	Mon, 25 Mar 2024 00:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9RJagsy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42602131188;
	Sun, 24 Mar 2024 23:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323683; cv=none; b=GbnNuskwn/MHri0Ww9c/d3lGjzPqOOJmj0m8BSW/uvv9nyaMxUks7b5jtHnexWUOfvmXsRwF1CNNse5vJKm1/Y6LAhxeWSGtkTAf020OZM3r950mu6GlfQ6Ah3OAiBnb57FTbK3Yrw2lcOyHkhzvGNTDygIh6KpUwXaKGyzjAgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323683; c=relaxed/simple;
	bh=PAMZMwA6ckum7R7Mm0LbM8DTdW/7ofn9I96UXMzIw1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oBPqRW0Dq+vv/ilH3EitpwSlxhtSaKSm4nvD9HYIO5ZL4nQgHT+2lDnZYtu4fx4K1LoZFh5Y9Q64vIY7wKeBjLNfjKqscRGVM4WFjr/GmOQDPAriuZBaogSXchYHMJkx9tFJ53ePQWBQSktqDGDjLSI5muDxsaWIHD4Ux8X3WzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9RJagsy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84608C43394;
	Sun, 24 Mar 2024 23:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323682;
	bh=PAMZMwA6ckum7R7Mm0LbM8DTdW/7ofn9I96UXMzIw1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e9RJagsyR6VxSnjjQ3fEs1iDCTR0V6TKTsd1ULfhvEnF5BeZI9MMIxU9W1Mew+Ew9
	 c2kq1euZ6SSMYmkhbcVxnAJkr6jgMYTUm6pi6eQjI2wN51ADkKafaS77l+oe5zCwEL
	 Mc5KLHnkZVWaMF1Kb2EFArUVAftLeAENyES2nesJ5kYUt9rThNjleAiTrdaWgrO9dE
	 C7O+XDq6HzMQ/3YK1h+x/4ePgcPYZa8WKTzhrRScnctKVglYDsHE0rE558mJstW+ho
	 GpOIrUOT2o53pmSvLzKhCY+P5xa/ukKDMcqstlDnACUQXc6qJ6FcuUzosfzFDwiRAx
	 1zTkVblQCev8g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 054/238] af_unix: Annotate data-race of gc_in_progress in wait_for_unix_gc().
Date: Sun, 24 Mar 2024 19:37:22 -0400
Message-ID: <20240324234027.1354210-55-sashal@kernel.org>
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

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 31e03207119a535d0b0e3b3a7f91983aeb2cb14d ]

gc_in_progress is changed under spin_lock(&unix_gc_lock),
but wait_for_unix_gc() reads it locklessly.

Let's use READ_ONCE().

Fixes: 5f23b734963e ("net: Fix soft lockups/OOM issues w/ unix garbage collector")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://lore.kernel.org/r/20240123170856.41348-2-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/unix/garbage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index dc27635403932..9121a4d5436d5 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -198,7 +198,7 @@ void wait_for_unix_gc(void)
 	if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC &&
 	    !READ_ONCE(gc_in_progress))
 		unix_gc();
-	wait_event(unix_gc_wait, gc_in_progress == false);
+	wait_event(unix_gc_wait, !READ_ONCE(gc_in_progress));
 }
 
 /* The external entry point: unix_gc() */
-- 
2.43.0


