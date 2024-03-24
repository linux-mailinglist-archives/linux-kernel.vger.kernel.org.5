Return-Path: <linux-kernel+bounces-115067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF1A888CDA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5C811F297DF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566762E15C7;
	Mon, 25 Mar 2024 01:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2etgfK/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074C82892D1;
	Sun, 24 Mar 2024 23:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324043; cv=none; b=iYs0HWY/9P2lERCQHjc+OC5kxUkW9ZDFOty3jXBGqq8ZdJQc60mpgHfY79HNEWNJdiitMFWa9w6hB8kY1sJGMP56eN8wki1O1exOfy7EjNArWVBPFD3BVdq5UMUrJaArXmOy0r2NLtxcAy9Aw95wfdFe5v86T+0qlsSpyTFWDdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324043; c=relaxed/simple;
	bh=PAMZMwA6ckum7R7Mm0LbM8DTdW/7ofn9I96UXMzIw1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EX7yJ/s98G/NpzDLkPEmJ+sPr544ANtYPQrI4UR85x3qxdND+wtZCjv1uIOmm3rqXONhX9C1TBUI8KG24KwNm0MBXmFwYf7e0dTcng+TeihkWBqu5KOzuL7jLnwyus1qAzNiZL0zz8FB8wUYS6vc90eqge9WlbZ9D46LfwXGPmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2etgfK/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B68C43394;
	Sun, 24 Mar 2024 23:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324041;
	bh=PAMZMwA6ckum7R7Mm0LbM8DTdW/7ofn9I96UXMzIw1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h2etgfK/uff7gM1K/ZjdwHYjS4NWLF8sGNo43CD0ABbrC3eeTy+1SPgv4oRM4ORaS
	 D9H+xoeiPUjhdHIMNJ52lc+08TaCoSeRcZ/A2rdVr6laxT4Qb2iQsm/eM/e5bW5VAg
	 6H8+aqEc8oxkV4c4ejO9VSUdByTb4TvcvmE/ZkgHTqgxYKZcsKCJ+bU2MBDebYOX4a
	 556XY6by7lLTg5HXoE/VwjXX6y87c/DwUOs1p/5J8Ho+bz+1dAuFHCnTaJefoPlhwJ
	 ebG+3UifYBgELcoCm7j36mqmu8FFgkTRML0jt0w223sAtTGu7EtaqVKCmrp4ZSjLgd
	 10qDP1zLr37gA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 042/183] af_unix: Annotate data-race of gc_in_progress in wait_for_unix_gc().
Date: Sun, 24 Mar 2024 19:44:15 -0400
Message-ID: <20240324234638.1355609-43-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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


