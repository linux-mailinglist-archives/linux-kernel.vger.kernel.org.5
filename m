Return-Path: <linux-kernel+bounces-115191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D0A888F4F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDE21B34D39
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772741CA517;
	Mon, 25 Mar 2024 01:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5t1hBap"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F83183BB1;
	Sun, 24 Mar 2024 23:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324260; cv=none; b=Zwke9QW2Hl/S1J1bEivBT79sJnHMCyWAxOYn01O378JfP8SzcJcSB3EvB9ZQqdWN8PCfnjXOYwZe/scHs9IXVaLSTZ6fAQLSYNUqM4Kz7yANJb7C6NuINypQnEhDeDtYO2f8GDdcOy3OpvtEO2xGgQ7tgOtDTqg909Sb6oIyS1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324260; c=relaxed/simple;
	bh=yzQuo6nvZxgBaP3+SBHQ5uuPQzapeRQVVkdaSwYNq6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWYaJ6WS9lPkd3MdaYsRcHFQM2YBl7X/rbfuaxs2srpgo90gQYwTdZfrHXLU+ojpFLAZr+ReLCMIdD5F7dC9fXSeOkU239sN2pLh1UAird3Dc/1btYqH2SZcuJ/1yvLVlHtu89g6XSVe7iMLkOKWHJ0s2aA/BkvBjxYIjjaDqhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5t1hBap; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD41BC433F1;
	Sun, 24 Mar 2024 23:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324259;
	bh=yzQuo6nvZxgBaP3+SBHQ5uuPQzapeRQVVkdaSwYNq6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O5t1hBapQ+g4eyLa6NFAgnDx4daAqgNBYOsVJjqE93MtHACmP1Zn4slBq2d7McPa7
	 aNXRNRz/HyS3t+PFRtiMdWzbm3TEdiKP+9IRi+2diTOfAspEQKoCRvI16+l1ih1Te/
	 sjElT1lUF/QH3I99wIamjk7TDJvmFkWSRQ5596FvesOOuWhCYgTCtRG0pKvpnLY4XM
	 lEzSWKa7A3jA6jqn3fH29ZPUgW+5DEqpES8ilbYV7AIHIdvtgAvGyrPgRr2NMlAh1g
	 Mc4J3Qs4Ks6ny6NxyXBlrVg4li1Xrk4zCWSNwBv6nx5V9o6Q8aIJU6cMjboLJ3QQQx
	 ItcAUP3zDFPBA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 039/148] af_unix: Annotate data-race of gc_in_progress in wait_for_unix_gc().
Date: Sun, 24 Mar 2024 19:48:23 -0400
Message-ID: <20240324235012.1356413-40-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index 4d283e26d8162..0a212422b513c 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -203,7 +203,7 @@ void wait_for_unix_gc(void)
 	if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC &&
 	    !READ_ONCE(gc_in_progress))
 		unix_gc();
-	wait_event(unix_gc_wait, gc_in_progress == false);
+	wait_event(unix_gc_wait, !READ_ONCE(gc_in_progress));
 }
 
 /* The external entry point: unix_gc() */
-- 
2.43.0


